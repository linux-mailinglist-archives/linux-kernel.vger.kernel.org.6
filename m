Return-Path: <linux-kernel+bounces-234410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A18691C656
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 21:06:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD1E6B21BF3
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 19:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C01FB6F2F8;
	Fri, 28 Jun 2024 19:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="MAOmymTB"
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B7A54662
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 19:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719601586; cv=none; b=lft+/1Yz+PnmIGfuIwy82hj6ilIGMv7Du+/pOQpGODt83bm9F/4P3og9slAfxsEU37QbaRjRcie7QI8but1AvwNHaxXcOA1UNlYzhYfl+yEN86iokqOiL/yv98uhlOa8n5leCcbqhL0osJRRRraZ7PDgw+yguia18jvh/mhnP80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719601586; c=relaxed/simple;
	bh=YilG7hAQ4bCoyFMO7jPkzeBtsMj8PhsOsGw/RlL9An4=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=lljX1GOc08KJDK5dmYWObJACrL7y2jFAB1Q2WQq9z5JhZLU6OwhCU7drQ/1T9B6jA+/Er+CxgBhwFu2wUszafrRKUCa8QwiXG0sxves1GtpYzXyrXE7AXre4O7vnlCA0e+vTLYjzCTy6irSq1Pj2FE3Y5wKFiPzkKo7fRQI+xTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=MAOmymTB; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-79c04e6e1b9so69119585a.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 12:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1719601582; x=1720206382; darn=vger.kernel.org;
        h=mime-version:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/P0aKcr077J0eGdBMkba+QgmC++9HxUfIpvEXZ3V628=;
        b=MAOmymTB0VDlstrPOW+kFxv1hMmwSuaflaJlLCNIJitF6lGXmrTwmVW1rzMxGFkQ06
         NEvgPvjE1w4aRuT7YNmmTciLNZhkzeAx9EcpnFbuFmEIKGTCXKyvu0wTwVxGXfspeDhx
         X50U/h6+5zVh8nwGSrY0rsbCf5WFcLfQhlf78NtEvhHAECuvB53S9hsMN+WgXso86UOE
         nF1H9KfbF/y18F5e3UZ5BmDMjSECnPpLcvav45oF4lYfnldOnlOCX8emDal8weDoEeK6
         /w0XjGMG6WcIbgbOlgHn7fGIxEPPeSOOkErsQTjp7x4iwCE1SVb74J5LyS1GmCwaVTEP
         iu6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719601582; x=1720206382;
        h=mime-version:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/P0aKcr077J0eGdBMkba+QgmC++9HxUfIpvEXZ3V628=;
        b=nAgglH6AatGDpXsRMpSFxbvzUG61V30az2ZJLa2FZn/vyv1BpKU/ehT4jnF2lVtUq3
         AnefmzO+og/nm5PYXo2Y4z/3oRDrO73jNtDvGGqp+i/8YYB81TMfUzZfdJK8JFRk6Hna
         W7CB0FsLw4Ug46YuOeYMK0S7iJEyxPJQcHfddzqdj4y3HHDQHpEXcz3UGbybyXqTsttR
         o3EzGWk1XmIEJ+h2YVzU1UQd+qX3Kw/vcIaawF1TAmyWi6NJvm4CQE6QObMpUh1IWZtA
         jnhURdxxdr0qkhRALpQ0nX0y9woJWmbQlY6z/Fy/Eek3VRmf0Kug16DsNro5+4ta+8SL
         q/og==
X-Gm-Message-State: AOJu0YxB84WOg7nXun8zWt9H9OTRWDs/Q0dOgnmVrWo5Z4HF438NbYgS
	vLK/Aqacd0Tpwdxqyf/KEuJCJT1ahsKc5l0A4uY0qhqfVguoTZwJAF1Rx/jHFjJh8SrhQT28+cZ
	R
X-Google-Smtp-Source: AGHT+IG69DJHDcmdiHD7SyEyLQpR/KoJw48t9mWYkz7+tg03DPrEL833+0HP3+shLqDeQu++rmN8Ew==
X-Received: by 2002:a05:620a:1787:b0:79d:5cd6:9f60 with SMTP id af79cd13be357-79d5cd6a4b1mr687435485a.67.1719601582013;
        Fri, 28 Jun 2024 12:06:22 -0700 (PDT)
Received: from xanadu (modemcable018.15-162-184.mc.videotron.ca. [184.162.15.18])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79d692999c0sm98393285a.65.2024.06.28.12.06.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 12:06:21 -0700 (PDT)
Date: Fri, 28 Jun 2024 15:06:20 -0400 (EDT)
From: Nicolas Pitre <npitre@baylibre.com>
To: Andrew Morton <akpm@linux-foundation.org>, 
    =?ISO-8859-15?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] mul_u64_u64_div_u64: make it precise always
Message-ID: <39o9pnn4-p22s-rp4p-067n-83s18o5prnpn@onlyvoer.pbz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

Library facilities must always return exact results. If the caller may
be contented with approximations then it should do the approximation on
its own.

In this particular case the comment in the code says "the algorithm
... might lose some precision". Well, if you try it with e.g.:

	a = 18446462598732840960
	b = 18446462598732840960
	c = 18446462598732840961

then the produced answer is 0 whereas the exact answer should be
18446462598732840959. This is _some_ precision loss indeed!

Let's reimplement this function so it always produces the exact result
regardless of its inputs while preserving existing fast paths
when possible.

Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
---
 lib/math/div64.c | 123 ++++++++++++++++++++++++++++++-----------------
 1 file changed, 80 insertions(+), 43 deletions(-)

diff --git a/lib/math/div64.c b/lib/math/div64.c
index 191761b1b6..03881ab418 100644
--- a/lib/math/div64.c
+++ b/lib/math/div64.c
@@ -186,55 +186,92 @@ EXPORT_SYMBOL(iter_div_u64_rem);
 #ifndef mul_u64_u64_div_u64
 u64 mul_u64_u64_div_u64(u64 a, u64 b, u64 c)
 {
-	u64 res = 0, div, rem;
-	int shift;
+	if (ilog2(a) + ilog2(b) <= 62)
+		return div64_u64(a * b, c);
 
-	/* can a * b overflow ? */
-	if (ilog2(a) + ilog2(b) > 62) {
-		/*
-		 * Note that the algorithm after the if block below might lose
-		 * some precision and the result is more exact for b > a. So
-		 * exchange a and b if a is bigger than b.
-		 *
-		 * For example with a = 43980465100800, b = 100000000, c = 1000000000
-		 * the below calculation doesn't modify b at all because div == 0
-		 * and then shift becomes 45 + 26 - 62 = 9 and so the result
-		 * becomes 4398035251080. However with a and b swapped the exact
-		 * result is calculated (i.e. 4398046510080).
-		 */
-		if (a > b)
-			swap(a, b);
+#if defined(__SIZEOF_INT128__)
+
+	/* native 64x64=128 bits multiplication */
+	unsigned __int128 prod = (unsigned __int128)a * b;
+	u64 n_lo = prod, n_hi = prod >> 64;
+
+#else
+
+	/* perform a 64x64=128 bits multiplication manually */
+	union {
+		u64 v;
+		struct {
+#if defined(CONFIG_CPU_LITTLE_ENDIAN)
+			u32 l;
+			u32 h;
+#elif defined(CONFIG_CPU_BIG_ENDIAN)
+			u32 h;
+			u32 l;
+#else
+#error "unknown endianness"
+#endif
+		};
+	} A, B, X, Y, Z;
+
+	A.v = a;
+	B.v = b;
+
+	X.v = (u64)A.l * B.l;
+	Y.v = (u64)A.l * B.h + X.h;
+	Z.v = (u64)A.h * B.h + Y.h;
+	Y.v = (u64)A.h * B.l + Y.l;
+	X.h = Y.l;
+	Z.v += Y.h;
+
+	u64 n_lo = X.v, n_hi = Z.v;
+
+#endif
 
+	int shift = __builtin_ctzll(c);
+
+	/* try reducing the fraction in case the dividend becomes <= 64 bits */
+	if ((n_hi >> shift) == 0) {
+		u64 n = (n_lo >> shift) | (n_hi << (64 - shift));
+
+		return div64_u64(n, c >> shift);
 		/*
-		 * (b * a) / c is equal to
-		 *
-		 *      (b / c) * a +
-		 *      (b % c) * a / c
-		 *
-		 * if nothing overflows. Can the 1st multiplication
-		 * overflow? Yes, but we do not care: this can only
-		 * happen if the end result can't fit in u64 anyway.
-		 *
-		 * So the code below does
-		 *
-		 *      res = (b / c) * a;
-		 *      b = b % c;
+		 * The remainder value if needed would be:
+		 *   res = div64_u64_rem(n, c >> shift, &rem);
+		 *   rem = (rem << shift) + (n_lo - (n << shift));
 		 */
-		div = div64_u64_rem(b, c, &rem);
-		res = div * a;
-		b = rem;
-
-		shift = ilog2(a) + ilog2(b) - 62;
-		if (shift > 0) {
-			/* drop precision */
-			b >>= shift;
-			c >>= shift;
-			if (!c)
-				return res;
-		}
 	}
 
-	return res + div64_u64(a * b, c);
+	if (n_hi >= c) {
+		/* overflow: result is unrepresentable in a u64 */
+		return -1;
+	}
+
+	/* Do the full 128 by 64 bits division */
+
+	shift = __builtin_clzll(c);
+	c <<= shift;
+
+	int p = 64 + shift;
+	u64 res = 0;
+	bool carry;
+
+	do {
+		carry = n_hi >> 63;
+		shift = carry ? 1 : __builtin_clzll(n_hi);
+		if (p < shift)
+			break;
+		p -= shift;
+		n_hi <<= shift;
+		n_hi |= n_lo >> (64 - shift);
+		n_lo <<= shift;
+		if (carry || (n_hi >= c)) {
+			n_hi -= c;
+			res |= 1ULL << p;
+		}
+	} while (n_hi);
+	/* The remainder value if needed would be n_hi << p */
+
+	return res;
 }
 EXPORT_SYMBOL(mul_u64_u64_div_u64);
 #endif
-- 
2.45.2


