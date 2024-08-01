Return-Path: <linux-kernel+bounces-271078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1D97944938
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 12:21:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9854528330C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 10:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D408183CB8;
	Thu,  1 Aug 2024 10:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dZIebzGN"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD93170A2C
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 10:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722507681; cv=none; b=s8K2PDpCzgLKXx3LnJebjHu6Q0mLImZUDiqUqGzMp/u1XLn5mYHtuNVoUye5eLgQY4Fw524oiNGCPiq7afFj6qnPMehsMuGpp6kDoZA2JuUrjwjwTcOofAtVI171okhRvCus36gx/RmJX7PbFrOaNJ8OVYSbvu2ip5ObeeCGV04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722507681; c=relaxed/simple;
	bh=1w2sEv3mO93UTbBWty5+SXCjCXTrLfrjbRNFOcTaVdc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=oNvKCtgxHqXBPW4D17QKGl1ck6xTXwjPUARxaZvhB7Rnh+jk2PzqpduqPub3D97+/7p3WzIP1pvgmC5Crn6fDvhUDwHrP/QLse8N/w4YsBCU8yQPewcbbyOCQgz3TifrSD/uw+2+a4NpWFekZV2RCokw3lOLj+oUxetoT2+WGqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dZIebzGN; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2ef2cb7d562so87037441fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 03:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722507678; x=1723112478; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jlj+yWmKtN5l/Z+12/zWK6DoBGtel4lk94/62hlvDME=;
        b=dZIebzGNoYARdWjWC6egLyoMj9sVldV/xD4o5rxhdivvO1w3zyXZKPcuz+XfqmBiaM
         veTUPdNMocF69bAHQsaImCLLia8cCq1joCOs3Rel5I9wd6jeb+zeYBi7dY46H/tKP0Qv
         KK3iM4P9UP/EJ3Z57GDVGK7L5ddxdy0c2rjSNwfsRB62aQwOQW9CRh8qsvlWr7LGePw5
         9GKQygSluyUaSOLgONmF30jBR/s+S2o7baC/mQiNuZKKWp6F85MzkQdJzknHPA9cfo2T
         tJunOVBS50YH8altgInHkUwR7LdYNGpRm7s6wfSDaHIMoJvaad3O6Z5TjgqU1+VboJZj
         u64Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722507678; x=1723112478;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jlj+yWmKtN5l/Z+12/zWK6DoBGtel4lk94/62hlvDME=;
        b=Al5HPPXwkVgcbpHEllrqifr0UNKPzzyOQ4Ks3itu/bLikXzCTnkP2XRHwMQcAsa9Mp
         9fqag57YkxpY5jpZDBMSLFGCjr+jzGdN3s/Hw3azQIUSo7a+MePh2y0NVPmO2JEAqfwj
         77KMFfq2chpyU3T+FBDL39OZdueCaKjJyooN+cILLHPO7cfw5LX9eQKeeCPOKy3I3HBJ
         TYr5pLvuwXVafAr+0ZfewhNoKFE4R8GydK+02N5uN/KJZUO5mBHXrrqtgibeEOsLbyo2
         dMubTi4wHPylQlXKYYi3Pb9uQfNDbQJlMi16S2mUAlvIkuGnY1/lPHEvts9PRAOwBKXQ
         DErQ==
X-Forwarded-Encrypted: i=1; AJvYcCUfhR8fp9Qr7RaO14jCxrHDaq0IxXPUcjyGL8sHy9BPLVYORGR2UYnrFdF6dsfoDBXq68bP/5ysUw+yhJinsLRNrZuQ3eD8xqheGy5+
X-Gm-Message-State: AOJu0YwoyMyaPfi3Ezb9+3dhtNAgyGIcMsM80xJAEglOwTPjkkQ9oqOY
	oTj3DqvxDJxEzsaIdMitMb7h3gkHsCr+9OPFDOX9r7lWPIHLanIHXM15aHH3/OA=
X-Google-Smtp-Source: AGHT+IGFSPm7v8ZK5AOlXNOPGo8Mx26FbnJnvQuJFQFkkN6gAYG3IGJNkhFuUYXqMVaXR2wtP4rzuQ==
X-Received: by 2002:a2e:b056:0:b0:2ef:24e0:6338 with SMTP id 38308e7fff4ca-2f153109f54mr14499711fa.27.1722507677510;
        Thu, 01 Aug 2024 03:21:17 -0700 (PDT)
Received: from [127.0.1.1] ([82.79.124.209])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4282bba283fsm51389035e9.46.2024.08.01.03.21.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 03:21:16 -0700 (PDT)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Thu, 01 Aug 2024 13:21:07 +0300
Subject: [PATCH] clk: qcom: gcc-x1e80100: Fix USB 0 and 1 PHY GDSC pwrsts
 flags
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240801-x1e80100-clk-gcc-fix-usb-phy-gdscs-pwrsts-v1-1-8df016768a0f@linaro.org>
X-B4-Tracking: v=1; b=H4sIAJJhq2YC/x2NQQqDQAxFryJZN5ARsdKrlC40ZsbQYodJbRXx7
 oauHg8e/+9gUlQMbtUORb5q+p5dwqUCnvo5CeroDjXVDXUUcA3iIEJ+PTExY9QVFxswTxum0dg
 w/4p9DNvYkwzXLrRNBN/LRbz9f90fx3ECLuJDV3sAAAA=
To: Bjorn Andersson <andersson@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
 Rajendra Nayak <quic_rjendra@quicinc.com>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Johan Hovold <johan+linaro@kernel.org>, 
 Sibi Sankar <quic_sibis@quicinc.com>, linux-arm-msm@vger.kernel.org, 
 linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Abel Vesa <abel.vesa@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1426; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=1w2sEv3mO93UTbBWty5+SXCjCXTrLfrjbRNFOcTaVdc=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBmq2GXS8lloMlaNdH4nPkAQziRD5N6S7RTl+NAl
 Qh023qqZdeJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZqthlwAKCRAbX0TJAJUV
 VvKYEACuIJccxhmTQYyrXJuggacL9Pc3hsUPWgFl/McffyRUEli88+FRoOTyAQ4p7nImxiHaPqj
 IIjgtTJ/oDpmycXIRnXKCvDIJz9qWfqB6zs6p8mnl+6SxfZCAEdUidJ5o0LF6lTICUuRidYMjd1
 p8hEKpEix5V27aC3af307FLqiF9k+3Gg+G/Khb2TqTz8E+bzw9HtoT4VDUWXBcI3hkqKjAB5NDa
 nhkwu9xPBmTeRr2uB0rWQQPJBTesui/Cqzmd+ykH6B/LD1CiwK6WhrO/yMXqpcePySDAIHAxJIx
 rUgPpZ39vjbShTCzu7FUj8B2CQbVKef8cXWyFuFgczbT0H8Q0j5jbVwHItx5ctjF8WfWkZrGoal
 7pjtdq1tHVzj8nX+XLBHw9xvNG7PwjQf1IJC4E1FuRNv/hyHux454JUjIy1f/A8DRyfb0ajSt6t
 WQmkpWu3lLEIOEzgsVdinvuRNpDJr5/rP82kGJgnDk7TvNnGfsPm1JmUJG3dSnnNqtFOi/VUwPg
 q597+6ARd13mkKWSLnQRYNA+PMkMaUsiqOmm1RRagNwz3hLX7f5wCdz9GvIL3FaUailavnvNund
 ezOKGDTWE96IHLOVCy4fmkBP89sZUwkdYs8eXuuCAPO2280IYJQrUCcpto0Ft8DDQ0mz1qQIMGO
 I89XaIbkW+11pyA==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

Allowing these GDSCs to collapse makes the QMP combo PHYs lose their
configuration on machine suspend. Currently, the QMP combo PHY driver
doesn't reinitialise the HW on resume. Under such conditions, the USB
SuperSpeed support is broken. To avoid this, mark the pwrsts flags with
RET_ON. This is in line with USB 2 PHY GDSC config.

Fixes: 161b7c401f4b ("clk: qcom: Add Global Clock controller (GCC) driver for X1E80100")
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 drivers/clk/qcom/gcc-x1e80100.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/qcom/gcc-x1e80100.c b/drivers/clk/qcom/gcc-x1e80100.c
index 6ffb3ddcae08..80e90e31be33 100644
--- a/drivers/clk/qcom/gcc-x1e80100.c
+++ b/drivers/clk/qcom/gcc-x1e80100.c
@@ -6203,7 +6203,7 @@ static struct gdsc gcc_usb_0_phy_gdsc = {
 	.pd = {
 		.name = "gcc_usb_0_phy_gdsc",
 	},
-	.pwrsts = PWRSTS_OFF_ON,
+	.pwrsts = PWRSTS_RET_ON,
 	.flags = POLL_CFG_GDSCR | RETAIN_FF_ENABLE,
 };
 
@@ -6215,7 +6215,7 @@ static struct gdsc gcc_usb_1_phy_gdsc = {
 	.pd = {
 		.name = "gcc_usb_1_phy_gdsc",
 	},
-	.pwrsts = PWRSTS_OFF_ON,
+	.pwrsts = PWRSTS_RET_ON,
 	.flags = POLL_CFG_GDSCR | RETAIN_FF_ENABLE,
 };
 

---
base-commit: e92057c615fec749fefcca4ab28ee5c425e3691b
change-id: 20240801-x1e80100-clk-gcc-fix-usb-phy-gdscs-pwrsts-6fa0eb78164f

Best regards,
-- 
Abel Vesa <abel.vesa@linaro.org>


