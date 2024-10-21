Return-Path: <linux-kernel+bounces-374687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF95D9A6E8B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 17:45:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B084228225A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 15:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 546CB1C57B4;
	Mon, 21 Oct 2024 15:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="wSSc1grT"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E9CD1C4600;
	Mon, 21 Oct 2024 15:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729525496; cv=none; b=HSv/AdmxwtFyop91+XQBSYLN84U1GfdsAJfZCKV9KuwWuB93rwWTo3xsdM2qVGBbzLYGobPzlIIZWJtyZ6erMf5NgsENL8gYqVIIjLH573iD2i49tkldmpCmqpzOoK1RPDH+dYeCfbYVXCVy7H63lYHiLCjQjQfG9MkfLU3muqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729525496; c=relaxed/simple;
	bh=COB0Nsn/V1fseoz89XT87A7tUCkXqVldk2SGie6FziU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NvFoA/hFNBwuButSQWS6DcXeeUQi/VQ0SH7hCNZonfQGEtCycH8RTLTnXMFcQXEEUSijwmCfyCav9YjOgNFJEcZFFwB8YSemYWeNjsi4xwcyOXEntiOEc60ZqEP6xFL9PZgGi0rawz0Yfq4MouVGBRo31Fg8F2sevXj52eTlQ3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=wSSc1grT; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=u+D70KubbG9mjRtXMOnJnl5R7+6sO8cl9zaS6GDovH4=; b=wSSc1grTXFJvOt6uayi4fHEUS8
	MhOzXRiE62SIVMSxQP+5+uYbZLaaQUl4MeOpWP/qzLWNecouMobrnbEvEaZXIUDWZEB6yv7CDThBM
	/4o4u/TOcw+3DngsOb561e9uBcepRSXi3xK1wHbT3Lp2iVdM42LsEYO7vuSenJgoz6m4VCqjHDyqH
	uwY9QPtY6LVVvILTILBTnhWUogjoZ44PSdiInbfplg6zcgSI8MerrMhGLwVTHFnSKu7ZtE+sataz0
	2uoYdHauD5lC+mhl22s5uBE2zvTpmauX9Hfulc2VMnZFjjRLSm+uRkAo9d3d3NBjAKMCZmVOw7T+A
	E4xFIcdA==;
Received: from i53875b34.versanet.de ([83.135.91.52] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1t2uaH-0005jR-Bd; Mon, 21 Oct 2024 17:44:41 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Rob Herring <robh@kernel.org>,
	Alexandre ARNOUD <aarnoud@me.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Luis de Arquer <ldearquer@gmail.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: Heiko Stuebner <heiko@sntech.de>,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	kernel@collabora.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	FUKAUMI Naoki <naoki@radxa.com>
Subject: Re: (subset) [PATCH v2 0/5] Enable HDMI0 on several RK3588 based boards
Date: Mon, 21 Oct 2024 17:44:33 +0200
Message-ID: <172952545660.1342338.17758539500442772335.b4-ty@sntech.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241019-rk3588-hdmi0-dt-v2-0-466cd80e8ff9@collabora.com>
References: <20241019-rk3588-hdmi0-dt-v2-0-466cd80e8ff9@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Sat, 19 Oct 2024 13:12:09 +0300, Cristian Ciocaltea wrote:
> Since the initial support for the RK3588 HDMI TX Controller [1] has been
> merged as of next-20241018, let's enable the HDMI0 output port for the
> following boards: Radxa ROCK 5A & 5B, Rockchip RK3588 EVB1 V10, Xunlong
> Orange Pi 5+.
> 
> @Luis: Could you please verify this series still works as expected on
> your Orange Pi device?
> 
> [...]

Applied, thanks!

[1/5] arm64: dts: rockchip: Add HDMI0 node to rk3588
      commit: 872c5aea392dc72ffe74eeab2b25864eadc12d23
[2/5] arm64: dts: rockchip: Enable HDMI0 on rock-5b
      commit: 9dee4ce1c35129d9d1971cb840b6af84bc5cba4c
[3/5] arm64: dts: rockchip: Enable HDMI0 on rk3588-evb1
      commit: c56ce5af882ffeb93d52560ad8c6199362698250
[4/5] arm64: dts: rockchip: Enable HDMI0 on orangepi-5-plus
      commit: 76ba840373b9d064eeeab17798990662f5d5eac5

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

