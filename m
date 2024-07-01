Return-Path: <linux-kernel+bounces-236151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61F5591DE13
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 13:34:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93DDC1C2277F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 11:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD375152DF1;
	Mon,  1 Jul 2024 11:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="EgTc1gzy"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEBB514F9FA;
	Mon,  1 Jul 2024 11:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719833527; cv=none; b=hNvosdhZ3qbvL2Fv/D834TQC4StHSDk5u1LvEzNZyj5o09/scM20OPyLVB5VGgGmfPcKL75DbA+PP33ze14rlJFHDTfrj1hryISWgUctADs25yYmbCNPframgc88vBbNrKpA9oTdBjHtYKBEQATjoDM12WTNCc6nfSvZE2wX9Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719833527; c=relaxed/simple;
	bh=IWqKgpcTwbg0LZqPsWGdtlP3A/WVEiC2gYH8LGWVs7A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PoR3sDTn4RQ+A7F1yg9Xdivixo0ZvF6TTLrK4XkvBDObpTF3AUczYX2V6OVh+tDeVnjaH+gU6QbC3DvFUTriifKkZTYITCYCm/6zxo1gl/tzaR+hrTEC1DsosoYN3AKnjUDVSalHUfoL8vk3OMTa61GyHCUjuqvvoLHL1VVv1Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=EgTc1gzy; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 61907240002;
	Mon,  1 Jul 2024 11:32:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1719833523;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sfZG8ibbCskYBjaUkA70z76iMY7bqlElSDzCQwYJd/Q=;
	b=EgTc1gzyL3pfQ/KiFB1+225D05a2zp0EmLxLD6bIkUkfH3Wuh89+7jJMk5AQIPp/HLbD6t
	yA4E5HXwpI8PwPNBcBIjahlOB4VSB3dk2ICdAYPWgTQYbJsTuR8WzLwTevV/fxpqkyq36d
	pAI/Fz9TzxqWDGjwXHX1+64JzI9hLIb/1cQacvmIG/shvLmQXfVBH0ezFegtgf47x/5Ze6
	c/2xhoAs1Y2OnFaCi4j9lRtdaplZnBE1mJFy7j636J31Wzvpke7r8dkPPxNPURjIFEpkuL
	n13DR2gHrMhPuykXfOxu/TnsCr/b5yU1gvXhMu8dSodSiauju9bdJAwbt1VKlQ==
From: Herve Codina <herve.codina@bootlin.com>
To: Herve Codina <herve.codina@bootlin.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Qiang Zhao <qiang.zhao@nxp.com>,
	Shengjiu Wang <shengjiu.wang@gmail.com>,
	Xiubo Li <Xiubo.Lee@gmail.com>,
	Fabio Estevam <festevam@gmail.com>,
	Nicolin Chen <nicoleotsuka@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: alsa-devel@alsa-project.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v2 09/10] dt-bindings: sound: fsl,qmc-audio: Add support for multiple QMC channels per DAI
Date: Mon,  1 Jul 2024 13:30:36 +0200
Message-ID: <20240701113038.55144-10-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240701113038.55144-1-herve.codina@bootlin.com>
References: <20240701113038.55144-1-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

The QMC audio uses one QMC channel per DAI and uses this QMC channel to
transmit interleaved audio channel samples.

In order to work in non-interleave mode, a QMC audio DAI needs to use
multiple QMC channels. In that case, the DAI maps each QMC channel to
exactly one audio channel.

Allow QMC audio DAIs with multiple QMC channels attached.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../bindings/sound/fsl,qmc-audio.yaml         | 41 ++++++++++++++++---
 1 file changed, 35 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/fsl,qmc-audio.yaml b/Documentation/devicetree/bindings/sound/fsl,qmc-audio.yaml
index b522ed7dcc51..a23e49198c37 100644
--- a/Documentation/devicetree/bindings/sound/fsl,qmc-audio.yaml
+++ b/Documentation/devicetree/bindings/sound/fsl,qmc-audio.yaml
@@ -12,7 +12,9 @@ maintainers:
 description: |
   The QMC audio is an ASoC component which uses QMC (QUICC Multichannel
   Controller) channels to transfer the audio data.
-  It provides as many DAI as the number of QMC channel used.
+  It provides several DAIs. For each DAI, the DAI is working in interleaved mode
+  if only one QMC channel is used by the DAI or it is working in non-interleaved
+  mode if several QMC channels are used by the DAI.
 
 allOf:
   - $ref: dai-common.yaml#
@@ -45,12 +47,19 @@ patternProperties:
       fsl,qmc-chan:
         $ref: /schemas/types.yaml#/definitions/phandle-array
         items:
-          - items:
-              - description: phandle to QMC node
-              - description: Channel number
+          items:
+            - description: phandle to QMC node
+            - description: Channel number
+        minItems: 1
         description:
-          Should be a phandle/number pair. The phandle to QMC node and the QMC
-          channel to use for this DAI.
+          Should be a phandle/number pair list. The list of phandle to QMC node
+          and the QMC channel pair to use for this DAI.
+          If only one phandle/number pair is provided, this DAI works in
+          interleaved mode, i.e. audio channels for this DAI are interleaved in
+          the QMC channel. If more than one pair is provided, this DAI works
+          in non-interleave mode. In that case the first audio channel uses the
+          the first QMC channel, the second audio channel uses the second QMC
+          channel, etc...
 
     required:
       - reg
@@ -79,6 +88,11 @@ examples:
             reg = <17>;
             fsl,qmc-chan = <&qmc 17>;
         };
+        dai@18 {
+            reg = <18>;
+            /* Non-interleaved mode */
+            fsl,qmc-chan = <&qmc 18>, <&qmc 19>;
+        };
     };
 
     sound {
@@ -115,4 +129,19 @@ examples:
                 dai-tdm-slot-rx-mask = <0 0 1 0 1 0 1 0 1>;
             };
         };
+        simple-audio-card,dai-link@2 {
+            reg = <2>;
+            format = "dsp_b";
+            cpu {
+                sound-dai = <&audio_controller 18>;
+            };
+            codec {
+                sound-dai = <&codec3>;
+                dai-tdm-slot-num = <2>;
+                dai-tdm-slot-width = <8>;
+                /* TS 9, 10 */
+                dai-tdm-slot-tx-mask = <0 0 0 0 0 0 0 0 0 1 1>;
+                dai-tdm-slot-rx-mask = <0 0 0 0 0 0 0 0 0 1 1>;
+            };
+        };
     };
-- 
2.45.0


