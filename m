Return-Path: <linux-kernel+bounces-302238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7291595FB7A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 23:17:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5EE51C21017
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 21:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A057A13D53F;
	Mon, 26 Aug 2024 21:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aurel32.net header.i=@aurel32.net header.b="kfiXjXT7"
Received: from hall.aurel32.net (hall.aurel32.net [195.154.113.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BAFC19D089;
	Mon, 26 Aug 2024 21:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.154.113.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724706929; cv=none; b=HKdfYBpEwQiTD7mtdLVDT3JB7pEbEd+cCrTR61/KoAndwO0hT0Uk5O54Wvc93bCcr7ipCZf6EsqNV2NijAlOwwQ1BtaZeBau+Y1TMzkJi0oj/7wHohf+61n8uVH5Mve22vY8m7DXB+nAFklrjbfxhayEXR1y4mVRFLoHuw04SB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724706929; c=relaxed/simple;
	bh=k5YPFOrs6fTATMDWwAOqcfw2Gn7fqDLtBygYvZQHQ6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cvsyH3uggi1GC0b/n4c+SjtIhgn9xqgmbYkN6Z+D5pbWsicufs6fZ4Yi8EUwG/fPyu8OZXjoM5JyKnroa9ypuV0lgYv2ekWUN3Dr2wtfoj57m6acmCWfTYo/L0GGWmssubbcxRpPScMiq9eHG+9nNuq4k+eGYIZBzph3JIb6BAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aurel32.net; spf=pass smtp.mailfrom=aurel32.net; dkim=pass (2048-bit key) header.d=aurel32.net header.i=@aurel32.net header.b=kfiXjXT7; arc=none smtp.client-ip=195.154.113.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aurel32.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aurel32.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aurel32.net
	; s=202004.hall; h=In-Reply-To:Content-Type:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Content-Transfer-Encoding:From:Reply-To:
	Subject:Content-ID:Content-Description:X-Debbugs-Cc;
	bh=hEJqLkmZIVJ3wjtshHhvyIvFr1RorWiDAtkC1KcSIh4=; b=kfiXjXT7BgYlgCdzvsI7pG4hFF
	LSRToOaL3SNqqNCAm0xxpMv3oRA8o0n/b3++Zy5YS1rSPCZNx2DsuavOK//MpHqxFPlDYV3iMIbWz
	MygI8lERhOP7onOTWS8tBQtqCgLGS4XaoGz5lGpxUI0wXGdrymSxH6D9SjJgOwYhgq1TOM/EhAH0v
	uWqbY4A1S+NZ5x/UlI1lndqhD6QsfCKb1dNIwyHlPgIIUMt5kxRfr9A6vttnATsOHiGC8Dt9GhCBz
	Me7Hb4LOeuhpk/NZmriArgwdGMA6gVSu86jS9z4cjsW9/TWnBIfU5wgh+D7mv/q7uHGj60Pjs2qwJ
	bqHTY2ug==;
Received: from ohm.aurel32.net ([2001:bc8:30d7:111::2] helo=ohm.rr44.fr)
	by hall.aurel32.net with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <aurelien@aurel32.net>)
	id 1sih3C-005vE0-1j;
	Mon, 26 Aug 2024 23:14:58 +0200
Date: Mon, 26 Aug 2024 23:14:58 +0200
From: Aurelien Jarno <aurelien@aurel32.net>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dongjin Kim <tobetter@gmail.com>,
	linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] arm64: dts: rockchip: Correct vendor prefix for
 Hardkernel ODROID-M1
Message-ID: <ZszwUp4UfgPSiIkl@aurel32.net>
Mail-Followup-To: Jonas Karlman <jonas@kwiboo.se>,
	Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dongjin Kim <tobetter@gmail.com>,
	linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240826205538.1066103-1-jonas@kwiboo.se>
 <20240826205538.1066103-3-jonas@kwiboo.se>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240826205538.1066103-3-jonas@kwiboo.se>
User-Agent: Mutt/2.2.13 (2024-03-09)

On 2024-08-26 20:55, Jonas Karlman wrote:
> The vendor prefix for Hardkernel ODROID-M1 is incorrectly listed as
> rockchip. Use the proper hardkernel vendor prefix for this board.
> 
> Fixes: fd3583267703 ("arm64: dts: rockchip: Add Hardkernel ODROID-M1 board")
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
>  arch/arm64/boot/dts/rockchip/rk3568-odroid-m1.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3568-odroid-m1.dts b/arch/arm64/boot/dts/rockchip/rk3568-odroid-m1.dts
> index a337f547caf5..9a122f67a6c4 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3568-odroid-m1.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3568-odroid-m1.dts
> @@ -13,7 +13,7 @@
>  
>  / {
>  	model = "Hardkernel ODROID-M1";
> -	compatible = "rockchip,rk3568-odroid-m1", "rockchip,rk3568";
> +	compatible = "hardkernel,rk3568-odroid-m1", "rockchip,rk3568";
>  
>  	aliases {
>  		ethernet0 = &gmac0;

Ditto, thanks for the fix.

Reviewed: Aurelien Jarno <aurelien@aurel32.net>

-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                     http://aurel32.net

