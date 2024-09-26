Return-Path: <linux-kernel+bounces-339775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C08EA986A60
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 03:12:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 289241F22656
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 01:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2C1E16FF25;
	Thu, 26 Sep 2024 01:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Cfz/QO9d"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE040139B
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 01:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727313130; cv=none; b=asBGI9pDNnIQyOAUgUpHyBphQEd+iURSllsMlbfbu4r9mH97boSJI7tT3dJjWaejPIDuPRMl3eQ+ylIPk3CNoWgS560W86ldzk2eGrslKHuptq3Ij/yNbonnTCAm3UmSs7Jc1RkDc4I5Hcy87FA9/34NgsU4Cj4DynzVW86VeJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727313130; c=relaxed/simple;
	bh=JouCtz1bAgNfJJimZrClUw2Oj0wCjbQPjYKrZeYdBfc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=AN7KLP6k7b17Ux9mcPycUfZniiXpXPHHZd+7U32QdWwbX3VvZxx7fBLCHLle3GFrzIA5yqor1h8DpI428T7TeOwmyOgHVByaZDAmJJ1riuAiwLLePmqsskusGa1BWQxOFK68eDzeg7UZPwu6ny1x6cMTP06uaFZk1BR1F1XNiJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--isaacmanjarres.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Cfz/QO9d; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--isaacmanjarres.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e22f0be237so9989967b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 18:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727313127; x=1727917927; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=w+L1GgvztnyP2D6nEfBPSziP/NrnIC1NcqFMQT4UV7s=;
        b=Cfz/QO9d6u99ruLkPyqq7/8JrbzGwHYpNz6liXZZaYmKpE9h/zz2gTnYyii4asJ3b7
         JzLZe21J3UlC8BDCUXodUzQMfqhLusWU+5KB8YNLrVkl7gaX++/7vzxgYwpe+7ZQMTsA
         sMGf+Y/UtuVA9EH/Kp8bwg/4uFSLDkroN82TI8AnJnLeNNVTvtDJUFGXb6xXLllCxiwq
         MVB7fGGZkHij5s9Oix77gD8lOvmBnZhSv7VtRUapCNJc+zyOV7rOQosohwYVrq++26io
         kVb4kZo76DlSLEVugXRbGHVRtQ7nCPaeuhQuCp+8L7gcbhjEdN3MN6iFk2awg2JuwVQj
         j3Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727313127; x=1727917927;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w+L1GgvztnyP2D6nEfBPSziP/NrnIC1NcqFMQT4UV7s=;
        b=vB4eR8/zjY0T0GnrfKdZ/XhNDWdS2ZuJq9S4r7q/5qkOHIZieBVhh6OU3g/48tVX9C
         3h3PufoVN6AP5szB9PsTNGunRXNJGw1lyMtIW6aHWxx0hTVpFjWdKl0k0BJoULOPYUl5
         Kt0wDYHldfT4UOdoBebgFUzEpBaJcsHm4Ah4Z638ySco7LKwMlj2PFCO8YxcT4w23fYg
         4CSfj1FUDzcSpoTIBKp55wvl9ac8tjFTHdHpynMRMhTkTMdFkj8IFpdDTRLq6Z1S9QZP
         d/m41kha0KDZlTU2mFL1a4YSdsZmWC7yNTFrsWN8TbitIN2mXGBKnXVFeswqszAT9X4e
         dVrg==
X-Forwarded-Encrypted: i=1; AJvYcCXJvs61aycGPNn+T29RCNP3Ua3bkMP/GfPPKv8zGVuFR1HHklrsgbumzO1ru0cOfe9fp6Ucqy2F40Bp3BA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy04iGGrQcfyYW8H/FG76Zq3m1ZkFMJZgNyIUKItmp1dElSih1G
	wI5Dcg0Oben8tj95RJvMcwxjW0vDsFOWfqOZzVz2YPG41VrTo9jlnUz52oUCLgmXLuci+z76p6D
	5kdqWoje/FZL6NmoJ4dN1fRBYDpIHCzcowA==
X-Google-Smtp-Source: AGHT+IG4V/WGnH5ptx2fC82gdmnNt7RontcMIAhfpe9sbCskmRCcX2FuYHtxRBkViBeH+t2zC0Cpmj6IbMZ17JP6muJtBg==
X-Received: from isaacmanjarres.irv.corp.google.com ([2620:15c:2d:3:fe3c:589e:ea33:ed67])
 (user=isaacmanjarres job=sendgmr) by 2002:a25:ad61:0:b0:e25:5cb1:77d8 with
 SMTP id 3f1490d57ef6-e255cb17917mr2730276.6.1727313127458; Wed, 25 Sep 2024
 18:12:07 -0700 (PDT)
Date: Wed, 25 Sep 2024 18:12:01 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
Message-ID: <20240926011203.1472798-1-isaacmanjarres@google.com>
Subject: [PATCH v1] printk: Improve memory usage logging during boot
From: "Isaac J. Manjarres" <isaacmanjarres@google.com>
To: Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, 
	John Ogness <john.ogness@linutronix.de>, Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: surenb@google.com, "Isaac J. Manjarres" <isaacmanjarres@google.com>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

When the initial printk ring buffer size is updated, setup_log_buf()
allocates a new ring buffer, as well as a set of meta-data structures
for the new ring buffer. The function also emits the new size of the
ring buffer, but not the size of the meta-data structures.

This makes it difficult to assess how changing the log buffer size
impacts memory usage during boot.

For instance, increasing the ring buffer size from 512 KB to 1 MB
through the command line yields an increase of 2304 KB in reserved
memory at boot, while the only obvious change is the 512 KB
difference in the ring buffer sizes:

log_buf_len=512K:

printk: log_buf_len: 524288 bytes
Memory: ... (... 733252K reserved ...)

log_buf_len=1M:

printk: log_buf_len: 1048576 bytes
Memory: ... (... 735556K reserved ...)

This is because of how the size of the meta-data structures scale with
the size of the ring buffer.

Even when there aren't changes to the printk ring buffer size (i.e. the
initial size ==  1 << CONFIG_LOG_BUF_SHIFT), it is impossible to tell
how much memory is consumed by the printk ring buffer during boot.

Therefore, unconditionally log the sizes of the printk ring buffer
and its meta-data structures, so that it's easier to understand
how changing the log buffer size (either through the command line or
by changing CONFIG_LOG_BUF_SHIFT) affects boot time memory usage.

With the new logs, it is much easier to see exactly why the memory
increased by 2304 KB:

log_buf_len=512K:

printk: log_buf_len: 524288 bytes
printk: prb_descs size: 393216 bytes
printk: printk_infos size: 1441792 bytes
Memory: ... (... 733252K reserved ...)

log_buf_len=1M:

printk: log_buf_len: 1048576 bytes
printk: prb_descs size: 786432 bytes
printk: printk_infos size: 2883584 bytes
Memory: ... (... 735556K reserved ...)

Signed-off-by: Isaac J. Manjarres <isaacmanjarres@google.com>
---
 kernel/printk/printk.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index beb808f4c367..0c169c28fa37 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -1156,6 +1156,17 @@ static unsigned int __init add_to_rb(struct printk_ringbuffer *rb,
 
 static char setup_text_buf[PRINTKRB_RECORD_MAX] __initdata;
 
+static void print_log_buf_usage_stats(void)
+{
+	unsigned int descs_count = log_buf_len >> PRB_AVGBITS;
+	size_t descs_size = descs_count * sizeof(struct prb_desc);
+	size_t infos_size = descs_count * sizeof(struct printk_info);
+
+	pr_info("log_buf_len: %u bytes\n", log_buf_len);
+	pr_info("prb_descs size: %zu bytes\n", descs_size);
+	pr_info("printk_infos size: %zu bytes\n", infos_size);
+}
+
 void __init setup_log_buf(int early)
 {
 	struct printk_info *new_infos;
@@ -1186,19 +1197,19 @@ void __init setup_log_buf(int early)
 		log_buf_add_cpu();
 
 	if (!new_log_buf_len)
-		return;
+		goto out;
 
 	new_descs_count = new_log_buf_len >> PRB_AVGBITS;
 	if (new_descs_count == 0) {
 		pr_err("new_log_buf_len: %lu too small\n", new_log_buf_len);
-		return;
+		goto out;
 	}
 
 	new_log_buf = memblock_alloc(new_log_buf_len, LOG_ALIGN);
 	if (unlikely(!new_log_buf)) {
 		pr_err("log_buf_len: %lu text bytes not available\n",
 		       new_log_buf_len);
-		return;
+		goto out;
 	}
 
 	new_descs_size = new_descs_count * sizeof(struct prb_desc);
@@ -1261,7 +1272,7 @@ void __init setup_log_buf(int early)
 		       prb_next_seq(&printk_rb_static) - seq);
 	}
 
-	pr_info("log_buf_len: %u bytes\n", log_buf_len);
+	print_log_buf_usage_stats();
 	pr_info("early log buf free: %u(%u%%)\n",
 		free, (free * 100) / __LOG_BUF_LEN);
 	return;
@@ -1270,6 +1281,8 @@ void __init setup_log_buf(int early)
 	memblock_free(new_descs, new_descs_size);
 err_free_log_buf:
 	memblock_free(new_log_buf, new_log_buf_len);
+out:
+	print_log_buf_usage_stats();
 }
 
 static bool __read_mostly ignore_loglevel;
-- 
2.46.1.824.gd892dcdcdd-goog


