Return-Path: <linux-kernel+bounces-293050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D0079578B8
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 01:36:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 037A128486F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 23:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 363DD1E3CB8;
	Mon, 19 Aug 2024 23:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Pb+qshuP"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60651E211A
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 23:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724110595; cv=none; b=tQK+qdw48mmENdLIBYqr6yzK1e32shg5jpXFlN9w1EjH/AitH3PvOZpfhyLDTwdLqymV6GK6oSpN4S10V+A8sA0G5OT0xNL2gZf/2kPniasVdHk3Lgy2q2ZC7/xF6Nzcjcti1Fq8If0WngyGSKztYW+n94jgnpaVANkfnAk+TEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724110595; c=relaxed/simple;
	bh=11LWC1dHsw1h3mwOO/q+bhPVSG1jtOalR/V6EhebHss=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ugwkafv70zRa1oYmpaFfH+GkuWh/FtH6TsmY6lt8pQmYyfWVFFXEIqMtzYGDv8BGcFlhQQOSzyAKbO5DyNrdFtilMTxBVakUrc/hgrfvOal2jQzn9Ck5zGcGtH+GYNseBUYgeVWICHntBp7PoQa4gie9SPcwXgGa315IGcSszp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Pb+qshuP; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-202318c4f45so19620045ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 16:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1724110593; x=1724715393; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c9Cd04T134NyakvqbnePNRvSvtAZOKVt3h8rY/EORRs=;
        b=Pb+qshuPZtui6ns+HBWeSRvEjQaKKuY/hLWAgFkQXZ9idS3NvZCn0EPlQN76VMS3du
         aizhQmcUAP7Vh87fA0JURODMrwuRX+OUT1ufgjrLI0RHqpBhI5Vmdfh9+KbV6r6Ldpn8
         IlkO7pwsaqwJTRQjcEBonm3BGp+Vslo42C3Lo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724110593; x=1724715393;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c9Cd04T134NyakvqbnePNRvSvtAZOKVt3h8rY/EORRs=;
        b=JOfvIxZ+xVC/YTBDOaiq3U8vdpi6FHTI+UIHrP/Riam8wB0mIwLDA5Oc+hSj4RLZGE
         U/qw2eh7zHyZRxRcwLfJQIsbD4C0itoeT8toFCmWsAnB4jkOn6wnVjcyFNgUCRIHR8Ry
         yVo01MKg6Zype8eBKkgoXPdiwhI/bHhhNkUk93exQKr95UpqjSXjAVIR3uiry8YyJPrb
         wv4fsnJ9xjN+XbYFSvtg6mq+fdC2BgCPlzRJ4p//oh6D4qQHkO38MAnZNesYycf+0lxB
         PKHrgxEM8+FapjTGSLHmQRBvoCf2nDjt2kMMVhQZ+Lxulp+OpewLZ2IOeeMuB1h508eo
         wLhA==
X-Gm-Message-State: AOJu0YypJnKg5fxI2Bo4HFfUsd2Dr86RZoa88KwA7EqCjTYlrnf82B7s
	haqh8q4k4X7vBNY/6EU64YACl0Dgv3Bfee6PQnXz4G+GT1XGQiV84PuJGjiHs1tfr+X4VU2t+k8
	=
X-Google-Smtp-Source: AGHT+IHMdQuQYTmr1VZjFq64pkXwFedtdel2DhVJEBi38KoF3VM1xbdsltPsvQqi4APbbL4RALu4+w==
X-Received: by 2002:a17:903:2307:b0:1fd:a5a2:5838 with SMTP id d9443c01a7336-20203e5518fmr187693085ad.6.1724110592977;
        Mon, 19 Aug 2024 16:36:32 -0700 (PDT)
Received: from localhost (210.73.125.34.bc.googleusercontent.com. [34.125.73.210])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-201f0302e84sm67507995ad.32.2024.08.19.16.36.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Aug 2024 16:36:32 -0700 (PDT)
From: Stephen Boyd <swboyd@chromium.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	patches@lists.linux.dev,
	linux-clk@vger.kernel.org,
	Konrad Dybcio <konradybcio@kernel.org>,
	Taniya Das <quic_tdas@quicinc.com>,
	Amit Pundir <amit.pundir@linaro.org>
Subject: [PATCH 2/2] clk: qcom: gcc-sm8550: Don't park the USB RCG at registration time
Date: Mon, 19 Aug 2024 16:36:27 -0700
Message-ID: <20240819233628.2074654-3-swboyd@chromium.org>
X-Mailer: git-send-email 2.46.0.184.g6999bdac58-goog
In-Reply-To: <20240819233628.2074654-1-swboyd@chromium.org>
References: <20240819233628.2074654-1-swboyd@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Amit Pundir reports that audio and USB-C host mode stops working if the
gcc_usb30_prim_master_clk_src clk is registered and
clk_rcg2_shared_init() parks it on XO. Skip parking this clk at
registration time to fix those issues.

Partially revert commit 01a0a6cc8cfd ("clk: qcom: Park shared RCGs upon
registration") by skipping the parking bit for this clk, but keep the
part where we cache the config register. That's still necessary to
figure out the true parent of the clk at registration time.

Fixes: 01a0a6cc8cfd ("clk: qcom: Park shared RCGs upon registration")
Fixes: 929c75d57566 ("clk: qcom: gcc-sm8550: Mark RCGs shared where applicable")
Cc: Konrad Dybcio <konradybcio@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>
Cc: Taniya Das <quic_tdas@quicinc.com>
Reported-by: Amit Pundir <amit.pundir@linaro.org>
Closes: https://lore.kernel.org/CAMi1Hd1KQBE4kKUdAn8E5FV+BiKzuv+8FoyWQrrTHPDoYTuhgA@mail.gmail.com
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/clk/qcom/clk-rcg.h    |  1 +
 drivers/clk/qcom/clk-rcg2.c   | 30 ++++++++++++++++++++++++++++++
 drivers/clk/qcom/gcc-sm8550.c |  2 +-
 3 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/clk-rcg.h b/drivers/clk/qcom/clk-rcg.h
index d7414361e432..8e0f3372dc7a 100644
--- a/drivers/clk/qcom/clk-rcg.h
+++ b/drivers/clk/qcom/clk-rcg.h
@@ -198,6 +198,7 @@ extern const struct clk_ops clk_byte2_ops;
 extern const struct clk_ops clk_pixel_ops;
 extern const struct clk_ops clk_gfx3d_ops;
 extern const struct clk_ops clk_rcg2_shared_ops;
+extern const struct clk_ops clk_rcg2_shared_no_init_park_ops;
 extern const struct clk_ops clk_dp_ops;
 
 struct clk_rcg_dfs_data {
diff --git a/drivers/clk/qcom/clk-rcg2.c b/drivers/clk/qcom/clk-rcg2.c
index 30b19bd39d08..bf26c5448f00 100644
--- a/drivers/clk/qcom/clk-rcg2.c
+++ b/drivers/clk/qcom/clk-rcg2.c
@@ -1348,6 +1348,36 @@ const struct clk_ops clk_rcg2_shared_ops = {
 };
 EXPORT_SYMBOL_GPL(clk_rcg2_shared_ops);
 
+static int clk_rcg2_shared_no_init_park(struct clk_hw *hw)
+{
+	struct clk_rcg2 *rcg = to_clk_rcg2(hw);
+
+	/*
+	 * Read the config register so that the parent is properly mapped at
+	 * registration time.
+	 */
+	regmap_read(rcg->clkr.regmap, rcg->cmd_rcgr + CFG_REG, &rcg->parked_cfg);
+
+	return 0;
+}
+
+/*
+ * Like clk_rcg2_shared_ops but skip the init so that the clk frequency is left
+ * unchanged at registration time.
+ */
+const struct clk_ops clk_rcg2_shared_no_init_park_ops = {
+	.init = clk_rcg2_shared_no_init_park,
+	.enable = clk_rcg2_shared_enable,
+	.disable = clk_rcg2_shared_disable,
+	.get_parent = clk_rcg2_shared_get_parent,
+	.set_parent = clk_rcg2_shared_set_parent,
+	.recalc_rate = clk_rcg2_shared_recalc_rate,
+	.determine_rate = clk_rcg2_determine_rate,
+	.set_rate = clk_rcg2_shared_set_rate,
+	.set_rate_and_parent = clk_rcg2_shared_set_rate_and_parent,
+};
+EXPORT_SYMBOL_GPL(clk_rcg2_shared_no_init_park_ops);
+
 /* Common APIs to be used for DFS based RCGR */
 static void clk_rcg2_dfs_populate_freq(struct clk_hw *hw, unsigned int l,
 				       struct freq_tbl *f)
diff --git a/drivers/clk/qcom/gcc-sm8550.c b/drivers/clk/qcom/gcc-sm8550.c
index 0244a05866b8..5abaeddd6afc 100644
--- a/drivers/clk/qcom/gcc-sm8550.c
+++ b/drivers/clk/qcom/gcc-sm8550.c
@@ -1159,7 +1159,7 @@ static struct clk_rcg2 gcc_usb30_prim_master_clk_src = {
 		.parent_data = gcc_parent_data_0,
 		.num_parents = ARRAY_SIZE(gcc_parent_data_0),
 		.flags = CLK_SET_RATE_PARENT,
-		.ops = &clk_rcg2_shared_ops,
+		.ops = &clk_rcg2_shared_no_init_park_ops,
 	},
 };
 
-- 
https://chromeos.dev


