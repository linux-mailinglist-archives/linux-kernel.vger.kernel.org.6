Return-Path: <linux-kernel+bounces-310764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C4BF9680F6
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 09:52:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E259B20ACF
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 07:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9152C17C9A4;
	Mon,  2 Sep 2024 07:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mJvtnVn/"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CCFE3C00
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 07:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725263547; cv=none; b=oC114kvO/oimG3DZN6AXBjy4Ft58AqCUszCpU1WfW1bvqqQq29U6kq4SOyxzmCTdquqfHtFVEOWB31f37ZViRXACVYKx0qcULs+95nvmIyN0O78qLWLdnrAuR9SefxEQIZ6dpiPpfQ+0J/1b+wRwW/Fwe/6M2R4TkyZAGYZw6rA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725263547; c=relaxed/simple;
	bh=3nAkcyovcR5wQ+ZHWPzbOoAXDGnZb9kF/DhMrsUvhkY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JEIOH6J9QKJS3vdV9Y+TSXHeSYSoEuAFSrnfgf3HDJgH+Ol9qmawMlbud59hMYn1i5EnMdJ9brsAyYX94BFrzN7AsZgje9vJ1B8AYLDSfOcs4+EeKrS+Dif14ubA7VY4DpxCRRrSoZ514YPKdb6NQe02VmnyVEciezs3WPUP26U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mJvtnVn/; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-42c7bc972a5so2086545e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 00:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725263545; x=1725868345; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XGwfN0CeifX9HzgQ4u8AIzU8rGDPcSifb8zJ05Qy9/Y=;
        b=mJvtnVn/l7Rjkg1TSTtdV3fNVdfLqhXREn1ANNiOqHc04XF5OjEpKdi6QUKsdK/wtB
         WLp4PRHaTDtPinSH5W79iCc97mgeleaZ2tCZ3wEzLsc+HQRUHtF5jEk/g/pV/718/Q3G
         drUJLXxeb3IZ9WuAYvue7yNqG6Z0gjfJD1XA+24g5ZNxsu5pokFRA5KWiTwx+l3PbDGk
         8bjsv6jJSWeyOkToIhQhRITD00VdbUdkbroCJxMpVmDIXYeMkQ8N/EwmLePcdtgn5QAd
         GP/gjtj/bTuD6A0gK74dGzrv2UDXpPPDlzrK0tlCQTab9l8iRUWUwAOQhoSODv6yp/V9
         xCoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725263545; x=1725868345;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XGwfN0CeifX9HzgQ4u8AIzU8rGDPcSifb8zJ05Qy9/Y=;
        b=XMKNmazfFKrftd7OTeGY0OdZkEKVtLlKRg1VK1CJhDxJ8/iXnwwftrIMgsbGi3fmBt
         YKm2oYQRWEmovHSCMalxTJiAuHbDzYav43H0sCJqdv2ZZXizukoLpYjWQVN+kGnwU9+b
         Lzcsj0KBWqVqXCXW1dU93e/tb8ztdI/Iah0sVLIx/Vm2xt+F3Qw4EyCfJSh0c+fVSAAd
         BXbuOQsDG4eA9XU+vX8GctVpdHFSCQDxWBQLNqqDtpECPUKbSB6QPbYuMVaSGop3GXyN
         CMSiP7oWAX/TBjQR9IDX9QuhwtXdbz3y8UAjWml2k8g18RIOglwt65dRstxmrpGrBTWJ
         RRkw==
X-Forwarded-Encrypted: i=1; AJvYcCXUzlXEXjQxUgE24mh6UfvHNZaieinM8Cis0ufRSeNXIBZdcGzv1D+v3GURFCF65OTL7GNV8eXil1ZhY7Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuKIGpUQ1JA7L1tbz9CXvrkiUAkGERLpPkZAP3wtwBoInCYopR
	RTt8VSr3GYljC78d0Iu3ardSUfkos0fGiRA+je6dC/fq+sdLiXF5Z5UYQI4joz4=
X-Google-Smtp-Source: AGHT+IH08wIcIro8Jehvl/Hi929ZBc8qRS7+U/oFTc3nEePg/wnCtxc7gBUpCSptuXI5+Y+n2+ZYgA==
X-Received: by 2002:a5d:588e:0:b0:374:d088:476f with SMTP id ffacd0b85a97d-374d0884b17mr191134f8f.5.1725263544757;
        Mon, 02 Sep 2024 00:52:24 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.82])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ba641db12sm164768265e9.35.2024.09.02.00.52.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 00:52:24 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/2] arm64: dts: imx8mm-var-som: drop unused top-level compatible
Date: Mon,  2 Sep 2024 09:52:19 +0200
Message-ID: <20240902075220.27971-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Variscite VAR-SOM-MX8MM System-on-Module cannot be used alone
without motherboard, so drop the top-level compatible field to avoid any
false impression that such usage is possible.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/freescale/imx8mm-var-som.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-var-som.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-var-som.dtsi
index d7830df5b6f9..cdfacbc35db5 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-var-som.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-var-som.dtsi
@@ -8,7 +8,6 @@
 
 / {
 	model = "Variscite VAR-SOM-MX8MM module";
-	compatible = "variscite,var-som-mx8mm", "fsl,imx8mm";
 
 	chosen {
 		stdout-path = &uart4;
-- 
2.43.0


