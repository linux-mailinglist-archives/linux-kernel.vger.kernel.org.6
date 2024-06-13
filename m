Return-Path: <linux-kernel+bounces-213202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CC409070C9
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 14:31:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9576B1C23AA3
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 12:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FE4956458;
	Thu, 13 Jun 2024 12:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KgA/HfKa"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813581EB25;
	Thu, 13 Jun 2024 12:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718281844; cv=none; b=V/xpCQYX3lkQKNt0mJnR2sIz4Iz1iml2iVTd4iQLFI/Aafm2XM3wfaRJbnrDoQ34kblPidGyNm0pH8KEiUwqnfJ1Q0AnBG7v0UiB6N6zExNZpf8MNVWdr59ggLcACovg7hSpP1Ki/nvQ/lsSy1bsrNQHSstD682BViSM3s/MafE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718281844; c=relaxed/simple;
	bh=70tSjkjNI+K1v1AOs1BGoWPIvIYLL+9JPSNGFWBBkTg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kxwVGcC2ZZDJFQmRN/yeei2lTlMIv96oAYrhP4Q6F+qh1p/pW+BsKieIo+f5yyLQWaoPy98v5Xz8lX+Mwp5FE9h1WW5AU9yyWHLYvJxHjAjaZiHWVGdmAk/LIFIU5BC6dV42Jot5pteOpTQMABwKe0QwzGA9v2dQLmhP31pKnCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KgA/HfKa; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-705c1220a52so928431b3a.1;
        Thu, 13 Jun 2024 05:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718281843; x=1718886643; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dyhnGzVIyoi/gHkvqNPaXXARC68ta1GMz1dJjxYfDu8=;
        b=KgA/HfKawdacgGg2OYgCW33vRECDUgCp5Tcwczp5alXV09URnHPOagp6GyBwn5WOHT
         t19zXDzWDmZvIhgbyEQ8el59+oaIJN4Yj21yEpwSJfI+9bHxw7wKn1x2GKvb42Imnq43
         mqRMdsHG8UpG+TluQdKG9AGoZK1YpZFQiuPGtb6RvpMiNfk81AkkMujcokwWTFh6QRzO
         xpOD1Fkne/sV9Q1327fdM+8FXcghwOIUmCONA5yJOwPylXL7dd7klbV9gavsBF31dSiw
         Jt+IjCORNOabHS8XhDivXqe25IsxN5ASvrycceCA646Oqd9Q3Pu+Z3ByCTnc+Ve8y7hk
         krqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718281843; x=1718886643;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dyhnGzVIyoi/gHkvqNPaXXARC68ta1GMz1dJjxYfDu8=;
        b=WGuof9IxHGMnS6OZ4V8GJ0t9//omI8dFJ35M1fqTfVxj46n82L08/kKV7/N01DDVXR
         tdt4gABWjYOQ72FYMJMEwls2QzxsSXbaAaTjAGQuZkLZVpG0PY7gae6Bvlsd8sOjYgdY
         WXnrcueu/fmQsY8moT8wz3TMzhd33kLceYK+s/o4aSlj7JdWWhzG7eVMzusjKSbAk1Xy
         Wtm2CZDcjqpiEjMaKODTfdqNgDiKIWWaGJkv6a7EU3Qqu+6eLX+gyFsJWjUbdxjY9erG
         5gs1GNhX3fflFy0pBYjT521Rwde2rRIr6Zw+paxpk8lNKbIJ3t67fz9YU+VFdNACYo7c
         KPWg==
X-Forwarded-Encrypted: i=1; AJvYcCUL++lCbub/tghFOEfcOGMwdIgYzBMC66ygl3dBNTQRKjmzDaNcwYUewkr8rTGuCf7dpUI6BqyzEak2R7xuI/IcorNsbqwqW+VXJig98Jm9lxusDHEA5ssfwzmTpN8t4WINgm6V9ifcdQ==
X-Gm-Message-State: AOJu0YwboJFGbnuQoi3/gkylO6JeNmXHiuUW/nbIaHLFT1kfOfKkdCol
	iTSze8hBzp+Zxc5L8igbxa/FqcUfZfzMXWoLewN/9bQqoYLCKPag
X-Google-Smtp-Source: AGHT+IG6Z9yGmBryZSy9wuMGay0o8aAhEaBmtbG5TCCILeJYBrSp7Dsjp60aC/QXOhsntZ/hKwlaQA==
X-Received: by 2002:a05:6a20:2444:b0:1b8:a2ca:3b6d with SMTP id adf61e73a8af0-1b8a9c08c68mr5240212637.37.1718281842629;
        Thu, 13 Jun 2024 05:30:42 -0700 (PDT)
Received: from localhost.localdomain ([113.30.217.222])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6fedf59299fsm875459a12.55.2024.06.13.05.30.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 05:30:42 -0700 (PDT)
From: Anand Moon <linux.amoon@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: Anand Moon <linux.amoon@gmail.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 2/2] arm64: dts: amlogic: Used onboard usb hub reset on odroid n2
Date: Thu, 13 Jun 2024 18:00:15 +0530
Message-ID: <20240613123020.43500-2-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240613123020.43500-1-linux.amoon@gmail.com>
References: <20240613123020.43500-1-linux.amoon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Odroid n2/n2+ previously use gpio-hog to reset the usb hub,
switch to used on-board usb hub reset to enable the usb hub
and enable power to hub.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
v7:none
V6:none
V5:none
V4:none
V3:none
V2:none
V1:none
---
 .../dts/amlogic/meson-g12b-odroid-n2.dtsi     | 36 ++++++++++++-------
 1 file changed, 24 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dtsi
index d80dd9a3da31..86eb81112232 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dtsi
@@ -31,6 +31,30 @@ hub_5v: regulator-hub-5v {
 		enable-active-high;
 	};
 
+	/* USB hub supports both USB 2.0 and USB 3.0 root hub */
+	usb-hub {
+		dr_mode = "host";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		/* 2.0 hub on port 1 */
+		hub_2_0: hub@1 {
+			compatible = "usb5e3,610";
+			reg = <1>;
+			peer-hub = <&hub_3_0>;
+			vdd-supply = <&usb_pwr_en>;
+		};
+
+		/* 3.0 hub on port 4 */
+		hub_3_0: hub@2 {
+			compatible = "usb5e3,620";
+			reg = <2>;
+			peer-hub = <&hub_2_0>;
+			reset-gpios = <&gpio GPIOH_4 GPIO_ACTIVE_LOW>;
+			vdd-supply = <&vcc_5v>;
+		};
+	};
+
 	sound {
 		compatible = "amlogic,axg-sound-card";
 		model = "ODROID-N2";
@@ -234,18 +258,6 @@ &gpio {
 		"PIN_3",  /* GPIOX_17 */
 		"PIN_5",  /* GPIOX_18 */
 		"PIN_36"; /* GPIOX_19 */
-	/*
-	 * WARNING: The USB Hub on the Odroid-N2 needs a reset signal
-	 * to be turned high in order to be detected by the USB Controller
-	 * This signal should be handled by a USB specific power sequence
-	 * in order to reset the Hub when USB bus is powered down.
-	 */
-	usb-hub-hog {
-		gpio-hog;
-		gpios = <GPIOH_4 GPIO_ACTIVE_HIGH>;
-		output-high;
-		line-name = "usb-hub-reset";
-	};
 };
 
 &i2c3 {
-- 
2.44.0


