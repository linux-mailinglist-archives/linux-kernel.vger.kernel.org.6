Return-Path: <linux-kernel+bounces-378550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A781F9AD228
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 19:08:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D11071C23BB5
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 17:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 581181CFED6;
	Wed, 23 Oct 2024 17:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H9VJE0Ix"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 283CB1CEEAD
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 17:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729703288; cv=none; b=qnz/lWWyiIRt7kxad2PlBwZvtTQ2FRfoEx9fvuedCW+u4SjuJrtq4TiTsYmoIApuqPk8sbsmW8jtmhRrtRz6S56/cp9VhDg1FKRNW9LRoJ0be0bYDBfKxx4zR1GCHuTKrTuIMDwb94AYA1Cr6xe8rUhvah4p9LlIxa5opbwzMs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729703288; c=relaxed/simple;
	bh=ZiQDRmQrDQydODmBhplTHGUqS5BFAUWK779ZQGEAgqA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rT3rlM/oC6OjJhodH2U2Y5PhZmCBvlXINLfNr463d1d4Ndo4JYiHdfaNaQDuvxnaREK8kVE/XF0/86zgySDxQV5eRE7QDWmoJ1Y8EMBgs7996TOUl2tPXVJTf15ZaQPwkQZ4JLLldYpIdxi1PIyf/2i/AaLLE5F2gzBuQXj9OLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=H9VJE0Ix; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e2bd3e0a26cso69785276.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 10:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729703286; x=1730308086; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qzUZQuDC5qa2V/vpTubJjhmN2aD40kQ8oHuQLi+u1Z4=;
        b=H9VJE0IxnL+nTpuDEfsO0joE5Y4h/z1jDdQWH90pxx78iQW0+5bC8VfzuKV24bUIYs
         JsgRVJHzYRaU4yx6NTIfs/fAgAnNj7fSlc/35MqQINhe8/EqMqbbaEH62DQmNMmE6gnL
         DaB95933+EXSIGWDW+BGhswMHRZvrC+TTIq6nrsH8ZbcjWCcNKR5lmKJM+IE4k3c6PW/
         aEv4xTCJOGgygaMJmnwWlmD0NYZVx9Vh19W3WDDgy/NpHuctojMwISl4M/GdPUjTxgSw
         vHXGz8+HaWxNq0oFjvVSSStkHGbOT3S2lwkPCsjCOQPWkTzZ8ZXH3TMK6atlhFefzaSZ
         9ZNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729703286; x=1730308086;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qzUZQuDC5qa2V/vpTubJjhmN2aD40kQ8oHuQLi+u1Z4=;
        b=mr+wERZvlYP32eSaEsu6iETWSwtPTIlRO4A0fLS8JMPJobkVBIC+JKYRtST4P1D62i
         vAdwCVEmOdNvhxMw9EIW5imGwSlD9G8SLCUMp7nazOSRw8y1/bOxQapsv48Y5CRZpWMN
         VQaVDpiawTRU8oVEwj3JcULxgLIM9zvMM0fKPkY86BR+0bsdAdiT7D19+wcIl2Gp0DDS
         hEHPK/Y6qoD69CF+BMyYtKOz9m06UEgTtmXYMNqmynRgC2PC+7uGWnraCSPESU7JZzVm
         SGYFJ1bFlEWyS4iXII59/Z7Ll1HLOKN7Ur8Z7refRoAnmrjdx2e6A7hDM3Tyf3yryB3I
         HCVw==
X-Forwarded-Encrypted: i=1; AJvYcCUBpi5ylhWgN1sFJjz6GxFkM8IDGA6eZo1YP6PCXxdm98+uigyf8m61j28VWr8tIHwgpsu0POJuN39xpV0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfjtHwYpuGjEsHfVTwxSBMB8poBHozYbd7YnpVxUE+3ZCnkEGY
	a47AyxlQiLujyM19uNQp8N/CH+PIZOEma8J8EUfy0UlnU0t2Rs8beqe8yVBTlwjciVbvZiaLB7A
	0og==
X-Google-Smtp-Source: AGHT+IEf9XVjhAQxbJksRoGGus3EwGVaSTpLfWlLEYi7zdwXtn6qn+dayeJKMPCmDwrDuVs0NH6hwtuuxI8=
X-Received: from surenb-desktop.mtv.corp.google.com ([2a00:79e0:2e3f:8:a087:59b9:198a:c44c])
 (user=surenb job=sendgmr) by 2002:a25:8289:0:b0:e2e:3401:ea0f with SMTP id
 3f1490d57ef6-e2e3a6bbdffmr7278276.7.1729703286023; Wed, 23 Oct 2024 10:08:06
 -0700 (PDT)
Date: Wed, 23 Oct 2024 10:07:55 -0700
In-Reply-To: <20241023170759.999909-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241023170759.999909-1-surenb@google.com>
X-Mailer: git-send-email 2.47.0.105.g07ac214952-goog
Message-ID: <20241023170759.999909-3-surenb@google.com>
Subject: [PATCH v4 2/6] alloc_tag: introduce shutdown_mem_profiling helper function
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: kent.overstreet@linux.dev, corbet@lwn.net, arnd@arndb.de, 
	mcgrof@kernel.org, rppt@kernel.org, paulmck@kernel.org, thuth@redhat.com, 
	tglx@linutronix.de, bp@alien8.de, xiongwei.song@windriver.com, 
	ardb@kernel.org, david@redhat.com, vbabka@suse.cz, mhocko@suse.com, 
	hannes@cmpxchg.org, roman.gushchin@linux.dev, dave@stgolabs.net, 
	willy@infradead.org, liam.howlett@oracle.com, pasha.tatashin@soleen.com, 
	souravpanda@google.com, keescook@chromium.org, dennis@kernel.org, 
	jhubbard@nvidia.com, urezki@gmail.com, hch@infradead.org, petr.pavlu@suse.com, 
	samitolvanen@google.com, da.gomez@samsung.com, yuzhao@google.com, 
	vvvvvv@google.com, rostedt@goodmis.org, iamjoonsoo.kim@lge.com, 
	rientjes@google.com, minchan@google.com, kaleshsingh@google.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-mm@kvack.org, 
	maple-tree@lists.infradead.org, linux-modules@vger.kernel.org, 
	kernel-team@android.com, surenb@google.com
Content-Type: text/plain; charset="UTF-8"

Implement a helper function to disable memory allocation profiling and
use it when creation of /proc/allocinfo fails.
Ensure /proc/allocinfo does not get created when memory allocation
profiling is disabled.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 lib/alloc_tag.c | 33 ++++++++++++++++++++++++++-------
 1 file changed, 26 insertions(+), 7 deletions(-)

diff --git a/lib/alloc_tag.c b/lib/alloc_tag.c
index 81e5f9a70f22..435aa837e550 100644
--- a/lib/alloc_tag.c
+++ b/lib/alloc_tag.c
@@ -8,6 +8,14 @@
 #include <linux/seq_buf.h>
 #include <linux/seq_file.h>
 
+#define ALLOCINFO_FILE_NAME		"allocinfo"
+
+#ifdef CONFIG_MEM_ALLOC_PROFILING_ENABLED_BY_DEFAULT
+static bool mem_profiling_support __meminitdata = true;
+#else
+static bool mem_profiling_support __meminitdata;
+#endif
+
 static struct codetag_type *alloc_tag_cttype;
 
 DEFINE_PER_CPU(struct alloc_tag_counters, _shared_alloc_tag);
@@ -144,9 +152,26 @@ size_t alloc_tag_top_users(struct codetag_bytes *tags, size_t count, bool can_sl
 	return nr;
 }
 
+static void __init shutdown_mem_profiling(void)
+{
+	if (mem_alloc_profiling_enabled())
+		static_branch_disable(&mem_alloc_profiling_key);
+
+	if (!mem_profiling_support)
+		return;
+
+	mem_profiling_support = false;
+}
+
 static void __init procfs_init(void)
 {
-	proc_create_seq("allocinfo", 0400, NULL, &allocinfo_seq_op);
+	if (!mem_profiling_support)
+		return;
+
+	if (!proc_create_seq(ALLOCINFO_FILE_NAME, 0400, NULL, &allocinfo_seq_op)) {
+		pr_err("Failed to create %s file\n", ALLOCINFO_FILE_NAME);
+		shutdown_mem_profiling();
+	}
 }
 
 static bool alloc_tag_module_unload(struct codetag_type *cttype,
@@ -174,12 +199,6 @@ static bool alloc_tag_module_unload(struct codetag_type *cttype,
 	return module_unused;
 }
 
-#ifdef CONFIG_MEM_ALLOC_PROFILING_ENABLED_BY_DEFAULT
-static bool mem_profiling_support __meminitdata = true;
-#else
-static bool mem_profiling_support __meminitdata;
-#endif
-
 static int __init setup_early_mem_profiling(char *str)
 {
 	bool enable;
-- 
2.47.0.105.g07ac214952-goog


