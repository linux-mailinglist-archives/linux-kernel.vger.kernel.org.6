Return-Path: <linux-kernel+bounces-309361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 273E2966956
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 21:12:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A70F1C20E74
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 19:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55EA41BE24F;
	Fri, 30 Aug 2024 19:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="uJVMzZcj"
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 071F11BD4E5
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 19:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725045076; cv=none; b=tBps1zUPhD1gAg+G2uDzDpLslxQtRg+mU/rCl8dtI7sX61CWLyHIf4KzOL0YO1+2s0uf9jzoXRJ94W7NYqtHEBduU26bq4VbTNUrXr4lbmMEMyQHmCpd4Lzjn6rsSAggDF6gIgNSKGui7N+BzqEyjwvn+DgYW0ahDZfl1E5QrD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725045076; c=relaxed/simple;
	bh=J+LpSR94ACn9qMFTKmrkKUKhlvib9nAQ8DfHXmh0T68=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RDNti8lU1sWfez6fNdWQJDrN/Suhh984XFaaxzXcuAXy36R5Wo0K336SIcbkHQSGsnU+R951UqqES2tFRn93zArHnNGseAd3FetAoTGLOX2QHBdAyYQaTtoSJtsel5hHbXlKalgUxZqSbzajtBhb23fMeDBNtnqxHLWrpRg7PBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=uJVMzZcj; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1725045071;
	bh=J+LpSR94ACn9qMFTKmrkKUKhlvib9nAQ8DfHXmh0T68=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uJVMzZcjMKmfISt6D/Gafqja4qtTfr8I+YQO8lwGQ++JnW7szfrncLXFeYCmVNskK
	 xHg664oMQLzJT3dOOhUA0jLbI3zh+8iDlhJbUy8bkyaWBVv6Qrq7Myc53i5rrpnoaA
	 0rdu8dodE/L4J3Jlb7BRtPDRUBJxozqMqO9GUyrFi+Uz3ieITGWAtZ4MnWBKYL0rPy
	 mKdCxuRZRxzr2zQwkclildVMLdYbbOJuitNVKz8oj3W/RwBgZHPOf4XetSaHMpZl4z
	 KBbELGFhfe+vN4oWdwEtjOSn2bE1ypZ+iEZ0u7o7ZI5Vw2gbX0a1d2h1tQHAQ1ZiCx
	 1wK7+A0BeWdYg==
Received: from thinkos.internal.efficios.com (96-127-217-162.qc.cable.ebox.net [96.127.217.162])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4WwSRg5w2Pz1JlK;
	Fri, 30 Aug 2024 15:11:11 -0400 (EDT)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH v3 6/6] cpumask: Implement cpumask_{first,next}_{nor,andnot}
Date: Fri, 30 Aug 2024 15:10:43 -0400
Message-Id: <20240830191043.1028827-7-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240830191043.1028827-1-mathieu.desnoyers@efficios.com>
References: <20240830191043.1028827-1-mathieu.desnoyers@efficios.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow finding the first or next bit within two input cpumasks which is
either:

- both zero and zero,
- respectively one and zero.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Yury Norov <yury.norov@gmail.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
Changes since v0:
- Rename "notandnot" to "nor".
- Use __always_inline.
Changes since v1:
- Use small_cpumask_bits instead of nr_cpumask_bits, which is better
  optimized for NR_CPUS < BITS_PER_LONG.
---
 include/linux/cpumask.h | 60 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index 23686bed441d..0bf6aabae62c 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -204,6 +204,32 @@ unsigned int cpumask_first_and_and(const struct cpumask *srcp1,
 				      cpumask_bits(srcp3), small_cpumask_bits);
 }
 
+/**
+ * cpumask_first_andnot - return the first cpu from *srcp1 & ~*srcp2
+ * @src1p: the first input
+ * @src2p: the second input
+ *
+ * Returns >= nr_cpu_ids if no cpus match in both.
+ */
+static __always_inline
+unsigned int cpumask_first_andnot(const struct cpumask *srcp1, const struct cpumask *srcp2)
+{
+	return find_first_andnot_bit(cpumask_bits(srcp1), cpumask_bits(srcp2), small_cpumask_bits);
+}
+
+/**
+ * cpumask_first_nor - return the first cpu from ~(*srcp1 | *srcp2)
+ * @src1p: the first input
+ * @src2p: the second input
+ *
+ * Returns >= nr_cpu_ids if no cpus match in both.
+ */
+static __always_inline
+unsigned int cpumask_first_nor(const struct cpumask *srcp1, const struct cpumask *srcp2)
+{
+	return find_first_nor_bit(cpumask_bits(srcp1), cpumask_bits(srcp2), small_cpumask_bits);
+}
+
 /**
  * cpumask_last - get the last CPU in a cpumask
  * @srcp:	- the cpumask pointer
@@ -246,6 +272,40 @@ static inline unsigned int cpumask_next_zero(int n, const struct cpumask *srcp)
 	return find_next_zero_bit(cpumask_bits(srcp), small_cpumask_bits, n+1);
 }
 
+/**
+ * cpumask_next_andnot - return the next cpu from *srcp1 & ~*srcp2
+ * @n: the cpu prior to the place to search (ie. return will be > @n)
+ * @src1p: the first input
+ * @src2p: the second input
+ *
+ * Returns >= nr_cpu_ids if no cpus match in both.
+ */
+static __always_inline
+unsigned int cpumask_next_andnot(int n, const struct cpumask *srcp1, const struct cpumask *srcp2)
+{
+	/* -1 is a legal arg here. */
+	if (n != -1)
+		cpumask_check(n);
+	return find_next_andnot_bit(cpumask_bits(srcp1), cpumask_bits(srcp2), small_cpumask_bits, n+1);
+}
+
+/**
+ * cpumask_next_nor - return the next cpu from ~(*srcp1 | *srcp2)
+ * @n: the cpu prior to the place to search (ie. return will be > @n)
+ * @src1p: the first input
+ * @src2p: the second input
+ *
+ * Returns >= nr_cpu_ids if no cpus match in both.
+ */
+static __always_inline
+unsigned int cpumask_next_nor(int n, const struct cpumask *srcp1, const struct cpumask *srcp2)
+{
+	/* -1 is a legal arg here. */
+	if (n != -1)
+		cpumask_check(n);
+	return find_next_nor_bit(cpumask_bits(srcp1), cpumask_bits(srcp2), small_cpumask_bits, n+1);
+}
+
 #if NR_CPUS == 1
 /* Uniprocessor: there is only one valid CPU */
 static inline unsigned int cpumask_local_spread(unsigned int i, int node)
-- 
2.39.2


