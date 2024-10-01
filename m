Return-Path: <linux-kernel+bounces-345149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A461698B281
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 04:50:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43F34286C98
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 02:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DD3358AD0;
	Tue,  1 Oct 2024 02:46:26 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5BD11552FF
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 02:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727750786; cv=none; b=X6WFHoq8oa1n5zTPN7mI/U0J0uo/VtJX+ANB5YOXi1AX4GvWYJgkwcWF3Uehq7vP9vjXR/anXRayFIKxgS62TNIOGsFoVPAriYqhuzaAJpgrd9CVrWBZoY48tfF3p216Nmu4RgXB06YmI7hNvX75MOEvWp+i6i/QCbRkkhyw448=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727750786; c=relaxed/simple;
	bh=SxvH6E3B8wImK1plrdYNyoq0sY2qMC5fGKPFE8UmKeg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=q9CqL+B7DDrs4LYOKCwjDTSNnrS++FeewaDpSksQVtKNC4DluxFgrLpzqxRGlLUkHOBCZ8aMgNv9eeF5oKowEoZ7vIpSGAfYNZmSV6o9fK0VPLMxzeSYuoarlIUSNFepvpHNnFg1EMwM2kRxdrQDmE87A0rxQI/s/WA7ymO0OUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D3AB9367;
	Mon, 30 Sep 2024 19:46:53 -0700 (PDT)
Received: from a077893.blr.arm.com (a077893.blr.arm.com [10.162.16.61])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E1A993F58B;
	Mon, 30 Sep 2024 19:46:20 -0700 (PDT)
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
Subject: [PATCH 35/47] arm64/sysreg: Add register fields for SPMDEVARCH_EL1
Date: Tue,  1 Oct 2024 08:13:44 +0530
Message-Id: <20241001024356.1096072-36-anshuman.khandual@arm.com>
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

This adds register fields for SPMDEVARCH_EL1 as per the definitions based
on DDI0601 2024-06.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm64/tools/sysreg | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
index 073d92fd085a..270058558a24 100644
--- a/arch/arm64/tools/sysreg
+++ b/arch/arm64/tools/sysreg
@@ -159,6 +159,15 @@ Res0	7
 Field	6:0	Implementer_low
 EndSysreg
 
+Sysreg	SPMDEVARCH_EL1	2	0	9	13	5
+Res0	63:32
+Field	31:21	ARCHITECT
+Field	20	PRESENT
+Field	19:16	REVISION
+Field	15:12	ARCHVER
+Field	11:0	ARCHPART
+EndSysreg
+
 Sysreg	SPMDEVAFF_EL1	2	0	9	13	6
 Res0	63:40
 Field	39:32	Aff3
-- 
2.25.1


