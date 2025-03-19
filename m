Return-Path: <linux-kernel+bounces-568370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 361A8A69490
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 17:16:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6538019C2E5B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 16:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A9581DFD98;
	Wed, 19 Mar 2025 16:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="FtX/YH15"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992281DE3AE;
	Wed, 19 Mar 2025 16:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742400727; cv=none; b=ljempT8UpGhhtHhKefw5BX+GXEviUlnKUmKyiEon18NA2QsofU7i6hDcpddu7dGaAxsTtHUjzUctocyolpF6BhKbUrZAut36LZOyrz06lEqcQbdXEyHZIeUbLpPUeIyolEmdl505LVChkuV+5j9KbTXCadzkFrfIIQ4UAf7U0Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742400727; c=relaxed/simple;
	bh=ZTORiOP8lCWlxqPdsA9WOVthA28claYMiiXwkgF4t0E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dx8hYCpbv5Misoqe6piPkz2er05okY8iE0wiB/5AhYS9GslPpq0E/ajb0BtRCOdGb1AI4u7SqdU81PDZ8DlJbSNAaAxVmJAJkMM0gvMqb8Nk2/JNNT/L72MUlVng6ebDpsZ0qppI7ptj7oyNm50wIPtwfxdY9bNMkDyEzQCZR8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=FtX/YH15; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4BE5620488;
	Wed, 19 Mar 2025 16:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1742400715;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b1yAFy1jrUWs7EUz51HeUQ/XlIqYqsEuyGm9trXWWY0=;
	b=FtX/YH15cz5MBTfAEo1M12IL65wfN42SFhpKoASraBoMJDBTvS3Tu5HafwMPgDsXEAUhE2
	jqlUcNzzEv+QOQk8avYXqEulDkmqtiZX2ZAozeZK1eoEtBokU5NiW3bzVRKUW2G1S+WG+k
	TCgoMuK9FCmz6Z7C/HiZqONxNfBRThlDx2vPmMh/ZGmARtVUNSa3FdXIH2GiqfczN0JDs5
	YvNTwAUftXNmZ0GB9ptPOd0a40rvE+cTsb5D72bbw72q4+qIhG7ofrgmFu9at7cWS4zG/H
	xe56a+se3incp1g8dbYNyMQMATYV3XhmCwD7loYS7yt0YOMD89ZsxW+NYZ837w==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Wed, 19 Mar 2025 17:08:11 +0100
Subject: [PATCH v3 2/3] hexdump: Allow skipping identical lines
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250319-perso-hexdump-v3-2-a6ba3a9f3742@bootlin.com>
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
 lib/hexdump.c                             | 20 +++++++++++++++++++-
 3 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/Documentation/core-api/printk-formats.rst b/Documentation/core-api/printk-formats.rst
index f80b5e262e9933992d1291f1d78fba97589d5631..820f92c65dc64e7d24af5c0031ee8c8d6bb0f931 100644
--- a/Documentation/core-api/printk-formats.rst
+++ b/Documentation/core-api/printk-formats.rst
@@ -310,7 +310,9 @@ Raw buffer as a hex string
 
 For printing small buffers (up to 64 bytes long) as a hex string with a
 certain separator. For larger buffers consider using
-:c:func:`print_hex`.
+:c:func:`print_hex`, especially since duplicated lines can be
+skipped automatically to reduce the overhead with the
+``DUMP_SKIP_IDENTICAL_LINES`` flag.
 
 MAC/FDDI addresses
 ------------------
diff --git a/include/linux/printk.h b/include/linux/printk.h
index 7dca2270c82c0ed788cd706274f1c1b14ed9a7fe..d9e3e4b0bab8d3ff6a49600abbdbc9b1e6320a60 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -757,6 +757,7 @@ enum {
 	DUMP_PREFIX_NONE = 0, /* Legacy definition for print_hex_dump() */
 	DUMP_PREFIX_ADDRESS = BIT(1),
 	DUMP_PREFIX_OFFSET = BIT(2),
+	DUMP_SKIP_IDENTICAL_LINES = BIT(3),
 };
 
 extern int hex_dump_to_buffer(const void *buf, size_t len, int rowsize,
diff --git a/lib/hexdump.c b/lib/hexdump.c
index 74fdcb4566d27f257a0e1288c261d81d231b06bf..f0d1a7f1ce817fd53a7ffd259fbe9b9c8348db16 100644
--- a/lib/hexdump.c
+++ b/lib/hexdump.c
@@ -8,6 +8,7 @@
 #include <linux/errno.h>
 #include <linux/kernel.h>
 #include <linux/minmax.h>
+#include <linux/string.h>
 #include <linux/export.h>
 #include <linux/unaligned.h>
 
@@ -240,6 +241,8 @@ EXPORT_SYMBOL(hex_dump_to_buffer);
  *   - %DUMP_PREFIX_OFFSET shows the offset in front of each line
  *   - %DUMP_PREFIX_ADDRESS shows the address in front of each line
  *   - %DUMP_ASCII prints the ascii equivalent after the hex output
+ *   - %DUMP_SKIP_IDENTICAL_LINES will display a single '*' instead of
+ *     duplicated lines.
  *
  * Given a buffer of u8 data, print_hex() prints a hex + ASCII dump
  * to the kernel log at the specified kernel log level, with an optional
@@ -263,8 +266,9 @@ void print_hex(const char *level, const char *prefix_str, int rowsize, int group
 	       const void *buf, size_t len, unsigned int dump_flags)
 {
 	const u8 *ptr = buf;
-	int i, linelen, remaining = len;
+	int i, prev_i, linelen, remaining = len;
 	unsigned char linebuf[32 * 3 + 2 + 32 + 1];
+	bool same_line = false;
 
 	if (rowsize != 16 && rowsize != 32)
 		rowsize = 16;
@@ -273,6 +277,20 @@ void print_hex(const char *level, const char *prefix_str, int rowsize, int group
 		linelen = min(remaining, rowsize);
 		remaining -= rowsize;
 
+		if (dump_flags & DUMP_SKIP_IDENTICAL_LINES) {
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
 				   dump_flags & DUMP_ASCII);

-- 
2.48.1


