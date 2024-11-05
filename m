Return-Path: <linux-kernel+bounces-395826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6401E9BC398
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 04:08:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 883361C21718
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 03:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3FAB74BE1;
	Tue,  5 Nov 2024 03:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dvft7ftB"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB62126BED
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 03:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730776104; cv=none; b=cglvlLi4Fq27MNH1aA8h367wqux+h5tYAnjNQFU+A6Ymy65aU0d80KpSJWgNlRYL2DVLFpfD3hvis95z2MRSvCcQ4uXGAsCOfFpEth8UXIbk3n4S7w3BnlfWqgxLSlwhL8ghhGosxyLPhlegT/aAW78ZU90aDFY9YHgcg9qy7kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730776104; c=relaxed/simple;
	bh=5HKQbLuFh/w4P48o0WwiGQJ4dP/1l86vgjlCj1HMcMY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pfCj0lAsmPfh6v7XEm4aKHtDB8Y/ptoFdfk4l2l9EtOSIpKvrlPIzP10qxJtApxS8lOwXZWxfavF/9TWqd6z6efjwf3hD6RoZBCqPnEiUn47otQAFFsPuUnmu8opkpA8Yesr8xIGcT8jdXqCOtLsPhUSlpdT78nXpafgMPaQ028=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=dvft7ftB; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-20ce5e3b116so39018655ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 19:08:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1730776102; x=1731380902; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SSuXby54cMC2vAK6ojnOdnoa4iB7IjmAMiqN+tDw83w=;
        b=dvft7ftBWYeOpYg4QG6/KgqIct9bJdwTfhSHPadKH8XH4NQrk2TaKkdXrhBCNRjFIA
         Y8tVUEBky2SWAB11iaT1mbi1m9Vwk2MQYjLw9490j5iyQ0pMthpOuLORwvUs05jIWFmo
         qvYIPqAlOp0+oCNRDA529ITrpDIKoKBfDI3SE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730776102; x=1731380902;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SSuXby54cMC2vAK6ojnOdnoa4iB7IjmAMiqN+tDw83w=;
        b=Ib5uCIKhXORr5ZhxQLRyF2jzrviJe+TqnzV7PvKrm0xLtif2q9cogChrLaDLdSC8aW
         iRjDeCCABvWd9Z+RS5n5+aV36lIhR3Fqbt+tfPj3vY3nf+HHwv01h0iF36NJzqsaq9jn
         Hw7eKeNiHJhHMYIKOAMqhPJhcxt1edO4tvptMET/Q0/Pe+fA01eTAouQXHhacY+HNESI
         lCL1tl4KmtFyjeEqPSbsAE2O8WGI9J1drPQJj9Cdlmmcy1YWSDVZM6et+nh7eMRQjJlF
         zABv/xL0WCCs25PN0/oWD6iF7jjqFpFKMFbQlA+0YXTr9N4Pc2xUWpGHoOtj78nWDigT
         UHlQ==
X-Forwarded-Encrypted: i=1; AJvYcCWRfpDI80DJmwROFA4ZJ7hxemUQOKd1uIwja2sOOFsPk85262aiNFY2Fd/hpbE6Eznxk4oIWh7NoJ9bvQY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzd+n75zXR+CkWp/VAU5cfzmb3QZAl7aDqYoIhh3Qoy6K/bagqt
	7tRtbLx9X27eHnqRXmgDwZBzsg0NY4563+baIU4QhEigNl9xoRMANmoX/p3b9Q==
X-Google-Smtp-Source: AGHT+IHuqQmwmjHY0D5zIUpVl/v6v6kAIikbzzkfJyep2UTBf3dxCno/2IHIhZ62pUvCmVudKfz89g==
X-Received: by 2002:a17:902:ce8c:b0:20c:e262:2560 with SMTP id d9443c01a7336-2111b0078bdmr185112795ad.50.1730776101869;
        Mon, 04 Nov 2024 19:08:21 -0800 (PST)
Received: from yuanhsinte.c.googlers.com (176.220.194.35.bc.googleusercontent.com. [35.194.220.176])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211057d8d4dsm67497885ad.270.2024.11.04.19.08.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 19:08:21 -0800 (PST)
From: Hsin-Te Yuan <yuanhsinte@chromium.org>
Date: Tue, 05 Nov 2024 03:08:12 +0000
Subject: [PATCH RESEND v2 2/4] arm64: dts: mediatek: mt8183: Switch to Elan
 touchscreen driver
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241105-post-reset-v2-2-c1dc94b65017@chromium.org>
References: <20241105-post-reset-v2-0-c1dc94b65017@chromium.org>
In-Reply-To: <20241105-post-reset-v2-0-c1dc94b65017@chromium.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Enric Balletbo i Serra <eballetbo@kernel.org>, 
 Hsin-Yi Wang <hsinyi@chromium.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Hans de Goede <hdegoede@redhat.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 Hsin-Te Yuan <yuanhsinte@chromium.org>
X-Mailer: b4 0.15-dev-7be4f

After commit 2be404486c05 ("HID: i2c-hid-of: Add reset GPIO support to
i2c-hid-of"), the i2c-hid-of driver used by some mt8183 devices resets
the touchscreen without having enough post-reset delay. This makes those
touchscreen fail to get probed.

Switch to Elan touchscreen driver, which has enough post-reset delay.

Fixes: 2be404486c05 ("HID: i2c-hid-of: Add reset GPIO support to i2c-hid-of")
Signed-off-by: Hsin-Te Yuan <yuanhsinte@chromium.org>
---
 arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-damu.dts     | 10 +++-------
 .../boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel-sku1.dts     |  9 ++-------
 .../boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel-sku6.dts     |  9 ++-------
 .../boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel-sku7.dts     |  9 ++-------
 4 files changed, 9 insertions(+), 28 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-damu.dts b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-damu.dts
index ebe6e161354c414d91859494ec9295db75a3baf9..b98a3530511e576347a4ed291d37d45dd42fec97 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-damu.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-damu.dts
@@ -14,14 +14,10 @@ / {
 };
 
 &touchscreen {
-	status = "okay";
+	compatible = "elan,ekth6a12nay";
 
-	compatible = "hid-over-i2c";
-	reg = <0x10>;
-	interrupts-extended = <&pio 155 IRQ_TYPE_LEVEL_LOW>;
-
-	post-power-on-delay-ms = <10>;
-	hid-descr-addr = <0x0001>;
+	vcc33-supply = <&pp3300_alw>;
+	vccio-supply = <&pp1800_alw>;
 };
 
 &qca_wifi {
diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel-sku1.dts b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel-sku1.dts
index 2dc64cc539f815b9848b8243e5b487f22d605a6d..9fb329626a82034e44fb5fbd2d0ad9675c0a5afa 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel-sku1.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel-sku1.dts
@@ -27,14 +27,9 @@ &cros_ec_pwm {
 };
 
 &touchscreen {
-	status = "okay";
-
-	compatible = "hid-over-i2c";
-	reg = <0x10>;
-	interrupts-extended = <&pio 155 IRQ_TYPE_LEVEL_LOW>;
+	compatible = "elan,ekth6a12nay";
 
-	post-power-on-delay-ms = <10>;
-	hid-descr-addr = <0x0001>;
+	vcc33-supply = <&pp3300_alw>;
 };
 
 &qca_wifi {
diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel-sku6.dts b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel-sku6.dts
index 53e996f9c605dc36df03d4b0051a91e19fefb38d..6d547361fc4f9d2ab1f9b048af443495c9bed323 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel-sku6.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel-sku6.dts
@@ -14,14 +14,9 @@ / {
 };
 
 &touchscreen {
-	status = "okay";
+	compatible = "elan,ekth6a12nay";
 
-	compatible = "hid-over-i2c";
-	reg = <0x10>;
-	interrupts-extended = <&pio 155 IRQ_TYPE_LEVEL_LOW>;
-
-	post-power-on-delay-ms = <10>;
-	hid-descr-addr = <0x0001>;
+	vcc33-supply = <&pp3300_alw>;
 };
 
 
diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel-sku7.dts b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel-sku7.dts
index d7db621383c6b823af08ca07e0794758d062e211..39ab09ce28aa2ed4335d5279a965f23a8458688e 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel-sku7.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel-sku7.dts
@@ -14,14 +14,9 @@ / {
 };
 
 &touchscreen {
-	status = "okay";
+	compatible = "elan,ekth6a12nay";
 
-	compatible = "hid-over-i2c";
-	reg = <0x10>;
-	interrupts-extended = <&pio 155 IRQ_TYPE_LEVEL_LOW>;
-
-	post-power-on-delay-ms = <10>;
-	hid-descr-addr = <0x0001>;
+	vcc33-supply = <&pp3300_alw>;
 };
 
 

-- 
2.47.0.199.ga7371fff76-goog


