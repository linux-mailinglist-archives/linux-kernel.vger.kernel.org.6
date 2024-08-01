Return-Path: <linux-kernel+bounces-271093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD900944966
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 12:36:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83BC0282316
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 10:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D26FF184549;
	Thu,  1 Aug 2024 10:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="IaYq7Y7E"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62078184528
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 10:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722508585; cv=none; b=Rur+KptfwqCbVOyOYQVP1vKRao0JF/cQ9yiRmKNqj4HR7W5Z3sONpwRFKKr/tCeX1XaTmAQ0oC3GPV+cDo/5BStBvuiUDKdFfPrlz97bFmw1upLUXX3hXBGSaeiNvILq8aKu55/L9Ti6xSWxq18W64uNHmFHYby4MitVDXd9ios=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722508585; c=relaxed/simple;
	bh=NRM+kgKwBU8r6cYAcjDNYZlfqQ6UT1sfjavDTYorIco=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XuZL7kwoRMylT0FE988ZWflPi28IiancpThELTF129SkIcpIJgofboBTWOWe5nzMLpw85tFxEdWOsEq/0hnYqE/tPfyzKnk1E3m+Sl3FChveSGlpXZ0bWQqAFW0kh+eArLe/zPERFNz6N0ThZdudwIPogm088U/VErMUPEKYjpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=IaYq7Y7E; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4266f3e0df8so43051035e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 03:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1722508582; x=1723113382; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uX4IaEMr1VdJXApOdGT5XxSsfW+jBZ4plMQMTeRKMD4=;
        b=IaYq7Y7E6DUA1DZJER7ZsByYWfw6r1mJBqmxk8qYOdMNlSgvB1oYMapztO3B9Ynzvq
         cD7V9NFScfo5XjQFv+Z9G6feSzITneY9+G3ydCo88hm0vRR7WoymjjLL0enAtoOW68Jy
         WNnj68DCDBOkWEsHW8WRwwZLARydSldXzGImivX5aSV+BbPdAk/FkFENZxjVPBS7300r
         03TW5zy99trEqUxVEzOCQHTJRveI/u4ChJvsqlrAd2K7jiOOIMPEOjRf6SgBf11nT2Ue
         cElRsspYTeXXl4viTMpPVHjD3HR7LIiA/R+dSzNp894PS5KMe06AFQuMlgNKW4akkwgj
         eTKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722508582; x=1723113382;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uX4IaEMr1VdJXApOdGT5XxSsfW+jBZ4plMQMTeRKMD4=;
        b=f7bh9dVQqGZcXP1A2xF7V576xh9x4TD3viGn+KRAc0sQhrIxHO7vu/SGj2LgUP56dr
         +ahxMF57MzCUABaBOVsxOaNDTg6vvj9q35pNAljyLLZIGdnhhOKbilVIBqP62MMLYsLM
         +db54Lc6hn2i6ZlDyswqWc9IlnHWwfmZLiApVSDGhhoZMMkjQYo0Utk/n8bHJ1uxkwyc
         WPrDl4v7OE+e7BTyoaCASBueVw7oYe3QZLqjvS6a8dz2VirCkNSt015RVwA9N/Zkxrqm
         OXpVtFEzZBYSgJpuFA+ANAEHP/V2IMeszamA88KdrTwcCBuoieT/dU6zk/mqiTRugwEd
         IfFw==
X-Forwarded-Encrypted: i=1; AJvYcCWqO/+H4syOO3lKrGjIGLtzTw98morufR5s9Vf8iMuyOzimLzTNisNQe2u4pTB3o2LbOGdDqRP91f32X6O1n362FKMGLBQtEOFWC9Pn
X-Gm-Message-State: AOJu0YxxVLcdnXy5k2zk2lUkwU6FItL/SoFQaIrjAp45CHK21mdbY5PB
	zhxWOpjcmxf/ozKoQCUFeDlucM79QOn+lz7V+IltThKacRF22PuFEMUiPaRNl24=
X-Google-Smtp-Source: AGHT+IHXZzVY2RHPJ7hV/J3clIiaRw2lCC2mSGOOlG4ghfqUb/oWihGNec6dU4R+28d8BMZ9icAykw==
X-Received: by 2002:a05:600c:314c:b0:427:9dad:e6ac with SMTP id 5b1f17b1804b1-428b032b25bmr15786785e9.34.1722508581377;
        Thu, 01 Aug 2024 03:36:21 -0700 (PDT)
Received: from fedora.fritz.box (aftr-82-135-80-26.dynamic.mnet-online.de. [82.135.80.26])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4282bb64952sm52975625e9.37.2024.08.01.03.36.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 03:36:20 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: mturquette@baylibre.com,
	sboyd@kernel.org,
	erick.archer@gmx.com,
	gustavoars@kernel.org,
	u.kleine-koenig@pengutronix.de,
	christophe.jaillet@wanadoo.fr
Cc: linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH v2] clk: hisilicon: Remove unnecessary local variable
Date: Thu,  1 Aug 2024 12:36:16 +0200
Message-ID: <20240801103616.20430-1-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The local u64 variable refdiv_val has the same value as the local u32
variable val and can be removed. Remove it and use val directly as the
divisor to also remove the following Coccinelle/coccicheck warning
reported by do_div.cocci:

  WARNING: do_div() does a 64-by-32 division, please consider using div64_u64 instead

Use the preferred div_u64() function instead of the do_div() macro.

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
Changes in v2:
- Use div_u64() instead of do_div() as suggested by Stephen Boyd
- Link to v1: https://lore.kernel.org/linux-kernel/20240710201844.710365-2-thorsten.blum@toblux.com/
---
 drivers/clk/hisilicon/clk-hi3559a.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/hisilicon/clk-hi3559a.c b/drivers/clk/hisilicon/clk-hi3559a.c
index c79a94f6d9d2..8646e9d352ed 100644
--- a/drivers/clk/hisilicon/clk-hi3559a.c
+++ b/drivers/clk/hisilicon/clk-hi3559a.c
@@ -407,7 +407,7 @@ static unsigned long clk_pll_recalc_rate(struct clk_hw *hw,
 		unsigned long parent_rate)
 {
 	struct hi3559av100_clk_pll *clk = to_pll_clk(hw);
-	u64 frac_val, fbdiv_val, refdiv_val;
+	u64 frac_val, fbdiv_val;
 	u32 postdiv1_val, postdiv2_val;
 	u32 val;
 	u64 tmp, rate;
@@ -435,14 +435,13 @@ static unsigned long clk_pll_recalc_rate(struct clk_hw *hw,
 	val = readl_relaxed(clk->ctrl_reg2);
 	val = val >> clk->refdiv_shift;
 	val &= ((1 << clk->refdiv_width) - 1);
-	refdiv_val = val;
 
 	/* rate = 24000000 * (fbdiv + frac / (1<<24) ) / refdiv  */
 	rate = 0;
 	tmp = 24000000 * fbdiv_val + (24000000 * frac_val) / (1 << 24);
 	rate += tmp;
-	do_div(rate, refdiv_val);
-	do_div(rate, postdiv1_val * postdiv2_val);
+	rate = div_u64(rate, val);
+	rate = div_u64(rate, postdiv1_val * postdiv2_val);
 
 	return rate;
 }
-- 
2.45.2


