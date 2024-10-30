Return-Path: <linux-kernel+bounces-388219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E81BE9B5C32
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 08:03:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 184031C20E87
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 07:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF7131E04AE;
	Wed, 30 Oct 2024 07:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Sk/olv3U"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BFE61DF751
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 07:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730271757; cv=none; b=FTPZcdqvo4OmF7j17aQj9ju3yLTrPll6NbYey3H7z8bzQy3iBj2StTzSC9X6HLejLuJCrJgsnrnTAC9P3oDbD96DVZeqkIjnFAVyzYNFUMA3sG7Y2zg6yU3DJ4KEfEw5G6SdEbPUk1VNEXVB9HrMgvD1yP5KiyIl7OIKLfquCuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730271757; c=relaxed/simple;
	bh=3f3iVJn9Qi05XrwmoQhkeKsmPZmKWCTCT/CWgEGoOT4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=myPtpJF/qfHR+TYWlgyUgDDb7oV0zOZrhA3l/z7zgzDCakyyqB9TfItabRNV8PIUC0dzX+sHSOtpArfuIrDPnH7Nekiarqa2ONdOYyr+sTos6FQocfby0FqK/mwUbESwUVTp8SHrKQXYUzUZ9XIUcJkqiSmowkMFp8M1tSx7XdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Sk/olv3U; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-7ede82dbb63so2147809a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 00:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1730271755; x=1730876555; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p5E41YcKQMsnvd5Y3pXv00rVYjTkf8zP3kA/zd8g2Nw=;
        b=Sk/olv3UfMhGrSl8uZAiSWMF5kaA367yMtEJPbQSi75AtNmGLpnss3X4kTSqKVH6O9
         3dQl6jctMybkYPRdzWhtXxNAjvw0GHa32dxFgAVnzy0NtsMCJoSUx05hstetpMXeOCpg
         DOYjt00VfTBps8YXaZTGARU6f8IKWMS5MSOd4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730271755; x=1730876555;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p5E41YcKQMsnvd5Y3pXv00rVYjTkf8zP3kA/zd8g2Nw=;
        b=NH8Nmq47yrsAyOM+vCRltUo/V6mGs1JCR8EO+bzEAq48JTWMwx47ZWEt8Gib6z1e4g
         QE8jH0dlsGRYW/PKsfY/iji3+wZi5BFI4IqwdyE68xTxJShPvw47hEtuvc9W7l0MQ41k
         bgoND/dy4uo1SLMVSsP9Nk7YAQSxuN0PWPX2ALQoQOSkus9HRSIzdv0bM+1CojFq1PWP
         jXwfYm1+Kj5cWuyrrvvGq6IbwvRQhjWTcIc7jq5UUceYUroTLgLv19vsDtCBCMwJkz+2
         +IyhE8+zJETELvh1EI76PAqsllh93gJzXft9p40Qs/xpJV1tlkrS3lCfH4J81jXg1CM+
         Z2pA==
X-Forwarded-Encrypted: i=1; AJvYcCUJmJQLT6ilU6IVzErqmnTfiqfCHugDtklJAa/6OLiN6oEwmiJD48EXXzKfOrwlfl260wG+glnWshaR2z4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5bIAd3qeBd4sVvSMpqemS/JsfoBzilHu/R0vOADMhJ5VuPkSc
	2c53iCHRZ968QBdMDEEF9NcPAqT3Ith8uD5M6waS2q7nYCwk3hbKuESjgWzsBQ==
X-Google-Smtp-Source: AGHT+IFrSYRhWTI2J+yd+pm72XTyFxdk2kxo61HvPYmkLDKpokBYjWWPyujJdt4yASL5lBgrzTxGwA==
X-Received: by 2002:a05:6a21:7890:b0:1d9:c5e6:51af with SMTP id adf61e73a8af0-1d9c5e654aemr11950511637.3.1730271754788;
        Wed, 30 Oct 2024 00:02:34 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:d1f3:aa64:657f:d8a8])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72057931a94sm8635848b3a.68.2024.10.30.00.02.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 00:02:34 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	devicetree@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] arm64: dts: mediatek: mt8183-kukui-jacuzzi: Add supplies for fixed regulators
Date: Wed, 30 Oct 2024 15:02:22 +0800
Message-ID: <20241030070224.1006331-4-wenst@chromium.org>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
In-Reply-To: <20241030070224.1006331-1-wenst@chromium.org>
References: <20241030070224.1006331-1-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the fixed regulators for the LCD panel and DP bridge were added,
their supplies were not modeled in. These, except for the 1.0V supply,
are just load switches, and need and have a supply.

Add the supplies for each of the fixed regulators.

Fixes: cabc71b08eb5 ("arm64: dts: mt8183: Add kukui-jacuzzi-damu board")
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi
index f540dcac74ea..80888bd4ad82 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi
@@ -20,6 +20,7 @@ pp1000_mipibrdg: pp1000-mipibrdg {
 		regulator-boot-on;
 
 		gpio = <&pio 54 GPIO_ACTIVE_HIGH>;
+		vin-supply = <&pp1800_alw>;
 	};
 
 	pp1800_mipibrdg: pp1800-mipibrdg {
@@ -32,6 +33,7 @@ pp1800_mipibrdg: pp1800-mipibrdg {
 		regulator-boot-on;
 
 		gpio = <&pio 36 GPIO_ACTIVE_HIGH>;
+		vin-supply = <&pp1800_alw>;
 	};
 
 	pp3300_panel: pp3300-panel {
@@ -44,6 +46,7 @@ pp3300_panel: pp3300-panel {
 		regulator-boot-on;
 
 		gpio = <&pio 35 GPIO_ACTIVE_HIGH>;
+		vin-supply = <&pp3300_alw>;
 	};
 
 	pp3300_mipibrdg: pp3300-mipibrdg {
@@ -56,6 +59,7 @@ pp3300_mipibrdg: pp3300-mipibrdg {
 		regulator-boot-on;
 
 		gpio = <&pio 37 GPIO_ACTIVE_HIGH>;
+		vin-supply = <&pp3300_alw>;
 	};
 
 	volume_buttons: volume-buttons {
-- 
2.47.0.163.g1226f6d8fa-goog


