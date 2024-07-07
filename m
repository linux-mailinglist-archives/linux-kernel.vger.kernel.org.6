Return-Path: <linux-kernel+bounces-243707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DFBBE929969
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 21:07:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D1EC1F2125C
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 19:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C126C6F30F;
	Sun,  7 Jul 2024 19:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="RvCMm0hU";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="cqswCqqi"
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5A25588B
	for <linux-kernel@vger.kernel.org>; Sun,  7 Jul 2024 19:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720379227; cv=none; b=Z2yv7Lf8YVytPTIbc1WCmBLsf61R6XFPlnp9sS4NY8ttCG778QYq0qksyFNO49/pwmtc08NHAZhTCyryutGyHBlvOORm4sx4Voc3QAznCXPPEDDXV5bhosDy0jThPFBDMqzy47Cmh0pRaR7MNc34FvzhntAEioKyLGvKs17dnL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720379227; c=relaxed/simple;
	bh=6kW25pg6VPwOxN0PpF7KB3SJguMNccZ4U3jj4C23kcc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lNLYsu9OPLWyGsCnArRMpu1w3p3cx1Z5E35Ktw1AEtdNW24uDVIKeQZTePUsizJTFqBkeCNtUKF6r7ZyHYxcWX8GCqvvyuFMSLz8kGj0LcRhdW+MdHdxJYS+3iIAknJfrhvw9NLHTu9szCz5/EarUfLh0yrpqD3mfFJCrNPMv00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fluxnic.net; spf=pass smtp.mailfrom=fluxnic.net; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=RvCMm0hU; dkim=fail (1024-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b=cqswCqqi reason="signature verification failed"; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 2A98D32D97;
	Sun,  7 Jul 2024 15:07:00 -0400 (EDT)
	(envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=6kW25pg6VPwO
	xN0PpF7KB3SJguMNccZ4U3jj4C23kcc=; b=RvCMm0hUqJXJjAewrYJKbI5g0PJV
	+tocvkBu2Zc4j6SLLej5nxckXdiYHauVvlaAXqkScod7TjaxH+l38QPjE/eLT3bW
	oL+ZCURrdooyFpgXhngeUzFz1ARDN0A8SzID/v+dNu/DN3aahCDxN4FFF+zayKZ5
	LooRsm5sHFI2Lag=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 23FB332D96;
	Sun,  7 Jul 2024 15:07:00 -0400 (EDT)
	(envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=fluxnic.net;
 h=from:to:cc:subject:date:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=2016-12.pbsmtp; bh=tp8lbijNKahXKUhHOOemSyS81f5Q5sXhy0yV3icmOLs=; b=cqswCqqi7ImjMCPCdUNnHAIenSp/Gl4+n049XGJJ0OlHr8klK3Y5FCxTL6LozKNEVcxNYqYB71wW5E3a7OLi3+qh5bebLv3S6bRMOJWlUwDBmNrMwD9dtGg+lGTB+hZ8xsE2Hn91uxdpzrbgCV+K5Vm3zkj2VggpF09VW/zQ5us=
Received: from yoda.fluxnic.net (unknown [184.162.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 1869732D92;
	Sun,  7 Jul 2024 15:06:56 -0400 (EDT)
	(envelope-from nico@fluxnic.net)
Received: from xanadu.lan (OpenWrt.lan [192.168.1.1])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id CB977D3B4E2;
	Sun,  7 Jul 2024 15:06:53 -0400 (EDT)
From: Nicolas Pitre <nico@fluxnic.net>
To: Andrew Morton <akpm@linux-foundation.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Nicolas Pitre <npitre@baylibre.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] mul_u64_u64_div_u64: make it precise always
Date: Sun,  7 Jul 2024 15:05:19 -0400
Message-ID: <20240707190648.1982714-2-nico@fluxnic.net>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240707190648.1982714-1-nico@fluxnic.net>
References: <20240707190648.1982714-1-nico@fluxnic.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Pobox-Relay-ID:
 140FC1A4-3C94-11EF-ADB1-DFF1FEA446E2-78420484!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable

From: Nicolas Pitre <npitre@baylibre.com>

Library facilities must always return exact results. If the caller may
be contented with approximations then it should do the approximation on
its own.

In this particular case the comment in the code says "the algorithm
... below might lose some precision". Well, if you try it with e.g.:

	a =3D 18446462598732840960
	b =3D 18446462598732840960
	c =3D 18446462598732840961

then the produced answer is 0 whereas the exact answer should be
18446462598732840959. This is _some_ precision lost indeed!

Let's reimplement this function so it always produces the exact result
regardless of its inputs while preserving existing fast paths
when possible.

Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
Tested-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com>
Tested-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 lib/math/div64.c | 108 ++++++++++++++++++++++++++++-------------------
 1 file changed, 65 insertions(+), 43 deletions(-)

diff --git a/lib/math/div64.c b/lib/math/div64.c
index 191761b1b6..b7fc752463 100644
--- a/lib/math/div64.c
+++ b/lib/math/div64.c
@@ -186,55 +186,77 @@ EXPORT_SYMBOL(iter_div_u64_rem);
 #ifndef mul_u64_u64_div_u64
 u64 mul_u64_u64_div_u64(u64 a, u64 b, u64 c)
 {
-	u64 res =3D 0, div, rem;
-	int shift;
+	if (ilog2(a) + ilog2(b) <=3D 62)
+		return div64_u64(a * b, c);
=20
-	/* can a * b overflow ? */
-	if (ilog2(a) + ilog2(b) > 62) {
-		/*
-		 * Note that the algorithm after the if block below might lose
-		 * some precision and the result is more exact for b > a. So
-		 * exchange a and b if a is bigger than b.
-		 *
-		 * For example with a =3D 43980465100800, b =3D 100000000, c =3D 10000=
00000
-		 * the below calculation doesn't modify b at all because div =3D=3D 0
-		 * and then shift becomes 45 + 26 - 62 =3D 9 and so the result
-		 * becomes 4398035251080. However with a and b swapped the exact
-		 * result is calculated (i.e. 4398046510080).
-		 */
-		if (a > b)
-			swap(a, b);
+#if defined(__SIZEOF_INT128__)
+
+	/* native 64x64=3D128 bits multiplication */
+	u128 prod =3D (u128)a * b;
+	u64 n_lo =3D prod, n_hi =3D prod >> 64;
+
+#else
+
+	/* perform a 64x64=3D128 bits multiplication manually */
+	u32 a_lo =3D a, a_hi =3D a >> 32, b_lo =3D b, b_hi =3D b >> 32;
+	u64 x, y, z;
+
+	x =3D (u64)a_lo * b_lo;
+	y =3D (u64)a_lo * b_hi + (u32)(x >> 32);
+	z =3D (u64)a_hi * b_hi + (u32)(y >> 32);
+	y =3D (u64)a_hi * b_lo + (u32)y;
+	z +=3D (u32)(y >> 32);
+	x =3D (y << 32) + (u32)x;
+
+	u64 n_lo =3D x, n_hi =3D z;
+
+#endif
+
+	int shift =3D __builtin_ctzll(c);
=20
+	/* try reducing the fraction in case the dividend becomes <=3D 64 bits =
*/
+	if ((n_hi >> shift) =3D=3D 0) {
+		u64 n =3D (n_lo >> shift) | (n_hi << (64 - shift));
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
-		 *      res =3D (b / c) * a;
-		 *      b =3D b % c;
+		 * The remainder value if needed would be:
+		 *   res =3D div64_u64_rem(n, c >> shift, &rem);
+		 *   rem =3D (rem << shift) + (n_lo - (n << shift));
 		 */
-		div =3D div64_u64_rem(b, c, &rem);
-		res =3D div * a;
-		b =3D rem;
-
-		shift =3D ilog2(a) + ilog2(b) - 62;
-		if (shift > 0) {
-			/* drop precision */
-			b >>=3D shift;
-			c >>=3D shift;
-			if (!c)
-				return res;
-		}
 	}
=20
-	return res + div64_u64(a * b, c);
+	if (n_hi >=3D c) {
+		/* overflow: result is unrepresentable in a u64 */
+		return -1;
+	}
+
+	/* Do the full 128 by 64 bits division */
+
+	shift =3D __builtin_clzll(c);
+	c <<=3D shift;
+
+	int p =3D 64 + shift;
+	u64 res =3D 0;
+	bool carry;
+
+	do {
+		carry =3D n_hi >> 63;
+		shift =3D carry ? 1 : __builtin_clzll(n_hi);
+		if (p < shift)
+			break;
+		p -=3D shift;
+		n_hi <<=3D shift;
+		n_hi |=3D n_lo >> (64 - shift);
+		n_lo <<=3D shift;
+		if (carry || (n_hi >=3D c)) {
+			n_hi -=3D c;
+			res |=3D 1ULL << p;
+		}
+	} while (n_hi);
+	/* The remainder value if needed would be n_hi << p */
+
+	return res;
 }
 EXPORT_SYMBOL(mul_u64_u64_div_u64);
 #endif
--=20
2.45.2


