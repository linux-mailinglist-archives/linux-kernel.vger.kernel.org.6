Return-Path: <linux-kernel+bounces-327377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EB12A9774E1
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 01:19:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 045FCB248C5
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 23:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C886A1C6896;
	Thu, 12 Sep 2024 23:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="MnYIxpMv"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78681C57B9
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 23:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726183050; cv=none; b=Aujrzx7ITzG3TAh9fsG4dwjwYXVindXpwMz5q+3704k/FFTAoEjgpRjkJfhMMoOhiiG8F5j/2rTRSPLsb38VjQwCJ73XTrkbfLDj3ftNHc9Xw1zddppLdIrgSmMSl85fXhlqcNvplBq2wu4KSBsbL5dsq0B0lN7xEdTNCthFwbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726183050; c=relaxed/simple;
	bh=ZQTODxyv7j9Jb3MVQzLLFTP1AD7KtUwwJbRsAsWaO44=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DVOCbmCPsqayDRgKR77yPe6HKlyJR/umt5ZcbzzrMRHc4uZuUsS3/2XIkgDtLmG1xu7vAiyWx6NCBQxhY87+OLfq79jJkUSkDrzzILJc8GMslAvG7noqU4Dw/8kZTj0cwHZA+kpByXaXhGHkVESKnlWRwy09GFBARU/rEmfo1w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=MnYIxpMv; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2055136b612so20499045ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 16:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1726183048; x=1726787848; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KDHpycfSyd14eKEYNZ2Tiwh37NTkssfzdaJprWVmYic=;
        b=MnYIxpMvgo30YZpkITBNIV/EeP4b9RXnuRVsP9tAQiC8dLM3QvpswEcD90jdgyNXLn
         YFf/OBXED/1dPYcZoaEvAjequ3RxsvdZfPBwoUmJhm24KhS2b/+ZdJHZVpELbytwzLZs
         Zt+ZVxlF4Op2wsWLunFWsS4bFjmW+7YbM5RisRmh+need/B518CBNgVBek+SX3DPReX4
         pK/+ohjff073TASMwyA5Qgut+c+wtSKxf7XcLaJSwXkJqaj3CrkgcZ9rjkUjNoUW2knY
         x80GgSlprYmwKbnRSQe4AuXTvV/xJaKW6B61e/3aPI/Hd+teoBtOVsLZbrTvYPSj5SIN
         u2qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726183048; x=1726787848;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KDHpycfSyd14eKEYNZ2Tiwh37NTkssfzdaJprWVmYic=;
        b=hZqNWEqj12+LXbQlOgUBi6HbojETXT6EQ78QPN0ot2LzZggiSQwP9gP4DdEdFsac7J
         tWE8Aow8PnvoAyFyvAUXpqTlE1UM62fN3CeIBiKJYxHmv3uapFDuQ5QaOjF9543OXlro
         H57UmAjy6w6ObE++Wmlu6HWkuItetI9+wMomwcDVVcZsqViKtcIRdNYYpilfgkjypycB
         R4qR3yDSpK33R3EFDBxG2O7ew00Xvlchb4Qn4ZlcyeaMRSLAufO0aQ/BFwgBdvMq/Yer
         /dQWFTt5rxlvZFYFyE2YQ/eqpr1jlV8zvtvRClJXyvNSA0UrIgotQyE8Bk2vcKaLKoA7
         P+Vw==
X-Forwarded-Encrypted: i=1; AJvYcCWvY0Vg7/ThejK2tzOUxzqeX/sxJgHentN4NQOQ+dBDm3PAtrjmncK74K+P+0gR0hL54aRXxcg1MeeWRiI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzA7BwQQBL+2GnFG3cfcSGWSLPRCDs88UKiT3NS0jYi/wBFp9x
	nMqoMmHjBVCmyj7lfGsvqFjys6viFO2VYsWwMj+8tINAVNvrURrz35Y0aQbzsbY=
X-Google-Smtp-Source: AGHT+IGgw8wuv6wUiP6Uqm3H0s61sB80F1WhERdlqMkwOmwPP9ITQsqy/bvbAfvC2aqbyGgjaY4ahg==
X-Received: by 2002:a17:90a:f2c9:b0:2da:6a4d:53a6 with SMTP id 98e67ed59e1d1-2db9ffb3672mr5841992a91.19.1726183047961;
        Thu, 12 Sep 2024 16:17:27 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2db6c1ac69asm3157591a91.0.2024.09.12.16.17.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 16:17:27 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: paul.walmsley@sifive.com,
	palmer@sifive.com,
	conor@kernel.org,
	linux-doc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-arch@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: corbet@lwn.net,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	robh@kernel.org,
	krzk+dt@kernel.org,
	oleg@redhat.com,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	peterz@infradead.org,
	akpm@linux-foundation.org,
	arnd@arndb.de,
	ebiederm@xmission.com,
	kees@kernel.org,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	lorenzo.stoakes@oracle.com,
	shuah@kernel.org,
	brauner@kernel.org,
	samuel.holland@sifive.com,
	debug@rivosinc.com,
	andy.chiu@sifive.com,
	jerry.shih@sifive.com,
	greentime.hu@sifive.com,
	charlie@rivosinc.com,
	evan@rivosinc.com,
	cleger@rivosinc.com,
	xiao.w.wang@intel.com,
	ajones@ventanamicro.com,
	anup@brainfault.org,
	mchitale@ventanamicro.com,
	atishp@rivosinc.com,
	sameo@rivosinc.com,
	bjorn@rivosinc.com,
	alexghiti@rivosinc.com,
	david@redhat.com,
	libang.li@antgroup.com,
	jszhang@kernel.org,
	leobras@redhat.com,
	guoren@kernel.org,
	samitolvanen@google.com,
	songshuaishuai@tinylab.org,
	costa.shul@redhat.com,
	bhe@redhat.com,
	zong.li@sifive.com,
	puranjay@kernel.org,
	namcaov@gmail.com,
	antonb@tenstorrent.com,
	sorear@fastmail.com,
	quic_bjorande@quicinc.com,
	ancientmodern4@gmail.com,
	ben.dooks@codethink.co.uk,
	quic_zhonhan@quicinc.com,
	cuiyunhui@bytedance.com,
	yang.lee@linux.alibaba.com,
	ke.zhao@shingroup.cn,
	sunilvl@ventanamicro.com,
	tanzhasanwork@gmail.com,
	schwab@suse.de,
	dawei.li@shingroup.cn,
	rppt@kernel.org,
	willy@infradead.org,
	usama.anjum@collabora.com,
	osalvador@suse.de,
	ryan.roberts@arm.com,
	andrii@kernel.org,
	alx@kernel.org,
	catalin.marinas@arm.com,
	broonie@kernel.org,
	revest@chromium.org,
	bgray@linux.ibm.com,
	deller@gmx.de,
	zev@bewilderbeest.net,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v4 05/30] riscv: Call riscv_user_isa_enable() only on the boot hart
Date: Thu, 12 Sep 2024 16:16:24 -0700
Message-ID: <20240912231650.3740732-6-debug@rivosinc.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240912231650.3740732-1-debug@rivosinc.com>
References: <20240912231650.3740732-1-debug@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Samuel Holland <samuel.holland@sifive.com>

Now that the [ms]envcfg CSR value is maintained per thread, not per
hart, riscv_user_isa_enable() only needs to be called once during boot,
to set the value for the init task. This also allows it to be marked as
__init.

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Deepak Gupta <debug@rivosinc.com>
Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 arch/riscv/include/asm/cpufeature.h | 2 +-
 arch/riscv/kernel/cpufeature.c      | 4 ++--
 arch/riscv/kernel/smpboot.c         | 2 --
 3 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/include/asm/cpufeature.h
index 45f9c1171a48..ce9a995730c1 100644
--- a/arch/riscv/include/asm/cpufeature.h
+++ b/arch/riscv/include/asm/cpufeature.h
@@ -31,7 +31,7 @@ DECLARE_PER_CPU(struct riscv_cpuinfo, riscv_cpuinfo);
 /* Per-cpu ISA extensions. */
 extern struct riscv_isainfo hart_isa[NR_CPUS];
 
-void riscv_user_isa_enable(void);
+void __init riscv_user_isa_enable(void);
 
 #define _RISCV_ISA_EXT_DATA(_name, _id, _subset_exts, _subset_exts_size, _validate) {	\
 	.name = #_name,									\
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index f7fcd23d55de..41fd0be25bd8 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -919,12 +919,12 @@ unsigned long riscv_get_elf_hwcap(void)
 	return hwcap;
 }
 
-void riscv_user_isa_enable(void)
+void __init riscv_user_isa_enable(void)
 {
 	if (riscv_has_extension_unlikely(RISCV_ISA_EXT_ZICBOZ))
 		current->thread_info.envcfg |= ENVCFG_CBZE;
 	else if (any_cpu_has_zicboz)
-		pr_warn_once("Zicboz disabled as it is unavailable on some harts\n");
+		pr_warn("Zicboz disabled as it is unavailable on some harts\n");
 }
 
 #ifdef CONFIG_RISCV_ALTERNATIVE
diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
index 0f8f1c95ac38..e36d20205bd7 100644
--- a/arch/riscv/kernel/smpboot.c
+++ b/arch/riscv/kernel/smpboot.c
@@ -233,8 +233,6 @@ asmlinkage __visible void smp_callin(void)
 	numa_add_cpu(curr_cpuid);
 	set_cpu_online(curr_cpuid, true);
 
-	riscv_user_isa_enable();
-
 	/*
 	 * Remote cache and TLB flushes are ignored while the CPU is offline,
 	 * so flush them both right now just in case.
-- 
2.45.0


