Return-Path: <linux-kernel+bounces-345155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0457598B287
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 04:51:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CA8A1C255DB
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 02:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40A381A4B6B;
	Tue,  1 Oct 2024 02:46:46 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99F1E1A3BB1
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 02:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727750805; cv=none; b=Up7akMc30VCcxgjeOxlnZiXrBluGPsOPuTKn4cMVUEJhrYbd7zNBEc9MyQuRFOLWkTRxsq7FMb4x4jzNfa7bMDTkodkYpc4p2hTpN3D7gvveZ2kqJIfo5YweQ16mf7A2Txlj/fWWOVRIVFVPMBHJmqikDuv5AGsAVqrTt4dELbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727750805; c=relaxed/simple;
	bh=Z7TScUmHHCtsxMxrUnLqllB6ap7TuudPJwolTLaBJAA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SReGIT4FGu6+YJFjg+vBM8/oCWMCAH54Wv8ByBFNL7sdSxPYf1KDgGFFWA0R/3ckCUtWs6FsCT+GzZJLPOCxme19o+zPsnasXppG/95iM/oAS8Di8OiVd4Y06UvaKmX6xSrpkq0AGYF6JyMIKoj2g3Qq1PIVt1Mj+lUbO/7m0G8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C072F367;
	Mon, 30 Sep 2024 19:47:13 -0700 (PDT)
Received: from a077893.blr.arm.com (a077893.blr.arm.com [10.162.16.61])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id CDA4F3F58B;
	Mon, 30 Sep 2024 19:46:40 -0700 (PDT)
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
Subject: [PATCH 40/47] arm64/sysreg: Add register fields for SPMCGCR1_EL1
Date: Tue,  1 Oct 2024 08:13:49 +0530
Message-Id: <20241001024356.1096072-41-anshuman.khandual@arm.com>
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

This adds register fields for SPMCGCR1_EL1 as per the definitions based
on DDI0601 2024-06.

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
index 50397a1a5799..ad7a1dc05f8a 100644
--- a/arch/arm64/tools/sysreg
+++ b/arch/arm64/tools/sysreg
@@ -129,6 +129,10 @@ Sysreg	SPMCGCR0_EL1	2	0	9	13	0
 Fields	SPMCGCRx_EL1
 EndSysreg
 
+Sysreg	SPMCGCR1_EL1    2       0       9       13      1
+Fields	SPMCGCRx_EL1
+EndSysreg
+
 Sysreg	SPMACCESSR_EL1	2	0	9	13	3
 Field	63:62	P31
 Field	61:60	P30
-- 
2.25.1


