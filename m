Return-Path: <linux-kernel+bounces-557720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC5B5A5DCD7
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 13:40:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11CBA17856D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 12:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E101243399;
	Wed, 12 Mar 2025 12:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mixaill.net header.i=@mixaill.net header.b="tkA3Ff7n"
Received: from mail.mixaill.net (mail.mixaill.net [144.76.234.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF86E24293F
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 12:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.234.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741783210; cv=none; b=AKlKQK9Cx4IRI35+k84UOGTFzwqb2QKvwETAcXcsyOwQQRo5ETuGshKMQmcM1BT7//09LkdhU716dEhqSVwX6kypCcfT+XfdUggMe8hHSDPU1OVBlsr3z+Da1k64lvuF7It1o4Zg/0d3Kb5ggMPJE711sN55rRmI+k1UGTeEHp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741783210; c=relaxed/simple;
	bh=jMT9AsMuwXF1APi4NbcUAZSoszB8NSVVnpmjQkxw23k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CbdJKL7oB3OTQrXLvzmpzBxAaos+eMwVNPjzTEw+FQuFIcU4dB/SHZh7jYoS7vFFmwmqyUlpicSiOe0QVHuT0wumHI2oyXZpKtd4sXzqBgdVjVpLgNdjIOUBWx0biMLzNZZrbK3NxJbMfyClxz3bVv8qASIEKDC3xCyCN7KEH8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mixaill.net; spf=pass smtp.mailfrom=mixaill.net; dkim=pass (2048-bit key) header.d=mixaill.net header.i=@mixaill.net header.b=tkA3Ff7n; arc=none smtp.client-ip=144.76.234.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mixaill.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mixaill.net
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 23978615E2;
	Wed, 12 Mar 2025 12:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mixaill.net; s=dkim;
	t=1741782741; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=F5Rmm+CnhuT5tHMtHkTvsAOQTGz1NZaJrStAC8PQUF8=;
	b=tkA3Ff7nq7L6d6/QZEHqxutLXpeazHekpRJQTR/sl4x2REpVQI0Cxd9t1djgN3aBthwXwa
	V6Jkdf3ksU15e7x2MF4U8k1EVz03t51YD10NqoQxVgEmPlqZ0ITPy7Ze0p37glRrZOClxb
	8TKFu+mPVikQ1cDu87W5PmeVuhP+HfAAR9r5jbReUEzguDNVBzHASKVjyG5Wasw87a9Heb
	Ras4oNTq+jfDrwqwCMVrqr/yjN1cq/nAVlVZXCscziK/ctgKdfnVu94AKtAD0AFoyUde0r
	tqd8GaHZmdBcsVsyy4LBhjvdQIo9MsbZDE7YSzFeP3uCSrNOIehDr2S3bU/6Mw==
From: Mikhail Paulyshka <me@mixaill.net>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	linux-kernel@vger.kernel.org
Cc: Mikhail Paulyshka <me@mixaill.net>
Subject: [PATCH 2/2] x86/rdrand: hide RDRAND and RDSEED from CPUID in case of a malfunction
Date: Wed, 12 Mar 2025 15:31:30 +0300
Message-ID: <20250312123130.8290-3-me@mixaill.net>
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

Some applications use the CPUID call instead of /proc/cpuinfo to get
CPU capabilities. In this case, they will still try to use non-functional
RDRAND/RDSEED implementations.

Disables visibility of RDRAND and RDSEED on AMD platforms.

Signed-off-by: Mikhail Paulyshka <me@mixaill.net>
---
 arch/x86/include/asm/msr-index.h       | 1 +
 arch/x86/kernel/cpu/rdrand.c           | 5 +++++
 tools/arch/x86/include/asm/msr-index.h | 1 +
 3 files changed, 7 insertions(+)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 72765b2fe0d8..bc5ef95cf0cb 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -614,6 +614,7 @@
 #define MSR_AMD64_OSVW_STATUS		0xc0010141
 #define MSR_AMD_PPIN_CTL		0xc00102f0
 #define MSR_AMD_PPIN			0xc00102f1
+#define MSR_AMD64_CPUID_FN_7		0xc0011002
 #define MSR_AMD64_CPUID_FN_1		0xc0011004
 #define MSR_AMD64_LS_CFG		0xc0011020
 #define MSR_AMD64_DC_CFG		0xc0011022
diff --git a/arch/x86/kernel/cpu/rdrand.c b/arch/x86/kernel/cpu/rdrand.c
index e9f7ef5dfe25..031c4297a54a 100644
--- a/arch/x86/kernel/cpu/rdrand.c
+++ b/arch/x86/kernel/cpu/rdrand.c
@@ -11,6 +11,7 @@
 #include <asm/processor.h>
 #include <asm/archrandom.h>
 #include <asm/sections.h>
+#include <asm/msr.h>
 
 
 enum { SAMPLES = 8, MIN_CHANGE = 5 };
@@ -46,6 +47,8 @@ void x86_init_rdrand(struct cpuinfo_x86 *c)
 
 	if (failure) {
 		clear_cpu_cap(c, X86_FEATURE_RDRAND);
+		if (c->x86_vendor == X86_VENDOR_AMD || c->x86_vendor == X86_VENDOR_HYGON)
+			msr_clear_bit(MSR_AMD64_CPUID_FN_1, 62);
 		pr_emerg("RDRAND is not reliable on this platform; disabling.\n");
 	}
 }
@@ -82,6 +85,8 @@ void x86_init_rdseed(struct cpuinfo_x86 *c)
 
 	if (failure) {
 		clear_cpu_cap(c, X86_FEATURE_RDSEED);
+		if (c->x86_vendor == X86_VENDOR_AMD || c->x86_vendor == X86_VENDOR_HYGON)
+			msr_clear_bit(MSR_AMD64_CPUID_FN_7, 18);
 		pr_emerg("RDSEED is not reliable on this platform; disabling.\n");
 	}
 }
diff --git a/tools/arch/x86/include/asm/msr-index.h b/tools/arch/x86/include/asm/msr-index.h
index 3ae84c3b8e6d..3deb6c11f134 100644
--- a/tools/arch/x86/include/asm/msr-index.h
+++ b/tools/arch/x86/include/asm/msr-index.h
@@ -612,6 +612,7 @@
 #define MSR_AMD64_OSVW_STATUS		0xc0010141
 #define MSR_AMD_PPIN_CTL		0xc00102f0
 #define MSR_AMD_PPIN			0xc00102f1
+#define MSR_AMD64_CPUID_FN_7		0xc0011002
 #define MSR_AMD64_CPUID_FN_1		0xc0011004
 #define MSR_AMD64_LS_CFG		0xc0011020
 #define MSR_AMD64_DC_CFG		0xc0011022
-- 
2.48.1


