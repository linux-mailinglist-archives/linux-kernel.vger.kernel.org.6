Return-Path: <linux-kernel+bounces-376875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5C549AB6F5
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 21:36:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2741DB240F8
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 19:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 598C91CBE9C;
	Tue, 22 Oct 2024 19:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B+bmmlKh"
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BCF21465A5;
	Tue, 22 Oct 2024 19:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729625769; cv=none; b=Ea1QICiARIqQ4XxlBiDCceB3bjjBNTMAfVQGGIAT3zjFJrjUcAVGfLzpq8JXkyMsCLr4Jn17naKCfQuRYjSzdnLLw2iqZ9sCQIQXfNDQ704cm9KKer6lifKCMFcVixIJYTqfYgtwCpp4W+pE59qXUWw+II51WnZdSInNQA/C2rI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729625769; c=relaxed/simple;
	bh=LVPIjCkp9cgePCACWtO/nlUWug0wOy0Ogz8clHkiz8g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YHh16g+WCRI4aCEA1QV7EItICv2xSk3/+MiIG5tlmOoMLWewupuNbAPDeVWPa5ACc2CP3h3DhvTHwNlAODmP/+C8FZajpd7Y+cgagDUYq7BBAZDiitvHFiUgbqOkHCKYAMqNRLqQGhrPE+pZp1K56dOfInp6OFYWNgLpWo5Y0SM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B+bmmlKh; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3a3b8b34be9so21112585ab.2;
        Tue, 22 Oct 2024 12:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729625767; x=1730230567; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dV9l/v2LcDXnviTDuNMkbMeVnn+PWfoffe417y/FNaw=;
        b=B+bmmlKhznJ8ri8wFCS9oNfKR0Lu5z5HnO+yrzh+i1CE5hH7VtOYjvbLHXa/8HKs5+
         qQrRkyiSYJ+evlrx9+Wxe7coAZiMMNAUSwB34PeN+Gg2YwgmGaDAfT4gsaPeE9EU2gVy
         pNBgK7LEafEiLKSqlkkwzXrfoTT8Uai1ObNiOhAIyicbdWSilj57w7U7NHDrIdp3GwdU
         dNK8C1tM7rV41130KAFx2n2tCpNd/BND3MnJb5Z5iPELpnfIa7usb7iY5pQKc9jTsVDZ
         n+Zy2uePvQLBEcErDOypIKJue3xkakZ3NoUVYpH0+uD+4CF1oexwo75Mf10ItJnIO2a8
         e5IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729625767; x=1730230567;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dV9l/v2LcDXnviTDuNMkbMeVnn+PWfoffe417y/FNaw=;
        b=ZtWUPFwiZz5uDPc+QO+sPDjuv9QqYKDDhh4/5yFN44/k+cfjqhZHM7vF3Kl2LSHv6B
         rD4z5xh0BVEVBHOFBqZ3UHoHryXpMl2hZPggxBVw2ZuBmzFxhNJ0dEcTqzd7svY3aKYl
         CQe58ASfnqMikO2i1lxDJeUkW+YwZUI+8OTkYzNWHM15FQLxdYj1bfDrFgaa3Mknb017
         pLzWZwYexaW8bflx4paX0Y9okaVkmAqkOD0Pc1GPvRWcctDm2S9H/419G19jgTXCoNzW
         +dMuiOMYLv3ttXCILhDFgkW5GwOiSedo5F10yyy94Ry7LtlPs017FqHkUhomolT66QMT
         Cy/A==
X-Forwarded-Encrypted: i=1; AJvYcCWtzT1feL9cVtidWbRf9x4YfAqMCIHmaNnjXtI/ahJdsVOavHIZu6aFm/GCQLzi/m1HntSqsb0lyklIJ+A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxj7TwsoACk8Wi5TfmGcyE4h/pmitHd3eoU/WJoYUThcXru3NCx
	dZ79qAF7Aajvgfta8hPNKImSuPP1L3IwHjl2Yy6VpntC7W8J7n2F
X-Google-Smtp-Source: AGHT+IHLlalPSHm8zG0hppdjSOOKHduEt8dQUk/4lbr+y7EGhPZQjy5bqFOm5stgAa1QyW5y40KauA==
X-Received: by 2002:a05:6e02:1749:b0:3a2:7592:2c5 with SMTP id e9e14a558f8ab-3a4d59be0c3mr2384155ab.17.1729625767259;
        Tue, 22 Oct 2024 12:36:07 -0700 (PDT)
Received: from CNSZTL-DEB.lan ([2408:8262:245d:4d65:bc4b:53ff:fead:2725])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7eaeaafb1e0sm5467316a12.3.2024.10.22.12.36.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 12:36:06 -0700 (PDT)
From: Tianling Shen <cnsztl@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Chris Morgan <macromorgan@hotmail.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Andy Yan <andyshrk@163.com>,
	Jagan Teki <jagan@edgeble.ai>,
	Tianling Shen <cnsztl@gmail.com>
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] arm64: dts: rockchip: replace deprecated snps,reset props for NanoPi R3S
Date: Wed, 23 Oct 2024 03:35:27 +0800
Message-ID: <20241022193537.1117919-3-cnsztl@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241022193537.1117919-1-cnsztl@gmail.com>
References: <20241022193537.1117919-1-cnsztl@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace deprecated snps,reset props and move them to the PHY node.

Fixes: 50decd493c83 ("arm64: dts: rockchip: Add FriendlyARM NanoPi R3S board")
Suggested-by: Jonas Karlman <jonas@kwiboo.se>
Signed-off-by: Tianling Shen <cnsztl@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3566-nanopi-r3s.dts | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3566-nanopi-r3s.dts b/arch/arm64/boot/dts/rockchip/rk3566-nanopi-r3s.dts
index 6bc17f755b79..66a00cddda0c 100644
--- a/arch/arm64/boot/dts/rockchip/rk3566-nanopi-r3s.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3566-nanopi-r3s.dts
@@ -149,10 +149,6 @@ &gmac1m0_tx_bus2_level3
 		     &gmac1m0_rx_bus2
 		     &gmac1m0_rgmii_clk_level2
 		     &gmac1m0_rgmii_bus_level3>;
-	snps,reset-gpio = <&gpio4 RK_PC2 GPIO_ACTIVE_LOW>;
-	snps,reset-active-low;
-	/* Reset time is 20ms, 100ms for rtl8211f */
-	snps,reset-delays-us = <0 20000 100000>;
 	status = "okay";
 };
 
@@ -414,6 +410,9 @@ rgmii_phy1: ethernet-phy@1 {
 		interrupts = <RK_PC3 IRQ_TYPE_LEVEL_LOW>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&eth_phy_reset_pin>;
+		reset-assert-us = <20000>;
+		reset-deassert-us = <100000>;
+		reset-gpios = <&gpio4 RK_PC2 GPIO_ACTIVE_LOW>;
 	};
 };
 
-- 
2.47.0


