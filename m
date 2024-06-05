Return-Path: <linux-kernel+bounces-203218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E96408FD7F8
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 22:57:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6055E1F254E8
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 20:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 320FC15FCF5;
	Wed,  5 Jun 2024 20:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="ZeAjMAag"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E75E15FA75
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 20:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717621026; cv=none; b=n5UUw23FoXxfz53c3AcN+rF4IEBjnU3sewgZTYC5dn+iNj+HUu+8fbz2rOXZKTaf/EbZH1FLbEIIxWpDv6qFbGMUlUWRKKsFlNnSHZREtro1QBh1FdF37vIu9n+IUHraEshB4JufzF7n8m8bCb8HsDUQwAx+D8t05OSWSSWpetM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717621026; c=relaxed/simple;
	bh=qDj+MgB0zc+Q81L2PsjZdeWfozqjI0P+THgHibhhnXk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k+QhaWSN1RdzwTwzK8s3xo3VBgZJQYprS48DcTHPQCJnquSAQqAgpYzZL9oBYvH3raQdQqDtHmasEF36CKUgOdJM/A3qzYlWHf0uQtDjsswDHCs83hxag/AoXn9MvkrNUCFzWg1PTO+hczzR3NX4dZJ0K7JbNkSZAv8JBd6JCW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=ZeAjMAag; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1f44b42e9a6so2917305ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 13:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1717621024; x=1718225824; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uty7FoscHz4fIjCNzqhW6L2ro7Xc7g0lgY7rTZohcbw=;
        b=ZeAjMAagdhUnjkEXu2C9MfIQS5yy0/WHWFEQIppso4Cy7xcdYOCyUVxGWdtZzlQ6Nw
         cBaao6nSPB0q+IiQmI3szsNAWD99mdogB0eQRoQZGpGWHFe6C7rNgM0uNsiADXopH2wO
         RmBQWqJnh/YrFwtFxTo2tqQjYRN/su7hQE98L+5luJj4muf8VmoswPQT45+znjdH5+oY
         vPpvkjHg7fOBgc5B28uTGzGYov7W3wDQvgHVWbocbZJdVwPDxfvVKwjW219BMN4C36pS
         EPK8DMJ8XZgGfHdySGKUZh4E6tJXHOV2sQhqbAyRuxJckffussCh5CdpYT9j+qMCuu1h
         9pMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717621024; x=1718225824;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Uty7FoscHz4fIjCNzqhW6L2ro7Xc7g0lgY7rTZohcbw=;
        b=lUn5WaezcYV7ZcgV1W26MUWFfe5OvQiZ+p6bOHAnKGYS5XZX+2Xk6ICToLcOoBrENb
         DMF6it8Oj75qywzAsgi4fcTLJ1bI8HqJrApjS7tJ9s9JouPSJRa1ccnMHnBoSVHnMB7F
         bwGfV5swWcFN4p1mlJoGUWC1ajm1+Ap9suIMfT2adMkVH10WPIRsCf8bmgTvS6P0HBHz
         movNO2lfbCII1ELdXXT+OIWPW5utmNCb00ug4WJQT7UJIgvcwC6k9aMdtBIf4DxEM+l3
         86/2j887M0drEkZXgU3MPuRZ2yyvbs2CqcEJKeE2aruF7pg6dd2ScRUNTpj+AIi8mPBE
         wZFw==
X-Forwarded-Encrypted: i=1; AJvYcCXnq+Wz4lNBZAIw8M+QRnHbAZrN23SX1r9BOP032lfxd8a5891IBW7ni5EpyD3c2fABSS7egCpOuC2TS04WTGnwB6+eHVvTMCASMDyf
X-Gm-Message-State: AOJu0Yz4xXZ+v+eLONP1JQrkfPXkcCiO3xshL78zLGiCMDGSp4bomRC3
	0pDgzSN827Szwvmnac1V5gEDKrmIyqloUz1ecl+Z5dtIauO3rfKjskwVhDJ1ZqU=
X-Google-Smtp-Source: AGHT+IFKrVvHD0aCZ85QY1knnJIWvkOUtWAJ3vKHRJSp/gSnF42JTtt2tr6r7NWF/3DXkYV7sTZKtA==
X-Received: by 2002:a17:903:1c2:b0:1f4:b2ce:8dbe with SMTP id d9443c01a7336-1f6a590400dmr43547455ad.9.1717621024293;
        Wed, 05 Jun 2024 13:57:04 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6323dd86esm107332135ad.121.2024.06.05.13.57.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 13:57:03 -0700 (PDT)
From: Samuel Holland <samuel.holland@sifive.com>
To: linux-riscv@lists.infradead.org,
	Palmer Dabbelt <palmer@dabbelt.com>
Cc: Andrew Jones <ajones@ventanamicro.com>,
	Conor Dooley <conor@kernel.org>,
	linux-kernel@vger.kernel.org,
	Deepak Gupta <debug@rivosinc.com>,
	Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH 3/3] riscv: Call riscv_user_isa_enable() only on the boot hart
Date: Wed,  5 Jun 2024 13:56:47 -0700
Message-ID: <20240605205658.184399-4-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.44.1
In-Reply-To: <20240605205658.184399-1-samuel.holland@sifive.com>
References: <20240605205658.184399-1-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that the [ms]envcfg CSR value is maintained per thread, not per
hart, riscv_user_isa_enable() only needs to be called once during boot,
to set the value for the init task. This also allows it to be marked as
__init. riscv_isa_extension_check() sets any_cpu_has_zicboz, so it also
needs to be marked __init; it could have had this annotation already.

Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

 arch/riscv/include/asm/cpufeature.h | 2 +-
 arch/riscv/kernel/cpufeature.c      | 8 ++++----
 arch/riscv/kernel/smpboot.c         | 2 --
 3 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/include/asm/cpufeature.h
index 347805446151..4bf7b7ebf6b3 100644
--- a/arch/riscv/include/asm/cpufeature.h
+++ b/arch/riscv/include/asm/cpufeature.h
@@ -31,7 +31,7 @@ DECLARE_PER_CPU(struct riscv_cpuinfo, riscv_cpuinfo);
 /* Per-cpu ISA extensions. */
 extern struct riscv_isainfo hart_isa[NR_CPUS];
 
-void riscv_user_isa_enable(void);
+void __init riscv_user_isa_enable(void);
 
 #if defined(CONFIG_RISCV_MISALIGNED)
 bool check_unaligned_access_emulated_all_cpus(void);
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 1153b96346ae..bfe8550c0aae 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -27,7 +27,7 @@
 
 #define NUM_ALPHA_EXTS ('z' - 'a' + 1)
 
-static bool any_cpu_has_zicboz;
+static bool any_cpu_has_zicboz __initdata;
 
 unsigned long elf_hwcap __read_mostly;
 
@@ -74,7 +74,7 @@ bool __riscv_isa_extension_available(const unsigned long *isa_bitmap, unsigned i
 }
 EXPORT_SYMBOL_GPL(__riscv_isa_extension_available);
 
-static bool riscv_isa_extension_check(int id)
+static bool __init riscv_isa_extension_check(int id)
 {
 	switch (id) {
 	case RISCV_ISA_EXT_ZICBOM:
@@ -725,12 +725,12 @@ unsigned long riscv_get_elf_hwcap(void)
 	return hwcap;
 }
 
-void riscv_user_isa_enable(void)
+void __init riscv_user_isa_enable(void)
 {
 	if (riscv_has_extension_unlikely(RISCV_ISA_EXT_ZICBOZ))
 		current->thread.envcfg |= ENVCFG_CBZE;
 	else if (any_cpu_has_zicboz)
-		pr_warn_once("Zicboz disabled as it is unavailable on some harts\n");
+		pr_warn("Zicboz disabled as it is unavailable on some harts\n");
 }
 
 #ifdef CONFIG_RISCV_ALTERNATIVE
diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
index 1319b29ce3b5..3e8ece31c30d 100644
--- a/arch/riscv/kernel/smpboot.c
+++ b/arch/riscv/kernel/smpboot.c
@@ -231,8 +231,6 @@ asmlinkage __visible void smp_callin(void)
 			elf_hwcap &= ~COMPAT_HWCAP_ISA_V;
 	}
 
-	riscv_user_isa_enable();
-
 	/*
 	 * Remote cache and TLB flushes are ignored while the CPU is offline,
 	 * so flush them both right now just in case.
-- 
2.44.1


