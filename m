Return-Path: <linux-kernel+bounces-556665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61B4AA5CD1A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 19:03:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0138E3AA4CD
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 18:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71C58262D13;
	Tue, 11 Mar 2025 18:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TH2cX9i1"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19487262801
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 18:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741716184; cv=none; b=OonEWZd7g3Xptaxu60RGsNu0THGCj2FiRvsTEcKxxGqmhZkO7OWXJSYcptdJydVePrCDMnXygGSIwy2k1/9hNfkH2hWntv9wgPWye9j6y1MMtPlgbVBXbQPYoWE0yQBlZNGJInckDHV/hn/hzH1SzAj32tNWnt1z2qCBNebNtVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741716184; c=relaxed/simple;
	bh=TSHmhqZwyLnRao31ZE/kuynrWIfbFM/u9czNvOIv9MM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=UVt4n3FrBfKtp3UnioFUYj6Jmcj5WKTAs+rfR0Bj0cjIo7/kW0zWAd5TAQc1biU9qGOJL+kks6i7lySdWspoYax6SYzb5RbE8BwAeJ9hpKq5baxQ10PecL6PmoaLYwhYVya0gpsiGGsrj+/Yxsmuqffyow8191Evy96Sf5e4beA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TH2cX9i1; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ac25520a289so779913266b.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 11:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741716181; x=1742320981; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0ccls6QlRwKxRURW2wbvi5fD6dk24Crfv3eaY7igy5w=;
        b=TH2cX9i1X7qPGcCjitS15NQto7EzckVYHXsKtXY9mCSpeiTb0GzbM2doZGnOWkkJv9
         QH5Cwvt3dKeFMQ4uhafRXi3Y2qFsxEoj4qnEa9VYD3lTTKUmq51EwIE5I3c/iuN2cnqR
         V5LwrzBmW67kwkzCCyG9nUZZpYigbN9WFQI8bLGeQsjxAnBiZbWncJs2uGuZFt/h59nK
         fphE14ihHswjXZhKhvwnk4qjCDI9N67pkB5YKP0jvn5I9OgkeFheB77dxddIk2j0fqI5
         vaEJr+7Tglhl6TrWy2ga/3mvNxPDma86AmQ7B+RUJXebqltaXgTXsmh92TqFu4jgl1gx
         BIkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741716181; x=1742320981;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0ccls6QlRwKxRURW2wbvi5fD6dk24Crfv3eaY7igy5w=;
        b=QXhDBm9r/ohkE1geZ6mWDxW+WGsFOZ5BlLp7xhbNTwiA6dlfEyv2sdbPXzQb/SlsTx
         OHj131DeTHLO85bZ1tvACnN30pt2Xpi/MoOYQdA/ukJF08+Jx/aKPe/+KhExam0A5jT8
         rdeRH7d9tPXruIcJm6/bBJ8mDosEX4tRyFyxSZnj6P5ghAxhEBlay4KyfXNADZxJrCtb
         QBzu2/Y+D2mHXcNsoKAxUAxbFryX55OHsnuKYXUuvMw1ke8BP1rcBxZiu0LdNZMrSfCw
         LX8hffDnpAo5ZSDUOm/NZMqDk0smtARtO64dqoM4iyZU+Ox6A/9nSBS8dAQV3W0eU9m6
         GnAw==
X-Forwarded-Encrypted: i=1; AJvYcCW+80XQgFtoYbpAAuIeTVE4CY3XqSMkFcxoJAh+JnI0oBh9vOztTeFxXX76ZOqGstw7YPGug0EWQgE3bXw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyci8SLMuT1W8hyAt1dsxnTGKqp40s++JPn6apMDPxU87p9Ou1M
	+Y8i5wR7Dd+y4xUzYa3pw+aXlrVz3wEwRhwEDKDwdualLELXOqx4NjXYGT6NGEM=
X-Gm-Gg: ASbGncup5bTfCiEGnfihFmiuH6CQFqlyzHjwyudctOaFMPYJkY1t1vR5SdwGdO0r1Sn
	oIUjoqjcDXl7wHu6fz86GQC1Cd5cjR30cBapJ8/TDd6NjwKKeB+UXgq+8VNSKigHz2ddVkvPRxE
	TBGxCl/sQKz2nUeZZeS3qfBCb4moG1r8GtsWg58ggslV4hWHRpShuqWH7vp+Dhc/c9NWy1fu6p+
	LxtgwX3qUO0Pi/+YLi3GlIdECopJJ6NSlFY5fXhxWSQn+4mOTRV02XV+QvNOBXAlaQHP+RpMo9c
	Y8dyf9gw88sAuxXypWdQeeCYm1Hj3bpPG3xUyCZMO3GqEcT44XfWOYs=
X-Google-Smtp-Source: AGHT+IGnY0H7YzlXD8CZSfCox70QPKmTLZoV4lqMqMMxiyALS3HVvR/aMstzphLmsjj59KVicmXt3g==
X-Received: by 2002:a17:907:1c24:b0:ac1:e1e1:1f30 with SMTP id a640c23a62f3a-ac252fa0c31mr2141888066b.38.1741716181234;
        Tue, 11 Mar 2025 11:03:01 -0700 (PDT)
Received: from localhost ([185.194.66.242])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-ac2394894cbsm957805166b.70.2025.03.11.11.03.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 11:03:00 -0700 (PDT)
From: Christopher Obbard <christopher.obbard@linaro.org>
Date: Tue, 11 Mar 2025 19:02:56 +0100
Subject: [PATCH] arm64: defconfig: Enable Qualcomm interconnects as
 built-in
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250311-wip-obbardc-qcom-defconfig-interconnects-builtin-v1-1-675b6bc57176@linaro.org>
X-B4-Tracking: v=1; b=H4sIAM960GcC/x2NQQrCMBAAv1L27EI3UlG/Ih6azaYu6KYmUQulf
 2/wNnOZWaFIVilw7VbI8tWiyZrQoQN+jDYJamgOrndDfyTCn86YvB9zYHxzemGQyMmiTqhWJTc
 24VrQf/RZ1dAN58h8OZEngpads0Rd/svbfdt2VwwgJIIAAAA=
X-Change-ID: 20250311-wip-obbardc-qcom-defconfig-interconnects-builtin-258fcc961b11
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, 
 Christopher Obbard <christopher.obbard@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1644;
 i=christopher.obbard@linaro.org; h=from:subject:message-id;
 bh=TSHmhqZwyLnRao31ZE/kuynrWIfbFM/u9czNvOIv9MM=;
 b=owEBbQKS/ZANAwAKAWNNxPBocEb4AcsmYgBn0HrQzl89Jaz1kNZJdzDGOQWcFYbCljywikz7i
 iJbfuU8tICJAjMEAAEKAB0WIQTxi9yLbCX5CqI9UXRjTcTwaHBG+AUCZ9B60AAKCRBjTcTwaHBG
 +DL6D/9IB7zq4cq3vY1Uw0waKJ/M8zCahI2LFsClUcFcgNnupikDLQ+SmcrOS6iYWqy/YcZQoD6
 VT3RQcN9OCgdeYSkAuhR6fXeN8GGJgiZXkSHWC/pn6M4exxHBGjRgn2i0cQqaMin+hW9G60fI5K
 L9aL0T/EP/MTgglpTKzhy+95WWh2JGR9hTXLfcSgen6fX/qiMIMsEKwtW24moUHMD9D4wb73+mY
 4scWoq5pWJ+TuVdpaurhAxFfRwgOObeiDEsRR+pqqU6iom1pTmV5cA9CpNaRjhmUNGnTYB0uqV1
 iBhsy/R2yd8AsX+Jrz52OHGpqmxa/+jJPFc20S7Tpx/aVmvvzXo3JkF4Zhfc7a19JEW8smZjJ5n
 3Scp8cnscwYBiVIYopZZ6HMjFsA0V5KXoOacBiqnXnw1CDHs48i2ZUoaF5R6OAkR2ueArZm8R8r
 kgGKM3zKTVdqsFWN7FAmx9x4aWY0omSWN+IY2TWvUOtA8NMJnFuKmFwu79SdpdKj84yxxZOKGKs
 49HqauXRI+g6UCm0G60qdDwWUqHqX65zjMMOS3vMwVUjVd3dbDS2uEnQ60Zuw6UJyQr0gZ2wTCK
 Cl/4MRMdb0P3wqr0E6eL7aZGJJixWG+nDMMk9R0t89eRki5HOd73rNgzb56w97aUAhQoU0HljoI
 CT5uZJChxYybamg==
X-Developer-Key: i=christopher.obbard@linaro.org; a=openpgp;
 fpr=F18BDC8B6C25F90AA23D5174634DC4F0687046F8

Currently some Qualcomm interconnect drivers are enabled
as modules which isn't overly useful since the interconnects
are required to be loaded during early boot.

Loading the interconnects late (e.g. in initrd or as module)
can cause boot issues, such as slowdown or even not booting
at all (since the interconnect would be required for storage
devices).

Be consistent and enable all of the Qualcomm interconnect
drivers as built-in to the kernel image.

Signed-off-by: Christopher Obbard <christopher.obbard@linaro.org>
---
 arch/arm64/configs/defconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 219ef05ee5a757c43a37ec9f8571ce9976354830..6582baee2ab02ecb2ff442c6e73aa6a23fee8d7f 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1656,11 +1656,11 @@ CONFIG_INTERCONNECT_IMX8MN=m
 CONFIG_INTERCONNECT_IMX8MQ=m
 CONFIG_INTERCONNECT_IMX8MP=y
 CONFIG_INTERCONNECT_QCOM=y
-CONFIG_INTERCONNECT_QCOM_MSM8916=m
+CONFIG_INTERCONNECT_QCOM_MSM8916=y
 CONFIG_INTERCONNECT_QCOM_MSM8996=y
-CONFIG_INTERCONNECT_QCOM_OSM_L3=m
+CONFIG_INTERCONNECT_QCOM_OSM_L3=y
 CONFIG_INTERCONNECT_QCOM_QCM2290=y
-CONFIG_INTERCONNECT_QCOM_QCS404=m
+CONFIG_INTERCONNECT_QCOM_QCS404=y
 CONFIG_INTERCONNECT_QCOM_QCS615=y
 CONFIG_INTERCONNECT_QCOM_QCS8300=y
 CONFIG_INTERCONNECT_QCOM_QDU1000=y

---
base-commit: b098bcd8278b89cb3eb73fdb6e06dc49af75ad37
change-id: 20250311-wip-obbardc-qcom-defconfig-interconnects-builtin-258fcc961b11

Best regards,
-- 
Christopher Obbard <christopher.obbard@linaro.org>


