Return-Path: <linux-kernel+bounces-299512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FB8B95D5AE
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 21:01:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDD032837E8
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 19:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9BDB1925B2;
	Fri, 23 Aug 2024 19:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="g6RmWf26"
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 455196026A
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 19:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724439650; cv=none; b=sPc1EAHT9hLa97tNzu1pMUsgkUHPRYBR2DZgf3Qwg+JKi92xtTuhxlAXhSuSvHRKIzRkeHeoYyAf3KRzOzZ8VskHNaq6RBHFKELB/jSbbWEtBSOQTmQa2Qtl28frotVp6ZFp+dfS1+3qG3PZbDQJaB1ALytxl5wuNAD62t45O70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724439650; c=relaxed/simple;
	bh=xPO3WBIua1wHM2bB6ZQOkhcMQEPuEXhULjQIcQKnpTs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QWBgVu1S3+o4YVLoVoFqhJG2Vvh7bMqc5u5c1yHe44Mrr+xLTvGmmyCkKDRcCxTdWlMtjAV5ElYbb6fL+zqiaTgpyULUDauyZB29UUNzr7MPAbuxztXPW/59EviiK8HjO3PtKDUeTXE3df4xlxTC3DuBciENd0AZ0kZX3ieSaqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=g6RmWf26; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1724439622;
	bh=xPO3WBIua1wHM2bB6ZQOkhcMQEPuEXhULjQIcQKnpTs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g6RmWf26zT5n6hD8MBw/o1HUTdwKYJnPlZ7H9EcruD9UKMe9rZbSo/vSLpjNZgoiz
	 WLn0AYuZ6vNHXwzVTMZ6TUg2eODPbmb88ySwlHTC2jOPmiLR8uvEjzFXGk+ZeeyXon
	 +dCHgPwVPSQL5t0hjYezCZLfC2AYziuQlviWsr7SLaDfhQe7CPaeYUO17A1r7gs0pW
	 8UL2VMzQE69mxmWgsO/1drJFQpvqJHA1K3ucsiELt89oFT0a8S/yUIUo5agHWK7CEv
	 cqgTTA3ImyC2qit7YkTB4DEHD1NKc7tUfQjeNgKqkAP1MPIXBsMWEUKXZ0OOHWaZ9l
	 1sdV6Z890pJPA==
Received: from thinkos.internal.efficios.com (unknown [IPv6:2606:6d00:100:4000:b243:804e:3bbd:91c9])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4Wr8XQ0pcjz1Hkv;
	Fri, 23 Aug 2024 15:00:22 -0400 (EDT)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Mel Gorman <mgorman@suse.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>,
	Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Shuah Khan <skhan@linuxfoundation.org>
Subject: [RFC PATCH v1 3/6] cpumask: Implement cpumask_{first,next}_{nor,andnot}
Date: Fri, 23 Aug 2024 14:59:43 -0400
Message-Id: <20240823185946.418340-4-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240823185946.418340-1-mathieu.desnoyers@efficios.com>
References: <20240823185946.418340-1-mathieu.desnoyers@efficios.com>
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
---
 include/linux/cpumask.h | 60 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index 23686bed441d..5573e75c13ec 100644
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
+	return find_first_andnot_bit(cpumask_bits(srcp1), cpumask_bits(srcp2), nr_cpumask_bits);
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
+	return find_first_nor_bit(cpumask_bits(srcp1), cpumask_bits(srcp2), nr_cpumask_bits);
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
+	return find_next_andnot_bit(cpumask_bits(srcp1), cpumask_bits(srcp2), nr_cpumask_bits, n+1);
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
+	return find_next_nor_bit(cpumask_bits(srcp1), cpumask_bits(srcp2), nr_cpumask_bits, n+1);
+}
+
 #if NR_CPUS == 1
 /* Uniprocessor: there is only one valid CPU */
 static inline unsigned int cpumask_local_spread(unsigned int i, int node)
-- 
2.39.2


