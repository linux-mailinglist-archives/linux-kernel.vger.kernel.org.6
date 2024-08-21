Return-Path: <linux-kernel+bounces-295372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 357C1959A2C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 13:37:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E63E1282363
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 11:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65C141BAECD;
	Wed, 21 Aug 2024 11:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b="kUIOuA1V"
Received: from mail.thorsis.com (mail.thorsis.com [217.92.40.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F0BF1B655A;
	Wed, 21 Aug 2024 10:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.92.40.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724238000; cv=none; b=jOzCpfaMdPFhrsWE34iawHeKebTNcgLCbnKuLaN5yW4OgN5gjAKlqnbXUyRC6c8vgoH1Bw7AG6nyBAgplF/m6hUzvvQsxAZrwjzyi7JvENppBtar76zsiCLiTJvYQ6q8MfSrBGFj63WsElLCDnzmlvenfvSWLu5CH56hH+Pd0io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724238000; c=relaxed/simple;
	bh=Z5C1FRckoTVEYt6BvjisZfD0B2IGu9+fT7K99xpq5tQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=W4sEv2t9z4hgaG4JN6B6fz1VmbU5XfT4LYvHmP9vcJf2Cvt+wwrwwTKbcut5WxkwOuk7Xn7Iy88T2hauRwFFXvayaPZL28rEmMm814aT0CLhspF17EoKeCJm0gYV4WvTr+BWv3FgnkRC4k6r3QMsDQoJzlu9UrKTILg8aNyVTho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com; spf=pass smtp.mailfrom=thorsis.com; dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b=kUIOuA1V; arc=none smtp.client-ip=217.92.40.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thorsis.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 697211483DF6;
	Wed, 21 Aug 2024 12:59:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
	t=1724237995; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=16XwRQ9Fnf5UaoUkVrP6/gJBIWPHHwI4pGVmwBYvBoM=;
	b=kUIOuA1VyC34Wteyyw80TGEFtsL048BEsSLab6Q79E3iie5zLTNXdlTHmXcJzB/dxzRYhJ
	0a5sX98oqWlLFzN+clu5sCSF1QjGEdAz+6usFZ8GU9hGgeIn0GJOhSA1H6OdttAHxTDa24
	SvowOrwbgIe2KeSDSjAgMW7whNiZ/GUY3iJBpC165rc19kMXOQJWmgcc7NlRKpeUbSo9J+
	cTsYkZYxzKp59yurJ7cWNRIjb3cp0TGzqf3Ba5TEo2e/mlCLyLE5Ep51ZqtZ8Las581yUD
	HnGFvXB8wLhwqFeTzXTv1rQWd5U6guNB2nFoNNJYX2jIeQtQVadLKp+sTlaV7Q==
From: Alexander Dahl <ada@thorsis.com>
To: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: Christian Melki <christian.melki@t2data.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/Microchip (AT91) SoC support),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v1 06/12] ARM: dts: microchip: sam9x60_curiosity: Enable OTP Controller
Date: Wed, 21 Aug 2024 12:59:37 +0200
Message-Id: <20240821105943.230281-7-ada@thorsis.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240821105943.230281-1-ada@thorsis.com>
References: <20240821105943.230281-1-ada@thorsis.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Allows to access the OTP memory now, and Product UID later.

Signed-off-by: Alexander Dahl <ada@thorsis.com>
---
 arch/arm/boot/dts/microchip/at91-sam9x60_curiosity.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/microchip/at91-sam9x60_curiosity.dts b/arch/arm/boot/dts/microchip/at91-sam9x60_curiosity.dts
index c6fbdd29019f..754ce8134f73 100644
--- a/arch/arm/boot/dts/microchip/at91-sam9x60_curiosity.dts
+++ b/arch/arm/boot/dts/microchip/at91-sam9x60_curiosity.dts
@@ -254,6 +254,10 @@ ethernet-phy@0 {
 	};
 };
 
+&otpc {
+	status = "okay";
+};
+
 &pinctrl {
 	adc {
 		pinctrl_adc_default: adc-default {
-- 
2.39.2


