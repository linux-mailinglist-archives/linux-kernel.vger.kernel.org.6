Return-Path: <linux-kernel+bounces-410004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C30C9C954F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 23:40:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A63F21F2326B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 22:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E263B1B0F2C;
	Thu, 14 Nov 2024 22:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jtVWwzYF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4602E1990C4;
	Thu, 14 Nov 2024 22:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731624028; cv=none; b=OVgB+Gso5ktBAM/7VkGlCuSgDVjysTD3fCJeM7OPY1X0QfOJ0a2cx+9eFX3AsDshE0b9YTO/AqT3Bcz+HCHPUCmv26ykHLlHw+hFeyZFpBEYgghgnLbK8muR361W5KEwWmTs+q/qzc+mDyMNGDEj2zgeFLuX9mKw8SGNoNgPYJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731624028; c=relaxed/simple;
	bh=q+dgoQrtOgKVilV2nVsbgAYQbJrn9GgLDKGPgYV2pDc=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:To:Date; b=mm6pYBMmrD9lntJqnJ34au2RBQ4fyFUHiD6uszbr5Y4QZTLFZeztX/vrHnFF1fI1YyfbDvCGqx0Uo7nRZ0OKBF9ngbrlruB5vUdrl9HAg6s0QgmQTtH1F4DXT/STzqWQTPMwsS7iGjUuzM4328tWv7St9fsUg/xbB93iWygB10E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jtVWwzYF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A196AC4CECD;
	Thu, 14 Nov 2024 22:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731624027;
	bh=q+dgoQrtOgKVilV2nVsbgAYQbJrn9GgLDKGPgYV2pDc=;
	h=In-Reply-To:References:Subject:From:To:Date:From;
	b=jtVWwzYFOpJ/mB2Fa/mloq4oMS5Ir56qJWbEJZ9Twwar0LaFkh95AowpZF8iCrCQd
	 F5pEAvNrhBpZmWIiS9ptJQYx5LjZq7iKb4UjO8kmCw6QIIqjaypemN3Rc6Rk7mlQ3K
	 uFPAqZKNYEcdi7+rUvWEbkcDzA2wS9GN0tGhBzJ06RpzBBFug/XhkfcNfhbGTip3Re
	 g7xzzMprUniwI5qruvRrKGr/+ZKV6JhwuQjQzv8l6tzyzgMZUl8luQwsEGt2wuMkcM
	 NQ3MBC6axxq99EM16xbEjn4nDTWvX4pccd/uNsaznxIm9rF29zcN3fg0rmcJepAVo3
	 anI0qsoPILy4A==
Message-ID: <b473d92cc353b1cf58169410236e4c51.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20241112230443.1406460-4-jan.dakinevich@salutedevices.com>
References: <20241112230443.1406460-1-jan.dakinevich@salutedevices.com> <20241112230443.1406460-4-jan.dakinevich@salutedevices.com>
Subject: Re: [PATCH v5 3/3] clk: meson: a1: add the audio clock controller driver
From: Stephen Boyd <sboyd@kernel.org>
To: Conor Dooley <conor+dt@kernel.org>, Jan Dakinevich <jan.dakinevich@salutedevices.com>, Jerome Brunet <jbrunet@baylibre.com>, Kevin Hilman <khilman@baylibre.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Martin Blumenstingl <martin.blumenstingl@googlemail.com>, Michael Turquette <mturquette@baylibre.com>, Neil Armstrong <neil.armstrong@linaro.org>, Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 14 Nov 2024 14:40:25 -0800
User-Agent: alot/0.12.dev1+gaa8c22fdeedb

Quoting Jan Dakinevich (2024-11-12 15:04:43)
> diff --git a/drivers/clk/meson/Kconfig b/drivers/clk/meson/Kconfig
> index 7cb21fc223b0..49f2086bc773 100644
> --- a/drivers/clk/meson/Kconfig
> +++ b/drivers/clk/meson/Kconfig
> @@ -133,6 +133,20 @@ config COMMON_CLK_A1_PERIPHERALS
>           device, A1 SoC Family. Say Y if you want A1 Peripherals clock
>           controller to work.
> =20
> +config COMMON_CLK_A1_AUDIO
> +       tristate "Amlogic A1 SoC Audio clock controller support"
> +       depends on ARM64
> +       select COMMON_CLK_MESON_REGMAP
> +       select COMMON_CLK_MESON_PHASE
> +       select COMMON_CLK_MESON_SCLK_DIV
> +       select COMMON_CLK_MESON_CLKC_UTILS
> +       select REGMAP_MMIO
> +       imply RESET_MESON_AUX

Should be 'depends on RESET_MESON_AUX'

