Return-Path: <linux-kernel+bounces-190133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BEAD8CF9E6
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 09:21:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC0801F211F5
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 07:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C89D36120;
	Mon, 27 May 2024 07:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lHx5mZR+"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1225D18044
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 07:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716794452; cv=none; b=NpyKGR/47Wd2H9P9LEF28fpZgHAw7aKb1GHX13i6MUVhNkb4Ijw0kuqUiRJ9iYXjNxwceg24NT/BnP+o3kyBblm5iNr1CW+2uP+EZWfH4jFWNapv8Naact38fknei79RMEP0zgkNcLn6XKZwumsG9wIyIOStAahiUsc1eN3POJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716794452; c=relaxed/simple;
	bh=kaV21qO6GYNjhKLxdxIBJT19wvTGFK2gerZ38MtKK1I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mn7NojYJ5tLBih+H9gNbAwPbu3HK/nk2M0BWLG8gxJEeK5zUxLPjcWstIF1i5bj7AzzlMG6QUlgJf7fJrbdRXLtGwnxfjCFj+0aignOnwqACB0EAuUGZMPMa6ow84Qqm81rOpUZ4ZBlGZiJr19pI5+iu2/bJ8WBG7GnWUYx/coI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lHx5mZR+; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a626777f74eso325031266b.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 00:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716794449; x=1717399249; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TW/LSfGwT5gH7WAKYUuPqo8Jagb7fI9CA0RtQ3h/hLM=;
        b=lHx5mZR+yCp6rkXAN2+7CMFEFhscTGuknwJBnX5oVlRaThOKxSs/wDqraewoK5du1D
         eo4kkRe/gAKouHEBlxRksj7b+xGECcFdsz4B9hmm4Ei3pPQrjhIBVZ6o0OxGpzqP26IS
         LBGJJULV1WnIHblih1INTDatJPcrgbl6lNE5dZ0+JG32kvjbji7ntAHZekGSTHRbJSDJ
         Y5yG542P0TiEO6wcCAgkuUuG4sAz9/qUXHk3sb89FwSno+GtMKHKZOoLGr3l3VxiGpFx
         EkW3LFaW6Kwsp7AERv6/YEZsRraGHrKcZT3bM0xtxoN0ARmrytTdOBIF48t0CdnyJHK6
         oRxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716794449; x=1717399249;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TW/LSfGwT5gH7WAKYUuPqo8Jagb7fI9CA0RtQ3h/hLM=;
        b=Pjv95iV2PW/HzpUlCKLRVucR35OM72sn+Oac+TwSqPq3cLhdzTKqslG5VuirVVy5fa
         npxJAxDZDsjc+tHi7pbIooib+x4syTXeJLzVXv69+eVpQDmHDGIg2kbgfJAS6iypeRLi
         LiNq1LJkvsZNONeTrz6agIK6PwGtZXA7EwLJmwm/vkfT8n9WjWTOLzUfmZDRXFKnNk8L
         O7nkdK5pdpi9SrnxXdzEYwPCHLFpzHFC6PBTAP0U60M/2BX8xpje/ZlEkMyGP+g70I6l
         euLJO1qMguEDXWBcsGqM3RgwkJGLJOeYkuZ+2oi8Zjj9y9O1qUSW8KxGQyvMiGwcYdkB
         vcdw==
X-Forwarded-Encrypted: i=1; AJvYcCUebXiwwFyAaH89ImY1spRngHehNxc65/E4j3JP6N7J9eFHpBljY7nMCSXThzwpNkfRaNQBNfEpjJF42qcDSdab4iiYgYbdEnfY6XTJ
X-Gm-Message-State: AOJu0YzrCMsl86fep0KF1jMLDpy7altrfnbE+/4y6J/l6LRjtPjDQJCd
	/bX1Sq4dfWijkfBGT7lKpX0NlnKnba19qavwOLt9aJ9ZHVnKMEEaao4Y15FeMYM=
X-Google-Smtp-Source: AGHT+IEb9O/hRjCH/tIkevCOFftVSv6LB7cbfSWDciPmsu1sKUNRJG4uWQdtZUSQVFBIbQhj77IErg==
X-Received: by 2002:a17:906:b792:b0:a53:ed1b:f3ba with SMTP id a640c23a62f3a-a62642e9202mr804025266b.28.1716794449328;
        Mon, 27 May 2024 00:20:49 -0700 (PDT)
Received: from [127.0.1.1] ([188.27.161.69])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626cc8e295sm457915666b.185.2024.05.27.00.20.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 00:20:48 -0700 (PDT)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Mon, 27 May 2024 10:20:36 +0300
Subject: [PATCH 2/3] phy: qcom-qmp: pcs: Add missing v6 N4 register offsets
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240527-x1e80100-phy-qualcomm-combo-fix-dp-v1-2-be8a0b882117@linaro.org>
References: <20240527-x1e80100-phy-qualcomm-combo-fix-dp-v1-0-be8a0b882117@linaro.org>
In-Reply-To: <20240527-x1e80100-phy-qualcomm-combo-fix-dp-v1-0-be8a0b882117@linaro.org>
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>, 
 Kuogee Hsieh <quic_khsieh@quicinc.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2174; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=kaV21qO6GYNjhKLxdxIBJT19wvTGFK2gerZ38MtKK1I=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBmVDRLIpngrysYu+odCHNQ1ihTi2HjKGK3kajka
 o5g5+S1rQWJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZlQ0SwAKCRAbX0TJAJUV
 Vp6CEAC1RTXQdEOn4Z0PpOv/6boLkn/EYuDV3dW54c7Kug8NlbEKXizESrytBv/tSGyy8givfDi
 ld2Mm0eU73K8dGdgVUNdtblJz390BZqdtJtCcB5snvZoDl0Q71Wp99h7TuQ8O46AmxW19nPQPmC
 ZWzSTe6SRs9Ad7zND6/zVVk/uoQYh4IZPfhmgpwsgMovALxyW1wrf2lYUnTZywp4HxOI8lpIvPU
 BBD4s0hC979Nwg+3MbtN/86G/sy9ZulQsOcDwn1EeXf7+nmP3/Lid8qXdSR1EsjIlgbq0wNrq8a
 QgDAN0C9NizmL2Um3IJoljnhoG8uH4cNg616fI34pFhv8uH/Z/Tvq0eq3RGW+94xvJzplCFMAmo
 lBu+BKwE8/iPHvIzlTRxyItFuYS4/qr6e0gfQ/cwATENJQZRstrznAqtg5lBYEqPzqFEOt2KETG
 EXlsympwax++Kpet6lC5LXhleDBBiVW2gc2m6vnv3IcpBg0E1AE14gtK8BIswKMNk1Sc9AlKs8T
 NS6Qn/ccgmuMyd3O53/s8h8CI58AslGa4FJ/XqhEgHfG8vnfZy4WXMmZfGWfftI8W9I0lEUVUZh
 HIlABdwZk/j9bPDCxOuB4NJM7rLyYOMjuS0E7SqZU4ALJ6Aw+oqEx1fQf58NfUhG8je3NBTNAFE
 o8vZ2Lhyhn0w6RQ==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

The new X1E80100 SoC bumps up the HW version of QMP phy to v6 N4 for
combo USB and DP PHY.  Currently, the X1E80100 uses the pure V6 PCS
register offsets, which are different. Add the offsets so the
mentioned platform can be fixed later on. Add the new PCS offsets
in a dedicated header file.

Fixes: d7b3579f84f7 ("phy: qcom-qmp-combo: Add x1e80100 USB/DP combo phys")
Co-developed-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-pcs-v6-n4.h | 32 +++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcs-v6-n4.h b/drivers/phy/qualcomm/phy-qcom-qmp-pcs-v6-n4.h
new file mode 100644
index 000000000000..b3024714dab4
--- /dev/null
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcs-v6-n4.h
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2023, Linaro Limited
+ */
+
+#ifndef QCOM_PHY_QMP_PCS_V6_N4_H_
+#define QCOM_PHY_QMP_PCS_V6_N4_H_
+
+/* Only for QMP V6 N4 PHY - USB/PCIe PCS registers */
+#define QPHY_V6_N4_PCS_SW_RESET			0x000
+#define QPHY_V6_N4_PCS_PCS_STATUS1		0x014
+#define QPHY_V6_N4_PCS_POWER_DOWN_CONTROL	0x040
+#define QPHY_V6_N4_PCS_START_CONTROL		0x044
+#define QPHY_V6_N4_PCS_POWER_STATE_CONFIG1	0x090
+#define QPHY_V6_N4_PCS_LOCK_DETECT_CONFIG1	0x0c4
+#define QPHY_V6_N4_PCS_LOCK_DETECT_CONFIG2	0x0c8
+#define QPHY_V6_N4_PCS_LOCK_DETECT_CONFIG3	0x0cc
+#define QPHY_V6_N4_PCS_LOCK_DETECT_CONFIG6	0x0d8
+#define QPHY_V6_N4_PCS_REFGEN_REQ_CONFIG1	0x0dc
+#define QPHY_V6_N4_PCS_RX_SIGDET_LVL		0x188
+#define QPHY_V6_N4_PCS_RCVR_DTCT_DLY_P1U2_L	0x190
+#define QPHY_V6_N4_PCS_RCVR_DTCT_DLY_P1U2_H	0x194
+#define QPHY_V6_N4_PCS_RATE_SLEW_CNTRL1		0x198
+#define QPHY_V6_N4_PCS_RX_CONFIG		0x1b0
+#define QPHY_V6_N4_PCS_ALIGN_DETECT_CONFIG1	0x1c0
+#define QPHY_V6_N4_PCS_ALIGN_DETECT_CONFIG2	0x1c4
+#define QPHY_V6_N4_PCS_PCS_TX_RX_CONFIG		0x1d0
+#define QPHY_V6_N4_PCS_EQ_CONFIG1		0x1dc
+#define QPHY_V6_N4_PCS_EQ_CONFIG2		0x1e0
+#define QPHY_V6_N4_PCS_EQ_CONFIG5		0x1ec
+
+#endif

-- 
2.34.1


