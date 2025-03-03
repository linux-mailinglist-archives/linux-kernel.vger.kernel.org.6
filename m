Return-Path: <linux-kernel+bounces-541621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 73A81A4BF3A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 12:48:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2A1D188C3E8
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 11:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1797F20B7F1;
	Mon,  3 Mar 2025 11:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="GiTislL2"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1424C20C003
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 11:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741002467; cv=none; b=qIKWPIIrnd0jmUXzU7UNPsOXuxh2iOyJ9cTVkOgBZQnc5bb3Q2ZlDelrgpYSNe7/li3Xr2fTPvqUl7ajQDVkktkU95resDZviu2Ic9nY5viP4GlO0xljkuQJ5xHwX18GjSuenef+50TS0ZeUhCmAwD57C0EQM+6jl1uPc89XYJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741002467; c=relaxed/simple;
	bh=ec14xnJrpwkJrC/ethpz0fLxzagiTiLZ9fwLcAvPKo8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WOem4717Bvq69VsS0bVy3IyT9ZlrBY592eeypg34ECOHsXXFRU6yL7pggmFd4TBx1ir1xEj8tPAl6Xjv4+GWjqUanJf1lLASmYpsbYJO1viGdnAVjrePK396UWgH25vwimp0iiUDzMwEDC3UWaL8peKlIF58mkT8d1LgY+uiZvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=GiTislL2; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4394036c0efso27153545e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 03:47:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1741002463; x=1741607263; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q3z/kCXdK0L4ldNMK0CvF1cmi0sAxHIrcS5GyQP4Qyg=;
        b=GiTislL2oGDcR3O/UPEyyV9DuHlFpA/s79L/3KSLzLUIQBsR3IYe5LdlLYaLmwGeA5
         BsSbNd8Z9RTdiwTSpreY7kQEQq66tglj7pW29z/yHJfqTu7esegTVwmWRzcU8dkeMxEG
         T51S4LOIe/5fXMWGrjRK+xEA4deNiNq5tC/p2I2+xIS8ZYfssX/5yMwa0pLv8SqQBBRr
         GoBRJQ5qoiikGwjqfvOl6q0x36D01GH6CqGshAZi8y49Kam21t5SrrP8bO3F9SIfesf6
         CgvlXnwJ0+IVvdz5WV9JPxSWsNPOUP1lESaDpLiEDGgK+ATO4Uxxt+tMzu3Whx23ljCW
         PF1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741002463; x=1741607263;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q3z/kCXdK0L4ldNMK0CvF1cmi0sAxHIrcS5GyQP4Qyg=;
        b=UKSY0U5C1GpcNVhMYusLtAn4eUz+0eO4Us6Ohazd5SkRr2XTsB9NPVtN+gkD+qmtud
         nUOZaeiizgFoo5mcLgkcNBcq0MskNfLxcI+52vjLOyl0Q2OREwFpgSncwibCSXEk024Z
         CwtTfQ9e47OI5xJaiWEGGiIlNVvsjPsWySVZXiGjegGOQ2D4ZOZV66YrBRBywsPNSmK1
         7scEwY5vRMOntE8mHRDmPPB2BzAU4Xbg75KJ7u7qJSFCTXqoKWMRz5NX33iJqMSFoUSO
         C1mngCPqGyRYAHCxV2ybWlPJ+GlOsBuXiBwHnz3Q8d8e+yfIsd+YGDr6nuLzOkNCkaiK
         4/Fw==
X-Forwarded-Encrypted: i=1; AJvYcCXxxWEN577yFBkkNpBs8uFdX/yVsIL+4qRLek3NaobHTjvAH44stSOjqT4JGezeGkLbMMzPjky6P6i/ers=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVs5nYHq4cFV2oIQWATbxcnpWXPgeVnDmcmplRrAmKzLPH3z+0
	k24XGJSfyX7a5KTL5k1lU3f12z45kUN/eCjBiFk9M7sfMlJpr1M3ohb8hBfON4k=
X-Gm-Gg: ASbGncsV/mqolwKazSbvxDUOvcIioqTv6v8Opnd4U+jedrgX25M2vi6WtE3hMfiVAc4
	A061NiIqbGJheL1+KCefH8DpT8z/dWbuY03XBSnmPl4GuBc0U3K9ojaDGilZ+20+r99ubGSe74Z
	N69wJmFdLjhuID6N62fCiwNp4SNxkq/++RSa1eEJhHspmLmCR5jKJ0p/e2ajfFKcYTwEmi/xUdt
	QcUYpYXtdHhPJhjGgklRYhTWhNiUxVmzvZV2esaYARK5DOOvVOfR202gtPi/oT0TeMWaEdYWztf
	rhMrwgZIxKCG11cxCwdMu6xAMyWZMJxbFKZbiJ2P/GsOx2E8T0tKM35vX5hYVZ3i5CqB85KqSVU
	9b3LIuuJKDHsIAV4HRBZcqAhjVQ==
X-Google-Smtp-Source: AGHT+IGcpkNfGC9cZp7cxPodUHwFeqsEzvnD9PBRgOzzVs1HtvoYaDG1YKghsPwupGg0CervwLwT7g==
X-Received: by 2002:a05:600c:190b:b0:439:955d:7ad9 with SMTP id 5b1f17b1804b1-43ba66fe855mr109065095e9.14.1741002463376;
        Mon, 03 Mar 2025 03:47:43 -0800 (PST)
Received: from localhost (amontpellier-556-1-148-206.w109-210.abo.wanadoo.fr. [109.210.4.206])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47a7a2asm14385125f8f.37.2025.03.03.03.47.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 03:47:43 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
	Cosmin Tanislav <cosmin.tanislav@analog.com>,
	Dumitru Ceclan <mitrutzceclan@gmail.com>,
	Guillaume Ranquet <granquet@baylibre.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Michael Walle <michael@walle.cc>,
	Nuno Sa <nuno.sa@analog.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/8] iio: adc: ad4130: Fix comparison of channel setups
Date: Mon,  3 Mar 2025 12:47:00 +0100
Message-ID: <20250303114659.1672695-12-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250303114659.1672695-10-u.kleine-koenig@baylibre.com>
References: <20250303114659.1672695-10-u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3350; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=ec14xnJrpwkJrC/ethpz0fLxzagiTiLZ9fwLcAvPKo8=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBnxZa43uPHm+mFcYsPYI+AEgpGn7hKsucQzPMCC CLTMo9E9RKJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZ8WWuAAKCRCPgPtYfRL+ TkWZB/4xBWucmDiiknccyOSXYattbMonYzRbz4bd9Umov8diX8N4xq0TJN7QrqvTlOp6CaSSPYk t+gXSgqH4jTIbnIb/x6kAWm981EhINKtu2hxbuPEkfoEEk4mNikABZBMZG7xc6U+M8BNAO8+GTd uzbv9mWwEV6LvzPmziBAXEcQlm7C6RsuUV9yBsXS93SB6vn0rce1aZucMHyR1JiuF5vx2mx+xRr 9T3neSNT8JiOldSEIAmLeOxg6zRL0ccwEGOfD95KVdD4XHjd5T1IfxPc0T15yf6Jc1XcPNXKxcZ EbqyAKdMYk2rHWzC22jfSbOVyx8ZeEkT9N3eWBvwLc32UUff
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Checking the binary representation of two structs (of the same type)
for equality doesn't have the same semantic as comparing all members for
equality. The former might find a difference where the latter doesn't in
the presence of padding or when ambiguous types like float or bool are
involved. (Floats typically have different representations for single
values, like -0.0 vs +0.0, or 0.5 * 2² vs 0.25 * 2³. The type bool has
at least 8 bits and the raw values 1 and 2 (probably) both evaluate to
true, but memcmp finds a difference.)

When searching for a channel that already has the configuration we need,
the comparison by member is the one that is needed.

Convert the comparison accordingly to compare the members one after
another. Also add a static_assert guard to (somewhat) ensure that when
struct ad4130_setup_info is expanded, the comparison is adapted, too.

This issue is somewhat theoretic, but using memcmp() on a struct is a
bad pattern that is worth fixing.

Fixes: 62094060cf3a ("iio: adc: ad4130: add AD4130 driver")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/iio/adc/ad4130.c | 41 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 39 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ad4130.c b/drivers/iio/adc/ad4130.c
index 061eeb9b1f8d..4ab1943c4697 100644
--- a/drivers/iio/adc/ad4130.c
+++ b/drivers/iio/adc/ad4130.c
@@ -223,6 +223,10 @@ enum ad4130_pin_function {
 	AD4130_PIN_FN_VBIAS = BIT(3),
 };
 
+/*
+ * If you make adaptations in this struct, you most likely also have to adapt
+ * ad4130_setup_info_eq(), too.
+ */
 struct ad4130_setup_info {
 	unsigned int			iout0_val;
 	unsigned int			iout1_val;
@@ -591,6 +595,40 @@ static irqreturn_t ad4130_irq_handler(int irq, void *private)
 	return IRQ_HANDLED;
 }
 
+static bool ad4130_setup_info_eq(struct ad4130_setup_info *a,
+				 struct ad4130_setup_info *b)
+{
+	/*
+	 * This is just to make sure that the comparison is adapted after
+	 * struct ad4130_setup_info was changed.
+	 */
+	static_assert(sizeof(*a) ==
+		      sizeof(struct {
+				     unsigned int iout0_val;
+				     unsigned int iout1_val;
+				     unsigned int burnout;
+				     unsigned int pga;
+				     unsigned int fs;
+				     u32 ref_sel;
+				     enum ad4130_filter_mode filter_mode;
+				     bool ref_bufp;
+				     bool ref_bufm;
+			     }));
+
+	if (a->iout0_val != b->iout0_val ||
+	    a->iout1_val != b->iout1_val ||
+	    a->burnout != b->burnout ||
+	    a->pga != b->pga ||
+	    a->fs != b->fs ||
+	    a->ref_sel != b->ref_sel ||
+	    a->filter_mode != b->filter_mode ||
+	    a->ref_bufp != b->ref_bufp ||
+	    a->ref_bufm != b->ref_bufm)
+		return false;
+
+	return true;
+}
+
 static int ad4130_find_slot(struct ad4130_state *st,
 			    struct ad4130_setup_info *target_setup_info,
 			    unsigned int *slot, bool *overwrite)
@@ -604,8 +642,7 @@ static int ad4130_find_slot(struct ad4130_state *st,
 		struct ad4130_slot_info *slot_info = &st->slots_info[i];
 
 		/* Immediately accept a matching setup info. */
-		if (!memcmp(target_setup_info, &slot_info->setup,
-			    sizeof(*target_setup_info))) {
+		if (ad4130_setup_info_eq(target_setup_info, &slot_info->setup)) {
 			*slot = i;
 			return 0;
 		}
-- 
2.47.1


