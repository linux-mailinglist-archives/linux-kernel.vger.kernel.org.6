Return-Path: <linux-kernel+bounces-367835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20B089A075D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 12:30:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44D0A1C266BA
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 10:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBAB2206E9C;
	Wed, 16 Oct 2024 10:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b="VvdLd/5k"
Received: from smtp73.ord1d.emailsrvr.com (smtp73.ord1d.emailsrvr.com [184.106.54.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABBBA206E67
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 10:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=184.106.54.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729074408; cv=none; b=lsJyAcP2o1UNUGjpxLwKs17bva2cI/gvWkHaq/ddNlnDF3XEYVKwm+jryNLh9KSdWcNBlV8WDNF62UsR1wdsg4tioDKeW/becW4b9bc3Smnddnsy5L9wkPRW9Pc7h/ZdRiHyb5gwvPe8SPpGqkZ35uO/IohpNLWVqECBWzzyCu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729074408; c=relaxed/simple;
	bh=+6Pts8kDd1dHcAWl0fplOpP+QkjkbN8jiOfNZ/0cc38=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VMCFz3/aUxxXbHO8T+bomR4yuqOwLKCIPbLHaIHGjXgR6hErNaKk4kV0SaV2N9Yd6FoPOabTXtoRTkoJX92g6B56Kpva8/03XRoK1vwNsadhOwcN9yJGQ+2ip7PTaML7/hRYacO3ldSmNuhBA7R1CzabgD6ptUUbfgY9Q6T60o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk; spf=pass smtp.mailfrom=mev.co.uk; dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b=VvdLd/5k; arc=none smtp.client-ip=184.106.54.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mev.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
	s=20221208-6x11dpa4; t=1729072097;
	bh=+6Pts8kDd1dHcAWl0fplOpP+QkjkbN8jiOfNZ/0cc38=;
	h=Date:Subject:To:From:From;
	b=VvdLd/5kTw8SpvJYgTd+XiNzsOGDjv6Q247ksFVwTW1TsqDUQ4s9OTBOQ7eNHim/1
	 XMDpLsY50cwwHI6AGHoPRxAy+DD8kdNgpFcstzdblx+QVXTI2+33zWSeeCRzvvJPhv
	 p+wk0AAR/fn0MxxNZ+OfcYRgBHHd6Ao2QcqmlnAw=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp18.relay.ord1d.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id 4FDF7A01AC;
	Wed, 16 Oct 2024 05:48:16 -0400 (EDT)
Message-ID: <74ccca51-085a-4a31-a854-98937d18fb91@mev.co.uk>
Date: Wed, 16 Oct 2024 10:48:15 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] comedi: Flush partial mappings in error case
To: Jann Horn <jannh@google.com>,
 H Hartley Sweeten <hsweeten@visionengravers.com>,
 Frank Mori Hess <fmh6jj@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20241015-comedi-tlb-v2-1-cafb0e27dd9a@google.com>
Content-Language: en-GB
From: Ian Abbott <abbotti@mev.co.uk>
Organization: MEV Ltd.
In-Reply-To: <20241015-comedi-tlb-v2-1-cafb0e27dd9a@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Classification-ID: bbdee840-a5ba-491f-8b49-acd103fe4767-1-1

On 15/10/2024 19:26, Jann Horn wrote:
> If some remap_pfn_range() calls succeeded before one failed, we still have
> buffer pages mapped into the userspace page tables when we drop the buffer
> reference with comedi_buf_map_put(bm). The userspace mappings are only
> cleaned up later in the mmap error path.
> 
> Fix it by explicitly flushing all mappings in our VMA on the error path.
> 
> See commit 79a61cc3fc04 ("mm: avoid leaving partial pfn mappings around in
> error case").
> 
> Cc: stable@vger.kernel.org
> Fixes: ed9eccbe8970 ("Staging: add comedi core")
> Signed-off-by: Jann Horn <jannh@google.com>
> ---
> Note: compile-tested only; I don't actually have comedi hardware, and I
> don't know anything about comedi.

It is possible to test it by loading the comedi_test driver module, 
which creates a comedi device in software.  But then you need to induce 
an error somehow.  I did it by hacking the comedi_mmap() function to 
break the loop that calls remap_pfn_range() early with an error.

> ---
> Changes in v2:
> - only do the zapping in the pfnmap path (Ian Abbott)
> - use zap_vma_ptes() instead of zap_page_range_single() (Ian Abbott)
> - Link to v1: https://lore.kernel.org/r/20241014-comedi-tlb-v1-1-4b699144b438@google.com
> ---
>   drivers/comedi/comedi_fops.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/comedi/comedi_fops.c b/drivers/comedi/comedi_fops.c
> index 1b481731df96..68e5301e6281 100644
> --- a/drivers/comedi/comedi_fops.c
> +++ b/drivers/comedi/comedi_fops.c
> @@ -2407,6 +2407,16 @@ static int comedi_mmap(struct file *file, struct vm_area_struct *vma)
>   
>   			start += PAGE_SIZE;
>   		}
> +
> +		/*
> +		 * Leaving behind a partial mapping of a buffer we're about to
> +		 * drop is unsafe, see remap_pfn_range_notrack().
> +		 * We need to zap the range here ourselves instead of relying
> +		 * on the automatic zapping in remap_pfn_range() because we call
> +		 * remap_pfn_range() in a loop.
> +		 */
> +		if (retval)
> +			zap_vma_ptes(vma, vma->vm_start, size);
>   	}
>   
>   	if (retval == 0) {
> 
> ---
> base-commit: 6485cf5ea253d40d507cd71253c9568c5470cd27
> change-id: 20241014-comedi-tlb-400246505961

I have tested it with the device created by the comedi_test.ko module 
using the comedi_test application from comedilib, by artificially 
breaking the partial mapping loop with an error half way to completion. 
I haven't noticed any problems from the zap_vma_ptes() call, so it is OK 
as far as I can tell.  (I don't really have any experience of calling 
functions like zap_vma_ptes().)

I note that there are a bunch of drivers in drivers/video/fbdev that 
also call remap_pfn_range() or io_remap_pfn_range() in a loop that 
probably require your attention!

Tested-by: Ian Abbott <abbotti@mev.co.uk>
Reviewed-by: Ian Abbott <abbotti@mev.co.uk>

-- 
-=( Ian Abbott <abbotti@mev.co.uk> || MEV Ltd. is a company  )=-
-=( registered in England & Wales.  Regd. number: 02862268.  )=-
-=( Regd. addr.: S11 & 12 Building 67, Europa Business Park, )=-
-=( Bird Hall Lane, STOCKPORT, SK3 0XA, UK. || www.mev.co.uk )=-

