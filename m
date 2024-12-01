Return-Path: <linux-kernel+bounces-426702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4F969DF6D2
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 18:50:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99578281AD7
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 17:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72F6F1DE4E9;
	Sun,  1 Dec 2024 17:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="KX2GhOKQ"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3FE1BC094
	for <linux-kernel@vger.kernel.org>; Sun,  1 Dec 2024 17:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733075272; cv=none; b=RYEeBgyivzpjjhLrSo4OY3NC9CXv9k0maqn+Rj1iyENxMysOzHdDwyvKnWM0jJOpRFFSpl9EKp+oI8yr4Pr7NYtr6DF0fkBOGS9Hc57G82q3eneXAmOKK2dZdUeKp7/Aoun05AM2S30gGBQMth4CAX/nlYb76Kc5yFbUae1m5gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733075272; c=relaxed/simple;
	bh=FRFUyZwPX4G/0Cai4GmO9ovi+nkQmDVraCIaymyOQS0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sHdtapwlcBOOV0qNJZG77870XLiVaoNmGZlVEeFdxcdfD3om3PUsZDiWT8o1XnUPWYk+sDiWvLBeHTDFICFXq2U+jVyuZ4lDZ6Mald0BKOAWdI5fBx6AJHty86HmnFel4i51KPLnZoaQfhiWohIDHK+YHENzGN/VOCnZW5TssYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=KX2GhOKQ; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a9e44654ae3so453339966b.1
        for <linux-kernel@vger.kernel.org>; Sun, 01 Dec 2024 09:47:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1733075269; x=1733680069; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C+h8roym6BKL4klc060XmQbisU15KKTnjExLT+vczjQ=;
        b=KX2GhOKQ4lf0X/+8OsWJ99PqZcZXcFdEacNbnuj1R++QGZCl9SUOBwHkdLMqO9rMPP
         3THG8f2SoGnIdywHvDocSCem5wgRQOi5W1Qa2aLOo7dh0bOCnm+v7CV829I/CafU2wWE
         cr7qwEHcWyOje3ifU1Y1hM05/OyLr2VItj8FE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733075269; x=1733680069;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C+h8roym6BKL4klc060XmQbisU15KKTnjExLT+vczjQ=;
        b=R3HA7zDHEFD+bOuEORzQ3Qrbo0oZRNziMUEj3fDS6LYLzeAli6B8rKatUz3OaPYymc
         Y7O7WP7fTkeX8oWfXU9hwhRQOMTUxvfXaRAK0X5qlDNGKY+PL2hJvnWfNm3Lw/Z+aiuC
         3VnjWwl/9wuSUkZgCLMI7U4cBUsqRaRlODKyv/l/gr67NAgOTSp06zyJR5nIqQLds0j1
         YnQu7ZxX+H2snr3NjOKA2GuiYesIEWTpyhFUEMKPL3CKTiUkU1gxNfP69b0MbSbR0lut
         hPQ8uA8L4mdIFMzGV4jJXIeOxeh9fK+XWe4KrhKQNqiG9EQ5cKtCGpKEIRcip2bcB3Vg
         sOcw==
X-Gm-Message-State: AOJu0YyFRRs6hkulpWoC3S3UHublEVZMH4WjklINFRh5jT5yDaAyg8s7
	wCp//dQ7Izi0B7YzwoPAfUG8kJ6q7tWPJ9jrDVnbJWtyo8t8GlxlN6A/bCuuh6B6D5zKYZDjFde
	2
X-Gm-Gg: ASbGncvcEmD7eHsKRjnLkX6vvUes9NmNDO4YinO+TIt/LWs1CDT0bQyo7qGCGAsUVYn
	rUtcO4XhDpiKojvXCP/sSIYoXC6gsKPP3NeGs2Z6eY64XNwEelpq4Sx+ldDk4DhJR/uion1YLit
	dKrSd8VX3HMngbdoYywARdFyIYSXNuzZiB3gGv6w6flM3cmZFLiNMQ1fJQIRUd5lC1HnjRiCD/3
	hEi4dCftVw373cY1p8LBRdcc75hOh8312QLq+ny6ewCRyeYWJKxGA5+ShMuwkwze72/hMlshfT2
	ovnsqCnxjFvpLjIMsjuVfjsaiGCM7sKe5QhsHw0G0qVYNMd5VQjGYa5Yx0iMELvM6UXZ+Je1szK
	bELJ+kB6hRjie6jY0
X-Google-Smtp-Source: AGHT+IHcG2/XEmp2qpnejnJb7rN8m4vpml4qw4y1T/GeofPNf27UqhM/khEJJ1uq/MGoaT5KNjmbrQ==
X-Received: by 2002:a17:906:3145:b0:aa4:9ab1:196c with SMTP id a640c23a62f3a-aa580edf60bmr1451047166b.9.1733075269496;
        Sun, 01 Dec 2024 09:47:49 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-82-54-94-193.retail.telecomitalia.it. [82.54.94.193])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa59990a78esm415220066b.163.2024.12.01.09.47.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Dec 2024 09:47:49 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: linux-amarula@amarulasolutions.com,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Fabio Estevam <festevam@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 16/18] arm64: dts: imx8mp: add PLLs to clock controller module (ccm)
Date: Sun,  1 Dec 2024 18:46:16 +0100
Message-ID: <20241201174639.742000-17-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241201174639.742000-1-dario.binacchi@amarulasolutions.com>
References: <20241201174639.742000-1-dario.binacchi@amarulasolutions.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the PLLs generated by anatop to the clock list of the Clock
Controller Module (CCM) node.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

 - Added in v4

---

(no changes since v1)

 arch/arm64/boot/dts/freescale/imx8mp.dtsi | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
index 0b928e173f29..861bd4f4dced 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
@@ -751,9 +751,14 @@ clk: clock-controller@30380000 {
 					     <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>;
 				#clock-cells = <1>;
 				clocks = <&osc_32k>, <&osc_24m>, <&clk_ext1>, <&clk_ext2>,
-					 <&clk_ext3>, <&clk_ext4>;
+					 <&clk_ext3>, <&clk_ext4>,
+					 <&anatop IMX8MP_ANATOP_AUDIO_PLL1>,
+					 <&anatop IMX8MP_ANATOP_AUDIO_PLL1>,
+					 <&anatop IMX8MP_ANATOP_DRAM_PLL>,
+					 <&anatop IMX8MP_ANATOP_VIDEO_PLL>;
 				clock-names = "osc_32k", "osc_24m", "clk_ext1", "clk_ext2",
-					      "clk_ext3", "clk_ext4";
+					      "clk_ext3", "clk_ext4", "audio_pll1", "audio_pll2",
+					      "dram_pll", "video_pll";
 				assigned-clocks = <&clk IMX8MP_CLK_A53_SRC>,
 						  <&clk IMX8MP_CLK_A53_CORE>,
 						  <&clk IMX8MP_CLK_NOC>,
-- 
2.43.0


