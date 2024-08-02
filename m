Return-Path: <linux-kernel+bounces-272551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E6FF945DC9
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 14:24:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FF4A1C21387
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 12:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 314561E2890;
	Fri,  2 Aug 2024 12:24:27 +0000 (UTC)
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0CBC14A0A0
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 12:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722601466; cv=none; b=OMXOpN1Bud4+/1EecZ13A7DK9qRgMEzWduaSYcrE/kYykirZwnD7qBmUni2s2aQNjTWQwl0wSod0PUb3lPm+auQe0neuaW3pkv0rweHvR4yuz/tzEEL6KvnEONYOVfg0tu7fQ0Q0y6jVwHMXXNK+5EhBeGIxtIy6tOz7iJxrXh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722601466; c=relaxed/simple;
	bh=xZlyc6Vx74zrVw9XYv57Nx1QcrtcfKrftrkamJYZoYY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=TSowqz3y1ezyYJT95x5I1H2YJ1lpA/IP+3b8Dgw0PzUVAnf3MTiKVXrm0Lh58ma1pmD/bza1KNOIJmV4xwhqlFhgIBu8EYlHA6PtnxSRE2KX/aoljByGBskvphnWthFz4HO46DIq3rEyFVM778Og1sBihmYKiKc5ItTDKhhyjhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6FA4124000B;
	Fri,  2 Aug 2024 12:24:20 +0000 (UTC)
Message-ID: <ce86ad6b-5f56-4856-9756-fa8867d0d1df@ghiti.fr>
Date: Fri, 2 Aug 2024 14:24:19 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next] crash: Fix riscv64 crash memory reserve dead loop
Content-Language: en-US
To: Jinjie Ruan <ruanjinjie@huawei.com>, bhe@redhat.com, vgoyal@redhat.com,
 dyoung@redhat.com, paul.walmsley@sifive.com, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, chenjiahao16@huawei.com, akpm@linux-foundation.org,
 kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org
References: <20240802090105.3871929-1-ruanjinjie@huawei.com>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20240802090105.3871929-1-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: alex@ghiti.fr

Hi Jinjie,

On 02/08/2024 11:01, Jinjie Ruan wrote:
> On RISCV64 Qemu machine with 512MB memory, cmdline "crashkernel=500M,high"
> will cause system stall as below:
>
> 	 Zone ranges:
> 	   DMA32    [mem 0x0000000080000000-0x000000009fffffff]
> 	   Normal   empty
> 	 Movable zone start for each node
> 	 Early memory node ranges
> 	   node   0: [mem 0x0000000080000000-0x000000008005ffff]
> 	   node   0: [mem 0x0000000080060000-0x000000009fffffff]
> 	 Initmem setup node 0 [mem 0x0000000080000000-0x000000009fffffff]
> 	(stall here)
>
> commit 5d99cadf1568 ("crash: fix x86_32 crash memory reserve dead loop


I can't find this revision, was this patch merged in 6.11?


> bug") fix this on 32-bit architecture. However, the problem is not
> completely solved. If `CRASH_ADDR_LOW_MAX = CRASH_ADDR_HIGH_MAX` on 64-bit
> architecture, for example, when system memory is equal to
> CRASH_ADDR_LOW_MAX on RISCV64, the following infinite loop will also occur:
>
> 	-> reserve_crashkernel_generic() and high is true
> 	   -> alloc at [CRASH_ADDR_LOW_MAX, CRASH_ADDR_HIGH_MAX] fail
> 	      -> alloc at [0, CRASH_ADDR_LOW_MAX] fail and repeatedly
> 	         (because CRASH_ADDR_LOW_MAX = CRASH_ADDR_HIGH_MAX).
>
> Before refactor in commit 9c08a2a139fe ("x86: kdump: use generic interface
> to simplify crashkernel reservation code"), x86 do not try to reserve crash
> memory at low if it fails to alloc above high 4G. However before refator in
> commit fdc268232dbba ("arm64: kdump: use generic interface to simplify
> crashkernel reservation"), arm64 try to reserve crash memory at low if it
> fails above high 4G. For 64-bit systems, this attempt is less beneficial
> than the opposite, remove it to fix this bug and align with native x86
> implementation.
>
> After this patch, it print:
> 	cannot allocate crashkernel (size:0x1f400000)
>
> Fixes: 39365395046f ("riscv: kdump: use generic interface to simplify crashkernel reservation")


Your patch subject indicates "-next" but I see this commit ^ landed in 
6.7, so I think we should merge it now, let me know if I missed something.

Thanks,

Alex


> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
>   kernel/crash_reserve.c | 9 ---------
>   1 file changed, 9 deletions(-)
>
> diff --git a/kernel/crash_reserve.c b/kernel/crash_reserve.c
> index 5387269114f6..69e4b8b7b969 100644
> --- a/kernel/crash_reserve.c
> +++ b/kernel/crash_reserve.c
> @@ -420,15 +420,6 @@ void __init reserve_crashkernel_generic(char *cmdline,
>   				goto retry;
>   		}
>   
> -		/*
> -		 * For crashkernel=size[KMG],high, if the first attempt was
> -		 * for high memory, fall back to low memory.
> -		 */
> -		if (high && search_end == CRASH_ADDR_HIGH_MAX) {
> -			search_end = CRASH_ADDR_LOW_MAX;
> -			search_base = 0;
> -			goto retry;
> -		}
>   		pr_warn("cannot allocate crashkernel (size:0x%llx)\n",
>   			crash_size);
>   		return;

