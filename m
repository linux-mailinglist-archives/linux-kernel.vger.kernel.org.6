Return-Path: <linux-kernel+bounces-396532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61A639BCE8F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 15:03:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DFBC5B20CBD
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 14:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E6251D86C7;
	Tue,  5 Nov 2024 14:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="LBb2SK2r"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC501D5160;
	Tue,  5 Nov 2024 14:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730815390; cv=none; b=WOaVux1rDvSxRYWpr48V2qp10mMjbgvMKDGbVyPWrINOPRB41yzV2AVK0xXJQP55WyiXlerdhM8J5kFw51WyirN0ecXoqz5ZzydtRY1oX0tw4FeOeXAGmR7EHEVdrWeu316POp6z5ErMELyJ6z90q65GoTGe1VXa0eC89bave9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730815390; c=relaxed/simple;
	bh=aAgUOU83++1ubqUQLjYI1QfRmHl6jjFqID+xsFAHSW4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aWSfso6H/eWJFfIQx3EwMJmNZVSFM56MMlvUW5CN5JBCeVWjyg1bxICtVkzBLUMs6iTS/WCPz7yh2I+1+Hmg/JK917fhaqwoKTj5JqWcmtJ2LMn9NG2wlkh000freVpEjQRcwfKwMVAtYMGxjkqmWg8MTegpC4vIopPHiLxp4/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=LBb2SK2r; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A5DY4vk006828;
	Tue, 5 Nov 2024 15:02:42 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=selector1; bh=r0pX1FHgLqkdgm4Z0bWZbm
	zE7jup2PMJjNG85lq5xOw=; b=LBb2SK2rgGAzRdzHeWVMVj5wUrFOVcCj4SebnD
	0YjsgEzAP5ZgAP/n0I8FIcSrOD2h1muBRAcXkAgqBlkauf7r8q+SEviZGTuV2ftI
	uLKulkkQoi74lrGQwYTCObro85lYQTeR3scvvrsNrzNk/prb3uPDRpnWNvuGpYd6
	Bu31CkevEqmAXPAjeQiMzJGWDihzgew4S1BshrCAXr46cAm15N6ZBVdVBmsQYcc2
	pgUIhp9EGsLHVZibfJnPX1dfHLVT6GOyWA1JdL8JenhyZLagv/e3sNe2lCN0fRzp
	FhflMwuRzWUIY0aSrcyPRMgMKJu2LahlJJgasPs2ieP/gJ+Q==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 42ncxbvpm2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Nov 2024 15:02:42 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 8680940064;
	Tue,  5 Nov 2024 15:01:37 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 19ECB2676C6;
	Tue,  5 Nov 2024 15:00:15 +0100 (CET)
Received: from localhost (10.252.16.126) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Tue, 5 Nov
 2024 15:00:14 +0100
From: Olivier Moysan <olivier.moysan@foss.st.com>
To: Olivier Moysan <olivier.moysan@foss.st.com>,
        Arnaud Pouliquen
	<arnaud.pouliquen@foss.st.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark
 Brown <broonie@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime
 Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue
	<alexandre.torgue@foss.st.com>
CC: <linux-sound@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] ASoC: dt-bindings: stm32: add missing port property
Date: Tue, 5 Nov 2024 14:59:41 +0100
Message-ID: <20241105135942.526624-1-olivier.moysan@foss.st.com>
X-Mailer: git-send-email 2.25.1
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
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

Add missing port property in STM32 SPDIFRX binding.
This will prevent potential warning:
Unevaluated properties are not allowed ('port' was unexpected)

Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
---
 Documentation/devicetree/bindings/sound/st,stm32-spdifrx.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/st,stm32-spdifrx.yaml b/Documentation/devicetree/bindings/sound/st,stm32-spdifrx.yaml
index 3dedc81ec12f..56c5738ea4c5 100644
--- a/Documentation/devicetree/bindings/sound/st,stm32-spdifrx.yaml
+++ b/Documentation/devicetree/bindings/sound/st,stm32-spdifrx.yaml
@@ -50,6 +50,10 @@ properties:
   resets:
     maxItems: 1
 
+  port:
+    $ref: audio-graph-port.yaml#
+    unevaluatedProperties: false
+
   access-controllers:
     minItems: 1
     maxItems: 2
-- 
2.25.1


