Return-Path: <linux-kernel+bounces-404537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D6A09C44DE
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 19:21:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25F7F1F25599
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 18:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C208E1C1AD1;
	Mon, 11 Nov 2024 18:18:16 +0000 (UTC)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AECD81A76DD;
	Mon, 11 Nov 2024 18:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731349096; cv=none; b=FYO/Z8nIR+eKJQpOCl7IKQA3pvcjs4r4ZbQlqQEE9uUrlcqJNgV2yZmnO8jx+Mdf9UonEvuglrr1GZwKmhHgSvIRB/psoCCulkMufN0EwmgSbWhw8vWRz/aQTwbWrCSaTXlwJ8znnhyqgsabxb71wuUWIsZWe8Zg+ghcHNYQ2fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731349096; c=relaxed/simple;
	bh=NUpHzi7ldruM7wye4rV2MHffa7XW4xvZarJXg/I+Xgg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EBnn6/GrcD9oX1qdC5bDzaWhXuYPH+3tKbQytES8Q0t7COL9/TZy0tssUbRz1JfDWZ43Ui0IO9MRqWZqorIMnyrUNefPIJciWdEZ+G6NOXcpFMblL7SNbDLP2zsjCr8D2thgOIBuWqGMY/KZ1aHMtfos90C8GC1czJ1sCPQE4ME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a9e8522c10bso746403666b.1;
        Mon, 11 Nov 2024 10:18:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731349093; x=1731953893;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L9QaR0BG6R1g4qnhXgnvmqa/ekoM0k94F2vyZtmSUk0=;
        b=EBmi/ADbzQib5ConeGEpBtClm4ojgU4fronTi+N9tP0Rc/bBIJ8+681vmfB5IemFX4
         EWyuBYeuY1Ko7SVt9D+T1J6NAhOMDk5LTcZ1BPGqX9n+rzc1GGR+sqxs0JAIxgXUFOo9
         Dvk7qUvj30Bxogfaiw05WBQlA4tbMmhYgxKX0baxLs5htckFhOXB3XgeByflRfLMPZnL
         qSXo6zVwWiKwP3nxwdzx5D1PzOsMKkQ5fM+GSFIomZTTqrS5dO8m2nMrgG04in2v0GhK
         SGeutRsxFejSPA69rTY5fA7Oryi3SZNe36uPoDW2rFzI/u25NRRFKiMduHwk6qDXEolB
         0d7Q==
X-Forwarded-Encrypted: i=1; AJvYcCWpnMZentoPjKAVpUJlyJEE4tqIYXBh7sIWP4bOMzLdWuiC/2kjTBuLfuWIHDBAQsZz1U9ZIkT1xDcK@vger.kernel.org, AJvYcCXUjNSx65JYZV5qsJN418hDoBX3Gfd8xnrtXbRV2myURLO/+thxYg1arhqHNjjayfnN6YXmqDwOxcRKtUsf@vger.kernel.org
X-Gm-Message-State: AOJu0Yxnlujk6cP63tWuLdA/ucG3aoHqDqk82H1QbcL4BV0QuTeICx6X
	PvV5aFsgpg4cXN6J0R1SCg4K+xbpmkarj8dFI5wvgXn68JqNNWvt
X-Google-Smtp-Source: AGHT+IFRTD3QXRpX84g/OrfQbY0Ox6bUTyQy1uaHky5CSXyrm+co0z+49Rf4f0/uWBqCzAr0o5zw8g==
X-Received: by 2002:a17:907:7f1b:b0:a9a:17be:fac7 with SMTP id a640c23a62f3a-a9eefeb5cb4mr1224603366b.14.1731349092826;
        Mon, 11 Nov 2024 10:18:12 -0800 (PST)
Received: from localhost.localdomain ([193.142.191.186])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0a17b64sm617868466b.39.2024.11.11.10.18.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 10:18:12 -0800 (PST)
From: =?UTF-8?q?Tam=C3=A1s=20Sz=C5=B1cs?= <tszucs@linux.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	=?UTF-8?q?Tam=C3=A1s=20Sz=C5=B1cs?= <tszucs@linux.com>,
	FUKAUMI Naoki <naoki@radxa.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Dragan Simic <dsimic@manjaro.org>,
	Chukun Pan <amadeus@jmu.edu.cn>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] arm64: dts: rockchip: Enable sdmmc2 on rock-3b and set it up for SDIO devices
Date: Mon, 11 Nov 2024 19:17:26 +0100
Message-ID: <20241111181807.13211-3-tszucs@linux.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241111181807.13211-1-tszucs@linux.com>
References: <20241111181807.13211-1-tszucs@linux.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Enable SDIO on Radxa ROCK 3 Model B M.2 Key E. Add all supported UHS-I rates and
enable 200 MHz maximum clock. Also, allow host wakeup via SDIO IRQ.

Signed-off-by: Tamás Szűcs <tszucs@linux.com>
---
 arch/arm64/boot/dts/rockchip/rk3568-rock-3b.dts | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3568-rock-3b.dts b/arch/arm64/boot/dts/rockchip/rk3568-rock-3b.dts
index 242af5337cdf..b7527ba418f7 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568-rock-3b.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3568-rock-3b.dts
@@ -688,14 +688,20 @@ &sdmmc2 {
 	cap-sd-highspeed;
 	cap-sdio-irq;
 	keep-power-in-suspend;
+	max-frequency = <200000000>;
 	mmc-pwrseq = <&sdio_pwrseq>;
 	non-removable;
 	pinctrl-names = "default";
 	pinctrl-0 = <&sdmmc2m0_bus4 &sdmmc2m0_clk &sdmmc2m0_cmd>;
+	sd-uhs-sdr12;
+	sd-uhs-sdr25;
+	sd-uhs-sdr50;
 	sd-uhs-sdr104;
+	sd-uhs-ddr50;
 	vmmc-supply = <&vcc3v3_sys2>;
 	vqmmc-supply = <&vcc_1v8>;
-	status = "disabled";
+	wakeup-source;
+	status = "okay";
 };
 
 &sfc {
-- 
2.45.2


