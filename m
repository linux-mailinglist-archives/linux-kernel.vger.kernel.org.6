Return-Path: <linux-kernel+bounces-335104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2A1097E114
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 13:19:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74AEE2813E5
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 11:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B5A7193065;
	Sun, 22 Sep 2024 11:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dk8l3LTs"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D753B15350D
	for <linux-kernel@vger.kernel.org>; Sun, 22 Sep 2024 11:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727003973; cv=none; b=nNCACbIt18L2+9kqgwgF9fv9TaU+bmV9dj1sxj7+OS56GXC688AmENUFhA2Kc+nl4mSr7JJofATxUu2y4dwu3bPtzLBXu1KiUdMYhujdUVTYIv8cPVe7SUP7TqzrWeanmHjEV35xFJS+Gmn9LOk2cC4dBx/w+VGNC5kg49Q4pqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727003973; c=relaxed/simple;
	bh=VGN0VKXEhkV8GBwMmdoKpsclTqZfTlhDFlwjz/lH6TA=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=U/nxSOKu/yM2I0om9jRLhq+vze8jucrmVrbUgmdgytRWaVAuRvEGmRUcJovgHwVo362RREmUO2+9aaSFIeY7gbB05wU12VNRI7SSn65I7iCNMocqjqbGShRPjfKoLHBvcg5iJV122fnjYlw7J3GTEXNHVy8JLK6PKN+kl6OOGGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dk8l3LTs; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-71781f42f75so3323341b3a.1
        for <linux-kernel@vger.kernel.org>; Sun, 22 Sep 2024 04:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727003970; x=1727608770; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0XGOYj44mxYlAIPacdVz2Xqqf2VHJVuoXCavyaxAiLM=;
        b=dk8l3LTsC1lnUQ9HNE82WExVI2FzQIpT+hwstJCquNvf+MkMgJtxdF2qbpEPEcQk8R
         Qo6uJUe+crYIagneOweYHpppypF8szTnsG1HqNSxS0HLHWcpFntAchE14XOlJsspJZZp
         i6HStajgZCMVSPexLkxkmdYlL/gRUd8CgI4RfKtlIoIELmuYYxn2yzu7Iw2r5xnEJcmb
         ISMlsnM0dE34KHiOjW0H7q4V9FlopwMYGqpvHbwkY6sNs7+ha4ThnDQSwn3ird1FOGi0
         XCyAroF9N6ldGS7fyXlxeMWFqZmqSQ1rkjx2uIXQLZG6dcovTQXsUPPF/FopMTq3raAF
         L3CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727003970; x=1727608770;
        h=references:message-id:date:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0XGOYj44mxYlAIPacdVz2Xqqf2VHJVuoXCavyaxAiLM=;
        b=w0CfC2Cf8f6EnqSSJJo/8Xgh1Vspv3yDJ6xuQli9uaVpifA2AXpIjYJlJdOOY0C3UO
         wW+nCKDEIMwH22qKaoKzvxnov9rwdEUkBPQYiji4wakjyGTYXMG06WlniTXWbu8+jLkL
         Ox9PIcq4T3XeIelfimht83OPe4BePyEXzywhpULgZf3GuiKpNZsjj4e5GDzQvD53O4rR
         6DYQrG6ksWSum5t2TDTJzDpsvsGYCskTSAhHivmxXedT3gu7PfSeMQckMi/kfhXjS5Ex
         eZLJ7y2gKg6+Up1g2/5ueUsCxhzOuHnNUAW8SIYZG8DT9Y93IT2YZUgDdiX98TKqp4l7
         lVQg==
X-Forwarded-Encrypted: i=1; AJvYcCXcJaa+CuTbLvb8ZRfzKGofCA/+4kFwiLHxVe13+9b4imp36KHH4hInMCl/Qy8z0UaIeDCPslc0zsVbl6E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZv5WTRTgCWMBudVrSFPZe+SDdVT5PZIJx/0O+5HknaWYPF4xk
	XZX2kh53oCgC1LJxFUG1+icxAAfGMOVuf1aUNwvVoi/Ma2doBZyP
X-Google-Smtp-Source: AGHT+IEarJPEGCPBYFymlyfwJIi6kol8+OpmLQWTv1Xlfmdw6aA8QyOeHPPTb+TJxBDxV5NMZGWPRg==
X-Received: by 2002:a05:6a00:4b0c:b0:717:8deb:c195 with SMTP id d2e1a72fcca58-7199ce0c432mr12177581b3a.21.1727003970167;
        Sun, 22 Sep 2024 04:19:30 -0700 (PDT)
Received: from dw-tp ([171.76.87.135])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71944a974dcsm12412341b3a.32.2024.09.22.04.19.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Sep 2024 04:19:29 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Luming Yu <luming.yu@shingroup.cn>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu, jialong.yang@shingroup.cn, luming.yu@gmail.com
Cc: Luming Yu <luming.yu@shingroup.cn>
Subject: Re: [RFC PATCH] powerpc/tlb: enable arch want batched unmap tlb flush
In-Reply-To: <9BC3D1299ECE8428+20240918092515.2121-2-luming.yu@shingroup.cn>
Date: Sun, 22 Sep 2024 16:39:53 +0530
Message-ID: <87frpsymf2.fsf@gmail.com>
References: <9BC3D1299ECE8428+20240918092515.2121-2-luming.yu@shingroup.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Luming Yu <luming.yu@shingroup.cn> writes:

> From: Yu Luming <luming.yu@gmail.com>
>
> ppc always do its own tracking for batch tlb. By trivially enabling
> the ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH in ppc, ppc arch can re-use
> common code in rmap and reduce overhead and do optimization it could not
> have without a tlb flushing context at low architecture level.

I looked at this patch and other than the compile failure, this patch
still won't optimize anything. The idea of this config is that we want
to batch all the tlb flush operation at the end. By returning false from
should_defer_flush() (in this patch), we are saying we cannot defer
the flush and hence we do tlb flush in the same context of unmap.

Anyway, I took a quick look at ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH
and I have a quick PoC for the same. I will soon post it.

-ritesh

>
> Signed-off-by: Luming Yu <luming.yu@shingroup.cn>
> ---
>  arch/powerpc/Kconfig                |  1 +
>  arch/powerpc/include/asm/tlbbatch.h | 30 +++++++++++++++++++++++++++++
>  2 files changed, 31 insertions(+)
>  create mode 100644 arch/powerpc/include/asm/tlbbatch.h
>
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index e94e7e4bfd40..e6db84dd014a 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -175,6 +175,7 @@ config PPC
>  	select ARCH_WANT_IPC_PARSE_VERSION
>  	select ARCH_WANT_IRQS_OFF_ACTIVATE_MM
>  	select ARCH_WANT_LD_ORPHAN_WARN
> +	select ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH
>  	select ARCH_WANT_OPTIMIZE_DAX_VMEMMAP	if PPC_RADIX_MMU
>  	select ARCH_WANTS_MODULES_DATA_IN_VMALLOC	if PPC_BOOK3S_32 || PPC_8xx
>  	select ARCH_WEAK_RELEASE_ACQUIRE
> diff --git a/arch/powerpc/include/asm/tlbbatch.h b/arch/powerpc/include/asm/tlbbatch.h
> new file mode 100644
> index 000000000000..484628460057
> --- /dev/null
> +++ b/arch/powerpc/include/asm/tlbbatch.h
> @@ -0,0 +1,30 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _ARCH_PPC_TLBBATCH_H
> +#define _ARCH_PPC_TLBBATCH_H
> +
> +struct arch_tlbflush_unmap_batch {
> +	/*
> +         *
> +	 */
> +};
> +
> +static inline void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch)
> +{
> +}
> +
> +static inline void arch_tlbbatch_add_pending(struct arch_tlbflush_unmap_batch *batch,
> +						struct mm_struct *mm,
> +						unsigned long uarddr)
> +{
> +}
> +
> +static inline bool arch_tlbbatch_should_defer(struct mm_struct *mm)
> +{
> +	/*ppc always do tlb flush in batch*/
> +	return false;
> +}
> +
> +static inline void arch_flush_tlb_batched_pending(struct mm_struct *mm)
> +{
> +}
> +#endif /* _ARCH_PPC_TLBBATCH_H */
> -- 
> 2.42.0.windows.2

