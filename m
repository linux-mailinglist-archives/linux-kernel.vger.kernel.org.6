Return-Path: <linux-kernel+bounces-345159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3E1298B28B
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 04:52:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5B16285F8A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 02:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14FE31ABED3;
	Tue,  1 Oct 2024 02:47:05 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68F431A7AFA
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 02:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727750824; cv=none; b=dMda2C8HfUIEy62v0Uf99hfwe9upmrnwzAo2U7epVtnXONWippDPgbEn6IaG06C1Ld5r6ujADYe5DCAr7oTxtEzk45QbstcEYERCBVcbPPGJxWyAIX355AtjkAIu6ihDHsye2DmMW89LES4ezJfglGqQ5yqye2Q2jnJsV70MY6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727750824; c=relaxed/simple;
	bh=c5iqpaTf95rRwldBsOxLSTGZIJ/5YKpcEJwc6kNMkig=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FkJ87RPxmBNDZCJsGRBydzXR6aD5JNZAossJNKu6jcaHDuDzbyMA0aIlGNnuJtH6HBwC8ZKzlbEkGg4bXrmXgqgmXcLABOL7hl7Puh2oPdxUT1w4ouhPCocNjxvUy8eLTTYzhvINkvoi97WfnJq2O5Wg680XzBj2jvUr+F5oYuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9150D367;
	Mon, 30 Sep 2024 19:47:29 -0700 (PDT)
Received: from a077893.blr.arm.com (a077893.blr.arm.com [10.162.16.61])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A96F33F58B;
	Mon, 30 Sep 2024 19:46:56 -0700 (PDT)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	maz@kernel.org
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
	Oliver Upton <oliver.upton@linux.dev>,
	James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH 44/47] arm64/sysreg: Add remaining debug registers affected by HDFGxTR2_EL2
Date: Tue,  1 Oct 2024 08:13:53 +0530
Message-Id: <20241001024356.1096072-45-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241001024356.1096072-1-anshuman.khandual@arm.com>
References: <20241001024356.1096072-1-anshuman.khandual@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The HDFGxTR2_EL2 registers trap a set of debug and trace related registers.
Almost all of those register encodings have been added in the tools sysreg
format. Let's also add all the remaining encodings which are formula based
(and only that, because we really don't care about what these registers
actually do at this stage).

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm64/include/asm/sysreg.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index 9ea97dddefc4..85cbce07ce77 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -270,6 +270,12 @@
 #define SYS_TRCVMIDCCTLR1		sys_reg(2, 1, 3, 3, 2)
 #define SYS_TRCVMIDCVR(m)		sys_reg(2, 1, 3, ((m & 7) << 1), 1)
 
+#define SYS_SPMEVCNTR_EL0(m)		sys_reg(2, 3, 14, (0 | (m >> 3)), (m & 7))
+#define SYS_SPMEVTYPER_EL0(m)		sys_reg(2, 3, 14, (2 | (m >> 3)), (m & 7))
+#define SYS_SPMEVFILTR_EL0(m)		sys_reg(2, 3, 14, (4 | (m >> 3)), (m & 7))
+#define SYS_SPMEVFILT2R_EL0(m)		sys_reg(2, 3, 14, (6 | (m >> 3)), (m & 7))
+#define SYS_PMEVCNTSVR_EL1(m)		sys_reg(2, 0, 14, (8 | (m >> 3)), (m & 7))
+
 /* ETM */
 #define SYS_TRCOSLAR			sys_reg(2, 1, 1, 0, 4)
 
-- 
2.25.1


