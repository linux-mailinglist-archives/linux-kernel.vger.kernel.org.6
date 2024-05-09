Return-Path: <linux-kernel+bounces-174573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B65358C10F3
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 16:08:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6C261C22CBB
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 14:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D781416D30F;
	Thu,  9 May 2024 14:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HauHQHsB"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8922815FCF5;
	Thu,  9 May 2024 14:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715263629; cv=none; b=csj3q9jObOUOSWM3nfGZqKDVRHITRx0hBEGJZq2UOzh4KXHdehXkGVHGgJMGmdz7x5+LSaktsxoZK178TG2y8ImcjBhlBuf/nHAPnYVgjVppuaWO6ynmdwX3wfcQb5GV4vM3zgQF6rNf6Pt090sS1vHkbXV/CJ6UW8y2ynZ7+XI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715263629; c=relaxed/simple;
	bh=4iw+1FN3xerg0geYMZmU/8ZVwOpVnO3MzjaALXgnI+A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lyOSgKwA9r7SWHov5YKfX1f1tOavaeRWd5/PMbo5rMGtoEhRRoYzm0xlaRM3qgMUzp3tnkZpLe8uC9xVg/u8itmCyt25mEKcSjOEycGy21X+YQjHn03aVT2LOkjc+ojQftvnsWX+ENZeN5nmd7nocmCLdiBTZQUVUv+mYFhNneU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HauHQHsB; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-34d7b0dac54so538993f8f.0;
        Thu, 09 May 2024 07:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715263626; x=1715868426; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nuIg0rxmudwavGYdewcr3VwDoFHinfP7P23xo/y6UpU=;
        b=HauHQHsBhH2hsobMWO7Sv28uA2N3mi28xF8mMp+e369xwq+ODyUPzr2uKZY+ma4n7k
         u1atdGiFLInoduJaJARJOOaI0vDQi+qxZLP/kEbSCxyFoiQihEPrkOwvzxbKKPfnDAUY
         t3WUHgOb7d/X7O2KoLa/Sgdt8A7QheiSqRaWsNKkbYkfsUKh9Rive4Sz+FZL4TyzHHzS
         laqksPKVJB0R9ldQ21Q+9uLgkQhb6UZaA+VK1RKO67ossVoJjfADjQ/VAHerlB3vmMXl
         Z2u0ikRVfe+G3t6q62AXAN2H+uSYFLZpJonHuHliu2M8vU7GDV1fDFX8xTn9JNlDzBjY
         it/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715263626; x=1715868426;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nuIg0rxmudwavGYdewcr3VwDoFHinfP7P23xo/y6UpU=;
        b=anNgrxNm98KkuqJ+iRq1qC2jndP95NS0YEXxVgy+2i+t2IYMwyffyn/XkeP5yNw2xp
         oTNWPr3RbEPGP8zTBThbZdEuppVqMj1iPXGAh+bLvKCbFI9BvK01jFuit8oasVpfUrN3
         wcczm8xmHYn6xCNldWZkYwVeTTjSbXoHiq+CbuMZyGkttVsy8vikewQlPCQMKi3qEna3
         QhUXg4XB8hMkiTKPWXNEpDk/Gjk9vrMf5ysq0MervdAXg3SLXQcr0EnEi3aOgeUytAl5
         VA6PaBhSMWl1QRk1zY8Idz7Df+38xHZGy3M3XNK3KiBW8fPsEidiUJsUG4CUaZhlH/NK
         fjag==
X-Forwarded-Encrypted: i=1; AJvYcCWL3ThgAI9c05bdkdYA0Z+/2R+GgUaPLN6micCueSeIsGYV0ql/uT+zXROFnVRO7WGaiYXgNW6kD5ZjdYXWLrFqTM5jXe330DKU4D6XEcEzgolWIbLDuzObf3kyDHhrvVDNwAFe0kAj4bduurU7DXdIAsYNKERBhmP4Xvm46HcPSehcVA==
X-Gm-Message-State: AOJu0Yz/hqXhzTH8FvAvKk/I/1yLAZRFuiXWAXD8xo0ROg5pyU1L0Dmy
	TENMheQOf5WS6FCVv2RnNo5QhJFKijqTRatVJRMazIX3y3DYuOE=
X-Google-Smtp-Source: AGHT+IGrYuifyNXu2UQb3DwjWFh9xvmk2vwwMGUSyNdVTWC6BwXLa/x62uQHm8HbCp9cEY6jEZx1eA==
X-Received: by 2002:a5d:5604:0:b0:34a:6fac:6dab with SMTP id ffacd0b85a97d-3501812650emr2546256f8f.12.1715263625950;
        Thu, 09 May 2024 07:07:05 -0700 (PDT)
Received: from U4.lan ([2a02:810b:f40:4600:b44:d8c3:6fa8:c46f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502baad058sm1793311f8f.66.2024.05.09.07.07.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 07:07:05 -0700 (PDT)
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
Subject: [PATCH v3 7/7] ARM: dts: rockchip: Add DSI for RK3128
Date: Thu,  9 May 2024 16:06:53 +0200
Message-ID: <20240509140653.168591-8-knaerzche@gmail.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240509140653.168591-1-knaerzche@gmail.com>
References: <20240509140653.168591-1-knaerzche@gmail.com>
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

changes since v2:
 - dropped ahb clock again

 arch/arm/boot/dts/rockchip/rk3128.dtsi | 36 ++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/arm/boot/dts/rockchip/rk3128.dtsi b/arch/arm/boot/dts/rockchip/rk3128.dtsi
index fbd95bb08cd3..7f2bf3e51082 100644
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
+		clocks = <&cru PCLK_MIPI>;
+		clock-names = "pclk";
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


