Return-Path: <linux-kernel+bounces-408182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7062C9C7B84
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 19:47:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33DCD28967C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 18:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA55A20402F;
	Wed, 13 Nov 2024 18:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iTSUZEO+"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E960C201113;
	Wed, 13 Nov 2024 18:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731523621; cv=none; b=Y7UPKNvCG+h2LDdLZa0Ntx2r70N6SvfjbpVzPkN/tcQuqacsuYJBOy8TnJ7Q7Yg8QbANMRbL8M1EsscTMByaxYzMOVFD1acQFcGsIhXx0mm/Z3XefkAGpHLOk2HYWgcIXQSfY3Sz6UGzkPdfLeomlNKHkOsDaRekSd9bcytIoWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731523621; c=relaxed/simple;
	bh=XU9d3rKo9WSucMjqxcPq+qWWtgplPMCrxxBOfEENDU0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=daoiZDLD5ny+ojOB934kImtUolFqJ0w9BhQWfNQ7Wi9kEs5mpRGwTKqys0uyEPNjiteC3TpRUZ+91bxTTSd6ZGRt8P+NgfNGPTM6tAAvjcJ0CplfPY6SGLzXUe8qkaLNhW/0woed+WvyNfL/mGvXRi22BuPQwbjYsNLSBquSqzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iTSUZEO+; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-20cbcd71012so84946265ad.3;
        Wed, 13 Nov 2024 10:46:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731523619; x=1732128419; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=P33VoikjBm5duNkx8xaeWrHYF0P7DMXAt94tpC31J2w=;
        b=iTSUZEO+dFygJOo9EhXc5n5rJQbJBPkmCA/i0Ezyommu42NNnn9UmtcofYAEiR0nwH
         2CqsZHNO/NsIMNprMESalvTBh+TNKHoZEnbWI34y+bByQibAaJRqiSce1iYYSO7xxiCc
         DdikANeVYeoNG0RSOZ0TlDo374woAiGIR+Kzm5GsFRLD6r1ATyQkNraytDIEPRVZoZPJ
         TUmVrKgjp+EhswHcxMXmUL7OKmHthlaVLMM3sUr+oyp8JkoVUTKzwvjz1Scfw7k8Cq+Z
         eyGaSSVZKAgboXg10Wp9dQSwl35ZeDGDj2DBeO6g/9GiJ05p/HxEICsxiXBcQ2iMeIQY
         ni6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731523619; x=1732128419;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P33VoikjBm5duNkx8xaeWrHYF0P7DMXAt94tpC31J2w=;
        b=E9gfDx3daOZ3YDm53rjh8lZXIfa8og9Npop/2Kh2krGrWQp+VZSyVg3rF2JUzrA9wx
         MRqdpFSQ0lsxC1POdDvaxpr1HeOUtalRCb6qMqkdRRoQuDfq8e64+DqZhMuX7RQ1MAJB
         ImJQzpjTrrCmFu/2BnGjYgGeyKF/PDgJ4djRHw8T2dTM0ROrVFptYqx/9mHmSxnRcCmQ
         2BvlySxAbwI47t56JOWcoVRJhfZiqO94bWZagOJSJU/TbKEB7N6FxFz1qpPyTke6nmrQ
         TE+Dm241jj+KS/t7GI7Ha92wuy1sPURwhZjrcckSip99NMG+ib/ri8aSVRmobDdkX2qc
         xC+g==
X-Forwarded-Encrypted: i=1; AJvYcCVLdYGnw9xmWtXLdvHeA+JcFYGWuxxhv956eMPLhYVrMq1Yg7fp2YqDQMmCLVXX1tdWEqOiZDuYA/djBTQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFwrYtxakD4dqarm6E0vTUIU/BQnC/ver2eLWr/wdAOvV++yIb
	LE/xGpIyKEKrGHBBOxe1fymRQBECbwRO2xRS5FS9oREECARPzUCQ
X-Google-Smtp-Source: AGHT+IHESQD1jBpzjbnA/pf42bGNBuRxJp/9iSWTwNWV8tGcuqkW41O0ErYSq1usag76kbEloGDkIQ==
X-Received: by 2002:a17:902:e750:b0:20b:b238:9d02 with SMTP id d9443c01a7336-2118354cf5dmr297936795ad.33.1731523619145;
        Wed, 13 Nov 2024 10:46:59 -0800 (PST)
Received: from localhost ([38.141.211.103])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177dc7d1csm114256955ad.51.2024.11.13.10.46.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 10:46:58 -0800 (PST)
From: Ragavendra <ragavendra.bn@gmail.com>
To: mturquette@baylibre.com,
	sboyd@kernel.org,
	unicorn_wang@outlook.com,
	inochiama@outlook.com
Cc: linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ragavendra <ragavendra.bn@gmail.com>
Subject: [PATCH] clk:sophgo: Remove uninitialized variable for CV1800 PLL
Date: Wed, 13 Nov 2024 10:46:17 -0800
Message-ID: <20241113184617.3745423-1-ragavendra.bn@gmail.com>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Updating the detected value to 0 in the ipll_find_rate and removing it
from the method parameters as it does not depend on external input.
Updating the calls to ipll_find_rate as well and removing the u32 val
variable from ipll_determine_rate.

Fixes: 80fd61ec4612 ("clk: sophgo: Add clock support for CV1800 SoC")
Signed-off-by: Ragavendra Nagraj <ragavendra.bn@gmail.com>
---
 drivers/clk/sophgo/clk-cv18xx-pll.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/sophgo/clk-cv18xx-pll.c b/drivers/clk/sophgo/clk-cv18xx-pll.c
index 29e24098bf5f..350195d4ac46 100644
--- a/drivers/clk/sophgo/clk-cv18xx-pll.c
+++ b/drivers/clk/sophgo/clk-cv18xx-pll.c
@@ -45,14 +45,13 @@ static unsigned long ipll_recalc_rate(struct clk_hw *hw,
 }
 
 static int ipll_find_rate(const struct cv1800_clk_pll_limit *limit,
-			  unsigned long prate, unsigned long *rate,
-			  u32 *value)
+			  unsigned long prate, unsigned long *rate)
 {
 	unsigned long best_rate = 0;
 	unsigned long trate = *rate;
 	unsigned long pre_div_sel = 0, div_sel = 0, post_div_sel = 0;
 	unsigned long pre, div, post;
-	u32 detected = *value;
+	u32 detected = 0;
 	unsigned long tmp;
 
 	for_each_pll_limit_range(pre, &limit->pre_div) {
@@ -77,7 +76,6 @@ static int ipll_find_rate(const struct cv1800_clk_pll_limit *limit,
 		detected = PLL_SET_PRE_DIV_SEL(detected, pre_div_sel);
 		detected = PLL_SET_POST_DIV_SEL(detected, post_div_sel);
 		detected = PLL_SET_DIV_SEL(detected, div_sel);
-		*value = detected;
 		*rate = best_rate;
 		return 0;
 	}
@@ -87,11 +85,10 @@ static int ipll_find_rate(const struct cv1800_clk_pll_limit *limit,
 
 static int ipll_determine_rate(struct clk_hw *hw, struct clk_rate_request *req)
 {
-	u32 val;
 	struct cv1800_clk_pll *pll = hw_to_cv1800_clk_pll(hw);
 
 	return ipll_find_rate(pll->pll_limit, req->best_parent_rate,
-			      &req->rate, &val);
+			      &req->rate);
 }
 
 static void pll_get_mode_ctrl(unsigned long div_sel,
@@ -134,7 +131,7 @@ static int ipll_set_rate(struct clk_hw *hw, unsigned long rate,
 	unsigned long flags;
 	struct cv1800_clk_pll *pll = hw_to_cv1800_clk_pll(hw);
 
-	ipll_find_rate(pll->pll_limit, parent_rate, &rate, &detected);
+	ipll_find_rate(pll->pll_limit, parent_rate, &rate);
 	pll_get_mode_ctrl(PLL_GET_DIV_SEL(detected),
 			  ipll_check_mode_ctrl_restrict,
 			  pll->pll_limit, &detected);
-- 
2.46.1


