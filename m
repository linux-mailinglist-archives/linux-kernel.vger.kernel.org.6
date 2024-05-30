Return-Path: <linux-kernel+bounces-195484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 149378D4D72
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 16:05:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5757B240B6
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 14:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AF63186E4B;
	Thu, 30 May 2024 14:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L/B8RX2Y"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA23E186E49
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 14:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717077934; cv=none; b=Xw93MJ3BFVbakMx2oAlumy0IPUwsrYvx5b17vbf4Hmv+epf2MNj2b3fCQnp1KMG/3tXjplibFbuB4iFbNHf1c2Xz6Ncomx6npWB2azN7/Nbpy6vLGRjTOY+6q/tY7YJ4ujhmsoXiN1vXBjorL4aIc1s/KUsIzUgEqbDPDvrGYHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717077934; c=relaxed/simple;
	bh=ESd0gNsxszqbQaloGtME7oCQ3PNGImKH+e9qTcBH1qk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=JqXqQeAqqg3K/aoM0Ty7lhELz/b6XEomhajvzaRYjrIna7Y2fzoMbvj27sj6DbMklzFftwWRxzoGw5LgX7/Er8l1E3aV3ptZSI2oKgjHYm9KPUmmBYC7MfzJfhxrg1F0KctAEbxyAssAF2yu6eooxIpaVCtb86HIOR6W9qwVkLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=L/B8RX2Y; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a63036f2daaso97405266b.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 07:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717077931; x=1717682731; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ozNVAnxqE0lL+qF5HV2h+4/UhN7PSqlhKtJqHseh0HI=;
        b=L/B8RX2YxSaggGp7tw6FdKibbb1unU3VPPON/2IXs3mh+d50C+Fs6Olj3BGQGD5L6q
         /+38Nkwht8CgJhrrK4NZqszbRS0XqIy7lnEX8y28t6KB5wGKH7bFwYyyPLY0hJip9wlX
         u2GWI2xeVoilzIsioojVNWS+ECDBzLr+CErKNjDMm/ms5IK+b5Vd4s+dfNWQ/He8Pykb
         TAUvNL+U4Zu6JVBo6hwwywcE/s50PqlHsN9A5v6AdnQxvmZH/L7dw6HAWtl7wxwY1IxA
         nsGT43SXv9v+CpJTwqXu5nKuym1H7+P81ND8iVhXqJbP0lZDsJyJ5XX2+BKyAeSr3jni
         Xojg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717077931; x=1717682731;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ozNVAnxqE0lL+qF5HV2h+4/UhN7PSqlhKtJqHseh0HI=;
        b=mJGnieRY2NOm2UAFVISzBV/Mu1QnJJzPcvcQfoSO6NSVslGOu3ER8F2ORIW/Sh/IEH
         E1IJD55n45j8TZh3ovohZYIeiTPA0QG/GPxmEHRzzVFkzSQrK3XRXqMGP4TMqz86OSqA
         wic4q6o7KW8oUEKSxIb1oAFyFpPoqo3UGKLQm9v7HCGyj+jmgKClh/UnpzgOBkZCJ1qC
         8FkfUzJ74MUazZdj6wgHVK3i3R8xVoPuBsO8licpooJ0/rchJVn3ABnflyHDOn7zXr0f
         94LcwxybAIIB08uCaGvCH6tCoAZd4resF5YntFcmuNIv3g6tmuDC5x9iqS2Co83Q7Qo/
         SWEQ==
X-Forwarded-Encrypted: i=1; AJvYcCVs79nfplZ5mpp6Dy3sUK7sdOuDiaAPYOrKtL56h25lVWgnj9fC/m/sNTRyhufC97KJct8kq7mfBo+aPZ5hMeomKiseFUDzP0H6abrE
X-Gm-Message-State: AOJu0YzRrElQT6z5ux4k84553QQPlgZAQ+wX4yCCsT0W2abmMAMf18Vt
	039+r1rcxFO3/s5FLuYVtyCQ27H/c3AJPoLbBtPOXOfeZ61L2MKIzcM5PYkuo+A=
X-Google-Smtp-Source: AGHT+IF/EgUdnO2R7u5brYgNfOJ73YaN+O9YN+pDX7gvTyYiHIa/WTphpHtPpGYtAukA9aMRxwrvhw==
X-Received: by 2002:a17:906:2550:b0:a66:7666:fc64 with SMTP id a640c23a62f3a-a667666ffcemr88422766b.4.1717077930807;
        Thu, 30 May 2024 07:05:30 -0700 (PDT)
Received: from [127.0.1.1] ([188.27.161.69])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a663848c9aasm49630566b.207.2024.05.30.07.05.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 07:05:30 -0700 (PDT)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Thu, 30 May 2024 17:05:24 +0300
Subject: [PATCH] clk: qcom: gcc-x1e80100: Set parent rate for USB3 sec and
 tert PHY pipe clks
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240530-x1e80100-clk-gcc-usb3-sec-tert-set-parent-rate-v1-1-7b2b04cad545@linaro.org>
X-B4-Tracking: v=1; b=H4sIAKOHWGYC/x2NwQrCMBAFf6Xs2YXdpAX1V8RDTF9rUGLZpFIo/
 XeDt5nLzE4FllDo2u1k+KaSPrmJnjqKz5BncBqbkxPXy+CFN8VZVITj+8VzjLyWh+eCyBVWG1R
 egiFXtlDBvZNwgVP1o1KLLoYpbf/h7X4cPxJIJf+AAAAA
To: Bjorn Andersson <andersson@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1259; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=ESd0gNsxszqbQaloGtME7oCQ3PNGImKH+e9qTcBH1qk=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBmWIel1xURmFNij+ie/FjjZdjHt5Q7HW7elDTa7
 lANeTceYDSJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZliHpQAKCRAbX0TJAJUV
 VnMiEACLXvkhX7K/Kz112drtLnDhAMbNb6HDLeh++fS2QCXs9qI+bIjcbdPR6/30p/LtLiLWIJb
 cNK46wGJVKbF2oXJlCr4ESUl0lbRlFXM5RRafqQl8DUWiFpYkRDkqpDa3l3nSf+ola7xybzXgsY
 F5V7jgqIRTeYb4HjYsJ/3TB+YLEgejcaVhksIHEbi2Nk8Cczc0X4M9TkJYWl2oRg7frJtffiC2K
 VJAbg3WTVGwFP0a/cUK9AEqaAWLHfD4z8gk8qZDHylXYu0vbC5wtb58lpmfXTB8v3hws6qJR9H8
 O6aqeWGh8Y/L+4+O+cwtKri95vnQEmRPsTUoQrqi2SA/qhEGfTH4uctL4HXkmgLHh9HJMp6Vs5Y
 GOyiB8b8PhFXXV3W3S42oGLE194Pq/kBlNI3gWhM8a12+SUfwIwAtwrfgmEWm7E3gC12+rNLAhg
 oHqyu7C0FyXM4Bm1fM7y5WWNGdbL8tpPUQBxc6OmWe5DzwGHKTwzZL2XtNAUemLc7uGrwCimIFa
 +2dmQChazyn6oDAWyUQ8MeUOJE+jRWOwGfY+oFUOm1NpeTr0TKdXRpgosj1/eUdKjkkmtmsn4xt
 w6YLx9za4BQJKWqHIcGMX++JtUCMcrJJe+CnkZG5vp54+8ENcD/LNr13FAE1Jx/b0BIxgrdZbyl
 zWF9Hj8ix0ZoohQ==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

Allow the USB3 second and third GCC PHY pipe clocks to propagate the
rate to the pipe clocks provided by the QMP combo PHYs. The first
instance is already doing that.

Fixes: ("161b7c401f4b clk: qcom: Add Global Clock controller (GCC) driver for X1E80100")
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 drivers/clk/qcom/gcc-x1e80100.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/qcom/gcc-x1e80100.c b/drivers/clk/qcom/gcc-x1e80100.c
index 1404017be918..8c72fdc99fd9 100644
--- a/drivers/clk/qcom/gcc-x1e80100.c
+++ b/drivers/clk/qcom/gcc-x1e80100.c
@@ -5269,6 +5269,7 @@ static struct clk_branch gcc_usb3_sec_phy_pipe_clk = {
 				&gcc_usb3_sec_phy_pipe_clk_src.clkr.hw,
 			},
 			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
 			.ops = &clk_branch2_ops,
 		},
 	},
@@ -5339,6 +5340,7 @@ static struct clk_branch gcc_usb3_tert_phy_pipe_clk = {
 				&gcc_usb3_tert_phy_pipe_clk_src.clkr.hw,
 			},
 			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
 			.ops = &clk_branch2_ops,
 		},
 	},

---
base-commit: 9d99040b1bc8dbf385a8aa535e9efcdf94466e19
change-id: 20240530-x1e80100-clk-gcc-usb3-sec-tert-set-parent-rate-420a9e2113d1

Best regards,
-- 
Abel Vesa <abel.vesa@linaro.org>


