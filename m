Return-Path: <linux-kernel+bounces-317367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A60896DD25
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 17:05:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9EF8AB24C72
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 15:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ACC919DFB9;
	Thu,  5 Sep 2024 15:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m8yZex7D"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF0E119DFB4
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 15:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725548563; cv=none; b=aJ1fmOvlTICFEpnwWHNRVXuc25YtwDL5k9aeVnH8bSM/94Jya5zswBxjSiBwRAD6n/jFGsxOW54Z2DoDwJpYliFTnpiYqklkUbTYcWc1ztn/kezIw8zIEcnyOCRHa84BF6avsF26zUNyLyT7hvECyQVahZUXcygDVNjXQqTbYdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725548563; c=relaxed/simple;
	bh=DQiGGGdIUmOGLqMSP8S8D5US+EouETuqJzqDRM2nEEw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZRH8LMqirt9OZ/Y+SLZEcznAwaJjPuxhaIAmSr+xLO5Z5DIziiX4V5pIWUhv18Zty/q48PB27K1ZTf+olyZcryfxWYqiS9bWvS7GBo78htYQUmpS3M4MSgPyiq6H5ZTHyiGeLrIuXP2TJEDJOj2NJylxHXn3mxXCuegppM0AbLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=m8yZex7D; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-42c53379a3fso1207625e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 08:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725548560; x=1726153360; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=C7NNd/zrhBJckNNsMfazAJhrD8NLYgZbQToW3LVZTbw=;
        b=m8yZex7Dbjy6Xxu9RCV6nf5qCpPAeb+w7jLuxKfskbXYoSlBvJ0aQU8thoi/G2uKz3
         MmvUW+S6bRaQtQUpmVrwru9s4E/oN51Bv4vio2E6PXTcFu0KpO/G/ckdW9sBYjYqEv8U
         dg0XF1jQEne9QaiKWLH3aLx3rM2Otma/Athpq0qoHwPaFUxHXwrnhDvGVQOx8umyoV5x
         Fy4oxx7sM4cWUaTeKaiGUstgk3mFgMGgpwLQJN0g47q5jwMtsPTyd8Tpe6FSXZOnOtEF
         i8IXdZ51Sjx4iN3UnJJ4OWqjRby/M2j/Hc0A8EMnu4rUXStyCSM+JSxKzd90m/CMmZ7c
         iang==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725548560; x=1726153360;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C7NNd/zrhBJckNNsMfazAJhrD8NLYgZbQToW3LVZTbw=;
        b=piXHO3RwcyyQ9PatDkqR1FaqKVAJmSuYKjCJEyQfenb/dnquwfpD+m9G6X1JTtv8rZ
         FZG9dYsP6U7VZ00aCPamD2cufPyMxuVAdOgOiL/PCCtRdRnG/GGAVC0CWVla20So7k12
         ov5eAb4y4IDy0gcwlnxQTSWrupTXsM73e3wU5QrdKU8fsqrrQhYQKX/3KM62K2+iT9hc
         hQCK6dJK0WL9qFg5+Zz2tk9zG5yzkqhrO+lmvhDKRTJBzUfrgImLyYWYZIIZzbHfMX/U
         ZPLmDtAd5XbWSiiK72Sw8397Axxh+nvK6lE2vhViKQpOi8exXhWLvljav58lte2O4QN8
         Utrg==
X-Forwarded-Encrypted: i=1; AJvYcCXpaMYYbdNYVlMyPF9Xko0wl4tNXzfzY8MEGveZEiKgxUmlmqxpMhlZ0b8WwHNhDTrT0Ad6DY7/YzFxJGI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6bG0CyHyms6caFlIYuU68BJDkDwbXJgnl4E4NC9JpB7HKpgOY
	WsS9V3L0LRj1exjFUGIottC55Mihpl9fovss948crpkxatAydIcSQxdljOkQel67kcmhN8VByUS
	V
X-Google-Smtp-Source: AGHT+IHJlS5UY9DkXnqsdsszOThXDhvA3DLG7+xih+aR/w+ZrYYdsKvCAGQHHk1O73JLUcrl3hmIsg==
X-Received: by 2002:a05:600c:1554:b0:425:6962:4253 with SMTP id 5b1f17b1804b1-42bbb43d5e4mr86867955e9.4.1725548557922;
        Thu, 05 Sep 2024 08:02:37 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.82])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bbdda3958sm203212705e9.26.2024.09.05.08.02.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 08:02:37 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] clk: qcom: constify static 'struct qcom_icc_hws_data'
Date: Thu,  5 Sep 2024 17:02:35 +0200
Message-ID: <20240905150235.276345-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Drivers and core code does not modify the file-scope static 'struct
qcom_icc_hws_data', so it can be made const for code safety and
readability.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/clk/qcom/common.h      | 2 +-
 drivers/clk/qcom/gcc-ipq5332.c | 2 +-
 drivers/clk/qcom/gcc-ipq9574.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/qcom/common.h b/drivers/clk/qcom/common.h
index 7e57f8fe8ea6..7ace5d7f5836 100644
--- a/drivers/clk/qcom/common.h
+++ b/drivers/clk/qcom/common.h
@@ -35,7 +35,7 @@ struct qcom_cc_desc {
 	size_t num_gdscs;
 	struct clk_hw **clk_hws;
 	size_t num_clk_hws;
-	struct qcom_icc_hws_data *icc_hws;
+	const struct qcom_icc_hws_data *icc_hws;
 	size_t num_icc_hws;
 	unsigned int icc_first_node_id;
 };
diff --git a/drivers/clk/qcom/gcc-ipq5332.c b/drivers/clk/qcom/gcc-ipq5332.c
index 9536b2b7d07c..00c48478c887 100644
--- a/drivers/clk/qcom/gcc-ipq5332.c
+++ b/drivers/clk/qcom/gcc-ipq5332.c
@@ -3622,7 +3622,7 @@ static const struct qcom_reset_map gcc_ipq5332_resets[] = {
 
 #define IPQ_APPS_ID			5332	/* some unique value */
 
-static struct qcom_icc_hws_data icc_ipq5332_hws[] = {
+static const struct qcom_icc_hws_data icc_ipq5332_hws[] = {
 	{ MASTER_SNOC_PCIE3_1_M, SLAVE_SNOC_PCIE3_1_M, GCC_SNOC_PCIE3_1LANE_M_CLK },
 	{ MASTER_ANOC_PCIE3_1_S, SLAVE_ANOC_PCIE3_1_S, GCC_SNOC_PCIE3_1LANE_S_CLK },
 	{ MASTER_SNOC_PCIE3_2_M, SLAVE_SNOC_PCIE3_2_M, GCC_SNOC_PCIE3_2LANE_M_CLK },
diff --git a/drivers/clk/qcom/gcc-ipq9574.c b/drivers/clk/qcom/gcc-ipq9574.c
index 645109f75b46..0405a2473842 100644
--- a/drivers/clk/qcom/gcc-ipq9574.c
+++ b/drivers/clk/qcom/gcc-ipq9574.c
@@ -4384,7 +4384,7 @@ static const struct qcom_reset_map gcc_ipq9574_resets[] = {
 
 #define IPQ_APPS_ID			9574	/* some unique value */
 
-static struct qcom_icc_hws_data icc_ipq9574_hws[] = {
+static const struct qcom_icc_hws_data icc_ipq9574_hws[] = {
 	{ MASTER_ANOC_PCIE0, SLAVE_ANOC_PCIE0, GCC_ANOC_PCIE0_1LANE_M_CLK },
 	{ MASTER_SNOC_PCIE0, SLAVE_SNOC_PCIE0, GCC_SNOC_PCIE0_1LANE_S_CLK },
 	{ MASTER_ANOC_PCIE1, SLAVE_ANOC_PCIE1, GCC_ANOC_PCIE1_1LANE_M_CLK },
-- 
2.43.0


