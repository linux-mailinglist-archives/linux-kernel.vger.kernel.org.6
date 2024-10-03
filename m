Return-Path: <linux-kernel+bounces-348645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A407298EA09
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 09:03:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4614A283A24
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 07:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E495013CF8E;
	Thu,  3 Oct 2024 07:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QJOCxWrd"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA12713F42A
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 07:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727938932; cv=none; b=RpYID4D1NQKUCXCya4ZQFI0lMNIY4Pg+cZJlhmcnhyrmDWY0222yhUcBwSG41cQMYT3w/lCO3I2JnwHjSv3pmoBBhekenXka/eh12x+bK0kU2DEOL/1jDGwOfSL3mQDjMupqq7F46MbJn6iIIcRru4yWZLwkzwhYGbxEFJSx3G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727938932; c=relaxed/simple;
	bh=Ye0siwcOaJvlxvSr6UbPhEw7tWXLtn2oIKJeHRX1aEQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GvCtAlrHZDld3T4Y4VUKPrdXSqlCOBHiSzRIFPm8CmNC+4cqzAespVYdU9dF9+ihYUn15itqKZX5ZcP+GaD8voLoXZc6f+yERDIEXtPkWZ/t8+vJxjw29OseJ09ixAv7dfEFM1bIueq2uWq6O/sHYclwIN9uUK8RnIKs53B3rGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=QJOCxWrd; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-71c702b2d50so488640b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2024 00:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1727938930; x=1728543730; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ftwFn9ZLUuKCLPPu13/3mAe7bDdVNGDECC9c6Eq3ZPM=;
        b=QJOCxWrdlq+lXIyC/qCmK8BTMum4ITnBt9IUYTDXmpPA05bIXvqTarjFENbUfa88ni
         gWbbEaqEvVWJYO7p7U1EbUvFZGZvcOqPm97XmOTfTAneCFvKPDBrl0bwBU6D8hpDfaa+
         e0InDBNGCY4gFAq/1Yv7DgjOeEukZw+N7V9xg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727938930; x=1728543730;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ftwFn9ZLUuKCLPPu13/3mAe7bDdVNGDECC9c6Eq3ZPM=;
        b=mvMQyG7ZgVeMzQN00yaRzV5Q7TFEdAclvLf1BF3NqKzsD+djslDShRptLyVWpswVPG
         803zeRK4SqbN4YnIjJpHdwpNTEinrWoOmTo08zPWbl2ZH06zJ1XRxwXf+jiKCZAZ4G/0
         ZS2pa0hglrJBcYe20GdDmV/JxyrZMSQ4mWIrVfMNR5AK2QVnfHrT8/3WtfQmDG4e1t6a
         6Y8Y+pzejM/wVVBuSFf3KzLrMx9bsJrMHWM+ddw/RvO/WihE845I7tOnu45ikML/0rtq
         UjjTwZFETkdFFOucupaczwQXcJpHJ9OW3QdHSh/ZJTHAYJ+YeqgLcMOI/pkSZhUy7v7k
         dWKQ==
X-Forwarded-Encrypted: i=1; AJvYcCW3ZY4q5D6RlZzRYo50anFU4S7YWvZ8QM/q3vPCOnzysQV6jhKsLyZoX4QfIwruHtmuaZiK6Fti9dzluK8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyi+JlHVD5NcyrzzJehbnqE1SPV0dMvcJ6erTiKaE/J8aSn4jO8
	priMkvuVCjZZSRPGunNLEMNIKKHFT+0itxovAvCNIgvKZBt+yJ4dNZEwK6+ARQ==
X-Google-Smtp-Source: AGHT+IHE/CCPGFNgWjWh9e6CyqMHQZblij2trHaQLpVyyZLVEj0BO/xQcou38wPPpQh6mNnsYlGS5A==
X-Received: by 2002:a05:6a00:1829:b0:714:1a7c:b727 with SMTP id d2e1a72fcca58-71dc5c772bbmr9315186b3a.8.1727938930039;
        Thu, 03 Oct 2024 00:02:10 -0700 (PDT)
Received: from fshao-p620.tpe.corp.google.com ([2401:fa00:1:10:3bd0:d371:4a25:3576])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71dd9d8e473sm633782b3a.81.2024.10.03.00.02.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 00:02:09 -0700 (PDT)
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
Subject: [PATCH v2 9/9] arm64: dts: mediatek: mt8188: Add eDP and DP TX nodes
Date: Thu,  3 Oct 2024 15:00:03 +0800
Message-ID: <20241003070139.1461472-10-fshao@chromium.org>
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
index e77bd2b76128..92e71977c775 100644
--- a/arch/arm64/boot/dts/mediatek/mt8188.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8188.dtsi
@@ -2006,6 +2006,10 @@ efuse: efuse@11f20000 {
 			#address-cells = <1>;
 			#size-cells = <1>;
 
+			dp_calib_data: dp-calib@1a0 {
+				reg = <0x1a0 0xc>;
+			};
+
 			lvts_efuse_data1: lvts1-calib@1ac {
 				reg = <0x1ac 0x40>;
 			};
@@ -2852,5 +2856,27 @@ padding7: padding@1c124000 {
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


