Return-Path: <linux-kernel+bounces-347423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FBD098D27B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 13:48:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76F0E1C213F2
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 11:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7268620B1E2;
	Wed,  2 Oct 2024 11:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="giUSrRza"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B0E2200107
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 11:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727869634; cv=none; b=bhaqmwrg8t3J1XD9uzxgJ0pUA9d2mXox9CPY6OdmoSyzqlTWKPieDzpXNEdBz0BVVF082CX59YJytVTN585Z68I1JOcoT41ayKhzrSiaUDcWJgRtfhTrL533ZwiHw4ARZ8Asv9g9oHjl5DxxxAIVmbHv0YCOe4issoNL0TO0fp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727869634; c=relaxed/simple;
	bh=/uRk6r36N6d8BP2a9sZYAmjS4S2UGgXlWzURx3RD7K4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AvzT0YiVW4508S/EJCGTwvf6YbYPvBLIx0zQ0vHThGPK+YxHAZmulK8/sKs8AmUxSPhUxxM4KgFnW6JkzpKdInyTnavAtAMchMzAWbFMoTir1q0ZaLHPy9DtMjzRc6zDVPBf7GVaFvTS2oeBQsSLCuVvDSxjrcuh3kom7N5lOp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=giUSrRza; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-71b070ff24dso5867280b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 04:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1727869633; x=1728474433; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R67MOM4KKUTh0qCCt++0T4Ue+lkz0KBhSiql033WWVM=;
        b=giUSrRzaqKCcUBqJw4L2niezIZ9YSPWMHGInJ9s5tOB1q/wk+pkkp1u/aBkE02GTZm
         He11stNgpyIpSKI1uK1Pv3rCVTomeryx4V+Tf0GtKxD4GwuTny5H2ev7nVh6PPRtYTSs
         40bZMGBpea3Bs+8QQDblYAcDNIRnJdOUL8TyE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727869633; x=1728474433;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R67MOM4KKUTh0qCCt++0T4Ue+lkz0KBhSiql033WWVM=;
        b=sC7IYwWe//U5qfw+isD8uSthTVIoJ6Sm9KsNBKhrYSyk9FrfZ38ThqWqfS2oewpFPE
         82H6o9VmUabn2MOz+sqTqBPKKfryQftTOA0SkJWzn7oDJcEH2fnEi0ocHdK8dpCbAIrV
         0JZhAssWUfz2gEvO3lIpcsbZpb4srtCMrPNCsBUG3sby0NhWKZqbG6sFvssc5OpaZOOq
         tF91wmBGSKaXVGsPXtQRK4KX0KtxQcbAXBvLgXJnXxyaQ0G3RWIP3PkIFqvbrXpaZfI6
         JY19s4+UwtqlUeUqkjm76YEqpZZ0tbfgQnMviosLszmO9BE4UfCuXpYwQAnf9POmP2Am
         oaYw==
X-Forwarded-Encrypted: i=1; AJvYcCVBF5qJdpvD30pZxhH72GjsYFnNaLHTbWDI0CcEoArfJztLwDiAdP5KXC4jQ8QvVfAAY/zrUU8n9JISpr0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsBoCVbsz8oQAogNB5CfRDJXeyUTvR1rq6y0ze3Otcspdrjn7T
	2xIfnuJmcKhyaMhkZSbGBNC8IDExWjMi0xBXhsTHQjY9vN+E8WJHF3RWrRo3jg==
X-Google-Smtp-Source: AGHT+IG5W5PbB9Dg2pXJwidpYLDnewgtqTRSMPqWMUaOdFMbuHNinBNwjLa/SIhmMYymYMhGikQ+CQ==
X-Received: by 2002:a05:6a00:2349:b0:719:1df4:9d02 with SMTP id d2e1a72fcca58-71dc5d6fab5mr4373727b3a.25.1727869632648;
        Wed, 02 Oct 2024 04:47:12 -0700 (PDT)
Received: from fshao-p620.tpe.corp.google.com ([2401:fa00:1:10:3bd0:d371:4a25:3576])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b2652baefsm9639627b3a.180.2024.10.02.04.47.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 04:47:12 -0700 (PDT)
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
Subject: [PATCH 9/9] arm64: dts: mediatek: mt8188: Add eDP and DP TX nodes
Date: Wed,  2 Oct 2024 19:41:49 +0800
Message-ID: <20241002114614.847553-10-fshao@chromium.org>
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

Add edp-tx and dp-tx nodes for the Embedded DisplayPort (eDP) and
DisplayPort ports to connect to DP-INTF ports and panels, and add the
efuse cell for the DP calibration data.

Individual board device tree should enable the nodes and connect input
and output ports as needed.

Signed-off-by: Fei Shao <fshao@chromium.org>
---

 arch/arm64/boot/dts/mediatek/mt8188.dtsi | 26 ++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8188.dtsi b/arch/arm64/boot/dts/mediatek/mt8188.dtsi
index 943333d2567f..67c539e5d146 100644
--- a/arch/arm64/boot/dts/mediatek/mt8188.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8188.dtsi
@@ -2004,6 +2004,10 @@ efuse: efuse@11f20000 {
 			#address-cells = <1>;
 			#size-cells = <1>;
 
+			dp_calib_data: dp-calib@1a0 {
+				reg = <0x1a0 0xc>;
+			};
+
 			lvts_efuse_data1: lvts1-calib@1ac {
 				reg = <0x1ac 0x40>;
 			};
@@ -2850,5 +2854,27 @@ padding7: padding@1c124000 {
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
2.46.1.824.gd892dcdcdd-goog


