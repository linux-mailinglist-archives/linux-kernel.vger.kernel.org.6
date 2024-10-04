Return-Path: <linux-kernel+bounces-350021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C5FD98FEC1
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 10:14:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 210BA1F243DA
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 08:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A702613F43B;
	Fri,  4 Oct 2024 08:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SLznpBWl"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF7E140360
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 08:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728029593; cv=none; b=TxGavgftGtxyF2Ixra7rYLn5g16DWH3mseo65wAqXajIhWypfFdSVGIHDaFC5Jb7hXcZFpx61SaPK1PriawPj2gnvn4kiOHX9sEbXpeM80uB3snsp1nddNHSDpVTG57ckH3gygdyOYZvGQ3o6gRNbEe7cGiu0NvyI9qXCU6fIAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728029593; c=relaxed/simple;
	bh=uxyWLD5dh7h0Mh0aBVTfxH5YILsrVLKXtv94ykKER5I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FxfEIW/v+tDrfT8FPpZa2U0qmneswm4VTNdmnul3pkXJamJ5sN/CKYqMChfHeBfPA74rSRcm0VmTgQ5XLuJvRpvUFnNyFhUE0skIHhc6opAKtfJ7o2D7Yo+AuOKcaz9crH/P58vglDZU89xxuB14JWguem/yEks4RXpXtwbq9Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=SLznpBWl; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-20b0b2528d8so20935095ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2024 01:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1728029591; x=1728634391; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GN85sCKrVOA3tu4HmVxI2QI8ZoLBkf3gydcFUAN5vhA=;
        b=SLznpBWljOohzvu6mp/NWiFu7XEnmZrpTG4ZimrWZmQ+E0DPKqggPENYz+Os/X+lwE
         FQ+4AGxhvpY1RjvGhzhz5xLz8wfyrBWJyLmm2hL39cd6T4TRzM9tiXQKFrinVlugD8Od
         /tPSIod/CEylvyViwNv1SSGLK/skWn0F2ECXE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728029591; x=1728634391;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GN85sCKrVOA3tu4HmVxI2QI8ZoLBkf3gydcFUAN5vhA=;
        b=fWldSD/+I92DqP6XSXLBbYY66De7gKVv++fRVwu/dNFNFyYoFV1iIKYs9IfRyYjxOP
         uE2q6JoKze4VsRTlO2kd58Yc+VsFFTz7acz1OTqVDPonQqCVoREVPP7drgvYQW+Eg79U
         RbMXeUIHgbOb1867biPGcqn9CTaC04eoTBeoa7Rg9byUNghDoK0omRl0CHOikR2GwTMk
         ZsiNrlPv//WE4oPzbeducAnevaMmit82SQ425DWv1nth2Dr1xSxW3FSuRO2NzgBVREUS
         MZ3T5i41JvEw63eBfaf2hH3YEGbLF2f2vHe+CyI2IkwapxqQwZ87QEG6EaeC6cIVXXSD
         eliA==
X-Forwarded-Encrypted: i=1; AJvYcCXZPvTAY102gdq+7uF8RZer2Gtxl1MX0/Pnj5N2tPkERrL0t5gFWCNfxwJn64vBw6Ng2nu92zip4h2fxYs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtX/4zepzpkJl7vOJF9/0VQU547g29d62R4NVd6HWt3lCCfpqO
	8mbdJrjVrPzR0k7PX9Tj7RtxZhG0D9+2IbyqRxQrv5xaRjjln1U59UQ4sSF6/g==
X-Google-Smtp-Source: AGHT+IE6hBhfSi7O3sSuEyG5gBp6fSKltdiW7DF90nxxWftNyyRn2q94R5o8RRcdXS8Hi7NBzU9KiQ==
X-Received: by 2002:a17:903:2349:b0:20b:c1e4:2d77 with SMTP id d9443c01a7336-20bfe494b6dmr27155845ad.38.1728029590960;
        Fri, 04 Oct 2024 01:13:10 -0700 (PDT)
Received: from fshao-p620.tpe.corp.google.com ([2401:fa00:1:10:73bb:cecf:e651:2ce6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20beefad264sm19401305ad.205.2024.10.04.01.13.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 01:13:10 -0700 (PDT)
From: Fei Shao <fshao@chromium.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Matthias Brugger <matthias.bgg@gmail.com>
Cc: Fei Shao <fshao@chromium.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH v3 9/9] arm64: dts: mediatek: mt8188: Add eDP and DP TX nodes
Date: Fri,  4 Oct 2024 16:12:01 +0800
Message-ID: <20241004081218.55962-10-fshao@chromium.org>
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
In-Reply-To: <20241004081218.55962-1-fshao@chromium.org>
References: <20241004081218.55962-1-fshao@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add edp-tx and dp-tx nodes for the Embedded DisplayPort (eDP) and
DisplayPort ports to connect to DP-INTF ports and panels, and add the
efuse cell for the DP calibration data.

Individual board device tree should enable the nodes and connect input
and output ports as needed.

Signed-off-by: Fei Shao <fshao@chromium.org>
---

(no changes since v1)

 arch/arm64/boot/dts/mediatek/mt8188.dtsi | 26 ++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8188.dtsi b/arch/arm64/boot/dts/mediatek/mt8188.dtsi
index 8864f1ead663..3b71d01d41cf 100644
--- a/arch/arm64/boot/dts/mediatek/mt8188.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8188.dtsi
@@ -2021,6 +2021,10 @@ efuse: efuse@11f20000 {
 			#address-cells = <1>;
 			#size-cells = <1>;
 
+			dp_calib_data: dp-calib@1a0 {
+				reg = <0x1a0 0xc>;
+			};
+
 			lvts_efuse_data1: lvts1-calib@1ac {
 				reg = <0x1ac 0x40>;
 			};
@@ -2882,5 +2886,27 @@ padding7: padding@1c124000 {
 			power-domains = <&spm MT8188_POWER_DOMAIN_VDOSYS1>;
 			mediatek,gce-client-reg = <&gce0 SUBSYS_1c12XXXX 0x4000 0x1000>;
 		};
+
+		edp_tx: edp-tx@1c500000 {
+			compatible = "mediatek,mt8188-edp-tx";
+			reg = <0 0x1c500000 0 0x8000>;
+			interrupts = <GIC_SPI 676 IRQ_TYPE_LEVEL_HIGH 0>;
+			nvmem-cells = <&dp_calib_data>;
+			nvmem-cell-names = "dp_calibration_data";
+			power-domains = <&spm MT8188_POWER_DOMAIN_EDP_TX>;
+			max-linkrate-mhz = <8100>;
+			status = "disabled";
+		};
+
+		dp_tx: dp-tx@1c600000 {
+			compatible = "mediatek,mt8188-dp-tx";
+			reg = <0 0x1c600000 0 0x8000>;
+			interrupts = <GIC_SPI 458 IRQ_TYPE_LEVEL_HIGH 0>;
+			nvmem-cells = <&dp_calib_data>;
+			nvmem-cell-names = "dp_calibration_data";
+			power-domains = <&spm MT8188_POWER_DOMAIN_DP_TX>;
+			max-linkrate-mhz = <5400>;
+			status = "disabled";
+		};
 	};
 };
-- 
2.47.0.rc0.187.ge670bccf7e-goog


