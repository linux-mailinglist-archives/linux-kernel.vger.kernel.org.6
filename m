Return-Path: <linux-kernel+bounces-345338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBC8798B4E5
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 08:50:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 653FC1F24E65
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 06:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD7081A303C;
	Tue,  1 Oct 2024 06:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BgOtThIS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C10263D;
	Tue,  1 Oct 2024 06:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727765419; cv=none; b=ZWV1v3MGSEltZs0SzezWMk9w0z2V0voEp+4S/Q+zIFeEfl+rGV3hnRgQPirStPw3JH/4zSmYil+gETkGW5oIMkloaDZzi7m/G8RQ1/ikB3SlPeEVBfb4w2/JrBcz1u7YgeAG1E//mKmtq96m4Vp8WgauEmO9JWIHNXdnRZZuCUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727765419; c=relaxed/simple;
	bh=rroKJMTafwnZjbBmdmjyAoYFiIBrMNZZ2LTPZPmox5g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ayfd6eTFaB2h3RYRiFxxtt2OOmsFs3oyMSUwkG+h/Q119HeCVGtfEiN9SLyQWMLtnzCqwkQXAwf5t8NCVcn3S52uPsQpg6dQ4kERbD3FBwSebBFDzr36CwMrEFWTceiDp0teHlgRXJaNitQ3IPKOpJXbOG+mLPwmKRLvW2QHnps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BgOtThIS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 610F0C4CEC6;
	Tue,  1 Oct 2024 06:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727765418;
	bh=rroKJMTafwnZjbBmdmjyAoYFiIBrMNZZ2LTPZPmox5g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BgOtThISE4xXpNpjO04tvg2Zx4IHuKMJEoSBXi60Wi+YDVXroisIgkP0q8KZn0GbN
	 NL/0XBlro4BOVZM3+cMUQcQfCS8X88wqvNriksk+xks6AURCm6puwZw+sTl3nzurqO
	 XoH/MIm75Q2H1MUFMJuhGVV2EJo5KBLbOhAlSE5Y=
Date: Tue, 1 Oct 2024 08:50:15 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Dan Williams <dan.j.williams@intel.com>
Cc: rafael.j.wysocki@intel.com, tj@kernel.org, linux-kernel@vger.kernel.org,
	regressions@lists.linux.dev
Subject: Re: [PATCH] driver core: Fix userspace expectations of uevent_show()
 as a probe barrier
Message-ID: <2024100130-turkey-duplicate-d670@gregkh>
References: <172772671177.1003633.7355063154793624707.stgit@dwillia2-xfh.jf.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <172772671177.1003633.7355063154793624707.stgit@dwillia2-xfh.jf.intel.com>

On Mon, Sep 30, 2024 at 01:05:13PM -0700, Dan Williams wrote:
> Commit "driver core: Fix uevent_show() vs driver detach race" [1]
> attempted to fix a lockdep report in uevent_show() by making the lookup
> of driver information for a given device lockless. It turns out that
> userspace likely depends on the side-effect of uevent_show() flushing
> device probing, as evidenced by the removal of the lock causing a
> regression initializing USB devices [2].
> 
> Introduce a new "locked" type for sysfs attributes that arranges for the
> attribute to be called under the device-lock, but without setting up a
> reverse locking order dependency with the kernfs_get_active() lock.

As this is "only" for the driver core, can you move some of the stuff in
the global .h files to the local ones so that no one else gets the wrong
idea they can use them?

thanks,

greg k-h

