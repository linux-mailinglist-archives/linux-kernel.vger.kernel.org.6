Return-Path: <linux-kernel+bounces-272428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 182E7945BD7
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 12:11:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 906CCB219D3
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 10:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D85481DB421;
	Fri,  2 Aug 2024 10:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bDywzy42"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE611C69D
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 10:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722593484; cv=none; b=ud38sZfOWVV4RZG+oLoS3o1yuQgxQoUG8PCvai/JJk9vwSUnMrBfBj0CKgtLyzEkqdb3cbr4bGUwbDDOs1gxAsTBDWvc4tPZPWiLHUnK1qQakkmgLEIBSvI0LAP7b5CJRzMDSCnzbiuNMaY3UMjNCMyJC9kqqvoctaj/bKa3q7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722593484; c=relaxed/simple;
	bh=I6aw5+55dd2uzGKTCNofEj9JqBcYJ5+X5swUYdScceg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gm15MVgicol4G6nITaGjh4ZuUely9rd42dEqW7z2w8rKxwJ7Tz9CG5+efXTG1iw+acFsp8TOimaJ31YB4CA+oZ2ID6L7v2V1b2RcngKBheMgmXtiTRpu5iYn97YEV3A8GNK//NxSaUCDUvf+fpHgOPda6bSPMDeQU5axRLgJWC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bDywzy42; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722593480;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mdrYwGhdrYt4Wjbem5gAPO4p6O6XbcLYXDqwBckiuuI=;
	b=bDywzy42fcoLwZa4vQO8M4LM8lcLI103jc577TDncrPCty7T9Thtuciz/Z0/nPUvbxP82Y
	TtHfNOvVUQeIYKnDyMrzmTQUYGPHTkmZF1yRz/04XJXMYqC+ctTLPwGfpcBK64ul/CRhtF
	l/Weg2L8OlBhr/3PWEOaVa3/pOS3/KI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-649-9Yi1FeTJOAmOBbhfGMXroA-1; Fri,
 02 Aug 2024 06:11:17 -0400
X-MC-Unique: 9Yi1FeTJOAmOBbhfGMXroA-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8B95419560B1;
	Fri,  2 Aug 2024 10:11:15 +0000 (UTC)
Received: from localhost (unknown [10.72.112.126])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 398CC1955D44;
	Fri,  2 Aug 2024 10:11:12 +0000 (UTC)
Date: Fri, 2 Aug 2024 18:11:01 +0800
From: Baoquan He <bhe@redhat.com>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: vgoyal@redhat.com, dyoung@redhat.com, paul.walmsley@sifive.com,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, chenjiahao16@huawei.com,
	akpm@linux-foundation.org, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH -next] crash: Fix riscv64 crash memory reserve dead loop
Message-ID: <ZqywtegyIS/YXOVv@MiWiFi-R3L-srv>
References: <20240802090105.3871929-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240802090105.3871929-1-ruanjinjie@huawei.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On 08/02/24 at 05:01pm, Jinjie Ruan wrote:
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
> bug") fix this on 32-bit architecture. However, the problem is not
> completely solved. If `CRASH_ADDR_LOW_MAX = CRASH_ADDR_HIGH_MAX` on 64-bit
> architecture, for example, when system memory is equal to
> CRASH_ADDR_LOW_MAX on RISCV64, the following infinite loop will also occur:

Interesting, I didn't expect risc-v defining them like these.

#define CRASH_ADDR_LOW_MAX              dma32_phys_limit
#define CRASH_ADDR_HIGH_MAX             memblock_end_of_DRAM()
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

And I don't like the idea crashkernel=,high failure will fallback to
attempt in low area, so this looks good to me.

> 
> After this patch, it print:
> 	cannot allocate crashkernel (size:0x1f400000)
> 
> Fixes: 39365395046f ("riscv: kdump: use generic interface to simplify crashkernel reservation")
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
>  kernel/crash_reserve.c | 9 ---------
>  1 file changed, 9 deletions(-)

Acked-by: Baoquan He <bhe@redhat.com>

> 
> diff --git a/kernel/crash_reserve.c b/kernel/crash_reserve.c
> index 5387269114f6..69e4b8b7b969 100644
> --- a/kernel/crash_reserve.c
> +++ b/kernel/crash_reserve.c
> @@ -420,15 +420,6 @@ void __init reserve_crashkernel_generic(char *cmdline,
>  				goto retry;
>  		}
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
>  		pr_warn("cannot allocate crashkernel (size:0x%llx)\n",
>  			crash_size);
>  		return;
> -- 
> 2.34.1
> 


