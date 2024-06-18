Return-Path: <linux-kernel+bounces-218486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D83B490C072
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 02:39:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCA011C20D4E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 00:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2976C481BD;
	Tue, 18 Jun 2024 00:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JFCVOQmX"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC494654D
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 00:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718670995; cv=none; b=PKIP2ruYE9Mag731PeRF0BsywxI/B/MAv2IOWOYL2oHrbCU5JxFpQ+vG44rU3cDbbVLUT9Y0Sh3eoq2/6Pf7mYqBxFjKHfWmoHWh0JxvlH1QzaRYQ12PJAmpdpHl9jATuz3aXoN5aYtiCCbpKFPfliRXGc5zXtuzxAEu6An1AWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718670995; c=relaxed/simple;
	bh=1o03+tyZEtYM4um+426rzvDE1hsWAW9PnI94x6z1KdE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SOOqN1BkkRhRfOHJgfssDlDseL4/Nq2mWAVvgs+ibOLaY1+XWdp4Ww6C16tzcWMC8/RpWTHH1FTX2xxDmBID+5K29z1MQFuN21RS7qpG+KvuCUj8QU6uNok4Ijnmoi2jjxBsozKxq3fZuBwCDfgy3C2JjhRMmDx0V+dxjRcYaTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=JFCVOQmX; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-70413de08c7so3557883b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 17:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1718670993; x=1719275793; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lAce2BbpEK1CBNaRWM54Pp5Bl8/PNgc1s0HraY4ZUrU=;
        b=JFCVOQmXDiHti/tkEW444QqUaxNPgQyLywjsssIbSVeuHlFtk8Gz8ZAMrE6PDyMm5z
         znh43PtaVAUMQ3vFE/uQh3eBqEZtDiYI6fe01nMEtea7l164GDOTR3hHttCWNWcCIBVB
         2Mm5Ti7kc6D7Rdb1ww7mLbKkpXKEPLw4EIw8k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718670993; x=1719275793;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lAce2BbpEK1CBNaRWM54Pp5Bl8/PNgc1s0HraY4ZUrU=;
        b=isuIsCE4AXDXZ/T0Sf+njyVPvOPagS4xNpxuWPKNHiB7PelzFd3gvjZ+fjtk8x2a1+
         SBIDiRapTWo4UJSEDsA7tb2VoUHxNrEgWrFHIeO+ZD+ms+WCwfsEVzL2wr//rBTqbvNa
         yoLA2G8OsO2tKcS8mjKlr3sNARncuwshBd/EDNbc3OAQRnOkumc5iKathQGVoTsGruOc
         kIUgQs8iEkmY5c0cK/G3ZcD5DT9Oz6lrDKlIKn/rVmpXxRjryIonru1FJrA4GpdEnJys
         ZUETfjD29oLIsxrAHNnmUBBZC2pLd3Ww5ryMOT1pS7clGw6TR6/sS37tvoh2pG/CAofM
         8YjQ==
X-Forwarded-Encrypted: i=1; AJvYcCUki91Jzx/W14jB+346KvBbJpCzpWqZwnhb7wTWMeA0oN4QK7wbm2wj757mVPqL8Z1/lf3mtgStPehJPNsEoZqKhcXP9poHYniuDdni
X-Gm-Message-State: AOJu0YzfOGRwvpueoCsPnV0VAfrdnzEkERtEEYbsMRd28r/mB6v8u+jH
	L85Yw/dwKp7qjGDD4YEjvTvEQ1pb9c04meCV9lvz/1oFQ7lPrlvNeJockTqyzNjWY/QQ68XYM90
	=
X-Google-Smtp-Source: AGHT+IGV9Py1qvucdwShLmpkRill7ZM+6U+g604nrmUu9QEAjDhM7zyjCzMTElgpRp32hmQUjdKn0Q==
X-Received: by 2002:a05:6a20:d488:b0:1b5:d10a:1b65 with SMTP id adf61e73a8af0-1bae8224fa0mr12214380637.49.1718670992951;
        Mon, 17 Jun 2024 17:36:32 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:1798:e71b:11ad:8b94])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705ccb99f4dsm7905917b3a.216.2024.06.17.17.36.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 17:36:31 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: Daniel Thompson <daniel.thompson@linaro.org>
Cc: kgdb-bugreport@lists.sourceforge.net,
	Douglas Anderson <dianders@chromium.org>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Jason Wessel <jason.wessel@windriver.com>,
	Thorsten Blum <thorsten.blum@toblux.com>,
	Yuran Pereira <yuran.pereira@hotmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 13/13] kdb: Add mdi, mdiW / mdiWcN commands to show iomapped memory
Date: Mon, 17 Jun 2024 17:34:47 -0700
Message-ID: <20240617173426.13.I572fb3cf62fae1e728dd154081101ae264dc3670@changeid>
X-Mailer: git-send-email 2.45.2.627.g7a2c4fd464-goog
In-Reply-To: <20240618003546.4144638-1-dianders@chromium.org>
References: <20240618003546.4144638-1-dianders@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add commands that are like the other "md" commands but that allow you
to read memory that's in the IO space.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 kernel/debug/kdb/kdb_main.c    | 38 +++++++++++++++++++++++----
 kernel/debug/kdb/kdb_private.h |  1 +
 kernel/debug/kdb/kdb_support.c | 48 ++++++++++++++++++++++++++++++++++
 3 files changed, 82 insertions(+), 5 deletions(-)

diff --git a/kernel/debug/kdb/kdb_main.c b/kernel/debug/kdb/kdb_main.c
index be72657741a5..a90d1e1482c2 100644
--- a/kernel/debug/kdb/kdb_main.c
+++ b/kernel/debug/kdb/kdb_main.c
@@ -1526,7 +1526,7 @@ static int kdb_mdr(int argc, const char **argv)
  */
 static void kdb_md_line(const char *fmtstr, unsigned long addr,
 			bool symbolic, bool nosect, int bytesperword,
-			int num, int repeat, bool phys)
+			int num, int repeat, bool phys, bool do_iomap)
 {
 	/* print just one line of data */
 	kdb_symtab_t symtab;
@@ -1543,7 +1543,10 @@ static void kdb_md_line(const char *fmtstr, unsigned long addr,
 		kdb_printf(kdb_machreg_fmt0 " ", addr);
 
 	for (i = 0; i < num && repeat--; i++) {
-		if (phys) {
+		if (do_iomap) {
+			if (kdb_getioword(&word, addr, bytesperword))
+				break;
+		} else if (phys) {
 			if (kdb_getphysword(&word, addr, bytesperword))
 				break;
 		} else if (kdb_getword(&word, addr, bytesperword))
@@ -1646,6 +1649,7 @@ static int kdb_md(int argc, const char **argv)
 	bool symbolic = false;
 	bool valid = false;
 	bool phys = false;
+	bool do_iomap = false;
 
 	kdbgetintenv("MDCOUNT", &mdcount);
 	kdbgetintenv("RADIX", &radix);
@@ -1655,6 +1659,8 @@ static int kdb_md(int argc, const char **argv)
 		valid = true;
 	else if (kdb_md_parse_arg0("mdp", argv[0], &repeat, &bytesperword))
 		phys = valid = true;
+	else if (kdb_md_parse_arg0("mdi", argv[0], &repeat, &bytesperword))
+		do_iomap = valid = true;
 	else if (strcmp(argv[0], "mds") == 0)
 		valid = true;
 
@@ -1765,7 +1771,11 @@ static int kdb_md(int argc, const char **argv)
 		if (KDB_FLAG(CMD_INTERRUPT))
 			return 0;
 		for (a = addr, z = 0; z < repeat; a += bytesperword, ++z) {
-			if (phys) {
+			if (do_iomap) {
+				if (kdb_getioword(&word, a, bytesperword)
+						|| word)
+					break;
+			} else if (phys) {
 				if (kdb_getphysword(&word, a, bytesperword)
 						|| word)
 					break;
@@ -1774,7 +1784,7 @@ static int kdb_md(int argc, const char **argv)
 		}
 		n = min(num, repeat);
 		kdb_md_line(fmtstr, addr, symbolic, nosect, bytesperword,
-			    num, repeat, phys);
+			    num, repeat, phys, do_iomap);
 		addr += bytesperword * n;
 		repeat -= n;
 		z = (z + num - 1) / num;
@@ -2604,7 +2614,7 @@ static int kdb_per_cpu(int argc, const char **argv)
 		kdb_printf("%5d ", cpu);
 		kdb_md_line(fmtstr, addr,
 			bytesperword == KDB_WORD_SIZE,
-			1, bytesperword, 1, 1, 0);
+			true, bytesperword, 1, 1, false, false);
 	}
 #undef KDB_PCU
 	return 0;
@@ -2717,6 +2727,24 @@ static kdbtab_t maintab[] = {
 		.help = "Display RAM given a PA using word size (W); show N words",
 		.flags = KDB_ENABLE_MEM_READ | KDB_REPEAT_NO_ARGS,
 	},
+	{	.name = "mdi",
+		.func = kdb_md,
+		.usage = "<paddr> <bytes>",
+		.help = "Display IO Memory",
+		.flags = KDB_ENABLE_MEM_READ | KDB_REPEAT_NO_ARGS,
+	},
+	{	.name = "mdiW",
+		.func = kdb_md,
+		.usage = "<paddr> <bytes>",
+		.help = "Display IO Memory using word size (W)",
+		.flags = KDB_ENABLE_MEM_READ | KDB_REPEAT_NO_ARGS,
+	},
+	{	.name = "mdiWcN",
+		.func = kdb_md,
+		.usage = "<paddr> <bytes>",
+		.help = "Display IO Memory using word size (W); show N words",
+		.flags = KDB_ENABLE_MEM_READ | KDB_REPEAT_NO_ARGS,
+	},
 	{	.name = "mdr",
 		.func = kdb_mdr,
 		.usage = "<vaddr> <bytes>",
diff --git a/kernel/debug/kdb/kdb_private.h b/kernel/debug/kdb/kdb_private.h
index 1f685d9f16f9..caece6240140 100644
--- a/kernel/debug/kdb/kdb_private.h
+++ b/kernel/debug/kdb/kdb_private.h
@@ -97,6 +97,7 @@ extern int kdb_putarea_size(unsigned long, void *, size_t);
 #define kdb_getarea(x, addr) kdb_getarea_size(&(x), addr, sizeof((x)))
 #define kdb_putarea(addr, x) kdb_putarea_size(addr, &(x), sizeof((x)))
 
+extern int kdb_getioword(unsigned long *word, unsigned long addr, size_t size);
 extern int kdb_getphysword(unsigned long *word,
 			unsigned long addr, size_t size);
 extern int kdb_getword(unsigned long *, unsigned long, size_t);
diff --git a/kernel/debug/kdb/kdb_support.c b/kernel/debug/kdb/kdb_support.c
index 0a39497140bf..5a4e3a0e96a5 100644
--- a/kernel/debug/kdb/kdb_support.c
+++ b/kernel/debug/kdb/kdb_support.c
@@ -19,6 +19,7 @@
 #include <linux/ptrace.h>
 #include <linux/highmem.h>
 #include <linux/hardirq.h>
+#include <linux/io.h>
 #include <linux/delay.h>
 #include <linux/uaccess.h>
 #include <linux/kdb.h>
@@ -331,6 +332,53 @@ static int kdb_getphys(void *res, unsigned long addr, size_t size)
 	return 0;
 }
 
+/*
+ * kdb_getioword
+ * Inputs:
+ *	word	Pointer to the word to receive the result.
+ *	addr	Address of the area to copy.
+ *	size	Size of the area.
+ * Returns:
+ *	0 for success, < 0 for error.
+ */
+int kdb_getioword(unsigned long *word, unsigned long addr, size_t size)
+{
+	void __iomem *mapped = ioremap(addr, size);
+	int diag = 0;
+
+	*word = 0;	/* Default value if addr or size is invalid */
+
+	if (!mapped)
+		return KDB_BADADDR;
+
+	switch (size) {
+	case 1:
+		*word = readb(mapped);
+		break;
+	case 2:
+		*word = readw(mapped);
+		break;
+	case 4:
+		*word = readl(mapped);
+		break;
+	case 8:
+#ifdef CONFIG_64BIT
+		if (size <= sizeof(*word)) {
+			*word = readq(mapped);
+			break;
+		}
+#endif
+		fallthrough;
+	default:
+		kdb_func_printf("bad width %zu\n", size);
+		diag = KDB_BADWIDTH;
+	}
+
+	iounmap(mapped);
+
+	return diag;
+}
+
 /*
  * kdb_getphysword
  * Inputs:
-- 
2.45.2.627.g7a2c4fd464-goog


