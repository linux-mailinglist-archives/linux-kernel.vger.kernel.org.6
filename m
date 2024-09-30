Return-Path: <linux-kernel+bounces-344669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD91D98AC84
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 21:09:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19AEE2823B6
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 19:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D575A199250;
	Mon, 30 Sep 2024 19:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bLu1R5Te"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3853E196450
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 19:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727723361; cv=none; b=T05thn57v1F15LDzLncLgVUTAJzAv0X34I4zD37phe4W+SibCaDwcxqttIFfbB+amrmtpcxo0Y8qJBOAw17ArpQvXnrH5FWhLo0fRk2Mz1D5a0brt5g9er/66gKC48NfvZ4L3hm+UIHmr3bOqE95HTg9MXZ2Ns6B7KGyeaWli6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727723361; c=relaxed/simple;
	bh=dHZcIL/ZoSvEkAWVdttRyG1ztXLb4a7HYVwTD3OaqvE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jb2GI7IJ6IiRuguZBD+2PgnXKJvDb2fczD4l/FKOy0cnAqWZNDJlmkbxOCYFbrWT39Htblk9gFIly1JVNRqS0esGvcx0R5jLkBPvxZZBDqJtGKThLDHnYkCxPtq1xdK4v9dqYVNbSgn6XhH4WYuG5eheX55qkOKeWRKIGxykA/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bLu1R5Te; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F694C4CEC7;
	Mon, 30 Sep 2024 19:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727723360;
	bh=dHZcIL/ZoSvEkAWVdttRyG1ztXLb4a7HYVwTD3OaqvE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bLu1R5TewlE+E7F4i5dRxsqEr9Llx2ZNQX1rYmUk2KXTulfSj6oK+azptWPgFuboP
	 L1ofQqw85rSioWblto3D4Y9vBjOvWuDu8CL9cugt6OHOxkrMcaKDzjw4bfv1UCIDA2
	 g4e8rlOXSsDBOU8YXSTUXrnuLCFpIdOO+zwlDeRo=
Date: Mon, 30 Sep 2024 21:09:18 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc: cve@kernel.org, linux-kernel@vger.kernel.org,
	Tom Chung <chiahsuan.chung@amd.com>,
	Hersen Wu <hersenxs.wu@amd.com>
Subject: Re: CVE-2024-46808: drm/amd/display: Add missing NULL pointer check
 within dpcd_extend_address_range
Message-ID: <2024093053-womanly-groom-a59b@gregkh>
References: <2024092709-CVE-2024-46808-8886@gregkh>
 <khg5rxxfvmdfjze2tpdamrnhsry7jd4eptxfdkht5nnpjacpy3@rhlk7omy3ulc>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <khg5rxxfvmdfjze2tpdamrnhsry7jd4eptxfdkht5nnpjacpy3@rhlk7omy3ulc>

On Mon, Sep 30, 2024 at 08:58:41PM +0200, Michal Koutný wrote:
> Hello.
> 
> On Fri, Sep 27, 2024 at 02:36:13PM GMT, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> > In the Linux kernel, the following vulnerability has been resolved:
> > 
> > drm/amd/display: Add missing NULL pointer check within dpcd_extend_address_range
> > 
> > [Why & How]
> > ASSERT if return NULL from kcalloc.
> > 
> > The Linux kernel CVE team has assigned CVE-2024-46808 to this issue.
> 
> This is not a good CVE fix since it'd bring the system down for users
> with panic_on_warn=1 anyway. (I wasn't able to `make
> drivers/gpu/drm/amd/display/dc/link/protocols/link_dpcd.i` but I assume
> the ASSERTs expand to one of the WARN_ONs, feel free to correct me.)

It's a good fix for those without that option enabled :)

> It'd need graceful handling of the kcalloc failure.

Agreed, it could be fixed better.

thanks,

greg k-h

