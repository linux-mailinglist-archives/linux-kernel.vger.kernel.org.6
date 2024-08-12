Return-Path: <linux-kernel+bounces-283049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B9E294EC59
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 14:07:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B0CFB22631
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 12:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B84D17839B;
	Mon, 12 Aug 2024 12:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="oeXWPxB2"
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A481366;
	Mon, 12 Aug 2024 12:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723464455; cv=none; b=QCJTwHyKUSAf8Q2m1sfQb/Oilp1EjIQTqP/L7d4Z/XCH7fpZeT24Ha/oOr0E76k/KP8AceAzHKcFjLxf87dIubgpqHAIb8f+/Ig4WLlqVLbffJgVuoYRC8QIm2CQySeq9TZ4oZS2T7DFDCJ72MwlGz7uBnGD3F2NkYVnDxMoXFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723464455; c=relaxed/simple;
	bh=Xo1rGXTVLdXeeCDNYUfNknjUgZBSmEXVe4Kv6Njcv6E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pxfQstnkXHU7kTF/p3uOa5F2tXI9E2irgBpvQGvLYAcXaEwGXV30iPr4J0nogS6lmfXJGpdc0rOL0J+BHS4pUFz7ohqUVFBPVeivrwjC6tOgRyXAGaZsVMufrLBv5vlxXnPi6K3yTiQug89wTiwsqffeQjBZXMtWy/hwQrH2IKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=oeXWPxB2; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47C8C6F0020315;
	Mon, 12 Aug 2024 14:07:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	hTGGJf1xrP8/mXE2sYPwE92h+HI1SDxZubRutBlQ/GA=; b=oeXWPxB2sYxOVlrG
	m5BB/+E88cqO3UaCWU2beVL3XBDPiM+sw2pxQ3nwOcWWvnKbVOWxCDuGyYGA+72f
	4/etw91pOmtlqOWF9chSHIH63HIPEqSmzLLTPFW1RCpY1z3TLH1Tp+mffoP7nv6g
	4hVN+i8bGW0fNVIY4fCgfssaosbaA/nOYj/pnuHy4+G79uAq7HPhR4FBpENSyLDr
	0VgvroCADP13mMaplvQObrXh9cGmZZZ8IQeb+KoikDM+mPMJC+6Y1qcn3Argjuq/
	aVxXvsNbVD1lOXh5G2ueCLU6UgJPUMdYWftcwPwstH/T5TWDrxGbDg6lkXvp3hRN
	f6tZnQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 40x15f6a2a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Aug 2024 14:07:02 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 4795B40046;
	Mon, 12 Aug 2024 14:06:58 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id E70EE25AF05;
	Mon, 12 Aug 2024 14:06:09 +0200 (CEST)
Received: from localhost (10.129.178.198) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Mon, 12 Aug
 2024 14:06:09 +0200
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
Subject: [PATCH 1/5] MAINTAINERS: add entry for ST STM32MP25 COMBOPHY driver
Date: Mon, 12 Aug 2024 14:05:25 +0200
Message-ID: <20240812120529.3564390-2-christian.bruel@foss.st.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240812120529.3564390-1-christian.bruel@foss.st.com>
References: <20240812120529.3564390-1-christian.bruel@foss.st.com>
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
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-12_02,2024-08-12_01,2024-05-17_01

Add myself as STM32MP25 COMBOPHY maintainer

Signed-off-by: Christian Bruel <christian.bruel@foss.st.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index f328373463b0d..258fb57ccff58 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21910,6 +21910,12 @@ F:	arch/m68k/kernel/*sun3*
 F:	arch/m68k/sun3*/
 F:	drivers/net/ethernet/i825xx/sun3*
 
+STMICROELECTRONICS STMP32MP25 USB3/PCIE COMBOPHY DRIVER
+M:	Christian Bruel <christian.bruel@foss.st.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/phy/st,stm32-combophy.yaml
+F:	drivers/phy/st/phy-stm32-combophy.c
+
 SUN4I LOW RES ADC ATTACHED TABLET KEYS DRIVER
 M:	Hans de Goede <hdegoede@redhat.com>
 L:	linux-input@vger.kernel.org
-- 
2.34.1


