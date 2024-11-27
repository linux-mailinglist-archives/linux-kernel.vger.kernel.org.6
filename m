Return-Path: <linux-kernel+bounces-423233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DD819DA4C5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 10:29:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F9B9B21515
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 09:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 162A1192B9E;
	Wed, 27 Nov 2024 09:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="DNiHHf5i"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378171925BF;
	Wed, 27 Nov 2024 09:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732699758; cv=none; b=DrSPXlsD1kRYVFKgICC3xqYwtxrAWHJe/IGuTaiIpdYuclKp2nXfqAEj5gvY8StpeoUYFsFzMk5rE0FjdTyV5CaG995vJBfwmTaVZM4dwgt3ewuCf+potx+w5vwoCGLUnhgehF7fblQ/IaNdrnnSGsByKeJY2lISvGPMI77ChGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732699758; c=relaxed/simple;
	bh=xcLioAl/Dv+ef87c57/4ljJanV46MqNzwNDD0/mxs4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=flXYloHJfET7cfhnmSrqgNVjbaFkY775ZANRpkAIBH1TEBFw5a9RftsKfVk4a+IV0GC+o1dyJcz4z55HUF6+KLczeVulIO1tdQDTeZJRtgd05qOaN9MzRPS3H2BedZQfu26KWW/zvNv8L8Vy5PM2iJvRJ2ukoJSmcBdCVjHAprk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=DNiHHf5i; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=US6YPwHGZjjY/0o2sbSCg5NuQ0NYboqqQtTlEz4XOBo=; b=DNiHHf5igtfm+55scaCjyZ70X7
	iuSqoFzaV3fG6GsxmRNtB0hU+YItLw9Kt1xc9qvPlnKftzC5IUJL3cswmUB+durrrkwlkVff3QvL0
	oW/WUQ4VENUS3go8z/eNA53dD5V82fV/Ub4F+EJb7EjER23M5HtZZG0OhCpgS52/ylbltk4fkF2df
	IKXxYTRzp07YGOJjLfjr6Hgs0mNiwvA+cvN6OcfjyE2k0lqR5Mrcu042p6kmfnA3EF5Y5h7pqMKxu
	e158u8PPCV38GUdV5KUReHvHOWNJANjHf7bWIGMXg98bcgU0FxyzxgG5tD9n5rlr1GxijAG/IVzpb
	Ttb1A31A==;
Received: from i5e86190f.versanet.de ([94.134.25.15] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tGEMA-0006nM-HZ; Wed, 27 Nov 2024 10:29:10 +0100
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Damon Ding <damon.ding@rock-chips.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 rfoss@kernel.org, vkoul@kernel.org, sebastian.reichel@collabora.com,
 cristian.ciocaltea@collabora.com, l.stach@pengutronix.de,
 andy.yan@rock-chips.com, hjc@rock-chips.com, algea.cao@rock-chips.com,
 kever.yang@rock-chips.com, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-phy@lists.infradead.org, Damon Ding <damon.ding@rock-chips.com>,
 sebastian.reichel@collabora.com
Subject:
 Re: [PATCH v1 04/10] phy: phy-rockchip-samsung-hdptx: Add support for eDP
 mode
Date: Wed, 27 Nov 2024 10:29:09 +0100
Message-ID: <4260470.1IzOArtZ34@diego>
In-Reply-To: <20241127075157.856029-5-damon.ding@rock-chips.com>
References:
 <20241127075157.856029-1-damon.ding@rock-chips.com>
 <20241127075157.856029-5-damon.ding@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Damon,

Am Mittwoch, 27. November 2024, 08:51:51 CET schrieb Damon Ding:
> Add basic support for RBR/HBR/HBR2 link rates, and the voltage swing and
> pre-emphasis configurations of each link rate have been verified according
> to the eDP 1.3 requirements.
> 
> Signed-off-by: Damon Ding <damon.ding@rock-chips.com>
> ---

[ ... huge block of DP phy support ...]

yes that block was huge, but I also don't see a way to split that up in a
useful way, so it should be fine.


> +static int rk_hdptx_phy_set_mode(struct phy *phy, enum phy_mode mode,
> +				 int submode)
> +{
> +	return 0;
> +}

I think it might make sense to go the same way as the DCPHY and also
naneng combophy, to use #phy-cells = 1 to select the phy-mode via DT .

See [0] for Sebastians initial suggestion regarding the DC-PHY.
The naneng combophy already uses that scheme of mode-selection too.

There is of course the issue of backwards-compatibility, but that can be
worked around in the binding with something like:

 '#phy-cells':
    enum: [0, 1]
    description: |
      If #phy-cells is 0, PHY mode is set to PHY_TYPE_HDMI
      If #phy-cells is 1 mode is set in the PHY cells. Supported modes are:
        - PHY_TYPE_HDMI
        - PHY_TYPE_DP
      See include/dt-bindings/phy/phy.h for constants.

PHY_TYPE_HDMI needs to be added to include/dt-bindings/phy/phy.h
but PHY_TYPE_DP is already there.

That way we would standardize on one form of accessing phy-types
on rk3588 :-) .

Also see the Mediatek CSI rx phy doing this too already [1]


Heiko

[0] https://lore.kernel.org/linux-rockchip/udad4qf3o7kt45nuz6gxsvsmprh4rnyfxfogopmih6ucznizih@7oj2jrnlfonz/
[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/phy/mediatek,mt8365-csi-rx.yaml




