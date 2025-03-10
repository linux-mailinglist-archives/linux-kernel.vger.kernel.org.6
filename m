Return-Path: <linux-kernel+bounces-553861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10F22A58FE7
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 10:41:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8DC73AD7F8
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 09:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3401225A23;
	Mon, 10 Mar 2025 09:40:29 +0000 (UTC)
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2844A225407
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 09:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741599629; cv=none; b=GhX5E+yL3p7I31c1Gf3GY8UAjvPgCtPBSaTtPDbz76wZQOU8oTb3LqODwj064mU1IDdyxTOsBKc/KZrq/BVbEdqcAGbu3O1yNY1QPCzPCoH+V1kGxDzigLSDBY4F/qh6HrpfDZhjJKO/thjQGSH4PMX9l98NDICil1P4vytyD7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741599629; c=relaxed/simple;
	bh=NZmNws+AfNWjWoQ4abWeUD/oZ5nnGIKNYL+4LDKcGGM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cX7qoCRX+NoCnRhPW8Y4399cJ1rROvQaK7AiR0GmIeanui2WdR+VIZZr2VIN/Vg33diOp0bgDhZFLf2uw8rYauWCncbt2+7uSCKSkstaPoazlGVmdZw4dFFuH2GzqOV1W+49Tj48ybtPFSLp8jqPuVLXrTnC3/jPlBMLBreyAXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id D2E8F43304;
	Mon, 10 Mar 2025 09:40:16 +0000 (UTC)
Message-ID: <e015a144-fd3f-4a71-97bf-64c784406b21@ghiti.fr>
Date: Mon, 10 Mar 2025 10:40:16 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8] riscv: Add runtime constant support
To: Charlie Jenkins <charlie@rivosinc.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Ard Biesheuvel <ardb@kernel.org>,
 Ben Dooks <ben.dooks@codethink.co.uk>,
 Pasha Bouzarjomehri <pasha@rivosinc.com>,
 Emil Renner Berthing <emil.renner.berthing@canonical.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250305-runtime_const_riscv-v8-1-fa66f3468dac@rivosinc.com>
Content-Language: en-US
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20250305-runtime_const_riscv-v8-1-fa66f3468dac@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduudeltdduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthejredttddvjeenucfhrhhomheptehlvgigrghnughrvgcuifhhihhtihcuoegrlhgvgiesghhhihhtihdrfhhrqeenucggtffrrghtthgvrhhnpedtuedtheduuddvfffgvefgfeehveeigeehtdduffdttdeffeduvdeftdegleefueenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhlughsrdhssgenucfkphepvddttddumeekiedumeeffeekvdemvghfledtmeehvdekmedufheijeemkedugedumeekgegvkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvtddtudemkeeiudemfeefkedvmegvfheltdemhedvkeemudhfieejmeekudegudemkeegvgekpdhhvghloheplgfkrfggieemvddttddumeekiedumeeffeekvdemvghfledtmeehvdekmedufheijeemkedugedumeekgegvkegnpdhmrghilhhfrhhomheprghlvgigsehghhhithhirdhfrhdpnhgspghrtghpthhtohepledprhgtphhtthhopegthhgrrhhlihgvsehrihhvohhsihhntgdrtghomhdprhgtphhtthhopehprghulhdrfigrlhhmshhlvgihsehsihhfihhvvgdrtghomhdprhgtp
 hhtthhopehprghlmhgvrhesuggrsggsvghlthdrtghomhdprhgtphhtthhopegrrhgusgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsggvnhdrughoohhkshestghouggvthhhihhnkhdrtghordhukhdprhgtphhtthhopehprghshhgrsehrihhvohhsihhntgdrtghomhdprhgtphhtthhopegvmhhilhdrrhgvnhhnvghrrdgsvghrthhhihhnghestggrnhhonhhitggrlhdrtghomhdprhgtphhtthhopehlihhnuhigqdhrihhstghvsehlihhsthhsrdhinhhfrhgruggvrggurdhorhhg
X-GND-Sasl: alex@ghiti.fr

Hi Charlie,

On 05/03/2025 23:53, Charlie Jenkins wrote:
> Implement the runtime constant infrastructure for riscv. Use this
> infrastructure to generate constants to be used by the d_hash()
> function.
>
> This is the riscv variant of commit 94a2bc0f611c ("arm64: add 'runtime
> constant' support") and commit e3c92e81711d ("runtime constants: add
> x86 architecture support").
>
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> ---
> Ard brought this to my attention in this patch [1].
>
> I benchmarked this patch on the Nezha D1 (which does not contain Zba or
> Zbkb so it uses the default algorithm) by navigating through a large
> directory structure. I created a 1000-deep directory structure and then
> cd and ls through it. With this patch there was a 0.57% performance
> improvement.
>
> [1] https://lore.kernel.org/lkml/CAMj1kXE4DJnwFejNWQu784GvyJO=aGNrzuLjSxiowX_e7nW8QA@mail.gmail.com/
> ---
> Changes in v8:
> - EDITME: describe what is new in this series revision.
> - EDITME: use bulletpoints and terse descriptions.
> - Link to v7: https://lore.kernel.org/r/20250218-runtime_const_riscv-v7-1-e431763157ff@rivosinc.com
>
> Changes in v7:
> - Added benchmarking info
> - Added CONFIG_RISCV_ISA_ZBA and CONFIG_RISCV_ISA_ZBKB to check that the
>    compiler supports the extensions.
> - Link to v6: https://lore.kernel.org/r/20250212-runtime_const_riscv-v6-1-3ef0146b310b@rivosinc.com
>
> Changes in v6:
> - .option arch only became officially supported by clang in version 17.
>    Add a config to check that and guard the alternatives uses .option
>    arch.
> - Link to v5: https://lore.kernel.org/r/20250203-runtime_const_riscv-v5-1-bc61736a3229@rivosinc.com
>
> Changes in v5:
> - Split instructions into 16-bit parcels to avoid alignment (Emil)
> - Link to v4: https://lore.kernel.org/r/20250130-runtime_const_riscv-v4-1-2d36c41b7b9c@rivosinc.com
>
> Changes in v4:
> - Add newlines after riscv32 assembler directives
> - Align instructions along 32-bit boundary (Emil)
> - Link to v3: https://lore.kernel.org/r/20250128-runtime_const_riscv-v3-1-11922989e2d3@rivosinc.com
>
> Changes in v3:
> - Leverage "pack" instruction for runtime_const_ptr() to reduce hot path
>    by 3 instructions if Zbkb is supported. Suggested by Pasha Bouzarjomehri (pasha@rivosinc.com)
> - Link to v2: https://lore.kernel.org/r/20250127-runtime_const_riscv-v2-1-95ae7cf97a39@rivosinc.com
>
> Changes in v2:
> - Treat instructions as __le32 and do proper conversions (Ben)
> - Link to v1: https://lore.kernel.org/r/20250127-runtime_const_riscv-v1-1-795b023ea20b@rivosinc.com
> ---
>   arch/riscv/Kconfig                     |  22 +++
>   arch/riscv/include/asm/runtime-const.h | 254 +++++++++++++++++++++++++++++++++
>   arch/riscv/kernel/vmlinux.lds.S        |   3 +
>   3 files changed, 279 insertions(+)
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 7612c52e9b1e35607f1dd4603a596416d3357a71..c123f7c0579c1aca839e3c04bdb662d6856ae765 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -783,6 +783,28 @@ config RISCV_ISA_ZBC
>   
>   	   If you don't know what to do here, say Y.
>   
> +config TOOLCHAIN_HAS_ZBKB
> +	bool
> +	default y
> +	depends on !64BIT || $(cc-option,-mabi=lp64 -march=rv64ima_zbkb)
> +	depends on !32BIT || $(cc-option,-mabi=ilp32 -march=rv32ima_zbkb)
> +	depends on LLD_VERSION >= 150000 || LD_VERSION >= 23900
> +	depends on AS_HAS_OPTION_ARCH
> +
> +config RISCV_ISA_ZBKB
> +	bool "Zbkb extension support for bit manipulation instructions"
> +	depends on TOOLCHAIN_HAS_ZBKB
> +	depends on RISCV_ALTERNATIVE
> +	default y
> +	help
> +	   Adds support to dynamically detect the presence of the ZBKB
> +	   extension (bit manipulation for cryptography) and enable its usage.
> +
> +	   The Zbkb extension provides instructions to accelerate a number
> +	   of common cryptography operations (pack, zip, etc).
> +
> +	   If you don't know what to do here, say Y.
> +
>   config RISCV_ISA_ZICBOM
>   	bool "Zicbom extension support for non-coherent DMA operation"
>   	depends on MMU
> diff --git a/arch/riscv/include/asm/runtime-const.h b/arch/riscv/include/asm/runtime-const.h
> new file mode 100644
> index 0000000000000000000000000000000000000000..db2c253a4c37f58927179868d53db824f42e491e
> --- /dev/null
> +++ b/arch/riscv/include/asm/runtime-const.h
> @@ -0,0 +1,254 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _ASM_RISCV_RUNTIME_CONST_H
> +#define _ASM_RISCV_RUNTIME_CONST_H
> +
> +#include <asm/alternative.h>
> +#include <asm/cacheflush.h>
> +#include <asm/text-patching.h>
> +#include <linux/uaccess.h>
> +
> +#ifdef CONFIG_32BIT
> +#define runtime_const_ptr(sym)					\
> +({								\
> +	typeof(sym) __ret;					\
> +	asm_inline(".option push\n\t"				\
> +		".option norvc\n\t"				\
> +		"1:\t"						\
> +		"lui	%[__ret],0x89abd\n\t"			\
> +		"addi	%[__ret],%[__ret],-0x211\n\t"		\
> +		".option pop\n\t"				\
> +		".pushsection runtime_ptr_" #sym ",\"a\"\n\t"	\
> +		".long 1b - .\n\t"				\
> +		".popsection"					\
> +		: [__ret] "=r" (__ret));			\
> +	__ret;							\
> +})
> +#else
> +/*
> + * Loading 64-bit constants into a register from immediates is a non-trivial
> + * task on riscv64. To get it somewhat performant, load 32 bits into two
> + * different registers and then combine the results.
> + *
> + * If the processor supports the Zbkb extension, we can combine the final
> + * "slli,slli,srli,add" into the single "pack" instruction. If the processor
> + * doesn't support Zbkb but does support the Zbb extension, we can
> + * combine the final "slli,srli,add" into one instruction "add.uw".
> + */
> +#define RISCV_RUNTIME_CONST_64_PREAMBLE				\
> +	".option push\n\t"					\
> +	".option norvc\n\t"					\
> +	"1:\t"							\
> +	"lui	%[__ret],0x89abd\n\t"				\
> +	"lui	%[__tmp],0x1234\n\t"				\
> +	"addiw	%[__ret],%[__ret],-0x211\n\t"			\
> +	"addiw	%[__tmp],%[__tmp],0x567\n\t"			\
> +
> +#define RISCV_RUNTIME_CONST_64_BASE				\
> +	"slli	%[__tmp],%[__tmp],32\n\t"			\
> +	"slli	%[__ret],%[__ret],32\n\t"			\
> +	"srli	%[__ret],%[__ret],32\n\t"			\
> +	"add	%[__ret],%[__ret],%[__tmp]\n\t"			\
> +
> +#define RISCV_RUNTIME_CONST_64_ZBA				\
> +	".option push\n\t"					\
> +	".option arch,+zba\n\t"					\
> +	"slli	%[__tmp],%[__tmp],32\n\t"			\
> +	"add.uw %[__ret],%[__ret],%[__tmp]\n\t"			\
> +	"nop\n\t"						\
> +	"nop\n\t"						\
> +	".option pop\n\t"					\
> +
> +#define RISCV_RUNTIME_CONST_64_ZBKB				\
> +	".option push\n\t"					\
> +	".option arch,+zbkb\n\t"				\
> +	"pack	%[__ret],%[__ret],%[__tmp]\n\t"			\
> +	"nop\n\t"						\
> +	"nop\n\t"						\
> +	"nop\n\t"						\
> +	".option pop\n\t"					\
> +
> +#define RISCV_RUNTIME_CONST_64_POSTAMBLE(sym)			\
> +	".option pop\n\t"					\
> +	".pushsection runtime_ptr_" #sym ",\"a\"\n\t"		\
> +	".long 1b - .\n\t"					\
> +	".popsection"						\
> +
> +#if defined(CONFIG_RISCV_ISA_ZBA) && defined(CONFIG_RISCV_ISA_ZBKB)
> +#define runtime_const_ptr(sym)						\
> +({									\
> +	typeof(sym) __ret, __tmp;					\
> +	asm_inline(RISCV_RUNTIME_CONST_64_PREAMBLE			\
> +		ALTERNATIVE_2(						\
> +			RISCV_RUNTIME_CONST_64_BASE,			\
> +			RISCV_RUNTIME_CONST_64_ZBA,			\
> +			0, RISCV_ISA_EXT_ZBA, 1,			\
> +			RISCV_RUNTIME_CONST_64_ZBKB,			\
> +			0, RISCV_ISA_EXT_ZBKB, 1			\
> +		)							\
> +		RISCV_RUNTIME_CONST_64_POSTAMBLE(sym)			\
> +		: [__ret] "=r" (__ret), [__tmp] "=r" (__tmp));		\
> +	__ret;								\
> +})
> +#elif defined(CONFIG_RISCV_ISA_ZBA)
> +#define runtime_const_ptr(sym)						\
> +({									\
> +	typeof(sym) __ret, __tmp;					\
> +	asm_inline(RISCV_RUNTIME_CONST_64_PREAMBLE			\
> +		ALTERNATIVE(						\
> +			RISCV_RUNTIME_CONST_64_BASE,			\
> +			RISCV_RUNTIME_CONST_64_ZBA,			\
> +			0, RISCV_ISA_EXT_ZBA, 1				\
> +		)							\
> +		RISCV_RUNTIME_CONST_64_POSTAMBLE(sym)			\
> +		: [__ret] "=r" (__ret), [__tmp] "=r" (__tmp));		\
> +	__ret;								\
> +})
> +#elif defined(CONFIG_RISCV_ISA_ZBKB)
> +#define runtime_const_ptr(sym)						\
> +({									\
> +	typeof(sym) __ret, __tmp;					\
> +	asm_inline(RISCV_RUNTIME_CONST_64_PREAMBLE			\
> +		ALTERNATIVE(						\
> +			RISCV_RUNTIME_CONST_64_BASE,			\
> +			RISCV_RUNTIME_CONST_64_ZBKB,			\
> +			0, RISCV_ISA_EXT_ZBKB, 1			\
> +		)							\
> +		RISCV_RUNTIME_CONST_64_POSTAMBLE(sym)			\
> +		: [__ret] "=r" (__ret), [__tmp] "=r" (__tmp));		\
> +	__ret;								\
> +})
> +#else
> +#define runtime_const_ptr(sym)						\
> +({									\
> +	typeof(sym) __ret, __tmp;					\
> +	asm_inline(RISCV_RUNTIME_CONST_64_PREAMBLE			\
> +		RISCV_RUNTIME_CONST_64_BASE				\
> +		RISCV_RUNTIME_CONST_64_POSTAMBLE(sym)			\
> +		: [__ret] "=r" (__ret), [__tmp] "=r" (__tmp));		\
> +	__ret;								\
> +})
> +#endif
> +#endif
> +
> +#ifdef CONFIG_32BIT
> +#define SRLI "srli "
> +#else
> +#define SRLI "srliw "
> +#endif


Nit: you could move that to include/asm/asm.h where we define 
architecture-width independent macro instructions (see REG_S for example).


> +
> +#define runtime_const_shift_right_32(val, sym)			\
> +({								\
> +	u32 __ret;						\
> +	asm_inline(".option push\n\t"				\
> +		".option norvc\n\t"				\
> +		"1:\t"						\
> +		SRLI "%[__ret],%[__val],12\n\t"			\
> +		".option pop\n\t"				\
> +		".pushsection runtime_shift_" #sym ",\"a\"\n\t"	\
> +		".long 1b - .\n\t"				\
> +		".popsection"					\
> +		: [__ret] "=r" (__ret)				\
> +		: [__val] "r" (val));				\
> +	__ret;							\
> +})
> +
> +#define runtime_const_init(type, sym) do {			\
> +	extern s32 __start_runtime_##type##_##sym[];		\
> +	extern s32 __stop_runtime_##type##_##sym[];		\
> +								\
> +	runtime_const_fixup(__runtime_fixup_##type,		\
> +			    (unsigned long)(sym),		\
> +			    __start_runtime_##type##_##sym,	\
> +			    __stop_runtime_##type##_##sym);	\
> +} while (0)
> +
> +static inline void __runtime_fixup_caches(void *where, unsigned int insns)
> +{
> +	/* On riscv there are currently only cache-wide flushes so va is ignored. */
> +	__always_unused uintptr_t va = (uintptr_t)where;
> +
> +	flush_icache_range(va, va + 4 * insns);
> +}
> +
> +/*
> + * The 32-bit immediate is stored in a lui+addi pairing.
> + * lui holds the upper 20 bits of the immediate in the first 20 bits of the instruction.
> + * addi holds the lower 12 bits of the immediate in the first 12 bits of the instruction.
> + */
> +static inline void __runtime_fixup_32(__le16 *lui_parcel, __le16 *addi_parcel, unsigned int val)
> +{
> +	unsigned int lower_immediate, upper_immediate;
> +	__le32 lui_res, addi_res;
> +	u32 lui_insn, addi_insn;
> +
> +	lui_insn = (u32)le16_to_cpu(lui_parcel[0]) | (u32)le16_to_cpu(lui_parcel[1]) << 16;
> +	addi_insn = (u32)le16_to_cpu(addi_parcel[0]) | (u32)le16_to_cpu(addi_parcel[1]) << 16;
> +
> +	lower_immediate = sign_extend32(val, 11);
> +	upper_immediate = (val - lower_immediate);
> +
> +	if (upper_immediate & 0xfffff000) {
> +		/* replace upper 20 bits of lui with upper immediate */
> +		lui_insn &= 0x00000fff;
> +		lui_insn |= upper_immediate & 0xfffff000;
> +	} else {
> +		/* replace lui with nop if immediate is small enough to fit in addi */
> +		lui_insn = 0x00000013;


There exists a NOP4 macro defined in ftrace.h, can you try to use it?


> +	}
> +
> +	if (lower_immediate & 0x00000fff) {
> +		/* replace upper 12 bits of addi with lower 12 bits of val */
> +		addi_insn &= 0x000fffff;
> +		addi_insn |= (lower_immediate & 0x00000fff) << 20;
> +	} else {
> +		/* replace addi with nop if lower_immediate is empty */
> +		addi_insn = 0x00000013;


Ditto here


> +	}
> +
> +	addi_res = cpu_to_le32(addi_insn);
> +	lui_res = cpu_to_le32(lui_insn);
> +	patch_insn_write(addi_parcel, &addi_res, sizeof(addi_res));
> +	patch_insn_write(lui_parcel, &lui_res, sizeof(lui_res));
> +}
> +
> +static inline void __runtime_fixup_ptr(void *where, unsigned long val)
> +{
> +#ifdef CONFIG_32BIT
> +		__runtime_fixup_32(where, where + 4, val);
> +		__runtime_fixup_caches(where, 2);
> +#else
> +		__runtime_fixup_32(where, where + 8, val);
> +		__runtime_fixup_32(where + 4, where + 12, val >> 32);
> +		__runtime_fixup_caches(where, 4);
> +#endif
> +}
> +
> +/*
> + * Replace the least significant 5 bits of the srli/srliw immediate that is
> + * located at bits 20-24
> + */
> +static inline void __runtime_fixup_shift(void *where, unsigned long val)
> +{
> +	__le16 *parcel = where;
> +	__le32 res;
> +	u32 insn;
> +
> +	insn = (u32)le16_to_cpu(parcel[0]) | (u32)le16_to_cpu(parcel[1]) << 16;
> +
> +	insn &= 0xfe0fffff;
> +	insn |= (val & 0b11111) << 20;
> +
> +	res = cpu_to_le32(insn);
> +	patch_text_nosync(where, &res, sizeof(insn));
> +}
> +
> +static inline void runtime_const_fixup(void (*fn)(void *, unsigned long),
> +				       unsigned long val, s32 *start, s32 *end)
> +{
> +	while (start < end) {
> +		fn(*start + (void *)start, val);
> +		start++;
> +	}
> +}
> +
> +#endif /* _ASM_RISCV_RUNTIME_CONST_H */
> diff --git a/arch/riscv/kernel/vmlinux.lds.S b/arch/riscv/kernel/vmlinux.lds.S
> index 002ca58dd998cb78b662837b5ebac988fb6c77bb..61bd5ba6680a786bf1db7dc37bf1acda0639b5c7 100644
> --- a/arch/riscv/kernel/vmlinux.lds.S
> +++ b/arch/riscv/kernel/vmlinux.lds.S
> @@ -97,6 +97,9 @@ SECTIONS
>   	{
>   		EXIT_DATA
>   	}
> +
> +	RUNTIME_CONST_VARIABLES
> +
>   	PERCPU_SECTION(L1_CACHE_BYTES)
>   
>   	.rel.dyn : {
>
> ---
> base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b
> change-id: 20250123-runtime_const_riscv-6cd854ee2817


Apart from the nits above that are up to you to fixup, you can add:

Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Thanks,

Alex


