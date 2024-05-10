Return-Path: <linux-kernel+bounces-175759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A54688C2483
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 14:07:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E41C28E12C
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 12:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0D8F170844;
	Fri, 10 May 2024 12:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b="wuDlwXBs"
Received: from mg.richtek.com (mg.richtek.com [220.130.44.152])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1021E16F823;
	Fri, 10 May 2024 12:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.130.44.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715342815; cv=none; b=jhRwxOSBwE+Ov00D75NiqA0Re18Z1h5fToSSNrsLKegU8UNgF1/KlG4v5jLtwlKrzZt/d+JWAIGs/fNC6RTct7E7H7G64GMnhI1dFWq3bloeI7IXtZ0tfSeLBKFP/4NZ0jGS/kql8JAPqZaf7Etn8cnBBG6695VQYGcSRI4caUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715342815; c=relaxed/simple;
	bh=Kri6ApUcgAkurOUKOhlGUuyZiQZb5rFxf6NIPTgDDB4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=anmCe0IyOiHrLV5pxQUJDOCJccrbdLYbHCYncUIMo+QSuKdNFO0ohFZMbnwm1Lndh4miSfO5y9cznzFxyEGoxz7o9M7EA7n61vxAyrnSynJoXq3YN0wc9ysgMUIHZdYgDXa86cACu7ZYGnmrKf/J42viia6njH1vCCfuigdFE1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=richtek.com; spf=pass smtp.mailfrom=richtek.com; dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b=wuDlwXBs; arc=none smtp.client-ip=220.130.44.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=richtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=richtek.com
X-MailGates: (SIP:2,PASS,NONE)(compute_score:DELIVER,40,3)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=richtek.com;
	s=richtek; t=1715342806;
	bh=NE7r2aCsiikDYhywBG+j93zq4aaWUUtMLU/H8m9LS8U=; l=1265;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=wuDlwXBslgrrplB8jFJPeA3Q/uFWO6/TA3UBDM8jsvSmnZCU+wXce7YlOwSkdt7Ep
	 3bpFFjTLR+n0x2A0SPI/f+a2X1YOLfDNx3OsH7flghfOvb0uVi43cjel1LEUnWy4GW
	 zuN1yHUjpIm8mfGoHmKhy7buz7kLmcmCaur95NAwtoB3CzCZmI6l1Ai/931Thn7D+5
	 7N7ABAPJ9b+IVbroOrV0JIoxdYMx4AfriGW+oPEJRVuc4imYQ+NAjSY9AhEMPlULVv
	 ocjpH4hgL6L6MFt/OvbKXZCqckJ7GF3k0Ju5uLboaT9Sxq+d64eD30eaNUkBgVjuHg
	 U26HZQYNjHW6Q==
Received: from 192.168.10.47
	by mg.richtek.com with MailGates ESMTPS Server V6.0(3213191:0:AUTH_RELAY)
	(envelope-from <alina_yu@richtek.com>)
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256/256); Fri, 10 May 2024 20:06:35 +0800 (CST)
Received: from ex3.rt.l (192.168.10.46) by ex4.rt.l (192.168.10.47) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 10 May
 2024 20:06:35 +0800
Received: from linuxcarl2.richtek.com (192.168.10.154) by ex3.rt.l
 (192.168.10.45) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 10 May 2024 20:06:35 +0800
From: Alina Yu <alina_yu@richtek.com>
To: <lgirdwood@gmail.com>, <broonie@kernel.org>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<alina_yu@richtek.com>, <johnny_lai@richtek.com>, <cy_huang@richtek.com>
Subject: [PATCH v3 6/6] regulator: dt-bindings: rtq2208: Add property to get ldo of RTQ2208 is adjustable or not
Date: Fri, 10 May 2024 20:06:25 +0800
Message-ID: <6a3a90d9aa2022dfb92e124e417f3e72c2f28b0b.1715340537.git.alina_yu@richtek.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1715340537.git.alina_yu@richtek.com>
References: <cover.1715340537.git.alina_yu@richtek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Since there is no way to check is ldo is adjustable or not.
As discussing in v2 series, 'richtek,fixed-microvolt' is added for that.
user is supposed to know whether vout of ldo is adjustable.

Signed-off-by: Alina Yu <alina_yu@richtek.com>
---
 Documentation/devicetree/bindings/regulator/richtek,rtq2208.yaml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/regulator/richtek,rtq2208.yaml b/Documentation/devicetree/bindings/regulator/richtek,rtq2208.yaml
index 609c066..6212f44 100644
--- a/Documentation/devicetree/bindings/regulator/richtek,rtq2208.yaml
+++ b/Documentation/devicetree/bindings/regulator/richtek,rtq2208.yaml
@@ -75,6 +75,13 @@ properties:
         description:
           regulator description for ldo[1-2].
 
+        properties:
+          richtek,fixed-microvolt:
+            description: |
+              If it exists, the voltage is unadjustable.
+              There is no risk-free method for software to determine whether the ldo vout is fixed or not.
+              Therefore, it can only be done in this way.
+
 required:
   - compatible
   - reg
@@ -177,6 +184,7 @@ examples:
             };
           };
           ldo1 {
+            richtek,fixed-microvolt = <1200000>;
             regulator-min-microvolt = <1200000>;
             regulator-max-microvolt = <1200000>;
             regulator-always-on;
-- 
2.7.4


