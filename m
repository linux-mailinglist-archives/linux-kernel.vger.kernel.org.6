Return-Path: <linux-kernel+bounces-337154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C446D984600
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 14:33:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E72F91C22E01
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 12:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52EF01AAE0F;
	Tue, 24 Sep 2024 12:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e/a/X+6K"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A29ED1A704B
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 12:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727181168; cv=none; b=leQJ5+UuAjMTjqBShSauSnFsRfPQyb6PPOReGHTwigbgx2cLHjU3FmkduIHFNp/bknh42X8for8QwUoDOZxwmyw5zpc1Gw7CTnet4LzOpsHsknO9gOMx3C2wtDVqP5sdUrHxcefzBxVliu7AYJXBDYVMUeb3o6Al0w/Np1Gb/TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727181168; c=relaxed/simple;
	bh=QNKItu6CdIakAOu8t/P7mCLBm64PWWxflE4fgw4oi3g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cNCHkcv2mU7wMz2+rEZr9jrBh6ptnXczCezSFa0HtslhrKff4+c/SYJEqfF/qCxXkCwpprX9lw4XmiYBbBVQoulnB44VavXl958ue00Hp+C5bVi/zV5CGvExDI3Y6zBsHWqYbzmv7EUp05LHOz/ES7G7cjcfjl1t2KevZGab5Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e/a/X+6K; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-719ba0654f9so1847868b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 05:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727181166; x=1727785966; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/EBQ39GffQsZFZpD0Yw16lUj/HxiDKUxWG4rj+AWg4M=;
        b=e/a/X+6KflmeZM8pMKVqvjPCYM8boze5n+DB4UVhUvWi9IKb285DN2zuskzNtUtVcJ
         4AT7WhBNhGuO72UnJ90pzq0NG+Df4Khn76swojhZSBT5qL9AtRq6xaxP2Tbl+UQEZ+2n
         Sv2wqWoj601S+ac335ZZACMGzCi4EzUhK9Ku3I9Od3U3oUsAqBDCaVOZZIRLIOqNdNfQ
         u0ybpdAMs8NuFpuHe1/8s8mNIjUZEW45LSbzK8Bxd6kuXM5Q1Gv825EFgtAaGfQN1kCE
         U1Ufdv3nKK7AMrRiJs+AlBhJNDQ/O+0m87jSFtgUQL0j2H0OYv5iAOnvF75Y35dG+2aT
         aqaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727181166; x=1727785966;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/EBQ39GffQsZFZpD0Yw16lUj/HxiDKUxWG4rj+AWg4M=;
        b=OW+R0puVe0eKvxw4kfa84Ztwz/MtRwsf6PfgVMsZszcDKkDWkB8+AgR98H5kzKNWLE
         Ons7f4BGVzxD/MxqfGcfRVdKiUt9P+zlvERAgZj02xtgAuy3FmAiHsBI153sAWgnnBMh
         t4heJqmrmqazJYEJdgAYuiQZDM70NIbMf1M4fZaCTMXN6G/RzmqakFCBG3xxf+099SKI
         sn1uU7k53NngTi2hJl77h4OL/Jz4E+2mDFuBYEaBZpwPhhwXVvkY7gTpZerqSh7OQOAx
         unWk5ekIDg1MAgw4TzlWfiT0jA77QAsaaiQpgIJviZXEwzrtJT7lFRWbEeRmfudM4YPx
         aNzg==
X-Forwarded-Encrypted: i=1; AJvYcCV1I1Py4P6tpEEydsmjsuwsx1QL99fRZ2y8yxRNqi7EUTBNHab3Rw1fWhIsPEneDQI8hl2N6UTU1NlyyEY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxz3sfLkccx811oTzJz5kcIKJpw8pYyFvrqZHC7vLy3cecx4VzG
	Wyu+EmraKjEtlc0jwhv9HgC5WP63Arl29r72DyEJCVG6K/GVkx35TdMBsuZQ
X-Google-Smtp-Source: AGHT+IGCSqf1DBXQ7C8vsjx2/P5PZ6pstXz6iz89pk6/TkaeZX/BxgiAbUeFbe/aJaiNKsjLhXVksg==
X-Received: by 2002:a05:6a20:cf8f:b0:1cf:2513:89f9 with SMTP id adf61e73a8af0-1d30aa0c5aemr17606608637.39.1727181165709;
        Tue, 24 Sep 2024 05:32:45 -0700 (PDT)
Received: from localhost.localdomain (ec2-13-113-80-70.ap-northeast-1.compute.amazonaws.com. [13.113.80.70])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71afc9c5ad4sm1115566b3a.188.2024.09.24.05.32.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 05:32:44 -0700 (PDT)
From: Zhang Boyang <zhangboyang.id@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Ferdinand Blomqvist <ferdinand.blomqvist@gmail.com>,
	Kees Cook <keescook@chromium.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Zhang Boyang <zhangboyang.id@gmail.com>
Subject: [PATCH 5/5] rslib: Fix 16-bit symbol support
Date: Tue, 24 Sep 2024 20:31:41 +0800
Message-Id: <20240924123141.16962-6-zhangboyang.id@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240924123141.16962-1-zhangboyang.id@gmail.com>
References: <20240924123141.16962-1-zhangboyang.id@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Current rslib support symsize up to 16, so the max value of rs->nn can
be up to 0xFFFF. Since fcr <= nn, prim <= nn, multiplications on them
might overflow and lead to wrong results, e.g. fcr*root[j], fcr*prim.

This patch fixes these overflows by introducing rs_modnn_mul(a, b). This
function is same as rs_modnn(a*b) but it avoids overflow when
calculating a*b. It requires 0 <= a <= nn && 0 <= b <= nn. As it use
uint32_t to do the multiplication internally, there will be no overflow
as long as 0 <= a <= nn <= 0xFFFF && 0 <= b <= nn <= 0xFFFF. In fact, if
we use `unsigned int' everywhere, there is no need to introduce
rs_modnn_mul(). But the `unsigned int' approach has poor scalability and
it may bring us to the mess of signed and unsigned integers.

With rs_modnn(), the intermediate result is now restricted to [0, nn).
This enables us to use rs_modnn_fast(a+b) to replace rs_modnn(a+b), as
long as 0 <= a+b < 2*nn. The most common case is one addend in [0, nn]
and the other addend in [0, nn). The examples of values in [0, nn] are
fcr, prim, indexes taken from rs->index_of[0...nn], etc. The examples of
values in [0, nn) are results from rs_modnn(), indexes taken from
rs->index_of[1...nn], etc.

Since the roots of RS generator polynomial, i.e. (fcr+i)*prim%nn, is
often used. It's now precomputed into rs->genroot[], to avoid writing
rs_modnn_mul(rs, rs_modnn_fast(rs, fcr + i), prim) everywhere.

The algorithm of searching for rs->iprim is also changed. Instead of
searching for (1+what*nn)%prim == 0, then iprim = (1+what*nn)/prim, it
now searches for iprim*prim%nn == 1 directly.

A new test case is also added to test_rslib.c to ensure correctness.

Signed-off-by: Zhang Boyang <zhangboyang.id@gmail.com>
---
 include/linux/rslib.h           | 23 +++++++++++++
 lib/reed_solomon/decode_rs.c    | 60 +++++++++++++++++++--------------
 lib/reed_solomon/reed_solomon.c | 28 +++++++++++----
 lib/reed_solomon/test_rslib.c   |  8 ++---
 4 files changed, 82 insertions(+), 37 deletions(-)

diff --git a/include/linux/rslib.h b/include/linux/rslib.h
index d228ece01069..4fb27d5bdb55 100644
--- a/include/linux/rslib.h
+++ b/include/linux/rslib.h
@@ -21,6 +21,7 @@
  * @alpha_to:	Antilog lookup table
  * @index_of:	log lookup table
  * @genpoly:	Generator polynomial
+ * @genroot:	Roots of generator polynomial, index form
  * @nroots:	Number of generator roots = number of parity symbols
  * @fcr:	First consecutive root, index form
  * @prim:	Primitive element, index form
@@ -36,6 +37,7 @@ struct rs_codec {
 	uint16_t	*alpha_to;
 	uint16_t	*index_of;
 	uint16_t	*genpoly;
+	uint16_t	*genroot;
 	int		nroots;
 	int		fcr;
 	int		prim;
@@ -127,6 +129,27 @@ static inline int rs_modnn(struct rs_codec *rs, int x)
 	return x;
 }
 
+/**
+ * rs_modnn_mul() - Modulo replacement for galois field arithmetics
+ *
+ *  @rs:	Pointer to the RS codec
+ *  @a:		a*b is the value to reduce (requires 0 <= a <= nn <= 0xFFFF)
+ *  @b:		a*b is the value to reduce (requires 0 <= b <= nn <= 0xFFFF)
+ *
+ *  Same as rs_modnn(a*b), but avoid integer overflow when calculating a*b
+*/
+static inline int rs_modnn_mul(struct rs_codec *rs, int a, int b)
+{
+	/* nn <= 0xFFFF, so (a * b) will not overflow uint32_t */
+	uint32_t x = (uint32_t)a * (uint32_t)b;
+	uint32_t nn = (uint32_t)rs->nn;
+	while (x >= nn) {
+		x -= nn;
+		x = (x >> rs->mm) + (x & nn);
+	}
+	return (int)x;
+}
+
 /**
  * rs_modnn_fast() - Modulo replacement for galois field arithmetics
  *
diff --git a/lib/reed_solomon/decode_rs.c b/lib/reed_solomon/decode_rs.c
index 6c1d53d1b702..3387465ab429 100644
--- a/lib/reed_solomon/decode_rs.c
+++ b/lib/reed_solomon/decode_rs.c
@@ -20,6 +20,7 @@
 	int iprim = rs->iprim;
 	uint16_t *alpha_to = rs->alpha_to;
 	uint16_t *index_of = rs->index_of;
+	uint16_t *genroot = rs->genroot;
 	uint16_t u, q, tmp, num1, num2, den, discr_r, syn_error;
 	int count = 0;
 	int num_corrected;
@@ -69,8 +70,8 @@
 			} else {
 				syn[i] = ((((uint16_t) data[j]) ^
 					   invmsk) & msk) ^
-					alpha_to[rs_modnn(rs, index_of[syn[i]] +
-						       (fcr + i) * prim)];
+					alpha_to[rs_modnn_fast(rs,
+						index_of[syn[i]] + genroot[i])];
 			}
 		}
 	}
@@ -81,8 +82,8 @@
 				syn[i] = ((uint16_t) par[j]) & msk;
 			} else {
 				syn[i] = (((uint16_t) par[j]) & msk) ^
-					alpha_to[rs_modnn(rs, index_of[syn[i]] +
-						       (fcr+i)*prim)];
+					alpha_to[rs_modnn_fast(rs,
+						index_of[syn[i]] + genroot[i])];
 			}
 		}
 	}
@@ -108,15 +109,17 @@
 
 	if (no_eras > 0) {
 		/* Init lambda to be the erasure locator polynomial */
-		lambda[1] = alpha_to[rs_modnn(rs,
-					prim * (nn - 1 - (eras_pos[0] + pad)))];
+		lambda[1] = alpha_to[rs_modnn_mul(rs,
+					 prim, (nn - 1 - (eras_pos[0] + pad)))];
 		for (i = 1; i < no_eras; i++) {
-			u = rs_modnn(rs, prim * (nn - 1 - (eras_pos[i] + pad)));
+			u = rs_modnn_mul(rs,
+					 prim, (nn - 1 - (eras_pos[i] + pad)));
 			for (j = i + 1; j > 0; j--) {
 				tmp = index_of[lambda[j - 1]];
 				if (tmp != nn) {
 					lambda[j] ^=
-						alpha_to[rs_modnn(rs, u + tmp)];
+						alpha_to[rs_modnn_fast(rs,
+							 u + tmp)];
 				}
 			}
 		}
@@ -137,9 +140,9 @@
 		for (i = 0; i < r; i++) {
 			if ((lambda[i] != 0) && (s[r - i - 1] != nn)) {
 				discr_r ^=
-					alpha_to[rs_modnn(rs,
-							  index_of[lambda[i]] +
-							  s[r - i - 1])];
+					alpha_to[rs_modnn_fast(rs,
+						 index_of[lambda[i]] +
+						 s[r - i - 1])];
 			}
 		}
 		discr_r = index_of[discr_r];	/* Index form */
@@ -153,8 +156,8 @@
 			for (i = 0; i < nroots; i++) {
 				if (b[i] != nn) {
 					t[i + 1] = lambda[i + 1] ^
-						alpha_to[rs_modnn(rs, discr_r +
-								  b[i])];
+						alpha_to[rs_modnn_fast(rs,
+							 discr_r + b[i])];
 				} else
 					t[i + 1] = lambda[i + 1];
 			}
@@ -166,8 +169,9 @@
 				 */
 				for (i = 0; i <= nroots; i++) {
 					b[i] = (lambda[i] == 0) ? nn :
-						rs_modnn(rs, index_of[lambda[i]]
-							 - discr_r + nn);
+						rs_modnn_fast(rs,
+						        index_of[lambda[i]] +
+							nn - discr_r);
 				}
 			} else {
 				/* 2 lines below: B(x) <-- x*B(x) */
@@ -197,11 +201,11 @@
 	/* Find roots of error+erasure locator polynomial by Chien search */
 	memcpy(&reg[1], &lambda[1], nroots * sizeof(reg[0]));
 	count = 0;		/* Number of roots of lambda(x) */
-	for (i = 1, k = iprim - 1; i <= nn; i++, k = rs_modnn(rs, k + iprim)) {
+	for (i = 1, k = iprim-1; i <= nn; i++, k = rs_modnn_fast(rs, k+iprim)) {
 		q = alpha_to[0];	/* lambda[0] is always 0 */
 		for (j = deg_lambda; j > 0; j--) {
 			if (reg[j] != nn) {
-				reg[j] = rs_modnn(rs, reg[j] + j);
+				reg[j] = rs_modnn_fast(rs, reg[j] + j);
 				q ^= alpha_to[reg[j]];
 			}
 		}
@@ -238,8 +242,8 @@
 		tmp = 0;
 		for (j = i; j >= 0; j--) {
 			if ((s[i - j] != nn) && (lambda[j] != nn))
-				tmp ^=
-				    alpha_to[rs_modnn(rs, s[i - j] + lambda[j])];
+				tmp ^= alpha_to[rs_modnn_fast(rs,
+						s[i - j] + lambda[j])];
 		}
 		omega[i] = index_of[tmp];
 	}
@@ -254,8 +258,9 @@
 		num1 = 0;
 		for (i = deg_omega; i >= 0; i--) {
 			if (omega[i] != nn)
-				num1 ^= alpha_to[rs_modnn(rs, omega[i] +
-							i * root[j])];
+				num1 ^= alpha_to[rs_modnn_fast(rs,
+						 omega[i] +
+						 rs_modnn_mul(rs, i, root[j]))];
 		}
 
 		if (num1 == 0) {
@@ -264,15 +269,18 @@
 			continue;
 		}
 
-		num2 = alpha_to[rs_modnn(rs, root[j] * (fcr - 1) + nn)];
+		num2 = alpha_to[rs_modnn_fast(rs,
+				rs_modnn_mul(rs, root[j], fcr) +
+				nn - root[j])];
 		den = 0;
 
 		/* lambda[i+1] for i even is the formal derivative
 		 * lambda_pr of lambda[i] */
 		for (i = min(deg_lambda, nroots - 1) & ~1; i >= 0; i -= 2) {
 			if (lambda[i + 1] != nn) {
-				den ^= alpha_to[rs_modnn(rs, lambda[i + 1] +
-						       i * root[j])];
+				den ^= alpha_to[rs_modnn_fast(rs,
+						lambda[i + 1] +
+						rs_modnn_mul(rs, i, root[j]))];
 			}
 		}
 
@@ -292,8 +300,8 @@
 			if (b[j] == 0)
 				continue;
 
-			k = (fcr + i) * prim * (nn-loc[j]-1);
-			tmp ^= alpha_to[rs_modnn(rs, index_of[b[j]] + k)];
+			k = rs_modnn_mul(rs, genroot[i], nn - loc[j] - 1);
+			tmp ^= alpha_to[rs_modnn_fast(rs, index_of[b[j]] + k)];
 		}
 
 		if (tmp != alpha_to[s[i]])
diff --git a/lib/reed_solomon/reed_solomon.c b/lib/reed_solomon/reed_solomon.c
index bb4f44c8edba..b924eeb98685 100644
--- a/lib/reed_solomon/reed_solomon.c
+++ b/lib/reed_solomon/reed_solomon.c
@@ -56,7 +56,7 @@ static DEFINE_MUTEX(rslistlock);
 
 /**
  * codec_init - Initialize a Reed-Solomon codec
- * @symsize:	symbol size, bits (1-8)
+ * @symsize:	symbol size, bits (1-16)
  * @gfpoly:	Field generator polynomial coefficients
  * @gffunc:	Field generator function
  * @fcr:	first root of RS code generator polynomial, index form
@@ -100,6 +100,10 @@ static struct rs_codec *codec_init(int symsize, int gfpoly, int (*gffunc)(int),
 	if(rs->genpoly == NULL)
 		goto err;
 
+	rs->genroot = kmalloc_array(rs->nroots, sizeof(uint16_t), gfp);
+	if(rs->genroot == NULL)
+		goto err;
+
 	/* Generate Galois field lookup tables */
 	rs->index_of[0] = rs->nn;	/* log(zero) = -inf */
 	rs->alpha_to[rs->nn] = 0;	/* alpha**-inf = 0 */
@@ -126,26 +130,34 @@ static struct rs_codec *codec_init(int symsize, int gfpoly, int (*gffunc)(int),
 		goto err;
 
 	/* Find prim-th root of 1, used in decoding */
-	for(iprim = 1; (iprim % prim) != 0; iprim += rs->nn);
+	for (iprim = 1; rs_modnn_mul(rs, iprim, prim) != 1; iprim++);
 	/* prim-th root of 1, index form */
-	rs->iprim = iprim / prim;
+	rs->iprim = iprim;
+
+	/* Precompute generator polynomial roots */
+	root = rs_modnn_mul(rs, fcr, prim);
+	for (i = 0; i < nroots; i++) {
+		rs->genroot[i] = root; /*  = (fcr + i) * prim % nn  */
+		root = rs_modnn_fast(rs, root + prim);
+	}
 
 	/* Form RS code generator polynomial from its roots */
 	rs->genpoly[0] = rs->alpha_to[0];
-	for (i = 0, root = fcr * prim; i < nroots; i++, root += prim) {
+	for (i = 0; i < nroots; i++) {
+		root = rs->genroot[i];
 		rs->genpoly[i + 1] = rs->alpha_to[0];
 		/* Multiply rs->genpoly[] by  @**(root + x) */
 		for (j = i; j > 0; j--) {
 			if (rs->genpoly[j] != 0) {
-				rs->genpoly[j] = rs->genpoly[j -1] ^
-					rs->alpha_to[rs_modnn(rs,
+				rs->genpoly[j] = rs->genpoly[j - 1] ^
+					rs->alpha_to[rs_modnn_fast(rs,
 					rs->index_of[rs->genpoly[j]] + root)];
 			} else
 				rs->genpoly[j] = rs->genpoly[j - 1];
 		}
 		/* rs->genpoly[0] can never be zero */
 		rs->genpoly[0] =
-			rs->alpha_to[rs_modnn(rs,
+			rs->alpha_to[rs_modnn_fast(rs,
 				rs->index_of[rs->genpoly[0]] + root)];
 	}
 	/* convert rs->genpoly[] to index form for quicker encoding */
@@ -157,6 +169,7 @@ static struct rs_codec *codec_init(int symsize, int gfpoly, int (*gffunc)(int),
 	return rs;
 
 err:
+	kfree(rs->genroot);
 	kfree(rs->genpoly);
 	kfree(rs->index_of);
 	kfree(rs->alpha_to);
@@ -188,6 +201,7 @@ void free_rs(struct rs_control *rs)
 		kfree(cd->alpha_to);
 		kfree(cd->index_of);
 		kfree(cd->genpoly);
+		kfree(cd->genroot);
 		kfree(cd);
 	}
 	mutex_unlock(&rslistlock);
diff --git a/lib/reed_solomon/test_rslib.c b/lib/reed_solomon/test_rslib.c
index 75cb1adac884..d19c95bcd31d 100644
--- a/lib/reed_solomon/test_rslib.c
+++ b/lib/reed_solomon/test_rslib.c
@@ -55,6 +55,7 @@ static struct etab Tab[] = {
 	{8,	0x11d,	1,	1,	30,	100	},
 	{8,	0x187,	112,	11,	32,	100	},
 	{9,	0x211,	1,	1,	33,	80	},
+	{16,  0x1ffed,	65534,	65534,	50,	5	},
 	{0, 0, 0, 0, 0, 0},
 };
 
@@ -232,9 +233,8 @@ static void compute_syndrome(struct rs_control *rsc, uint16_t *data,
 	struct rs_codec *rs = rsc->codec;
 	uint16_t *alpha_to = rs->alpha_to;
 	uint16_t *index_of = rs->index_of;
+	uint16_t *genroot = rs->genroot;
 	int nroots = rs->nroots;
-	int prim = rs->prim;
-	int fcr = rs->fcr;
 	int i, j;
 
 	/* Calculating syndrome */
@@ -245,8 +245,8 @@ static void compute_syndrome(struct rs_control *rsc, uint16_t *data,
 				syn[i] = data[j];
 			} else {
 				syn[i] = data[j] ^
-					alpha_to[rs_modnn(rs, index_of[syn[i]]
-						+ (fcr + i) * prim)];
+					alpha_to[rs_modnn_fast(rs,
+						index_of[syn[i]] + genroot[i])];
 			}
 		}
 	}
-- 
2.30.2


