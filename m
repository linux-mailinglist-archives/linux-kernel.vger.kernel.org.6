Return-Path: <linux-kernel+bounces-222698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75BFD9105DF
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 15:28:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CFD71C20E80
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 13:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A41D41AE86B;
	Thu, 20 Jun 2024 13:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b="a9m/sWIq"
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861901AD3F4;
	Thu, 20 Jun 2024 13:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=208.88.110.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718890001; cv=none; b=oBbibviH+Y+0LJlnNlsvIbicLTY9B+J1HlMLe0hwqhF88h3TL++ZXWxSXIwZ7lxTSI8uiAIalN2A5LjlDhUg1rdXCUK6sMjb9TphNk3rfZ9jjbr+W92rZPPAHVg8e9jT+5QayrDQgNhFRsDEQTSXSQiHX6eAyrEEhBKGJqkBhAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718890001; c=relaxed/simple;
	bh=uHRf8QnSmjHeP+y1W3PFaa/SDZvxV0HhtGn+PdLFSwI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=e+OQoP2Naows4gbRHVjoeArc5Y4bWGJIw41qW9cJw1GePFIOrf17F8QXaGuswWDIwPa+vQ8CxigvkPW96OurfABrqIiCIZ+zwaps8ULDt0Xqz95CyIr7un09oVT/tMFYCOneUURY08svRn/TWRNO26o/mD5iFHVCIAsk8GAEGP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com; spf=pass smtp.mailfrom=savoirfairelinux.com; dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b=a9m/sWIq; arc=none smtp.client-ip=208.88.110.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=savoirfairelinux.com
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id B735C9C5BB5;
	Thu, 20 Jun 2024 09:26:39 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id iP3d_f_PxoSX; Thu, 20 Jun 2024 09:26:38 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id C13A19C5BB3;
	Thu, 20 Jun 2024 09:26:38 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com C13A19C5BB3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1718889998; bh=WIDdP8Nhs+T0AX1bFRGBcj7z1PDp/O7FjFT/o694t9E=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=a9m/sWIqPv+3D9QIkNsZZRgbiN+vjq6Tb+ClhwW1n6JPxlnyCadOkmqpLgvUe6jJ/
	 MZXiBjuo4lsUrhDJb8fH8lcdmvjcGI/2P8PJqmn4dxM5/KiGLej1rh/lQFNcq6P4bX
	 Ldyc5IAF0v/35s4TtTrUY0eyBOVKYh129GA8hodHMUP/Ae6QQBU/kwvxlCvQtWFMjR
	 Ox8smoJytTyRjqL2nBQEhV43UEY1Giy/BcFHmrdpLKbyYW1rQBaTs7IQhKNEU+W3tV
	 +PbbdZ2hf2wV6/EvR31Y6r/okCJEO4zOF9Kqxkl+zstoWgOcGOy/6t44lnT3+Ka7qi
	 KxIaN7NBTz/Ng==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id UmrgJU7p_K7k; Thu, 20 Jun 2024 09:26:38 -0400 (EDT)
Received: from gerard.rennes.sfl (lmontsouris-657-1-69-118.w80-15.abo.wanadoo.fr [80.15.101.118])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id E5BB69C5BCD;
	Thu, 20 Jun 2024 09:26:35 -0400 (EDT)
From: Elinor Montmasson <elinor.montmasson@savoirfairelinux.com>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Shengjiu Wang <shengjiu.wang@gmail.com>,
	Xiubo Li <Xiubo.Lee@gmail.com>,
	Nicolin Chen <nicoleotsuka@gmail.com>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
	linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	alsa-devel@alsa-project.org,
	linuxppc-dev@lists.ozlabs.org,
	Elinor Montmasson <elinor.montmasson@savoirfairelinux.com>,
	Philip-Dylan <philip-dylan.gleonec@savoirfairelinux.com>
Subject: [PATCHv5 6/9] ASoC: dt-bindings: fsl-asoc-card: add compatible string for spdif
Date: Thu, 20 Jun 2024 15:25:08 +0200
Message-Id: <20240620132511.4291-7-elinor.montmasson@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240620132511.4291-1-elinor.montmasson@savoirfairelinux.com>
References: <20240620132511.4291-1-elinor.montmasson@savoirfairelinux.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The S/PDIF audio card support was merged from imx-spdif into the
fsl-asoc-card driver, making it possible to use an S/PDIF with an ASRC.
Add the new compatible and update properties.

Signed-off-by: Elinor Montmasson <elinor.montmasson@savoirfairelinux.com>
---
 .../bindings/sound/fsl-asoc-card.yaml         | 30 ++++++++++++++++---
 1 file changed, 26 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/fsl-asoc-card.yaml b/D=
ocumentation/devicetree/bindings/sound/fsl-asoc-card.yaml
index 9922664d5ccc..f2e28b32808e 100644
--- a/Documentation/devicetree/bindings/sound/fsl-asoc-card.yaml
+++ b/Documentation/devicetree/bindings/sound/fsl-asoc-card.yaml
@@ -33,6 +33,7 @@ properties:
       - items:
           - enum:
               - fsl,imx-sgtl5000
+              - fsl,imx-sabreauto-spdif
               - fsl,imx25-pdk-sgtl5000
               - fsl,imx53-cpuvo-sgtl5000
               - fsl,imx51-babbage-sgtl5000
@@ -54,6 +55,7 @@ properties:
               - fsl,imx6q-ventana-sgtl5000
               - fsl,imx6sl-evk-wm8962
               - fsl,imx6sx-sdb-mqs
+              - fsl,imx6sx-sdb-spdif
               - fsl,imx6sx-sdb-wm8962
               - fsl,imx7d-evk-wm8960
               - karo,tx53-audio-sgtl5000
@@ -65,6 +67,7 @@ properties:
               - fsl,imx-audio-sgtl5000
               - fsl,imx-audio-wm8960
               - fsl,imx-audio-wm8962
+              - fsl,imx-audio-spdif
       - items:
           - enum:
               - fsl,imx-audio-ac97
@@ -81,6 +84,7 @@ properties:
               - fsl,imx-audio-wm8960
               - fsl,imx-audio-wm8962
               - fsl,imx-audio-wm8958
+              - fsl,imx-audio-spdif
=20
   model:
     $ref: /schemas/types.yaml#/definitions/string
@@ -93,8 +97,15 @@ properties:
       need to add ASRC support via DPCM.
=20
   audio-codec:
-    $ref: /schemas/types.yaml#/definitions/phandle
-    description: The phandle of an audio codec
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    description: |
+      The phandle of an audio codec.
+      With "fsl,imx-audio-spdif", either SPDIF audio codec spdif_transmitt=
er,
+      spdif_receiver or both.
+    minItems: 1
+    maxItems: 2
+    items:
+      maxItems: 1
=20
   audio-cpu:
     $ref: /schemas/types.yaml#/definitions/phandle
@@ -150,8 +161,10 @@ properties:
     description: dai-link uses bit clock inversion.
=20
   mclk-id:
-    $ref: /schemas/types.yaml#/definitions/uint32
-    description: main clock id, specific for each card configuration.
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    description: Main clock id for each codec, specific for each card conf=
iguration.
+    minItems: 1
+    maxItems: 2
=20
   mux-int-port:
     $ref: /schemas/types.yaml#/definitions/uint32
@@ -195,3 +208,12 @@ examples:
              "AIN2L", "Line In Jack",
              "AIN2R", "Line In Jack";
     };
+
+  - |
+    sound-spdif-asrc {
+      compatible =3D "fsl,imx-audio-spdif";
+      model =3D "spdif-asrc-audio";
+      audio-cpu =3D <&spdif>;
+      audio-asrc =3D <&easrc>;
+      audio-codec =3D <&spdifdit>, <&spdifdir>;
+    };
--=20
2.34.1


