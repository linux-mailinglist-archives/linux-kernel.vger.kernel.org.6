Return-Path: <linux-kernel+bounces-530434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A0C3A43364
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 04:09:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9083717B1E1
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 03:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EF321547F3;
	Tue, 25 Feb 2025 03:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YQ/PPfe5"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9791151991;
	Tue, 25 Feb 2025 03:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740452958; cv=none; b=YBvnJbRpsMmd8Bb6vJ7gpiaD/lTfxO/hgeNzFrqRV2qqSpotHus4S4cLIKFFMHazSwy0aYCeUME05dr/w+AIgi3QBgJ0F/ZOrGg+6b4yOEDW3yJIWJ8Pw0IDmBCqH8nbn3xHgWa1h5uRB2N56uHHtd3AbRDBa8fLLCbkH5iijyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740452958; c=relaxed/simple;
	bh=yP4sJVz/+xRLnihlGpoNeTpJ4ncWPc1FCVMuukSKggY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gbYYdJ1Ff+l0kbAlV9RQGJwO3O9SLZZQcyUPwV7gnW9llZ8rAh5aipjbmS8OUSBEc5MbNWgfOmySTy49xXgpioAbnTjAINXv5r7dNfZ5MObUbdmdfX7EDmVOksLctzCRpNIk0fH6tcWt0Y5Dos5V80CzDMKYJiqnRvOqa7rozWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YQ/PPfe5; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-216513f8104so12240885ad.2;
        Mon, 24 Feb 2025 19:09:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740452956; x=1741057756; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=elpjqOmNwpb5zLF3nxKBv/pF+35q6+L3HqlbKg46eQo=;
        b=YQ/PPfe51VcPPY7lYwnuv2eEIT/EfBTBFYyihLnQuN0J9y3Yn66veQa/xbK8MwoGqF
         nnVuBmtnHsdbJLynsyoUpYgM+cY0G1wp3X1T0Vuv329emLfVLoqhdYbVApd6cICEsJDg
         okEsKCcyU9A98cXJvzTBBixobq+22Sg46ku5tvmJAKsvKxtElio8g1kBu7H91/6jReea
         AxVC/9qlBj5KYR6K0U3z5g/K3xQnuf40P356y4eZqyaKTunyk6GO+7W1Du19NzFbO9Qn
         yJqLB3HyZge7WpL3k8ilDce+hO5oDGc5sjahq/ET7/x8JFAc2lLK6Q2Hm+q1f3e9lv7o
         yezA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740452956; x=1741057756;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=elpjqOmNwpb5zLF3nxKBv/pF+35q6+L3HqlbKg46eQo=;
        b=l/hzA8IvtfZl88mk2PnhcVGlErsICkYdK/bqjAK/8NEp989K4b/BTkV2QGi/VkwdZr
         2gx+fYm4FXo0CvdbRjZ+vrV5kqEOL8cdqmNmvEgMPz/BucjVvLUURFBTr7DvNtH5WGs/
         J3rojTw6vgBR5qAZoYuLmtY3dId674LKGgNfSRcVNsWzNjfr7tMk/SLpjbq+vMFSHUdO
         B/t6xOAGUpHy0tQJvjJNNxksidYU2lEB2IVZen6G4X03t3/He39Hv9uOifQ3qLYSW1fs
         jX6fp5JlMD1n87wKHf0F/QGCQqKVwqxQNccaFljW60v3OTrulFjULULgTmwoyf7td9jf
         NphQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6NiDDTgCBgO0aJqkP/e9Lid1QcwrSSB2JTFQyuJvGv9vA33upCSOqw75/qQ68+UQbS+mQP09Qs7GY@vger.kernel.org, AJvYcCXffWqzLFv/AdHUqNycgryrJXKBUPjNnjAjoxZ8/FZAtP15c71MUW/whKAWV/YfUMSLFJEcRT/C4ZnB+kio@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8O/5Lk/PVHkQKu13UbElvnebgP74Ox5PU08Xi+39AjaXMbX/D
	RybAsMuNT5UMQMMRRrecyYz6UiNs09rhO3BpkHsijzGtC1xqXYqM
X-Gm-Gg: ASbGncud9ghE9F5m8B2gCiRgVIO60BbTzTUcjEzl9MgDOWPIXXV5S8qKg/NlQ12zACm
	H3P2OthskheeMc8pKi9fy0fdrLpVpCjoId8dZGAtza8TzpCXipzbPCBZ+jz7BHholCQdQbv3Yyo
	fViTCezPRORNmSTJJAsCEZfQVJc65lO8HE3R6SWbGisRe26aNR/24x+pWT8JuucquLRdiY60elk
	8zvE0hA5oVRAVkQ8IxbDycK/ntQEgqzxWL+cUHlJnsa2/8v5Iae9FIpqnUBkGEzIeC/HydZWJEH
	g/4QThZvgC/jS8/MjkhDyTs+SeMCtOk=
X-Google-Smtp-Source: AGHT+IFDe2Sgq26vK2EiPZfc+NSBNuzC6A0u7dIPc3aRtjWh21i36Ss1MdvlgxEx1VMTHu4uwTgcIQ==
X-Received: by 2002:a17:903:1c5:b0:220:bf1c:35da with SMTP id d9443c01a7336-2219ff72473mr96063675ad.7.1740452956032;
        Mon, 24 Feb 2025 19:09:16 -0800 (PST)
Received: from rock-5b.. ([221.220.131.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2230a0aea5fsm3405505ad.224.2025.02.24.19.09.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 19:09:15 -0800 (PST)
From: Jianfeng Liu <liujianfeng1994@gmail.com>
To: linux-rockchip@lists.infradead.org
Cc: Piotr Oniszczuk <piotr.oniszczuk@gmail.com>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Jianfeng Liu <liujianfeng1994@gmail.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] arm64: dts: rockchip: add hdmi1 support to ROCK 5 ITX
Date: Tue, 25 Feb 2025 11:08:48 +0800
Message-ID: <20250225030904.2813023-1-liujianfeng1994@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable the HDMI port next to ethernet port.

Signed-off-by: Jianfeng Liu <liujianfeng1994@gmail.com>
---

Changes in v2:
- Remove wrong port &hdptxphy_hdmi0
- Link to v1: https://lore.kernel.org/all/20250215152550.3975614-1-liujianfeng1994@gmail.com/

 .../boot/dts/rockchip/rk3588-rock-5-itx.dts   | 49 +++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-rock-5-itx.dts b/arch/arm64/boot/dts/rockchip/rk3588-rock-5-itx.dts
index 6d68f70284e4..891c8afff160 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-rock-5-itx.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588-rock-5-itx.dts
@@ -11,6 +11,7 @@
 #include <dt-bindings/leds/common.h>
 #include <dt-bindings/pinctrl/rockchip.h>
 #include <dt-bindings/pwm/pwm.h>
+#include <dt-bindings/soc/rockchip,vop2.h>
 #include "dt-bindings/usb/pd.h"
 #include "rk3588.dtsi"
 
@@ -89,6 +90,17 @@ fan0: pwm-fan {
 		pwms = <&pwm14 0 10000 0>;
 	};
 
+	hdmi1-con {
+		compatible = "hdmi-connector";
+		type = "a";
+
+		port {
+			hdmi1_con_in: endpoint {
+				remote-endpoint = <&hdmi1_out_con>;
+			};
+		};
+	};
+
 	/* M.2 E-KEY */
 	sdio_pwrseq: sdio-pwrseq {
 		compatible = "mmc-pwrseq-simple";
@@ -261,6 +273,28 @@ &gpu {
 	status = "okay";
 };
 
+&hdmi1 {
+	pinctrl-0 = <&hdmim0_tx1_cec &hdmim0_tx1_hpd
+		     &hdmim1_tx1_scl &hdmim1_tx1_sda>;
+	status = "okay";
+};
+
+&hdmi1_in {
+	hdmi1_in_vp1: endpoint {
+		remote-endpoint = <&vp1_out_hdmi1>;
+	};
+};
+
+&hdmi1_out {
+	hdmi1_out_con: endpoint {
+		remote-endpoint = <&hdmi1_con_in>;
+	};
+};
+
+&hdptxphy1 {
+	status = "okay";
+};
+
 &i2c0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&i2c0m2_xfer>;
@@ -1209,3 +1243,18 @@ &usbdp_phy1 {
 	rockchip,dp-lane-mux = <2 3>;
 	status = "okay";
 };
+
+&vop {
+	status = "okay";
+};
+
+&vop_mmu {
+	status = "okay";
+};
+
+&vp1 {
+	vp1_out_hdmi1: endpoint@ROCKCHIP_VOP2_EP_HDMI1 {
+		reg = <ROCKCHIP_VOP2_EP_HDMI1>;
+		remote-endpoint = <&hdmi1_in_vp1>;
+	};
+};
-- 
2.43.0


