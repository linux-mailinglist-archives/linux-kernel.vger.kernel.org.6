Return-Path: <linux-kernel+bounces-381977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB1D39B072D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 17:08:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B4511F23E85
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 15:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23382231CA4;
	Fri, 25 Oct 2024 15:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qc0tTq1M"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D54520D518
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 15:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729868652; cv=none; b=Zf/YM/qFWihs41BqxoGOiAf8VOC13NcyD+3J2yWd69oPCjfRVIeujQmFrDe2UGKUHDlQnSWCUUNyIXNbraDJ51kqT6fRw6ExaroPaJNFg1Rcp/Q5lU3zQ/aI9XJiIMjZbN1BZkL5o61hWWDkMsPzPN/bXG4cGNTVF5j8Ey5oP+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729868652; c=relaxed/simple;
	bh=DWgkCUleQv61cF52XKRC6NW3EAFyFKJ2O9J1+CznBwg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FeMtjBeQIgMRztIf9BTC9YUAS4LpO0s/b5CQvpL7P3nTIVv5RKO0T6/BDR9HHa9dh8YkVrobRNd7nu5f7T2Vu93LFbzEMkEmiA6sXgA3oOO2ZsugROXSXXe5NpFTHRe1w6BXwVgtwMNdBboxi/ozG7nx4CHSl4csSYEoH3Rwypk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qc0tTq1M; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-539e6c754bdso2007618e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 08:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729868647; x=1730473447; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gWbqeFeatJwTSwfIbMsvs+JYctmC6KE3I7fU3fJLjdw=;
        b=qc0tTq1MRviU+xdQeqAHPVOE8GcPhf1UcS4r5shxFh2c6fuuJDmK/MehwPIC/1LqDe
         3Ar1lC8OxM651o8WaP/34CeV2eBhD18hys/RXA1LN6r2UmJ7XqE90aFtvYyymM2xEvrc
         uAET6R9xqx8TL9WJ2U9fLLcEk6u6NZBxa/buCTbjXCiZ0R4/agocCnM2bJ/kFN647yjR
         8IZZWXpfrDU/JmT8dUqkeNDhRpzGjIEqjgygwsKXgD9dFtBj//jKnGrPqDbLE6wA+KPR
         UbD/kOLeg0qnrnToYVF5YBA/X9RnxB3RUEoV/+TsA6QXAcnaN5Frhms32p8MEVW3ni3/
         3guA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729868647; x=1730473447;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gWbqeFeatJwTSwfIbMsvs+JYctmC6KE3I7fU3fJLjdw=;
        b=o9M1JN8PTpjKGUUdrHacaIPz7PJCF8HQ53X32aT1VdQmuLLuX3BYiTJzSCCuYckwhw
         9L+4+rvBUxYIwW9+u3uazQ+GXHYkvK0BV/NPrRG82cpaxj8vrTpi156SWTLczlEvBr7T
         UtKx9bDbdFR9+kVe8J2fb3CTzsrQWHmJKD8jgveBC0xee9ANjz85aBx6+4jbZW1cPoHG
         F0xgdP3SOYmnrj/1hIpydCHmiiWzKp6XBdhqE0U0PZm3JHRpOg4JRGQbj6+O7GrtoBfI
         Oa4/bTc+NnivURicURdiFgPuI4+8hOh6d588Z7V7HxQNsWEqNy8CfUu6HhWc19d7g7PY
         a1Zw==
X-Forwarded-Encrypted: i=1; AJvYcCWuS3PI4dQYnWFyT40Rz8vV8xef1NoJ68WYPDU+ypQ9NvL5fgBS63DItjUfQvrjFwvRkAP6uvFHM8D3syQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+3jq0Sb/gGNZvmgapTc8fmRSJolAyWikLS6SEkbxF7jm0E73L
	koYEFIJ9N0bjb4YOBF7GqHV54FUo1SiocHYSqHeJO6Vf2W6/ulqUpP/E3WZmua8=
X-Google-Smtp-Source: AGHT+IG20xRS9wcyui4FcvavTpHZLmQIUWJiugqBFD4Xf0H9aeEKc1LTw3oRpMzf4b1QUJLiKJghNQ==
X-Received: by 2002:a05:6512:3a95:b0:539:fbd4:9c9a with SMTP id 2adb3069b0e04-53b1a34e141mr5644697e87.35.1729868646455;
        Fri, 25 Oct 2024 08:04:06 -0700 (PDT)
Received: from [127.0.1.1] (2001-14ba-a0c3-3a00-70b-e6fc-b322-6a1b.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:70b:e6fc:b322:6a1b])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53b2e10a915sm209542e87.12.2024.10.25.08.04.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 08:04:04 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 25 Oct 2024 18:03:40 +0300
Subject: [PATCH v3 06/11] clk: qcom: rcg2: add clk_rcg2_shared_floor_ops
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241025-sar2130p-clocks-v3-6-48f1842fd156@linaro.org>
References: <20241025-sar2130p-clocks-v3-0-48f1842fd156@linaro.org>
In-Reply-To: <20241025-sar2130p-clocks-v3-0-48f1842fd156@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Taniya Das <quic_tdas@quicinc.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3985;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=DWgkCUleQv61cF52XKRC6NW3EAFyFKJ2O9J1+CznBwg=;
 b=owEBbQKS/ZANAwAKARTbcu2+gGW4AcsmYgBnG7NU6j6OWhTgXqUEJ2/odVlWEZ2bbNI6bD6Mo
 NCPsf+iEPeJAjMEAAEKAB0WIQRdB85SOKWMgfgVe+4U23LtvoBluAUCZxuzVAAKCRAU23LtvoBl
 uL5BD/9CSCxjrjrncbvWqJOP4HwARsp+0uichVgZFd7X5GdsEv7Pm+PIr1AP9jqcIfhIRpfIxrs
 JZt3w+Myjuj7bR36sAE7Yz+Op8Rx5tBO0uG3qLDOpV05OGhfvFT+S3DcuRLoFzYB07pJv4/OYD7
 k6FYyTngtmhE2KSZzHwQbZ7qPB2UX8u7pp9NbC0Flldv5sdbB5r+o8b9HnaRBp6kJ0axiGU+4X+
 wEdphOizxRx3X31nlmxdEfJBC4PwOI3HjRtnxTJoxV2u1vok6qnaehCdo4ZiJooSN1+1nMjbiE3
 cAIV0GG8kMczqgf7yS8v8iZwXPOTm83AO6d7lUGsVdQxZYCC7/4oEuVnjjkfMsv9PMjfTaGDSdw
 +i0BmX3BAQ2kUswlPKTrqZFsOLGtWhCc2DB/MmJ1ttwzc7fEF5nITodgW9y9g1q8iUNReDM9jjl
 wStee1Q9rvz/mhrT63JTT28C3Qs21uk9jzDlue0zcYcv99p34b9D0DrIuK5L6b9/roQUGFtwrAY
 tWiNVIVU80JzJM9OSBG+0WfSx/GFToUMhJFEuhQ6r+GLrrST5E+Cojixzo3b1r8w4uALdJnWXC/
 npjjI0iEdsmGk77fH4UHFrQYz2nkKTgMGEu0wVDshkdp0tUNJ9qMxikNMKn9aSBrueCD7a2sg/m
 1U0PuXoNGqNhLrg==
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Generally SDCC clocks use clk_rcg2_floor_ops, however on SAR2130P
platform it's recommended to use rcg2_shared_ops for all Root Clock
Generators to park them instead of disabling. Implement a mix of those,
clk_rcg2_shared_floor_ops.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/clk/qcom/clk-rcg.h  |  1 +
 drivers/clk/qcom/clk-rcg2.c | 48 ++++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 44 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/qcom/clk-rcg.h b/drivers/clk/qcom/clk-rcg.h
index 8e0f3372dc7a8373d405ef38e3d5c747a6d51383..80f1f4fcd52a68d8da15e3e1405703b6ddc23421 100644
--- a/drivers/clk/qcom/clk-rcg.h
+++ b/drivers/clk/qcom/clk-rcg.h
@@ -198,6 +198,7 @@ extern const struct clk_ops clk_byte2_ops;
 extern const struct clk_ops clk_pixel_ops;
 extern const struct clk_ops clk_gfx3d_ops;
 extern const struct clk_ops clk_rcg2_shared_ops;
+extern const struct clk_ops clk_rcg2_shared_floor_ops;
 extern const struct clk_ops clk_rcg2_shared_no_init_park_ops;
 extern const struct clk_ops clk_dp_ops;
 
diff --git a/drivers/clk/qcom/clk-rcg2.c b/drivers/clk/qcom/clk-rcg2.c
index bf26c5448f006724b447bb0d9b11889d316cb6d0..bf6406f5279a4c75c0a42534c15e9884e4965c00 100644
--- a/drivers/clk/qcom/clk-rcg2.c
+++ b/drivers/clk/qcom/clk-rcg2.c
@@ -1186,15 +1186,23 @@ clk_rcg2_shared_force_enable_clear(struct clk_hw *hw, const struct freq_tbl *f)
 	return clk_rcg2_clear_force_enable(hw);
 }
 
-static int clk_rcg2_shared_set_rate(struct clk_hw *hw, unsigned long rate,
-				    unsigned long parent_rate)
+static int __clk_rcg2_shared_set_rate(struct clk_hw *hw, unsigned long rate,
+				      unsigned long parent_rate,
+				      enum freq_policy policy)
 {
 	struct clk_rcg2 *rcg = to_clk_rcg2(hw);
 	const struct freq_tbl *f;
 
-	f = qcom_find_freq(rcg->freq_tbl, rate);
-	if (!f)
+	switch (policy) {
+	case FLOOR:
+		f = qcom_find_freq_floor(rcg->freq_tbl, rate);
+		break;
+	case CEIL:
+		f = qcom_find_freq(rcg->freq_tbl, rate);
+		break;
+	default:
 		return -EINVAL;
+	}
 
 	/*
 	 * In case clock is disabled, update the M, N and D registers, cache
@@ -1207,10 +1215,28 @@ static int clk_rcg2_shared_set_rate(struct clk_hw *hw, unsigned long rate,
 	return clk_rcg2_shared_force_enable_clear(hw, f);
 }
 
+static int clk_rcg2_shared_set_rate(struct clk_hw *hw, unsigned long rate,
+				    unsigned long parent_rate)
+{
+	return __clk_rcg2_shared_set_rate(hw, rate, parent_rate, CEIL);
+}
+
 static int clk_rcg2_shared_set_rate_and_parent(struct clk_hw *hw,
 		unsigned long rate, unsigned long parent_rate, u8 index)
 {
-	return clk_rcg2_shared_set_rate(hw, rate, parent_rate);
+	return __clk_rcg2_shared_set_rate(hw, rate, parent_rate, CEIL);
+}
+
+static int clk_rcg2_shared_set_floor_rate(struct clk_hw *hw, unsigned long rate,
+					  unsigned long parent_rate)
+{
+	return __clk_rcg2_shared_set_rate(hw, rate, parent_rate, FLOOR);
+}
+
+static int clk_rcg2_shared_set_floor_rate_and_parent(struct clk_hw *hw,
+		unsigned long rate, unsigned long parent_rate, u8 index)
+{
+	return __clk_rcg2_shared_set_rate(hw, rate, parent_rate, FLOOR);
 }
 
 static int clk_rcg2_shared_enable(struct clk_hw *hw)
@@ -1348,6 +1374,18 @@ const struct clk_ops clk_rcg2_shared_ops = {
 };
 EXPORT_SYMBOL_GPL(clk_rcg2_shared_ops);
 
+const struct clk_ops clk_rcg2_shared_floor_ops = {
+	.enable = clk_rcg2_shared_enable,
+	.disable = clk_rcg2_shared_disable,
+	.get_parent = clk_rcg2_shared_get_parent,
+	.set_parent = clk_rcg2_shared_set_parent,
+	.recalc_rate = clk_rcg2_shared_recalc_rate,
+	.determine_rate = clk_rcg2_determine_floor_rate,
+	.set_rate = clk_rcg2_shared_set_floor_rate,
+	.set_rate_and_parent = clk_rcg2_shared_set_floor_rate_and_parent,
+};
+EXPORT_SYMBOL_GPL(clk_rcg2_shared_floor_ops);
+
 static int clk_rcg2_shared_no_init_park(struct clk_hw *hw)
 {
 	struct clk_rcg2 *rcg = to_clk_rcg2(hw);

-- 
2.39.5


