Return-Path: <linux-kernel+bounces-336942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 431F29842E4
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 12:02:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8E65B28C7E
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 10:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D188E16EC19;
	Tue, 24 Sep 2024 10:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="gOBbkaIx"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A66DA157468;
	Tue, 24 Sep 2024 10:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727172116; cv=none; b=s5iFvDslU7V0wGGDKluJmc7w1hDtyBr7ZkHAZeI4hRYk7TPrQd6r3qrzx3aOB24Y8vpZD3+1tVXkvlFMgTvFRy7XYfgU+yfybMOAKRqPNllvz8B+6wm85nA4JloHL9wg8VFSVBAY57guLi+QsH4pb6CbBjXzioIBeXX6Qx2NBP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727172116; c=relaxed/simple;
	bh=8BntHdJKTVHehDW1coPIlliBM6qot7zxXTvP1W2E1gQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cJSzYs+KH9mYzEbtklTTWbfJPqPKb67h3W42IFgABfySBM3LuvXOGL89TPigzlwqHLyIug4cJMDIQ7aU4SkgWDTU2RfoLSnX44cdVsnrCEGtM3jMQJ1fyhrAu8Vry59KIcK26TxxxD232tyb5LVspuWsl+R/UB88WpQJ/KMWs8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=gOBbkaIx; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=wN/DSRtcF/OkDmxb5zcG6ZVuHGTbBxm343M7VReWfF4=; b=gOBbkaIxnKeGaa4VMW7yPSofTB
	AeivSJXFIh1j+NcL670mDJ2AsoQGTruQoBnl/yJb8q/HW15I0NtncLLvDiceTx1AJrNCQraSSE5MU
	dVtWrbjfxc0JdsTlgbtn99aFbV1W+nvKthwSDmpgDuKqo0e4Jm+P8uzOd05VGqX0cAvy5B7PiKFqu
	Js3GN0L1jzrDImKXcwZEWVBY2+6LewRc4HdoaXm0CPudnLPjtrGkRQagI9++y9GAy5rRDTJlrRkvd
	VXn7dkroEVjvQr4aqw5yO6P7Re0Eca5HvnrbdBjxy+4tiQr5arTwULQJ22QLJAyafz8irpcdQOBkZ
	Xllim9Ww==;
Received: from 90-177-212-167.rck.o2.cz ([90.177.212.167] helo=phil.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1st2Mi-0000xb-76; Tue, 24 Sep 2024 12:01:52 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: vkoul@kernel.org, kishon@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, Frank Wang <frawang.cn@gmail.com>
Cc: linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-rockchip@lists.infradead.org, william.wu@rock-chips.com,
 tim.chen@rock-chips.com, wmc@rock-chips.com,
 Frank Wang <frank.wang@rock-chips.com>
Subject:
 Re: [PATCH v2 1/2] dt-bindings: phy: rockchip,inno-usb2phy: add rk3576
Date: Tue, 24 Sep 2024 12:01:51 +0200
Message-ID: <11146778.5MRjnR8RnV@phil>
In-Reply-To: <20240924085510.20863-1-frawang.cn@gmail.com>
References: <20240924085510.20863-1-frawang.cn@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Frank,

Am Dienstag, 24. September 2024, 10:55:09 CEST schrieb Frank Wang:
> From: Frank Wang <frank.wang@rock-chips.com>
> 
> Add compatible for the USB2 phy in the Rockchip RK3576 SoC.

can you please add some details to the commit message, about those
new clocks. I.e. what they do.

Thanks
Heiko

> Signed-off-by: Frank Wang <frank.wang@rock-chips.com>
> ---
> Changelog:
> v2:
>  - Categorize clock names by oneOf keyword.
> 
> v1:
>  - https://patchwork.kernel.org/project/linux-phy/patch/20240923025326.10467-1-frank.wang@rock-chips.com/
> 
>  .../bindings/phy/rockchip,inno-usb2phy.yaml      | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/phy/rockchip,inno-usb2phy.yaml b/Documentation/devicetree/bindings/phy/rockchip,inno-usb2phy.yaml
> index 5254413137c64..8af4e0f8637fc 100644
> --- a/Documentation/devicetree/bindings/phy/rockchip,inno-usb2phy.yaml
> +++ b/Documentation/devicetree/bindings/phy/rockchip,inno-usb2phy.yaml
> @@ -20,6 +20,7 @@ properties:
>        - rockchip,rk3366-usb2phy
>        - rockchip,rk3399-usb2phy
>        - rockchip,rk3568-usb2phy
> +      - rockchip,rk3576-usb2phy
>        - rockchip,rk3588-usb2phy
>        - rockchip,rv1108-usb2phy
>  
> @@ -34,10 +35,20 @@ properties:
>      const: 0
>  
>    clocks:
> -    maxItems: 1
> +    minItems: 1
> +    maxItems: 3
>  
>    clock-names:
> -    const: phyclk
> +    minItems: 1
> +    maxItems: 3
> +    items:
> +      oneOf:
> +        - description: aclk for USB MMU.
> +          const: aclk
> +        - description: aclk_slv for USB MMU.
> +          const: aclk_slv
> +        - description: PHY input reference clocks.
> +          const: phyclk
>  
>    assigned-clocks:
>      description:
> @@ -143,6 +154,7 @@ allOf:
>            contains:
>              enum:
>                - rockchip,rk3568-usb2phy
> +              - rockchip,rk3576-usb2phy
>                - rockchip,rk3588-usb2phy
>  
>      then:
> 





