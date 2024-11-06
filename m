Return-Path: <linux-kernel+bounces-398097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A73C59BE551
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 12:14:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE9381C21129
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 11:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E0D51DE4F1;
	Wed,  6 Nov 2024 11:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="w11ufpAu"
Received: from mail-40140.protonmail.ch (mail-40140.protonmail.ch [185.70.40.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1918418C00E
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 11:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730891671; cv=none; b=gi7ufP56RcWynldR4HCdRSf5DrPdlAhwhKQt7rJhu4PyTqDu7CQy5/IxDF+0wMTxhNh3WrOYsNdLLo4rODXjUG9d/YN/UutxQiMsCQZn8Y/ErBac4WjD2H8Xz3f+BL+/8BP8g7ftg6L4CrWOs5BPk71640FLOw6HOdb2YVVZl+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730891671; c=relaxed/simple;
	bh=BxquhkBW532I4hD3BajrntKsboORTcgVhG73iCFJjO8=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=SnqAK8s5emphV8N/wIJmcwHZmU1VKp9wHLyB8iPvHH12pGb9gbf37BgZfpA2NvLxGc9yVWEzEJ/74QmCo+oqOMK+1ZCi0dByX45zPsAkI3+Zt2Bky7JScDwrlafCdXj9yc7wBXhWA/OMCQJQeMdcrPfFTEx5Z2V8LvMAqBCOj8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=w11ufpAu; arc=none smtp.client-ip=185.70.40.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1730891666; x=1731150866;
	bh=44Jj4Axf6VhdEIAU0ENXCGhb1JV9u+U+0Mxi10i0Jj4=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
	 List-Unsubscribe:List-Unsubscribe-Post;
	b=w11ufpAuhZXSVRhO+3yN3KUxWb3+xqn+03qFy60Uh2a4PZ3L2c5gnRhKpCuIOTshI
	 5qUnWNb8MrKU+4DJx/N4Of6Lz+b7RFD/5fFZBFzT7/xvC1wAOfAu2xyilaaeuSMvhn
	 GDvCNJha3KWg0z12meCJ4lm8BNjeR3IZEu3cleJy5Ns0nef33P1tqE+Bw0QVS1Ieoi
	 KnZZNJzcEMTwnrNZyavS3N4skMCnAcwWTA9CUnbqwkv8UmPUTkeYSjQqfyDBaEsXXh
	 oGXDbc4hXpB1hCrgfEkNjyVIqio5cGhOCzqjmY6n253Qw4LC6i2X32RRJA2YF4EyU/
	 oOAP4gbxEwyGg==
Date: Wed, 06 Nov 2024 11:14:21 +0000
To: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Philipp Zabel <p.zabel@pengutronix.de>, Sam Shih <sam.shih@mediatek.com>, Lukas Bulwahn <lukas.bulwahn@redhat.com>, Daniel Golle <daniel@makrotopia.org>
From: Yassine Oudjana <y.oudjana@protonmail.com>
Cc: Yassine Oudjana <y.oudjana@protonmail.com>, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 0/2] MediaTek MT6735 syscon clock/reset controller support
Message-ID: <20241106111402.200940-1-y.oudjana@protonmail.com>
Feedback-ID: 6882736:user:proton
X-Pm-Message-ID: 0dd6bd5ca0773cfa6c0df23af5f595a7210c9feb
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

These patches are part of a larger effort to support the MT6735 SoC family
in mainline Linux. More patches can found here[1].

This series adds support for clocks and resets of the following blocks:
- IMGSYS (Camera)
- MFGCFG (GPU)
- VDECSYS (Video decoder)
- VENCSYS (Video encoder, also has JPEG codec clocks)

[1] https://gitlab.com/mt6735-mainline/linux/-/commits/mt6735-staging

Changes since v1:
- Simplify Kconfig dependencies.
- Remove some extra newlines.

Yassine Oudjana (2):
  dt-bindings: clock: mediatek: Add bindings for MT6735 syscon clock and
    reset controllers
  clk: mediatek: Add drivers for MT6735 syscon clock and reset
    controllers

 .../bindings/clock/mediatek,syscon.yaml       |  4 +
 MAINTAINERS                                   | 10 +++
 drivers/clk/mediatek/Kconfig                  | 28 +++++++
 drivers/clk/mediatek/Makefile                 |  4 +
 drivers/clk/mediatek/clk-mt6735-imgsys.c      | 57 +++++++++++++
 drivers/clk/mediatek/clk-mt6735-mfgcfg.c      | 61 ++++++++++++++
 drivers/clk/mediatek/clk-mt6735-vdecsys.c     | 79 +++++++++++++++++++
 drivers/clk/mediatek/clk-mt6735-vencsys.c     | 53 +++++++++++++
 .../clock/mediatek,mt6735-imgsys.h            | 15 ++++
 .../clock/mediatek,mt6735-mfgcfg.h            |  8 ++
 .../clock/mediatek,mt6735-vdecsys.h           |  9 +++
 .../clock/mediatek,mt6735-vencsys.h           | 11 +++
 .../reset/mediatek,mt6735-mfgcfg.h            |  9 +++
 .../reset/mediatek,mt6735-vdecsys.h           |  9 +++
 14 files changed, 357 insertions(+)
 create mode 100644 drivers/clk/mediatek/clk-mt6735-imgsys.c
 create mode 100644 drivers/clk/mediatek/clk-mt6735-mfgcfg.c
 create mode 100644 drivers/clk/mediatek/clk-mt6735-vdecsys.c
 create mode 100644 drivers/clk/mediatek/clk-mt6735-vencsys.c
 create mode 100644 include/dt-bindings/clock/mediatek,mt6735-imgsys.h
 create mode 100644 include/dt-bindings/clock/mediatek,mt6735-mfgcfg.h
 create mode 100644 include/dt-bindings/clock/mediatek,mt6735-vdecsys.h
 create mode 100644 include/dt-bindings/clock/mediatek,mt6735-vencsys.h
 create mode 100644 include/dt-bindings/reset/mediatek,mt6735-mfgcfg.h
 create mode 100644 include/dt-bindings/reset/mediatek,mt6735-vdecsys.h

--=20
2.47.0



