Return-Path: <linux-kernel+bounces-345150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0CEC98B282
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 04:50:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D232286EAC
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 02:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59464170A18;
	Tue,  1 Oct 2024 02:46:30 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A88BB1552FF
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 02:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727750789; cv=none; b=drGf4BvnKRThZeCeG7wjqg0W8481Ja0wBfiyvbpKMQ4lpqan0kpOC+hBiolvxfpvpglc+4r7JSwzwwCauKyDqqAUSAY1pRNh4TOb6NgxxyGMjtVS6zzG/EjQ9G8xa+Vo4UNs4pDJywLiSgOC2KAX8R8cFzcn3VhZrCOz3DYT9pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727750789; c=relaxed/simple;
	bh=7KiUN9C94ygCdrTgHsh9IlzGgra5s6KZhi1EQrwXttI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hRBxTG0+toSSNSmkJduuoA8irxQ9hX1bCBKFJd/1CwBexagMkFx4g5ufOrjIY5lhl/63TKgnF07Q2ubUcgLemudv+qt9m73fwXlZakvWr+okuqeqnji/TPRgg/bQtONdlawGjS3yQZ0CyOY13UvSSMDYqa4MO+BsofDHgTO58bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D1957367;
	Mon, 30 Sep 2024 19:46:57 -0700 (PDT)
Received: from a077893.blr.arm.com (a077893.blr.arm.com [10.162.16.61])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id DF6263F58B;
	Mon, 30 Sep 2024 19:46:24 -0700 (PDT)
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
Subject: [PATCH 36/47] arm64/sysreg: Add register fields for SPMCFGR_EL1
Date: Tue,  1 Oct 2024 08:13:45 +0530
Message-Id: <20241001024356.1096072-37-anshuman.khandual@arm.com>
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

This adds register fields for SPMCFGR_EL1 as per the definitions based
on DDI0601 2024-06.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm64/tools/sysreg | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
index 270058558a24..a07d89e43498 100644
--- a/arch/arm64/tools/sysreg
+++ b/arch/arm64/tools/sysreg
@@ -180,6 +180,24 @@ Field	15:8	Aff1
 Field	7:0	Aff0
 EndSysreg
 
+Sysreg	SPMCFGR_EL1	2	0	9	13	7
+Res0	63:32
+Field	31:28	NCG
+Res0	27:25
+Field	24	HDBG
+Field	23	TR0
+Field	22	SS
+Field	21	FZ0
+Field	20	MSI
+Field	19	RAO
+Res0	18
+Field	17	NA
+Field	16	EX
+Field	15:14	RAZ
+Field	13:8	SIZE
+Field	7:0	N
+EndSysreg
+
 Sysreg	SPMINTENSET_EL1	2	0	9	14	1
 Field	63	P63
 Field	62	P62
-- 
2.25.1


