Return-Path: <linux-kernel+bounces-354790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F2FB9942A2
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 10:49:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F52A1C23E21
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 08:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 744EB1DD552;
	Tue,  8 Oct 2024 08:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JsTfdyma"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71AEB1DD55F
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 08:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728375727; cv=none; b=rsRXPPA1km/6evSRR3aojvMFViMLLRL/LS66fcaqS6th/3h189icLrswMju10tsEw8nMYj2nWfvrwRuqyJ7XQ+A9VqBM8uJZ7xGdNy7br7kcJVZwUVayWCkwSJPcpD8A+yQ1kPfjhgkTPcEUn3rIE/dKa8tW/WOupzEsOG19HRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728375727; c=relaxed/simple;
	bh=KxrvOwNcoeeDK29sUt5+JjD22MOnbw+qFb325dYYMuk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L8Fs/lRWi6SHXvz51+yHqMItKoWBykfJLiUaWUxeFsARaBStNUjFRMIvM3tOMvznYa8QDDST0zkXANyTc6d4bp5bvI3qly1rpdHsG6EpZMOwfLynejQV8o1taeP10U7RszN0dbCIsvlpELsZ8ERxz9NGBJnvKJh1FQ1VGa2+9yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=JsTfdyma; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-71df468496fso2748032b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2024 01:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1728375726; x=1728980526; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AEmpf1Qh2kfZRDBsrgiylITiUd0y+4rTAJ+KrYJvhnY=;
        b=JsTfdymaduAAVF8fm2ltfNQoeDvTcY9L4oGagNKFPFdiFDr3kRbNp04CVchMxHLtbP
         GdhJbdWj3iNwCduakQhk5/t2Is0UGfp2BQOQ7mFhoj6fTrgg5BOKgDRTIoOkCfmgacZX
         O8/L3NAoKRb9Uuu8dQpwd/g+G92SPYQV0q2+o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728375726; x=1728980526;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AEmpf1Qh2kfZRDBsrgiylITiUd0y+4rTAJ+KrYJvhnY=;
        b=VSTQI7++PvfEt2MhgVLWLfsx8dyyyI2or6O52LzZ08omgEuymYYAXLTx2UfCvq3Eua
         25UIDSStqVZ8dY4afPYdQrVOQETslnHkimXk0VMC9XmezJAJTBs2fb88DPY7LIDJzfd3
         0to1OD7yeOlL6XJIyWTxoVUbqJ7+tPnX73zZoCKA99jKX/TR1W/8PeWIcUYavuGvfXRW
         narkrZCj+y+ThJ5tZBtiKmfTPsiozwHnxAWfA7iWWUnULd3WxEDlOMUmsvfDlgwXkCxP
         IheWgRSeQqOiu2QcY2JMbeKzx9gbSqRiERA2uOZufBUNjKBHz4sLXpHEdcAzxgi9cLsL
         X7Fg==
X-Forwarded-Encrypted: i=1; AJvYcCWsCIRUfvl0g4ijQBSRL/CxFMPPXbtikceRvrs1KLoJhzmYyJcLKxfA6vqGaGTSXmrUs2Fdbo6V5yGMgEs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1+emC1Z0wyHWFDVxateFW0eN/hhO7bHrgxxEqO2FQwcXTdRn6
	HsNVl7Yg6JhFT8CyJ7or77ffjNqlM57R7h+GBkXjU44BxdZpO01tlGx9tZbGSg==
X-Google-Smtp-Source: AGHT+IGs6ruuA946P6zuVAHheO6fA4ce2N15T5/3R5m2iMP4gQbVW50etvU9cRYSthEEe6bgR250uQ==
X-Received: by 2002:a05:6a00:c8b:b0:71e:cb:e7b2 with SMTP id d2e1a72fcca58-71e00cbe85amr2649580b3a.21.1728375725616;
        Tue, 08 Oct 2024 01:22:05 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:10df:d27e:8d4b:6740])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e9f6c4ce2bsm6247176a12.83.2024.10.08.01.22.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 01:22:05 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	devicetree@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] arm64: dts: mediatek: mt8186-corsola-voltorb: Merge speaker codec nodes
Date: Tue,  8 Oct 2024 16:21:59 +0800
Message-ID: <20241008082200.4002798-1-wenst@chromium.org>
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Voltorb device uses a speaker codec different from the original
Corsola device. When the Voltorb device tree was first added, the new
codec was added as a separate node when it should have just replaced the
existing one.

Merge the two nodes. The only differences are the compatible string and
the GPIO line property name. This keeps the device node path for the
speaker codec the same across the MT8186 Chromebook line.

Fixes: 321ad586e607 ("arm64: dts: mediatek: Add MT8186 Voltorb Chromebooks")
Cc: <stable@vger.kernel.org>
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 .../dts/mediatek/mt8186-corsola-voltorb.dtsi  | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8186-corsola-voltorb.dtsi b/arch/arm64/boot/dts/mediatek/mt8186-corsola-voltorb.dtsi
index 52ec58128d56..fbcd97069df9 100644
--- a/arch/arm64/boot/dts/mediatek/mt8186-corsola-voltorb.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8186-corsola-voltorb.dtsi
@@ -10,12 +10,6 @@
 
 / {
 	chassis-type = "laptop";
-
-	max98360a: max98360a {
-		compatible = "maxim,max98360a";
-		sdmode-gpios = <&pio 150 GPIO_ACTIVE_HIGH>;
-		#sound-dai-cells = <0>;
-	};
 };
 
 &cpu6 {
@@ -59,19 +53,14 @@ &cluster1_opp_15 {
 	opp-hz = /bits/ 64 <2200000000>;
 };
 
-&rt1019p{
-	status = "disabled";
+&rt1019p {
+	compatible = "maxim,max98360a";
+	sdmode-gpios = <&pio 150 GPIO_ACTIVE_HIGH>;
+	/delete-property/ sdb-gpios;
 };
 
 &sound {
 	compatible = "mediatek,mt8186-mt6366-rt5682s-max98360-sound";
-	status = "okay";
-
-	spk-hdmi-playback-dai-link {
-		codec {
-			sound-dai = <&it6505dptx>, <&max98360a>;
-		};
-	};
 };
 
 &spmi {
-- 
2.47.0.rc0.187.ge670bccf7e-goog


