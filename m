Return-Path: <linux-kernel+bounces-372757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D7119A4CC4
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 12:12:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 312D2283C55
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 10:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5FD41DF96B;
	Sat, 19 Oct 2024 10:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="agwCIdAp"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E21218755C;
	Sat, 19 Oct 2024 10:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729332766; cv=none; b=XkBKxC1t+lwOZq+21Euq4+Au8WhddjHAoXlZM4IiVbIwPtwRbRvfWIr7W5eWJUSrTDK+yQ3A9Ee1oFmXOGXwMOJG3mJ74jjzkEGc32cevBNJSs3AR4qO5qsoqCEaw+RAL8iZ7s5+8zL+m2dYwPVvMRgTAOOf9p7qV5dORFrQyYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729332766; c=relaxed/simple;
	bh=WX/NBZEjkntFun/D0pGIVbOd18uKP04lnSuDqn9OWBo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=cFbjq18MOM+83Y0QkJKEsJgBFI9OAZpl5e2B69kEMPMRQ3JBcsSoOG2EaLMxF3cYS83vGj705BhrEQgGm7XCszdGrYeahWtDbb5XZXwwyTmjaAkc38gwADrhCF99zXtxfjHRkof3lmwDbwv3NurVofwk2qHZJhcGYx5I8ohW+tQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=agwCIdAp; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1729332762;
	bh=WX/NBZEjkntFun/D0pGIVbOd18uKP04lnSuDqn9OWBo=;
	h=From:Subject:Date:To:Cc:From;
	b=agwCIdApCuVlTvjEXHtj1nG5GT2GHfu26JRn9CN2NKEWYk5/oyrCR4+T6RllP7jBf
	 pYij70OW4JKVPkrXUd4GpZHyXewcJahsdUHLXM0tzkO/EmgoKh9/BYru5OtHUHNyLW
	 N37J2bOmpow6nkjlRddl0PEqGaVzZR9I4JztwZAMS/BMcEzZmOOa9zWpbW3u7kL1aG
	 7mQCLY0CeBB6LwDeUL0/xz06j0R4X7MJmnlt8wBid1AVIEruerRgzJFG9dabdCScPW
	 REwnta+SfYXN25v7w8a3oYzuCWAepZIDxgPeJUi2H3DNZXVaXGPZXq9Jbduz7FOhk4
	 rblRQdO4SOy+Q==
Received: from localhost (unknown [188.24.146.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 1139D17E1395;
	Sat, 19 Oct 2024 12:12:42 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Subject: [PATCH v2 0/5] Enable HDMI0 on several RK3588 based boards
Date: Sat, 19 Oct 2024 13:12:09 +0300
Message-Id: <20241019-rk3588-hdmi0-dt-v2-0-466cd80e8ff9@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPmFE2cC/2WNyw6CMBBFf4XM2jFtEW1Z+R+GRenDTgRqWkI0h
 H+3krhyeU5yz10hu0QuQ1utkNxCmeJUQBwqMEFPd4dkC4Ng4sQZl5gedSMlBjsSQzsj17xuLGO
 Xs/ZQVs/kPL324q0rHCjPMb33g4V/7a+l/loLR4a9lV4o5Z029mriMOg+Jn00cYRu27YP+nQz3
 7IAAAA=
X-Change-ID: 20241018-rk3588-hdmi0-dt-1a135d0076af
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 Luis de Arquer <ldearquer@gmail.com>, Alexandre ARNOUD <aarnoud@me.com>
Cc: kernel@collabora.com, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, FUKAUMI Naoki <naoki@radxa.com>
X-Mailer: b4 0.14.2

Since the initial support for the RK3588 HDMI TX Controller [1] has been
merged as of next-20241018, let's enable the HDMI0 output port for the
following boards: Radxa ROCK 5A & 5B, Rockchip RK3588 EVB1 V10, Xunlong
Orange Pi 5+.

@Luis: Could you please verify this series still works as expected on
your Orange Pi device?

Thanks,
Cristian

[1]: https://lore.kernel.org/all/20241016-b4-rk3588-bridge-upstream-v10-0-87ef92a6d14e@collabora.com/

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
Changes in v2:
- Updated descriptions for rock-5a & rock-5b patches to include Radxa,
  per Naoki's review; also collected his Tested-by on the latter
- Included Naoki's HPD pin related fix in rock-5a patch and dropped the
  UNTESTED prefix from the subject
- Link to v1: https://lore.kernel.org/r/20241019-rk3588-hdmi0-dt-v1-0-bd8f299feacd@collabora.com

---
Cristian Ciocaltea (5):
      arm64: dts: rockchip: Add HDMI0 node to rk3588
      arm64: dts: rockchip: Enable HDMI0 on rock-5b
      arm64: dts: rockchip: Enable HDMI0 on rk3588-evb1
      arm64: dts: rockchip: Enable HDMI0 on orangepi-5-plus
      arm64: dts: rockchip: Enable HDMI0 on rock-5a

 arch/arm64/boot/dts/rockchip/rk3588-base.dtsi      | 41 +++++++++++++++++
 arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dts   | 47 +++++++++++++++++++
 .../boot/dts/rockchip/rk3588-orangepi-5-plus.dts   | 47 +++++++++++++++++++
 arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts    | 47 +++++++++++++++++++
 arch/arm64/boot/dts/rockchip/rk3588s-rock-5a.dts   | 52 ++++++++++++++++++++++
 5 files changed, 234 insertions(+)
---
base-commit: f2493655d2d3d5c6958ed996b043c821c23ae8d3
change-id: 20241018-rk3588-hdmi0-dt-1a135d0076af


