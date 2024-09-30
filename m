Return-Path: <linux-kernel+bounces-343818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1925F989FE6
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 12:56:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C929D281550
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 10:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00C5D18E353;
	Mon, 30 Sep 2024 10:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="NxdGBla8"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E30018E05D;
	Mon, 30 Sep 2024 10:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727693762; cv=none; b=k1WwkBKJMTc5X6Q0S5ENTKQfAo8igtnfrcHCfv2OacbU1+bgmcNlqVvN1R6PlutWk5S4J392sX3IsiTxoE5/pEzTOqXY9pxMeKiUP7g3cICS4GmeCBPx1xwzK4mfH2v3aoDllXBfFDD9uOv3CNmEA8ZS9RHY1yt0fn540TuGJtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727693762; c=relaxed/simple;
	bh=u5Ykq9x9Mw8GGmgm1BlyONs6IiKYykgeSBidBJgTKxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BQFe96M5YipIV+Jaet79NTAktaeS0kIQzMyLudyhOj03atM1FT3H88du8C6qvg9Va7q7lBxAWyUuX4soFCjrKXJluWqiTDm7ah8MTJem+W6GJ7Cu8svJAJd6bYtaxA0aO93YLc1orVGFyUvC9FlRekTbyxDevZ2dqNVxUXyucGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=NxdGBla8; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=8xxzUhl6uSfkyw0tmHbtRGqCicUBU09EcQogAhvlRfk=; b=NxdGBla8ip1Oh2Af/hkPZ4zvzl
	1l5gjwWK37/fewamnPXKeQfgR2oc7EGhEAUrMOk5NChIs5GxBHRSrzF4AlQoDIuWAiJdpyHhZxVH5
	kBYCToJ+u1M7ZBtM9zHNE0bSZqkFDrJSsHhdemmcXbNL2TUd9zXW8hI/5NKhAGj4miXTN9T1cD1M9
	nrYBjeSoKUZ/g+l4dCsoY1DheNpB+i25XQcsT3jzEkJ8rot6S6NIzybMRlhhiCxHw9sdLvKfK/C3j
	4Dmqh4W3S5XQL9RWXPXXJer9eQ7biqNVOuSQr0NG/otaRSb7BVyBuaG5Js3QHWjZcdh4fblfoxQmz
	nHYKtgmg==;
Received: from i5e861925.versanet.de ([94.134.25.37] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1svE4F-0004Xd-Lq; Mon, 30 Sep 2024 12:55:51 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Florian Klink <flokli@flokli.de>
Cc: Heiko Stuebner <heiko@sntech.de>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	Kever Yang <kever.yang@rock-chips.com>,
	linux-kernel@vger.kernel.org,
	Ondrej Jirman <megi@xff.cz>,
	Dragan Simic <dsimic@manjaro.org>,
	linux-rockchip@lists.infradead.org,
	FUKAUMI Naoki <naoki@radxa.com>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	devicetree@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v2] arm64: dts: rockchip: enable automatic fan control on Orange Pi 5+
Date: Mon, 30 Sep 2024 12:55:38 +0200
Message-ID: <172769365131.1880381.17228188074772344432.b4-ty@sntech.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240922145538.256235-2-flokli@flokli.de>
References: <20240922145538.256235-2-flokli@flokli.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Sun, 22 Sep 2024 17:55:29 +0300, Florian Klink wrote:
> This links the PWM fan on Orange Pi 5+ as an active cooling device
> managed automatically by the thermal subsystem, with a target SoC
> temperature of 65C and a minimum-spin interval from 55C to 65C to
> ensure airflow when the system gets warm.
> 
> This is pretty much the same as '4a152231b050 ("arm64: dts: rockchip:
> enable automatic fan control on Rock 5B")', except for the Orange Pi
> 5+ board.
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: rockchip: enable automatic fan control on Orange Pi 5+
      commit: a804c849ef89462ae6f7446d2ec9b919a3fb509d

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

