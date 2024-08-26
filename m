Return-Path: <linux-kernel+bounces-301849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3403195F670
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 18:24:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B24761F246CE
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 16:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B005194C62;
	Mon, 26 Aug 2024 16:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="AnhcmmXA"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A69194A6B;
	Mon, 26 Aug 2024 16:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724689463; cv=none; b=GCsAEdVtEnToNRCjr9RForTuFFgJjlsljoXnZqQbxc627Bg1IhVXvoMHkuYLQYRH/O+Z8fw/0OuuyXeI/eA/uKCkaIhxA7E1cCsrw9Ipo5lqZ5haC400yxW8m9MEFeEZF2eTwJdE1n5GdXYZ17qy8M7A5BwtVexLdvNjNNFM6R8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724689463; c=relaxed/simple;
	bh=YYOnyzVm0DefYoAR/N+5ywIUwUC+0PI25GaRbdlUrTc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=svNBaZOJ30MpDNNFS6R3Q8pi4wYmlJDcQnfU7NMRiCADNiXQZKm2w8RRUoZlP/ghMo3QU/6V7ClORf/UEERRLIgXVk/u9WE9D8X7wm8qdyeo4t+66sRsYjPF4JqaYaW4sE7a3XvM5/Jgqp2AKILMktCv7izGl2wtR+vL+JVgyB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=AnhcmmXA; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E069B1C000B;
	Mon, 26 Aug 2024 16:24:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1724689459;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TdX3ZbrZm2V9kCZ1VTA9DBUI2ASedEqq/VcGXyHdFkA=;
	b=AnhcmmXAgYj/OD+cuFFSBipCyBwxl7SKYxI7K1C9HSvyZ+lSEUe4dc+w1VTz5iAuG1d16l
	SVlq9N1JwxhzB+MfIwm4Yo5Y92CPZVDk9bRhS8HgMP4WatVyn7CGdMWwcB/z7vHic2JjE/
	pxtdr12RGyxeEmtdTCcwDrpIOZaF+CJgUSn9894sh1vUcuuPAbKH43IyllCqacOz10/XXP
	7FMFW0u80mKldbVtOTi4xI2iGLrMd53BzSPAzYu1JrJ1mx+377ALqPhBfEoqkeSd45nwdW
	flKSdVL4YFuH8JZFM6HPqHnQRXvEqb6fssFYw86BvzraAFVvDvwnb2S6bFfRDA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jonathan Corbet <corbet@lwn.net>,
	John Ogness <john.ogness@linutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 2/2] hexdump: Allow skipping identical lines
Date: Mon, 26 Aug 2024 18:24:16 +0200
Message-ID: <20240826162416.74501-3-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240826162416.74501-1-miquel.raynal@bootlin.com>
References: <20240826162416.74501-1-miquel.raynal@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com

When dumping long buffers (especially for debug purposes) it may be very
convenient to sometimes avoid spitting all the lines of the buffer if
the lines are identical. Typically on embedded devices, the console
would be wired to a UART running at 115200 bauds, which makes the dumps
very (very) slow. In this case, having a flag to avoid printing
duplicated lines is handy.

Example of a made up repetitive output:
0f 53 63 47 56 55 78 7a aa b7 8c ff ff ff ff ff
ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
ff ff ff ff ff ff ff ff ff ff ff ff 01 2a 39 eb

Same but with the flag enabled:
0f 53 63 47 56 55 78 7a aa b7 8c ff ff ff ff ff
ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
*
ff ff ff ff ff ff ff ff ff ff ff ff 01 2a 39 eb

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 Documentation/core-api/printk-formats.rst |  4 +++-
 include/linux/printk.h                    |  1 +
 lib/hexdump.c                             | 21 +++++++++++++++++++--
 3 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/Documentation/core-api/printk-formats.rst b/Documentation/core-api/printk-formats.rst
index 4451ef501936..917b7b401858 100644
--- a/Documentation/core-api/printk-formats.rst
+++ b/Documentation/core-api/printk-formats.rst
@@ -292,7 +292,9 @@ Raw buffer as a hex string
 
 For printing small buffers (up to 64 bytes long) as a hex string with a
 certain separator. For larger buffers consider using
-:c:func:`print_hex_dump`.
+:c:func:`print_hex_dump`, especially since dupplicated lines can be
+skipped automatically to reduce the overhead with the
+``DUMP_FLAG_SKIP_IDENTICAL_LINES`` flag.
 
 MAC/FDDI addresses
 ------------------
diff --git a/include/linux/printk.h b/include/linux/printk.h
index 5981f29c79c4..33a74a536780 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -719,6 +719,7 @@ enum {
 
 enum {
 	DUMP_FLAG_ASCII,
+	DUMP_FLAG_SKIP_IDENTICAL_LINES,
 };
 
 extern int hex_dump_to_buffer(const void *buf, size_t len, int rowsize,
diff --git a/lib/hexdump.c b/lib/hexdump.c
index f485b66aebbb..8749349a4fae 100644
--- a/lib/hexdump.c
+++ b/lib/hexdump.c
@@ -4,6 +4,7 @@
  */
 
 #include <linux/types.h>
+#include <linux/string.h>
 #include <linux/ctype.h>
 #include <linux/errno.h>
 #include <linux/kernel.h>
@@ -239,7 +240,8 @@ EXPORT_SYMBOL(hex_dump_to_buffer);
  * @buf: data blob to dump
  * @len: number of bytes in the @buf
  * @flags: controls the output, typically %DUMP_FLAG_ASCII will print the ascii
- * equivalent after the hex output.
+ * equivalent after the hex output, %DUMP_FLAG_SKIP_IDENTICAL_LINES will display
+ * a single '*' instead of duplicated lines.
  *
  * Given a buffer of u8 data, print_hex_dump() prints a hex + ASCII dump
  * to the kernel log at the specified kernel log level, with an optional
@@ -264,8 +266,9 @@ void print_hex_dump(const char *level, const char *prefix_str, int prefix_type,
 		    const void *buf, size_t len, unsigned int flags)
 {
 	const u8 *ptr = buf;
-	int i, linelen, remaining = len;
+	int i, prev_i, linelen, remaining = len;
 	unsigned char linebuf[32 * 3 + 2 + 32 + 1];
+	bool same_line = false;
 
 	if (rowsize != 16 && rowsize != 32)
 		rowsize = 16;
@@ -274,6 +277,20 @@ void print_hex_dump(const char *level, const char *prefix_str, int prefix_type,
 		linelen = min(remaining, rowsize);
 		remaining -= rowsize;
 
+		if (flags & DUMP_FLAG_SKIP_IDENTICAL_LINES) {
+			if (i && !memcmp(ptr + i, ptr + prev_i, linelen)) {
+				prev_i = i;
+				if (same_line)
+					continue;
+				same_line = true;
+				printk("%s*\n", level);
+				continue;
+			} else {
+				prev_i = i;
+				same_line = false;
+			}
+		}
+
 		hex_dump_to_buffer(ptr + i, linelen, rowsize, groupsize,
 				   linebuf, sizeof(linebuf),
 				   flags & DUMP_FLAG_ASCII);
-- 
2.43.0


