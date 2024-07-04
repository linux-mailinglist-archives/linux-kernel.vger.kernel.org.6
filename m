Return-Path: <linux-kernel+bounces-240836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A69DF927369
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 11:55:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2AFF5B22287
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 09:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E03DE1AB8E5;
	Thu,  4 Jul 2024 09:55:35 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C556F18FC81;
	Thu,  4 Jul 2024 09:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720086935; cv=none; b=W3SFrad1XBGyMSYNMSQlJN/elXh4YcnkBlzGqCv7PwIJB9kc9W7HnzCpRlBGRt8o+L4WXQZ6uOJv20pSzDk00cZ9foxlLFtny/pnoc73tgHaKKASCY/ednfBYJ9/OkejWfRo6PsGYUeoAfgxKiV5PBy0s2KIEvLdC0uZlvLm3Hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720086935; c=relaxed/simple;
	bh=a9gCjavV0b9EvjwTw4am+1ns/6TjE63fRGCPyiA7MTM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=m8EwxB60bdGUK5LdfEreauIdPvuIxgNTbXWqM+NIdeIcn9K3mYwipcm+2guawDE1cELfPicfDI1M5Da17S9lyRXaUmOg9KSOwBCjqLGGEVwCEamEIVu/ua1D85gBfSFeD6S9R/gGOKksfDXWkG8Du27Au7OBKaFSazSaqAbCIwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i53875ac2.versanet.de ([83.135.90.194] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sPJBX-0007Vl-DI; Thu, 04 Jul 2024 11:55:27 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: heiko@sntech.de
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	dsimic@manjaro.org
Subject: [PATCH v2 0/2] ROCK 5 ITX devicetree
Date: Thu,  4 Jul 2024 11:55:22 +0200
Message-Id: <20240704095524.788607-1-heiko@sntech.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a basic support for the Rock 5 ITX board.

After struggling a bit with the pcie3 ports, thankfully they seem to run
pretty nice now thanks to me finding the property for the shared-rx-clk
for the pcie3 phy.

changes in v2:
- update naming to include a space/dash between 5 and ITX. As Dragan wrote
    "the name of this board deviates from the standard Radxa naming scheme,
     which is something like "ROCK <number><letter>" thus, "rock-5a" is
     fine, but it should be "rock-5-itx", simply because there's a space
     between "5" and "ITX" in "ROCK 5 ITX"
- spelling fixes (Dragan)
- removed status from adc-keys (Krzysztof)
- added Krzysztof's binding Ack, after asking on IRC about the
  added "-"
- updated copyright statement to something correct

Heiko Stuebner (2):
  dt-bindings: arm: rockchip: Add ROCK 5 ITX board
  arm64: dts: rockchip: add rock5 itx board

 .../devicetree/bindings/arm/rockchip.yaml     |    5 +
 arch/arm64/boot/dts/rockchip/Makefile         |    1 +
 .../boot/dts/rockchip/rk3588-rock-5-itx.dts   | 1186 +++++++++++++++++
 3 files changed, 1192 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3588-rock-5-itx.dts

-- 
2.39.2


