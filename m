Return-Path: <linux-kernel+bounces-535125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 907F3A46F49
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 00:18:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9514416DA43
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 23:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4141F2702A9;
	Wed, 26 Feb 2025 23:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="wGY3TAx8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9516E2702A6
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 23:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740611878; cv=none; b=lgRjdutDGOyo0EKxaP9566JIz/WgIciXnnQop+SbXOC0tPihaA8iqsJikZkFA/cJU+QNCo8jhLS44rLjk6pdti449wK5r1tqUx4xFHbK5/G/a+1o2ufTAU1wGiOzjFoxEbY0pzQpWfRinLN9VKRofQrRPPEn8N+bZe16+xHwwXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740611878; c=relaxed/simple;
	bh=OsPBbBDRBelmxtrIjN40D8mjD0K+XAx9oSN3t1dr0qA=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=LwMpepclm5eYXBrFZbvYbGiYz6SPlbgD8YxiISJE+IINQxz3tFKB578yDTGmHp4UaCHh5Up68z+xhCfm1INnSCGpEpeK33iyLdoJ8A2tNbX07udXNCes4kd0IT8Aydav1RyEgavAmN9+c8EO9w9nzJaIWVQtPVIYuxC/tK5M4Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=wGY3TAx8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9A07C4CED6;
	Wed, 26 Feb 2025 23:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1740611878;
	bh=OsPBbBDRBelmxtrIjN40D8mjD0K+XAx9oSN3t1dr0qA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=wGY3TAx8B0uuobV/pphbkjds+J0vuWBrWQt16W6hkkihQaJbRpkxCvBsWUPClZKLa
	 ChHNE+5h2NRp2Os/J63zgMv4teXIWQI6UOJY00LmASEL7lzCQCPz32asdtGdL1DTKh
	 +U8RqH3PJSK2s+DItB/PyC1R4vFLL+m6ilK321K8=
Date: Wed, 26 Feb 2025 15:17:57 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: <zhongjinji@honor.com>
Cc: <yuzhao@google.com>, <linux-kernel@vger.kernel.org>,
 <linux-mm@kvack.org>, <rientjes@google.com>, <vbabka@suse.cz>,
 <yipengxiang@honor.com>, <liulu.liu@honor.com>, <feng.han@honor.com>
Subject: Re: [PATCH] mm/page_alloc: make the maximum number of highatomic
 pageblocks resizable
Message-Id: <20250226151757.6e3f4ce355d0fdbc11cd54c0@linux-foundation.org>
In-Reply-To: <20250226024126.3718-1-zhongjinji@honor.com>
References: <20250226024126.3718-1-zhongjinji@honor.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 26 Feb 2025 10:41:25 +0800 <zhongjinji@honor.com> wrote:

> From: zhongjinji <zhongjinji@honor.com>
> 
> In the past, nr_reserved_highatomic was considered to be part of
> unusable_free when there was no ALLOC_RESERVES flag. To prevent
> unusable_free from being too large, it is reasonable to set a
> fixed maximum highatomic value.

Can you explain further?  Why is it "reasonable"?  Please fully describe
the userspace-visible problem which this patch fixes.

> Even if the maximum number of highatomic pageblocks is set to be larger,
> unusable_free may not increase, since Yu Zhao provided the modification
> about nr_free_highatomic in
> https://lore.kernel.org/all/20241028182653.3420139-1-yuzhao@google.com/T/#u
> 
> More highatomic pageblocks are beneficial for the successful allocation
> of high-order page, which is helpful in some devices. Therefore, use
> highatomic_reserve_ratio to adjust the maximum number of highatomic
> pageblocks.

Can you provide testcases and measurements which help us to understand
and to quantify the benefits of this change?

> @@ -6199,6 +6201,13 @@ static const struct ctl_table page_alloc_sysctl_table[] = {
>  		.mode		= 0644,
>  		.proc_handler	= percpu_pagelist_high_fraction_sysctl_handler,
>  		.extra1		= SYSCTL_ZERO,
> +	},
> +		.procname	= "highatomic_reserve_ratio",
> +		.data		= &highatomic_reserve_ratio,
> +		.maxlen		= sizeof(highatomic_reserve_ratio),
> +		.mode		= 0644,
> +		.proc_handler	= proc_dointvec_minmax,
> +		.extra1		= SYSCTL_ZERO,
>  	},

Is there any way at all in which we can address the issue you're seeing
without adding yet another tunable?

Also, a new highatomic_reserve_ratio should be documented in
Documentation/admin-guide/sysctl/vm.rst, please.


