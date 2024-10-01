Return-Path: <linux-kernel+bounces-345158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B951498B28A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 04:52:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 411E0285D69
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 02:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE8CA18455C;
	Tue,  1 Oct 2024 02:46:59 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8030186E50
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 02:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727750819; cv=none; b=lcFYIrzoy3jEtp8ZSI8B+12bbB8CVARnaj1fvIJ/w4qjbIxBD9FHFtssMLOM/jTTMZAuBTO9X8JAMNznLYyc1XAQkBSai+EBWQhSz9YvJMe+8e/Q+VimQc4Cfj4tOPVTy39JQoSFrFWTLG6TV38uBKQWqz/3Bn6Zc4Y9MIbS7WQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727750819; c=relaxed/simple;
	bh=4kHulIleLo7wrq2uuTN3bbXMYM955m5MTjifdw3TuF0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Z6P9dWG65+u4iItnDyXCgIx03zWaiIKGmzhXgq3901hPugD06xq9fKYToKfiPtXbiQpMhvbBujkfxQEGatq+jVbFgmVR01gXzoB6UxztNveOHH4RZ6nVL8/CC3unOb0Mulz2psk7B4BvybAKPAh/Yf7qnn6KR7gEI/sizI0FP84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A09E6DA7;
	Mon, 30 Sep 2024 19:47:25 -0700 (PDT)
Received: from a077893.blr.arm.com (a077893.blr.arm.com [10.162.16.61])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B4E373F58B;
	Mon, 30 Sep 2024 19:46:52 -0700 (PDT)
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
Subject: [PATCH 43/47] arm64/sysreg: Add register fields for SPMACCESSR_EL2
Date: Tue,  1 Oct 2024 08:13:52 +0530
Message-Id: <20241001024356.1096072-44-anshuman.khandual@arm.com>
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

This adds register fields for SPMACCESSR_EL2 as per the definitions based
on DDI0601 2024-06.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm64/tools/sysreg | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
index b464d02e5fb9..974218762525 100644
--- a/arch/arm64/tools/sysreg
+++ b/arch/arm64/tools/sysreg
@@ -657,6 +657,41 @@ Field	1	P1
 Field	0	P0
 EndSysreg
 
+Sysreg	SPMACCESSR_EL2	2	4	9	13	3
+Field	63:62	P31
+Field	61:60	P30
+Field	59:58	P29
+Field	57:56	P28
+Field	55:54	P27
+Field	53:52	P26
+Field	51:50	P25
+Field	49:48	P24
+Field	47:46	P23
+Field	45:44	P22
+Field	43:42	P21
+Field	41:40	P20
+Field	39:38	P19
+Field	37:36	P18
+Field	35:34	P17
+Field	33:32	P16
+Field	31:30	P15
+Field	29:28	P14
+Field	27:26	P13
+Field	25:24	P12
+Field	23:22	P11
+Field	21:20	P10
+Field	19:18	P9
+Field	17:16	P8
+Field	15:14	P7
+Field	13:12	P6
+Field	11:10	P5
+Field	9:8	P4
+Field	7:6	P3
+Field	5:4	P2
+Field	3:2	P1
+Field	1:0	P0
+EndSysreg
+
 Sysreg	SPMSCR_EL1	2	7	9	14	7
 Field	63:32	IMP_DEF
 Field	31	RAO
-- 
2.25.1


