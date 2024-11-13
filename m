Return-Path: <linux-kernel+bounces-408382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36CF49C7E1E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 23:10:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C44ACB23397
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 22:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3563B18C021;
	Wed, 13 Nov 2024 22:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="kNPIKluT"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCCF2189BA0;
	Wed, 13 Nov 2024 22:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731535830; cv=none; b=QRV74kljf8HjM/c4aq7vZNCdxrID0zn6Qr3qFLJRZLdbAlbyqTOXWuyTKGaESENZNLouqMt+xWLo5zRYDNkEi6Rx3aVHg9r9fHSyPBm2zkRmPL/WWMU/hYiIL7HcwWwCw9lWp1HY0LGVlPyt+Sr7njsgm8HvamSB8AtvNGVfmzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731535830; c=relaxed/simple;
	bh=GDFhyIIdJCPwr+RE3RFrbNBp7E6CG5ezDJRmtYNSVoQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XIlOPQM/FrAw0CYNpueI17wQyE2WU416a0A2pSIKpYE2mRI4Kl+MRIqxoNRtMnwSAsS4clpKRgmk75D26ggw+NMqXPfrbMZwbjNHfEeHpf6pNvY97bus6my9e6XfZbeXOZyO+Fq20qIBv35gYunS+SHe3Guz3m5XVEg/EMXXZJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=kNPIKluT; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:
	Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=4og6PGVYmoVjgqQoxtFl7GKtzsIYYbh32WB3ISptOXc=; b=kNPIKluTKwIuek4744s04eyNjH
	RFpR1ugPSkM5kzPaALfraFNEHJIPUaf65HoNfDPUxpuHTTQmHXZ83wzJ6ZxC33U9580Idzt/oUh/j
	KaSmWN6KSo11+WF7MPY2tbajoGo39aQhADr1QXD8NTsQoDjwBrXUoJCXVQBJpItG070hb/Da+zrMN
	ghsq8PBg18Pq07QpYj4gWXDu5GocTcXAjb87OdeTP8TyEaXMwyOj7OIZCnFNKT4CujZI0az2xbnvY
	YJA7cxW4Tb90Fb+X78SRntf99+vSjtOMmQ5C6HALu208/IDarq2TH/3PxDm0c3+AcKj6Lb/bDKP5x
	SLLrrTzg==;
Received: from i53875a30.versanet.de ([83.135.90.48] helo=phil..)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tBLZ8-00069a-LC; Wed, 13 Nov 2024 23:10:22 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: vkoul@kernel.org,
	kishon@kernel.org
Cc: heiko@sntech.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	quentin.schulz@cherry.de,
	linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	sebastian.reichel@collabora.com
Subject: [PATCH v3 0/2] MIPI DSI phy for rk3588
Date: Wed, 13 Nov 2024 23:10:16 +0100
Message-ID: <20241113221018.62150-1-heiko@sntech.de>
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
  dt-bindings: phy: Add Rockchip MIPI CSI/DSI PHY schema
  phy: rockchip: Add Samsung CSI/DSI Combo DCPHY driver

 .../phy/rockchip,rk3588-mipi-dcphy.yaml       |   82 +
 drivers/phy/rockchip/Kconfig                  |   12 +
 drivers/phy/rockchip/Makefile                 |    1 +
 .../phy/rockchip/phy-rockchip-samsung-dcphy.c | 1647 +++++++++++++++++
 4 files changed, 1742 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/rockchip,rk3588-mipi-dcphy.yaml
 create mode 100644 drivers/phy/rockchip/phy-rockchip-samsung-dcphy.c

-- 
2.45.2


