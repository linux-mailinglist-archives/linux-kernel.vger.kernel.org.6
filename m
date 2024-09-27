Return-Path: <linux-kernel+bounces-341745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55F6D98855F
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 14:44:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 870D21C23341
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 12:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D13518F2C4;
	Fri, 27 Sep 2024 12:43:15 +0000 (UTC)
Received: from albert.telenet-ops.be (albert.telenet-ops.be [195.130.137.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E9818D650
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 12:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.137.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727440993; cv=none; b=Gk1iG6GooydTIfb+upS5h3DdvLo6i4bCXzpx5U322O0GUUlouMrS5sNwn201Iy84Scj+meMjT3PV/ReHoHgs7hG/KHAfbJspI01cbsZRul5lrt3c4WqR7BLS47WLL6rvdM0aa1WO+22n7ojpUOI4VdHmuby9z7TlJa6htLJT1s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727440993; c=relaxed/simple;
	bh=iT5rXWgkVPcbkFWW81Uc2zGRtQvQkpapAwr3dLRdXHs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BoxZNWWRZqpWFz6YPFgmPsVr+kXutnXKrTrYG8gyOou+9buqiA7K2EPHmkaoUGvB71DtrVztpK4PVqvqd5X6mrinljBrbaYT6EhkN0s0EAC0+5ORN7g/mOgAmtObtuhgDPIJkPz2dRlvocgHxj6IZJQnquXWd2RgZD1Jg+oiu1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.137.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:b47d:fd74:3975:15b7])
	by albert.telenet-ops.be with cmsmtp
	id HQic2D00E3BfLyr06Qiclu; Fri, 27 Sep 2024 14:43:02 +0200
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1suAIj-000fPu-HI;
	Fri, 27 Sep 2024 14:42:31 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1suAIp-008IDm-0M;
	Fri, 27 Sep 2024 14:42:31 +0200
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lubomir Rintel <lkundrak@v3.sk>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Magnus Damm <magnus.damm@gmail.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Paul Cercueil <paul@crapouillou.net>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Shengjiu Wang <shengjiu.wang@gmail.com>,
	Xiubo Li <Xiubo.Lee@gmail.com>,
	Nicolin Chen <nicoleotsuka@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Adrien Grassein <adrien.grassein@gmail.com>,
	Adam Ford <aford173@gmail.com>
Cc: linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	linux-renesas-soc@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-mips@vger.kernel.org,
	alsa-devel@alsa-project.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH treewide 04/11] arm64: dts: freescale: imx: Switch to simple-audio-card,hp-det-gpios
Date: Fri, 27 Sep 2024 14:42:19 +0200
Message-Id: <b38545c29d6cbf0b394ddb4747ce810c679f95d1.1727438777.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1727438777.git.geert+renesas@glider.be>
References: <cover.1727438777.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the deprecated "simple-audio-card,hp-det-gpio" property by
"simple-audio-card,hp-det-gpios" in Simple Audio Card device nodes.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts | 2 +-
 arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi       | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts b/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
index b268ba7a0e12a3f8..9d8e7231b7c63742 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
@@ -172,7 +172,7 @@ sound {
 			"Headphones", "HP_OUT",
 			"Builtin Speaker", "Speaker Amp OUTR",
 			"Speaker Amp INR", "LINE_OUT";
-		simple-audio-card,hp-det-gpio = <&gpio3 20 GPIO_ACTIVE_HIGH>;
+		simple-audio-card,hp-det-gpios = <&gpio3 20 GPIO_ACTIVE_HIGH>;
 
 		simple-audio-card,cpu {
 			sound-dai = <&sai2>;
diff --git a/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi b/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
index 1b39514d5c12aafc..bb37a32ce4616d9f 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
@@ -241,7 +241,7 @@ sound {
 			"Headset Mic", "MICBIAS",
 			"IN3R", "Headset Mic",
 			"DMICDAT", "Digital Mic";
-		simple-audio-card,hp-det-gpio = <&gpio3 9 GPIO_ACTIVE_HIGH>;
+		simple-audio-card,hp-det-gpios = <&gpio3 9 GPIO_ACTIVE_HIGH>;
 
 		simple-audio-card,cpu {
 			sound-dai = <&sai2>;
-- 
2.34.1


