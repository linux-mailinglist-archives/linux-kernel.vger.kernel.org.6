Return-Path: <linux-kernel+bounces-320430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ED3E970A31
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 23:48:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B27041F219D8
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 21:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A87C417BEC8;
	Sun,  8 Sep 2024 21:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qhcy2np7"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B00D17BEC6
	for <linux-kernel@vger.kernel.org>; Sun,  8 Sep 2024 21:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725832087; cv=none; b=b4JDzLdtz0xA0y8uUwJOMGRMM/2Ncab/OKltdl6YH5JBDcvQVfhgDKbaKHPSWKAEXgCpuk5byK3Y2z8iN+m1xwuFTE6PcB5DVhhDROBUyzWvRBT0IdYDehBvVJ98t9HkY1jeZuoTLsq1Dpkb1dRsLz6E7FIoCnB9Qg68bXlOFAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725832087; c=relaxed/simple;
	bh=61A2TmpCBTvA1OQSWxfcDyW9YW/y1h704XtvhNpV7BQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G9w/eZ9EtUCZ/PvRZ526w8PGf9DQCOAoZxPea25xth4awJ1vW70TpYZlPYnoQAYuW0oYwHvox+8cpFAGfTnQrrgkXlZS8fcdSNzw/eDMaRahdRd7WseeXBKZEryDku2TyTBjsPHbUSssVK+RpaRV0I/st0nu92yMYndj3KKppr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qhcy2np7; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2f75c6ed397so13585961fa.2
        for <linux-kernel@vger.kernel.org>; Sun, 08 Sep 2024 14:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725832084; x=1726436884; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+5lHdD1vu8tp19LY7L9NdChS/5uF8VF0FGda3xCecrM=;
        b=Qhcy2np7pfIkJAEmBMcsYq6yLeGWFFJ9g5jxUkU2kOEb0zsowq1N+yghCikLOMRVwZ
         0OqLCZS2S85NXPGF85hzRhd2h9XV9x5mL5pS3oBEydGE2aorDrdSXmomJTJVl2gZCE0A
         7M/3ZTqjx00mlgBUwTBg0RCuAo3HXj6z1wplyAx6PqoVavaBRqqD6DIPfQwCAiCp5NXt
         Apg9/0ygYISJeM6JT0MV0bH8r3CbLSe7uoi/Uu108qnruLozTV+fNWmODS8DxFwknGq6
         QPXW5rnYeZ14dQXNnCZrhgw6qijNbqComb9ZJBG88yOcFzt37ujdkFV372xSowJLaZdL
         f1yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725832084; x=1726436884;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+5lHdD1vu8tp19LY7L9NdChS/5uF8VF0FGda3xCecrM=;
        b=qJ1iMbdbrbZ/kaVKe50lwUkdoARTUbAwOzmELI35X60+7xnEfu+6sHKTQS7dMjJzj7
         BeZJq4hxjyX1LsLWQVamN8OaYBTSSojSQXt2XLMCkNYIttU+tPaBdNdzulN1IUqcwShR
         e6Im/QDo5l5bGdQJaKOP1Y2HmNKxUMCGALMAgS9xLoIf3MaZbyrgbwc+Sil/XXO+qww7
         ZEp3EQqbtxMW5RfqTrPE/FQZcnAO97BFmzI/SOg36QQBiXi3UOrJySg2+GNvYvS14N5v
         go/SOt1nGwma7yA4gh/MqlPjqzjK+oAQs7H3xh9OAIFeLGhPGRiu/jU1aA27mwUgsIM6
         lmEQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8iP9HgeQDoUX6+PmC/SD6XNDLKvx/LJfs6oPGs0LuyGRY103q3GijUVbyEqm4HBOh3cNJXj2QGxMytgw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZZr3ioGEkWrsFmZSrpGveRboV+NNGgViF69cdlu7RTiyubUJz
	/eA1IrfUGWEsQJAJKhd9tw9yzgs/tVjG5+CmpkryS3czreR4yNgy
X-Google-Smtp-Source: AGHT+IGWrBJfazLT3p6fzD1nzJeGKGktro5pYGcc4Vwm9vZSCn+YQvZnQ7GH/Qcypc5LoLYr8Z+kkg==
X-Received: by 2002:a05:651c:1543:b0:2f7:614f:7d3e with SMTP id 38308e7fff4ca-2f7614f80b5mr27281081fa.30.1725832083627;
        Sun, 08 Sep 2024 14:48:03 -0700 (PDT)
Received: from localhost.localdomain ([94.19.228.143])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f75c009a5dsm6094001fa.72.2024.09.08.14.48.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2024 14:48:03 -0700 (PDT)
From: Andrey Skvortsov <andrej.skvortzov@gmail.com>
To: Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Shoji Keita <awaittrot@shjk.jp>,
	Icenowy Zheng <icenowy@aosc.io>,
	Andre Przywara <andre.przywara@arm.com>,
	Andrey Skvortsov <andrej.skvortzov@gmail.com>
Subject: [PATCH 2/2] arm64: dts: sun50i-a64-pinephone: Add mount-matrix for PinePhone magnetometers
Date: Mon,  9 Sep 2024 00:47:18 +0300
Message-ID: <20240908214718.36316-3-andrej.skvortzov@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240908214718.36316-1-andrej.skvortzov@gmail.com>
References: <20240908214718.36316-1-andrej.skvortzov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shoji Keita <awaittrot@shjk.jp>

For lis3mdl, values are based on datasheet and PCB drawing
and tested on a real device.

For af8133j, values are from testing on a real device.

Signed-off-by: Shoji Keita <awaittrot@shjk.jp>
Signed-off-by: Andrey Skvortsov <andrej.skvortzov@gmail.com>

---
 arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
index 66fbb35a7fae9..d35d747292ce6 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
@@ -195,6 +195,9 @@ af8133j: magnetometer@1c {
 		reset-gpios = <&pio 1 1 GPIO_ACTIVE_LOW>;
 		avdd-supply = <&reg_dldo1>;
 		dvdd-supply = <&reg_dldo1>;
+		mount-matrix = "0", "-1", "0",
+				"-1", "0", "0",
+				"0", "0", "-1";
 
 		/* status will be fixed up in firmware */
 		status = "disabled";
@@ -206,6 +209,9 @@ lis3mdl: magnetometer@1e {
 		reg = <0x1e>;
 		vdd-supply = <&reg_dldo1>;
 		vddio-supply = <&reg_dldo1>;
+		mount-matrix = "0", "1", "0",
+				"-1", "0", "0",
+				"0", "0", "1";
 	};
 
 	/* Light/proximity sensor */
-- 
2.45.2


