Return-Path: <linux-kernel+bounces-304735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AAF44962420
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 11:57:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 540F71F21EEE
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 09:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A97616B399;
	Wed, 28 Aug 2024 09:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NS1tJQHU"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56E0166F20
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 09:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724839006; cv=none; b=pkrT9sTt1whP0gwjjcDxIl+0HCiznIubuGXCNtahptX6GavGEAqcrW+tFK4Ilpm40Lt1CUU6CpoeUbJPglJsPnQdaRwO2Vrj5Tb5irLHShyebxt7gUPkPRR0t98xKUQZjbZTHqG10R+CHRNVB4A3SobgbiXhEBZYpyONvpeMHGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724839006; c=relaxed/simple;
	bh=ge4SxTWNVKyFGRQiLbdG08o14Wfg6HB1zk1RSCadr00=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QON0zoqgYzPySqnx+CZ2Wnok5sENAu0XVr4z/FXF53tFVNG1uYRsnfvYCKk5+p6CGM9bLDYZgLdaynC3KyN+igEUy7r7FrUtEBpXSv677MRT0GBs1ZBEXzuEeA70BZbfjibqHjCJbrw6wVF/FKQw8Cu4lvijf2h5Buk7lpgajCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NS1tJQHU; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4280772333eso9283205e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 02:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724839003; x=1725443803; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N/jIvTuTNMLOubMyObTcs7DeZHs1cvzKt8VJq5iN+3Y=;
        b=NS1tJQHUgk0WmNIEddf+Xz3VWdiluZz0H5+DydBaED6e1bzsmpuOv0+ycFsOO3TSwC
         S7pJ7H7M9FaICuKlfkYe/LG/dZPN+CT2K9JQKx3WwYWRvKz2LTwZFz4oXUamTSxc1+3D
         YjbPCihxQbVpGX/e3r7T/1FPMsVwaH9aWLFNXms/F14jCuGbZ9rTa25/fSRGSpZBMMDj
         MYNI7vnDIIvK378xEDQRgv8NQvT2k+C1Xr586HvdapqdlzAzaGOl1oz4BYve3WT9Mzee
         FjMZ/D5ZpMv3/lU5H8EYcTNTXi3KMpZgb/b3RMer7uuFrTM3TdHY5BWXj0XqcxzkG0QL
         UJCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724839003; x=1725443803;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N/jIvTuTNMLOubMyObTcs7DeZHs1cvzKt8VJq5iN+3Y=;
        b=AFlydVKuXGhQ+hhoopbDktXZyeJhW91soo3VXsHf78XI6PpB2ZtiGilrbTkhKYt9GN
         W5uEzyEqubxk31zmQA6hGTNDvGa62bNAELwQ7rZ1YughFBeNG5uipLtGZp2FnqVgKVEr
         5TFwhrxwke4IP/ctK6tk9UP5nMDbXdcg1ETSj0tMl4eQ8eglwWDfQkE01OMgzzyIl4VB
         J2Upw8dxqPN4eirxg+UhvvUW5hh2pR48E4R6z8GVG6ZKqj/jJ3mYe+01g3TO7fzlfRe4
         zrsOrSXupHYoqvQRyDNVB9Wvgl1Yx+yBDpbwvg7D31ypgVMb1n86yrrDRW52tkBlntne
         N4Ng==
X-Forwarded-Encrypted: i=1; AJvYcCVXL0q7m2HBiiTreDiEj38X0nXxhvQZEor6F9F9FksjmEEx4tTu7xtTDjZt+Z2hbAevS9hm1fdae4oQA4c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeRZ57HHCSQYjwl54WMVCJAbECnNdVNrNcwTGzAV++7XVqO1dI
	pQdNE+X5LOiXLxf1s0DV6cf7BfbEPED8okbBeMezScXkVdDtqDUhd8Zj0X0dZXU=
X-Google-Smtp-Source: AGHT+IF5V1OJizmXPGv7EUtJkonq52X5+q4graFsdQFbBk5bixOQ03LcyEh/3h0hEpedeZ8cEZc+UQ==
X-Received: by 2002:a05:600c:5118:b0:425:6dfa:c005 with SMTP id 5b1f17b1804b1-42acc8dca6dmr70541755e9.2.1724839003070;
        Wed, 28 Aug 2024 02:56:43 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.82])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3730810fb33sm15067077f8f.13.2024.08.28.02.56.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 02:56:42 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Andrey Smirnov <andrew.smirnov@gmail.com>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/3] ARM: dts: imx7d-zii-rmu2: fix Ethernet PHY pinctrl property
Date: Wed, 28 Aug 2024 11:56:36 +0200
Message-ID: <20240828095638.231569-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240828095638.231569-1-krzysztof.kozlowski@linaro.org>
References: <20240828095638.231569-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is no "fsl,phy" property in pin controller pincfg nodes:

  imx7d-zii-rmu2.dtb: pinctrl@302c0000: enet1phyinterruptgrp: 'fsl,pins' is a required property
  imx7d-zii-rmu2.dtb: pinctrl@302c0000: enet1phyinterruptgrp: 'fsl,phy' does not match any of the regexes: 'pinctrl-[0-9]+'

Fixes: f496e6750083 ("ARM: dts: Add ZII support for ZII i.MX7 RMU2 board")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/nxp/imx/imx7d-zii-rmu2.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx7d-zii-rmu2.dts b/arch/arm/boot/dts/nxp/imx/imx7d-zii-rmu2.dts
index 521493342fe9..8f5566027c25 100644
--- a/arch/arm/boot/dts/nxp/imx/imx7d-zii-rmu2.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx7d-zii-rmu2.dts
@@ -350,7 +350,7 @@ MX7D_PAD_SD3_RESET_B__SD3_RESET_B	0x59
 
 &iomuxc_lpsr {
 	pinctrl_enet1_phy_interrupt: enet1phyinterruptgrp {
-		fsl,phy = <
+		fsl,pins = <
 			MX7D_PAD_LPSR_GPIO1_IO02__GPIO1_IO2	0x08
 		>;
 	};
-- 
2.43.0


