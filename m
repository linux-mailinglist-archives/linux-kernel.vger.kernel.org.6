Return-Path: <linux-kernel+bounces-293857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 467BB9585D2
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 13:29:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C66891F24D0F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 11:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69CBB18E759;
	Tue, 20 Aug 2024 11:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b="g5cctYVO"
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4297E18E048;
	Tue, 20 Aug 2024 11:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=208.88.110.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724153339; cv=none; b=hGDCBq2MO8ydnRTKFXndGmtJEA6ts43b+blO6OcNLrdcKmDehsOdG/CiV/erOoSdqa+Y3Rq5mZbZCeRZj0Z7II7oAriVSg7DschVlEJrNdGiV2vEJZUcSIk1W505EtPJPDC73m2IroIgffNDlCDX+Tx896dC4UOj2zXj7Tco01s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724153339; c=relaxed/simple;
	bh=Fw7i15Uk4ElEBQ9NuybuwhJgflJQP2cop0S91tX02HA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=mX5o4U6a6lQrhN+/9okfPXyZLQ+CnVM04mfYfSl+4nX9YODwdAnQ5K/qvlA5QvOnFMbmtjJpuB0977FowY9t7oumlbnuf7m9KKHY0ZTlj82qNWtuqh5Qb3kx4rRwn9JsO5Gv+kD8pFfCsgZ0iDw3+nxvkooTYl+XZyluk0LHO/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com; spf=pass smtp.mailfrom=savoirfairelinux.com; dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b=g5cctYVO; arc=none smtp.client-ip=208.88.110.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=savoirfairelinux.com
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id A86A79C5CFF;
	Tue, 20 Aug 2024 07:28:53 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id 6PHx-AwEQUI8; Tue, 20 Aug 2024 07:28:52 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id CF51C9C5DD8;
	Tue, 20 Aug 2024 07:28:52 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com CF51C9C5DD8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1724153332; bh=chr/7XC5IjmPlgTwemPr9SDOEWskwMTyTM/nHv8aNvk=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=g5cctYVOfrqptNDneEYQlJujj7Gz6GqBAHT7J5wAn80v50MbpoksH5XWnWDsu+afT
	 pli2mHT4I89B/6yrHLLE0J/NZs8427JkL7mWctXwLxH3NpiAeJj1ROwBorF0Ag4fhB
	 vM++QpdYn/qtlfntDMKH1VOpFRtXryD/maErta9EqJACQY2oriq5KRcSgqlbOQkfaV
	 YXdfsQHEK4F3bzLJ5Jyb1/QlYyZAMTe6Q9XT0Fe2NgwHsHzsQWIZEgpOgyehCnR+eC
	 y3OvaA9OQH+UNMZCORrRs1N/2khPItFs8345mueKXg/PDcAcXqeaEoXmoGQI+gUd6e
	 AtG00B0sFcWNw==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id 6LOSUcPF8PDX; Tue, 20 Aug 2024 07:28:52 -0400 (EDT)
Received: from gerard.rennes.sfl (80-15-101-118.ftth.fr.orangecustomers.net [80.15.101.118])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id AE2359C5CFF;
	Tue, 20 Aug 2024 07:28:50 -0400 (EDT)
From: Elinor Montmasson <elinor.montmasson@savoirfairelinux.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Mark Brown <broonie@kernel.org>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
	Shengjiu Wang <shengjiu.wang@gmail.com>,
	Xiubo Li <Xiubo.Lee@gmail.com>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	alsa-devel@alsa-project.org,
	Elinor Montmasson <elinor.montmasson@savoirfairelinux.com>
Subject: [PATCH v7 0/2] ASoC: fsl-asoc-card: add S/PDIF controller support
Date: Tue, 20 Aug 2024 13:28:25 +0200
Message-Id: <20240820112827.126380-1-elinor.montmasson@savoirfairelinux.com>
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

This is the v7 of the series of patches aiming to make the machine
driver=C2=A0'fsl-asoc-card'=C2=A0compatible with S/PDIF controllers on imx =
boards.

The core of the contribution was merged with v6 of the series.
v7 fixes the order of properties for new nodes in device-trees
so that `compatible` is first in the list as recommended.

These two patches update all in-tree device-trees to use the new
'fsl-asoc-card' properties.
Note that as the old properties are still supported by `fsl-asoc-card`:
- previous versions of in-tree device-trees are still supported.
- out-of-tree device-trees are still supported.

This series of patches was successfully built for arm64 and x86 on top
of the latest=C2=A0"for-next" branch of the ASoC git tree on the 19th of
August 2024.
These modifications have also been tested on an i.MX8MN evaluation board
with a linux kernel RT v6.1.26-rt8.

Best regards,
Elinor Montmasson


Changelog:
v6 -> v7:
- Changed the order of properties in new device-tree spdif-in/out nodes,
  so that `compatible` is first.
- v6 patch series at:
https://lore.kernel.org/all/20240627083104.123357-1-elinor.montmasson@savoi=
rfairelinux.com/

v5 -> v6:
- Remove applied patch "ASoC: fsl-asoc-card: set priv->pdev before using
  it".
- Add backward compatibility with `imx-spdif` DT properties.
- Squash removal of `imx-spdif.yaml` into patch updating
  `fsl-asoc-card.yaml`.
- `fsl-asoc-card.yaml`: fix indentation, document use of compatible
  "fsl,imx-audio-spdif" only with "fsl,imx-sabreauto-spdif" or
  "fsl,imx6sx-sdb-spdif".
- Explain better in commit messages why there are new DT properties that
  can be used with "fsl,imx-audio-spdif" and what are the benefits to
  use them.
- v5 patch series at:
https://lore.kernel.org/all/20240620132511.4291-1-elinor.montmasson@savoirf=
airelinux.com/

v4 -> v5:
- Focus the contribution to bringing S/PDIF / ASRC support.
- Instead of creating a new compatible for the S/PDIF `fsl-asoc-card`
  support, merge the driver `imx-spdif` into `fsl-asoc-card`, and keep
  the compatible. It preserves the base S/PDIF audio card support
  but also extends it with the possibility to use an ASRC.
  It also reduces code and driver duplication.
- Following driver merge, adapt device trees using "fsl,imx-audio-spdif"
  compatible.=20
- Use more `for_each_codecs` macros in `fsl-asoc-card` when adding
  multi-codec support.
- Remove patches about new device-tree bindings that were not relevant
  for an S/PDIF specific support.
- Improve DT schema changes.
- Move `priv->pdev` assignment earlier in "fsl_asoc_card_probe()" to fix
  a NULL pointer dereference in "fsl_asoc_card_audmux_init()".
- v4 patch series at:
https://lore.kernel.org/all/20240515135411.343333-1-elinor.montmasson@savoi=
rfairelinux.com/

v3 -> v4:
- Use the standard TDM bidings, as defined in "tdm-slot.txt", for the
  new optional DT bindings setting the TDM slots number and width.
- Use the clock DT bindings to optionally specify the CPU DAI system
  clock frequency, instead of a dedicated new binding.
- Rename the new DT binding "cpu-sysclk-dir-out" to
  "cpu-system-clock-direction-out" to better follow the style of the
  simple-card driver.
- Merge TX an RX bindings for CPU DAI system-clock, to better follow the
  style of the simple-card driver, and also as there was no use case in
  fsl-asoc-card where TX and RX settings had to be different.
- Add the documentation for the new bindings in the new DT schema
  bindings documentation. Also add an example with the generic codec.
- v3 patch series at:
https://lore.kernel.org/alsa-devel/20231218124058.2047167-1-elinor.montmass=
on@savoirfairelinux.com/

v2 -> v3:
- When the bitmaster or framemaster are retrieved from the device tree,
  the driver will now compare them with the two codecs possibly given in
device tree, and not just the first codec.
- Improve driver modifications to use multiple codecs for better
  integration of future multi-codec use cases:
    * Use `for_each_codec` macros when possible.
    * `fsl_asoc_card_priv` struct now has 2 `codec_priv` as the driver
    * can currently retrieve 2 codec phandles from the device tree.
- Fix subject of patch 10/10 to follow the style of the subsystem
- v2 patch series at:
https://lore.kernel.org/alsa-devel/20231027144734.3654829-1-elinor.montmass=
on@savoirfairelinux.com/

v1 -> v2:
- Replace use of the dummy codec by the pair of codecs spdif_receiver /
  spdif_transmitter.
- Adapt how dai links codecs are used to take into account the
  possibility for multiple codecs per link.
- Change compatible name.
- Adapt driver to be able to register two codecs given in the device
  tree.
- v1 patch series at:
https://lore.kernel.org/alsa-devel/20230901144550.520072-1-elinor.montmasso=
n@savoirfairelinux.com/


Elinor Montmasson (2):
  arm64: dts: imx8m: update spdif sound card node properties
  ARM: dts: imx6: update spdif sound card node properties

 arch/arm/boot/dts/nxp/imx/imx6q-cm-fx6.dts    | 15 +++++++++---
 arch/arm/boot/dts/nxp/imx/imx6q-prti6q.dts    | 15 +++++++++---
 arch/arm/boot/dts/nxp/imx/imx6q-tbs2910.dts   |  9 +++++--
 arch/arm/boot/dts/nxp/imx/imx6qdl-apalis.dtsi | 15 +++++++++---
 .../arm/boot/dts/nxp/imx/imx6qdl-apf6dev.dtsi |  9 +++++--
 .../arm/boot/dts/nxp/imx/imx6qdl-colibri.dtsi | 15 +++++++++---
 .../arm/boot/dts/nxp/imx/imx6qdl-cubox-i.dtsi |  9 +++++--
 .../dts/nxp/imx/imx6qdl-hummingboard.dtsi     |  9 +++++--
 .../boot/dts/nxp/imx/imx6qdl-sabreauto.dtsi   |  9 +++++--
 .../boot/dts/nxp/imx/imx6qdl-wandboard.dtsi   |  9 +++++--
 .../arm/boot/dts/nxp/imx/imx6sx-sabreauto.dts |  9 +++++--
 arch/arm/boot/dts/nxp/imx/imx6sx-sdb.dtsi     |  9 +++++--
 arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi | 15 +++++++++---
 arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi | 15 +++++++++---
 arch/arm64/boot/dts/freescale/imx8mq-evk.dts  | 24 +++++++++++++++----
 15 files changed, 147 insertions(+), 39 deletions(-)

--=20
2.34.1


