Return-Path: <linux-kernel+bounces-444290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D20C9F0430
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 06:28:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DB58282FEA
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 05:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8943018A95A;
	Fri, 13 Dec 2024 05:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jgwGOTLJ"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 972A1188CC9
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 05:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734067676; cv=none; b=WH2GB6YH3SVfzMXfyMNVS9uHVpPTlhpS4AwgldGz6YZLrgtNOM8gmZcWkeSILfcKkZ1tnQKAwaagXM+9tNqMgDlpto2+SOrW+oyQwPNZaTPfuVaD58GZJgNm8hNOBkQpfzE7CnIVgdRsIzslXAc1tsv/dXrpw+IvqmOE3nh05RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734067676; c=relaxed/simple;
	bh=bk9gIncBGFq0J0SRqSDAmnds14P+ZGVSByXhzONMc9M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=t7A8X9NVzesynIlt/iaoEcdn2ciSdyAEbMXaL/tX/5WS1xHZSpnehyeib0M/lTSTZunIMRpFf6UI0LIYLb1AfN64i3MYo3Whh66Y8PY6RL3ol2ltbyuc+o7X2FT4xbYPxtYj+9DVQQ0rRm5U1FpLcSZm9Z08TTsJEibzRM8rk7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=jgwGOTLJ; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-725f4025e25so1142929b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 21:27:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1734067674; x=1734672474; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9sHUcSk8M94bRNs3iZu7+gRAJsjDAn//p+qux811FOg=;
        b=jgwGOTLJ7u7Gij9HNXzOv/aDjXxvSoz6xn2qgipG932BlzsuTICNXCpOiPrwbie2n3
         ypX06IN/RJK2YUy/DCDuLjF3bZrpWfVjCAggNpNZeT+pykM9B542iS7NTXS6Gc7D2UWK
         MI9ExVoLWgbT6jayij1qdGtM8ftwLFcXPPdbY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734067674; x=1734672474;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9sHUcSk8M94bRNs3iZu7+gRAJsjDAn//p+qux811FOg=;
        b=g0ejYvSVEXBRrIEPh9v8TRZc8jO2g413P/VDpn0FH/OHQFCp/rJzsmhpKPZP6y0fXj
         hq/6klxoX49bNbUWBqZWJmOX40WuymmMwJ6mfTAa+Tur0dqFM4/BK6dw9wdDAeRy3Auk
         iuz4SBw2geSVY14OqJKOnn9HV3AZSAw6dzPJDezMsbz8H4l496GBry1p9actS0Pb9Ko6
         Fo8RefeoFgkjsMEPcRoLMkbkgi9G3iHZCoq/aG6YgjNVWedK0FYXxustaKFCAciejVb2
         dIkxXoKudGoudNq5IXBevYdauobYeJhKR/ROoD4y/2vmYshRjNv6JErY5VuZDYA9mFQy
         MaNQ==
X-Forwarded-Encrypted: i=1; AJvYcCUaIlQs7MowYBURHQAgQhMgXla0CPbzd2TD88EScAXYv5HcbCl9trEBvbT3LSV3ZWM0mKmvsDOr3s7sflo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmFI5G5KmkBWHUWAfM+CRFj+GuhpcWRHxlCgplS3exMXEa3VJy
	+/23cPI7MQiaqA3/sijqHOzYo7ajukxGh+jc1T1rEvCKz6zJzUwCq62y2W9pCA==
X-Gm-Gg: ASbGncvukc8PqwHeQ0eEqSJOmFAsSHgHyEsp6atwmhP+SZuZvCOk8WbAJMl1pIXVKaJ
	cU1UAXY4JWO7ViOjjgeuGEMy/q+l7x9CEajii1Ybx5SSWM5BjJwtxzM+wWxW8mkKk6MkeZ3w4Ta
	HWUxAbY82+xF5N6OFie2r68kBPdeaJRv5rlaj5MEuVjNcZlJ92HC7w6WZBtByH3q4gi/3owctJR
	Ic/Njaclo7gVv1ck95GYFyAT+PVSSWZnnCAt+CNUMIkQbVxlQ0+AeBBQyk9L6iO3W2vkqj+nOId
	H8qc2na3yRc+l1geh5XkFPcP+m1vRjg3N0CfremOnhSH0q4=
X-Google-Smtp-Source: AGHT+IEewRI1exts+mBt5zPXwiV4DU9C7+OYlL08s3JN7DhOdqeiqTJY3msJOJkX4Vs4aQwdU++g3g==
X-Received: by 2002:a05:6a21:7803:b0:1e1:b35b:5132 with SMTP id adf61e73a8af0-1e1dfd6023bmr2007610637.20.1734067674075;
        Thu, 12 Dec 2024 21:27:54 -0800 (PST)
Received: from yuanhsinte.c.googlers.com (176.220.194.35.bc.googleusercontent.com. [35.194.220.176])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7263803a805sm7386830b3a.14.2024.12.12.21.27.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 21:27:53 -0800 (PST)
From: Hsin-Te Yuan <yuanhsinte@chromium.org>
Date: Fri, 13 Dec 2024 05:27:47 +0000
Subject: [PATCH v3 1/2] arm64: dts: mediatek: mt8183: kenzo: Support second
 source touchscreen
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241213-touchscreen-v3-1-7c1f670913f9@chromium.org>
References: <20241213-touchscreen-v3-0-7c1f670913f9@chromium.org>
In-Reply-To: <20241213-touchscreen-v3-0-7c1f670913f9@chromium.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Enric Balletbo i Serra <eballetbo@kernel.org>, 
 Hsin-Yi Wang <hsinyi@chromium.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 Hsin-Te Yuan <yuanhsinte@chromium.org>
X-Mailer: b4 0.15-dev-7be4f

Some kenzo devices use second source touchscreen.

Fixes: 0a9cefe21aec ("arm64: dts: mt8183: Add kukui-jacuzzi-kenzo board")
Signed-off-by: Hsin-Te Yuan <yuanhsinte@chromium.org>
---
 .../boot/dts/mediatek/mt8183-kukui-jacuzzi-kenzo.dts      | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-kenzo.dts b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-kenzo.dts
index e8241587949b2bc238ffa85f8fa6b6ca78b1d6f5..561770fcf69e66341c080687e2efaa6e98c550a8 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-kenzo.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-kenzo.dts
@@ -12,3 +12,18 @@ / {
 	chassis-type = "laptop";
 	compatible = "google,juniper-sku17", "google,juniper", "mediatek,mt8183";
 };
+
+&i2c0 {
+	touchscreen@40 {
+		compatible = "hid-over-i2c";
+		reg = <0x40>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&touchscreen_pins>;
+
+		interrupts-extended = <&pio 155 IRQ_TYPE_LEVEL_LOW>;
+
+		post-power-on-delay-ms = <70>;
+		hid-descr-addr = <0x0001>;
+	};
+};

-- 
2.47.1.613.gc27f4b7a9f-goog


