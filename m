Return-Path: <linux-kernel+bounces-296695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5417A95ADF0
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 08:47:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 874161C2264F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 06:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F72315098A;
	Thu, 22 Aug 2024 06:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lqYrXSKe"
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7778513C68E
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 06:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724309237; cv=none; b=mQ3K2Niqo2wEQNFCLsekcN2j6FcObB+s++Nbyk7RAKbZpywexSEUxpHP8tDz2/AEHqFFmsMzOPvdR3VCPRVGd6Fpl5JHb2dFPC9X+hVK4MmjhT5NNoSfKMJkIWgMrzk+zZp0opn5Sh2qAWWXiXOMPDWCbpg5KXjk0zjIXCjFgPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724309237; c=relaxed/simple;
	bh=VEcYQT5x3766vS7r2HfAiZ5/A6Vg6Iz4KN2/9kJJTGM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r+6GAmOpue3HY5i28sNtAtDpyUo3muqjBBL/y44XmqOBBWiK7mqrscgBhq99Gcvih7UfiBOkVM6NeZ+KmT3jAm5bex8PDlDbUitvPtPXLO25/Tp1xU4uvhRaPi3X4X9DqeNooSXW2iNTmu6IgFBUjyiXha1xQF6Uq1/Qwlr5zUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=lqYrXSKe; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-2701c010388so238760fac.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 23:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1724309234; x=1724914034; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VF9PjinJER9wjMA+9D6wXT2j5101Rcr5iAVO00wcnuk=;
        b=lqYrXSKe5aLlar5Cj0QDqPqkEDd5JQ1DusK2IMppuou7CWNbP/RA6f360KB+EVrFI2
         v+ddxtrMuL1sbDnghdGqoND6d7YNPCzOBZYKvt98Rks//RW/pJx2eBpaT8rP6er8aJag
         w98Ic7nGC44G6DQBleV7vz/VqecoXfZkYtUUM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724309234; x=1724914034;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VF9PjinJER9wjMA+9D6wXT2j5101Rcr5iAVO00wcnuk=;
        b=e4oZzY3YS4VzcXVcbUTP/uRlXqWWdFJH1OCN3yuWTMM5anY9Upwx6KMXUrIUGdAqgo
         hl/bNqg4biDjeQgHBS8vhCEUxMo8zVuzZc8lpr3kmKDf2vrC6+zHNjioj7mjQDluy506
         AbWqbxtprhNpJX3JiZLO4qdZd1lxL1H6SSYKLEdIcjYbQnmZ6b7iklKhF5iaAMol5lim
         fwbEgZwSofYBzxmnbUItSnQNOhhRL08pHMtD69EuRK96pBTXBwBOA4GFhXacyMd5vFSQ
         833iKv2dMjURCRUDAEdOKeX8g9esSuvZbeP9kN/ZYGUHRTuz0Jb9jNVkx2BiCx2+z1ne
         X5Mw==
X-Forwarded-Encrypted: i=1; AJvYcCWjWo8V2gRsV3u3YKtPW3Be8AIbMpzCBEk0lxVoIz9FpaNuhpDIFqYx7kq3suGf6vcqCz2TDw8PfKQxTbc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxst6Lubr5WkkgCMf4U8Ti+UKvcSA6UqUWvS0NkXiQJT2dHTsU/
	7IR+CgqgjajeKIcg24o5pXBMt9JFKagayzp5fO1ieIVCLf9uUx8U4gYHp3RykQ==
X-Google-Smtp-Source: AGHT+IGrUfTOkboBsPUwPI3QFIqP0YcLyJ19ev6z6avzO4hsPA9b8UhcQhr91d3x2cfdkibvPWSpUA==
X-Received: by 2002:a05:6871:1cb:b0:25b:6d53:d294 with SMTP id 586e51a60fabf-2737ef7d20bmr5327067fac.23.1724309234476;
        Wed, 21 Aug 2024 23:47:14 -0700 (PDT)
Received: from localhost (185.174.143.34.bc.googleusercontent.com. [34.143.174.185])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-7143424a530sm698129b3a.51.2024.08.21.23.47.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Aug 2024 23:47:14 -0700 (PDT)
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
Subject: [PATCH v3 3/3] arm64: dts: mediatek: mt8186: Add svs node
Date: Thu, 22 Aug 2024 06:46:50 +0000
Message-ID: <20240822064650.1473930-4-rohiagar@chromium.org>
X-Mailer: git-send-email 2.46.0.295.g3b9ea8a38a-goog
In-Reply-To: <20240822064650.1473930-1-rohiagar@chromium.org>
References: <20240822064650.1473930-1-rohiagar@chromium.org>
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


