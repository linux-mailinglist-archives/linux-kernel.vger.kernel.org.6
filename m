Return-Path: <linux-kernel+bounces-295217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D847C9598B8
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 12:58:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 911972819FA
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 10:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 206141CCEF3;
	Wed, 21 Aug 2024 09:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Cy0aKsfP"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310B01CCEF1
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 09:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724232451; cv=none; b=Tb+9++ypP2lWYexqZw8qx8dZatf6EohZtBofIasUKTN6lni067YNzExRuBxTAzLP98aut1Cu0H3QAN6kXdsHXakxO7//rWcpWx3keH5nT5pmQmkOL5DVW1TBC5Jcs+VXPE9N9PQjJb38qpJaNCtVf8YgLfXR12lVg8oyuK5WbGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724232451; c=relaxed/simple;
	bh=VEcYQT5x3766vS7r2HfAiZ5/A6Vg6Iz4KN2/9kJJTGM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ITt9yX0wcJdxuUqfPeZlHLDJ2PEjpseDku1iIWg97hMzdiaL0Fwl5uCmjoay2dcnyRZHm1ANTFyOTuCOBFrpQ3uWK2vr0l6yR+BLVq+2MXKXhfbrAQATNDHHesPXnqCxg4JJ2VB67nUJnI3ARkR4iecVwz25YPL3oix6eaggGOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Cy0aKsfP; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-70d1a74a43bso4473920b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 02:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1724232449; x=1724837249; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VF9PjinJER9wjMA+9D6wXT2j5101Rcr5iAVO00wcnuk=;
        b=Cy0aKsfPo5mt8KGq8R1/sOOOos9ZqPyWvgFGvPht+SJpk6kN6WLd8xIa7reIybMPiB
         G2H5vInD67KoW+ZibLPw3/KlVPPIYI0T7RfE28ircMQDM8r+WejpUkizeRyMZDqxv0wt
         pLagjySAkJlpd5nnJZJ/b0ZMRM0eDrNEyBeeQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724232449; x=1724837249;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VF9PjinJER9wjMA+9D6wXT2j5101Rcr5iAVO00wcnuk=;
        b=CCK4CZaOUHsKVwo61kS6HvkvGPyiPHw0PBhbx2ugc9fbFrEG9stfEys6WzgDewFjIh
         ow296Rh1lvjCw0S7sg5kUWDYO1z2fpRhgCbi4Yb1jHhS5WiMg8TBIeVoz9n+OBXIARxl
         lsp5s6U55ntJW0afGTPtZzngnTr0eObX/D5mI82FC4O1GRHQxzVj/uU8d7YGGqo9+BLq
         oefh6UgqeHA5EDj/9wYI9MJk6e/uZO7h2tJJOn7QPsOXVSJgbvIG/XCyWbyqpKhbhGrP
         45JIVYQVEDxA3HdVfbD8Mfk6opLBlBjvJ0obsqWBxOW7l2StWw44rV3JVRXBLypFuPt2
         pBBg==
X-Forwarded-Encrypted: i=1; AJvYcCXAAjLuz4XDJ8CD/v8Ap+8cq7KXj1uMcGu8rjtEOLrAKwRehIU8exWQ1V2wwgeRG08OoDKUrTKAthJ0Otc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEiqxRwfEtcLdv343N2hnEOtbtx4ZR562bt2j8ZNstwqe7BA3R
	8Bbw01QumIpQvPY/oi07JEFyBFgRxEnzHkPi/66H+N1I5yEb3f7fUqphYr0WMg==
X-Google-Smtp-Source: AGHT+IFnfIrNiUomfEp1ttryB9uQgWfxL55rhoeddUhSzpcz4uk60NiwIgmgyqLVCB/iQ59t6moGxQ==
X-Received: by 2002:a05:6a20:4392:b0:1c4:b302:ad14 with SMTP id adf61e73a8af0-1cad8160aa4mr2007740637.24.1724232449282;
        Wed, 21 Aug 2024 02:27:29 -0700 (PDT)
Received: from localhost (185.174.143.34.bc.googleusercontent.com. [34.143.174.185])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-201f0300844sm89985195ad.47.2024.08.21.02.27.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Aug 2024 02:27:29 -0700 (PDT)
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
Subject: [PATCH v2 3/3] arm64: dts: mediatek: mt8186: Add svs node
Date: Wed, 21 Aug 2024 09:26:59 +0000
Message-ID: <20240821092659.1226250-4-rohiagar@chromium.org>
X-Mailer: git-send-email 2.46.0.295.g3b9ea8a38a-goog
In-Reply-To: <20240821092659.1226250-1-rohiagar@chromium.org>
References: <20240821092659.1226250-1-rohiagar@chromium.org>
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


