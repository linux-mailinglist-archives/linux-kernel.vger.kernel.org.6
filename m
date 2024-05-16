Return-Path: <linux-kernel+bounces-180829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 776A38C73A5
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 11:21:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2C2FB21CAF
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 09:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EB8114388B;
	Thu, 16 May 2024 09:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b="lpszGh8V"
Received: from mg.richtek.com (mg.richtek.com [220.130.44.152])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A0C8143742;
	Thu, 16 May 2024 09:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.130.44.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715851265; cv=none; b=ODjY0rCn+UXIjIeQTHW9cG29cVJEJSUSwM3VyQSIKBd51EFcYMmDz3hVA5FEcVVM2yCvCAUgeTLtLOeF4AexxmKrtVtiecdPYP7AwdMO3gSroXvs0STdAmH4WowKzSTU9KpgMlaJgoHqt++PZeZ/HeF04tsSQyO9w6w/vfUyEp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715851265; c=relaxed/simple;
	bh=vj5iTVNnr0LltL75dJySY0TkZeBZ96BYbyS8soMrNtU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XG0PhisnSb8S3wuCkug1XNlynnXUFol8BuGKLZaU/Bhr56g/6g/08yWh8GIZj0amADgKLkOx4mqqFqR0EAp5lELLhqj5R6DBgweecvlmn90opAZhzFRjo7Es55e7OJCHOsoZA7B0aosWUoX3GH/giAxtX/TglT0+A40ZpVzWvRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=richtek.com; spf=pass smtp.mailfrom=richtek.com; dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b=lpszGh8V; arc=none smtp.client-ip=220.130.44.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=richtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=richtek.com
X-MailGates: (SIP:2,PASS,NONE)(compute_score:DELIVER,40,3)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=richtek.com;
	s=richtek; t=1715851255;
	bh=4FZFc/ldoEBTquoVTySNzI9r+bg5+rvsd53z2bgulQA=; l=1600;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=lpszGh8Vr0mMWp+CAg2n8fvks5Xz9Fj4zSvZEJVhoSF90BnqpFPnV5oqJe1993kUF
	 2t7KD5tLsDKXLx8GF/cec5iVln8IRmsEHiXMwXBQVKlSw3jFpR3cbNh8z8tpZliO6s
	 mA3qb6/vIE5WGc0LFLAoUbzisHaI7KmodKx698qfCHGSHceKMR6EEUv2lLQuTPwCcJ
	 Mjsh/ownrLRZIKdTPCEjOZDifZtbzHb7mxaoEVbR1uMX/4NTI4PLS1ANSNrXz3kZGJ
	 nGiqMQQO9WlTN5FmWK4QCYSqMyv9tOkD7T29yoHhTmpSq4hFNvMVR+1XOD2MEy8f10
	 jo2ZYdt0t+vTA==
Received: from 192.168.10.46
	by mg.richtek.com with MailGates ESMTPS Server V6.0(3213195:0:AUTH_RELAY)
	(envelope-from <alina_yu@richtek.com>)
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256/256); Thu, 16 May 2024 17:20:40 +0800 (CST)
Received: from ex4.rt.l (192.168.10.47) by ex3.rt.l (192.168.10.46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 16 May
 2024 17:20:40 +0800
Received: from linuxcarl2.richtek.com (192.168.10.154) by ex4.rt.l
 (192.168.10.45) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 16 May 2024 17:20:40 +0800
From: Alina Yu <alina_yu@richtek.com>
To: <lgirdwood@gmail.com>, <broonie@kernel.org>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<alina_yu@richtek.com>, <cy_huang@richtek.com>
Subject: [PATCH 2/2] regulator: dt-bindings: rtq2208: Add specified fixed LDO VOUT property
Date: Thu, 16 May 2024 17:20:34 +0800
Message-ID: <9c1bbe4b38a4ee5650d888478f1ce2cec2733669.1715846612.git.alina_yu@richtek.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1715846612.git.alina_yu@richtek.com>
References: <cover.1715846612.git.alina_yu@richtek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

As the fixed voltage for the LDO is outside the range of the adjustable voltage mode,
the constraints for this scenario are not suitable to represent both modes.
Therefore, A property is added to specify the fixed LDO VOUT.

Examples of fixed LDO VOUT and adjustable LDO VOUT is also added to this version.

Signed-off-by: Alina Yu <alina_yu@richtek.com>
---
 .../devicetree/bindings/regulator/richtek,rtq2208.yaml        | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/regulator/richtek,rtq2208.yaml b/Documentation/devicetree/bindings/regulator/richtek,rtq2208.yaml
index 609c066..87accc6 100644
--- a/Documentation/devicetree/bindings/regulator/richtek,rtq2208.yaml
+++ b/Documentation/devicetree/bindings/regulator/richtek,rtq2208.yaml
@@ -75,6 +75,12 @@ properties:
         description:
           regulator description for ldo[1-2].
 
+        properties:
+          richtek,fixed-microvolt:
+            description: |
+              This property can be used to set a fixed operating voltage that lies outside
+              the range of the regulator's adjustable mode.
+
 required:
   - compatible
   - reg
@@ -177,6 +183,8 @@ examples:
             };
           };
           ldo1 {
+            /* Fixed LDO VOUT */
+            richtek,fixed-microvolt = <1200000>;
             regulator-min-microvolt = <1200000>;
             regulator-max-microvolt = <1200000>;
             regulator-always-on;
@@ -185,7 +193,8 @@ examples:
             };
           };
           ldo2 {
-            regulator-min-microvolt = <3300000>;
+            /* Adjustable LDO VOUT */
+            regulator-min-microvolt = <1800000>;
             regulator-max-microvolt = <3300000>;
             regulator-always-on;
             regulator-state-mem {
-- 
2.7.4


