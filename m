Return-Path: <linux-kernel+bounces-438912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC3849EA846
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 06:57:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EB7C28813A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 05:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5314522A1C8;
	Tue, 10 Dec 2024 05:55:27 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C09722A1E8
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 05:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733810127; cv=none; b=d0ehWf2bilpalbtCoBfRwyfGh8Bgu5FTfHJdT8I+aH8gDUfPTW5zgWiRx9CIemPEUp85HIa4fiMbf98pADRC+XcVQlNpB9lA8R7k92UFzjCUKbA8xSjOVzf8Bb6X48f4IFLEwOvoFSAmTS/rGCFPay53BeWoqYkWU4n2RXbJqyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733810127; c=relaxed/simple;
	bh=ct46qktxCS0PmlmR0EXxV9Ecqp/uPcDY+/UUEO564Vc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DG5Ts9bC3kVjDS5RX/hXUQjTK3i4LgSwAuxFdi/On+d4cT6VmmkX4sf83eU6MmVUMD9NgOgqx5neUuPs9nWpsHiwPlsAAJ++u8zcVxXT5/5OHthPR+YJu/u0ALKkTAcZHdGPouik7FPM7HO89Vi2fKzKnDNRtfnuqsbY2Dui9zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 47BF5113E;
	Mon,  9 Dec 2024 21:55:53 -0800 (PST)
Received: from a077893.arm.com (unknown [10.163.48.173])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A766D3F58B;
	Mon,  9 Dec 2024 21:55:21 -0800 (PST)
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
Subject: [PATCH V2 22/46] arm64/sysreg: Add register fields for PMICNTR_EL0
Date: Tue, 10 Dec 2024 11:22:47 +0530
Message-Id: <20241210055311.780688-23-anshuman.khandual@arm.com>
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

This adds register fields for PMICNTR_EL0 as per the definitions based
on DDI0601 2024-09.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm64/tools/sysreg | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
index ff833f6f7f6d..8baf57c06dbd 100644
--- a/arch/arm64/tools/sysreg
+++ b/arch/arm64/tools/sysreg
@@ -2591,6 +2591,10 @@ UnsignedEnum	2:0	F8S1
 EndEnum
 EndSysreg
 
+Sysreg	PMICNTR_EL0	3	3	9	4	0
+Field	63:0	ICNT
+EndSysreg
+
 SysregFields	HFGxTR_EL2
 Field	63	nAMAIR2_EL1
 Field	62	nMAIR2_EL1
-- 
2.25.1


