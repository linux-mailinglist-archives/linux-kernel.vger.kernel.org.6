Return-Path: <linux-kernel+bounces-372930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3307C9A4F6C
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 17:46:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 544141C236CA
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 15:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1596191F78;
	Sat, 19 Oct 2024 15:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EY9DDAYq"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E943217BEC5
	for <linux-kernel@vger.kernel.org>; Sat, 19 Oct 2024 15:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729352709; cv=none; b=PC3hprew5r7tLJoNtB5iSYL3UNeQFdxrPyZkKzrxGp3/ILrlb6il1AH+aXszIrK91UxqRpuBHRLeeuPMTUc1EImj1jXAHM/kUki0BBi/KBA4TY2RNKZF4rhpJk+ttM68bzPlRTkEpTM+rk4Co17n5cL5FVUkrb8+SOmDtwIzW2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729352709; c=relaxed/simple;
	bh=W4/vDRwVV7Of/fJJlqT46Dx7PzvQidb+t0kRpal68/c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b4wpoJeZmJEHfx887sFFUUsGQsEbSSRNvb8zOKUYK8BANLb9Akqf1vkZtrRA+A/3C6IErpjcbOkdYNTELbMOkGBYTZi5PFomIzrZcqdB7ZzuCjKQ48ryAOUMTQhf23HYDGNHV9JOHo6gGDNy+garF3wNuOPZteWtVU54Xj/uWWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EY9DDAYq; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-539f6e1f756so3746771e87.0
        for <linux-kernel@vger.kernel.org>; Sat, 19 Oct 2024 08:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729352706; x=1729957506; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a2eyUP7PqA7x+pyAdp03ksII8x7mpw580zNqO7054tI=;
        b=EY9DDAYqnkMjsxkqCvH5YE2hWdIAvZ6uWG0Nitqf8/I8fGaGICfiTl61l4zTCMJaNW
         P4brp5BMBoHR3hYeibl6LEcNvigLDB4R9QeZeY6N5I2dO7IlVWOeuxu0whDngbc/568/
         l7mG2NYwIZfHPkUHiW/RmAFt8iKXsXavINpofYzR4bXEoDYWUENncksMlKoU8XOXd189
         d80Xi3h9Gl0Mhr4SbjlNcg4inh0Hs/hB98B4Lc34kanTLDiEEsE5VMdp8cholmobeF78
         y/qoM05Zpjtr9BNEPTyFZYsND09NYXiWTHfkcfTueCsDTDTPvI7+cfrTmJHH+z9N7zac
         ksPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729352706; x=1729957506;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a2eyUP7PqA7x+pyAdp03ksII8x7mpw580zNqO7054tI=;
        b=rT/Rwq4eeYLGJO3j5fj96dKeUjgY3AX/oKFa260BuK4/knWQRQfx5OyOKd9NF8p+X6
         YOOeQeFaRhPadaV6zZpr927O9H6w9eW24oY66NZem1YiZ4T1qIDxp9KPU/CqyJCaKFSk
         aPEGv3UrFUmqj0OWNmtEPvoWh2D+I8kdgE133el5BHL1RxnTQk6G3gDiQS20+lmCEo2C
         jo9x8UVEXtwTZrBGlae8tF09fEr1Z+z7tnBVp6vlt2OYHgGfhWu0tjhDaSi1otcpTwSI
         SSdPiNBq0YmPNtHUfFdLABoqutanOOT1NKsXeqZXTeGDgcHvokVCvOlobEgX7Q1u5HOb
         515Q==
X-Forwarded-Encrypted: i=1; AJvYcCU+X5BFURg5fe97bn8jAbGSW8oUHTVNE5sSddUuISSC1w2Ts142gW20COLM/c8zTxZINCtjrQ4Ei8QQusE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwG45pGgCNp9cQjryh45Wjl8GA84DHz0grvaf+eh0DdUcw6kPbE
	0rSC75DZP9yWhwxNBBk6jJSA8cSqJeWSxIlgPMH0IRMnhztbsoGmMGA6a9LHzIE=
X-Google-Smtp-Source: AGHT+IHYkxaqVw5cjcGpwc15iXsqxdS1REG0bROkgUTWFdJwNDtdPJFkX67nBhyMkA+cVatBoV0POQ==
X-Received: by 2002:a05:6512:3d23:b0:539:e5e9:2159 with SMTP id 2adb3069b0e04-53a1522a8d6mr3648948e87.31.1729352705832;
        Sat, 19 Oct 2024 08:45:05 -0700 (PDT)
Received: from [127.0.1.1] (2001-14ba-a0c3-3a00-70b-e6fc-b322-6a1b.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:70b:e6fc:b322:6a1b])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53a15211401sm562854e87.249.2024.10.19.08.45.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Oct 2024 08:45:05 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sat, 19 Oct 2024 18:44:54 +0300
Subject: [PATCH 5/6] phy: qualcomm: qmp-pcie: define several new registers
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241019-sar2130p-phys-v1-5-bf06fcea2421@linaro.org>
References: <20241019-sar2130p-phys-v1-0-bf06fcea2421@linaro.org>
In-Reply-To: <20241019-sar2130p-phys-v1-0-bf06fcea2421@linaro.org>
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2284;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=W4/vDRwVV7Of/fJJlqT46Dx7PzvQidb+t0kRpal68/c=;
 b=owEBbQKS/ZANAwAKARTbcu2+gGW4AcsmYgBnE9P11KkGH2U3FfSVJk4GXFitZtpTXBBZzkDtV
 X5dZJTX5mKJAjMEAAEKAB0WIQRdB85SOKWMgfgVe+4U23LtvoBluAUCZxPT9QAKCRAU23LtvoBl
 uNRiD/0ZwTFkuQxkkN7LyCCEOioAKMZH5mREhcnSqNdH9AXwgMFg458S24lOEL8+qMDN6Jw4hv3
 KGJVUkKe9RvHoV1+DH9EzeJ9a4g4dP4lOU1CB58hgyNSACs6p1zXGld2DgrBH+G5R+vyZf/G+t5
 nCE/cdQ5SMHDSqaOZvs/vgjOXDyN/DbMrv4kwO0mb+sUaoiIl7Fjlj8ZQdX0Jmyv2hy/NDxj3hL
 WZ2ptAkziXlieQiV31phKG2xzVx/HfF/fLSs9zWSU2Kh2bDK8BLMchFYQsPQwMw1w/12ccaiJxy
 RWTE0y4CCmWdcEZQtT7OSvRFEKxkzszAduFKp27P4Hk9J2ZtkqVKn1zQQzI7zurMmjTzMrwGKrt
 YMZP7xEhElvVBH4Ljlimcn/T2wVGYenE2AJnv2DJ+XTvpQghrSQsRJHLg/QXJPiwO5mxZHHnTU7
 f/HIaFev5UcegC5E7Zb55XBErHGJv4PWZXhA2QXcKZjIMIBHW1LfFzP1QFN9oomEhqmxM1wxMal
 aLh9GQhYd5RvoDV5jGhh/i9a4u7M8eP5gBYxsh9YJMKFpA3qLyyxJxlhcQ9EJ0RrbgKwb15lGs1
 AB+PPB/a8RHn4P4zR4EUQKZdrWYil77tDytAjuuQdVuAne6lWQ/MXx2dtei8qA+Au1EFlkJCJK6
 rENgrAGiegI9QXQ==
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


