Return-Path: <linux-kernel+bounces-345142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71A8298B27A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 04:49:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27DC9286273
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 02:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A26041A255E;
	Tue,  1 Oct 2024 02:45:58 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A0F21A2563
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 02:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727750758; cv=none; b=JfdKxg55J4F9c9u6iTs9Lq9nP9IalFG0teFfUSgIDPDmA3lnFU7q0cYHkoTh2CvF4Uek/4cdpBatf3RwrloaahSC3oVXKqtq778Srd/2QVDXgNbOALlWm/e6WxbkdlgXzIh4uHqMgo3Yea0+F4OkvVuYLTlI8xp6o4Db2axnPo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727750758; c=relaxed/simple;
	bh=XJe7RQF6fg9aFZh4nLFYUKte66aBl4qGde+CDtOwU3o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=i0EMoFTyXsifUuEY1Odvl38COqb943NrYgKCT5lpmayzJOH1k9OWZaJcQ6scSOcMb+2wrMwSyNPOTHf7oKF7/FPBkLIlrqp9EYthSZq7ZJQfFww5r8WUIkG76uHYGAg5nOZpMzLq8eKTxOUuAqXAFBbgfeGejHfnE7V9vkkv7s4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 16A82367;
	Mon, 30 Sep 2024 19:46:26 -0700 (PDT)
Received: from a077893.blr.arm.com (a077893.blr.arm.com [10.162.16.61])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2F1413F58B;
	Mon, 30 Sep 2024 19:45:52 -0700 (PDT)
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
Subject: [PATCH 28/47] arm64/sysreg: Add register fields for SPMINTENCLR_EL1
Date: Tue,  1 Oct 2024 08:13:37 +0530
Message-Id: <20241001024356.1096072-29-anshuman.khandual@arm.com>
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

This adds register fields for SPMINTENCLR_EL1 as per the definitions based
on DDI0601 2024-06.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm64/tools/sysreg | 67 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
index 6086fcced8cf..6c2696640083 100644
--- a/arch/arm64/tools/sysreg
+++ b/arch/arm64/tools/sysreg
@@ -161,6 +161,73 @@ Field	15:8	Aff1
 Field	7:0	Aff0
 EndSysreg
 
+Sysreg	SPMINTENCLR_EL1	2	0	9	14	2
+Field	63	P63
+Field	62	P62
+Field	61	P61
+Field	60	P60
+Field	59	P59
+Field	58	P58
+Field	57	P57
+Field	56	P56
+Field	55	P55
+Field	54	P54
+Field	53	P53
+Field	52	P52
+Field	51	P51
+Field	50	P50
+Field	49	P49
+Field	48	P48
+Field	47	P47
+Field	46	P46
+Field	45	P45
+Field	44	P44
+Field	43	P43
+Field	42	P42
+Field	41	P41
+Field	40	P40
+Field	39	P39
+Field	38	P38
+Field	37	P37
+Field	36	P36
+Field	35	P35
+Field	34	P34
+Field	33	P33
+Field	32	P32
+Field	31	P31
+Field	30	P30
+Field	29	P29
+Field	28	P28
+Field	27	P27
+Field	26	P26
+Field	25	P25
+Field	24	P24
+Field	23	P23
+Field	22	P22
+Field	21	P21
+Field	20	P20
+Field	19	P19
+Field	18	P18
+Field	17	P17
+Field	16	P16
+Field	15	P15
+Field	14	P14
+Field	13	P13
+Field	12	P12
+Field	11	P11
+Field	10	P10
+Field	9	P9
+Field	8	P8
+Field	7	P7
+Field	6	P6
+Field	5	P5
+Field	4	P4
+Field	3	P3
+Field	2	P2
+Field	1	P1
+Field	0	P0
+EndSysreg
+
 Sysreg	PMCCNTSVR_EL1	2	0	14	11	7
 Field	63:0	CCNT
 EndSysreg
-- 
2.25.1


