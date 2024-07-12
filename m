Return-Path: <linux-kernel+bounces-250937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9718092FEC6
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 18:47:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7F8F1C22A99
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 16:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE681176FD3;
	Fri, 12 Jul 2024 16:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e3OUO5r0"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC348176FBD;
	Fri, 12 Jul 2024 16:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720802805; cv=none; b=aNAbk2k9nUHqkK+gHaNBcmNJ2f44VUgKvVYaz0lMqJxOC1tIq/ey8Z5T/9wwIfG5bbaABkaASD5eEfj8Xo0pwMUafGHJFh8CXTjcT8LkygbBo7y3oZNB8nOAdCbEOjI7tRYNcnzytfJpruEWCtNLEz5HoLpsHFHdkYXjYKZpFeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720802805; c=relaxed/simple;
	bh=+iFQKorBsIJjX+acq5sKUHPsW58xI62ho3MzPpqpywM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GR95QQmdykgSYrx/ymbIC2Wabdv6Rz7LYAGW8oliCDhrREW5EhiONK3eZiY/SsHbv5BmEQ4GmJRjMfI4DTRpyza0x8G7gkLXFmTa2vf1OfEBdEn3u1faVAS72m2xMP13gTpH+p/bphlLZrE8/V7a7GlKTRXD3kHW2aY29uRr//U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e3OUO5r0; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-75ee39f1ffbso1516225a12.2;
        Fri, 12 Jul 2024 09:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720802803; x=1721407603; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R0p6c631FLQWoVkBf59WViemKYmG2YbdNp5MW1ulJ3U=;
        b=e3OUO5r0KhwCZ9okAEhB8U8tg5/dVpN4iJRIrLCMY0PaRchQ+da9fYVLZhJNsO4W7I
         uaAsYt35sCivm2zNHD9HdmHLDPNogWOQJ+hM8bismfatysdoWZfbYRXpq6HCBGUCXOLE
         D+h0qoJyXCm1nntRBALQ7jVoO2RwV/iHFDklvGl+V8EuG6foybDuu0Cg9aQlvXsRfgBJ
         3nSPEaeG56Q6KGJu0pYESzkoXzFyNF0/ckRGi71P1YRGysLaAvO+89pwMwV3E66h2nUh
         jKT+cwHaLSTBrQGeeRZuRaxP3bU0k4D+gAY2IS4OhXxXBfiq/edzrZxI28wcKpRVgp/4
         AamA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720802803; x=1721407603;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R0p6c631FLQWoVkBf59WViemKYmG2YbdNp5MW1ulJ3U=;
        b=GXh+53fHaWBJyVbzGoc8P/Rbz6QDR7WMOwVYnSYbKdYHo4LiVCQKC0jlm3ioOwL6r0
         CVrMje3Yvhj2sdx1yVjQr5iNwBY7lc849sUTgjnYmR6QMD1IqTqatLfWH7fhJmph42LN
         XP58Y741Ke9GShQ0XfB9UztmMdgYJXwOx0yhu9MRcWY/xBh2ceIBSI1hMVccx9EqTUy4
         waDkumlRRvTYN1gFIKnFE03//f6rp8iFSzuNKrD7jpetzOYjAE6wr7RVw5cQ1F9geYw2
         E7i0hm8LEl9uHynM/lfh8OvFPEyRbh/LJ2rgmNE7NtoEsNDSxnOUxAcnOnBtA2qCU3yH
         8qhA==
X-Forwarded-Encrypted: i=1; AJvYcCXayov8+qXR6ENu8SxG9pIzv+qc+whRSR8ah22lDc1/d8sI9eMSkocC81xs6683kHMDqZgN4Mh/QQYW4Md7Mi1N0E8EHzhO0N9045+GGsINrYCnDXVgMbvaz+fdntSCHeDLqT9CioiXhQ==
X-Gm-Message-State: AOJu0YzEreaXYdsXByNAtLVnwrx+sJpe66N+v+zcnJ3D1A1VMxhkL80y
	4HK75KXLoWe+v5tT6d+2fP37H6XUmNvtiLkvogmX5Hk7kIFvFRU8
X-Google-Smtp-Source: AGHT+IFDNxRREJPmJRLCYo6XCextG0QrJvySxgtmRlqYBjRTxLmp/vQCGH+/Vxt91Db5JSs0j42PXQ==
X-Received: by 2002:a05:6a21:999d:b0:1c2:a0b2:e69 with SMTP id adf61e73a8af0-1c2a0b2110bmr12269918637.33.1720802802998;
        Fri, 12 Jul 2024 09:46:42 -0700 (PDT)
Received: from localhost.localdomain ([113.30.217.222])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cacd65a663sm1765436a91.40.2024.07.12.09.46.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 09:46:42 -0700 (PDT)
From: Anand Moon <linux.amoon@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>
Cc: Anand Moon <linux.amoon@gmail.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH-next v3 2/3] arm64: dts: rockchip: Add missing pinctrl for PCIe30x1 node
Date: Fri, 12 Jul 2024 22:15:50 +0530
Message-ID: <20240712164554.1763-2-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240712164554.1763-1-linux.amoon@gmail.com>
References: <20240712164554.1763-1-linux.amoon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add missing pinctrl settings for PCIe 3.0 x1 clock request and wake
signals. Each component of PCIe communication have the following control
signals: PERST, WAKE, CLKREQ, and REFCLK. These signals work to generate
high-speed signals and communicate with other PCIe devices.
Used by root complex to endpoint depending on the power state.

PERST is referred to as a fundamental reset. PERST should be held low
until all the power rails in the system and the reference clock are stable.
A transition from low to high in this signal usually indicates the
beginning of link initialization.

WAKE signal is an active-low signal that is used to return the PCIe
interface to an active state when in a low-power state.

CLKREQ signal is also an active-low signal and is used to request the
reference clock.

Rename node from 'pcie2' to 'pcie30x1' to align with schematic
nomenclature.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 .../arm64/boot/dts/rockchip/rk3588-rock-5b.dts | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
index 721e87a3a464..c5ac233264fc 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
@@ -318,7 +318,7 @@ map2 {
 
 &pcie2x1l0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&pcie2_0_rst>;
+	pinctrl-0 = <&pcie30x1_pins>;
 	reset-gpios = <&gpio4 RK_PA5 GPIO_ACTIVE_HIGH>;
 	vpcie3v3-supply = <&vcc3v3_pcie2x1l0>;
 	status = "okay";
@@ -364,16 +364,24 @@ hp_detect: hp-detect {
 	};
 
 	pcie2 {
-		pcie2_0_rst: pcie2-0-rst {
-			rockchip,pins = <4 RK_PA5 RK_FUNC_GPIO &pcfg_pull_none>;
+		pcie2_2_rst: pcie2-2-rst {
+			rockchip,pins = <3 RK_PB0 RK_FUNC_GPIO &pcfg_pull_none>;
 		};
+	};
 
+	pcie30x1 {
 		pcie2_0_vcc3v3_en: pcie2-0-vcc-en {
 			rockchip,pins = <1 RK_PD2 RK_FUNC_GPIO &pcfg_pull_none>;
 		};
 
-		pcie2_2_rst: pcie2-2-rst {
-			rockchip,pins = <3 RK_PB0 RK_FUNC_GPIO &pcfg_pull_none>;
+		pcie30x1_pins: pcie30x1-pins {
+			rockchip,pins =
+				/* PCIE30x1_0_CLKREQn_M1_L */
+				<4 RK_PA3 4 &pcfg_pull_down>,
+				/* PCIE30x1_0_PERSTn_M1_L */
+				<4 RK_PA5 RK_FUNC_GPIO &pcfg_pull_down>,
+				/* PCIE30x1_0_WAKEn_M1_L */
+				<4 RK_PA4 4 &pcfg_pull_down>;
 		};
 	};
 
-- 
2.44.0


