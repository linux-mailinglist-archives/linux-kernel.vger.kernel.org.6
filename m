Return-Path: <linux-kernel+bounces-359893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AAA7099920E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 21:18:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDEB91C23B9D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 19:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A49591AFB36;
	Thu, 10 Oct 2024 19:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="bURjO6Ap"
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CCBE15B0F2
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 19:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728587912; cv=none; b=Giz8RDBpraTLiwee2Ljuzn/wysk0kEkqGxpKvHicKr0KMChALYgtEkeK95LJzUpQcd0iG4rvmEuwcF4ieZXnhz4D1w4nASGrZs/RoJdbFit4y/UdPhNH2jZ/+TA9fr26Ep0Ha4nUGqYvMKHny5ktX4s48gn9KUhu0KGk5eWrOeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728587912; c=relaxed/simple;
	bh=X4x9g9/zAmfDziEds/iQY26Vp6eovPMTSxk18EDjj/o=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=YFfR5bT2BDPtFUF3j9R3uaJn2gaaViI8x4tmdh9buolgx8hQ0g81qqYrqP2+Upri23bPqBS4A6KXmFrpEeFJ1+OXslOo/DL87+cB7h0uVlIDn15PfRiv8d1UfN3p3Nya7tOcqRJvC1M5KYbXaKMoA1fYCfy83euY7gl+FSghRm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=bURjO6Ap; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1728587901;
	bh=X4x9g9/zAmfDziEds/iQY26Vp6eovPMTSxk18EDjj/o=;
	h=Date:From:To:Cc:Subject:From;
	b=bURjO6Apm1cVShmVhmFZoM216LbfrcqBD9ZU2XFmfuHFunPl4Fmx8bPxvAb5LKsoy
	 mX4lG6l28FlAzRBiLXYoScZNxJ26b2F9Fl+D8P38v1bl12kHM31hGjnaocXRylOolN
	 DjHI0NVQcas+5QXLhq6X5KaSyXbjGuDr3+8S7k0FjvznW84WC3MHfituOX3aTza2N9
	 plAKQuERYwfS+12CMCftehrKtYDUNuNemvM9HDaWlIHyYer+U8UcvsJp6L26abgHlH
	 eXfFLUE1wpLoOwq4Lfj9o2+YdASG89a5r6msZQ6CfQ/7Tn9TERubJyBK54b28/fKvh
	 uszG7+VAayw0A==
Received: from [172.16.0.134] (96-127-217-162.qc.cable.ebox.net [96.127.217.162])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4XPfg11gbrzrqL;
	Thu, 10 Oct 2024 15:18:21 -0400 (EDT)
Message-ID: <8b944c2b-7f89-4d05-afd8-612de852f5dd@efficios.com>
Date: Thu, 10 Oct 2024 15:16:25 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, paulmck <paulmck@kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Maged Michael <maged.michael@gmail.com>
Subject: [RFC] Synchronized Shared Pointers for the Linux kernel
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

I've created a new API (sharedptr.h) for the use-case of
providing existence object guarantees (e.g. for Rust)
when dereferencing pointers which can be concurrently updated.
I call this "Synchronized Shared Pointers".

This should be an elegant solution to Greg's refcount
existence use-case as well.

The current implementation can be found here:

https://github.com/compudj/linux-dev/commit/64c3756b88776fe534629c70f6a1d27fad27e9ba

Patch added inline below for feedback.

Thanks!

Mathieu


diff --git a/include/linux/sharedptr.h b/include/linux/sharedptr.h
new file mode 100644
index 000000000000..ff925c509734
--- /dev/null
+++ b/include/linux/sharedptr.h
@@ -0,0 +1,163 @@
+// SPDX-FileCopyrightText: 2024 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
+//
+// SPDX-License-Identifier: LGPL-2.1-or-later
+
+#ifndef _LINUX_SHAREDPTR_H
+#define _LINUX_SHAREDPTR_H
+
+/*
+ * sharedptr: Synchronized Shared Pointers
+ *
+ * Synchronized shared pointers guarantee existence of objects when the
+ * synchronized pointer is dereferenced. It is meant to help solving the
+ * problem of object existence guarantees faced by Rust when interfacing
+ * with C.
+ *
+ * Those shared pointers are based on a reference counter embedded into
+ * the object, using hazard pointers to provide object existence
+ * guarantee based on pointer dereference for synchronized shared
+ * pointers.
+ *
+ * References:
+ *
+ * [1]: M. M. Michael, "Hazard pointers: safe memory reclamation for
+ *      lock-free objects," in IEEE Transactions on Parallel and
+ *      Distributed Systems, vol. 15, no. 6, pp. 491-504, June 2004
+ */
+
+#include <linux/hazptr.h>
+#include <linux/refcount.h>
+#include <linux/types.h>
+#include <linux/rcupdate.h>
+
+DECLARE_HAZPTR_DOMAIN(hazptr_domain_sharedptr);
+
+struct sharedptr_node {
+	refcount_t refcount;
+};
+
+/*
+ * Local copy of a shared pointer, holding a reference to a
+ * shared pointer node.
+ */
+struct sharedptr {
+	struct sharedptr_node *spn;
+};
+
+/*
+ * A syncsharedptr has a single updater, but many threads can
+ * concurrently copy a shared pointer from it using
+ * sharedptr_copy_from_sync(). Just like a sharedptr, a syncsharedptr
+ * holds a reference to a shared pointer node.
+ */
+struct syncsharedptr {
+	struct sharedptr_node *spn;
+};
+
+/*
+ * Initialize shared pointer node with refcount=1. Returns a shared pointer.
+ */
+static inline
+struct sharedptr sharedptr_create(struct sharedptr_node *spn)
+{
+	struct sharedptr sp = {
+		.spn = spn,
+	};
+	if (spn)
+		refcount_set(&spn->refcount, 1);
+	return sp;
+}
+
+static inline
+struct sharedptr sharedptr_copy(struct sharedptr sp)
+{
+	struct sharedptr_node *spn = sp.spn;
+
+	if (spn)
+		refcount_inc(&spn->refcount);
+	return sp;
+}
+
+static inline
+bool sharedptr_is_null(struct sharedptr sp)
+{
+	return sp.spn == NULL;
+}
+
+/* Move sharedptr to a syncsharedptr. */
+static inline
+void sharedptr_move_to_sync(struct syncsharedptr *dst, struct sharedptr *src)
+{
+	WARN_ON_ONCE(dst->spn);	/* Single updater, expect dst==NULL. */
+	rcu_assign_pointer(dst->spn, src->spn);
+	src->spn = NULL;	/* Transfer ownership. */
+}
+
+/*
+ * Copy sharedptr to a syncsharedptr, incrementing the reference.
+ */
+static inline
+void sharedptr_copy_to_sync(struct syncsharedptr *dst, const struct sharedptr *src)
+{
+	struct sharedptr_node *spn = src->spn;
+
+	WARN_ON_ONCE(dst->spn);	/* Single updater, expect dst==NULL. */
+	if (spn)
+		refcount_inc(&spn->refcount);
+	rcu_assign_pointer(dst->spn, spn);
+}
+
+/*
+ * Obtain a shared pointer copy from a syncsharedptr.
+ */
+static inline
+struct sharedptr sharedptr_copy_from_sync(const struct syncsharedptr *ssp)
+{
+	struct sharedptr_node *spn, *hp;
+	struct hazptr_slot *slot;
+	struct sharedptr sp;
+
+	preempt_disable();
+	hp = spn = hazptr_load_try_protect(&hazptr_domain_sharedptr, &ssp->spn, &slot);
+	if (!spn)
+		goto end;
+	if (!refcount_inc_not_zero(&spn->refcount))
+		spn = NULL;
+	hazptr_release(slot, hp);
+end:
+	sp.spn = spn;
+	preempt_enable();
+	return sp;
+}
+
+static inline
+void syncsharedptr_delete(struct syncsharedptr *ssp,
+			  void (*sharedptr_node_release)(struct sharedptr_node *spn))
+{
+	struct sharedptr_node *spn = ssp->spn;
+
+	if (!spn)
+		return;
+	WRITE_ONCE(ssp->spn, NULL);
+	if (refcount_dec_and_test(&spn->refcount)) {
+		hazptr_scan(&hazptr_domain_sharedptr, spn, NULL);
+		sharedptr_node_release(spn);
+	}
+}
+
+static inline
+void sharedptr_delete(struct sharedptr *sp,
+		      void (*sharedptr_node_release)(struct sharedptr_node *spn))
+{
+	struct sharedptr_node *spn = sp->spn;
+
+	if (!spn)
+		return;
+	WRITE_ONCE(sp->spn, NULL);
+	if (refcount_dec_and_test(&spn->refcount)) {
+		hazptr_scan(&hazptr_domain_sharedptr, spn, NULL);
+		sharedptr_node_release(spn);
+	}
+}
+
+#endif /* _LINUX_SHAREDPTR_H */
diff --git a/kernel/hazptr.c b/kernel/hazptr.c
index 3f9f14afbf1d..ba772f020325 100644
--- a/kernel/hazptr.c
+++ b/kernel/hazptr.c
@@ -8,6 +8,9 @@
  
  #include <linux/hazptr.h>
  #include <linux/percpu.h>
+#include <linux/sharedptr.h>
+
+DEFINE_HAZPTR_DOMAIN(hazptr_domain_sharedptr);
  
  /*
   * hazptr_scan: Scan hazard pointer domain for @addr.

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

