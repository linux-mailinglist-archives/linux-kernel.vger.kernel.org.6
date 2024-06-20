Return-Path: <linux-kernel+bounces-222130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A643B90FD2D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 08:59:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5A2C1C24416
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 06:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF3BB44C81;
	Thu, 20 Jun 2024 06:58:44 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0043144376
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 06:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718866724; cv=none; b=iBF3UplGd9FHzmaIRUalT3IoSyVUUaUmA0im94kxFjBoAKkExjXQAlNBa2rtfmfpQuYINiqIuuMyjMrvmcJHBfmo726kCe1uxnyfaIY15P7SNB1FViqwdiDqdAqokVQcL2npkBPZ4Vx+1EbavEPBRyUlxrX1cHPD2ssNHp9ZHV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718866724; c=relaxed/simple;
	bh=MaptKQEXggdgTWeJWGD6HqSltEbT8KaW7mxL6990ZwY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kAYmHJcDeLMKcvcqW+jiDy36heSJXBrK7QI3hbs8eXmgG/T5G6oLr9W8wR/uhlSkcC6DXqzvhZ8aZzN6sqNK+A7KS8e1rllvjRZcqM9YEDW/BKGcgxZuls67dzpqBpkkkVYxiYdvgs2Rp4QyKt1m8Lq93UbSEJtlCSDYwXKb0mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 638E2DA7;
	Wed, 19 Jun 2024 23:59:07 -0700 (PDT)
Received: from a077893.arm.com (unknown [10.163.46.59])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 67C443F73B;
	Wed, 19 Jun 2024 23:58:38 -0700 (PDT)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-arm-kernel@lists.infradead.org,
	maz@kernel.org
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
	Oliver Upton <oliver.upton@linux.dev>,
	James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [RFC 05/10] arm64/sysreg: Add register fields for HDFGWTR2_EL2
Date: Thu, 20 Jun 2024 12:28:02 +0530
Message-Id: <20240620065807.151540-6-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240620065807.151540-1-anshuman.khandual@arm.com>
References: <20240620065807.151540-1-anshuman.khandual@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds register fields for HDFGWTR2_EL2 as per the definitions based
on DDI0601 2024-03.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Reviewed-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm64/tools/sysreg | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
index 8b43f99f6779..3cd254755cd9 100644
--- a/arch/arm64/tools/sysreg
+++ b/arch/arm64/tools/sysreg
@@ -2483,6 +2483,33 @@ Field	1 nPMIAR_EL1
 Field	0 nPMECR_EL1
 EndSysreg
 
+Sysreg HDFGWTR2_EL2	3	4	3	1	1
+Res0	63:24
+Field	23 nMDSTEPOP_EL1
+Field	22 nTRBMPAM_EL1
+Field	21 nPMZR_EL0
+Field	20 nTRCITECR_EL1
+Field	19 nPMSDSFR_EL1
+Res0	18:17
+Field	16 nSPMSCR_EL1
+Field	15 nSPMACCESSR_EL1
+Field	14 nSPMCR_EL0
+Field	13 nSPMOVS
+Field	12 nSPMINTEN
+Field	11 nSPMCNTEN
+Field	10 nSPMSELR_EL0
+Field	9 nSPMEVTYPERn_EL0
+Field	8 nSPMEVCNTRn_EL0
+Field	7 nPMSSCR_EL1
+Res0	6
+Field	5 nMDSELR_EL1
+Field	4 nPMUACR_EL1
+Field	3 nPMICFILTR_EL0
+Field	2 nPMICNTR_EL0
+Field	1 nPMIAR_EL1
+Field	0 nPMECR_EL1
+EndSysreg
+
 Sysreg HDFGRTR_EL2	3	4	3	1	4
 Field	63	PMBIDR_EL1
 Field	62	nPMSNEVFR_EL1
-- 
2.25.1


