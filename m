Return-Path: <linux-kernel+bounces-564608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41E81A65835
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 17:36:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DD0D3B10A6
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 16:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EACB1A23BB;
	Mon, 17 Mar 2025 16:36:18 +0000 (UTC)
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 099B81922D3
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 16:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742229378; cv=none; b=F8loVlU1PrnJagPOTk4SYoojqKqQ9x5TRk9UlcuxifZZzqb5VR09UUtSWvvMxD1i4IjggBsXHNBt/PHCP0bpp5i+ibSjvnaTlEDI9XqQPOci3PpE9nDPRujL5b/XDNq2wiWjiWz5xmTd/L6h73WvfWgQ7oOTQjVbuuTstIPSGMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742229378; c=relaxed/simple;
	bh=XOz73fs4njuWISS4miyh4nhy0sHdCuLjt7rMNIvKoc8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=efA01xIxl5nFi15skvwBSXF2wnYiDFJGumrb3nUe1vAG+FLz0eRg7EwjoNO2PGZvRyoBBniEWysOJ7hA3+XQSSAkz9961jjkpAdkinVmM5K//Rd/RkTgoyH2d0MWzl7IsL4k6FL5YSRJNeu+CvCzNna69tc54+pRxctGL1WQcUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id B0361442B7;
	Mon, 17 Mar 2025 16:36:12 +0000 (UTC)
Message-ID: <d964bf15-7172-448b-9aa1-72d5bf3e1695@ghiti.fr>
Date: Mon, 17 Mar 2025 17:36:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] riscv: introduce asm/swab.h
Content-Language: en-US
To: Ignacio Encinas <ignacio@iencinas.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>
Cc: Eric Biggers <ebiggers@kernel.org>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev,
 skhan@linuxfoundation.org, Zhihang Shao <zhihang.shao.iscas@gmail.com>,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
References: <20250310-riscv-swab-v1-1-34652ef1ee96@iencinas.com>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20250310-riscv-swab-v1-1-34652ef1ee96@iencinas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugedttdduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthejredttddvjeenucfhrhhomheptehlvgigrghnughrvgcuifhhihhtihcuoegrlhgvgiesghhhihhtihdrfhhrqeenucggtffrrghtthgvrhhnpefhhfdutdevgeelgeegfeeltdduhfduledvteduhfegffffiefggfektefhjedujeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeefuddrfedvrdekuddrudekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeefuddrfedvrdekuddrudekjedphhgvlhhopegludelvddrudeikedrvddurddvhegnpdhmrghilhhfrhhomheprghlvgigsehghhhithhirdhfrhdpnhgspghrtghpthhtohepuddtpdhrtghpthhtohepihhgnhgrtghiohesihgvnhgtihhnrghsrdgtohhmpdhrtghpthhtohepphgruhhlrdifrghlmhhslhgvhiesshhifhhivhgvrdgtohhmpdhrtghpthhtohepphgrlhhmvghrsegurggssggvlhhtrdgtohhmpdhrtghpthhtohepvggsihhgghgvrhhssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhrihhstghvsehlihhsthhsrdhinhhfrhgruggvrggur
 dhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlqdhmvghnthgvvghssehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtohepshhkhhgrnheslhhinhhugihfohhunhgurghtihhonhdrohhrgh
X-GND-Sasl: alex@ghiti.fr

Hi Ignacio,

On 10/03/2025 23:03, Ignacio Encinas wrote:
> Implement endianness swap macros for RISC-V.
>
> Use the rev8 instruction when Zbb is available. Otherwise, rely on the
> default mask-and-shift implementation.
>
> Signed-off-by: Ignacio Encinas <ignacio@iencinas.com>
> ---
> Motivated by [1]. A couple of things to note:
>
> We need a default implementation to fall back on, but there isn't any in
> `asm-generic/swab.h`. Should I introduce a first patch moving
> ___constant_swab<XX> into include/uapi/asm-generic/swab.h?


Yes, that or something else to avoid the code duplication.


>
> I don't particularly like the ARCH_SWAB macro but I can't think of
> anything better that doesn't result in code duplication.
>
> Tested with crc_kunit as pointed out here [2]. I can't provide
> performance numbers as I don't have RISC-V hardware yet.
>
> Ccing everyone involved with [1].
>
> [1] https://lore.kernel.org/all/20250302220426.GC2079@quark.localdomain/
> [2] https://lore.kernel.org/all/20250216225530.306980-1-ebiggers@kernel.org/
> ---
>   arch/riscv/include/asm/swab.h | 81 +++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 81 insertions(+)
>
> diff --git a/arch/riscv/include/asm/swab.h b/arch/riscv/include/asm/swab.h
> new file mode 100644
> index 0000000000000000000000000000000000000000..8f8a13b343f6ffbefbb3c7747ab4e14243852014
> --- /dev/null
> +++ b/arch/riscv/include/asm/swab.h
> @@ -0,0 +1,81 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +#ifndef _ASM_RISCV_SWAB_H
> +#define _ASM_RISCV_SWAB_H
> +
> +#include <linux/types.h>
> +#include <linux/compiler.h>
> +#include <asm/alternative-macros.h>
> +#include <asm/hwcap.h>
> +
> +#if defined(CONFIG_RISCV_ISA_ZBB) && !defined(NO_ALTERNATIVE)


NO_ALTERNATIVE does not exist to my knowledge, and you don't need to 
check for ALTERNATIVE as alternative-macros.h will do the right thing in 
that case.


> +
> +/*
> + * FIXME, RFC PATCH: This is copypasted from include/uapi/linux/swab.h
> + * should I move these `#defines` to include/uapi/asm-generic/swab.h
> + * and include that file here and in include/uapi/linux/swab.h ?
> + */
> +#define ___constant_swab16(x) ((__u16)(				\
> +	(((__u16)(x) & (__u16)0x00ffU) << 8) |			\
> +	(((__u16)(x) & (__u16)0xff00U) >> 8)))
> +
> +#define ___constant_swab32(x) ((__u32)(				\
> +	(((__u32)(x) & (__u32)0x000000ffUL) << 24) |		\
> +	(((__u32)(x) & (__u32)0x0000ff00UL) <<  8) |		\
> +	(((__u32)(x) & (__u32)0x00ff0000UL) >>  8) |		\
> +	(((__u32)(x) & (__u32)0xff000000UL) >> 24)))
> +
> +#define ___constant_swab64(x) ((__u64)(				\
> +	(((__u64)(x) & (__u64)0x00000000000000ffULL) << 56) |	\
> +	(((__u64)(x) & (__u64)0x000000000000ff00ULL) << 40) |	\
> +	(((__u64)(x) & (__u64)0x0000000000ff0000ULL) << 24) |	\
> +	(((__u64)(x) & (__u64)0x00000000ff000000ULL) <<  8) |	\
> +	(((__u64)(x) & (__u64)0x000000ff00000000ULL) >>  8) |	\
> +	(((__u64)(x) & (__u64)0x0000ff0000000000ULL) >> 24) |	\
> +	(((__u64)(x) & (__u64)0x00ff000000000000ULL) >> 40) |	\
> +	(((__u64)(x) & (__u64)0xff00000000000000ULL) >> 56)))
> +
> +#define ___constant_swahw32(x) ((__u32)(			\
> +	(((__u32)(x) & (__u32)0x0000ffffUL) << 16) |		\
> +	(((__u32)(x) & (__u32)0xffff0000UL) >> 16)))
> +
> +#define ___constant_swahb32(x) ((__u32)(			\
> +	(((__u32)(x) & (__u32)0x00ff00ffUL) << 8) |		\
> +	(((__u32)(x) & (__u32)0xff00ff00UL) >> 8)))
> +
> +
> +#define ARCH_SWAB(size) \
> +static __always_inline unsigned long __arch_swab##size(__u##size value) \


I don't like the ARCH_SWAB macro neither but I don't have another 
solution too, maybe someone will come up with some macro magic.


> +{									\
> +	unsigned long x = value;					\
> +									\
> +	asm goto(ALTERNATIVE("j %l[legacy]", "nop", 0,			\
> +			     RISCV_ISA_EXT_ZBB, 1)			\
> +			     :::: legacy);				\
> +									\
> +	asm volatile (".option push\n"					\
> +		      ".option arch,+zbb\n"				\
> +		      "rev8 %0, %1\n"					\
> +		      ".option pop\n"					\
> +		      : "=r" (x) : "r" (x));				\
> +									\
> +	return x >> (BITS_PER_LONG - size);				\
> +									\
> +legacy:									\
> +	return  ___constant_swab##size(value);				\
> +}
> +
> +#ifdef CONFIG_64BIT
> +ARCH_SWAB(64)
> +#define __arch_swab64 __arch_swab64
> +#endif
> +
> +ARCH_SWAB(32)
> +#define __arch_swab32 __arch_swab32
> +
> +ARCH_SWAB(16)
> +#define __arch_swab16 __arch_swab16
> +
> +#undef ARCH_SWAB
> +
> +#endif /* defined(CONFIG_RISCV_ISA_ZBB) && !defined(NO_ALTERNATIVE) */
> +#endif /* _ASM_RISCV_SWAB_H */
>
> ---
> base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b
> change-id: 20250307-riscv-swab-b81b94a9ac1b
>
> Best regards,


It would be nice to have some perf numbers too, maybe Bjorn will chime in :)

Thanks for your patch, looking forward the v2,

Alex


