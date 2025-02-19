Return-Path: <linux-kernel+bounces-522656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DD10A3CD02
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 00:04:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69A5B7A8B50
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 23:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E05B25C70D;
	Wed, 19 Feb 2025 23:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="bkLU4YES"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2905257ACE;
	Wed, 19 Feb 2025 23:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740006203; cv=none; b=VvH2cVh/zadBcNhQxg2atAp+C7jIVJTsTSl1rqUI2td4hfBvziZGBIrrmhpI9D5jf7AoSh89njy1ba2OYZefiFihpaWCf2SN4pELY3ZpP0w+QFcIU0z0IIGtXCbl1jHYgEs6q7U5LdpjBqojaI8JUtH4gvwrB3YqEFQyYGRE1l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740006203; c=relaxed/simple;
	bh=GirwESdaI+RJ9HvJVcapEPWjFi6xoHCf0oX+hQcZ3nI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Oo1fIPyLhsntSmXSfmyasn/h0sKzW0YrSt0dk9wWu0XoBVtwRiLkdGV3QFFh+eDIQKf7iqXcjkdimfW+mj5o70kFZISUngBwla7ydHJJCjPv4Vw5E6xFHpO604tjBHt7hptg1MPTkuaS7qV0b2noZf12Vtobt+dXc/njIKyjJ28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=bkLU4YES; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:
	Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=gxy/D70314SLvPjtQ3M8F2Cxl5dglM+LoYwaFSNDAIo=; b=bkLU4YESjqUDorekF8n19QZNSY
	ufx57LUNk51CyVqi+HqizUoPbK5NYPs8EZQpNDTTb6UNUECJN4cEVgDap4XDMSxsSsGTyfu6rMLpY
	GP+r8NyvKABBBDf6iK8poZEEdOChXj88Wlm0eLx2xTXBz0dMy0W8eGzLr727m3z4CTMEsfX8RgURx
	pqvEn/Ifw48zX3T7OaNA/AjkgSqLTciBuJf8XDFMLOTomb9eoPeEQhovep3mrUbnljg6HChbhwoH6
	IFPGN0S3L/Ih7dx8nr8XJD1NDA+Ch/9AMmIoEck//pJEsZBukL87j16mgZ2mVJHHgbg8QaAPZBnP3
	gQ8cpmew==;
Received: from i53875bc0.versanet.de ([83.135.91.192] helo=localhost.localdomain)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tkt64-0006Du-9o; Thu, 20 Feb 2025 00:03:16 +0100
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
Subject: [PATCH v7 0/2] MIPI DSI phy for rk3588
Date: Thu, 20 Feb 2025 00:02:57 +0100
Message-ID: <20250219230303.2539733-1-heiko@sntech.de>
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
 .../phy/rockchip/phy-rockchip-samsung-dcphy.c | 1715 +++++++++++++++++
 4 files changed, 1815 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/rockchip,rk3588-mipi-dcphy.yaml
 create mode 100644 drivers/phy/rockchip/phy-rockchip-samsung-dcphy.c

-- 
2.47.2


