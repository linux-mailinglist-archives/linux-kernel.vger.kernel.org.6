Return-Path: <linux-kernel+bounces-313564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BECC096A719
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 21:07:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1E071C23D0E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 19:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3A9D1D5CCF;
	Tue,  3 Sep 2024 19:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="xyzZMXxH"
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E62861D5CC3
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 19:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725390442; cv=none; b=tKfc5v04fE+ZbLA72EIJH5Wo8cRqsj6weV/R6bEjclKEyrIiqAGCpZvgn1VunEk923YTRVHekIOR6xCkf0dO5xc+ClushStI4sVLZZbVX1inPCVvgh7jHkUgduCzX4c3/aMs0g3m04nNLa/17AblbX5GsDf2yG5cnykIIxfSJoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725390442; c=relaxed/simple;
	bh=A0sI3oczydTd93povLvr7er/ShfUr2MfVdqfvmIv6Nk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NerVTJukp3uPcDlX8K5Ky4CabG0JxbL2aMhBRAocpvnG98bSuu1mLg45oErE8CA32Kst4xxT3rkai6snWW/t9Zf7tv/VASOv7HktQaNafc8DV8O4BqhBc26H7EQ5Itnzs5XE1wPFPZzAfrrp9zTbfQDrLOjW8HGnWSNbH49k+Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=xyzZMXxH; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1725390436;
	bh=A0sI3oczydTd93povLvr7er/ShfUr2MfVdqfvmIv6Nk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=xyzZMXxH9QE67vRW3zdIam6MhhwKC2bQawov3f3M8bqQ53jylvgc3TGLhiUGG6v4P
	 A3WI6NsDbr+znaOvWOc7ufK/8NoWKuU7T2gBDYRLL9ihUeRwmVAWU7v8rXZlHqzz/i
	 qpPT0/5Qlop2cP4curZeNtN72lm/XSbOUO6jyLM8Ndbm0R1Dgkg5dexrWbZjNJ0g64
	 zQQHU22ZlKQUjPVi7MCT5ucDZiV+jGEjsPuoytQl1bzxH81/XjnMS5zqmJ74N2dMnb
	 Y0+srLx5RuehhvMcYBPIiDm043SiHsRSEm9g4mXkdtz8QApIibRdTLMJlr8iTqatRT
	 573v6xoDbibKQ==
Received: from thinkos.internal.efficios.com (96-127-217-162.qc.cable.ebox.net [96.127.217.162])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4Wyw9J1bZpz1Jxy;
	Tue,  3 Sep 2024 15:07:16 -0400 (EDT)
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
	Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [RFC PATCH 1/2] cpumask: Implement cpumask_next_andnot
Date: Tue,  3 Sep 2024 15:06:49 -0400
Message-Id: <20240903190650.53644-2-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240903190650.53644-1-mathieu.desnoyers@efficios.com>
References: <20240903190650.53644-1-mathieu.desnoyers@efficios.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow finding the next bit within two input cpumasks which is
respectively one and zero.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Yury Norov <yury.norov@gmail.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 include/linux/cpumask.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index 23686bed441d..5da1c66cfa65 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -246,6 +246,23 @@ static inline unsigned int cpumask_next_zero(int n, const struct cpumask *srcp)
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
 #if NR_CPUS == 1
 /* Uniprocessor: there is only one valid CPU */
 static inline unsigned int cpumask_local_spread(unsigned int i, int node)
-- 
2.39.2


