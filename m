Return-Path: <linux-kernel+bounces-298907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8409B95CD13
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 14:59:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9AA91C212C9
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 12:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D3701862BE;
	Fri, 23 Aug 2024 12:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rO9b5O/b"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29A818028
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 12:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724417943; cv=none; b=SjYe8qXxS+I8aEV7uqUHMbk9pnLcT4YgIIFRr+qKAe3ewqk/ecuPDY6Wz/QzU/CW1nvr5N2iSIBH7KuXc68f7HkazdwviL2GhFwv9D071A2W5v2g/gD0N4EA7kSSC2mbHNgzH32uQd8Mcnc9Tf8mqOGrOOjotgh7aAhLQHYGaVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724417943; c=relaxed/simple;
	bh=7kNEi/OiZze03OM1wbMpjeZA2NZZGXIuVb2E2KfBN4A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=SoyhBNSKlxBpmuX85syNt/mptSYPebgVAtT54UKCEMHrXnbj27zgGkixWxTBj1jywvMHwIqfSV06f0rD8HTOcVX4/FMig9oggk4pL2mJ1w8K/F2JExPZu4H5LnhdUT+bM4TL9N/25uUm+TP7/fZ/GT73CHyXtJFDfBW+9HaARHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rO9b5O/b; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2f040733086so17684181fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 05:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724417939; x=1725022739; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qghjeC4G1cLi83JB5WxagT7bfxgoomvA+OfZjEPYThQ=;
        b=rO9b5O/bW2qmDRD7QxtZE2BLIGcN7/jTP9RMiqupCI/s7CwgMEkeItF3uDYCFbUygJ
         +XsCzZtB5u+7HRZ6u4c40nSeKMewxB7913xmNThriGZK1uZehKL0qFLgrwDF3r/wlYRL
         oqPnzsCOYQL3oUlWHCJXE/gutA+75Jo2QCgGVpAjvc4xEJ+BMqPbLPtKNxRhMqp0Dg6v
         vEzIlJeB23zQP7LXl56MvjMvFCIKQumkL3XxwSoxBfXqLyHLTHqckQj2Kayh/ZbqaEu/
         bWmTPZnRlKkJMXib1jrt4bgB9gj5gBKUM0bCjojemEbBHk8LXNXIVOEAB97tsD8Vmef4
         Z9Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724417939; x=1725022739;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qghjeC4G1cLi83JB5WxagT7bfxgoomvA+OfZjEPYThQ=;
        b=k7C+CRytjPOxSK0I14tVRW4rnBuLto65v18pHUfvVmXk8OxkRzbzcvBOSwsi5W13+J
         5H42IhqN2ToEhQ7tpcwL2NYNdPsk/7lqVgUi52NbqsxJwsXIMSOxJQz+bMtzclH/OswL
         kn6/Vv91Z6BBqAr4OXv0dwqNwbOVDA8lvCainGSuzwf97M41Lrnp7G8EDgIO9aHctGeD
         FHLfxWOsJRSOjn4//iu/OHM92rUC4nJrDN0t4AQBsYtRnPhI4HG8G6QsXZxP6/3jBy2g
         Vv6IbrNFLH50q9jX1jI8x6RtasvfHnxVr28/0Dqg4zODyeydgG0NEQlFs2uCSUpj5s09
         spjw==
X-Forwarded-Encrypted: i=1; AJvYcCVzX3pkTSdzgO68xtE8WjGK+yaI5ymllvOgwAG8GXOyDLGtZJc0gjAIfIXTT2KnlTAucFuUbiOo1ujF+k0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLKVxN37zk/pADuIPxic4Y9z8PFtmiGinYA0tCcXDfLk+wCuuy
	KvyfK4pyVK47DEuK9/UY3Cd3AqDUcXmzm/0attY+L0ASHyIm5U+fTB+cPIwSCCE=
X-Google-Smtp-Source: AGHT+IFmyJqIIYKvFHFmvTWKdG+lP5pWyv5LUxcyYzdy1j+zF2jNHfzDubXY6GIudLULTmshpFaK5A==
X-Received: by 2002:a2e:8ec6:0:b0:2f3:cabc:6158 with SMTP id 38308e7fff4ca-2f4f5756f0emr13105291fa.11.1724417938476;
        Fri, 23 Aug 2024 05:58:58 -0700 (PDT)
Received: from [127.0.0.1] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c0515a9806sm2086709a12.87.2024.08.23.05.58.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 05:58:58 -0700 (PDT)
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Date: Fri, 23 Aug 2024 13:58:56 +0100
Subject: [PATCH] clk: qcom: gcc-x1e80100: Don't use parking clk_ops for
 QUPs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240823-x1e80100-clk-fix-v1-1-0b1b4f5a96e8@linaro.org>
X-B4-Tracking: v=1; b=H4sIAI+HyGYC/x2MQQqAMAzAviI9W+iq6OZXxINo1aKobCAD2d8dH
 hNIXgjiVQJ0xQteHg16nRlMWcC0jecqqHNmYOKaLFcYjVgyRDgdOy4aseHW8GwdsSPI2e0l63/
 ZDyl9ArLTH2IAAAA=
To: Bjorn Andersson <andersson@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rajendra Nayak <quic_rjendra@quicinc.com>, 
 Sibi Sankar <quic_sibis@quicinc.com>, Abel Vesa <abel.vesa@linaro.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>
X-Mailer: b4 0.15-dev

Per Stephen Boyd's explanation in the link below, QUP RCG clocks do not
need to be parked when switching frequency. A side-effect in parking to a
lower frequency can be a momentary invalid clock driven on an in-use serial
peripheral.

This can cause "junk" to spewed out of a UART as a low-impact example. On
the x1e80100-crd this serial port junk can be observed on linux-next.

Apply a similar fix to the x1e80100 Global Clock controller to remediate.

Link: https://lore.kernel.org/all/20240819233628.2074654-3-swboyd@chromium.org/
Fixes: 161b7c401f4b ("clk: qcom: Add Global Clock controller (GCC) driver for X1E80100")
Fixes: 929c75d57566 ("clk: qcom: gcc-sm8550: Mark RCGs shared where applicable")
Suggested-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
I ran into some junk on the x1e80100 serial port and asked around to see if
someone had already found and fixed.

Neil pointed me at Stephen's fix for sm8550 which I found is also required
to fix the same thing x1e80100.
---
 drivers/clk/qcom/gcc-x1e80100.c | 48 ++++++++++++++++++++---------------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/drivers/clk/qcom/gcc-x1e80100.c b/drivers/clk/qcom/gcc-x1e80100.c
index 6ffb3ddcae086..f17f8a1fcf414 100644
--- a/drivers/clk/qcom/gcc-x1e80100.c
+++ b/drivers/clk/qcom/gcc-x1e80100.c
@@ -670,7 +670,7 @@ static struct clk_init_data gcc_qupv3_wrap0_s0_clk_src_init = {
 	.parent_data = gcc_parent_data_0,
 	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
 	.flags = CLK_SET_RATE_PARENT,
-	.ops = &clk_rcg2_shared_ops,
+	.ops = &clk_rcg2_ops,
 };
 
 static struct clk_rcg2 gcc_qupv3_wrap0_s0_clk_src = {
@@ -687,7 +687,7 @@ static struct clk_init_data gcc_qupv3_wrap0_s1_clk_src_init = {
 	.parent_data = gcc_parent_data_0,
 	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
 	.flags = CLK_SET_RATE_PARENT,
-	.ops = &clk_rcg2_shared_ops,
+	.ops = &clk_rcg2_ops,
 };
 
 static struct clk_rcg2 gcc_qupv3_wrap0_s1_clk_src = {
@@ -719,7 +719,7 @@ static struct clk_init_data gcc_qupv3_wrap0_s2_clk_src_init = {
 	.parent_data = gcc_parent_data_0,
 	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
 	.flags = CLK_SET_RATE_PARENT,
-	.ops = &clk_rcg2_shared_ops,
+	.ops = &clk_rcg2_ops,
 };
 
 static struct clk_rcg2 gcc_qupv3_wrap0_s2_clk_src = {
@@ -736,7 +736,7 @@ static struct clk_init_data gcc_qupv3_wrap0_s3_clk_src_init = {
 	.parent_data = gcc_parent_data_0,
 	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
 	.flags = CLK_SET_RATE_PARENT,
-	.ops = &clk_rcg2_shared_ops,
+	.ops = &clk_rcg2_ops,
 };
 
 static struct clk_rcg2 gcc_qupv3_wrap0_s3_clk_src = {
@@ -768,7 +768,7 @@ static struct clk_init_data gcc_qupv3_wrap0_s4_clk_src_init = {
 	.parent_data = gcc_parent_data_0,
 	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
 	.flags = CLK_SET_RATE_PARENT,
-	.ops = &clk_rcg2_shared_ops,
+	.ops = &clk_rcg2_ops,
 };
 
 static struct clk_rcg2 gcc_qupv3_wrap0_s4_clk_src = {
@@ -785,7 +785,7 @@ static struct clk_init_data gcc_qupv3_wrap0_s5_clk_src_init = {
 	.parent_data = gcc_parent_data_0,
 	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
 	.flags = CLK_SET_RATE_PARENT,
-	.ops = &clk_rcg2_shared_ops,
+	.ops = &clk_rcg2_ops,
 };
 
 static struct clk_rcg2 gcc_qupv3_wrap0_s5_clk_src = {
@@ -802,7 +802,7 @@ static struct clk_init_data gcc_qupv3_wrap0_s6_clk_src_init = {
 	.parent_data = gcc_parent_data_0,
 	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
 	.flags = CLK_SET_RATE_PARENT,
-	.ops = &clk_rcg2_shared_ops,
+	.ops = &clk_rcg2_ops,
 };
 
 static struct clk_rcg2 gcc_qupv3_wrap0_s6_clk_src = {
@@ -819,7 +819,7 @@ static struct clk_init_data gcc_qupv3_wrap0_s7_clk_src_init = {
 	.parent_data = gcc_parent_data_0,
 	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
 	.flags = CLK_SET_RATE_PARENT,
-	.ops = &clk_rcg2_shared_ops,
+	.ops = &clk_rcg2_ops,
 };
 
 static struct clk_rcg2 gcc_qupv3_wrap0_s7_clk_src = {
@@ -836,7 +836,7 @@ static struct clk_init_data gcc_qupv3_wrap1_s0_clk_src_init = {
 	.parent_data = gcc_parent_data_0,
 	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
 	.flags = CLK_SET_RATE_PARENT,
-	.ops = &clk_rcg2_shared_ops,
+	.ops = &clk_rcg2_ops,
 };
 
 static struct clk_rcg2 gcc_qupv3_wrap1_s0_clk_src = {
@@ -853,7 +853,7 @@ static struct clk_init_data gcc_qupv3_wrap1_s1_clk_src_init = {
 	.parent_data = gcc_parent_data_0,
 	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
 	.flags = CLK_SET_RATE_PARENT,
-	.ops = &clk_rcg2_shared_ops,
+	.ops = &clk_rcg2_ops,
 };
 
 static struct clk_rcg2 gcc_qupv3_wrap1_s1_clk_src = {
@@ -870,7 +870,7 @@ static struct clk_init_data gcc_qupv3_wrap1_s2_clk_src_init = {
 	.parent_data = gcc_parent_data_0,
 	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
 	.flags = CLK_SET_RATE_PARENT,
-	.ops = &clk_rcg2_shared_ops,
+	.ops = &clk_rcg2_ops,
 };
 
 static struct clk_rcg2 gcc_qupv3_wrap1_s2_clk_src = {
@@ -887,7 +887,7 @@ static struct clk_init_data gcc_qupv3_wrap1_s3_clk_src_init = {
 	.parent_data = gcc_parent_data_0,
 	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
 	.flags = CLK_SET_RATE_PARENT,
-	.ops = &clk_rcg2_shared_ops,
+	.ops = &clk_rcg2_ops,
 };
 
 static struct clk_rcg2 gcc_qupv3_wrap1_s3_clk_src = {
@@ -904,7 +904,7 @@ static struct clk_init_data gcc_qupv3_wrap1_s4_clk_src_init = {
 	.parent_data = gcc_parent_data_0,
 	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
 	.flags = CLK_SET_RATE_PARENT,
-	.ops = &clk_rcg2_shared_ops,
+	.ops = &clk_rcg2_ops,
 };
 
 static struct clk_rcg2 gcc_qupv3_wrap1_s4_clk_src = {
@@ -921,7 +921,7 @@ static struct clk_init_data gcc_qupv3_wrap1_s5_clk_src_init = {
 	.parent_data = gcc_parent_data_0,
 	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
 	.flags = CLK_SET_RATE_PARENT,
-	.ops = &clk_rcg2_shared_ops,
+	.ops = &clk_rcg2_ops,
 };
 
 static struct clk_rcg2 gcc_qupv3_wrap1_s5_clk_src = {
@@ -938,7 +938,7 @@ static struct clk_init_data gcc_qupv3_wrap1_s6_clk_src_init = {
 	.parent_data = gcc_parent_data_0,
 	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
 	.flags = CLK_SET_RATE_PARENT,
-	.ops = &clk_rcg2_shared_ops,
+	.ops = &clk_rcg2_ops,
 };
 
 static struct clk_rcg2 gcc_qupv3_wrap1_s6_clk_src = {
@@ -955,7 +955,7 @@ static struct clk_init_data gcc_qupv3_wrap1_s7_clk_src_init = {
 	.parent_data = gcc_parent_data_0,
 	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
 	.flags = CLK_SET_RATE_PARENT,
-	.ops = &clk_rcg2_shared_ops,
+	.ops = &clk_rcg2_ops,
 };
 
 static struct clk_rcg2 gcc_qupv3_wrap1_s7_clk_src = {
@@ -972,7 +972,7 @@ static struct clk_init_data gcc_qupv3_wrap2_s0_clk_src_init = {
 	.parent_data = gcc_parent_data_0,
 	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
 	.flags = CLK_SET_RATE_PARENT,
-	.ops = &clk_rcg2_shared_ops,
+	.ops = &clk_rcg2_ops,
 };
 
 static struct clk_rcg2 gcc_qupv3_wrap2_s0_clk_src = {
@@ -989,7 +989,7 @@ static struct clk_init_data gcc_qupv3_wrap2_s1_clk_src_init = {
 	.parent_data = gcc_parent_data_0,
 	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
 	.flags = CLK_SET_RATE_PARENT,
-	.ops = &clk_rcg2_shared_ops,
+	.ops = &clk_rcg2_ops,
 };
 
 static struct clk_rcg2 gcc_qupv3_wrap2_s1_clk_src = {
@@ -1006,7 +1006,7 @@ static struct clk_init_data gcc_qupv3_wrap2_s2_clk_src_init = {
 	.parent_data = gcc_parent_data_0,
 	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
 	.flags = CLK_SET_RATE_PARENT,
-	.ops = &clk_rcg2_shared_ops,
+	.ops = &clk_rcg2_ops,
 };
 
 static struct clk_rcg2 gcc_qupv3_wrap2_s2_clk_src = {
@@ -1023,7 +1023,7 @@ static struct clk_init_data gcc_qupv3_wrap2_s3_clk_src_init = {
 	.parent_data = gcc_parent_data_0,
 	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
 	.flags = CLK_SET_RATE_PARENT,
-	.ops = &clk_rcg2_shared_ops,
+	.ops = &clk_rcg2_ops,
 };
 
 static struct clk_rcg2 gcc_qupv3_wrap2_s3_clk_src = {
@@ -1040,7 +1040,7 @@ static struct clk_init_data gcc_qupv3_wrap2_s4_clk_src_init = {
 	.parent_data = gcc_parent_data_0,
 	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
 	.flags = CLK_SET_RATE_PARENT,
-	.ops = &clk_rcg2_shared_ops,
+	.ops = &clk_rcg2_ops,
 };
 
 static struct clk_rcg2 gcc_qupv3_wrap2_s4_clk_src = {
@@ -1057,7 +1057,7 @@ static struct clk_init_data gcc_qupv3_wrap2_s5_clk_src_init = {
 	.parent_data = gcc_parent_data_0,
 	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
 	.flags = CLK_SET_RATE_PARENT,
-	.ops = &clk_rcg2_shared_ops,
+	.ops = &clk_rcg2_ops,
 };
 
 static struct clk_rcg2 gcc_qupv3_wrap2_s5_clk_src = {
@@ -1074,7 +1074,7 @@ static struct clk_init_data gcc_qupv3_wrap2_s6_clk_src_init = {
 	.parent_data = gcc_parent_data_8,
 	.num_parents = ARRAY_SIZE(gcc_parent_data_8),
 	.flags = CLK_SET_RATE_PARENT,
-	.ops = &clk_rcg2_shared_ops,
+	.ops = &clk_rcg2_ops,
 };
 
 static struct clk_rcg2 gcc_qupv3_wrap2_s6_clk_src = {
@@ -1091,7 +1091,7 @@ static struct clk_init_data gcc_qupv3_wrap2_s7_clk_src_init = {
 	.parent_data = gcc_parent_data_0,
 	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
 	.flags = CLK_SET_RATE_PARENT,
-	.ops = &clk_rcg2_shared_ops,
+	.ops = &clk_rcg2_ops,
 };
 
 static struct clk_rcg2 gcc_qupv3_wrap2_s7_clk_src = {

---
base-commit: 826d8eb42d2a7192c2c8e2103a4d07fb6006f409
change-id: 20240823-x1e80100-clk-fix-62712d890290

Best regards,
-- 
Bryan O'Donoghue <bryan.odonoghue@linaro.org>


