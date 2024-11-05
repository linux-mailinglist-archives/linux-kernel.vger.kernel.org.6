Return-Path: <linux-kernel+bounces-396738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 612699BD169
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 17:01:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 851E31C229C0
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 16:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5D9A1E1C26;
	Tue,  5 Nov 2024 15:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="etRW7Ceo"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED191DE2A9
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 15:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730822316; cv=none; b=DaH5AHuLiWpUcSJDmjVvS+mJ494qV+A7F/ewmaF5SJoxIgfCYBsqc4sLWhw/ppK65QCpdcE2qHJVJ24Wc/qO/puHxbDUTB1MRWFSuLg1S40nAyjXAMNCUZm5e90TqPRtHSyM7I+zwAlBqomd1HKuheEPQsPu4zlIDU0OtYtTvSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730822316; c=relaxed/simple;
	bh=uS7QM2OlO2Fy0ecWbAAO2d+aA/HsKz+/e9K4Qda2RF8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qWYCYkCF0e44LNtyXvHOfgbwyppdMPAghLaOoFfj/YF1AL1wDLlkSZoBT5H1VeFtX+Ma6bthmFK9CSVdzdfoZVKRG3XECfg79Y48fBzWaKqhnvlPJ3IzvJooG0hHJCB3M885a8sbYImYx/dExrvXADpZt/MG5ddBLzwIqtm4VxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=etRW7Ceo; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-460c316fc37so41072721cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 07:58:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730822313; x=1731427113; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7ixh7vcAwRrq/kjGmH6l0IZgJtKtt8jYOoa3BHfLv64=;
        b=etRW7Ceo7ceouH4XgCtd43L72QNNX6QCwyTk4Wq90I6VQ32sP9iWjFsnrnPASjUcRO
         PRkV3doNPHZwIWLOl9XoXJqf/6Ah3M4Qe0GOA07Zrh7rinsVclVw5DBv6LQRSZpPZOVZ
         uN2PJ7ERFl3Oum/acqu/ekFDYxLYJ0JTOewc22G1RNMw8AxxRd4xPvTeE3Zlymq6VQe2
         E9//hIFvUrvzGavTcTaIQqx8huHkrz4XaqaDRxWp7J+v1SuXacpXY7ECX0SHSxL0Ji7K
         czgwQHOGN3DdiS8GX1dn+t8p6a6xxkAcaNppXiksAKt6dZcbdf6JSdwQimXvdTUjvSBR
         keKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730822313; x=1731427113;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7ixh7vcAwRrq/kjGmH6l0IZgJtKtt8jYOoa3BHfLv64=;
        b=FfThJ9hYKp3YIRrejDQDhOMwbS8H8dV9SwJcaCSboLpMYEiQ5MBOqCsoSspY/+7+py
         VqWcWTcutXCkIGzV18OCYPSW3EICyWD8dyWNTdYvv/7l/rLCIGxVieipMjvfS7YV/7je
         QdkKJy6GQEDgBQIFKLP1hG/E7ZTZAYhp7+Bhr9kxpOqTFgYzZ6oYK2gWFyzeUEcOq5Nd
         ZrOUODd43nvWXqtVf+RfB218BKzZCMoUE2BKikhMpqIMO83n68iGg/HfpNbGK3Oy/1fO
         Lrhc6iCfPFOBDxVQ1ZraTn6LZhDqLeLlrWrYu9Sx/QBOpUi70RRhquo9+5FcufeTAhUY
         zmEA==
X-Gm-Message-State: AOJu0YzwRemjfD3z6/5GwivigCUDr/DWiAieBykTT6bKU8kJlZmEbNPJ
	/vpaOItdR7FmKW0e6xytA2qEutfX+4L3RP1vnik8Yk4bUNzF4trdoDWX
X-Google-Smtp-Source: AGHT+IHqWlznjinIIbx/AjHipDuqCQmNCVECj1E8S8blpnNnVSIOBbeSXQTUl0++vBtANNxPdVOR7A==
X-Received: by 2002:a05:6214:4406:b0:6d3:77b8:cb3 with SMTP id 6a1803df08f44-6d377b80d00mr98421416d6.12.1730822312663;
        Tue, 05 Nov 2024 07:58:32 -0800 (PST)
Received: from citadel.lan ([2600:6c4a:4d3f:6d5c::1019])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d353fc6d07sm61710586d6.44.2024.11.05.07.58.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 07:58:32 -0800 (PST)
From: Brian Gerst <brgerst@gmail.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org
Cc: Ingo Molnar <mingo@kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Ard Biesheuvel <ardb@kernel.org>,
	Uros Bizjak <ubizjak@gmail.com>,
	Brian Gerst <brgerst@gmail.com>
Subject: [PATCH v5 16/16] kallsyms: Remove KALLSYMS_ABSOLUTE_PERCPU
Date: Tue,  5 Nov 2024 10:58:01 -0500
Message-ID: <20241105155801.1779119-17-brgerst@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241105155801.1779119-1-brgerst@gmail.com>
References: <20241105155801.1779119-1-brgerst@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

x86-64 was the only user.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
---
 init/Kconfig            |  5 ---
 kernel/kallsyms.c       | 12 ++-----
 scripts/kallsyms.c      | 72 +++++++----------------------------------
 scripts/link-vmlinux.sh |  4 ---
 4 files changed, 14 insertions(+), 79 deletions(-)

diff --git a/init/Kconfig b/init/Kconfig
index b374c0de5cfd..32db844d00d1 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1846,11 +1846,6 @@ config KALLSYMS_ALL
 
 	  Say N unless you really need all symbols, or kernel live patching.
 
-config KALLSYMS_ABSOLUTE_PERCPU
-	bool
-	depends on KALLSYMS
-	default n
-
 # end of the "standard kernel features (expert users)" menu
 
 config ARCH_HAS_MEMBARRIER_CALLBACKS
diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
index a9a0ca605d4a..4198f30aac3c 100644
--- a/kernel/kallsyms.c
+++ b/kernel/kallsyms.c
@@ -148,16 +148,8 @@ static unsigned int get_symbol_offset(unsigned long pos)
 
 unsigned long kallsyms_sym_address(int idx)
 {
-	/* values are unsigned offsets if --absolute-percpu is not in effect */
-	if (!IS_ENABLED(CONFIG_KALLSYMS_ABSOLUTE_PERCPU))
-		return kallsyms_relative_base + (u32)kallsyms_offsets[idx];
-
-	/* ...otherwise, positive offsets are absolute values */
-	if (kallsyms_offsets[idx] >= 0)
-		return kallsyms_offsets[idx];
-
-	/* ...and negative offsets are relative to kallsyms_relative_base - 1 */
-	return kallsyms_relative_base - 1 - kallsyms_offsets[idx];
+	/* values are unsigned offsets */
+	return kallsyms_relative_base + (u32)kallsyms_offsets[idx];
 }
 
 static unsigned int get_symbol_seq(int index)
diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
index 03852da3d249..4b0234e4b12f 100644
--- a/scripts/kallsyms.c
+++ b/scripts/kallsyms.c
@@ -5,7 +5,7 @@
  * This software may be used and distributed according to the terms
  * of the GNU General Public License, incorporated herein by reference.
  *
- * Usage: kallsyms [--all-symbols] [--absolute-percpu]  in.map > out.S
+ * Usage: kallsyms [--all-symbols] in.map > out.S
  *
  *      Table compression uses all the unused char codes on the symbols and
  *  maps these to the most used substrings (tokens). For instance, it might
@@ -37,7 +37,6 @@ struct sym_entry {
 	unsigned long long addr;
 	unsigned int len;
 	unsigned int seq;
-	bool percpu_absolute;
 	unsigned char sym[];
 };
 
@@ -55,14 +54,9 @@ static struct addr_range text_ranges[] = {
 #define text_range_text     (&text_ranges[0])
 #define text_range_inittext (&text_ranges[1])
 
-static struct addr_range percpu_range = {
-	"__per_cpu_start", "__per_cpu_end", -1ULL, 0
-};
-
 static struct sym_entry **table;
 static unsigned int table_size, table_cnt;
 static int all_symbols;
-static int absolute_percpu;
 
 static int token_profit[0x10000];
 
@@ -73,7 +67,7 @@ static unsigned char best_table_len[256];
 
 static void usage(void)
 {
-	fprintf(stderr, "Usage: kallsyms [--all-symbols] [--absolute-percpu] in.map > out.S\n");
+	fprintf(stderr, "Usage: kallsyms [--all-symbols] in.map > out.S\n");
 	exit(1);
 }
 
@@ -164,7 +158,6 @@ static struct sym_entry *read_symbol(FILE *in, char **buf, size_t *buf_len)
 		return NULL;
 
 	check_symbol_range(name, addr, text_ranges, ARRAY_SIZE(text_ranges));
-	check_symbol_range(name, addr, &percpu_range, 1);
 
 	/* include the type field in the symbol name, so that it gets
 	 * compressed together */
@@ -175,7 +168,6 @@ static struct sym_entry *read_symbol(FILE *in, char **buf, size_t *buf_len)
 	sym->len = len;
 	sym->sym[0] = type;
 	strcpy(sym_name(sym), name);
-	sym->percpu_absolute = false;
 
 	return sym;
 }
@@ -319,11 +311,6 @@ static int expand_symbol(const unsigned char *data, int len, char *result)
 	return total;
 }
 
-static bool symbol_absolute(const struct sym_entry *s)
-{
-	return s->percpu_absolute;
-}
-
 static int compare_names(const void *a, const void *b)
 {
 	int ret;
@@ -455,22 +442,11 @@ static void write_src(void)
 		 */
 
 		long long offset;
-		bool overflow;
-
-		if (!absolute_percpu) {
-			offset = table[i]->addr - relative_base;
-			overflow = offset < 0 || offset > UINT_MAX;
-		} else if (symbol_absolute(table[i])) {
-			offset = table[i]->addr;
-			overflow = offset < 0 || offset > INT_MAX;
-		} else {
-			offset = relative_base - table[i]->addr - 1;
-			overflow = offset < INT_MIN || offset >= 0;
-		}
-		if (overflow) {
+
+		offset = table[i]->addr - relative_base;
+		if (offset < 0 || offset > UINT_MAX) {
 			fprintf(stderr, "kallsyms failure: "
-				"%s symbol value %#llx out of range in relative mode\n",
-				symbol_absolute(table[i]) ? "absolute" : "relative",
+				"relative symbol value %#llx out of range\n",
 				table[i]->addr);
 			exit(EXIT_FAILURE);
 		}
@@ -725,36 +701,15 @@ static void sort_symbols(void)
 	qsort(table, table_cnt, sizeof(table[0]), compare_symbols);
 }
 
-static void make_percpus_absolute(void)
-{
-	unsigned int i;
-
-	for (i = 0; i < table_cnt; i++)
-		if (symbol_in_range(table[i], &percpu_range, 1)) {
-			/*
-			 * Keep the 'A' override for percpu symbols to
-			 * ensure consistent behavior compared to older
-			 * versions of this tool.
-			 */
-			table[i]->sym[0] = 'A';
-			table[i]->percpu_absolute = true;
-		}
-}
-
 /* find the minimum non-absolute symbol address */
 static void record_relative_base(void)
 {
-	unsigned int i;
-
-	for (i = 0; i < table_cnt; i++)
-		if (!symbol_absolute(table[i])) {
-			/*
-			 * The table is sorted by address.
-			 * Take the first non-absolute symbol value.
-			 */
-			relative_base = table[i]->addr;
-			return;
-		}
+	/*
+	 * The table is sorted by address.
+	 * Take the first symbol value.
+	 */
+	if (table_cnt)
+		relative_base = table[0]->addr;
 }
 
 int main(int argc, char **argv)
@@ -762,7 +717,6 @@ int main(int argc, char **argv)
 	while (1) {
 		static const struct option long_options[] = {
 			{"all-symbols",     no_argument, &all_symbols,     1},
-			{"absolute-percpu", no_argument, &absolute_percpu, 1},
 			{},
 		};
 
@@ -779,8 +733,6 @@ int main(int argc, char **argv)
 
 	read_map(argv[optind]);
 	shrink_table();
-	if (absolute_percpu)
-		make_percpus_absolute();
 	sort_symbols();
 	record_relative_base();
 	optimize_token_table();
diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index a9b3f34a78d2..df5f3fbb46f3 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -140,10 +140,6 @@ kallsyms()
 		kallsymopt="${kallsymopt} --all-symbols"
 	fi
 
-	if is_enabled CONFIG_KALLSYMS_ABSOLUTE_PERCPU; then
-		kallsymopt="${kallsymopt} --absolute-percpu"
-	fi
-
 	info KSYMS "${2}.S"
 	scripts/kallsyms ${kallsymopt} "${1}" > "${2}.S"
 
-- 
2.47.0


