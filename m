Return-Path: <linux-kernel+bounces-262922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E9A693CEB8
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 09:17:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BFF41C21631
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 07:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 251F215666F;
	Fri, 26 Jul 2024 07:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZmyjPj6q"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B030175570
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 07:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721978227; cv=none; b=gUnbGUrCOWw58flamKp+lRMFSoEIuCyyvRRObiSjJFAdzC8KJWhQ586/fGQBCGRLvPWT8mMT2IO4t//diBpEjMjEbY/uq/Pi8futHhT1oLBdXi4JhMPdFi/WFPZV9IUONObrAY2rWu04vl5T3UZ3wurF5czgwddrVhnZo5JtO14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721978227; c=relaxed/simple;
	bh=1Nvs/8Kt+upgOyjXRd8HbkEzugVKCAjoIpWCWBKxlWk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=BvvM5vzqE08odkhR4aNMPIRc9vvXUznkPu+2vUI22NhMsSlzDh2cglTsXasMHqv9kKdJBF2vk+t0IQLedxqyB1n0z89z9Shn4B6VLhSnIC1YVlEJMtmpePUtdOmDcfEC9sWxu1ToQnquf8e1CAKNwfC0A29vwqjMBDxgWbyFF2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZmyjPj6q; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-42122ac2f38so9510845e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 00:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721978224; x=1722583024; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=f5fZc0Z1BPfgBmbUxSwFiphndMv9OlBc2qr6if08fJ8=;
        b=ZmyjPj6qqxVlBRBoLR2mk8trCOATQM54xNynYkXn2t0k617DnTKKCd7pZ+fSspT/2e
         yS71oA31c29vb/oaNhbpxxIzc6SSQKtdi5ZDOedttoOKn/EVVYVu9g1YvTcfEE4ArrYr
         oKynVtRZ9lvEdIlmD8tR+B5GUPIfo/gQJf9N3QXhkLrkQDmbsVziAoYQagIBQjmSCRHL
         uv6WWoilg5pHmnIqw1qbJ6Eu/3vmKY213toPrOnQl2BfUOBH1hFIVC8fd3Pqv3WKBgBb
         nPArAy+kHGKzpdXGQGoFZvbUbFMDKltpTTIgJ2SVVpHStOLtk4sUbssp3qr4OBq8QeIX
         fEcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721978224; x=1722583024;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f5fZc0Z1BPfgBmbUxSwFiphndMv9OlBc2qr6if08fJ8=;
        b=MZrJsjrj5c9WJnE6ZOG0yZPOvOIwocW7sgrHg86wWkd34NVVP7DT5PRLtHGFcwDLRB
         Vy9MsdxPPCQG2xn1bDstC5GcndwSYePtiMhoA8Gjei1PZYrCEPZ46lHCypQ1ywqhpkQo
         CY+eO5E719qGuots+X8xz8fO2q4KxW0qT0mISUCtPuHrAxtJQsC1RIV0M/aMzKk04tHk
         DQu2fIv75OGmUcbjvkC50ZnFBBekTfhUMcFQLcs4CScw2/6rxDZayZ5QZJ0gN/I096fa
         t3ARD4JJ/zXoy4zJJrNkxiEuTDz8ctu2EQsg5RPHHgsfvjOf0G0RngDDN8IskHJqlxVm
         Ng4A==
X-Forwarded-Encrypted: i=1; AJvYcCWBMqhDpwuYlqZzIViPfmn/yChVVm0oDEXqxRvZ6U/26STm/zPDwFYHQwWF8QJ1Bb6qBxC/fPHA3GZbK1plDeGAtjddAzRjeStPthuY
X-Gm-Message-State: AOJu0YzoxFhx/rzpeJwX3djfSC4G/LBHM0tm/3+Shub1ixstRR5cgtMK
	Xx5l2OXx3cGVPMt03ybdaXKYox9JdRjh1l9Jk0dGUqF3qxBTrrMLUs5pEysp6BI=
X-Google-Smtp-Source: AGHT+IHmUYcCHoBWim6hLPveQGEcMSW+Ez+euODuPwLymBdFGWqWwJg4HKqug+jFC6v9z6Jn9sZeVA==
X-Received: by 2002:a05:600c:3c8f:b0:426:5cc7:82f with SMTP id 5b1f17b1804b1-42803b43d7fmr36330175e9.13.1721978223535;
        Fri, 26 Jul 2024 00:17:03 -0700 (PDT)
Received: from [127.0.1.1] ([82.79.124.209])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427f9359422sm109096335e9.10.2024.07.26.00.17.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 00:17:03 -0700 (PDT)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Fri, 26 Jul 2024 10:16:56 +0300
Subject: [PATCH] phy: qcom-qmp-pcie: Fix X1E80100 PCIe Gen4 PHY
 initialisation
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240726-x1e80100-phy-qmp-pcie-fix-config-v1-1-b569f03c0c48@linaro.org>
X-B4-Tracking: v=1; b=H4sIAGdNo2YC/x2NywqAIBAAfyX23MIqRY9fiQ6la+0hM4Uoon9PO
 g4DMw8kjsIJ+uKByKck2X0GVRZg1skvjGIzgyZdUaNrvBS3pIgwrDceW8BghNHJhWb3Thacutm
 apna2cww5EyJn+y+G8X0/JtDbFHIAAAA=
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Johan Hovold <johan+linaro@kernel.org>, linux-arm-msm@vger.kernel.org, 
 linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Johan Hovold <johan@kernel.org>, Abel Vesa <abel.vesa@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5152; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=1Nvs/8Kt+upgOyjXRd8HbkEzugVKCAjoIpWCWBKxlWk=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBmo01pxKZ5wvkYHH6ICmnpqaZVZxnCO3YKe4DfU
 O2DhkxoYPWJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZqNNaQAKCRAbX0TJAJUV
 Vkl0D/0V28qaDgycM1xGtsm+T8qpFarPqqpb6VhqZ+kHgYvlaO5w3lFJQBsI8p6h60koXJP3p5R
 DgroXWfQbRD/Xl791JVXfr11OAUa2lx9Yh4jEzVRNXjUedX0nR5A6wFSRJpBWthrv37bFvfz+MH
 6N8CG9qOcA2qwShoBx+tOaHHsD4OtoLhMtrmZGCtPgryafOzxx2+EDewG1mNu4cjlmY/XcQexv1
 4L9MmsyI5uLuuFkwzVMoNjPLbY37d8EYH0UN1/HODWiULyXWRPqFlDW/Qc9jNll/Na5V4XSmTFT
 BbZmck3/CRJRp0ZMxnUZWAEJWdfhSrdLrXWTAp9YjdXtNSpeReVsCivJIw82PD0ZJRuYspzH84J
 ThyR7+gTUKQOzkaC7lxVXPrY+r7lyUD/CFmsNYeGdo2+X9xPRhnxK5K/3XzbR/QoSWCDFspzh8g
 v5Mzbrur6pGaezgigY60nrxB2klwl0mgdJoNnHRUoZf+VVbAciqwINaNXVVEBLN+mspDJjnP/ra
 LJSz9r6OOBvmQe5/y9I1K9+u32TfIvammdjAKkpjazfPxR83jy8k0249ID9ZZCkS0kfKQqIhQPi
 EshkTD2/dtI23BKgYAu7poHaM5nH+4W+fxSsOC3LiKSelg8BA5EF3b1lepGMh6fMAhW41+OCTOG
 wLxT0MvqZE+etcA==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

Update the PCIe Gen4 PHY init sequence with the latest based on internal
Qualcomm documentation.

Fixes: 606060ce8fd0 ("phy: qcom-qmp-pcie: Add support for X1E80100 g3x2 and g4x2 PCIE")
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
index 5b36cc7ac78b..8b624afbf014 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
@@ -1245,8 +1245,8 @@ static const struct qmp_phy_init_tbl x1e80100_qmp_gen4x2_pcie_serdes_tbl[] = {
 static const struct qmp_phy_init_tbl x1e80100_qmp_gen4x2_pcie_ln_shrd_tbl[] = {
 	QMP_PHY_INIT_CFG(QSERDES_V6_LN_SHRD_RXCLK_DIV2_CTRL, 0x01),
 	QMP_PHY_INIT_CFG(QSERDES_V6_LN_SHRD_DFE_DAC_ENABLE1, 0x88),
-	QMP_PHY_INIT_CFG(QSERDES_V6_LN_SHRD_TX_ADAPT_POST_THRESH1, 0x00),
-	QMP_PHY_INIT_CFG(QSERDES_V6_LN_SHRD_TX_ADAPT_POST_THRESH2, 0x1f),
+	QMP_PHY_INIT_CFG(QSERDES_V6_LN_SHRD_TX_ADAPT_POST_THRESH1, 0x02),
+	QMP_PHY_INIT_CFG(QSERDES_V6_LN_SHRD_TX_ADAPT_POST_THRESH2, 0x0d),
 	QMP_PHY_INIT_CFG(QSERDES_V6_LN_SHRD_RX_MODE_RATE_0_1_B0, 0xd4),
 	QMP_PHY_INIT_CFG(QSERDES_V6_LN_SHRD_RX_MODE_RATE_0_1_B1, 0x12),
 	QMP_PHY_INIT_CFG(QSERDES_V6_LN_SHRD_RX_MODE_RATE_0_1_B2, 0xdb),
@@ -1263,6 +1263,7 @@ static const struct qmp_phy_init_tbl x1e80100_qmp_gen4x2_pcie_ln_shrd_tbl[] = {
 	QMP_PHY_INIT_CFG(QSERDES_V6_LN_SHRD_RX_MARG_COARSE_THRESH4_RATE3, 0x1f),
 	QMP_PHY_INIT_CFG(QSERDES_V6_LN_SHRD_RX_MARG_COARSE_THRESH5_RATE3, 0x1f),
 	QMP_PHY_INIT_CFG(QSERDES_V6_LN_SHRD_RX_MARG_COARSE_THRESH6_RATE3, 0x1f),
+	QMP_PHY_INIT_CFG(QSERDES_V6_LN_SHRD_RX_SUMMER_CAL_SPD_MODE, 0x5b),
 };
 
 static const struct qmp_phy_init_tbl x1e80100_qmp_gen4x2_pcie_tx_tbl[] = {
@@ -1286,12 +1287,15 @@ static const struct qmp_phy_init_tbl x1e80100_qmp_gen4x2_pcie_rx_tbl[] = {
 	QMP_PHY_INIT_CFG(QSERDES_V6_20_RX_DFE_1, 0x01),
 	QMP_PHY_INIT_CFG(QSERDES_V6_20_RX_DFE_2, 0x01),
 	QMP_PHY_INIT_CFG(QSERDES_V6_20_RX_DFE_3, 0x45),
-	QMP_PHY_INIT_CFG(QSERDES_V6_20_RX_VGA_CAL_MAN_VAL, 0x0b),
+	QMP_PHY_INIT_CFG_LANE(QSERDES_V6_20_RX_VGA_CAL_MAN_VAL, 0x0A, 1),
+	QMP_PHY_INIT_CFG_LANE(QSERDES_V6_20_RX_VGA_CAL_MAN_VAL, 0x0B, 2),
+	QMP_PHY_INIT_CFG(QSERDES_V6_20_VGA_CAL_CNTRL1, 0x00),
 	QMP_PHY_INIT_CFG(QSERDES_V6_20_RX_GM_CAL, 0x0d),
 	QMP_PHY_INIT_CFG(QSERDES_V6_20_RX_EQU_ADAPTOR_CNTRL4, 0x0b),
 	QMP_PHY_INIT_CFG(QSERDES_V6_20_RX_SIGDET_ENABLES, 0x1c),
 	QMP_PHY_INIT_CFG(QSERDES_V6_20_RX_PHPRE_CTRL, 0x20),
-	QMP_PHY_INIT_CFG(QSERDES_V6_20_RX_DFE_CTLE_POST_CAL_OFFSET, 0x38),
+	QMP_PHY_INIT_CFG_LANE(QSERDES_V6_20_RX_DFE_CTLE_POST_CAL_OFFSET, 0x3A, 1),
+	QMP_PHY_INIT_CFG_LANE(QSERDES_V6_20_RX_DFE_CTLE_POST_CAL_OFFSET, 0x38, 2),
 	QMP_PHY_INIT_CFG(QSERDES_V6_20_RX_Q_PI_INTRINSIC_BIAS_RATE32, 0x39),
 	QMP_PHY_INIT_CFG(QSERDES_V6_20_RX_MODE_RATE2_B0, 0x14),
 	QMP_PHY_INIT_CFG(QSERDES_V6_20_RX_MODE_RATE2_B1, 0xb3),
@@ -1307,6 +1311,7 @@ static const struct qmp_phy_init_tbl x1e80100_qmp_gen4x2_pcie_rx_tbl[] = {
 	QMP_PHY_INIT_CFG(QSERDES_V6_20_RX_MODE_RATE3_B4, 0x4b),
 	QMP_PHY_INIT_CFG(QSERDES_V6_20_RX_MODE_RATE3_B5, 0x76),
 	QMP_PHY_INIT_CFG(QSERDES_V6_20_RX_MODE_RATE3_B6, 0xff),
+	QMP_PHY_INIT_CFG(QSERDES_V6_20_RX_TX_ADPT_CTRL, 0x10),
 };
 
 static const struct qmp_phy_init_tbl x1e80100_qmp_gen4x2_pcie_pcs_tbl[] = {
@@ -1314,6 +1319,8 @@ static const struct qmp_phy_init_tbl x1e80100_qmp_gen4x2_pcie_pcs_tbl[] = {
 	QMP_PHY_INIT_CFG(QPHY_V6_20_PCS_RX_SIGDET_LVL, 0xcc),
 	QMP_PHY_INIT_CFG(QPHY_V6_20_PCS_EQ_CONFIG4, 0x00),
 	QMP_PHY_INIT_CFG(QPHY_V6_20_PCS_EQ_CONFIG5, 0x22),
+	QMP_PHY_INIT_CFG(QPHY_V6_20_PCS_TX_RX_CONFIG1, 0x04),
+	QMP_PHY_INIT_CFG(QPHY_V6_20_PCS_TX_RX_CONFIG2, 0x02),
 };
 
 static const struct qmp_phy_init_tbl x1e80100_qmp_gen4x2_pcie_pcs_misc_tbl[] = {
@@ -1324,11 +1331,13 @@ static const struct qmp_phy_init_tbl x1e80100_qmp_gen4x2_pcie_pcs_misc_tbl[] = {
 	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_20_PCS_G4_PRE_GAIN, 0x2e),
 	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_20_PCS_RX_MARGINING_CONFIG1, 0x03),
 	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_20_PCS_RX_MARGINING_CONFIG3, 0x28),
+	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_20_PCS_G3_RXEQEVAL_TIME, 0x27),
+	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_20_PCS_G4_RXEQEVAL_TIME, 0x27),
 	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_20_PCS_TX_RX_CONFIG, 0xc0),
 	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_20_PCS_POWER_STATE_CONFIG2, 0x1d),
-	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_20_PCS_RX_MARGINING_CONFIG5, 0x0f),
-	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_20_PCS_G3_FOM_EQ_CONFIG5, 0xf2),
-	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_20_PCS_G4_FOM_EQ_CONFIG5, 0xf2),
+	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_20_PCS_RX_MARGINING_CONFIG5, 0x18),
+	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_20_PCS_G3_FOM_EQ_CONFIG5, 0x7a),
+	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_20_PCS_G4_FOM_EQ_CONFIG5, 0x8a),
 };
 
 static const struct qmp_phy_init_tbl sm8250_qmp_pcie_serdes_tbl[] = {

---
base-commit: 864b1099d16fc7e332c3ad7823058c65f890486c
change-id: 20240725-x1e80100-phy-qmp-pcie-fix-config-a9bdc75fd9fe

Best regards,
-- 
Abel Vesa <abel.vesa@linaro.org>


