Return-Path: <linux-kernel+bounces-267113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 646E3940CB0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 11:00:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 821071C246A9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 09:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C50C8193074;
	Tue, 30 Jul 2024 08:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="k+7qHjqI"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B2F193066
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 08:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722329998; cv=none; b=sh/LgUPknn85sDignxAnKDTy7WVWu/EV/11XBc5yMRkBZ8uoXLMrsSFO31t6DQ4qpoW5ASykG+082mEt3WB71UOW5ku9r84tWy6lUaklP5iraHAnQx8tM9ORPFKN9JtOLyE4C5sgktk3bSNjn2uYjYlz/bA8kicl2vaWPsG+zhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722329998; c=relaxed/simple;
	bh=u0yfPdvKmYy+PsFVglSVdM8PLravYgUzc+0rdQILkT4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nqUpqbIAEEVZbi0yi/nmtTma/g9buBhE2DUnfTtqnv1N4wggQin3eyzIgJFghzv+qWUlMECTkXhp//3a6RdrWNgm0WF2FdsnnwoNIDTzWlZG10jccQCeipwFS4M7xrgj+jLLNqwi4c2bLl6ioxj4bfHeL8A1bkm8aVf3QFM8I8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=k+7qHjqI; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4280ac10b7cso499305e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 01:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1722329994; x=1722934794; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nNVuxs1MrMq4lcDOUZmx3vJTp4xEo5IRLOaYragrSo8=;
        b=k+7qHjqIhH9uv5D9mgAzAJU0iOzIzxEmWI8N+3ki6yzl3a0B0NYLqUYAp+kU3VgOYG
         gHubFeA9reMNTe8VlGtBu0BINPo5RhnUu1SOQfbtVOqjRFe0n8vW4rd3KUdk1MoGekV3
         x4EyWvlBQTAe8hjBZn2gBjltzoAGqXWNBLVqrO7XhjJU619MpXNiBgd7uQTPZgIvtGgX
         gzUP/dZK80T1dFE7uJZeHG2pPNcHcsoSZN2KHaLja2RoA3+j1ZR0Rlae7oL+6olSJgEF
         hFvmqJkSBIFdQekI0EXfJxhuYpzlNqKPfc+bb7tWj8ML3HpoxBQOjbqC4ErIcZ60KvGr
         3pgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722329994; x=1722934794;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nNVuxs1MrMq4lcDOUZmx3vJTp4xEo5IRLOaYragrSo8=;
        b=r9dwvWJh3Bzb5CIb5MTBcUCQrHyLGRHdXP1v6DmCcJOB1VcNVgyYwSgbibQbg9/W+i
         xJVQOI58WXK4tMf4oEDQnIKEQnT+XLUHq/xCqk4a1gEWOmE9vlRmtzcsMlu+DKqR6X1g
         mbCXdsIu9/apW3Asqw3i3nZbu01Ptml85OXnbz4qXG6ixX/Utvgaok1odtgTsjKVpsNY
         MJcNDzMmo40aAPVJv0pEFIaPUfu6+njM+hETWiDZdVb/PgnPZ6vOqf/Es88MM3QFrJSX
         OusOZiiVDET21wA+rS+WPTQlZCzJJpxukZUDUvDbD7P9vBDIVqBH0drC3FSfMBM8rp95
         3LQg==
X-Gm-Message-State: AOJu0YzNQbUng4v46yX93Ua5kRXaElqnfrQJXWr+1Ax5GXAQjBTYWiwC
	fgl7z1utprydG9BYDfowEVL8/7ToP7qHAXbSi20PPnhP7PJ6KDpECSC3tjD6wZI=
X-Google-Smtp-Source: AGHT+IFoWKDhfiVSA9aPn4FBTB1PiREVVPkTaeG764ytCjXhR/sBVssh7utGGffqhcPp0zgg8YjliA==
X-Received: by 2002:a05:600c:3b87:b0:426:668f:5ed7 with SMTP id 5b1f17b1804b1-42805700160mr73422405e9.2.1722329993329;
        Tue, 30 Jul 2024 01:59:53 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:e17:9700:16d2:7456:6634:9626? ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-428240b3b25sm11235555e9.0.2024.07.30.01.59.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jul 2024 01:59:53 -0700 (PDT)
Message-ID: <28d780da-4f43-4db5-8e1b-c66bb9973cd1@rivosinc.com>
Date: Tue, 30 Jul 2024 10:59:52 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] tools: Add riscv barrier implementation
To: Charlie Jenkins <charlie@rivosinc.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Andrea Parri <parri.andrea@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
References: <20240729-optimize_ring_buffer_read_riscv-v1-0-6bbc0f2434ee@rivosinc.com>
 <20240729-optimize_ring_buffer_read_riscv-v1-1-6bbc0f2434ee@rivosinc.com>
Content-Language: en-US
From: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <20240729-optimize_ring_buffer_read_riscv-v1-1-6bbc0f2434ee@rivosinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 29/07/2024 22:50, Charlie Jenkins wrote:
> Many of the other architectures use their custom barrier implmentations.

Hi Charlie,

Typo: implmentations -> implementations

> Use the barrier code from the kernel sources to optimize barriers in
> tools.
> 
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> ---
>  tools/arch/riscv/include/asm/barrier.h | 39 ++++++++++++++++++++++++++++++++++
>  tools/arch/riscv/include/asm/fence.h   | 13 ++++++++++++
>  tools/include/asm/barrier.h            |  2 ++
>  3 files changed, 54 insertions(+)
> 
> diff --git a/tools/arch/riscv/include/asm/barrier.h b/tools/arch/riscv/include/asm/barrier.h
> new file mode 100644
> index 000000000000..6997f197086d
> --- /dev/null
> +++ b/tools/arch/riscv/include/asm/barrier.h
> @@ -0,0 +1,39 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copied from the kernel sources to tools/arch/riscv:
> + *
> + * Copyright (C) 2012 ARM Ltd.
> + * Copyright (C) 2013 Regents of the University of California
> + * Copyright (C) 2017 SiFive
> + */
> +
> +#ifndef _TOOLS_LINUX_ASM_RISCV_BARRIER_H
> +#define _TOOLS_LINUX_ASM_RISCV_BARRIER_H
> +
> +#include <asm/fence.h>
> +#include <linux/compiler.h>
> +
> +/* These barriers need to enforce ordering on both devices and memory. */
> +#define mb()		RISCV_FENCE(iorw, iorw)
> +#define rmb()		RISCV_FENCE(ir, ir)
> +#define wmb()		RISCV_FENCE(ow, ow)
> +
> +/* These barriers do not need to enforce ordering on devices, just memory. */
> +#define smp_mb()	RISCV_FENCE(rw, rw)
> +#define smp_rmb()	RISCV_FENCE(r, r)
> +#define smp_wmb()	RISCV_FENCE(w, w)
> +
> +#define smp_store_release(p, v)						\
> +do {									\
> +	RISCV_FENCE(rw, w);						\
> +	WRITE_ONCE(*p, v);						\
> +} while (0)
> +
> +#define smp_load_acquire(p)						\
> +({									\
> +	typeof(*p) ___p1 = READ_ONCE(*p);				\
> +	RISCV_FENCE(r, rw);						\
> +	___p1;								\
> +})
> +
> +#endif /* _TOOLS_LINUX_ASM_RISCV_BARRIER_H */
> diff --git a/tools/arch/riscv/include/asm/fence.h b/tools/arch/riscv/include/asm/fence.h
> new file mode 100644
> index 000000000000..37860e86771d
> --- /dev/null
> +++ b/tools/arch/riscv/include/asm/fence.h
> @@ -0,0 +1,13 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copied from the kernel sources to tools/arch/riscv:
> + */
> +
> +#ifndef _ASM_RISCV_FENCE_H
> +#define _ASM_RISCV_FENCE_H
> +
> +#define RISCV_FENCE_ASM(p, s)		"\tfence " #p "," #s "\n"
> +#define RISCV_FENCE(p, s) \
> +	({ __asm__ __volatile__ (RISCV_FENCE_ASM(p, s) : : : "memory"); })
> +
> +#endif	/* _ASM_RISCV_FENCE_H */
> diff --git a/tools/include/asm/barrier.h b/tools/include/asm/barrier.h
> index 8d378c57cb01..0c21678ac5e6 100644
> --- a/tools/include/asm/barrier.h
> +++ b/tools/include/asm/barrier.h
> @@ -8,6 +8,8 @@
>  #include "../../arch/arm64/include/asm/barrier.h"
>  #elif defined(__powerpc__)
>  #include "../../arch/powerpc/include/asm/barrier.h"
> +#elif defined(__riscv)
> +#include "../../arch/riscv/include/asm/barrier.h"
>  #elif defined(__s390__)
>  #include "../../arch/s390/include/asm/barrier.h"
>  #elif defined(__sh__)
> 

Can not really tell for that part except it seems ok to me as well.
Andrea might be a better candidate to add its Rb.

Thanks,

Clément

