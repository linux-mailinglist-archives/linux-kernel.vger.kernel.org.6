Return-Path: <linux-kernel+bounces-568367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 01B7AA69489
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 17:16:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D05AE19C1A3F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 16:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 905C42D78A;
	Wed, 19 Mar 2025 16:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="XAerFY9T"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9B71CCB4B;
	Wed, 19 Mar 2025 16:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742400725; cv=none; b=J4WHLgkIZuyEuTa2pJMaho1CFcde0e5mlybnToZbEHOz7aA2/fWmDBykduOOum4kHEixyCC5qN//0Eyg52N4jEMcf4n97xT0Gs2q1aWb/ot/YIHepqga+XaLzDIt83FgSjp5u3mzfsoYTV2Tysc6SV6n+HUR3Kp62UizGyndL4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742400725; c=relaxed/simple;
	bh=Yit60MizxPdRAT0dGt9yEpVcp5G813hgs0g6iVfQ2dQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=t6uMs8MxR2L+F0YHNhmiTS0pSEeSWZFMbA/wVts3ZYKuw9bT3BadTzLXHLFLWEJvIi5UCpAKMDKDkVXroRctcTM3Zdcimdt8T98bmCruhkaDKkoOtvaZu0cxM247DASyiY9FlDgP0Bz8/BZZJd/ls74XucLesrUpdEDtswDn7oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=XAerFY9T; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 998F620487;
	Wed, 19 Mar 2025 16:11:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1742400715;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TgQW7SKf+36bry4gG5ZfyulYo2oF3QSahnUBo0Xtw3I=;
	b=XAerFY9THmzvZNFx0XpeSs74R2niZnVDVdnTLzDm9rMXentyby3uKDSs1w4pzjWKKvtiAR
	pv706IKVNRpdTJVfaVsJRNaL3UCi9ACGBGcxUvd3OOt66Ao44PIsM/STyiiQ/2ndamIM5r
	+5bYoPsjFuwU6AERdphYwryE/Ws5cLRBD9ett6FEjwoD2pY6vIW2Z58FfmApESUtCnhHJf
	g2TA/heaaalFhrv5u5fSvR7X4b+Fw2vP/Fimalcocw6Z/tjKLs1exERlREmdawFT92T7P3
	cJXpCOrtDDXoWh8lzwDsjVopXsG5/6ZpBIbGlhx0TNOqhao76Uzbu15+1QcbcA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Wed, 19 Mar 2025 17:08:10 +0100
Subject: [PATCH v3 1/3] hexdump: Simplify print_hex_dump()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250319-perso-hexdump-v3-1-a6ba3a9f3742@bootlin.com>
References: <20250319-perso-hexdump-v3-0-a6ba3a9f3742@bootlin.com>
In-Reply-To: <20250319-perso-hexdump-v3-0-a6ba3a9f3742@bootlin.com>
To: Petr Mladek <pmladek@suse.com>, 
 David Laight <david.laight.linux@gmail.com>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 Jonathan Corbet <corbet@lwn.net>, John Ogness <john.ogness@linutronix.de>, 
 Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Miquel Raynal <miquel.raynal@bootlin.com>
X-Mailer: b4 0.15-dev
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugeehjeejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomhepofhiqhhuvghlucftrgihnhgrlhcuoehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeelgfehvdduieefieeikeffgffggfdttdeugeffieetheeuleelfeehffdtffetveenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghloheplgduledvrdduieekrdegvddrgeeingdpmhgrihhlfhhrohhmpehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedufedprhgtphhtthhopegrnhgurhhihidrshhhvghvtghhvghnkhhosehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohepthhhohhmrghsrdhpvghtrgiiiihonhhisegsohhothhlihhnrdgtohhmpdhrtghpthhtoheplhhinhhugidqughotgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohhrsggvtheslhifnhdrnhgvthdprhgtphhtthhopehrohhst
 hgvughtsehgohhoughmihhsrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhohhhnrdhoghhnvghssheslhhinhhuthhrohhnihigrdguvgdprhgtphhtthhopehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhm
X-GND-Sasl: miquel.raynal@bootlin.com

print_hex_dump() already has numerous parameters, and could be extended
with a new one. Adding new parameters is super painful due to the number
of users, and it makes the function calls even longer.

Create a print_hex() to replace print_hex_dump(), with 'prefix_type' and
'ascii' being merged into a 'dump_flags' parameter. This way extending
the list of dump flags will be much easier.

For convenience, a print_hex_dump macro is created to fallback on the
print_hex() implementation. A tree-wide change to remove its use could
be done in the future.

No functional change intended.

Suggested-by: Petr Mladek <pmladek@suse.com>
Suggested-by: David Laight <david.laight.linux@gmail.com>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 Documentation/core-api/printk-formats.rst |  2 +-
 include/linux/printk.h                    | 42 +++++++++++++++++++++++-------
 lib/hexdump.c                             | 43 ++++++++++++++-----------------
 3 files changed, 53 insertions(+), 34 deletions(-)

diff --git a/Documentation/core-api/printk-formats.rst b/Documentation/core-api/printk-formats.rst
index ecccc0473da9c10f45f2464566f690472c61401e..f80b5e262e9933992d1291f1d78fba97589d5631 100644
--- a/Documentation/core-api/printk-formats.rst
+++ b/Documentation/core-api/printk-formats.rst
@@ -310,7 +310,7 @@ Raw buffer as a hex string
 
 For printing small buffers (up to 64 bytes long) as a hex string with a
 certain separator. For larger buffers consider using
-:c:func:`print_hex_dump`.
+:c:func:`print_hex`.
 
 MAC/FDDI addresses
 ------------------
diff --git a/include/linux/printk.h b/include/linux/printk.h
index 4217a9f412b265f1dc027be88eff7f5a0e0e4aab..7dca2270c82c0ed788cd706274f1c1b14ed9a7fe 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -747,22 +747,31 @@ do {									\
 
 extern const struct file_operations kmsg_fops;
 
+/*
+ * Dump flags for print_hex().
+ * DUMP_PREFIX_{NONE,ADDRESS,OFFSET} are mutually exclusive.
+ */
 enum {
-	DUMP_PREFIX_NONE,
-	DUMP_PREFIX_ADDRESS,
-	DUMP_PREFIX_OFFSET
+	DUMP_HEX_DATA = 0,
+	DUMP_ASCII = BIT(0),
+	DUMP_PREFIX_NONE = 0, /* Legacy definition for print_hex_dump() */
+	DUMP_PREFIX_ADDRESS = BIT(1),
+	DUMP_PREFIX_OFFSET = BIT(2),
 };
+
 extern int hex_dump_to_buffer(const void *buf, size_t len, int rowsize,
 			      int groupsize, char *linebuf, size_t linebuflen,
 			      bool ascii);
 #ifdef CONFIG_PRINTK
-extern void print_hex_dump(const char *level, const char *prefix_str,
-			   int prefix_type, int rowsize, int groupsize,
-			   const void *buf, size_t len, bool ascii);
+extern void print_hex(const char *level, const char *prefix_str,
+		      int rowsize, int groupsize,
+		      const void *buf, size_t len,
+		      unsigned int dump_flags);
 #else
-static inline void print_hex_dump(const char *level, const char *prefix_str,
-				  int prefix_type, int rowsize, int groupsize,
-				  const void *buf, size_t len, bool ascii)
+static inline void print_hex(const char *level, const char *prefix_str,
+			     int rowsize, int groupsize,
+			     const void *buf, size_t len,
+			     unsigned int dump_flags)
 {
 }
 static inline void print_hex_dump_bytes(const char *prefix_str, int prefix_type,
@@ -791,6 +800,21 @@ static inline void print_hex_dump_debug(const char *prefix_str, int prefix_type,
 }
 #endif
 
+/*
+ * print_hex_dump - legacy version of print_hex() with a longer parameter list
+ *
+ * Refer to print_hex() for the parameters definition which are identical except:
+ * - prefix_type: controls whether prefix of an offset, address, or none
+ * is printed (%DUMP_PREFIX_OFFSET, %DUMP_PREFIX_ADDRESS, %DUMP_PREFIX_NONE).
+ * This parameter has been removed in favor of a common 'flags' parameter.
+ * - ascii: include ASCII after the hex output.
+ * This parameter has been removed in favor of a common 'flags' parameter.
+ */
+
+#define print_hex_dump(level, prefix_str, prefix_type, rowsize, groupsize, buf, len, ascii) \
+	print_hex(level, prefix_str, rowsize, groupsize, buf, len, \
+		  (prefix_type) | ((ascii) ? DUMP_ASCII : DUMP_HEX_DATA))
+
 /**
  * print_hex_dump_bytes - shorthand form of print_hex_dump() with default params
  * @prefix_str: string to prefix each line with;
diff --git a/lib/hexdump.c b/lib/hexdump.c
index c3db7c3a764365b01e78f8ed0b7f782f33a5ce34..74fdcb4566d27f257a0e1288c261d81d231b06bf 100644
--- a/lib/hexdump.c
+++ b/lib/hexdump.c
@@ -228,39 +228,39 @@ EXPORT_SYMBOL(hex_dump_to_buffer);
 
 #ifdef CONFIG_PRINTK
 /**
- * print_hex_dump - print a text hex dump to syslog for a binary blob of data
+ * print_hex - print a text hex dump to syslog for a binary blob of data
  * @level: kernel log level (e.g. KERN_DEBUG)
  * @prefix_str: string to prefix each line with;
  *  caller supplies trailing spaces for alignment if desired
- * @prefix_type: controls whether prefix of an offset, address, or none
- *  is printed (%DUMP_PREFIX_OFFSET, %DUMP_PREFIX_ADDRESS, %DUMP_PREFIX_NONE)
  * @rowsize: number of bytes to print per line; must be 16 or 32
  * @groupsize: number of bytes to print at a time (1, 2, 4, 8; default = 1)
  * @buf: data blob to dump
  * @len: number of bytes in the @buf
- * @ascii: include ASCII after the hex output
+ * @dump_flags: controls the output format, typically:
+ *   - %DUMP_PREFIX_OFFSET shows the offset in front of each line
+ *   - %DUMP_PREFIX_ADDRESS shows the address in front of each line
+ *   - %DUMP_ASCII prints the ascii equivalent after the hex output
  *
- * Given a buffer of u8 data, print_hex_dump() prints a hex + ASCII dump
+ * Given a buffer of u8 data, print_hex() prints a hex + ASCII dump
  * to the kernel log at the specified kernel log level, with an optional
  * leading prefix.
  *
- * print_hex_dump() works on one "line" of output at a time, i.e.,
+ * print_hex() works on one "line" of output at a time, i.e.,
  * 16 or 32 bytes of input data converted to hex + ASCII output.
- * print_hex_dump() iterates over the entire input @buf, breaking it into
+ * print_hex() iterates over the entire input @buf, breaking it into
  * "line size" chunks to format and print.
  *
  * E.g.:
- *   print_hex_dump(KERN_DEBUG, "raw data: ", DUMP_PREFIX_ADDRESS,
- *		    16, 1, frame->data, frame->len, true);
+ *   print_hex(KERN_DEBUG, "raw data: ", 16, 1, frame->data, frame->len,
+ *             DUMP_PREFIX_ADDRESS | DUMP_ASCII);
  *
  * Example output using %DUMP_PREFIX_OFFSET and 1-byte mode:
  * 0009ab42: 40 41 42 43 44 45 46 47 48 49 4a 4b 4c 4d 4e 4f  @ABCDEFGHIJKLMNO
  * Example output using %DUMP_PREFIX_ADDRESS and 4-byte mode:
  * ffffffff88089af0: 73727170 77767574 7b7a7978 7f7e7d7c  pqrstuvwxyz{|}~.
  */
-void print_hex_dump(const char *level, const char *prefix_str, int prefix_type,
-		    int rowsize, int groupsize,
-		    const void *buf, size_t len, bool ascii)
+void print_hex(const char *level, const char *prefix_str, int rowsize, int groupsize,
+	       const void *buf, size_t len, unsigned int dump_flags)
 {
 	const u8 *ptr = buf;
 	int i, linelen, remaining = len;
@@ -274,22 +274,17 @@ void print_hex_dump(const char *level, const char *prefix_str, int prefix_type,
 		remaining -= rowsize;
 
 		hex_dump_to_buffer(ptr + i, linelen, rowsize, groupsize,
-				   linebuf, sizeof(linebuf), ascii);
+				   linebuf, sizeof(linebuf),
+				   dump_flags & DUMP_ASCII);
 
-		switch (prefix_type) {
-		case DUMP_PREFIX_ADDRESS:
-			printk("%s%s%p: %s\n",
-			       level, prefix_str, ptr + i, linebuf);
-			break;
-		case DUMP_PREFIX_OFFSET:
+		if (dump_flags & DUMP_PREFIX_ADDRESS)
+			printk("%s%s%p: %s\n", level, prefix_str, ptr + i, linebuf);
+		else if (dump_flags & DUMP_PREFIX_OFFSET)
 			printk("%s%s%.8x: %s\n", level, prefix_str, i, linebuf);
-			break;
-		default:
+		else
 			printk("%s%s%s\n", level, prefix_str, linebuf);
-			break;
-		}
 	}
 }
-EXPORT_SYMBOL(print_hex_dump);
+EXPORT_SYMBOL(print_hex);
 
 #endif /* defined(CONFIG_PRINTK) */

-- 
2.48.1


