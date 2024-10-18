Return-Path: <linux-kernel+bounces-371727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 291D09A3F43
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 15:14:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 589331C2494E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 13:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 356A11EE00E;
	Fri, 18 Oct 2024 13:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Zb0EOaKF"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE671DACAA
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 13:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729257239; cv=none; b=Ye3ngcMuqEQkpfJxziq6+Y/hrovzvs++ODwjUHpIn8rHi8kV15Qo67wV44r+CjhmQP9LqADPRZgCui2ERpQ7dzvXYvNyLtphxO1KWxfFavxYUkTQ4KdczhyQOC1Rh06ETrHziogiTnsjnesNLcAcSYXGzJlGRow15HpXk7o/dzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729257239; c=relaxed/simple;
	bh=HhRR5d4jmo6CPi9lmPJR+0DOtFhzhX6gLm+pS79kY3w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fFu8vjDsQ65xD0olUK9vD7i8Sxvmzwn5seT1n/MbfOD1y3BnFvYBmqPl5og5h4hzrtHYQVByVIsrf75rIOphfhWXLK3e84A8VoF1ejSDSLTs764RwZvp7Lq4rHwbfkSTcIVsoG8oI2J4MNfcz+yyKgdEd+WvoE9TshNApu6dLHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Zb0EOaKF; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7ea8c4ce232so1915166a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 06:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1729257237; x=1729862037; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+dRN7sp9adnaf0gmX/kygO9824Q5cpdY3njPLrCdXXs=;
        b=Zb0EOaKFmWMpx8WMK7/vLylbP+tm7aSyralHrUSUugw5szUh56lYJUe/LNj2H4WPI+
         GdvUIguxW4/ZYaNAtKIj5geeQKX0jlI9oCtEil2wsQ0qY3DWvjuZXJS8WdkVZJ2l4SK6
         M1ebimFl7JDSmrDI4AXQFzJuOukime4t3IWio=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729257237; x=1729862037;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+dRN7sp9adnaf0gmX/kygO9824Q5cpdY3njPLrCdXXs=;
        b=Bxwd0K66B4wMMElOe6LqiiK9qwNdEZKzfUenftBq07qP+I9ehp4GFkzHLgL4IHOKGp
         1bVETE1mkf88bn3uR8YpYJjjPBAeWOuclt5D8iRY6mbIabPzBUsbVZq32qcI8bs8HK1j
         IAGMII8rVM1/BP3ddcLBgaaGrBe+2a+PvnohORMITTIOEaJLkB3yKeG/mhTWlyGYcUgk
         iHPq+jfZrFOhl7ipovwgaPAYHxE74NIE1Dx5Qi49z/ogY49Q6cVO4dmMHgYp2kcgd0ce
         5KyYNya8lWBnqsCdgNT1Qj7zTtw57Pp00HwbzofCL7EzB0/zp9D1oBPCMnC1zHys0a9X
         gi7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUAyGr8/+hxotHn4NT2HYqfyOvOBe6DBZP1kbpYffm4xvI73zFtUzjqUCUWbNL11ntNE6+vnhgX93ja408=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7vQsgkHNh8DdRjK5wvz8+kB2D/DEXkXzAYV+vVevk2rVrw4e5
	cUF4AFcLo601xjc2UGY8fgUO1zRvHXrGs093scOKDdulxaf4+y66ps5bWe2rXw==
X-Google-Smtp-Source: AGHT+IG28NlyG5rPtxLjr3QMID39Dq27Ev7Stc0ZZoqqQfbQBGFdiwKlYI1AT/T18xmyW3UlwwjAkA==
X-Received: by 2002:a05:6a21:4a4c:b0:1d8:fd01:52b7 with SMTP id adf61e73a8af0-1d92c4bac01mr3296386637.2.1729257236906;
        Fri, 18 Oct 2024 06:13:56 -0700 (PDT)
Received: from yuanhsinte.c.googlers.com (176.220.194.35.bc.googleusercontent.com. [35.194.220.176])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7eacc256cc8sm1120222a12.56.2024.10.18.06.13.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 06:13:56 -0700 (PDT)
From: Hsin-Te Yuan <yuanhsinte@chromium.org>
Date: Fri, 18 Oct 2024 13:13:43 +0000
Subject: [PATCH v2 3/4] arm64: dts: mediatek: mt8183: kenzo: Support second
 source touchscreen
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241018-post-reset-v2-3-28d539d79e18@chromium.org>
References: <20241018-post-reset-v2-0-28d539d79e18@chromium.org>
In-Reply-To: <20241018-post-reset-v2-0-28d539d79e18@chromium.org>
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

Some kenzo devices use second source touchscreen.

Fixes: 0a9cefe21aec ("arm64: dts: mt8183: Add kukui-jacuzzi-kenzo board")
Signed-off-by: Hsin-Te Yuan <yuanhsinte@chromium.org>
---
 arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-kenzo.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-kenzo.dts b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-kenzo.dts
index e8241587949b2bc238ffa85f8fa6b6ca78b1d6f5..813e6bf65b62ee6742e52133f9adf7e83a6078c5 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-kenzo.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-kenzo.dts
@@ -12,3 +12,15 @@ / {
 	chassis-type = "laptop";
 	compatible = "google,juniper-sku17", "google,juniper", "mediatek,mt8183";
 };
+
+&i2c0 {
+	touchscreen@40 {
+		compatible = "hid-over-i2c";
+		reg = <0x40>;
+
+		interrupts-extended = <&pio 155 IRQ_TYPE_LEVEL_LOW>;
+
+		post-power-on-delay-ms = <70>;
+		hid-descr-addr = <0x0001>;
+	};
+};

-- 
2.47.0.rc1.288.g06298d1525-goog


