Return-Path: <linux-kernel+bounces-241363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 428C3927A4B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 17:38:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF2E71F24AEA
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 15:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CA701B1419;
	Thu,  4 Jul 2024 15:38:29 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 876311AC252;
	Thu,  4 Jul 2024 15:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720107509; cv=none; b=B2+bPTDti4Hfs7TxZdD4XqE9+bxS5A/8G2BBTYVE6pw3oQ8sITgEbytO6SFjcxj6KO5s9fg4WctXUui0TDQRakq3KQARbpuriP2UkTsUs99CRzuZ6iadOT91VmIqpTiBPDNlz/9w5YL41SI7mCC6H9sK6ZrzO61MNDse2WqlBrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720107509; c=relaxed/simple;
	bh=l1wHu69/IK8uif0zEfYCBrxUK8K1NoPw77tDhkWZ8DA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=X27mkRJeiIEl1fn7llhTK32S7PNXdubYwQZaJSuWKE3AQgdPihMTT2gd+LSMX9M6mC5C+Zr4RlFCJCIT2CuRWezQBjtovdp8oqAiid/MafxdRfkQNTVzHCuXdXQv6l9I4uCxAajjCKqui1oYnT321ddbZaBLREOVb1jJTFI6Uu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i53875ac2.versanet.de ([83.135.90.194] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sPOXM-0002hy-9F; Thu, 04 Jul 2024 17:38:20 +0200
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
Subject: [PATCH v3 0/2] ROCK 5 ITX devicetree
Date: Thu,  4 Jul 2024 17:38:13 +0200
Message-Id: <20240704153815.837392-1-heiko@sntech.de>
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

changes in v3:
- better sorting (Diederik)
- fix usb supply (vcc5v0_usb is not a supply of the usb3 hub) (Alex)
- drop type-c sink elements, type-c cannot power the board (sigmaris)
- add links to schematics (Dragan)

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
  arm64: dts: rockchip: add ROCK 5 ITX board

 .../devicetree/bindings/arm/rockchip.yaml     |    5 +
 arch/arm64/boot/dts/rockchip/Makefile         |    1 +
 .../boot/dts/rockchip/rk3588-rock-5-itx.dts   | 1178 +++++++++++++++++
 3 files changed, 1184 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3588-rock-5-itx.dts

-- 
2.39.2


