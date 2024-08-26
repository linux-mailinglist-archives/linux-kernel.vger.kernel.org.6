Return-Path: <linux-kernel+bounces-300738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E3AF95E7BE
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 06:50:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C55D31F215E4
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 04:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5D48762DF;
	Mon, 26 Aug 2024 04:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=classfun.cn header.i=@classfun.cn header.b="cU7tB+ql"
Received: from classfun.cn (unknown [129.204.178.38])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B7E526289;
	Mon, 26 Aug 2024 04:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.204.178.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724647788; cv=none; b=q4SdnK7vD+WP+A8LEUsbGC9SsQ5ZpTS3jvSQR3smriZPjAHiX0mL7h7FUPnrrIxq2bE4uhucp5GGU0AETQCUnFizvPi/y6YC4O4CmAuCLcc30dYLvDNH86hf0mjYGnrG+ONTLdyAQjpBh4JPwQQQ7UjeuO1k7G7cms4QPYtgJ0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724647788; c=relaxed/simple;
	bh=zf9prF7SZSFt2kj6kv6mOgVOdbzWOYYt86sposFANMw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ehm8N6C/y7X2yxyivtrbhocNoOyxT4dJHYFBT7J095NSwYX7A1+npKNz4EAf7L3+fcDzS9JjtimFqsxe/hyapeSHy60g2BfIIe2tsYMv37bpZZtg8kbSlljFF58vKBIx4y9YIefaxaX3Qnf028NCxuzZlKdmj3xAiT0+FMbcmZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=classfun.cn; spf=pass smtp.mailfrom=classfun.cn; dkim=pass (1024-bit key) header.d=classfun.cn header.i=@classfun.cn header.b=cU7tB+ql; arc=none smtp.client-ip=129.204.178.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=classfun.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=classfun.cn
Received: from bigfoot-server-arm-node1.classfun.cn (unknown [124.72.161.4])
	(Authenticated sender: bigfoot)
	by classfun.cn (Postfix) with ESMTPSA id F0B8C78906;
	Mon, 26 Aug 2024 12:45:57 +0800 (CST)
DKIM-Filter: OpenDKIM Filter v2.11.0 classfun.cn F0B8C78906
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=classfun.cn;
	s=default; t=1724647559;
	bh=NSHErsM8htHNOeXSrXTfEZqSzTZxwoCyojkZOF0TEmQ=;
	h=From:To:Cc:Subject:Date:From;
	b=cU7tB+ql1bVLvh1HSL0UULk7sCTs5R7klAX3hngYIIfY2nR2PqcwDDftd6RSUjVak
	 AcMc/rQ9J7ceXC/7Wjav/4GZwme0rjL7CSDJfg27496Y0nfB8Qt7dS0joN8JtH7o6j
	 7DOZwcyAhyRlU24zimTc9jMQell6Q5b67on9Qdfg=
From: Junhao Xie <bigfoot@classfun.cn>
To: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Jonas Karlman <jonas@kwiboo.se>,
	Chukun Pan <amadeus@jmu.edu.cn>,
	Junhao Xie <bigfoot@classfun.cn>,
	FUKAUMI Naoki <naoki@radxa.com>,
	Dragan Simic <dsimic@manjaro.org>,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] Add support for LCKFB Taishan Pi RK3566
Date: Mon, 26 Aug 2024 12:44:10 +0800
Message-ID: <20240826044530.726458-1-bigfoot@classfun.cn>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

LCKFB Taishan Pi is a SBC based on the RK3566 SoC.

This series bring support for:
* UART
* RGB LED
* AP6212 WiFi
* AP6212 Bluetooth
* SD Card
* eMMC
* HDMI
* Mali GPU
* USB Type-C
* USB Type-A

Signed-off-by: Junhao Xie <bigfoot@classfun.cn>
---
Junhao Xie (3):
  dt-bindings: vendor-prefixes: Add Shenzhen JLC Technology Group LCKFB
  dt-bindings: arm: rockchip: Add LCKFB Taishan Pi RK3566
  arm64: dts: rockchip: add dts for LCKFB Taishan Pi RK3566

 .../devicetree/bindings/arm/rockchip.yaml     |   5 +
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 arch/arm64/boot/dts/rockchip/Makefile         |   1 +
 .../boot/dts/rockchip/rk3566-lckfb-tspi.dts   | 743 ++++++++++++++++++
 4 files changed, 751 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3566-lckfb-tspi.dts

-- 
2.45.2


