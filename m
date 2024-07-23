Return-Path: <linux-kernel+bounces-260364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96FF193A7DA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 21:56:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2277EB22F02
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 19:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E37F143871;
	Tue, 23 Jul 2024 19:55:51 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CED2142624
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 19:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721764550; cv=none; b=igX0KIySEgWe/vZAXAPtuBYQcDHKk9kDWc0eZBp8cCKxVXqRosoG0wElrocISkHTzyKljZe+vDSTtXmTnUWRZLa2qtmn6Tvi9FE5MoS+1n/ODQPVPgZF8h3g+UpQXK+qOSyhxEpUl29xamqhiqnIE3K48uZ2U7Yc8+BYu/w8ZR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721764550; c=relaxed/simple;
	bh=OgH/MFn71YZJud8AydSKjAwdpyC0D4f2pGsG8wxHlF0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oEOw3x/fb4hL+77Qo0ZUmB6qXnxOX1WYapM13SlYhhEAcAWJ8r1rgUlvv0rGDXBnqWjZXxHgTBXCUFH2px67l1u75ntgSRGwwHGpIlnCrX9bB7A/0crjnsJzY0NmT691fLF5wKx+aE46D1PWqVRQG5bxeOEoNNvp+TeArVsyj4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i5e860cd3.versanet.de ([94.134.12.211] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sWLbs-0005iD-MN; Tue, 23 Jul 2024 21:55:44 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: heiko@sntech.de
Cc: ukleinek@debian.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 03/14] arm64: dts: rockchip: enable uart0 on Qnap-TS433
Date: Tue, 23 Jul 2024 21:55:27 +0200
Message-Id: <20240723195538.1133436-4-heiko@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240723195538.1133436-1-heiko@sntech.de>
References: <20240723195538.1133436-1-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Uart0 is connected to an MCU on the board that handles system control
like the fan-speed. So far no driver for it is available though.

Tested-by: Uwe Kleine-König <ukleinek@debian.org>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm64/boot/dts/rockchip/rk3568-qnap-ts433.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3568-qnap-ts433.dts b/arch/arm64/boot/dts/rockchip/rk3568-qnap-ts433.dts
index 9bf9c3b65ca31..bc26f2e98c185 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568-qnap-ts433.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3568-qnap-ts433.dts
@@ -104,6 +104,14 @@ &sdhci {
 	status = "okay";
 };
 
+/*
+ * Connected to an MCU, that provides access to more LEDs,
+ * buzzer, fan control and more.
+ */
+&uart0 {
+	status = "okay";
+};
+
 /*
  * Pins available on CN3 connector at TTL voltage level (3V3).
  * ,_  _.
-- 
2.39.2


