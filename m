Return-Path: <linux-kernel+bounces-350017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F60798FEB9
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 10:14:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64F69282B3C
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 08:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31B0713D53A;
	Fri,  4 Oct 2024 08:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gB2wdCEC"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42EE6142E83
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 08:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728029581; cv=none; b=ouC9gZ5HEVsoWt1vP2kR6pO7aDgkFGCLH/zzUjF/xOYfAlFm/tzbeSzdxhAI+jsj/p3uJv2H7KW9Eif7pS+0xaIqHTnT44M2XMXZlxNDhR2mGtIpuvnSqJA+OTvYZIzRPmXtcEE0GPDvEj9VkBF5xtp2ibCbJuRkBB2gHSUNewo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728029581; c=relaxed/simple;
	bh=hd5Srt28l3TLt9oVH9HGicSBLdSBZuEY/6ZQ2mt/jqo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JJpLLj7cdw9fKuaXcB5pxDSpBzubBJNEFGrSnkJNnc2f5mpjdsv8bAened3DeAyKYeWQEd7XXOtJNbIjiacWA+uSkNDMF4d7e1Iz2mvzZyFP6nzbUoYrwFOPsJf6umlCw2yJ+r7uBTRP2UgoRf1l6QWH4TJBiwQckXVB75IoHGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=gB2wdCEC; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-20b5fb2e89dso14233675ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2024 01:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1728029580; x=1728634380; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9DhL+yqm4JWemXjqVREhHsRQssA7CSfL5kIS59CVyeA=;
        b=gB2wdCECJZvG01a31pPw0q8CtsAh6w9Q31JCqSpTT5osrblZbhJ8bTumyoNckpoccQ
         xW+ywVx/JbNiRKwPxRuAx+gaBDF5t4CR6RZD+drqXukooBRXtsiFjlxWXIzbFiPatovj
         k3WbOyHSqX0jEKgWISiW735szCkLHCcSk3D+o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728029580; x=1728634380;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9DhL+yqm4JWemXjqVREhHsRQssA7CSfL5kIS59CVyeA=;
        b=BkzBz8hTeNkx+pJ5tZAsRzOF/3vYTl1m/h/LmQgr9WxwH5npz/IoZx3qw8UZfhQcwF
         6e9BiGEVt08WM9R/Zr4QbNXuRftkLp9RCsn93HdPIeJp76XA9bdDI75eZHUelZFDUVQZ
         RbyFnnmfrxoljlNoO8LGRcyhnAwLQpm7V+MLHTtlKhhrHOGjfZZOrH4uGmg/VsW9p5vb
         hX4FYd7RulqAut+vr9DX9PnY1JmRQw6V4Q7Kle4YP0rkf5BKOlVIF6Q6DdzkTtxq3THp
         jUednKjI1zH0eqLHQ6aAlk+gHzQbLgjWk4aFk0/PYWAR0i8hH4kBZ57zdeA9tk9glSMj
         qlWQ==
X-Forwarded-Encrypted: i=1; AJvYcCXfk17xQNdijNdPEzjCI1grP02zm9zlqqGBOFbzseRtPgOuxpGq7oXMDa96KBPwaA/Y8Bw1K9bReiz1wpc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEfNKjCT9spPHNdzm8qNozcLLyEJ3CJVuf999FR78sEckg+0A/
	k8ZYH4yZXR5DgzzfoQkF/g/ulBmEUMRw+CCNx4jYwj2FuIrTdQBbuF1w+EKJrw==
X-Google-Smtp-Source: AGHT+IH60gDoSksZRxBPYz8lE7yUsHBmH9SByFQjxJjyREMpraheTARQnyuSg3kqldf9evYR6R5/Lw==
X-Received: by 2002:a17:903:32cd:b0:20b:af36:ead with SMTP id d9443c01a7336-20bff194fd0mr27908675ad.44.1728029579648;
        Fri, 04 Oct 2024 01:12:59 -0700 (PDT)
Received: from fshao-p620.tpe.corp.google.com ([2401:fa00:1:10:73bb:cecf:e651:2ce6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20beefad264sm19401305ad.205.2024.10.04.01.12.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 01:12:59 -0700 (PDT)
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
Subject: [PATCH v3 5/9] arm64: dts: mediatek: mt8188: Add JPEG decoder and encoder nodes
Date: Fri,  4 Oct 2024 16:11:57 +0800
Message-ID: <20241004081218.55962-6-fshao@chromium.org>
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

Add JPEG encoder and decoder nodes for hardware-accelerated JPEG
decoding and encoding support.

Signed-off-by: Fei Shao <fshao@chromium.org>
---

(no changes since v1)

 arch/arm64/boot/dts/mediatek/mt8188.dtsi | 29 ++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8188.dtsi b/arch/arm64/boot/dts/mediatek/mt8188.dtsi
index bb07d2629e08..a6a5d9cc875b 100644
--- a/arch/arm64/boot/dts/mediatek/mt8188.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8188.dtsi
@@ -2332,6 +2332,35 @@ video_encoder: video-encoder@1a020000 {
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
2.47.0.rc0.187.ge670bccf7e-goog


