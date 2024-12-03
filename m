Return-Path: <linux-kernel+bounces-429334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 46AF39E1C06
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 13:22:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B70A6B60F8C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 11:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A02111EE01C;
	Tue,  3 Dec 2024 11:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="It1J3/+s"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DABE1E47AC
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 11:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733224440; cv=none; b=Vx5b3xfLPbD8QDbw5Aex50R2j93mOs789JmQ3vL08BGjh5X91/83h5Jnk0ostfJP9/KWY0bBaaJ7sVKXNQs8/CW4MbUrir4bMoyTKLDpi/2mzKDgVxQRhtDQ8e4i7KJovqSM5m4r6PILdW3kKciy4V9n2BZX0Pxhgcfy6mgQss8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733224440; c=relaxed/simple;
	bh=hPzvAQBya4lMaHbeDMGEHEu0Sst46VpHxejcDLV1/YY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cT5AkmhHFdFbXR7i9DyXsEk+mlY825y0mqQgy4LaBU1oU557xHtYBD2E2knjOmXALa/w8R7GQDgYOavmEGXCrPD4hirNdt12WZL54yQw2bYl1iOdyXbDd4PAK54v0gF4Tb3ANJ/LO67Ku5PwcbcaU8pc2rSqEQstmgaLhdbInhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=It1J3/+s; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-434a852bb6eso49489545e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 03:13:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1733224437; x=1733829237; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vuYmwt2mwWEd+Tu2KpQNpDTdmewly+5/W4Kvuhh8MtU=;
        b=It1J3/+s9eSfgOa8xL59iWVGv+bPplYPchi3wNeRX2rnrYbTkBFFvQtNbDfm1r41OG
         qgBVYtaUStEnB5rBO3lZRE2JNiqq/BrOXom1WDnToiQxwuP+th0L+oEeaEuz6BZtxlWQ
         GAqrdY74ufxHua152q5gx1h0V/u2yPDuoCozhjPXuFj5YxlLGafPWd1XrJyX7U3nezW5
         CTHDPFT1pdavJiWU2Khk+m6t02EbH9zCCuTWuAmUz4d7Zpo7VwRze2UVDrr6odo25X7T
         GnlaqtR4KRk7r2WiViqaEkG8rJDo49sD7BFGDvlsLGyOUvyr7SOnUSvF/zgT017NrMi5
         avig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733224437; x=1733829237;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vuYmwt2mwWEd+Tu2KpQNpDTdmewly+5/W4Kvuhh8MtU=;
        b=tb+LYa8KIyVTyslL67FnVHhGPiOhYsIDDBv9r/X1/n5AL8H6djz4sO9S7TsBG3XN9B
         lKLvHrc+Mve0XjnjuhWup2uVw72NmQhQCoD9QRY0r7o9FdrtOrJViKV7sz9/BKcD5m6f
         7ziT3wwMR+liL9dI9EldeNMtJhMclgjuJTMx0xyqE145I9xf5UxOWsZTqHuxj4Mgj2kq
         RXeaHRBUkozK1N22OobrDxzMjhSUatbws9CSlDAQy+fUBRBtRDokshg7jrcVADDG3YTG
         rp8HCg5vqkxjebO4qfFlWOFpAKSrZphBr/BKYFqciWBQStJdQtgoJJCxcrzFZsyDH1Wh
         bOlQ==
X-Forwarded-Encrypted: i=1; AJvYcCVd/iDpNWI5JXuJOcRjONL9A5t2ciIcvDmL1yqnJuH2pCg7ucO4xAqjPR0CUqcbgA2VQW41iGq7qIhGye8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/x+OBVp5OtEQsm0msMq6UeEMkitrAz9P3NUZSa4S8S45w009a
	C4PzcTu+2hwpw1L5/TYzxsDxXCEDVq88tz2hFKRmbeRF7ZdIGcb1KHAc9DiwqIE=
X-Gm-Gg: ASbGncu3qajtOKY+Ntq5ZT1ZhU88eS4+eLaenQSWg+GWnLf+wSSJQJQDzEJasfOsUw8
	3g64JT7ptlOTtLjTGHaRHfqMYrQcIgMrEvqiyj8uluB8ValIMFHUKIQsMQ1T290XUQ7V/0Ip9bW
	/P+FwgiyNmQh79k2nd7wuP9AHhtJPyDkq+ZHQnJn5er4TW4LLsvL5/GC7sPtUNm+Phouqfa0tCq
	IyHmWXad8s0YCgYNfGOf/y+2bNG2/cFIbu9MxnIzR7ID/M5DxT6YaZ5z4IHNWQEe/BoiZq9Qqne
	3sJj
X-Google-Smtp-Source: AGHT+IHOuquR0Z2Y/9RwvEymwXXAAW6Jm4OPLCo5DQNmdYBocmhFqjdVsjkAP+GiCZweMjILCABwxQ==
X-Received: by 2002:a05:600c:4710:b0:434:a30b:5455 with SMTP id 5b1f17b1804b1-434d0a239c3mr16423245e9.27.1733224435487;
        Tue, 03 Dec 2024 03:13:55 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.161])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385e0117069sm11794315f8f.60.2024.12.03.03.13.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 03:13:55 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: prabhakar.mahadev-lad.rj@bp.renesas.com,
	jic23@kernel.org,
	lars@metafoo.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	geert+renesas@glider.be,
	magnus.damm@gmail.com,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	p.zabel@pengutronix.de
Cc: claudiu.beznea@tuxon.dev,
	linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH 14/14] arm64: dts: renesas: rzg3s-smarc-som: Enable ADC
Date: Tue,  3 Dec 2024 13:13:14 +0200
Message-Id: <20241203111314.2420473-15-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241203111314.2420473-1-claudiu.beznea.uj@bp.renesas.com>
References: <20241203111314.2420473-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Enable ADC.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi b/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
index 2ed01d391554..57ebdfc858eb 100644
--- a/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
@@ -94,6 +94,10 @@ vcc_sdhi2: regulator2 {
 	};
 };
 
+&adc {
+	status = "okay";
+};
+
 #if SW_CONFIG3 == SW_ON
 &eth0 {
 	pinctrl-0 = <&eth0_pins>;
-- 
2.39.2


