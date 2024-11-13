Return-Path: <linux-kernel+bounces-407016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E0A99C6773
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 03:53:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34EFFB224F8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 02:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2646D15821A;
	Wed, 13 Nov 2024 02:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IjiYJAZv"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E1213CF9C;
	Wed, 13 Nov 2024 02:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731466414; cv=none; b=XXlBtTGhU/VjFavp80mONVNCiY0rJHmGzpRAs45PgIZRXiiQiXDGPP2MIduivIzjqeuPnu7M5eyJiax/nCNglL/TlNof0osdLDlsayRbziwMuoI3VV0rm4zzG9RPn7gb42y/tl63UVdOJq68bhu2KdBrfZl/vwWwUPWSzsmQ02o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731466414; c=relaxed/simple;
	bh=F8QP/nKQfxhnRj66m6QjaRraxkUxtoGI7tb5Z4gi2f8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Rnw+2yxZ41Q4x4JxAsFFVRnZms8WNU4cugaIpSfOP71U9sJpVnIvOQNybHHC7swRPAv+3+/mnJLX2tytwzLoLWy2GlE5jKM16h4Z2Mwq4Ku030mPQCXvmyPrpjVQ+Fhtq1Mr+kYA7HZHqDHDOW8raq1e81TW5Q0OMmHgYjYREuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IjiYJAZv; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-71e79f73aaeso5338087b3a.3;
        Tue, 12 Nov 2024 18:53:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731466412; x=1732071212; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xewsKThZcrjPpi/GIkRDSebXbGvFDy87C/0XOp8UGec=;
        b=IjiYJAZvW0U9x+FV78/jWVnUpds4K931cOl7bChf65ztOi+Ojyi/QQH9EDt9zLVNX+
         hNtaA6o2zIik4053HzTkBE1QB+MF6spN1KvqOODOoc/0acl7K8DqA3cD8lGRqzIO0w5a
         5Geo5sdW/x4e33S0rA7I1Gk9FHykpciP9Cmtj2VVLrRC5l6vT53/lkqpQCZON2yGDZFR
         ES9Owuv9wBA3LzHtFMFM/bd39CGZsWIbqIXCq8NA9/X2sOc4RDc+AjdCLj7pvDqB7JQ+
         sxAAwEZ86a/dOINEypAnGLBUORWInRQrM/frlPlMkc+POp0TKrhHTTf+cbZyB0qqQzgK
         OeFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731466412; x=1732071212;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xewsKThZcrjPpi/GIkRDSebXbGvFDy87C/0XOp8UGec=;
        b=OdITUmntmiswOQZpkgVnldDvO/vKggaqTiiQ4nbKtd3gS3fu+AwrRhJZ1WmGkn7rof
         gKfX6wai19t2I9SvQGrvQ895HAL6DsWDVSdE8mZFJu/IY+oJ5g3iboSBUSme+QnCHDoN
         V5dzDsmpac5w/nXvOlCtS6K9Jd4h3dIVz2RyxHjOrjgPpo+X8Lw7hl7Wd2kXvUHp0lZb
         43xlAND+8Z+MRuwKHl4sUFoKldn/6W1+oNMyCtqwgVMnLPPrRUZXW8NS9vzL6B3lY+G2
         9rewC6N1dZopv8kp0NNUyRygGRjahts1fqsKFUjIk7l1RMg7chkwsV2SO1YnS+qRuTeC
         gt7A==
X-Forwarded-Encrypted: i=1; AJvYcCXSaPVL7YfqrDaQA1D+8whL+PVGoV6v+OKfhOsgkI62Ds1wNh+LXER0nirpKvWwhHAwjd286deMzJ+TZDI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEPsZxQxgQWxLZ1FU6c+j4+H7XkOQbm6K9Nf3MJnmy3lzfc+GJ
	3Kb0WYEWRYVWFClPOkFphG4i4ct4TFLBjdtuLhwdbxuKZtjtQMcq
X-Google-Smtp-Source: AGHT+IGy9ah1otck2RobZiWb6M56TaBXd4DkoJC8PBSWlDZT03uCcic/l+WsvL3cza9CBzYwkmKlVQ==
X-Received: by 2002:a05:6a00:2e1d:b0:71e:7c92:a192 with SMTP id d2e1a72fcca58-7241336afb8mr25943275b3a.24.1731466412340;
        Tue, 12 Nov 2024 18:53:32 -0800 (PST)
Received: from localhost ([38.141.211.103])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7f41f489186sm11237371a12.9.2024.11.12.18.53.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 18:53:31 -0800 (PST)
From: Ragavendra <ragavendra.bn@gmail.com>
To: mturquette@baylibre.com,
	sboyd@kernel.org,
	unicorn_wang@outlook.com,
	inochiama@outlook.com
Cc: linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ragavendra <ragavendra.bn@gmail.com>
Subject: [PATCH] clk:sophgo:clk-cv18xx-pll: Remove uninitialized u32 parameter and variable
Date: Tue, 12 Nov 2024 18:53:18 -0800
Message-ID: <20241113025318.3667350-1-ragavendra.bn@gmail.com>
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
 
+
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


