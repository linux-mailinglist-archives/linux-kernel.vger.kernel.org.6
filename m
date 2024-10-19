Return-Path: <linux-kernel+bounces-372726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C88AD9A4C5E
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 10:50:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53E4528260F
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 08:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF8361E0DE6;
	Sat, 19 Oct 2024 08:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="JC/05x2I"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0911E0DE2
	for <linux-kernel@vger.kernel.org>; Sat, 19 Oct 2024 08:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729327694; cv=none; b=KtEvxYbumZrORV7H7jJIiZvWsbYJyF0Joex8CqU9swRt09PSp3QPiPtYuhzsL/bBcXs6svyw1rZq5IMSgK3s+pBnA8MFrVhKiilWfmuIK6pxS5AIvKPR6u8Ze6E4cjQeLMEf6eeCYDfTD8epnyx2qbdXTnMcAKdeVrimBts9C7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729327694; c=relaxed/simple;
	bh=QkgHvw9IBOeGPAakrzCTmrkD96bz5qPFYSsEtoUc+6s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=S/68KbNlDQvnIDfdDWyI2PgBQepycPxpxxt+oeM1Df/qkz2knsaYgb5O3w/mg9TMB5vkvBv8mYEqDRpL0T75GCeuTpHqh4djzIZUjSf0CNfxtfM8vwou8buOcXYEbzSEuxv7/mj9ZISp92PVxkqUsGVQZQ611IXEIa9KBIKH3dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=JC/05x2I; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-431616c23b5so9549825e9.0
        for <linux-kernel@vger.kernel.org>; Sat, 19 Oct 2024 01:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1729327690; x=1729932490; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i1BDFdSyg41e2LABdQN1el7m1GZPq2Uu7y0UUTGsVos=;
        b=JC/05x2IHqKMY4XIqE+GHpMTkBvG0/11CN9YZc3OVSjOKYWFvQ1atbCGQaWR+GH59t
         QkZz4ydXhituuzlsJ/l31CPa6n1HuCUjFdebymIKmmL5wg3/wqwGUFMw0CX4NlRkX8qq
         Sd+5hCBt5o1Yv3jZ+y416VU5R3oH/rCdgd6TjG+FelftvsAsACKXFVxUDdqQjOW2ABny
         tgjIs6e+Gq3Uqr+IR0Xcwf8bzvs2m8JWl9SL4tkg1XnPVdc/XTAEqc7Sr9CQO4MXGTmI
         GVL7DMuGZS0pPSXJxA0k92zPplTIEg7+N1jgULjon7iXnk1ECU/SVao7m/vrKAYvhwiU
         HxjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729327690; x=1729932490;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i1BDFdSyg41e2LABdQN1el7m1GZPq2Uu7y0UUTGsVos=;
        b=GsrS1i07Dt3a4wGy/PDigHbCE8YXUSfyO0VegvoaLIlA+YvO7xWeeZQcBZDuRkXYOk
         syyfnMoNWKJ/O9xqRv34k8GSVXCuChRAyZ7kMDAnvCuiLOoogglh+4rW1Xv9s61G7RIn
         zAmJDlcPEJ6GyLN1cAdc87H0OY0ehmZEN6xw0kOz6FLwWDSq7es8gzbLrZ9o5I8VBWzc
         I951rr/sJ5m1nZlYUDgBdItpBDGV5vQ65qrgKNcsWZjbwhFWfoBSoB6PGiBInmfqGYO0
         7XEdHwQ6MI7F1srPTjMWPcsrVmFwEDAX8FFXxNXpezlbLd1gE78GqfGApaej+F7/YgfJ
         EbOw==
X-Forwarded-Encrypted: i=1; AJvYcCUjfrcSeY3tK8oAgXkyKQAVOL2kdeDjwW+KaLsAnqndpQ2Hza0WiNrEL6nnzDOl9REaVQ/c/36mNZ9BC34=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5at2Y9B2705rZnhcoFd52hhsGfuwRZSx9EJxGnzDLFZ0wXeH/
	WM3LyQqQMsZVm+dNwRQ5mSSUrDerK7uS/Q/IpV9dMrsAb2m5xJJlDfPVLIruw90=
X-Google-Smtp-Source: AGHT+IGHzPKJDiCrpkrv0zEGse3U3VvdpNmMFQCy8z/QXuS15hpNd6JHm2gDYDjdinG8u1jiTCFuqw==
X-Received: by 2002:a05:600c:3b85:b0:42f:84ec:3e0 with SMTP id 5b1f17b1804b1-43158721801mr65450245e9.9.1729327690371;
        Sat, 19 Oct 2024 01:48:10 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.23])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ecf0eccbasm3898731f8f.81.2024.10.19.01.48.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Oct 2024 01:48:09 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: geert+renesas@glider.be,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	alexandre.belloni@bootlin.com,
	magnus.damm@gmail.com,
	p.zabel@pengutronix.de
Cc: linux-renesas-soc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rtc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	claudiu.beznea@tuxon.dev,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v4 11/12] arm64: dts: renesas: rzg3s-smarc-som: Enable RTC
Date: Sat, 19 Oct 2024 11:47:37 +0300
Message-Id: <20241019084738.3370489-12-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241019084738.3370489-1-claudiu.beznea.uj@bp.renesas.com>
References: <20241019084738.3370489-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Enable RTC.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v4:
- collected tags

Changes in v3:
- none

Changes in v2:
- none

 arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi b/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
index 6be0ffdcb87e..939820a925d6 100644
--- a/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
@@ -347,6 +347,10 @@ mux {
 	};
 };
 
+&rtc {
+	status = "okay";
+};
+
 &vbattb {
 	assigned-clocks = <&vbattb VBATTB_MUX>;
 	assigned-clock-parents = <&vbattb VBATTB_XC>;
-- 
2.39.2


