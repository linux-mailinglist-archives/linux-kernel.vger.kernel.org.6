Return-Path: <linux-kernel+bounces-409938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 659B39C93A9
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 22:01:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA57EB28AD3
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 21:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00E591ADFE4;
	Thu, 14 Nov 2024 21:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eu+RVRc0"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073B81AB6F1;
	Thu, 14 Nov 2024 21:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731618094; cv=none; b=F60Jk7a3iJS1Fqb1bbUNYJ7072PfaeMWTMC90G7NfQGFSrljjV3ExcOSWHYNpI+5VOeR4hF0JtfZzc73f+NLCUwsdyKcjneq0vFrH1SmkH3FvqtrJ7x3n2FRkpNePV4V6essHGtYB5BMrfvQmLL2/ZDlqPE++Jgkzr6PtAyM7Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731618094; c=relaxed/simple;
	bh=S7tRjuXaZpHsyBV91aZWFUrd0TldunNKHIzfBKQ6OdQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q8ouG5UdZDLdXP5OuhtvIfVhuARbpE91cWVR1SeSVXbEdVHkgMJX8Uymjd6kpSzpFgFT2n5Q5d7G0gWWjxx1kLeMEivW+BH2tu2DYWDXeCPr3RXCdGCHcDd0pcEMtjMIljc7nSl2G9bZlEJw+VsSS1doI2QdmtD74EzcwwAUkCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Eu+RVRc0; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-211c1bd70f6so10007015ad.0;
        Thu, 14 Nov 2024 13:01:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731618092; x=1732222892; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=B8if49p7SgY4GYN04lAfksTYRw6sC0UZKeThEbuX8Kw=;
        b=Eu+RVRc0r4FQHLAJXuZePiQhJ4HklrVBcIreb3NcDACiUW7QFHh3yqj5/OUSa+KtY5
         gMLhCH8rHgDXMRoNFCiO31MU1tZCncPp4EIY5VApw/LCNj9znFnNmzDBPggzI+h9QN4q
         TSehWK2sWfV0YhlbqXK4Aw160tIhkG8XbX0jyZfRQ9vhut/f8x4wdK/znVnHL4vYE06F
         h6i/N6K4/mnBV0w7B78RfzjVV/YJnw+b2OAIYlsgCaoZ8tt+SvgYdgJD9IQoCgbAxFed
         iIlT1KFJiZC9Rhps3QvQ5OsWSyUNIsL0ysQjhK2WUxxFTK0V3s0uPhzLDlzNb2vbKB0m
         0lWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731618092; x=1732222892;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B8if49p7SgY4GYN04lAfksTYRw6sC0UZKeThEbuX8Kw=;
        b=HotnE4/yXow6dxmUYeUqU/rT0uis/EUsDG/77ANfz90ua6ccYRnDzQwd4KBxwrEJ+I
         eNfgqvzn7y0ehUmh+7/d5aTVBYGSqLxA2bpvLOQQapOj7OvMesqr2gmtY8Zpx1Sfo4O1
         H//4F63OG+UnqnO2CGyX7XZfB3L1IDRxfcQJdiTn7sNKUhaR34zQoKsDIz5XeNmRnaQx
         eID4S+ETEQr+a2LtzJAcQkYmFfb7wNs94J0b/oHMo2WE8b77BD0BJStcWFYRUSdOh83J
         SP/HwuVb5+PJgqfa3UXYqNP2X4OrlRjolBlWvc7RMs8c8nFdyJTZkCFVuAxSar7jtE5E
         Yg/A==
X-Forwarded-Encrypted: i=1; AJvYcCUdk4XctGmMS8bm9yolyaq8WsTk5ifa6MQznOGWsgZYEnK0S4dKpogHZ4ZDossbsspa4APgHjAHLlojJKg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJ9M8uFnzmk3KhtFaE+K/Tse/gupdwLbNBpHCffqv5N7/v2H7t
	zuuZ5QgTbt/kgEjzNbnaAMxpjTB20IJTAADJbPhJ4O0VzQ8PswXL
X-Google-Smtp-Source: AGHT+IHj4ZXgkfQxt90ivIXnn4Vke6xU9tFkg7w7hfd+e0TpPIOlSvx61B0tPtnj/U3hHjtCmfl8ug==
X-Received: by 2002:a05:6a21:9983:b0:1d8:a322:6e with SMTP id adf61e73a8af0-1dc80691cd1mr7436048637.19.1731618091988;
        Thu, 14 Nov 2024 13:01:31 -0800 (PST)
Received: from localhost ([38.141.211.103])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7f8c1c3c39esm68973a12.33.2024.11.14.13.01.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 13:01:31 -0800 (PST)
From: Ragavendra <ragavendra.bn@gmail.com>
To: unicorn_wang@outlook.com,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	inochiama@outlook.com
Cc: linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ragavendra <ragavendra.bn@gmail.com>
Subject: [PATCH v2] clk:sophgo: Remove uninitialized variable for CV1800 PLL
Date: Thu, 14 Nov 2024 13:01:15 -0800
Message-ID: <20241114210115.29766-1-ragavendra.bn@gmail.com>
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
V1 -> V2: Updated commit log, title and addressed review comments
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

base-commit: 2e1b3cc9d7f790145a80cb705b168f05dab65df2
-- 
2.46.1


