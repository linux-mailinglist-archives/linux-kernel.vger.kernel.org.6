Return-Path: <linux-kernel+bounces-513911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39AB9A35024
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 22:06:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D473F188C143
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 21:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60A622661A9;
	Thu, 13 Feb 2025 21:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="oVNy0YXX"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC76266B79;
	Thu, 13 Feb 2025 21:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739480786; cv=none; b=gOjBTNBVpvt2XnGI9t5XrA8wFHdGpqHAHa4pU3ErucB2tWu1mURsc+lofS6+xmffxpzfm8xuVd0XutxN+UjQXCT7m70IkD4N1bd785xne7FGhH/QLX9/ahK4nNIjd4f4P4JTJ0//9pCG//i7Rj2+bjVJTWoWLYlttggYco5LmRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739480786; c=relaxed/simple;
	bh=a2fB9wr/h7U/6HZTcm7xQ1EGsft9gg282LSV5XeX0v4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CMsOGgRrhZ8NgQ+33CrcgJLEcZ/+yeBEkqGk0JsTpPO8Su6dnkup9FiY9arYwBv2WPS19OUeL0H1AWqH22+SG1mRoHH7vK7lqzx9knyvoAusY9kIW5FQZM05ppcVhHw0WRXMrv5aed5faO9nvlBn5oys1Bjd0g0KUFWFoQbORVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=oVNy0YXX; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:
	Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=NXJUGBvDPkCp2lSwyUa9SRmZSrIoKC6js7gmMeChEic=; b=oVNy0YXXg2Rpbu8oXcoHKrmwfP
	TkV1Lnz+e07AfltG+k9Ltrv4ftiaYWRtbUgcb1JedmnFg8+S1fZHWZ7Y9n6JnbMnl/3BOoNbXNqXt
	w8M/0GV10waXdXPCaF+zNv1d2NfopMz95VyRdzYoCjddA2h/LDJw8h+KDi3vPoeKWgpEteGx3zSf/
	1VUK/VOtrdnTZscIO7Zk4RNEPkeqZ/SjBA/cfT2avcAoLU5nm8T+oUs8Ui1bCtm1GlOXCuG4oO6so
	wWu4AC7ExGsSEW6nOoJ9uhmXM46m7RqUmp17FhfAcc6RklKRFBAjJL+irOL5SMhKLkiCKi8J/c8/Q
	6+h1ZqCg==;
Received: from i53875bc0.versanet.de ([83.135.91.192] helo=localhost.localdomain)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tigPY-0006WG-UP; Thu, 13 Feb 2025 22:06:17 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: vkoul@kernel.org,
	kishon@kernel.org
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	quentin.schulz@cherry.de,
	sebastian.reichel@collabora.com,
	heiko@sntech.de,
	linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	dse@thaumatec.com
Subject: [PATCH v6 0/2] MIPI DSI phy for rk3588
Date: Thu, 13 Feb 2025 22:05:46 +0100
Message-ID: <20250213210554.1645755-1-heiko@sntech.de>
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
 .../phy/rockchip/phy-rockchip-samsung-dcphy.c | 1604 +++++++++++++++++
 4 files changed, 1704 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/rockchip,rk3588-mipi-dcphy.yaml
 create mode 100644 drivers/phy/rockchip/phy-rockchip-samsung-dcphy.c

-- 
2.47.2


