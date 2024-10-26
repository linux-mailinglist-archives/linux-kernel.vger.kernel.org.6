Return-Path: <linux-kernel+bounces-383299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FA729B19B7
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 18:17:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 252B528227E
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 16:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CE0442AA6;
	Sat, 26 Oct 2024 16:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AFkpFvAB"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E6F1C32
	for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 16:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729959441; cv=none; b=sJ0a5RG52jtx9nXMgy+dMaapNk2ldhXSJwB37QwWsYXA+7BZsvokkMXzo2Qi3Tpu0B6fob2hA4USRVUK61MY8MrZb2sgN8jAYpoMu214r+weLm1Ps0YCPwx4juHfVZmwVxpQJ1ZYVFjOduCWV2Dk0aDICfXnemzyKfZQ/bXaukY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729959441; c=relaxed/simple;
	bh=/icf03M47VvEB/0t1y8XgfIVeTG1NyR7+ph00bmm2oc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CJGj8N5WqXvvhN7KwJkZ1I1MRmoWsTlAVtxAsuxZcvTPTRXy6HK7AVp/EX4QDEThvXFGP/fAukoMPyKK1W7WV9OBHTpOXdMoyY4oLJWsQdnn1GO7NNbKdJF4uYwGNIIm8X3gS95Lown4XrNEfQ1Ggaj7d6mz3pPhgz64rXbfBzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AFkpFvAB; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2e2b71fd16fso368610a91.3
        for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 09:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729959438; x=1730564238; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=q0ToQhndnLOEGKHRjsJDV2lxZ3cLs2ivXIHqcO/4O+s=;
        b=AFkpFvABcTqFNBi9qcvhjkjMLi7KyNnfVZMGvgTBVUwPC9VVXQsj9fqjfojBGzmMYn
         sGcvsm6aHdVjiGZxidjCdSu4mGG8ge4S6T5TH5t1MI3Oj1Tkcz2lnSfiyVTkKbwEsR/o
         APMatgRUS8+X+ihJufks38ziV8eoKGciNI8iTLe/YMY9NockgLkMKUiqsCvcGVOjeTKb
         W3QAGFHNnW6eQyUfPzI7bZiixNMaWKPu0MsoAhN1ai/vW+dIjaB+AOVbSX7ZNHAH12Uo
         poZcWm50G3kh1QXiQXkQtomrm1W3cSVZ7zb+mTq4BAHa1ece+FgpD+MQ53Bg5dYVAXjz
         xIPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729959438; x=1730564238;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q0ToQhndnLOEGKHRjsJDV2lxZ3cLs2ivXIHqcO/4O+s=;
        b=F8KPSXBEfufs8izPwEntq6+ZaSA2pc/dJyGrcyxviMougVdW06mM8JFRnvvaSRhY8j
         XUW0b0YSoqA8vaSBe+yVFp0yalnk5qgvDDkkD8Qrlr+YLBZS2yZOlQUMAl/H9vErzg+R
         yL5ZcYovEqWM8EKTJe+4s+gUFBGkeYha3S7ePQFpK2VhxUI7BVJieuDjEdHw//Wdp34x
         WDu/qRTQrqhOvxTn3Xn3ebLA/u/WVEwXJVftyByCbarUIwEIOqbCZP4eHyxYZ31D8Dro
         ShX3ePxLnaxaPCS1/IEu4yMvUJyDD4A48SdcGoKxrl3dZxX64AUsL3J01+RQ/bXECiZn
         nLWQ==
X-Forwarded-Encrypted: i=1; AJvYcCUpXMQAxl9vBIbT8dvKrM0yKkOkEnkzwvS7SMVGPC+Tczu/Xs8brlK0ok7TER9B3vVNkJPYGesBDC4gWEw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyc02y/GRfk7NWs0M41fIZabwGheY1jTBM5u6cvveiTKAdP02QU
	0iGYzowBrWRA8hXuOWooT0XfSX2h2bVcHMpngKfeGxxkuA91gC4i
X-Google-Smtp-Source: AGHT+IGggOKmGbto26xaeQ9xyFoSLi/VAbipK2NHUkw50UKrIJrIoWL91YzpC/9gu4sxX2p+0hFfIQ==
X-Received: by 2002:a17:90a:34cb:b0:2e1:682b:361e with SMTP id 98e67ed59e1d1-2e8f11a96dfmr1467042a91.4.1729959437577;
        Sat, 26 Oct 2024 09:17:17 -0700 (PDT)
Received: from ice.. ([171.76.87.243])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e8e3555adesm3661607a91.2.2024.10.26.09.17.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Oct 2024 09:17:17 -0700 (PDT)
From: Nihar Chaithanya <niharchaithanya@gmail.com>
To: ryabinin.a.a@gmail.com
Cc: andreyknvl@gmail.com,
	dvyukov@google.com,
	glider@google.com,
	elver@google.com,
	skhan@linuxfoundation.org,
	kasan-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	Nihar Chaithanya <niharchaithanya@gmail.com>
Subject: [PATCH v3] kasan: report: filter out kasan related stack entries
Date: Sat, 26 Oct 2024 21:44:17 +0530
Message-Id: <20241026161413.222898-1-niharchaithanya@gmail.com>
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
out the kasan related stack frames in place of dump_stack_lvl() and
stack_depot_print().

Within this new functionality:
	- A function kasan_dump_stack_lvl() in place of dump_stack_lvl() is
	  created which contains functionality for saving, filtering and
	  printing the stack-trace.
	- A function kasan_stack_depot_print() in place of
	  stack_depot_print() is created which contains functionality for
	  filtering and printing the stack-trace.
	- The get_stack_skipnr() function which employs pattern based stack
	  filtering is included.
	- The replace_stack_entry() function which uses ip value based
	  stack filtering is included.

Signed-off-by: Nihar Chaithanya <niharchaithanya@gmail.com>
Fixes: https://bugzilla.kernel.org/show_bug.cgi?id=215756
---
Changes in v2:
        - Changed the function name from save_stack_lvl_kasan() to
          kasan_dump_stack_lvl().
        - Added filtering of stack frames for print_track() with
          kasan_stack_depot_print().
        - Removed redundant print_stack_trace(), and instead using
          stack_trace_print() directly.
        - Removed sanitize_stack_entries() and replace_stack_entry()
          functions.
        - Increased the buffer size in get_stack_skipnr to 128.

Changes in v3:
	- Included an additional criteria for pattern based filtering
	  in get_stack_skipnr().
	- Included ip value based stack filtering with the functions
	  sanitize_stack_entries() and replace_stack_entry().
	- Corrected the comments and name of the newly added functions
	  kasan_dump_stack() and kasan_stack_depot_print().

 mm/kasan/report.c | 111 ++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 107 insertions(+), 4 deletions(-)

diff --git a/mm/kasan/report.c b/mm/kasan/report.c
index 3e48668c3e40..648a89fea3e7 100644
--- a/mm/kasan/report.c
+++ b/mm/kasan/report.c
@@ -261,6 +261,110 @@ static void print_error_description(struct kasan_report_info *info)
 			info->access_addr, current->comm, task_pid_nr(current));
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
+		/* Never show  kasan_* or __kasan_* functions. */
+		if ((strnstr(buf, "kasan_", len) == buf) ||
+			(strnstr(buf, "__kasan_", len) == buf))
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
+/*
+ * Skips to the first entry that matches the function of @ip, and then replaces
+ * that entry with @ip, returning the entries to skip with @replaced containing
+ * the replaced entry.
+ */
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
+static int
+sanitize_stack_entries(unsigned long stack_entries[], int num_entries, unsigned long ip,
+		       unsigned long *replaced)
+{
+	return ip ? replace_stack_entry(stack_entries, num_entries, ip, replaced) :
+			  get_stack_skipnr(stack_entries, num_entries);
+}
+
+/*
+ * Use in place of dump_stack() to filter out KASAN-related frames in
+ * the stack trace.
+ */
+static void kasan_dump_stack(unsigned long ip)
+{
+	unsigned long reordered_to = 0;
+	unsigned long stack_entries[KASAN_STACK_DEPTH] = { 0 };
+
+	int num_stack_entries = stack_trace_save(stack_entries, KASAN_STACK_DEPTH, 0);
+	int skipnr = sanitize_stack_entries(stack_entries, num_stack_entries,
+										ip, &reordered_to);
+
+	dump_stack_print_info(KERN_ERR);
+	stack_trace_print(stack_entries + skipnr, num_stack_entries - skipnr, 0);
+}
+
+/*
+ * Use in place of stack_depot_print() to filter out KASAN-related frames
+ * in the stack trace.
+ */
+static void kasan_stack_depot_print(depot_stack_handle_t stack)
+{
+	unsigned int nr_entries;
+	unsigned long *entries = NULL;
+	unsigned int skipnr;
+
+	nr_entries = stack_depot_fetch(stack, &entries);
+	if (nr_entries) {
+		skipnr = get_stack_skipnr(entries, nr_entries);
+		stack_trace_print(entries + skipnr, nr_entries - skipnr, 0);
+	} else
+		pr_err("(stack is not available)\n");
+}
+
 static void print_track(struct kasan_track *track, const char *prefix)
 {
 #ifdef CONFIG_KASAN_EXTRA_INFO
@@ -277,7 +381,7 @@ static void print_track(struct kasan_track *track, const char *prefix)
 	pr_err("%s by task %u:\n", prefix, track->pid);
 #endif /* CONFIG_KASAN_EXTRA_INFO */
 	if (track->stack)
-		stack_depot_print(track->stack);
+		kasan_stack_depot_print(track->stack);
 	else
 		pr_err("(stack is not available)\n");
 }
@@ -374,7 +478,6 @@ static void print_address_description(void *addr, u8 tag,
 {
 	struct page *page = addr_to_page(addr);
 
-	dump_stack_lvl(KERN_ERR);
 	pr_err("\n");
 
 	if (info->cache && info->object) {
@@ -484,11 +587,11 @@ static void print_report(struct kasan_report_info *info)
 		kasan_print_tags(tag, info->first_bad_addr);
 	pr_err("\n");
 
+	kasan_dump_stack(info->ip);
+
 	if (addr_has_metadata(addr)) {
 		print_address_description(addr, tag, info);
 		print_memory_metadata(info->first_bad_addr);
-	} else {
-		dump_stack_lvl(KERN_ERR);
 	}
 }
 
-- 
2.34.1


