Return-Path: <linux-kernel+bounces-345115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ABA798B25A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 04:44:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1812283078
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 02:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA1AD3B7AC;
	Tue,  1 Oct 2024 02:44:15 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBFC643155
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 02:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727750655; cv=none; b=D2Wxypra7Zbo0CyNp9Sh6Ceb88QsYhKMP50uW2zVb8kxtZXvim/PYeeCSqUhisQcaN13Bg07tg4JdEbq51n9wk1AZTo2QR/nlpycxsga6Z+bm0vvpiewLJHiIWB/6NuXkYW0uDC9dmtiIUm4XwZSOSXLuEmZbrutr4XI/FseNH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727750655; c=relaxed/simple;
	bh=6bqCXfETTYasIuDes0nDf/4jwHva8W0JBSb/uG9wrBg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RPuy7us/O1sDMtFvDzbfbKJjxv33UkJWkZCDJbWkcAZSdOK2LV1PLTDEiF1Iwc2DWcWD/5/7E88NVKanWqYsJrpxHK86PuI2H0VRUQXuIPs0MIcwgpVlMG7H6TbLXl/pRmTmztpwrjQV43aEv5XRM0nBdm/SsBGxuMeKhIKqv/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D2C701424;
	Mon, 30 Sep 2024 19:44:42 -0700 (PDT)
Received: from a077893.blr.arm.com (a077893.blr.arm.com [10.162.16.61])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E1D093F58B;
	Mon, 30 Sep 2024 19:44:09 -0700 (PDT)
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
Subject: [PATCH 02/47] arm64/sysreg: Update register fields for ID_AA64DFR0_EL1
Date: Tue,  1 Oct 2024 08:13:11 +0530
Message-Id: <20241001024356.1096072-3-anshuman.khandual@arm.com>
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

This updates ID_AA64DFR0_EL1.[SEBEP|PMSS|PMUVer] register fields as per the
definitions based on DDI0601 2024-06.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm64/tools/sysreg | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
index 41b0e54515eb..0e90d40af2bd 100644
--- a/arch/arm64/tools/sysreg
+++ b/arch/arm64/tools/sysreg
@@ -1226,9 +1226,15 @@ UnsignedEnum	35:32	PMSVer
 	0b0101	V1P4
 EndEnum
 Field	31:28	CTX_CMPs
-Res0	27:24
+UnsignedEnum	27:24	SEBEP
+	0b0000	NI
+	0b0001	IMP
+EndEnum
 Field	23:20	WRPs
-Res0	19:16
+UnsignedEnum	19:16	PMSS
+	0b0000	NI
+	0b0001	IMP
+EndEnum
 Field	15:12	BRPs
 UnsignedEnum	11:8	PMUVer
 	0b0000	NI
@@ -1238,6 +1244,7 @@ UnsignedEnum	11:8	PMUVer
 	0b0110	V3P5
 	0b0111	V3P7
 	0b1000	V3P8
+	0b1001	V3P9
 	0b1111	IMP_DEF
 EndEnum
 UnsignedEnum	7:4	TraceVer
-- 
2.25.1


