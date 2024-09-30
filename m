Return-Path: <linux-kernel+bounces-344652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05F8098AC5D
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 20:48:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 207B01C217D7
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 18:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73B29198850;
	Mon, 30 Sep 2024 18:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gErjfmEf"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BBCE5466B
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 18:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727722116; cv=none; b=YvnnFlFWcPfyYmO+R0EDJ6gfjIwCeRuKwpZG6oNu/Fxh13URdGOWnrnX0TdTfeBek/6lFEStQkv0DHzZFLUuMJzjX4+QxbB+9L+UdIvK2cLc6S8P1Vksvpxlh2r/yeOX8GK9SIipFZ+95t/v0devAkAqogNMv8Nd5pkn4oPBveE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727722116; c=relaxed/simple;
	bh=V73HocS3qJGceDQ58b/ymNVP4DDs0aiGpFlrLQA+khg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=WWsW0R8mNArJg1VWCWHovW/LTx7Vi+OPJnnzHgM+Pr+J0bOTxQP0sR2qwcmm2lRXOHVp9edc9Z6kN17pzol/IAttt+snfVY95ENPBxeO7lzhwSXsG5jDgtb7T18w2Kf36jFQeGxu7nDyias1w5BvkqAuNv+OEdp9ZVnAcKkCejY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--isaacmanjarres.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gErjfmEf; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--isaacmanjarres.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e25cfee6581so7157574276.2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 11:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727722114; x=1728326914; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gJ178Z98ooxYmSzZZ3zgy29RsVYz57fPkJggwO7eM/Y=;
        b=gErjfmEfuTi4FKRRcZA7CyqzrVgSWIWCaoOGqaEiVUF/TXiBieKYJiFfN1Z+m8FReI
         imLqh7PF+Lkl62SL8KpUNC20JOVZZFsU5Jgatod6x/q8cCxmEbb27tJblFxeV98Ll3+v
         trWgWyqsP/AIyTuB8UXz7BW6hpdpeN6iy10UGzbFHJsuY/8BidkSKz3uJ4QIQgAE21cW
         VGHFPLZfRh+ctf5jH2Gbk8DISfPJu6SHhtsvtgWxzhTu/FILtZ6nJ7/SH6igyA56zJHM
         mawClmGM6piQHzHQ2x6FoVGVCoDZu4miWkg7rPphxyAmVI9vHXuaFSvrXbISBaAOBwWG
         dGxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727722114; x=1728326914;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gJ178Z98ooxYmSzZZ3zgy29RsVYz57fPkJggwO7eM/Y=;
        b=EkebYFSScH5TqA8T6DMFsgOGIBsqTJb0KXMVfzFsiD4YUSwe8l/VbvGR3Kpg4EqLWr
         77rztnaoRFPi5w6uaeajwjq39NZaq9p1zxKFLqLLkINGYy1QgxOa9tc0bk5pPDuotPJs
         Lr/a6s1K5NYt9DrVzERtY3OZGGTzLIEGRs8+xIoyAlx8qgh/iqgiTuNV+ZRnEjUub+XQ
         wsjWH3y6gzb5GWPBzRk25T0qaQbG9L3OtjqabFQu/UaUGKMbcFuXE9gCkXUYJvcvf0po
         A86gn4qqwW8llxNVRIT4k3ro93cO53o3OnqHuCWRZB8xUrFxS16Eevg+w8IQeHuLbotk
         NdlA==
X-Forwarded-Encrypted: i=1; AJvYcCWaN7FQT+4LxzFgs/s+23e1oLTynxBIbE1K1urwGeD/Y3N6sNxKzdvAClKgbR9GwGuXtNI3JNUhb6/z7KU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+r2LcwuCrbI879zWfrYB+z02K4dKF/+VwSlZFdA+NJhFaZBi9
	GNa0lgb6a43y+zcGyDdgtfYZNcOVvCxwpNgfeHL8JqgTz1f1iSKmFsbcXqnvDnpQFEdG+zPeLIe
	G8KNRpU2DHwMWSywt4AHaPbly/Ey/r+1IAQ==
X-Google-Smtp-Source: AGHT+IHKdJwe3gXbPZkFGl9SvyFbYs0HExcWa86V3vK7SnHa+jNnD780sdTOLoZrHq6baXrlpeXJRarERm5QsET+V/WZbA==
X-Received: from isaacmanjarres.irv.corp.google.com ([2620:15c:2d:3:179f:eecf:1162:3e05])
 (user=isaacmanjarres job=sendgmr) by 2002:a25:fc06:0:b0:e25:c8fc:b78c with
 SMTP id 3f1490d57ef6-e2604c7ea2amr8563276.9.1727722114003; Mon, 30 Sep 2024
 11:48:34 -0700 (PDT)
Date: Mon, 30 Sep 2024 11:48:24 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
Message-ID: <20240930184826.3595221-1-isaacmanjarres@google.com>
Subject: [PATCH v2] printk: Improve memory usage logging during boot
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
 kernel/printk/printk.c | 30 ++++++++++++++++++++++++++----
 1 file changed, 26 insertions(+), 4 deletions(-)

v1 -> v2:
- Consolidated the printk memory usage stats into a single line, and
  summed the printk_info and prb_desc structure sizes into a single
  stat to make the output more user-friendly.
- Fixed an error that caused the memory usage stats to be emitted twice
  when using the default printk buffer.

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index beb808f4c367..9ba7dd8f352f 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -1156,6 +1156,17 @@ static unsigned int __init add_to_rb(struct printk_ringbuffer *rb,
 
 static char setup_text_buf[PRINTKRB_RECORD_MAX] __initdata;
 
+static void print_log_buf_usage_stats(void)
+{
+	unsigned int descs_count = log_buf_len >> PRB_AVGBITS;
+	size_t meta_data_size;
+
+	meta_data_size = descs_count * (sizeof(struct prb_desc) + sizeof(struct printk_info));
+
+	pr_info("log buffer data + meta data: %u + %zu = %zu bytes\n",
+		log_buf_len, meta_data_size, log_buf_len + meta_data_size);
+}
+
 void __init setup_log_buf(int early)
 {
 	struct printk_info *new_infos;
@@ -1185,20 +1196,29 @@ void __init setup_log_buf(int early)
 	if (!early && !new_log_buf_len)
 		log_buf_add_cpu();
 
-	if (!new_log_buf_len)
+	if (!new_log_buf_len) {
+		/*
+		 * If early == 0 here, then we're using the default buffer,
+		 * but the memory usage stats haven't been printed yet,
+		 * so do that now.
+		 */
+		if (!early)
+			goto out;
+
 		return;
+	}
 
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
@@ -1261,7 +1281,7 @@ void __init setup_log_buf(int early)
 		       prb_next_seq(&printk_rb_static) - seq);
 	}
 
-	pr_info("log_buf_len: %u bytes\n", log_buf_len);
+	print_log_buf_usage_stats();
 	pr_info("early log buf free: %u(%u%%)\n",
 		free, (free * 100) / __LOG_BUF_LEN);
 	return;
@@ -1270,6 +1290,8 @@ void __init setup_log_buf(int early)
 	memblock_free(new_descs, new_descs_size);
 err_free_log_buf:
 	memblock_free(new_log_buf, new_log_buf_len);
+out:
+	print_log_buf_usage_stats();
 }
 
 static bool __read_mostly ignore_loglevel;
-- 
2.46.1.824.gd892dcdcdd-goog


