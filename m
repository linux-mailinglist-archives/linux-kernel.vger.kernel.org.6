Return-Path: <linux-kernel+bounces-244097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D9603929F12
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 11:30:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91DE9286137
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 09:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB8DF7B3E1;
	Mon,  8 Jul 2024 09:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XlrAmO7w"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7ADC55E58
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 09:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720430970; cv=none; b=MMb1qOUdPXg78e//C6kMtm2EqhNh87sKYCNZIrGM3KVfcvdZi4YiOFYhbKNk+2F3GF+7nK3R2H1WbI+9tGC7CvAB94a+bsW2Wv7eA6/O26qxvI135HoBm+koT7fKiiAlS1TZFS3PBrTExfsBrI3nxNCFmfHf0iXmDR6yTuPC1Ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720430970; c=relaxed/simple;
	bh=dTtktbIQzPN0M1WT/SSamB3BTYm0QnUYyOtyVkFgo2s=;
	h=Message-Id:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=NxkLzt3UG8F426rS1kqgTOSMM9d+ZI3okNUp8E1DtpRgUpDxVcGHLfSeenE8SUKnJv6gnVHKRO88oQjefjpS9Cuk//UvJx27BKgUQ4NZj+cH2oKrtyuJo/j90wHb/bw2gLqaD0PuT1Ub6sr2vIDtRJDKsG55rdTTcQv+fSyyulM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=XlrAmO7w; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=epm86oBKZwoCXF9Cm3n9QKwfFnScPDeksYSx49nPLjc=; b=XlrAmO7wkpxZa38ZJDKZYvgdCT
	0I/265L5x/eqAMAJz3wL9jS+qGVvJ18V6Rjtv5mxbvA2MCcdKwphchej4geFBSgtLKal7kxxACgVk
	RZYepdzrjpf05+nP8jgTWMJhCQoYeVbPLRmXxP6tSmQaoZs7Rh2N7Fs9InZCdB3mqK+37r43Uw+Q6
	BGrV5sv0yde4GstfYlZNR3LyPDqdQYG4ddoF3+l3c5x6r5EdrfK20PCtYXK/WoGzlbzz+WH+h8oj1
	o2zxu8lcEPd1QVSWmaZ7ksF+8y5D3nEyJr5o/iJL37vO8owyKXJN1XypJv8l4VfHUZ018e+RN3cj0
	pdP5OtWA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sQkgN-00000000ZsQ-4AzS;
	Mon, 08 Jul 2024 09:29:18 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 254BF302DCD; Mon,  8 Jul 2024 11:29:13 +0200 (CEST)
Message-Id: <20240708092416.010695534@infradead.org>
User-Agent: quilt/0.65
Date: Mon, 08 Jul 2024 11:12:49 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: mingo@kernel.org,
 andrii@kernel.org
Cc: linux-kernel@vger.kernel.org,
 peterz@infradead.org,
 rostedt@goodmis.org,
 mhiramat@kernel.org,
 oleg@redhat.com,
 jolsa@kernel.org,
 clm@meta.com,
 paulmck@kernel.org
Subject: [PATCH 08/10] srcu: Add __srcu_clone_read_lock()
References: <20240708091241.544262971@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

In order to support carrying an srcu_read_lock() section across fork,
where both the parent and child process will do: srcu_read_unlock(),
it is needed to account for the extra decrement with an extra
increment at fork time.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/srcu.h     |    1 +
 include/linux/srcutiny.h |   10 ++++++++++
 kernel/rcu/srcutree.c    |    5 +++++
 3 files changed, 16 insertions(+)

--- a/include/linux/srcu.h
+++ b/include/linux/srcu.h
@@ -55,6 +55,7 @@ void call_srcu(struct srcu_struct *ssp,
 		void (*func)(struct rcu_head *head));
 void cleanup_srcu_struct(struct srcu_struct *ssp);
 int __srcu_read_lock(struct srcu_struct *ssp) __acquires(ssp);
+void __srcu_clone_read_lock(struct srcu_struct *ssp, int idx);
 void __srcu_read_unlock(struct srcu_struct *ssp, int idx) __releases(ssp);
 void synchronize_srcu(struct srcu_struct *ssp);
 unsigned long get_state_synchronize_srcu(struct srcu_struct *ssp);
--- a/include/linux/srcutiny.h
+++ b/include/linux/srcutiny.h
@@ -71,6 +71,16 @@ static inline int __srcu_read_lock(struc
 	return idx;
 }
 
+static inline void __srcu_clone_read_lock(struct srcu_struct *ssp, int idx)
+{
+	int newval;
+
+	preempt_disable();  // Needed for PREEMPT_AUTO
+	newval = READ_ONCE(ssp->srcu_lock_nesting[idx]) + 1;
+	WRITE_ONCE(ssp->srcu_lock_nesting[idx], newval);
+	preempt_enable();
+}
+
 static inline void synchronize_srcu_expedited(struct srcu_struct *ssp)
 {
 	synchronize_srcu(ssp);
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -720,6 +720,11 @@ int __srcu_read_lock(struct srcu_struct
 }
 EXPORT_SYMBOL_GPL(__srcu_read_lock);
 
+void __srcu_clone_read_lock(struct srcu_struct *ssp, int idx)
+{
+	this_cpu_inc(ssp->sda->srcu_lock_count[idx].counter);
+}
+
 /*
  * Removes the count for the old reader from the appropriate per-CPU
  * element of the srcu_struct.  Note that this may well be a different



