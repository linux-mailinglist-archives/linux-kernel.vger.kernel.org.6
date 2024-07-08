Return-Path: <linux-kernel+bounces-244497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28BF592A509
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 16:47:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC7002819CB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 14:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5171E1411FD;
	Mon,  8 Jul 2024 14:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jc5AjsVs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB7B7E56B;
	Mon,  8 Jul 2024 14:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720450046; cv=none; b=kjDMZKau/4ZtiR1vKHKxGxZQmrfpNr+Zm3DEYKWkIR6KgPulVzp1V7ApLFQZgfwWc2wlRLIIZRxT+4lye7M8jvos7zu/55hGMZWyJIIaEqf150CwxV9Hs8W+kt89yszYajXxO4R0YOvibrnZyAIhVSkSPjrD7uJ22o6lGboZXkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720450046; c=relaxed/simple;
	bh=+vH5Wl2pf2rKsw1/NxNTENPBRL2nLneoS1IPUz/ojvk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CfokjO+YiYF+ap2EXGepx5SIK+RKsELm0z1TDK5YNpbuoNXzIQM7ACaQg6h1BK56ZDc9yyJTqknKlDr4XzCuF1CwS3DQmXrb5YnH07vJ8tZXgJP5DoVY+RHHDbOKdcFYi9usx09OKCbGVKuAJOq5/VEO+fudexKi1V2FI8ladcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jc5AjsVs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23C65C116B1;
	Mon,  8 Jul 2024 14:47:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720450046;
	bh=+vH5Wl2pf2rKsw1/NxNTENPBRL2nLneoS1IPUz/ojvk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jc5AjsVsDc+SYPNGAWZ3Ost1NVoAo4ADtJwYBoKm7KKgJebfDvDfxFGeKFx+u0w4X
	 ocJDEfZ749lyVO+vQE8+bqZRP3iiZGaVm7WJYbngnkqmwIrqZquE89a72M+NiNAp0l
	 zJUAWN2pUilGM8R7aFaKUK4b88rYnXtjYSZXTs/mwhAAjx4YCVfFfKbQUYdDNg24ah
	 ukJlyiV8d5UM2gxY3ReeqGsGtREqYr1vXBR/N0mSsCGoAT5NHhQcnCdzk+ucMEpwHC
	 ljesqdK27ntzO+EPHiQjNnpnOFV9wdL68scZxZm1v6XjHSYWe9eblBVPXSBKxlyPtP
	 c73m3wWsUDSsQ==
Date: Mon, 8 Jul 2024 08:47:25 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Elinor Montmasson <elinor.montmasson@savoirfairelinux.com>
Cc: Shawn Guo <shawnguo@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
	imx@lists.linux.dev, Catalin Marinas <catalin.marinas@arm.com>,
	devicetree@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-kernel@vger.kernel.org, Xiubo Li <Xiubo.Lee@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Will Deacon <will@kernel.org>, Fabio Estevam <festevam@gmail.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Nicolin Chen <nicoleotsuka@gmail.com>,
	Takashi Iwai <tiwai@suse.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Shengjiu Wang <shengjiu.wang@gmail.com>,
	Russell King <linux@armlinux.org.uk>, linux-sound@vger.kernel.org,
	alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	Philip-Dylan <philip-dylan.gleonec@savoirfairelinux.com>
Subject: Re: [PATCH v6 5/7] ASoC: dt-bindings: update fsl-asoc-card bindings
 after imx-spdif merge
Message-ID: <172045004389.3168553.9456011538931000974.robh@kernel.org>
References: <20240627083104.123357-1-elinor.montmasson@savoirfairelinux.com>
 <20240627083104.123357-6-elinor.montmasson@savoirfairelinux.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240627083104.123357-6-elinor.montmasson@savoirfairelinux.com>


On Thu, 27 Jun 2024 10:31:02 +0200, Elinor Montmasson wrote:
> The S/PDIF audio card support with compatible "fsl,imx-audio-spdif"
> was merged from imx-spdif into the fsl-asoc-card driver.
> It makes possible to use an S/PDIF with an ASRC.
> 
> This merge introduces new DT bindings to use with compatible
> "fsl,imx-audio-spdif" to follow the way fsl-asoc-card works:
> * the "spdif-controller" property from imx-spdif is named "audio-cpu"
>   in fsl-asoc-card.
> * fsl-asoc-card uses codecs explicitly declared in DT
>   with "audio-codec".
>   With an SPDIF, codec drivers spdif_transmitter and
>   spdif_receiver should be used.
>   Driver imx-spdif used instead the dummy codec and a pair of
>   boolean properties, "spdif-in" and "spdif-out".
> 
> In an upcoming commit, in-tree DTs will be modified to follow these new
> properties:
> * Property "spdif-controller" will be renamed "audio-cpu".
> * spdif_transmitter and spdif_receiver nodes will be declared
>   and linked to the fsl-asoc-card node with the property "audio-codec".
> 
> To keep backward compatibility with other DTs, support for
> "spdif-controller", "spdif-in" and "spdif-out" properties is kept.
> However, it is recommended to use the new properties if possible.
> It is better to declare transmitter and/or receiver
> in DT than using the dummy codec.
> 
> DTs using compatible "fsl,imx-audio-spdif" are still supported, and
> fsl-asoc-card will behave the same as imx-spdif for these DTs.
> 
> Signed-off-by: Elinor Montmasson <elinor.montmasson@savoirfairelinux.com>
> ---
>  .../bindings/sound/fsl,imx-audio-spdif.yaml   | 66 -------------------
>  .../bindings/sound/fsl-asoc-card.yaml         | 53 +++++++++++++--
>  2 files changed, 49 insertions(+), 70 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/sound/fsl,imx-audio-spdif.yaml
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


