Return-Path: <linux-kernel+bounces-393407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3430E9BA026
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 14:00:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED16928251E
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 13:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A6BF18BB8D;
	Sat,  2 Nov 2024 13:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="A+UtL/ly"
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB25C18BBA0;
	Sat,  2 Nov 2024 13:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730552412; cv=none; b=MP27URsVw6+xocQNFjruZM+kwjBqZTRh8hyt9aW0T/nW2T12b/JFxJzA768yeOFMOf5NKl7UOIkzg76At1IV/JV4KLZ2eJIj8ukDZbRLrIHl3Py3OVOgXFBIbaf78BdEHrjgCjRK1SarIvjmp3ftpkdlBGmfWKMH/jy1lcvlliA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730552412; c=relaxed/simple;
	bh=3UkeRzv8tuyM480RNYtsP4upZlJ+1C00o1KTqGMdwCg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fSJF3gfBqHB0t215MMAsKadnN1JBCGqd5455Kqi9WZFfDydlKJ5/Pli8Nsl96yX6UB13RQWTnTJSR6lwno2nkDOSEFZ3NE2YSbXOlPW9sWsieJX3L/EoLzWLolDPIBcZZPoGd/+Oai+ESiEnA2TvpG3GV4t9YJ+RmBhPBNmkAaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=A+UtL/ly; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 69622A0ABF;
	Sat,  2 Nov 2024 14:00:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=6BVVyLjJdR6me74k/F+O
	t1blbg2/epRtk+d2HKjKdKo=; b=A+UtL/lytKD+HLHR4iDjYCIulzShvKEyTfgw
	3Z5KSRo6vXfQ0/d/E2XSJrJBfqVK5bwJNXTB3d41PvsGpTpT2tbDSHTeuKMCjdAI
	f0DmKXb76aM4Xv7GA0KGyMwktjy0sujpM7uUWVsBgs2iJYV88XYAwBxARZ6hqKBC
	uEElnh0nBjnhkOUin+Alo4vvCj/AwWoeeatw795rt0Ye4niKhSues4kMrB9+7vqC
	2l5C2dRl8cw9VBXdcxMyRt3cWhlvxHXz31vp2I07kj+ZBcS3CXbxas/cS48c5lqR
	1UZUchOQ3NKPxBLg2scsexKhGd9dzNegQ4xsnSDevNN2iMlH7K+F4iZDOZDmXzh7
	M6t+Wsr8S9s8QNEYsjiPLio+c8PVlClscZByvv4q9DP356oCoquLwmLtCz7bqqxQ
	ulJYjJTHZ1FsRIvgaj4NDR0HURlaVFdAFUX0WkDrrz2fS+zt7Cjpf721AbKz0MhN
	S9wx9NN2r1M+BwjW8j/dJJ3sXSQ5m77SwkQ9yYLdwn2CqlHNpmzpX3Jmd6+pGti7
	8ZhUXitbbX5uFqRbBLfaYd79+pPhDhsct6jDbfHQPRq99OW8WzGKs/oGj+giMaXW
	9uNG+hUakgslS2rFSbp68yI1di+ZY1RJwS2xcpSAHs7KguD1uSMZZNdLh8+rsWuH
	dGTaLco=
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
Subject: [PATCH v5 2/3] dt-bindings: sound: Add Allwinner suniv F1C100s Audio Codec
Date: Sat, 2 Nov 2024 13:57:11 +0100
Message-ID: <20241102125712.2647325-3-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241102125712.2647325-1-csokas.bence@prolan.hu>
References: <20241102125712.2647325-1-csokas.bence@prolan.hu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1730552408;VERSION=7979;MC=1258900186;ID=222167;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A2980D9485566706B

Add compatible string for Allwinner suniv F1C100s audio codec.

[ csokas.bence: Reimplement Mesih Kilinc's binding in YAML ]
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



