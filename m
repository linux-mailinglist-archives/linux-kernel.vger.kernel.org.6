Return-Path: <linux-kernel+bounces-174475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46F9B8C0F51
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 14:09:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 786C81C20D7A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 12:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C99015B112;
	Thu,  9 May 2024 12:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vfx1n+xh"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B333A14F9F0;
	Thu,  9 May 2024 12:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715256451; cv=none; b=FHJbZHOrsGCR6wrY34d/rqHBktN18dgNnARPvi+BH1TQjGKJphBDWvOeN2RJvNEhjxE8AK16YMESStL0RO1/jp6XM9r2at6scns7sMIKWdFtLXkjR+DanPHUhI9VG2wDEVnLeVUZxAdSZBADKYHxEm11bcJgK2ITCeCb8C+dnZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715256451; c=relaxed/simple;
	bh=OMYougl15MAk8VEqu84prRIZcizHMoHAQECI65nhgI8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FZDN+g9L6Jert/h0iJQY9e8Jm+LLzjWaPHRzbBMnKHPgkqv5XCg+Fhf0CjvARBvkR7QkATSOCD9zkdEHO0/RvRS14RgsRmJKadvF5QJgN/hlxIHTPAYaTxVS5Btx/XRGd1QkABqg3JrndlhS8dOi9MJPOSzXvUADwSi956bz6QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vfx1n+xh; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2e242b1dfd6so9924061fa.0;
        Thu, 09 May 2024 05:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715256448; x=1715861248; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UJEaWHpHfTjOx8txJp83KCReKfr+CJyqA30JyxkgRQs=;
        b=Vfx1n+xh8Afh/RfQz7q9LjwROrJFCQlFuw9De2N15r+bGfwioufMJiNWb0s9fkutxx
         UYGWLbk/tr9HwlqhdGwrt58IR5SeJ4MlPN6HzoO5rsmjMKUBnJMCLm+g2qXFGyPJ+x97
         u/J5Q9o9Qvmao5ceuw+GnHVBMaVAH1IeeKmCJE7hFqGKGy0Je2gFtzJIwVpL5GP1t29u
         BQnOg8gYSqXcQLk8xKnmn4yifzV5VWZrtTkff/BfiNsTM+GWmQrN7FfySvyys6RTVe6M
         tin3wayc24hXE9L7ULbiI8cjvwcbVPK8xecQCH6ovtBUXx0MdHXRgWgFYUWsLgpU0V4I
         /cPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715256448; x=1715861248;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UJEaWHpHfTjOx8txJp83KCReKfr+CJyqA30JyxkgRQs=;
        b=RkHtU6SHf+lEOLIkXUCSueNc5rthMEsDCORxzxha39Of7WA4U3UaG72MtUEXUTfuUZ
         IIwAmuwA/aOfIIZ/yTJv1XcphLFrqDBQgI3kCHGSySc0k9uFaV47K9Gm8exNcBtN1qVZ
         aBexij7bB4ROBYAN8DdEEsllhwdwHqliQAc8L4B9LJ3MQQWg4j4i5YiAciIXw/t9Z0Fq
         JVUvwbwODJ2JztaZPWcpgU1ny4gAeQflRHW05cvYadz26InRDt3mbYposgb8Rcm3g+DR
         mPPIcBFUu9aQWmMSJy9rDHTbyhYUSykD7zv6klAFK3669Hi0dVjnvMVO4R5QEUBH7Y9H
         mi7g==
X-Forwarded-Encrypted: i=1; AJvYcCWuPX/fPek5DmaqqT9qgkgk/+eN8tCvvm6OEodwrgtpKMHsvDVt9RSfbK+v/13eTrbNSX3Q+VZzwZU6/v0oFek1bG1zDctIT+FlRTC25oWjnkLdMZaHDCiJtUDy2+h68cjxHFO0YDc9qnlTCX6e0uEKvbaK7t9fXQ2PgSl+wRRHg5gXfQ==
X-Gm-Message-State: AOJu0YxyLt1Y/Cug9eNA3araRO/abk8+bbg80zYgvrZ7xd5gLDf8HWZ4
	5iuTZ/KHZlNhurnd+DIL071CTnynU4D36EKJeQ1lB2+C9+yPREk=
X-Google-Smtp-Source: AGHT+IEOGVpnlxc4D9Jfg4bzT5yUTxC5Nb1l7o9iKNsaxhKiAZ+w5GYZsS4D630ujkwBJ9hHrRUsqA==
X-Received: by 2002:a2e:4602:0:b0:2e0:3132:94d4 with SMTP id 38308e7fff4ca-2e446f7c72amr28137541fa.16.1715256447777;
        Thu, 09 May 2024 05:07:27 -0700 (PDT)
Received: from U4.lan ([2a02:810b:f40:4600:b44:d8c3:6fa8:c46f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41fccce1912sm24112005e9.11.2024.05.09.05.07.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 05:07:27 -0700 (PDT)
From: Alex Bee <knaerzche@gmail.com>
To: Sandy Huang <hjc@rock-chips.com>,
	=?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
	Andy Yan <andy.yan@rock-chips.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	Alex Bee <knaerzche@gmail.com>
Subject: [PATCH v2 7/7] ARM: dts: rockchip: Add DSI for RK3128
Date: Thu,  9 May 2024 14:07:15 +0200
Message-ID: <20240509120715.86694-8-knaerzche@gmail.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240509120715.86694-1-knaerzche@gmail.com>
References: <20240509120715.86694-1-knaerzche@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the Designware MIPI DSI controller and it's port nodes.

Signed-off-by: Alex Bee <knaerzche@gmail.com>
---
changes since v1:
 - added HCLK_VIO_H2P as ahb clock

 arch/arm/boot/dts/rockchip/rk3128.dtsi | 36 ++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/arm/boot/dts/rockchip/rk3128.dtsi b/arch/arm/boot/dts/rockchip/rk3128.dtsi
index fbd95bb08cd3..1ed4436549ee 100644
--- a/arch/arm/boot/dts/rockchip/rk3128.dtsi
+++ b/arch/arm/boot/dts/rockchip/rk3128.dtsi
@@ -277,6 +277,42 @@ vop_out_hdmi: endpoint@0 {
 				reg = <0>;
 				remote-endpoint = <&hdmi_in_vop>;
 			};
+
+			vop_out_dsi: endpoint@1 {
+				reg = <1>;
+				remote-endpoint = <&dsi_in_vop>;
+			};
+		};
+	};
+
+	dsi: dsi@10110000 {
+		compatible = "rockchip,rk3128-mipi-dsi", "snps,dw-mipi-dsi";
+		reg = <0x10110000 0x4000>;
+		interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru PCLK_MIPI>, <&cru HCLK_VIO_H2P>;
+		clock-names = "pclk", "ahb";
+		phys = <&dphy>;
+		phy-names = "dphy";
+		resets = <&cru SRST_VIO_MIPI_DSI>;
+		reset-names = "apb";
+		rockchip,grf = <&grf>;
+		power-domains = <&power RK3128_PD_VIO>;
+		status = "disabled";
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			dsi_in: port@0 {
+				reg = <0>;
+				dsi_in_vop: endpoint {
+					remote-endpoint = <&vop_out_dsi>;
+				};
+			};
+
+			dsi_out: port@1 {
+				reg = <1>;
+			};
 		};
 	};
 
-- 
2.43.2


