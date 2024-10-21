Return-Path: <linux-kernel+bounces-374112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 286A29A6395
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 12:37:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 492241C20A0F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 10:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63C561F4287;
	Mon, 21 Oct 2024 10:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K2y8SKgz"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F70C1EABD5
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 10:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729506805; cv=none; b=IAqVt8GSe+DsgG7bgN5UbXPeUe7OE4wr3Xwcm7h8+YvL8uSvVOotNAjfviCoR8NRrfpcGQPDjNE2igr/Of2s9hJxpQs3uRa32VhhOqTDfvX2jkhMSnJ2Cx3Ta8k/hvdK3vArVc/vNZjAeZDsjgFC1iy/oKHUi3LPGZg8E8rNBEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729506805; c=relaxed/simple;
	bh=C8i0BK5hjIYTgbsrEcYZTdHLVO8L8ePy9YX6HVa1xfY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TKiKBajCJQOjBwWjJ03SXevvC44JYalgUkzmlkCzuAXrK9HDmod8Un0x5wiFBlWmuMYhKYMRpLWdQfGYSBFUXdC7qajNi/CbjNdeAIsRCvpl7oNq/a9Bw45rVn6qDuzEDhdl2uSS1BYB+E2orkSH0y1WIY+zKiLyzWRF4RZb87I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=K2y8SKgz; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-539fbe22ac0so4697312e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 03:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729506801; x=1730111601; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j8gd1TRUah4UlBv9ZsEU3Mqp5q0KNFXM5pn6NKjKpmw=;
        b=K2y8SKgzVx5qt8qmYuKEWQnpPMWTAS4BN7v0FfhY6i7UdpjI2ttp1rrdRTSIGx8BSE
         Z89nbg+/iFBVw/WilfSYnNRCbEDQPJ+oJuoqqyQYaIM6TVTdY1X/0Mv1UAlsjiLv4i+N
         Vsnw94jBiPpFXB9HiYKa+6KOTHGZDPIgmoadIVDCRD+K5KsJs2XzPxV4nYbBZ2S4W6nb
         J8HEwIxY0l1zR9fH6pwfGDI8YqAIp1AuCwKVK9HQem5lOiMxen/xigcSrufkkifFh6ZO
         P2YFVkEZPo4/DZT0KBiyQEJdGMIqG0jPYA3uA5e9oUi3PyM205gU4MXR70R0BDMO43Vm
         +z3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729506801; x=1730111601;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j8gd1TRUah4UlBv9ZsEU3Mqp5q0KNFXM5pn6NKjKpmw=;
        b=OV/gygrPQdY1NA29d+1YezMpUbSftUbFiO6He3PrJwDsPtfI4qOCto1gEU5hzyuZTM
         E0d0dbwH38LA1GJz5ibcpKhPHVN9oH55Ulm8ZA0FZfFO7a2a8fCPWKzC9jO2kxyPeoxO
         asdpbUd8Di0X7MmA6ezl83+mYi6KTGfVzCzdoMhSc0wuS5SuqCKyFYSzhSy6i8hkOSe4
         genyYggRELjbdIiBmqL2bhW0ZJt7Gos1W7c9BD3yXsKW//KjmZhY1VOQGgTt8n9ayYgi
         X9GJN9JiTQ1Ff5hmQEve2o7nKAgHwKiwbQbQq6e+hkBIjIO31hfq0ohhUUs9iN3RZ40n
         VoXg==
X-Forwarded-Encrypted: i=1; AJvYcCWixgsK8Fbyu2uv3NdxedoCadIYi0Yo94/jPCESaCA12yUCSwuvlWdVye49D+yx/tmoBCrgeqYGZoLnJws=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaFPE5oTy2hAueEPl55fIKLm+yXcjvW9rXcI/bXnmMYb5/NrrV
	AO/8EeHbObbSoaJW76J/srcV/zXrI8QNyX2Ets5DluALRanuSJJXxPoa9xXft1A=
X-Google-Smtp-Source: AGHT+IGmj57mtq465eQeNEM3MJbB1FH4T/C55hHZQXWyS33zmmMnbFslGOovmnW593TY87rhPFRh9A==
X-Received: by 2002:a05:6512:3f18:b0:539:e60a:6dd0 with SMTP id 2adb3069b0e04-53a1545f5c1mr5230828e87.51.1729506800541;
        Mon, 21 Oct 2024 03:33:20 -0700 (PDT)
Received: from [127.0.1.1] (2001-14ba-a0c3-3a00-70b-e6fc-b322-6a1b.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:70b:e6fc:b322:6a1b])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53a22420015sm454132e87.123.2024.10.21.03.33.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 03:33:19 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 21 Oct 2024 13:33:12 +0300
Subject: [PATCH v2 6/6] phy: qualcomm: qmp-pcie: add support for SAR2130P
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241021-sar2130p-phys-v2-6-d883acf170f7@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=8219;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=C8i0BK5hjIYTgbsrEcYZTdHLVO8L8ePy9YX6HVa1xfY=;
 b=owEBbQKS/ZANAwAKARTbcu2+gGW4AcsmYgBnFi3mDhUTzkMc3QYJyKmmx/dbbincKxTdi831X
 p9cTn1PN9uJAjMEAAEKAB0WIQRdB85SOKWMgfgVe+4U23LtvoBluAUCZxYt5gAKCRAU23LtvoBl
 uCEhD/9t0nsRG105zPFKyeZFtE/RQ/E2qhGKXgcEZGX4UZPRllM1yjkdvGso2O90rCzDJt/2MKL
 e8pDxGTHGcuaa2te2RK6RFOMPjJPdNp359+QMWVKkoAMYDMPGgq37/mZaW8eViVfuQk3/dIIU4E
 3G/BHZbypAavtgYmEg060ZlzPfPmWFMqi9dPvBA9MUHvrDVJDRdFARDx3SGCMYooB4pkQTvrIZZ
 IHlrHYcvClWV1JnNqDpuk8Vu8cfOIP0n/7kTwfL/sKALAOn4wmRB79MZUoOmCUl6Q8JrZt3dDU0
 CUCG7OMhBBwPM4hzAUWkm77CSwDMJq+30CDtg++MouGeNh5lB4Cok7bjaz4zP5P+mZd+zS8mQN1
 UwhXyX9obQRtYdNLm1DyrypenLG2+/XaZoE3gmVksAVB2ARKR2b+fa15QR03hRrMwa4URlAc3RA
 mViwPCHHwlcQKjWEKxvqbRhIHPvSu+aewJhXUFk6qrDLz5mldxKWZDmkRWHX3e25zhLof44zB7F
 LpgLGONxiR5eNf5a/QY0cyZ0A33PVnYHRz5mbgADLiTbVC5BlU2GYBWHUTzb1QPm6QUE4rm9bA5
 7aW5Cbr8ee4F/lpSFbMezfF89VSCtMQog1nF8pt47Kre7qb+0ZiyMjZXqSnXpaWq70BmvsSAWdO
 uPai0xvx1BTZXaA==
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Add PCIe QMP PHY configuration for the Qualcomm SAR2130P platform.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 141 +++++++++++++++++++++++++++++++
 1 file changed, 141 insertions(+)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
index 1ca1f21b1cc225f435da9c775c97dfa142117f95..c2ba411c6c90fbbc1b3e96b02e8e63c565f254f9 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
@@ -2725,6 +2725,101 @@ static const struct qmp_phy_init_tbl sa8775p_qmp_gen4x2_pcie_ep_pcs_alt_tbl[] =
 	QMP_PHY_INIT_CFG(QPHY_V5_20_PCS_INSIG_SW_CTRL7, 0x00),
 };
 
+static const struct qmp_phy_init_tbl sar2130p_qmp_gen3x2_pcie_rc_serdes_tbl[] = {
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_SSC_EN_CENTER, 0x01),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_SSC_PER1, 0x31),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_SSC_PER2, 0x01),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_SSC_STEP_SIZE1_MODE0, 0xff),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_SSC_STEP_SIZE2_MODE0, 0x06),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_SSC_STEP_SIZE1_MODE1, 0x4c),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_SSC_STEP_SIZE2_MODE1, 0x06),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_CLK_ENABLE1, 0x90),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_SYS_CLK_CTRL, 0x82),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_PLL_IVCO, 0x07),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_CP_CTRL_MODE0, 0x02),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_CP_CTRL_MODE1, 0x02),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_PLL_RCTRL_MODE0, 0x16),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_PLL_RCTRL_MODE1, 0x16),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_PLL_CCTRL_MODE0, 0x36),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_PLL_CCTRL_MODE1, 0x36),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_SYSCLK_EN_SEL, 0x08),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_BG_TIMER, 0x0e),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_LOCK_CMP_EN, 0x42),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_LOCK_CMP1_MODE0, 0x08),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_LOCK_CMP2_MODE0, 0x1a),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_LOCK_CMP1_MODE1, 0x14),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_LOCK_CMP2_MODE1, 0x34),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_DEC_START_MODE0, 0x82),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_DEC_START_MODE1, 0x68),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_DIV_FRAC_START1_MODE0, 0xab),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_DIV_FRAC_START2_MODE0, 0xea),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_DIV_FRAC_START3_MODE0, 0x02),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_DIV_FRAC_START1_MODE1, 0xab),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_DIV_FRAC_START2_MODE1, 0xaa),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_DIV_FRAC_START3_MODE1, 0x02),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_VCO_TUNE_MAP, 0x14),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_CLK_SELECT, 0x34),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_HSCLK_SEL_1, 0x01),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_CORECLK_DIV_MODE1, 0x04),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_CMN_CONFIG_1, 0x16),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_ADDITIONAL_MISC_3, 0x0f),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_CORE_CLK_EN, 0xa0),
+};
+
+static const struct qmp_phy_init_tbl sar2130p_qmp_gen3x2_pcie_pcs_lane1_tbl[] = {
+	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_PCS_LANE1_INSIG_SW_CTRL2, 0x01),
+	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_PCS_LANE1_INSIG_MX_CTRL2, 0x01),
+};
+
+static const struct qmp_phy_init_tbl sar2130p_qmp_gen3x2_pcie_rc_tx_tbl[] = {
+	QMP_PHY_INIT_CFG_LANE(QSERDES_V6_TX_BIST_MODE_LANENO, 0x00, 2),
+};
+
+static const struct qmp_phy_init_tbl sar2130p_qmp_gen3x2_pcie_rc_pcs_tbl[] = {
+	QMP_PHY_INIT_CFG(QPHY_V6_PCS_G12S1_TXDEEMPH_M6DB, 0x17),
+	QMP_PHY_INIT_CFG(QPHY_V6_PCS_G3S2_PRE_GAIN, 0x2e),
+};
+
+static const struct qmp_phy_init_tbl sar2130p_qmp_gen3x2_pcie_ep_serdes_tbl[] = {
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_SYSCLK_EN_SEL, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_BG_TIMER, 0x06),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_SYS_CLK_CTRL, 0x07),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_PLL_IVCO, 0x07),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_CP_CTRL_MODE0, 0x28),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_CP_CTRL_MODE1, 0x28),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_PLL_RCTRL_MODE0, 0x0d),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_PLL_RCTRL_MODE1, 0x0d),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_PLL_CCTRL_MODE0, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_PLL_CCTRL_MODE1, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_LOCK_CMP_EN, 0x42),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_LOCK_CMP1_MODE0, 0xff),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_LOCK_CMP2_MODE0, 0x04),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_LOCK_CMP1_MODE1, 0xff),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_LOCK_CMP2_MODE1, 0x09),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_DEC_START_MODE0, 0x19),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_DEC_START_MODE1, 0x14),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_INTEGLOOP_GAIN0_MODE0, 0xfb),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_INTEGLOOP_GAIN1_MODE0, 0x03),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_INTEGLOOP_GAIN0_MODE1, 0xfb),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_INTEGLOOP_GAIN1_MODE1, 0x03),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_VCO_TUNE_MAP, 0x14),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_HSCLK_SEL_1, 0x01),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_CORECLK_DIV_MODE1, 0x04),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_CMN_CONFIG_1, 0x16),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_CMN_MODE, 0x14),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_CORE_CLK_EN, 0xa0),
+};
+
+static const struct qmp_phy_init_tbl sar2130p_qmp_gen3x2_pcie_ep_pcs_tbl[] = {
+	QMP_PHY_INIT_CFG(QPHY_V6_PCS_G12S1_TXDEEMPH_M6DB, 0x17),
+};
+
+static const struct qmp_phy_init_tbl sar2130p_qmp_gen3x2_pcie_ep_pcs_misc_tbl[] = {
+	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_PCS_PCIE_EQ_CONFIG1, 0x1e),
+	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_PCS_PCIE_POWER_STATE_CONFIG2, 0x14),
+	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_PCS_PCIE_POWER_STATE_CONFIG4, 0x07),
+};
+
 struct qmp_pcie_offsets {
 	u16 serdes;
 	u16 pcs;
@@ -3290,6 +3385,49 @@ static const struct qmp_phy_cfg msm8998_pciephy_cfg = {
 	.skip_start_delay	= true,
 };
 
+static const struct qmp_phy_cfg sar2130p_qmp_gen3x2_pciephy_cfg = {
+	.lanes = 2,
+
+	.offsets		= &qmp_pcie_offsets_v5,
+
+	.tbls = {
+		.tx		= sm8550_qmp_gen3x2_pcie_tx_tbl,
+		.tx_num		= ARRAY_SIZE(sm8550_qmp_gen3x2_pcie_tx_tbl),
+		.rx		= sm8550_qmp_gen3x2_pcie_rx_tbl,
+		.rx_num		= ARRAY_SIZE(sm8550_qmp_gen3x2_pcie_rx_tbl),
+		.pcs		= sm8550_qmp_gen3x2_pcie_pcs_tbl,
+		.pcs_num	= ARRAY_SIZE(sm8550_qmp_gen3x2_pcie_pcs_tbl),
+		.pcs_lane1	= sar2130p_qmp_gen3x2_pcie_pcs_lane1_tbl,
+		.pcs_lane1_num	= ARRAY_SIZE(sar2130p_qmp_gen3x2_pcie_pcs_lane1_tbl),
+	},
+	.tbls_rc = &(const struct qmp_phy_cfg_tbls) {
+		.serdes		= sar2130p_qmp_gen3x2_pcie_rc_serdes_tbl,
+		.serdes_num	= ARRAY_SIZE(sar2130p_qmp_gen3x2_pcie_rc_serdes_tbl),
+		.tx		= sar2130p_qmp_gen3x2_pcie_rc_tx_tbl,
+		.tx_num		= ARRAY_SIZE(sar2130p_qmp_gen3x2_pcie_rc_tx_tbl),
+		.pcs		= sar2130p_qmp_gen3x2_pcie_rc_pcs_tbl,
+		.pcs_num	= ARRAY_SIZE(sar2130p_qmp_gen3x2_pcie_rc_pcs_tbl),
+		.pcs_misc	= sm8550_qmp_gen3x2_pcie_pcs_misc_tbl,
+		.pcs_misc_num	= ARRAY_SIZE(sm8550_qmp_gen3x2_pcie_pcs_misc_tbl),
+	},
+	.tbls_ep = &(const struct qmp_phy_cfg_tbls) {
+		.serdes		= sar2130p_qmp_gen3x2_pcie_ep_serdes_tbl,
+		.serdes_num	= ARRAY_SIZE(sar2130p_qmp_gen3x2_pcie_ep_serdes_tbl),
+		.pcs		= sar2130p_qmp_gen3x2_pcie_ep_pcs_tbl,
+		.pcs_num	= ARRAY_SIZE(sar2130p_qmp_gen3x2_pcie_ep_pcs_tbl),
+		.pcs_misc	= sar2130p_qmp_gen3x2_pcie_ep_pcs_misc_tbl,
+		.pcs_misc_num	= ARRAY_SIZE(sar2130p_qmp_gen3x2_pcie_ep_pcs_misc_tbl),
+	},
+	.reset_list		= sdm845_pciephy_reset_l,
+	.num_resets		= ARRAY_SIZE(sdm845_pciephy_reset_l),
+	.vreg_list		= qmp_phy_vreg_l,
+	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
+	.regs			= pciephy_v5_regs_layout,
+
+	.pwrdn_ctrl		= SW_PWRDN | REFCLK_DRV_DSBL,
+	.phy_status		= PHYSTATUS,
+};
+
 static const struct qmp_phy_cfg sc8180x_pciephy_cfg = {
 	.lanes			= 2,
 
@@ -4639,6 +4777,9 @@ static const struct of_device_id qmp_pcie_of_match_table[] = {
 	}, {
 		.compatible = "qcom,sa8775p-qmp-gen4x4-pcie-phy",
 		.data = &sa8775p_qmp_gen4x4_pciephy_cfg,
+	}, {
+		.compatible = "qcom,sar2130p-qmp-gen3x2-pcie-phy",
+		.data = &sar2130p_qmp_gen3x2_pciephy_cfg,
 	}, {
 		.compatible = "qcom,sc8180x-qmp-pcie-phy",
 		.data = &sc8180x_pciephy_cfg,

-- 
2.39.5


