Return-Path: <linux-kernel+bounces-375067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2FA99A9078
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 21:58:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E210281C4B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 19:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 333001E0DD5;
	Mon, 21 Oct 2024 19:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c7/XgDl1"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A8B1E0B70
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 19:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729540714; cv=none; b=NRce3SG1vdIlrA/zPC/a2UchrriZybbdbv6OUXxPF36RrNiEpnaQdZSlbMs91jFHcM4J8TqokvZENrAWuR2PXrAlZEnnOEdgbzG7zxumxKlO1bRFzx3l76ERXmElT5vGTt771FYh2HuSMef+mX+Y3WExOQVdLkacig/SYN3EkO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729540714; c=relaxed/simple;
	bh=GiobojYiVfVoZBFuSMMSjKv3icK3jZgNcGiHUKWvBFI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=u4Ldmlo3xugolqyxgyLsleni5EFcPowaMs83IaHTxdgdWdczLCdBCNvvk7ZybOfg0bzIsRoj1YvwVimcvnbbnpNPB0wKIR+KFAFjeofNJazGM8FwCmg87JDjdUrPa3aPm6IhRUl9lpg3QN2JJMTKnKQN27LXPgBYpfe1uAmb9/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c7/XgDl1; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-71e5417f8d4so312620b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 12:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729540712; x=1730145512; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=j/FgF0DU7rN81tqNTOqqY5AogDEl5GSNKz8OuW5qCJA=;
        b=c7/XgDl1cByt7jrp8HaveuW8IxiysfvfY/pfvCweXVivxNYSbUp5GVEA0++naQAEig
         uQcMmKAzhYHvNwddye12Ft63Y5N6qP/yCWfcT5lRBF9GlsYjOB1JFD0GUeT3E6iY8sqy
         qeeePypGPFXqh/vWjq6UTlJZGo/Ao0YkFXsTrtC1OX7/o3Z3gcIGsfe59G97N/BCSXW2
         0obJcAdPvrBRgxGqBeaGLkIn2jiwP2mP3La8rqPnYHi1iBb8EoRj9I3F6d8ljrfC/zFM
         ERdexqdEzPwe6bSNyYzz7vnmzirmaV7Ra90jOaa4umCk0SNdxOCPz/ehQFOBJlq/F2Nd
         3YAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729540712; x=1730145512;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j/FgF0DU7rN81tqNTOqqY5AogDEl5GSNKz8OuW5qCJA=;
        b=k9rdslf4/ETq3/8zUuM9PzpdgfATyKpdiZTADakaKDHDWuGUds9+z7A2rAfM53IBLD
         JdNIWfHD1a4B6njtLmMa1VH74kWx/TPN72+xIqoVDs2hLR0lds3df1njv3aP9jwENJTs
         CDv+RCio8uTIWG6oL6vPXdjOmET7qBZ4V0Fe4eaKhtYWQD6WSexjbuCVuJF9fmzDsEUZ
         w6z1F7e8ixnYYXOBC3Q2F7I5QzFLdCtQm6QhsL7Nsf3CaYiZGlfxvM+0jfQp1YVbswx5
         OSUglelVbw3bq5edM+lk9Kp6yISTMK9j0C2WW9+shP+T+nAMqLKpFjhUyF7Tc+KD/NCn
         RU4A==
X-Forwarded-Encrypted: i=1; AJvYcCU0NBFiNGEzZFwzmN1+SXGOsBi8HbWjjuHKoYvXhq2l7qQHsMTdcg2p8oij5L4tOi3yrd5fFOyUSkufEXc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxP19iTrwbLtL29qWiYRVwviIY1bpNmAZIgRIgsoAc36CD/sNYE
	UT1NEAu0cvtt37htBWrA5A+EA5HGPjWQlDrPDiOTd9WyLUISAU4uhNwcWFIu0MY=
X-Google-Smtp-Source: AGHT+IFbbo2FCzmyaEvh+4vefK128rGbliC2Oq+pvv23OD/JdHWj7XNKeV3KiAD15pNYTR8kdOsTDg==
X-Received: by 2002:a05:6a00:2e24:b0:71e:66bb:d33b with SMTP id d2e1a72fcca58-71ea3129093mr7659113b3a.1.1729540712152;
        Mon, 21 Oct 2024 12:58:32 -0700 (PDT)
Received: from ice.. ([171.76.87.28])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec1312cd8sm3292796b3a.31.2024.10.21.12.58.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 12:58:31 -0700 (PDT)
From: Nihar Chaithanya <niharchaithanya@gmail.com>
To: ryabinin.a.a@gmail.com
Cc: glider@google.com,
	andreyknvl@gmail.com,
	dvyukov@google.com,
	elver@google.com,
	skhan@linuxfoundation.org,
	kasan-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	Nihar Chaithanya <niharchaithanya@gmail.com>
Subject: [PATCH v2] kasan:report: filter out kasan related stack entries
Date: Tue, 22 Oct 2024 01:27:15 +0530
Message-Id: <20241021195714.50473-1-niharchaithanya@gmail.com>
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
	- The get_stack_skipnr() function is included to get the number of
	  stack entries to be skipped for filtering the stack-trace.

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

Note:
When using sanitize_stack_entries() the output was innacurate for free and
alloc tracks, because of the missing ip value in print_track().
The buffer size in get_stack_skipnr() is increase as it was too small when
testing with some KASAN uaf bugs which included free and alloc tracks.

 mm/kasan/report.c | 62 ++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 56 insertions(+), 6 deletions(-)

diff --git a/mm/kasan/report.c b/mm/kasan/report.c
index b48c768acc84..e00cf764693c 100644
--- a/mm/kasan/report.c
+++ b/mm/kasan/report.c
@@ -261,6 +261,59 @@ static void print_error_description(struct kasan_report_info *info)
 			info->access_addr, current->comm, task_pid_nr(current));
 }
 
+/* Helper to skip KASAN-related functions in stack-trace. */
+static int get_stack_skipnr(const unsigned long stack_entries[], int num_entries)
+{
+	char buf[128];
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
+/*
+ * Use in place of stack_dump_lvl to filter KASAN related functions in
+ * stack_trace.
+ */
+static void kasan_dump_stack_lvl(void)
+{
+	unsigned long stack_entries[KASAN_STACK_DEPTH] = { 0 };
+	int num_stack_entries = stack_trace_save(stack_entries, KASAN_STACK_DEPTH, 1);
+	int skipnr = get_stack_skipnr(stack_entries, num_stack_entries);
+
+	dump_stack_print_info(KERN_ERR);
+	stack_trace_print(stack_entries + skipnr, num_stack_entries - skipnr, 0);
+	pr_err("\n");
+}
+
+/*
+ * Use in place of stack_depot_print to filter KASAN related functions in
+ * stack_trace.
+ */
+static void kasan_stack_depot_print(depot_stack_handle_t stack)
+{
+	unsigned long *entries;
+	unsigned int nr_entries;
+
+	nr_entries = stack_depot_fetch(stack, &entries);
+	int skipnr = get_stack_skipnr(entries, nr_entries);
+
+	if (nr_entries > 0)
+		stack_trace_print(entries + skipnr, nr_entries - skipnr, 0);
+}
+
 static void print_track(struct kasan_track *track, const char *prefix)
 {
 #ifdef CONFIG_KASAN_EXTRA_INFO
@@ -277,7 +330,7 @@ static void print_track(struct kasan_track *track, const char *prefix)
 	pr_err("%s by task %u:\n", prefix, track->pid);
 #endif /* CONFIG_KASAN_EXTRA_INFO */
 	if (track->stack)
-		stack_depot_print(track->stack);
+		kasan_stack_depot_print(track->stack);
 	else
 		pr_err("(stack is not available)\n");
 }
@@ -374,9 +427,6 @@ static void print_address_description(void *addr, u8 tag,
 {
 	struct page *page = addr_to_page(addr);
 
-	dump_stack_lvl(KERN_ERR);
-	pr_err("\n");
-
 	if (info->cache && info->object) {
 		describe_object(addr, info);
 		pr_err("\n");
@@ -484,11 +534,11 @@ static void print_report(struct kasan_report_info *info)
 		kasan_print_tags(tag, info->first_bad_addr);
 	pr_err("\n");
 
+	kasan_dump_stack_lvl();
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


