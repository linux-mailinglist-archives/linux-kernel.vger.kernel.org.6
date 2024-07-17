Return-Path: <linux-kernel+bounces-255031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BDA33933AC5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 12:05:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7483D2814A5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 10:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEDFE1802DC;
	Wed, 17 Jul 2024 10:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KVfNyEWv"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B0D17FABC
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 10:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721210681; cv=none; b=Yy4SY9uPqeXoWxrcJflCO2Cy7IIMJJkdXPk1RG4s9rrJdOEaFDCmdlajt+WouxMsm4KSpHB/g0mSQUKxcu7z6mIfwaGFgkMFhWtNsGE1KgCCR8jrFclhvi2BKgBTDYctB7Onr+Gccj0uQV7J8reLIPXc+ZRvdtoyzWL1e4Qp3Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721210681; c=relaxed/simple;
	bh=Rks5U6PDlX023HI5XO41XNs0HluLCmpOuaHzGf+O+RI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ojXLDaTh1D1GenEC7R78Qm14TAiPNcYEL/DhEWOS4WS2oEYTW9p1EUhtYSIRGPa4kZKt8LWTjW+K+B6NWRBJJXHYOgLqoj2vlN7N6NizIPfktkNHyb5OiQKTu1u9zYOMzAGC6S4oYVtgGbVy+LvODzkDshO+TeckBz1eCgwinAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KVfNyEWv; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-52e9f788e7bso7901297e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 03:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721210678; x=1721815478; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NRiN27vGSJBcP1hIFG84vOcNjPJ4vrPRYJgyPKlQri0=;
        b=KVfNyEWv8LlUap6diZCJiUjLeEI3EdK8qFbql/w3AtJEVDxhd8RUtDtZROqouOFNCH
         Rp3kZAQ4i+X2JKapDzNwgeWRQcqCjl+2KIfQCLtatSx3qYxH8u4zuqpyYHL6IF4RFUIl
         kSo0LlJ4EfdTRHlaqJSwYwRDoAeLU+8bb3XmjNzZpZgBZV8FrV1JgIn3ynAN4nbZd43k
         km9RXaUen53dKNXdjuKHIkyNq8vIUKu4MTmhYo6oZdhiaI+Dsf+tZs2aGem4C7p5r2jp
         RAvPDNY5TuMrEBu7FdwolriyQBEMiTCCSeJCb2acjHyn96Cr+adUh4dzIwMjKwKolE2c
         SCCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721210678; x=1721815478;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NRiN27vGSJBcP1hIFG84vOcNjPJ4vrPRYJgyPKlQri0=;
        b=l/6k48rgC6/+vsPgH7a66GZJDMX1qCHPvfIgCN33GEypIDOgt2XCqptipfeJBreD0k
         uZb1QGIkgf0xfP94h+GpoYBLz9SS08kAfdWi9V6XNQLUNOOChRFhPvqU9Ys7HXwUbynq
         zJnZ4t6YXOUbdvXUYDv1CYoIlHlCACWE3OsQiUOkObqF0k8a/R8QAmX0f4IJbx1W1h1z
         w7aYQNIGWVXyREvpaPHBXkI2pRsZTBNxJcq1j3BRvjMNz4829eP1FE0RrfChLaWPz/FB
         dbpHqdbmQyiVU753cvyGstI0pBeGnKaHnI6n3WEv8mekPNk9q5+w+yhmOIfRvvvPTBR1
         fqsg==
X-Forwarded-Encrypted: i=1; AJvYcCUA8QSAmfTlGhRUxML1bUW8f8z8Ak/5eCeJJiuj9AcyKUjgQ3FwKafyrrGaC9EOctvNx1gYno9KQwpA6oWw4683YhnS/wZmK7o9Bp0T
X-Gm-Message-State: AOJu0YyQ9lH81Szuy+F6SivRHJWwgZhkr1yV8ytTl8q6myhiksiI/YjT
	xkkqSs17GfDkjBJPxa1jQSxG5Mw7dXCgSN17GbpSom9kLb8E2wgMaTxCdRfuBNI=
X-Google-Smtp-Source: AGHT+IGKVDX1FX90P7BWcIAL5e9jEmytU66bnnRH/koaXAiXPgMtcnuEYV3cdgkOxkBhkESp0HexeA==
X-Received: by 2002:a05:6512:3f18:b0:52c:deba:7e6e with SMTP id 2adb3069b0e04-52ee53cff20mr933709e87.29.1721210677806;
        Wed, 17 Jul 2024 03:04:37 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ed253924asm1425391e87.262.2024.07.17.03.04.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 03:04:37 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 17 Jul 2024 13:04:34 +0300
Subject: [PATCH v2 7/7] dt-bindings: clock: qcom,sm8650-dispcc: replace
 with symlink
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240717-dispcc-sm8550-fixes-v2-7-5c4a3128c40b@linaro.org>
References: <20240717-dispcc-sm8550-fixes-v2-0-5c4a3128c40b@linaro.org>
In-Reply-To: <20240717-dispcc-sm8550-fixes-v2-0-5c4a3128c40b@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5097;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=Rks5U6PDlX023HI5XO41XNs0HluLCmpOuaHzGf+O+RI=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBml5cumjXDiqUDeaTnkOwBbgAiBvt3/BiawV0+4
 vNaAZm9LGOJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZpeXLgAKCRCLPIo+Aiko
 1QqgB/9Zo5Ua2kMBkjo2TX2ytRlJEYg3mdFcP2dEyrA8cWqHyVC5hPGIi5DH+KwoemoIeD4sKm7
 L8/m3rVWLKQ/hYJ+H2P924jGuOv6K92QEyZwtR4WBVQ7bsbJmwKHhwDi4bOj8Nz7TWHvfVH9QlS
 fYlPvH9DMtG4N1k6DfaGfEApfGGs1ahaYpzBPwt6mL8rPnVzbMznIhnl0YbwncTErtpOhXTF3LO
 NGSr50Xoe22EhnCUUxQp/9zdr84SPDof8Ql6a3bIMqC4BbRs3zpMpvKFGF0VrKyYklSp+cLM+UR
 OHjkeocm6ucOSxTCutGeFUyvu8/r9D+UiAWVNxwc7GZ7oMUi
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

The display clock controller indices for SM8650 and SM8550 are
completely equal. Replace the header file for qcom,sm8650-dispcc with
the symlink to the qcom,sm8550-dispcc header file.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 include/dt-bindings/clock/qcom,sm8650-dispcc.h | 103 +------------------------
 1 file changed, 1 insertion(+), 102 deletions(-)

diff --git a/include/dt-bindings/clock/qcom,sm8650-dispcc.h b/include/dt-bindings/clock/qcom,sm8650-dispcc.h
deleted file mode 100644
index b0a668b395a5..000000000000
--- a/include/dt-bindings/clock/qcom,sm8650-dispcc.h
+++ /dev/null
@@ -1,102 +0,0 @@
-/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
-/*
- * Copyright (c) 2022, Qualcomm Innovation Center, Inc. All rights reserved
- * Copyright (c) 2023, Linaro Ltd.
- */
-
-#ifndef _DT_BINDINGS_CLK_QCOM_SM8650_DISP_CC_H
-#define _DT_BINDINGS_CLK_QCOM_SM8650_DISP_CC_H
-
-/* DISP_CC clocks */
-#define DISP_CC_MDSS_ACCU_CLK					0
-#define DISP_CC_MDSS_AHB1_CLK					1
-#define DISP_CC_MDSS_AHB_CLK					2
-#define DISP_CC_MDSS_AHB_CLK_SRC				3
-#define DISP_CC_MDSS_BYTE0_CLK					4
-#define DISP_CC_MDSS_BYTE0_CLK_SRC				5
-#define DISP_CC_MDSS_BYTE0_DIV_CLK_SRC				6
-#define DISP_CC_MDSS_BYTE0_INTF_CLK				7
-#define DISP_CC_MDSS_BYTE1_CLK					8
-#define DISP_CC_MDSS_BYTE1_CLK_SRC				9
-#define DISP_CC_MDSS_BYTE1_DIV_CLK_SRC				10
-#define DISP_CC_MDSS_BYTE1_INTF_CLK				11
-#define DISP_CC_MDSS_DPTX0_AUX_CLK				12
-#define DISP_CC_MDSS_DPTX0_AUX_CLK_SRC				13
-#define DISP_CC_MDSS_DPTX0_CRYPTO_CLK				14
-#define DISP_CC_MDSS_DPTX0_LINK_CLK				15
-#define DISP_CC_MDSS_DPTX0_LINK_CLK_SRC				16
-#define DISP_CC_MDSS_DPTX0_LINK_DIV_CLK_SRC			17
-#define DISP_CC_MDSS_DPTX0_LINK_INTF_CLK			18
-#define DISP_CC_MDSS_DPTX0_PIXEL0_CLK				19
-#define DISP_CC_MDSS_DPTX0_PIXEL0_CLK_SRC			20
-#define DISP_CC_MDSS_DPTX0_PIXEL1_CLK				21
-#define DISP_CC_MDSS_DPTX0_PIXEL1_CLK_SRC			22
-#define DISP_CC_MDSS_DPTX0_USB_ROUTER_LINK_INTF_CLK		23
-#define DISP_CC_MDSS_DPTX1_AUX_CLK				24
-#define DISP_CC_MDSS_DPTX1_AUX_CLK_SRC				25
-#define DISP_CC_MDSS_DPTX1_CRYPTO_CLK				26
-#define DISP_CC_MDSS_DPTX1_LINK_CLK				27
-#define DISP_CC_MDSS_DPTX1_LINK_CLK_SRC				28
-#define DISP_CC_MDSS_DPTX1_LINK_DIV_CLK_SRC			29
-#define DISP_CC_MDSS_DPTX1_LINK_INTF_CLK			30
-#define DISP_CC_MDSS_DPTX1_PIXEL0_CLK				31
-#define DISP_CC_MDSS_DPTX1_PIXEL0_CLK_SRC			32
-#define DISP_CC_MDSS_DPTX1_PIXEL1_CLK				33
-#define DISP_CC_MDSS_DPTX1_PIXEL1_CLK_SRC			34
-#define DISP_CC_MDSS_DPTX1_USB_ROUTER_LINK_INTF_CLK		35
-#define DISP_CC_MDSS_DPTX2_AUX_CLK				36
-#define DISP_CC_MDSS_DPTX2_AUX_CLK_SRC				37
-#define DISP_CC_MDSS_DPTX2_CRYPTO_CLK				38
-#define DISP_CC_MDSS_DPTX2_LINK_CLK				39
-#define DISP_CC_MDSS_DPTX2_LINK_CLK_SRC				40
-#define DISP_CC_MDSS_DPTX2_LINK_DIV_CLK_SRC			41
-#define DISP_CC_MDSS_DPTX2_LINK_INTF_CLK			42
-#define DISP_CC_MDSS_DPTX2_PIXEL0_CLK				43
-#define DISP_CC_MDSS_DPTX2_PIXEL0_CLK_SRC			44
-#define DISP_CC_MDSS_DPTX2_PIXEL1_CLK				45
-#define DISP_CC_MDSS_DPTX2_PIXEL1_CLK_SRC			46
-#define DISP_CC_MDSS_DPTX3_AUX_CLK				47
-#define DISP_CC_MDSS_DPTX3_AUX_CLK_SRC				48
-#define DISP_CC_MDSS_DPTX3_CRYPTO_CLK				49
-#define DISP_CC_MDSS_DPTX3_LINK_CLK				50
-#define DISP_CC_MDSS_DPTX3_LINK_CLK_SRC				51
-#define DISP_CC_MDSS_DPTX3_LINK_DIV_CLK_SRC			52
-#define DISP_CC_MDSS_DPTX3_LINK_INTF_CLK			53
-#define DISP_CC_MDSS_DPTX3_PIXEL0_CLK				54
-#define DISP_CC_MDSS_DPTX3_PIXEL0_CLK_SRC			55
-#define DISP_CC_MDSS_ESC0_CLK					56
-#define DISP_CC_MDSS_ESC0_CLK_SRC				57
-#define DISP_CC_MDSS_ESC1_CLK					58
-#define DISP_CC_MDSS_ESC1_CLK_SRC				59
-#define DISP_CC_MDSS_MDP1_CLK					60
-#define DISP_CC_MDSS_MDP_CLK					61
-#define DISP_CC_MDSS_MDP_CLK_SRC				62
-#define DISP_CC_MDSS_MDP_LUT1_CLK				63
-#define DISP_CC_MDSS_MDP_LUT_CLK				64
-#define DISP_CC_MDSS_NON_GDSC_AHB_CLK				65
-#define DISP_CC_MDSS_PCLK0_CLK					66
-#define DISP_CC_MDSS_PCLK0_CLK_SRC				67
-#define DISP_CC_MDSS_PCLK1_CLK					68
-#define DISP_CC_MDSS_PCLK1_CLK_SRC				69
-#define DISP_CC_MDSS_RSCC_AHB_CLK				70
-#define DISP_CC_MDSS_RSCC_VSYNC_CLK				71
-#define DISP_CC_MDSS_VSYNC1_CLK					72
-#define DISP_CC_MDSS_VSYNC_CLK					73
-#define DISP_CC_MDSS_VSYNC_CLK_SRC				74
-#define DISP_CC_PLL0						75
-#define DISP_CC_PLL1						76
-#define DISP_CC_SLEEP_CLK					77
-#define DISP_CC_SLEEP_CLK_SRC					78
-#define DISP_CC_XO_CLK						79
-#define DISP_CC_XO_CLK_SRC					80
-
-/* DISP_CC resets */
-#define DISP_CC_MDSS_CORE_BCR					0
-#define DISP_CC_MDSS_CORE_INT2_BCR				1
-#define DISP_CC_MDSS_RSCC_BCR					2
-
-/* DISP_CC GDSCR */
-#define MDSS_GDSC						0
-#define MDSS_INT2_GDSC						1
-
-#endif
diff --git a/include/dt-bindings/clock/qcom,sm8650-dispcc.h b/include/dt-bindings/clock/qcom,sm8650-dispcc.h
new file mode 120000
index 000000000000..c0a291188f28
--- /dev/null
+++ b/include/dt-bindings/clock/qcom,sm8650-dispcc.h
@@ -0,0 +1 @@
+qcom,sm8550-dispcc.h
\ No newline at end of file

-- 
2.39.2


