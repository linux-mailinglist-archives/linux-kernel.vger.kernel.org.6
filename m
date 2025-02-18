Return-Path: <linux-kernel+bounces-519141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3511A39888
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 11:17:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEFC33B42B9
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 10:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 906C923A561;
	Tue, 18 Feb 2025 10:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="F9WUjVOt"
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DCAE23958D
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 10:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739873477; cv=none; b=DBaT0v+LRI9hEFwQDqI4zIZSeBDwrGi3/Jh7ej2tVYm7FB1alWoMV1BTIOHex+AkoaGoRFSgtI+iDfQmXVWrdZIt49LjXEQUEBUUGWhBkXMqfuFMqXbgjBOb7rWjhGB3qTmrdg89FLeIvWqhI3bXFLzk8BfMqyjx+8WT2UXGxsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739873477; c=relaxed/simple;
	bh=zjTD9LJIKtAue/DjJ5uWTRVcYeoe4HLbQY/Nig+qlVo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DK9ieSB5drptT25vimCgT7zTXh1xUh8mQrbA7NCPTVlJJO/tDH3bcmvgYa8rNlSJ2pLWWZwHfEUgss/7rJKwp9gTMjkMO5y8CyZxw+16oqgS9zBttp8j5u35h9LGiq9RLvJYdErQy/UZbJvJR8QNhk0YISPFOjsR/EpziK2vaTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=F9WUjVOt; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1739873401;
	bh=TCGWb83nGv4/GMDsB+/881lyzMtaLWqEgIYJGHLCl4M=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=F9WUjVOtLSZ2euwPrE2R/+gJs+k/PsWRtu4H0fMx+lwgYBEPOYsG1cx2+XkTAtGJi
	 ejvw9Hw7cxDdWHyTtuj7xJ1oDVPGddsU7RkYQ3r0DPB96sUdBT04f565NLJpli0VVy
	 PzQ8B1RlD8e/qXQHXu4VIr77U2R3UZ4cwohkuA+g=
X-QQ-mid: bizesmtpip3t1739873389t1hrz7c
X-QQ-Originating-IP: c4ShBVJaMHo9FBNDxlj5GAOTW1DoodOZQFtkl4mMraA=
Received: from localhost.localdomain ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 18 Feb 2025 18:09:47 +0800 (CST)
X-QQ-SSF: 0002000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 14694023163078506760
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
Subject: [PATCH v3] LoongArch: acpi: Make parse_acpi_topology() return void
Date: Tue, 18 Feb 2025 18:09:46 +0800
Message-ID: <90496FB80CAB5AAE+20250218100946.502797-1-wangyuli@uniontech.com>
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
X-QQ-XMAILINFO: MRPzwZ7o8e7ou4Ta96Xyys+QzUw6jNReNNdg8/RisaMBkO60WAqf7mZK
	RSS64pJwbNAdvZohxyIJcquqxNNPGYfmFZdpee1p3wAmfhgJtyHZ8fbboEljc5MU2BxbGGN
	q687g+TOqVvGoFwJFIesApcgGEtXMJZyCowu0kgEHaxAubbxQeXUH2WoER4A0JMVFNxRyZv
	nQYzR7t3+bkg1A2+YjqazdjZlFrhRdAy+VLycaQnZr/ZdsTniO2srkYpQUFhlR710umxPSP
	GX6TgKM0FYbeCVxYiNhcrK+6bRi/1lnsUPAxFIwJ+rPgYWoMJnjeBziwrmseTfBUqiPPmHW
	MIfOWZlPqFKGxG1YpOiK9QtUCx+Aah13l3Rk91tbVixXMoi2Z4t+PYYS9k4fu/A+1XPMEad
	/7sWETIouCkYt6Z6s4oCnrFb2llpmRhOrwpDga3vPo5NGOFydN3XHGvD1kjO7zQMR1MR/4D
	b1c21WvNhkbiZUuMLmZSk/bT/+qE4RlLtnpFBnfpaM7TLL9RJUwPmKSOHEq5lHWUVNV96BD
	cvK1J+hG5OHbS3bC9NJkU+mLxn5wBFeCQMss7R/UFkkcQyaJidmNCsSW9K0CxkpajelCVZX
	D/Qb3KkbDuwuHUnC6Xj1hYSASvm8g9YRR3j5CWSABvZlJMLz2P/a8rcDOBhM6jYypPdXC4t
	TNHtvNDgUcAIWwYZSAYdezJiXkC5uue+Tc9pVYknQE67PnCvwsgHFjRfjqdGbXXxjcoyWP3
	ScjdaBkIPGnTO2BfWQ8RBUD+L2AXML5rd/+43F4C1SDpWzvEVEIhSslCpUNiBrfWnf6Xab9
	Fvt38DGAiNyXJRilJ0KBfZ15YaXUHdF4v3vHYRV4DeFtAiyuLd2CF12/FhtUA9NRkzrzwXc
	FG8ZWEZMNCDEPPmdoxDuSDry+0g3T/RR3qEZkvJ5KmMQJYbL3XpO6ICRWydJEA9w5gmzr20
	xHFTLH9JphhN0LKsWtbgzLJg0A/eTO18IU1WbIokY8qrOTCvQpc7MO35Ye5fywohHiwUsGt
	ptiVGs21H1ZMJABYaToEKQ7/xXMU0D9+IWXxBwBJFuWb4mwnFCmHMMqrxsHDH/0WmUR+eEk
	xPzPbAfSYjUPBEj2b0/frO4gvqJeuehwtt7PYoIY6P6o8ot3JYgcucmoPB80vdvobXhsgm8
	dUMz0WnCsmqQGj/ErGesU2i5kyho+gRMAAPUAWyOSgm8sDU=
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
X-QQ-RECHKSPAM: 0

The return value of parse_acpi_topology() is both unnecessary and
unused.

Co-developed-by: Wentao Guan <guanwentao@uniontech.com>
Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
Signed-off-by: Yuli Wang <wangyuli@uniontech.com>
---
Changelog:
 *v1->v2: Fix missing "return".
  v2->v3: Fix missing "{}"
---
 arch/loongarch/include/asm/acpi.h |  2 +-
 arch/loongarch/kernel/acpi.c      | 12 ++++++------
 2 files changed, 7 insertions(+), 7 deletions(-)

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
index 382a09a7152c..2bb3bc42e6ed 100644
--- a/arch/loongarch/kernel/acpi.c
+++ b/arch/loongarch/kernel/acpi.c
@@ -173,7 +173,7 @@ static void __init acpi_process_madt(void)
 
 int pptt_enabled;
 
-int __init parse_acpi_topology(void)
+void __init parse_acpi_topology(void)
 {
 	int cpu, topology_id;
 
@@ -181,23 +181,23 @@ int __init parse_acpi_topology(void)
 		topology_id = find_acpi_cpu_topology(cpu, 0);
 		if (topology_id < 0) {
 			pr_warn("Invalid BIOS PPTT\n");
-			return -ENOENT;
+			return;
 		}
 
 		if (acpi_pptt_cpu_is_thread(cpu) <= 0)
 			cpu_data[cpu].core = topology_id;
 		else {
 			topology_id = find_acpi_cpu_topology(cpu, 1);
-			if (topology_id < 0)
-				return -ENOENT;
+			if (topology_id < 0){
+				pr_warn("Invalid BIOS PPTT\n");
+				return;
+			}
 
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


