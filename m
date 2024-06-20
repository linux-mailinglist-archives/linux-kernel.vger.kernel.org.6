Return-Path: <linux-kernel+bounces-222700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A14D69105E7
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 15:28:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CA881C21C9C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 13:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71B951AE872;
	Thu, 20 Jun 2024 13:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b="IgK2q24I"
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F21D1AED55;
	Thu, 20 Jun 2024 13:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=208.88.110.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718890007; cv=none; b=RY5bp95U488fnqGl5J3EnkYoa/ZwqXb26K63lQMhgETizPr+nGGob0iqD+ZRO930cSkf+clpwqsBy9TQw4mF1uxEVQWnF9jCRdhEdV53DBraFhoJXHjXLlZtQrajVKhzGP4HpxDs/JTwAMymZlCU1WudDdByBf+vQjiM90dDb7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718890007; c=relaxed/simple;
	bh=ZboxhAN1nAJKhZUMbUDLtu4pCT1sWwnxHPvIlUS2RgQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bu6HjbmeUKBxkffGjjxvnzgaDMH1xLCe31bAd8eIkTRROzu35lDGNqK7nsESoPx2uGj8N/jlKsaLMOq8PGg9jYHphmt1VWh6EVUgRumDEajExkbIcur7Kl6mlyPNZLb6ugSKwNlbm6Mce6JO4SJtdrj+eDYdy4XMSBgbfMFjFIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com; spf=pass smtp.mailfrom=savoirfairelinux.com; dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b=IgK2q24I; arc=none smtp.client-ip=208.88.110.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=savoirfairelinux.com
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 947B69C58D7;
	Thu, 20 Jun 2024 09:26:45 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id 1oN2S6fbGw84; Thu, 20 Jun 2024 09:26:44 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 9B9059C5BD0;
	Thu, 20 Jun 2024 09:26:44 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 9B9059C5BD0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1718890004; bh=IxuGX0qCoVtAnpi7VYe/G+5pTn61z1lEtzCcfexjT68=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=IgK2q24IXb7GPhcc0AXJZdbrpqFrg8fNawkDMBDLfTTiyqY144SnT6HfBcyXT+yVM
	 A4mN91E7HIfYqQimjNgPrbfwJ6L0lh/sPllRbI/Bo046VxFITd3Hup1Vz/IGp0dAuP
	 Cs6zpWAiDIi+CcaC7HniH4wNVYc93/qwPgfHgcWLCsa23mf2oXSz453hsY8OPfZQdi
	 yTGynxLkrmm9h2YGmPOsZr/QW2qfnY1e5VNnbI+RjltvK/cOTB4hvXdVKUwWrYk+vV
	 UGZb74NAEhsdd2+nWbaVrAyfhu7UbZRBWrwejDmu/7QgMR61s2qQbKlAiiNnVyg00P
	 8jiQ1/WrtVOCQ==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id 5eIRff_C5wVV; Thu, 20 Jun 2024 09:26:44 -0400 (EDT)
Received: from gerard.rennes.sfl (lmontsouris-657-1-69-118.w80-15.abo.wanadoo.fr [80.15.101.118])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id C2C489C5BCD;
	Thu, 20 Jun 2024 09:26:41 -0400 (EDT)
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
Subject: [PATCHv5 8/9] arm64: dts: imx8m: update spdif sound card node properties
Date: Thu, 20 Jun 2024 15:25:10 +0200
Message-Id: <20240620132511.4291-9-elinor.montmasson@savoirfairelinux.com>
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

Following merge of imx-spdif driver into fsl-asoc-card:
* update properties to match those used by fsl-asoc-card.
* S/PDIF in/out dummy codecs must now be declared explicitly, add and
  use them.

These modifications were tested only on an imx8mn-evk board.

Signed-off-by: Elinor Montmasson <elinor.montmasson@savoirfairelinux.com>
---
 arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi | 15 +++++++++---
 arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi | 15 +++++++++---
 arch/arm64/boot/dts/freescale/imx8mq-evk.dts  | 24 +++++++++++++++----
 3 files changed, 43 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi b/arch/arm64/boo=
t/dts/freescale/imx8mm-evk.dtsi
index 90d1901df2b1..348855a41852 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
@@ -180,12 +180,21 @@ cpu {
 		};
 	};
=20
+	spdif_out: spdif-out {
+		#sound-dai-cells =3D <0>;
+		compatible =3D "linux,spdif-dit";
+	};
+
+	spdif_in: spdif-in {
+		#sound-dai-cells =3D <0>;
+		compatible =3D "linux,spdif-dir";
+	};
+
 	sound-spdif {
 		compatible =3D "fsl,imx-audio-spdif";
 		model =3D "imx-spdif";
-		spdif-controller =3D <&spdif1>;
-		spdif-out;
-		spdif-in;
+		audio-cpu =3D <&spdif1>;
+		audio-codec =3D <&spdif_out>, <&spdif_in>;
 	};
 };
=20
diff --git a/arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi b/arch/arm64/boo=
t/dts/freescale/imx8mn-evk.dtsi
index 9e0259ddf4bc..6a47e09703a7 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi
@@ -124,12 +124,21 @@ sound-wm8524 {
 			"Line Out Jack", "LINEVOUTR";
 	};
=20
+	spdif_out: spdif-out {
+		#sound-dai-cells =3D <0>;
+		compatible =3D "linux,spdif-dit";
+	};
+
+	spdif_in: spdif-in {
+		#sound-dai-cells =3D <0>;
+		compatible =3D "linux,spdif-dir";
+	};
+
 	sound-spdif {
 		compatible =3D "fsl,imx-audio-spdif";
 		model =3D "imx-spdif";
-		spdif-controller =3D <&spdif1>;
-		spdif-out;
-		spdif-in;
+		audio-cpu =3D <&spdif1>;
+		audio-codec =3D <&spdif_out>, <&spdif_in>;
 	};
=20
 	sound-micfil {
diff --git a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts b/arch/arm64/boot=
/dts/freescale/imx8mq-evk.dts
index 7507548cdb16..b953865f0b46 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
@@ -125,19 +125,33 @@ link_codec: simple-audio-card,codec {
 		};
 	};
=20
+	spdif_out: spdif-out {
+		#sound-dai-cells =3D <0>;
+		compatible =3D "linux,spdif-dit";
+	};
+
+	spdif_in: spdif-in {
+		#sound-dai-cells =3D <0>;
+		compatible =3D "linux,spdif-dir";
+	};
+
 	sound-spdif {
 		compatible =3D "fsl,imx-audio-spdif";
 		model =3D "imx-spdif";
-		spdif-controller =3D <&spdif1>;
-		spdif-out;
-		spdif-in;
+		audio-cpu =3D <&spdif1>;
+		audio-codec =3D <&spdif_out>, <&spdif_in>;
+	};
+
+	hdmi_arc_in: hdmi-arc-in {
+		#sound-dai-cells =3D <0>;
+		compatible =3D "linux,spdif-dir";
 	};
=20
 	sound-hdmi-arc {
 		compatible =3D "fsl,imx-audio-spdif";
 		model =3D "imx-hdmi-arc";
-		spdif-controller =3D <&spdif2>;
-		spdif-in;
+		audio-cpu =3D <&spdif2>;
+		audio-codec =3D <&hdmi_arc_in>;
 	};
 };
=20
--=20
2.34.1


