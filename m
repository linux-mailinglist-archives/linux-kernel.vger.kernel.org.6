Return-Path: <linux-kernel+bounces-222282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E41F90FF2F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 10:45:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C221E1F218FF
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 08:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49ACD1AB34D;
	Thu, 20 Jun 2024 08:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ew1lZeu1"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 276DD1A4F17;
	Thu, 20 Jun 2024 08:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718873004; cv=none; b=bjPRrkyLf/NHfQgSXOVvqP6LSwm9alJc6jVS3PUVm9fAzfbheZ0nkjLO6qirPAo+xVbv6xfAO8gFfNkbqOMeVIQA2c4fdKpLV5ytGAKW4iDGuc+hOJa+UXYy5Sa8g3bKm6BFdGYGcuVd09HwRmPlt4wPbxlKfdcEog0rgVUozCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718873004; c=relaxed/simple;
	bh=rBkSeB69MknRRW1vvLLHZBCUsHjl3fAMU+GE38ZYnJk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PNLiBiRctHcyuLzKqoR3yDZRV99zXJ+ihPnIjLgwlkLBfgZYZOJk9MH2EQgihoqlI6onu8SD4F1CVSdgCGDshWqiX7vHIuwy4IF9Xy3UUV4/dF4LkfFAK8w9SNKLjT17VIPpfLRZoXdxq57JEXZe8BwUYvLfGz6C4ejKT80FwOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ew1lZeu1; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 806CD20016;
	Thu, 20 Jun 2024 08:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1718873000;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LQir0ryB/8aPBX/LEL6U1QothG+zRSSIaipi9sCzLmY=;
	b=ew1lZeu1oYh7noJ/c69BVNsPhRCTgkWHP3qwLlXxKKhYbGmkbHKPiXHyqURBfmqSYorKIm
	ScesK+S0610KGyeAzFMxdNifl136+7dKBnmCpdCAx8UtdDbqgk4Q+K/Fu8MmcJRUnXyEco
	aI8lxmr++LgOF8ZbFK5gZ80NcQ9Srn7oGRytUndRQtMbXrE1E9D2/NzYn3JAciPjbe/nV0
	fbWdYz4bqFuodE7bo8he2o4vth9amo92zSTDN+52ISW+898gFDU65YN4FIhuQ+i1cfnnOz
	LNJdsvWx4mTDJytFSARmGafznmz15swgkXh4wv7MOz2vBe4XOfKuwD+RIbgu2w==
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
Subject: [PATCH 09/10] dt-bindings: sound: fsl,qmc-audio: Add support for multiple QMC channels per DAI
Date: Thu, 20 Jun 2024 10:42:56 +0200
Message-ID: <20240620084300.397853-10-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240620084300.397853-1-herve.codina@bootlin.com>
References: <20240620084300.397853-1-herve.codina@bootlin.com>
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


