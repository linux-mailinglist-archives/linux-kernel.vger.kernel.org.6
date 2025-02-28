Return-Path: <linux-kernel+bounces-538297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64AE5A496CC
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 11:17:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 417F43B7CED
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 10:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B68E25E81E;
	Fri, 28 Feb 2025 10:13:46 +0000 (UTC)
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 432E325B677;
	Fri, 28 Feb 2025 10:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740737625; cv=none; b=LEVNnlppyKOHubFJytN32pNcXhnrEOa2I1v2lMBMwIzTqggNXZQtmurTyvFPNGhxI5h4bKGHcnKA/Kz+Rs1kxbl6e2qI3kAXIlYa7g9k+g0qgWLs7IRuZExyRXAvocCzZFL5b+aGbMeGq0/VhqpjyfPihCLszOT/eKg8PwQTNNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740737625; c=relaxed/simple;
	bh=LX3SAwyCFVjK8BLSUJrXqGAcdTvg0eAP7yXzGFnL0jo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SlydLx2CXO0ZESZ6+0fUY2adekH8VLmpa7MNnK/Mq3z8sqVJ1n7AM6hhBalA5WjFIPlZ0sHc3HfYaUBpuQdvV9sqSvp21K5HVYnMBfCnz9qNeZ34A6NWSuI8T7MTXVyu4GBH+oJO9XDjI2voUiuqgWVmuypBketGB8UiN5pZNLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9DDB144453;
	Fri, 28 Feb 2025 10:13:33 +0000 (UTC)
Message-ID: <608d690a-54ad-4c1e-bf4b-b21c81792cfd@ghiti.fr>
Date: Fri, 28 Feb 2025 11:13:32 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/5] riscv/bug: Add ARCH_WARN_ASM macro for BUG/WARN
 asm code sharing with Rust
Content-Language: en-US
To: FUJITA Tomonori <fujita.tomonori@gmail.com>,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Cc: x86@kernel.org, linux-riscv@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, peterz@infradead.org, hpa@zytor.com,
 paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
 catalin.marinas@arm.com, will@kernel.org, chenhuacai@kernel.org,
 kernel@xen0n.name, tangyouling@loongson.cn, hejinyang@loongson.cn,
 yangtiezhu@loongson.cn, ojeda@kernel.org, alex.gaynor@gmail.com,
 boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
 benno.lossin@proton.me, a.hindborg@kernel.org, aliceryhl@google.com,
 tmgross@umich.edu
References: <20250213135759.190006-1-fujita.tomonori@gmail.com>
 <20250213135759.190006-3-fujita.tomonori@gmail.com>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20250213135759.190006-3-fujita.tomonori@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeltdduvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpeetlhgvgigrnhgurhgvucfihhhithhiuceorghlvgigsehghhhithhirdhfrheqnecuggftrfgrthhtvghrnheptdfhleefjeegheevgeeljeellefgvefhkeeiffekueejteefvdevhfelvdeggeeinecukfhppedvtddtudemkeeiudemfeefkedvmegvfheltdemgegrvggsmeguieefugemvdgskeehmegvtgdtugenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvtddtudemkeeiudemfeefkedvmegvfheltdemgegrvggsmeguieefugemvdgskeehmegvtgdtugdphhgvlhhopeglkffrggeimedvtddtudemkeeiudemfeefkedvmegvfheltdemgegrvggsmeguieefugemvdgskeehmegvtgdtuggnpdhmrghilhhfrhhomheprghlvgigsehghhhithhirdhfrhdpnhgspghrtghpthhtohepfedvpdhrtghpthhtohepfhhujhhithgrrdhtohhmohhnohhrihesghhmrghilhdrtghomhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehruhhsthdqfhhorhdql
 hhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopeigkeeisehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhrihhstghvsehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtoheplhhinhhugidqrghrmhdqkhgvrhhnvghlsehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtoheplhhoohhnghgrrhgthheslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopehtghhlgieslhhinhhuthhrohhnihigrdguvg
X-GND-Sasl: alex@ghiti.fr

Hi FUJITA,

On 13/02/2025 14:57, FUJITA Tomonori wrote:
> Add new ARCH_WARN_ASM macro for BUG/WARN assembly code sharing with
> Rust to avoid the duplication.
>
> No functional changes.
>
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
> ---
>   arch/riscv/include/asm/bug.h | 37 +++++++++++++++++++++---------------
>   1 file changed, 22 insertions(+), 15 deletions(-)
>
> diff --git a/arch/riscv/include/asm/bug.h b/arch/riscv/include/asm/bug.h
> index 1aaea81fb141..6ab13b56feb0 100644
> --- a/arch/riscv/include/asm/bug.h
> +++ b/arch/riscv/include/asm/bug.h
> @@ -31,40 +31,45 @@ typedef u32 bug_insn_t;
>   
>   #ifdef CONFIG_GENERIC_BUG_RELATIVE_POINTERS
>   #define __BUG_ENTRY_ADDR	RISCV_INT " 1b - ."
> -#define __BUG_ENTRY_FILE	RISCV_INT " %0 - ."
> +#define __BUG_ENTRY_FILE(file)	RISCV_INT " " file " - ."
>   #else
>   #define __BUG_ENTRY_ADDR	RISCV_PTR " 1b"
> -#define __BUG_ENTRY_FILE	RISCV_PTR " %0"
> +#define __BUG_ENTRY_FILE(file)	RISCV_PTR " " file
>   #endif
>   
>   #ifdef CONFIG_DEBUG_BUGVERBOSE
> -#define __BUG_ENTRY			\
> +#define __BUG_ENTRY(file, line, flags)	\
>   	__BUG_ENTRY_ADDR "\n\t"		\
> -	__BUG_ENTRY_FILE "\n\t"		\
> -	RISCV_SHORT " %1\n\t"		\
> -	RISCV_SHORT " %2"
> +	__BUG_ENTRY_FILE(file) "\n\t"	\
> +	RISCV_SHORT " " line "\n\t"	\
> +	RISCV_SHORT " " flags
>   #else
> -#define __BUG_ENTRY			\
> -	__BUG_ENTRY_ADDR "\n\t"		\
> -	RISCV_SHORT " %2"
> +#define __BUG_ENTRY(file, line, flags)		\
> +	__BUG_ENTRY_ADDR "\n\t"			\
> +	RISCV_SHORT " " flags
>   #endif
>   
>   #ifdef CONFIG_GENERIC_BUG
> -#define __BUG_FLAGS(flags)					\
> -do {								\
> -	__asm__ __volatile__ (					\
> +
> +#define ARCH_WARN_ASM(file, line, flags, size)			\
>   		"1:\n\t"					\
>   			"ebreak\n"				\
>   			".pushsection __bug_table,\"aw\"\n\t"	\
>   		"2:\n\t"					\
> -			__BUG_ENTRY "\n\t"			\
> -			".org 2b + %3\n\t"                      \
> -			".popsection"				\
> +		__BUG_ENTRY(file, line, flags) "\n\t"		\
> +			".org 2b + " size "\n\t"                \
> +			".popsection\n"				\
> +
> +#define __BUG_FLAGS(flags)					\
> +do {								\
> +	__asm__ __volatile__ (					\
> +		ARCH_WARN_ASM("%0", "%1", "%2", "%3")		\
>   		:						\
>   		: "i" (__FILE__), "i" (__LINE__),		\
>   		  "i" (flags),					\
>   		  "i" (sizeof(struct bug_entry)));              \
>   } while (0)
> +
>   #else /* CONFIG_GENERIC_BUG */
>   #define __BUG_FLAGS(flags) do {					\
>   	__asm__ __volatile__ ("ebreak\n");			\
> @@ -78,6 +83,8 @@ do {								\
>   
>   #define __WARN_FLAGS(flags) __BUG_FLAGS(BUGFLAG_WARNING|(flags))
>   
> +#define ARCH_WARN_REACHABLE
> +
>   #define HAVE_ARCH_BUG
>   
>   #include <asm-generic/bug.h>


This looks good to me so:

Acked-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Thanks,

Alex


