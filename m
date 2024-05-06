Return-Path: <linux-kernel+bounces-169834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 093B38BCE5E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 14:49:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B47251F22E9D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 12:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 831E56BFB0;
	Mon,  6 May 2024 12:48:52 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA9454645;
	Mon,  6 May 2024 12:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714999732; cv=none; b=gZRzwR4vVb8Iz+jJcHFEv5ToIgdsdoxshG5SVmlkHU3BwxtpBRjhd+P8ZGLzqOvRGZmYQ1okxvo936BLwdnYfKuYHtB5IX5SrYZJbPzo6nrMx5EciYZvDxDzK3CCMtfsIKKSSlBtPnmYS524sls4BbX48riFR/+tXTiDrZ2f4kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714999732; c=relaxed/simple;
	bh=69iCLm09QGWcswv+yIGciO3RdHdWBKpfNDIVAauuaCc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=h2gdK/H0/6uIjOg2Gk6n5OEhefPozsrI/M/3l+EBsE3W8gCksoT3LX0E9deNA/VvJ2OKKigOZ01N3nugDP+rIaMUZbY6kzxZN2fovVuGHO+ZFV0Xlmjk4J2TunnmiUl04P4pBrIw6KA9iNQxeil470v9KxGKo7aDDSB/OgYhh7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i53875b5d.versanet.de ([83.135.91.93] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1s3xls-0005vc-H2; Mon, 06 May 2024 14:48:44 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: vkoul@kernel.org,
	kishon@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: quentin.schulz@cherry.de,
	heiko@sntech.de,
	linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] MIPI DSI phy for rk3588
Date: Mon,  6 May 2024 14:48:34 +0200
Message-Id: <20240506124836.3621528-1-heiko@sntech.de>
X-Mailer: git-send-email 2.39.2
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


Heiko Stuebner (2):
  dt-bindings: phy: Add Rockchip MIPI CSI/DSI PHY schema
  phy: rockchip: Add Samsung CSI/DSI Combo DCPHY driver

 .../phy/rockchip,rk3588-mipi-dcphy.yaml       |   76 +
 drivers/phy/rockchip/Kconfig                  |   12 +
 drivers/phy/rockchip/Makefile                 |    1 +
 .../phy/rockchip/phy-rockchip-samsung-dcphy.c | 1609 +++++++++++++++++
 4 files changed, 1698 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/rockchip,rk3588-mipi-dcphy.yaml
 create mode 100644 drivers/phy/rockchip/phy-rockchip-samsung-dcphy.c

-- 
2.39.2


