Return-Path: <linux-kernel+bounces-429879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 306519E280E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 17:50:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCF971671A5
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 16:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08F731F9F5C;
	Tue,  3 Dec 2024 16:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="xLgs2Li0"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B8D91F8927;
	Tue,  3 Dec 2024 16:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733244590; cv=none; b=f7HukSC3GYfqSwHgKDNL+d1F8rdbmx3RVQRSbIm0bp/a5G2cxrEi6m3t3tnx3K9e1WnVByy/4BsO8qKmB/kKFPhm/cRnoL7vKPFXN5yQVhDWCiTq3Hi9DgSFQlCVkSdYwt+aGSqopijB3bIu/SHn3LaZ/zHpArUDUvr2iGyqVKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733244590; c=relaxed/simple;
	bh=9QjjQhrpIZoRjOjWjhp0+i8iOw4Ja0a0dKJQLqjYaIM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dQ+cAlVmqHVSlby2arOxbXmag8FAYJn3BlSgmxI/OuZVBbZgWhbGCxmc+p/OOSVCa21l8IH7aWrhOrQlV9GGXVji+Lp8XPDNQP1hTzNzDW4SRtgi6PnT1BlF/B8aMbJoIjzhHAp44wYD0gwKNMjpzgeUT3se9hIErUqeW+Fdkz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=xLgs2Li0; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:
	Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=zUMJP/s3MYtTzLFMldW9WHKV2OFH1dxcgqMyCi8YpAA=; b=xLgs2Li0E4WWYgibJQvB/usQtS
	yWwXBBzBss1CTxpCwTQVUlxYtxqwQKa26hziDiYvJi4B9VhJBUYggV6CEHnwCv5pGZ1AsINt7lML8
	Kxt9hWcUy4uTExzuAEd/m83ea+gro1NVHD1EFXOYXJ4ZIqN5s8Kboq3hobJ5HImqauVbCJkGz6B0d
	pVWI3APtYH46o8Dw3zLkeT1T0g+2j6pZCeoVvOtECq8ULONzDDj/4esGWWqVhoBayXe/6WEotxcsL
	/LuF6baMzZL0uphFqncOt1itZkjB0RknpMzV03UhTwfGRE1E9GcoTKfAYrLyE+DDCec/ikyhNcI+L
	DZ+aRvzQ==;
Received: from i53875bc4.versanet.de ([83.135.91.196] helo=localhost.localdomain)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tIW5n-0003fy-5X; Tue, 03 Dec 2024 17:49:43 +0100
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
Subject: [PATCH v5 0/2] MIPI DSI phy for rk3588
Date: Tue,  3 Dec 2024 17:49:30 +0100
Message-ID: <20241203164934.1500616-1-heiko@sntech.de>
X-Mailer: git-send-email 2.45.2
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
2.45.2


