Return-Path: <linux-kernel+bounces-557987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55088A5E016
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 16:20:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65C6F3A2ACD
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 15:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8F2525BAAC;
	Wed, 12 Mar 2025 15:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EMfrX/R9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cSY3YaaR"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 580F825742B
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 15:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741792611; cv=none; b=n9eD789HbeIP6ZnFa8bKCPisrUTvDrAyWsRytlRPylzSrx0aClqQ4DQ719Lu1snlPmY5O0tNuvbHftzIgjjaIZKliYjz8YHS4aLdfjRzhfpVH7QhjK3LZbUtn3Me3YniRqAy3KqSt5nOK4XvyUoTZCrbPCmfFyZsJZJKoraUJKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741792611; c=relaxed/simple;
	bh=JUPFEbJeMoHWfrH/ZVwEH0MomkuBtAKsRLp1ZXYurwo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hQEPOCHDtdw9b74LkkZ2nqcGEGdcTy5mETRRU97dXx99jUUl+ed2N+oeH4XdgQmDBgRI+qPJhtMKHt90v/MVz70dWQSktU441KDNY7wSghuazwcjzhI2CkhUOYlD5ATrrANFxPvxPodjSGSoFOlG7mntXEbPFF/0AW0Z+QM+DHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EMfrX/R9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cSY3YaaR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741792606;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=si5dEG1uweLN2PpJ+c7HS1w13Fpbcv6DZJnMkGCu60E=;
	b=EMfrX/R9YbQeVeibLTnVIcDgRjZJIad2AZx5Xd7ySh2JnD3eCWASpiKflcDN7GmWq4qMoh
	IpPF1VWHe7XH05QFyFWTxFJ02liXcEf36esB5TOf7xtAW7musWSJeZi+EFFuIHk1JJ6yk5
	jbyv0PSnzD5CmzBbmlvW2Olk6EulUVI9ro0r83hcc1INRG5EqPBLYlqRgsIS7dxCK01b4a
	dz5tXNiItIMdFYGI+2NNhJEct5Ot2HRa7RORjo5Vo43kGXvc+lAeQ3P4v4fK6pS91mmsIt
	6GAl26aC3Hx+GzF+GaOfgSWiU81d1QPUBPyyCMc2A1eLiyxa/GxKT1Y2BDsyrw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741792606;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=si5dEG1uweLN2PpJ+c7HS1w13Fpbcv6DZJnMkGCu60E=;
	b=cSY3YaaRvRgNorkJBb3yqfXwVgcNB0RlpjUgNxpakCGJQPbFWUioGUS4qN8TNWCxahNu8W
	j7h31g8OqIhGIVDQ==
To: linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Waiman Long <longman@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Christoph Hellwig <hch@infradead.org>,
	linux-mm@kvack.org,
	Christoph Hellwig <hch@lst.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v10 19/21] mm: Add vmalloc_huge_node()
Date: Wed, 12 Mar 2025 16:16:32 +0100
Message-ID: <20250312151634.2183278-20-bigeasy@linutronix.de>
In-Reply-To: <20250312151634.2183278-1-bigeasy@linutronix.de>
References: <20250312151634.2183278-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Peter Zijlstra <peterz@infradead.org>

To enable node specific hash-tables.

[bigeasy: use __vmalloc_node_range_noprof(), add nommu bits]

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Uladzislau Rezki <urezki@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: linux-mm@kvack.org
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/vmalloc.h | 3 +++
 mm/nommu.c              | 5 +++++
 mm/vmalloc.c            | 7 +++++++
 3 files changed, 15 insertions(+)

diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
index 31e9ffd936e39..09c3e3e33f1f8 100644
--- a/include/linux/vmalloc.h
+++ b/include/linux/vmalloc.h
@@ -171,6 +171,9 @@ void *__vmalloc_node_noprof(unsigned long size, unsigne=
d long align, gfp_t gfp_m
 void *vmalloc_huge_noprof(unsigned long size, gfp_t gfp_mask) __alloc_size=
(1);
 #define vmalloc_huge(...)	alloc_hooks(vmalloc_huge_noprof(__VA_ARGS__))
=20
+void *vmalloc_huge_node_noprof(unsigned long size, gfp_t gfp_mask, int nod=
e) __alloc_size(1);
+#define vmalloc_huge_node(...)	alloc_hooks(vmalloc_huge_node_noprof(__VA_A=
RGS__))
+
 extern void *__vmalloc_array_noprof(size_t n, size_t size, gfp_t flags) __=
alloc_size(1, 2);
 #define __vmalloc_array(...)	alloc_hooks(__vmalloc_array_noprof(__VA_ARGS_=
_))
=20
diff --git a/mm/nommu.c b/mm/nommu.c
index baa79abdaf037..d04e601a8f4d7 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -209,6 +209,11 @@ EXPORT_SYMBOL(vmalloc_noprof);
=20
 void *vmalloc_huge_noprof(unsigned long size, gfp_t gfp_mask) __weak __ali=
as(__vmalloc_noprof);
=20
+void *vmalloc_huge_node_noprof(unsigned long size, gfp_t gfp_mask, int nod=
e)
+{
+	return vmalloc_huge_noprof(size, gfp_mask);
+}
+
 /*
  *	vzalloc - allocate virtually contiguous memory with zero fill
  *
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index a6e7acebe9adf..69247b46413ca 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -3966,6 +3966,13 @@ void *vmalloc_huge_noprof(unsigned long size, gfp_t =
gfp_mask)
 }
 EXPORT_SYMBOL_GPL(vmalloc_huge_noprof);
=20
+void *vmalloc_huge_node_noprof(unsigned long size, gfp_t gfp_mask, int nod=
e)
+{
+	return __vmalloc_node_range_noprof(size, 1, VMALLOC_START, VMALLOC_END,
+					   gfp_mask, PAGE_KERNEL, VM_ALLOW_HUGE_VMAP,
+					   node, __builtin_return_address(0));
+}
+
 /**
  * vzalloc - allocate virtually contiguous memory with zero fill
  * @size:    allocation size
--=20
2.47.2


