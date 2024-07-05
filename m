Return-Path: <linux-kernel+bounces-242495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCE0D9288E1
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 14:43:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99AC128387E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 12:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C171014A634;
	Fri,  5 Jul 2024 12:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="LZbUzGOc"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD4641487D8;
	Fri,  5 Jul 2024 12:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720183422; cv=none; b=u1jlLa4TQ6whuovXU0DqUm3odkdfmfMKlDnWSJUQn1lOYoFa/3bDqMwdfso/SAKGRw9U2rjH6PKA93eIPMmQu4dE8gSzLyD+GtIEXTWh43vvwH8bB8c3dL3Wc+SYKbqkCQgaxasEZSTY7bGl4eCFUzv8lWOl4nLFVlq930+JcbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720183422; c=relaxed/simple;
	bh=niwvqIE+h1cjh82f0pDykYGJvGh/UF7aodFDBImjDLw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=APumAnd2RS08vW0W4scMohzztVZOp2152/Ou229p/S/vbb8iHY8CXFCm6rehvvSouJ/qyeKdrOU/PZejFpYYIBfp91/JFl6Ff+S0wygU/6c9QY/rYnXRRJxSuRIpoSEby4K/EVCNa0EGtYv1B5qirmFXt7aZIZsiodCyOH5D4p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=LZbUzGOc; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 664111C0002;
	Fri,  5 Jul 2024 12:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1720183418;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nlfsyrfrSV5hF7t1zqFMldKwtDb7AOHp12rdTPm/ZDs=;
	b=LZbUzGOcsxUwbjpHB6/JsV9w0p0aBzEauJfj5XkdqIhKIQ5c6HCfvUxklLZUouSWc12ygK
	WiVEc5tmdKjtaamzVE7SiHcWgB6ZHj6gqe0FyKcIhOkmQ6xcPQbsOtzx2sH1i7/fI0WaGK
	6gAm66Ee7NuB3gQwI94M7e2DyemlNR5sMM7vKLBRBSCC9ntMV3xajxW0A2x4/I4BZbwdY9
	VXHuMssMmCFm3L8Gfxc21snO+f4SrZVca8t1nvJoIqsxTmum+fA+VoZhJiHJ58RL3XuKTH
	SF55iA0tj1WeXyLh0dqJCozh2NrpEV5Oc/VFlyS28AUsZ3tGs3PLXAgTkV92Wg==
From: Gregory CLEMENT <gregory.clement@bootlin.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Andrew Lunn
 <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Krzysztof Kozlowski
 <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH 0/7] ARM: dts: marvell: orion / kirkwood: few cleanups
In-Reply-To: <20240701-dts-marvell-cleanup-v1-0-4773bd20691a@linaro.org>
References: <20240701-dts-marvell-cleanup-v1-0-4773bd20691a@linaro.org>
Date: Fri, 05 Jul 2024 14:43:37 +0200
Message-ID: <87ikxkj9fq.fsf@BLaptop.bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: gregory.clement@bootlin.com

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> writes:

> Few cleanups reported by dtbs_check.
>
> Best regards,
> Krzysztof
>
> ---

Series applied on mvebu/dt

Thanks,

Gregory


> Krzysztof Kozlowski (7):
>       ARM: dts: marvell: kirkwood: align GPIO keys node name with bindings
>       ARM: dts: marvell: kirkwood: drop incorrect address/size-cells in GPIO keys
>       ARM: dts: marvell: kirkwood: align LED node name with bindings
>       ARM: dts: marvell: orion: align GPIO keys node name with bindings
>       ARM: dts: marvell: orion: drop incorrect address/size-cells in GPIO keys
>       ARM: dts: marvell: orion5x-lswsgl: use 'gpios' property for LEDs
>       ARM: dts: marvell: orion: align LED node name with bindings
>
>  .../dts/marvell/kirkwood-blackarmor-nas220.dts     |  6 +--
>  arch/arm/boot/dts/marvell/kirkwood-c200-v1.dts     |  8 +--
>  arch/arm/boot/dts/marvell/kirkwood-cloudbox.dts    |  8 ++-
>  arch/arm/boot/dts/marvell/kirkwood-d2net.dts       |  2 +-
>  arch/arm/boot/dts/marvell/kirkwood-dir665.dts      | 22 ++++----
>  arch/arm/boot/dts/marvell/kirkwood-dns320.dts      | 10 ++--
>  arch/arm/boot/dts/marvell/kirkwood-dns325.dts      | 10 ++--
>  arch/arm/boot/dts/marvell/kirkwood-dnskw.dtsi      |  8 ++-
>  arch/arm/boot/dts/marvell/kirkwood-dockstar.dts    |  4 +-
>  arch/arm/boot/dts/marvell/kirkwood-dreamplug.dts   |  6 +--
>  arch/arm/boot/dts/marvell/kirkwood-goflexnet.dts   | 20 ++++----
>  .../dts/marvell/kirkwood-guruplug-server-plus.dts  |  8 +--
>  arch/arm/boot/dts/marvell/kirkwood-ib62x0.dts      | 12 ++---
>  arch/arm/boot/dts/marvell/kirkwood-iconnect.dts    | 20 ++++----
>  .../boot/dts/marvell/kirkwood-iomega_ix2_200.dts   | 16 +++---
>  arch/arm/boot/dts/marvell/kirkwood-l-50.dts        | 20 ++++----
>  arch/arm/boot/dts/marvell/kirkwood-laplug.dts      |  6 +--
>  .../arm/boot/dts/marvell/kirkwood-linkstation.dtsi |  2 -
>  .../boot/dts/marvell/kirkwood-linksys-viper.dts    | 10 ++--
>  arch/arm/boot/dts/marvell/kirkwood-lsxl.dtsi       | 18 +++----
>  arch/arm/boot/dts/marvell/kirkwood-mplcec4.dts     | 12 ++---
>  .../boot/dts/marvell/kirkwood-mv88f6281gtw-ge.dts  | 12 ++---
>  arch/arm/boot/dts/marvell/kirkwood-netxbig.dtsi    |  8 ++-
>  arch/arm/boot/dts/marvell/kirkwood-ns2-common.dtsi |  6 +--
>  arch/arm/boot/dts/marvell/kirkwood-ns2lite.dts     |  2 +-
>  arch/arm/boot/dts/marvell/kirkwood-nsa310.dts      | 20 ++++----
>  arch/arm/boot/dts/marvell/kirkwood-nsa310a.dts     | 18 +++----
>  arch/arm/boot/dts/marvell/kirkwood-nsa310s.dts     |  8 ++-
>  arch/arm/boot/dts/marvell/kirkwood-nsa320.dts      | 18 +++----
>  arch/arm/boot/dts/marvell/kirkwood-nsa325.dts      | 18 +++----
>  .../boot/dts/marvell/kirkwood-nsa3x0-common.dtsi   |  8 ++-
>  .../boot/dts/marvell/kirkwood-openblocks_a6.dts    |  4 +-
>  .../boot/dts/marvell/kirkwood-openblocks_a7.dts    |  2 -
>  arch/arm/boot/dts/marvell/kirkwood-pogo_e02.dts    |  4 +-
>  .../dts/marvell/kirkwood-pogoplug-series-4.dts     |  8 ++-
>  .../boot/dts/marvell/kirkwood-sheevaplug-esata.dts |  2 +-
>  arch/arm/boot/dts/marvell/kirkwood-sheevaplug.dts  |  4 +-
>  arch/arm/boot/dts/marvell/kirkwood-synology.dtsi   | 58 +++++++++++-----------
>  arch/arm/boot/dts/marvell/kirkwood-t5325.dts       |  4 +-
>  arch/arm/boot/dts/marvell/kirkwood-ts219-6281.dts  |  6 +--
>  arch/arm/boot/dts/marvell/kirkwood-ts219-6282.dts  |  6 +--
>  arch/arm/boot/dts/marvell/kirkwood-ts419.dtsi      |  6 +--
>  .../dts/marvell/mvebu-linkstation-gpio-simple.dtsi |  2 -
>  .../boot/dts/marvell/orion5x-lacie-d2-network.dts  |  9 ++--
>  .../orion5x-lacie-ethernet-disk-mini-v2.dts        |  7 ++-
>  .../boot/dts/marvell/orion5x-linkstation-lschl.dts |  4 +-
>  arch/arm/boot/dts/marvell/orion5x-lswsgl.dts       | 25 +++++-----
>  .../marvell/orion5x-maxtor-shared-storage-2.dts    |  7 ++-
>  .../boot/dts/marvell/orion5x-netgear-wnr854t.dts   |  2 +-
>  .../arm/boot/dts/marvell/orion5x-rd88f5182-nas.dts |  2 +-
>  50 files changed, 230 insertions(+), 278 deletions(-)
> ---
> base-commit: 9c9a5aa3a60dc9e1e2448c29f346385914052642
> change-id: 20240701-dts-marvell-cleanup-1c9fcf6ae439
>
> Best regards,
> -- 
> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

