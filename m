Return-Path: <linux-kernel+bounces-568842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FC17A69B19
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 22:45:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB10019C0AC5
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 21:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79CEE21A446;
	Wed, 19 Mar 2025 21:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="B/TIRtQE"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E37199E80
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 21:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=121.127.44.59
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742420678; cv=none; b=SH5FVbzAvEpBrgbgRAQ1RaeYmPs184lM1IkpFPc+Xj77zbY5Tu6lOgFrma8o1b98uFtZ6Rgz97PW+qLWo8m3v5T8mCPyMsBQE0/2La1j8/ZVY7PuAwe3lrQWiSYWDXOIyORBTG9MkcxmWk3KVBB2uC5XXkr1J53jDA+Fip8hlVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742420678; c=relaxed/simple;
	bh=gGt8j/sTkg9BWUEL2TCqqTwJiomkTiA+VZJTTs7wwEY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JlyviHABXrP99ZZOGgkMzb9o1uT1+nSk7mHoert0LpBa66PiJLGdFT4Cl8SGDPl4aaI1tKzolLb5lLDmWtONp6dLtM5YMlDgxuYVga9hw0ZVmnW5qOgHEsrLzRiOPFRlV4Y3nW46Z2YplfqZ1eszz9/HsDbZSZdBeFTdwQbabHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=B/TIRtQE; arc=none smtp.client-ip=121.127.44.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1742420670;
 bh=hs6Pwio3uOKO/Rs8ESj0aY1nLaXKMEYE6oUslcHF8n0=;
 b=B/TIRtQEQNCvqe9TaGY8khnRZju+wZJ1rgpCfZWOPFjsfyXLBYnZXEr3+pqRatDhk0xYF+Cr5
 6YEqJdQeo0qnXgC4QNY3EQg+w8IEiyZWA+mhJ/hW8iNEol3tYoYJZAQaH5dYwCByL4lRiVRNJnP
 3PA35kopRQOQJIrzuXEf30/TafMkAXZq7ueoVoa2g9ROr/AALFrJmIIiZ6nIRqVIubTuOlS1bxY
 hSafC1pYkSSwJPaLrfDsJTABcP1b7fP0hsevQV+eIuB7S4sVMBoS6Qwk5LdyUDRB4JmSFMqaQvC
 kMThh9R81KTmZnKxD6JjqNETbzpGKxBqFhogJTXU38ZQ==
X-Forward-Email-ID: 67db3ab6cf4d592372b993d9
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.59
X-Forward-Email-Version: 0.4.40
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Heiko Stuebner <heiko@sntech.de>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	David Wu <david.wu@rock-chips.com>,
	Yao Zi <ziyao@disroot.org>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH net-next v3 0/5] net: stmmac: dwmac-rk: Add GMAC support for RK3528
Date: Wed, 19 Mar 2025 21:44:04 +0000
Message-ID: <20250319214415.3086027-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.49.0
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

This series add initial support for the Ethernet controllers found in
RK3528 and initial support to power up/down the integrated PHY.

Changes in v3:
- Rebase on latest net-next/main
- Collect r-b tag on dt-bindings patch
Link to v2: https://lore.kernel.org/r/20250309232622.1498084-1-jonas@kwiboo.se

Changes in v2:
- Restrict the minItems: 4 change to rockchip,rk3528-gmac
- Add initial support to power up/down the integrated PHY in RK3528
- Split device tree changes into a separate series
Link to v1: https://lore.kernel.org/r/20250306221402.1704196-1-jonas@kwiboo.se

David Wu (1):
  net: stmmac: dwmac-rk: Add GMAC support for RK3528

Jonas Karlman (4):
  dt-bindings: net: rockchip-dwmac: Add compatible string for RK3528
  net: stmmac: dwmac-rk: Move integrated_phy_powerup/down functions
  net: stmmac: dwmac-rk: Add integrated_phy_powerdown operation
  net: stmmac: dwmac-rk: Add initial support for RK3528 integrated PHY

 .../bindings/net/rockchip-dwmac.yaml          |  16 +-
 .../net/ethernet/stmicro/stmmac/dwmac-rk.c    | 277 ++++++++++++++----
 2 files changed, 242 insertions(+), 51 deletions(-)

-- 
2.49.0


