Return-Path: <linux-kernel+bounces-345138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73D9B98B276
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 04:48:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 238772837A1
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 02:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0E7A192D9F;
	Tue,  1 Oct 2024 02:45:42 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23B12126BE3
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 02:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727750742; cv=none; b=Z+84ldIhCUwjNn1kS1Vqn7HKXW+Gr5EH5UX3FQbekJyPtFUDcHXFDsBoslIsk3bZ2nNe/pedoalGypplSDd7d9PWi1c9aRmOPfYgnS64XQzOuoP5BC7AbL7+10Sz5pIDXHZ93LWQyvfmeyg835JHotlAqby3wirHiKXJ19PktyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727750742; c=relaxed/simple;
	bh=6u6zzcQCLNKKhc3FZ7bUkh38Q1So228MDyoO088uQOY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bNGSkuWJT9K0zUrRFmrgP59/cSCxq1Z+pLmru5C96JumR6pgI9U/dRbQFNNo2Dk2wgUu3D9C3L8EPMzGWKc/F+zKa7sxvTVa8pP9TedEP4KfoFh8c8Uf3QWYI+ULFAdqfOc4Yy8VKSM8JI7qH7dk1PlPw+cJaQQI2M3qG+cq5gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 47768367;
	Mon, 30 Sep 2024 19:46:10 -0700 (PDT)
Received: from a077893.blr.arm.com (a077893.blr.arm.com [10.162.16.61])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 56B883F58B;
	Mon, 30 Sep 2024 19:45:37 -0700 (PDT)
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
Subject: [PATCH 24/47] arm64/sysreg: Add register fields for PMICFILTR_EL0
Date: Tue,  1 Oct 2024 08:13:33 +0530
Message-Id: <20241001024356.1096072-25-anshuman.khandual@arm.com>
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

This adds register fields for PMICFILTR_EL0 as per the definitions based
on DDI0601 2024-06.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm64/tools/sysreg | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
index 4bf8ae6d8a26..300c213f39da 100644
--- a/arch/arm64/tools/sysreg
+++ b/arch/arm64/tools/sysreg
@@ -2492,6 +2492,27 @@ Sysreg	PMICNTR_EL0	3	3	9	4	0
 Field	63:0	ICNT
 EndSysreg
 
+Sysreg	PMICFILTR_EL0	3	3	9	6	0
+Res0	63:59
+Field	58	SYNC
+Field	57:56	VS
+Res0	55:32
+Field	31	P
+Field	30	U
+Field	29	NSK
+Field	28	NSU
+Field	27	NSH
+Field	26	M
+Res0	25
+Field	24	SH
+Field	23	T
+Field	22	RLK
+Field	21	RLU
+Field	20	RLH
+Res0	19:16
+Field	15:0	evtCount
+EndSysreg
+
 SysregFields	HFGxTR_EL2
 Field	63	nAMAIR2_EL1
 Field	62	nMAIR2_EL1
-- 
2.25.1


