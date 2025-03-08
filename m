Return-Path: <linux-kernel+bounces-552394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 54BFEA57984
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 10:34:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9B787A8397
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 09:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 194091ABEC5;
	Sat,  8 Mar 2025 09:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kvZ5JG54"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE8817A311
	for <linux-kernel@vger.kernel.org>; Sat,  8 Mar 2025 09:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741426478; cv=none; b=GQszj3y5LVpDTtW5YPRlJdXMevvDD/EBzMaxXOihcdzC0/1NvU4MU39PiQ1IUGS4yE9dINFJq5dOJ+zBQqjP2+8efHmIaV5HOMi8UiKTYo3/+7I+AAO7c3hS5tjKx71ScfB7VRiWKFMGbE5vbJzPOtpRFWC3gRs6nWcAcoNZeUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741426478; c=relaxed/simple;
	bh=AEQke3iaJcEGCk8IGcfYNyhfdxGPTniHtJn0Lphxmi8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ajxuGe2JzvEUneI9J+u7IVQLgXpKYu0uh/FyEd6eQEfA/mXSehCQkfG2vO+HMRBW4cY4hn0F14+Q0LGSkyU9soedi8uv6cvgAw0u9+8XPcen/fEHeWGZpuoo3MjmWtTstUbyrn2GigSUmP3kschmqPcyR9bG7szHYdlKDxwSrF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kvZ5JG54; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3912c09bea5so1984243f8f.1
        for <linux-kernel@vger.kernel.org>; Sat, 08 Mar 2025 01:34:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741426474; x=1742031274; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zPHgjKqwrv3u0UPeI6ZEyPubF6kRYWjLcRGaVrm7wYg=;
        b=kvZ5JG54kXmmm8nwwOx1Mu9edT6ID7SdAwhAlPBlPQgPg8L/5Nf67Oye/kB/pOanLA
         jFdYLCy0PDXcwXip+MNVjGCAA+0+EyEJN1wqfK7F+BQ4wSUjvX1vI/DVHCHRXCigl02j
         9MfBb2CdADf0ZvTSrxL6nibxVRsIobTb94sBsAZRK6DImRuc2xfaHJ4vV8M0dK8SvoYH
         hSLOxLZUUK0+Z6v0yk01kuanjRUGrCF4/9qvKsXSwQ8TmJnmrDhCoSKb/0J2IHmC/eLU
         N5b9eav/JbGyrP/EffjxVxpWioLORki+9rzqP3QbdTfj5a15Y2/NTA5XQLqgji+glSpy
         2bCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741426474; x=1742031274;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zPHgjKqwrv3u0UPeI6ZEyPubF6kRYWjLcRGaVrm7wYg=;
        b=IqSrn0fwgF+V2KY9pgxzgNgKkvq6UovOYK6sHV99ULqRnfVds7KDXyGtqAmdTYz9JA
         Zr1p/JG0kOcjfa+FnoyFBIKcqdUGtC8kE1zcOFuRLrtXDYrMnh8/GDofTdvYFJkVO/dY
         mYbNrZcFQBlVP5vuM7ermghbO9b8UyouIN1WPTFUL8Y+k1B9x9gbIgYixJ6PuWQ9ckgp
         0JVLA4d1J+/uTZkIY7LyLJ790mf4Hi8ek1ctyhqMjabvHMbQ1BtDgp6xRC/74PuX3ehI
         6GfdqVcuGhoCasK+Jt+CyH3PfeipwFkJ2GlGMZAtaQ0p9gIbBQ7/hzIk4GvSiNAiyOfq
         paJQ==
X-Gm-Message-State: AOJu0Yz1ompyyIjRS4qb779hrNFGgayp052KRgI2RMbgfgpddpJ2uTRZ
	6cm9hAWdBb2oK5G7GHmtGRFyr88HaaqaslKc2oLjELUntYQlxYPs1/ezdw==
X-Gm-Gg: ASbGnct+f5gLz0VBqvg6wIPjTUHzUyvnVVgbT0G5iQigi80ArtVCzAGIx7etYKBxJ5j
	XsPwaAv0WLJqeQHRL5cywqbXQOC9aUvdK0sn3ajI/q07eM9ZTrupuBe23JbpKHoGXvDzb8XF/bU
	u/kXysb3vuesgheAoWJzaJl2HZ8kfPEGtL2nzmxOscN+Cp1LL8n1KZ4jvgWNRTR58WgKHfPL9Bm
	tMnLbs0lx1XW+ryJvmUO9xBtac+VWSDIyUlwIcb7SvZmThFi+i8TaGhwHYJuAIObrZnmrzM6j10
	JooCGfJZw8Pe9DgFmqM3bULAuqh/qyrLxSK3C18KArhy724sEP/ear0cgqIlSUaX5Sg2IXZjOA7
	+vyi/uDDZlFUQC5joZtAm1utVoQ==
X-Google-Smtp-Source: AGHT+IEs1etUoC2eBYjq1euM2OhKf/IYlfghXIBPhfXLRSrwrB2JK00cq+8ygKyp657SjJ7cKiLl4g==
X-Received: by 2002:a5d:5985:0:b0:390:f9d0:5df with SMTP id ffacd0b85a97d-39132da9b88mr4247858f8f.52.1741426474148;
        Sat, 08 Mar 2025 01:34:34 -0800 (PST)
Received: from snowdrop.snailnet.com (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912bfba686sm8367784f8f.19.2025.03.08.01.34.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Mar 2025 01:34:33 -0800 (PST)
From: David Laight <david.laight.linux@gmail.com>
To: linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>
Cc: David Laight <david.laight.linux@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Christophe Leroy <christophe.leroy@c-s.fr>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	nnac123@linux.ibm.com,
	horms@kernel.org
Subject: [PATCH v2 1/1] lib: Optimise hex_dump_to_buffer()
Date: Sat,  8 Mar 2025 09:34:21 +0000
Message-Id: <20250308093421.3724-1-david.laight.linux@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fastpath the normal case of single byte output that fits in the buffer.
Output byte groups (byteswapped on little-endian) without calling snprintf().
Remove the restriction that rowsize must be 16 or 32.
(All callers currently pass 16 or 32.)
Remove the restriction that groupsize must be 8 or less.
If groupsize isn't a power of 2 or doesn't divide into both len and
  rowsize it is set to 1 (otherwise byteswapping is hard).
Change the types of the rowsize and groupsize parameters to be unsigned types.

Fix the return value (should be zero) when both len and linebuflen are zero.

All the updated tests in lib/test_hexdump.c pass.
Code size (x86-64) approximately halved.

Signed-off-by: David Laight <david.laight.linux@gmail.com>
---
Changes for v2:
- Fix typo in kerneldoc comment.
- Fix indendation of function prototype contunuation lines.
- Add un/likely() to the buffer overflow comparisons.
  These are useful for the human readers and may improve code.
- Adjust buffer limit tests to reduce register pressure.
  (Removes a stack spill with gcc 12.2 for x86-84.)
- Change some types to 'unsigned long' to avoid explicit zero extension
  instructions when indexing arrays.

asc_hex[] is directly indexed to avoid the high nibble being masked.
Possibly the helpers hex_pack_byte() (etc) could be changed now that
'char' is unsigned in all kernel builds.

I've also stopped gcc changing the loop that fills the pad before the
ascii to a call to memset() - the count is small, often 1.
An alternative option would be to explicitly memset the output buffer
to spaces and then fill in the hex digits over the top.
Definitely better if the output size is constant (unrolled writes).

gcc 12 and 13 (but not 14) manage to load the two characters into (eg) %al
and %ah and then do a 16bit write.
However (I think to avoid false dependencies) the whole of %eax must
be zeroed, this is done in a very stange way reading a zero from memory!
See https://www.godbolt.org/z/1ds784hEq
Strangly this only happens with -mno-sse.

 include/linux/printk.h |   6 +-
 lib/hexdump.c          | 172 +++++++++++++++++++++--------------------
 2 files changed, 91 insertions(+), 87 deletions(-)

diff --git a/include/linux/printk.h b/include/linux/printk.h
index 4217a9f412b2..19689467f532 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -752,9 +752,9 @@ enum {
 	DUMP_PREFIX_ADDRESS,
 	DUMP_PREFIX_OFFSET
 };
-extern int hex_dump_to_buffer(const void *buf, size_t len, int rowsize,
-			      int groupsize, char *linebuf, size_t linebuflen,
-			      bool ascii);
+extern size_t hex_dump_to_buffer(const void *buf, size_t len, size_t rowsize,
+				 size_t groupsize, char *linebuf,
+				 size_t linebuflen, bool ascii);
 #ifdef CONFIG_PRINTK
 extern void print_hex_dump(const char *level, const char *prefix_str,
 			   int prefix_type, int rowsize, int groupsize,
diff --git a/lib/hexdump.c b/lib/hexdump.c
index c3db7c3a7643..054548bf44ae 100644
--- a/lib/hexdump.c
+++ b/lib/hexdump.c
@@ -98,13 +98,16 @@ EXPORT_SYMBOL(bin2hex);
  * hex_dump_to_buffer - convert a blob of data to "hex ASCII" in memory
  * @buf: data blob to dump
  * @len: number of bytes in the @buf
- * @rowsize: number of bytes to print per line; must be 16 or 32
- * @groupsize: number of bytes to print at a time (1, 2, 4, 8; default = 1)
+ * @rowsize: number of bytes to print per line
+ * @groupsize: number of bytes to print at a time
  * @linebuf: where to put the converted data
  * @linebuflen: total size of @linebuf, including space for terminating NUL
  * @ascii: include ASCII after the hex output
  *
- * hex_dump_to_buffer() works on one "line" of output at a time, i.e.,
+ * If @groupsize isn't a power of 2 that divides into both @len and @rowsize
+ * then it is set to 1.
+ *
+ * hex_dump_to_buffer() works on one "line" of output at a time, e.g.,
  * 16 or 32 bytes of input data converted to hex + ASCII output.
  *
  * Given a buffer of u8 data, hex_dump_to_buffer() converts the input data
@@ -124,105 +127,106 @@ EXPORT_SYMBOL(bin2hex);
  * (excluding the terminating NUL) which would have been written to the final
  * string if enough space had been available.
  */
-int hex_dump_to_buffer(const void *buf, size_t len, int rowsize, int groupsize,
-		       char *linebuf, size_t linebuflen, bool ascii)
+size_t hex_dump_to_buffer(const void *buf, size_t len, size_t rowsize,
+			  size_t groupsize, char *linebuf, size_t linebuflen,
+			  bool ascii)
 {
+	char *dst_last = linebuf + linebuflen - 2;
+	char *pad_end, *dst = linebuf;
+	size_t out_len, pad_len;
 	const u8 *ptr = buf;
-	int ngroups;
-	u8 ch;
-	int j, lx = 0;
-	int ascii_column;
-	int ret;
+	unsigned long ch;
+	char ch_hi;
+	size_t j;
 
-	if (rowsize != 16 && rowsize != 32)
-		rowsize = 16;
+	if (unlikely(!len)) {
+		if (linebuflen)
+			linebuf[0] = 0;
+		return 0;
+	}
 
-	if (len > rowsize)		/* limit to one line at a time */
-		len = rowsize;
-	if (!is_power_of_2(groupsize) || groupsize > 8)
-		groupsize = 1;
-	if ((len % groupsize) != 0)	/* no mixed size output */
-		groupsize = 1;
+	if (unlikely(len > rowsize)) {
+		if (rowsize == 0)
+			rowsize = 16;
+		if (len > rowsize)
+			len = rowsize;
+	}
 
-	ngroups = len / groupsize;
-	ascii_column = rowsize * 2 + rowsize / groupsize + 1;
+	if (unlikely((groupsize | rowsize | len) & (groupsize - 1)))
+		groupsize = 1;
 
-	if (!linebuflen)
-		goto overflow1;
+	if (groupsize == 1 && likely(len * 3 <= linebuflen)) {
+		for (j = 0; j < len; j++, dst += 3) {
+			ch = ptr[j];
+			dst[0] = hex_asc[ch >> 4];
+			dst[1] = hex_asc[ch & 0xf];
+			dst[2] = ' ';
+		}
 
-	if (!len)
-		goto nil;
+		pad_len = (rowsize - len) * 3;
+	} else {
+		unsigned int mask = groupsize - 1;
+		unsigned int byteswap;
 
-	if (groupsize == 8) {
-		const u64 *ptr8 = buf;
+		byteswap = IS_ENABLED(CONFIG_CPU_BIG_ENDIAN) ? 0 : mask;
 
-		for (j = 0; j < ngroups; j++) {
-			ret = snprintf(linebuf + lx, linebuflen - lx,
-				       "%s%16.16llx", j ? " " : "",
-				       get_unaligned(ptr8 + j));
-			if (ret >= linebuflen - lx)
-				goto overflow1;
-			lx += ret;
+		for (j = 0; j < len; j++) {
+			ch = ptr[j ^ byteswap];
+			ch_hi = hex_asc[ch >> 4];
+			if (unlikely(dst >= dst_last)) {
+				if (dst == dst_last)
+					dst_last[0] = ch_hi;
+				if (++dst_last >= linebuf)
+					dst_last[0] = 0;
+				out_len = ascii ? rowsize : len;
+				out_len = out_len * 2 + out_len / groupsize;
+				return out_len + (ascii ? 1 + len : -1);
+			}
+			*dst++ = ch_hi;
+			*dst++ = hex_asc[ch & 0xf];
+			if ((j & mask) == mask)
+				*dst++ = ' ';
 		}
-	} else if (groupsize == 4) {
-		const u32 *ptr4 = buf;
 
-		for (j = 0; j < ngroups; j++) {
-			ret = snprintf(linebuf + lx, linebuflen - lx,
-				       "%s%8.8x", j ? " " : "",
-				       get_unaligned(ptr4 + j));
-			if (ret >= linebuflen - lx)
-				goto overflow1;
-			lx += ret;
-		}
-	} else if (groupsize == 2) {
-		const u16 *ptr2 = buf;
+		pad_len = rowsize - len;
+		if (pad_len)
+			pad_len = pad_len * 2 + pad_len / groupsize;
+	}
+	out_len = dst - linebuf;
 
-		for (j = 0; j < ngroups; j++) {
-			ret = snprintf(linebuf + lx, linebuflen - lx,
-				       "%s%4.4x", j ? " " : "",
-				       get_unaligned(ptr2 + j));
-			if (ret >= linebuflen - lx)
-				goto overflow1;
-			lx += ret;
-		}
-	} else {
-		for (j = 0; j < len; j++) {
-			if (linebuflen < lx + 2)
-				goto overflow2;
-			ch = ptr[j];
-			linebuf[lx++] = hex_asc_hi(ch);
-			if (linebuflen < lx + 2)
-				goto overflow2;
-			linebuf[lx++] = hex_asc_lo(ch);
-			if (linebuflen < lx + 2)
-				goto overflow2;
-			linebuf[lx++] = ' ';
-		}
-		if (j)
-			lx--;
+	if (!ascii) {
+		dst[-1] = 0;
+		return out_len - 1;
 	}
-	if (!ascii)
-		goto nil;
 
-	while (lx < ascii_column) {
-		if (linebuflen < lx + 2)
-			goto overflow2;
-		linebuf[lx++] = ' ';
+	dst_last++;
+	pad_len++;
+	out_len += pad_len + len;
+	pad_end = dst + pad_len;
+	if (unlikely(pad_end > dst_last)) {
+		if (dst >= dst_last) {
+			dst_last[0] = 0;
+			return out_len;
+		}
+		pad_end = dst_last;
 	}
+
+	do {
+		*dst++ = ' ';
+		/* Stop gcc generating a call to memset() */
+		barrier();
+	} while (dst < pad_end);
+
+	if (unlikely(dst + len > dst_last))
+		len = dst_last - dst;
+
 	for (j = 0; j < len; j++) {
-		if (linebuflen < lx + 2)
-			goto overflow2;
 		ch = ptr[j];
-		linebuf[lx++] = (isascii(ch) && isprint(ch)) ? ch : '.';
+		*dst++ = ch >= ' ' && ch < 0x7f ? ch : '.';
 	}
-nil:
-	linebuf[lx] = '\0';
-	return lx;
-overflow2:
-	linebuf[lx++] = '\0';
-overflow1:
-	return ascii ? ascii_column + len : (groupsize * 2 + 1) * ngroups - 1;
+	*dst = 0;
+
+	return out_len;
 }
 EXPORT_SYMBOL(hex_dump_to_buffer);
 
-- 
2.39.5


