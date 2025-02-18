Return-Path: <linux-kernel+bounces-519112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 76575A39825
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 11:07:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04CF6188D653
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 10:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0FEE23237A;
	Tue, 18 Feb 2025 10:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="dvjb6zU4"
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF49653
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 10:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739873193; cv=none; b=G4lPD00wI7hmOgx0dFhzIJiTIvrHIcRZOjgGnJkbJePFsmEpvWQUGHz1ht/kuZXv0rlL2ttP7JZ3WqzDQpBlpT4ZmGDCgiRkq7j1FJNjZxs/K1BxIqS7nC9QEZY7xpXUSXNct0QkEy+oxDm2sR8mukvBR7QzaCKYcg5gIwbXJbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739873193; c=relaxed/simple;
	bh=yTQLFA2M60fO6k4WtuJpDsKQ5AkSMH3vfnsFVh5jiew=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ldZnpRGDxFsAd4hGMa5ND2WZLSDHCAlYo0vJyK8sjkzYXG4/A1q7ZXQD0oAFh+EGEuinQ8Xph0StkNfKEQh2m26XH1GDtMhlCsw5hhnds9NzTLcHmlA959MCCPeiGFGpZzAlxe7f1LxPyYdE8MGBKvlfQ/49kcxdMCZaR9aRPos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=dvjb6zU4; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1739873164;
	bh=TFJStyRkd1bQw5tjsHzKQeYrAIDitsLr5zzdKFMGMbc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=dvjb6zU4Cxeq1fnRlr5wJeVRXw/TSdF6YG9wz+gU2EjwJCwwXp5YmViFojpPP79Ea
	 u7E4PBllNen1FkC6+md1QkcWKRXYSI7cK6BzYKn421qvVJIRSU8kb4lmAAbN5ikKXl
	 4wdUIPqs7Ld7fuX7naTo6ufjGuRD61fOtTUMIcBs=
X-QQ-mid: bizesmtpip2t1739873151t23iyhi
X-QQ-Originating-IP: TwGmGTJ49W7Svc0/Eh/Oa3QTL3/IcQynx4AZ4jbyB4w=
Received: from localhost.localdomain ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 18 Feb 2025 18:05:49 +0800 (CST)
X-QQ-SSF: 0002000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 5340021001472229730
From: WangYuli <wangyuli@uniontech.com>
To: chenhuacai@kernel.org,
	kernel@xen0n.name
Cc: loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	wangyuli@uniontech.com,
	guanwentao@uniontech.com,
	yangtiezhu@loongson.cn,
	maobibo@loongson.cn,
	zhanjun@uniontech.com,
	niecheng1@uniontech.com,
	chenlinxuan@uniontech.com
Subject: [PATCH v2] LoongArch: acpi: Make parse_acpi_topology() return void
Date: Tue, 18 Feb 2025 18:05:46 +0800
Message-ID: <07F85BCCFA4D65DF+20250218100546.500452-1-wangyuli@uniontech.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: Ngks2kg28nq5wTl/POcCcm1ewxXLLymmlQMTo1osKKC8xC9zTxyTLDTB
	ZH773r8i5lg+55A6m+Q8s/yXSNSmYXNrOyOENMcAsAAPKoLZXK09MV/2Rx/8P0iwUD6sBtI
	tQuFBzN2jtr6GYFLC5DTS43CWHgmmdBxg8ttUx0dNcx2RZeCJKyfPI3TEBz1T85Zz1VFBrK
	Pluj0spLhRVFCoEMBuuqzDyJwmn55dsHJDawio2cIgWYpmDhr/M+T3qVl9+mzDfuoO1Kel0
	HRQW1+IIkCV2pQWSZJp8hLDDKc73c7zq/ExX057ujObxbsvKqtkb3azYJ+ig3mGzBOdI2UH
	TBaZku0D33xMrrxeTCTSxq7it7eh/ea/BnFQdEfZEMlHy0v6iw9t82kuKeoN+YtRcuxZ68Y
	02OagaYGA3aQd7RPnSvtltmZgW5kmKUKjydhYBtYcaxVNdJltbKKZv2Oih2VwF51iZmjMEF
	neYMO7i4xNgQGw67XRtkc53iT949UX+FuSuUWNes0i6PggsHjiAg9rJkDPzkiAK4iZHS7id
	VnRGu5dUls9oQ8thQbrtd1TkCbBar0aGpIXTYI8lYY7tF+Jtwra75ZpyABFN1mBgikwxei7
	8XTOJLBsnanu/vw4ioZT2pabrhSNs5pbUs1prnzEgPsBuUu0FPrr1O/4uSA/nYl3cM+65oo
	cDgsu5/XbuWxJKiVETEjDS2vwGv1TDGKf62qM8VxDNor3KNtN9sbBp1D92Cx6Ev3HW6iK3Y
	PabGCGcO3xXfS4c6C4ldrBDL1KXejeOgmJNNmMsnc1s6xD5UoNe/j4qq8haBPCAqVNTdaoz
	mCnRpI4jUmO3qEALZezuScu7OgVXLAAAA9zf7MMnBC4wBgpCGPgZi5xyDTEbtTLKrtSGlHc
	3FXPfV/WdRCfzEqtkPOH1i6PC25tYj8xWkmj3OH8SXHLoNalAr1E1OQlwT9sUf00S/6i82O
	khIFBvzyIYBfGlLZN/jwpC+vQTGxj1BpxUPHIOOakhaD7p6GWSbBVrj/bEkWWEG/JCXVrkb
	RhvcL9vQTfjOmPzCCooxVKsNqtr678ZCyOZ6haQF9FVo3QR2K68AnG2qmbFiM=
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
X-QQ-RECHKSPAM: 0

The return value of parse_acpi_topology() is both unnecessary and
unused.

Co-developed-by: Wentao Guan <guanwentao@uniontech.com>
Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
Signed-off-by: Yuli Wang <wangyuli@uniontech.com>
---
Changelog:
 *v1->v2: Fix missing "return".
---
 arch/loongarch/include/asm/acpi.h | 2 +-
 arch/loongarch/kernel/acpi.c      | 9 ++++-----
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/loongarch/include/asm/acpi.h b/arch/loongarch/include/asm/acpi.h
index 313f66f7913a..c1b90a90e28b 100644
--- a/arch/loongarch/include/asm/acpi.h
+++ b/arch/loongarch/include/asm/acpi.h
@@ -38,7 +38,7 @@ static inline bool acpi_has_cpu_in_madt(void)
 extern struct list_head acpi_wakeup_device_list;
 extern struct acpi_madt_core_pic acpi_core_pic[MAX_CORE_PIC];
 
-extern int __init parse_acpi_topology(void);
+extern void __init parse_acpi_topology(void);
 
 static inline u32 get_acpi_id_for_cpu(unsigned int cpu)
 {
diff --git a/arch/loongarch/kernel/acpi.c b/arch/loongarch/kernel/acpi.c
index 382a09a7152c..5581e8009421 100644
--- a/arch/loongarch/kernel/acpi.c
+++ b/arch/loongarch/kernel/acpi.c
@@ -173,7 +173,7 @@ static void __init acpi_process_madt(void)
 
 int pptt_enabled;
 
-int __init parse_acpi_topology(void)
+void __init parse_acpi_topology(void)
 {
 	int cpu, topology_id;
 
@@ -181,7 +181,7 @@ int __init parse_acpi_topology(void)
 		topology_id = find_acpi_cpu_topology(cpu, 0);
 		if (topology_id < 0) {
 			pr_warn("Invalid BIOS PPTT\n");
-			return -ENOENT;
+			return;
 		}
 
 		if (acpi_pptt_cpu_is_thread(cpu) <= 0)
@@ -189,15 +189,14 @@ int __init parse_acpi_topology(void)
 		else {
 			topology_id = find_acpi_cpu_topology(cpu, 1);
 			if (topology_id < 0)
-				return -ENOENT;
+				pr_warn("Invalid BIOS PPTT\n");
+				return;
 
 			cpu_data[cpu].core = topology_id;
 		}
 	}
 
 	pptt_enabled = 1;
-
-	return 0;
 }
 
 #ifndef CONFIG_SUSPEND
-- 
2.47.2


