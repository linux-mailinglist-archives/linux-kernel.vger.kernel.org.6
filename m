Return-Path: <linux-kernel+bounces-438909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E80A29EA843
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 06:57:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C1EA287AD7
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 05:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E4EF228371;
	Tue, 10 Dec 2024 05:55:04 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57566227B9E
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 05:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733810104; cv=none; b=Rqev7boeFEiu2N27Dis2wBffRDuU+qk99kxdPO5qpA4o0k+jx18W5HOL+nPg4tkc+h/dPkjt/1GZmZqDGc3rtFZYSKf4Cee5ajcwxuyarhPdNlWycyC+uC8hPdW8MXqryQoWGdfmmYZr2X3usB0ph7ysg6ll9+GCIUIJsK0uYXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733810104; c=relaxed/simple;
	bh=m3r2PO9cMWyQ9T7yOEAXCcSKJ8L7QGI0YXi/iqus1yU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AQmpNG5562PcTXkdMZxw/Xb0vHMYScZLlLdkSyFIKRjIcqalXEh12ZcgbO4cyeJvrxqGK7+oOseNPGhhg7Uz5wXSngTISy6yQe+KoqtuZrlFXyn2k3XcXLRPKD+UDT5OPwJRKsROmNBNdWsmx0T2sedQbdips+rjhGldM7e1OOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1386A113E;
	Mon,  9 Dec 2024 21:55:29 -0800 (PST)
Received: from a077893.arm.com (unknown [10.163.48.173])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id AF3303F58B;
	Mon,  9 Dec 2024 21:54:48 -0800 (PST)
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
Subject: [PATCH V2 19/46] arm64/sysreg: Add register fields for PMCCNTSVR_EL1
Date: Tue, 10 Dec 2024 11:22:44 +0530
Message-Id: <20241210055311.780688-20-anshuman.khandual@arm.com>
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

This adds register fields for PMCCNTSVR_EL1 as per the definitions based
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
index 462adb8031ca..00d0015d7df4 100644
--- a/arch/arm64/tools/sysreg
+++ b/arch/arm64/tools/sysreg
@@ -126,6 +126,10 @@ Field	15:8	Aff1
 Field	7:0	Aff0
 EndSysreg
 
+Sysreg	PMCCNTSVR_EL1	2	0	14	11	7
+Field	63:0	CCNT
+EndSysreg
+
 Sysreg ID_PFR0_EL1	3	0	0	1	0
 Res0	63:32
 UnsignedEnum	31:28	RAS
-- 
2.25.1


