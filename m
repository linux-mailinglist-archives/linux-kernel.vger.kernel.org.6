Return-Path: <linux-kernel+bounces-370641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E4A79A2FFD
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 23:46:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6A5D285786
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 21:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FFE91D6DAD;
	Thu, 17 Oct 2024 21:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ndF/Y2eo"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83831D54EF
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 21:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729201572; cv=none; b=ayygb1mRf/BdNrT4absUjIB5w63nctPKre5/5TThzbWiiBKmAbXYcik0IMCrSDPTNvyt4/+56oyNOPAa/9Uv9mFwldtYGBRlmrQMv+Ucw+FB/ei4/893QtOlg3XBKHCX9H0klbW2djA8EzVE0bpQJd5lJt3wIGYlLG6rWh83nGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729201572; c=relaxed/simple;
	bh=q1K1HW3jG8IKYVi9MlhEha1p/ZeGitimdFUzzW5h+D0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eQ5Ya/1lJwmFov6igwX1ybaj4QmjuQPjz4ne99D3NU9wOp9Cxv6PImhHgR0MPcikJ1GQXelN8piYBFnhYCvI5Dm5Iwo/N/Mp/fgU6hydOPBrfvz1xhl/FQuXtsX9PhbTX/nuue9Tznl3wcfi7M1Cx7q7ShABhCj9KNQyEiqK418=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ndF/Y2eo; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-7ea6a4b3807so189800a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 14:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729201570; x=1729806370; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tI1WUEgzzH52RdmMvRjnf4Xl2Jbh0RwAUil8kMyE9bo=;
        b=ndF/Y2eofH8dVcyKn9Nr7feG5l4Q9h0HafG/s41+N/Z018PoA/zqK4KAQWGY7+rMER
         /VQo/FoUJvCP4Ck3GtEY42KDYoxZllWnb1O8zscYVilmHKILGl36g2ZIn1tOoUqjEql2
         vmV+zvZKRFPB8Qv6QlBRl6+pkMx/LuoFhjNfrYyFeGYP8Ms0/2bi2u45EXdieu+jeShx
         df00lHljVaf6s7km5Mp/O0T4/4pqhUSukfxjT7GIn0Kjn6DzcxR/uPWFsgQYqvNFcpHv
         PWxGQFjIvLa4BsYhfP662PYb1+B8DpCVip8eKTDZeG4v3i5bAzPNzqRWc4PpPzx00Vwa
         +kSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729201570; x=1729806370;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tI1WUEgzzH52RdmMvRjnf4Xl2Jbh0RwAUil8kMyE9bo=;
        b=cdqmFZ8k1tXNej3OFxQcGV/hDWjYKsyWZhajwRpgSxwyRebE+k5RqtkiJ4vQucURpq
         Q268YpPueOwjzQMvDvqjJUeE+gGp9nTbU7bKxQfcqeM535une3XYY2XCSlpW4UG6ybZH
         VAm30abBsygGNvUX77O4lxP/QkojYu3M6r6qpTFb4177BkERji4jgFMi3ozx5tAa29Bj
         vR9bvjuRBVlxYvRgpzFPVmquGF9lgsCclIR8i0XTHmQlxL/b4tJAylMFNb/vPPKsEGjp
         kt8gz5eO88X0t5Lpwq7aZreJ8Bi3WsrQjkNaVLIPPTJItjir4vDqImauBRRfn8b1lOvi
         qK4g==
X-Forwarded-Encrypted: i=1; AJvYcCXJS6Hulo/VDOlUNTY0gBCuZwR0DKdFrGRtTdCvUGiIlFg1jF9HwZiTvCeHyydqbweWMyEC5rawRI3b0SQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBICBjP2uN7lSai2PA4zjVzI0XPYKNM6opdM34AP6s3Kk/oA81
	GZKmh03gahvKaUedymTjpKLbNnpMD4wwzddziTsySDmvlgHVvlVJ
X-Google-Smtp-Source: AGHT+IF4KxhFLm8lSHBoImRllcM8d/1wTkuCTPJjrr+qggsaUckdNMGZ05pJj+u6O7CblCNEP75N0Q==
X-Received: by 2002:a05:6a21:9990:b0:1cf:2be2:6525 with SMTP id adf61e73a8af0-1d92c5872eemr219645637.11.1729201569998;
        Thu, 17 Oct 2024 14:46:09 -0700 (PDT)
Received: from ice.. ([171.76.83.88])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7eacc20d2desm62817a12.7.2024.10.17.14.46.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 14:46:09 -0700 (PDT)
From: Nihar Chaithanya <niharchaithanya@gmail.com>
To: ryabinin.a.a@gmail.com
Cc: andreyknvl@gmail.com,
	dvyukov@google.com,
	skhan@linuxfoundation.org,
	kasan-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	Nihar Chaithanya <niharchaithanya@gmail.com>
Subject: [PATCH] kasan:report: filter out kasan related stack entries
Date: Fri, 18 Oct 2024 03:12:54 +0530
Message-Id: <20241017214251.170602-1-niharchaithanya@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The reports of KASAN include KASAN related stack frames which are not
the point of interest in the stack-trace. KCSAN report filters out such
internal frames providing relevant stack trace. Currently, KASAN reports
are generated by dump_stack_lvl() which prints the entire stack.

Add functionality to KASAN reports to save the stack entries and filter
out the kasan related stack frames in place of dump_stack_lvl().

Within this new functionality:
	- A function save_stack_lvl_kasan() in place of dump_stack_lvl() is
	  created which contains functionality for saving, filtering and printing
          the stack-trace.
	- The stack-trace is saved to an array using stack_trace_save() similar to
  	  KCSAN reporting which is useful for filtering the stack-trace,
	- The sanitize_stack_entries() function is included to get the number of
          entries to be skipped for filtering similar to KCSAN reporting,
	- The dump_stack_print_info() which prints generic debug info is included
  	  from __dump_stack(),
	- And the function print_stack_trace() to print the stack-trace using the
 	  array containing stack entries as well as the number of entries to be
 	  skipped or filtered out is included.

Signed-off-by: Nihar Chaithanya <niharchaithanya@gmail.com>
Fixes: https://bugzilla.kernel.org/show_bug.cgi?id=215756
---
 mm/kasan/report.c | 92 +++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 90 insertions(+), 2 deletions(-)

diff --git a/mm/kasan/report.c b/mm/kasan/report.c
index b48c768acc84..c180cd8b32ae 100644
--- a/mm/kasan/report.c
+++ b/mm/kasan/report.c
@@ -39,6 +39,7 @@ static unsigned long kasan_flags;
 
 #define KASAN_BIT_REPORTED	0
 #define KASAN_BIT_MULTI_SHOT	1
+#define NUM_STACK_ENTRIES 64
 
 enum kasan_arg_fault {
 	KASAN_ARG_FAULT_DEFAULT,
@@ -369,12 +370,99 @@ static inline bool init_task_stack_addr(const void *addr)
 			sizeof(init_thread_union.stack));
 }
 
+/* Helper to skip KASAN-related functions in stack-trace. */
+static int get_stack_skipnr(const unsigned long stack_entries[], int num_entries)
+{
+	char buf[64];
+	int len, skip;
+
+	for (skip = 0; skip < num_entries; ++skip) {
+		len = scnprintf(buf, sizeof(buf), "%ps", (void *)stack_entries[skip]);
+
+		/* Never show  kasan_* functions. */
+		if (strnstr(buf, "kasan_", len) == buf)
+			continue;
+		/*
+		 * No match for runtime functions -- @skip entries to skip to
+		 * get to first frame of interest.
+		 */
+		break;
+	}
+
+	return skip;
+}
+
+static int
+replace_stack_entry(unsigned long stack_entries[], int num_entries, unsigned long ip,
+		    unsigned long *replaced)
+{
+	unsigned long symbolsize, offset;
+	unsigned long target_func;
+	int skip;
+
+	if (kallsyms_lookup_size_offset(ip, &symbolsize, &offset))
+		target_func = ip - offset;
+	else
+		goto fallback;
+
+	for (skip = 0; skip < num_entries; ++skip) {
+		unsigned long func = stack_entries[skip];
+
+		if (!kallsyms_lookup_size_offset(func, &symbolsize, &offset))
+			goto fallback;
+		func -= offset;
+
+		if (func == target_func) {
+			*replaced = stack_entries[skip];
+			stack_entries[skip] = ip;
+			return skip;
+		}
+	}
+
+fallback:
+	/* Should not happen; the resulting stack trace is likely misleading. */
+	WARN_ONCE(1, "Cannot find frame for %pS in stack trace", (void *)ip);
+	return get_stack_skipnr(stack_entries, num_entries);
+}
+
+static void
+print_stack_trace(unsigned long stack_entries[], int num_entries, unsigned long reordered_to)
+{
+	stack_trace_print(stack_entries, num_entries, 0);
+	if (reordered_to)
+		pr_err("  |\n  +-> reordered to: %pS\n", (void *)reordered_to);
+}
+
+static int
+sanitize_stack_entries(unsigned long stack_entries[], int num_entries, unsigned long ip,
+		       unsigned long *replaced)
+{
+	return ip ? replace_stack_entry(stack_entries, num_entries, ip, replaced) :
+			  get_stack_skipnr(stack_entries, num_entries);
+}
+
+static void save_stack_lvl_kasan(const char *log_lvl, struct kasan_report_info *info)
+{
+	unsigned long reordered_to = 0;
+	unsigned long stack_entries[NUM_STACK_ENTRIES] = {0};
+	int num_stack_entries = stack_trace_save(stack_entries, NUM_STACK_ENTRIES, 1);
+	int skipnr = sanitize_stack_entries(stack_entries,
+				 num_stack_entries, info->ip, &reordered_to);
+
+	dump_stack_print_info(log_lvl);
+	pr_err("\n");
+
+	print_stack_trace(stack_entries + skipnr, num_stack_entries - skipnr,
+					 reordered_to);
+	pr_err("\n");
+}
+
 static void print_address_description(void *addr, u8 tag,
 				      struct kasan_report_info *info)
 {
 	struct page *page = addr_to_page(addr);
 
-	dump_stack_lvl(KERN_ERR);
+	save_stack_lvl_kasan(KERN_ERR, info);
 	pr_err("\n");
 
 	if (info->cache && info->object) {
@@ -488,7 +576,7 @@ static void print_report(struct kasan_report_info *info)
 		print_address_description(addr, tag, info);
 		print_memory_metadata(info->first_bad_addr);
 	} else {
-		dump_stack_lvl(KERN_ERR);
+		save_stack_lvl_kasan(KERN_ERR, info);
 	}
 }
 
-- 
2.34.1


