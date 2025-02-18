Return-Path: <linux-kernel+bounces-519316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87A87A39B7D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 12:55:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B3633B539C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 11:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C25BB241131;
	Tue, 18 Feb 2025 11:55:15 +0000 (UTC)
Received: from smtp-42aa.mail.infomaniak.ch (smtp-42aa.mail.infomaniak.ch [84.16.66.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C4F32405EF
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 11:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739879715; cv=none; b=Feo5JdfZKaQPJbJyu/N3NkUn7kXw8AXJXTcqX16sYJRo0Y4GYbw2Hl6TtHm7NP64naqi6Cn+dVWXM7wSrAqyd/sDbgUgQg4D4uAboICcmqoWcUbas603IJyxrYzMa58v0CP8zGwnsDqDL9jggShLC3J5fRqh+yTAT25hHjWbeiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739879715; c=relaxed/simple;
	bh=mBv40pRR7MKUXb++oJNPTPMLu1stYDN7CMpH6HHhSA0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=L685+6E4qs+NSe39BTUo1WUjBhhJ5/DwybC/NTPeqqJN22QxTsMyBHgMjZfp1N79vu8Uay74VQ1hrvGumkkm+YXfnbLtVCrz0yy8c0NoXXof1DVZUagIA4c7mKzwNXPCA+ZLZhR72gf8UXeS6ntVoabM0P0pNMAsl7qxMt/ugco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0leil.net; spf=pass smtp.mailfrom=0leil.net; arc=none smtp.client-ip=84.16.66.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0leil.net
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246b])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4YxyVd2gHPz4FR;
	Tue, 18 Feb 2025 12:49:29 +0100 (CET)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4YxyVc59ZGzkyq;
	Tue, 18 Feb 2025 12:49:28 +0100 (CET)
From: Quentin Schulz <foss+kernel@0leil.net>
Subject: [PATCH 0/9] arm64: dts: rockchip: align and reorganize Theobroma
 DTS(I)
Date: Tue, 18 Feb 2025 12:49:11 +0100
Message-Id: <20250218-tsd-align-haikou-v1-0-5c44d1dd8658@cherry.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALdztGcC/x3MQQqAIBBA0avErBvQIZO6SrSQmmwoLLQiiO6et
 HyL/x9IHIUTtMUDkS9JsoUMXRYwzC54RhmzgRQZRVrjkUZ0q/iAs5NlO9FSRbqyytamgZztkSe
 5/2XXv+8HVPcwi2IAAAA=
X-Change-ID: 20250211-tsd-align-haikou-724214707659
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.14.2
X-Infomaniak-Routing: alpha

We have three SoMs that can use Haikou as their carrierboard so it'd be
nice to have consistency across SoMs on what's enabled by default. To
that end, Tiger Haikou now has UART5 enabled and Puma Haikou now has the
EEPROM found on Haikou specified.

Additionally, some devices were configured or enabled in the wrong
places (either SoM DTSI when they needed to be configured in
carrierboard DTS or vice-versa). This moves things around to better
match actual HW definition and make it easier to reuse the SoM DTSI
without having to undo carrierboard-specific changes. While at it,
disable devices/buses exposed on connectors which do not have overlays.
They need to be enabled in the appropriate overlays whenever they will
be added.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
Quentin Schulz (9):
      arm64: dts: rockchip: enable UART5 on RK3588 Tiger Haikou
      arm64: dts: rockchip: move DDC bus from Haikou carrierboard to RK3399 Puma DTSI
      arm64: dts: rockchip: move I2C6 from Haikou carrierboard to Puma DTSI
      arm64: dts: rockchip: disable I2C6 on Puma DTSI
      arm64: dts: rockchip: enable I2S0 in Haikou carrierboard, not Puma DTSI
      arm64: dts: rockchip: add EEPROM found on RK3399 Puma Haikou
      arm64: dts: rockchip: enable Ethernet in Haikou carrierboard, not Puma DTSI
      arm64: dts: rockchip: enable I2C3 in Haikou carrierboard, not Ringneck DTSI
      arm64: dts: rockchip: disable I2C2 bus by default on RK3588 Tiger

 arch/arm64/boot/dts/rockchip/px30-ringneck-haikou.dts |  2 ++
 arch/arm64/boot/dts/rockchip/px30-ringneck.dtsi       |  4 ----
 arch/arm64/boot/dts/rockchip/rk3399-puma-haikou.dts   | 18 +++++++++++++++---
 arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi         | 10 ++++++++--
 arch/arm64/boot/dts/rockchip/rk3588-tiger-haikou.dts  |  2 ++
 arch/arm64/boot/dts/rockchip/rk3588-tiger.dtsi        |  1 -
 6 files changed, 27 insertions(+), 10 deletions(-)
---
base-commit: 2408a807bfc3f738850ef5ad5e3fd59d66168996
change-id: 20250211-tsd-align-haikou-724214707659

Best regards,
-- 
Quentin Schulz <quentin.schulz@cherry.de>


