Return-Path: <linux-kernel+bounces-401408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FB729C19E8
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 11:06:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80F1A1C2106D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 10:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB7441E3DC8;
	Fri,  8 Nov 2024 10:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="WdeJYyzM"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48B71E3DC3
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 10:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731060340; cv=none; b=uKxdBZcNxmMGumwMFwx5/CMWFcpwe/eEV8OOwlIQej7bTrTlXY8v3QUL2uXbX76QW27BaftcgOnbWgYwGzvsxYZgsTpCy/K4YaGZeWZpinkowvg2INNXGe00cSZWDIyGlH+OqlK0UdqQWMT3as5chv2ybfcDGxpGnWCShHZp33U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731060340; c=relaxed/simple;
	bh=aVeWIhV+EQgINF/dzLhLAY+zJ+kL2qc72LUlFGQF1ow=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CfK+gWehQCsNAAXinQOnjFhr2aNxgeTGSCaRBp7B+pu8ESAVGZ2A5iFItcfk1lGFq6zCLE74fTaxyIig7vIjFlJhD41QV0NSRLxLQFs8KAIKiKh1Hld/OAjSduFV7AA7cqX82XlRprONSyXOHJPADl869Ynwl1Z+ptQEXeo0mJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=WdeJYyzM; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5cb615671acso1259815a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 02:05:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1731060336; x=1731665136; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6cwCXjU0n2G3z+UZFHjOKDveE8Cms1D3rG5Gj4FG1Ng=;
        b=WdeJYyzMfDHB3RNFOPzCwN0kvYWctAD+e+egwAkKdcVoQGp4bGaclcKgF6LmRXvL6x
         2I4H6IcFsg/sWrEYRy3PyoGTOIzIZIW2pXiR9+iTt5r0pGfst+mH0Pzd8XEmgfXZJpR7
         vJvMRX5Hi4+eKVYmIkUCoXNs1MvFSPCA8rwQfKjx33yZBKfYYyHI2ONsEslk4qyfdx16
         n8Xa21JN15Z8NpWpByR0EemOy6eVAe5iLaQU2XSTR9xy7XK0G0StM8+VeWxIsvfI3WOZ
         HXq1yNhagdZL4GUmzVBgFXApLdJBgmoYuHirp80o0sS4pSIF71fAamV8ibGx25PL4J0m
         iCXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731060336; x=1731665136;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6cwCXjU0n2G3z+UZFHjOKDveE8Cms1D3rG5Gj4FG1Ng=;
        b=TnPq7r/JT05sUMGsnDT88wHBZrEzTfapZ/AZDra5aUj9/9RO1+sxwSRy8ds+rpHrgE
         HadvG3BDpoXLRNV6HRhm59FWFvJtuiLQjfCzExAmgAhMX7DYopkDvMc2TFD49WyEM/Bb
         4O59uPxqXIFmRWC4T5gwntOK27AgSCZGDSkmYmj8M+ubAgJ9gmL3mcqsvEDAuZTXJziJ
         LxXwS46Xm6QHGpk8K/44KWh8CB4RzpxJ50xraE1P8spIyB1tZ6hSXEg7bwi5nULOoHW8
         1uSeRf5VSx8Qs7h5iPLOCzl35lGhZuzTToMBxAJvFCV6WLH/Njf0U/YWn/skbq+nx8ZW
         CQfQ==
X-Forwarded-Encrypted: i=1; AJvYcCWO3RwTshRTLSJu6G+L7TfaQOYfFpC3yZBZPUcwzlk0kVGtTm3CwFjCW5aFOcjt4qJFqtB44Gq+OqBBxA8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyRw2fRrgxne36zX7LNeW+USbkiGtaCIW96hKPqNDQQmgSrV/g
	RQfQaCyysGW6IZ0tgj5iEpLK74lrbwRJ6GpyX4VybRa+CMQUa0+KpV05cz96aU4=
X-Google-Smtp-Source: AGHT+IEhAY36VlwWizUIHL2fn1f9dEMQ6HoqJ2ZC+QNZ3eCzorNxh6EUQp5eUYFZp0uhHTBZAdJVUQ==
X-Received: by 2002:a50:9f89:0:b0:5cf:11cc:91d3 with SMTP id 4fb4d7f45d1cf-5cf11cc9357mr775907a12.9.1731060336107;
        Fri, 08 Nov 2024 02:05:36 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.28])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cf03c4f0bdsm1775959a12.56.2024.11.08.02.05.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 02:05:35 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: geert+renesas@glider.be,
	magnus.damm@gmail.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	p.zabel@pengutronix.de,
	g.liakhovetski@gmx.de,
	lethal@linux-sh.org
Cc: linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-serial@vger.kernel.org,
	claudiu.beznea@tuxon.dev,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v2 5/8] arm64: dts: renesas: rzg3s-smarc: Fix the debug serial alias
Date: Fri,  8 Nov 2024 12:05:10 +0200
Message-Id: <20241108100513.2814957-6-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241108100513.2814957-1-claudiu.beznea.uj@bp.renesas.com>
References: <20241108100513.2814957-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

The debug serial of the RZ/G3S is SCIF0 which is routed on the Renesas
RZ SMARC Carrier II board on the SER3_UART. Use serial3 alias for it for
better hardware description. Along with it, the chosen properties were
moved to the device tree corresponding to the RZ SMARC Carrier II board.

Fixes: adb4f0c5699c ("arm64: dts: renesas: Add initial support for RZ/G3S SMARC SoM")
Fixes: d1ae4200bb26 ("arm64: dts: renesas: Add initial device tree for RZ SMARC Carrier-II Board")
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v2:
- none

 arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi | 5 -----
 arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi     | 7 ++++++-
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi b/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
index 2ed01d391554..55c72c8a0735 100644
--- a/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
@@ -43,11 +43,6 @@ aliases {
 #endif
 	};
 
-	chosen {
-		bootargs = "ignore_loglevel";
-		stdout-path = "serial0:115200n8";
-	};
-
 	memory@48000000 {
 		device_type = "memory";
 		/* First 128MB is reserved for secure area. */
diff --git a/arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi b/arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi
index 4509151344c4..33b9873b225a 100644
--- a/arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi
@@ -12,10 +12,15 @@
 / {
 	aliases {
 		i2c0 = &i2c0;
-		serial0 = &scif0;
+		serial3 = &scif0;
 		mmc1 = &sdhi1;
 	};
 
+	chosen {
+		bootargs = "ignore_loglevel";
+		stdout-path = "serial3:115200n8";
+	};
+
 	keys {
 		compatible = "gpio-keys";
 
-- 
2.39.2


