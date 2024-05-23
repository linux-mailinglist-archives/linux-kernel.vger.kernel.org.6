Return-Path: <linux-kernel+bounces-187857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02A108CD9A2
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 20:06:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 336E31C21575
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 18:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5007682891;
	Thu, 23 May 2024 18:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="gLmirwFx"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B951378C67;
	Thu, 23 May 2024 18:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716487552; cv=none; b=qgBVJGuCJv/iXh/708oMlV2lSlQp15JdZlwVQ3nomSrQfoLajNpQyBXm6H705HkCH96m/LHBzso7xBzQZ4OWeox2HIP8tuuWPBlCAIWFy9SWYvq7UH4kPWB9Ycmkf48MsgwKVZdrn4tqAc8bZd2/iPXXZYDSocHkQ87UmqF3HAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716487552; c=relaxed/simple;
	bh=2UTj3wbkQPMghvusHM9ms1z8encqAQF5wAhxtxLe+88=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AiGMe5suBN+MJiVdUwQePnQ/d2kkYgWOrAv5nQ3MenGIBCVzjlHo/lv/HCKJMbHEw1fc1LdZ+eBlovQj4x7wab+bPHWvWvcLG758gZh111IaahA5aSO4xCrCEz/K5T2dJeLsWd8Nx5GdKmcps+1R7F1/KXx3+I+yBcmGHy8D/cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=gLmirwFx; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44NHUkvL014089;
	Thu, 23 May 2024 20:05:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	TIHHv5VnBC4M6BAYS8GF3x1yTwxcxgzzLyrVLp3iXdI=; b=gLmirwFxgIiLAdfe
	R91WJo4kgRSNfiM0C0uT10JTEamGW6JyrmCfSV0dCR0rG5GLPP9HNq39+1f7Dvlu
	HxbKtxrv0aGDrrA2gOROazR7BO9KsCPzmxz07pDXQfYsQW4bvvlGUyWSd0lM7lj+
	Xy9rotRmvUyHvQXyWlxPeLh/9i7aoB/9xkatduI/HKkAv3zYDDNl5n27eMwIbztk
	qIRxAWRLLT/8WRFVZ8NPSY2OBFaeouec53SBLtvEvMjk8574QO3XXgWyJQ3RtLj3
	Mb1FgoJCPVrFJ6/rGYJ4OuDuetDGInPxIWxNLDHIW1JA47fVcjb7PsAeG+MhZeSF
	TtFIhQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3yaa8t82hc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 May 2024 20:05:28 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 22D9F40044;
	Thu, 23 May 2024 20:05:25 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 715C221BF62;
	Thu, 23 May 2024 20:04:39 +0200 (CEST)
Received: from localhost (10.48.87.205) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 23 May
 2024 20:04:39 +0200
From: Patrick Delaunay <patrick.delaunay@foss.st.com>
To: Alexandre TORGUE <alexandre.torgue@foss.st.com>,
        Liam Girdwood
	<lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Pascal
 Paillet <p.paillet@foss.st.com>
CC: Marek Vasut <marex@denx.de>,
        Patrick Delaunay
	<patrick.delaunay@foss.st.com>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: [PATCH v4 1/2] dt-bindings: regulator: st,stm32mp1-pwr-reg: add compatible for STM32MP13
Date: Thu, 23 May 2024 20:04:33 +0200
Message-ID: <20240523200353.v4.1.Ia0a99d90acb512aa020a6e7a8cca8cc1b71f1759@changeid>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240523180435.583257-1-patrick.delaunay@foss.st.com>
References: <20240523180435.583257-1-patrick.delaunay@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-23_11,2024-05-23_01,2024-05-17_01

Add new compatible "st,stm32mp13-pwr-reg" for STM32MP13 SoC family.

Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
---

Changes in v4:
- use fallback as proposed by Marek on V3 for STM32MP13:
  compatible = "st,stm32mp13-pwr-reg", "st,stm32mp1,pwr-reg"

Changes in v3:
- Replace oneOf/const by enum; solve the V2 issues for dt_binding_check

Changes in v2:
- update for Rob review, only add compatible for STM32MP13 family

 .../devicetree/bindings/regulator/st,stm32mp1-pwr-reg.yaml | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/regulator/st,stm32mp1-pwr-reg.yaml b/Documentation/devicetree/bindings/regulator/st,stm32mp1-pwr-reg.yaml
index c9586d277f41..3cb2dad18781 100644
--- a/Documentation/devicetree/bindings/regulator/st,stm32mp1-pwr-reg.yaml
+++ b/Documentation/devicetree/bindings/regulator/st,stm32mp1-pwr-reg.yaml
@@ -11,7 +11,12 @@ maintainers:
 
 properties:
   compatible:
-    const: st,stm32mp1,pwr-reg
+    oneOf:
+      - items:
+          - const: st,stm32mp1,pwr-reg
+      - items:
+          - const: st,stm32mp13-pwr-reg
+          - const: st,stm32mp1,pwr-reg
 
   reg:
     maxItems: 1
-- 
2.25.1


