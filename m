Return-Path: <linux-kernel+bounces-394751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A08209BB37B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 12:34:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 580FB1F23065
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 11:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6FF71CCEFA;
	Mon,  4 Nov 2024 11:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="kqt+5cnK"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A72C1B3955;
	Mon,  4 Nov 2024 11:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730719779; cv=none; b=PPzfFsL5Q0yOQMltyBn6qmX12qpgFHCFmp2h8i+PGP9UmUIl/Oh/vPQ65PUDkPp3zjiagznu12FRPC+DKsI/X1hHD9y/wFUBPZSklPihzlq3SazZAA1wxRNSNFYa09GMuetExdN4/Bu/FAJU2a/gDsr1KPsEabhDoPvcUD9f0cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730719779; c=relaxed/simple;
	bh=ZJrgzQybkfJtFUGa4HuYAaVpD5GPr+dW8NwJQleXs8E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G6KMgTRWM9RuV3PqzOgU26fRcPkSJC4xdfF0RumITfPfA3Pl8CVxRtJydP6ziztXaLWPpi+yjyuhCZivYX2RNuYp/bhWLuyQD3WPfJxaOyxbmVLlVzlhMUjzQf8rORa4jUFYALZ1lcDSTcaG2b+Etd4GDxihfn8KxprHTcoOBdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=kqt+5cnK; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:
	Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=B/m0DmMmdN7OE/GwES6hP0Nrm+id8/nt/xalEt0CiLM=; b=kqt+5cnKknfCwkNP2anZVlLhZ1
	3yicda/sP6J99Pj117/14X9ivNNDnzPGwKavXDcPMR/WjBkMosqd8uaMxv8nlSjxGVvr3PvmywqQf
	zfFDMaU24BTPMR32V4XXMFnUL8C7Ab9Zt5aRopW5Tgl5zwfO/NbNGtvLj3Jzo514dDc7C6ncvR22w
	ePJlxGZ1K+IPF/uRJrdjVuJxuCUuFMX0TJOcSGw01GZs8pHN1GAzs3Z1M2huZ/CR0W7mi1O+ZIBfl
	UgsfSU0B9PlUK2vwiZ79z8QPNxwPDAmKtVEtyq6iUuCz+YoUuAWTUB4tzWp5ShTyAsIyXRf2d0FdV
	hTHp19sw==;
Received: from i5e860cc9.versanet.de ([94.134.12.201] helo=localhost.localdomain)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1t7uzy-0008Vi-8W; Mon, 04 Nov 2024 12:11:54 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: vkoul@kernel.org,
	kishon@kernel.org
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	quentin.schulz@cherry.de,
	linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	heiko@sntech.de
Subject: [PATCH v2 0/2] MIPI DSI phy for rk3588
Date: Mon,  4 Nov 2024 12:11:14 +0100
Message-ID: <20241104111121.99274-1-heiko@sntech.de>
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
 .../phy/rockchip/phy-rockchip-samsung-dcphy.c | 1654 +++++++++++++++++
 4 files changed, 1749 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/rockchip,rk3588-mipi-dcphy.yaml
 create mode 100644 drivers/phy/rockchip/phy-rockchip-samsung-dcphy.c

-- 
2.45.2


