Return-Path: <linux-kernel+bounces-224815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D9B6F912728
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 16:02:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F353B25CD2
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 14:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 117BE11182;
	Fri, 21 Jun 2024 14:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EC5yeuEE"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B603412E5E
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 14:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718978508; cv=none; b=Jy9PBtA1OPTz3oX4l46J5qfK1b0oVkXKF3Oevi1lUeEu8uNFiv/Pfu67JIp877RLYv0PoM9b213ogiX8RHCfYZTOlu8oWkR1WfqUoJs5tgWqCyI5ag4WZ7X1AoJGz2seYgbmJ1i/n4bdi+fMPSN0BgTN7+D1AhSgNWfTLibL0VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718978508; c=relaxed/simple;
	bh=s29/37KKHt3PZEwZnsIXFrVPh+olGHQ9l5FpzQHfmHw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Y07eUcxYr9fXpFZWUSdERveMtt+bWZvLuDCIKGBfgOc5Xbczgvl7ERlSkYFRjAJO6ug8/OM121ymDYgGZdsFj2H7cK0CpMW7HqafQzxWAcGCR2uQBHSy6cReJAJbtCaVmlZ5f9bqpDFrsPtPm9cH2mUvAsB8Fb89RvAPYejzSPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EC5yeuEE; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-36279cf6414so1620328f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 07:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718978505; x=1719583305; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VTmCmBVw5TK18hnTViwPxa5USZ4/k7Zp22q2p7WUivg=;
        b=EC5yeuEED0zCLAT0OiirYaGoGFhJEws9ShPOkQsKgObdNmUb4ZHtHGStzETBrN0OzM
         MdI91x5ktx0JOEP+Ud0fxQ3eZ9gyolx3jkaLID0dH+tyLSNDghSRd8i/cQG8ZL7JZ3Xp
         nrjVAgcASZJEX/Lvd/iPgN0Tmb2jxjnBvmzYCXS9ovetMt0C5+576wyBSZiRVAgwhfGF
         xLyBPfCxtgay0qbEuc8FRq1kPqVx3Wv58WNo3LhVh0keyepwUpLTnhS7q5PF3lV/6415
         6aEWOLqGorDPSwcoL5BaREKwq1al5PQGw+hZu8Ms/kvMVhTNcxpdh9nwo0I6eizG3366
         EPcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718978505; x=1719583305;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VTmCmBVw5TK18hnTViwPxa5USZ4/k7Zp22q2p7WUivg=;
        b=nVNLOqs5UxojPfzLZdFinC0agH9HXhAcWjv+5+5odmMIivszOFHqd7UU7/pokFiFK/
         VHUVaPR7ZoTBwYlRy+NsTdhbiGBHqdzauMCHusRNTl9EKD+eQVaEN8hq25pZLKyAjrmz
         xOgVIQxRvJd4eHGoPyuVgX6JUwhYfBKXYD4n+MOZSQSDvUSylsvmRhuLwflLq1QLuNlA
         GHnmIYUT1NVL2FzEX2ImdXV6KawU+HT0en8Pbq7RWtzcaDMTYS+2dLUba8C1nmsexvyN
         +mv9tTCvDqqWd685rl5wOgADkR0kyrKGPZ/e1Gq8tnK5gB7+12kPVruq4vS+dS//8ZtD
         QDKg==
X-Forwarded-Encrypted: i=1; AJvYcCWk33v2T5Bn2ntTxluZIm+wya1t7Rcj5r+IU32aTfgJ8jjOfIq/3q+TKsfUENs6Wz2cs65UpurQU0orPGx4O2K9+3nxe0VIOHEu4d/i
X-Gm-Message-State: AOJu0Yxv1H2gsbRrJEmJcpTdlF7P0XkrBrYxnia0k+gPT23xFSo/fEYu
	9BsdtygE4FAuRVqHcDHoPAjvJ2MKonIRQQ++Fk4Bm1af2XTaYufFNzZn/RGK/DA=
X-Google-Smtp-Source: AGHT+IFxktwNEdIxzRgRaxMr7311ZbKCUGBy3Qbuf1UdLbqLslUUN9msZmInAMl92TDdPTiCwLSvqw==
X-Received: by 2002:a5d:55c6:0:b0:35f:3166:8d6 with SMTP id ffacd0b85a97d-363192d0074mr6882584f8f.52.1718978504494;
        Fri, 21 Jun 2024 07:01:44 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-366383f6722sm1847342f8f.24.2024.06.21.07.01.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 07:01:43 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Fri, 21 Jun 2024 16:01:15 +0200
Subject: [PATCH 2/5] clk: qcom: dispcc-sm8650: use correct clk ops for
 dptx1_aux_clk_src
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240621-topic-sm8650-upstream-fix-dispcc-v1-2-7b297dd9fcc1@linaro.org>
References: <20240621-topic-sm8650-upstream-fix-dispcc-v1-0-7b297dd9fcc1@linaro.org>
In-Reply-To: <20240621-topic-sm8650-upstream-fix-dispcc-v1-0-7b297dd9fcc1@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Taniya Das <quic_tdas@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=836;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=s29/37KKHt3PZEwZnsIXFrVPh+olGHQ9l5FpzQHfmHw=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBmdYfDx4ESgTofISPDhVJkMyU4w7Sks9rcsq7u4Z1A
 BEpXkI6JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZnWHwwAKCRB33NvayMhJ0bMvD/
 4pwokQdsAV24Bn3hk2mghSfM8Rr5qBzdvPGNZBEUtbmyxB89MReRbLkuAm6A3Ay5jLptC/+cfd4XEp
 5UrdXpIeHb77rKXamOW6SLw3/Ek0dE8gTiU51SICLBYXB+0wXKdmfQMYWNvyg3jN0qtsDXoRDrXdi5
 PjgP36Gck8YK0YTCYWIAxvQ6CVqZz8O7RM8bMCuPhSBPQD9Zttd98OjRUL5SzZ70TPqTLNkxcGygkL
 jkEwZWOIc40CZPJGwfZVWAYl1gicfgkfTyvfDHujClDRc1/aIv3Lo28ugLRfh28jgYQH1LmRbIqskD
 ICkOQncVdQvr7ZyOlWkJ2Bcd8llUM25us+39G3TilMtH43bIlYcxWrtwzD56k9QvBQmU3BC3knG/Ec
 5M92rY2Ly1P8EWolMyZRJzsMHKzwalf3Rd7ldCn/ZZqumjIVlHoZGBWZB0apk/u5++vrLFhIo1J0W+
 fbkvPOXM3stI9EULzwihoplgFQVQnB0UVPM7aUmnHVp5IhsBYl/nGxvlj+o2yow1Nhbym0w4vCb2Ev
 iOYZRj/XXJOO/RGCA9iXFyoWJ8cTmIaRr1jqMoTX0pZp1T4AIDhpE34ou4esRgZozC11sko7wiGIZz
 TO583s770P5wlEgG7lRF4fB3c+lKbRzalUA8384W1Q/dC1mCDEZqnzpm/Sbg==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Use the same clk clocks ops as the dptx0_aux_clk_src, dptx2_aux_clk_src
and dptx3_aux_clk_src.

Fixes: 9e939f008338 ("clk: qcom: add the SM8650 Display Clock Controller driver")
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/clk/qcom/dispcc-sm8650.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/dispcc-sm8650.c b/drivers/clk/qcom/dispcc-sm8650.c
index 31c82f791b44..70944b7128e2 100644
--- a/drivers/clk/qcom/dispcc-sm8650.c
+++ b/drivers/clk/qcom/dispcc-sm8650.c
@@ -398,7 +398,7 @@ static struct clk_rcg2 disp_cc_mdss_dptx1_aux_clk_src = {
 		.parent_data = disp_cc_parent_data_0,
 		.num_parents = ARRAY_SIZE(disp_cc_parent_data_0),
 		.flags = CLK_SET_RATE_PARENT,
-		.ops = &clk_dp_ops,
+		.ops = &clk_rcg2_shared_ops,
 	},
 };
 

-- 
2.34.1


