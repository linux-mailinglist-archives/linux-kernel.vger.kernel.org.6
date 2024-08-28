Return-Path: <linux-kernel+bounces-305159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45409962A66
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 16:37:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9A971F253AC
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 14:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28DA719E802;
	Wed, 28 Aug 2024 14:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="d6Ck69EJ"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA9C16CD23;
	Wed, 28 Aug 2024 14:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724855859; cv=none; b=rMTlR9S5FlQXVD1IzfhRl0TzDb2tCMVhFAvLfjg0ihzJ9mIAEHRW/yxmR3QQY/nEQ74uYJQAqI+KcN4jnC3iHRUAm78DrrZL7wfFuj2UGiWrN/3lvz5M/lMCNd8Ou+rf0BE6Ix40+1sOOmdOxl0PV/eV7MbH400YTsUVPqjAQyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724855859; c=relaxed/simple;
	bh=vhiwPFDwZPoMT5uUsK6BaUXqBzSYidzgs9I+cwkEGkk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LJUYEjc3W84TJpMJCYyiuAK1DNCZovbcHyLhrpEeXbfBnvyj/5AfNTUwcGfqb7Dni8FYxq8AGyvr33xAV/uMet5I0/TEmYAuBuPMkhSbpa5OiRY2OO4Py4Gyt0KY+mLvxHk4xKILIKVOo7JTfG8x/LSSDey/rrMqnuiTvXkXHxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=d6Ck69EJ; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47SDcCfo022823;
	Wed, 28 Aug 2024 16:37:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	ck4s9sjzRdFKY2yhhiCmjDcHrYqvSsSnJL3gyw79cpI=; b=d6Ck69EJgH4Hi8VP
	oFGQKmRMaYpJ7jhMcHd2BpspEApjVTSi/x1J9WlPcQE0Ii8+QVDBJ3hZycdtMDNS
	ChrdUyaINUyfOqam7Jzn0MZq+cR1+MaxJCBBfNp3YWE2WaJ2cdVy+zqNMHRzsDAF
	AObsUk/sk3gfH+ghntKqDSFHK9dw+xBNUXZ3i2R+GVmZhiJi2nMXIGuUOHMA964Y
	1zkbfNZI57VjsI0/KLwOt7GkzWZCKaWDpLgh2qP756gao/Vo8kOvnIwP4UY7zHhY
	5ueFFGhfP26d7UOT37MAjYjKZpVO5wGUFTZ3khvnGY2sjsoXsFyL9CdftjmFxk2m
	hExK1g==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 41a4y00b4n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Aug 2024 16:37:16 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 9F3864002D;
	Wed, 28 Aug 2024 16:37:12 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id EAA9B26F247;
	Wed, 28 Aug 2024 16:36:25 +0200 (CEST)
Received: from localhost (10.129.178.212) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Wed, 28 Aug
 2024 16:36:25 +0200
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
Subject: [PATCH v4 3/5] MAINTAINERS: add entry for ST STM32MP25 COMBOPHY driver
Date: Wed, 28 Aug 2024 16:34:50 +0200
Message-ID: <20240828143452.1407532-4-christian.bruel@foss.st.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240828143452.1407532-1-christian.bruel@foss.st.com>
References: <20240828143452.1407532-1-christian.bruel@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-28_05,2024-08-27_01,2024-05-17_01

Add myself as STM32MP25 COMBOPHY maintainer

Signed-off-by: Christian Bruel <christian.bruel@foss.st.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index f328373463b0..4dc304ba6f90 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21910,6 +21910,12 @@ F:	arch/m68k/kernel/*sun3*
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


