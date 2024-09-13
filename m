Return-Path: <linux-kernel+bounces-327632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 273E597788D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 07:59:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E2A41F25B74
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 05:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92B5918785F;
	Fri, 13 Sep 2024 05:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="nudFpYs6"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 698CD323D
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 05:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726207154; cv=none; b=sJNZ7qMERQinKavz+s7lFnTieu1DgmDO+iNWwcq1Xr3+lFbU2xp87PW9oTGHk9q82L4HcvIPccqKvYDPqXtiX3fNeV2f1/An8e6rudbNRx6LkAiNY/74a3sb05pGv+VDu6KrEWo88o/VgCKBuwZlZvT3zQl1eYMr6Cfe4x/OL2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726207154; c=relaxed/simple;
	bh=oOZ0SSDVlIa2uSBoWZC9ihxdrSn+uv43ddpmZzkpAAg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uw2XZVupJssjPqTfttBsBhcG1lC6aXu3PubJbOxdKl4L0nx12TCzJRJJ4eCdeHtBa5FU0ri/gHc/tWlsey+YrNaU976z5U57X05rk0lFEHQaDHo22LuJwvflMKqD+xi49Vg8jVqrkKlUJm3TZjNs+hXE4ReUHa9oZvMlsrg2aEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=nudFpYs6; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=Jot10
	t2ttv2oSJjbHdmFaubj0wa1UNajLUVcu1bzgLY=; b=nudFpYs60TolMSsP5ZFG3
	SjF5wYJd8YYRgXepKOPm6aUby+6nesPtfp/1S7WNCAI/DwoqcVkHX1l8sQOJuDZZ
	1zN42pWMd0o2AqHVfolhpykWD4BuBGPQN1THKQ3BcBua2OlKADZWtIUvZrD5Le+1
	tox7AArfTTRA58DcXq/5Cg=
Received: from localhost.localdomain (unknown [111.35.191.143])
	by gzga-smtp-mta-g2-1 (Coremail) with SMTP id _____wDXryVb1ONmNSjeFg--.19887S4;
	Fri, 13 Sep 2024 13:58:02 +0800 (CST)
From: David Wang <00107082@163.com>
To: surenb@google.com,
	kent.overstreet@linux.dev,
	akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	David Wang <00107082@163.com>
Subject: [PATCH v2] lib/alloc_tag: Add accumulative call counter for memory allocation profiling
Date: Fri, 13 Sep 2024 13:57:29 +0800
Message-Id: <20240913055729.7208-1-00107082@163.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDXryVb1ONmNSjeFg--.19887S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxWFW3AFyUZrW8JFy3ZFWUJwb_yoWrCFW3pa
	1Ygw17Ga1rXrn7Gry7K3409r93tw4vyryfKFW29w4F9F1ayFWDXr1DKryavFykCFW0qF1j
	vwnagrW7CFnrJwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pE1vVZUUUUU=
X-CM-SenderInfo: qqqrilqqysqiywtou0bp/1tbiqQxZqmVOC2jImAAAsO

Accumulative allocation counter can be used to evaluate
memory allocation behavior/rate via delta(counters)/delta(time).
It can help analysis performance issues, identify top modules
with high rate of memory allocation activity.
Considering this would incur extra performance and memory impact,
introduce kconfig MEM_ALLOC_PROFILING_ACCUMULATIVE_CALL_COUNTER.

Signed-off-by: David Wang <00107082@163.com>
---
Changes in v2:
- Add kconfig MEM_ALLOC_PROFILING_ACCUMULATIVE_CALL_COUNTER as
suggested by "Kent Overstreet <kent.overstreet@linux.dev>"

---
 include/linux/alloc_tag.h | 18 +++++++++++++++---
 lib/Kconfig.debug         | 10 ++++++++++
 lib/alloc_tag.c           | 10 +++++++++-
 3 files changed, 34 insertions(+), 4 deletions(-)

diff --git a/include/linux/alloc_tag.h b/include/linux/alloc_tag.h
index 8c61ccd161ba..5a94d61205b5 100644
--- a/include/linux/alloc_tag.h
+++ b/include/linux/alloc_tag.h
@@ -18,6 +18,9 @@
 struct alloc_tag_counters {
 	u64 bytes;
 	u64 calls;
+#ifdef CONFIG_MEM_ALLOC_PROFILING_ACCUMULATIVE_CALL_COUNTER
+	u64 accu_calls;
+#endif
 };
 
 /*
@@ -103,13 +106,19 @@ static inline bool mem_alloc_profiling_enabled(void)
 static inline struct alloc_tag_counters alloc_tag_read(struct alloc_tag *tag)
 {
 	struct alloc_tag_counters v = { 0, 0 };
+#ifdef CONFIG_MEM_ALLOC_PROFILING_ACCUMULATIVE_CALL_COUNTER
+	v.accu_calls = 0;
+#endif
 	struct alloc_tag_counters *counter;
 	int cpu;
 
 	for_each_possible_cpu(cpu) {
-		counter = per_cpu_ptr(tag->counters, cpu);
-		v.bytes += counter->bytes;
-		v.calls += counter->calls;
+		counter		= per_cpu_ptr(tag->counters, cpu);
+		v.bytes		+= counter->bytes;
+		v.calls		+= counter->calls;
+#ifdef CONFIG_MEM_ALLOC_PROFILING_ACCUMULATIVE_CALL_COUNTER
+		v.accu_calls	+= counter->accu_calls;
+#endif
 	}
 
 	return v;
@@ -145,6 +154,9 @@ static inline void __alloc_tag_ref_set(union codetag_ref *ref, struct alloc_tag
 	 * counter because when we free each part the counter will be decremented.
 	 */
 	this_cpu_inc(tag->counters->calls);
+#ifdef CONFIG_MEM_ALLOC_PROFILING_ACCUMULATIVE_CALL_COUNTER
+	this_cpu_inc(tag->counters->accu_calls);
+#endif
 }
 
 static inline void alloc_tag_ref_set(union codetag_ref *ref, struct alloc_tag *tag)
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index a30c03a66172..1e9974d28510 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1000,6 +1000,16 @@ config MEM_ALLOC_PROFILING_DEBUG
 	  Adds warnings with helpful error messages for memory allocation
 	  profiling.
 
+config MEM_ALLOC_PROFILING_ACCUMULATIVE_CALL_COUNTER
+	bool "Enable accumulative allocation counters"
+	default n
+	depends on MEM_ALLOC_PROFILING
+	help
+	  Record accumulative call counters for memory allocation. This may have
+	  extra performance and memory impact, but the impact is small.
+	  The stat can be used to evaluate allocation activity/rate
+	  via delta(counter)/delta(time).
+
 source "lib/Kconfig.kasan"
 source "lib/Kconfig.kfence"
 source "lib/Kconfig.kmsan"
diff --git a/lib/alloc_tag.c b/lib/alloc_tag.c
index 81e5f9a70f22..6b03edb04e7d 100644
--- a/lib/alloc_tag.c
+++ b/lib/alloc_tag.c
@@ -66,8 +66,12 @@ static void allocinfo_stop(struct seq_file *m, void *arg)
 static void print_allocinfo_header(struct seq_buf *buf)
 {
 	/* Output format version, so we can change it. */
-	seq_buf_printf(buf, "allocinfo - version: 1.0\n");
+	seq_buf_printf(buf, "allocinfo - version: 1.1\n");
+#ifdef CONFIG_MEM_ALLOC_PROFILING_ACCUMULATIVE_CALL_COUNTER
+	seq_buf_printf(buf, "#     <size>  <calls> <tag info> <accumulative calls>\n");
+#else
 	seq_buf_printf(buf, "#     <size>  <calls> <tag info>\n");
+#endif
 }
 
 static void alloc_tag_to_text(struct seq_buf *out, struct codetag *ct)
@@ -78,8 +82,12 @@ static void alloc_tag_to_text(struct seq_buf *out, struct codetag *ct)
 
 	seq_buf_printf(out, "%12lli %8llu ", bytes, counter.calls);
 	codetag_to_text(out, ct);
+#ifdef CONFIG_MEM_ALLOC_PROFILING_ACCUMULATIVE_CALL_COUNTER
+	seq_buf_printf(out, " %llu\n", counter.accu_calls);
+#else
 	seq_buf_putc(out, ' ');
 	seq_buf_putc(out, '\n');
+#endif
 }
 
 static int allocinfo_show(struct seq_file *m, void *arg)
-- 
2.39.2


