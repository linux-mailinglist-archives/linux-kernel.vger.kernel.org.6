Return-Path: <linux-kernel+bounces-326632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5034F976B0A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 15:47:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CA3D1C233C8
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 13:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 267661A7253;
	Thu, 12 Sep 2024 13:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gMEHe9CK"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094E618028;
	Thu, 12 Sep 2024 13:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726148832; cv=none; b=IFGWi++aSBZnp8OVYJHY80nzCoSPou1EYqUAKg3qefyj93g0TbZUfNd+RUL6MpXhe/ePjyqO+72MLie1zPOIUkWVB+4+12VSWj4PuuHt8AA4Fan14+x0kB/0SaD2AAePW+mnNUt7TRs1lq9IgzD1BTrRXmYMQmssr+KYxKajiPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726148832; c=relaxed/simple;
	bh=vxlZxlE7+5rpc2cmj8uCHYV4Bo6FpRGIrzc8t3rw/dM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=OYPkqU5ZAvU7H3tlilXDjJopFoPKSXp7PScMQZO+0XpLeIYfhixoOLuLPN9/Pz573bWBuivcH5cdRCiB3yso45X8TxOScMc8Yw49Tti7TLWoeclWCtG6cIL5SLXaKP8KJ9+nthoClHRCLLnL/OYt3bHDOTLcTYuI/eaOAytqBxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gMEHe9CK; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-42bb7298bdeso11170155e9.1;
        Thu, 12 Sep 2024 06:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726148829; x=1726753629; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iX3nLJDVZKTgpr5b7V5HsEySQIl9g2HiZwb8C583JSM=;
        b=gMEHe9CKI0PrzisyCJ80AVwyo53dH30tN2QqpK3HZcAUVuUYAcBdyujrZDvEkwJdGH
         SaxQcE1TgqXVFV3XvEQEoyULa3IlCu9k+tzOYJxWBdD5kWgXaWF1KunfGDqPMvJ7DYuP
         1V1xGWbgRea/DzWTa6qIznb1BbU1e4oJV5b739XNRvY0Mmqt2yn1Ogo7Gh7Xzdpj9Zk5
         cCShtnLudDMCtOe5QCwJt33+V8SczKqZ+Hor0L/nFdyJ5bCWyZObKA9hnRxxPpCN0td0
         Sa6Lg32HIiwhj9/nnYw2TdEas/J2b0Eg3ebP/3U98/vUW9LHize17ULp2TPQ4Dpl3Yw3
         2Few==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726148829; x=1726753629;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iX3nLJDVZKTgpr5b7V5HsEySQIl9g2HiZwb8C583JSM=;
        b=u737fuSK6Rk7+qMpqhsfK4pdb9YVRsWMc3djKJ2NH979LX4eUFaiI0XjswyWr0b4CE
         L33W1XPk116dCa966KWPjnTkPNoDN8sM9FMqRmfdK2tpSsVXEhfVu3jQXox4bB9DUI60
         jcCWDq2XhE3M0subb6E/Iyeg2VeTSPPi6wTXV1gHQokZN5YgkivDEf7F7RJxkHjdLl7e
         Ny6a7Dg4nqsd/kGi5T4R1jRi57unDTyyOAoMxol8jDky770cjqma+jwFdzDSKRsM4s24
         T8Bs/+59jOCN4RbU85GRr7Hb2fX4+dQQot50FjuyS/I7Luw6UCCN1AzE1dowY4IW6210
         aPjg==
X-Forwarded-Encrypted: i=1; AJvYcCUJnrOjYRfyGqBaLzPLa/1hWWHJsJmOW5dsHtNbuU4AeYpc38LRCB6KaQ4rCedBaY7URSrJ4Y8X8QQ=@vger.kernel.org, AJvYcCVqAIgCnxzRc+FMFKk3FBGtLJH5ITantcJZMsFLQikEB+3lUxKqdRMhmYlThHxPoK/0OC8qdzmLZB8Z1+DY@vger.kernel.org
X-Gm-Message-State: AOJu0YwRo/rgj7LwUQF/EuXRTkmxhEYiPBy2oFyyTBSJZ7G54oD829e4
	S+fun5o5SR380rRjHvbXpMHGQUIg1EY+NnT/+pjui0W8SZulTUYw
X-Google-Smtp-Source: AGHT+IHC9XdTfjx/pAFpCWOVNlEvNdPSxj0PhGBxUQzvdOJaDkYwYMFE0pIfnhtZoKKfXpXw6UMUhw==
X-Received: by 2002:adf:a356:0:b0:374:ce15:9995 with SMTP id ffacd0b85a97d-378c2d03afbmr2287871f8f.34.1726148829162;
        Thu, 12 Sep 2024 06:47:09 -0700 (PDT)
Received: from localhost (craw-09-b2-v4wan-169726-cust2117.vm24.cable.virginm.net. [92.238.24.70])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378956ddaf3sm14460588f8f.96.2024.09.12.06.47.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 06:47:08 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	linux-clk@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] clk: lmk04832: make read-only const arrays static
Date: Thu, 12 Sep 2024 14:47:07 +0100
Message-Id: <20240912134707.590224-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Don't populate the read-only const arrays pll2_p and dclk_div_adj
on the stack at run time, instead make them static.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/clk/clk-lmk04832.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/clk-lmk04832.c b/drivers/clk/clk-lmk04832.c
index c997e7491996..2bcf422f0b04 100644
--- a/drivers/clk/clk-lmk04832.c
+++ b/drivers/clk/clk-lmk04832.c
@@ -375,7 +375,7 @@ static unsigned long lmk04832_vco_recalc_rate(struct clk_hw *hw,
 					      unsigned long prate)
 {
 	struct lmk04832 *lmk = container_of(hw, struct lmk04832, vco);
-	const unsigned int pll2_p[] = {8, 2, 2, 3, 4, 5, 6, 7};
+	static const unsigned int pll2_p[] = {8, 2, 2, 3, 4, 5, 6, 7};
 	unsigned int pll2_n, p, pll2_r;
 	unsigned int pll2_misc;
 	unsigned long vco_rate;
@@ -637,7 +637,7 @@ static int lmk04832_register_vco(struct lmk04832 *lmk)
 
 static int lmk04832_clkout_set_ddly(struct lmk04832 *lmk, int id)
 {
-	const int dclk_div_adj[] = {0, 0, -2, -2, 0, 3, -1, 0};
+	static const int dclk_div_adj[] = {0, 0, -2, -2, 0, 3, -1, 0};
 	unsigned int sclkx_y_ddly = 10;
 	unsigned int dclkx_y_ddly;
 	unsigned int dclkx_y_div;
-- 
2.39.2


