Return-Path: <linux-kernel+bounces-208082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE3B490205F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 13:28:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C65FE1C21B93
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 11:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 725E27E0F4;
	Mon, 10 Jun 2024 11:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y11qWq30"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC697BB17;
	Mon, 10 Jun 2024 11:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718018879; cv=none; b=DSK7gjmG+FTAsIR11LFqQRsIyhVGrUEBrWqFpYJEDFnIoOkeYG7nSiLZ3FnmJK+O4pr4Seqvpxxz3DFmgEpW2uGmt4oZaRpcUkujpeXiJiNO8RWzXt1lAkcnOJVpAvynfJ1hmfCMLg5cf6jo3WBVxFIV7fOffPuzwv63eOpzLHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718018879; c=relaxed/simple;
	bh=Ufe1ZLLoSpV2K0MaHShy7dxkB+4myYMOF10kUQW4gXo=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=Ncgg3tzxHBPU+m99EutPPMmZYdnO4bKttFeF8DD53+J5nxqH3SlqCFNjT+f7qayEsbw9VQy6J3m7XWPj2Ld0bVi/xqw01MSOJ0yQbFk2x5GJtmvlvp2J31JrGMqNjWEpeNs9Gu9lGkk3nRv+rSj3IQcTFH9Kwpuyy99IGAWerCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y11qWq30; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ACDEC2BBFC;
	Mon, 10 Jun 2024 11:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718018879;
	bh=Ufe1ZLLoSpV2K0MaHShy7dxkB+4myYMOF10kUQW4gXo=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=Y11qWq30JfF1hbZ5lW8q94mVwGFAZz6WmQi0tGPt8JvvCOaPT0ZAdTvd5G0BHLHvJ
	 jDM3zjchO1oHI6T0VewH68UTOMNfJmxyyaycTTV1hIuPqRpF3fd74/GSbD/7HuAywg
	 kySI4Q4zETEwS/G1Dwc0r0KHbTJ2ZWEIJPgeDXO4UAB1B+MdDKZPhSLkC6kuRdpOGd
	 e+xdffUGjXR8cfHK+ojVrTA7NnxN/I1nbyOnRq9G5vzQFaiwdC8dzG7pnvaC1l4cIa
	 abou26jaw2GdG+3zqZy07fFf38Kz+U7aUSHMXMAGxVkeNrsSkoMQpyZh/bhFv84zJ2
	 uu3p1QGPoIi7A==
Date: Mon, 10 Jun 2024 05:27:58 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>
Cc: Russell King <linux@armlinux.org.uk>, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Jaroslav Kysela <perex@perex.cz>, Vladimir Zapolskiy <vz@mleia.com>, 
 Rob Herring <robh+dt@kernel.org>, Mark Brown <broonie@kernel.org>, 
 Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, 
 devicetree@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>
In-Reply-To: <20240610102415.79740-1-piotr.wojtaszczyk@timesys.com>
References: <20240610102415.79740-1-piotr.wojtaszczyk@timesys.com>
Message-Id: <171801887810.1852058.9889760011059594602.robh@kernel.org>
Subject: Re: [PATCH] ASoC: fsl: Add i2s and pcm drivers for LPC32xx CPUs


On Mon, 10 Jun 2024 12:24:07 +0200, Piotr Wojtaszczyk wrote:
> This driver was ported from an old version in linux 2.6.27 and adjusted
> for the new ASoC framework and DMA API.
> 
> Signed-off-by: Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>
> ---
>  .../bindings/sound/nxp,lpc3220-i2s.yaml       |  50 +++
>  arch/arm/boot/dts/lpc32xx.dtsi                |   4 +
>  arch/arm/mach-lpc32xx/phy3250.c               |  60 +++
>  sound/soc/fsl/Kconfig                         |   7 +
>  sound/soc/fsl/Makefile                        |   2 +
>  sound/soc/fsl/lpc3xxx-i2s.c                   | 411 ++++++++++++++++++
>  sound/soc/fsl/lpc3xxx-i2s.h                   |  94 ++++
>  sound/soc/fsl/lpc3xxx-pcm.c                   |  75 ++++
>  8 files changed, 703 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/nxp,lpc3220-i2s.yaml
>  create mode 100644 sound/soc/fsl/lpc3xxx-i2s.c
>  create mode 100644 sound/soc/fsl/lpc3xxx-i2s.h
>  create mode 100644 sound/soc/fsl/lpc3xxx-pcm.c
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/sound/nxp,lpc3220-i2s.yaml: 'maintainers' is a required property
	hint: Metaschema for devicetree binding documentation
	from schema $id: http://devicetree.org/meta-schemas/base.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240610102415.79740-1-piotr.wojtaszczyk@timesys.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


