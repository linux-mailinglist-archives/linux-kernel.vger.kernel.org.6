Return-Path: <linux-kernel+bounces-305250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0280962BD9
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 17:16:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F844B25138
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 15:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFBCF1A76C4;
	Wed, 28 Aug 2024 15:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="aEWdhDDY"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A59651A706B;
	Wed, 28 Aug 2024 15:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724858066; cv=none; b=LF4i4n7gapQn0fvvbLeNoFtoLg8xPGgTQ3cVDbNilotqBBlI3AMtD+2QSS1iXsl92hqe7QZrrL3B7Br5FByP7oNO15KdkTdS6V8Rf860dlYq5iewYVTdB6FqnHix/wP5RCuTmpA5wWndZf/7Pk5TiGIaTHM45qun7HnSgkrqQiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724858066; c=relaxed/simple;
	bh=Ew3Wx2eYp9qvM7g5zipR8+GupOj0F+MUmh75MbtPaJs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o86qZVxRZSzSLrI48F4C64JFMn0bz8GXbj/AnCzhuaHq0RqVOWTGSMCq/XZp6hDQkdyr4MIy+xkd5yR8SZTtrEAgxM2J/fmkXD/tdchoePLPZdwLQSMhATqyI/xWpFj0TOnwt7N+clEEYvM+wFqLFhCZyJf6JHAFFcjAAtSURJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=aEWdhDDY; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=LevMEsCzUj4G8ENrhUfHsg8ts9orTIQ9E7AP5yZ+FK8=; b=aEWdhDDYw5+twZWDzXVsUja0ha
	NoQdtwH5CDlssSpTFXB+SaXQzO3iSLy6LHX/06slAv7INfcUsSJ8R8tMcoEPV16o9QU1JJJY7S5Mo
	f4NWFUaehr30EaJOCkhfVjkCK2qIf2m5WhdNDhlpERjKmK2ofvkCdVLXfQ07fwrzu0l221+cYNgA6
	u0T0ITOSF4WotwDeCeXpuPc0gNMYWXROXE6LdmcVSj/tc/KgRxU2uQs2r933DFpP9oms7YKWFYlQr
	NgUhw5wBcKRUfV3dlkeHLe4uezYNiwOkGnLMvl/T20/nC9njX2S1lD0Qgt0zOMXaqlXCOJPqJ3iRH
	XkX6pDpQ==;
Received: from i5e8616cd.versanet.de ([94.134.22.205] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sjKNG-00065f-TW; Wed, 28 Aug 2024 17:14:18 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Jonas Karlman <jonas@kwiboo.se>
Cc: Heiko Stuebner <heiko@sntech.de>,
	Aurelien Jarno <aurelien@aurel32.net>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v2 0/4] arm64: dts: rockchip: Add Hardkernel ODROID-M1S
Date: Wed, 28 Aug 2024 17:14:12 +0200
Message-ID: <172485421375.1511809.9810674722852460291.b4-ty@sntech.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240827211825.1419820-1-jonas@kwiboo.se>
References: <20240827211825.1419820-1-jonas@kwiboo.se>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 27 Aug 2024 21:18:14 +0000, Jonas Karlman wrote:
> This series fixes wrong vendor prefix on the Hardkernel ODROID-M1 board
> and adds initial support for the Hardkernel ODROID-M1S board.
> 
> The Hardkernel ODROID-M1S is a single-board computer based on Rockchip
> RK3566 SoC. It features e.g. 4/8 GB LPDDR4 RAM, 64 GB eMMC, SD-card,
> GbE LAN, HDMI 2.0, M.2 NVMe and USB 2.0/3.0.
> 
> [...]

Applied, thanks!

[1/4] dt-bindings: arm: rockchip: Correct vendor for Hardkernel ODROID-M1
      commit: fa63d087bbf67ca907a8ee6ab54f9932cd02f919
[2/4] arm64: dts: rockchip: Correct vendor prefix for Hardkernel ODROID-M1
      commit: 735065e774dcfc62e38df01a535862138b6c92ed
[3/4] dt-bindings: arm: rockchip: Add Hardkernel ODROID-M1S
      commit: 611a434a7d3387fc0eee50cfcc318cc237c1d489
[4/4] arm64: dts: rockchip: Add Hardkernel ODROID-M1S
      commit: 10dc64fe0f980c47c7e747885ddf7a8c12780337

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

