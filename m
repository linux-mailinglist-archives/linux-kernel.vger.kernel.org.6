Return-Path: <linux-kernel+bounces-347419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82C8998D274
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 13:48:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 499DE28451C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 11:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77AF5205E01;
	Wed,  2 Oct 2024 11:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gf9wblcu"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AEDF20127F
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 11:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727869623; cv=none; b=p1Qt4mOCogBWNb7+f4xSrcNvQmAafg4WOvEj9F6jn1DtMar5+nzkuqGTVKxxrL3r1QYpRPfyHjQaRwbHfs/1COa0fA4n2Kpd+uRgzAOiKMucYCY4uapRjhqX1PVx1eGL9YEjW9fns6YrkrOkr3UG/605j7cM5eJCN7gV0x3IuLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727869623; c=relaxed/simple;
	bh=yTCk2U7CgZftBRXEy1dJZTvb/880I8dY15oVa2MtGNI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n5fSIe0si1vzRqfvf7nZu/5N7J/EHDbrV25GYXo77fb/Q2sKL30gYunGxGfzxsN8+40SF+RdavhYKiJXe/ijTdZPAgoc23Bx/TcwKh4O+Hm3cTgE1VJgFY/2bQUvI6fkzqt01PWN69wKX4omLy0kSjQRKfcXSgxIN54gjkgTlSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=gf9wblcu; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-71b8d10e9b3so3950884b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 04:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1727869622; x=1728474422; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M1kvp0VcH49Dd7pUdjrxa7BKtPwxncHiMFzmQPvOHBw=;
        b=gf9wblcumQ8N4NSei0DXb+jeHQk6lOv9H/iecSH3f2RjIsmXkVH5clf0gZc45t9zk7
         NIbQWaikXc24db5yZKPWLCGpvv7ONBI1/jn1QC1IRix0iykv05au9lkRfdOP1EJBf57g
         sq6nKa82exQckYyhLrDtEkT3RxaX/dAWYYgf4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727869622; x=1728474422;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M1kvp0VcH49Dd7pUdjrxa7BKtPwxncHiMFzmQPvOHBw=;
        b=EO37K+HPOdhiJRTWUj24dBqPyvcuLeVT3tMk2N7eARs0JWu5CUL3J4he8m0qnOMQt8
         3xBusYV4eolni5FNkG2mMZyJNsYP86jmHXIqVmv5nTaqPektHP66/uB+Ejtx9kAyc0xr
         xpZ0eW8Xcs3rRSwO6eEKCdjDLI3cAIPf9fFQ8LESYqtDjtu5mSTnqNNSeKi8XJRxwmgJ
         ruXpJaqa6DIk3avgw+3qBx90CCF6AoIb6JCbVqjMfjqNgbWhiJ6T0GU4iUH97A4L7gVf
         qYvNfqG1IWbmeHlZsWzQlO2D36dib2EFRmK0H4XmgPur9icu3SDfWtCeMvDXsUSQe4HH
         FZ3Q==
X-Forwarded-Encrypted: i=1; AJvYcCXPx6Frpfpaq3f5rvpy3Z8k9cmLCFydVeOR3dAIdI3sqzA9wJKylGTVqtqqfeIEkuQpAhlB6ZPe2F7NW80=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8397N007KjtdGdS01QTKIl3zSYw0xZZXjkov+aZV83lIqc97e
	iczeKo1fL1vCYeSmdGGfCXtf2bFAzIt1ZssAJws8qTSzyJVRWRzwaRtA/DAJ4w==
X-Google-Smtp-Source: AGHT+IF6Sqgx1tY88G1e9K/KXewRN0uZSr4m6+KJokFU2mORUavDZPLIjw+Q/puV3XntoKVReVaLgg==
X-Received: by 2002:a05:6a00:2d88:b0:714:186a:ae0b with SMTP id d2e1a72fcca58-71dc5d6e144mr4961081b3a.24.1727869621952;
        Wed, 02 Oct 2024 04:47:01 -0700 (PDT)
Received: from fshao-p620.tpe.corp.google.com ([2401:fa00:1:10:3bd0:d371:4a25:3576])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b2652baefsm9639627b3a.180.2024.10.02.04.46.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 04:47:01 -0700 (PDT)
From: Fei Shao <fshao@chromium.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Fei Shao <fshao@chromium.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Rob Herring <robh@kernel.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH 5/9] arm64: dts: mediatek: mt8188: Add JPEG decoder and encoder nodes
Date: Wed,  2 Oct 2024 19:41:45 +0800
Message-ID: <20241002114614.847553-6-fshao@chromium.org>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
In-Reply-To: <20241002114614.847553-1-fshao@chromium.org>
References: <20241002114614.847553-1-fshao@chromium.org>
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

 arch/arm64/boot/dts/mediatek/mt8188.dtsi | 29 ++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8188.dtsi b/arch/arm64/boot/dts/mediatek/mt8188.dtsi
index dbea562ee8ba..c1b057166aa3 100644
--- a/arch/arm64/boot/dts/mediatek/mt8188.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8188.dtsi
@@ -2315,6 +2315,35 @@ video_encoder: video-encoder@1a020000 {
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


