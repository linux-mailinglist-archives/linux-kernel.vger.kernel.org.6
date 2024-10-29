Return-Path: <linux-kernel+bounces-386331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A3829B4201
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 06:58:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4885A1C215FB
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 05:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9078201027;
	Tue, 29 Oct 2024 05:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="NbrwfI7a"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618877464;
	Tue, 29 Oct 2024 05:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730181478; cv=none; b=Y/Adj+OoIpx4irMSS7D0/NEMdlG+P0AtyUHbLn7Hg5zsYYYDZkSBnkD697NEK3tgOkj7cFBiduF9wu/deGu6sCFobUxAO4f4HF+Ts4pY2SqdyUVg9Ah4YLg52n+AhIRJUbUTNB5aWZ1gbXj4yh3yDSB7TY5gxrIzfivX3XxOI7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730181478; c=relaxed/simple;
	bh=ZdmxadM0qitMz8h++TS+i+JMGgqwYOA9lEVe+RyuLTA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nVyQ+TqIxs5kAm66vk9aJA7y79L3YLC1PPToH7OYFdegaVE7b4li/jw26dErl3MJMZFkY9CmRs8uefA6XwCE00acKzweVzSsyu+xaRlXucY85XnUJK216NXwz02U0yW8d2ot3IH3gjjOVQoL+h+YFUcaelbCZ4s/SmH51ShGkYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=NbrwfI7a; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=y5hIEno3hSw6Bs0nElkBzz+S0GGKfeU4NL68Zcym0TA=; b=NbrwfI7aCxqhCar/MFfBqte2mf
	VGpnwyAfOfOh9lRUXfqFcG42dV5YmDVFqRY8J6BHuxzjYZktxw94kcQstkaCDifpGDCKhfJ28j9ME
	1hEM7NxgPSOWMhvNMbTOv0+my+QF6FOLbzvtDnVxyMDLLxm0lsrObclwmLDpcT0g8koFLu+EzSFqc
	oizBkhahfbGiY7y16s/95CbXy/nKXo2yYrEG0sAxBGhJ8YJXNKecY13vxY1KcN65YDl3/4Bo4cDz4
	D9RnOzStcM0gxOrICT6d92LrRXZejeZB7efsDRjKfZonPNUp1mub0wTCuTODyBTntFmIHNc7SCA0n
	vledpmHA==;
Received: from [185.156.123.69] (helo=phil.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1t5fEb-0005Ts-O7; Tue, 29 Oct 2024 06:57:41 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Dmitry Yashin <dmt.yashin@gmail.com>
Cc: linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, Dmitry Yashin <dmt.yashin@gmail.com>
Subject:
 Re: [PATCH 2/3] dt-bindings: arm: rockchip: add Banana Pi BPI-P2 Pro board
Date: Tue, 29 Oct 2024 06:57:39 +0100
Message-ID: <5957455.DvuYhMxLoT@phil>
In-Reply-To: <20241028213314.476776-3-dmt.yashin@gmail.com>
References:
 <20241028213314.476776-1-dmt.yashin@gmail.com>
 <20241028213314.476776-3-dmt.yashin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Am Montag, 28. Oktober 2024, 22:33:13 CET schrieb Dmitry Yashin:
> Banana Pi BPI-P2 Pro is the SBC made by Shenzhen SINOVOIP based on
> Rockchip RK3308.
> 
> Banana Pi BPI-P2 Pro features:
> - Rockchip RK3308B-S
> - DDR3 512 MB
> - eMMC 8 GB
> - 100M lan + onboard PoE
> - 40 pin and 12 pin headers
> - AP6256 BT + WIFI
> - TF card slot
> - 2x USB 2.0 (Type-C OTG and Type-A)
> - Headphone jack
> 
> Add devicetree binding for Banana Pi BPI-P2 Pro.
> 
> Signed-off-by: Dmitry Yashin <dmt.yashin@gmail.com>
> ---
>  Documentation/devicetree/bindings/arm/rockchip.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
> index 1e3eceb266b7..0c85c15d5c04 100644
> --- a/Documentation/devicetree/bindings/arm/rockchip.yaml
> +++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
> @@ -1104,6 +1104,11 @@ properties:
>            - const: rockchip,rk3568-evb1-v10
>            - const: rockchip,rk3568
>  
> +      - description: Sinovoip RK3308 Banana Pi BPI-P2 Pro

isn't BPI the short form of Banana Pi?
So the naming is sort of double and I'd expect it to be
    Sinovoip RK3308 BanaPi P2 Pro
similar to how the R2 below does is?


Heiko

> +        items:
> +          - const: sinovoip,rk3308-bpi-p2pro
> +          - const: rockchip,rk3308
> +
>        - description: Sinovoip RK3568 Banana Pi R2 Pro
>          items:
>            - const: sinovoip,rk3568-bpi-r2pro
> 





