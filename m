Return-Path: <linux-kernel+bounces-533551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7035A45BF5
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 11:38:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93E1F188BCE8
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 10:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A977238171;
	Wed, 26 Feb 2025 10:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="IrpValUl"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D614C42A9D
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 10:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740566308; cv=none; b=eScWozIxXv4mTEmRLS04lEqrBaiES8aZwyBdbsFXS4OgQR8P3kJO6RCtHT5qtl/LXN052Po/HEYwct2574OLEMScOLYA7MSe39wIyYBBEr37q11ytJ62iFZC+ZUvVIsCpDh4ebiSSEuuHTZDSTVgZdOU63HfwF4cfdGcxT0D2R8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740566308; c=relaxed/simple;
	bh=tNpEOIvOjXOOQR5E74DVxKlmjYF1Bu7KF+vF2eWUnFI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S4sUA3FgwcMZ2du5F3CteERtlZ7ZjL101bk2gk85fY/eb/vrtDkLuhi4B7F/cewt4JXj9r3RS/TcZS09jx6hicsm18jff107TMMEUEvbpTFEerspiGbeAkkRP5x7twnnUfx+WQRdt2CJ/eRgrd5fHK2ffWEwkImRYkN9y2EUEr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=IrpValUl; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:
	Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=+UGCoWBioAMtXtHm8CAvoMnBqRSxIPHa7kTP4Y78/Mo=; b=IrpValUloRiJKw2SB7N7epThrt
	NFi6BJUBdQ3Hz94ktQ/QHyU68jQGRFTdFYwxj+2PYDd/yk0OAqlAdi9LIZuXI8qxgCUlLnUv4CHWL
	MDxra/vNufGVI3auC0oWJL1B0s+XyEqkVtZAXW6araCSdRkI3OCmHg0ryH6a5Bpo45XIQpDmiXFOR
	60UTsCGPRb5lBUd3uDM9U4kas0T2a+00RZjpFxC7QeT5FGaGCH6nnl8OBWbwpU1n9Cotaw9oUHc5v
	h85IiB31Q4A/aKXm23WdlS8yanUqPg0dxJhf4Y//fNbdi46/WKWKVwhEZHs/PdZXetjhOLMyXo39/
	b51fq44g==;
Received: from i53875b47.versanet.de ([83.135.91.71] helo=localhost.localdomain)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tnEo2-0006aJ-GC; Wed, 26 Feb 2025 11:38:22 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: vkoul@kernel.org,
	kishon@kernel.org
Cc: heiko@sntech.de,
	linux-phy@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	quentin.schulz@cherry.de,
	sebastian.reichel@collabora.com,
	christophe.jaillet@wanadoo.fr
Subject: [PATCH v2 0/2] phy: rockchip: usbdp: improve typec orientation handling
Date: Wed, 26 Feb 2025 11:38:08 +0100
Message-ID: <20250226103810.3746018-1-heiko@sntech.de>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reinit the phy if it's already running when a type-orientation
event happens.

changes in v2:
- fix an error I made when splitting into code-move + re-init
  function should still return 0 after first patch
- use rk_udphy_init() instead of disable + setup combo
  We don't need to disable + reenable clocks

Heiko Stuebner (2):
  phy: rockchip: usbdp: move type-orientation-switch further down
  phy: rockchip: usbdp: re-init the phy on orientation-change

 drivers/phy/rockchip/phy-rockchip-usbdp.c | 171 +++++++++++-----------
 1 file changed, 88 insertions(+), 83 deletions(-)

-- 
2.47.2


