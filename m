Return-Path: <linux-kernel+bounces-557556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 06435A5DAC5
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 11:46:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0125E189D170
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 10:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A5C0244EB6;
	Wed, 12 Mar 2025 10:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fKcOjMHz"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EEE924339C
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 10:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741776249; cv=none; b=bjNiV6VDrY06/StlMr5+5Grx5BbzQPDr1spZN8a0fKQxRifcBIWgtTZc0jIDPRNrWwNbwDG7zuZBwdYPiTzxSC26o6LMoeyTPZfYfJaPHCy7r987IekjBNCv81aPNYSbeHYPfF3U0nWlgsYrEG5UZHWv5X54noT9OPyyiEYVd9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741776249; c=relaxed/simple;
	bh=DLOFKyixrKjuNk5xbPr6+WZVuEvD4zxgmFK1T42/rQ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LMAICxyBUQX1/028uqczM47Dc3ysmZ4P3OHlrD0YYpuQwEyJY/YT0wNiXWkk7NIXyP/B19MvqxKUPx9TmQ0fTSUWRZhcR1fpVaX3Af4cFODyx4/jJDt/2o7qa7aCl+4HIebBZhrNIsHO3jp1sOFW0ueRPyEXnWXyFXltugMn5nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=fKcOjMHz; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2feb867849fso10022132a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 03:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1741776247; x=1742381047; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iBHq9V8lKreFqK9KM1t5HhbZfxxdkE8xQHpVyP8b1xQ=;
        b=fKcOjMHzh5460KSR8xnOFBqDFi+7vSkhBVTb4KRCzG0WLmHDrRy0kxkrp4D0aa3CWY
         u3y17L9/TN9UYnnBlOBq2XoQa2jX1JF+TdrDQtxwR/7cjpID3leroe8InlRCKlSbU6y4
         1RiGAImqn41F7LWjx32+gnZb4lyBdMuOCa4gY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741776247; x=1742381047;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iBHq9V8lKreFqK9KM1t5HhbZfxxdkE8xQHpVyP8b1xQ=;
        b=v7vl+2tGiJUGQcdwCYVik+Hn8JPkSacfAEsRO5jQ3kL/jCP5QBpOllTP0kyJ0DaB5u
         GMLRCuTmcmZQw1dtLgoRm/33EcgID0YZOOajyy9A16G797ozsSjGbz0aBsWjqIrJvzFA
         zl4+7ySWlGbrIpY2v4732Qmlk9eC4kqlFFkmHsAUTWvvzch41h7K2Q8E61fsPQNjm7tE
         fWA7HYOZhfTm5Aa3QMu6zrz9Am6sDwRj4Z4SOBYI02aNO8QctNOBInZSHQzMXORB8eDU
         hQj0ihJSxQEkHzydwecODOmoZ50yNl8DGZG4AQA9FtRkIcHc4pK6vAKTI9CZk10lNYn1
         gzhQ==
X-Forwarded-Encrypted: i=1; AJvYcCVDP5ogxIMu4BuDIj2Ui+c/3Ve46aWB52f1KcttUosCbkpw4PLaw8jz9XDfZ7RL3JxmV35p/pgquuEfhHg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqvyHAdyDPmwXpmPvN2QhR/COPAhht27qd6UeymphG7gx4vlP1
	pQU1PCeC4yBQr9WOBwVOrSI797zKA1Zd/YKeDJtq/5jjgbPPNIEICXJQ+Jog6Q==
X-Gm-Gg: ASbGncsJMAtp1xotIn5FCN4rprT/ZoGs+vH2EYnyscF+j8+gD7B93vNQZjVcBq6XwMa
	Tr+TQJgNPzSVK6Zsiceef6Gf62hAny703U3Bs3GdnU2peJsGdLzcE4KPHrLTAjNGeEy0AL+HCqx
	g3LAGstWurk3H1ewArhvndogQhQMUgP2+R5ReieAfS4fxpuMgDLswehh4n4ZRFGmzgryqmSWWMR
	n0LiYJ927vxVY7G3vAJQ0DpnJzm0JwnsUvkpKf2lSP8LJwP6Lo9yQDF5NswCjoUrgibDK1yEN05
	q670PHOy5ws5AlNmDY1AIWvPg3MDpqwwDdfyRD12N5xQRb87Jw4qoS2FV66Vg9Y=
X-Google-Smtp-Source: AGHT+IHgEKYXDVQ8fG2MojJ+3+NZnnUhzA79ZMbcKKeZymlj+PamoGqt91exqHl5LDqK7OCjTlvNwA==
X-Received: by 2002:a17:90b:350d:b0:2ee:c04a:4276 with SMTP id 98e67ed59e1d1-2ff7ce7276dmr28891107a91.5.1741776247611;
        Wed, 12 Mar 2025 03:44:07 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:b5ed:b71c:fb14:a696])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3011926599csm1405675a91.35.2025.03.12.03.44.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 03:44:07 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Benson Leung <bleung@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	chrome-platform@lists.linux.dev,
	linux-input@vger.kernel.org,
	Douglas Anderson <dianders@chromium.org>
Subject: [PATCH 5/8] arm64: dts: mediatek: mt8186: Merge Voltorb device trees
Date: Wed, 12 Mar 2025 18:43:39 +0800
Message-ID: <20250312104344.3084425-6-wenst@chromium.org>
X-Mailer: git-send-email 2.49.0.rc0.332.g42c0ae87b1-goog
In-Reply-To: <20250312104344.3084425-1-wenst@chromium.org>
References: <20250312104344.3084425-1-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are only two different SKUs of Voltorb, and the only difference
between them is whether a touchscreen is present or not. This can be
detected by a simple I2C transfer to the address, instead of having
separate device trees.

Merge the two device trees together and simplify the compatible string
list. The dtsi is still kept separate since there is an incoming device
that shares the same design, but with slightly difference components.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 arch/arm64/boot/dts/mediatek/Makefile               |  3 +--
 .../mediatek/mt8186-corsola-voltorb-sku589824.dts   | 13 -------------
 ...orb-sku589825.dts => mt8186-corsola-voltorb.dts} |  5 ++---
 3 files changed, 3 insertions(+), 18 deletions(-)
 delete mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola-voltorb-sku589824.dts
 rename arch/arm64/boot/dts/mediatek/{mt8186-corsola-voltorb-sku589825.dts => mt8186-corsola-voltorb.dts} (76%)

diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/mediatek/Makefile
index 58484e830063..ff67931e7821 100644
--- a/arch/arm64/boot/dts/mediatek/Makefile
+++ b/arch/arm64/boot/dts/mediatek/Makefile
@@ -73,8 +73,7 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += mt8186-corsola-tentacool-sku327681.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8186-corsola-tentacool-sku327683.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8186-corsola-tentacruel-sku262144.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8186-corsola-tentacruel-sku262148.dtb
-dtb-$(CONFIG_ARCH_MEDIATEK) += mt8186-corsola-voltorb-sku589824.dtb
-dtb-$(CONFIG_ARCH_MEDIATEK) += mt8186-corsola-voltorb-sku589825.dtb
+dtb-$(CONFIG_ARCH_MEDIATEK) += mt8186-corsola-voltorb.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8186-evb.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8188-evb.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8188-geralt-ciri-sku0.dtb
diff --git a/arch/arm64/boot/dts/mediatek/mt8186-corsola-voltorb-sku589824.dts b/arch/arm64/boot/dts/mediatek/mt8186-corsola-voltorb-sku589824.dts
deleted file mode 100644
index d16834eec87a..000000000000
--- a/arch/arm64/boot/dts/mediatek/mt8186-corsola-voltorb-sku589824.dts
+++ /dev/null
@@ -1,13 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0 OR MIT)
-/*
- * Copyright 2022 Google LLC
- */
-
-/dts-v1/;
-#include "mt8186-corsola-voltorb.dtsi"
-
-/ {
-	model = "Google Voltorb sku589824 board";
-	compatible = "google,voltorb-sku589824", "google,voltorb",
-		     "mediatek,mt8186";
-};
diff --git a/arch/arm64/boot/dts/mediatek/mt8186-corsola-voltorb-sku589825.dts b/arch/arm64/boot/dts/mediatek/mt8186-corsola-voltorb.dts
similarity index 76%
rename from arch/arm64/boot/dts/mediatek/mt8186-corsola-voltorb-sku589825.dts
rename to arch/arm64/boot/dts/mediatek/mt8186-corsola-voltorb.dts
index 45e57f7706cc..cc805408a8b7 100644
--- a/arch/arm64/boot/dts/mediatek/mt8186-corsola-voltorb-sku589825.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8186-corsola-voltorb.dts
@@ -7,9 +7,8 @@
 #include "mt8186-corsola-voltorb.dtsi"
 
 / {
-	model = "Google Voltorb sku589825 board";
-	compatible = "google,voltorb-sku589825", "google,voltorb",
-		     "mediatek,mt8186";
+	model = "Google Voltorb board";
+	compatible = "google,voltorb", "mediatek,mt8186";
 };
 
 &i2c1 {
-- 
2.49.0.rc0.332.g42c0ae87b1-goog


