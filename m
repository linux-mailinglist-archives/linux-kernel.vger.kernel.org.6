Return-Path: <linux-kernel+bounces-324705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2474974FF1
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 12:42:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D61FB1C21D6C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 10:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E7AC186E23;
	Wed, 11 Sep 2024 10:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="0Ydb+mx3"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2612E17C7C4;
	Wed, 11 Sep 2024 10:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726051306; cv=none; b=MQP73JYQ0GTVdjFFRaOp0uVLkhUSR8krFTL6PeokmgtY385IZnhjO8UwC8P5YF872MMnOpPp0WBClMRavXIsQ7cVieWGFqq4Hp2uu8t8WWuh7axtItkbiSqdIC0RISztEGmAx1D+LEWquOLDIIUgedxssiVzf2+wJS/XvHe5WHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726051306; c=relaxed/simple;
	bh=dFUaXVsG/0ONXTnVumLo/zW4NyJsvapnyuNLHKSBWKI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WHx1PZBWE1oJNcq78Ipx8Lq8vp0S+CO3iZV0TMF93y53+qxm1NbnORFmbTw8Rn4STeJb/ufxU1o+TI37uztZNoABtEyEVMi9jhsG4sw9V9c99Z0cMkZPF3IhUA7p+r0cCmix6GtxQFGr3qVUaG1G4jWeWuJlY7ySfGGcGwGnsAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=0Ydb+mx3; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48B7XB99023068;
	Wed, 11 Sep 2024 12:41:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	eLuX/nQPhWf6ErbXXxR1BMAo/biD0EaZBl6867u6jMo=; b=0Ydb+mx381RjNRdB
	ZbdD8cxbwbs2px1sa/IxO3pBmMMDTjmIhRah0ZeypLuUl/HKy2/p2xbanryUeMFe
	QvVhLPWbZQ6X9p4lazBbk76PYH0KENonpkssIZyZcjDigu8t9y2wmSZYAuY0LVRP
	BTUN8qRDEE19Go31zPfuKS1Ebfba6mKw5Tp/QtWBj3AgnsHfpJAy/A7QqsyXLFAn
	f0uf7Qbhl1HCX29XdSIW4tTcErAmOsgrfiWLbpK+diPUn0SQkb9sujcEsijELBkK
	7oQgFdtsC8Hdh0ICdND0BkjdkhVCU3faY5fCP70eY2K+5TbYj4Aahujj9tp5Ilqt
	16BKlw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 41h0cypbah-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Sep 2024 12:41:25 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 39B73400BA;
	Wed, 11 Sep 2024 12:40:16 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 12CE4265095;
	Wed, 11 Sep 2024 12:37:41 +0200 (CEST)
Received: from localhost (10.129.178.212) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Wed, 11 Sep
 2024 12:37:40 +0200
From: Christian Bruel <christian.bruel@foss.st.com>
To: <vkoul@kernel.org>, <kishon@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@foss.st.com>,
        <p.zabel@pengutronix.de>
CC: <linux-phy@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <fabrice.gasnier@foss.st.com>,
        Christian Bruel <christian.bruel@foss.st.com>
Subject: [PATCH v7 3/5] MAINTAINERS: add entry for ST STM32MP25 COMBOPHY driver
Date: Wed, 11 Sep 2024 12:37:27 +0200
Message-ID: <20240911103729.2980431-4-christian.bruel@foss.st.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240911103729.2980431-1-christian.bruel@foss.st.com>
References: <20240911103729.2980431-1-christian.bruel@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

Add myself as STM32MP25 COMBOPHY maintainer

Signed-off-by: Christian Bruel <christian.bruel@foss.st.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index a70b7c9c3533..abcb5e4c5324 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21908,6 +21908,12 @@ F:	drivers/*/stm32-*timer*
 F:	drivers/pwm/pwm-stm32*
 F:	include/linux/*/stm32-*tim*
 
+STMP32MP25 USB3/PCIE COMBOPHY DRIVER
+M:	Christian Bruel <christian.bruel@foss.st.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/phy/st,stm32mp25-combophy.yaml
+F:	drivers/phy/st/phy-stm32-combophy.c
+
 STMMAC ETHERNET DRIVER
 M:	Alexandre Torgue <alexandre.torgue@foss.st.com>
 M:	Jose Abreu <joabreu@synopsys.com>
-- 
2.34.1


