Return-Path: <linux-kernel+bounces-222691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 077CF9105C8
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 15:26:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED6911C20B9E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 13:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93BB01AD3F0;
	Thu, 20 Jun 2024 13:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b="Qk/sR5k4"
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD4E51ACE94;
	Thu, 20 Jun 2024 13:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=208.88.110.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718889984; cv=none; b=aegdqvDxh6PGQrjZyiuipaXdhxWUsep9nPAX1IyM1L6E9kc/YJ/Ib64lD3G4+d5IIEE+9ahSu1fVMjZBEEkjEJqnOJ9BUNN4jHcmrbHWTl4MsHqrwuYILEgycct8cngqJ35drqu0q3aJpSGYCU3ceVd3AR6+pmlnpYqOpkXfz9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718889984; c=relaxed/simple;
	bh=skBpDlqyjwQaFn99kQpKQNX/zKajEVFtRHZv8Un2Y2o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=JsiWafaeoVTdRf89UJcTt0TZFIQbGQwrAzaYY7ZxraGZsR9vS2HXKjBuzsIgrAJGgoEnw22BhSRfJxvOqiJSHgEb4jZalNXUiqPXZGD1Hu5QJH8HPljcA20ALZZEmL8zk7zY1jEL2YUAxtXoLk2Z0Ml6JCrDDIo1YU/UnPrzmEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com; spf=pass smtp.mailfrom=savoirfairelinux.com; dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b=Qk/sR5k4; arc=none smtp.client-ip=208.88.110.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=savoirfairelinux.com
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 6C2D39C3240;
	Thu, 20 Jun 2024 09:26:13 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id tWZLTMGpjfJE; Thu, 20 Jun 2024 09:26:11 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 7B16E9C5625;
	Thu, 20 Jun 2024 09:26:11 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 7B16E9C5625
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1718889971; bh=j97G0da8OsHXoIQTZAx0D9lInyeaXOz7op8GRSt10VM=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=Qk/sR5k4Lp2oSnWyvu7y0zssZpxpu+oiUtS4Cc+5D3G102f8GQvstlSr10k1LmuNV
	 HjcTrshIvmyuktL2qf6dSyB7jo/vjeC3JeDnegVr9DvQnbvNzmF5pVfmDFIkd989CQ
	 tUfa1NUfk4GSqwyRaBqdD4Br9LTB/wh+UDX/m2GWyjrAWXXnn1we63pLw1llMtIpvl
	 9a7t5g42je8MJlY2iLWg1wgri6ejfevNwqhVRtKQg6KHHt4Esw2UXrwLQG+BnlKyKE
	 I7wCu0nYSdMP6s1yw0GuM6skRsqAKdVg9hM6A6wmhd0n2B78rvWvqTSeJsdddzhqMg
	 ekrx6qFa3mNpA==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id 84fPbdbD_-bf; Thu, 20 Jun 2024 09:26:11 -0400 (EDT)
Received: from gerard.rennes.sfl (lmontsouris-657-1-69-118.w80-15.abo.wanadoo.fr [80.15.101.118])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 76F0D9C54A8;
	Thu, 20 Jun 2024 09:26:08 -0400 (EDT)
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
Subject: [PATCHv5 0/9] ASoC: fsl-asoc-card: add S/PDIF controller
Date: Thu, 20 Jun 2024 15:25:02 +0200
Message-Id: <20240620132511.4291-1-elinor.montmasson@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=quoted-printable
Content-Transfer-Encoding: quoted-printable

Hello,

This is the v5 of the series of patches aiming to make the machine
driver `fsl-asoc-card` compatible with S/PDIF controllers on imx boards.
The main goal is to allow the use of S/PDIF controllers with ASRC
modules.

The `imx-spdif` machine driver already has specific support for S/PDIF
controllers but doesn't support using an ASRC with it. However, the
`fsl-asoc-card` machine driver has the necessary code to create a sound
card which can use an ASRC module.
It is then possible to extend the support for S/PDIF audio cards by
merging the `imx-spdif` driver into `fsl-asoc-card`.

The first patch fixes a NULL pointer dereference in `fsl-asoc-card`
which occurs when the function "fsl_asoc_card_audmux_init()" prints
error logs.

The next three patches adapt the `fsl-asoc-card` driver to support
multiple codec use cases.
The driver can get 2 codec phandles from the device tree, and
codec-related variables are doubled.
`for_each_codecs` macros are also used when possible to ease adding
other multi-codec use cases in the future.
This makes possible to use the two S/PDIF dummy codec drivers
`spdif_receiver` and `spdif_transmitter` instead of `snd-soc-dummy`,
which was used in `imx-spdif`.

The fifth patch merges the S/PDIF support from `imx-spdif` to
`fsl-asoc-card`.
`fsl-asoc-card` offers the same functionalities as `imx-spdif` did, but
this merge also extends the S/PDIF support with the possibility of using
an ASRC.
Compatible "fsl,imx-audio-spdif" is kept, but some DT properties have to
be updated in device trees to match those of `fsl-asoc-card`:
* "spdif-controller" is now "audio-cpu" in `fsl-asoc-card`.
* "spdif-in" and "spdif-out" are now replaced by the "audio-codec"
  property of `fsl-asoc-card`. S/PDIF specific dummy codecs should be
  used with `fsl-asoc-card`, and therefore declared in device trees.

The last four patches update the device tree bindings of
`fsl-asoc-card`, remove the now obsolete binding of `imx-spdif`, and
update all device trees using the `fsl,imx-audio-spdif` compatible.

This series of patches was successfully built for arm64 and x86 on top
of the latest=C2=A0"for-next" branch of the ASoC git tree on the 19th of Ju=
ne
2024.
These modifications have also been tested on an i.MX8MN evaluation board
with a linux kernel RT v6.1.26-rt8.

If you have any questions or remarks about these commits, don't hesitate
to reply to this message.

Best regards,
Elinor Montmasson

Changelog:
v4 -> v5:
* Focus the contribution to bringing S/PDIF / ASRC support.
* Instead of creating a new compatible for the S/PDIF `fsl-asoc-card`
  support, merge the driver `imx-spdif` into `fsl-asoc-card`, and keep
  the compatible. It preserves the base S/PDIF audio card support but
  also extends it with the possibility to use an ASRC.
  It also reduces code and driver duplication.
* Following driver merge, adapt device trees using "fsl,imx-audio-spdif"
  compatible.=20
* Use more `for_each_codecs` macros in `fsl-asoc-card` when adding
  multi-codec support.
* Remove patches about new device-tree bindings that were not relevant
  for an S/PDIF specific support.
* Improve DT schema changes.
* Move `priv->pdev` assignment earlier in "fsl_asoc_card_probe()" to fix
  a NULL pointer dereference in "fsl_asoc_card_audmux_init()".
* v4 patch series at :
https://lore.kernel.org/all/20240515135411.343333-1-elinor.montmasson@savoi=
rfairelinux.com/

v3 -> v4:
* Use the standard TDM bidings, as defined in "tdm-slot.txt", for the
  new optional DT bindings setting the TDM slots number and width.
* Use the clock DT bindings to optionally specify the CPU DAI system
  clock frequency, instead of a dedicated new binding.
* Rename the new DT binding "cpu-sysclk-dir-out" to
  "cpu-system-clock-direction-out" to better follow the style of the
  simple-card driver.
* Merge TX an RX bindings for CPU DAI system-clock, to better follow the
  style of the simple-card driver, and also as there was no use case in
  fsl-asoc-card where TX and RX settings had to be different.
* Add the documentation for the new bindings in the new DT schema
  bindings documentation. Also add an example with the generic codec.
* v3 patch series at :
https://lore.kernel.org/alsa-devel/20231218124058.2047167-1-elinor.montmass=
on@savoirfairelinux.com/

v2 -> v3:
* When the bitmaster or framemaster are retrieved from the device tree,
  the driver will now compare them with the two codecs possibly given in
  device tree, and not just the first codec.
* Improve driver modifications to use multiple codecs for better
  integration of future multi-codec use cases:
    * Use `for_each_codec` macros when possible.
    * `fsl_asoc_card_priv` struct now has 2 `codec_priv` as the driver
      can currently retrieve 2 codec phandles from the device tree.
* Fix subject of patch 10/10 to follow the style of the subsystem
* v2 patch series at:
https://lore.kernel.org/alsa-devel/20231027144734.3654829-1-elinor.montmass=
on@savoirfairelinux.com/

v1 -> v2:
* Replace use of the dummy codec by the pair of codecs spdif_receiver /
  spdif_transmitter.
* Adapt how dai links codecs are used to take into account the
  possibility for multiple codecs per link.
* Change compatible name.
* Adapt driver to be able to register two codecs given in the device
  tree.
* v1 patch series at:
https://lore.kernel.org/alsa-devel/20230901144550.520072-1-elinor.montmasso=
n@savoirfairelinux.com/

Elinor Montmasson (9):
  ASoC: fsl-asoc-card: set priv->pdev before using it
  ASoC: fsl-asoc-card: add support for dai links with multiple codecs
  ASoC: fsl-asoc-card: add second dai link component for codecs
  ASoC: fsl-asoc-card: add compatibility to use 2 codecs in dai-links
  ASoC: fsl-asoc-card: merge spdif support from imx-spdif.c
  ASoC: dt-bindings: fsl-asoc-card: add compatible string for spdif
  ASoC: dt-bindings: imx-audio-spdif: remove binding
  arm64: dts: imx8m: update spdif sound card node properties
  ARM: dts: imx6: update spdif sound card node properties

 .../bindings/sound/fsl,imx-audio-spdif.yaml   |  66 ----
 .../bindings/sound/fsl-asoc-card.yaml         |  30 +-
 arch/arm/boot/dts/nxp/imx/imx6q-cm-fx6.dts    |  15 +-
 arch/arm/boot/dts/nxp/imx/imx6q-prti6q.dts    |  15 +-
 arch/arm/boot/dts/nxp/imx/imx6q-tbs2910.dts   |   9 +-
 arch/arm/boot/dts/nxp/imx/imx6qdl-apalis.dtsi |  15 +-
 .../arm/boot/dts/nxp/imx/imx6qdl-apf6dev.dtsi |   9 +-
 .../arm/boot/dts/nxp/imx/imx6qdl-colibri.dtsi |  15 +-
 .../arm/boot/dts/nxp/imx/imx6qdl-cubox-i.dtsi |   9 +-
 .../dts/nxp/imx/imx6qdl-hummingboard.dtsi     |   9 +-
 .../boot/dts/nxp/imx/imx6qdl-sabreauto.dtsi   |   9 +-
 .../boot/dts/nxp/imx/imx6qdl-wandboard.dtsi   |   9 +-
 .../arm/boot/dts/nxp/imx/imx6sx-sabreauto.dts |   9 +-
 arch/arm/boot/dts/nxp/imx/imx6sx-sdb.dtsi     |   9 +-
 arch/arm/configs/imx_v6_v7_defconfig          |   1 -
 arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi |  15 +-
 arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi |  15 +-
 arch/arm64/boot/dts/freescale/imx8mq-evk.dts  |  24 +-
 arch/arm64/configs/defconfig                  |   1 -
 sound/soc/fsl/Kconfig                         |  10 +-
 sound/soc/fsl/Makefile                        |   2 -
 sound/soc/fsl/fsl-asoc-card.c                 | 361 ++++++++++++------
 sound/soc/fsl/imx-spdif.c                     | 103 -----
 23 files changed, 408 insertions(+), 352 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/fsl,imx-audio-s=
pdif.yaml
 delete mode 100644 sound/soc/fsl/imx-spdif.c

--=20
2.34.1


