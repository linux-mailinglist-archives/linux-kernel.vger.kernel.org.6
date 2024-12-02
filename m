Return-Path: <linux-kernel+bounces-427190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E1869DFDE2
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 10:57:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF62FB22A37
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 09:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64D1E1FBE96;
	Mon,  2 Dec 2024 09:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="i/dJ/qDZ"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D9521F949;
	Mon,  2 Dec 2024 09:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733133434; cv=none; b=q5ryqdrEy+0XSBf9zExqWv46jjCyvPO4hR8paMlTv1JuNZR4CfChZbyG1xN1Lo159lRWG2ObOZZDxYIw8kVNZeduVaSN+rWp1sN3GJORoSAzKPuQR2eAQ7cRKEsHNfalvB2h7c2ikpiJBJ0X8XBdmMk39zPSSoNGnEXDUtSujNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733133434; c=relaxed/simple;
	bh=GnfNzt3KbFYFi9nwt42MZ8lghzINadPOi1gcOZVLanI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iKYXTrOlqBLNFazeSIHOB4dwgP+1FUTNoDtwxq42cPQNprKgVpzH4YNUbH/OZlt639mTxjrUXhN2l2gUqG3fnpVcGIbWb5lCMfX+gv4W0Wyt024djlavRi4BguCobiMbbdepLd8L+6o1Z12i+nV/AbbbkijH55aFKa9nLwbKxbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=i/dJ/qDZ; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=zX++2BfI71EfbL0UifJIyYdnjIn03M87iaL/MLYsMe4=; b=i/dJ/qDZA4x76D5c0J418PwECQ
	pPOKivungXawQrf6RAPl5Qkpki5ptQMnwt6cWyxMj81J8JQG5s0V4B8s9z46wVRtMDLDP9BgCHuBu
	qmo/ukICI31OS4muDHfZxYHggjmt4paR2h1nCFoQqKKFtrvJPj+YAD+/TaC1UpD9y/9WkDg2bE3mc
	wYZmq2jl2BWnEnBhLcRltjz3FuNkDg9xVwXK/5VYnBcQzsB0MTrN1T12AzMuRX8nJ4b3e4tottRWv
	4Nf5TZg3lHKGR51Rp6jX083np7KoII81O2a48MBF/ZSTMuN52ni2047l5iKt1qnFK7h5qN+hCtnEE
	5NbaPxBQ==;
Received: from i53875bc4.versanet.de ([83.135.91.196] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tI3Am-0000Ii-BO; Mon, 02 Dec 2024 10:56:56 +0100
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Jakob Unterwurzacher <jakobunt@gmail.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Sasha Levin <sashal@kernel.org>,
 Iskander Amara <iskander.amara@theobroma-systems.com>,
 Jakob Unterwurzacher <jakob.unterwurzacher@cherry.de>,
 Vahe Grigoryan <vahe.grigoryan@theobroma-systems.com>,
 Quentin Schulz <quentin.schulz@cherry.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH] arm64: dts: rockchip: increase gmac rx_delay to 0x11 on
 rk3399-puma
Date: Mon, 02 Dec 2024 10:56:55 +0100
Message-ID: <2578458.4XsnlVU6TS@diego>
In-Reply-To: <63b3be80-cb6c-49e5-858f-70fd826140c5@cherry.de>
References:
 <20241202090408.201662-1-jakob.unterwurzacher@cherry.de>
 <63b3be80-cb6c-49e5-858f-70fd826140c5@cherry.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Am Montag, 2. Dezember 2024, 10:52:06 CET schrieb Quentin Schulz:
> Hi Jakob,
> 
> On 12/2/24 10:04 AM, Jakob Unterwurzacher wrote:
> > During mass manufacturing, we noticed the mmc_rx_crc_error counter,
> > as reported by "ethtool -S eth0 | grep mmc_rx_crc_error" to increase
> > above zero during nuttcp speedtests.
> > 
> > Cycling through the rx_delay range on two boards shows that is a large
> > "good" region from 0x11 to 0x35 (see below for details).
> > 
> 
> Is this missing a "there" after that? "that there is a large good region"?
> 
> > This commit increases rx_delay to 0x11, which is the smallest
> > possible change that fixes the issue we are seeing on the KSZ9031 PHY.
> > This also matches what most other rk3399 boards do.
> > 
> > Tests for Puma PCBA S/N TT0069903:
> > 
> > 	rx_delay mmc_rx_crc_error
> > 	-------- ----------------
> > 	0x09 (dhcp broken)
> > 	0x10 897
> > 	0x11 0
> > 	0x20 0
> > 	0x30 0
> > 	0x35 0
> > 	0x3a 745
> > 	0x3b 11375
> > 	0x3c 36680
> > 	0x40 (dhcp broken)
> > 	0x7f (dhcp broken)
> > 
> > Tests for Puma PCBA S/N TT0157733:
> > 
> > 	rx_delay mmc_rx_crc_error
> > 	-------- ----------------
> > 	0x10 59
> > 	0x11 0
> > 	0x35 0
> > 
> > Signed-off-by: Jakob Unterwurzacher <jakob.unterwurzacher@cherry.de>
> 
> This would be a candidate for backporting I believe.
> 
> Therefore, a

also please include a

Fixes: 2c66fc34e945 ("arm64: dts: rockchip: add RK3399-Q7 (Puma) SoM")

> Cc: <stable@vger.kernel.org>
> 
> here would have been nice (in the commit log), c.f. 
> https://www.kernel.org/doc/html/latest/process/submitting-patches.html#select-the-recipients-for-your-patch
> 
> > ---
> >   arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi
> > index 9efcdce0f593..13d0c511046b 100644
> > --- a/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi
> > +++ b/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi
> > @@ -181,7 +181,7 @@ &gmac {
> >   	snps,reset-active-low;
> >   	snps,reset-delays-us = <0 10000 50000>;
> >   	tx_delay = <0x10>;
> > -	rx_delay = <0x10>;
> > +	rx_delay = <0x11>;
> 
> While at it, we could reorder this alphabetically and move rx_delay 

I would disagree. This is a "fix", so should ideally only do the minimal
changes to make life of the stable people easier.

Doing this one-line change is way easier to understand than stuff also
moving around.

Heiko

> between pinctrl-0 and snps,reset-gpio? c.f. 
> https://www.kernel.org/doc/html/latest/devicetree/bindings/dts-coding-style.html#order-of-properties-in-device-node 
> rx_delay and tx_delay seem to be vendor-specific but without the vendor 
> prefix, but so is snps,reset-gpio so that should be fine to reorder this 
> way.
> 
> Considering we have an option for KSZ9031 on RK3588 Jaguar and RK3588 
> Tiger and the "same" MAC IP is used and that we use the same TXD and RXD 
> delay than on RK3399 Puma right now, I guess we would want to check 
> those don't need a change as well? (funnily enough, all RK3588-based 
> boards in 6.12 actually have 0x00 for rx_delay and 0x43/0x44 for 
> tx_delay, except ours which are at 0x10). Not a blocker for this patch 
> though, so:
> 
> Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
> 
> Thanks!
> Quentin
> 





