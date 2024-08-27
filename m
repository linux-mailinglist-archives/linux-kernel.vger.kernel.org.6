Return-Path: <linux-kernel+bounces-304107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EC5B961A4E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 01:13:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67D6FB22F85
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 23:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F27681D47AD;
	Tue, 27 Aug 2024 23:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DF8+5UlS"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2EB1D4173
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 23:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724800365; cv=none; b=MA5f2rzzd6aPf73C/c5qZCfRtJNMOb1A9XaIGnQYRa/W4mRsirrgnwFDR135Z1tNONr9sBs6ApoyRhcnCJm2JIxwnekMKbdH0b4tyamqZMYXIHXjkZDrZFpzll7vyS8PddzCRtl8Us5wtzEQ8aFJB9n3djIF6oyYlAQ7iZOQqFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724800365; c=relaxed/simple;
	bh=SgcruDqpzkIUIuGB2VE07Hi5jscNhvIrf+oO5aoFq/0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YqmbSAAA2RQvbKCWaHoqiMHyaMb/tWTWyXCwhpNOCQG6bIyslZ0VSOVbACLC7Af25MbthmejD5MfUr2jFEh4U4idEjX9zQxa7s/CxS4jYAsgWEeoCLyG9XzYiDxcDKvfDPfn9ehQwlECICZbfYcdwCIgy1yRktC0I91Ar7IJOfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=DF8+5UlS; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2020e83eca1so58215635ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 16:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1724800362; x=1725405162; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SNh6OK9gpcvI3kTzyi1JJizEEsumTLCrxNqqOJriJ5g=;
        b=DF8+5UlSKzrVfKCNGSqgYokiUnnk6FGlaj8PyNWkZIUJaEO+LD84+VH3sTy5Ne9lIo
         0A1ahXKkeudiCqXRKWD1DS62ZD9q0fVLHzDF/Z8v1UNsNb7EtjNlaTrYNA/0Udlgx5sL
         p7S4DufF6Th1gYwJKix779GsKjJCXt9/q9iXg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724800362; x=1725405162;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SNh6OK9gpcvI3kTzyi1JJizEEsumTLCrxNqqOJriJ5g=;
        b=FI2dp/j4CxPhsISh5fnKw2rEWqdRWcSrqstnfTvDs7YkogfobKARPQ+HHXcd58h7Vo
         3Ay37Ai+6Mvwvj6zpFgzGUAczqKp1C4Kz9cBdvEkqSCDcuPsep2ro4IxE+lR2UmVu/0i
         H6R7H7vA2t5ZBUed6GACWNFwCHguQ7udGZkzL4sp8ZbJXoRLjNJGrF7kNq6qECxvEyjL
         LVpUWpHtoAc7WWn95InFA8G9bH4JqzhDEtlPAjDl1COWLtMMXA/KWsBHwPVlOz6yANFF
         dLPHVcRw4MhJPh1moWiLB/mZ2TCotjCbuFgn5/Fw4PZf5HUAd+MMVvSo6TuPqnyFHLr3
         /Kkg==
X-Gm-Message-State: AOJu0YxjO0hpffEr845BNOninqvXu1KKPTKyl8DwIUYVA8k4M6Q5RAIg
	gK3zK7lji+SNzm+SQz0PnOOrbnObqBn0jg3nM6jFxBKK/q0OJEATjMR4O5coyA==
X-Google-Smtp-Source: AGHT+IE1FzxMvUzMWQvsr/j5KuzyWibWhIHdYDiLnIiEuSTFy6W3CdwN5QnJLMTfVPlq3u7D9BESYA==
X-Received: by 2002:a17:903:32cf:b0:202:1176:5e39 with SMTP id d9443c01a7336-2039e4fbd72mr135195715ad.56.1724800362408;
        Tue, 27 Aug 2024 16:12:42 -0700 (PDT)
Received: from localhost (210.73.125.34.bc.googleusercontent.com. [34.125.73.210])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-203c9723a54sm43082345ad.180.2024.08.27.16.12.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Aug 2024 16:12:42 -0700 (PDT)
From: Stephen Boyd <swboyd@chromium.org>
To: Konrad Dybcio <konradybcio@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	patches@lists.linux.dev,
	linux-clk@vger.kernel.org,
	Taniya Das <quic_tdas@quicinc.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Amit Pundir <amit.pundir@linaro.org>
Subject: [PATCH v2 1/2] clk: qcom: dispcc-sc7180: Only park display clks at init
Date: Tue, 27 Aug 2024 16:12:34 -0700
Message-ID: <20240827231237.1014813-2-swboyd@chromium.org>
X-Mailer: git-send-email 2.46.0.295.g3b9ea8a38a-goog
In-Reply-To: <20240827231237.1014813-1-swboyd@chromium.org>
References: <20240827231237.1014813-1-swboyd@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Amit Pundir reports that audio and USB-C host mode stops working on
sm8550 if the gcc_usb30_prim_master_clk_src clk is registered and
clk_rcg2_shared_init() parks it on XO.

Partially revert commit 01a0a6cc8cfd ("clk: qcom: Park shared RCGs upon
registration") by skipping the parking bit, and make that the default
for shared RCGs, but keep the part where we cache the config register as
that's still necessary to figure out the true parent of the clk at
registration time. Move the logic from clk_rcg2_shared_init() to another
clk_ops structure for use by the display clks on sc7180 to minimize the
impact of that commit on other qcom SoCs that can't handle the parking
part.

Fixes: 01a0a6cc8cfd ("clk: qcom: Park shared RCGs upon registration")
Cc: Konrad Dybcio <konradybcio@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>
Cc: Taniya Das <quic_tdas@quicinc.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>
Reported-by: Amit Pundir <amit.pundir@linaro.org>
Closes: https://lore.kernel.org/CAMi1Hd1KQBE4kKUdAn8E5FV+BiKzuv+8FoyWQrrTHPDoYTuhgA@mail.gmail.com
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/clk/qcom/clk-rcg.h       |  1 +
 drivers/clk/qcom/clk-rcg2.c      | 36 +++++++++++++++++++++++++++++---
 drivers/clk/qcom/dispcc-sc7180.c |  8 +++----
 3 files changed, 38 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/qcom/clk-rcg.h b/drivers/clk/qcom/clk-rcg.h
index d7414361e432..5f479a29d969 100644
--- a/drivers/clk/qcom/clk-rcg.h
+++ b/drivers/clk/qcom/clk-rcg.h
@@ -198,6 +198,7 @@ extern const struct clk_ops clk_byte2_ops;
 extern const struct clk_ops clk_pixel_ops;
 extern const struct clk_ops clk_gfx3d_ops;
 extern const struct clk_ops clk_rcg2_shared_ops;
+extern const struct clk_ops clk_rcg2_shared_init_park_ops;
 extern const struct clk_ops clk_dp_ops;
 
 struct clk_rcg_dfs_data {
diff --git a/drivers/clk/qcom/clk-rcg2.c b/drivers/clk/qcom/clk-rcg2.c
index 30b19bd39d08..5f0b729d7115 100644
--- a/drivers/clk/qcom/clk-rcg2.c
+++ b/drivers/clk/qcom/clk-rcg2.c
@@ -1305,6 +1305,31 @@ clk_rcg2_shared_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
 }
 
 static int clk_rcg2_shared_init(struct clk_hw *hw)
+{
+	struct clk_rcg2 *rcg = to_clk_rcg2(hw);
+
+	/*
+	 * Cache the cfg so that the parent is properly mapped at registration.
+	 */
+	regmap_read(rcg->clkr.regmap, rcg->cmd_rcgr + CFG_REG, &rcg->parked_cfg);
+
+	return 0;
+}
+
+const struct clk_ops clk_rcg2_shared_ops = {
+	.init = clk_rcg2_shared_init,
+	.enable = clk_rcg2_shared_enable,
+	.disable = clk_rcg2_shared_disable,
+	.get_parent = clk_rcg2_shared_get_parent,
+	.set_parent = clk_rcg2_shared_set_parent,
+	.recalc_rate = clk_rcg2_shared_recalc_rate,
+	.determine_rate = clk_rcg2_determine_rate,
+	.set_rate = clk_rcg2_shared_set_rate,
+	.set_rate_and_parent = clk_rcg2_shared_set_rate_and_parent,
+};
+EXPORT_SYMBOL_GPL(clk_rcg2_shared_ops);
+
+static int clk_rcg2_shared_init_park(struct clk_hw *hw)
 {
 	/*
 	 * This does a few things:
@@ -1335,8 +1360,13 @@ static int clk_rcg2_shared_init(struct clk_hw *hw)
 	return 0;
 }
 
-const struct clk_ops clk_rcg2_shared_ops = {
-	.init = clk_rcg2_shared_init,
+/*
+ * Like clk_rcg2_shared_ops but also park the clk at init to avoid the parent
+ * from being shutdown, getting the clk stuck when it is turned on
+ * automatically by the GDSC.
+ */
+const struct clk_ops clk_rcg2_shared_init_park_ops = {
+	.init = clk_rcg2_shared_init_park,
 	.enable = clk_rcg2_shared_enable,
 	.disable = clk_rcg2_shared_disable,
 	.get_parent = clk_rcg2_shared_get_parent,
@@ -1346,7 +1376,7 @@ const struct clk_ops clk_rcg2_shared_ops = {
 	.set_rate = clk_rcg2_shared_set_rate,
 	.set_rate_and_parent = clk_rcg2_shared_set_rate_and_parent,
 };
-EXPORT_SYMBOL_GPL(clk_rcg2_shared_ops);
+EXPORT_SYMBOL_GPL(clk_rcg2_shared_init_park_ops);
 
 /* Common APIs to be used for DFS based RCGR */
 static void clk_rcg2_dfs_populate_freq(struct clk_hw *hw, unsigned int l,
diff --git a/drivers/clk/qcom/dispcc-sc7180.c b/drivers/clk/qcom/dispcc-sc7180.c
index 4710247be530..068af819f23e 100644
--- a/drivers/clk/qcom/dispcc-sc7180.c
+++ b/drivers/clk/qcom/dispcc-sc7180.c
@@ -154,7 +154,7 @@ static struct clk_rcg2 disp_cc_mdss_ahb_clk_src = {
 		.parent_data = disp_cc_parent_data_4,
 		.num_parents = ARRAY_SIZE(disp_cc_parent_data_4),
 		.flags = CLK_SET_RATE_PARENT,
-		.ops = &clk_rcg2_shared_ops,
+		.ops = &clk_rcg2_shared_init_park_ops,
 	},
 };
 
@@ -263,7 +263,7 @@ static struct clk_rcg2 disp_cc_mdss_mdp_clk_src = {
 		.name = "disp_cc_mdss_mdp_clk_src",
 		.parent_data = disp_cc_parent_data_3,
 		.num_parents = ARRAY_SIZE(disp_cc_parent_data_3),
-		.ops = &clk_rcg2_shared_ops,
+		.ops = &clk_rcg2_shared_init_park_ops,
 	},
 };
 
@@ -291,7 +291,7 @@ static struct clk_rcg2 disp_cc_mdss_rot_clk_src = {
 		.name = "disp_cc_mdss_rot_clk_src",
 		.parent_data = disp_cc_parent_data_3,
 		.num_parents = ARRAY_SIZE(disp_cc_parent_data_3),
-		.ops = &clk_rcg2_shared_ops,
+		.ops = &clk_rcg2_shared_init_park_ops,
 	},
 };
 
@@ -305,7 +305,7 @@ static struct clk_rcg2 disp_cc_mdss_vsync_clk_src = {
 		.name = "disp_cc_mdss_vsync_clk_src",
 		.parent_data = disp_cc_parent_data_0,
 		.num_parents = ARRAY_SIZE(disp_cc_parent_data_0),
-		.ops = &clk_rcg2_shared_ops,
+		.ops = &clk_rcg2_shared_init_park_ops,
 	},
 };
 
-- 
https://chromeos.dev


