Return-Path: <linux-kernel+bounces-440996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95B079EC7A3
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 09:47:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E83E3188C654
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 08:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E7621E9B12;
	Wed, 11 Dec 2024 08:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="fFDwsdp2"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2471E9B06;
	Wed, 11 Dec 2024 08:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733906855; cv=none; b=iiRJYOxaaPKOTYOoXMJjYJSdi2L+XMyUxGxr8pqd/cndasLDPwdaNH/YGZAKO4KTd7yI/KGx7rGCwbfb9ZMIGyMSBT2cA7jfuFr1NND/KLw8mHoq+VX+eg4uIug3H7so2WBFUE789fxQxc5gKbNU1+pABIvfTjF6e2HVc5qQgfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733906855; c=relaxed/simple;
	bh=koDuNN51UZqR0k8WbBv23cNisUQJ9LuwQj5sXklqQQI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t9oB0utaATd93b6GvDXjUW0WlAF2Uoxwa8101INQjQnepbN3Ubcr6rrNTWNDUq5Kv0PMRVXR75FXBVjwpXDXhWx4S2T4u2wGza+cAwbSeHX2hoVU9Nmun9OVuWIA88+w4dwmNHCOa7+eJBvLfAQPif+M9KkJtgrslPjWWD4kups=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=fFDwsdp2; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=TOB+Fxp49rSShIZTVjtd1jIBj8qsd4mGBRlOc0nOjoY=; b=fFDwsdp22wcbCT+bR3kubCHU7P
	RgjeyO2qzR2mrXOHIzbvyXNyJmiTtyixsDWmkL+7GTA458f+BQtAlLKGR5M0koTY12SzYatQzcfAT
	KVFy/duNKx3RB/Ay3zxnrJX+o9QFscjXydr3HfVAiNkVEWgy0R6uIce38V3EsH2n3WpWN7rkr1YGS
	G29nCmuM0v4Ss6poRMfMmEd6faZJrAEpe7in/bMwYsBCZy1lNZqzTmHebq2W/HjDUbaka33acg0HH
	T3kBCi086tPHtknNMKNEtd+jjETUR+6Nl5NdgwcVJf7OunvqLCf4v1iMWTNzGHjDeZFCVM+Xkx90y
	xhDC3BFQ==;
Received: from i53875bc4.versanet.de ([83.135.91.196] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tLIN0-0000Bg-N9; Wed, 11 Dec 2024 09:46:58 +0100
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Sandy Huang <hjc@rock-chips.com>, Andy Yan <andy.yan@rock-chips.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: Alexandre ARNOUD <aarnoud@me.com>, kernel@collabora.com,
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
Subject: Re: [PATCH v2 0/4] Add support for HDMI1 output on RK3588 SoC
Date: Wed, 11 Dec 2024 09:46:57 +0100
Message-ID: <12942826.iMDcRRXYNz@diego>
In-Reply-To: <20241211-rk3588-hdmi1-v2-0-02cdca22ff68@collabora.com>
References: <20241211-rk3588-hdmi1-v2-0-02cdca22ff68@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Cristian,

Am Mittwoch, 11. Dezember 2024, 00:06:13 CET schrieb Cristian Ciocaltea:
> The patches provide the basic support to handle the second HDMI output
> port found on Rockchip RK3588 SoC.
> 
> For now I enabled it on Radxa ROCK 5B only, the board I've been using to
> validate this.
> 
> ** IMPORTANT **
> 
> The series has a runtime dependency on "phy: phy-rockchip-samsung-hdptx:
> Don't use dt aliases to determine phy-id", a patch submitted recently by
> Heiko [1].  Without applying it, the functionality on both HDMI TX ports
> will break.

Looking at the drm/rockchip patch, that should not cause disruptions on
its own, right?

Only with the dts-parts enabled would we run into phy-issue.
(Asking, because things go through different trees and the drm
part looks ready)


Heiko


> Furthermore, please note this is subject to the same limitations as
> HDMI0 when it comes to the supported display modes.  The fixes provided
> via [2] are not applicable to HDMI1, hence I will handle it separately
> as soon as all dependencies are merged.
> 
> Thanks,
> Cristian
> 
> [1] https://lore.kernel.org/lkml/20241206103401.1780416-3-heiko@sntech.de/
> [2] https://lore.kernel.org/all/20241116-vop2-hdmi0-disp-modes-v1-0-2bca51db4898@collabora.com/
> 
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> ---
> Changes in v2:
> - Override hdmi1 pinctrl-0 on rock-5b as it requires hdmim0_tx1_cec
>   instead of hdmim2_tx1_cec (fixes a pin conflict when enabling
>   CONFIG_SPI_ROCKCHIP_SFC)
> - Link to v1: https://lore.kernel.org/r/20241207-rk3588-hdmi1-v1-0-ca3a99b46a40@collabora.com
> 
> ---
> Cristian Ciocaltea (4):
>       drm/rockchip: dw_hdmi_qp: Add support for RK3588 HDMI1 output
>       arm64: dts: rockchip: Add PHY node for HDMI1 TX port on RK3588
>       arm64: dts: rockchip: Add HDMI1 node on RK3588
>       arm64: dts: rockchip: Enable HDMI1 on rock-5b
> 
>  arch/arm64/boot/dts/rockchip/rk3588-extra.dtsi  |  62 ++++++++++++
>  arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts |  44 ++++++++-
>  drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c  | 119 +++++++++++++++++++-----
>  3 files changed, 200 insertions(+), 25 deletions(-)
> ---
> base-commit: 40384c840ea1944d7c5a392e8975ed088ecf0b37
> change-id: 20241207-rk3588-hdmi1-704cbb7cd75f
> 
> 





