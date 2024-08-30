Return-Path: <linux-kernel+bounces-309448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95B84966AC4
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 22:38:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD6071C21E44
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 20:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E58DF1BF81E;
	Fri, 30 Aug 2024 20:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="ghLJuRGJ"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B491BD018;
	Fri, 30 Aug 2024 20:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725050318; cv=none; b=SnOm0mDp4NaYGTT4cteWJwZmRNnxsizOcEAEo7RwGsY+b8sQozx+Bm0rX6RJ53qJNbxIt0Ye4JDeErN+DqqhkGd4FbBUbL/8ZNxVTMyjx9zpV7t3r/Jp2ElaeXqjmZd0DHSaYp728Cy3OwD9sLZi+4dgJepWzIT63nyzuxLnYio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725050318; c=relaxed/simple;
	bh=T+c8/CczGD6UHcEZP3V+XY0cyMjORWr0myRFxNAsX1E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=el5WBBwfosu1PAgEIfo/ldshNt+4CA+s1gykbsfqvKnoZ+MjYj7WT4VUgdIft6CyjeLPn8/VRGteNAanaVj+/dz17Tipz3JjCTxfkyyNpcE+OEbTXLtVID55cK1+pC6ohfT01XV6IumF/B84RRZwHhl/R9/WI5gvtUyxPhmlnLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=ghLJuRGJ; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:
	Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Y87Wj2BoC+XSVLs7maxMom4zaevBF7HD4ifA4tnI7jg=; b=ghLJuRGJLkEfPm7xljKFc2h7E1
	iAgsV+/4FjNg4GSXxbdMGD6+b186qxKCFT69Gj111CPKIi40rF9i91SUvY9qdpy+UbljQ7lxJtB1o
	r6qbOL2gJRthMpXsIXWljaeBKpLwCsQIAdIK5H2o4xvEZkNRL4ll4Gk8XJsiv1Kjw8eTXNx+OW3+A
	NM8snfN7TryAdh2NHpPbSVXLNN/DmxxrSGfEtEpdFDBcAINr3XOeYGOxGho2CYGIkgSmBQihbW4P0
	/ag6//15A+CoHKVhIO5PEplld9EV86hvi8N9FjKjchaBUMC0u027sIBuwl2EZWK9EwEoc9/2RGTF8
	rWYJ6xjw==;
Received: from i5e861921.versanet.de ([94.134.25.33] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sk8O9-0006ey-Hx; Fri, 30 Aug 2024 22:38:33 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: lgirdwood@gmail.com,
	broonie@kernel.org
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	heiko@sntech.de,
	marcin.juszkiewicz@linaro.org,
	linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: [PATCH 0/3] Fixes for the audio setup on the rk3588-nanopc-t6
Date: Fri, 30 Aug 2024 22:38:16 +0200
Message-ID: <20240830203819.1972536-1-heiko@sntech.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Nanopc-T6 board does contain some devicetree errors, that came to
light with recent changes to the board.

clock and port properties need to be part of the codec-binding like used
on other codecs already and one property needs to be removed from the
board.


Heiko Stuebner (3):
  ASoC: dt-bindings: realtek,rt5616: document mclk clock
  ASoC: dt-bindings: realtek,rt5616: Document audio graph port
  arm64: dts: rockchip: drop hp-pin-name property from audio card on
    nanopc-t6

 .../devicetree/bindings/sound/realtek,rt5616.yaml    | 12 ++++++++++++
 arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dtsi   |  1 -
 2 files changed, 12 insertions(+), 1 deletion(-)

-- 
2.43.0


