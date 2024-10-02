Return-Path: <linux-kernel+bounces-347791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FD3F98DEB5
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 17:19:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDA631F2666B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 15:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DDDA1D172C;
	Wed,  2 Oct 2024 15:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=perex.cz header.i=@perex.cz header.b="DtMR24Hk"
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5861D1515;
	Wed,  2 Oct 2024 15:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.48.224.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727882202; cv=none; b=i3/8k6UFBpONQa1oSsPATAqibj6I+AMhww3S7QivnxcPAbKrnl2/8JbPzQfKxp5UeuIBjeMku/JTOAkCXgjHQD/gQr9r7C68tXaF6Po3Ni7WPVOgMkehqb724IaAdSgY+Xk4Euk/KJ5AK13l4jAY0v0EnuPdSEG6JiogQDbE3Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727882202; c=relaxed/simple;
	bh=xPZjZzew1QtrAr2pTh/DYxbHOFNcJzwkd7Xmhr/wbE8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JYsehvnkQVX/lv3D4I9/kVoVT9H79nYErL5l1FbKdeOT9xg/HRgboUtveuSpQ1ISF+sNeZECV9AEwWhZsCI/QB2oB8SMOSuT3/sQ1ekVbR7LioARS5PjGs2GF5sdPiJZSOPejHlseOa0x6Jg+Pk/00atnSiAjWgPz46BJbfznTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=perex.cz; spf=pass smtp.mailfrom=perex.cz; dkim=pass (1024-bit key) header.d=perex.cz header.i=@perex.cz header.b=DtMR24Hk; arc=none smtp.client-ip=77.48.224.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=perex.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=perex.cz
Received: from mail1.perex.cz (localhost [127.0.0.1])
	by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 940984485;
	Wed,  2 Oct 2024 17:16:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 940984485
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
	t=1727882194; bh=xPM+lBzdAaRf7zt5BIUqNfuev2Kz7iNV9T1h9D1t1eM=;
	h=From:To:Cc:Subject:Date:From;
	b=DtMR24HkoOCeNS7Umr3FiD0+0j4YFK+D8YEqUrrqY6xqZmKWWXfsICZyR5mF2ZHGk
	 GFv4Myt3JWHsYUEc2mL/b05ZcVKOLBZzs0FogIb63xREmqktsgUqubmM0h0rNB8ufL
	 SkyvDGk7CDgfsE1fCN6rhCJVRc4skZSCWbZJ5CFY=
Received: from p1gen4.perex-int.cz (unknown [192.168.100.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: perex)
	by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
	Wed,  2 Oct 2024 17:15:43 +0200 (CEST)
From: Jaroslav Kysela <perex@perex.cz>
To: Linux Sound ML <linux-sound@vger.kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>,
	Jaroslav Kysela <perex@perex.cz>,
	linux-kernel@vger.kernel.org,
	Ban Tao <fengzheng923@gmail.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Jerome Brunet <jbrunet@baylibre.com>,
	=?UTF-8?q?Martin=20Povi=C5=A1er?= <povik+lin@cutebit.org>,
	Peter Rosin <peda@axentia.se>,
	Clemens Ladisch <clemens@ladisch.de>,
	Takashi Sakamoto <o-takashi@sakamocchi.jp>,
	"Geoffrey D. Bennett" <g@b4.vu>,
	Shengjiu Wang <shengjiu.wang@gmail.com>,
	Xiubo Li <Xiubo.Lee@gmail.com>,
	Fabio Estevam <festevam@gmail.com>,
	Nicolin Chen <nicoleotsuka@gmail.com>,
	"J.M.B. Downing" <jonathan.downing@nautel.com>,
	Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>,
	Vladimir Zapolskiy <vz@mleia.com>,
	Herve Codina <herve.codina@bootlin.com>,
	Cezary Rojewski <cezary.rojewski@intel.com>,
	Liam Girdwood <liam.r.girdwood@linux.intel.com>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
	Kiseok Jo <kiseok.jo@irondevice.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Daniel Mack <zonque@gmail.com>,
	Stephan Gerhold <stephan@gerhold.net>,
	Peter Ujfalusi <peter.ujfalusi@gmail.com>,
	Jarkko Nikula <jarkko.nikula@bitmer.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Sylwester Nawrocki <s.nawrocki@samsung.com>,
	Vinod Koul <vkoul@kernel.org>,
	Sanyog Kale <sanyog.r.kale@intel.com>,
	Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	Shenghao Ding <shenghao-ding@ti.com>,
	Kevin Lu <kevin-lu@ti.com>,
	Baojun Xu <baojun.xu@ti.com>,
	M R Swami Reddy <mr.swami.reddy@ti.com>,
	Vishwas A Deshpande <vishwas.a.deshpande@ti.com>,
	Kirill Marinushkin <kmarinushkin@birdec.com>,
	Kevin Cernekee <cernekee@chromium.org>,
	Anton Yakovlev <anton.yakovlev@opensynergy.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
Subject: [PATCH] MAINTAINERS: ALSA: use linux-sound@vger.kernel.org list
Date: Wed,  2 Oct 2024 17:15:36 +0200
Message-ID: <20241002151536.1855793-1-perex@perex.cz>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

We are now using the linux-sound@vger.kernel.org list for kernel
related work. This patch converts all remaining entries that reference
the former alsa-devel mailing list.

All ALSA developers should subscribe to the linux-sound
mailing list. Thank you.

Cc: linux-kernel@vger.kernel.org
Cc: Ban Tao <fengzheng923@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: Nuno Sá <nuno.sa@analog.com>
Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: Jerome Brunet <jbrunet@baylibre.com>
Cc: Martin Povišer <povik+lin@cutebit.org>
Cc: Peter Rosin <peda@axentia.se>
Cc: Clemens Ladisch <clemens@ladisch.de>
Cc: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: Geoffrey D. Bennett <g@b4.vu>
Cc: Shengjiu Wang <shengjiu.wang@gmail.com>
Cc: Xiubo Li <Xiubo.Lee@gmail.com>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: J.M.B. Downing <jonathan.downing@nautel.com>
Cc: Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>
Cc: Vladimir Zapolskiy <vz@mleia.com>
Cc: Herve Codina <herve.codina@bootlin.com>
Cc: Cezary Rojewski <cezary.rojewski@intel.com>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Cc: Bard Liao <yung-chuan.liao@linux.intel.com>
Cc: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Cc: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>
Cc: Kiseok Jo <kiseok.jo@irondevice.com>
Cc: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: Daniel Mack <zonque@gmail.com>
Cc: Stephan Gerhold <stephan@gerhold.net>
Cc: Peter Ujfalusi <peter.ujfalusi@gmail.com>
Cc: Jarkko Nikula <jarkko.nikula@bitmer.com>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc: Vinod Koul <vkoul@kernel.org>
Cc: Sanyog Kale <sanyog.r.kale@intel.com>
Cc: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
Cc: Olivier Moysan <olivier.moysan@foss.st.com>
Cc: Shenghao Ding <shenghao-ding@ti.com>
Cc: Kevin Lu <kevin-lu@ti.com>
Cc: Baojun Xu <baojun.xu@ti.com>
Cc: M R Swami Reddy <mr.swami.reddy@ti.com>
Cc: Vishwas A Deshpande <vishwas.a.deshpande@ti.com>
Cc: Kirill Marinushkin <kmarinushkin@birdec.com>
Cc: Kevin Cernekee <cernekee@chromium.org>
Cc: Anton Yakovlev <anton.yakovlev@opensynergy.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
Signed-off-by: Jaroslav Kysela <perex@perex.cz>
---
 MAINTAINERS | 86 ++++++++++++++++++++++++++---------------------------
 1 file changed, 43 insertions(+), 43 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index c27f3190737f..a0a9a9f020ed 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -860,7 +860,7 @@ F:	drivers/crypto/allwinner/
 
 ALLWINNER DMIC DRIVERS
 M:	Ban Tao <fengzheng923@gmail.com>
-L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
+L:	linux-sound@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/sound/allwinner,sun50i-h6-dmic.yaml
 F:	sound/soc/sunxi/sun50i-dmic.c
@@ -1517,7 +1517,7 @@ F:	drivers/iio/gyro/adxrs290.c
 ANALOG DEVICES INC ASOC CODEC DRIVERS
 M:	Lars-Peter Clausen <lars@metafoo.de>
 M:	Nuno Sá <nuno.sa@analog.com>
-L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
+L:	linux-sound@vger.kernel.org
 S:	Supported
 W:	http://wiki.analog.com/
 W:	https://ez.analog.com/linux-software-drivers
@@ -1594,7 +1594,7 @@ F:	drivers/rtc/rtc-goldfish.c
 AOA (Apple Onboard Audio) ALSA DRIVER
 M:	Johannes Berg <johannes@sipsolutions.net>
 L:	linuxppc-dev@lists.ozlabs.org
-L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
+L:	linux-sound@vger.kernel.org
 S:	Maintained
 F:	sound/aoa/
 
@@ -2091,7 +2091,7 @@ F:	drivers/crypto/amlogic/
 
 ARM/Amlogic Meson SoC Sound Drivers
 M:	Jerome Brunet <jbrunet@baylibre.com>
-L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
+L:	linux-sound@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/sound/amlogic*
 F:	sound/soc/meson/
@@ -2129,7 +2129,7 @@ F:	drivers/*/*alpine*
 ARM/APPLE MACHINE SOUND DRIVERS
 M:	Martin Povišer <povik+lin@cutebit.org>
 L:	asahi@lists.linux.dev
-L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
+L:	linux-sound@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/sound/adi,ssm3515.yaml
 F:	Documentation/devicetree/bindings/sound/apple,*
@@ -3732,7 +3732,7 @@ F:	arch/arm/boot/dts/microchip/at91-tse850-3.dts
 
 AXENTIA ASOC DRIVERS
 M:	Peter Rosin <peda@axentia.se>
-L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
+L:	linux-sound@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/sound/axentia,*
 F:	sound/soc/atmel/tse850-pcm5142.c
@@ -4851,7 +4851,7 @@ F:	include/uapi/linux/bsg.h
 
 BT87X AUDIO DRIVER
 M:	Clemens Ladisch <clemens@ladisch.de>
-L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
+L:	linux-sound@vger.kernel.org
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git
 F:	Documentation/sound/cards/bt87x.rst
@@ -4913,7 +4913,7 @@ F:	drivers/net/can/bxcan.c
 
 C-MEDIA CMI8788 DRIVER
 M:	Clemens Ladisch <clemens@ladisch.de>
-L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
+L:	linux-sound@vger.kernel.org
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git
 F:	sound/pci/oxygen/
@@ -8252,7 +8252,7 @@ F:	drivers/edac/ti_edac.c
 
 EDIROL UA-101/UA-1000 DRIVER
 M:	Clemens Ladisch <clemens@ladisch.de>
-L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
+L:	linux-sound@vger.kernel.org
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git
 F:	sound/usb/misc/ua101.c
@@ -8814,7 +8814,7 @@ F:	drivers/net/can/usb/f81604.c
 FIREWIRE AUDIO DRIVERS and IEC 61883-1/6 PACKET STREAMING ENGINE
 M:	Clemens Ladisch <clemens@ladisch.de>
 M:	Takashi Sakamoto <o-takashi@sakamocchi.jp>
-L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
+L:	linux-sound@vger.kernel.org
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git
 F:	include/uapi/sound/firewire.h
@@ -8888,7 +8888,7 @@ F:	drivers/input/joystick/fsia6b.c
 
 FOCUSRITE SCARLETT2 MIXER DRIVER (Scarlett Gen 2+ and Clarett)
 M:	Geoffrey D. Bennett <g@b4.vu>
-L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
+L:	linux-sound@vger.kernel.org
 S:	Maintained
 W:	https://github.com/geoffreybennett/scarlett-gen2
 B:	https://github.com/geoffreybennett/scarlett-gen2/issues
@@ -9209,7 +9209,7 @@ M:	Shengjiu Wang <shengjiu.wang@gmail.com>
 M:	Xiubo Li <Xiubo.Lee@gmail.com>
 R:	Fabio Estevam <festevam@gmail.com>
 R:	Nicolin Chen <nicoleotsuka@gmail.com>
-L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
+L:	linux-sound@vger.kernel.org
 L:	linuxppc-dev@lists.ozlabs.org
 S:	Maintained
 F:	sound/soc/fsl/fsl*
@@ -9219,7 +9219,7 @@ FREESCALE SOC LPC32XX SOUND DRIVERS
 M:	J.M.B. Downing <jonathan.downing@nautel.com>
 M:	Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>
 R:	Vladimir Zapolskiy <vz@mleia.com>
-L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
+L:	linux-sound@vger.kernel.org
 L:	linuxppc-dev@lists.ozlabs.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/sound/nxp,lpc3220-i2s.yaml
@@ -9227,7 +9227,7 @@ F:	sound/soc/fsl/lpc3xxx-*
 
 FREESCALE SOC SOUND QMC DRIVER
 M:	Herve Codina <herve.codina@bootlin.com>
-L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
+L:	linux-sound@vger.kernel.org
 L:	linuxppc-dev@lists.ozlabs.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/sound/fsl,qmc-audio.yaml
@@ -11154,7 +11154,7 @@ F:	drivers/iio/pressure/dps310.c
 
 INFINEON PEB2466 ASoC CODEC
 M:	Herve Codina <herve.codina@bootlin.com>
-L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
+L:	linux-sound@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/sound/infineon,peb2466.yaml
 F:	sound/soc/codecs/peb2466.c
@@ -11317,7 +11317,7 @@ M:	Bard Liao <yung-chuan.liao@linux.intel.com>
 M:	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
 M:	Kai Vehmanen <kai.vehmanen@linux.intel.com>
 R:	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>
-L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
+L:	linux-sound@vger.kernel.org
 S:	Supported
 F:	sound/soc/intel/
 
@@ -12001,7 +12001,7 @@ F:	drivers/tty/ipwireless/
 
 IRON DEVICE AUDIO CODEC DRIVERS
 M:	Kiseok Jo <kiseok.jo@irondevice.com>
-L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
+L:	linux-sound@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/sound/irondevice,*
 F:	sound/soc/codecs/sma*
@@ -13952,7 +13952,7 @@ F:	drivers/media/i2c/max96717.c
 
 MAX9860 MONO AUDIO VOICE CODEC DRIVER
 M:	Peter Rosin <peda@axentia.se>
-L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
+L:	linux-sound@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/sound/max9860.txt
 F:	sound/soc/codecs/max9860.*
@@ -15085,7 +15085,7 @@ F:	drivers/spi/spi-at91-usart.c
 
 MICROCHIP AUDIO ASOC DRIVERS
 M:	Claudiu Beznea <claudiu.beznea@tuxon.dev>
-L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
+L:	linux-sound@vger.kernel.org
 S:	Supported
 F:	Documentation/devicetree/bindings/sound/atmel*
 F:	Documentation/devicetree/bindings/sound/axentia,tse850-pcm5142.txt
@@ -15957,7 +15957,7 @@ F:	include/linux/mtd/*nand*.h
 
 NATIVE INSTRUMENTS USB SOUND INTERFACE DRIVER
 M:	Daniel Mack <zonque@gmail.com>
-L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
+L:	linux-sound@vger.kernel.org
 S:	Maintained
 W:	http://www.native-instruments.com
 F:	sound/usb/caiaq/
@@ -16728,7 +16728,7 @@ F:	drivers/extcon/extcon-ptn5150.c
 
 NXP SGTL5000 DRIVER
 M:	Fabio Estevam <festevam@gmail.com>
-L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
+L:	linux-sound@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/sound/fsl,sgtl5000.yaml
 F:	sound/soc/codecs/sgtl5000*
@@ -16752,7 +16752,7 @@ K:	"nxp,tda998x"
 
 NXP TFA9879 DRIVER
 M:	Peter Rosin <peda@axentia.se>
-L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
+L:	linux-sound@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/sound/nxp,tfa9879.yaml
 F:	sound/soc/codecs/tfa9879*
@@ -16764,7 +16764,7 @@ F:	drivers/nfc/nxp-nci
 
 NXP/Goodix TFA989X (TFA1) DRIVER
 M:	Stephan Gerhold <stephan@gerhold.net>
-L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
+L:	linux-sound@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/sound/nxp,tfa989x.yaml
 F:	sound/soc/codecs/tfa989x.c
@@ -16850,7 +16850,7 @@ F:	include/uapi/misc/ocxl.h
 OMAP AUDIO SUPPORT
 M:	Peter Ujfalusi <peter.ujfalusi@gmail.com>
 M:	Jarkko Nikula <jarkko.nikula@bitmer.com>
-L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
+L:	linux-sound@vger.kernel.org
 L:	linux-omap@vger.kernel.org
 S:	Maintained
 F:	sound/soc/ti/n810.c
@@ -17407,7 +17407,7 @@ F:	include/linux/pm_opp.h
 
 OPL4 DRIVER
 M:	Clemens Ladisch <clemens@ladisch.de>
-L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
+L:	linux-sound@vger.kernel.org
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git
 F:	sound/drivers/opl4/
@@ -18790,7 +18790,7 @@ F:	drivers/crypto/intel/qat/
 
 QCOM AUDIO (ASoC) DRIVERS
 M:	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
-L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
+L:	linux-sound@vger.kernel.org
 L:	linux-arm-msm@vger.kernel.org
 S:	Supported
 F:	Documentation/devicetree/bindings/soc/qcom/qcom,apr*
@@ -19652,7 +19652,7 @@ F:	drivers/net/ethernet/renesas/rtsn.*
 
 RENESAS IDT821034 ASoC CODEC
 M:	Herve Codina <herve.codina@bootlin.com>
-L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
+L:	linux-sound@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/sound/renesas,idt821034.yaml
 F:	sound/soc/codecs/idt821034.c
@@ -20403,7 +20403,7 @@ F:	security/safesetid/
 
 SAMSUNG AUDIO (ASoC) DRIVERS
 M:	Sylwester Nawrocki <s.nawrocki@samsung.com>
-L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
+L:	linux-sound@vger.kernel.org
 S:	Maintained
 B:	mailto:linux-samsung-soc@vger.kernel.org
 F:	Documentation/devicetree/bindings/sound/samsung*
@@ -20939,7 +20939,7 @@ F:	drivers/media/rc/serial_ir.c
 
 SERIAL LOW-POWER INTER-CHIP MEDIA BUS (SLIMbus)
 M:	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
-L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
+L:	linux-sound@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/slimbus/
 F:	drivers/slimbus/
@@ -21373,7 +21373,7 @@ F:	Documentation/devicetree/bindings/i2c/socionext,synquacer-i2c.yaml
 F:	drivers/i2c/busses/i2c-synquacer.c
 
 SOCIONEXT UNIPHIER SOUND DRIVER
-L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
+L:	linux-sound@vger.kernel.org
 S:	Orphan
 F:	sound/soc/uniphier/
 
@@ -21632,7 +21632,7 @@ F:	tools/testing/selftests/alsa
 
 SOUND - COMPRESSED AUDIO
 M:	Vinod Koul <vkoul@kernel.org>
-L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
+L:	linux-sound@vger.kernel.org
 S:	Supported
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git
 F:	Documentation/sound/designs/compress-offload.rst
@@ -21695,7 +21695,7 @@ M:	Vinod Koul <vkoul@kernel.org>
 M:	Bard Liao <yung-chuan.liao@linux.intel.com>
 R:	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>
 R:	Sanyog Kale <sanyog.r.kale@intel.com>
-L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
+L:	linux-sound@vger.kernel.org
 S:	Supported
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire.git
 F:	Documentation/driver-api/soundwire/
@@ -22168,7 +22168,7 @@ F:	kernel/static_call.c
 
 STI AUDIO (ASoC) DRIVERS
 M:	Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
-L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
+L:	linux-sound@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/sound/st,sti-asoc-card.txt
 F:	sound/soc/sti/
@@ -22189,7 +22189,7 @@ F:	drivers/media/usb/stk1160/
 STM32 AUDIO (ASoC) DRIVERS
 M:	Olivier Moysan <olivier.moysan@foss.st.com>
 M:	Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
-L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
+L:	linux-sound@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/iio/adc/st,stm32-dfsdm-adc.yaml
 F:	Documentation/devicetree/bindings/sound/st,stm32-*.yaml
@@ -22892,7 +22892,7 @@ F:	drivers/irqchip/irq-xtensa-*
 
 TEXAS INSTRUMENTS ASoC DRIVERS
 M:	Peter Ujfalusi <peter.ujfalusi@gmail.com>
-L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
+L:	linux-sound@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/sound/davinci-mcasp-audio.yaml
 F:	sound/soc/ti/
@@ -22901,7 +22901,7 @@ TEXAS INSTRUMENTS AUDIO (ASoC/HDA) DRIVERS
 M:	Shenghao Ding <shenghao-ding@ti.com>
 M:	Kevin Lu <kevin-lu@ti.com>
 M:	Baojun Xu <baojun.xu@ti.com>
-L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
+L:	linux-sound@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/sound/tas2552.txt
 F:	Documentation/devicetree/bindings/sound/ti,tas2562.yaml
@@ -23269,7 +23269,7 @@ F:	drivers/soc/ti/*
 TI LM49xxx FAMILY ASoC CODEC DRIVERS
 M:	M R Swami Reddy <mr.swami.reddy@ti.com>
 M:	Vishwas A Deshpande <vishwas.a.deshpande@ti.com>
-L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
+L:	linux-sound@vger.kernel.org
 S:	Maintained
 F:	sound/soc/codecs/isabelle*
 F:	sound/soc/codecs/lm49453*
@@ -23284,14 +23284,14 @@ F:	drivers/iio/adc/ti-lmp92064.c
 
 TI PCM3060 ASoC CODEC DRIVER
 M:	Kirill Marinushkin <kmarinushkin@birdec.com>
-L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
+L:	linux-sound@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/sound/pcm3060.txt
 F:	sound/soc/codecs/pcm3060*
 
 TI TAS571X FAMILY ASoC CODEC DRIVER
 M:	Kevin Cernekee <cernekee@chromium.org>
-L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
+L:	linux-sound@vger.kernel.org
 S:	Odd Fixes
 F:	sound/soc/codecs/tas571x*
 
@@ -23319,7 +23319,7 @@ F:	drivers/iio/adc/ti-tsc2046.c
 
 TI TWL4030 SERIES SOC CODEC DRIVER
 M:	Peter Ujfalusi <peter.ujfalusi@gmail.com>
-L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
+L:	linux-sound@vger.kernel.org
 S:	Maintained
 F:	sound/soc/codecs/twl4030*
 
@@ -23995,7 +23995,7 @@ F:	drivers/usb/storage/
 
 USB MIDI DRIVER
 M:	Clemens Ladisch <clemens@ladisch.de>
-L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
+L:	linux-sound@vger.kernel.org
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git
 F:	sound/usb/midi.*
@@ -24655,7 +24655,7 @@ VIRTIO SOUND DRIVER
 M:	Anton Yakovlev <anton.yakovlev@opensynergy.com>
 M:	"Michael S. Tsirkin" <mst@redhat.com>
 L:	virtualization@lists.linux.dev
-L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
+L:	linux-sound@vger.kernel.org
 S:	Maintained
 F:	include/uapi/linux/virtio_snd.h
 F:	sound/virtio/*
@@ -25384,7 +25384,7 @@ F:	include/xen/interface/io/usbif.h
 XEN SOUND FRONTEND DRIVER
 M:	Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
 L:	xen-devel@lists.xenproject.org (moderated for non-subscribers)
-L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
+L:	linux-sound@vger.kernel.org
 S:	Supported
 F:	sound/xen/*
 
-- 
2.46.0


