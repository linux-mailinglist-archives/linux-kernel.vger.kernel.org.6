Return-Path: <linux-kernel+bounces-363306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D05399C05F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 08:50:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C3EDB20ED5
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 06:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1C3C145324;
	Mon, 14 Oct 2024 06:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="YXoRqWd3"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC6D13A24D;
	Mon, 14 Oct 2024 06:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728888624; cv=none; b=JuGs0smgLx/Vc082Rr6oCJlCYBrNWWClwUwqeOI5zXqDMn0CIBO77H4VYC9rf/dIUAyfxnlTIZS7HRJRSlj/6xEfWAUs9I5JcPCluRGUxg1Xtv11t1j6pPK/CUikvbjwhrDwPcWX6wPHaSXvVS3tByGpk3IEQugDIZPd9Joyr/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728888624; c=relaxed/simple;
	bh=SPaERr+frnN8S/Cdxdeffz0qp4nRXCiWqgfySXCE3XI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mYJXYbBGd+tXAAmrpiJX2xScr9uLbSensQn1QDTWIm/xeTTAm9FY4sqpE66OgLNItu+y0pY91mt1fptCXUjh+NJi3o2CQwiFfMBZur6AgvePn/rnsfd8SNw+u5oc8Cfm/K6mO3zd0qmF+b5cAFUZDZScv33LYKXZ8GoyD07iVh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=YXoRqWd3; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ZmAW6fZGix/AXO5/o5fQwKF8FWNV3LuFftvqlLUibzU=; b=YXoRqWd3T4v/uADHvjaklU3wSM
	hJnl/cqT255Xe3Qn0KBBiicQRmWTgSATqFkhMEMer+wmOwuE8fnfMuV5pVLPI6p7m6BG6WAxAQC62
	d9+VFzIjplLVrDdv6RbkfMXjqoW6gHFOVPukQHmSnj/rYaJdc9T11K8HkSwdLQHD/wYZxYuJ2Z6po
	UNf38M3306E27WXDz+UxYouAsAoQ4KEO8A9iWxs/xBumoi3R7ppwrBZQ009AdoyYACrd3U2jJRPxv
	jealmvOvERhEJMAlFG7sIboA+0IOslWgRwKidg9IdciKBmNVeAzMHbrcF2bA26rTYCmVwlCYg2/JY
	MptTaqIA==;
Received: from i53875b34.versanet.de ([83.135.91.52] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1t0EuH-0005VP-TD; Mon, 14 Oct 2024 08:50:17 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: vkoul@kernel.org, kishon@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, Frank Wang <frawang.cn@gmail.com>
Cc: linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-rockchip@lists.infradead.org, william.wu@rock-chips.com,
 tim.chen@rock-chips.com, yubing.zhang@rock-chips.com,
 Frank Wang <frank.wang@rock-chips.com>
Subject: Re: [PATCH 1/2] dt-bindings: phy: rockchip-usbdp: add rk3576
Date: Mon, 14 Oct 2024 08:50:16 +0200
Message-ID: <1900633.tdWV9SEqCh@diego>
In-Reply-To: <20241014020342.15974-1-frawang.cn@gmail.com>
References: <20241014020342.15974-1-frawang.cn@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Am Montag, 14. Oktober 2024, 04:03:41 CEST schrieb Frank Wang:
> From: Frank Wang <frank.wang@rock-chips.com>
> 
> Add compatible for the USBDP phy in the Rockchip RK3576 SoC.
> 
> Signed-off-by: Frank Wang <frank.wang@rock-chips.com>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>

> ---
>  Documentation/devicetree/bindings/phy/phy-rockchip-usbdp.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/phy/phy-rockchip-usbdp.yaml b/Documentation/devicetree/bindings/phy/phy-rockchip-usbdp.yaml
> index 1f1f8863b80d..b42f1272903d 100644
> --- a/Documentation/devicetree/bindings/phy/phy-rockchip-usbdp.yaml
> +++ b/Documentation/devicetree/bindings/phy/phy-rockchip-usbdp.yaml
> @@ -13,6 +13,7 @@ maintainers:
>  properties:
>    compatible:
>      enum:
> +      - rockchip,rk3576-usbdp-phy
>        - rockchip,rk3588-usbdp-phy
>  
>    reg:
> 





