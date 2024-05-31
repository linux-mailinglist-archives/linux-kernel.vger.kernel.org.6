Return-Path: <linux-kernel+bounces-196562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F44E8D5E13
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 11:20:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5E631F27019
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 09:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDB3080BE5;
	Fri, 31 May 2024 09:20:23 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 325D7770FA
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 09:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717147223; cv=none; b=qfIuvkK+vr/0RSZSzEGuA+mXwff5GfrwyEwBcwot3fs6Q0U7Qp0XSpQu3/egTIhikgcI+hRsSbZ/2VBPC7L76eqwQ2ufaVhR05CNEzX703MVHaib8+6JPLk6hg9MEYNLWOKIJ8O2D0SyNVhHJ2VOd8AzP3AQSJ5NmSD64v6KSh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717147223; c=relaxed/simple;
	bh=ruBsYJ4huVIZMpMBAy76E8TlWiMHe0zbNIrFh1nqMKk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=DFGKkaUbDLu21VI9cXMTcYt00wId6mICLqV0cSy9VJotN6+hrV/O4Md+vu6G93Xs9927quzCKUZwhGeCRaam2uY+yW7iCzmlLnlAZtW2bThCegdCWTNy+gAS/+fJ+zzGigzzm3DQvXknRdOP+agVEp2wQCSmsvWqETsD29slf5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d85ff70000001748-48-6659964bd3bd
From: Byungchul Park <byungchul@sk.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: kernel_team@skhynix.com,
	akpm@linux-foundation.org,
	ying.huang@intel.com,
	vernhao@tencent.com,
	mgorman@techsingularity.net,
	hughd@google.com,
	willy@infradead.org,
	david@redhat.com,
	peterz@infradead.org,
	luto@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	rjgolo@gmail.com
Subject: [PATCH v11 02/12] arm64: tlbflush: add APIs manipulating tlb batch's arch data
Date: Fri, 31 May 2024 18:19:51 +0900
Message-Id: <20240531092001.30428-3-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240531092001.30428-1-byungchul@sk.com>
References: <20240531092001.30428-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGLMWRmVeSWpSXmKPExsXC9ZZnka7PtMg0g5YnLBZz1q9hs/i84R+b
	xYsN7YwWX9f/YrZ4+qmPxeLyrjlsFvfW/Ge1OL9rLavFjqX7mCwuHVjAZHG89wCTxfx7n9ks
	Nm+aymxxfMpURovfP4CKT86azOIg4PG9tY/FY+esu+weCzaVemxeoeWxeM9LJo9NqzrZPDZ9
	msTu8e7cOXaPEzN+s3jMOxno8X7fVTaPrb/sPBqnXmPz+LxJLoAvissmJTUnsyy1SN8ugStj
	9dybrAWLeSte75zD1sD4m6uLkZNDQsBE4u7kR6ww9pO/zcwgNpuAusSNGz/BbBEBM4mDrX/Y
	QWxmgbtMEgf62UBsYYFwifk3tjCB2CwCqhI//28Am8MrYCrxbv8/RoiZ8hKrNxwAm8MJNOfA
	3ztgcSGgmkX/e4FsLqCa12wS5zZ+h2qQlDi44gbLBEbeBYwMqxiFMvPKchMzc0z0MirzMiv0
	kvNzNzECQ39Z7Z/oHYyfLgQfYhTgYFTi4Q2oiEgTYk0sK67MPcQowcGsJML7Kx0oxJuSWFmV
	WpQfX1Sak1p8iFGag0VJnNfoW3mKkEB6YklqdmpqQWoRTJaJg1OqgdFJhGOp4aO1pknlmnFl
	77euuxDA+8N7r4/SVM3Huuxy94x/zNRN5v/umcqxNfx3wK/ykzuX//yrIlm/TEvfc4OQ68Op
	h6x/iHgFbH7kwt4QeH+y54lVq88teOb3b+8Zed3/JhqC106xLj6yTktohlxXJlu6xe17Eg/v
	T9kx6fKLJYd25imtuVKrxFKckWioxVxUnAgAqiUIBHkCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLLMWRmVeSWpSXmKPExsXC5WfdrOs9LTLNoO+NmcWc9WvYLD5v+Mdm
	8WJDO6PF1/W/mC2efupjsTg89ySrxeVdc9gs7q35z2pxftdaVosdS/cxWVw6sIDJ4njvASaL
	+fc+s1ls3jSV2eL4lKmMFr9/ABWfnDWZxUHQ43trH4vHzll32T0WbCr12LxCy2PxnpdMHptW
	dbJ5bPo0id3j3blz7B4nZvxm8Zh3MtDj/b6rbB6LX3xg8tj6y86jceo1No/Pm+QC+KO4bFJS
	czLLUov07RK4MlbPvclasJi34vXOOWwNjL+5uhg5OSQETCSe/G1mBrHZBNQlbtz4CWaLCJhJ
	HGz9ww5iMwvcZZI40M8GYgsLhEvMv7GFCcRmEVCV+Pl/AyuIzStgKvFu/z9GiJnyEqs3HACb
	wwk058DfO2BxIaCaRf97GScwci1gZFjFKJKZV5abmJljqlecnVGZl1mhl5yfu4kRGMjLav9M
	3MH45bL7IUYBDkYlHt6Aiog0IdbEsuLK3EOMEhzMSiK8v9KBQrwpiZVVqUX58UWlOanFhxil
	OViUxHm9wlMThATSE0tSs1NTC1KLYLJMHJxSDYzs8SUfWOdEqJStvKazdV30GRV17tOvNeK+
	q3v4nty0ot5g9oIHkfriHrLWXsW/wr/7M9hKOOq0SRgaBOzMOBuXVcP/Iu2MWtREhh1L+zc/
	8tzIasMtHlyr+qle61Dt/fXXZNxaZ81TmqFhlJddcnSf76wKgy+7exLlNbKClSa/mSD5iH1J
	nBJLcUaioRZzUXEiAFDjtkNgAgAA
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

A new mechanism, LUF(Lazy Unmap Flush), defers tlb flush until folios
that have been unmapped and freed, eventually get allocated again.  It's
safe for folios that had been mapped read only and were unmapped, since
the contents of the folios don't change while staying in pcp or buddy
so we can still read the data through the stale tlb entries.

This is a preparation for the mechanism that requires to manipulate tlb
batch's arch data.  Even though arm64 does nothing for tlb things, arch
with CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH should provide the APIs.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 arch/arm64/include/asm/tlbflush.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
index 95fbc8c05607..4fefc1f90304 100644
--- a/arch/arm64/include/asm/tlbflush.h
+++ b/arch/arm64/include/asm/tlbflush.h
@@ -354,6 +354,24 @@ static inline void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch)
 	dsb(ish);
 }
 
+static inline void arch_tlbbatch_clear(struct arch_tlbflush_unmap_batch *batch)
+{
+	/* nothing to do */
+}
+
+static inline void arch_tlbbatch_fold(struct arch_tlbflush_unmap_batch *bdst,
+			       struct arch_tlbflush_unmap_batch *bsrc)
+{
+	/* nothing to do */
+}
+
+static inline bool arch_tlbbatch_done(struct arch_tlbflush_unmap_batch *bdst,
+			       struct arch_tlbflush_unmap_batch *bsrc)
+{
+	/* Kernel can consider tlb batch always has been done. */
+	return true;
+}
+
 /*
  * This is meant to avoid soft lock-ups on large TLB flushing ranges and not
  * necessarily a performance improvement.
-- 
2.17.1


