Return-Path: <linux-kernel+bounces-295156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 371A89597D4
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 12:41:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69D711C209C3
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 10:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCAB41D45F5;
	Wed, 21 Aug 2024 08:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="QcoTYbVa"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1034B1D45F2
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 08:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724229831; cv=none; b=plrdNgCUSZL1IFYwPq6LysbYNfKQjKlXFv4QNjFKXligvn/XbrNjwj/nzbeDfaW+UsMxex3yH+ly3+GZZK2RPY6sVT1+hD93ZOWJl0Fb4Gju5Tv5z/wRnLjwXC2IzGqRp4LltiTqn4ylwSudObPKcp2ivxdhMybCtcvUncmsSbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724229831; c=relaxed/simple;
	bh=18iOuPQ2oz3eJXc26U9q2i0XK//JIVBl/QmiREyK5bQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CY6XIoQldprLGLU7bpzWwipZiycMDqHZ299x8163nIWyAdITeuxi8MM1vH6qt5oRS0PxgsRt/cdbkZlLDydAE2kl/JneW5NoK2dSaIWUOtmkMiO0y0vUvrE5pER1uisUZC65ufnwX9q9g6YpWk5xjPTmTbyzKEsP7ZrykypN3JA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=QcoTYbVa; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=b+eB73GrPccCdLU6CWfc1pg5yiGEbiwTbUmoc3zvXNA=; b=QcoTYbVaABv8lmTWg5EUXU9zOc
	fHDmF8VR5HyWsQh0p/qGZ+G/gQTSU181Vygyx0Wxen1cuH+j3E5rUPIu2PSLBFlABKu7TSi0OfDh1
	zFXCUqXNkXlDhB10krdXIqltXmqyD4BmujaVN1nFDWalNBwSSkd/BMHxh3yR4fYdY5hIz3I5/O/xr
	NIHN2kh5Fbbg1fZyACF+VHp1kEDdRNHwbsv6BPODxUFsz7KPOQRLwsRaLjF0YGahPeyRY49r6sqo2
	ibZQIZTK4bLF49hr2KsKx27Iboatt212jDpMVj6UIneynrCsytrfD0IiRKaFoGPfhHPyvlgqXw8wa
	otCc+P4g==;
Received: from i53875aca.versanet.de ([83.135.90.202] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sggwG-0004yi-VV; Wed, 21 Aug 2024 10:43:33 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: linux-rockchip@lists.infradead.org, linux-phy@lists.infradead.org,
 Dragan Simic <dsimic@manjaro.org>
Cc: vkoul@kernel.org, kishon@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH v2 3/3] phy: phy-rockchip-inno-usb2: Improve error handling while
 probing
Date: Wed, 21 Aug 2024 10:44:00 +0200
Message-ID: <12869965.VsHLxoZxqI@diego>
In-Reply-To:
 <866445027a4f41165c872f494b04c218b6e67b09.1724225528.git.dsimic@manjaro.org>
References:
 <cover.1724225528.git.dsimic@manjaro.org>
 <866445027a4f41165c872f494b04c218b6e67b09.1724225528.git.dsimic@manjaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Am Mittwoch, 21. August 2024, 09:37:55 CEST schrieb Dragan Simic:
> Improve error handling in the probe path by using function dev_err_probe()
> where appropriate, and by no longer using it rather pointlessly in one place
> that actually produces a single, hardcoded error code.
> 
> Signed-off-by: Dragan Simic <dsimic@manjaro.org>

> @@ -1375,8 +1372,10 @@ static int rockchip_usb2phy_probe(struct platform_device *pdev)
>  	rphy->irq = platform_get_irq_optional(pdev, 0);
>  	platform_set_drvdata(pdev, rphy);
>  
> -	if (!phy_cfgs)
> -		return dev_err_probe(dev, -EINVAL, "phy configs are not assigned!\n");
> +	if (!phy_cfgs) {
> +		dev_err(dev, "phy configs are not assigned\n");
> +		return -EINVAL;
> +	}
>  
>  	ret = rockchip_usb2phy_extcon_register(rphy);
>  	if (ret)

I really don't understand the rationale here. Using dev_err_probe here 
is just fine and with that change you just introduce more lines of code
for exactly the same functionality?



