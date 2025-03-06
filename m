Return-Path: <linux-kernel+bounces-549818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92D4EA5578F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 21:39:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE2E7189302C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 20:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC84327703F;
	Thu,  6 Mar 2025 20:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="m8JIKYP4"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61D825D8FA
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 20:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.215.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741293555; cv=none; b=tvAkeVVnyK1myrlShWV99YurvHHeq0dIpkXAkr8aVIbpgy56DRge+3thzpoutnrTfmGXo2hLy0hr4ShU49R7ubtcQ2p3h6lHeCZZpL4ZrRHeHaEnux1UFTYmXrxDvlEJbHoLIXT8hf8mce3Z2tK0Ksc9nBFMgBqg7mVtCNpOFmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741293555; c=relaxed/simple;
	bh=kXlwnVm/MmDRRUROUu6959pIgE0xYihWzk7uz8o+OKM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cZ4S9RIxuKiSTIzbc13HOMh78Wi5rSWMd1zXEhpvIixVq09WrES1sHmh1Jhq7QLMbpzizYS6SlaSgYft2ocr34PJHcX+dWkXDyoWoZGKr+4dflsSnCy7aEdmwd0K6h3i+U0KvPTYngVy+JDL/S5ZoeT5aKpXbqq78MNYrneSPvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=m8JIKYP4; arc=none smtp.client-ip=149.28.215.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1741293553;
 bh=+Q3pBznN8M0b0cdvrfOAVu+/YpKDnQ8zfRnmStTM8EY=;
 b=m8JIKYP4EZ3aEFTTlfg3ww3VDujeTlzjvbkClBiIep8uZp7l8X6fRJo9dGMIfNKFQPm8iaSpj
 5hqCky1XCN3ZD19pr5GlMBXk62DRuwSBMAd+eVnRtGoCuP2MmoLo+d1O+sm5Ekc0ylbzRnFCp+P
 sOWqg04IxJ779Rr+e36Ihzo1aBSbI4yd5U+PW+dggJHE2zVQ70CnqAGsILKFnn7HNrpSoHn8Rtu
 3v89G2EtM5kx57Tl4jZfKi+CXXacFAGE3fv//hI/bnvZBTexJSfKQbSiftr4BNohqLVRKsUcecC
 KBgnzIL9AaaYRkUuCFMbDaOAwqCwzX7GuDdOFQm7EISA==
X-Forward-Email-ID: 67ca07e7deafcb1458af9232
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
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
Cc: netdev@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 0/3] Use DELAY_ENABLE macro for RK3328, RK3566/RK3568 and RK3588
Date: Thu,  6 Mar 2025 20:38:51 +0000
Message-ID: <20250306203858.1677595-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Almost all Rockchip GMAC variants use the DELAY_ENABLE macro to help
enable or disable use of MAC rx/tx delay. However, RK3328, RK3566/RK3568
and RK3588 GMAC driver does not.

Use of the DELAY_ENABLE macro help ensure the MAC rx/tx delay is
disabled, instead of being enabled and using a zero delay, when
RGMII_ID/RXID/TXID is used.

RK3328 driver was merged around the same time as when DELAY_ENABLE was
introduced so it is understandable why it was missed. Both RK3566/RK3568
and RK3588 support were introduced much later yet they also missed using
the DELAY_ENABLE macro (so did vendor kernel at that time).

This series fixes all these cases to unify how GMAC delay feature is
enabled or disabled across the different GMAC variants.

Jonas Karlman (3):
  net: stmmac: dwmac-rk: Use DELAY_ENABLE macro for RK3328
  net: stmmac: dwmac-rk: Use DELAY_ENABLE macro for RK3566/RK3568
  net: stmmac: dwmac-rk: Use DELAY_ENABLE macro for RK3588

 .../net/ethernet/stmicro/stmmac/dwmac-rk.c    | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

-- 
2.48.1


