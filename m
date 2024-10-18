Return-Path: <linux-kernel+bounces-372476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B833D9A4906
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 23:40:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C11231C2430C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 21:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C842F18FC90;
	Fri, 18 Oct 2024 21:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="hs9w+OYG"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0094218C332;
	Fri, 18 Oct 2024 21:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729287624; cv=none; b=m2r6hbdeigFvND2PrB8v1CSM5bwDNIKNoq5SrWLAzDd0TRH048ubwpzfUoQv/U0Pwk0wb+JFnBrdXImRB/7a6Hlo148+Rzx9r13wCvov/ov/e/65r0ViTwoCdW6qxt0S2cQ2dY9uaCASsVeq1is+yfE8F5X1bO0neteXG9rA4+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729287624; c=relaxed/simple;
	bh=jzMY5ROrS69sk17xI0Wa3em7WxCWgNTftdL4b/p4/Po=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=KX0QXSY27kojxHj1oUiZiyuam+W3FDZ2rKGh0Te4Iu+tNMvcYKtewyLeiB7S7eUGsdDghiWew/isAeY/Z93/zrkmvN71W2QjsQIDOmHjh6CXniXcm5Bn8p2WyjlDoMchLZIkdFIi+tuqQzSTMC63UVfbhuiSfGg5chcuL52Khwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=hs9w+OYG; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1729287619;
	bh=jzMY5ROrS69sk17xI0Wa3em7WxCWgNTftdL4b/p4/Po=;
	h=From:Subject:Date:To:Cc:From;
	b=hs9w+OYGnrPcqkRLJ/Gth7If4b1/T4/Q5rkkSGFfHn5l3TDjsaZhpmXK6t8U+2NOY
	 990gMBfW12IfEUT8F52QEUeU9KsJ3KFGrXl0cnZDaftNCijfq78soiYhnJN9iDGe05
	 deA6EDexQxqjaFOIxCsJyUhGd3vhrLK7pI0CvI6H0yLAhlTFwqgoJHQwkua7Ze5fxg
	 38w2cYv7qhSLb1XFnVdHsjVhpbtttGvEQ96KwxOv1OWKtbEDqXYYd6noqdQB/t/rva
	 QpP+tzRe3m0BFuVvjl3CkW//tKO/UPf0EjisxVcOfYulW5LwQZ72XozbfML5s+trMl
	 P0y67ucPp8Sfw==
Received: from localhost (unknown [188.24.146.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id B935C17E3759;
	Fri, 18 Oct 2024 23:40:19 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Subject: [PATCH 0/5] Enable HDMI0 on several RK3588 based boards
Date: Sat, 19 Oct 2024 00:39:48 +0300
Message-Id: <20241019-rk3588-hdmi0-dt-v1-0-bd8f299feacd@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKTVEmcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxNDA0ML3aJsY1MLC92MlNxMA92UEl3DRENj0xQDA3OzxDQloK6CotS0zAq
 widGxtbUAeCa8V2EAAAA=
X-Change-ID: 20241018-rk3588-hdmi0-dt-1a135d0076af
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 Luis de Arquer <ldearquer@gmail.com>, Alexandre ARNOUD <aarnoud@me.com>
Cc: kernel@collabora.com, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2

Since the initial support for the RK3588 HDMI TX Controller [1] has been
merged as of next-20241018, let's enable the HDMI0 output port for the
following boards: Radxa ROCK 5A & 5B, Rockchip RK3588 EVB1 V10, Xunlong
Orange Pi 5+.

@Luis: Could you please verify this series still works as expected on
your Orange Pi device?

The ROCK 5A related patch is currently untested, but we might be able to
validate it beginning of next week.

Thanks,
Cristian

[1]: https://lore.kernel.org/all/20241016-b4-rk3588-bridge-upstream-v10-0-87ef92a6d14e@collabora.com/

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
Cristian Ciocaltea (5):
      arm64: dts: rockchip: Add HDMI0 node to rk3588
      arm64: dts: rockchip: Enable HDMI0 on rock-5b
      arm64: dts: rockchip: Enable HDMI0 on rk3588-evb1
      arm64: dts: rockchip: Enable HDMI0 on orangepi-5-plus
      [UNTESTED] arm64: dts: rockchip: Enable HDMI0 on rock-5a

 arch/arm64/boot/dts/rockchip/rk3588-base.dtsi      | 41 +++++++++++++++++++
 arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dts   | 47 ++++++++++++++++++++++
 .../boot/dts/rockchip/rk3588-orangepi-5-plus.dts   | 47 ++++++++++++++++++++++
 arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts    | 47 ++++++++++++++++++++++
 arch/arm64/boot/dts/rockchip/rk3588s-rock-5a.dts   | 47 ++++++++++++++++++++++
 5 files changed, 229 insertions(+)
---
base-commit: f2493655d2d3d5c6958ed996b043c821c23ae8d3
change-id: 20241018-rk3588-hdmi0-dt-1a135d0076af


