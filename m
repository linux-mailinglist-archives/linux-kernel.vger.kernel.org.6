Return-Path: <linux-kernel+bounces-438891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A23BF9EA830
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 06:53:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A709280CA8
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 05:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D798C227598;
	Tue, 10 Dec 2024 05:53:30 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CD50227576
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 05:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733810010; cv=none; b=uTWThW15u6TwsnUse5lbWVY6le7DcoACSgRWOAXoCbVGzYIy/ll2wSSsx2A7K6txEBmns9bk5a+RyzJt4n2zotRiFKe89+U7jYUb/Y0Qir+C1y1TASNmF4sdqZHjfwzQdKpv9nBMRRZjHBENje9l/m6CJmm5cIjLzzcVNR3x4qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733810010; c=relaxed/simple;
	bh=MSbLU1/0OzuEZ7Pc//TooBI5NPs3zWHPJshr6l+p4kw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=irA2+4UsD0eJmR76jfHTZ+j4zJBaY+E0DAJTBv7cUUZnX+pbKPJnsTV7/r0diHyRiaauh5oMJ9h4p4nAShsA4amYYX54I8x3xfjagrlw3LFqAERQDBCRQPYOC6WOS/+90HgIYbZJUpLIZldeKKXyjAJSs0MANZQfQr3zoj6KmWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6AE8B113E;
	Mon,  9 Dec 2024 21:53:56 -0800 (PST)
Received: from a077893.arm.com (unknown [10.163.48.173])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1CC0B3F58B;
	Mon,  9 Dec 2024 21:53:23 -0800 (PST)
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
Subject: [PATCH V2 01/46] arm64/sysreg: Update register fields for ID_AA64MMFR0_EL1
Date: Tue, 10 Dec 2024 11:22:26 +0530
Message-Id: <20241210055311.780688-2-anshuman.khandual@arm.com>
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

This updates ID_AA64MMFR0_EL1.FGT and ID_AA64MMFR0_EL1.PARANGE register
fields as per the definitions based on DDI0601 2024-09.

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
index b081b54d6d22..a6cbe0dcd63b 100644
--- a/arch/arm64/tools/sysreg
+++ b/arch/arm64/tools/sysreg
@@ -1591,6 +1591,7 @@ EndEnum
 UnsignedEnum	59:56	FGT
 	0b0000	NI
 	0b0001	IMP
+	0b0010	FGT2
 EndEnum
 Res0	55:48
 UnsignedEnum	47:44	EXS
@@ -1652,6 +1653,7 @@ Enum	3:0	PARANGE
 	0b0100	44
 	0b0101	48
 	0b0110	52
+	0b0111	56
 EndEnum
 EndSysreg
 
-- 
2.25.1


