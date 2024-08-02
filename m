Return-Path: <linux-kernel+bounces-272190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06C7094586E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 09:10:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C2D71C23731
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 07:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A367B15B54C;
	Fri,  2 Aug 2024 07:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hSq5Ug0q"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A581598E3
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 07:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722582597; cv=none; b=GsuSpI8BrVk7asMn2j/3gdfrRwGbZ2/bOpG4nGPu2+cinc/8aPt+qCVq5dI4q9KS1iLnlwjBbZMxpMd3tDyPA7R1ORByUNEW1/8/oucNbEl8jxrZGdG9xVj0YPPKsahl20XiU77U0492c+G3NtSfFuySh/OtaYkOpjpr2VS0LPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722582597; c=relaxed/simple;
	bh=qukvKq6BW36VQopCqVeGMajQBRgKUM0bgNiwhrujaXU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=duhxdDYpvzrKrJOBfn2iL6pmkdavZtjPKCIh/HyGpQTcWm+Qv8ENPlj5WdHYUqm+m/pRS8fKUWDAcimwwRt7XDxPP5tPU2sL/dTjw+k4MlExiI/4tW/mPHuwxtGbixvtGoKGMHKIVCKQbSCuljO7yjLJgqGsckx3y9q043P/3g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=hSq5Ug0q; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1fd90c2fc68so62001575ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2024 00:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1722582596; x=1723187396; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=S7Br9pmxpWGWBK1ASt7BgnymbG5sO0VEPtoGkQEDSjI=;
        b=hSq5Ug0qnvS+NtDGLKeK9Qqm6k2yEWRpCQ3PYvOtsvbomV1LuZxmIjuL1RC4H03Um/
         9pTMPxcSTgUGsuWuYhSjnL4+55Qt6cOOvsnL2oqAOY+gOUpYT5P+keiGTivBM/MO72PE
         sZgzTLVmtzXj/Fyk8f5vuZf/JVrx1OrT5DBNQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722582596; x=1723187396;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S7Br9pmxpWGWBK1ASt7BgnymbG5sO0VEPtoGkQEDSjI=;
        b=BPNpbdBfurUWz7NROTif4ap7+7tORamWzhEpksy7V5Zz6JesSv3n1TZ78mshMJMiyd
         yJCF+uxKoIvy9ZLEKGVu59tenhiC4iGjIas0hWRJd5PEbL/yrCvaWAmyzHnJ3Ja4GblA
         r2nyYOAjP0u30a2oW2mswhwEEk7UpOHF7PXkVk4Y5+NdP45caSNmrf0tsenyEVwYFGLh
         CJTFwaHEYxsqt1s3JZ7N1oKZ2IyT9ak72wFF6WQ506Ap3MSKOIFLmAZf6cYPZ2eaZKXk
         gqGz8b70c1c2C0vW3jgHv3LAZNQ0K2qjumAeZTxH+Aa8TElpKoiyju4aa3OZHBVEg+A5
         47Kw==
X-Forwarded-Encrypted: i=1; AJvYcCXurSL+iE6SOOOLe9KGTKC0MMqF4Zb6tA6YKGPWnFgFH48HutPc58gFJQoGOnjU6PgE1fWg5bpW2U8cvsTUDXToefo1Ilfvt0vgqhAI
X-Gm-Message-State: AOJu0YwLdvJwewCFrBgA8l7UPVL2GINJQV8tUFB6LC5iRwNmhrhbGvmH
	uG10Pc/kAbSfHU7N5/8UDjfiwWqHFyP23rrYdr492ovr7cxUeser2LCe8nbf4g==
X-Google-Smtp-Source: AGHT+IGLq0mErGqzzVN2fu1NHv5FwQg+WZUq33b12gl6nvqOLVq6lohDfRmMscu6BBut3VG69qGzww==
X-Received: by 2002:a17:903:182:b0:1ff:5135:130d with SMTP id d9443c01a7336-1ff57261cc7mr32752225ad.16.1722582595790;
        Fri, 02 Aug 2024 00:09:55 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:f2e4:75b7:52fc:71cc])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff58f19e15sm10228345ad.40.2024.08.02.00.09.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 00:09:55 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: mediatek: mt8195: Correct clock order for dp_intf*
Date: Fri,  2 Aug 2024 15:09:50 +0800
Message-ID: <20240802070951.1086616-1-wenst@chromium.org>
X-Mailer: git-send-email 2.46.0.rc2.264.g509ed76dc8-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The clocks for dp_intf* device nodes are given in the wrong order,
causing the binding validation to fail.

Fixes: 6c2503b5856a ("arm64: dts: mt8195: Add dp-intf nodes")
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 arch/arm64/boot/dts/mediatek/mt8195.dtsi | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
index 989e8ac545ac..e89ba384c4aa 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
@@ -3252,10 +3252,10 @@ dp_intf0: dp-intf@1c015000 {
 			compatible = "mediatek,mt8195-dp-intf";
 			reg = <0 0x1c015000 0 0x1000>;
 			interrupts = <GIC_SPI 657 IRQ_TYPE_LEVEL_HIGH 0>;
-			clocks = <&vdosys0  CLK_VDO0_DP_INTF0>,
-				 <&vdosys0 CLK_VDO0_DP_INTF0_DP_INTF>,
+			clocks = <&vdosys0 CLK_VDO0_DP_INTF0_DP_INTF>,
+				 <&vdosys0  CLK_VDO0_DP_INTF0>,
 				 <&apmixedsys CLK_APMIXED_TVDPLL1>;
-			clock-names = "engine", "pixel", "pll";
+			clock-names = "pixel", "engine", "pll";
 			status = "disabled";
 		};
 
@@ -3522,10 +3522,10 @@ dp_intf1: dp-intf@1c113000 {
 			reg = <0 0x1c113000 0 0x1000>;
 			interrupts = <GIC_SPI 513 IRQ_TYPE_LEVEL_HIGH 0>;
 			power-domains = <&spm MT8195_POWER_DOMAIN_VDOSYS1>;
-			clocks = <&vdosys1 CLK_VDO1_DP_INTF0_MM>,
-				 <&vdosys1 CLK_VDO1_DPINTF>,
+			clocks = <&vdosys1 CLK_VDO1_DPINTF>,
+				 <&vdosys1 CLK_VDO1_DP_INTF0_MM>,
 				 <&apmixedsys CLK_APMIXED_TVDPLL2>;
-			clock-names = "engine", "pixel", "pll";
+			clock-names = "pixel", "engine", "pll";
 			status = "disabled";
 		};
 
-- 
2.46.0.rc2.264.g509ed76dc8-goog


