Return-Path: <linux-kernel+bounces-291877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75C4B956873
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 12:26:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14E2CB223A6
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 10:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D4A616BE35;
	Mon, 19 Aug 2024 10:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="oMt3pAEk"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3DD16B72E
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 10:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724063065; cv=none; b=Vg/SFw2oRV6nrnt9fZdNGej5W0ji2SBpiAJsJu3dGoOs73E4TXxljb3i/2oe0SpqbyK1HLCjU8/g52xOFlnMpLmtjHpkpzMvlJme1/q249hNZDIDCLR1nv8y2BQmWNtY6mNYlGt2+Rk1IlNCL20eoq5XQZkJm4I/1ZGh6lxooCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724063065; c=relaxed/simple;
	bh=6dxetGM5vmL5SbPPHVy2B1Gw76+hss5JlYQEJT4DiXE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=I/Ud5yjDzBdkTMXz5wMwvnvfHOr6ydJ8nS+Fr1I+JtCv0gQX8AtVLzAGNKDdYSGYuz3pbje7DPvvVycrYSBzpVlkSSUIVC24OFTDq37jbrl9s8DDupRZFFpvie8vJGqlm65eKtWIprOIBYSmRu2Zeq3VI562410QlT1LMe9aElg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=oMt3pAEk; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-428243f928fso45662965e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 03:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1724063062; x=1724667862; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JevMdo+s9e0DzWfmlUF9Qlit9bWNc3VwroIkxBEWZ5g=;
        b=oMt3pAEkO1PKJl/m/ffCYBRYvE+O/JWqMJY39ZoKiDwG9X6VaHGE1/xm70pJN3oMbY
         ogKCMLBU3iCC9480Rdnfan8+J5Ol3YUq0CNhODzXSdY1DrP1+HU0k6emtERHv+Jdh9sE
         HQIETEy0qE2W7tEzW2F3QDQIlgCVr+JsTOw8rgAJRNrft7EjvaaHQ6Jc2Nd0jwwH4LMN
         l+vlSzz5bmwMHuoqzsdtX5eBONrmN93+VpbBZ0Kj6pJVdOq3S1GbWiZJsNX1nSA6xYBY
         ZtXq+U4W0STCAMa+gqw5ZrzanCVDcGTCVHubUa+scHfmlUQrvBHMxlRzZ2sJjmE0NUmV
         aJ5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724063062; x=1724667862;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JevMdo+s9e0DzWfmlUF9Qlit9bWNc3VwroIkxBEWZ5g=;
        b=mi8d83cfUp98yEXN9+IhKacrilAbeJEGRcR0+b5gDC+35uaa90arpGIkCKbtIBpzDK
         rhdlbZptaEG6/fkyOAtSglzFRRcpLzEaLyPy9pSBq6M0DqS95m4KDSOhSSEhiFxLJo23
         IR3y9gh2arRSPSx/YmqC+IAsK7H9t1EzFslJ/jZBBHzse2GAYHv2nwfGjJrjRBQ39KXK
         HQiUOBlsThVGVSETOoEjXR991NOtaKx4hS/ZWXCE9FxyXlQR4EdJSSfDbximXZ2WbLLE
         +4H6j0gQuvUnaj+26nTL1dDm++5+yvza2tixLLMR0JsLLFaRSnGJ7x9rkZ/0//rE9Kaq
         0zSw==
X-Forwarded-Encrypted: i=1; AJvYcCV9+NwjtVECtqgGXCI/BurPnlXJzcCMZp0b1wDIpV0JoSh4thYBHNnZc9Dkm10ETjesWXhkt80SZVSs/iEAq0gB/WNvoMJP9TDWn/Rx
X-Gm-Message-State: AOJu0YyaewcEWHNyQiwmh3AmLXyfYQKeGuRemGpJJhz/lmpZm3ujWTQC
	adwQ9FBTPYSn5XKq4DQY8FJJ5Ah69UrHsc7ZeiVWtqAu03zY3A4rlmmyW9iuPak=
X-Google-Smtp-Source: AGHT+IGXnLf7FHx5qPdROajd++4kF5shWlQUQohQYF/CYz5DK/SEqIOHou6LsZE9CQVQ8Ow9GizCSw==
X-Received: by 2002:a05:600c:1d94:b0:428:15b0:c8dd with SMTP id 5b1f17b1804b1-429ed7b78cemr104132875e9.20.1724063061815;
        Mon, 19 Aug 2024 03:24:21 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ed650402sm106690275e9.11.2024.08.19.03.24.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 03:24:21 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: chris.brandt@renesas.com,
	andi.shyti@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	geert+renesas@glider.be,
	magnus.damm@gmail.com,
	p.zabel@pengutronix.de,
	wsa+renesas@sang-engineering.com
Cc: linux-renesas-soc@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	claudiu.beznea@tuxon.dev,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v4 10/11] arm64: dts: renesas: rzg3s-smarc: Enable i2c0 node
Date: Mon, 19 Aug 2024 13:23:47 +0300
Message-Id: <20240819102348.1592171-11-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240819102348.1592171-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240819102348.1592171-1-claudiu.beznea.uj@bp.renesas.com>
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

Changes in v4:
- none

Changes in v3:
- none

Changes in v2:
- none

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


