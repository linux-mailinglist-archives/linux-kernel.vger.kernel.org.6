Return-Path: <linux-kernel+bounces-442900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 083F69EE3AB
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 11:05:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14805188B96D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 10:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FCA621146B;
	Thu, 12 Dec 2024 10:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="mpVbdCY2"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 504C6210F4A;
	Thu, 12 Dec 2024 10:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733997897; cv=none; b=BT1IaU65Nskl6cw/3SDLcKv1HuCqOqCZUKtGlRqYIA8MVFno5+VslDiaSTX0A65ejyPqO9s0S17EX65Vm5ptas6anUF81bKYiMyQhlcrsqdfw1c3e7xgBEUEkke47UtCz12dP4Z7haFjs8P9X0n/UAfAzsEgmMMsJwQkVTvDrBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733997897; c=relaxed/simple;
	bh=r4vBtZGzMSY3w44LNP2WSbN/PdhlBAw89h+kvrRSONQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=MBE5+oe+FzJ352zpRplr6Yc6jFeIFCcw88APsXmeZ6Jy8LEE7Sw2coaT8DL5pxi7e2Dd6asjNstNvgp8mhNwmmwML0jk3N3lDULVqJaEUU4HqYuwTe2PUZ19l2HJiiYWLT5SUgh4w+BNGm6pU/ulRXdZ8M+54I1s6gmWkNaweWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=mpVbdCY2; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1733997893;
	bh=r4vBtZGzMSY3w44LNP2WSbN/PdhlBAw89h+kvrRSONQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=mpVbdCY2Va0Smw/rNAyfLNXZVoH/jmvic4/QBN87YO/il4dDjTmTIxUeqIrZcbWhe
	 KiFlCwNpebrNjrt4b64IFuM8D3ERAK8+2I9q4nejBmdaZZyD9+WodxHqtve1gShgAm
	 09oAF/sCZgTw+UxyigyNNI8sMW2sgMf1OBmsKamG3ETXoltoHj5iU12xADtovxk65/
	 cGPKY4cku6ubJo5DPq3PvF7MPyjw2rwHqNOOsw0AAsiFIfv0NJNcKfBHnG5iZ4/Aa7
	 M2elu+gDn6mlCUaRn8UpL67AvmcjHWyPCmDE+uihqfMaeHfgmL1+DL09Tp+AebD7V9
	 JD3M5oZUxc6kA==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 81A7317E35F2;
	Thu, 12 Dec 2024 11:04:52 +0100 (CET)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>, 
 Chen-Yu Tsai <wenst@chromium.org>
Cc: devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241211052427.4178367-1-wenst@chromium.org>
References: <20241211052427.4178367-1-wenst@chromium.org>
Subject: Re: (subset) [PATCH 0/8] arm64: dts: mediatek: Drop
 regulator-compatible property
Message-Id: <173399789246.41280.12946526807536049492.b4-ty@collabora.com>
Date: Thu, 12 Dec 2024 11:04:52 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Wed, 11 Dec 2024 13:24:18 +0800, Chen-Yu Tsai wrote:
> This series drops usage of the long deprecated "regulator-compatible"
> property from MediaTek device tree files. The property was introduced
> in 2012, and then subsequently deprecated after two months. It was
> never carried over during the binding YAML conversion.
> 
> Drop the property from the MT6315 regulator binding, and all MediaTek
> device tree files. IMO it should never have been used to begin with.
> This also gets rid of any validation errors [1] related to them.
> 
> [...]

Applied to v6.13-next/dts64, thanks!

[2/8] arm64: dts: mediatek: mt8173-evb: Drop regulator-compatible property
      commit: a6d5983e40f5d5b219337569cdd269727f5a3e2e
[3/8] arm64: dts: mediatek: mt8173-elm: Drop regulator-compatible property
      commit: 4b907b3ea5fba240808136cc5599d14b52230b39
[4/8] arm64: dts: mediatek: mt8192-asurada: Drop regulator-compatible property
      commit: d1fb968551c8688652b8b817bb081fdc9c25cd48
[5/8] arm64: dts: mediatek: mt8195-cherry: Drop regulator-compatible property
      commit: 4dbaa5d5def2c49e44efaa5e796c23d9b904be09
[6/8] arm64: dts: mediatek: mt8195-demo: Drop regulator-compatible property
      commit: 2a8af9b95f504260a6d8200a11f0ae5c90e9f787
[7/8] arm64: dts: medaitek: mt8395-nio-12l: Drop regulator-compatible property
      commit: ab60442f26b15ba69b210974722a851ed03188ff
[8/8] arm64: dts: mediatek: mt8395-genio-1200-evk: Drop regulator-compatible property
      commit: b99bf07c2c8b3c85c1935ddca2a73bc686f8d847

Cheers,
Angelo



