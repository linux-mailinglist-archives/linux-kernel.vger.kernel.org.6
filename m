Return-Path: <linux-kernel+bounces-549901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B2A9A55862
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 22:10:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D61B63AAB34
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 21:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AA0C2517A9;
	Thu,  6 Mar 2025 21:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="p5ugOss8"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A68A2063EB
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 21:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.215.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741295404; cv=none; b=rrcJ+gc9P0NqgqFkBkBu6Uwr7oJgBnr7AFTIJ/zZrknugGmrGUldRGEUZXNRMDS+gutgIfmyoAJu7VjC9NdWx301taQpS5lwu21Myi1KkxWz1FNMQYlYogosBn0aksaKslv/p9+TGWe34FwcF6qrWwLDGTa/Sf1aUP6022CHE1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741295404; c=relaxed/simple;
	bh=CqDwVU/7nprSiF8y5VrrWZurTCaefDs5QFxlc3Lmriw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nxMJFmEbYIHYmFzCn4M9q6B7mWlo73oL/sdSslzUJkvU0TMnIjHWdXOrv/NQB3uAHHxia2QxPaTka++1+HV9NssOKai42mv88Lj8ftzHmJOLDi4AVPcMDTT9mJunrrNr+vZ+nSEkmR+voWtCApM2OIBGxtglpXdtzsNh5U3u5F0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=p5ugOss8; arc=none smtp.client-ip=149.28.215.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1741295402;
 bh=sDXS6ccmXHM7aVTn2W8PvKDj84puFXbx1PJBmmh83iE=;
 b=p5ugOss8RGqOEIGV/X54kmjfx87TiB2fCDoZPDjw5Qec+e91CPS8dGVsiESxNXqMj7A7/k5xr
 j5HNU+BnEMeFynL9+tInZLOmA6SNYtlR82RC//TS59KTEE/GJnL8Eqmg++QBVn7WDZqgSy7fM+R
 qcFxjJ3gUX+4wJ6hrboOiT3V2xJUDfO9uSgoYhd3L33E5oVJhsn3yreNIrHbdbW3XVSqnO+Jom6
 cK4E1VZrBw3ioXKJshWTNyMps4exY9nQqErn0GLQfT5vBC+SYaC/MP4+a2p6M+76RlnfAWitUmm
 Py84Y2YuIbhSVXDa+uF3taQo7XeAvSFFWvQ9qoEer7Jg==
X-Forward-Email-ID: 67ca0f24ad3e70e1cd99d7f2
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
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 0/2] net: stmmac: dwmac-rk: Validate rockchip,grf and php-grf during probe
Date: Thu,  6 Mar 2025 21:09:44 +0000
Message-ID: <20250306210950.1686713-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All Rockchip GMAC variants require writing to GRF to configure e.g.
interface mode and MAC rx/tx delay. The GRF syscon regmap is located
with help of a rockchip,grf and rockchip,php-grf phandle.

However, validating the rockchip,grf and rockchip,php-grf syscon regmap
is deferred until e.g. interface mode or speed is configured.

This series change to validate the rockchip,grf and rockchip,php-grf
syscon regmap at probe time to help simplify the SoC specific operations.

I do not expect that this will introduce any regression. Prior to this,
use of a device tree without a rockchip,grf would fail when interface
mode or speed is configured, with this use of such device tree would
instead result in failure at probe time.

Jonas Karlman (2):
  dt-bindings: net: rockchip-dwmac: Require rockchip,grf and
    rockchip,php-grf
  net: stmmac: dwmac-rk: Validate rockchip,grf and php-grf during probe

 .../bindings/net/rockchip-dwmac.yaml          |  17 +-
 .../net/ethernet/stmicro/stmmac/dwmac-rk.c    | 269 ++----------------
 2 files changed, 32 insertions(+), 254 deletions(-)

-- 
2.48.1


