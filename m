Return-Path: <linux-kernel+bounces-224818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9211A912733
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 16:02:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3D491C2432A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 14:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 490BC3D984;
	Fri, 21 Jun 2024 14:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NTBjE9yM"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAFEA2C182
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 14:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718978511; cv=none; b=dTlbFU/RofRF8KJCTt02J2hq1o0f1rJuPN/tnVEQb70QPWACV9yp9kHvtgr+m9flb5BCcy7CLUsaH8VTp6wEMizxnHF+9zYgSK+eRbaqmBaiFphOtQKL9iw/++TSMjL8jflAtDWnYqojOd2gcEUTCjFzOqCW75b2VSPsdsckJLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718978511; c=relaxed/simple;
	bh=4bDh7sRBhgwG5+mLbZdufXiPUuyeNa+prJH8L8Jmc14=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Uwzq8+7m4H+06VSEwmoPy6vciSjkln72c1FlTMdVbJYc8zcIfftGnfZyWbGUrSxsGb8NuuzvhRLoF9VsWZ+LHW482UvcROoo5oD3s/ZZTNm6yE+UKnYQL0Oi336GNV3AO6QO0ZfFsTQs9coY6le/lWrlocJBkJ4SyVxo7VsolLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NTBjE9yM; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4217136a74dso17538505e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 07:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718978508; x=1719583308; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K0jH/bj7Lqj0At6MAhYLJTdfQCIn+n13kr0wPP2H/nA=;
        b=NTBjE9yMYFAXdOTkOeSAWQrQrnC7fq00QgetNYOJyQe5irP4ghpn31ZyCqXOvCFL4S
         ObDXQ8oQj399inUaBSKT2JQNWzYbIkYTCJYDnrTJLk95JPxnUeT9/KP3x0S/S71X6ecR
         TL5nhbm6wf/AbabOKLDk99RF0w5yteHAWVSLRA7J4gfe5N+uWl6xdKKiBD34xiLD3rmh
         mIzhm6gYps2TlmZ10JcJiJrilMV9zn8wY0vT+2B+QriiBjz+76CCvkuvIUfzdOTx051J
         BseMonTLcCvDoXaa+2urq/jrONEvOjLfTWdoFd1J4Q/WFJI8uPot0wvWxCwGcXbHMMTt
         idyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718978508; x=1719583308;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K0jH/bj7Lqj0At6MAhYLJTdfQCIn+n13kr0wPP2H/nA=;
        b=Gg3CyBba42XjGHlIuxjrmOoP8/p+wo7NvEJ303079mKQtZdKoE0ZAta0f/bXK5OYd+
         bEcrzGa9J40kkYfRZbbaWzxRC/iF8Om9FmGuw+e8C91N14bt0bDPyDs67eobGZrUydDU
         KZ/3A+n7ATeEPaKQVn26JcXJVoKQNadG0WZ5Bx0HzZ2s2gEHHIzJwbAr8e+JzCZdNT8F
         pIwSBCcU4bJvjUtkaABHTe+rU5DZmXtPCIRvWkhTtbOJZn/HGwRlDEaZ85TJot/oGds6
         uVie9AyK5xF4g1EbdiCLlPmli2BxTf7/tHMecAnp9uU8zcoNkdG5CxjS64MH/TochzvF
         HnOQ==
X-Forwarded-Encrypted: i=1; AJvYcCWY/BNIW18J0+gMhac+4nXu1XUDlIQSPrFCUAKZdo5I/SCyvsIOwPUVV2p9Nxkz9e0Niag7L8yUHfKq4Ve981P567aTcleDOtBeGksa
X-Gm-Message-State: AOJu0YzNKQMazTnr8h6IK5iHKM4xo+AWTcbHoDrsUtLRh5hJKddll9CA
	yNfeklclLrK8SdaAeLbxXbJWZjsKwUyO9t8SGiKkWluRLZlv0HEBrxFea2uwdK8=
X-Google-Smtp-Source: AGHT+IHQhtN0geVJUd7mOt3RhAhPJ693+WAnvErRVzmUP4NSBKoEdkmKBpU+SGk0NmCnwdouZ1nXNw==
X-Received: by 2002:a7b:c3cc:0:b0:422:6449:1307 with SMTP id 5b1f17b1804b1-42475296a62mr65318825e9.32.1718978507859;
        Fri, 21 Jun 2024 07:01:47 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-366383f6722sm1847342f8f.24.2024.06.21.07.01.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 07:01:47 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Fri, 21 Jun 2024 16:01:18 +0200
Subject: [PATCH 5/5] clk: qcom: dispcc-sm8650: Update the GDSC wait_val
 fields and flags
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240621-topic-sm8650-upstream-fix-dispcc-v1-5-7b297dd9fcc1@linaro.org>
References: <20240621-topic-sm8650-upstream-fix-dispcc-v1-0-7b297dd9fcc1@linaro.org>
In-Reply-To: <20240621-topic-sm8650-upstream-fix-dispcc-v1-0-7b297dd9fcc1@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Taniya Das <quic_tdas@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1354;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=4bDh7sRBhgwG5+mLbZdufXiPUuyeNa+prJH8L8Jmc14=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBmdYfEIJAtyBOt9vpTxJ/ZTkkFM/nBTe1lGqWGLbCc
 PThoYZiJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZnWHxAAKCRB33NvayMhJ0TBwD/
 9IvnzqHvxjgGHvLWvkLAi1AJlRmMikHj42W+nItBO6zESHJ7quCKgo+LaDBRF7hSMmeoRClh6NVMhw
 SgB+6gjnOlmS0CV7Tl97EnYoKD/xUOmJGUC/arXRZ1G11R1IzYkrlgZutHTTfJ0smtKjHZDIA65iBM
 v5vmo1SgwfGAtWmf2dInYfz7dttvDdwUkFYz3uv83hvXAG9eTrJALX4N3yvNo+SuFlnc1b3dj/jGBk
 Rl7MEYy70gMN0PKwVzC5dptCL6RPTy5UxWaebb3Ww1jwcIQhFdhW6b+YI+Ta3ZNrm1RuOJ8t3hV7Ci
 WuzlEj2tDe/nHSMDNl7/U1xoun0zHIsvGGjfmUmEhqtkLoEuOGdn5KY/63wKG/EBjSq2MFBB8M7EZ4
 gtD/gZ/VITNT9y1O1jLkFulz80l9VqQ5XnhoK7dK9W7Oi1xVL+yaPbamPxlHWE323Q6IUjGPaJRFcm
 HevFMPSiCgXEELadcpKlA4GOMB1GBJqh64zs8g3/1r3pEA8Sox/1FMWXhoEGfMwT4Ly46aplLB/vBG
 Yuvr9LxjbMBdZwm/EuTL/yU85KmITSpUXJ0haWJvmhEA+t99mDfrFyqvbBnQDUIC2YtGfP8Q54jK8X
 JhXXuN9izKXP8deS7RDvmbnitxkZ5vAbflt2c/2achSX2SR4/vqpbum9Vqpg==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Update the GDSC wait_val fields and flags as per the default hardware values.
Add the missing POLL_CFG_GDSCR flag.

Fixes: 9e939f008338 ("clk: qcom: add the SM8650 Display Clock Controller driver")
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/clk/qcom/dispcc-sm8650.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/qcom/dispcc-sm8650.c b/drivers/clk/qcom/dispcc-sm8650.c
index d88eebb32575..2da3c11b0c3d 100644
--- a/drivers/clk/qcom/dispcc-sm8650.c
+++ b/drivers/clk/qcom/dispcc-sm8650.c
@@ -1604,20 +1604,26 @@ static struct clk_branch disp_cc_sleep_clk = {
 
 static struct gdsc mdss_gdsc = {
 	.gdscr = 0x9000,
+	.en_rest_wait_val = 0x2,
+	.en_few_wait_val = 0x2,
+	.clk_dis_wait_val = 0xf,
 	.pd = {
 		.name = "mdss_gdsc",
 	},
 	.pwrsts = PWRSTS_OFF_ON,
-	.flags = HW_CTRL | RETAIN_FF_ENABLE,
+	.flags = POLL_CFG_GDSCR | HW_CTRL | RETAIN_FF_ENABLE,
 };
 
 static struct gdsc mdss_int2_gdsc = {
 	.gdscr = 0xb000,
+	.en_rest_wait_val = 0x2,
+	.en_few_wait_val = 0x2,
+	.clk_dis_wait_val = 0xf,
 	.pd = {
 		.name = "mdss_int2_gdsc",
 	},
 	.pwrsts = PWRSTS_OFF_ON,
-	.flags = HW_CTRL | RETAIN_FF_ENABLE,
+	.flags = POLL_CFG_GDSCR | HW_CTRL | RETAIN_FF_ENABLE,
 };
 
 static struct clk_regmap *disp_cc_sm8650_clocks[] = {

-- 
2.34.1


