Return-Path: <linux-kernel+bounces-516790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F1D2A3776C
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 21:19:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A18C16BF68
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 20:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D91A19B5B4;
	Sun, 16 Feb 2025 20:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V1CXHS8P"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 090EB1442E8
	for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2025 20:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739737157; cv=none; b=AnI2Ucl7kembdeACp85/exiRGzwlug84MkUV/TDcJqLrpco1ykHClt5sxs2fz8gQ1kVKqQHcy2I6+R4OSO+joALMLW/lHeAk/tHYPJmGyxuKaSZmJfJ/1n93c8eQ34h1/83e8PBHrAd6/tABzJWrBD8AkY46rZcEEiQbZjS2oB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739737157; c=relaxed/simple;
	bh=5vET/Ou1PDDyKjOtfy501y+tyeDkHLeJQUjWFOpAbiQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kdtCwGkyjauNqwzwgquPqHzrSRFQZFrOKKOnb/ZfyTQOnO7vh6lZ6zFlzgK5vpj3mHjmARPeXk8YHkLxrVXlY8LKxbmPA/4utUz32bfXWs3BGBToH5Or1lAydLsy55/QB4P2V7fwL4eQY+qFQIGQohXQzAj2MfsWZn0OAizYZi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V1CXHS8P; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-38f403edb4eso232349f8f.3
        for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2025 12:19:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739737154; x=1740341954; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wcORu97Ma/0XPhsdiIQdr72OgVnzXvpwEseFqbHC+kA=;
        b=V1CXHS8PdH/3mBqz4Co7qVOADr/yshLZEVJPkMHm3iu9N9i2fE876y+/eQRCz/x+ZC
         or/bqxWntrHUjZEm2Mw0cfeoLPnLbOuQJY2hBHEyZTXH+ufk5hXWHS639eGPqBxyxNI7
         STszgx8ti+341ZtGlOsIDj0bxDkvXTBJz87O4WHBxKfYCnWPkpBgOeBUDpqFr6Lx4xEC
         gUJpS71mgo8++5fcSgskokC2Dkc0RsgMwCOM1dxp/PTO2+T57OJq6zZE/2BxygQgFaVc
         PuUV5s/IzV+ZYtcOjTlfJD9TdmLjRwQPVBHaCIZ4yZoFcBrnQ+DCmhZTr/V3FFyrHPog
         JYAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739737154; x=1740341954;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wcORu97Ma/0XPhsdiIQdr72OgVnzXvpwEseFqbHC+kA=;
        b=dNlMK6Laik1RST5NicrayNj2tGAikRDRlnul2pO3zYwetgQBFreR8Iwah1Zr/xB0wZ
         WB5GH2gI0piLn6m7eIoQxFfFRO1iXPC2K5PFedDj83lNd6jHHmzjT1ta4wY3aVeDUIC2
         xby3fPg9yICLHgqTH5Jc8XGS7Hf8pgp+hyhjZYbLal3cIImUAyjbiNXOW6+RZdW8WKKW
         lRdD63NZMWJLaFs76vG4XzHZKH+S7JFCqM0Soi6U5+mqB13BrkPE7rZo1Qe9JPrWXgt7
         cph9YRu9UEEqhiUV63WPE0wm4+PdB9YwGfm3H/Luoa4FGffnPhpZgVytV04pfcLGaacA
         bmAw==
X-Gm-Message-State: AOJu0YyAEo0XIuvf1IUKbaocyfy9yGiHfL5Ltl3hzzRcSbUZoQUEJlK6
	n+HPAmHn3JCTFO2l/GWNOguGcgiHqwDi0wwKuG8y6eGSiV5s1yu4jkWgKA==
X-Gm-Gg: ASbGncvsHLG86S9XdPWP/lT7utr+/GTIHGb5C5597Z2qw+nU83MIGBZvjcV2xMI+jRV
	EuzpZbec6hX1rR9XFIczxyni5OZdkZvG2aigm9a9Yh5qXx11r1SfQfi7NX4bsuki7s4MbBoLSO5
	v0J+wJaQR+E6ZOPIpeglONNgMTkCC6mZzgkWBGY84ySdPIahLnmauib0Cf21loktl9slI2UY82J
	WtgZWG2lW9zOPbyZvffB80bZA3HzaqkMHejeiyTIgOfYYvpFoactTp+7ejMVz/SnVXlF4sqzpI7
	4uSzW5z0MMkduUgwfI3VK5kJMwFPdpjjZoSvYi3N2RTYRbXpKjEtDyV3eWhquExRyosZ5EsH
X-Google-Smtp-Source: AGHT+IHS1U/TdD51ht7gl5HWHc7c+vJM1wQGjQiUaqtRJfbB5RBd0XIbTJQ1HN7aN6GBXyLFSPPfsw==
X-Received: by 2002:a5d:6ac1:0:b0:38f:229a:b48 with SMTP id ffacd0b85a97d-38f33f34e0fmr5786885f8f.32.1739737154021;
        Sun, 16 Feb 2025 12:19:14 -0800 (PST)
Received: from snowdrop.snailnet.com (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f258ddbe0sm10504048f8f.39.2025.02.16.12.19.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Feb 2025 12:19:13 -0800 (PST)
From: David Laight <david.laight.linux@gmail.com>
To: linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>
Cc: David Laight <david.laight.linux@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH next 1/1] lib: Optimise hex_dump_to_buffer()
Date: Sun, 16 Feb 2025 20:19:01 +0000
Message-Id: <20250216201901.161781-1-david.laight.linux@gmail.com>
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
Remove the restriction that groupsize must be 8 or less.
If groupsize isn't a power of 2 or doesn't divide into both len and
  rowsize it is set to 1 (otherwise byteswapping is hard).
Change the types of the rowsize and groupsize parameters to be unsigned types.

Tested in a userspace harness, code size (x86-64) halved to 723 bytes.

Signed-off-by: David Laight <david.laight.linux@gmail.com>
---
 include/linux/printk.h |   6 +-
 lib/hexdump.c          | 165 ++++++++++++++++++++---------------------
 2 files changed, 85 insertions(+), 86 deletions(-)

diff --git a/include/linux/printk.h b/include/linux/printk.h
index 4217a9f412b2..49e67f63277e 100644
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
+			      size_t groupsize, char *linebuf,
+			      size_t linebuflen, bool ascii);
 #ifdef CONFIG_PRINTK
 extern void print_hex_dump(const char *level, const char *prefix_str,
 			   int prefix_type, int rowsize, int groupsize,
diff --git a/lib/hexdump.c b/lib/hexdump.c
index c3db7c3a7643..da40ae217c41 100644
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
+ * the it is set to 1.
+ *
+ * hex_dump_to_buffer() works on one "line" of output at a time, e.g.,
  * 16 or 32 bytes of input data converted to hex + ASCII output.
  *
  * Given a buffer of u8 data, hex_dump_to_buffer() converts the input data
@@ -124,105 +127,101 @@ EXPORT_SYMBOL(bin2hex);
  * (excluding the terminating NUL) which would have been written to the final
  * string if enough space had been available.
  */
-int hex_dump_to_buffer(const void *buf, size_t len, int rowsize, int groupsize,
-		       char *linebuf, size_t linebuflen, bool ascii)
+size_t hex_dump_to_buffer(const void *buf, size_t len, size_t rowsize,
+		       size_t groupsize, char *linebuf, size_t linebuflen,
+		       bool ascii)
 {
+	char *dst_end = linebuf + linebuflen;
+	size_t out_len, pad_len;
+	char *dst = linebuf;
 	const u8 *ptr = buf;
-	int ngroups;
+	unsigned int j;
 	u8 ch;
-	int j, lx = 0;
-	int ascii_column;
-	int ret;
 
-	if (rowsize != 16 && rowsize != 32)
-		rowsize = 16;
+	if (!len) {
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
+	if (len > rowsize) {
+		if (rowsize == 0)
+			rowsize = 16;
+		if (len > rowsize)
+			len = rowsize;
+	}
 
-	ngroups = len / groupsize;
-	ascii_column = rowsize * 2 + rowsize / groupsize + 1;
+	if ((groupsize & (groupsize - 1)) || (rowsize & (groupsize - 1)) ||
+	    (len & (groupsize - 1)))
+		groupsize = 1;
 
-	if (!linebuflen)
-		goto overflow1;
+	if (groupsize == 1 && len * 3 <= linebuflen) {
+		for (j = 0; j < len; j++, dst += 3) {
+			ch = ptr[j];
+			dst[0] = hex_asc_hi(ch);
+			dst[1] = hex_asc_lo(ch);
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
-		}
-	} else if (groupsize == 4) {
-		const u32 *ptr4 = buf;
+		for (j = 0; j < len; j++) {
+			if (dst + 2 > dst_end)
+				goto hex_truncated;
+			ch = ptr[j ^ byteswap];
+			dst[0] = hex_asc_hi(ch);
+			dst[1] = hex_asc_lo(ch);
+			dst += 2;
 
-		for (j = 0; j < ngroups; j++) {
-			ret = snprintf(linebuf + lx, linebuflen - lx,
-				       "%s%8.8x", j ? " " : "",
-				       get_unaligned(ptr4 + j));
-			if (ret >= linebuflen - lx)
-				goto overflow1;
-			lx += ret;
+			if ((j & mask) != mask)
+				continue;
+			if (dst >= dst_end)
+				goto hex_truncated;
+			*dst++ = ' ';
 		}
-	} else if (groupsize == 2) {
-		const u16 *ptr2 = buf;
 
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
+		pad_len = rowsize - len;
+		pad_len = pad_len * 2 + pad_len / groupsize;
 	}
-	if (!ascii)
-		goto nil;
+	dst--;
+	out_len = dst - linebuf;
 
-	while (lx < ascii_column) {
-		if (linebuflen < lx + 2)
-			goto overflow2;
-		linebuf[lx++] = ' ';
+	if (!ascii) {
+		*dst = 0;
+		return out_len;
 	}
+
+	pad_len += 2;
+	out_len += pad_len + len;
+	if (dst + pad_len >= dst_end)
+		pad_len = dst_end - dst - 1;
+	while (pad_len--)
+		*dst++ = ' ';
+
+	if (dst + len >= dst_end)
+		len = dst_end - dst - 1;
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
+
+hex_truncated:
+	if (dst_end != linebuf)
+		dst_end[-1] = 0;
+
+	out_len = ascii ? rowsize : len;
+	out_len = out_len * 2 + out_len / groupsize;
+	out_len += ascii ? 1 + len : -1;
+	return out_len;
 }
 EXPORT_SYMBOL(hex_dump_to_buffer);
 
-- 
2.39.5


