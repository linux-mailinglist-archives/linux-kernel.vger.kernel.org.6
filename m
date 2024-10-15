Return-Path: <linux-kernel+bounces-366642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7980E99F82B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 22:37:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CD781C21DA8
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 20:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 880651F8193;
	Tue, 15 Oct 2024 20:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AIdXaRjt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C3B158D9C;
	Tue, 15 Oct 2024 20:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729024651; cv=none; b=hsOEjMlgdONUZVW/C5Nb/IcK/vU0y48k6pmCXNlP6y4cK2lucsdxtQ0T2qrnaJKpsQBdCpkdbJ/mzKcozsQRrrgRrFiflRBm7ZYVKWdvxcgvHG+xSfVw/g5GkAYRwgGAEDN1d+/WDkJwN5ArhIvDc5ESMXf6UJ4YzbWGR2zO/t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729024651; c=relaxed/simple;
	bh=wEllmQzVhgF4GVOEm1VErXB6Nk08jOpeFQrbb38vU6w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jTYvOhf4Y4zFXL16CaU6jZ9Jg+w9wNO+k5XpXD35qoZjvZAC2Gl4ep2acQU5K2oLQ8gn2I6u2+cK3gBIS+Zcu0Qzi6rAtoJjzlBeuFT/fHeQhohSqdUnY1RanYzUhR22llVHcpVT60wxy3JYFPkXw5ryXYa0SCh5w9QwrL89OXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AIdXaRjt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE1C6C4CEC6;
	Tue, 15 Oct 2024 20:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729024650;
	bh=wEllmQzVhgF4GVOEm1VErXB6Nk08jOpeFQrbb38vU6w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AIdXaRjtRU52RixQ78a0qnfo5er9t1kQMM6/HBYQRQ+WSdI4fqrBoN8e/Q6Pqqqo2
	 3YQfF9R4ARVIG2TKqAqi/nwZsnqXg9RDWa5AXJkGXZ+Mp6bsw1tS3v+cim4TfxAlVt
	 2XhZRYUAvsgZsmDuGoyzYTMuq7KQKY0KRsI9gChZ4DZVzDzaxFkLN78/FOTcuDBiEb
	 zvgqPikaEeEaHEbbe9aZX+EURghDT+tr8usAZMM2vfp0HMCucCKE5p4/tDI4kOKqE4
	 G8mohUPqezznGm4E7+AbrPz2BQujfH7D8TTKJ7XrYqzexc2zRI6njmae4p5CjaabyH
	 gSEFMnBvLw4GQ==
Date: Tue, 15 Oct 2024 15:37:28 -0500
From: Rob Herring <robh@kernel.org>
To: Cenk Uluisik <cenk.uluisik@googlemail.com>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Chris Morgan <macromorgan@hotmail.com>,
	Dragan Simic <dsimic@manjaro.org>, Jonas Karlman <jonas@kwiboo.se>,
	Andy Yan <andyshrk@163.com>, Tim Lunn <tim@feathertop.org>,
	Jagan Teki <jagan@edgeble.ai>,
	Michael Riesch <michael.riesch@wolfvision.net>,
	Jimmy Hon <honyuenkwun@gmail.com>, Jing Luo <jing@jing.rocks>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/2] dt-bindings: arm: rockchip: Add Orange Pi 5b enum
 to Orange Pi 5 entry
Message-ID: <20241015203728.GA1914063-robh@kernel.org>
References: <20241015192905.28969-1-cenk.uluisik@googlemail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241015192905.28969-1-cenk.uluisik@googlemail.com>

On Tue, Oct 15, 2024 at 09:28:35PM +0200, Cenk Uluisik wrote:
> This extends the Xunlong Orange Pi 5 device tree binding with an enum for
> the Orange Pi 5b, which is implemented before the device tree.
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

Well, still kind of too fast because I just acked v5. Before you send 
v7, read the process for adding tags.

You should also read the part on adding change log to your patches.

> 
> diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
> index 687823e58c22..62bb6587da8f 100644
> --- a/Documentation/devicetree/bindings/arm/rockchip.yaml
> +++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
> @@ -1051,7 +1051,9 @@ properties:
>  
>        - description: Xunlong Orange Pi 5
>          items:
> -          - const: xunlong,orangepi-5
> +          - enum:
> +              - xunlong,orangepi-5
> +              - xunlong,orangepi-5b
>            - const: rockchip,rk3588s
>  
>        - description: Zkmagic A95X Z2
> -- 
> 2.46.1
> 

