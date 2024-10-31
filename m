Return-Path: <linux-kernel+bounces-391405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E17DC9B8639
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 23:47:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23092B21B89
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 22:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 656981E1A12;
	Thu, 31 Oct 2024 22:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vtLUuDIc"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6DB519CC05
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 22:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730414820; cv=none; b=WkxtgWXSrVo0bD+vdgaVbd52RCMXi3lfA2Vdk/XU1kOUr0+rIwrRrFdRYjYBLWqZ+LmOa9B+0ZAZP4fX3s4VE49jrDWwjd0z6zzbz8c0eBetmC4/dx788/zcHOrFh3e90/IV570f+uJgz6WHL2/TEvJCwCXtY8UW8m4Ph4iuC3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730414820; c=relaxed/simple;
	bh=gpNhkl8JRQNQcbUpwHiXhYHWR7awIPV7sOfZto9Xxl4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WtCMwA7OSNYvHnqVusJHK+2ialWHtJpieweJUwpBkRK0qBzrOsjj1FZPu/lvNXwGxTaEWzB5vuIhPF23C8XBd6wE6AvX+ja0wr80iY0Xdme59DnlO300yKwrg8XDZFgys7imrDiMOwcIUrAsFZaMq698xYC0jJS3SVs5pz3fpq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kinseyho.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vtLUuDIc; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kinseyho.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6ea33140094so34149467b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 15:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730414814; x=1731019614; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=guCTOxzKlbAV7mFNRx7TvPMOy3sTYQa/R9Du6hcfImY=;
        b=vtLUuDIciTIdNaFrLiq8Ur8VsFUei7GaZIT9ePSik7jWTqdAJpzlbnvUGoAltaal8C
         eCHcQlYgR1YYg7zxglaANb4tWbG/bELvWs/D1wavBciRrzgK6NqRmtODPOXvMNGo0LPM
         qSFLgbds4GOp7VhJQCvFwmbkF+Q3Ot6711TUYesN9X3e8LwN7G5Mbxmy3RCCDJtyRgKW
         i4L2VEYAnoCCOrg216jaLaGWt/mOxIaqMA73JWuzi3oYpNtJnnn8NFe8bIrk+aCwmH7N
         Bn3Nynyikd1tR8buGM0mUywCMYBpwohaMHA1Fd2LHYnNiokC5il5upbdUerUI95Bkfub
         bN0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730414814; x=1731019614;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=guCTOxzKlbAV7mFNRx7TvPMOy3sTYQa/R9Du6hcfImY=;
        b=T14tcsaoXnBlmNVqrlwrw4WWEWllbgnKO7VSLxza83fF+f/rJ88//eBw9MjFOj6X0m
         dEnHNu5opc2zjwBPpX6mgaommJJDqqI2wboG1smcVr1kUJ5Mpwm7kz4Zw1QQZbSobAdY
         kCl0TsJA9v5gd1KH6+zbsVZh+0Pc1d6V0vbSyRz6lF6hmWj2k8MAqYrMlWeN88+R/JU7
         wwWjGqqGxXRrB+M8Y/w2hYVKXWC4Zluk+Q1LA8J/Odr5VPJRpEI6pJTw1OqM2asRso02
         Kp/HK0C0Gp13UfleMC2J0SSwVx+6fo8yu5OnMr+2tE0M0Us2NlWFmuObmzlzZRgwaHSp
         tfag==
X-Forwarded-Encrypted: i=1; AJvYcCVot1JdxGRMSrPIha9VtOOo5g1UsBbd1iGHrVziHhDlJxkhTOb2UNXfESAhd66ntG3gkcQvXNUpuJxDyq8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQcIIygxQW4yj6iQCXwKsrUGOUMdf5Qpb03+AKmflO7EAUyvWS
	u1jJNnt7eO9Su0D9fEsud6Nlg1KYj1Kv+E3vPbrAT/+6CPPRfwDZZjtCI+2c6pdYUNS6aKQ/pnn
	Ap8KRZ/q1uA==
X-Google-Smtp-Source: AGHT+IGA5sjZe8vpyl9lON3SR0LDoe9B+CE24eA4rKmGB1vEzw7Pi4vx0K181caj3vNLVFXCXdibXtjqBQbgGQ==
X-Received: from kinseyct.c.googlers.com ([fda3:e722:ac3:cc00:a1:836b:ac13:31a5])
 (user=kinseyho job=sendgmr) by 2002:a25:6b49:0:b0:e0e:8b26:484e with SMTP id
 3f1490d57ef6-e30e5b41dffmr2685276.8.1730414813939; Thu, 31 Oct 2024 15:46:53
 -0700 (PDT)
Date: Thu, 31 Oct 2024 22:45:50 +0000
In-Reply-To: <20241031224551.1736113-1-kinseyho@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241031224551.1736113-1-kinseyho@google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <20241031224551.1736113-2-kinseyho@google.com>
Subject: [PATCH mm-unstable v1 1/2] mm: add generic system-wide page counters
From: Kinsey Ho <kinseyho@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	David Rientjes <rientjes@google.com>, willy@infradead.org, Vlastimil Babka <vbabka@suse.cz>, 
	David Hildenbrand <david@redhat.com>, Kinsey Ho <kinseyho@google.com>, 
	Joel Granados <joel.granados@kernel.org>, Kaiyang Zhao <kaiyang2@cs.cmu.edu>, 
	Sourav Panda <souravpanda@google.com>, linux-kernel@vger.kernel.org, 
	cgroups@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

commit f4cb78af91e3 ("mm: add system wide stats items category") and
commit 9d8573111024 ("mm: don't account memmap per-node") renamed
NR_VM_WRITEBACK_STAT_ITEMS to NR_VM_STAT_ITEMS to track
memmap/memmap_boot pages system wide.

Extend the implementation so that the system wide page statistics can
be tracked using a generic interface. This patch is in preparation for
the next patch which adds a rarely modified system wide vmstat.

Note that this implementation uses global atomic fields with no per-cpu
optimizations as the existing usecase (memmap pages) is rarely modified
as well.

Signed-off-by: Kinsey Ho <kinseyho@google.com>
---
 include/linux/vmstat.h |  8 ++++++++
 mm/vmstat.c            | 32 +++++++++++++++++++++++---------
 2 files changed, 31 insertions(+), 9 deletions(-)

diff --git a/include/linux/vmstat.h b/include/linux/vmstat.h
index d2761bf8ff32..ac4d42c4fabd 100644
--- a/include/linux/vmstat.h
+++ b/include/linux/vmstat.h
@@ -145,6 +145,11 @@ extern atomic_long_t vm_zone_stat[NR_VM_ZONE_STAT_ITEMS];
 extern atomic_long_t vm_node_stat[NR_VM_NODE_STAT_ITEMS];
 extern atomic_long_t vm_numa_event[NR_VM_NUMA_EVENT_ITEMS];
 
+/*
+ * Global page accounting (no per cpu differentials).
+ */
+extern atomic_long_t vm_global_stat[NR_VM_STAT_ITEMS];
+
 #ifdef CONFIG_NUMA
 static inline void zone_numa_event_add(long x, struct zone *zone,
 				enum numa_stat_item item)
@@ -491,6 +496,9 @@ static inline void node_stat_sub_folio(struct folio *folio,
 	mod_node_page_state(folio_pgdat(folio), item, -folio_nr_pages(folio));
 }
 
+void mod_global_page_state(enum vm_stat_item item, long nr);
+unsigned long global_page_state(enum vm_stat_item item);
+
 extern const char * const vmstat_text[];
 
 static inline const char *zone_stat_name(enum zone_stat_item item)
diff --git a/mm/vmstat.c b/mm/vmstat.c
index 22a294556b58..e5a6dd5106c2 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -161,9 +161,11 @@ void vm_events_fold_cpu(int cpu)
  */
 atomic_long_t vm_zone_stat[NR_VM_ZONE_STAT_ITEMS] __cacheline_aligned_in_smp;
 atomic_long_t vm_node_stat[NR_VM_NODE_STAT_ITEMS] __cacheline_aligned_in_smp;
+atomic_long_t vm_global_stat[NR_VM_STAT_ITEMS] __cacheline_aligned_in_smp;
 atomic_long_t vm_numa_event[NR_VM_NUMA_EVENT_ITEMS] __cacheline_aligned_in_smp;
 EXPORT_SYMBOL(vm_zone_stat);
 EXPORT_SYMBOL(vm_node_stat);
+EXPORT_SYMBOL(vm_global_stat);
 
 #ifdef CONFIG_NUMA
 static void fold_vm_zone_numa_events(struct zone *zone)
@@ -1033,22 +1035,34 @@ unsigned long node_page_state(struct pglist_data *pgdat,
 }
 #endif
 
+void mod_global_page_state(enum vm_stat_item item, long nr)
+{
+	atomic_long_add(nr, &vm_global_stat[item]);
+}
+
+unsigned long global_page_state(enum vm_stat_item item)
+{
+	long x = atomic_long_read(&vm_global_stat[item]);
+#ifdef CONFIG_SMP
+	if (x < 0)
+		x = 0;
+#endif
+	return x;
+}
+
 /*
  * Count number of pages "struct page" and "struct page_ext" consume.
- * nr_memmap_boot_pages: # of pages allocated by boot allocator
- * nr_memmap_pages: # of pages that were allocated by buddy allocator
+ * NR_MEMMAP_BOOT_PAGES: # of pages allocated by boot allocator
+ * NR_MEMMAP_PAGES: # of pages that were allocated by buddy allocator
  */
-static atomic_long_t nr_memmap_boot_pages = ATOMIC_LONG_INIT(0);
-static atomic_long_t nr_memmap_pages = ATOMIC_LONG_INIT(0);
-
 void memmap_boot_pages_add(long delta)
 {
-	atomic_long_add(delta, &nr_memmap_boot_pages);
+	mod_global_page_state(NR_MEMMAP_BOOT_PAGES, delta);
 }
 
 void memmap_pages_add(long delta)
 {
-	atomic_long_add(delta, &nr_memmap_pages);
+	mod_global_page_state(NR_MEMMAP_PAGES, delta);
 }
 
 #ifdef CONFIG_COMPACTION
@@ -1880,8 +1894,8 @@ static void *vmstat_start(struct seq_file *m, loff_t *pos)
 
 	global_dirty_limits(v + NR_DIRTY_BG_THRESHOLD,
 			    v + NR_DIRTY_THRESHOLD);
-	v[NR_MEMMAP_PAGES] = atomic_long_read(&nr_memmap_pages);
-	v[NR_MEMMAP_BOOT_PAGES] = atomic_long_read(&nr_memmap_boot_pages);
+	for (int i = NR_MEMMAP_PAGES; i < NR_VM_STAT_ITEMS; i++)
+		v[i] = global_page_state(i);
 	v += NR_VM_STAT_ITEMS;
 
 #ifdef CONFIG_VM_EVENT_COUNTERS
-- 
2.47.0.163.g1226f6d8fa-goog


