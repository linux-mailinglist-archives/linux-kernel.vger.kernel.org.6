Return-Path: <linux-kernel+bounces-407786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 522B89C7457
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 15:32:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12EB7283E52
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 14:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6E1D2022F3;
	Wed, 13 Nov 2024 14:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="G5aqhW3D"
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598DC201279
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 14:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731508084; cv=none; b=oScFnWzQ+sypUkzhCs/12Ba7UP73rtG3/y76P+oQPdPD8lmzh5Dyh7hNXKMfBN5B67Tqmh6DLTlHZqCXhLeDSsMDMfiXrg10vseki20R/IdjdG4XlnIb7gKJvNxmXCYVJL4DvQQtEtf8MpAjjRrPlrDsrDjXxlFh26SY34b36lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731508084; c=relaxed/simple;
	bh=7Eni9NORmKjkt8SWZ+OGibbslnMQLpddsvCL8STPwwo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HWLk/nknH5dwhhwInpCOGA88sNgFqW2GoC4E/LLyJ4OCGO0YRUEcFAMzhMql9k7hOOADJHPmOZaFc2CZ1zT6nQv9NnwKOAdwSJCghtpZY7eoK4eE+z5ITspeT4DYlrT8s8lJ432Ym7MkLK2RF6aBfWctQzri0rnxM2opz3OAG90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=G5aqhW3D; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6d396a6f6aaso50318656d6.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 06:28:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1731508080; x=1732112880; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ani2W2ZQrBBpRmgkjhMcO9RTPfyjpQdKdikE2zOpotQ=;
        b=G5aqhW3DAnupYVQbz9ppwOuebVIkkxcipkPGbiGgL/tehFzdQJhadx8ptlJRx0XXLE
         5uy4GaQnOMSJ7iiBLkQcef7cS/xxQYM253agatDgTZd0KIKtuwutgCXRrBM9hp1X1dJO
         XwLyXSH8lWdiBP+DvKxJ17VXETrQLOHjbLosE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731508080; x=1732112880;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ani2W2ZQrBBpRmgkjhMcO9RTPfyjpQdKdikE2zOpotQ=;
        b=fic8xKezJrQTWoJTTn0d5E+znsdLapWNCclEERlhFzeqKv2reTtSmb1lidCZV6F+vD
         SobslzywoFC0qPCsziAMzOEd0vjEExKwRDsA8ItvkNt20C6Jhu8oOgLI2VHu6ij7/80U
         513gP5cN32FLAEvSXUgK/19/8Gf/9CSK9c/rLWCMjOlrHkChvx0w/ELfjgtyLZo9kJgT
         EmmtxNOda9fDi50nMdLCRkq0ZW4D1dyTshWTKVIsOUgxMV19mcMZKnLn3EkPUMPBk4PR
         cgTgel853Jmvf8OKL+s6UOw8O81UxNc+P3GCncTxRkjDkZp1sqlLDELfecp84LcbjsNx
         me+g==
X-Forwarded-Encrypted: i=1; AJvYcCVsQ83Yif0lxULF/qVqPkbIZYm1NIampyMoC5c/14jYkYNEGCohmO1vhAHbSYp8MzHeLNe44xAhvmUZDlo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeFTm8F8cYjgAXp8sI0xFT0w15J00S9xVluzFaVxPf0vD16H3a
	yq/jaycTLyhlndJ1XfFmGDYxd440mnzQ0wry7qQgd5mE+11mTFT86yxE4jE0ww==
X-Google-Smtp-Source: AGHT+IEI4ykwHsoz1dNLWyvPcKgN33L/wFe+HGOnWCnxtwEzVUOCsxchyzq0ByuGvekTc9rx43TbHQ==
X-Received: by 2002:a05:6214:5c07:b0:6d3:4849:1b8a with SMTP id 6a1803df08f44-6d39e14cdb2mr295420966d6.21.1731508080057;
        Wed, 13 Nov 2024 06:28:00 -0800 (PST)
Received: from vb004028-vm1.. ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d3961defe5sm85134976d6.10.2024.11.13.06.27.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 06:27:59 -0800 (PST)
From: Vamsi Krishna Brahmajosyula <vamsi-krishna.brahmajosyula@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: rostedt@goodmis.org,
	mhiramat@kernel.org,
	mqaio@linux.alibaba.com,
	namhyung.kim@lge.com,
	oleg@redhat.com,
	andrii@kernel.org,
	jolsa@kernel.org,
	sashal@kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	vasavi.sirnapalli@broadcom.com,
	Vamsi Krishna Brahmajosyula <vamsi-krishna.brahmajosyula@broadcom.com>
Subject: [PATCH v6.1 1/2] uprobes: encapsulate preparation of uprobe args buffer
Date: Wed, 13 Nov 2024 14:27:33 +0000
Message-Id: <20241113142734.2406886-2-vamsi-krishna.brahmajosyula@broadcom.com>
X-Mailer: git-send-email 2.39.4
In-Reply-To: <20241113142734.2406886-1-vamsi-krishna.brahmajosyula@broadcom.com>
References: <20241113142734.2406886-1-vamsi-krishna.brahmajosyula@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Andrii Nakryiko <andrii@kernel.org>

[ Upstream commit 3eaea21b4d27cff0017c20549aeb53034c58fc23 ]

Move the logic of fetching temporary per-CPU uprobe buffer and storing
uprobes args into it to a new helper function. Store data size as part
of this buffer, simplifying interfaces a bit, as now we only pass single
uprobe_cpu_buffer reference around, instead of pointer + dsize.

This logic was duplicated across uprobe_dispatcher and uretprobe_dispatcher,
and now will be centralized. All this is also in preparation to make
this uprobe_cpu_buffer handling logic optional in the next patch.

Link: https://lore.kernel.org/all/20240318181728.2795838-2-andrii@kernel.org/
[Masami: update for v6.9-rc3 kernel]

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Reviewed-by: Jiri Olsa <jolsa@kernel.org>
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Stable-dep-of: 373b9338c972 ("uprobe: avoid out-of-bounds memory access of fetching args")
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Vamsi Krishna Brahmajosyula <vamsi-krishna.brahmajosyula@broadcom.com>
---
 kernel/trace/trace_uprobe.c | 79 +++++++++++++++++++------------------
 1 file changed, 41 insertions(+), 38 deletions(-)

diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index 127c78aec17d..e09eef65d32f 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -858,6 +858,7 @@ static const struct file_operations uprobe_profile_ops = {
 struct uprobe_cpu_buffer {
 	struct mutex mutex;
 	void *buf;
+	int dsize;
 };
 static struct uprobe_cpu_buffer __percpu *uprobe_cpu_buffer;
 static int uprobe_buffer_refcnt;
@@ -947,9 +948,26 @@ static void uprobe_buffer_put(struct uprobe_cpu_buffer *ucb)
 	mutex_unlock(&ucb->mutex);
 }
 
+static struct uprobe_cpu_buffer *prepare_uprobe_buffer(struct trace_uprobe *tu,
+						       struct pt_regs *regs)
+{
+	struct uprobe_cpu_buffer *ucb;
+	int dsize, esize;
+
+	esize = SIZEOF_TRACE_ENTRY(is_ret_probe(tu));
+	dsize = __get_data_size(&tu->tp, regs);
+
+	ucb = uprobe_buffer_get();
+	ucb->dsize = tu->tp.size + dsize;
+
+	store_trace_args(ucb->buf, &tu->tp, regs, esize, dsize);
+
+	return ucb;
+}
+
 static void __uprobe_trace_func(struct trace_uprobe *tu,
 				unsigned long func, struct pt_regs *regs,
-				struct uprobe_cpu_buffer *ucb, int dsize,
+				struct uprobe_cpu_buffer *ucb,
 				struct trace_event_file *trace_file)
 {
 	struct uprobe_trace_entry_head *entry;
@@ -960,14 +978,14 @@ static void __uprobe_trace_func(struct trace_uprobe *tu,
 
 	WARN_ON(call != trace_file->event_call);
 
-	if (WARN_ON_ONCE(tu->tp.size + dsize > PAGE_SIZE))
+	if (WARN_ON_ONCE(ucb->dsize > PAGE_SIZE))
 		return;
 
 	if (trace_trigger_soft_disabled(trace_file))
 		return;
 
 	esize = SIZEOF_TRACE_ENTRY(is_ret_probe(tu));
-	size = esize + tu->tp.size + dsize;
+	size = esize + ucb->dsize;
 	entry = trace_event_buffer_reserve(&fbuffer, trace_file, size);
 	if (!entry)
 		return;
@@ -981,14 +999,14 @@ static void __uprobe_trace_func(struct trace_uprobe *tu,
 		data = DATAOF_TRACE_ENTRY(entry, false);
 	}
 
-	memcpy(data, ucb->buf, tu->tp.size + dsize);
+	memcpy(data, ucb->buf, ucb->dsize);
 
 	trace_event_buffer_commit(&fbuffer);
 }
 
 /* uprobe handler */
 static int uprobe_trace_func(struct trace_uprobe *tu, struct pt_regs *regs,
-			     struct uprobe_cpu_buffer *ucb, int dsize)
+			     struct uprobe_cpu_buffer *ucb)
 {
 	struct event_file_link *link;
 
@@ -997,7 +1015,7 @@ static int uprobe_trace_func(struct trace_uprobe *tu, struct pt_regs *regs,
 
 	rcu_read_lock();
 	trace_probe_for_each_link_rcu(link, &tu->tp)
-		__uprobe_trace_func(tu, 0, regs, ucb, dsize, link->file);
+		__uprobe_trace_func(tu, 0, regs, ucb, link->file);
 	rcu_read_unlock();
 
 	return 0;
@@ -1005,13 +1023,13 @@ static int uprobe_trace_func(struct trace_uprobe *tu, struct pt_regs *regs,
 
 static void uretprobe_trace_func(struct trace_uprobe *tu, unsigned long func,
 				 struct pt_regs *regs,
-				 struct uprobe_cpu_buffer *ucb, int dsize)
+				 struct uprobe_cpu_buffer *ucb)
 {
 	struct event_file_link *link;
 
 	rcu_read_lock();
 	trace_probe_for_each_link_rcu(link, &tu->tp)
-		__uprobe_trace_func(tu, func, regs, ucb, dsize, link->file);
+		__uprobe_trace_func(tu, func, regs, ucb, link->file);
 	rcu_read_unlock();
 }
 
@@ -1339,7 +1357,7 @@ static bool uprobe_perf_filter(struct uprobe_consumer *uc,
 
 static void __uprobe_perf_func(struct trace_uprobe *tu,
 			       unsigned long func, struct pt_regs *regs,
-			       struct uprobe_cpu_buffer *ucb, int dsize)
+			       struct uprobe_cpu_buffer *ucb)
 {
 	struct trace_event_call *call = trace_probe_event_call(&tu->tp);
 	struct uprobe_trace_entry_head *entry;
@@ -1360,7 +1378,7 @@ static void __uprobe_perf_func(struct trace_uprobe *tu,
 
 	esize = SIZEOF_TRACE_ENTRY(is_ret_probe(tu));
 
-	size = esize + tu->tp.size + dsize;
+	size = esize + ucb->dsize;
 	size = ALIGN(size + sizeof(u32), sizeof(u64)) - sizeof(u32);
 	if (WARN_ONCE(size > PERF_MAX_TRACE_SIZE, "profile buffer not large enough"))
 		return;
@@ -1383,13 +1401,10 @@ static void __uprobe_perf_func(struct trace_uprobe *tu,
 		data = DATAOF_TRACE_ENTRY(entry, false);
 	}
 
-	memcpy(data, ucb->buf, tu->tp.size + dsize);
-
-	if (size - esize > tu->tp.size + dsize) {
-		int len = tu->tp.size + dsize;
+	memcpy(data, ucb->buf, ucb->dsize);
 
-		memset(data + len, 0, size - esize - len);
-	}
+	if (size - esize > ucb->dsize)
+		memset(data + ucb->dsize, 0, size - esize - ucb->dsize);
 
 	perf_trace_buf_submit(entry, size, rctx, call->event.type, 1, regs,
 			      head, NULL);
@@ -1399,21 +1414,21 @@ static void __uprobe_perf_func(struct trace_uprobe *tu,
 
 /* uprobe profile handler */
 static int uprobe_perf_func(struct trace_uprobe *tu, struct pt_regs *regs,
-			    struct uprobe_cpu_buffer *ucb, int dsize)
+			    struct uprobe_cpu_buffer *ucb)
 {
 	if (!uprobe_perf_filter(&tu->consumer, 0, current->mm))
 		return UPROBE_HANDLER_REMOVE;
 
 	if (!is_ret_probe(tu))
-		__uprobe_perf_func(tu, 0, regs, ucb, dsize);
+		__uprobe_perf_func(tu, 0, regs, ucb);
 	return 0;
 }
 
 static void uretprobe_perf_func(struct trace_uprobe *tu, unsigned long func,
 				struct pt_regs *regs,
-				struct uprobe_cpu_buffer *ucb, int dsize)
+				struct uprobe_cpu_buffer *ucb)
 {
-	__uprobe_perf_func(tu, func, regs, ucb, dsize);
+	__uprobe_perf_func(tu, func, regs, ucb);
 }
 
 int bpf_get_uprobe_info(const struct perf_event *event, u32 *fd_type,
@@ -1479,10 +1494,8 @@ static int uprobe_dispatcher(struct uprobe_consumer *con, struct pt_regs *regs)
 	struct trace_uprobe *tu;
 	struct uprobe_dispatch_data udd;
 	struct uprobe_cpu_buffer *ucb;
-	int dsize, esize;
 	int ret = 0;
 
-
 	tu = container_of(con, struct trace_uprobe, consumer);
 	tu->nhit++;
 
@@ -1494,18 +1507,14 @@ static int uprobe_dispatcher(struct uprobe_consumer *con, struct pt_regs *regs)
 	if (WARN_ON_ONCE(!uprobe_cpu_buffer))
 		return 0;
 
-	dsize = __get_data_size(&tu->tp, regs);
-	esize = SIZEOF_TRACE_ENTRY(is_ret_probe(tu));
-
-	ucb = uprobe_buffer_get();
-	store_trace_args(ucb->buf, &tu->tp, regs, esize, dsize);
+	ucb = prepare_uprobe_buffer(tu, regs);
 
 	if (trace_probe_test_flag(&tu->tp, TP_FLAG_TRACE))
-		ret |= uprobe_trace_func(tu, regs, ucb, dsize);
+		ret |= uprobe_trace_func(tu, regs, ucb);
 
 #ifdef CONFIG_PERF_EVENTS
 	if (trace_probe_test_flag(&tu->tp, TP_FLAG_PROFILE))
-		ret |= uprobe_perf_func(tu, regs, ucb, dsize);
+		ret |= uprobe_perf_func(tu, regs, ucb);
 #endif
 	uprobe_buffer_put(ucb);
 	return ret;
@@ -1517,7 +1526,6 @@ static int uretprobe_dispatcher(struct uprobe_consumer *con,
 	struct trace_uprobe *tu;
 	struct uprobe_dispatch_data udd;
 	struct uprobe_cpu_buffer *ucb;
-	int dsize, esize;
 
 	tu = container_of(con, struct trace_uprobe, consumer);
 
@@ -1529,18 +1537,13 @@ static int uretprobe_dispatcher(struct uprobe_consumer *con,
 	if (WARN_ON_ONCE(!uprobe_cpu_buffer))
 		return 0;
 
-	dsize = __get_data_size(&tu->tp, regs);
-	esize = SIZEOF_TRACE_ENTRY(is_ret_probe(tu));
-
-	ucb = uprobe_buffer_get();
-	store_trace_args(ucb->buf, &tu->tp, regs, esize, dsize);
-
+	ucb = prepare_uprobe_buffer(tu, regs);
 	if (trace_probe_test_flag(&tu->tp, TP_FLAG_TRACE))
-		uretprobe_trace_func(tu, func, regs, ucb, dsize);
+		uretprobe_trace_func(tu, func, regs, ucb);
 
 #ifdef CONFIG_PERF_EVENTS
 	if (trace_probe_test_flag(&tu->tp, TP_FLAG_PROFILE))
-		uretprobe_perf_func(tu, func, regs, ucb, dsize);
+		uretprobe_perf_func(tu, func, regs, ucb);
 #endif
 	uprobe_buffer_put(ucb);
 	return 0;
-- 
2.39.4


