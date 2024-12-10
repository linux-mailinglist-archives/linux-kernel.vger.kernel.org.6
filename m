Return-Path: <linux-kernel+bounces-438921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D1129EA84E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 06:59:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21B7016C7B2
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 05:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE74C22F3A8;
	Tue, 10 Dec 2024 05:56:05 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1373722836E
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 05:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733810165; cv=none; b=N6fXhT19nxkQZNynAXFW3iDRZtEInIaBpOupubChmn4tMGRzGl5u+ggIRLkKV+4UaRAc3O1xAm7HUgZElA/l9M25RganI7tS4LAW5akTDq4gYWjtRnyvwKfkZov3FwsUnumdb1FLqP/B/qFVTlfPrtme+iaslBpBpXrYQ+lyj1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733810165; c=relaxed/simple;
	bh=Kb2mAhQuDznJ/xq2ScWlltmk8IeJqrp5a+QMu+fQdRg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=InXHXtF5K35jcfV/dO+gaUnZGbT6Pt6O5gxIRIFzM5zK956KHf2jtfH7+R5lvfbs9fC1tLb+tkacgmVReMaGE8xl84emn7oA57GrCf2UoS3E2ecpbmwnVo3ZE5ggnQICL82hw1tMcIJ0//i5LZ75QXGEisVPwEB4cf6Rt9VVvzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C3928113E;
	Mon,  9 Dec 2024 21:56:31 -0800 (PST)
Received: from a077893.arm.com (unknown [10.163.48.173])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2DEB13F58B;
	Mon,  9 Dec 2024 21:55:59 -0800 (PST)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	maz@kernel.org
Cc: ryan.roberts@arm.com,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Oliver Upton <oliver.upton@linux.dev>,
	James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH V2 31/46] arm64/sysreg: Add register fields for SPMSELR_EL0
Date: Tue, 10 Dec 2024 11:22:56 +0530
Message-Id: <20241210055311.780688-32-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241210055311.780688-1-anshuman.khandual@arm.com>
References: <20241210055311.780688-1-anshuman.khandual@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds register fields for SPMSELR_EL0 as per the definitions based
on DDI0601 2024-09.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm64/tools/sysreg | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
index a7b8f5602163..e57973b27e9c 100644
--- a/arch/arm64/tools/sysreg
+++ b/arch/arm64/tools/sysreg
@@ -513,6 +513,18 @@ Field	1	P1
 Field	0	P0
 EndSysreg
 
+Sysreg	SPMSELR_EL0	2	3	9	12	5
+Res0	63:10
+Field	9:4	SYSPMUSEL
+Res0	3:2
+UnsignedEnum	1:0	BANK
+	0b00	BANK_0
+	0b01	BANK_1
+	0b10	BANK_2
+	0b11	BANK_3
+EndEnum
+EndSysreg
+
 Sysreg	SPMOVSSET_EL0	2	3	9	14	3
 Field	63	P63
 Field	62	P62
-- 
2.25.1


