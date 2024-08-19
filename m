Return-Path: <linux-kernel+bounces-292273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DD91956D58
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 16:32:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90D7B1C2304A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 14:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A2411741D9;
	Mon, 19 Aug 2024 14:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="dESzAWsb"
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1273416C692
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 14:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724077932; cv=none; b=ki/C8HlruG6GY+Pff8+L+eUcnam4TZzec/2ZkVdXRtTLqvD2I69aI2BYMPxKv2O4a2tjJAzSy3GZu5d4qVudznlsKDmRpPLvoj0tNk+9tdTy+Wj6bW7r0HfU5QGUlgm0FHE5RqcIMwLb6W+AvrGZPDJQclY1wEM8A3ywISTqcUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724077932; c=relaxed/simple;
	bh=DEbGp9wYg5NOjou+uBlHQvfdNvk7CmHWxQAcAMsPyd8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=L0S7TpaHZcMMN1dQK0J/Fjom5Q0O2Go2XoF/vpHHfITXpMlXDDI50GfitIdjSrW9fzV0mJdv1GzaC63CLe9VPGAwJzu6hZ7pvObbjR20B7+M+ixPZoPN/h+Yi8H4LhoAsstVub7yD11GisdVbEVAixT/yCaAMRKlZ4E+ydoWB/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=dESzAWsb; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1724077475;
	bh=DEbGp9wYg5NOjou+uBlHQvfdNvk7CmHWxQAcAMsPyd8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dESzAWsbJlCtqstz6N9scjxx4ImaShlLSD3KjnzWzOeGAM3Jvepqoe8oaZsC+Yq59
	 h/AgFB2vDxsYMePiIRF8lxpMocDnV7nefMyVtyFalf17oWPgHz1NxKM/N8h7+LSKgO
	 LdvO1haIYWXoUnEJqljo9LNyO/N4lyqyJruq04tZM9N09ImMuHwZXacssnR27zkZxS
	 eDghaJ1WWCduzQ7I9GCEUEkk8cQNLDUg0f0/2jbP7ntkwQkiwIyS2YQ5euDLnQHEiy
	 qs2P+YS6vlqfikFmzGiIWFG+oBLtuFxPxVhRfDjdI43hWH3f7TIlpOtDr5f5OgLAjS
	 qiAaRJ4ASqdvA==
Received: from thinkos.internal.efficios.com (109.56.13.38.mobile.3.dk [109.56.13.38])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4WnZc16Jvvz1Hjv;
	Mon, 19 Aug 2024 10:24:33 -0400 (EDT)
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
Subject: [RFC PATCH 2/5] cpumask: Implement cpumask_{first,next}_{not,}andnot
Date: Mon, 19 Aug 2024 16:24:03 +0200
Message-Id: <20240819142406.339084-3-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240819142406.339084-1-mathieu.desnoyers@efficios.com>
References: <20240819142406.339084-1-mathieu.desnoyers@efficios.com>
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
 include/linux/cpumask.h | 60 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index 23686bed441d..57b7d99d6da1 100644
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
+static inline
+unsigned int cpumask_first_andnot(const struct cpumask *srcp1, const struct cpumask *srcp2)
+{
+	return find_first_andnot_bit(cpumask_bits(srcp1), cpumask_bits(srcp2), nr_cpumask_bits);
+}
+
+/**
+ * cpumask_first_notandnot - return the first cpu from ~*srcp1 & ~*srcp2
+ * @src1p: the first input
+ * @src2p: the second input
+ *
+ * Returns >= nr_cpu_ids if no cpus match in both.
+ */
+static inline
+unsigned int cpumask_first_notandnot(const struct cpumask *srcp1, const struct cpumask *srcp2)
+{
+	return find_first_notandnot_bit(cpumask_bits(srcp1), cpumask_bits(srcp2), nr_cpumask_bits);
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
+static inline
+unsigned int cpumask_next_andnot(int n, const struct cpumask *srcp1, const struct cpumask *srcp2)
+{
+	/* -1 is a legal arg here. */
+	if (n != -1)
+		cpumask_check(n);
+	return find_next_andnot_bit(cpumask_bits(srcp1), cpumask_bits(srcp2), nr_cpumask_bits, n+1);
+}
+
+/**
+ * cpumask_next_notandnot - return the next cpu from ~*srcp1 & ~*srcp2
+ * @n: the cpu prior to the place to search (ie. return will be > @n)
+ * @src1p: the first input
+ * @src2p: the second input
+ *
+ * Returns >= nr_cpu_ids if no cpus match in both.
+ */
+static inline
+unsigned int cpumask_next_notandnot(int n, const struct cpumask *srcp1, const struct cpumask *srcp2)
+{
+	/* -1 is a legal arg here. */
+	if (n != -1)
+		cpumask_check(n);
+	return find_next_notandnot_bit(cpumask_bits(srcp1), cpumask_bits(srcp2), nr_cpumask_bits, n+1);
+}
+
 #if NR_CPUS == 1
 /* Uniprocessor: there is only one valid CPU */
 static inline unsigned int cpumask_local_spread(unsigned int i, int node)
-- 
2.39.2


