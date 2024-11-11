Return-Path: <linux-kernel+bounces-404178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE4709C404E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 15:05:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9306C283FF8
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 14:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C36E819F13B;
	Mon, 11 Nov 2024 14:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nxWkwmhR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF1019F10A;
	Mon, 11 Nov 2024 14:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731333880; cv=none; b=q0Gb2qTutnaIfPRqa0SPzg6pxE6W84sgKFzw9q/TQXWdaabUlKsfrHCO3ohCPW0tgy/TA4itDTyL2fctOtthYzDHrEj6zIrGb6wG6jIhSN2sXTk7jCktQGEOr3J7VehoYWjJiIWC10WajBDGAvFOf18KAAxgiwTMA5zsGT39cLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731333880; c=relaxed/simple;
	bh=tfyBpJQLB8RonUSKABvWjDRZpQ89oMSB5iQHnfS4ceo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lFNVviKLFulnqiCzg5SwEyR5a0soEQ39smUJqvdk6Wdso8DIP5ZOs13bvIXnTExvLmdhAWBRBegMCvibnKvP4F8BrNuvuIAm0uwfzqrhq+1/kYshodR9Xn/il23UAsnUs8VQpGVEgkHkPU+bHO4wBwNBSG0W2ZNlkpegcocUqx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nxWkwmhR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12CCDC4CECF;
	Mon, 11 Nov 2024 14:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731333879;
	bh=tfyBpJQLB8RonUSKABvWjDRZpQ89oMSB5iQHnfS4ceo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nxWkwmhRg56OBVDA41QkDTQkpgoxC1qk+7/jDM8lTmM4EHzrVjIG/XdHgHd8/NCY0
	 STPAGpnpB3g0iB1Lcn+4dlC5e99JsFJUzQ8PIKh+pupOJ1joU5MaRe52rpGntfFkLa
	 Dr8xG9ZTMUIt2pe5uFf1kgpt91WeUhCDd2ICTVjw=
Date: Mon, 11 Nov 2024 15:04:36 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: cve@kernel.org, linux-kernel@vger.kernel.org,
	linux-cve-announce@vger.kernel.org,
	Matt Fleming <mfleming@cloudflare.com>
Subject: Re: CVE-2024-50219: mm/page_alloc: let GFP_ATOMIC order-0 allocs
 access highatomic reserves
Message-ID: <2024111147-spur-stooge-c0b0@gregkh>
References: <2024110925-CVE-2024-50219-c970@gregkh>
 <f6e053b5-982d-472b-9c75-95d7f390bd68@suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f6e053b5-982d-472b-9c75-95d7f390bd68@suse.cz>

On Mon, Nov 11, 2024 at 11:40:49AM +0100, Vlastimil Babka wrote:
> On 11/9/24 11:15, Greg Kroah-Hartman wrote:
> > Description
> > ===========
> > 
> > In the Linux kernel, the following vulnerability has been resolved:
> > 
> > mm/page_alloc: let GFP_ATOMIC order-0 allocs access highatomic reserves
> > 
> > Under memory pressure it's possible for GFP_ATOMIC order-0 allocations to
> > fail even though free pages are available in the highatomic reserves. 
> > GFP_ATOMIC allocations cannot trigger unreserve_highatomic_pageblock()
> > since it's only run from reclaim.
> > 
> > Given that such allocations will pass the watermarks in
> > __zone_watermark_unusable_free(), it makes sense to fallback to highatomic
> > reserves the same way that ALLOC_OOM can.
> > 
> > This fixes order-0 page allocation failures observed on Cloudflare's fleet
> > when handling network packets:
> 
> Hi,
> 
> I would like to dispute the CVE. GFP_ATOMIC page allocations failures can
> generally happen (typically from network receive path, like here) and should
> always have a fallback. The impact could be somewhat worse performance at
> worst. AFAIK they are not affected by panic_on_warn nor panic_on_oom either,
> it's a pr_warn(), so I don't think there's a DoS vector.

I read this as "there was a failure, with no fallback", but in looking
at the traceback:

> >   kswapd1: page allocation failure: order:0, mode:0x820(GFP_ATOMIC),
> >   nodemask=(null),cpuset=/,mems_allowed=0-7
> >   CPU: 10 PID: 696 Comm: kswapd1 Kdump: loaded Tainted: G           O 6.6.43-CUSTOM #1
> >   Hardware name: MACHINE
> >   Call Trace:
> >    <IRQ>
> >    dump_stack_lvl+0x3c/0x50
> >    warn_alloc+0x13a/0x1c0
> >    __alloc_pages_slowpath.constprop.0+0xc9d/0xd10
> >    __alloc_pages+0x327/0x340
> >    __napi_alloc_skb+0x16d/0x1f0

This function DOES have a fallback if this failed, so it's ok here.
Many other ATOMIC allocations in the kernel do not have fallbacks, which
would cause a crash.

Note, it is setting the NOWARN flag, so shouldn't this not be warning?

Anyway, you are right, I'll go reject this one, thanks for the review!

thanks,

greg k-h

