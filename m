Return-Path: <linux-kernel+bounces-511472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BEE9BA32B7C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 17:22:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F14B01885944
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 16:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2151521018A;
	Wed, 12 Feb 2025 16:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d9GmcSLx"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D3CF2135B0
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 16:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739377335; cv=none; b=nVKqI3iOdED0g6X/NvsBZfFDlxhlvGcE6WMRg2ntpWLkGbvupZgyC5FoeJvoF47OG2M22JNTiw3IOOFcDVN+mKLFNZV/VV9uuF2Qrt6r+EN1bQdg6KzX0qHwSfJ4SJOvVXPkW/mdXWiWJVeC8w7VJY03MqLCbQaorJ4QIVRFdqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739377335; c=relaxed/simple;
	bh=Hzgs46TnIY+1XTuVlrUyLq39N5+Ofv85tKlkA0srnSs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TmS9FwmrS0TDSpJX56E2f1PiGL+OZEBdLOkn3vXajUCvTDrBFGwKSxZ20RDSFdg2cxNicbrozt7VHdcnPQP6mCmJo7zBqeWbL8pwnm0HpISnb+HISq3hsEqWngeuejU4l+UoZMDKcrM0LlqIBSi8oHyr/Z0R4drv2E+/HpCnw3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d9GmcSLx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739377332;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=3mkeENwhXrVCnkP0vqjiIG1p6lDK9GeK7SyVkLKRxtQ=;
	b=d9GmcSLxac8e1P4/OhXWac03OYDIkT7FhISz7reUGtJlqbUYtlG9l4nwVWbIHMJ/dhhVeP
	Fk4BLnF5UD6olAZAjeuYPAyj3dse7vn261xtk6L9eBg9KH7R9/sCY6X8rjEfBovSUQOSAa
	CSG0WzklStTvKO2evcZ6KsRZtWpjnpI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-464-gENj6CbJMx6w85Nz5YcQ9Q-1; Wed,
 12 Feb 2025 11:22:07 -0500
X-MC-Unique: gENj6CbJMx6w85Nz5YcQ9Q-1
X-Mimecast-MFC-AGG-ID: gENj6CbJMx6w85Nz5YcQ9Q
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 68C7D1801A3A;
	Wed, 12 Feb 2025 16:22:05 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.88.238])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C78DB1800359;
	Wed, 12 Feb 2025 16:22:01 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
Cc: kasan-dev@googlegroups.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	Nico Pache <npache@redhat.com>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH v2] kasan: Don't call find_vm_area() in RT kernel
Date: Wed, 12 Feb 2025 11:21:51 -0500
Message-ID: <20250212162151.1599059-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

The following bug report appeared with a test run in a RT debug kernel.

[ 3359.353842] BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:48
[ 3359.353848] in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 140605, name: kunit_try_catch
[ 3359.353853] preempt_count: 1, expected: 0
  :
[ 3359.353933] Call trace:
  :
[ 3359.353955]  rt_spin_lock+0x70/0x140
[ 3359.353959]  find_vmap_area+0x84/0x168
[ 3359.353963]  find_vm_area+0x1c/0x50
[ 3359.353966]  print_address_description.constprop.0+0x2a0/0x320
[ 3359.353972]  print_report+0x108/0x1f8
[ 3359.353976]  kasan_report+0x90/0xc8
[ 3359.353980]  __asan_load1+0x60/0x70

Commit e30a0361b851 ("kasan: make report_lock a raw spinlock")
changes report_lock to a raw_spinlock_t to avoid a similar RT problem.
The print_address_description() function is called with report_lock
acquired and interrupt disabled.  However, the find_vm_area() function
still needs to acquire a spinlock_t which becomes a sleeping lock in
the RT kernel. IOW, we can't call find_vm_area() in a RT kernel and
changing report_lock to a raw_spinlock_t is not enough to completely
solve this RT kernel problem.

Fix this bug report by skipping the find_vm_area() call in this case
and just print out the address as is.

For !RT kernel, follow the example set in commit 0cce06ba859a
("debugobjects,locking: Annotate debug_object_fill_pool() wait type
violation") and use DEFINE_WAIT_OVERRIDE_MAP() to avoid a spinlock_t
inside raw_spinlock_t warning.

Fixes: e30a0361b851 ("kasan: make report_lock a raw spinlock")
Signed-off-by: Waiman Long <longman@redhat.com>
---
 mm/kasan/report.c | 47 ++++++++++++++++++++++++++++++++++-------------
 1 file changed, 34 insertions(+), 13 deletions(-)

 [v2] Encapsulate the change into a new
      kasan_print_vmalloc_info_ret_page() helper

diff --git a/mm/kasan/report.c b/mm/kasan/report.c
index 3fe77a360f1c..9580ac3f3203 100644
--- a/mm/kasan/report.c
+++ b/mm/kasan/report.c
@@ -370,6 +370,38 @@ static inline bool init_task_stack_addr(const void *addr)
 			sizeof(init_thread_union.stack));
 }
 
+/*
+ * RT kernel cannot call find_vm_area() in atomic context. For !RT kernel,
+ * prevent spinlock_t inside raw_spinlock_t warning by raising wait-type
+ * to WAIT_SLEEP.
+ *
+ * Return: page pointer or NULL
+ */
+static inline struct page *kasan_print_vmalloc_info_ret_page(void *addr)
+{
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT)) {
+		static DEFINE_WAIT_OVERRIDE_MAP(vmalloc_map, LD_WAIT_SLEEP);
+		struct page *page = NULL;
+		struct vm_struct *va;
+
+		lock_map_acquire_try(&vmalloc_map);
+		va = find_vm_area(addr);
+		if (va) {
+			pr_err("The buggy address belongs to the virtual mapping at\n"
+			       " [%px, %px) created by:\n"
+			       " %pS\n",
+			       va->addr, va->addr + va->size, va->caller);
+			pr_err("\n");
+
+			page = vmalloc_to_page(addr);
+		}
+		lock_map_release(&vmalloc_map);
+		return page;
+	}
+	pr_err("The buggy address %px belongs to a vmalloc virtual mapping\n", addr);
+	return NULL;
+}
+
 static void print_address_description(void *addr, u8 tag,
 				      struct kasan_report_info *info)
 {
@@ -398,19 +430,8 @@ static void print_address_description(void *addr, u8 tag,
 		pr_err("\n");
 	}
 
-	if (is_vmalloc_addr(addr)) {
-		struct vm_struct *va = find_vm_area(addr);
-
-		if (va) {
-			pr_err("The buggy address belongs to the virtual mapping at\n"
-			       " [%px, %px) created by:\n"
-			       " %pS\n",
-			       va->addr, va->addr + va->size, va->caller);
-			pr_err("\n");
-
-			page = vmalloc_to_page(addr);
-		}
-	}
+	if (is_vmalloc_addr(addr))
+		page = kasan_print_vmalloc_info_ret_page(addr);
 
 	if (page) {
 		pr_err("The buggy address belongs to the physical page:\n");
-- 
2.48.1


