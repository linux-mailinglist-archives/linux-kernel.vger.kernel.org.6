Return-Path: <linux-kernel+bounces-553436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 816E0A58995
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 01:13:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C44E188B64B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 00:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 631AE320F;
	Mon, 10 Mar 2025 00:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="B53pD1jc"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3FD81E
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 00:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=121.127.44.59
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741565588; cv=none; b=Mvkdq1ttrWrVviI2IeyUln2JTkCczmnEZ8KcjkdUIxtIrOHrOqbXwUwY/iglTXa+arMxtTiQ/mKROSRqJXA7Yt3w5iUhGm1PciPpqATzMMpWsUhHfJNu5iVcjTJTQFLKLQRB2kqKlDn3bzjnRFUYm56Xv+Q6HBONCgXcZkbj3+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741565588; c=relaxed/simple;
	bh=iGJdYcl/t5QjJX9+gwTgiqfKfbbSeqSFhSlg9Qw2U2g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GRzXQms9hkIbdRpPL525/S0SnIvbPr1ypwRSOXMmZRl9aNUAs4WQ2B0rtLVFEYzc/MOfvmz0ewBVobnOMEV4NyI/zXP+vIeZpdRWbaK82Ng1ndHAJthbnd3wpMc+Z118/xvmDsq7tuTHZZuBwuJn1mhNTSmYAsLQm97XZqM0y/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=B53pD1jc; arc=none smtp.client-ip=121.127.44.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1741565586;
 bh=HkcBOyMrU08By5wz8cHkuMlZXuzZuC30spWDpSCMgq8=;
 b=B53pD1jch6CAxTz1fMg7CbahBoJSxCIjl43fYcIFY6Bt9u/tjPf2nuhUyGH+8785GBDOICVPr
 gyXPIFf4hPW32QBUwnNbWG1JZeu8vin2n5/fO7OGAefhciZRhXTh1ncf+b1DWkD1DbKS7NiNpZ/
 o6Z5mlcXLviFKsJh57TizDTxfrM2sjMjp39B+1OMy0i95ik1R7nPe9oDXO/dizRY8fFk9su//B8
 14xp7RfFCPuyW2dpjGPv2n20izuhGnTrvgLcg0m1yf2JgbSDVSQ3sD+Mh+kM6y8QzSCF2P8F5CF
 Cbgb4ceISf4YlCIybvTI78SaKdPZqMXcHV7xIPVfpU1Q==
X-Forward-Email-ID: 67ce2e8ff812de2512d1f540
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.59
X-Forward-Email-Version: 0.4.40
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Heiko Stuebner <heiko@sntech.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Yao Zi <ziyao@disroot.org>,
	Chukun Pan <amadeus@jmu.edu.cn>,
	linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v2 0/2] rockchip: Enable Ethernet controller on Radxa E20C
Date: Mon, 10 Mar 2025 00:12:49 +0000
Message-ID: <20250310001254.1516138-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Rockchip RK3528 has two Ethernet controllers, one 100/10 MAC to be
used with the integrated PHY and a second 1000/100/10 MAC to be used
with an external Ethernet PHY.

This series add device tree nodes for the Ethernet controllers found in
RK3528 and enable the LAN interface on Radxa E20C.

This include a gmac0 node for the 100/10 MAC and its related integrated
PHY node that only have recived limited testing. I have no board that
expose an Ethernet port for the gmac0 and the integrated PHY. However,
the PHY can be identified on addr 0x2 as 0044.1400 and in vendor kernel
this relate to the Rockchip RK630 PHY. A proper PHY driver will be
needed to support any real use of gmac0.

Changes in v2:
- Split from the "Add GMAC support for RK3528" driver series [1]
- Add ethernet-phy@2 for the integrated PHY
- Rebase on top of the "Support I2C controllers in RK3528" series [2]

This series depend on the "net: stmmac: dwmac-rk: Add GMAC support for
RK3528" [1] series and the "Support I2C controllers in RK3528" [2]
series for a clean apply.

[1] https://lore.kernel.org/r/20250309232622.1498084-1-jonas@kwiboo.se
[2] https://lore.kernel.org/r/20250309070603.35254-1-ziyao@disroot.org

Jonas Karlman (2):
  arm64: dts: rockchip: Add GMAC nodes for RK3528
  arm64: dts: rockchip: Enable Ethernet controller on Radxa E20C

 .../boot/dts/rockchip/rk3528-radxa-e20c.dts   |  30 +++++
 arch/arm64/boot/dts/rockchip/rk3528.dtsi      | 105 ++++++++++++++++++
 2 files changed, 135 insertions(+)

-- 
2.48.1


