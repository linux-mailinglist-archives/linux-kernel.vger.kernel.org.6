Return-Path: <linux-kernel+bounces-346841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71B9198C98F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 01:40:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 246701F22180
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 23:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 843091D4340;
	Tue,  1 Oct 2024 23:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="loa/bINo"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5791D4339
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 23:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727826042; cv=none; b=pMcIKvn89cXjd85G8bhKSLK47wGBtr/eMNBUmcl082eirHx/+c/sim4c3tCsqhhLIfQeb4EQ2LpXBHMuJ7Wy80Qf3/nDcMqPTP/rUEl2xC2m1Sm4neSuivZi8l9qk3aiHb4hfwYeXzSQsgek6oesv89Lrbbd0ii2r3i8x+fJJvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727826042; c=relaxed/simple;
	bh=NS12qIknKAL5AtQt5zNluFgO5GcXSAeCf6qRM1UQzS8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FOAZKDLEslOGhJBMov/kSG9v3S5egsGOaZMpAp+EGFNUdPUHpPBEiwtqGXWn/Pl5jLdqLkuRxZaOBCiGo6PKtMk194wWGlZ6hH9Qp675LfWlmO3XBEmDT6VUTsMDBHEy36PAciN5a70W3elNwi/l0/pF4ajCytm+D8rcRu9vO2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=loa/bINo; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=X0boj5RnFLoxWGhjt8kf/h3huITnyE9XWJHSw1uX0Qk=; b=loa/bINoJDsh1aKl
	AWGMeW5+l4svJZeISRQ4I4lFYjVYtstfcNRMYx4AmvEoTN6EaTWLq1SYtydlHHcg8pi24rw1FIt1J
	uZrpl0EvbvRsuHtPJeVq2NFYID7jiOQb6yHVxmiZ7Ed95bz8KxMkjem7XJ5OWIyEHSHdvwW3jTX/j
	y6NwoDAJvE6hZD17+weQKOy/PvEpzqaunp4Vpwws2mMwXyv8n50tSrOgsGY7tvk0MQmAtO+Y5BJXo
	8LowlRQjW4N+KrlIH821nmgkzP2IVAN3AxOO8QRSRTCmyE7c9ehRZuOcls3YBpesAlV750rQCk18w
	qY9n8DNLEu5+8pJ0bw==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1svmTa-008LmS-1c;
	Tue, 01 Oct 2024 23:40:18 +0000
From: linux@treblig.org
To: mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com
Cc: linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH] sched/wait: Remove unused bit_wait_io_timeout
Date: Wed,  2 Oct 2024 00:40:16 +0100
Message-ID: <20241001234016.231696-1-linux@treblig.org>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

bit_wait_io_timeout has been unused since 2016's
commit 62906027091f ("mm: add PageWaiters indicating tasks are waiting for a page bit")

Remove it.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 include/linux/wait_bit.h |  1 -
 kernel/sched/wait_bit.c  | 14 --------------
 2 files changed, 15 deletions(-)

diff --git a/include/linux/wait_bit.h b/include/linux/wait_bit.h
index 7725b7579b78..d9c23377dc75 100644
--- a/include/linux/wait_bit.h
+++ b/include/linux/wait_bit.h
@@ -49,7 +49,6 @@ int wake_bit_function(struct wait_queue_entry *wq_entry, unsigned mode, int sync
 extern int bit_wait(struct wait_bit_key *key, int mode);
 extern int bit_wait_io(struct wait_bit_key *key, int mode);
 extern int bit_wait_timeout(struct wait_bit_key *key, int mode);
-extern int bit_wait_io_timeout(struct wait_bit_key *key, int mode);
 
 /**
  * wait_on_bit - wait for a bit to be cleared
diff --git a/kernel/sched/wait_bit.c b/kernel/sched/wait_bit.c
index 134d7112ef71..c6aab3db70bf 100644
--- a/kernel/sched/wait_bit.c
+++ b/kernel/sched/wait_bit.c
@@ -228,20 +228,6 @@ __sched int bit_wait_timeout(struct wait_bit_key *word, int mode)
 }
 EXPORT_SYMBOL_GPL(bit_wait_timeout);
 
-__sched int bit_wait_io_timeout(struct wait_bit_key *word, int mode)
-{
-	unsigned long now = READ_ONCE(jiffies);
-
-	if (time_after_eq(now, word->timeout))
-		return -EAGAIN;
-	io_schedule_timeout(word->timeout - now);
-	if (signal_pending_state(mode, current))
-		return -EINTR;
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(bit_wait_io_timeout);
-
 void __init wait_bit_init(void)
 {
 	int i;
-- 
2.46.2


