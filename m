Return-Path: <linux-kernel+bounces-206790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3576F900DBC
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 23:59:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 214831C21075
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 21:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EB6115534A;
	Fri,  7 Jun 2024 21:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="oxe2qypZ"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06B044C8C
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 21:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717797545; cv=none; b=IvvctPsHEF+ctkXFBwmm1B0rEyKzcabNgHAHI65KKB1QyRT4haJefK/g9V+D8IEDNwFnbHDQzDTMNJjSSGkL6ahJobdc3V2DTFd48MY81hk/WBXMUjQARDbpaz0u6J5LhytYmxLkT/ZIPEKuzGx8NE/1zg3n8q9Q6kcitXClVLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717797545; c=relaxed/simple;
	bh=rENexTIqBNmTrluvHZlOwBLMcD45eQgOiZWXRj3Kuec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sAPTe5RdNzcY0QMVt+5wzuGbOFSbEBs+SFVl0CS492kDEc7l5hh2kB4v1DhfuOYO1LG7/U9t4Yd7+mWxPs5EiGvC2PHFyU2cN/u2Gz9ptm/im4HBD6tc1+64oQm8EbhUJsSrVwNcpXq3nCyJbj/0pO0AY4RO4ZPyLxkkYu1qnTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=oxe2qypZ; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2c284095ea6so2192625a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2024 14:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1717797543; x=1718402343; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RLl7Z9cmHrlTxhzq50m38fFLsEdzrzYpZmCV1yjgSWk=;
        b=oxe2qypZ14oSi1OeK90any9lQ+cLvxFHhHrXPgd5pEyw19dJ4lPkBNoGl7KN1EOX6W
         E9e0ifGWXgJJcbYWDVcyywe9WltFXwGjxWK/sKtE5kPgsOCk4l5PnJ8Zhd+pFDCkomjE
         ElmlYYOpkZGb0JU9utbH+1muPDPyOxUZNB61EgWigP/cOfKj2yFRaikawAIcsThT2Va+
         /nhV32KaAWucnOehZOCGD0wTzflxn+ZI+Yki4UMZmVTkNwgUEyjieg908l8cDDcu1jPI
         BJyGYLBmn9n0LgMyalCZzgyP1+7YS3YvcpcrCrFthfsWM0aHYd7ELejLebMyUXl2wLf3
         nyOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717797543; x=1718402343;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RLl7Z9cmHrlTxhzq50m38fFLsEdzrzYpZmCV1yjgSWk=;
        b=p8O5Ni38S9jf4vFDG+ko/r+Q1S/RYstKP9412kegRSwnx/q+61SS0/T4JmcLPyhzW3
         jNEFRz3XenH4ZHzszz2sXWnk3RdQDx9r1JAqfR54AQJozDL1wftNBoqSykeOBboT7tdZ
         5ofPDW47jmyfy85tSsyTndKlyZvB6WD1gXzhWe7sQdOpu1O/UGYpa+j3BHAShDiUeAGu
         SRHofOyq94+3G8NJxPSws+oGJcvZUv62VNKrCeKLdpfJXRESvHK5KwBV9aChq14q8rJW
         Z29t9ZLcHrI0pBwTaIZCTn6EDLYKvjq9s08sn8TKPG+D1OxuzYSYwHMnjBtKliryiv13
         vY8w==
X-Forwarded-Encrypted: i=1; AJvYcCVSf8mUWzC8SWyLfaexoGROEqaCzNdFUBVa8woQ3idN2CtJl7Hn4aj/Nd0U3k+BddhSpUm1EKimtwy2p11/dAZLojQtBeI7oCmXLhKc
X-Gm-Message-State: AOJu0YwMNlE2d3131gpWMFRg90HiHqsmBIbyoHfLoqkH97y/1wmGw9am
	TKnxosunS51EnTt5gwZYEOg+trpr45vRdqO1eTnOlsLDNUNU7qGjODXQ8FFY/Z4=
X-Google-Smtp-Source: AGHT+IFHUqEwBfucdw7yMbwX8qF9FDrpiVd3tPhrbs74VMEKkqD+jcARbpfEWS9oN2e60xfGbdGsuw==
X-Received: by 2002:a17:90a:cc5:b0:2c0:33a7:2afb with SMTP id 98e67ed59e1d1-2c2bcad0f9fmr3876235a91.10.1717797542975;
        Fri, 07 Jun 2024 14:59:02 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c29c4a574bsm4093594a91.56.2024.06.07.14.59.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 14:59:02 -0700 (PDT)
Date: Fri, 7 Jun 2024 14:59:00 -0700
From: Deepak Gupta <debug@rivosinc.com>
To: Samuel Holland <samuel.holland@sifive.com>
Cc: linux-riscv@lists.infradead.org, Palmer Dabbelt <palmer@dabbelt.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Conor Dooley <conor@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] riscv: Add support for per-thread envcfg CSR values
Message-ID: <ZmOCpF5ACdQiSfcm@debug.ba.rivosinc.com>
References: <20240605205658.184399-1-samuel.holland@sifive.com>
 <20240605205658.184399-3-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20240605205658.184399-3-samuel.holland@sifive.com>

On Wed, Jun 05, 2024 at 01:56:46PM -0700, Samuel Holland wrote:
>Some bits in the [ms]envcfg CSR, such as the CFI state and pointer
>masking mode, need to be controlled on a per-thread basis. Support this
>by keeping a copy of the CSR value in struct thread_struct and writing
>it during context switches. It is safe to discard the old CSR value
>during the context switch because the CSR is modified only by software,
>so the CSR will remain in sync with the copy in thread_struct.
>
>Use ALTERNATIVE directly instead of riscv_has_extension_unlikely() to
>minimize branchiness in the context switching code.
>
>Since thread_struct is copied during fork(), setting the value for the
>init task sets the default value for all other threads.
>
>Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
>---
>
> arch/riscv/include/asm/processor.h | 1 +
> arch/riscv/include/asm/switch_to.h | 8 ++++++++
> arch/riscv/kernel/cpufeature.c     | 2 +-
> 3 files changed, 10 insertions(+), 1 deletion(-)
>
>diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/processor.h
>index 68c3432dc6ea..0838922bd1c8 100644
>--- a/arch/riscv/include/asm/processor.h
>+++ b/arch/riscv/include/asm/processor.h
>@@ -118,6 +118,7 @@ struct thread_struct {
> 	unsigned long s[12];	/* s[0]: frame pointer */
> 	struct __riscv_d_ext_state fstate;
> 	unsigned long bad_cause;
>+	unsigned long envcfg;
> 	u32 riscv_v_flags;
> 	u32 vstate_ctrl;
> 	struct __riscv_v_ext_state vstate;
>diff --git a/arch/riscv/include/asm/switch_to.h b/arch/riscv/include/asm/switch_to.h
>index 7594df37cc9f..9685cd85e57c 100644
>--- a/arch/riscv/include/asm/switch_to.h
>+++ b/arch/riscv/include/asm/switch_to.h
>@@ -70,6 +70,13 @@ static __always_inline bool has_fpu(void) { return false; }
> #define __switch_to_fpu(__prev, __next) do { } while (0)
> #endif
>
>+static inline void __switch_to_envcfg(struct task_struct *next)
>+{
>+	asm volatile (ALTERNATIVE("nop", "csrw " __stringify(CSR_ENVCFG) ", %0",
>+				  0, RISCV_ISA_EXT_XLINUXENVCFG, 1)
>+			:: "r" (next->thread.envcfg) : "memory");
>+}
>+
> extern struct task_struct *__switch_to(struct task_struct *,
> 				       struct task_struct *);
>
>@@ -103,6 +110,7 @@ do {							\
> 		__switch_to_vector(__prev, __next);	\
> 	if (switch_to_should_flush_icache(__next))	\
> 		local_flush_icache_all();		\
>+	__switch_to_envcfg(__next);			\
> 	((last) = __switch_to(__prev, __next));		\
> } while (0)

Suggestion:
Probably make this patch 1

>
>diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
>index 2879e26dbcd8..1153b96346ae 100644
>--- a/arch/riscv/kernel/cpufeature.c
>+++ b/arch/riscv/kernel/cpufeature.c
>@@ -728,7 +728,7 @@ unsigned long riscv_get_elf_hwcap(void)
> void riscv_user_isa_enable(void)
> {
> 	if (riscv_has_extension_unlikely(RISCV_ISA_EXT_ZICBOZ))
>-		csr_set(CSR_ENVCFG, ENVCFG_CBZE);
>+		current->thread.envcfg |= ENVCFG_CBZE;

Suggestion:
Squash this with current patch 1 and call it patch 2.

> 	else if (any_cpu_has_zicboz)
> 		pr_warn_once("Zicboz disabled as it is unavailable on some harts\n");
> }
>-- 
>2.44.1
>

