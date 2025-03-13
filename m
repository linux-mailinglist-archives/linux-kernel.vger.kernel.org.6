Return-Path: <linux-kernel+bounces-559607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63153A5F61D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 14:41:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D39B17EC87
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 13:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B6AE267B00;
	Thu, 13 Mar 2025 13:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="gyJyVrD1"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E77267731;
	Thu, 13 Mar 2025 13:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741873257; cv=none; b=eKLNfNzODX/tk/vVIltnQcS8dVUfFB7wh7uiofgeqzwI4j5T9K5SNdU2WV14yi0xUUqpqS7ubQZlIsGrFtmd3tpZPU/5LSJtlJdTb8AQW3E352hIMsROyT2UOLqs475+nbIkE491JtQgfkr+WAzJy575z9ERHbGXBY+7S2vXr6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741873257; c=relaxed/simple;
	bh=fDrllgJwbtF5U+EFRF19R7vCBQLB8dfEURQCxyc9ok0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SscldYA0yr9hyC8YjUOiX5a/gNhv8/BLseTC5i7etbn6OY3+oN0VipNVMY6ebPSLpVCNcDODoFqKGuMhApcnY8UigA/ISO5p9LbYqiWCvhMCGEDsBHH7KVA3vL3f655jQ6nbdKTrHp3YOn/IezuKpm85iBTNjva9f3B4RKyourA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=gyJyVrD1; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:
	Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=4CWs8MteW/WaidbFLCARB0U29Fg/zJsP3Gsrar0C4Ew=; b=gyJyVrD1SJUsXkw6uxZS3GyW3g
	yN5gt3IJJom2RAdV08DWMh0KkFwfK18ljaOcqm4qZWt1izix6OXX2Auikxa04YcUR6+zDUNjglmYE
	VyOyTWb74IUejLowq3DWuBg8J4yF3Iu7EnWN+HGsPGnGEs6RkPFdzXj1ywrAuRwF+vuqlXPKwPckJ
	VBGZmJMpsIutJjLqs9/Hajm7p8B4mCeJsI/tZ562ePWcQKI9BuQg7GOnAPmGTC2vcj18QIkJMHBtl
	ubbZMr45dsNr4lewH6/APGmfJ8/G8A3TmiASAJWn+Pzdy/iNaFtiD6URQDxbv8hL3CjX1Xkhsszis
	iVHssZHQ==;
Received: from [62.91.42.92] (helo=phil..)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tsine-0008Rg-Vf; Thu, 13 Mar 2025 14:40:39 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: vkoul@kernel.org,
	kishon@kernel.org
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	quentin.schulz@cherry.de,
	sebastian.reichel@collabora.com,
	linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	dse@thaumatec.com,
	heiko@sntech.de
Subject: [PATCH v8 0/2] MIPI DSI phy for rk3588
Date: Thu, 13 Mar 2025 14:40:30 +0100
Message-ID: <20250313134035.278133-1-heiko@sntech.de>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds the phy driver need for DSI output on rk3588.

The phy itself is used for both DSI output and CSI input, though the
CSI part for the whole chain needs a lot more work, so is left out for
now and only the DSI part implemented.

This allows the rk3588 with its current VOP support to drive a DSI display
using the DSI2 controller driver I'll submit in a next step.

Only generic phy interfaces are used, so the DSI part is pretty straight
forward.

changes in v8:
- add comment that the timing values comes from the vendor kernel (Vinod)

changes in v7:
- missing pclk-disable in resume error path
- replace remaining magic values with actual constants
- lower-case hex values
- made lane_disable behave similar to lane_enable wrt. lane count

changes in v6:
- rebase onto 6.14-rc1
- add Krzysztof binding review
- v5 was sent at the beginning of december '24, so probably has been lost

changes in v5:
- add bitfield.h for the FIELD_PROP definition
  (reported by kernel-test-robot)
- add Sebastian's Reviewed-by
- add Conor's Ack to the dt-binding

changes in v4:
- moved to #phy-cells = 1 as suggested by Sebastian, with the argument
  denoting the requested phy-type (C-PHY, D-PHY). This works similarly
  how the Mediatek C/D-PHY already implements this, see mails around:
  https://lore.kernel.org/all/20230608200552.GA3303349-robh@kernel.org/
- dropped Krzysztof's review tag from the binding because of this
- dropped custom UPDATE macro and use FIELD_PREP instead
- build a FIELD_PREP_HIWORD macro for the GRF settings
- add received Tested-by tags

changes in v3:
- add Krzysztof review tag to the binding
- address Sebastian's review comments
  - better error handling
  - dropping empty function
  - headers
  - not using of_match_ptr - this should also make the
    test-robot happier

changes in v2:
- fix error in dt-binding example
- drop unused frequency table
- pull in some more recent improvements from the vendor-kernel
  which includes a lot less magic values
- already include the support for rk3576
- use dev_err_probe

Heiko Stuebner (2):
  dt-bindings: phy: Add Rockchip MIPI C-/D-PHY schema
  phy: rockchip: Add Samsung MIPI D-/C-PHY driver

 .../phy/rockchip,rk3588-mipi-dcphy.yaml       |   87 +
 drivers/phy/rockchip/Kconfig                  |   12 +
 drivers/phy/rockchip/Makefile                 |    1 +
 .../phy/rockchip/phy-rockchip-samsung-dcphy.c | 1719 +++++++++++++++++
 4 files changed, 1819 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/rockchip,rk3588-mipi-dcphy.yaml
 create mode 100644 drivers/phy/rockchip/phy-rockchip-samsung-dcphy.c

-- 
2.47.2


