Return-Path: <linux-kernel+bounces-418584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 391549D633B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 18:36:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3256282D6D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 17:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1DF01DF99B;
	Fri, 22 Nov 2024 17:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QKeBLGEM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9TVtjVhh"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09FAC1DF759
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 17:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732296965; cv=none; b=l6Hvt7dsYYQk9MQ8ialnSjAVRMa1LgWyffm1LvT1BTFK69jB4XvCbC247G2oKJ1dPFS7eJUgKeBgJE6m7kr82yy0WdEnFd+k6PX9Q+dLVQs6KeQR2ImhScN0KA16Vc4cOPWkGLc3q7lpKpAYHI/a3xIanBAccdYukNKceP/caf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732296965; c=relaxed/simple;
	bh=ru+qPh0+fdD+3UW9gAXU/j1CZeYHpqdK62PLYgcPt5k=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=H+rwhq+QXx0bFD7Ea49HTBldFdugfr0LyZVUEp2xmZFVjRXMpnDYf3bAkGg3MGVTHxgvr9J8S39W53l39AV7oxUm87wH8LcptuCTCzfgutJpm22hZefZm3rYEYO8Nk1rc2C9JEkfjGnO3nePiVaVqixDlLTZI2wSTsEL13BPmlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QKeBLGEM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=9TVtjVhh; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 22 Nov 2024 18:35:57 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1732296958;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=g4uvewhN/5RRhM9hjcyM70QtZWjMssi/swMDzE0BVRw=;
	b=QKeBLGEMjP6TnnXW75toiUe3cbQouwkf6BgPyg3lB33SawM3/A0/Xkfax9FLfcAIDI/0tj
	B+wjJ8Wux/p0ZL/XrbUJZ8TmcVAojnaxsnxE5tCmpKMrhf8qUczSZKMci0if4JNM+9Tjb6
	6GnASzqzY6GWiXn57b3DkWC4HK+hggTZJwfvwQtKYlVTUFLBf/VQ/L9/rTFJiN2IrcLoxL
	5klOzT4R6xPSbvMtaAv53bZJEZsYz0AFyJCEnSn2I8nDd1aYqsvsn2r5jKCrTy+uczB0tB
	+X04vqJDTMvmAQPBK6XBVqcp1bFbPlvsvgrpCuVHffU5DrLJdTmtvwNGMeUWhg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1732296958;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=g4uvewhN/5RRhM9hjcyM70QtZWjMssi/swMDzE0BVRw=;
	b=9TVtjVhh6+StipzZIRP1zvt2VFdHfjpvNze3jL14H4p+SSTSqUdTYWbeezjyvab55hveyx
	qRbmrPjoZOd/j7BQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de, Shrikanth Hegde <sshegde@linux.ibm.com>,
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>
Subject: [PATCH] sched/core: Update kernel boot parameters for LAZY preempt.
Message-ID: <20241122173557.MYOtT95Q@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Update the documentation for the `preempt=' parameter which now also
accepts `lazy'.

Fixes: 7c70cb94d29cd ("sched: Add Lazy preemption model")
Reported-by: Shrikanth Hegde <sshegde@linux.ibm.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 Documentation/admin-guide/kernel-parameters.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 9cd9cd06538bf..23d9bd5ea7e47 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4818,6 +4818,11 @@
 			       can be preempted anytime.  Tasks will also yield
 			       contended spinlocks (if the critical section isn't
 			       explicitly preempt disabled beyond the lock itself).
+			lazy - Scheduler controlled. Similar to full but instead
+			       of preempting the task immediately, the task gets
+			       one HZ tick time to yield itself before the
+			       preemption will be forced. One preemption is when the
+			       task returns to user space.
 
 	print-fatal-signals=
 			[KNL] debug: print fatal signals
-- 
2.45.2


