Return-Path: <linux-kernel+bounces-295147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67A499597A6
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 12:29:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 892E61F21AAB
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 10:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0563E1D049E;
	Wed, 21 Aug 2024 08:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="RzFPWaY0"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355F51D0498
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 08:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724229598; cv=none; b=iv/MLEIpZ8utQhPGh2hNe/aMPFkJgia4zrjjyS4umMoBIwi3aRKHBl/IrwKfwuAdLU9LrRlPSh36G7Q5QS9Jj4cwKD6CueSjEDw38tcg3KfpnRTZ8cUgS6YTcLfE5RTZJca1QAC2MbmwPXPLLw3wbguZDBmNbYgGrHd1afDAPHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724229598; c=relaxed/simple;
	bh=tHvvFCQ0u6xnxnEE/G4QCYixb4rvYnv0lQrkuQOzw68=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q18ws52U80L1m3vSOvcNuvblGhHpFdXx8DrfynPPAF8+i5i0cDrddUpe0WA/DzseK2pRWLyLwGzh573zs+OdgxBotawz0kEy/Ndh6ps9bwK3uREsYPl8c6DDkNx9pdMcoo6e+mfTupwItNKC3PbICT2nz51J9jBODZNeK/evtgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=RzFPWaY0; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=TNlrqR9qfwPAJLvJisUTd40ki99DSrsE8LQudixVXCo=; b=RzFPWaY0ITb98LjfRNdrnfXojD
	UiFpDSbSpC+4Xf1YVqDDeoX50XVWf5eGM5nnvURzqNC7wzzzTzWVrXcCnXnB+bhBmzdW/W6WKvuvW
	boFjTw1gCJpv445Abl+jCLzWA3Ww+uBFHwvBtQLyrjfDDaZ+H6697crz/96q0KTwWHNVtGoSTPk4T
	ovkjji4rU8WzVBb0DUMSHNBJsflqa9Ald49DslM/2uRFI4YaOje18pMS8mGTT8gWnpFzu7J1fdJad
	r8gXH7vQITWhXL2k8LYzT+wVECHvFOW52V/IIxzBW/5Bp2bYK1iAe1XorKaE/NMq/wHPItJ9Pb1v5
	qwoRAupA==;
Received: from i53875aca.versanet.de ([83.135.90.202] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sggsL-0004xm-FZ; Wed, 21 Aug 2024 10:39:29 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: linux-rockchip@lists.infradead.org, linux-phy@lists.infradead.org,
 Dragan Simic <dsimic@manjaro.org>
Cc: vkoul@kernel.org, kishon@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH v2 1/3] phy: phy-rockchip-inno-usb2: Perform trivial code cleanups
Date: Wed, 21 Aug 2024 10:39:54 +0200
Message-ID: <5307900.6fTUFtlzNn@diego>
In-Reply-To:
 <14167d6b025e18d2a06ee429feea6551ef6f9c44.1724225528.git.dsimic@manjaro.org>
References:
 <cover.1724225528.git.dsimic@manjaro.org>
 <14167d6b025e18d2a06ee429feea6551ef6f9c44.1724225528.git.dsimic@manjaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Am Mittwoch, 21. August 2024, 09:37:53 CEST schrieb Dragan Simic:
> Perform a few trivial code cleanups, e.g. to obey the reverse Christmas tree
> rule, to avoid use of "{ ... }" code blocks where they aren't really needed,
> or to avoid line wrapping by using the 100-column width better.
> 
> No intended functional changes are introduced by these code cleanups.
> 
> Signed-off-by: Dragan Simic <dsimic@manjaro.org>

> @@ -445,7 +445,6 @@ static int rockchip_usb2phy_extcon_register(struct rockchip_usb2phy *rphy)
>  	}
>  
>  	rphy->edev = edev;
> -
>  	return 0;
>  }

depending on how nitpicky we want to be, I'm not very fond of this change.
Assigning the extcon-dev and returning "0" are two different actions, and
I think most drivers do actually use a blank line between those.

But that really is just a style preference for me, so anyway

Reviewed-by: Heiko Stuebner <heiko@sntech.de>



