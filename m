Return-Path: <linux-kernel+bounces-262972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA2D693CF50
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 10:09:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECFFA1C21E69
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 08:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 522D8176AB0;
	Fri, 26 Jul 2024 08:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Bi8mHPw9"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA5A3176AAA
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 08:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721981364; cv=none; b=RXtDtzzRpJ4AAn0QPQBAIgqqHAeq1nzWeXEhr0eymLgocSr0NH73iFX8re1d6vIBDd/HqGimWsvi6p9SAbw8Aar80B17DRzJqm0oovvtHH/SrY81vGijkqA27zGeHct8W8eNoJmwCkCCL6i+KimRnMW04CrrwvoZMX6VTgQ7mGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721981364; c=relaxed/simple;
	bh=0Ev1NJXO/vcewQUS0pvbOAzbbKcLujlVohcdLLZ0JLk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=dMctXdrJEESpJM/QCYb6N3fSCF/lgq97+M+Bt7qRVFkVuYo5xO+HN4Kj37Ehh2QSnYCaL7YIagqY4z4/b/TfHDcLKAN4S6aADBmSJl1db06+R461F7wTSsts8ltmhVzpmdIdA6362kVnBU5Zc+46SO2pevPOMQ2JnKiNOnZ7KRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Bi8mHPw9; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4266b1f1b21so13528605e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 01:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721981361; x=1722586161; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xq7y9roOuA76DPFVh5KVJ6GTETUZ8LnoKVsLBau2hjs=;
        b=Bi8mHPw9cTqPhJowHLGnFjY+VjiuM/9v0FT/22h0sFDPCQ5x+/g+HwGp6rnb4UoDLC
         X/V/zRysNbUUs0kZ5H6G8dPUcwSXxB/Z6/RAyC6q4dhu+kTZpccu273RsHC4mrkVLDV/
         ySTVkWUSaG3BcEy0ZCKieU6lihXG6VNQZm4Ndbu9yMbje+JIAjU9yTxNYcD8VyOKhs/v
         2dDqztCcw9Fk6hJ3/VkgoRWCri4trZUzJb6kvuqR1H7enha7IcVsqjfVrnG/OvqSWoX8
         6y/Zc5XqVkzx8IPYF/hNR3fKL3jy4Z8Lr0xARRZChBPuvfTUwMYs2THvs3fiqh9tizU1
         vBow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721981361; x=1722586161;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xq7y9roOuA76DPFVh5KVJ6GTETUZ8LnoKVsLBau2hjs=;
        b=U7iz9h6aySYagYEgD4utMGZYPme6WE7ic5fALFsRwCWrcbJzQkX2751MkO5aU+5RJR
         jBoIIBKUvoI5yRm3S3hFEOg6T+KrP94oXUwb9+VFtc1cgJLQDkMKi/hjbVFL5Mal4dST
         du0eZRt8QU0S7gA15A+EUHgIq8ZkjWCqspi/3apF/0ABHlE6UrBFiPt+84cskgemDBTA
         3QZWmbL6rzpq65iLRfsaS3LS0hD8a49t/VcJWWkLerLhKF0aYTWRiZ7D+VEo2ghlG3o3
         Nu/77SE+Q72ZHKE4ZMXTNwqtEAdLQwjul11rhzMVhQ42TP/d+PpDCXeX6Eg4KoFzUrQ6
         7Qww==
X-Forwarded-Encrypted: i=1; AJvYcCU9CKUc1wXwf01DxdgjHurfR+4gHqm0R3t/9Z9FRFVzUAl92s9bXZm/U5nqpAgiE1G4+OCJNwlxe29Y6V6f2eAax6FIbvziotNCtiT/
X-Gm-Message-State: AOJu0Yz5ttAbPkMWvmJcacfaQayaRDBdm6JyTUFwedNLRVwgnEfYvmaE
	7qZHBrb1zb5bjIiTHOe1AbJFPPIy0aeIGt5HPrcUSN82ePKzpuy5c1rBY5NncPFqjKGKcrTxEjV
	y
X-Google-Smtp-Source: AGHT+IF6sbu6KhB0zmkRsKlh8Fz7u3qp/6dYVz39nvmDiHL59ImYMBVzaMLY3CXVxWhp/d/nIqvfcg==
X-Received: by 2002:a05:600c:1554:b0:428:c0a:27ea with SMTP id 5b1f17b1804b1-4280c0a2870mr7311465e9.12.1721981360850;
        Fri, 26 Jul 2024 01:09:20 -0700 (PDT)
Received: from [127.0.1.1] ([82.79.124.209])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427f93e6883sm105939045e9.37.2024.07.26.01.09.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 01:09:20 -0700 (PDT)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Fri, 26 Jul 2024 11:09:14 +0300
Subject: [PATCH] phy: qcom: qmp-pcie: Configure all tables on port B PHY
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240726-phy-qcom-qmp-pcie-write-all-tbls-second-port-v1-1-751b9ee01184@linaro.org>
X-B4-Tracking: v=1; b=H4sIAKlZo2YC/x3NQQ6CMBBG4auQWTsJNirEqxgX0P6VSUpb2gYhh
 LvbuPw27x2UkQSZns1BCatkCb7iemlIT4P/gMVUk2rVre3UneO086LDzMscOWoBf5MU8OAcl9F
 lztDBG44hFe5hoWH67jFaqsmYYGX7717v8/wBUxbgnn4AAAA=
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>
Cc: Johan Hovold <johan+linaro@kernel.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Qiang Yu <quic_qianyu@quicinc.com>, 
 Abel Vesa <abel.vesa@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2156; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=pmtR+b0rddclf0zEqNoY+i4bslmPX+m1gb/KqQ3y57Y=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBmo1msLR5gbarrTnuyIVlBVaZ3+WCr3a6rUf64Q
 0EeYTf7fLuJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZqNZrAAKCRAbX0TJAJUV
 VngFD/95++zG/i2Y5GrVxjw9w2aWZENYxMt2QLFYf3IWk5Z1xjeiw31aUha7rk505REpArVOxTr
 N5aV2Oxb+O4hZVtAZvj+vuwX9s3PcPxKBw2JvGBpljP/NU6p3VyQ8MfAZdGEULU42RUhclMR8EG
 50tA8qAw+GxZ5u553sgO0Stm5I9xmDPf3nYxY70etehNq7Ujv55B+/0Zvj/ZZQh4ZV3T06jtrXp
 1/QQ1h7tPsfe3r6S5V7v5DTHenRbQFAuPgDNXDaOXweXgbJz91SA2/2r/Bx+CzA+vLvlJhHoMoo
 kN62c2QqaXRldbB/SwxZ7ECepcAJjcuNFmMgt13qhmX9xy+aJ0qJ18uKJJ/cO2vQoDff6XKA2w2
 6pDt5pNQjqzRybHgvhtEQ0q9wnTiu/LSaKtVnYXw4bwlGYRDuLUafvWx9mvtPMx8+ZTEH7rp2uB
 BghN4ncNGFSYZpxvVR37q2YTHwNvVqi3Myt6Fp5kYidydkG4zfXuO77wxJziD/k3EA/BKTVIIuJ
 zH8czU55FyO4rbXVFRzefhDPm6nUC5ejZhGWmzPwxOksZbpCZwOtGmuNyiVUOVFl+GFdRhG4K4N
 poiRSEGbZaCOKZuXnZgSYPkarY+z7Ujzh8m1lrKYiruzILT7TV3oOt7JZe/PgL60JE6alS0t5It
 B07MYoLFF3DMWaA==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

From: Qiang Yu <quic_qianyu@quicinc.com>

Currently, only the RX and TX tables are written to the second PHY
(port B) when the 4-lanes mode is configured, but according to Qualcomm
internal documentation, the pcs, pcs_misc, serdes and ln_shrd tables need
to be written as well.

Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
index 5b36cc7ac78b..fd59ebd32f5f 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
@@ -3660,18 +3660,30 @@ static void qmp_pcie_init_port_b(struct qmp_pcie *qmp, const struct qmp_phy_cfg_
 {
 	const struct qmp_phy_cfg *cfg = qmp->cfg;
 	const struct qmp_pcie_offsets *offs = cfg->offsets;
-	void __iomem *tx3, *rx3, *tx4, *rx4;
+	void __iomem *tx3, *rx3, *tx4, *rx4, *pcs, *pcs_misc, *ln_shrd, *serdes;
 
 	tx3 = qmp->port_b + offs->tx;
 	rx3 = qmp->port_b + offs->rx;
 	tx4 = qmp->port_b + offs->tx2;
 	rx4 = qmp->port_b + offs->rx2;
+	serdes = qmp->port_b + offs->serdes;
+	pcs = qmp->port_b + offs->pcs;
+	pcs_misc = qmp->port_b + offs->pcs_misc;
+	ln_shrd = qmp->port_b + offs->ln_shrd;
 
 	qmp_configure_lane(tx3, tbls->tx, tbls->tx_num, 1);
 	qmp_configure_lane(rx3, tbls->rx, tbls->rx_num, 1);
 
 	qmp_configure_lane(tx4, tbls->tx, tbls->tx_num, 2);
 	qmp_configure_lane(rx4, tbls->rx, tbls->rx_num, 2);
+
+	qmp_configure(serdes, tbls->serdes, tbls->serdes_num);
+	qmp_configure(serdes, cfg->serdes_4ln_tbl, cfg->serdes_4ln_num);
+
+	qmp_configure(pcs, tbls->pcs, tbls->pcs_num);
+	qmp_configure(pcs_misc, tbls->pcs_misc, tbls->pcs_misc_num);
+
+	qmp_configure(ln_shrd, tbls->ln_shrd, tbls->ln_shrd_num);
 }
 
 static void qmp_pcie_init_registers(struct qmp_pcie *qmp, const struct qmp_phy_cfg_tbls *tbls)

---
base-commit: 864b1099d16fc7e332c3ad7823058c65f890486c
change-id: 20240725-phy-qcom-qmp-pcie-write-all-tbls-second-port-8efeced876bf

Best regards,
-- 
Abel Vesa <abel.vesa@linaro.org>


