Return-Path: <linux-kernel+bounces-222126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 741EF90FD29
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 08:58:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A0F81F259BE
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 06:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5924344376;
	Thu, 20 Jun 2024 06:58:27 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 537A644C64
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 06:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718866706; cv=none; b=mFm9kXl8/iiwBPaBH4mHa4vXa4W+hsnr3g8RnuxKm0YwWRaxitokmowP0LkZNZKB/Yt2Fx6WbVPfM7LRIPiTgcvzqB9ahm39cspbdxhJJrq+PN9albQbhBSkOjp/Yu8MDNJrC0wYCGFxEvCueFBDpxDGNAaPyo1xIaMkYLKziP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718866706; c=relaxed/simple;
	bh=rAWzQoKLawDmEfaA88cxGcCrCsJwwjtuG5tBfPZ0+gI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AfKN6zR9MjxAPfriTP0VZOlsD6+2fPtzRE5ppTDG++5+Mh/8Hb5N/I9zrwsyrV/gJ0Rs3DtP7Acd1qIl7VewvWPcuLLeSo5zpoTnv15kWf0u5VT81r1JaXa24xHBAt222eroH5pAReeynbXI+QpzAeS2jcykY+USxPLbA318cow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8EB01DA7;
	Wed, 19 Jun 2024 23:58:48 -0700 (PDT)
Received: from a077893.arm.com (unknown [10.163.46.59])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id F29793F73B;
	Wed, 19 Jun 2024 23:58:18 -0700 (PDT)
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
Subject: [RFC 01/10] arm64/sysreg: Update ID_AA64MMFR0_EL1 register
Date: Thu, 20 Jun 2024 12:27:58 +0530
Message-Id: <20240620065807.151540-2-anshuman.khandual@arm.com>
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

This updates ID_AA64MMFR0_EL1.FGT and ID_AA64MMFR0_EL1.PARANGE register
fields as per the definitions based on DDI0601 2024-03.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Reviewed-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm64/tools/sysreg | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
index a4c1dd4741a4..b50dd7568c0d 100644
--- a/arch/arm64/tools/sysreg
+++ b/arch/arm64/tools/sysreg
@@ -1556,6 +1556,7 @@ EndEnum
 UnsignedEnum	59:56	FGT
 	0b0000	NI
 	0b0001	IMP
+	0b0010	FGT2
 EndEnum
 Res0	55:48
 UnsignedEnum	47:44	EXS
@@ -1617,6 +1618,7 @@ Enum	3:0	PARANGE
 	0b0100	44
 	0b0101	48
 	0b0110	52
+	0b0111	56
 EndEnum
 EndSysreg
 
-- 
2.25.1


