Return-Path: <linux-kernel+bounces-293499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC40195808D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 10:08:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E0B1B23801
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 08:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D759A18A944;
	Tue, 20 Aug 2024 08:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GLOOFGHj"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC90518A6B6
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 08:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724141249; cv=none; b=VHLF5l3Xu9Gqh31X5w9EWlD9qIidwRAQKxCTWYGKTYZ/wnBVxgCOVu3Pf1l4h44j8EJhpFZjDmiNeuBSE0lwaCz5qYTXi+aNyaqNq3jCJ2C7ni82RgTuNGG0f7uemUZkNmZM6oX7iNyHcUEME8M1GxvTP5gNhIyN1aE0ECSvIxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724141249; c=relaxed/simple;
	bh=VEcYQT5x3766vS7r2HfAiZ5/A6Vg6Iz4KN2/9kJJTGM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=urw/rCCRDl8/YOv8cT58hlHWGgzNS08NOWGZ3PKiCu1PNg2SusW197bVrl1j4A6YWQDOJie6w5t5yT6JXXZrocnuG/0wV/x4w4s/E0L12VAfqWrGgC1fDgZFTOI+JK3JIr0BBsD+Qo9BqzCWUzqKWFItaYiMRuYQ+wmmh/lJ5ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=GLOOFGHj; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-710d0995e21so3830894b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 01:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1724141247; x=1724746047; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VF9PjinJER9wjMA+9D6wXT2j5101Rcr5iAVO00wcnuk=;
        b=GLOOFGHjVmPavSd1yxFtQ+Nkg4qQrYOIsdSWDU2uX6R4EdhXn8egGZYvoRZttJsaqA
         q29ZCPYR72IKVFdhqjIQwnuFuUqJpW7EcA/BskDXbk4YVHpuU728q40Ro/SppcimVeue
         eYpcybAp4RPDDqosdLzKjib8DVSQ9ONtCu9/A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724141247; x=1724746047;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VF9PjinJER9wjMA+9D6wXT2j5101Rcr5iAVO00wcnuk=;
        b=JggpD9+PLdv15/rNJv5FShz9rjA8ZypL3tLImz17H9M1X+C55dg0l16xMc1JngQNrY
         8DqE+BhW1mb+FFHLyPML5fBfGmu+8bVo4JxaTOTAvzJk70d1Qt9QO+fOQP7LeWynhaWI
         jb38YjoYOehyXvNUC3HbpZbWVeqt50e4PyUjFBcdseGxloqg9V9xbNG+j6c7rk9fxxSs
         SRGn0HO0xiIB++VckGfBSga5PE1X/VKCl7v/L1W3wS/Vijqd8KqbKhlQlf5a4asD7hEL
         UGIHwapoMC8bL6hL1/IY62cuSUY7/8d7rWayhFBV6WWdrEcyd7/9ajo16WqqCfo9RYDk
         ws9g==
X-Forwarded-Encrypted: i=1; AJvYcCWOpRLEO49Jy9SSxOJ2HZE/YQEIzAcM8HpMNdY6+oqJoxTzqPtIqk+BRFTR53Vsp9Y/8FLlZmnOpsVUDeU=@vger.kernel.org
X-Gm-Message-State: AOJu0YywHItfnXxoBDikel7B6xAwk9o7asSKW5V0rkzWReOqBdM+TS+6
	geddi9rAhW9UPytGc9/zHo3c+eLxd7ZhBcLxXbNwt3KKXoOMMotfm+tINU7Q/g==
X-Google-Smtp-Source: AGHT+IEPf1X/OGkNUtPINTfo4AoKkECt270oSCWZe/9fyUNP+Ezk7UPgYKjiJPWONz6oyBub6ygygA==
X-Received: by 2002:a05:6a00:1a8f:b0:714:1310:15dc with SMTP id d2e1a72fcca58-71413101623mr287077b3a.17.1724141246957;
        Tue, 20 Aug 2024 01:07:26 -0700 (PDT)
Received: from localhost (185.174.143.34.bc.googleusercontent.com. [34.143.174.185])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-7141556ad97sm250991b3a.167.2024.08.20.01.07.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Aug 2024 01:07:26 -0700 (PDT)
From: Rohit Agarwal <rohiagar@chromium.org>
To: chunkuang.hu@kernel.org,
	p.zabel@pengutronix.de,
	airlied@gmail.com,
	daniel@ffwll.ch,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	ck.hu@mediatek.com,
	jitao.shi@mediatek.com
Cc: dri-devel@lists.freedesktop.org,
	linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Rohit Agarwal <rohiagar@chromium.org>
Subject: [PATCH 3/3] arm64: dts: mediatek: mt8186: Add svs node
Date: Tue, 20 Aug 2024 08:06:59 +0000
Message-ID: <20240820080659.2136906-4-rohiagar@chromium.org>
X-Mailer: git-send-email 2.46.0.295.g3b9ea8a38a-goog
In-Reply-To: <20240820080659.2136906-1-rohiagar@chromium.org>
References: <20240820080659.2136906-1-rohiagar@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add clock/irq/efuse setting in svs nodes for mt8186 SoC.

Signed-off-by: Rohit Agarwal <rohiagar@chromium.org>
---
 arch/arm64/boot/dts/mediatek/mt8186.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8186.dtsi b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
index e27c69ec8bdd..a51f3d8ce745 100644
--- a/arch/arm64/boot/dts/mediatek/mt8186.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
@@ -1361,6 +1361,18 @@ spi0: spi@1100a000 {
 			status = "disabled";
 		};
 
+		svs: svs@1100b000 {
+			compatible = "mediatek,mt8186-svs";
+			reg = <0 0x1100b000 0 0x400>;
+			interrupts = <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH 0>;
+			clocks = <&infracfg_ao CLK_INFRA_AO_THERM>;
+			clock-names = "main";
+			nvmem-cells = <&svs_calibration>, <&lvts_e_data1>;
+			nvmem-cell-names = "svs-calibration-data", "t-calibration-data";
+			resets = <&infracfg_ao MT8186_INFRA_PTP_CTRL_RST>;
+			reset-names = "svs_rst";
+		};
+
 		pwm0: pwm@1100e000 {
 			compatible = "mediatek,mt8186-disp-pwm", "mediatek,mt8183-disp-pwm";
 			reg = <0 0x1100e000 0 0x1000>;
@@ -1676,6 +1688,14 @@ efuse: efuse@11cb0000 {
 			#address-cells = <1>;
 			#size-cells = <1>;
 
+			lvts_e_data1: data@1cc {
+				reg = <0x1cc 0x14>;
+			};
+
+			svs_calibration: calib@550 {
+				reg = <0x550 0x50>;
+			};
+
 			gpu_speedbin: gpu-speedbin@59c {
 				reg = <0x59c 0x4>;
 				bits = <0 3>;
-- 
2.46.0.295.g3b9ea8a38a-goog


