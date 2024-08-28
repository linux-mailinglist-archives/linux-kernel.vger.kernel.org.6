Return-Path: <linux-kernel+bounces-304205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B2542961BC9
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 04:07:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6879B1F24A29
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 02:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCD3F41A8F;
	Wed, 28 Aug 2024 02:07:46 +0000 (UTC)
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8122B1B969
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 02:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724810866; cv=none; b=Kn+XKuCNbjChFlmBLOa/6+rgkWvTjBjg8bpsji43sRoEwpTHA9lacry+v9RSG8gVwMATqZkyCJgyZ5p8lT/T+LAWAfqrvuN3tnzbw+SFsmlTz5SnATTfrzx6oQhvJX083QaYewDtebFOnr4jKhTLMmBbRR+WxdKOlo01S5iCMHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724810866; c=relaxed/simple;
	bh=zmrpfzNfsYR3nGV1VPJvI1aBj1WN2CCFuRkUcXP3Y3s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MdHOshPD6oj/L9i1lBeylNUsbJnRk5AFFPrriqoG/Awp3NM1UShAew3DUiiLFArQte7gP6skSS8GFFEuJuTs1w/TRTnSFUaSxj3XYiXDRHpu4oYig+oGgZVVhb8EsOOZBJ+QhyLpPEp3ybb/kTS36qeCq+Rv8vCQVksesn4P/q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from qiao.. (unknown [210.73.53.31])
	by APP-05 (Coremail) with SMTP id zQCowACnEUFahs5mJkzmCg--.9771S2;
	Wed, 28 Aug 2024 10:07:24 +0800 (CST)
From: Zhe Qiao <qiaozhe@iscas.ac.cn>
To: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	conor.dooley@microchip.com,
	samuel.holland@sifive.com,
	evan@rivosinc.com,
	sunilvl@ventanamicro.com,
	ajones@ventanamicro.com,
	andy.chiu@sifive.com,
	tglx@linutronix.de,
	qiaozhe@iscas.ac.cn
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] riscv: Report error when repeatedly recording CPU hardware ID
Date: Wed, 28 Aug 2024 10:07:18 +0800
Message-ID: <20240828020718.46977-1-qiaozhe@iscas.ac.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowACnEUFahs5mJkzmCg--.9771S2
X-Coremail-Antispam: 1UD129KBjvJXoW7CF1DAFWrKFWUGr15KF45KFg_yoW8Jw47pr
	W8Grs0krsYvFsFk34Sqa4xuFy3JF1vgw4ftF4fta4rJr1UAwnrJ39xKa43ZF15tF48X3Wr
	AF4Yyr1YgFyUCa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9214x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr
	1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
	7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r
	1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02
	628vn2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4
	IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1r
	MI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJV
	WUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j
	6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYx
	BIdaVFxhVjvjDU0xZFpf9x0JUd-B_UUUUU=
X-CM-SenderInfo: ptld061kh6x2xfdvhtffof0/

If the same CPU hardware attributes exist, the boot is aborted.
Ensure the uniqueness of the CPU hardware ID recorded in the
__cpuid_to_hartid_map[] array.

Signed-off-by: Zhe Qiao <qiaozhe@iscas.ac.cn>
---
V1 -> V2:
  1. Change the error report to BUG().
  2. Change the function name to is_cartid_duplicate().
  3. Modify commit description.
---
 arch/riscv/kernel/smpboot.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
index 0f8f1c95ac38..f29a6fd55aa8 100644
--- a/arch/riscv/kernel/smpboot.c
+++ b/arch/riscv/kernel/smpboot.c
@@ -118,6 +118,16 @@ static void __init acpi_parse_and_init_cpus(void)
 #define acpi_parse_and_init_cpus(...)	do { } while (0)
 #endif
 
+static bool __init is_hartid_duplicate(unsigned int cpuid, u64 hart)
+{
+	unsigned int i;
+
+	for (i = 1; (i < cpuid) && (i < NR_CPUS); i++)
+		if (cpuid_to_hartid_map(i) == hart)
+			return true;
+	return false;
+}
+
 static void __init of_parse_and_init_cpus(void)
 {
 	struct device_node *dn;
@@ -131,6 +141,9 @@ static void __init of_parse_and_init_cpus(void)
 		if (rc < 0)
 			continue;
 
+		if (is_hartid_duplicate(cpuid, hart))
+			BUG_ON(1);
+
 		if (hart == cpuid_to_hartid_map(0)) {
 			BUG_ON(found_boot_cpu);
 			found_boot_cpu = 1;
-- 
2.43.0


