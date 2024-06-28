Return-Path: <linux-kernel+bounces-233640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5775B91BA9A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 11:00:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87B3E1C23BCB
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 09:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A593714E2E2;
	Fri, 28 Jun 2024 08:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="a/juoRNW"
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318F5150996;
	Fri, 28 Jun 2024 08:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719565174; cv=none; b=KlrFw8gAW+2w/c9FE7ancXmE4BNf6wdJlkgFQK7OrgP60UrJgR5m1peEzfUWYGSeiqeZp0dBLULs4WSccaX/png/Sqy8rN0QErioekRJ/nZXrnUYlkCD1PIszrdNThIphJcS+MgW2SUmH0dAGJwxc5n7kU11Q+grr8s0f+tgS8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719565174; c=relaxed/simple;
	bh=+w4Yz/ZaM+lGunuI6paSxIckwQy8JHS2c8fwmVwsTHE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Uanu3fp3SfoWuX2qEEWT7ZwmB+F+ZuyjS9RZmzcqeywEXTrIwYL2H6f0QerBFN68tsZw+MWHFFnmYUYEBi4ng+3cgcPws9cJXdEc9sP5vvIhgEvHuHNN2mIGFaqI4uvKg4n4j5V5KIgZtD9m7YHrKki96pf9KaYqivCn2jARvZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=a/juoRNW; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45S143JW022309;
	Fri, 28 Jun 2024 10:59:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	c+iZHm8zx6LxaqkfrOvGEiThh6zj8iGmK/s1bGa2eq4=; b=a/juoRNWpWnBP1Lv
	en8bcNKUlMxBZSsHoqPl17J8BmWVuSXIrUeloERkVNxCxfxq1Khzmap5pc7o5tZN
	gGa8nq7xAXA3e+QRANL+Y3vMkPdffv7Pj17L3ntUzoz3en6qaSbrrz2ed8Dx+O2+
	8tyjxIWnyee45lIEGMpqM3YmD8nL7owJqt+ygLvGd8txhrkUkoCBBTXg+5o3mqjt
	M1Zrp9H5PiKaxkFVwea71IdcFzmAdRTSnPBBRdTYxskR85OBilS2bPks9MpHtKrx
	uYeS9rPvr/YQs/6Af3BvOpw7mxNq6+imGD+BIgCPiFA6b9ZkZEjkd+0FHFBgpkkI
	gWWdEw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3yx9jjpgct-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Jun 2024 10:59:15 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 18DCB40045;
	Fri, 28 Jun 2024 10:59:11 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id B1F8521ADBF;
	Fri, 28 Jun 2024 10:58:22 +0200 (CEST)
Received: from localhost (10.252.26.109) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 28 Jun
 2024 10:58:22 +0200
From: Pascal Paillet <p.paillet@foss.st.com>
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
CC: <p.paillet@foss.st.com>, Etienne Carriere <etienne.carriere@foss.st.com>
Subject: [PATCH v2 4/4] arm64: stm32: enable scmi regulator for stm32
Date: Fri, 28 Jun 2024 10:58:14 +0200
Message-ID: <20240628085814.1586186-5-p.paillet@foss.st.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240628085814.1586186-1-p.paillet@foss.st.com>
References: <20240628085814.1586186-1-p.paillet@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-28_05,2024-06-28_01,2024-05-17_01

Add SCMI ARM REGULATOR configuration for stm32.

Signed-off-by: Pascal Paillet <p.paillet@foss.st.com>
---
 arch/arm64/Kconfig.platforms | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index a52618073de2..3738a9fc2d6c 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -312,6 +312,8 @@ config ARCH_STM32
 	select STM32_EXTI
 	select ARM_SMC_MBOX
 	select ARM_SCMI_PROTOCOL
+	select REGULATOR
+	select REGULATOR_ARM_SCMI
 	select COMMON_CLK_SCMI
 	select STM32_FIREWALL
 	help
-- 
2.34.1


