Return-Path: <linux-kernel+bounces-445863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 007B49F1C89
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 05:35:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C413188D579
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 04:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 656E527442;
	Sat, 14 Dec 2024 04:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E4BkmSne"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3FE1EBE
	for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 04:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734150930; cv=none; b=TLugg5+nBLW6U9YCtyXpoQLo2iuLqKv1u3rzE/v8d8BL9LlJ7n3NzlbZ4jJTZsSQ+iXZOsM3LAAukrUXJPP8eoqF6T+PPGGs+33SvwSizCAMmlF43CCBI8RnYbtyahdvs1msuJd44WxX6mFoiRBR9LY/0Ug0pnmrjOfK+VMdrgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734150930; c=relaxed/simple;
	bh=mmMDThyct6EjeRdz+fnJe0nY/rASetZ3DPQ1Cq8H384=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jluI/DqHILw17yqN7CKQBSwZkq3z9q1YzAixPILwj9FuzrxqxSqVRcL2uyewUQGPf8v3sSCo445P61Y8acd979lfMQyYxJIqm60TmkTBfth5vMaO6UGakn+2u3jw7jEtypSLMY2aSJ0HD+8nWgAXDTZ6Jzf2xRpk+99bSqW9Mm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E4BkmSne; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CBEBC4CED1;
	Sat, 14 Dec 2024 04:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734150930;
	bh=mmMDThyct6EjeRdz+fnJe0nY/rASetZ3DPQ1Cq8H384=;
	h=From:To:Cc:Subject:Date:From;
	b=E4BkmSnedgzzT4cVwOmNzbEN+zUhDvU39RGbzF6nDW9RtB/W8rbalUutbh9LT8p3J
	 KzHeXK0OliI9AFwc0tncM/gdseC1bR0Az1vbgeJtAoqPOsrZej8mnL7qxLxQrESzXQ
	 lTqUyhZpkKSYruLIXDGUl4tJ1h099QU0qIWh2awY9lLzXGulQ9hinIbTVOTGhX5qJH
	 7DI+Fu/9tAGf0nx1WU6AUyR/bgNFWWTQv+Z/gKB2ZKTpsOMNTYwa2aNyS7U7swokwE
	 m0KexztfVqwb7C/G0BC7kLDRChtYa+m71niYrtX5pNwEenASPYw3sQ+ONk+yuBzxjv
	 CJQpjW/qzcLhg==
From: guoren@kernel.org
To: guoren@kernel.org,
	conor@kernel.org,
	alexghiti@rivosinc.com
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	bjorn@rivosinc.com,
	leobras@redhat.com,
	peterz@infradead.org,
	parri.andrea@gmail.com,
	longman@redhat.com,
	boqun.feng@gmail.com,
	arnd@arndb.de,
	will@kernel.org,
	corbet@lwn.net,
	Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH] riscv: Add riscv_force_qspinlock for early_param
Date: Fri, 13 Dec 2024 23:35:10 -0500
Message-Id: <20241214043510.3795984-1-guoren@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Guo Ren <guoren@linux.alibaba.com>

When CONFIG_RISCV_COMBO_SPINLOCKS is enabled, permit qspinlock
force enabled. See the Kconfig entry for RISCV_COMBO_SPINLOCKS.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
---
 Documentation/admin-guide/kernel-parameters.txt |  5 +++++
 arch/riscv/kernel/setup.c                       | 13 ++++++++++++-
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 3872bc6ec49d..43d0df2922b2 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5887,6 +5887,11 @@
 			[KNL] Disable ring 3 MONITOR/MWAIT feature on supported
 			CPUs.
 
+	riscv_force_qspinlock [RISCV, EARLY]
+			When CONFIG_RISCV_COMBO_SPINLOCKS is enabled, permit
+			qspinlock force enabled. See the Kconfig entry for
+			RISCV_COMBO_SPINLOCKS.
+
 	riscv_isa_fallback [RISCV,EARLY]
 			When CONFIG_RISCV_ISA_FALLBACK is not enabled, permit
 			falling back to detecting extension support by parsing
diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
index 45010e71df86..74b13bc64c9c 100644
--- a/arch/riscv/kernel/setup.c
+++ b/arch/riscv/kernel/setup.c
@@ -247,6 +247,15 @@ static void __init parse_dtb(void)
 #if defined(CONFIG_RISCV_COMBO_SPINLOCKS)
 DEFINE_STATIC_KEY_TRUE(qspinlock_key);
 EXPORT_SYMBOL(qspinlock_key);
+
+static bool force_qspinlock;
+
+static int __init riscv_force_qspinlock(char *p)
+{
+	force_qspinlock = true;
+	return 0;
+}
+early_param("riscv_force_qspinlock", riscv_force_qspinlock);
 #endif
 
 static void __init riscv_spinlock_init(void)
@@ -267,7 +276,9 @@ static void __init riscv_spinlock_init(void)
 		using_ext = "using Ziccrse";
 	}
 #if defined(CONFIG_RISCV_COMBO_SPINLOCKS)
-	else {
+	else if (force_qspinlock) {
+		using_ext = "force";
+	} else {
 		static_branch_disable(&qspinlock_key);
 		pr_info("Ticket spinlock: enabled\n");
 		return;
-- 
2.40.1


