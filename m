Return-Path: <linux-kernel+bounces-347266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00AC998D048
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 11:34:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31DC61C222AD
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 09:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D47C81E1A3C;
	Wed,  2 Oct 2024 09:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="MatshYVf"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB2C1E131C;
	Wed,  2 Oct 2024 09:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727861616; cv=none; b=Hczb3tdhDu70n3W4JlG9zFEWNSmtjqWPHGqcsd/WOfqthgQnC8NLtIJOLsMnOy9FRM4SZ+uG8P1fc3PcMaObCZumXpBqGPWC+I42AtSEVZ152vH1IJ3HFRnPk7vEqQQlD9QCmtSJqFhfuJms6JePcE//XuMRsZz916p4WXguJuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727861616; c=relaxed/simple;
	bh=e5TK+I2oYnRQG4QdX0P6mxvv+kjLwPutRBAWCgBesyE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=XP/VqOlnqukSFz4wA1J1XsxfeSgbvrLOVqgMtVRZWLBfSBfM73eq8aI6XGf9HYINqLLc2ULxya/IAFKhCnn04lAOV+2/x8OQWalGh4Nfun63wDUkI3Rdwi2ejjqKptxLv2ME9L0SwdJipfEjfIa/jEDSd0l9XHWKhCySL0j0mM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=MatshYVf; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1727861612;
	bh=e5TK+I2oYnRQG4QdX0P6mxvv+kjLwPutRBAWCgBesyE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=MatshYVfvsWvV9NCcvudL3wcnCVSEBGb2qkDzT1GgoiU3QgcMwoUdxnTfmE0B8Zkg
	 ZCVMU6W2zmQaxrb7nI8EFAm3boc0wgbzBmSe/FMVfw/xAQFpLvP3JruJqQggvGA91y
	 oOYoQfspy2NkY0idvMVQybdBPlD6xwKGLGBPCCdTeoIWPzGlJkN+5/AU6NSE6zBY1e
	 ZwidbPatIyVbX7n7sCFqoPoxBTLEhmfZWki6a5/iswuUu4QDmLFSmETYoo2eQq/Tam
	 uYeG2EMcNFF8XRGc0wvJxJp25r0iHq6tY2zcBiUxQxzU/fpGe26tqzmIuIxDH/V1Cw
	 ZglBmu28SLmoQ==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 6EA2317E1270;
	Wed,  2 Oct 2024 11:33:32 +0200 (CEST)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 Pablo Sun <pablo.sun@mediatek.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
In-Reply-To: <20240912070624.25540-1-pablo.sun@mediatek.com>
References: <20240912070624.25540-1-pablo.sun@mediatek.com>
Subject: Re: [PATCH v2] arm64: dts: mediatek: mt8395-genio-1200-evk: Enable
 GPU
Message-Id: <172786161239.39477.15429063817774681723.b4-ty@collabora.com>
Date: Wed, 02 Oct 2024 11:33:32 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Thu, 12 Sep 2024 15:06:24 +0800, Pablo Sun wrote:
> Enable the Mali Valhall GPU on Genio 1200 EVK by providing regulator
> supply settingsi to gpu and mfg1, and enable the GPU node.
> 
> In addition, set the GPU related regulator voltage range:
> 
> 1. Set the recommended input voltage range of DVDD_GPU to (0.546V-0.787V),
>    based on Table 5-3 of MT8395 Application Processor Datasheet.
>    The regulator mt6315_7_vbuck1("Vgpu") connects to the DVDD_GPU input.
>    Note that the minimum voltage in SoC eFuse data, which is read by
>    MTK-SVS to adjust the regulator voltage, does not go below
>    the recommended operating voltage in the datasheet.
> 
> [...]

Applied to v6.12-next/dts64, thanks!

[1/1] arm64: dts: mediatek: mt8395-genio-1200-evk: Enable GPU
      https://git.kernel.org/mediatek/c/a0fc74a4

Cheers,
Angelo



