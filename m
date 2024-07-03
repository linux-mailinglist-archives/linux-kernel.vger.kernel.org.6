Return-Path: <linux-kernel+bounces-238759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DEC75924FA4
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 05:37:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 748A51F275EF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 03:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FACE328A0;
	Wed,  3 Jul 2024 03:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="uGV7433j";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="dh0x2uHc"
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B1D1B95B
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 03:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719977776; cv=none; b=Z6Wwr7blxWXpbVTqd4G6hEb+Cdmll+Sn/cuicckG9f7tjjOJpgpfXKV6BSL9CpO0dAcjoVBHsGn2bton4KDy1szdvPA0ZOAHyaN4ANvRenNBszZxlDzxbn/oiVyhtaNjh3VN0M7fRYNIlujCnYHJvX5B0vm9D7vs2MUK7TyO49w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719977776; c=relaxed/simple;
	bh=lT6RLash4CuN3+zZ6rbgyUfZ76/w+P195UNSoGYglbo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bHI2Zpv9ODgKRPEKN0KS23mIKbIfXnJWmVm0MSR9ATD1aywV5hp5ZZPD024R/HtVVaLAY2+wao0C6MHaiJ2gbS5JMl7UXKfcJcZR+CORvSgDm6PbdlMxjY8QAnQas7jsI5oh1d3E5B0NWhOjNHipePRtpJ44C5g5d8m8f+j9EjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fluxnic.net; spf=pass smtp.mailfrom=fluxnic.net; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=uGV7433j; dkim=fail (1024-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b=dh0x2uHc reason="signature verification failed"; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C64A3267C5;
	Tue,  2 Jul 2024 23:36:07 -0400 (EDT)
	(envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=sasl; bh=lT6RLash4CuN3+zZ6rbgyUfZ7
	6/w+P195UNSoGYglbo=; b=uGV7433jTOoOJB3xeIdLOCMF8Spz+4r6+Vf7FNi5/
	jlIF0GM6GPp6fiTeyayih8J+L8e4jgFu0C1qS9nr6FkdMZsqujkBn0H0v+mgMOxq
	xHHAVf0mkT2j1Q4Ds7cX/ZjZBAce56fOZvJyECVY8Ywtnj/k5LCReEALXMtI2/rK
	oQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id AAD03267C3;
	Tue,  2 Jul 2024 23:36:07 -0400 (EDT)
	(envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=fluxnic.net;
 h=from:to:cc:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=2016-12.pbsmtp; bh=Ki3nGTnd4PRSQbxSrHxnHZO3kQnZkmIeaAixDyp7MUM=; b=dh0x2uHcJqj73tlGF/O3ozza5LYBse1jN7tlNadeBYSHtrEAp4nsZEX4DBZ5XAUik7/F/+Q087w/WSVOtSyn+EHK1knByU9Qs1Q+i4gsrGA8DO3UjQz7aGhWlhsMMTsctCg8X3ahwlPVu5MvdeCd34wZgJRW+oOJK1Xhnw7jfFk=
Received: from yoda.fluxnic.net (unknown [184.162.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 074DA267C2;
	Tue,  2 Jul 2024 23:36:07 -0400 (EDT)
	(envelope-from nico@fluxnic.net)
Received: from xanadu.lan (OpenWrt.lan [192.168.1.1])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id 8C644D31181;
	Tue,  2 Jul 2024 23:36:05 -0400 (EDT)
From: Nicolas Pitre <nico@fluxnic.net>
To: Andrew Morton <akpm@linux-foundation.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Nicolas Pitre <npitre@baylibre.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] mul_u64_u64_div_u64: make it precise always
Date: Tue,  2 Jul 2024 23:34:08 -0400
Message-ID: <20240703033552.906852-2-nico@fluxnic.net>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240703033552.906852-1-nico@fluxnic.net>
References: <20240703033552.906852-1-nico@fluxnic.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Pobox-Relay-ID:
 61C4FC20-38ED-11EF-BF38-5B6DE52EC81B-78420484!pb-smtp1.pobox.com
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
---
 lib/math/div64.c | 123 ++++++++++++++++++++++++++++++-----------------
 1 file changed, 80 insertions(+), 43 deletions(-)

diff --git a/lib/math/div64.c b/lib/math/div64.c
index 191761b1b6..dd461b3973 100644
--- a/lib/math/div64.c
+++ b/lib/math/div64.c
@@ -186,55 +186,92 @@ EXPORT_SYMBOL(iter_div_u64_rem);
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
+	A.v =3D a;
+	B.v =3D b;
+
+	X.v =3D (u64)A.l * B.l;
+	Y.v =3D (u64)A.l * B.h + X.h;
+	Z.v =3D (u64)A.h * B.h + Y.h;
+	Y.v =3D (u64)A.h * B.l + Y.l;
+	X.h =3D Y.l;
+	Z.v +=3D Y.h;
+
+	u64 n_lo =3D X.v, n_hi =3D Z.v;
+
+#endif
=20
+	int shift =3D __builtin_ctzll(c);
+
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


