Return-Path: <linux-kernel+bounces-407020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3DB89C677D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 04:00:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E0EE2839D0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 03:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C191815B992;
	Wed, 13 Nov 2024 02:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xy/wcNLc"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2BC9158DA3;
	Wed, 13 Nov 2024 02:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731466795; cv=none; b=T9G5u+X0YHLsW8NQPPxjQMyJVM7NlgPnq0e4CKNzb9ibMi5ZqLgn9eGhJbl0ZbqhUKwwBHuCPNiY+w90YJAwKjuKrmcPUVBmBeiyBHccesatpYSclvY7o2SfWnPstEOQNT8mVeTm2sazyUvnPPKKh2eI+7Cx6HL1wvcJE0F47eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731466795; c=relaxed/simple;
	bh=xD8kKRq7+4k4HcfZdKsgkctTkJdiFEAHzKDnT0OXlXM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dJ4N4KmbUE6nAqhHp3szRsZH0nkdPKOevtSgtAibrODBNwr3GNcdZlwj2js7yhKGXxO+u1QiePXJNE1HJLRXrrA9PjkRGQFvJkm3R/62IcNLNfvLm1EPEt3a2TgNrNoJs0cWXfYbfGsozzmsWpgZ+ARkArCI8gqoWsUb/LOrVZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xy/wcNLc; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-20c77459558so58309585ad.0;
        Tue, 12 Nov 2024 18:59:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731466793; x=1732071593; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=W81fYZYWxGlJy8lfHEItgZUnAzKTdEV769e8W10GZXU=;
        b=Xy/wcNLcibfuv2IwjCjCBUJ6AUvrrVd5ELmUnC7n7tmKupLJhYAKH79Fdk5M7DJHy/
         R9VtCgEKlSsJr1G6CQeA4eTNagd+ZEk0MPaKgKLuJoebM/toVcgpX0vXWX8McPDYsOKt
         LopbF3UF7nCdLpkBx67PniyvAEZsVj6+6P0Jn1hmTlWTlnwTSKhq0WLZAFt+rw6AjD0S
         N+s4M6A48SG9IOKaOOnfoYSnH1ZGWRe9f3rBeuXb+W0AFDk/NJrZyDlRPDwlhexxTy+d
         hAKwUfMg08XJ3hL7sBlcF/eHLRDWeO8f+B+95Bnr4hoJjXWQBdIdNCNQ6nEVEBR4QoEt
         Qw/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731466793; x=1732071593;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W81fYZYWxGlJy8lfHEItgZUnAzKTdEV769e8W10GZXU=;
        b=M/4vKaMDz8ecQHHeLVo7Gy51YsM/fH6AWLASt0R+s6rh8PkLsYKKcN+jqyqZL5kJfh
         IohofjXOyyuILJKQ+CTvzUiK4NlrMNMIjaLTljk/cfxotGauNHSCO0w4kdb3G2oDQFIt
         vTLa0Juxp23w1VddlfNfBT19M7oXMvdnk82/CnsqE1TIq4z0U2XDXbSq1IOaYiOa9on9
         26styv7wZaDEEBoUqYZsMF5MUu5zgShXxReJXAPZwN0/vK+LjULQvfb9r17cB9gsWH6C
         q6xGMn+Gz90EWyVViTUPDjq1WzZ//bTX9O58+AFVZrxO5FsnkG6VlTO/b5Vv4qYKKOPD
         5PJQ==
X-Forwarded-Encrypted: i=1; AJvYcCUWtYr5qv+LyRbWtWmjle+6KV2nP2BVkwiAMn17txQFcrrFhmB5Rt5zwCjDwSVGlv+hZVPdarHsXYCCvM0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyyU3VWNga1SBpALDKDvwquot9vMZdGMmUJ+Bw+HSFAsOyorIY
	Wo/urc5VDdUh7vmB9c9rYKTcyBa1es2LBTBwUhOJ9d8BQm+CLmkKYC/FXi9L
X-Google-Smtp-Source: AGHT+IHcvWsJoBJW4kkoKkI7GiNlP/hw6qumB5qQm1g4Y9BYKZ+c16xjZzE5o9wwGcAOYVCZFfmdZw==
X-Received: by 2002:a17:903:2347:b0:20b:8907:b597 with SMTP id d9443c01a7336-211ab96d0dbmr63365525ad.28.1731466792957;
        Tue, 12 Nov 2024 18:59:52 -0800 (PST)
Received: from localhost ([38.141.211.103])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177df643csm101443755ad.112.2024.11.12.18.59.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 18:59:52 -0800 (PST)
From: Ragavendra <ragavendra.bn@gmail.com>
To: mturquette@baylibre.com,
	sboyd@kernel.org,
	unicorn_wang@outlook.com,
	inochiama@outlook.com
Cc: linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ragavendra <ragavendra.bn@gmail.com>
Subject: [PATCH] clk:sophgo:clk-cv18xx-pll: Remove uninitialized u32 parameter and variable
Date: Tue, 12 Nov 2024 18:59:47 -0800
Message-ID: <20241113025947.3670504-1-ragavendra.bn@gmail.com>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Updating the detected value to 0 in the ipll_find_rate and removing it from the method parameters as it does not depend on external input. Updating the calls to ipll_find_rate as well and removing the u32 val variable from ipll_determine_rate.

Fixes: 80fd61ec4612 ("clk: sophgo: Add clock support for CV1800 SoC")
Signed-off-by: Ragavendra Nagraj <ragavendra.bn@gmail.com>
---
 drivers/clk/sophgo/clk-cv18xx-pll.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/sophgo/clk-cv18xx-pll.c b/drivers/clk/sophgo/clk-cv18xx-pll.c
index 29e24098bf5f..57981a08fd5f 100644
--- a/drivers/clk/sophgo/clk-cv18xx-pll.c
+++ b/drivers/clk/sophgo/clk-cv18xx-pll.c
@@ -44,15 +44,15 @@ static unsigned long ipll_recalc_rate(struct clk_hw *hw,
 			      PLL_GET_POST_DIV_SEL(value));
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
@@ -87,11 +87,10 @@ static int ipll_find_rate(const struct cv1800_clk_pll_limit *limit,
 
 static int ipll_determine_rate(struct clk_hw *hw, struct clk_rate_request *req)
 {
-	u32 val;
 	struct cv1800_clk_pll *pll = hw_to_cv1800_clk_pll(hw);
 
 	return ipll_find_rate(pll->pll_limit, req->best_parent_rate,
-			      &req->rate, &val);
+			      &req->rate);
 }
 
 static void pll_get_mode_ctrl(unsigned long div_sel,
@@ -134,7 +133,7 @@ static int ipll_set_rate(struct clk_hw *hw, unsigned long rate,
 	unsigned long flags;
 	struct cv1800_clk_pll *pll = hw_to_cv1800_clk_pll(hw);
 
-	ipll_find_rate(pll->pll_limit, parent_rate, &rate, &detected);
+	ipll_find_rate(pll->pll_limit, parent_rate, &rate);
 	pll_get_mode_ctrl(PLL_GET_DIV_SEL(detected),
 			  ipll_check_mode_ctrl_restrict,
 			  pll->pll_limit, &detected);
-- 
2.46.1


