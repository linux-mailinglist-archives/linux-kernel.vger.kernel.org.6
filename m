Return-Path: <linux-kernel+bounces-522017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75399A3C4E9
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 17:26:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 906CF3AE73E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 16:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 000411FECA9;
	Wed, 19 Feb 2025 16:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QSCGc83e"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C1B1FE469
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 16:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739982229; cv=none; b=H8sdVL6w7he+0mveEfEw/xqcScfKDPM014FfVtyrGe01oi2ogxXvgNBnNTtbFNlU6KWO1xMOiDT/0DYH16mk1/ABrQQ4hQCuecvkn8x4f81zMujnY/XoK2AVp5aBvjWa3DgP234VDLTgOtkWWvOBleW7rOYPs/uQvsom4Jg5PkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739982229; c=relaxed/simple;
	bh=e7uWihHaRuX3l60xcjRDNo7zV9F+Ds60faI4+TOm1Tw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jtgIgszNG1FsExUX17/TtUooujEJftFEYE7VFzNI3mARVg0gX7GrAyVaaqTbbD9VoAwVN5SWcIGDs/KUQcY+I1DkSF+Ud5De+nqxwHCsxpkQgiz/4bNG48GmecLGOm8ICEXurc39UqMjEr8QYfBsh0a0aSMkxw4R2eqyKPz8MZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QSCGc83e; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4397185cfa9so4102415e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 08:23:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739982226; x=1740587026; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=STDYxeOydJEmeZwWEUJZhgJUaxAx3cfQSyjYXjHJqhE=;
        b=QSCGc83eVgV9H49UYQE3nB15kElFnPfz8oT5zDy5Ho375u49jODjqCCJae5PJs+mf5
         wh5CxuVvMtTAz5t/AYFk1S7sO8ryn7+zxMat3rVNPvDlg+H/OwCwPoNUQHFAbR++g+2J
         LR1vDL2309owPum5sajjpQy5wX3GD/abaRad+SIjr1AF1EQ2LrR2kKVDiZC7zlyfwLOK
         tmXMQplPFRSOQQIIn8Rdg+xhaGKY7HUDjEefvbyfe/wyGQRt0YlXVaAVpYfrkhia31+f
         Fk3i5Pxfspb2tVtb5hM5DyQhzojXi6dkMSjIywVPHwGcwKOxkJWi5kmWCSc9u161jX2L
         r5oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739982226; x=1740587026;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=STDYxeOydJEmeZwWEUJZhgJUaxAx3cfQSyjYXjHJqhE=;
        b=qDhf5Qsd3FbrTXUjUVnaDQVqVJDIWAkwAxmp5yUP0X9zZE9zsbJ5P/22eqkgysHXK+
         l7x2zlZxYEp2qhTiBTrt5jMKPPth1qkanHZNIO1pUhlSwhUe0uyT8ypIVMFKtA76OC+W
         q+4Oj5II274zjYhAmPuu2QqlVUQE7IHg9xbxjWHDxGEu9Dbn5unqPpVAi1AxRGx6cvPb
         CSoXju0ezi3F0Wf5YMVZiCaLkcxYWccHufjNMomT4mjPJ3eglgmdcMF+jtreEkztqYoA
         3HLg0SdYj+nycYAuendya+rYxiLGL2SrddmwMZePJEjVTS/ewKvG3KqXPvRx2IvFDSii
         3E7w==
X-Forwarded-Encrypted: i=1; AJvYcCX11eUBUBqDtP9D562ZDwpeXtIC29Dt4jki1f+9C/Hs4Tpq7vbuQ+kICOfujW85fHJno8aTwL0YFdYwOdM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx43wBk6Fp3FjuJMNi8reu9VKWAPtToV2gx39libCq+rOFe6wvt
	1Z2edvsjBQIA1kylJbQdsO7WNbYg+zkOanupW1XghgTgGt/CWCK1HZIOYgKpyCY=
X-Gm-Gg: ASbGnctkws6qN0hGjVkDBbA4pY5S9lNCMvBXDwwwN3CF5LFGQ5DVT8QDEBVdX3C6pGl
	Kg5n4BCCVubbjDUjVJcpCWXRe7cnKxSZ6nMQU/05J0j4awDHe1b9VGJ90k7qBG8Og/BnXuno8qV
	ldeNYCFdx28bw+LCO1fIKD5b+mZvIoWOcvkG+FT50kV1xAvmjDy9Rl3izWvQyNqF0t6PeWPKUS9
	gnNTgBj8J2vuGluMN0AEl2/P6wJLO+FMOwilyqbgzy7k07bsyucMVVgnm6cLhOwWW8TDbm2GoUd
	serbo1YNi35AlxVNz3aQHyi4cZFSVNw=
X-Google-Smtp-Source: AGHT+IFCXH6juWXCxM4namsDbJk7fdm7tD4GiYlIZEnzx6Vaog88SCNo/gNggeL5ghgnRcT3Fr5pqw==
X-Received: by 2002:a05:600c:1512:b0:439:8b19:fa9a with SMTP id 5b1f17b1804b1-4398b19fc41mr36232625e9.2.1739982225613;
        Wed, 19 Feb 2025 08:23:45 -0800 (PST)
Received: from [127.0.1.1] ([178.197.206.225])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f25a0fe5esm18442417f8f.99.2025.02.19.08.23.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 08:23:45 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 19 Feb 2025 17:23:33 +0100
Subject: [PATCH v5 2/2] drm/msm/dsi/phy: Define PHY_CMN_CLK_CFG[01]
 bitfields and simplify saving
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250219-drm-msm-phy-pll-cfg-reg-v5-2-d28973fa513a@linaro.org>
References: <20250219-drm-msm-phy-pll-cfg-reg-v5-0-d28973fa513a@linaro.org>
In-Reply-To: <20250219-drm-msm-phy-pll-cfg-reg-v5-0-d28973fa513a@linaro.org>
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Jonathan Marek <jonathan@marek.ca>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Rob Clark <robdclark@chromium.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2560;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=e7uWihHaRuX3l60xcjRDNo7zV9F+Ds60faI4+TOm1Tw=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBntgWLptxlLsDSPuC13zxCb4GjCqFlevEaleizP
 796ZuFHIgGJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZ7YFiwAKCRDBN2bmhouD
 1/uWD/9Tvjr1rRMWsPNMmAYYIaKkacdXn8m5XOmuCW4DbdnsCKrLkiQMbMlWLiy1dY6qPP7IJxt
 SwAnt2GRPWIxdM8N504hqqx+PG7vc85jOsIh55NAUUFMrHiJbTZ8pTrKat8MOCwb56TVtOLnuKa
 vHomGZwcGqRCZN2TfJ2YdtZWYVQGG01ylF9AEm3LSZHKYB2ykLLgD8locKlvyGymRkOPnSsIWy+
 bXwDv1PkzYSFrSo8CnA5asBzdJHJWEHzGkNbQJCqWuubTtqL1ribeOaYa++cyN/TSWXZMfHBmc0
 z5DZAVQn295rzoroUmrFVSoTEegzudPiICE2Y1NhdLMSZpn/8Oqu52C0/nbSbzMqpDjLb4JHtC4
 WQJtKv1zSumQI1p1xe+StDtLPCm6upiOEfIm0DA3EJaFcTrZWsxY4AnOiZ/V7+hv7QjmRsOBquM
 28PZtgQBdeiW2Uy+2r3y0K7hHb6dJHWEWAdS1DvZDZ15soRKXKJjdZJtaZ21R0z28CeJIBrh2z1
 QgOWGlBbqsWdlFyuwc0Naioi03zY4xCOrJP5Yn7SJEOTBDJj5fckmQOzZkUAAPVDPxNmKjHaCLO
 7psBxs/jikM6sJz/qX+6QfaItHvskVAmhULu23h45HYbbtZnQHf5mqac+g0KlRwMINhciDKtLyh
 VHtIGFCovaGZjJg==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Add bitfields for PHY_CMN_CLK_CFG0 and PHY_CMN_CLK_CFG1 registers to
avoid hard-coding bit masks and shifts and make the code a bit more
readable.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes in v5:
1. Split part touching pll_7nm_register() to new patch.
2. Update commit msg.

Changes in v4:
1. Add mising bitfield.h include
2. One more FIELD_GET and DSI_7nm_PHY_CMN_CLK_CFG1_DSICLK_SEL (Dmitry)

Changes in v3:
1. Use FIELD_GET
2. Keep separate bit_clk_div and pix_clk_div
3. Rebase (some things moved to previous patches)

Changes in v2:
1. New patch
---
 drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c b/drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c
index 2fca469b10b33ac2350de5ab8a606704e84800ea..5ef5bc252019486c6f24f256d88d69ad3f6c838b 100644
--- a/drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c
+++ b/drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c
@@ -3,6 +3,7 @@
  * Copyright (c) 2018, The Linux Foundation
  */
 
+#include <linux/bitfield.h>
 #include <linux/clk.h>
 #include <linux/clk-provider.h>
 #include <linux/iopoll.h>
@@ -572,11 +573,11 @@ static void dsi_7nm_pll_save_state(struct msm_dsi_phy *phy)
 	cached->pll_out_div &= 0x3;
 
 	cmn_clk_cfg0 = readl(phy_base + REG_DSI_7nm_PHY_CMN_CLK_CFG0);
-	cached->bit_clk_div = cmn_clk_cfg0 & 0xf;
-	cached->pix_clk_div = (cmn_clk_cfg0 & 0xf0) >> 4;
+	cached->bit_clk_div = FIELD_GET(DSI_7nm_PHY_CMN_CLK_CFG0_DIV_CTRL_3_0__MASK, cmn_clk_cfg0);
+	cached->pix_clk_div = FIELD_GET(DSI_7nm_PHY_CMN_CLK_CFG0_DIV_CTRL_7_4__MASK, cmn_clk_cfg0);
 
 	cmn_clk_cfg1 = readl(phy_base + REG_DSI_7nm_PHY_CMN_CLK_CFG1);
-	cached->pll_mux = cmn_clk_cfg1 & 0x3;
+	cached->pll_mux = FIELD_GET(DSI_7nm_PHY_CMN_CLK_CFG1_DSICLK_SEL__MASK, cmn_clk_cfg1);
 
 	DBG("DSI PLL%d outdiv %x bit_clk_div %x pix_clk_div %x pll_mux %x",
 	    pll_7nm->phy->id, cached->pll_out_div, cached->bit_clk_div,
@@ -598,7 +599,8 @@ static int dsi_7nm_pll_restore_state(struct msm_dsi_phy *phy)
 	dsi_pll_cmn_clk_cfg0_write(pll_7nm,
 				   DSI_7nm_PHY_CMN_CLK_CFG0_DIV_CTRL_3_0(cached->bit_clk_div) |
 				   DSI_7nm_PHY_CMN_CLK_CFG0_DIV_CTRL_7_4(cached->pix_clk_div));
-	dsi_pll_cmn_clk_cfg1_update(pll_7nm, 0x3, cached->pll_mux);
+	dsi_pll_cmn_clk_cfg1_update(pll_7nm, DSI_7nm_PHY_CMN_CLK_CFG1_DSICLK_SEL__MASK,
+				    cached->pll_mux);
 
 	ret = dsi_pll_7nm_vco_set_rate(phy->vco_hw,
 			pll_7nm->vco_current_rate,

-- 
2.43.0


