Return-Path: <linux-kernel+bounces-395827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 006449BC39A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 04:09:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A649B1F22A0F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 03:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 463DC76035;
	Tue,  5 Nov 2024 03:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cVr+BscP"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E64E13A409
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 03:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730776106; cv=none; b=NpohC55yFhxiDxnhwQBc0DEj0tVe7mbWhcUAiOZvvDefdi2W+nafuKb2a8MpNJMDwp5h/9AIlt1Piu+MjZxYGKgoBTD8mvoCRKPLD+fN+si1t56LmGyVQulkbjy9cxSrhgMcPAS69EeY+YfIjPvhNGvlb5VjJ/e/2E1ZG4RJOyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730776106; c=relaxed/simple;
	bh=RF7UJXnVaHEsJfC1ISRqxrKgzyE0SA8QVcPURG3tS1k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=vAYHtI68SMvyK8tq/e6cCM8bXhm36EZBN3qVfy5Ss+0P6BL5CTxBsVHOqDNyBCrR5tpMBomYa/gX/x/pBs9epffor77luq+wVsrBAkVqml3CaetshXcBO6oSoJVgd8UlP5WSytIZUuFRJFQIEwWNVtK1yGbvGsd+77r+fgFNSk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=cVr+BscP; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7ea12e0dc7aso3301744a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 19:08:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1730776105; x=1731380905; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jVNKfz2t6zEgtE6p7hSHFZ+86J0/BrsT2sCmnVgjQCw=;
        b=cVr+BscPgHHJNOQ1ie6nVVy3tMRidDnCL50Sfkesz9Y46bDtXPY8lbuuOn3kqRAyN7
         Cb//LBIvx7DS13HAFkfuYNtvs5Mm6bl8szLk2Qgb+OHlWssnkv4ZOXcpYu6VDjq/MyLd
         72u1/zHip7s+sK6auAoITqL2Zu12TE78oxtq4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730776105; x=1731380905;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jVNKfz2t6zEgtE6p7hSHFZ+86J0/BrsT2sCmnVgjQCw=;
        b=gFw5gFsNfTiDHv1Kvh2M9Lm5iRDxieVos8+mn7VDecolcsjB+qDjW1AKYlGUoj7daE
         lhOJQNTi17IGZeywMjYkWUm6aoYiPpbhtjwSyiDig8T+FyGyH3S5owNbDLxbTEWdX5dm
         FB0SPpeQcoood+aVhmvm3ZkyepgY+lfhL8AQFUnxxfW+2uhELFTipaoiW3xOdKljUB8U
         CRCgnyDx/VvoQRlf+qtRtbIg9a0KIeSFy1e/wH5prGPrb0cD8uDi4lPb7C1SBTh2BQM9
         iGSYQn18MiimmBQ/jxc9QvTgj0VI+rRzJWiolIoN9C63Oha1KLAV2+yRT8cYvTj/Qc3T
         qvhA==
X-Forwarded-Encrypted: i=1; AJvYcCU4bOVrF1dyoPaYWCSLpaj/lM1DZmZVp6brlwTQQk3frZu/NqARajgXRS+3XraFNyAwPZ9mff1IEPzSkyY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxc+9oE+xc3/SyDk9+N3EGEmnVxnRGDsSTChIkMMzOfP6OmsHu2
	dRbxJ8lQfAKunS4XbJ9KxEW2PyxvfjATGWSr+gtOnMbVh5kiuDHRUsV/MOH3lw==
X-Google-Smtp-Source: AGHT+IHIrNO0VoT73VkYM3UKR4zs5Ym7OnU1LxK7zSs0kR7UH9l8Gsq3xPWPJiw3R+H/jGdnosVuAQ==
X-Received: by 2002:a17:90b:3901:b0:2e2:af52:a7b7 with SMTP id 98e67ed59e1d1-2e94c52f395mr19754083a91.34.1730776104667;
        Mon, 04 Nov 2024 19:08:24 -0800 (PST)
Received: from yuanhsinte.c.googlers.com (176.220.194.35.bc.googleusercontent.com. [35.194.220.176])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211057d8d4dsm67497885ad.270.2024.11.04.19.08.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 19:08:24 -0800 (PST)
From: Hsin-Te Yuan <yuanhsinte@chromium.org>
Date: Tue, 05 Nov 2024 03:08:13 +0000
Subject: [PATCH RESEND v2 3/4] arm64: dts: mediatek: mt8183: kenzo: Support
 second source touchscreen
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241105-post-reset-v2-3-c1dc94b65017@chromium.org>
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
2.47.0.199.ga7371fff76-goog


