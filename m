Return-Path: <linux-kernel+bounces-205331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 988498FFA9F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 06:37:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8338B25561
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 04:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDBEB15A4AF;
	Fri,  7 Jun 2024 04:27:24 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0351157A53
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 04:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717734443; cv=none; b=GCy6bkJDk2xS1in0mwRKgIjD73CvVS+yOic8muYLrxeJdHO7oOvtAeoycYd43Eht2PkmEeyn8+wWN3gqYqfLECf1qRq9Xo57Qan+I2POV65Gc+PlYDcJELVQjthyHbBqHZNZN9+uHy2lPXLJVn7VumjVYNtGTrvFIV3FyJUHEks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717734443; c=relaxed/simple;
	bh=mcW5Z5FQ6Y3GQ3OezzTtBmOWIdwMr2Ed8A4SuKE20Yg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Pdty15a4Mi1G4tEpchd7n43nES5iE1/T3jAjtNGPnBnn0tghlS9ywQ37AgMXGkZevkR9SYw+jV2d1h73OhcEv3P7nMUX/AkfMY4jSS4oRG9oUzpCIAYzCwE8or4WFkqox3mnW74AyJzamc44cqbDYrysb7ZFkKW+VGeu4kky3wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4VwSmx6R7bzdZhG;
	Fri,  7 Jun 2024 12:25:53 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (unknown [7.193.23.68])
	by mail.maildlp.com (Postfix) with ESMTPS id CC282140124;
	Fri,  7 Jun 2024 12:27:03 +0800 (CST)
Received: from huawei.com (10.175.104.67) by kwepemm600013.china.huawei.com
 (7.193.23.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 7 Jun
 2024 12:26:49 +0800
From: Zhihao Cheng <chengzhihao1@huawei.com>
To: <richard@nod.at>, <david.oberhollenzer@sigma-star.at>,
	<miquel.raynal@bootlin.com>, <yi.zhang@huawei.com>, <xiangyang3@huawei.com>,
	<huangxiaojia2@huawei.com>
CC: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH mtd-utils 030/110] ubifs-utils: Add linux hexdump implementations lib
Date: Fri, 7 Jun 2024 12:24:55 +0800
Message-ID: <20240607042615.2069840-31-chengzhihao1@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240607042615.2069840-1-chengzhihao1@huawei.com>
References: <20240607042615.2069840-1-chengzhihao1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600013.china.huawei.com (7.193.23.68)

Add linux hexdump implementations lib, because function print_hex_dump()
is used in UBIFS linux kernel libs.

This is a preparation for replacing implementation of UBIFS utils with
linux kernel libs.

Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 ubifs-utils/Makemodule.am    |   1 +
 ubifs-utils/common/defs.h    |   6 ++
 ubifs-utils/common/hexdump.c | 218 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 225 insertions(+)
 create mode 100644 ubifs-utils/common/hexdump.c

diff --git a/ubifs-utils/Makemodule.am b/ubifs-utils/Makemodule.am
index c14ba028..cb4e1cf1 100644
--- a/ubifs-utils/Makemodule.am
+++ b/ubifs-utils/Makemodule.am
@@ -24,6 +24,7 @@ common_SOURCES = \
 	ubifs-utils/common/hashtable/hashtable_itr.c \
 	ubifs-utils/common/devtable.h \
 	ubifs-utils/common/devtable.c \
+	ubifs-utils/common/hexdump.c \
 	ubifs-utils/common/ubifs.h \
 	ubifs-utils/common/key.h \
 	ubifs-utils/common/lpt.h \
diff --git a/ubifs-utils/common/defs.h b/ubifs-utils/common/defs.h
index 6d99a2fd..548d9dfb 100644
--- a/ubifs-utils/common/defs.h
+++ b/ubifs-utils/common/defs.h
@@ -26,6 +26,12 @@ enum { MKFS_PROGRAM_TYPE = 0 };
 
 enum { ERR_LEVEL = 1, WARN_LEVEL, INFO_LEVEL, DEBUG_LEVEL };
 
+enum {
+	DUMP_PREFIX_NONE,
+	DUMP_PREFIX_ADDRESS,
+	DUMP_PREFIX_OFFSET
+};
+
 #define pr_debug(fmt, ...) do { if (info_.debug_level >= DEBUG_LEVEL)	\
 	printf("<DEBUG> %s[%d] (%s): %s: " fmt, PROGRAM_NAME, getpid(),	\
 	       info_.dev_name, __FUNCTION__, ##__VA_ARGS__);		\
diff --git a/ubifs-utils/common/hexdump.c b/ubifs-utils/common/hexdump.c
new file mode 100644
index 00000000..7ac46943
--- /dev/null
+++ b/ubifs-utils/common/hexdump.c
@@ -0,0 +1,218 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * lib/hexdump.c
+ */
+
+#include <stdio.h>
+
+#include "linux_types.h"
+#include "defs.h"
+
+#define __get_unaligned_t(type, ptr) ({					   \
+	const struct { type x; } __packed *__pptr = (typeof(__pptr))(ptr); \
+	__pptr->x;								\
+})
+
+#define get_unaligned(ptr)      __get_unaligned_t(typeof(*(ptr)), (ptr))
+
+const char hex_asc[] = "0123456789abcdef";
+
+#define hex_asc_lo(x)   hex_asc[((x) & 0x0f)]
+#define hex_asc_hi(x)   hex_asc[((x) & 0xf0) >> 4]
+
+void print_hex_dump(const char *prefix_str, int prefix_type,
+		    int rowsize, int groupsize,
+		    const void *buf, size_t len, bool ascii);
+/**
+ * hex_dump_to_buffer - convert a blob of data to "hex ASCII" in memory
+ * @buf: data blob to dump
+ * @len: number of bytes in the @buf
+ * @rowsize: number of bytes to print per line; must be 16 or 32
+ * @groupsize: number of bytes to print at a time (1, 2, 4, 8; default = 1)
+ * @linebuf: where to put the converted data
+ * @linebuflen: total size of @linebuf, including space for terminating NUL
+ * @ascii: include ASCII after the hex output
+ *
+ * hex_dump_to_buffer() works on one "line" of output at a time, i.e.,
+ * 16 or 32 bytes of input data converted to hex + ASCII output.
+ *
+ * Given a buffer of u8 data, hex_dump_to_buffer() converts the input data
+ * to a hex + ASCII dump at the supplied memory location.
+ * The converted output is always NUL-terminated.
+ *
+ * E.g.:
+ *   hex_dump_to_buffer(frame->data, frame->len, 16, 1,
+ *			linebuf, sizeof(linebuf), true);
+ *
+ * example output buffer:
+ * 40 41 42 43 44 45 46 47 48 49 4a 4b 4c 4d 4e 4f  @ABCDEFGHIJKLMNO
+ *
+ * Return:
+ * The amount of bytes placed in the buffer without terminating NUL. If the
+ * output was truncated, then the return value is the number of bytes
+ * (excluding the terminating NUL) which would have been written to the final
+ * string if enough space had been available.
+ */
+static int hex_dump_to_buffer(const void *buf, size_t len, int rowsize,
+			      int groupsize, char *linebuf, size_t linebuflen,
+			      bool ascii)
+{
+	const u8 *ptr = buf;
+	int ngroups;
+	u8 ch;
+	int j, lx = 0;
+	int ascii_column;
+	int ret;
+
+	if (rowsize != 16 && rowsize != 32)
+		rowsize = 16;
+
+	if (len > rowsize)		/* limit to one line at a time */
+		len = rowsize;
+	if (!is_power_of_2(groupsize) || groupsize > 8)
+		groupsize = 1;
+	if ((len % groupsize) != 0)	/* no mixed size output */
+		groupsize = 1;
+
+	ngroups = len / groupsize;
+	ascii_column = rowsize * 2 + rowsize / groupsize + 1;
+
+	if (!linebuflen)
+		goto overflow1;
+
+	if (!len)
+		goto nil;
+
+	if (groupsize == 8) {
+		const u64 *ptr8 = buf;
+
+		for (j = 0; j < ngroups; j++) {
+			ret = snprintf(linebuf + lx, linebuflen - lx,
+				       "%s%16.16llx", j ? " " : "",
+				       get_unaligned(ptr8 + j));
+			if (ret >= linebuflen - lx)
+				goto overflow1;
+			lx += ret;
+		}
+	} else if (groupsize == 4) {
+		const u32 *ptr4 = buf;
+
+		for (j = 0; j < ngroups; j++) {
+			ret = snprintf(linebuf + lx, linebuflen - lx,
+				       "%s%8.8x", j ? " " : "",
+				       get_unaligned(ptr4 + j));
+			if (ret >= linebuflen - lx)
+				goto overflow1;
+			lx += ret;
+		}
+	} else if (groupsize == 2) {
+		const u16 *ptr2 = buf;
+
+		for (j = 0; j < ngroups; j++) {
+			ret = snprintf(linebuf + lx, linebuflen - lx,
+				       "%s%4.4x", j ? " " : "",
+				       get_unaligned(ptr2 + j));
+			if (ret >= linebuflen - lx)
+				goto overflow1;
+			lx += ret;
+		}
+	} else {
+		for (j = 0; j < len; j++) {
+			if (linebuflen < lx + 2)
+				goto overflow2;
+			ch = ptr[j];
+			linebuf[lx++] = hex_asc_hi(ch);
+			if (linebuflen < lx + 2)
+				goto overflow2;
+			linebuf[lx++] = hex_asc_lo(ch);
+			if (linebuflen < lx + 2)
+				goto overflow2;
+			linebuf[lx++] = ' ';
+		}
+		if (j)
+			lx--;
+	}
+	if (!ascii)
+		goto nil;
+
+	while (lx < ascii_column) {
+		if (linebuflen < lx + 2)
+			goto overflow2;
+		linebuf[lx++] = ' ';
+	}
+	for (j = 0; j < len; j++) {
+		if (linebuflen < lx + 2)
+			goto overflow2;
+		ch = ptr[j];
+		linebuf[lx++] = (isascii(ch) && isprint(ch)) ? ch : '.';
+	}
+nil:
+	linebuf[lx] = '\0';
+	return lx;
+overflow2:
+	linebuf[lx++] = '\0';
+overflow1:
+	return ascii ? ascii_column + len : (groupsize * 2 + 1) * ngroups - 1;
+}
+
+/**
+ * print_hex_dump - print a text hex dump to syslog for a binary blob of data
+ * @prefix_str: string to prefix each line with;
+ *  caller supplies trailing spaces for alignment if desired
+ * @prefix_type: controls whether prefix of an offset, address, or none
+ *  is printed (%DUMP_PREFIX_OFFSET, %DUMP_PREFIX_ADDRESS, %DUMP_PREFIX_NONE)
+ * @rowsize: number of bytes to print per line; must be 16 or 32
+ * @groupsize: number of bytes to print at a time (1, 2, 4, 8; default = 1)
+ * @buf: data blob to dump
+ * @len: number of bytes in the @buf
+ * @ascii: include ASCII after the hex output
+ *
+ * Given a buffer of u8 data, print_hex_dump() prints a hex + ASCII dump
+ * to the kernel log at the specified kernel log level, with an optional
+ * leading prefix.
+ *
+ * print_hex_dump() works on one "line" of output at a time, i.e.,
+ * 16 or 32 bytes of input data converted to hex + ASCII output.
+ * print_hex_dump() iterates over the entire input @buf, breaking it into
+ * "line size" chunks to format and print.
+ *
+ * E.g.:
+ *   print_hex_dump(KERN_DEBUG, "raw data: ", DUMP_PREFIX_ADDRESS,
+ *		    16, 1, frame->data, frame->len, true);
+ *
+ * Example output using %DUMP_PREFIX_OFFSET and 1-byte mode:
+ * 0009ab42: 40 41 42 43 44 45 46 47 48 49 4a 4b 4c 4d 4e 4f  @ABCDEFGHIJKLMNO
+ * Example output using %DUMP_PREFIX_ADDRESS and 4-byte mode:
+ * ffffffff88089af0: 73727170 77767574 7b7a7978 7f7e7d7c  pqrstuvwxyz{|}~.
+ */
+void print_hex_dump(const char *prefix_str, int prefix_type,
+		    int rowsize, int groupsize,
+		    const void *buf, size_t len, bool ascii)
+{
+	const u8 *ptr = buf;
+	int i, linelen, remaining = len;
+	char linebuf[32 * 3 + 2 + 32 + 1];
+
+	if (rowsize != 16 && rowsize != 32)
+		rowsize = 16;
+
+	for (i = 0; i < len; i += rowsize) {
+		linelen = min(remaining, rowsize);
+		remaining -= rowsize;
+
+		hex_dump_to_buffer(ptr + i, linelen, rowsize, groupsize,
+				   linebuf, sizeof(linebuf), ascii);
+
+		switch (prefix_type) {
+		case DUMP_PREFIX_ADDRESS:
+			printf("%s%p: %s\n", prefix_str, ptr + i, linebuf);
+			break;
+		case DUMP_PREFIX_OFFSET:
+			printf("%s%.8x: %s\n", prefix_str, i, linebuf);
+			break;
+		default:
+			printf("%s%s\n", prefix_str, linebuf);
+			break;
+		}
+	}
+}
-- 
2.13.6


