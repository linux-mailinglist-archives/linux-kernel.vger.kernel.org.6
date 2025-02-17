Return-Path: <linux-kernel+bounces-518340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F12B1A38D9D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 21:44:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0408D3B44FD
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 20:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D27AE239070;
	Mon, 17 Feb 2025 20:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VqmmJZ4e"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A002238D35
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 20:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739825064; cv=none; b=toJDu4pvePpVKTlqNysR8AYBVXpFqsfk2lWN8K/33HZqVeFwaN6x3eLksSxmoR7smkfslHs435+ej4Zj85KcXQIq0kYTZsv1EQtolEX5FyktL+Ob4+WXe1a01+leepnNQBmlFoZg4o1S39cID9pfzDERoIdG2lIrRug0Dc4Z89I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739825064; c=relaxed/simple;
	bh=RFK2Noe38zdkgY0PuZD37xTp5S6DnnP5D4TgwgXWHn4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BqqDKENPAIjou2ydn6kB/n9EnEMwMa/t2SJSsFIzlJ1i1AhdrLxxQm+yy5p0fDCL6wf52q/StxSTNLARFB2uRwl/9MkjOy4FDc5MlqI4xpJ3681adFyHKCV0YTjPou2Lw1dOHBf5CDpZCjgUrx3gEhTn2q25ma1gn16P6WAPCRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VqmmJZ4e; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739825061;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2QmrLCQEQpkTfPHbNiLQH+djwRd+v9Lt5IkB8rbHV3Y=;
	b=VqmmJZ4eGiKSHx1klf8edb9QFVmS8/DkuHprTSQCt8Ce2DOfijW5arB+EhB89LO5EmLrmD
	l36LXeS4MuyQ3pwQFZQSz0rE5DeRDurcppTaZN3+p+z18od3af/wSRZz4pJpgFiMDKsrM8
	M/FK7AAWGNesS03Vxpeak6wva/Hl6S4=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-76-yUKzqEUaPyaxt_hlM-890A-1; Mon,
 17 Feb 2025 15:44:17 -0500
X-MC-Unique: yUKzqEUaPyaxt_hlM-890A-1
X-Mimecast-MFC-AGG-ID: yUKzqEUaPyaxt_hlM-890A_1739825055
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 05AF618EB2C3;
	Mon, 17 Feb 2025 20:44:15 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.80.243])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C115B1800362;
	Mon, 17 Feb 2025 20:44:11 +0000 (UTC)
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
Subject: [PATCH v4] kasan: Don't call find_vm_area() in a PREEMPT_RT kernel
Date: Mon, 17 Feb 2025 15:44:02 -0500
Message-ID: <20250217204402.60533-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

The following bug report was found when running a PREEMPT_RT debug kernel.

 BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:48
 in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 140605, name: kunit_try_catch
 preempt_count: 1, expected: 0

 Call trace:
  rt_spin_lock+0x70/0x140
  find_vmap_area+0x84/0x168
  find_vm_area+0x1c/0x50
  print_address_description.constprop.0+0x2a0/0x320
  print_report+0x108/0x1f8
  kasan_report+0x90/0xc8

Since commit e30a0361b851 ("kasan: make report_lock a raw spinlock"),
report_lock was changed to raw_spinlock_t to fix another similar
PREEMPT_RT problem. That alone isn't enough to cover other corner cases.

print_address_description() is always invoked under the
report_lock. The context under this lock is always atomic even on
PREEMPT_RT. find_vm_area() acquires vmap_node::busy.lock which is a
spinlock_t, becoming a sleeping lock on PREEMPT_RT and must not be
acquired in atomic context.

Don't invoke find_vm_area() on PREEMPT_RT and just print the address.
Non-PREEMPT_RT builds remain unchanged. Add a DEFINE_WAIT_OVERRIDE_MAP()
macro to tell lockdep that this lock nesting is allowed because the
PREEMPT_RT part (which is invalid) has been taken care of. This macro
was first introduced in commit 0cce06ba859a ("debugobjects,locking:
Annotate debug_object_fill_pool() wait type violation").

Fixes: e30a0361b851 ("kasan: make report_lock a raw spinlock")
Suggested-by: Andrey Konovalov <andreyknvl@gmail.com>
Signed-off-by: Waiman Long <longman@redhat.com>
---
 mm/kasan/report.c | 34 +++++++++++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

 [v4] Use Andrey's suggestion of a kasan_find_vm_area() helper and
 update comment and commit log as suggested by Andrey and Sebastian.

diff --git a/mm/kasan/report.c b/mm/kasan/report.c
index 3fe77a360f1c..8357e1a33699 100644
--- a/mm/kasan/report.c
+++ b/mm/kasan/report.c
@@ -370,6 +370,36 @@ static inline bool init_task_stack_addr(const void *addr)
 			sizeof(init_thread_union.stack));
 }
 
+/*
+ * This function is invoked with report_lock (a raw_spinlock) held. A
+ * PREEMPT_RT kernel cannot call find_vm_area() as it will acquire a sleeping
+ * rt_spinlock.
+ *
+ * For !RT kernel, the PROVE_RAW_LOCK_NESTING config option will print a
+ * lockdep warning for this raw_spinlock -> spinlock dependency. This config
+ * option is enabled by default to ensure better test coverage to expose this
+ * kind of RT kernel problem. This lockdep splat, however, can be suppressed
+ * by using DEFINE_WAIT_OVERRIDE_MAP() if it serves a useful purpose and the
+ * invalid PREEMPT_RT case has been taken care of.
+ */
+static inline struct vm_struct *kasan_find_vm_area(void *addr)
+{
+	static DEFINE_WAIT_OVERRIDE_MAP(vmalloc_map, LD_WAIT_SLEEP);
+	struct vm_struct *va;
+
+	if (IS_ENABLED(CONFIG_PREEMPT_RT))
+		return NULL;
+
+	/*
+	 * Suppress lockdep warning and fetch vmalloc area of the
+	 * offending address.
+	 */
+	lock_map_acquire_try(&vmalloc_map);
+	va = find_vm_area(addr);
+	lock_map_release(&vmalloc_map);
+	return va;
+}
+
 static void print_address_description(void *addr, u8 tag,
 				      struct kasan_report_info *info)
 {
@@ -399,7 +429,7 @@ static void print_address_description(void *addr, u8 tag,
 	}
 
 	if (is_vmalloc_addr(addr)) {
-		struct vm_struct *va = find_vm_area(addr);
+		struct vm_struct *va = kasan_find_vm_area(addr);
 
 		if (va) {
 			pr_err("The buggy address belongs to the virtual mapping at\n"
@@ -409,6 +439,8 @@ static void print_address_description(void *addr, u8 tag,
 			pr_err("\n");
 
 			page = vmalloc_to_page(addr);
+		} else {
+			pr_err("The buggy address %px belongs to a vmalloc virtual mapping\n", addr);
 		}
 	}
 
-- 
2.48.1


