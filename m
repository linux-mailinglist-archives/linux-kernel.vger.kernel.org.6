Return-Path: <linux-kernel+bounces-224816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A07BD91272D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 16:02:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B76BF1C23A41
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 14:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE1A211CA0;
	Fri, 21 Jun 2024 14:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eM65aqwS"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F82618C19
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 14:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718978509; cv=none; b=dTycfXIUhej1HvRKQ7ad1tUiQNN2qnWFzPi/GdVO+wf1KhCh92L0zbX8BMvVmDpcL9UX8EO6YIZ3acafrrwcErHs30WMuUkqdtoLLAEyCQ1WiYkpj9vhwID7gj0JvFoS4oiRHb9rCdjPeJIRxR2p4pz+i/QFaiKWj65m0U8hLBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718978509; c=relaxed/simple;
	bh=ZBPKe0HHy+NyoafIzdK5mOmvrNkqjTbzbqbuR1ZiAVA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CBFQ+6eh1Rfw4/Jqa7VPTQLL2Xqd5rLcLHH7wEV8AVqnGVuBK/cHTWZEbWXHDl8NRSmcpNimvmWU6fID11v7LoQN0fTKS2yHpu6LHytHNypyA0EBpqWntOeebhMLMfxCPBbjIgu0xteoMAYMkcSOCnGC+FcYsLKF3lIqaGvTU30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eM65aqwS; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4218180a122so15250555e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 07:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718978506; x=1719583306; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o5+sTt6uiJKalIlmDHjnKyJpvfmOgCNjSbZLNNkLsCU=;
        b=eM65aqwSZRHDhCgrZ8DWpaxLJ4SIoBYG2JPKbaQ3UpCytScI2raYwIaFobleuHeUaU
         itGaCzX+tyR0VlygI4oKl1Sm7y/vRxoPllPC+x7V1rnpFq3yfjeDquodKiLAVTGmRpMJ
         He/iSb2gVa5fbnORXQOLapWjYwaaik4OxefC00Yp2/dfVCf9huOmYe7r/CD1P6CFNvLy
         POe8nZ4ow+ff4+PBZRHHSBgUN3wqSdS8qHXxos0DGIjCfgZFRvYV8SMNPbboy45N3URX
         bcjFwBCBUQgznx6nwN1DFRUBnH9m+FW7GcEEONzqyS2Hs+3h/z59/eYW9xv8cTRVleel
         1l2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718978506; x=1719583306;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o5+sTt6uiJKalIlmDHjnKyJpvfmOgCNjSbZLNNkLsCU=;
        b=BA9Wk/0sURwOrwBTAl2XehG/WVLWJ3MxrcR2/Z51jvTKa/YT2AUpJn7P183WWDS8UP
         JVEXZwSyMJy/0h3xk+hstzCIC3c7Jgc92CsK+3UYw+cBTqwia7RxwzM6vtAFMjeMNpap
         kAwAChkm6kj8yU/7j/XiwB7YvegentMWj6lPFOJi/KeXyIYZDQB5+7KK556o1U01qtWN
         A2mGx/eQIbe70wWy0c0RnMSNfHvQyQJG0JESTRxqXtoqyIUMK++pmZIWRfCdkXU97Ziv
         1qdJo/rSsX12ZqtFnWVx+F1B/yVhoCta5e5c7SR38oJVaAeeKMCV+Z2IEQVu4yQwx7DE
         Vipw==
X-Forwarded-Encrypted: i=1; AJvYcCXztaS7DLy/49diYtDbvTimdWTxcJDLkppfJjd/NFBrVeUx5wEIjWwB4yie4fMrK8jcGYjMjrMd4FCp1Ay2/eg3p4LvWR5zRPLUFSZp
X-Gm-Message-State: AOJu0YzwQE2+ieH5mqelPznWjodWFOVfMtCW0qIjCZXNDnGdX4Q9p9TA
	6o/MLtNnE/z6+jBjOAov5KZ5xXmT7Ha3GZraxoQpvaFlFrplyYSsY91HHVAo2aE=
X-Google-Smtp-Source: AGHT+IFRf4YsT1LA7JumYO+RE0NnDI449Jn1lv64bJfe1l8pnL0UTsbQHKu1g5tW7vg6O7EPoOJvgA==
X-Received: by 2002:a05:600c:1615:b0:420:2cbe:7efd with SMTP id 5b1f17b1804b1-42475298bd5mr70005875e9.31.1718978505587;
        Fri, 21 Jun 2024 07:01:45 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-366383f6722sm1847342f8f.24.2024.06.21.07.01.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 07:01:44 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Fri, 21 Jun 2024 16:01:16 +0200
Subject: [PATCH 3/5] clk: qcom: dispcc-sm8650: drop TCXO from table when
 using rcg2_shared_ops
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240621-topic-sm8650-upstream-fix-dispcc-v1-3-7b297dd9fcc1@linaro.org>
References: <20240621-topic-sm8650-upstream-fix-dispcc-v1-0-7b297dd9fcc1@linaro.org>
In-Reply-To: <20240621-topic-sm8650-upstream-fix-dispcc-v1-0-7b297dd9fcc1@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Taniya Das <quic_tdas@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1213;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=ZBPKe0HHy+NyoafIzdK5mOmvrNkqjTbzbqbuR1ZiAVA=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBmdYfEgA3rC4cjm5PQ1CVeHpk6hPGldHPUXsaYPo8b
 SH57d16JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZnWHxAAKCRB33NvayMhJ0WyMD/
 9SzxrvD4BNIm4PO11v+MDIOg8BVs84oUGJWLrIP5yTOzWNwVz8bZMVzdkpedrHaFULpN60Mg5bJ244
 jx6/vHumGEkqDghgPpB9fadZJ+p/HFESHlqTG3pjE9z+cyVuNXJGBTiU09UfZ3TdWO+qLKBpZzFlB8
 2IEKj6RCrSfPg2tagsON2LPn48i/F9yQ+bg4x0x0ltZCY5DXYFJB7b4h1FysgoJn75uJY42Wflrn1W
 8zZrwET2ACnPEW4g7ypzaDZSJDu0GHQeDC0YOLEuQmVNTejLVyPbGB4fCOSrD6Mq7v9G6Cr8zyil2h
 4OfHQnPbS9lABAWkAG9DE13G9ZohJATPgkSbPnvH9W4tv/8Rz3ETGS/ec0k7GVtGzK2m0EEC4TCwLA
 2AX7IwbWXlymvvftEF4GRWEZuG0XpWeNNOSf6rqVw1Vvm/W7ic5OtEtCP//Oyx7HCogyFMn8fJFl5Z
 hGzUddX2ybyFnOu1AlhobNIWbB6Z4+HSUrYPsXBdAnekDlTI03f74XZq1OvqZ+0ET81mOYBbVYVo9J
 m+F1Kqf7SWIMT0VBHe46sTbP0TQaUzKT03ppXBwBkGyt8B4IDo7RTAYHBILj4oxgUgLkGQaJsZYR8s
 fMwo6fJPWruhuzJvzYcmQaVVQDnXl4n6v4mm+O2jamu6Psw0f1kjHtYChKhQ==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Since those clocks are using rcg2_shared_ops to park on TCXO
instead of disable, no need to have TCXO in the frequency table.

Fixes: 9e939f008338 ("clk: qcom: add the SM8650 Display Clock Controller driver")
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/clk/qcom/dispcc-sm8650.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/clk/qcom/dispcc-sm8650.c b/drivers/clk/qcom/dispcc-sm8650.c
index 70944b7128e2..d22f61772667 100644
--- a/drivers/clk/qcom/dispcc-sm8650.c
+++ b/drivers/clk/qcom/dispcc-sm8650.c
@@ -272,7 +272,6 @@ static const struct clk_parent_data disp_cc_parent_data_9[] = {
 };
 
 static const struct freq_tbl ftbl_disp_cc_mdss_ahb_clk_src[] = {
-	F(19200000, P_BI_TCXO, 1, 0, 0),
 	F(37500000, P_DISP_CC_PLL1_OUT_MAIN, 16, 0, 0),
 	F(75000000, P_DISP_CC_PLL1_OUT_MAIN, 8, 0, 0),
 	{ }
@@ -580,7 +579,6 @@ static struct clk_rcg2 disp_cc_mdss_esc1_clk_src = {
 };
 
 static const struct freq_tbl ftbl_disp_cc_mdss_mdp_clk_src[] = {
-	F(19200000, P_BI_TCXO, 1, 0, 0),
 	F(85714286, P_DISP_CC_PLL0_OUT_MAIN, 3, 0, 0),
 	F(100000000, P_DISP_CC_PLL0_OUT_MAIN, 3, 0, 0),
 	F(150000000, P_DISP_CC_PLL0_OUT_MAIN, 3, 0, 0),

-- 
2.34.1


