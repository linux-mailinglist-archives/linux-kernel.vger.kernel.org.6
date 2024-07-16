Return-Path: <linux-kernel+bounces-253519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3935D93226E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 11:05:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9103283252
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 09:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA8E6197A7D;
	Tue, 16 Jul 2024 09:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eu6s9uhN"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B14195FD1
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 09:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721120733; cv=none; b=SKcrqdYLgHc9q7XJoXDVd2JZv+tlPaq5aFXczpL1PMcWRvJA8RXD4YkTQCrt6GAwK1D96rU159ktn4oLKlYGO+epdViViI2ODvzLHNU16F8c755M2pswn7IB247eMvbRLB6O+K14LCUCBKZ3eI+qfjK4bU+muCZ4nEahQANR1Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721120733; c=relaxed/simple;
	bh=9kjY/Djp/F/3OF8vSwyklelh7pho8HAr219TOgHK6QY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Dllh0jdAnmu30hJcwKWcPg5GVP7vkVZKyGWcDfzVVCHsEyaKtgpV1ZCbEr2ziSjPxhFTJlKfXbwp8QckwhJn5KaOa5AUbXoxPvGDL1Ie0LUtD8z0oDVw8rOQJYaapn00zhSv1zSZ/b3Z/HDltWuB3eRLPmN7KzDifvd7UaMiDaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eu6s9uhN; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4266fd39527so38572925e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 02:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721120730; x=1721725530; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7caggAbMV+gauV7GaQywpQKcgWZbw/RmAxo+bKntFnM=;
        b=eu6s9uhNkZT/lYvwJx3m3oTip5WCzS9OEYGh7pLJbb5tNwzv61Cjg6Oj7zWsruTi8R
         V4TjGVKGHAbacdTYSSJ4mYv3E96qu/vy8qFJ5QaglFfKkKQ7QZcwEk43A0y24u9GEIkm
         aZPRnpLPZ+Ioz50rpnB4cpP8NM6VtLWqGRfvyhz+wYm9xdfs2Ry0s1lJesN7DVCGARYq
         w+DeOBRq8gAn9ilu1uGlCzf+EELT5S+mDjzCgRkbi6DVE5fPabYM74ticzR0padf62/V
         P8ql9Q128uBfb4BQ4faNWNl5PDl2Vq4sBMgrjomEy1pYHQEpRY65tdeugigthd3W+MOi
         X9DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721120730; x=1721725530;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7caggAbMV+gauV7GaQywpQKcgWZbw/RmAxo+bKntFnM=;
        b=h6B3dPOG4A51fpXD0m1/FJu6PHf/cz4gQiTRa3n9rUe3xIEF/83DBjVFYX9mALyZQb
         IxLp97QH0s6bgVRcV7jsID+GUaZV1IfzlMlpYAX27SUKTc43+2VQWBUH1Xr/Gz1yC41o
         TpDD6Qan89y5unqNy/4ttJCohqmOyyAgURWKpa7jLF/ibdrHyck1AjvtqB5AeR2JRoCi
         vIdqbDcBH7oOd1ERxT7bgoBSjqsNw1ch/tkQg92n2dDKJ+shZDE11IPobjRK7f3VxiwC
         1jwQOtkACgoSj8RmMY0MEmRFA2o1Pb0OyyDIRJq5uu6mM0q5x6/lZb0+y/pq5dzXxbQB
         gO+g==
X-Forwarded-Encrypted: i=1; AJvYcCVK/GFc2eDukHJfQdMVdrr+M4XGmluY9eZewfYN8Agtg+0+5NaRMCsg5mR+QO5AobUfg5yHp7ARerJyYO07q5aDcuPlJuNw57fpGGzn
X-Gm-Message-State: AOJu0YzWXdwZsCGV6TC6qBhOo3mjuxo7ivYF+zUjIXIgw8b/KgcmC67t
	GF1z0SqA82IRotMVTHmOul5iEqv3NDkHl5Ki7tipJbmP3BelvHVj8aHTWYRXmPRDtYJwPOQBhDq
	2
X-Google-Smtp-Source: AGHT+IFPja/yhqh4LG3OM6hJoZIl8i83YBL6Krit+0VgtUsV1BF8rZcZB7m8GajN3C3e4cnC/xjj2A==
X-Received: by 2002:a05:600c:450a:b0:426:61f6:2e38 with SMTP id 5b1f17b1804b1-427ba72aec1mr8979775e9.35.1721120730413;
        Tue, 16 Jul 2024 02:05:30 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4279f25a962sm148687875e9.12.2024.07.16.02.05.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 02:05:30 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Tue, 16 Jul 2024 11:05:22 +0200
Subject: [PATCH v3 2/3] clk: qcom: dispcc-sm8650: add missing
 CLK_SET_RATE_PARENT flag
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240716-topic-sm8650-upstream-fix-dispcc-v3-2-5bfd56c899da@linaro.org>
References: <20240716-topic-sm8650-upstream-fix-dispcc-v3-0-5bfd56c899da@linaro.org>
In-Reply-To: <20240716-topic-sm8650-upstream-fix-dispcc-v3-0-5bfd56c899da@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Taniya Das <quic_tdas@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1123;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=9kjY/Djp/F/3OF8vSwyklelh7pho8HAr219TOgHK6QY=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBmljfWvqB9LqmuGnidpZ7kKWsaFkCu5H+9CCZ+hnbL
 5WrGGZOJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZpY31gAKCRB33NvayMhJ0Xl7D/
 9zczWFeiXrx+ez3FVQgHZJ6BOS6hDE9P6hK7qa3Fa45WsoVJbfF/PLcfTBnaiXqmbjFSecHbT/AIUG
 gOqAxTtY0akzo2wJfWzhFC9qG85E3FByhfdbAfLvAkn4nf6rV2QQP5sxuG7vtw+nZEIBaGYc89VQbU
 Nj0p7tFYNDV0k0dBOuW8za2KnG/b+YsyaZvzrDaimlIICcAVVnWjiQfmN7oIBrKvhZ0nxuz7wDV2B8
 gUa8xxL3MhjbRC8tkcDK88qcD5w+R9MPZaRkF7EUS8pkcrdLEUmErHo0IbysG2P/nsO4+8yctGpe2F
 XBEDi3TXcEL6PrXE8lsQgAUcbmWhTia5ZlJenyY3wBm+zrUSqVIJ4TO8232QmeJU50Z2YYgclX5KpO
 dW+70WN2oibbee2rlfQLgpYskHRVk20ExjP1/uPoSZ7XTa6BlNwATouZM0T3iLvdLKJ/pQHu55GB9T
 GnfYBi7suiRk29bIAtuEgdzeVBId1MKqaOsKos9Q/A9Sl+taAEHm3tHgtq8rE3a9sDl+kKZbN8O5+r
 IX4ywvYeCWTvs/XhPlcTSXzBcYQQ2TNNFdbfK84Oc0tGAqfWJqxAOlqiYuXYJc3miaUzrPRuqAEErp
 qTgIT5KTMt2CU1eOz5pAD2zcsYMYXGgXgoe7J2IYPI8aP8WVBPfS2WpKJliw==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Add the missing CLK_SET_RATE_PARENT for the byte0_div_clk_src
and byte1_div_clk_src, the clock rate should propagate to
the corresponding _clk_src.

Fixes: 9e939f008338 ("clk: qcom: add the SM8650 Display Clock Controller driver")
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/clk/qcom/dispcc-sm8650.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/qcom/dispcc-sm8650.c b/drivers/clk/qcom/dispcc-sm8650.c
index 80fe25afccf7..f38f5f43acb2 100644
--- a/drivers/clk/qcom/dispcc-sm8650.c
+++ b/drivers/clk/qcom/dispcc-sm8650.c
@@ -696,6 +696,7 @@ static struct clk_regmap_div disp_cc_mdss_byte0_div_clk_src = {
 			&disp_cc_mdss_byte0_clk_src.clkr.hw,
 		},
 		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
 		.ops = &clk_regmap_div_ops,
 	},
 };
@@ -710,6 +711,7 @@ static struct clk_regmap_div disp_cc_mdss_byte1_div_clk_src = {
 			&disp_cc_mdss_byte1_clk_src.clkr.hw,
 		},
 		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
 		.ops = &clk_regmap_div_ops,
 	},
 };

-- 
2.34.1


