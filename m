Return-Path: <linux-kernel+bounces-274996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF5BA947F4D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 18:25:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C1BEB20A25
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 16:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7A8915E5D3;
	Mon,  5 Aug 2024 16:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GDhA+0oy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25DF5156C74;
	Mon,  5 Aug 2024 16:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722875111; cv=none; b=KCsIQb5fGMM9KQzKtVek7v9j5zp+7Q+KZIlXCBdNEGLM9GPxOTCmVHHg1rjV1WTzSYFAB+xiqJuZN9aLsED66+rrhgoAMmw4rU8I8ZLMzzAUKjgfLF3W4Mm41dDZNuaUD5zB6xyhiG5f0jmwTOmRC5kIbY01NNEb0vFdbOd03+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722875111; c=relaxed/simple;
	bh=zbN7KVijszQ1S5hPulI5G2cAOfeTI15A4gHSS9o6zoc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ftTEZymRdft6wntAh3Cd32iphvwk6eoHfJTq+7BD/XjZPh1xSKgbGQ2XuW2lXn+GEufbGO82LH6h7cYoc6E884m2MVUcetuutqnmp2u502KMqTLVdV+Gj4UUFyoIdkPLwXlfi3KJfBrigoCPyWroYKvennJ7/2ngNsPObgwM6os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GDhA+0oy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E788FC32782;
	Mon,  5 Aug 2024 16:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722875109;
	bh=zbN7KVijszQ1S5hPulI5G2cAOfeTI15A4gHSS9o6zoc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=GDhA+0oy7dmVAqooLzpx75FrWIZ86ZsUPeAHEKk4vFckpdf1AWNhNCB8poPpSJCBa
	 6HPWSyJGI89mOcLXdpiUgRhnrLMTIU4nC8t/ofWGJZXKL4ct/PE5d6E8VA6m2vBlnG
	 4TyiHhxN8QkIpuyLaEwBaZ54naGdFn4MRvLbGfCILmGJANq+nXlv5yxTAHPmfrgMqe
	 hUzVOMwPtV/eMREmqvz7Hxaq7TKmx/2zOorqSSdclUwJzTwIjtHEDKFguC4OvEHvBQ
	 qayHackhNfaS5qn1jRNO0wcyQ93Qg5jsA6HCrThZRiMPyHeoN5Zz7OY/nmPhrGRVXo
	 u2KcG0Q/7ylpw==
From: Vinod Koul <vkoul@kernel.org>
To: Kishon Vijay Abraham I <kishon@kernel.org>, 
 Heiko Stuebner <heiko@sntech.de>, Algea Cao <algea.cao@rock-chips.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: kernel@collabora.com, linux-phy@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20240620-rk3588-hdmiphy-clkprov-v2-0-6a2d2164e508@collabora.com>
References: <20240620-rk3588-hdmiphy-clkprov-v2-0-6a2d2164e508@collabora.com>
Subject: Re: [PATCH v2 0/4] Add clock provider support to Rockchip RK3588
 HDMI TX PHY
Message-Id: <172287510559.465699.10935386894693742033.b4-ty@kernel.org>
Date: Mon, 05 Aug 2024 21:55:05 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Thu, 20 Jun 2024 03:36:21 +0300, Cristian Ciocaltea wrote:
> The HDMI PHY PLL can be used as an alternative clock source to RK3588
> SoC CRU. Since it provides more accurate clock rates, it can be used by
> VOP2 to improve display modes handling, such as supporting non-integer
> refresh rates.
> 
> The first two patches in the series provide a couple of fixes and
> improvements to the existing HDPTX PHY driver, while the next two add
> the necessary changes to support the clock provider functionality.
> 
> [...]

Applied, thanks!

[1/4] phy: phy-rockchip-samsung-hdptx: Explicitly include pm_runtime.h
      commit: 1b369ff94bc36d2e16c8a91c0ea8ebd329555976
[2/4] phy: phy-rockchip-samsung-hdptx: Enable runtime PM at PHY core level
      commit: 10ba8479f460e9256f7d884dc1b7d89006a89c7b
[3/4] dt-bindings: phy: rockchip,rk3588-hdptx-phy: Add #clock-cells
      commit: a652f2210054276990d45626a3b9ad5c99465f5a
[4/4] phy: phy-rockchip-samsung-hdptx: Add clock provider support
      commit: c4b09c562086f32588d962d30d0b7e93fe3e7cbb

Best regards,
-- 
Vinod Koul <vkoul@kernel.org>


