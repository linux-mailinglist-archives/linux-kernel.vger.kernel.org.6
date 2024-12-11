Return-Path: <linux-kernel+bounces-441592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 385E49ED079
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 16:54:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1E84161E12
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 15:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B6231D6DBB;
	Wed, 11 Dec 2024 15:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MJyw/KlC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D0C24634E;
	Wed, 11 Dec 2024 15:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733932482; cv=none; b=txFWonbrUYIbojkyRDtGXU4UUxNQzS8Dke767Nanx+uGJ8zgVT+8B7UlWvnnPqfRmV7OyBnTbf8+sTCjRlgzEoVIBaCf8SGD7x/Md2PMdDcuEIruJ+aAihGmRYGhX1KvYhSSsYlLg7Kc2ZlLmXVdPJuLsAyAQXkuXVT7ttPWARU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733932482; c=relaxed/simple;
	bh=Z/nbk/8Kb/p1U+kHAubTcn5qOKR0MEKHfLVov/7+cCE=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=J91M9onD6Oo0Xgf1zXjCh2HfOWk0CXFjqLdfWqwkhVt5wI1F4tIDQWsGSfnlLZofNRPj9/6BucofMYMV+Dpi1Dma5XfJAQATXcbmRb06w3JWZCbSlsIpSOhVtIKWbvuJPezuqe6y6QC/hjJWTPtxCtxGH3VwRCuj3hhoWauxIf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MJyw/KlC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E53FC4CED4;
	Wed, 11 Dec 2024 15:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733932481;
	bh=Z/nbk/8Kb/p1U+kHAubTcn5qOKR0MEKHfLVov/7+cCE=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=MJyw/KlC9PsR8A7QmwQl+ECfyQDa36GtAov7ute6Lb2pDzGHI5s/CwO+Tjxcj9RBV
	 Udh7zF5KgAcRYZgQWVLyZmx1JcBUuZluIh8ocAWasByBGAN41rh1Rm3f9hOXj3NXvZ
	 8al3tAu6BklmNPMeIAeiizXMaMqtPnH13o0j7Nk2vtvVw89epNoshB+UmLQYR89W4B
	 5t26PWGXLee/eytjtQHHRutRJoWxTP8TQHCRCuink5FyoU+Zm7ifMAV/jFBxQRLxuS
	 HgunMtvv8bIqCzO5OLNeEDpGpPti3RzSWDElNMWyi7+owwUELExnEV5/wcZtVyLuld
	 m/UKl145tSb4w==
Date: Wed, 11 Dec 2024 09:54:39 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: kernel@collabora.com, Aary Patil <aary.patil@mediatek.com>, 
 Conor Dooley <conor+dt@kernel.org>, parkeryang <Parker.Yang@mediatek.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Trevor Wu <trevor.wu@mediatek.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, devicetree@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>, linux-mediatek@lists.infradead.org, 
 Matthias Brugger <matthias.bgg@gmail.com>, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-sound@vger.kernel.org, 
 Suhrid Subramaniam <suhrid.subramaniam@mediatek.com>, 
 Liam Girdwood <lgirdwood@gmail.com>
To: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
In-Reply-To: <20241210-genio700-audio-output-v2-0-c50886ae0be2@collabora.com>
References: <20241210-genio700-audio-output-v2-0-c50886ae0be2@collabora.com>
Message-Id: <173393224281.3090994.9490420905071029981.robh@kernel.org>
Subject: Re: [PATCH v2 0/2] Enable audio output for Genio 700 EVK board


On Tue, 10 Dec 2024 17:54:27 -0300, Nícolas F. R. A. Prado wrote:
> This series enables audio output support for the Genio 700 EVK board.
> Patch 1 adds the missing #sound-dai-cells property in the MT6359 node as
> a prerequisite, and patch 2 describes the audio DT nodes to get audio
> output working on the two audio jacks, Earphone and Speaker, present on
> the board.
> 
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> ---
> Changes in v2:
> - Dropped merged/unnecessary patches (2, 3, 4)
> - Removed unnecessary mediatek,dai-link property
> - Link to v1: https://lore.kernel.org/r/20241205-genio700-audio-output-v1-0-0e955c78c29e@collabora.com
> 
> ---
> Nícolas F. R. A. Prado (2):
>       arm64: dts: mt6359: Add #sound-dai-cells property
>       arm64: dts: mediatek: mt8390-genio-700-evk: Add sound output support
> 
>  arch/arm64/boot/dts/mediatek/mt6359.dtsi           |  1 +
>  .../boot/dts/mediatek/mt8390-genio-700-evk.dts     | 48 ++++++++++++++++++++++
>  2 files changed, 49 insertions(+)
> ---
> base-commit: d1486dca38afd08ca279ae94eb3a397f10737824
> change-id: 20241204-genio700-audio-output-fba8f2ebad10
> 
> Best regards,
> --
> Nícolas F. R. A. Prado <nfraprado@collabora.com>
> 
> 


My bot found new DTB warnings on the .dts files added or changed in this
series.

Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
are fixed by another series. Ultimately, it is up to the platform
maintainer whether these warnings are acceptable or not. No need to reply
unless the platform maintainer has comments.

If you already ran DT checks and didn't see these error(s), then
make sure dt-schema is up to date:

  pip3 install dtschema --upgrade


New warnings running 'make CHECK_DTBS=y mediatek/mt8390-genio-700-evk.dtb' for 20241210-genio700-audio-output-v2-0-c50886ae0be2@collabora.com:

arch/arm64/boot/dts/mediatek/mt8390-genio-700-evk.dtb: pmic: '#sound-dai-cells', 'mt6359codec', 'mt6359rtc' do not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/mfd/mediatek,mt6397.yaml#
arch/arm64/boot/dts/mediatek/mt8390-genio-700-evk.dtb: jpeg-decoder@1a040000: iommus: [[124, 685], [124, 686], [124, 690], [124, 691], [124, 692], [124, 693]] is too long
	from schema $id: http://devicetree.org/schemas/media/mediatek-jpeg-decoder.yaml#






