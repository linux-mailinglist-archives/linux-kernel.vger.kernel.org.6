Return-Path: <linux-kernel+bounces-552654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA585A57C5C
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 18:32:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE47E16C80E
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 17:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89A8C1E8358;
	Sat,  8 Mar 2025 17:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="UZ+1WlFQ"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E141BEF74;
	Sat,  8 Mar 2025 17:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741455139; cv=none; b=Y90b952MxeS5+PG4nH/VitQPUSaDlJKZs3pSpVNRKchOcKHqnsu9JmNS8ceQ98NgN2Kjwx/CnLywuCGhevwNKCU0afm5E8TLewsLh/3p8+lkpGm4Rcxl4n8SY3udlrcYUKgb/+MhXgzyjMWkDvNpaIA1byGQ2jOATd4nKXUdT5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741455139; c=relaxed/simple;
	bh=nNiN9K4E46dbIvbUYC+yWk8Bs+6d/3nPhtm+gba7wKY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NlB34MIL77z5PLb9CNT945XL9IB8sbuqLdRm1yOXwENI11yg/63bfNyEGa4dZvmAcL1aG3XKUxYPk28QAJrEGYE8/xEZ3G9OskSeU7/+df1LXr/vRR8NeVAxZzEk75ORSMT3oWwsXZQH14XRWumR4M6nS2ED7t16TqILmYcZeRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=UZ+1WlFQ; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=TwCpWhtmMBakpaMGHdISZitCtlIawEEMo8Rgfzygze4=; b=UZ+1WlFQdQTmet1JzRbdXCrYQN
	/uG5rd3zDP2G5kaa/2F4DNflhGf9mS3D1Fk4OXrix8aRVQ0jxYM5Bnu2OGVXHunv9LCOdKkC+d/I/
	BJh5yHHPKM/f3VMLoizM91VUp4hML53PK/K7gjKVqLn/NAyGWbehIIeafMpIs8u9nyst0/aqQOb8X
	lbJItjL7dxwf9j9Ujp6uWq3V/RjHMy7F+nKheWCWideq7+aHwi6fWBGtaneyPAMnlOHT0IQ3BPILV
	p4QZHpma7kr88HsZSy+4Vkchgyl1Baz/nv4OMu3/7JhBptwI/fyyW0Mz523fgdyBzhefD1zzHl6n6
	2O07e9Iw==;
Received: from [194.95.143.137] (helo=phil.dip.tu-dresden.de)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tqy20-0004Tx-6Z; Sat, 08 Mar 2025 18:32:12 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonas Karlman <jonas@kwiboo.se>
Cc: Heiko Stuebner <heiko@sntech.de>,
	Yao Zi <ziyao@disroot.org>,
	linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/4] rockchip: Add support for leds and buttons on Radxa E20C
Date: Sat,  8 Mar 2025 18:32:05 +0100
Message-ID: <174145503577.101861.8733087252860398696.b4-ty@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250304201642.831218-1-jonas@kwiboo.se>
References: <20250304201642.831218-1-jonas@kwiboo.se>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 04 Mar 2025 20:16:33 +0000, Jonas Karlman wrote:
> The Radxa E20C has three GPIO leds, one SARADC maskrom button and one
> GPIO user button.
> 
> This series add leds, gpio-keys and adc-keys nodes to board DT to
> describe the leds and buttons found on Radxa E20C.
> 
> Changes in v2:
> - Change gpio-leds node name to leds
> - Drop patches already applied
> - Merge saradc and gpio button series
> - Reorder patches
> 
> [...]

Applied, thanks!

[1/4] arm64: dts: rockchip: Add leds node to Radxa E20C
      commit: 6a709e003492e9878d5f1357be0b2e1162e1e6a6
[2/4] arm64: dts: rockchip: Add user button to Radxa E20C
      commit: ad8afc8813567994164f2720189c819da8c22b99
[3/4] arm64: dts: rockchip: Add SARADC node for RK3528
      commit: 6e58302c84ce90aadbecd41efe1f69098a6f91e5
[4/4] arm64: dts: rockchip: Add maskrom button to Radxa E20C
      commit: 3a2819ee9c71d1c6388e456cc4eb042914d15d7e

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

