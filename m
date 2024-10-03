Return-Path: <linux-kernel+bounces-348642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9AA798EA03
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 09:03:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7845283842
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 07:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 091ED136328;
	Thu,  3 Oct 2024 07:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FwNErA6N"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E819E13A888
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 07:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727938924; cv=none; b=H7CCr3Ynwo3LdQe359PFW3RPfB2l3S1UxyRyPbUcv5vGDKTgTIlGrsFYebFCfdrd02Mwai5fJm0d0GbiGNGFi7V6hGkYp63nDn9KYnJae6tHoMXBup+5xRQEsirwiTMcCOn2yCYbYRYPJK92STZDHStgI/q4KnZP7h9z9ZQv1K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727938924; c=relaxed/simple;
	bh=Vr2xDeUGR7wn0IG1ujsn4pL0w26Sn9GhHyQQhGtQ1oY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k/RxUOh6+A9M6+ibKu0TIEuAchuIPrViGnuGVlnB684AlZGjuQ1gwoLfXp6Mw+TSiuJ8sb9MrBrlQf2FDNKB7S0h7O1qGnOi6yfxjq1n+QP3C3EMr8X5B8Kubw8sOOIruQZXmBF9R0a1nTTD0FJFalF1mku2NnIq994UKn57K7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=FwNErA6N; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7db4c1a54easo380099a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2024 00:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1727938922; x=1728543722; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3DZWdl8216aZT8y3IXtxjhUrWkN3hJN2Yt08JxwRcJQ=;
        b=FwNErA6NehZaX0yN8a512PuCG7at+ZhXJVyYRYjDonRvNTUwjLrw0m/uM6P6ppTsvM
         wIagAQ4XdcKklVN6E1UmBn7ydlI1fzxfQzvKRPhkLzhzTMjqpu0w4faAvUClCgV40ASW
         vNmkmty8CqRsgNS8Lylg2LV63H9mcU6tGeQIU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727938922; x=1728543722;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3DZWdl8216aZT8y3IXtxjhUrWkN3hJN2Yt08JxwRcJQ=;
        b=YnSgWzoYyfkXtr5MwRycbz50y144BlpxVPLntZEm2ndRUSkGMOUCpUlDrOax43nZlO
         WJ84D8SAOfdTD9+2ZQ1TXa9Y90mWhWZEjPKmX9efhSB7TuOPOzkJxdYDc9yhVe+J+GQO
         7ZTmSIqemF+OxoMqbJfzQMyzY0bnPVN2VoAocWLX2Pk8CcZ5zeesp9E6+ZGI7B+8kVEA
         hAEFNisZx/Km8UsvDrXZm4LEYAeRC2MomOpyP5O/8FeJOhybz0PWX900OGmNQIOhefCL
         d4WSjfpr1sxzShG7CBRgsk/mF/SxoolDTn9dUxe04BBGMr+pT+23Nf4Qy18iYIX5GViS
         XQqg==
X-Forwarded-Encrypted: i=1; AJvYcCWgWJfNiq2GnbrO9IS2WL0dlTX4X4rAzwJlb4DQzX+3w8EvqbeqUppye2UU4Eu86TCBn6ioCMHqD8+MZPw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwM/j/1jzg4g1wSOvBk5rFO9mLHTmQI6ZVRF1VvkZ1NAx/JR9vb
	0hSuf4LRkQLvtTJO7EwmRsgfK9wxC68PvtrOeLNirK3UaCwqiaUzTOusHetl2A==
X-Google-Smtp-Source: AGHT+IE2SFaqb1OLYR+xEq8sUkTQwvxY9SfiKLM3jT+7mDigbRjSypSLlCdkbSzQtSVqhSe3ATAMiQ==
X-Received: by 2002:a05:6a20:c886:b0:1cf:2862:beca with SMTP id adf61e73a8af0-1d5db136c5amr8275656637.13.1727938922335;
        Thu, 03 Oct 2024 00:02:02 -0700 (PDT)
Received: from fshao-p620.tpe.corp.google.com ([2401:fa00:1:10:3bd0:d371:4a25:3576])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71dd9d8e473sm633782b3a.81.2024.10.03.00.02.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 00:02:01 -0700 (PDT)
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
Subject: [PATCH v2 6/9] arm64: dts: mediatek: mt8188: Add display nodes for vdosys0
Date: Thu,  3 Oct 2024 15:00:00 +0800
Message-ID: <20241003070139.1461472-7-fshao@chromium.org>
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

Add the vdosys0 display nodes to support the internal display pipeline.

Signed-off-by: Fei Shao <fshao@chromium.org>
---

(no changes since v1)

 arch/arm64/boot/dts/mediatek/mt8188.dtsi | 86 ++++++++++++++++++++++++
 1 file changed, 86 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8188.dtsi b/arch/arm64/boot/dts/mediatek/mt8188.dtsi
index 0eb57f95bbaf..c4026de18fd8 100644
--- a/arch/arm64/boot/dts/mediatek/mt8188.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8188.dtsi
@@ -26,6 +26,7 @@ / {
 	aliases {
 		gce0 = &gce0;
 		gce1 = &gce1;
+		mutex0 = &mutex0;
 	};
 
 	cpus {
@@ -2346,6 +2347,71 @@ jpeg_decoder: jpeg-decoder@1a040000 {
 			power-domains = <&spm MT8188_POWER_DOMAIN_VDEC0>;
 		};
 
+		ovl0: ovl@1c000000 {
+			compatible = "mediatek,mt8188-disp-ovl", "mediatek,mt8183-disp-ovl";
+			reg = <0 0x1c000000 0 0x1000>;
+			clocks = <&vdosys0 CLK_VDO0_DISP_OVL0>;
+			interrupts = <GIC_SPI 636 IRQ_TYPE_LEVEL_HIGH 0>;
+			iommus = <&vdo_iommu M4U_PORT_L0_DISP_OVL0_RDMA0>;
+			power-domains = <&spm MT8188_POWER_DOMAIN_VDOSYS0>;
+			mediatek,gce-client-reg = <&gce0 SUBSYS_1c00XXXX 0x0000 0x1000>;
+		};
+
+		rdma0: rdma@1c002000 {
+			compatible = "mediatek,mt8188-disp-rdma", "mediatek,mt8195-disp-rdma";
+			reg = <0 0x1c002000 0 0x1000>;
+			clocks = <&vdosys0 CLK_VDO0_DISP_RDMA0>;
+			interrupts = <GIC_SPI 638 IRQ_TYPE_LEVEL_HIGH 0>;
+			iommus = <&vdo_iommu M4U_PORT_L1_DISP_RDMA0>;
+			power-domains = <&spm MT8188_POWER_DOMAIN_VDOSYS0>;
+			mediatek,gce-client-reg = <&gce0 SUBSYS_1c00XXXX 0x2000 0x1000>;
+		};
+
+		color0: color@1c003000 {
+			compatible = "mediatek,mt8188-disp-color", "mediatek,mt8173-disp-color";
+			reg = <0 0x1c003000 0 0x1000>;
+			clocks = <&vdosys0 CLK_VDO0_DISP_COLOR0>;
+			interrupts = <GIC_SPI 639 IRQ_TYPE_LEVEL_HIGH 0>;
+			power-domains = <&spm MT8188_POWER_DOMAIN_VDOSYS0>;
+			mediatek,gce-client-reg = <&gce0 SUBSYS_1c00XXXX 0x3000 0x1000>;
+		};
+
+		ccorr0: ccorr@1c004000 {
+			compatible = "mediatek,mt8188-disp-ccorr", "mediatek,mt8192-disp-ccorr";
+			reg = <0 0x1c004000 0 0x1000>;
+			clocks = <&vdosys0 CLK_VDO0_DISP_CCORR0>;
+			interrupts = <GIC_SPI 640 IRQ_TYPE_LEVEL_HIGH 0>;
+			power-domains = <&spm MT8188_POWER_DOMAIN_VDOSYS0>;
+			mediatek,gce-client-reg = <&gce0 SUBSYS_1c00XXXX 0x4000 0x1000>;
+		};
+
+		aal0: aal@1c005000 {
+			compatible = "mediatek,mt8188-disp-aal", "mediatek,mt8183-disp-aal";
+			reg = <0 0x1c005000 0 0x1000>;
+			clocks = <&vdosys0 CLK_VDO0_DISP_AAL0>;
+			interrupts = <GIC_SPI 641 IRQ_TYPE_LEVEL_HIGH 0>;
+			power-domains = <&spm MT8188_POWER_DOMAIN_VDOSYS0>;
+			mediatek,gce-client-reg = <&gce0 SUBSYS_1c00XXXX 0x5000 0x1000>;
+		};
+
+		gamma0: gamma@1c006000 {
+			compatible = "mediatek,mt8188-disp-gamma", "mediatek,mt8195-disp-gamma";
+			reg = <0 0x1c006000 0 0x1000>;
+			clocks = <&vdosys0 CLK_VDO0_DISP_GAMMA0>;
+			interrupts = <GIC_SPI 642 IRQ_TYPE_LEVEL_HIGH 0>;
+			power-domains = <&spm MT8188_POWER_DOMAIN_VDOSYS0>;
+			mediatek,gce-client-reg = <&gce0 SUBSYS_1c00XXXX 0x6000 0x1000>;
+		};
+
+		dither0: dither@1c007000 {
+			compatible = "mediatek,mt8188-disp-dither", "mediatek,mt8183-disp-dither";
+			reg = <0 0x1c007000 0 0x1000>;
+			clocks = <&vdosys0 CLK_VDO0_DISP_DITHER0>;
+			interrupts = <GIC_SPI 643 IRQ_TYPE_LEVEL_HIGH 0>;
+			power-domains = <&spm MT8188_POWER_DOMAIN_VDOSYS0>;
+			mediatek,gce-client-reg = <&gce0 SUBSYS_1c00XXXX 0x7000 0x1000>;
+		};
+
 		disp_dsi: dsi@1c008000 {
 			compatible = "mediatek,mt8188-dsi";
 			reg = <0 0x1c008000 0 0x1000>;
@@ -2361,6 +2427,26 @@ disp_dsi: dsi@1c008000 {
 			status = "disabled";
 		};
 
+		mutex0: mutex@1c016000 {
+			compatible = "mediatek,mt8188-disp-mutex";
+			reg = <0 0x1c016000 0 0x1000>;
+			clocks = <&vdosys0 CLK_VDO0_DISP_MUTEX0>;
+			interrupts = <GIC_SPI 658 IRQ_TYPE_LEVEL_HIGH 0>;
+			power-domains = <&spm MT8188_POWER_DOMAIN_VDOSYS0>;
+			mediatek,gce-client-reg = <&gce0 SUBSYS_1c01XXXX 0x6000 0x1000>;
+			mediatek,gce-events = <CMDQ_EVENT_VDO0_DISP_STREAM_DONE_0>;
+		};
+
+		postmask0: postmask@1c01a000 {
+			compatible = "mediatek,mt8188-disp-postmask",
+				     "mediatek,mt8192-disp-postmask";
+			reg = <0 0x1c01a000 0 0x1000>;
+			clocks = <&vdosys0 CLK_VDO0_DISP_POSTMASK0>;
+			interrupts = <GIC_SPI 661 IRQ_TYPE_LEVEL_HIGH 0>;
+			power-domains = <&spm MT8188_POWER_DOMAIN_VDOSYS0>;
+			mediatek,gce-client-reg = <&gce0 SUBSYS_1c01XXXX 0xa000 0x1000>;
+		};
+
 		vdosys0: syscon@1c01d000 {
 			compatible = "mediatek,mt8188-vdosys0", "syscon";
 			reg = <0 0x1c01d000 0 0x1000>;
-- 
2.46.1.824.gd892dcdcdd-goog


