Return-Path: <linux-kernel+bounces-371714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42B409A3F12
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 15:02:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF9571F257E1
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 13:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAB711885B8;
	Fri, 18 Oct 2024 13:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tNB2UpFd"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05FC24084C
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 13:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729256547; cv=none; b=aIMfA/2Q2mtjTpPdqn8IcoU7wtDktQfhsVYMSwXXBvXfJ2VY2DwjP/IsEYMoZWWWhYgRtWdIEOsVGlz3SARlkpL7F3FsrMDUXElUquhwJXjVp8sFt+ELvT6mwiFi3SQd0TMGt1hrae+37BNx7DQnyUbUlD23YUiSrqoYBWUuBuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729256547; c=relaxed/simple;
	bh=C49UxWfwudobA0oVeClthd6MHqj4KuKHQV+wJPs4JKE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bKcmO08A4cHm6AdBMhpPXlwHV06E6zYmKa/327CR9WIN9uc2GIa5IHbthR9U5BtnrX5B4x9ao1+rdd/mWRozdHtYctZ4QEktRYG3XKQgpsTTAAj8g5CcTapbkTtfV3bmmTDeNVNH0IX03SCLk+zA7oq0wxAnoVlS2zdhYInQino=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tNB2UpFd; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4314f38d274so27276435e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 06:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729256543; x=1729861343; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Yo1uQJUXg8PU6STfdxAj8qXez3dTCFvPnWXMLXqyc/s=;
        b=tNB2UpFd/zjJhQcAjfZvljB7rjMaJl1fWHJ0QcT65qs0QrYEGAG82MkXgZQxg34d3V
         cw9Zwrmjp1HezoZy7mUaoLEdw3BFapjN45VnWzCw84cyS3ghomeSoiHgIxevu9KfqB9U
         MKMKQ61G6HMsfW1rOenLEAL66WAyHN+hcfWVExemuJrKr0SBHSnDw3AcdGDNWEfxMs30
         5K8xE1gzegvBFoK+dU7iPciqccKOEdEMRWf5XRO/t1Fc36U6ArpxDHcpQcAnxZEAkbP6
         FSCTBzY33uM5n+4acWi9ae6w52R010kT9TljBafkxkLjbjNAJtbHtd4q5L1ePbpHUCMJ
         XfQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729256543; x=1729861343;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yo1uQJUXg8PU6STfdxAj8qXez3dTCFvPnWXMLXqyc/s=;
        b=hbn/x52YvF/oEQSAoK7T3CLap8mDnTk6DZesyPCa6NL63tzGPXhHZ1vRZuq9KUoGk1
         UFhelHX5gqxG7Vt/rtXj+Ii/dikoVEzx9xe+0TdKlsbU5dYkhqS36+wbHFL1TdQHuFou
         Nhn9z+MtIb/uat0lYRj6HGDIkVIl1DmgqGy7p80DCjEwin44qoJVl0zNpa9+wo+H0OEZ
         2uvn5lt/QG0I+JqaxM4+FTS2vARXbRTnMIkAFmGIdi6uc25TuIPQfHLOzx35ywP2ylKp
         hsqG2sqdt298hgjF6HADQmTtoXO2LS/YcoHeCIC+4D9prCY+xSPPXVKsyYeb+IB7CACM
         HK5Q==
X-Forwarded-Encrypted: i=1; AJvYcCXdN/+Z5T17xGLCbjX3wtR8tYQ/ZtRlkaDr+D1pcdzWSiu8EikN8E0kjhBliMZcRca9PxV8WCTBvLtnWoI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywmna8Mlc3AH9RJrXGbd8L51bebNcE6UsGs9LWtCD1zFz7Sd6dd
	Ej34LfvwaTNQKF/Uz1I7S6vJvywUvD8SuIWedmtccdJD+MjDk5gf9RPpxudzACA=
X-Google-Smtp-Source: AGHT+IGkFYJMVKXgPlKjlx/nVstLc5egfgTDX9ehcNEDC23QAyFPkTSDwFGn5cVXBVuGdzsNw3ENeQ==
X-Received: by 2002:a05:600c:c89:b0:431:4847:47c0 with SMTP id 5b1f17b1804b1-4316161ede4mr21601655e9.7.1729256542645;
        Fri, 18 Oct 2024 06:02:22 -0700 (PDT)
Received: from gpeter-l.lan ([209.198.129.62])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43160e44404sm23616735e9.35.2024.10.18.06.02.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 06:02:21 -0700 (PDT)
From: Peter Griffin <peter.griffin@linaro.org>
To: peter.griffin@linaro.org,
	krzk@kernel.org,
	s.nawrocki@samsung.com,
	cw00.choi@samsung.com,
	alim.akhtar@samsung.com,
	mturquette@baylibre.com,
	sboyd@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tudor.ambarus@linaro.org,
	andre.draszik@linaro.org,
	kernel-team@android.com,
	willmcvicker@google.com
Subject: [PATCH] clk: samsung: gs101: make all ufs related clocks critical
Date: Fri, 18 Oct 2024 14:02:15 +0100
Message-ID: <20241018130215.487425-1-peter.griffin@linaro.org>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enabling UFSHCD_CAP_HIBERN8_WITH_CLK_GATING in the UFS driver means
all UFS clocks are gated/ungated, which leads to the UFS IP getting
into a bad state and being completely non functional.

Downstream these clocks are all left in Automatic Clock Gate (ACG)
mode, and are not exposed to the UFS driver in DT. Enabling ACG is
ultimately what we need to do in the upstream Samsung clock driver
as well.

However until ACG is enabled upstream, we mark these clocks as
critical to avoid them being disabled. This then allow us to enable
UFSHCD_CAP_HIBERN8_WITH_CLK_GATING and have UFS hibern8.

Whilst this may seem at first glance a strange thing to do, the clocks
between UFS host and UFS device are still gated after this change, and
enabling UFS hibern8 leads to substantially cooler device when running
the upstream kernel on a Pixel 6 phone. This change only effects the
clocks from the CMU to the UFS IP.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
 drivers/clk/samsung/clk-gs101.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/samsung/clk-gs101.c b/drivers/clk/samsung/clk-gs101.c
index 85098c61c15e..86b39edba122 100644
--- a/drivers/clk/samsung/clk-gs101.c
+++ b/drivers/clk/samsung/clk-gs101.c
@@ -2775,11 +2775,11 @@ static const struct samsung_gate_clock hsi2_gate_clks[] __initconst = {
 	GATE(CLK_GOUT_HSI2_QE_UFS_EMBD_HSI2_ACLK,
 	     "gout_hsi2_qe_ufs_embd_hsi2_aclk", "mout_hsi2_bus_user",
 	     CLK_CON_GAT_GOUT_BLK_HSI2_UID_QE_UFS_EMBD_HSI2_IPCLKPORT_ACLK,
-	     21, 0, 0),
+	     21, CLK_IS_CRITICAL, 0),
 	GATE(CLK_GOUT_HSI2_QE_UFS_EMBD_HSI2_PCLK,
 	     "gout_hsi2_qe_ufs_embd_hsi2_pclk", "mout_hsi2_bus_user",
 	     CLK_CON_GAT_GOUT_BLK_HSI2_UID_QE_UFS_EMBD_HSI2_IPCLKPORT_PCLK,
-	     21, 0, 0),
+	     21, CLK_IS_CRITICAL, 0),
 	GATE(CLK_GOUT_HSI2_CLK_HSI2_BUS_CLK,
 	     "gout_hsi2_clk_hsi2_bus_clk", "mout_hsi2_bus_user",
 	     CLK_CON_GAT_GOUT_BLK_HSI2_UID_RSTNSYNC_CLK_HSI2_BUS_IPCLKPORT_CLK,
@@ -2806,7 +2806,7 @@ static const struct samsung_gate_clock hsi2_gate_clks[] __initconst = {
 	GATE(CLK_GOUT_HSI2_SYSREG_HSI2_PCLK,
 	     "gout_hsi2_sysreg_hsi2_pclk", "mout_hsi2_bus_user",
 	     CLK_CON_GAT_GOUT_BLK_HSI2_UID_SYSREG_HSI2_IPCLKPORT_PCLK,
-	     21, 0, 0),
+	     21, CLK_IS_CRITICAL, 0),
 	GATE(CLK_GOUT_HSI2_UASC_PCIE_GEN4A_DBI_1_ACLK,
 	     "gout_hsi2_uasc_pcie_gen4a_dbi_1_aclk", "mout_hsi2_bus_user",
 	     CLK_CON_GAT_GOUT_BLK_HSI2_UID_UASC_PCIE_GEN4A_DBI_1_IPCLKPORT_ACLK,
@@ -2842,7 +2842,7 @@ static const struct samsung_gate_clock hsi2_gate_clks[] __initconst = {
 	GATE(CLK_GOUT_HSI2_UFS_EMBD_I_ACLK,
 	     "gout_hsi2_ufs_embd_i_aclk", "mout_hsi2_bus_user",
 	     CLK_CON_GAT_GOUT_BLK_HSI2_UID_UFS_EMBD_IPCLKPORT_I_ACLK,
-	     21, 0, 0),
+	     21, CLK_IS_CRITICAL, 0),
 	GATE(CLK_GOUT_HSI2_UFS_EMBD_I_CLK_UNIPRO,
 	     "gout_hsi2_ufs_embd_i_clk_unipro", "mout_hsi2_ufs_embd_user",
 	     CLK_CON_GAT_GOUT_BLK_HSI2_UID_UFS_EMBD_IPCLKPORT_I_CLK_UNIPRO,
@@ -2850,7 +2850,7 @@ static const struct samsung_gate_clock hsi2_gate_clks[] __initconst = {
 	GATE(CLK_GOUT_HSI2_UFS_EMBD_I_FMP_CLK,
 	     "gout_hsi2_ufs_embd_i_fmp_clk", "mout_hsi2_bus_user",
 	     CLK_CON_GAT_GOUT_BLK_HSI2_UID_UFS_EMBD_IPCLKPORT_I_FMP_CLK,
-	     21, 0, 0),
+	     21, CLK_IS_CRITICAL, 0),
 	/* TODO: should have a driver for this */
 	GATE(CLK_GOUT_HSI2_XIU_D_HSI2_ACLK,
 	     "gout_hsi2_xiu_d_hsi2_aclk", "mout_hsi2_bus_user",
-- 
2.47.0.rc1.288.g06298d1525-goog


