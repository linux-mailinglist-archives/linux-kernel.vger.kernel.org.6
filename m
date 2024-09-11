Return-Path: <linux-kernel+bounces-324454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47F63974CA9
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 10:29:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED1B228802A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 08:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35C7B16DEB3;
	Wed, 11 Sep 2024 08:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="xnhmvc8J"
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3DE14F9CC;
	Wed, 11 Sep 2024 08:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726043301; cv=none; b=nwzvTG/lCD9FKJEZ+ep9tSr2hsophtepMBE/rM6907v1wOpo0xY0U/blV5l7oaN/367MnZPSj7gtpIxq1N74aakzvmshlczelL/kWsZKD084FpY8KqmKOSgEsgJ+319L21SwzUvMSREGSILxklRyti/3qwtRhD1+ctIMtQvo7nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726043301; c=relaxed/simple;
	bh=TSUoIJxoFZuWExEyCfIbZp9QDtFVWojZrfzagLq9dLk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U83sOQJcrpmdhRYRNbP/PjSToc2KC5/oK7hQC0iK45zTUVQmBoBpkC835KevyPg5MiIrOLpBwCtbDTslhb2Jgwby6TXmZhRmFq6kkTCfL3IPLx1Kaalb6lNhH/XOdRSUkO261sTtN9AM4Iju9k1rM96i9AYlf/LNdYu3SpbawvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=xnhmvc8J; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48B5n4pL009823;
	Wed, 11 Sep 2024 10:28:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	1fdKUn1mK1VpsX7BQIy67bO9fbUNKRihyPqu7FVizg0=; b=xnhmvc8JkBw1F2Xq
	2MDxEAyxv86EpmC5T0kTvA4akY43mzWnmuEUl4SUP6aQCbSo3sqk9Z2MAoSkLT6S
	G3ndzwE70PDIQNi4Xq5P9YDKLcuXenpxlPg6IpefeENBymL3I8kvl3eSAPCHzQWF
	p0P2sJ0yqdYLWt6w0DlbfRWKhdF2WQ4tYj3yHvLYsRjjA1GcrFpMjUDtRo1Ab5Fy
	CnSALkgTS0I+fduzEUeFBxWP99WpF7qY4vZMpY8/cldLRtNCQjXXkxpskIooq2H/
	mweu4zjvTdIWkOFkGWCpCuZrzUyonIK6Pxe5+kUcNV+Byfm4O8WbRjo1XvDjn1rh
	ce7Fow==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 41gyaadhgk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Sep 2024 10:28:09 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 3C11D4002D;
	Wed, 11 Sep 2024 10:27:00 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 8015E24C429;
	Wed, 11 Sep 2024 10:26:10 +0200 (CEST)
Received: from localhost (10.129.178.212) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Wed, 11 Sep
 2024 10:26:10 +0200
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
Subject: [PATCH v6 3/5] MAINTAINERS: add entry for ST STM32MP25 COMBOPHY driver
Date: Wed, 11 Sep 2024 10:25:28 +0200
Message-ID: <20240911082530.2978336-4-christian.bruel@foss.st.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240911082530.2978336-1-christian.bruel@foss.st.com>
References: <20240911082530.2978336-1-christian.bruel@foss.st.com>
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
index a70b7c9c3533..b922a5637b16 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21931,6 +21931,12 @@ F:	arch/m68k/kernel/*sun3*
 F:	arch/m68k/sun3*/
 F:	drivers/net/ethernet/i825xx/sun3*
 
+STMICROELECTRONICS STMP32MP25 USB3/PCIE COMBOPHY DRIVER
+M:	Christian Bruel <christian.bruel@foss.st.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/phy/st,stm32mp25-combophy.yaml
+F:	drivers/phy/st/phy-stm32-combophy.c
+
 SUN4I LOW RES ADC ATTACHED TABLET KEYS DRIVER
 M:	Hans de Goede <hdegoede@redhat.com>
 L:	linux-input@vger.kernel.org
-- 
2.34.1


