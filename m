Return-Path: <linux-kernel+bounces-438154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D07279E9D7E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 18:50:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F1931886DC8
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 17:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D28A61A2398;
	Mon,  9 Dec 2024 17:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aTBrH4p8"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 294291C5CBD
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 17:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733766560; cv=none; b=rTOpIVcZwzoY2GxZMcy0Mm4vpFqlb6JIZvUQR89jTchV2wMu6lZLHN2n9tY/6aOUQ+4YI5pB1gxrf7FosH9CUuAWzC+bTgs97SSHGXp1bq55/p36NVLpv3EN0YZLt+dM5rTe/EHOE4piCS08ShgVjkVO92cEqowZ5I/lVijidWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733766560; c=relaxed/simple;
	bh=/ngJ31invQX5gKPkdlu21QxuRo0Yy8l2N/s4QwYdOLU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EA3ameHZPObQRxIGZZIiuluxyauO6wuo9d75Pot6ZPLw3RgiwfVHttqOVJ+xFwR5Vo6ZhoETUcT90u2iAt5PaM0Rc/HO3g37E22J9vF9quN/+hRp/Fl3JHyPhRTUAcwpV5lMnat0tUMp/SRvxyti8PGIGmYgGHmQcP7rqhfwYjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aTBrH4p8; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-21619108a6bso22151265ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 09:49:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733766557; x=1734371357; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Zf8gzCK3nfrU3b7Uuxbc0dGE1qzZ9/xYXm+PyMypy4k=;
        b=aTBrH4p8uwN3mK5wZi7cIQnJaMEtTpmWg2zzu3gWwTrzKQZcehNf69M1+xI3+/zviP
         7YvIby+h1KzcGHf/gV5vooIIBH+ygB1bpX5t/jEpfv/1VdAoGCeSvC36MMfwFbkrGL37
         EQ57TwZMDr/MnMd41wbDRqqDfVxrmBIJ4XW2sCMuxWjYW1qMwZTMNlOGxLzKfUifk9UP
         fnwKdkjb8/2VWAcBYFFWklndtVmLFQKiKEdt05aTPYm9Eovxvm11rsaNQ4cnwUUBn5jz
         j0C2umfOdkzBXguJxw7Tp/qbcPoQWczg6EHm3KjeI5db8D9SesBn1rO84prc+cHQN3Dj
         Tzpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733766557; x=1734371357;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zf8gzCK3nfrU3b7Uuxbc0dGE1qzZ9/xYXm+PyMypy4k=;
        b=ghXurx3sHtequuuHITcpOZ6uC2ckQMsKYb/2oxZQoLfl/ShDV58da8GS0D4Nd6esXx
         yB//lQHavXj7pl92akt2dom47mHB6yfcMiktL7PrTP2gKpEkidMdCUJXT/8Ee53W2yxd
         jwy5JqUBV3rr0GC/T3jn8Z4ZwaxF4tu8T/aUZY2ia0errD6AQTuBtqYjZuHt6m1GRRm0
         zki9Ffr2nWVzSXNrBdZ5PjyipfXlVR+BmyFzXYP2qZhhAMiLJcAm3TIxYL7YmkXEkYs7
         RLAhN99aY6L83km9us3/iP8o0lANivyrqZFdbf3cOqwiYGYVr2OXad/HIi5ZvQDUmCh5
         Q5SA==
X-Forwarded-Encrypted: i=1; AJvYcCUzLHLdQ6SSaQEaQILL1LXNdjVmJPfcayAPPUgj8sUPXd7ytNh0Dr8Z85AZ8kWIKreGFGZKz4BOOhyFvJo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKQfsqXj1FpfDSwM2UgJSdF5nG36kE6+dA3ZHwC1wnB6SnsWr6
	PsHiaNr40sBSiJl/2TVI48CGF4L0rDh8FTZdI5p4Ukscz1pl0mYEvBG3oax6HdI=
X-Gm-Gg: ASbGncsYrW8u5mA9M1A3t1qK42HlsBIScqmCaAcLED/9+Wu9H5xjIsV2C0cH/EyXUD6
	bPSW+0x1ZeyU+IcDKnzDDNh83ISfdsnAkAYphlPY2+Y7UHIpsaAKDz5Ox8cuKZVHqRAaU51sYKR
	Z6/ICyfSX8Egr14yFPmMLEKHvrHNDQP2BhPV4xkdYCz/5arQtWzVdb+TOqdMkeOgT66Gml5qj4Q
	+/+pEFNIg7LAK7mVdYE2Vz4nuLbYwxbySUIImcRJlXkGW+y/w==
X-Google-Smtp-Source: AGHT+IFY3WJ1ALik4fCfvOaI+IBshnfFj9VVWrccJaSzIqDQLA6VvD98zEwQj/L1R/jPX93PhyCxlw==
X-Received: by 2002:a17:903:2303:b0:216:2a36:5b2e with SMTP id d9443c01a7336-2166a024b1fmr19667555ad.32.1733766557531;
        Mon, 09 Dec 2024 09:49:17 -0800 (PST)
Received: from x-wing.. ([2406:7400:94:42cf:4dea:f154:880:3adc])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2164d103993sm21837865ad.193.2024.12.09.09.49.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 09:49:17 -0800 (PST)
From: Amit Pundir <amit.pundir@linaro.org>
To: Stephen Boyd <sboyd@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Taniya Das <quic_tdas@quicinc.com>,
	Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm <linux-arm-msm@vger.kernel.org>,
	linux-clk <linux-clk@vger.kernel.org>,
	lkml <linux-kernel@vger.kernel.org>
Subject: [RESEND] clk: qcom: gcc-sdm845: Do not use shared clk_ops for QUPs
Date: Mon,  9 Dec 2024 23:19:12 +0530
Message-ID: <20241209174912.2526928-1-amit.pundir@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Similar to the earlier fixes meant for sm8x50 and x1e platforms,
we have to stop using the shared clk ops for sdm845 QUPs as well.

As Stephen Boyd pointed out in earlier fixes, there wasn't a problem
to mark QUP clks shared until we started parking shared RCGs at clk
registration time in commit 01a0a6cc8cfd ("clk: qcom: Park shared RCGs
upon registration"). Parking at init is actually harmful to the UART
when earlycon is used. If the device is pumping out data while the
frequency changes and we see garbage on the serial console until the
driver can probe and actually set a proper frequency.

This patch reverts the QUP clk sharing ops part of commit 06391eddb60a
("clk: qcom: Add Global Clock controller (GCC) driver for SDM845"), so
that the QUPs on sdm845 don't get parked during clk registration and
break UART operations.

Fixes: 01a0a6cc8cfd ("clk: qcom: Park shared RCGs upon registration")
Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
---
 drivers/clk/qcom/gcc-sdm845.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/clk/qcom/gcc-sdm845.c b/drivers/clk/qcom/gcc-sdm845.c
index dc3aa7014c3e..c6692808a822 100644
--- a/drivers/clk/qcom/gcc-sdm845.c
+++ b/drivers/clk/qcom/gcc-sdm845.c
@@ -454,7 +454,7 @@ static struct clk_init_data gcc_qupv3_wrap0_s0_clk_src_init = {
 	.name = "gcc_qupv3_wrap0_s0_clk_src",
 	.parent_data = gcc_parent_data_0,
 	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
-	.ops = &clk_rcg2_shared_ops,
+	.ops = &clk_rcg2_ops,
 };
 
 static struct clk_rcg2 gcc_qupv3_wrap0_s0_clk_src = {
@@ -470,7 +470,7 @@ static struct clk_init_data gcc_qupv3_wrap0_s1_clk_src_init = {
 	.name = "gcc_qupv3_wrap0_s1_clk_src",
 	.parent_data = gcc_parent_data_0,
 	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
-	.ops = &clk_rcg2_shared_ops,
+	.ops = &clk_rcg2_ops,
 };
 
 static struct clk_rcg2 gcc_qupv3_wrap0_s1_clk_src = {
@@ -486,7 +486,7 @@ static struct clk_init_data gcc_qupv3_wrap0_s2_clk_src_init = {
 	.name = "gcc_qupv3_wrap0_s2_clk_src",
 	.parent_data = gcc_parent_data_0,
 	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
-	.ops = &clk_rcg2_shared_ops,
+	.ops = &clk_rcg2_ops,
 };
 
 static struct clk_rcg2 gcc_qupv3_wrap0_s2_clk_src = {
@@ -502,7 +502,7 @@ static struct clk_init_data gcc_qupv3_wrap0_s3_clk_src_init = {
 	.name = "gcc_qupv3_wrap0_s3_clk_src",
 	.parent_data = gcc_parent_data_0,
 	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
-	.ops = &clk_rcg2_shared_ops,
+	.ops = &clk_rcg2_ops,
 };
 
 static struct clk_rcg2 gcc_qupv3_wrap0_s3_clk_src = {
@@ -518,7 +518,7 @@ static struct clk_init_data gcc_qupv3_wrap0_s4_clk_src_init = {
 	.name = "gcc_qupv3_wrap0_s4_clk_src",
 	.parent_data = gcc_parent_data_0,
 	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
-	.ops = &clk_rcg2_shared_ops,
+	.ops = &clk_rcg2_ops,
 };
 
 static struct clk_rcg2 gcc_qupv3_wrap0_s4_clk_src = {
@@ -534,7 +534,7 @@ static struct clk_init_data gcc_qupv3_wrap0_s5_clk_src_init = {
 	.name = "gcc_qupv3_wrap0_s5_clk_src",
 	.parent_data = gcc_parent_data_0,
 	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
-	.ops = &clk_rcg2_shared_ops,
+	.ops = &clk_rcg2_ops,
 };
 
 static struct clk_rcg2 gcc_qupv3_wrap0_s5_clk_src = {
@@ -550,7 +550,7 @@ static struct clk_init_data gcc_qupv3_wrap0_s6_clk_src_init = {
 	.name = "gcc_qupv3_wrap0_s6_clk_src",
 	.parent_data = gcc_parent_data_0,
 	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
-	.ops = &clk_rcg2_shared_ops,
+	.ops = &clk_rcg2_ops,
 };
 
 static struct clk_rcg2 gcc_qupv3_wrap0_s6_clk_src = {
@@ -566,7 +566,7 @@ static struct clk_init_data gcc_qupv3_wrap0_s7_clk_src_init = {
 	.name = "gcc_qupv3_wrap0_s7_clk_src",
 	.parent_data = gcc_parent_data_0,
 	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
-	.ops = &clk_rcg2_shared_ops,
+	.ops = &clk_rcg2_ops,
 };
 
 static struct clk_rcg2 gcc_qupv3_wrap0_s7_clk_src = {
@@ -582,7 +582,7 @@ static struct clk_init_data gcc_qupv3_wrap1_s0_clk_src_init = {
 	.name = "gcc_qupv3_wrap1_s0_clk_src",
 	.parent_data = gcc_parent_data_0,
 	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
-	.ops = &clk_rcg2_shared_ops,
+	.ops = &clk_rcg2_ops,
 };
 
 static struct clk_rcg2 gcc_qupv3_wrap1_s0_clk_src = {
@@ -598,7 +598,7 @@ static struct clk_init_data gcc_qupv3_wrap1_s1_clk_src_init = {
 	.name = "gcc_qupv3_wrap1_s1_clk_src",
 	.parent_data = gcc_parent_data_0,
 	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
-	.ops = &clk_rcg2_shared_ops,
+	.ops = &clk_rcg2_ops,
 };
 
 static struct clk_rcg2 gcc_qupv3_wrap1_s1_clk_src = {
@@ -614,7 +614,7 @@ static struct clk_init_data gcc_qupv3_wrap1_s2_clk_src_init = {
 	.name = "gcc_qupv3_wrap1_s2_clk_src",
 	.parent_data = gcc_parent_data_0,
 	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
-	.ops = &clk_rcg2_shared_ops,
+	.ops = &clk_rcg2_ops,
 };
 
 static struct clk_rcg2 gcc_qupv3_wrap1_s2_clk_src = {
@@ -630,7 +630,7 @@ static struct clk_init_data gcc_qupv3_wrap1_s3_clk_src_init = {
 	.name = "gcc_qupv3_wrap1_s3_clk_src",
 	.parent_data = gcc_parent_data_0,
 	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
-	.ops = &clk_rcg2_shared_ops,
+	.ops = &clk_rcg2_ops,
 };
 
 static struct clk_rcg2 gcc_qupv3_wrap1_s3_clk_src = {
@@ -646,7 +646,7 @@ static struct clk_init_data gcc_qupv3_wrap1_s4_clk_src_init = {
 	.name = "gcc_qupv3_wrap1_s4_clk_src",
 	.parent_data = gcc_parent_data_0,
 	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
-	.ops = &clk_rcg2_shared_ops,
+	.ops = &clk_rcg2_ops,
 };
 
 static struct clk_rcg2 gcc_qupv3_wrap1_s4_clk_src = {
@@ -662,7 +662,7 @@ static struct clk_init_data gcc_qupv3_wrap1_s5_clk_src_init = {
 	.name = "gcc_qupv3_wrap1_s5_clk_src",
 	.parent_data = gcc_parent_data_0,
 	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
-	.ops = &clk_rcg2_shared_ops,
+	.ops = &clk_rcg2_ops,
 };
 
 static struct clk_rcg2 gcc_qupv3_wrap1_s5_clk_src = {
@@ -678,7 +678,7 @@ static struct clk_init_data gcc_qupv3_wrap1_s6_clk_src_init = {
 	.name = "gcc_qupv3_wrap1_s6_clk_src",
 	.parent_data = gcc_parent_data_0,
 	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
-	.ops = &clk_rcg2_shared_ops,
+	.ops = &clk_rcg2_ops,
 };
 
 static struct clk_rcg2 gcc_qupv3_wrap1_s6_clk_src = {
@@ -694,7 +694,7 @@ static struct clk_init_data gcc_qupv3_wrap1_s7_clk_src_init = {
 	.name = "gcc_qupv3_wrap1_s7_clk_src",
 	.parent_data = gcc_parent_data_0,
 	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
-	.ops = &clk_rcg2_shared_ops,
+	.ops = &clk_rcg2_ops,
 };
 
 static struct clk_rcg2 gcc_qupv3_wrap1_s7_clk_src = {
-- 
2.43.0


