Return-Path: <linux-kernel+bounces-363918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A392D99C873
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 13:15:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 288791F22D02
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 11:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85D351ABECB;
	Mon, 14 Oct 2024 11:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZmhVdIxL"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C20E1ABEC5
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 11:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728904289; cv=none; b=oSyOTu9ggAKej8Oo1uHBhWQ/BartPeW3lI0PgM/QZ549bLheDHcXq1u6kx68VdY170MKm6gqkf5XnnZZ4skjeWLi665X0qPf8Xd1O4j5rZAqT0Vu7RfEneuZzLcWn1QM/EauOo2y5jfgYagVloC2DcV/Z/DK7TYEanL6pkaxde4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728904289; c=relaxed/simple;
	bh=GnOkoIePkuB+mF2MXNqTIm13tio21R4W9hTGFqVzjVw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hUNwd5uOBZZk0c4AHWxi88bZ4JEV2ggTW+BcEhqffCXJNQcLQ6SUcadXW07DvtzdpO0WVYKRPujqPudDkJtRXxwb277umjDrA0ysaeC4Bbja9ntZyyKJC4k5WoRwNEc6VNOPOPtUSW6TWd9Fo2cjzSzaBKbTDE/EKJ+00WjRcOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ZmhVdIxL; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-20c7edf2872so30859815ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 04:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1728904286; x=1729509086; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JzRjb+S8zyoCwq6LpSDCmXTOKhtLT2g1jRj+6KgRZV8=;
        b=ZmhVdIxLZ7HWQ2J+HPx10PqPq+BrYv9KM9/bOISC+iiRLRdDF5aW/T1Q9XnPfAlEH8
         8uFeaITTJkPwaJ/N+ySbSVs34VS8u9JNkdU5d1xAxoEFYWn9pa/ZdyYf3jbTirje0ctP
         JWpKZiD+ND0MgX+I35zAW/PmqcQVJS4hRNZnE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728904286; x=1729509086;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JzRjb+S8zyoCwq6LpSDCmXTOKhtLT2g1jRj+6KgRZV8=;
        b=uKnQ8ZgOVef9v/ECHKcGXfmjygIPLfgrIuId9898AJtH4n0u/Qe00BPo52lhQfVxHB
         h0i4XvPe/RN4y2KR8eSFDxBbKcBNc0Wz4Bu/ixwA2DA715hXWLJXjcrjPAH5tMB0KQ4z
         owsIQGpwjqcag2r+kDfB69TzVjQlO0jQCuMiF7gVbvwvgtQ54r9mH0WndaWEcsvPQgar
         BvE8aLhfBydXbXLI96XloM7NUxZdu2UhTWxorgOYYAqRuc7Ox+ifEf3xjFVxivBfb0qq
         C7D+0r4CLoMe6E/fLL8i0+xilDee8QpqhgUI5xHGwHLhZQgab57wkthBIeZtFrTiVuSR
         OZ6g==
X-Forwarded-Encrypted: i=1; AJvYcCW7pbyGF8Byh6eYqJsYdwDPQyE/02ntdTurgA29d3N78vScIDPgugGT7040Yr6i7yruQfbvVN/+WG3JN7s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4ecCArtrQr7E5wZjwuveSI3qgH++tJhEJCP+VXWLVpWZwNDBV
	8rw6khtTLZKyJje7kZpQTsIosuav9D891uz8S/wEuu69k35tA0HYnos9v8h/qA==
X-Google-Smtp-Source: AGHT+IELUu+qrYGjcjMowi7359iDu4Heemy/A3/8LsSdVAlzuHR6kP5CWQn9jo3hK1Lq1jF5k4GIZQ==
X-Received: by 2002:a17:902:c406:b0:20b:6c1e:1e13 with SMTP id d9443c01a7336-20c804ee35dmr226867335ad.23.1728904286674;
        Mon, 14 Oct 2024 04:11:26 -0700 (PDT)
Received: from fshao-p620.tpe.corp.google.com ([2401:fa00:1:10:4907:d52a:1a1a:58d0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c8bc3e6fcsm63858285ad.118.2024.10.14.04.11.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 04:11:26 -0700 (PDT)
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
Subject: [PATCH v4 5/9] arm64: dts: mediatek: mt8188: Add JPEG decoder and encoder nodes
Date: Mon, 14 Oct 2024 19:09:27 +0800
Message-ID: <20241014111053.2294519-6-fshao@chromium.org>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
In-Reply-To: <20241014111053.2294519-1-fshao@chromium.org>
References: <20241014111053.2294519-1-fshao@chromium.org>
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
index 57f283be4402..79bb80f4b7e5 100644
--- a/arch/arm64/boot/dts/mediatek/mt8188.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8188.dtsi
@@ -2327,6 +2327,35 @@ video_encoder: video-encoder@1a020000 {
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
 		disp_dsi0: dsi@1c008000 {
 			compatible = "mediatek,mt8188-dsi";
 			reg = <0 0x1c008000 0 0x1000>;
-- 
2.47.0.rc1.288.g06298d1525-goog


