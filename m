Return-Path: <linux-kernel+bounces-527513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99B6CA40C30
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 00:48:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84BCA1753C7
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 23:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FFF2204F86;
	Sat, 22 Feb 2025 23:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="Vh4T+Bhr"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E42201266;
	Sat, 22 Feb 2025 23:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740268111; cv=none; b=CeTmtmWakkeg6ihHfrL7wi1roJgdrvR/sfZCKAip9egGtwL5c14k4YcVxj1od/aT6fm4PyXd9Kvrq5Szw4LAcI/QfX3g1t3uO3Vu+dI+ANm4ZiodacJbgLZdoyYVNfp6/6VW8XaLowxmccrlq8mfkGcICRfT0y/GuTAKTldSCZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740268111; c=relaxed/simple;
	bh=LUKtB6AcM9hdi0sIS2JyyDe267R4Zu3VemlFGAtPLdo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qw1U/fQAj76ceGigHNS36lJkRk6BVrbbkbLb7RSFzAqVLnk/YBsR8VPZmPrtnf4H5w7VwkDZcFI1qFD0H1B7aMyiYiAqcGSezEIqfadr/CyOpsqqDPtq8VDHDEUaDdFHHodLQfcdNS8jJSQUVdlVYHIGsBZMi5THVi+e1ddr7XU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=Vh4T+Bhr; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=2W8RdEs8ElUG61A2Vr7LdSd4N8lCsVrQU9K5HgnJu08=; b=Vh4T+BhrZcM4wUvwISldHAJcPj
	Yijqv51k5NaV1lcWAhkq9lzmwj9IBdqapcmP/KC1B6N3wA/WThYIb8k/wBzO78Ww/c1J+makNzbsm
	rQa0mcVRl4g2HtBSpgP6MIDA00JKq4QD7Yb3NkG/Lg7IPN8JZ23LrwZMXSrBdB3jthno1DFmdZlsf
	RZDzRbnDfsNC4Sptm4HiyNhUsIGeGQMy/kx1ssBnJZiHqhBdFU7QH0snbVJH45jCyIs7u4QFy+VNs
	fT4HjJKb+ibmN0G/0UYnbjHf7c4NuCNI6bpwl6L4F9f4lO1XICs8UlP4jeywg2lZxB0GoMnHb2x4S
	mvgd379w==;
Received: from i53875a10.versanet.de ([83.135.90.16] helo=phil.fritz.box)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tlzEO-0004TL-8G; Sun, 23 Feb 2025 00:48:24 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Quentin Schulz <foss+kernel@0leil.net>
Cc: Heiko Stuebner <heiko@sntech.de>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Quentin Schulz <quentin.schulz@cherry.de>
Subject: Re: [PATCH 0/9] arm64: dts: rockchip: align and reorganize Theobroma DTS(I)
Date: Sun, 23 Feb 2025 00:48:17 +0100
Message-ID: <174026756681.3008209.14237088050946268747.b4-ty@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250218-tsd-align-haikou-v1-0-5c44d1dd8658@cherry.de>
References: <20250218-tsd-align-haikou-v1-0-5c44d1dd8658@cherry.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 18 Feb 2025 12:49:11 +0100, Quentin Schulz wrote:
> We have three SoMs that can use Haikou as their carrierboard so it'd be
> nice to have consistency across SoMs on what's enabled by default. To
> that end, Tiger Haikou now has UART5 enabled and Puma Haikou now has the
> EEPROM found on Haikou specified.
> 
> Additionally, some devices were configured or enabled in the wrong
> places (either SoM DTSI when they needed to be configured in
> carrierboard DTS or vice-versa). This moves things around to better
> match actual HW definition and make it easier to reuse the SoM DTSI
> without having to undo carrierboard-specific changes. While at it,
> disable devices/buses exposed on connectors which do not have overlays.
> They need to be enabled in the appropriate overlays whenever they will
> be added.
> 
> [...]

Applied, thanks!

[1/9] arm64: dts: rockchip: enable UART5 on RK3588 Tiger Haikou
[2/9] arm64: dts: rockchip: move DDC bus from Haikou carrierboard to RK3399 Puma DTSI
[3/9] arm64: dts: rockchip: move I2C6 from Haikou carrierboard to Puma DTSI
[4/9] arm64: dts: rockchip: disable I2C6 on Puma DTSI
[5/9] arm64: dts: rockchip: enable I2S0 in Haikou carrierboard, not Puma DTSI
[6/9] arm64: dts: rockchip: add EEPROM found on RK3399 Puma Haikou
[7/9] arm64: dts: rockchip: enable Ethernet in Haikou carrierboard, not Puma DTSI
[8/9] arm64: dts: rockchip: enable I2C3 in Haikou carrierboard, not Ringneck DTSI
[9/9] arm64: dts: rockchip: disable I2C2 bus by default on RK3588 Tiger

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

