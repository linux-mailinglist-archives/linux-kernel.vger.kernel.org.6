Return-Path: <linux-kernel+bounces-557721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00E1AA5DCD9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 13:40:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4EA1177A90
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 12:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DD0924339D;
	Wed, 12 Mar 2025 12:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mixaill.net header.i=@mixaill.net header.b="deFDyMfv"
Received: from mail.mixaill.net (mail.mixaill.net [144.76.234.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7712417D4
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 12:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.234.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741783210; cv=none; b=fUc1/SsJIW/iDXKVLb/ciyCQKwfjXcSDF9nlS7XcaOSGm1eLNMQiHeXvdhL9xZYPquJZPsKKR2VGWonJqWFiZLDzyqzXiLwxNGvsLUsm/NEE63pGwynyMwk1408G8VMRKglviS/lynk0QVmlg5a/1LBlcaue8SODoT0roxtlfyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741783210; c=relaxed/simple;
	bh=pjII2r/d5HELycQskWE90cO/4xsFs8xzlTv+L/9zO6A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XEnOFwfGll/m8mJpDbQkH6IIBC0Wtw1NJOFkm3fx10vN2gcJ2iqy8Ez+GNLWVAYrAXEKcV8RHXVWN+FmRZbnX/HKHs9EONhGqdqp15/cMSTUkJojROxBtqy1zy7OBEkI375ZfI7jDtkJU9vzsPz0n00OQxIdx3oOP/7o9uvDtyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mixaill.net; spf=pass smtp.mailfrom=mixaill.net; dkim=pass (2048-bit key) header.d=mixaill.net header.i=@mixaill.net header.b=deFDyMfv; arc=none smtp.client-ip=144.76.234.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mixaill.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mixaill.net
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 49D3F61645;
	Wed, 12 Mar 2025 12:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mixaill.net; s=dkim;
	t=1741782740; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=tKoQ9fnXCA+462DgAyzhcAnZFkPM1t+GpdFBbIF9eYM=;
	b=deFDyMfvl+SqNWgNRgEO+k9GXGxmB9iwzFGlBXLL6qIj0RDGSCGE63ayD/PXrQfma5f276
	wAVPXjF/Gz/mpgkHV74CIfbrb9yLeHwJ2Lacq3O0mrrVEMeaVNk5mfGRpp02TJiqjQ1TtU
	SV4rHU0r2f7yqAyvkfVBRnmTTFT2PaoX8sFm5dsV/2KeNVxMPpcbox3CdNstPkiDwS2SU4
	J8OM6jD6D/fMFKixZDA/LsxLxWzDBQVZO37gAuQ1sIl5AGPwAzMedSzUifpC7LNvILcM6Y
	hLEk3uKaqcjL9E2j8X8ismFD1y1JwqeVhqQhMMJQUjyMmr5i709r46ejBBiKqA==
From: Mikhail Paulyshka <me@mixaill.net>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	linux-kernel@vger.kernel.org
Cc: Mikhail Paulyshka <me@mixaill.net>
Subject: [PATCH 1/2] x86/rdrand: implement sanity check for RDSEED
Date: Wed, 12 Mar 2025 15:31:29 +0300
Message-ID: <20250312123130.8290-2-me@mixaill.net>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250312123130.8290-1-me@mixaill.net>
References: <20250312123130.8290-1-me@mixaill.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

On AMD Cyan Skillfish (Family 0x17 Model 0x47 Stepping 0x0) there is
a situation where RDRAND works perfectly but RDSEED generates FF's

Performs a separate check for RDRAND and RDSEED as their behavior
may be different.

Signed-off-by: Mikhail Paulyshka <me@mixaill.net>
---
 arch/x86/include/asm/archrandom.h |  1 +
 arch/x86/kernel/cpu/common.c      |  1 +
 arch/x86/kernel/cpu/rdrand.c      | 43 ++++++++++++++++++++++++++++---
 3 files changed, 42 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/archrandom.h b/arch/x86/include/asm/archrandom.h
index 02bae8e0758b..62ffc8983700 100644
--- a/arch/x86/include/asm/archrandom.h
+++ b/arch/x86/include/asm/archrandom.h
@@ -57,6 +57,7 @@ static inline size_t __must_check arch_get_random_seed_longs(unsigned long *v, s
 
 #ifndef CONFIG_UML
 void x86_init_rdrand(struct cpuinfo_x86 *c);
+void x86_init_rdseed(struct cpuinfo_x86 *c);
 #endif
 
 #endif /* ASM_X86_ARCHRANDOM_H */
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 7cce91b19fb2..277781863210 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1883,6 +1883,7 @@ static void identify_cpu(struct cpuinfo_x86 *c)
 	}
 
 	x86_init_rdrand(c);
+	x86_init_rdseed(c);
 	setup_pku(c);
 	setup_cet(c);
 
diff --git a/arch/x86/kernel/cpu/rdrand.c b/arch/x86/kernel/cpu/rdrand.c
index eeac00d20926..e9f7ef5dfe25 100644
--- a/arch/x86/kernel/cpu/rdrand.c
+++ b/arch/x86/kernel/cpu/rdrand.c
@@ -12,18 +12,20 @@
 #include <asm/archrandom.h>
 #include <asm/sections.h>
 
+
+enum { SAMPLES = 8, MIN_CHANGE = 5 };
+
 /*
  * RDRAND has Built-In-Self-Test (BIST) that runs on every invocation.
  * Run the instruction a few times as a sanity check. Also make sure
  * it's not outputting the same value over and over, which has happened
  * as a result of past CPU bugs.
  *
- * If it fails, it is simple to disable RDRAND and RDSEED here.
+ * If it fails, it is simple to disable RDRAND here.
  */
 
 void x86_init_rdrand(struct cpuinfo_x86 *c)
 {
-	enum { SAMPLES = 8, MIN_CHANGE = 5 };
 	unsigned long sample, prev;
 	bool failure = false;
 	size_t i, changed;
@@ -44,7 +46,42 @@ void x86_init_rdrand(struct cpuinfo_x86 *c)
 
 	if (failure) {
 		clear_cpu_cap(c, X86_FEATURE_RDRAND);
-		clear_cpu_cap(c, X86_FEATURE_RDSEED);
 		pr_emerg("RDRAND is not reliable on this platform; disabling.\n");
 	}
 }
+
+
+/*
+ * RDSEED has Built-In-Self-Test (BIST) that runs on every invocation.
+ * Run the instruction a few times as a sanity check. Also make sure
+ * it's not outputting the same value over and over, which has happened
+ * as a result of past CPU bugs.
+ *
+ * If it fails, it is simple to disable RDSEED here.
+ */
+
+void x86_init_rdseed(struct cpuinfo_x86 *c)
+{
+	unsigned long sample, prev;
+	bool failure = false;
+	size_t i, changed;
+
+	if (!cpu_has(c, X86_FEATURE_RDSEED))
+		return;
+
+	for (changed = 0, i = 0; i < SAMPLES; ++i) {
+		if (!rdseed_long(&sample)) {
+			failure = true;
+			break;
+		}
+		changed += i && sample != prev;
+		prev = sample;
+	}
+	if (changed < MIN_CHANGE)
+		failure = true;
+
+	if (failure) {
+		clear_cpu_cap(c, X86_FEATURE_RDSEED);
+		pr_emerg("RDSEED is not reliable on this platform; disabling.\n");
+	}
+}
-- 
2.48.1


