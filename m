Return-Path: <linux-kernel+bounces-348641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6DB098EA01
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 09:03:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DD412830EB
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 07:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43159139D07;
	Thu,  3 Oct 2024 07:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PBJ9IsPP"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51337136328
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 07:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727938921; cv=none; b=jIaA+6QM5Wg2IXICQrZKsE5Oy6nJm9JHoQKNIQ3EpOTPVx4u27LmlD91UAK8Obe8IK1MU+7H748ayAziRti7Qx5Wh7VfQ71hCCBMa8YwDq76j9viTCx7VCsSIo6UBk32GzVGWdp1S8J3Wq+8Hzrcr55vt2ECE16/GU2TU3wPgC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727938921; c=relaxed/simple;
	bh=BQd/K0GfhQ8esTLAa/m+wQzT5OPcp3nOxWz4nz8a98A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ag5+qYE78AdpH8/rvnwAGgjkQ5/4EfGLH7yRsYRvbBh/rFBJVtEyMkG8vt7VEXnJazXEBHOwWw2ZIiAw8Q1MZC2/4MycSuDiPoy1lC6Ip23OfJoxXDOLvLf3HIr8m4E4umLrIaRbcBo+dc6W/v+bnFAWtXHY8Ygi+480hHU37HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=PBJ9IsPP; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-718e2855479so510205b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2024 00:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1727938920; x=1728543720; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/d/o7lkyrEK7MdTXzGL48vZFksOeTQ6shmZULA6Dpk0=;
        b=PBJ9IsPP0cLyJCby0qJZuptJuJGYFUpRTnXZwInTFU4ZrFezrgdrHBvnce72smPuKY
         L7maUVOilyq8L0OtFEZtZM/5n9RG4Ip9nnQa+FYp1nRDezsgG6S/WEwVGIHpbV4+ov5w
         x5xR/mWF1BipQzLhi3ZiOjFmWpFEfjr2Nx9wg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727938920; x=1728543720;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/d/o7lkyrEK7MdTXzGL48vZFksOeTQ6shmZULA6Dpk0=;
        b=S/grNjqP1jAuTOo2DCdmMeMKkwbHvRf0xsyYVRgOxwJTyGpSuj6TiWWJArzq7d1qB1
         kz47MYdLLl6F8xvS0vLbf2w3m0gWEEs8S7Md17FxP0fjFuGosSYRYgXRklRMvTEQVeo5
         ekMspmb1r7LnKtTqEVQL2HT08nwsInuv2Bp964uJyrPAQkmGBT0Exq5caQDVcwdGI2zi
         O50PXLkW1iZNHFdwSno9RbeSTt0foZzMWeh2TEpVw4usTKgboiLlm1gK0hhf83dfWU2g
         btHESbC1frTTpKcayxvaT+ws+zQDZWuT0+ETnseLzMzU6i4c3a3Pt1XtotUgSGr/aJv7
         s3HQ==
X-Forwarded-Encrypted: i=1; AJvYcCWws0CGChnfkq6HW8LIJOQ2O+pY/3Svo6Cjl6pVaIfJCnOd5aOAymnJfi29boFrguoDdoyzkJWCGExYP0E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPUeJXbiu34liioU1sFxRVbY5HrldwJA3x40M/VtScdjAFNLLf
	U1Xu/uHntzjTOyip+panCrq3WjQaSIrPR82PFhjFKQFXmBbrH8P8Y56LVIo50Q==
X-Google-Smtp-Source: AGHT+IFh1+pRTF5QP2Z4S/FKW/7aJxh3DsNrBR5NMDBZX20D5QgF1Et4sk3LUOF99xcybVx+7A1zsw==
X-Received: by 2002:a05:6a00:a14:b0:717:81b3:4c7a with SMTP id d2e1a72fcca58-71dc5d6e0dcmr9516899b3a.24.1727938919636;
        Thu, 03 Oct 2024 00:01:59 -0700 (PDT)
Received: from fshao-p620.tpe.corp.google.com ([2401:fa00:1:10:3bd0:d371:4a25:3576])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71dd9d8e473sm633782b3a.81.2024.10.03.00.01.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 00:01:59 -0700 (PDT)
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
Subject: [PATCH v2 5/9] arm64: dts: mediatek: mt8188: Add JPEG decoder and encoder nodes
Date: Thu,  3 Oct 2024 14:59:59 +0800
Message-ID: <20241003070139.1461472-6-fshao@chromium.org>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
In-Reply-To: <20241003070139.1461472-1-fshao@chromium.org>
References: <20241003070139.1461472-1-fshao@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add JPEG encoder and decoder nodes for hardware-accelerated JPEG
decoding and encoding support.

Signed-off-by: Fei Shao <fshao@chromium.org>
---

(no changes since v1)

 arch/arm64/boot/dts/mediatek/mt8188.dtsi | 29 ++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8188.dtsi b/arch/arm64/boot/dts/mediatek/mt8188.dtsi
index 49d4180595a9..0eb57f95bbaf 100644
--- a/arch/arm64/boot/dts/mediatek/mt8188.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8188.dtsi
@@ -2317,6 +2317,35 @@ video_encoder: video-encoder@1a020000 {
 			mediatek,scp = <&scp>;
 		};
 
+		jpeg_encoder: jpeg-encoder@1a030000 {
+			compatible = "mediatek,mt8188-jpgenc", "mediatek,mtk-jpgenc";
+			reg = <0 0x1a030000 0 0x10000>;
+			clocks = <&vencsys CLK_VENC1_JPGENC>;
+			clock-names = "jpgenc";
+			interrupts = <GIC_SPI 354 IRQ_TYPE_LEVEL_HIGH 0>;
+			iommus = <&vdo_iommu M4U_PORT_L19_JPGENC_Y_RDMA>,
+				 <&vdo_iommu M4U_PORT_L19_JPGENC_C_RDMA>,
+				 <&vdo_iommu M4U_PORT_L19_JPGENC_Q_TABLE>,
+				 <&vdo_iommu M4U_PORT_L19_JPGENC_BSDMA>;
+			power-domains = <&spm MT8188_POWER_DOMAIN_VENC>;
+		};
+
+		jpeg_decoder: jpeg-decoder@1a040000 {
+			compatible = "mediatek,mt8188-jpgdec", "mediatek,mt2701-jpgdec";
+			reg = <0 0x1a040000 0 0x10000>;
+			clocks = <&vencsys CLK_VENC1_LARB>,
+				 <&vencsys CLK_VENC1_JPGDEC>;
+			clock-names = "jpgdec-smi", "jpgdec";
+			interrupts = <GIC_SPI 355 IRQ_TYPE_LEVEL_HIGH 0>;
+			iommus = <&vdo_iommu M4U_PORT_L19_JPGDEC_WDMA_0>,
+				 <&vdo_iommu M4U_PORT_L19_JPGDEC_BSDMA_0>,
+				 <&vdo_iommu M4U_PORT_L19_JPGDEC_WDMA_1>,
+				 <&vdo_iommu M4U_PORT_L19_JPGDEC_BSDMA_1>,
+				 <&vdo_iommu M4U_PORT_L19_JPGDEC_HUFF_OFFSET_1>,
+				 <&vdo_iommu M4U_PORT_L19_JPGDEC_HUFF_OFFSET_0>;
+			power-domains = <&spm MT8188_POWER_DOMAIN_VDEC0>;
+		};
+
 		disp_dsi: dsi@1c008000 {
 			compatible = "mediatek,mt8188-dsi";
 			reg = <0 0x1c008000 0 0x1000>;
-- 
2.46.1.824.gd892dcdcdd-goog


