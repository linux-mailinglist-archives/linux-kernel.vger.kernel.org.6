Return-Path: <linux-kernel+bounces-269543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF28594340D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 18:21:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84ABE1F2254F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 16:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C4BF1BBBC7;
	Wed, 31 Jul 2024 16:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1Yw0CyLp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD571A76C2
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 16:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722442881; cv=none; b=OHAX9yciIekcSriU1NiPCMRb5nHq0ZOrr1hYdfztATzloJhHuMQtyvfAS1ZlZo+MnJt5Gd3om8J8o7zTJIgCIq6SuWSJXgyh9UPgSXAnEiHHm/XxvoVSTwzLizGQUJODPkphqGRZCg++C3l5tVkAAJiPTYi/E6SdLtE2Fjpa7H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722442881; c=relaxed/simple;
	bh=UcMfimX8M8ETWdPGuhN59Tp/J7zkSCXITMwCdzMqt6s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Aqj0SSsJjX3mduBgXG804fQsnVydqsL7AQs+Po0Ai9RS/DyRYD+NFRL49W+2Qhi79NxLJe/F5F/nk4sJRc4jpnsAtqY/feD4WqbXT82LkolwanXhcxzCdPBgl9EnP1NKJXBXaktYVuPlgSNVJOqcpjY0eN9E0Yo8bfySr/hymQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1Yw0CyLp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7BA9C4AF0B;
	Wed, 31 Jul 2024 16:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722442881;
	bh=UcMfimX8M8ETWdPGuhN59Tp/J7zkSCXITMwCdzMqt6s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=1Yw0CyLpOrWw//fRYbx4Ane1cEALRdKjo0VL/ctgkYLbwX4mlyHrl/DVfLINHcNNx
	 lK5PtrtkyVqEQCTh0ERqsD2vEHm2bd+elgHDTP08qeSfDM6/fONYQmo6dm2W3PB/hJ
	 u8LmJ6vQn2CmszyW4LNXQmN9nZ9Uk3Hn8MZOqRXg=
Date: Wed, 31 Jul 2024 18:21:18 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Zijun Hu <zijun_hu@icloud.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org,
	Zijun Hu <quic_zijuhu@quicinc.com>
Subject: Re: [PATCH] driver core: Simplify driver API
 device_find_child_by_name() implementation
Message-ID: <2024073119-mortally-ashes-80f0@gregkh>
References: <20240720-simplify_drv_api-v1-1-07c5e028cccf@quicinc.com>
 <2024073128-tinfoil-unaligned-8164@gregkh>
 <917359cc-a421-41dd-93f4-d28937fe2325@icloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <917359cc-a421-41dd-93f4-d28937fe2325@icloud.com>

On Thu, Aug 01, 2024 at 12:04:40AM +0800, Zijun Hu wrote:
> On 2024/7/31 20:53, Greg Kroah-Hartman wrote:
> > On Sat, Jul 20, 2024 at 09:21:50AM +0800, Zijun Hu wrote:
> >> From: Zijun Hu <quic_zijuhu@quicinc.com>
> >>
> >> Simplify device_find_child_by_name() implementation by using present
> >> driver APIs device_find_child() and device_match_name().
> >>
> >> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> >> ---
> >>  drivers/base/core.c    | 15 +++------------
> >>  include/linux/device.h |  4 ++++
> >>  2 files changed, 7 insertions(+), 12 deletions(-)
> >>
> >> diff --git a/drivers/base/core.c b/drivers/base/core.c
> >> index 730cae66607c..22ab4b8a2bcd 100644
> >> --- a/drivers/base/core.c
> >> +++ b/drivers/base/core.c
> >> @@ -4089,18 +4089,9 @@ EXPORT_SYMBOL_GPL(device_find_child);
> >>  struct device *device_find_child_by_name(struct device *parent,
> >>  					 const char *name)
> >>  {
> >> -	struct klist_iter i;
> >> -	struct device *child;
> >> -
> >> -	if (!parent)
> >> -		return NULL;
> >> -
> >> -	klist_iter_init(&parent->p->klist_children, &i);
> >> -	while ((child = next_device(&i)))
> >> -		if (sysfs_streq(dev_name(child), name) && get_device(child))
> >> -			break;
> >> -	klist_iter_exit(&i);
> >> -	return child;
> >> +	/* TODO: remove type cast after const device_find_child() prototype */
> > 
> > I do not understand the TODO here.  Why is it needed?  Why not fix it up
> > now?
> > 
> 
> i have below findings during trying to simplify this API.
> 
> there are a type of driver APIs for finding device, for example,
> (bus|driver|class)_find_device() which all take below type for
> parameter @match:
> int (*match)(struct device *, const void *match_data)
> but device_find_child() take below type with void * for @match_data:
> int (*match)(struct device *, void *match_data).
> 
> @match's type of device_find_child() is not good as other finding APIs
> since nothing will be touched for finding operations normally.
> 
> i want to introduce a dedicate type for device match.
> typedef int (*device_match_t)(struct device *dev, const void *data);

Yes, that would be good.

> advantages:
> 1) device_match_t is simpler for finding APIs declarations and definitions
> 2) maybe stop further driver APIs from using bad match type as
> device_find_child()
> 
> TODO:
> 1) introduce device_match_t and use it for current present APIs
> (bus|driver|class)_find_device()
> 2) change API device_find_child() to take device_match_t, more jobs to
> do since need to touch many drivers
> 3) correct this change by by remove all TODO inline comments and force cast.
> 
> not sure if my ideas is good, what is your opinions?

That's great, but evolve it properly, don't add TODO lines here, there's
no real need for that.  Should end up with a lot of good cleanup
changes, and might not be all that bad overall.

thanks,

greg k-h

