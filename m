Return-Path: <linux-kernel+bounces-305000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 03E649627EC
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 14:56:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 312001C23F15
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 12:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42A3117CA00;
	Wed, 28 Aug 2024 12:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="q4cO08Wv"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CDC8178CF2;
	Wed, 28 Aug 2024 12:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724849795; cv=none; b=OUFxAb+71ms6lMeEiLrBhT4On4tvBDI5CjrLrraMQgKZV1WAxwOREJYWdQoEqcFvv8ST6jj8WjJi/cbhr2KD4q2rLR8Tzlj23S9nl/F00AE5wm2yXMPEBcrkPVJttGkL6KQ1/Bfc4oBrLvcOcCGtk9mLBuOyQ6GuOJLdtB9i+N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724849795; c=relaxed/simple;
	bh=qBt4zcYbUQYxSL00RFYb5bKzu3Bn6JtYhJlf9sjm6XQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HFWRsFvdyHPhfQmMuzmP0foLqy8LKHNs2c/LQfXy5LzXJVqdCdk8jEoeGUkqNgnoRUb0SXdDYJWSx2Eg4az7fvTw2LKbtr5suMgaVgyFNNoqsXpCxq8lUFO4mzasEh1QFfmd19wJcD0pai0MTGPddxceQeW6/1dHRvqbdDjJNvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=q4cO08Wv; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=3bMNu3lJFboLmoxcd2f5D0OI0rHEumBUEVx3ifZtn4c=; b=q4cO08WvKwTqslAfyp5DyrgBQk
	107GUj52R78ifmj2wVr54IUNCgh0FSUN4wfmjHyn11shzJpHaiXJ68VTzp0NJq6e59tZoqC0Qrmlt
	F8LsFgUW2vp0C/o9SflYzOQYylYf7JBKY8Q0M+zkw4aClYOoXASDiJoZ/rnjgVPsHRNQurzB8fP/n
	kIktOdhjJcSfOJPomC1cWrUiIKg9mUCT+Pnha2q/9cnWPXJcOiJvemwwi+tJ4HfGkjdYDIhL18iii
	Ka36d2jPaDsar+tYIpGIfkEdj0QJBPBixlXgN2KWKsA+2ZbBOiv8fB/VEzEozV/iENARLkZJ2w4wF
	pRmimk8w==;
Received: from i5e8616cd.versanet.de ([94.134.22.205] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sjIDs-0005MB-Dj; Wed, 28 Aug 2024 14:56:28 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Heiko Stuebner <heiko@sntech.de>,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	Rob Herring <robh@kernel.org>,
	Jianfeng Liu <liujianfeng1994@gmail.com>,
	kernel@collabora.com,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	devicetree@vger.kernel.org,
	Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v8 0/2] RK3588 VEPU121/VPU121 support
Date: Wed, 28 Aug 2024 14:56:24 +0200
Message-ID: <172484978176.1499193.8850818524012540505.b4-ty@sntech.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240827181206.147617-1-sebastian.reichel@collabora.com>
References: <20240827181206.147617-1-sebastian.reichel@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 27 Aug 2024 20:10:19 +0200, Sebastian Reichel wrote:
> This enables support for Hantro in the RK3588 base devicetree. Sebastian Fricke
> send the pull request for the driver/binding changes for 6.12 some hours ago:
> 
> https://lore.kernel.org/all/20240827133315.qlmwdvwmghidayzy@basti-XPS-13-9310/
> 
> Changes since PATCHv7:
>  * Dropped patches 1-4 (merged to media tree)
>  * Rebased DT patches to use rk3588-base.dtsi instead of rk3588s.dtsi
>  * Dropped a bunch of people from Cc since the media side is done
> 
> [...]

Applied, thanks!

[1/2] arm64: dts: rockchip: Add VEPU121 to RK3588
      commit: cc0a05865cd5ff2a12479ab85093ed203af10520
[2/2] arm64: dts: rockchip: Add VPU121 support for RK3588
      commit: 6166b1c0084e059af539c93a9d48afe44220dbef

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

