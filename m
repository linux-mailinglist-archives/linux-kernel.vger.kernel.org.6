Return-Path: <linux-kernel+bounces-544091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA67DA4DD4C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 13:00:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 722803A35BB
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 12:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D511C202976;
	Tue,  4 Mar 2025 12:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="eCMDZPz2"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19B61FF61E
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 12:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741089621; cv=none; b=RAkPRGBmE3rFrffitcVMnPbjfB1j58KQWBaviU+waNqBc27vnS+L96vtsiGHgnSb/3lYRmAecEkzDJ4uR3KaJwGcjobJ7J+OzZGephRKQyq5hpniiG2t+zQQk4d5mAuu5/zjS7RBNbLt1ZDevT8dlIXCG15I9TO+fcPfD41jQNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741089621; c=relaxed/simple;
	bh=0KlxLzFd1lxQd/8YpnPnCCibjWag2I74cCn43Ti2Suw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fc3eiQ3FTjFy5jXdF4BuIrIb3GJTrEjLJBeHO9Tfyxl0amBETdCHRX8/tT1Dr67LkuuW4jWGJyCJL5owtcjj6hn2tjBJTLuRmR+rIRYnaCAmYnkQcceTHFmMeH9Gxk5IwqbC7HJaDzew3Zns8X16GxR/qvxBfyLq1/OUzPZBIkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=eCMDZPz2; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-390f69e71c8so2289677f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 04:00:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1741089617; x=1741694417; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dsOXXT+GJOZQxfHaJbyOnCfiUI8BUwrK26GnKW4Oj7U=;
        b=eCMDZPz2p8uZ8EosEibvpmqnk/dp5MbBhBQXJgRy9JuzWuBAHYWoVGz6gwEBUSpJpA
         /JQ+eQ1jTRWLaXlyzS96p4nIhNESDzMMROxafvMlEVQka6g6IDdv+3E+Oqi7wUZOPTyr
         qOcpakguqLnOtd84xGvITidNlCRr/k7xuXusbLgt7HZGt5iQiL2vvNH84QwSBKpxZE8q
         g5hR2jdOULC7l8I2AUx5QSDOkA+xDxXY5udfqbQkJlU+/NSR+PGDsiwxb/JiohBx1+W9
         xknP4fJg+PfAdQrUKRLErpK7X8XhE4ZO9F++0I4KCdvpjUB/M7VT6zd7LkadXwdY2iAW
         WUHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741089617; x=1741694417;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dsOXXT+GJOZQxfHaJbyOnCfiUI8BUwrK26GnKW4Oj7U=;
        b=ueasTw0+ab66+LJMmLKE5CgmgvL1n/9pwxYGdcfqRsnD4WSzkf6SH0JC/2WS36mrE2
         shidiZ/hc+32g7gdILGU9a4jY8nZAFexhg3GaI1B/52JKv/SitjjObFqJkNDXm2/tj+B
         6pIGNR4sLSaVzRAtC3FTjfiwsDdnCUgGGrHqsoAmot+tTBDKb7hl7uZoN6tWyd2zL6Ts
         vOzqbMxvqizBLhdjNClZBvsKSUB5ddkxKbzrCtmp/pKC3/Fbi2t3RMr0E/4RNdqyjcTM
         Vd4J0vSpWrlmi+Gg818wWYX7Uhh4nmwQ0mLY3Tp4GkGh8bI5DQRQfWsTS7TKQlimzQw8
         +Wog==
X-Forwarded-Encrypted: i=1; AJvYcCURmxJV+496f8af7OCXZdrclwjgRkptfXcsbZ5savrkrh5zu6S1Xa8hekEI8XxuM9Dl7QCo2i3OfyBMJPU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoCFdSJeCKyvS/BKZRLX38pESXUpfQOVQUNENkKHJeUUNfkBUY
	qCA30lxTG3JRzbj18liOb2wawww5TtyPJQ0NsZoxPJ6E8xjzpXeVxf1a51EaeNo=
X-Gm-Gg: ASbGnct7OBSIowiDukmU2LDKF8ds2uNCH572sZxZ9BLJlMa2/8q4B+rvTw3XCWJOcM2
	4CKQtu00B9rpJOC/m+c2HbfFKgm8aFwGGFwfK/BObQzVseq1I/6QXul9eF/nbtQrWTA/PY+cAUx
	oS3hZzVKo87xw/zRMZNXc2TsflSSm2ArA7ZoqVgGOyOKKzRw3UVmWGiIVgRLhL5LMM/qYYwlrNK
	lrLWCSdPVW7u4j8dKC7vVRwY9fLdXYB1g7raJTblq+w1JL2/c5QKKzw3ciCU6Cw2+PUqTxdY+d3
	ogopOk4IXRN/LngqnI4lVfrM9f7j/dXu
X-Google-Smtp-Source: AGHT+IHfvp/euog7c3Gu4POXjA8Lq4HBzrln9LMIjOKJFZe5dI3SCeWKlW6YsuSzufoq3FjOtkj5Fg==
X-Received: by 2002:a5d:59af:0:b0:388:c61d:4415 with SMTP id ffacd0b85a97d-3911560f325mr2216933f8f.18.1741089617020;
        Tue, 04 Mar 2025 04:00:17 -0800 (PST)
Received: from localhost ([2a02:8308:a00c:e200::688c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e4844ac6sm17312025f8f.71.2025.03.04.04.00.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 04:00:16 -0800 (PST)
From: Andrew Jones <ajones@ventanamicro.com>
To: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Cc: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	charlie@rivosinc.com,
	cleger@rivosinc.com,
	alex@ghiti.fr,
	Anup Patel <apatel@ventanamicro.com>,
	corbet@lwn.net,
	Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH v3 1/8] riscv: Annotate unaligned access init functions
Date: Tue,  4 Mar 2025 13:00:16 +0100
Message-ID: <20250304120014.143628-11-ajones@ventanamicro.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250304120014.143628-10-ajones@ventanamicro.com>
References: <20250304120014.143628-10-ajones@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Several functions used in unaligned access probing are only run at
init time. Annotate them appropriately.

Fixes: f413aae96cda ("riscv: Set unaligned access speed at compile time")
Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
---
 arch/riscv/include/asm/cpufeature.h        |  4 ++--
 arch/riscv/kernel/traps_misaligned.c       |  8 ++++----
 arch/riscv/kernel/unaligned_access_speed.c | 14 +++++++-------
 3 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/include/asm/cpufeature.h
index 569140d6e639..19defdc2002d 100644
--- a/arch/riscv/include/asm/cpufeature.h
+++ b/arch/riscv/include/asm/cpufeature.h
@@ -63,7 +63,7 @@ void __init riscv_user_isa_enable(void);
 #define __RISCV_ISA_EXT_SUPERSET_VALIDATE(_name, _id, _sub_exts, _validate) \
 	_RISCV_ISA_EXT_DATA(_name, _id, _sub_exts, ARRAY_SIZE(_sub_exts), _validate)
 
-bool check_unaligned_access_emulated_all_cpus(void);
+bool __init check_unaligned_access_emulated_all_cpus(void);
 #if defined(CONFIG_RISCV_SCALAR_MISALIGNED)
 void check_unaligned_access_emulated(struct work_struct *work __always_unused);
 void unaligned_emulation_finish(void);
@@ -76,7 +76,7 @@ static inline bool unaligned_ctl_available(void)
 }
 #endif
 
-bool check_vector_unaligned_access_emulated_all_cpus(void);
+bool __init check_vector_unaligned_access_emulated_all_cpus(void);
 #if defined(CONFIG_RISCV_VECTOR_MISALIGNED)
 void check_vector_unaligned_access_emulated(struct work_struct *work __always_unused);
 DECLARE_PER_CPU(long, vector_misaligned_access);
diff --git a/arch/riscv/kernel/traps_misaligned.c b/arch/riscv/kernel/traps_misaligned.c
index 7cc108aed74e..aacbd9d7196e 100644
--- a/arch/riscv/kernel/traps_misaligned.c
+++ b/arch/riscv/kernel/traps_misaligned.c
@@ -605,7 +605,7 @@ void check_vector_unaligned_access_emulated(struct work_struct *work __always_un
 	kernel_vector_end();
 }
 
-bool check_vector_unaligned_access_emulated_all_cpus(void)
+bool __init check_vector_unaligned_access_emulated_all_cpus(void)
 {
 	int cpu;
 
@@ -625,7 +625,7 @@ bool check_vector_unaligned_access_emulated_all_cpus(void)
 	return true;
 }
 #else
-bool check_vector_unaligned_access_emulated_all_cpus(void)
+bool __init check_vector_unaligned_access_emulated_all_cpus(void)
 {
 	return false;
 }
@@ -659,7 +659,7 @@ void check_unaligned_access_emulated(struct work_struct *work __always_unused)
 	}
 }
 
-bool check_unaligned_access_emulated_all_cpus(void)
+bool __init check_unaligned_access_emulated_all_cpus(void)
 {
 	int cpu;
 
@@ -684,7 +684,7 @@ bool unaligned_ctl_available(void)
 	return unaligned_ctl;
 }
 #else
-bool check_unaligned_access_emulated_all_cpus(void)
+bool __init check_unaligned_access_emulated_all_cpus(void)
 {
 	return false;
 }
diff --git a/arch/riscv/kernel/unaligned_access_speed.c b/arch/riscv/kernel/unaligned_access_speed.c
index 91f189cf1611..b7a8ff7ba6df 100644
--- a/arch/riscv/kernel/unaligned_access_speed.c
+++ b/arch/riscv/kernel/unaligned_access_speed.c
@@ -121,7 +121,7 @@ static int check_unaligned_access(void *param)
 	return 0;
 }
 
-static void check_unaligned_access_nonboot_cpu(void *param)
+static void __init check_unaligned_access_nonboot_cpu(void *param)
 {
 	unsigned int cpu = smp_processor_id();
 	struct page **pages = param;
@@ -175,7 +175,7 @@ static void set_unaligned_access_static_branches(void)
 	modify_unaligned_access_branches(&fast_and_online, num_online_cpus());
 }
 
-static int lock_and_set_unaligned_access_static_branch(void)
+static int __init lock_and_set_unaligned_access_static_branch(void)
 {
 	cpus_read_lock();
 	set_unaligned_access_static_branches();
@@ -218,7 +218,7 @@ static int riscv_offline_cpu(unsigned int cpu)
 }
 
 /* Measure unaligned access speed on all CPUs present at boot in parallel. */
-static int check_unaligned_access_speed_all_cpus(void)
+static int __init check_unaligned_access_speed_all_cpus(void)
 {
 	unsigned int cpu;
 	unsigned int cpu_count = num_possible_cpus();
@@ -264,7 +264,7 @@ static int check_unaligned_access_speed_all_cpus(void)
 	return 0;
 }
 #else /* CONFIG_RISCV_PROBE_UNALIGNED_ACCESS */
-static int check_unaligned_access_speed_all_cpus(void)
+static int __init check_unaligned_access_speed_all_cpus(void)
 {
 	return 0;
 }
@@ -379,7 +379,7 @@ static int riscv_online_cpu_vec(unsigned int cpu)
 }
 
 /* Measure unaligned access speed on all CPUs present at boot in parallel. */
-static int vec_check_unaligned_access_speed_all_cpus(void *unused __always_unused)
+static int __init vec_check_unaligned_access_speed_all_cpus(void *unused __always_unused)
 {
 	schedule_on_each_cpu(check_vector_unaligned_access);
 
@@ -393,13 +393,13 @@ static int vec_check_unaligned_access_speed_all_cpus(void *unused __always_unuse
 	return 0;
 }
 #else /* CONFIG_RISCV_PROBE_VECTOR_UNALIGNED_ACCESS */
-static int vec_check_unaligned_access_speed_all_cpus(void *unused __always_unused)
+static int __init vec_check_unaligned_access_speed_all_cpus(void *unused __always_unused)
 {
 	return 0;
 }
 #endif
 
-static int check_unaligned_access_all_cpus(void)
+static int __init check_unaligned_access_all_cpus(void)
 {
 	bool all_cpus_emulated, all_cpus_vec_unsupported;
 
-- 
2.48.1


