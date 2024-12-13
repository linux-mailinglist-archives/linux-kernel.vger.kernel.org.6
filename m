Return-Path: <linux-kernel+bounces-444500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 79D0A9F07E6
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 10:29:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B955218883F8
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 09:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CF141B21A2;
	Fri, 13 Dec 2024 09:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="C3JRJagG"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EAC81B2180
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 09:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734082170; cv=none; b=daMLLadpI8S6CJ4YAdE6dNDF4EMrZQcXPZU/HN+ZoVXbbvt4He2kCoeWPggUu048k3EwJqqaZ/T3l04602exmzEN5i/Cm+eJXh25f7tIeN6xacCsrtJ9lb+OXcq2lA6Weg8FlV4fdongcT1MYpwvmT39OlE0pTg16+FFxU/kY8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734082170; c=relaxed/simple;
	bh=yinIFd+zq5HjBKuCQsnbuc+tRxeEenFe+BW3v3K1hpA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=a5e9nbgrfgv3N/SlkLY7/serNA6RlWL/mEbEohqDLriMDuY/SNVt2lmGglmwBk0j73pDbvZCkgSFMHHO51Ay5Q+dhnHS6PstIellLfwrYCZtjABD4FfNf4a+txXMdbZc6kATjX6x30g2pbVMPcdD5+1U8usYgTID5wKWaRWTqwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=C3JRJagG; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-7fdc6e04411so919385a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 01:29:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1734082166; x=1734686966; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6t03VSo/NkHlsh+FX0CoPxMU4wWbqRd5I1nezIlvOp4=;
        b=C3JRJagGi/OicZQiR4r7xyLtoGI/ms5ORQyntlP8Fif4JpGA9CxGL575JZVBOlpuyn
         sNMqXUnO+kWrvdyOsrbYKK7/Z/IXCZC3g8w15K7fhOxIuYEzQ/telo23imrobB/YfGFd
         QL6oqjIIsDKRN/xnpT+WaUGSZfDq0qB3raj7Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734082166; x=1734686966;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6t03VSo/NkHlsh+FX0CoPxMU4wWbqRd5I1nezIlvOp4=;
        b=diNdrRDSBA+v8K2aUF4RG6wRwhK7S9Dxu9DYpceuCxsTFeCCR8hGCgMb1/qyNieErx
         sZ17NZyz+AAxUCyt6v3W2gKJwVLz6c8hncOL6cglO64RGO5hJ6YnX9Rm+k4wBb5JtK01
         7fjzTfcGHN/ev7ZaMyTMVXlFyt/yP2JBND29yKfh/DFaWaY50j8w8IR0csnB99Cvewps
         +q+hlLIpt5irvTAvfp60kLBI7xJySTvNWVgtjsBMAMtxUihcFOxN2wc9AoKyqqOP/kvw
         WoOINvsUe/wYn47zbFyzYWeSIz2iqq8sr6CsvBAzckVG91qCEGQY+O3MXh0jV/SNFvXJ
         aNhQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFO2aZ6xdlKQhUw46m2xG75zBGixnJ3Wwe40hbYc1xdgtWtKCVIMacLI6zTx000hTBoGf32A4FErxs0Hw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn52CAPPhmnWqp6ioGjDMMTZWkTJb4rfLotnfxTBryOeO5kCbi
	LlKe9y75JxqfM5o466scSKMXjZ3eU0IMRuJZAKeT42dRUkhjcPPFloWE/SEmZA==
X-Gm-Gg: ASbGncvXMAgWxRkHjUwh0E7ru/8bDpuN4A6YCtohsou6zM1DvRC3iGL9AA+fGTMCfYC
	1blJjy3CfV67xgLAXMAPot/IcRG5K+8IDsUicyvwcckNJCoNZ0jRzbsJewfGgXtQzqsldzS1lfx
	vabMFH5MiKpy9scKySJSba27PRv8KObyLRmEI0CxxorCM/EhKOeM2slr9/u2kwXG93PlXJjMZjL
	/yGdr3UQYYY1h+7E6bEKubgd1bT4YuS4jDmFcF0zQfFN8/W/+sUNbMuEWkWqtaz6gFt6AV5fc6i
	obOOJgng5sf118FjGx7fP3Bb0k3cCHCDh8OHC+e86SiFHLw=
X-Google-Smtp-Source: AGHT+IFVvckKPZkGAO6T5Pb8DWTggJU8BHRz85vU+mCYNsL0QexjIl0XaTItdT0xzRVlKw/f7tvSpw==
X-Received: by 2002:a17:90b:3b52:b0:2ee:9cd2:a589 with SMTP id 98e67ed59e1d1-2f28fd6b4b1mr3333710a91.20.1734082166620;
        Fri, 13 Dec 2024 01:29:26 -0800 (PST)
Received: from yuanhsinte.c.googlers.com (176.220.194.35.bc.googleusercontent.com. [35.194.220.176])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f142e0ac42sm2733070a91.36.2024.12.13.01.29.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 01:29:26 -0800 (PST)
From: Hsin-Te Yuan <yuanhsinte@chromium.org>
Date: Fri, 13 Dec 2024 09:29:22 +0000
Subject: [PATCH] arm64: dts: mediatek: mt8188: Add GPU speed bin NVMEM
 cells
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241213-speedbin-v1-1-a0053ead9477@chromium.org>
X-B4-Tracking: v=1; b=H4sIAHH+W2cC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxNDI0Nj3eKC1NSUpMw83TRjY8tkIzMTi7Q0AyWg8oKi1LTMCrBR0bG1tQD
 317s+WgAAAA==
X-Change-ID: 20241213-speedbin-f339c2648ff0
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 Hsin-Te Yuan <yuanhsinte@chromium.org>
X-Mailer: b4 0.15-dev-7be4f

On the MT8188, the chip is binned for different GPU voltages at the
highest OPPs. The binning value is stored in the efuse.

Add the NVMEM cell, and tie it to the GPU.

Signed-off-by: Hsin-Te Yuan <yuanhsinte@chromium.org>
---
 arch/arm64/boot/dts/mediatek/mt8188.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8188.dtsi b/arch/arm64/boot/dts/mediatek/mt8188.dtsi
index cd27966d2e3c05833f11294cfa8f6a984d4e0dbc..0e865f5083b475c6e33cf6a0ce51d2b615af7850 100644
--- a/arch/arm64/boot/dts/mediatek/mt8188.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8188.dtsi
@@ -1752,6 +1752,11 @@ efuse: efuse@11f20000 {
 			lvts_efuse_data1: lvts1-calib@1ac {
 				reg = <0x1ac 0x40>;
 			};
+
+			gpu_speedbin: gpu-speedbin@581 {
+				reg = <0x581 0x1>;
+				bits = <0 3>;
+			};
 		};
 
 		gpu: gpu@13000000 {
@@ -1763,6 +1768,8 @@ gpu: gpu@13000000 {
 				     <GIC_SPI 382 IRQ_TYPE_LEVEL_HIGH 0>,
 				     <GIC_SPI 381 IRQ_TYPE_LEVEL_HIGH 0>;
 			interrupt-names = "job", "mmu", "gpu";
+			nvmem-cells = <&gpu_speedbin>;
+			nvmem-cell-names = "speed-bin";
 			operating-points-v2 = <&gpu_opp_table>;
 			power-domains = <&spm MT8188_POWER_DOMAIN_MFG2>,
 					<&spm MT8188_POWER_DOMAIN_MFG3>,

---
base-commit: 1488143f901e04e132722cb093613e8d019a4ec6
change-id: 20241213-speedbin-f339c2648ff0

Best regards,
-- 
Hsin-Te Yuan <yuanhsinte@chromium.org>


