Return-Path: <linux-kernel+bounces-224516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C08C912377
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 13:26:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB4871F26341
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 11:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2373B17B438;
	Fri, 21 Jun 2024 11:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="JAa7eP8N"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEDF717A93A
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 11:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718969022; cv=none; b=YlovrrIynPSaXdErxYjDP7jkxdtO4T1BLBy2U9gCBSx3yDRUBJYBsXa4PLiuPs0+94o9hsDs7suuE+iInwbnQ14JIjbZi/FWnkCT9PA8wShBOxTX5HiDc7SbRjgGqYTgLQvNAu/4DnNO0r42cY8Q1VRNT0htIAhvCzouXSVbAdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718969022; c=relaxed/simple;
	bh=JYgANfGK0OX8coSzjyoca5b835OY0thvAp8k5tv/WVM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jwDd6PKOQ0A4PoCGGsExw+woEeYTEuigc12b0VKYHH0+JvgwX17PuClX5gv/zT4l5cMgfZRRaYSfmS/+1oOruO0neA/Vq5e4fZgovjvsg6Heg04eoxIoAahMFvcn85EqLxA9Cj51SK235E0HYsU/2UqcM4jzaJTdqwUC+UvkzZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=JAa7eP8N; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a6f13dddf7eso233568066b.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 04:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1718969019; x=1719573819; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ebUuaMvHVQnkndloXfGsR/owtWP+gpjE1NoWoH3dplE=;
        b=JAa7eP8NR3gPlIWuXDitYo/A9n1uSnBAtziN6wps1x1rrVVjUtYJ0ujtn55MkhJ/Tb
         ORWKkmkyukeN5BgoHQ5halpq6Fa+aWnKNioEF/R6sXt83DKoofB5jCtNeOZ9quJWNM9G
         As9zlAO51VCsfZc9q19X3oTw/5XCX9jUBEqNAmbj72DNuQAydzc4n2etJMySMJ1VRytY
         X4OXV6p2A2P7vnMUvuYj1htW5lrsgCPsqE22vEb9P/PtsBoHy9VkSoRGfG6cao17wtXo
         r0BEnujtQC2IP6shoU2xugkAXIHtlWEDUcvmOvaa/IaH8hLQngx1AEMhoFyDxNRKT+N6
         QRJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718969019; x=1719573819;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ebUuaMvHVQnkndloXfGsR/owtWP+gpjE1NoWoH3dplE=;
        b=wnYL8Wdbbe4HKM/WuwYkLCWUgJ8LZA8r/KIMw/6QrIyFKkZvRzfGye6t1pOXuUwJ+N
         DCkV3bKqjIdv+6gKx8B29+wvfqR1PMZ+j+EcE9clBCJV6j1aLAkj1G+ITCRBaonC9dGH
         JEn/H6zW14E560YHNzVTgsgs0RwtZTrmi1+gRGxboh1s3uJ5oWPOz2IZiWighXFl7xD6
         pEWr6GiyM64p4V6R/vvQFV+fK00eXA7T4gdFdX87jibylvf+p+qxVhzl/6l7Xef4b8io
         5nuEpV6CR66menLtPA1RT34lNq1iqrh8IbiCZwXUTu6CE9xAgxA2lo1NzQ4oPIiTm0EB
         A8yw==
X-Forwarded-Encrypted: i=1; AJvYcCW+srlafaoCsvAUbxP0Q8jj7UzfQe8qY4KbAvyy8sDXys3laSucho+DQevhR6/ml0DV5d4GICG3QZCe7qN+bRQGAfRtVL03r9eozTP3
X-Gm-Message-State: AOJu0Yz/wg2Fyj75COm4I8169jMMPpyinGLLkWRU0SWCxRJL2Rg8lCMm
	6QaleiuViNKtfrln1GM3zdMIoHLJ/5JGZd9tP/0z/LnwrFzNL8ntkQBrTTONpJ0=
X-Google-Smtp-Source: AGHT+IGZv8gS1+I6ldBjfQ4fdMF7NlgFickAepkyUrui9xQnT8bZE+QnGQ4UWGjz1h6JNkW6Y5A7vw==
X-Received: by 2002:a17:907:a587:b0:a6f:bf0f:4209 with SMTP id a640c23a62f3a-a6fbf0f42f2mr378145566b.42.1718969019378;
        Fri, 21 Jun 2024 04:23:39 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.70])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6fd0838345sm64498466b.99.2024.06.21.04.23.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 04:23:39 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: chris.brandt@renesas.com,
	andi.shyti@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	geert+renesas@glider.be,
	magnus.damm@gmail.com,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	p.zabel@pengutronix.de,
	wsa+renesas@sang-engineering.com
Cc: linux-renesas-soc@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	claudiu.beznea@tuxon.dev,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH 11/12] arm64: dts: renesas: rzg3s-smarc: Enable i2c0 node
Date: Fri, 21 Jun 2024 14:23:02 +0300
Message-Id: <20240621112303.1607621-12-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240621112303.1607621-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240621112303.1607621-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Enable i2c0 node.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi b/arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi
index deb2ad37bb2e..7945d44e6ee1 100644
--- a/arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi
@@ -11,6 +11,7 @@
 
 / {
 	aliases {
+		i2c0 = &i2c0;
 		serial0 = &scif0;
 		mmc1 = &sdhi1;
 	};
@@ -66,6 +67,12 @@ vccq_sdhi1: regulator-vccq-sdhi1 {
 	};
 };
 
+&i2c0 {
+	status = "okay";
+
+	clock-frequency = <1000000>;
+};
+
 &pinctrl {
 	key-1-gpio-hog {
 		gpio-hog;
-- 
2.39.2


