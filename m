Return-Path: <linux-kernel+bounces-438893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55F4F9EA833
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 06:54:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DAC5169BED
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 05:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2501228389;
	Tue, 10 Dec 2024 05:53:39 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 168F3228383
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 05:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733810019; cv=none; b=TuTjHlQGD/KET6VUcSxk+nlNDtKn6MWDBW4zs+rydMCdol37CZ6SLS0YYqBDCpG1btLnl8ImqiR0xS3PuNKghETJU9aSX6ukTWk1o4OXXCMPRu8vI46xVNyhOqvw5GuisNjNkS3CV3UKPWdbVak9JETjVQhODvEE2SiX3yylyu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733810019; c=relaxed/simple;
	bh=GkoVkkoNSjPJIC7i2Jqd3ADUfKdnchBUnmhHwRXgQk0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KLxND0sND5OJDpTpowcza33gZKEWJX0fITlkYKM/epryY5hdztpDoVpapzWmgQ2yfqrBQyDwpooSCHq+dc0+j3IVGK+lTve/VKixkCgUhLTSfZGlLl3s5m5oyb4WoAlxFQR7TA94oUQ4bbsxHdmD9GwqIPkWj/i+V4e6/AbIcZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 84A7F113E;
	Mon,  9 Dec 2024 21:54:05 -0800 (PST)
Received: from a077893.arm.com (unknown [10.163.48.173])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6BD013F58B;
	Mon,  9 Dec 2024 21:53:33 -0800 (PST)
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
Subject: [PATCH V2 03/46] arm64/sysreg: Update register fields for ID_AA64PFR0_EL1
Date: Tue, 10 Dec 2024 11:22:28 +0530
Message-Id: <20241210055311.780688-4-anshuman.khandual@arm.com>
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

This updates ID_AA64PFR0_EL1.RAS and ID_AA64PFR0_EL1.RME register fields as
per the definitions based on DDI0601 2024-09.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm64/tools/sysreg | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
index b5bda7c94689..59351931d907 100644
--- a/arch/arm64/tools/sysreg
+++ b/arch/arm64/tools/sysreg
@@ -873,6 +873,8 @@ EndEnum
 UnsignedEnum	55:52	RME
 	0b0000	NI
 	0b0001	IMP
+	0b0010	GPC2
+	0b0011	GPC3
 EndEnum
 UnsignedEnum	51:48	DIT
 	0b0000	NI
@@ -899,6 +901,7 @@ UnsignedEnum	31:28	RAS
 	0b0000	NI
 	0b0001	IMP
 	0b0010	V1P1
+	0b0011	V2
 EndEnum
 UnsignedEnum	27:24	GIC
 	0b0000	NI
-- 
2.25.1


