Return-Path: <linux-kernel+bounces-206791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C646B900DC5
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 00:00:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52D05286B07
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 22:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36CF315534A;
	Fri,  7 Jun 2024 21:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="vFx/Nsv3"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 215D344C8C
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 21:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717797595; cv=none; b=c0/xcfsFR7IjApNL0YCAhxcYB0JwedejZZ8u5JoXGuaKT2QilhoZjRipcEoiniMIgfjJG0ezxkkm299Dq912T/c30LwTbItV3F4eNo8XtAp8/w8t0JeOFYl0VDhioAiBN188fdpuMrARLK+XtfSyIfxRwuXvMHfNJKa2MPMHr0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717797595; c=relaxed/simple;
	bh=UY2wuKP+QBtCD8vmowobQMOq5MBEknNYfIb9DZ2HKuw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lsWnFnN/LXPpttVHrR8Zos9E00/jFob6MOkSseTJcU1AKhXIkAV4KO+deoc3/+6JJfJ57IVP8h8zCZbSYx1hpV9ptCnSuXNgQ8moKqiYmXrzS/+82iai4lUSkLmDM8hkJ0Jaj7hgewW2KmqGTz9pUMRVOSnqnwfgl+x8TFQwg2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=vFx/Nsv3; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1f61f775738so22987305ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2024 14:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1717797593; x=1718402393; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=abwbQjKkdLcyA3ZLBTexttcGmNEMcNRQlC/IY+wd5Rg=;
        b=vFx/Nsv3TNsdX+GBlC4p9i/tU5whXdJbczNPrZm/aCljfxs6tLLHHsuj0+udBiAmTv
         4KAE6j6fDSW3Nk9jCDFC57/5FjsL0kjk2lGxqp8ZiAsBE57tqfA/82OvYdu8lbTsSE9y
         a93KGHam+IxBTrX4poc4itCQP13ubdLsCwA5fRfXf9Lo87mTZShpJR/bneuXxBM/usvk
         qLrLd3678yOiD1TNxRDVNpw+WahV0jp4RLyfrFkeTKWeYslz4SyGowTtmWtGwzG+yTY5
         HoNwIiT46zoKiub3JEbaMlm0DKRP8+lIUHjmbbw+Mqp24RVW6AcQptof2cxCZ6qjyNQ3
         62yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717797593; x=1718402393;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=abwbQjKkdLcyA3ZLBTexttcGmNEMcNRQlC/IY+wd5Rg=;
        b=PcntEl0XNUgJdXMp2l9BPUrD1CkTdn+BgTBx0LctPxuiG+AUvAknh8fz3KcPvj1uYF
         ZW2XYqN7QvASWD/0wMt0qekfe1PvHy6QL+8UA5aNG0vGmYS5OS9dkXg5eR2c0VgkU2c6
         AnL7D/6x9MnqPeOw1ktxpwsaaTeAYHOwRLdxkA0GtG1y/sPx7T1tD+9Z7X3KOLKkgpxP
         BNzgev00KRb5JF1+y1XiyGKTvAsBZjdtIc2O+BpxNInXxhk8qqG4AfJ78XXDq0Sxpamn
         Q07yc29C15nQrGeUGneVqzo+MfGgdlxNciZhduvbj4DXsLRpiK3ZNVWo6U5GzVsMLSqm
         t9LQ==
X-Forwarded-Encrypted: i=1; AJvYcCVDdxDm8W64a4x8XzAkFgiviafdar+lLcCdE6qtttA+WYpUI7qPZr+JyiCvBrTW2mNFr02HnwQ3q2A+k5XUCmR8ps5uOg7/VTZGMuK8
X-Gm-Message-State: AOJu0YwPIJTn3gejyomkzb/asoFxaS9R2JhdzZt8ZnlL50BGlfZjFyd2
	zZsW0ZtD+Ab2OtFnj70QQ5KddSHkRjNFRjTYMfB8BahMv4gFZdCzVSLFzv+BwBQ=
X-Google-Smtp-Source: AGHT+IEhy4tn7bfCFbg3FP8GGeWKEJlk4JoPD+Sf0Ab6hBJqXd6TZWntaCjHmX8Tbs3J6VbUbkAHeg==
X-Received: by 2002:a17:903:41ca:b0:1f6:7f45:4d37 with SMTP id d9443c01a7336-1f6d03f5337mr43464365ad.66.1717797593381;
        Fri, 07 Jun 2024 14:59:53 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6bd7ccf33sm39167825ad.125.2024.06.07.14.59.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 14:59:52 -0700 (PDT)
Date: Fri, 7 Jun 2024 14:59:51 -0700
From: Deepak Gupta <debug@rivosinc.com>
To: Samuel Holland <samuel.holland@sifive.com>
Cc: linux-riscv@lists.infradead.org, Palmer Dabbelt <palmer@dabbelt.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Conor Dooley <conor@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] riscv: Call riscv_user_isa_enable() only on the boot
 hart
Message-ID: <ZmOC18Lj2WrMe9J/@debug.ba.rivosinc.com>
References: <20240605205658.184399-1-samuel.holland@sifive.com>
 <20240605205658.184399-4-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20240605205658.184399-4-samuel.holland@sifive.com>

On Wed, Jun 05, 2024 at 01:56:47PM -0700, Samuel Holland wrote:
>Now that the [ms]envcfg CSR value is maintained per thread, not per
>hart, riscv_user_isa_enable() only needs to be called once during boot,
>to set the value for the init task. This also allows it to be marked as
>__init. riscv_isa_extension_check() sets any_cpu_has_zicboz, so it also
>needs to be marked __init; it could have had this annotation already.
>
>Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
>---
>
> arch/riscv/include/asm/cpufeature.h | 2 +-
> arch/riscv/kernel/cpufeature.c      | 8 ++++----
> arch/riscv/kernel/smpboot.c         | 2 --
> 3 files changed, 5 insertions(+), 7 deletions(-)
>
>diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/include/asm/cpufeature.h
>index 347805446151..4bf7b7ebf6b3 100644
>--- a/arch/riscv/include/asm/cpufeature.h
>+++ b/arch/riscv/include/asm/cpufeature.h
>@@ -31,7 +31,7 @@ DECLARE_PER_CPU(struct riscv_cpuinfo, riscv_cpuinfo);
> /* Per-cpu ISA extensions. */
> extern struct riscv_isainfo hart_isa[NR_CPUS];
>
>-void riscv_user_isa_enable(void);
>+void __init riscv_user_isa_enable(void);
>
> #if defined(CONFIG_RISCV_MISALIGNED)
> bool check_unaligned_access_emulated_all_cpus(void);
>diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
>index 1153b96346ae..bfe8550c0aae 100644
>--- a/arch/riscv/kernel/cpufeature.c
>+++ b/arch/riscv/kernel/cpufeature.c
>@@ -27,7 +27,7 @@
>
> #define NUM_ALPHA_EXTS ('z' - 'a' + 1)
>
>-static bool any_cpu_has_zicboz;
>+static bool any_cpu_has_zicboz __initdata;
>
> unsigned long elf_hwcap __read_mostly;
>
>@@ -74,7 +74,7 @@ bool __riscv_isa_extension_available(const unsigned long *isa_bitmap, unsigned i
> }
> EXPORT_SYMBOL_GPL(__riscv_isa_extension_available);
>
>-static bool riscv_isa_extension_check(int id)
>+static bool __init riscv_isa_extension_check(int id)
> {
> 	switch (id) {
> 	case RISCV_ISA_EXT_ZICBOM:
>@@ -725,12 +725,12 @@ unsigned long riscv_get_elf_hwcap(void)
> 	return hwcap;
> }
>
>-void riscv_user_isa_enable(void)
>+void __init riscv_user_isa_enable(void)
> {
> 	if (riscv_has_extension_unlikely(RISCV_ISA_EXT_ZICBOZ))
> 		current->thread.envcfg |= ENVCFG_CBZE;
> 	else if (any_cpu_has_zicboz)
>-		pr_warn_once("Zicboz disabled as it is unavailable on some harts\n");
>+		pr_warn("Zicboz disabled as it is unavailable on some harts\n");
> }
>
> #ifdef CONFIG_RISCV_ALTERNATIVE
>diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
>index 1319b29ce3b5..3e8ece31c30d 100644
>--- a/arch/riscv/kernel/smpboot.c
>+++ b/arch/riscv/kernel/smpboot.c
>@@ -231,8 +231,6 @@ asmlinkage __visible void smp_callin(void)
> 			elf_hwcap &= ~COMPAT_HWCAP_ISA_V;
> 	}
>
>-	riscv_user_isa_enable();
>-
> 	/*
> 	 * Remote cache and TLB flushes are ignored while the CPU is offline,
> 	 * so flush them both right now just in case.

Suggestion:
Squash with current patch 1 and call it patch 2.

>-- 
>2.44.1
>

