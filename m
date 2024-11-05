Return-Path: <linux-kernel+bounces-395828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5EAA9BC39C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 04:09:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B3441F22BCB
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 03:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2615E14D719;
	Tue,  5 Nov 2024 03:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ONmqnyOe"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A5EE1420A8
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 03:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730776110; cv=none; b=ZUaDB1XuOcW6u+Ixj5NOsebqfmYmhuSyx7mHxM++z+95TtfZNXG/NqOCERMirApgPmXmldchXHIhh6wAny1DBBOy51ETOldxLnTiYUntj38rJyqhVun0Cebz0g7nca+fI/IubtUAiZ40e3I3K5ReWe9EsZtMwvd94ERpzlWj5XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730776110; c=relaxed/simple;
	bh=LegS2qPNA21GD4AcjtZ5CBXXSgyiE2Fv9FQCHVrVb8Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fMDMcdd9G+YCmW2tepE2mWO5sXaspmOyI/IsxSjBfFy+lUPJy2/sdkNCiu6MI6I7KU+iVZoBLkPFALBJrs5Gb8E+R7Ws2JYMYdaMzhKRd7fsgrsPMXDtSlgxSw7Q/6h9OtvvoKExgCevQmf4qVaTU0ktANII7sbf+yCvkZrASKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ONmqnyOe; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-20c7ee8fe6bso46253455ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 19:08:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1730776107; x=1731380907; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=euPhqg7viIx2XTAkn9Q5AvVF/uGDGrDQK80Z56OHLio=;
        b=ONmqnyOepE9VT9V9t4RhQprAYGSYJpRj5DXKs16NQglORyzPxc87N0SAEnGjWI8eIp
         jNHVHEbfSpWXH2Z0i+toeOIbmzsX5zDaMbRBJJ2tJQU9d0HcGKrz6yZOymZxULySN9ZB
         g9YJLprudjZyNEqyh/zqtyKtKJynxbz/1h8Mo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730776107; x=1731380907;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=euPhqg7viIx2XTAkn9Q5AvVF/uGDGrDQK80Z56OHLio=;
        b=LAnGSWZAG7EgBBXR6EDcOSK72PqfHXBooaAtS6LBr5HMFH9uRhIUjNw20vCDlUcTN7
         v8tZL6w2M7QaA3ID/3wO4YWautkt8X3g8E8t2xAMCCppCbvlvOl+ixaHYQvGsn/t6olY
         RjoauArsOdMLNWQPr+XGjd/T1PMKrlTYLPv81GoQmmHkxh4DFKQLpSHYSatWSCjNnpgj
         MExzogNoSJanewByvzpmNws5VMyqVtLlEUN9ZrvCGKLoo8tSz9ZLvQZ9KKmeGlJW6NDG
         QcvEsDHwMD5uUS6FCKGHEJNpWlLC1kM2XSOqYYh5/C/vo2PlH+1s2v6QK60INWyTClIW
         OuDw==
X-Forwarded-Encrypted: i=1; AJvYcCWQrm6aSGle4wzuCqgilPndciYUh+kZax4OF0+KBLcFAWLob6/2UqnUN3y1llLywHXGHHnLaHujI0V7cbI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVFO1LcjsxmdSlwKUG1JhturyK0nBcCbayUsurPK1MhmnZSe7v
	xSxIHb2euEprmo70rrSozzb3znTz9nlT2ZCAnd06Y7oIKTL9XZvdROddxYkkBA==
X-Google-Smtp-Source: AGHT+IGBp3c1Lhzc3e6+qTBBRkT4mBZaYjen82U0w7kAh09SHgIN3F5lnKg4nHiKKOQv7zPeWuvL8A==
X-Received: by 2002:a17:902:cec4:b0:20c:c834:b107 with SMTP id d9443c01a7336-210c68cc81bmr425323355ad.22.1730776107551;
        Mon, 04 Nov 2024 19:08:27 -0800 (PST)
Received: from yuanhsinte.c.googlers.com (176.220.194.35.bc.googleusercontent.com. [35.194.220.176])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211057d8d4dsm67497885ad.270.2024.11.04.19.08.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 19:08:27 -0800 (PST)
From: Hsin-Te Yuan <yuanhsinte@chromium.org>
Date: Tue, 05 Nov 2024 03:08:14 +0000
Subject: [PATCH RESEND v2 4/4] arm64: dts: mediatek: mt8183: willow:
 Support second source touchscreen
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241105-post-reset-v2-4-c1dc94b65017@chromium.org>
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

Some willow devices use second source touchscreen.

Fixes: f006bcf1c972 ("arm64: dts: mt8183: Add kukui-jacuzzi-willow board")
Signed-off-by: Hsin-Te Yuan <yuanhsinte@chromium.org>
---
 arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-kenzo.dts | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-kenzo.dts b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-kenzo.dts
index 813e6bf65b62ee6742e52133f9adf7e83a6078c5..e8241587949b2bc238ffa85f8fa6b6ca78b1d6f5 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-kenzo.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-kenzo.dts
@@ -12,15 +12,3 @@ / {
 	chassis-type = "laptop";
 	compatible = "google,juniper-sku17", "google,juniper", "mediatek,mt8183";
 };
-
-&i2c0 {
-	touchscreen@40 {
-		compatible = "hid-over-i2c";
-		reg = <0x40>;
-
-		interrupts-extended = <&pio 155 IRQ_TYPE_LEVEL_LOW>;
-
-		post-power-on-delay-ms = <70>;
-		hid-descr-addr = <0x0001>;
-	};
-};

-- 
2.47.0.199.ga7371fff76-goog


