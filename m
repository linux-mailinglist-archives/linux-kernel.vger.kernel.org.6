Return-Path: <linux-kernel+bounces-233636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 250C791BA93
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 10:59:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C298A1F22F97
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 08:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD59D14EC4B;
	Fri, 28 Jun 2024 08:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="70iyAEbF"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9825414AD35;
	Fri, 28 Jun 2024 08:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719565168; cv=none; b=N5spoHt5pm9tX+i3aUTbDY3P8+j7oDQ9LcogXb7pycACldzLPwB+d7U3HgToDGPRhEOB1BapCw169aKhtfFPtCR36w5RvbWh+ZidqV+3frPRpnHmvpMuA1TskQqyh7pYHQ1Tr9Fm22v8eA5+Bvgw1uDXfoJhJLTgfnAdbA1oTPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719565168; c=relaxed/simple;
	bh=nauwjGmdLFNccHeQD8Fy+29KCvxwz7v+YNM+sNggz9I=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LfnA17gE3r+E3bdoBNs5ci3eeP/d48GSpJ6n6VOXnBmuik859bkEF2g/BO8h8umazVPxJgWcU1s4Q3TiRr8SNVoGCmixaMFS+rWD8ulFUJhKr3OKmJWvaSvjSICaP88vGZ1eyJbCeQSlCvLzY9B9nUia7phJh07tW5JTAjolNcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=70iyAEbF; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45S11DVo008505;
	Fri, 28 Jun 2024 10:58:58 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=selector1; bh=VTjohtlLmp5i0WMDdkVZHk
	SydQAA4BiVavYseaicg8k=; b=70iyAEbFId9824zmG45vv9SqcfTCljzA16IH/e
	a7XVsE3881PKA9lNo0CDfVR/pao6bdK0o9UoIfqtWa0lrkhXfk3LfafAglCmocnz
	atn9Ps9CmkCH4ppBfoP9masSWij+foE+sQX9Pcu0YNDmlifXxHIZZsAEoq8zfOWK
	PXWFyYQas2T5N/a2y+VJkvqTvBKxm8fria3VM3mw4NuowxReuy4c0pdVLA/7FoqI
	QbbcYwsAoAG8hxqwJ0rLloAGtuKGy+HIT7aQuaKYwSQckyIzcVsDVuaVZEoN9KFp
	l8h/Sn62GeRu25zNNqdfe+0/pMWKBc4kav7xXKKx9on5nTNg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3ywnxxs3nj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Jun 2024 10:58:58 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 1BE0E40045;
	Fri, 28 Jun 2024 10:58:53 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 6106821ADB6;
	Fri, 28 Jun 2024 10:58:21 +0200 (CEST)
Received: from localhost (10.252.26.109) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 28 Jun
 2024 10:58:19 +0200
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
Subject: [PATCH v2 0/4] Add SCMI regulators desciption on STM32MP25
Date: Fri, 28 Jun 2024 10:58:10 +0200
Message-ID: <20240628085814.1586186-1-p.paillet@foss.st.com>
X-Mailer: git-send-email 2.34.1
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

Add the description for SCMI regulators provided by OP-TEE firmware.
The binding file named st,stm32mp25-regulator.h will be also used in
the OP-TEE firmware.

Changes in v2:
 - fix regulator binding commit title in patch 0001
 - add regulator selection for stm32 in patch 0004

Pascal Paillet (4):
  regulators: dt-bindings: add STM32MP25 regulator bindings
  arm64: dts: st: add scmi regulators on stm32mp25
  arm64: dts: st: describe power supplies for stm32mp257f-ev1 board
  arm64: stm32: enable scmi regulator for stm32

 arch/arm64/Kconfig.platforms                  |  2 +
 arch/arm64/boot/dts/st/stm32mp251.dtsi        | 35 ++++++++++++++
 arch/arm64/boot/dts/st/stm32mp257f-ev1.dts    | 43 +++++++++++++----
 .../regulator/st,stm32mp25-regulator.h        | 48 +++++++++++++++++++
 4 files changed, 119 insertions(+), 9 deletions(-)
 create mode 100644 include/dt-bindings/regulator/st,stm32mp25-regulator.h

-- 
2.34.1


