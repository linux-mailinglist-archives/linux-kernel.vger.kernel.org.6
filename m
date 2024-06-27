Return-Path: <linux-kernel+bounces-232008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C71B991A17C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 10:32:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F05B2B219A5
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 08:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60D3112D214;
	Thu, 27 Jun 2024 08:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b="wRIwt8ID"
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D02811E0;
	Thu, 27 Jun 2024 08:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=208.88.110.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719477107; cv=none; b=HA9QN7/p2iKnPb8xVOl6zU2WnWc/L/UYRicKdp7zFb6PE9yx3kZzpdmCIOmUXInimCrxvtvHBHZLULpnuvvCuhM1cmFdyG2+4DVp9vpgNL66BvQzVUGtIJKML1hIYRun8Luqh/9hJPI+BCJPFfsU5Lbz3zuaPt1EeZ1arsfnLbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719477107; c=relaxed/simple;
	bh=++IoEURWdpmI3DujhCudBy0aPmPVNND4JEKhvgIVMOc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=H0ChyAu9d46qYjj4fjWPUtFDuTbVSuZIzVA7CYK6fCScyurSHcrdAg6IbQvFd1P9/721WE0u/lHr60acCtjob6INf44lW1veAmdx/9I5awIZOXglKGWAVr3ZiT2hffvl1d55s4vS5U7WoX540oFcO2IY0skJwlEglsW9J8C5s4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com; spf=pass smtp.mailfrom=savoirfairelinux.com; dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b=wRIwt8ID; arc=none smtp.client-ip=208.88.110.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=savoirfairelinux.com
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 478C69C4232;
	Thu, 27 Jun 2024 04:31:37 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id UVveuKWVRExp; Thu, 27 Jun 2024 04:31:35 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 2C34E9C5704;
	Thu, 27 Jun 2024 04:31:35 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 2C34E9C5704
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1719477095; bh=NILLEYMuf5ya6yxHJeCsZ7WE1bY5G5zWYOd3TKCd0iM=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=wRIwt8IDqVFMA45sQRQvXq8bUe7cYQbEtIN/p/RJPM9zp77opXxtOWE42jMJC0OJz
	 UvW+4z2f51jOhiFdGRulvZqSM9pepNn+d1uIHXQIuYuoHesPT9fRn64V0C+k/KCXGM
	 hByRxaA/t/Ff5NlVg3YhTV+/eCXVmQ8SOAJF1PaQQWtvKrbZz1qtyJSebNTmX7mqqZ
	 O+jwKjWX3g2rpyVdm5TSkbfT6Q2GbOLhJWfbnRNspZXrNVe0vwStZRZV8LlhRJ77gb
	 N1Y/DvjscaUac0ugq5NiA+ougW2Hgk/aB7qadnCpwbJT0OsZajELFugkJXYSgn+bOL
	 Nz+DyOrxq3OGQ==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id 5NfSTpLf_Lja; Thu, 27 Jun 2024 04:31:35 -0400 (EDT)
Received: from gerard.rennes.sfl (80-15-101-118.ftth.fr.orangecustomers.net [80.15.101.118])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 284559C4232;
	Thu, 27 Jun 2024 04:31:32 -0400 (EDT)
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
Subject: [PATCH v6 0/7] ASoC: fsl-asoc-card: add S/PDIF controller support
Date: Thu, 27 Jun 2024 10:30:57 +0200
Message-Id: <20240627083104.123357-1-elinor.montmasson@savoirfairelinux.com>
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

This is the v6 of the series of patches aiming to make the machine
driver `fsl-asoc-card` compatible with S/PDIF controllers on imx boards.
The main goal is to allow the use of S/PDIF controllers with ASRC
modules.

The `imx-spdif` machine driver already has specific support for S/PDIF
controllers but doesn't support using an ASRC with it. However, the
`fsl-asoc-card` machine driver has the necessary code to create a sound
card which can use an ASRC module.
It is then possible to extend the support for S/PDIF audio cards by
merging the `imx-spdif` driver into `fsl-asoc-card`.

The first three patches adapt the `fsl-asoc-card` driver to support
multiple codec use cases.
The driver can get 2 codec phandles from the device tree, and
codec-related variables are doubled.
`for_each_codecs` macros are also used when possible to ease adding
other multi-codec use cases in the future.
It makes possible to use the two S/PDIF dummy codec drivers
`spdif_receiver` and `spdif_transmitter` instead of `snd-soc-dummy`,
which was used in `imx-spdif`.

The fourth patch merges the S/PDIF support from `imx-spdif` to
`fsl-asoc-card`.
`fsl-asoc-card` offers the same functionalities as `imx-spdif` did, but
this merge also extends the S/PDIF support with the possibility of using
an ASRC.
Compatible "fsl,imx-audio-spdif" is kept, but `fsl-asoc-card` uses
different DT properties compared to `imx-spdif`:
* The "spdif-controller" property from `imx-spdif` is named "audio-cpu"
  in `fsl-asoc-card`.
* `fsl-asoc-card` uses codecs explicitly declared in DT with
  "audio-codec". With an S/PDIF, codec drivers `spdif_transmitter` and
  `spdif_receiver` should be used. Driver `imx-spdif` used instead the
  dummy codec and a pair of boolean properties, "spdif-in" and
  "spdif-out".
Backward compatibility is therefore implemented in `fsl-asoc-card`.
However, it is recommended to use the new properties when needed.
Especially, declaring and using S/PDIF transmitter and/or receiver nodes
is better than using the dummy codec.

The last three patches update the device tree bindings of
`fsl-asoc-card` and update all in-tree device trees to use the
`fsl-asoc-card` properties.
Note that as the old properties are still supported:
* previous versions of in-tree device trees are still supported.
* out-of-tree device trees are still supported.

This series of patches was successfully built for arm64 and x86 on top
of the latest=C2=A0"for-next" branch of the ASoC git tree on the 26th of Ju=
ne
2024.
These modifications have also been tested on an i.MX8MN evaluation board
with a linux kernel RT v6.1.26-rt8.

If you have any questions or remarks about these commits, don't hesitate
to reply to this message.

Best regards,
Elinor Montmasson


Changelog:
v5 -> v6:
* Remove applied patch "ASoC: fsl-asoc-card: set priv->pdev before using
  it".
* Add backward compatibility with `imx-spdif` DT properties.
* Squash removal of `imx-spdif.yaml` into patch updating
  `fsl-asoc-card.yaml`.
* `fsl-asoc-card.yaml`: fix indentation, document use of compatible
  "fsl,imx-audio-spdif" only with "fsl,imx-sabreauto-spdif" or
  "fsl,imx6sx-sdb-spdif".
* Explain better in commit messages why there are new DT properties that
  can be used with "fsl,imx-audio-spdif" and what are the benefits to
  use them.=20
* v5 patch series at :
https://lore.kernel.org/all/20240620132511.4291-1-elinor.montmasson@savoirf=
airelinux.com/

v4 -> v5:
* Focus the contribution to bringing S/PDIF / ASRC support.
* Instead of creating a new compatible for the S/PDIF `fsl-asoc-card`
  support, merge the driver `imx-spdif` into `fsl-asoc-card`, and keep
  the compatible. It preserves the base S/PDIF audio card support but also
  extends it with the possibility to use an ASRC. It also reduces code and
  driver duplication.
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


Elinor Montmasson (7):
  ASoC: fsl-asoc-card: add support for dai links with multiple codecs
  ASoC: fsl-asoc-card: add second dai link component for codecs
  ASoC: fsl-asoc-card: add compatibility to use 2 codecs in dai-links
  ASoC: fsl-asoc-card: merge spdif support from imx-spdif.c
  ASoC: dt-bindings: update fsl-asoc-card bindings after imx-spdif merge
  arm64: dts: imx8m: update spdif sound card node properties
  ARM: dts: imx6: update spdif sound card node properties

 .../bindings/sound/fsl,imx-audio-spdif.yaml   |  66 ---
 .../bindings/sound/fsl-asoc-card.yaml         |  53 ++-
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
 sound/soc/fsl/fsl-asoc-card.c                 | 383 ++++++++++++------
 sound/soc/fsl/imx-spdif.c                     | 103 -----
 23 files changed, 453 insertions(+), 352 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/fsl,imx-audio-s=
pdif.yaml
 delete mode 100644 sound/soc/fsl/imx-spdif.c

--=20
2.34.1


