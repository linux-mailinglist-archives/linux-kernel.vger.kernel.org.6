Return-Path: <linux-kernel+bounces-345153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41DEF98B285
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 04:51:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 354BE1C2542D
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 02:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C0A81A3BD3;
	Tue,  1 Oct 2024 02:46:42 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E59B175D36
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 02:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727750801; cv=none; b=owtIIay9KzojfdxTwp+esyW7cII0a72aH9FxE6AMP13Wr5pORP2eQvyZvat8UqJCHZsJPzZxpRi+8YH543aYYolHoKrAPquffY0bPzUbjk2NSsh0vjBKYXO7WftBGBjggGth1IeVhBNFbK/6Fxiqwmd7A9zQkzOIxgvQ4tT35Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727750801; c=relaxed/simple;
	bh=8euke0Pyg6fNNprpVG35CncQYJaSm5+HM39YFbVmpGU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=V1aXlWOmf35ZPKHNH5iCVbrQrqm7jvJqdybHcHVR5RgKKb4/P9tTPBEsC+W/xpoG2vf98o69NGGeDQLUG/PMYKgheDhfCogV+RBw6O+FscNm4s9F6IfAKBD3MiNL2eDPrbHP2f64A/TvX2k46MKhD04bedcnTVJUXxIwETKxdcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C4DA9367;
	Mon, 30 Sep 2024 19:47:09 -0700 (PDT)
Received: from a077893.blr.arm.com (a077893.blr.arm.com [10.162.16.61])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D3A873F58B;
	Mon, 30 Sep 2024 19:46:36 -0700 (PDT)
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
Subject: [PATCH 39/47] arm64/sysreg: Add register fields for SPMCGCR0_EL1
Date: Tue,  1 Oct 2024 08:13:48 +0530
Message-Id: <20241001024356.1096072-40-anshuman.khandual@arm.com>
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

This adds register fields for SPMCGCR0_EL1 as per the definitions based
on DDI0601 2024-06.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm64/tools/sysreg | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
index 020fda4fbd9b..50397a1a5799 100644
--- a/arch/arm64/tools/sysreg
+++ b/arch/arm64/tools/sysreg
@@ -114,6 +114,21 @@ Res0	63:1
 Field	0	OSLK
 EndSysreg
 
+SysregFields	SPMCGCRx_EL1
+Field	63:56	N7
+Field	55:48	N6
+Field	47:40	N5
+Field	39:32	N4
+Field	31:24	N3
+Field	23:16	N2
+Field	15:8	N1
+Field	7:0	N0
+EndSysregFields
+
+Sysreg	SPMCGCR0_EL1	2	0	9	13	0
+Fields	SPMCGCRx_EL1
+EndSysreg
+
 Sysreg	SPMACCESSR_EL1	2	0	9	13	3
 Field	63:62	P31
 Field	61:60	P30
-- 
2.25.1


