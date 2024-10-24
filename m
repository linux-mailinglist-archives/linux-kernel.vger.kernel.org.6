Return-Path: <linux-kernel+bounces-379297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12C039ADC9A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 08:52:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 423C01C22771
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 06:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10C791ABEBB;
	Thu, 24 Oct 2024 06:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="piJOe3x6"
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6CBD18B460;
	Thu, 24 Oct 2024 06:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729752667; cv=none; b=FbFXcMY+kcK0snqGhh6emlGUeJM4moS1Ka+DdF41jEKBXfyEALyBuongDK7Qs7JqhN8eT5l2cqF2XWZNoUs/JnqSF5wMO7S61R0i0Oa6KtJoXW2hSYgJ6WKDR1LFGS9D5pjKjFW3+ZllJQsDMvJmMQxkRzwgfm6v3ZHSGqPObfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729752667; c=relaxed/simple;
	bh=5SFr1V6tHOcpnlb3o4BMWfd4L9U2Tnw0/a4SLVFXa9E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QoCQfechJYThlAaAjLNgnMYbqSkoyHaFvT3zXlyaAbhqRKvr+SpYbvmMpP3FOxRtggQOYUjutQVjPW1aKezYTKEwOYOqtrNdzQRlunrOx+Vv5josm1X/hhBbcU/w2qLAajGRxBidlkZX1Vni1QWG6ceJCHCVndvFwDhn+EPTuQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=piJOe3x6; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 0EE63A0B65;
	Thu, 24 Oct 2024 08:50:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=hr+VlRp4LSkY0Zy0C0X2
	S5gF0hJCl0OgFIINDYPo60c=; b=piJOe3x6KYsaFa+WFZnnppcKrl3riyU35Tna
	BglPi3scGiUdkEZSwjgttExGoaTyXBpl0UPMfKZBC5BXVlK92z+VO8UOJUNM62Bp
	kqMINcbqER5/vRDrpWTmxqV0HP60KEF+8F3gaVtDiP657vQQzYt8VVZlCBgjauIC
	HuBKwac9+zZUhUF0UQ2nGTgTKZo7nMUUJrYpDFCuBwTW5ueWvKeKyctB4HXxHy6k
	pb4aSr2966eCUahLgtwemGhtv+aMJTU3M1zQ9rbD89P1O41HQAqca2t0cB6NG8fy
	XYzcB0G5IFaqM3xdIRfhtM/Fzn8uqCGal7BUYDuLCuee25xER9SCgwC6iPeYpSg1
	iC/16qgaus1roEzutvrrx71A2FAsiPw/fSU6318hJxj88N1Z3deCcFtH62vT4V3c
	2461fk0k2SD5iVko1dgxwJk5Kb/3VwFdxCGM5AhUSmszybZZ0ocjeF/IlitERmA5
	QYEMpkRc8UOwhKYLmjnpQ3xCDBEto7AO22tnS5KFlP3m/kWAU/AtP34xA7HgMfv5
	trrnso4QErOXXHCWC1mmJ/KUdmjoAYI/jJcy2TXj9KAdYrR1XnjDvJU9HLOrEPrj
	lNUqKuKH5KTGFwSki/9dVmhZ6zaZn/1j5EBKhksSuC/OHpN5ds0YU+2xrJ0UgIA+
	6VvGtIY=
From: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>
To: Chen-Yu Tsai <wens@csie.org>, Maxime Ripard <mripard@kernel.org>,
	<linux-sound@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-sunxi@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
CC: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>, "Liam
 Girdwood" <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, "Samuel
 Holland" <samuel@sholland.org>
Subject: [PATCH 07/10] dt-bindings: sound: Add Allwinner suniv F1C100s Audio Codec
Date: Thu, 24 Oct 2024 08:49:28 +0200
Message-ID: <20241024064931.1144605-8-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <13ab5cec-25e5-4e82-b956-5c154641d7ab@prolan.hu>
References:
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1729752654;VERSION=7978;MC=4016853731;ID=153595;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A2980D94855677065

Add compatible string for Allwinner suniv F1C100s audio codec.

[ csokas.bence: Reimplement in YAML ]
Signed-off-by: Csókás, Bence <csokas.bence@prolan.hu>
---
 .../sound/allwinner,sun4i-a10-codec.yaml      | 31 +++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/allwinner,sun4i-a10-codec.yaml b/Documentation/devicetree/bindings/sound/allwinner,sun4i-a10-codec.yaml
index 78273647f766..16f4f7a40d9d 100644
--- a/Documentation/devicetree/bindings/sound/allwinner,sun4i-a10-codec.yaml
+++ b/Documentation/devicetree/bindings/sound/allwinner,sun4i-a10-codec.yaml
@@ -22,6 +22,7 @@ properties:
       - allwinner,sun8i-a23-codec
       - allwinner,sun8i-h3-codec
       - allwinner,sun8i-v3s-codec
+      - allwinner,suniv-f1c100s-codec
 
   reg:
     maxItems: 1
@@ -70,6 +71,7 @@ properties:
         - MIC1
         - MIC2
         - MIC3
+        - MIC
 
         # Microphone Biases from the SoC
         - HBIAS
@@ -80,6 +82,8 @@ properties:
         - Headset Mic
         - Line In
         - Line Out
+        - Right FM In
+        - Left FM In
         - Mic
         - Speaker
 
@@ -229,6 +233,33 @@ allOf:
               - Mic
               - Speaker
 
+  - if:
+      properties:
+        compatible:
+          enum:
+            - allwinner,suniv-f1c100s-codec
+
+    then:
+      properties:
+        allwinner,audio-routing:
+          items:
+            enum:
+              - HP
+              - HPCOM
+              - LINEIN
+              - LINEOUT
+              - MIC
+              - HBIAS
+              - MBIAS
+              - Headphone
+              - Headset Mic
+              - Line In
+              - Line Out
+              - Right FM In
+              - Left FM In
+              - Mic
+              - Speaker
+
 unevaluatedProperties: false
 
 examples:
-- 
2.34.1



