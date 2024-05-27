Return-Path: <linux-kernel+bounces-190132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E964A8CF9E4
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 09:21:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95EDC280ABC
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 07:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6619322615;
	Mon, 27 May 2024 07:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T7Ayi0wa"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C7026AFF
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 07:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716794451; cv=none; b=shZjqMLspcMDL89XST8xFvvjGE3cAiGMBWYwvql34fdaXMYadvgoj4IhmelsTo0w8j+xpVI8aJhW9qrDI22weBGJCg4Ofm9Pe1SKLM8l/FYQObfh5YMOP9fm6/1oCPBhJaIpaATDvfYhFuGNN6RFhqLSxGla+8LFNA3tGg6h58Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716794451; c=relaxed/simple;
	bh=/NKx4g17yrslFj63kXaD12eTW6X1NFoq4AP4B+eaOcA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SZuKztv/T09iqh6Jf8KuLalZsEL9f6aYRSx9hRqawDeB8K8Clc5LyrBK+L/ic82zw0Ns8IkJ9ehZ6GKycgGJhn3z3SFlWs8hI6BbGeOBdqPypEA9TUc5tuKTeg2fyqpzSQlDteiaMQ9Fb+QAp6CgBZHlOpLz6JahjoHoakrpCVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=T7Ayi0wa; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a62972c88a9so192369466b.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 00:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716794448; x=1717399248; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dFIwML9I1Cig6SdAiuvO9nVLq/nrtM3r9MfRFepo5r8=;
        b=T7Ayi0waLcVdAm/rI0sjWZCzLIk/6ghcOF6cAp5deZjytPaaxQnxpXVV8SwJgtNJkR
         AU8mdeq4eN/6aorm6WlcCtJgFzd9sJoG9LhMT2/cT3n96TU/LNAJhHQOvDKuG/D+9jrN
         ntmj7TbIIFtPkp5qmS105N2LcgsNQcuoKJ2EaaaXSU4RBLWbcwxwuZ/pqUdcbQl4eMnO
         If9pTB809z/XCgoAXceR18a0zf+o/W6G74VbrMHcpXl9/oUpaRhkb/j41Dnq4OL34pgX
         T0RkEsb6d6omgqtE9N9dOCcOvRe1Ruiv+STuOzNDdATaGEA9/6FKpm3h/EpD+o2ZEyAn
         7pYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716794448; x=1717399248;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dFIwML9I1Cig6SdAiuvO9nVLq/nrtM3r9MfRFepo5r8=;
        b=usBFg34GyWoVEY5hXjckjMAr5Hn/2PrYJnGVnwNjomw6CPgrf4/d8hPug2fPXBr2km
         HvmrHCdm7+pAMbmRvgHD5KRfMZEgqXn+wfRHyt/XtLPLUDL37+/lpyigt6Tj9jozodNS
         8ALJShsGlRbLb41H3MR8toBgrx/vhpAsy+Bkdt0uq7P23G24XhTt+oOyBBmVvGQDr6dI
         ggLn+q88u9AhrABlvGAK0NMlpWBYFM5okJjLc+vCaWh0NavYDfECIncnOEX5uvfuqrEi
         xMo+ReUxAJi3p6Hj+2Ww2cP2NoUpIiRe7aoZ3gUDDqYkgpzJtvcDr/+fq0WFd7iYcpnj
         mVJw==
X-Forwarded-Encrypted: i=1; AJvYcCVGxhPumcTaw0IMVeuHbpqA9lFDq3dV1zQNHy08exFyL61FBTI8tMikfxu93gXqXtI6HRj9VfX+giNFMNpP5C7KDoILRD+tf98cmH6d
X-Gm-Message-State: AOJu0YwO0AKODLGEbH2e7w9akCoBpTmfH7zFyeREEsahL02/0Ko4RLQX
	cyjl38ZEUDT2MR8X6+6hjCl8tX1YAfbzx11hYN+FGnG3kJBDwFMJ0aaAOwKcRTU=
X-Google-Smtp-Source: AGHT+IFfzB2M2LevgqhauhGVIk/oSQl9F99lkA56JEK7GoiqpOehtsnPlrupsGgAOl52ZKCriOeykw==
X-Received: by 2002:a17:906:b117:b0:a59:a431:a8ce with SMTP id a640c23a62f3a-a626407c0d3mr605363366b.2.1716794448164;
        Mon, 27 May 2024 00:20:48 -0700 (PDT)
Received: from [127.0.1.1] ([188.27.161.69])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626cc8e295sm457915666b.185.2024.05.27.00.20.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 00:20:47 -0700 (PDT)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Mon, 27 May 2024 10:20:35 +0300
Subject: [PATCH 1/3] phy: qcom-qmp: qserdes-txrx: Add missing registers
 offsets
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240527-x1e80100-phy-qualcomm-combo-fix-dp-v1-1-be8a0b882117@linaro.org>
References: <20240527-x1e80100-phy-qualcomm-combo-fix-dp-v1-0-be8a0b882117@linaro.org>
In-Reply-To: <20240527-x1e80100-phy-qualcomm-combo-fix-dp-v1-0-be8a0b882117@linaro.org>
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>, 
 Kuogee Hsieh <quic_khsieh@quicinc.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2046; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=/NKx4g17yrslFj63kXaD12eTW6X1NFoq4AP4B+eaOcA=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBmVDRJ6FoabRU16VxO/vpp4UncOhfCzCs8qutbM
 KXmtXnXlEuJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZlQ0SQAKCRAbX0TJAJUV
 VmpKD/wPTDzajfnprk6RxhJ8L1Lqp++t0pR+SxyHN3sdKDX/76ZxrV0d1D3zq3YwhEt20KTZcEY
 OBPLe2SmCjZiaFke7lMe3cww6Y79xR0kLzDbsy1majk/zpBJ77x65OsCW06H+76VyLsELFF6aQS
 3To8fBqNxrVkYz3VV9BXVQhHBevztXNQsHIG1FQVHmyOBAZE7hJCM8JEv4ktT9ovx5HCxFd1Y/H
 i/tc0EZ+gs9n9DPIyNhEHiqhi/ogyxdSV+4tUWPk113SnjmkxKTGXVb6pNd8qFtJD/TnhoIcuy/
 agz4R6jb4KMR2tCSISaPhT1FUSEq3WJM7Tu1+TZlomVs6skt7xOkoyE5dL3OHOym4kEPgEnU+/U
 IQIoAo0rO5wFPDYvT1Bz7qPOz+o09XtM4kPV53RH7s2Iplc8qFbsAA5iY9Yrgf3SMDfbkBV+wtM
 a5Ya9/zOBA58xVaJKF8OgsrUYSvLD/Bil0dGYrivQlKVzfAyowtFZcpUUxnn+OvfTBKZa/4BxH1
 fgV25v2aQRyvg+DXdnlXlmc+UOesUlWFAp1lYqW5o3SSkKqBY7HgzByQhyY3mFAdII3HtWIAdl5
 +bj3FF4JDsrvsKtVKApF+viVRnO7c/T0sgb0yh2IFRxxH4rFYqnYTNAouLwynjuJfuLYEFs2bZz
 WLB1VFbbJY3Zv0Q==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

Currently, the x1e80100 uses pure V6 register offsets for DP part of the
combo PHY. This hasn't been an issue because external DP is not yet
enabled on any of the boards yet. But in order to enabled it, all these
new V6 N4 register offsets are needed. So add them.

Fixes: 762c3565f3c8 ("phy: qcom-qmp: qserdes-txrx: Add V6 N4 register offsets")
Co-developed-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v6_n4.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v6_n4.h b/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v6_n4.h
index a814ad11af07..d37cc0d4fd36 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v6_n4.h
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v6_n4.h
@@ -6,11 +6,24 @@
 #ifndef QCOM_PHY_QMP_QSERDES_TXRX_V6_N4_H_
 #define QCOM_PHY_QMP_QSERDES_TXRX_V6_N4_H_
 
+#define QSERDES_V6_N4_TX_CLKBUF_ENABLE			0x08
+#define QSERDES_V6_N4_TX_TX_EMP_POST1_LVL		0x0c
+#define QSERDES_V6_N4_TX_TX_DRV_LVL			0x14
+#define QSERDES_V6_N4_TX_RESET_TSYNC_EN			0x1c
+#define QSERDES_V6_N4_TX_PRE_STALL_LDO_BOOST_EN		0x20
 #define QSERDES_V6_N4_TX_RES_CODE_LANE_OFFSET_TX	0x30
 #define QSERDES_V6_N4_TX_RES_CODE_LANE_OFFSET_RX	0x34
+#define QSERDES_V6_N4_TX_TRANSCEIVER_BIAS_EN		0x48
+#define QSERDES_V6_N4_TX_HIGHZ_DRVR_EN			0x4c
+#define QSERDES_V6_N4_TX_TX_POL_INV			0x50
+#define QSERDES_V6_N4_TX_PARRATE_REC_DETECT_IDLE_EN	0x54
 #define QSERDES_V6_N4_TX_LANE_MODE_1			0x78
 #define QSERDES_V6_N4_TX_LANE_MODE_2			0x7c
 #define QSERDES_V6_N4_TX_LANE_MODE_3			0x80
+#define QSERDES_V6_N4_TX_TRAN_DRVR_EMP_EN		0xac
+#define QSERDES_V6_N4_TX_TX_BAND			0xd8
+#define QSERDES_V6_N4_TX_INTERFACE_SELECT		0xe4
+#define QSERDES_V6_N4_TX_VMODE_CTRL1			0xb0
 
 #define QSERDES_V6_N4_RX_UCDR_FO_GAIN_RATE2		0x8
 #define QSERDES_V6_N4_RX_UCDR_SO_GAIN_RATE2		0x18

-- 
2.34.1


