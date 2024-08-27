Return-Path: <linux-kernel+bounces-302650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFFED960172
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 08:20:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11336B21DA4
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 06:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABAA61422C7;
	Tue, 27 Aug 2024 06:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bLv4eT00"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80DD854656;
	Tue, 27 Aug 2024 06:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724739601; cv=none; b=MZLCaNjQQYcVZiTHrvgZwLu40wL1VC4MUFg8qyjjkaZCPE/wTe9bivEiMhW+zqlLHMwgteiaJpbJdYwYeEjyRQWWDcZtrNfFUa71Fbcb/Xqoq9KQFasUhuCVqmuWK7bdXd6n1Dbr9O67MOaMYl4GV4CMdAqiO/lzCOmHiy5oOMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724739601; c=relaxed/simple;
	bh=z3xxKPMhVCSpFL5YBUOSJOvKOR5jXfsB2QqqZ5ZQAGU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XWbCy+Xqo4xH/739Saj4pg+Sb+OFL04kbvF6kbAQpf9bkrqrFYB5WJEVCf6onJS5Lq8C2T7ddAcrRxoXJyB2FvCOAga/aGs3ul2xRz6PwL5BZCjeUr0zhLON2TR0gSXRguf4UcR5j3WlqbbqV5K4XOMn7dHxYfuvOo/0Yki8g5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bLv4eT00; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1fec34f94abso50872395ad.2;
        Mon, 26 Aug 2024 23:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724739599; x=1725344399; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nZcegG7EAv0GyJ5Ll2akpwJW9oogMv8ZVknMbVlYwjk=;
        b=bLv4eT00JwSQQPPX7dt5ja7OYgl7CrZ5w5oW3zV3nRAVgUC6v4DqYUYMPRgjwtCFMf
         j+5oY7v8o2G9qLTHnt3v7yIiCkBFxPR0Cr+qLlA/G9pf51NayD8tPUEb0De59CUYXSuI
         pJMd6YHIxfu5P0JSj93oPh70INzqyonagNzRbd2hOOPbK1TpPbO+dtLDawc8gfllUU6j
         rH919BAfmf7hMbN33egXMt/PlrZxwYYq7dUBD2JxJg4zyNSNRk+muBV7voIfx/jXELVo
         UGt0i5ybzAE1cNNuZKoIrEHfQSL4pO4PWuGHEG+lA/LmesS6sUZX4PDs3uDOO5u9OXbd
         FLog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724739599; x=1725344399;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nZcegG7EAv0GyJ5Ll2akpwJW9oogMv8ZVknMbVlYwjk=;
        b=e0poRHWYD5ndL6HCqI1tqOSKFT5BanWX9dg5G+6nXJSWgRDf6HEQTugrDUVQbjmT21
         dicgmmo1cFZQh5SVKecp/dsH9IUrGvOzK4kDTZaN+xx6bAX4GXFSgcUqSiLlv+wdyDzc
         rCtuMsvbJ6R5hrb2n2Zh9MWd1CSGpKQBKUGSOn/6Pr3bVM0sam0sGAovq7v7JlX6tTFr
         4Ynv7jN6U/vqmAbQ88wv5Vu3zDKcIBrE/iqNwDtYA7j2uDIrrq66ObrBnVs0ZLItezal
         YhI3c9KsoK6olHHVbzS4/Rw776CHfy1TYfK1bJEDTtNhw3NvXz9coXlXKt/gpqYmodOu
         yItw==
X-Forwarded-Encrypted: i=1; AJvYcCVaN9McOq7YBhZdl3yerP+/RnOE12BzWtaPKmzU+kjYm5VBZavnW765j6+e3k6GSPn0LjkCrDIulCly/A8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwTTAPK797z+Wy8MtfZEAmalMsAtTHj4KBo11fZYILU8v4yKWZ
	EZ7W6hbFyD34/VVOvciv8qSzh8DSfDmwtFUnxfndAyKm0wJmvhiyuLEqBcdV
X-Google-Smtp-Source: AGHT+IFf6hTvm316Gr3NNCQBadqqu265dsdNgJ5z6giG6NDkpRVicfYnuwJqMjz0uH86PWStwVafrw==
X-Received: by 2002:a17:903:2c7:b0:201:f1b5:24ac with SMTP id d9443c01a7336-2039e51279bmr142933375ad.54.1724739598730;
        Mon, 26 Aug 2024 23:19:58 -0700 (PDT)
Received: from m91p.airy.home ([172.92.174.232])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-203855dbec8sm76631465ad.137.2024.08.26.23.19.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 23:19:58 -0700 (PDT)
From: Bo Gan <ganboing@gmail.com>
To: linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: samuel.holland@sifive.com,
	emil.renner.berthing@canonical.com,
	mturquette@baylibre.com,
	paul.walmsley@sifive.com,
	sboyd@kernel.org
Subject: [PATCH] clk: analogbits: Fix incorrect calculation of vco rate delta
Date: Mon, 26 Aug 2024 23:19:54 -0700
Message-Id: <20240827061954.351773-1-ganboing@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In function `wrpll_configure_for_rate`, we try to determine the best PLL
configuration for a target rate. However, in the loop where we try values
of R, we should compare the derived `vco` with `target_vco_rate`. However,
we were in fact comparing it with `target_rate`, which is actually after
Q shift. This is incorrect, and sometimes can result in suboptimal clock
rates. This patch fixes it.

Signed-off-by: Bo Gan <ganboing@gmail.com>
---
 drivers/clk/analogbits/wrpll-cln28hpc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/analogbits/wrpll-cln28hpc.c b/drivers/clk/analogbits/wrpll-cln28hpc.c
index 65d422a588e1..9d178afc73bd 100644
--- a/drivers/clk/analogbits/wrpll-cln28hpc.c
+++ b/drivers/clk/analogbits/wrpll-cln28hpc.c
@@ -255,81 +255,81 @@ int wrpll_configure_for_rate(struct wrpll_cfg *c, u32 target_rate,
 	}
 
 	c->flags &= ~WRPLL_FLAGS_BYPASS_MASK;
 
 	/* Calculate the Q shift and target VCO rate */
 	divq = __wrpll_calc_divq(target_rate, &target_vco_rate);
 	if (!divq)
 		return -1;
 	c->divq = divq;
 
 	/* Precalculate the pre-Q divider target ratio */
 	ratio = div64_u64((target_vco_rate << ROUND_SHIFT), parent_rate);
 
 	fbdiv = __wrpll_calc_fbdiv(c);
 	best_r = 0;
 	best_f = 0;
 	best_delta = MAX_VCO_FREQ;
 
 	/*
 	 * Consider all values for R which land within
 	 * [MIN_POST_DIVR_FREQ, MAX_POST_DIVR_FREQ]; prefer smaller R
 	 */
 	for (r = c->init_r; r <= c->max_r; ++r) {
 		f_pre_div = ratio * r;
 		f = (f_pre_div + (1 << ROUND_SHIFT)) >> ROUND_SHIFT;
 		f >>= (fbdiv - 1);
 
 		post_divr_freq = div_u64(parent_rate, r);
 		vco_pre = fbdiv * post_divr_freq;
 		vco = vco_pre * f;
 
 		/* Ensure rounding didn't take us out of range */
 		if (vco > target_vco_rate) {
 			--f;
 			vco = vco_pre * f;
 		} else if (vco < MIN_VCO_FREQ) {
 			++f;
 			vco = vco_pre * f;
 		}
 
-		delta = abs(target_rate - vco);
+		delta = abs(target_vco_rate - vco);
 		if (delta < best_delta) {
 			best_delta = delta;
 			best_r = r;
 			best_f = f;
 		}
 	}
 
 	c->divr = best_r - 1;
 	c->divf = best_f - 1;
 
 	post_divr_freq = div_u64(parent_rate, best_r);
 
 	/* Pick the best PLL jitter filter */
 	range = __wrpll_calc_filter_range(post_divr_freq);
 	if (range < 0)
 		return range;
 	c->range = range;
 
 	return 0;
 }
 EXPORT_SYMBOL_GPL(wrpll_configure_for_rate);
 
 /**
  * wrpll_calc_output_rate() - calculate the PLL's target output rate
  * @c: ptr to a struct wrpll_cfg record to read from
  * @parent_rate: PLL refclk rate
  *
  * Given a pointer to the PLL's current input configuration @c and the
  * PLL's input reference clock rate @parent_rate (before the R
  * pre-divider), calculate the PLL's output clock rate (after the Q
  * post-divider).
  *
  * Context: Any context.  Caller must protect the memory pointed to by @c
  *          from simultaneous modification.
  *
  * Return: the PLL's output clock rate, in Hz.  The return value from
  *         this function is intended to be convenient to pass directly
  *         to the Linux clock framework; thus there is no explicit
  *         error return value.
  */
-- 
2.34.1


