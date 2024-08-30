Return-Path: <linux-kernel+bounces-308119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7B0C96577F
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 08:16:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EDE21F270D6
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 06:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1835152E17;
	Fri, 30 Aug 2024 06:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AeOyT73k"
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B58EF4690;
	Fri, 30 Aug 2024 06:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724998604; cv=none; b=Q1qHVBHzZEaXhgxt70QyvoXFZa/lo1kfjncHhEkIbLWNSGFBmrMFGEqe9o+dYKXLwi8WMYZ+f+nxi9LwmOf0VaFj6G5GvH8jyGYk+kG9JDkUwfHO/M7Kaf1opnP5VKXVCAyct8g17g8gP3YOWBnVQ/QB6uQxfl25+lQI+I9sFVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724998604; c=relaxed/simple;
	bh=kwLU0Qllp0uF3RpaZ6YdoRsAKpBOlqE4OortN2zxMOg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=g1rTOU1nfzGkbB5Xd2i+LcztVTevU1OroY5xbgVAi4IbMNu52KQ2n5uGwEkAKkbiyU4YFkZgmOBlCfgeOx9dueZgiGocSKroUSfwvXpK9v3SZX0EDTVHy5bhr0d592F9WBensJ0Sv2fe4vQQJLVGYA+v0qSrR687wwrFiv6SOQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AeOyT73k; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-70b3b62025dso988608a34.0;
        Thu, 29 Aug 2024 23:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724998601; x=1725603401; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yFCh/eP/aoZWHU1KKEtdLzMx+5SadMmNDlFlgmEdxY4=;
        b=AeOyT73kR5UZVmfri3/pwikXoSoTic6SITF8BInt9JBpERsfTcN/v2TsMdoVMd3nto
         8fSzxBhLkRzkuBYcA7J+50cD143P6wE8ThezJrYlz0pBm59GM6QcZOYSgsKj7hABf7N7
         h85Jcs3C512xhEBv8xb9lk6dns1oLrD0m3QjctBgD6Fv0zbsva4r2AvqrFsScApKAhnj
         DJ0vO9sHVCzfMopMsXFyyF/M+xBH6Uhw5PVw5kik9WQESc7DDazXoUxbIf0eLsk5POR4
         hGiE1iBTAPGD7ZsNKJpqmjwzfveM6RaV0LUqCEbQfpOf67UF7vNr2S5H2s3+DNRBrHbP
         wmrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724998601; x=1725603401;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yFCh/eP/aoZWHU1KKEtdLzMx+5SadMmNDlFlgmEdxY4=;
        b=XQnaYJWMg+Oi/5VWa+mYpcAtoH4Th6qL66qxdi6JDbCjgveoSXL2FbsVrJnVCt1I9n
         LaXfsmntF2idKphFnr/rxfZ1371HilGtkepnIzb0vVgqdyMRalPDzUoBjy/mLgC+SogS
         04kefizZnK7bsBzse1DnrbVgDmRV7kImGLm4i+uAbS5LE5JGzmizai7eBjPotL42xmfy
         T0yihRiwdONE0GRV164Erq58IS84SnAOFkvNzzooDOlthD8PZ2QsYN9lkstwwpKtNsEg
         24tR4uTnrhA4+NPzESxbvYAS3vHAxrtWcKuhgzPnaxdaQyOPCoSMnbGofTv4XkeSRvp/
         hUcQ==
X-Forwarded-Encrypted: i=1; AJvYcCXXJRa/Ln+v0F/6NXtF0Am7LTcK1F19vEJE8gL9mdyXBGg+jmWPmLZpXU1J8jWunk1swOvISv1vVsWYZrI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9krjP/5GX/uBGVe6NocFLesQ/wFC/YkVYKf0DdcevV6pwUcmj
	eFvwX6iU1uhnvpStBXCFtd1uG6sQFOGYG9QqTOIR9Ry7FeG4Ix37zGbLtOzw
X-Google-Smtp-Source: AGHT+IFgKBpHg+xSJgTxxKhUWmz77q6DAIGQhGHthR81ua2RC6ZBy6ko+TUP7YVAxE+We6YS8paT4Q==
X-Received: by 2002:a05:6358:9044:b0:1b1:a8b7:2d03 with SMTP id e5c5f4694b2df-1b603c3f977mr667916855d.13.1724998600746;
        Thu, 29 Aug 2024 23:16:40 -0700 (PDT)
Received: from m91p.airy.home ([172.92.174.232])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d22e742c74sm2237014a12.4.2024.08.29.23.16.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 23:16:40 -0700 (PDT)
From: Bo Gan <ganboing@gmail.com>
To: linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sboyd@kernel.org
Cc: samuel.holland@sifive.com,
	emil.renner.berthing@canonical.com,
	mturquette@baylibre.com,
	paul.walmsley@sifive.com
Subject: [PATCH v2] clk: analogbits: Fix incorrect calculation of vco rate delta
Date: Thu, 29 Aug 2024 23:16:39 -0700
Message-Id: <20240830061639.2316-1-ganboing@gmail.com>
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

Fixes: 7b9487a9a5c4 ("clk: analogbits: add Wide-Range PLL library")
Signed-off-by: Bo Gan <ganboing@gmail.com>
---
v1 -> v2: Add Fixes tag

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


