Return-Path: <linux-kernel+bounces-213015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2F299069D8
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 12:20:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D9691C21D22
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 10:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B8311422DA;
	Thu, 13 Jun 2024 10:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HsnLA2G5"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C99F14036F
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 10:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718274006; cv=none; b=muizN+ZuYZML4IWsCCy/1ejhpfZnzDdffHz42mG7J2cRr5Gf6n0sOe0b1RX1KkCEvmuCMfDvM1e1UZgBE2dLe36RpRK+Cp/5guR0AVzvC3u5dOQD3xDGb3jDmOY/39eIZ13DPsmFGAyrW/K2DgI+yp4hVlsIRPMPotFzdbyFeRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718274006; c=relaxed/simple;
	bh=yJHUAkGXRUAqSw3kT67351NRbqCbUNjFaRw8L2R5mZg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=oSodnBWHE3rWWpLf62mfytRnmgDQr8wKCYCVLdNurFzV/o9NpR8X5t0XKA7MM6nPZS66O74QNdw60z9AXIQnFhZBgODq+l6zpG7ZgPy8LY1v5mufzFhrmjz99/Oony51ho8Mm0bc/UNEe2m4Wa8+3+ILS5CGIwfHc20K+kRuw/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=HsnLA2G5; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7042a8ad9f5so1245433b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 03:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1718274004; x=1718878804; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=j6xMy0PSx7RAK5KyLRoFGIY2S4TSiOFCk9JAjN+55oY=;
        b=HsnLA2G5q03Ycvz9VqoDO76Hlev3e3ORu1caXOTyCgx1cASqmfRHr1JBK8WMYavsw3
         3N7CseAwqljfUVsysEcD9RbcIw1YWzJhPJAxQI8FTSW1dVRUjDCe6BHaHdslSkm7COSP
         S8/7jchhnGi3DvkobT3RWJTh4apqVl8EqgQ5w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718274004; x=1718878804;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j6xMy0PSx7RAK5KyLRoFGIY2S4TSiOFCk9JAjN+55oY=;
        b=lWCJAqsmnZIy2HjSR3BvLTYVeg4ChAb3QSLQqMxd6vvpF9ZE/jjymH7Gz/LmpJzMnU
         iMzx5Ozco5SZr9sEFuszLK+00DktDMzJ/L9T+Yz0bi6sqXhyWP2sQ9jqyX3BHHKPO6P5
         +SGPqIA3pxwtKKMSWjEhh6WcUMkigY60ZBOECF4vSnezp+9Lz3rQlur61we3OVyPFfzL
         LmBYzEbzmo5poXmRY6+/9/YzkJeCG0u6vGBXc8y+3OAEp5cKOCIXKmiePLwUYQO7X90L
         0bV0JEMtCoAi6bCiK3Uvm6vhRCVVs9ApH4zS+zl+yE7sr4ZE5eGDARNLYdZx9+UkHxO2
         xZxA==
X-Forwarded-Encrypted: i=1; AJvYcCVnWcZf8ZbLkk9Lf7mGd2saZi+mYsonbq38fk+YPbaGeH0fDkXVWJ4n63MizKY2fuAaWrfr9KN1jxtnYdd+TxJU0LoUGq+qqTRkBsOB
X-Gm-Message-State: AOJu0YwIal9hRUUcSAUR09ZCoXbnZX4LgjGdwSSKfceYv1c2tr4fkUIf
	bxuRavQL+YsHnvc0ySHObV+hpC1BexrVF/uEgX7Vm4T9oGMndxGcbEK34zzaRA==
X-Google-Smtp-Source: AGHT+IGvGm28fk+okkNWjfFgYvPyFLTuWgmuTCIzXUdUG0qAQ/FS0ndUR84hPXLwOSrKkTwZkSzbEg==
X-Received: by 2002:a05:6a20:daa8:b0:1a9:d27c:3151 with SMTP id adf61e73a8af0-1b8bf0c4483mr3508458637.23.1718274003916;
        Thu, 13 Jun 2024 03:20:03 -0700 (PDT)
Received: from yuanhsinte.c.googlers.com (60.252.199.104.bc.googleusercontent.com. [104.199.252.60])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6fedcf36b9esm817047a12.19.2024.06.13.03.20.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 03:20:03 -0700 (PDT)
From: Hsin-Te Yuan <yuanhsinte@chromium.org>
Date: Thu, 13 Jun 2024 10:19:58 +0000
Subject: [PATCH] arm64: dts: Fix the value of `dlg,jack-det-rate` mismatch
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240613-jack-rate-v1-1-62ee0259e204@chromium.org>
X-B4-Tracking: v=1; b=H4sIAM3HamYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDM0Nj3azE5GzdosSSVN1kE3OLtERzs+RUQ0sloPqCotS0zAqwWdGxtbU
 An6aP6lsAAAA=
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Heiko Stuebner <heiko@sntech.de>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, Hsin-Te Yuan <yuanhsinte@chromium.org>
X-Mailer: b4 0.13.0

According to Documentation/devicetree/bindings/sound/dialog,da7219.yaml,
the value of `dlg,jack-det-rate` property should be '32_64' instead of
'32ms_64ms'.

Signed-off-by: Hsin-Te Yuan <yuanhsinte@chromium.org>
---
 arch/arm64/boot/dts/mediatek/mt8183-kukui-audio-da7219.dtsi | 2 +-
 arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi                | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-audio-da7219.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui-audio-da7219.dtsi
index 8b57706ac814..586eee79c73c 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-audio-da7219.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-audio-da7219.dtsi
@@ -27,7 +27,7 @@ da7219_aad {
 			dlg,btn-cfg = <50>;
 			dlg,mic-det-thr = <500>;
 			dlg,jack-ins-deb = <20>;
-			dlg,jack-det-rate = "32ms_64ms";
+			dlg,jack-det-rate = "32_64";
 			dlg,jack-rem-deb = <1>;
 
 			dlg,a-d-btn-thr = <0xa>;
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
index 789fd0dcc88b..3cd63d1e8f15 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
@@ -450,7 +450,7 @@ da7219_aad {
 			dlg,btn-cfg = <50>;
 			dlg,mic-det-thr = <500>;
 			dlg,jack-ins-deb = <20>;
-			dlg,jack-det-rate = "32ms_64ms";
+			dlg,jack-det-rate = "32_64";
 			dlg,jack-rem-deb = <1>;
 
 			dlg,a-d-btn-thr = <0xa>;

---
base-commit: cea2a26553ace13ee36b56dc09ad548b5e6907df
change-id: 20240613-jack-rate-c478fa76ce19

Best regards,
-- 
Hsin-Te Yuan <yuanhsinte@chromium.org>


