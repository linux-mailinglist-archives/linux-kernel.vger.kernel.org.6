Return-Path: <linux-kernel+bounces-549291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A7B4A55062
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 17:18:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 531561889438
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 16:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4F92213253;
	Thu,  6 Mar 2025 16:18:43 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8916A198E63;
	Thu,  6 Mar 2025 16:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741277923; cv=none; b=uW6dOM0npeM0Y21j0dDAOcgDSGrgDwwELzd9vvdTesS5VniUu97NMlQHN3feGScy0drQF4Cqk/c6a6+ojPNfsacxKn1juxyT7Ad6QR0OGs43KEbEVQgT8p5Tak84r2EKVs3d8FZBHuc3jp5fIOcRA7kWhvTkOMN/Q+SNPGpAjxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741277923; c=relaxed/simple;
	bh=kHCFZNJ1eJAdRX7doQG8ZLc9N/yEqZCLZ+L3A+KZVKY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U5bRKkhXP9RZIZTH8XqG78qAjAVi9637R6BY4GgubhpOP5xOfwlkKgpcHjf4ACJamtv6dUF38Deq0+NIwqz50GI6FzlOSmuKXF9X8ELQZCY2W8enVYlVR7JCasz4iEckJoHjfoPUbOzlDjibliywJKZkO9KoEDUYI2/8bzErdms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8BE4C4CEE0;
	Thu,  6 Mar 2025 16:18:40 +0000 (UTC)
Date: Thu, 6 Mar 2025 16:18:38 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Cristian Marussi <cristian.marussi@arm.com>
Cc: Alice Ryhl <aliceryhl@google.com>, Sudeep Holla <sudeep.holla@arm.com>,
	linux-arm-kernel@lists.infradead.org, arm-scmi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [Bug report] Memory leak in scmi_device_create
Message-ID: <Z8nK3uFkspy61yjP@arm.com>
References: <Z8g8vhS9rqQ_ez48@google.com>
 <Z8iFeEWq16pNQdMa@pluto>
 <Z8mCbc2Z2QGd3f8M@google.com>
 <Z8my4MZ-In0ibxVY@arm.com>
 <Z8nDj129ZVeZBVSp@pluto>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8nDj129ZVeZBVSp@pluto>

On Thu, Mar 06, 2025 at 03:47:27PM +0000, Cristian Marussi wrote:
> On Thu, Mar 06, 2025 at 02:36:16PM +0000, Catalin Marinas wrote:
> > This loop in scmi_device_create() looks strange:
> > 
> > 	list_for_each_entry(rdev, phead, node) {
> > 		struct scmi_device *sdev;
> > 
> > 		sdev = __scmi_device_create(np, parent,
> > 					    rdev->id_table->protocol_id,
> > 					    rdev->id_table->name);
> > 		/* Report errors and carry on... */
> > 		if (sdev)
> > 			scmi_dev = sdev;
> > 		else
> > 			pr_err("(%s) Failed to create device for protocol 0x%x (%s)\n",
> > 			       of_node_full_name(parent->of_node),
> > 			       rdev->id_table->protocol_id,
> > 			       rdev->id_table->name);
> > 	}
> > 
> > We can override scmi_dev a few times in the loop and lose the previous
> > sdev allocations. Is this intended?
> 
> Yes...it is weird..but by design I would say :P ...
> 
> ...because this is called to instantiate one single device OR instantiate at
> once all the multiple devices needed for a protocol: in this latter case it
> returns just one of the created devices to signal success or NULL if all the
> devices' creation failed....we dont need to keep the allocated devices references
> anyway here since on success those devices are now referenced and kept on the
> SCMI bus, so they can be searched/scanned/destroyed from there.

Not sure why the pointer isn't found, device_add() should link it with
the parent. Unless something else fails, the parent is freed and the
linked devices unreachable. I'm not familiar at all with this code, I
just saw kmemleak and thought of replying.

The loop is still weird, scmi_chan_setup() seems to use the pointer to
scmi_device for something more meaningful than a pass/fail check. Also
the overall result is based only on what the last __scmi_device_create()
return value was, irrespective of the previous iterations of the loop.
You do have a pr_err() but no early bailing out of the loop on failure.
I'm curious if there are any SCMI errors in the Alice's kernel log.

-- 
Catalin

