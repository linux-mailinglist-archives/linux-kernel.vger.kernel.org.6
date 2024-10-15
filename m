Return-Path: <linux-kernel+bounces-366625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 047F399F7F6
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 22:13:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCEB5284011
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 20:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9209A1F8184;
	Tue, 15 Oct 2024 20:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DPiYtKXp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD831F80A6;
	Tue, 15 Oct 2024 20:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729023208; cv=none; b=ZZJFji9edaMKqngvyeYzHj/90oh95sH63hdIYthY0/Na9VwbdCzp/HIsFGZ4tYkE6XgSs1og0zLX7f0g7RYV8D2d5RUxqQRcJLt61r5Dr1e08A0IhkK/rXcU6DpIOiyVuzHhM74dHHezxINwEyTYa/g45salHBR6jlFNwFvwsBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729023208; c=relaxed/simple;
	bh=i6xUc2BLIxopI8JVWx6yrBevmVH88BaZ1U6j/GtsNaI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TQ0YhaV0ytq5bDE9WSWduyFrxmwTgByd03B2NekjdFFUCDO5hWFJd1nzaF2FMGIv36MUxHGNackQjQChLty8gS3uUgLCKRBQPNg2W/h1Ban/pcCsGGGcNsD5R+p89+DTCUsf3wp0YD7cflGHo9Jssv44kkriwUrnR+ABcX2g4ME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DPiYtKXp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2807DC4CEC6;
	Tue, 15 Oct 2024 20:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729023205;
	bh=i6xUc2BLIxopI8JVWx6yrBevmVH88BaZ1U6j/GtsNaI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DPiYtKXpb7VReZQjPz4f5W7ppw/AqYRmw1kJOmBgklH9jFfoquXVrwjGzou4Nj+Cg
	 NlbsyMuuT5mWw/zCjy1fQMxIfr2Ijop5jS5q77dnlmK9H7qKuBjvn4bzwWHpuhFjUL
	 obT0/Mw7A7lDpaI4bu1Wl3AUZGqlDZbE8GDmkl2Rxjv02D/MDRyuruiUKBMOJ848zl
	 SSGO2/rbRilAyJyprHzSik7OlTLKId4AM/XLVZYcEDwP092bWUHUmZf0Wx+0dOTCFT
	 gGu1XHc6hEJ6xTfAx7o04/78twSM66dTc9Ixi82RFAxImYMT5CoI+VhrsSUYg7z5NQ
	 Ugw/6lq+zBcTg==
Date: Tue, 15 Oct 2024 15:13:24 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Cenk Uluisik <cenk.uluisik@googlemail.com>
Cc: Andy Yan <andyshrk@163.com>, Dragan Simic <dsimic@manjaro.org>,
	Tim Lunn <tim@feathertop.org>, Jagan Teki <jagan@edgeble.ai>,
	linux-arm-kernel@lists.infradead.org,
	Jonas Karlman <jonas@kwiboo.se>, Jing Luo <jing@jing.rocks>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Chris Morgan <macromorgan@hotmail.com>,
	Michael Riesch <michael.riesch@wolfvision.net>,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	Jimmy Hon <honyuenkwun@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>
Subject: Re: [PATCH v5 1/2] dt-bindings: arm: rockchip: Add Orange Pi 5b enum
 to Orange Pi 5 entry
Message-ID: <172902320363.1787838.552661206100007627.robh@kernel.org>
References: <20241014180324.536702-1-cenk.uluisik@googlemail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241014180324.536702-1-cenk.uluisik@googlemail.com>


On Mon, 14 Oct 2024 20:02:52 +0200, Cenk Uluisik wrote:
> This extends the Xunlong Orange Pi 5 device tree binding
> with an enum for the Orange Pi 5b, which is implemented
> before the device tree.
> 
> How does this board differ from the original Orange Pi 5?
>   - the Orange Pi 5 has a M.2 NVMe M-key PCI 2.0x1
>     slot (hooked to combphy0_ps) whereas the Orange Pi 5b uses combphy0_ps
>     for the WiFi.
>   - The Orange Pi 5 with the M.2 socket has a regulator defined hooked to
>     "GPIO0_C5" (i.e. PCIE_PWREN_H) whereas the Orange Pi 5B has GPIO0_C5
>     hooked to BT_WAKE_HOST.
>   - builtin eMMC storage
>   - no SPI NOR flash (u-boot, preboot etc. initiates
>       from within the eMMC
>       storage)
>   - ap6275p Wifi module (like the Orange Pi 5 Plus)
>   - builtin BlueTooth module
> 
> Signed-off-by: Cenk Uluisik <cenk.uluisik@googlemail.com>
> ---
>  Documentation/devicetree/bindings/arm/rockchip.yaml | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


