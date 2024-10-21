Return-Path: <linux-kernel+bounces-374111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ACFF29A63AB
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 12:38:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8AF32B273AE
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 10:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E83C1F1308;
	Mon, 21 Oct 2024 10:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xS7BtQmI"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399951EABD1
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 10:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729506803; cv=none; b=uj/cAtd4haBzwC4014NT0Az1fweHM5FOUB/+v5Y24b1+IO9uWEGZOtdcwdXZnlvUEZ6dIGVDoHGUPoqswn/lVCAjVw5Cgt6XnUZxlt+MStmhgyu+UGfgxsZiWxymVhSob9GlopjRWfmc7WgioYgWDv1Ky6AcMUvb8PjJ0iJWvQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729506803; c=relaxed/simple;
	bh=W4/vDRwVV7Of/fJJlqT46Dx7PzvQidb+t0kRpal68/c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aSQx2UD1LiuwY6mS/rkrINiBxWdOBmrAtexHWKGgmBH0CVXorveH+jlLtIgNEpkhVlKoHJ92j2yYy1ZtKc5t7HHXJbUYIS2Wlo1HtSgjjq0T9muP18JiNzIWIf/YvXfLYAzkp29VslTmOgtHerai3wt06RenWY36kGjrOO0kfz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xS7BtQmI; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-539e690479cso4475356e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 03:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729506799; x=1730111599; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a2eyUP7PqA7x+pyAdp03ksII8x7mpw580zNqO7054tI=;
        b=xS7BtQmIHEY6wcWbrQBIR+H3P4PhJfvWcZr7odtYA2bLaW+3HDqI9CGDRUl20MJUhM
         X1W3cGil2sm0SK4HniJKvpmu5eNdgqXvKdPADXZdBDpy72K9/GMq4zm3YA6kuTrHElZu
         /vUzsX1Gxk9okdo3AJ3TuVi2V4UxUFZj6wyvYzbpPsv9e/rkMkmeUH/8PSIW0w6fn1mM
         WCbhjuiPKITC7BbFsm7gRFD42uL5CqSgXKuWVwkwlvgWtI4uHcZw+4hURAl+Pdi7wSW7
         UeP6DRLlLe99eXWpFUo1GqMG9pf4qAT3oxrP6scI6EFlA3R2Rvjf8Sxrdo5i2Vze/rRD
         jgnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729506799; x=1730111599;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a2eyUP7PqA7x+pyAdp03ksII8x7mpw580zNqO7054tI=;
        b=GiOMap0+4Zid6lTYXjeIZPMH+LkYjH2r5MW3vGuhOi+ZOGY1Yzye8kSwsUEP5Kn6h/
         RK/zVEy5oNsf8MMyiR9IR+HCfCPPzbGKH2Lj8u750lbZ86y6oDacBhnmmTjw1fAgt3Zc
         VF4mUxNirm1vXfNmqnQ3HJGAnoeVaD8cRBEvmpOv8KhQX+qZjlxSKTD6TaPfrdWiav4K
         a8gL4xu1MjpbqJO5csVUGEWmP3toGGY4igxI9zVedUBC+aywNYmBhISKy5jR/zis7sOR
         ANQwCLuIpumRa5bZn5H4X1Dd6yIakOUmahkfOcJ4nJNvnPN0C2Ohy/vVI64/bu6NPT34
         pFpg==
X-Forwarded-Encrypted: i=1; AJvYcCX1IRC5KtEkb8mRlRP+F1K5Si8Iugplt9wz2BfT6xreAJw6QyU45zjiK+/5cG9SI9Ds2dNGKtLowjnn3o0=@vger.kernel.org
X-Gm-Message-State: AOJu0YybioS3lB8VPMXNrtEbzP0MWpqd+no3sYYScQTHwjdK0ib2dvPn
	chNSbYVnAoMA3Imf1KxQLatRa/VrsYcpCFvAyny8ZfeBDlrl/yf767HraKexMrx4GWzh/f2axT9
	z96A=
X-Google-Smtp-Source: AGHT+IFZo5GW8v+yyp5vYLGPYf+byaJGKXtBt33CKtMNWs/N57lLW1TNpqYN1A01/pdjvy9xiNmH6w==
X-Received: by 2002:a05:6512:31c1:b0:539:8b02:8f1d with SMTP id 2adb3069b0e04-53a154b0defmr5386722e87.30.1729506798993;
        Mon, 21 Oct 2024 03:33:18 -0700 (PDT)
Received: from [127.0.1.1] (2001-14ba-a0c3-3a00-70b-e6fc-b322-6a1b.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:70b:e6fc:b322:6a1b])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53a22420015sm454132e87.123.2024.10.21.03.33.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 03:33:17 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 21 Oct 2024 13:33:11 +0300
Subject: [PATCH v2 5/6] phy: qualcomm: qmp-pcie: define several new
 registers
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241021-sar2130p-phys-v2-5-d883acf170f7@linaro.org>
References: <20241021-sar2130p-phys-v2-0-d883acf170f7@linaro.org>
In-Reply-To: <20241021-sar2130p-phys-v2-0-d883acf170f7@linaro.org>
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Johan Hovold <johan+linaro@kernel.org>, linux-arm-msm@vger.kernel.org, 
 linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2284;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=W4/vDRwVV7Of/fJJlqT46Dx7PzvQidb+t0kRpal68/c=;
 b=owEBbQKS/ZANAwAKARTbcu2+gGW4AcsmYgBnFi3llK2VMAdY8RUvXi7sII6DECPUY7pUyprnl
 MYczqI15pGJAjMEAAEKAB0WIQRdB85SOKWMgfgVe+4U23LtvoBluAUCZxYt5QAKCRAU23LtvoBl
 uLB6EACdoVicC9lvaF5ZXStdqwm5+9LS21uvk3TMKsFB7IcKVYBWkits/r5kFxwVxdZrIpytfdt
 fiRW44IsX3j1xHe8vXD/qDbcuFwr/j1blNjerISF+U6NDplZTuqizqwGqaTF2j3Y9Md4yiUrhYo
 5GvQ9QJFNuw2PMEP4g2Tfoscc0/kAwDahgJn9jHXczG/iUQx5iHy2SZp7rQ7bUXMl09INF1zs5x
 PmzNHOQw8wM5ApBUa6LXdeTeqAWDBHmnumCSIKYXkG9TOOc4IgHPUFUc2Xp3yMA7sjcFOAM4aOj
 xheeF9gObKzuJEMt/GtHsdniLYr25UQiZc2RcK7h0IEyP+FUWKb/4SECx87mzvwDDwVuwF9irHj
 oUI832DiOROA/48Ks2SaOO3eGrVh7nm8WQoKl6XSJBv5FpNSogofrWXGYm/8YE9HQverEaOURB8
 P3rr15TCcrXc10DpSXk5YprHQv5LFbeS44//UnfsYO3tb6Ef8YY9WZDDFcojyNcxpFj5pWtnGVm
 MNqqoMxeq9Du1HLFIZOEOJt9qtD9DuRe7WWUi/5eymvxAK1CAUmByfKE8j4ACh/P3EsPOCGa+Io
 0/xLInDJyIPBcvKgJRQG4yTlk2Bkos5NwU58TSkYhPBWIfOxtwnbarhgKCK7NAaYmvLFocGbhDl
 w2LmihHdr+dm7TQ==
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Define several registers to be used by PCIe QMP PHYs on v6 platforms.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v6.h     | 3 +++
 drivers/phy/qualcomm/phy-qcom-qmp-pcs-v6.h          | 2 ++
 drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v6.h | 1 +
 3 files changed, 6 insertions(+)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v6.h b/drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v6.h
index 0ca79333d94261610f7274968c96362dcfb1f354..45397cb3c0c6fd2cd989ddc600510589792a3b1a 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v6.h
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v6.h
@@ -14,4 +14,7 @@
 #define QPHY_PCIE_V6_PCS_PCIE_ENDPOINT_REFCLK_DRIVE	0x20
 #define QPHY_PCIE_V6_PCS_PCIE_OSC_DTCT_ACTIONS		0x94
 
+#define QPHY_PCIE_V6_PCS_LANE1_INSIG_SW_CTRL2		0x024
+#define QPHY_PCIE_V6_PCS_LANE1_INSIG_MX_CTRL2		0x028
+
 #endif
diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcs-v6.h b/drivers/phy/qualcomm/phy-qcom-qmp-pcs-v6.h
index 08299d2b78f096fa5f9388a4d54ddfa85667b18c..aa5afb921f12c07e0648f69433a2e6e2fb756c07 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-pcs-v6.h
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcs-v6.h
@@ -17,6 +17,8 @@
 #define QPHY_V6_PCS_LOCK_DETECT_CONFIG3		0x0cc
 #define QPHY_V6_PCS_LOCK_DETECT_CONFIG6		0x0d8
 #define QPHY_V6_PCS_REFGEN_REQ_CONFIG1		0x0dc
+#define QPHY_V6_PCS_G12S1_TXDEEMPH_M6DB		0x168
+#define QPHY_V6_PCS_G3S2_PRE_GAIN		0x170
 #define QPHY_V6_PCS_RX_SIGDET_LVL		0x188
 #define QPHY_V6_PCS_RCVR_DTCT_DLY_P1U2_L	0x190
 #define QPHY_V6_PCS_RCVR_DTCT_DLY_P1U2_H	0x194
diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v6.h b/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v6.h
index 23ffcfae9efab4a9e081414f9b3bbd0079d34f18..f47fdc9cecda8c4fe46c83e6449d68c033cd7fe2 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v6.h
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v6.h
@@ -6,6 +6,7 @@
 #ifndef QCOM_PHY_QMP_QSERDES_TXRX_USB_V6_H_
 #define QCOM_PHY_QMP_QSERDES_TXRX_USB_V6_H_
 
+#define QSERDES_V6_TX_BIST_MODE_LANENO				0x00
 #define QSERDES_V6_TX_CLKBUF_ENABLE				0x08
 #define QSERDES_V6_TX_TX_EMP_POST1_LVL				0x0c
 #define QSERDES_V6_TX_TX_DRV_LVL				0x14

-- 
2.39.5


