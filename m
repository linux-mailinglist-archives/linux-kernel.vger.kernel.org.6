Return-Path: <linux-kernel+bounces-549467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30F18A552EF
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 18:23:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4EE13AE47E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 17:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA8E225D541;
	Thu,  6 Mar 2025 17:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="lkKpOT/w"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408C325D522;
	Thu,  6 Mar 2025 17:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741281745; cv=none; b=D1QdIBSB8gNsBMLtRDYyLv1CWM37101WGm3TM5IABaybIHCP3cQj2WjmEpV6cHp2wSQo/WSwZNpmTS028Z9wRdFz3Qj28cg2gbkiIzlYCbWZRARJK1mr+hIA0M6eZlkTpVFhkktKjAcvU5G6ubxeaamdX8Fj7vLY6d3gs/S+n58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741281745; c=relaxed/simple;
	bh=IOhRCA/DyJBGMbZ8hUbAZZk2HebTGwPUk1oPUtVBlfs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c/8DErOta/WUC4273fVogteMF0oK9ANEcshJxYBGWw0ucNwBtzZETOXnBFGk6pUs/skaU6JWt0bI0faQr9YBTdfqdvkQfQeND/v7ev7C5lkwmXeQ/yyd9pUnGSmj/sSO2YFveOR87bQaw7qICzuF7+vSiF1wGjp3+CokiVJO5Xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=lkKpOT/w; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 526Gv4Kv023582;
	Thu, 6 Mar 2025 18:22:11 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	QGqcjvvOtCGaNoLEVOIiJ6HpiC2CtjcBe7GSdx0rGbE=; b=lkKpOT/wczIoV6T6
	elVq4VHeVL2QQcBYK9UPk0LWvGCgGHzu1ZhjiJgRMfN51+I2b+pof7/7NnQ7NHrL
	Y/gy0VNGhorLsVfeuNRl0W2wpSDeUSoaglwXlp1pcTDYc911pslmdRaQ7SNr5fSB
	j3GzUyIeFhuC1WNN3zlK5hQJhrt+xnYOo6dfGzSqtkoAp373PTPZSTFtyNjJUxLA
	vQ4m4eb/hv8lNsQmZqzW+uwFSKrIqnq+dAxPc/WBqVlyAVH6DCJ7QlX1jRuiOPHV
	RHKwqal6E80mnJKnE6s1ySimE2Zfb0mthdLaqsakJTf1+PlWZ3NE2kPAkTT67fil
	96louw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 457dr0h89n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Mar 2025 18:22:11 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id B0EF640076;
	Thu,  6 Mar 2025 18:21:22 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 747A35B9D78;
	Thu,  6 Mar 2025 18:18:49 +0100 (CET)
Received: from localhost (10.252.22.44) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 6 Mar
 2025 18:18:49 +0100
From: Olivier Moysan <olivier.moysan@foss.st.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Rob
 Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor
 Dooley <conor+dt@kernel.org>,
        Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
CC: Olivier Moysan <olivier.moysan@foss.st.com>, <linux-sound@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] ASoC: dt-bindings: add regulator support to dmic codec
Date: Thu, 6 Mar 2025 18:18:39 +0100
Message-ID: <20250306171840.593443-2-olivier.moysan@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250306171840.593443-1-olivier.moysan@foss.st.com>
References: <20250306171840.593443-1-olivier.moysan@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-06_05,2025-03-06_01,2024-11-22_01

Add optional vref-supply property to describe the regulator supplying
the digital microphones.

Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
---
 Documentation/devicetree/bindings/sound/dmic-codec.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/dmic-codec.yaml b/Documentation/devicetree/bindings/sound/dmic-codec.yaml
index 59ef0cf6b6e5..cc3c84dd4c26 100644
--- a/Documentation/devicetree/bindings/sound/dmic-codec.yaml
+++ b/Documentation/devicetree/bindings/sound/dmic-codec.yaml
@@ -19,6 +19,9 @@ properties:
   '#sound-dai-cells':
     const: 0
 
+  vref-supply:
+    description: Phandle to the digital microphone reference supply
+
   dmicen-gpios:
     description: GPIO specifier for DMIC to control start and stop
     maxItems: 1
-- 
2.25.1


