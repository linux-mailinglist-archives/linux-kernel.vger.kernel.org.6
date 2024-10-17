Return-Path: <linux-kernel+bounces-370513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA1CE9A2DDB
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 21:32:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7968C282986
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 19:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF277227B8D;
	Thu, 17 Oct 2024 19:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b="C92aSNRl"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5150C219CB7
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 19:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729193539; cv=none; b=B/0OuyQd4ZzpMvJ9OmLS7GMQz0o2yvUQbFK4SMF8EDeZqFTAyqiWt73JJbBr5R6q6CPom0YxDJEJMQxXgGqy1lvQtcb5dfRsJO12oVjbTQeUDhrY33tg/1LmtWmS6QwZTwfr1Zqwji9qepzA7NcxCui/W1fDY3ROSs8qrjgqJTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729193539; c=relaxed/simple;
	bh=vcUXd5tt9utnmCVe/nP6iWVCPF6al6ngb6a3ypPbz8U=;
	h=Date:Subject:In-Reply-To:CC:From:To:Message-ID:Mime-Version:
	 Content-Type; b=EkSTrxF5koE9gPkP8EQpCq16vRZ868laPMKwhgETj5/4GxXxsuj9z/XoMl9VsPv3fO2dhL1Z0ILNPtZlpu8m+5ixm2GCzT6SQT9gGVf/Pql2vGgiBgrTNAg9xrhZqT3+WgS0JIpRGHL7mzVq5VMr/qOx+QfMRCkG8gk7HMo0Ero=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com; spf=pass smtp.mailfrom=dabbelt.com; dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b=C92aSNRl; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dabbelt.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-71e7086c231so981722b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 12:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1729193535; x=1729798335; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TfCj0XZYQNwVFG9YcnvaiklTwIyQ/GhWVOU/ROFZAio=;
        b=C92aSNRliXUZa4r6bkC42hbLvd1ICOB0CikdQCc4o/w1HHZOf+RWUVIB4jFrkZ54Uj
         0vgr4ZQ+OeN+1hf3uuvkORB5LcPgLjgoBV1QP3pvVsHXDMheAOE/ndDCakwvdY+qeCT+
         gSKx1wUbQmWgNWnCbN/+6+XFdK8VWI28xh5ophXT20imLaeKUDux8sGW5soAhYc9iZts
         kSUvO2HtaYXFRg1eUAMY13vaP6NMx6iGQHu0DVJKHGckQL/Ih+VvLpZchsRZ8y+FKPHn
         z+9mbSqniDgYEr28lhAiJSWic/N1jiRPSUcyOjoPRPg99tsw2VGR4XyXjkD+Nnr0GtAS
         YK2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729193535; x=1729798335;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TfCj0XZYQNwVFG9YcnvaiklTwIyQ/GhWVOU/ROFZAio=;
        b=N8Y84E4vNFZNYdP7vU8JBpvhKu0fyWXkwCfqpwYR2iG08hIJkMuTifqaCEwmwc5r5p
         m2QbQIivQN6k0w/cQq64RNXbTkkFCAxKtqpQ9KpGA0fDJX0fik4gz63vPvlzF5JuakIg
         oqqGQfqspwTbS58d6CNhrx7Lh58ZiVkwhigq5FDBzkTJljl/WQ/o8jGthxD78dOlo4Ma
         TwWvtr5daxf5mTCZHYpfU709j0Z0ZKOZAsdV4cKweOVQiauRoCCPCkxzi+ewGlgFZqJo
         byBKhT5+3Kx26xRWgVznsCqI5ccndHTBrKtczScGzVw/3fG6H7kwSh1jsVlZOJU6GKEl
         nX8w==
X-Forwarded-Encrypted: i=1; AJvYcCXIN7gneEmhIkFYSbgNKilytro5urkpDgogTtmCSgijY+ic3pChrPeiJv1113Y6b1MjSrpOBR43d+GrzDQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXZOuKN7+RNA+FflT4mF4GpGy5F1stKg0MoSBBygBfWxbe4e8y
	Q647cDmvPfQ1qp8ppwgbC+F+/8hW4XG+nY/bqvRkK2bVGhbUgbJOm4SEkOXcUtU=
X-Google-Smtp-Source: AGHT+IEYQqSWyT9DM1JblvCRXie6c7wEQ7WCCMd8WOwGbnCY29CemQ9nchGTw3++94PPWZqamrgDPA==
X-Received: by 2002:a05:6a00:2d25:b0:71e:5950:97d2 with SMTP id d2e1a72fcca58-71ea3328e08mr68611b3a.17.1729193534443;
        Thu, 17 Oct 2024 12:32:14 -0700 (PDT)
Received: from localhost ([50.145.13.30])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ea34a7fa8sm9965b3a.184.2024.10.17.12.32.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 12:32:13 -0700 (PDT)
Date: Thu, 17 Oct 2024 12:32:13 -0700 (PDT)
X-Google-Original-Date: Thu, 17 Oct 2024 12:32:02 PDT (-0700)
Subject:     Re: [PATCH v11 4/5] jump_label: adjust inline asm to be consistent
In-Reply-To: <20241015-tracepoint-v11-4-cceb65820089@google.com>
CC: rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
  peterz@infradead.org, jpoimboe@kernel.org, jbaron@akamai.com, Ard Biesheuvel <ardb@kernel.org>,
  ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com, boqun.feng@gmail.com,
  gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me, a.hindborg@kernel.org,
  linux-trace-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
  Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
  dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, seanjc@google.com, ubizjak@gmail.com,
  Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
  oliver.upton@linux.dev, Mark Rutland <mark.rutland@arm.com>, ryan.roberts@arm.com, tabba@google.com,
  linux-arm-kernel@lists.infradead.org, Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
  apatel@ventanamicro.com, ajones@ventanamicro.com, alexghiti@rivosinc.com,
  Conor Dooley <conor.dooley@microchip.com>, samuel.holland@sifive.com, linux-riscv@lists.infradead.org,
  chenhuacai@kernel.org, kernel@xen0n.name, maobibo@loongson.cn, yangtiezhu@loongson.cn,
  akpm@linux-foundation.org, zhaotianrui@loongson.cn, loongarch@lists.linux.dev, aliceryhl@google.com
From: Palmer Dabbelt <palmer@dabbelt.com>
To: aliceryhl@google.com
Message-ID: <mhng-0614da52-c420-4be1-a5b9-64dacae91d0e@palmer-ri-x1c9a>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On Tue, 15 Oct 2024 06:14:58 PDT (-0700), aliceryhl@google.com wrote:
> To avoid duplication of inline asm between C and Rust, we need to
> import the inline asm from the relevant `jump_label.h` header into Rust.
> To make that easier, this patch updates the header files to expose the
> inline asm via a new ARCH_STATIC_BRANCH_ASM macro.
>
> The header files are all updated to define a ARCH_STATIC_BRANCH_ASM that
> takes the same arguments in a consistent order so that Rust can use the
> same logic for every architecture.
>
> Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Co-developed-by: Miguel Ojeda <ojeda@kernel.org>
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
>  arch/arm/include/asm/jump_label.h       | 14 +++++----
>  arch/arm64/include/asm/jump_label.h     | 20 ++++++++-----
>  arch/loongarch/include/asm/jump_label.h | 16 +++++++----
>  arch/riscv/include/asm/jump_label.h     | 50 ++++++++++++++++++---------------
>  arch/x86/include/asm/jump_label.h       | 35 +++++++++--------------
>  5 files changed, 73 insertions(+), 62 deletions(-)

[...]

> diff --git a/arch/riscv/include/asm/jump_label.h b/arch/riscv/include/asm/jump_label.h
> index 1c768d02bd0c..87a71cc6d146 100644
> --- a/arch/riscv/include/asm/jump_label.h
> +++ b/arch/riscv/include/asm/jump_label.h
> @@ -16,21 +16,28 @@
>
>  #define JUMP_LABEL_NOP_SIZE 4
>
> +#define JUMP_TABLE_ENTRY(key, label)			\
> +	".pushsection	__jump_table, \"aw\"	\n\t"	\
> +	".align		" RISCV_LGPTR "		\n\t"	\
> +	".long		1b - ., " label " - .	\n\t"	\
> +	"" RISCV_PTR "	" key " - .		\n\t"	\
> +	".popsection				\n\t"
> +
> +/* This macro is also expanded on the Rust side. */
> +#define ARCH_STATIC_BRANCH_ASM(key, label)		\
> +	"	.align		2		\n\t"	\
> +	"	.option push			\n\t"	\
> +	"	.option norelax			\n\t"	\
> +	"	.option norvc			\n\t"	\
> +	"1:	nop				\n\t"	\
> +	"	.option pop			\n\t"	\
> +	JUMP_TABLE_ENTRY(key, label)
> +
>  static __always_inline bool arch_static_branch(struct static_key * const key,
>  					       const bool branch)
>  {
>  	asm goto(
> -		"	.align		2			\n\t"
> -		"	.option push				\n\t"
> -		"	.option norelax				\n\t"
> -		"	.option norvc				\n\t"
> -		"1:	nop					\n\t"
> -		"	.option pop				\n\t"
> -		"	.pushsection	__jump_table, \"aw\"	\n\t"
> -		"	.align		" RISCV_LGPTR "		\n\t"
> -		"	.long		1b - ., %l[label] - .	\n\t"
> -		"	" RISCV_PTR "	%0 - .			\n\t"
> -		"	.popsection				\n\t"
> +		ARCH_STATIC_BRANCH_ASM("%0", "%l[label]")
>  		:  :  "i"(&((char *)key)[branch]) :  : label);
>
>  	return false;
> @@ -38,21 +45,20 @@ static __always_inline bool arch_static_branch(struct static_key * const key,
>  	return true;
>  }
>
> +#define ARCH_STATIC_BRANCH_JUMP_ASM(key, label)		\
> +	"	.align		2		\n\t"	\
> +	"	.option push			\n\t"	\
> +	"	.option norelax			\n\t"	\
> +	"	.option norvc			\n\t"	\
> +	"1:	j	" label "		\n\t" \
> +	"	.option pop			\n\t"	\
> +	JUMP_TABLE_ENTRY(key, label)
> +
>  static __always_inline bool arch_static_branch_jump(struct static_key * const key,
>  						    const bool branch)
>  {
>  	asm goto(
> -		"	.align		2			\n\t"
> -		"	.option push				\n\t"
> -		"	.option norelax				\n\t"
> -		"	.option norvc				\n\t"
> -		"1:	j		%l[label]		\n\t"
> -		"	.option pop				\n\t"
> -		"	.pushsection	__jump_table, \"aw\"	\n\t"
> -		"	.align		" RISCV_LGPTR "		\n\t"
> -		"	.long		1b - ., %l[label] - .	\n\t"
> -		"	" RISCV_PTR "	%0 - .			\n\t"
> -		"	.popsection				\n\t"
> +		ARCH_STATIC_BRANCH_JUMP_ASM("%0", "%l[label]")
>  		:  :  "i"(&((char *)key)[branch]) :  : label);
>
>  	return false;

Acked-by: Palmer Dabbelt <palmer@rivosinc.com> # RISC-V

