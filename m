Return-Path: <linux-kernel+bounces-185453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C70FF8CB521
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 23:11:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6456E1F221FC
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 21:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2500B149E14;
	Tue, 21 May 2024 21:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="E4Fk6iaZ"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11792149C54
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 21:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.215.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716325858; cv=none; b=O2gzrQ0ld6XXPLqXo+rLuB8to/wonELb18loZM9L2eUrXiKmDy0BZni/3ZK7XuI8YEWVY7oD8Q1F4mOwhoZJCuSOBfZ0X1pjFzTFfUjqG3oNQi6jS4Fo0khEhMhHj5RNwGKlon1nzuD1wcFfNHAZc6M23YjnK4+vW7VBKvwr9dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716325858; c=relaxed/simple;
	bh=5JQ3ipziOYr10ODqPHwmiEtThvSBSsrrPYVlIByz2mY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jheCbOJOVrsAXqNkwJEziSqvZxwg/QRBbhP+KRKOyTEdRM35tzljUiarcygctC0X4ZpAeHfFzLSLsb7mwuO77UP4w3MCwTyo71D5FRUmgF3YNfuwrIyGh1JqYx742FlvJOlNZOq57JwYSaQH1IMnO3NGnUOtXFYXEeFoA1JvI20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=E4Fk6iaZ; arc=none smtp.client-ip=149.28.215.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1716325851; bh=aD5ElAXuf7/SqhPMov55JPF9VkiI9/bGsfbICmFQCbQ=;
 b=E4Fk6iaZ2ObfYyVGavisOGDYxRJSx5X+OIItJ+Nk17X+9Y0TkOkM0SENkr3+OTzqTeJ5pUnCz
 kCy8QB8AUmet32Ef0TZ8W3g5dyHjuOmM7D6dcGXnA3LMM/To4aGC4iK4Id5jVB3F2DN3OwcrsO1
 HHYesovdcCBo7FD2/6RJINlXa4ClCchvMpSTZ+TwwNuRu7tfGq9sRMcgxtDY2IEf30sn+LW/wyH
 c6uwNThw9LmyZP1Oq+VInf9wkYh0BmEvzHorLmu6MwvTePsLCIMdiztINSSY8XqlEdDLGNdBaDn
 bGbvIjBy696G22UL7sy/pIvMiwNDglPjjQ9UhZye/+gg==
From: Jonas Karlman <jonas@kwiboo.se>
To: Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Sjoerd Simons <sjoerd@collabora.com>, Akash Gajjar
 <akash@openedev.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, Jonas
 Karlman <jonas@kwiboo.se>
Subject: [PATCH 03/13] arm64: dts: rockchip: rk3308-rock-pi-s: Fix SD NAND and eMMC init
Date: Tue, 21 May 2024 21:10:06 +0000
Message-ID: <20240521211029.1236094-4-jonas@kwiboo.se>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240521211029.1236094-1-jonas@kwiboo.se>
References: <20240521211029.1236094-1-jonas@kwiboo.se>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 664d0dd88b6b0c828344aeca

Radxa ROCK Pi S have optional onboard SD NAND on board revision v1.1,
v1.2 and v1.3, revision v1.5 changed to use optional onboard eMMC.

The optional SD NAND typically fails to initialize:

  mmc_host mmc0: Bus speed (slot 0) = 400000Hz (slot req 400000Hz, actual 400000HZ div = 0)
  mmc0: error -110 whilst initialising SD card
  mmc_host mmc0: Bus speed (slot 0) = 300000Hz (slot req 300000Hz, actual 300000HZ div = 0)
  mmc0: error -110 whilst initialising SD card
  mmc_host mmc0: Bus speed (slot 0) = 200000Hz (slot req 200000Hz, actual 200000HZ div = 0)
  mmc0: error -110 whilst initialising SD card
  mmc_host mmc0: Bus speed (slot 0) = 100000Hz (slot req 100000Hz, actual 100000HZ div = 0)
  mmc0: error -110 whilst initialising SD card

Add pinctrl and cap-sd-highspeed to fix SD NAND initialization. Also
drop bus-width and mmc-hs200-1_8v to fix eMMC initialization on the new
v1.5 board revision, only 3v3 signal voltage is used.

Fixes: 2e04c25b1320 ("arm64: dts: rockchip: add ROCK Pi S DTS support")
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
Hardware revision changes can be found at:
- https://wiki.radxa.com/RockpiS/hardware/revisions
- https://docs.radxa.com/en/rockpi/rockpis/hardware/hardware-revision
---
 arch/arm64/boot/dts/rockchip/rk3308-rock-pi-s.dts | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3308-rock-pi-s.dts b/arch/arm64/boot/dts/rockchip/rk3308-rock-pi-s.dts
index b47fe02c33fb..84f4b4a44644 100644
--- a/arch/arm64/boot/dts/rockchip/rk3308-rock-pi-s.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3308-rock-pi-s.dts
@@ -126,10 +126,12 @@ &cpu0 {
 };
 
 &emmc {
-	bus-width = <4>;
 	cap-mmc-highspeed;
-	mmc-hs200-1_8v;
+	cap-sd-highspeed;
+	no-sdio;
 	non-removable;
+	pinctrl-names = "default";
+	pinctrl-0 = <&emmc_bus8 &emmc_clk &emmc_cmd>;
 	vmmc-supply = <&vcc_io>;
 	status = "okay";
 };
-- 
2.43.2


