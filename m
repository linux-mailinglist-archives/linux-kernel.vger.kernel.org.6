Return-Path: <linux-kernel+bounces-376324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 839379AA32F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 15:31:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45049283F1F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 13:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 983BD19E970;
	Tue, 22 Oct 2024 13:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="SRItfhnJ"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F7182499;
	Tue, 22 Oct 2024 13:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729603881; cv=none; b=d2flZsoWagFHbwqZb+Oh8FsKP8gBHZUpdX64LL73iUhA97mwFtZdcG7v2YV2rqY5R/QljKxyP6/1c+YjgzGMy8ImoHaNHC6EMnyfSwiUHts6tUJ896kgcJh9ntcerghMtBAv/6dLpw5NEVE3mKi1OhU4oA43+LzHzRUZB3mBYvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729603881; c=relaxed/simple;
	bh=BCB3AThLlN8WEGZU1WKSkBEP1zwnfwydDRKTnZbvyf8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iGY4CZmdsEIbL1wvLhVxpXPVuiKhnHVL0EwKjbcFBqWFG4zcWHMTAfN6XtXVq2Mpw8NTc2OR6ddbXsGqFBr/FMEjgtVmhMOTjBhm4xABq/kYeIAsldFBa4NVgWJi6MYDX7k/Y+ePOiB7UvOZOfnXT1SvDBipwdUqXQrCa+t/SM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=SRItfhnJ; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=936xC21AgwcciWwjdDPzM7HXD5fwzfqYATKWEq7i4NY=; b=SRItfhnJiuGRI9iIcdo6Aw3B2u
	sFIulNb/Xv0N/3sFKtpSgsAcTQ84WINUwclqVa9BSho6pc7eRVZ2HJDpxcVZy1qvgIvMEpchr5z4L
	JRkEQr9meMdqKMsXJlYse8YD20PcW2HEv5Nd0DAamZvnng6pF3bWwXxRNXS4g1v0bp5wcEBtd3VsJ
	3G1C5Zk0QI+w3HGNJIp2bPUfTCs+ybQg1xXYvLaen9r71m1W3bPh05dasqoNDYezKIIRunJoWmp0t
	toUjyVu+c/oJLmfOCoj27jz+Ng7ASKbz34+wKSgWmM6WaU1CZKI2RJkGgUAG0YZW7K1Jq5SSf/vVS
	+RJ/3dCQ==;
Received: from [213.70.40.217] (helo=phil.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1t3Ey9-0005Km-GY; Tue, 22 Oct 2024 15:30:41 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Chris Morgan <macromorgan@hotmail.com>,
 Dragan Simic <dsimic@manjaro.org>, Jonas Karlman <jonas@kwiboo.se>,
 Andy Yan <andyshrk@163.com>, Tim Lunn <tim@feathertop.org>,
 Jagan Teki <jagan@edgeble.ai>,
 Michael Riesch <michael.riesch@wolfvision.net>,
 Jimmy Hon <honyuenkwun@gmail.com>,
 Cenk Uluisik <cenk.uluisik@googlemail.com>, Jing Luo <jing@jing.rocks>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 Cenk Uluisik <cenk.uluisik@googlemail.com>
Subject:
 Re: [PATCH v6 1/2] dt-bindings: arm: rockchip: Add Orange Pi 5b enum to
 Orange Pi 5 entry
Date: Tue, 22 Oct 2024 15:30:40 +0200
Message-ID: <12536302.O9o76ZdvQC@phil>
In-Reply-To: <20241015192905.28969-1-cenk.uluisik@googlemail.com>
References: <20241015192905.28969-1-cenk.uluisik@googlemail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Am Dienstag, 15. Oktober 2024, 21:28:35 CEST schrieb Cenk Uluisik:
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

In its v5, this patch received [0] a

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

which overlapped with this version getting sent out.
The patch contents look identical between that version and this one.


Heiko

[0] https://lore.kernel.org/all/172902320363.1787838.552661206100007627.robh@kernel.org/


>  Documentation/devicetree/bindings/arm/rockchip.yaml | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
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
> 





