Return-Path: <linux-kernel+bounces-217860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12A1590B544
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 17:53:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79DCF281A1B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 15:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 052A377624;
	Mon, 17 Jun 2024 15:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="jyJLQ0yO"
Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.219])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 605A5768E1
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 15:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.50.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718638438; cv=none; b=T6u3GLFCvEWJjtWrPAEeNLHLMY46ysWLS8SWXJwn9AwkK6dp56bFZUaaSObFyS/Vw+abzZ2Wklog9bQSfaBolVStCkrVUTE69dexJ+Do1X2Snh1PTT3c4jl7NeUdjyggQfehjip8cwg7C3H513+dpUNNyi5lxickvmR+KYw0kEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718638438; c=relaxed/simple;
	bh=pHiu+hAd4XU2vX1VrkxJP6YEyAUBEy25VGv1TWYVPcU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bH62TJUwfEE4V3nxHB1tyAwq5h/SRshXDNTzNebdC7eJhF8StHfmA810yTiQkq/9fyCG3QA9XCyPExq2ohg1yDNbevUhnrPzcHO3MNc8+hgiB2MApO96RVZF8/9kL5r07KeAF7X4p5U3q7KLFZfnqAkbYDEaSEYMBY258bb0Ga0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=jyJLQ0yO; arc=none smtp.client-ip=45.254.50.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=7OviY
	DEQb7uRFcJ+eACIcQxXYLnr6KuLZxlnKBnBsaI=; b=jyJLQ0yOFz/4Yu2UG8Xba
	/tsXf/vMWZ0NDoxtu/bRZlAl3Xdp9V3em/sjV+GNLYkR3RdQFTtKI5dfgz46k1/Y
	qFEQhFUtqfEr4dEhzpinL2z/1zmWfQvH5fFvsYu9FAYcrugzjjMgcA2fvUDIhQUc
	VGbqHrbqqxMNrPw3763YuA=
Received: from localhost.localdomain (unknown [111.35.186.64])
	by gzga-smtp-mta-g0-2 (Coremail) with SMTP id _____wDnFys+V3BmcLM3BA--.12089S4;
	Mon, 17 Jun 2024 23:33:25 +0800 (CST)
From: David Wang <00107082@163.com>
To: surenb@google.com,
	kent.overstreet@linux.dev,
	akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	David Wang <00107082@163.com>
Subject: [PATCH] Add accumulated call counter for memory allocation profiling
Date: Mon, 17 Jun 2024 23:32:50 +0800
Message-Id: <20240617153250.9079-1-00107082@163.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnFys+V3BmcLM3BA--.12089S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxCry5WF13CF4UGF18Xw1DKFg_yoW5Xr4rpF
	4Y9F1UGan5JrykC3Wxtw1vqry3t3yjka43KrWjg395uF1YyrWDXayDKr1j9FyxCFy0gFnF
	vwnIg3y7C3WkA37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pE1vVZUUUUU=
X-CM-SenderInfo: qqqrilqqysqiywtou0bp/1tbiMwYBqmXAl5KK4wAAsX

Accumulated call counter can be used to evaluate rate
of memory allocation via delta(counters)/delta(time).
This metrics can help analysis performance behaviours,
e.g. tuning cache size, etc.

Signed-off-by: David Wang <00107082@163.com>
---
 include/linux/alloc_tag.h | 11 +++++++----
 lib/alloc_tag.c           |  7 +++----
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/include/linux/alloc_tag.h b/include/linux/alloc_tag.h
index abd24016a900..62734244c0b9 100644
--- a/include/linux/alloc_tag.h
+++ b/include/linux/alloc_tag.h
@@ -18,6 +18,7 @@
 struct alloc_tag_counters {
 	u64 bytes;
 	u64 calls;
+	u64 accu_calls;
 };
 
 /*
@@ -102,14 +103,15 @@ static inline bool mem_alloc_profiling_enabled(void)
 
 static inline struct alloc_tag_counters alloc_tag_read(struct alloc_tag *tag)
 {
-	struct alloc_tag_counters v = { 0, 0 };
+	struct alloc_tag_counters v = { 0, 0, 0 };
 	struct alloc_tag_counters *counter;
 	int cpu;
 
 	for_each_possible_cpu(cpu) {
-		counter = per_cpu_ptr(tag->counters, cpu);
-		v.bytes += counter->bytes;
-		v.calls += counter->calls;
+		counter		= per_cpu_ptr(tag->counters, cpu);
+		v.bytes		+= counter->bytes;
+		v.calls		+= counter->calls;
+		v.accu_calls	+= counter->accu_calls;
 	}
 
 	return v;
@@ -145,6 +147,7 @@ static inline void __alloc_tag_ref_set(union codetag_ref *ref, struct alloc_tag
 	 * counter because when we free each part the counter will be decremented.
 	 */
 	this_cpu_inc(tag->counters->calls);
+	this_cpu_inc(tag->counters->accu_calls);
 }
 
 static inline void alloc_tag_ref_set(union codetag_ref *ref, struct alloc_tag *tag)
diff --git a/lib/alloc_tag.c b/lib/alloc_tag.c
index 11ed973ac359..c4059362d828 100644
--- a/lib/alloc_tag.c
+++ b/lib/alloc_tag.c
@@ -66,8 +66,8 @@ static void allocinfo_stop(struct seq_file *m, void *arg)
 static void print_allocinfo_header(struct seq_buf *buf)
 {
 	/* Output format version, so we can change it. */
-	seq_buf_printf(buf, "allocinfo - version: 1.0\n");
-	seq_buf_printf(buf, "#     <size>  <calls> <tag info>\n");
+	seq_buf_printf(buf, "allocinfo - version: 1.1\n");
+	seq_buf_printf(buf, "#     <size>  <calls> <tag info> <accumulated calls>\n");
 }
 
 static void alloc_tag_to_text(struct seq_buf *out, struct codetag *ct)
@@ -78,8 +78,7 @@ static void alloc_tag_to_text(struct seq_buf *out, struct codetag *ct)
 
 	seq_buf_printf(out, "%12lli %8llu ", bytes, counter.calls);
 	codetag_to_text(out, ct);
-	seq_buf_putc(out, ' ');
-	seq_buf_putc(out, '\n');
+	seq_buf_printf(out, " %llu\n", counter.accu_calls);
 }
 
 static int allocinfo_show(struct seq_file *m, void *arg)
-- 
2.39.2


