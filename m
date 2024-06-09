Return-Path: <linux-kernel+bounces-207385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 79FC190165A
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jun 2024 16:25:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92095B20E60
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jun 2024 14:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BD8C446D2;
	Sun,  9 Jun 2024 14:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ML92zgsb"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057EB3D57A
	for <linux-kernel@vger.kernel.org>; Sun,  9 Jun 2024 14:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717943146; cv=none; b=EshlCS83zzKlZDyG7JmcclXCxQ7aaWlM5YxJ4REb6TWqXWh53ScpwEFOLuWtLjRwSRWlwBJHzgdmH1wV8ukNnLim0urlB63vHLlG3brAm4HuO48JiGY/vrLUOQA5sjATeSfvJ5Z6j6LiTzxUKfq7kkkZ2Xwx793jQmHdY04Ys+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717943146; c=relaxed/simple;
	bh=xWJcthAwcXetackijworDdOP3pj/B30QufIuDo7YXGE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MHwuD29KTxO7XAYlJvhBTElJ80ovDzAfK8qag811XhEGSKE8Big+E4PZyL5dzoGt4WDCCOHfOyGHYA/7Hjm0R4UTymi/W0KZT3eCNZAt11q6yWUNcT/R+0Puk4Vr+Pss2oXRYFTFCdbOYE+DXKXScpEN9MVJBJTkeD7bWokmhT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ML92zgsb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717943143;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7z2lNHxUJKQiVCQfi36YKT1EsuvC8gBlvEEk8ni7Rcg=;
	b=ML92zgsbFJ1qXmyVEogssu57nkAzULZrn94TuV4FExtbkNWOLjsD90kuTtT1GXCzzJPoX/
	D1PhManPclMD1Hie3lSBv/2DHLm56dO2bDSWszE0/XWz8G9Tn78TLtbLHbDJejF+HVT9cz
	VOwUUC/Zz/fI+XyB6qU2GUoWSu758o4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-403--VxcXvYnOxGBRCJqFb6cpA-1; Sun, 09 Jun 2024 10:25:40 -0400
X-MC-Unique: -VxcXvYnOxGBRCJqFb6cpA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C939A8045C6;
	Sun,  9 Jun 2024 14:25:39 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.58])
	by smtp.corp.redhat.com (Postfix) with SMTP id 8DC1D175ED;
	Sun,  9 Jun 2024 14:25:38 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sun,  9 Jun 2024 16:24:10 +0200 (CEST)
Date: Sun, 9 Jun 2024 16:24:08 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] exit: kill signal_struct->quick_threads
Message-ID: <20240609142408.GA11174@redhat.com>
References: <20240609142342.GA11165@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240609142342.GA11165@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

do_exit() can simply decrement signal_struct->live earlier and call
synchronize_group_exit() only if group_dead is true. Also, this code
can avoid spin_lock_irq(siglock) if SIGNAL_GROUP_EXIT is already set.

The only "nontrivial" user of signal->live is css_task_iter_advance()
but it should not be affected. With or without this change the task
is the exiting/exited leader which has already passed cgroup_exit(),
atomic_read(signal->live) can race with sub-threads but this is fine.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 include/linux/sched/signal.h |  1 -
 kernel/exit.c                | 12 +++++++-----
 kernel/fork.c                |  2 --
 3 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index 0a0e23c45406..f98aae40d7e6 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -95,7 +95,6 @@ struct signal_struct {
 	refcount_t		sigcnt;
 	atomic_t		live;
 	int			nr_threads;
-	int			quick_threads;
 	struct list_head	thread_head;
 
 	wait_queue_head_t	wait_chldexit;	/* for wait4() */
diff --git a/kernel/exit.c b/kernel/exit.c
index f95a2c1338a8..11bac37e2bc6 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -800,10 +800,11 @@ static void synchronize_group_exit(struct task_struct *tsk, long code)
 	struct sighand_struct *sighand = tsk->sighand;
 	struct signal_struct *signal = tsk->signal;
 
+	if (READ_ONCE(signal->flags) & SIGNAL_GROUP_EXIT)
+		return;
+
 	spin_lock_irq(&sighand->siglock);
-	signal->quick_threads--;
-	if ((signal->quick_threads == 0) &&
-	    !(signal->flags & SIGNAL_GROUP_EXIT)) {
+	if (!(signal->flags & SIGNAL_GROUP_EXIT)) {
 		signal->flags = SIGNAL_GROUP_EXIT;
 		signal->group_exit_code = code;
 		signal->group_stop_count = 0;
@@ -818,7 +819,9 @@ void __noreturn do_exit(long code)
 
 	WARN_ON(irqs_disabled());
 
-	synchronize_group_exit(tsk, code);
+	group_dead = atomic_dec_and_test(&tsk->signal->live);
+	if (group_dead)
+		synchronize_group_exit(tsk, code);
 
 	WARN_ON(tsk->plug);
 
@@ -833,7 +836,6 @@ void __noreturn do_exit(long code)
 	exit_signals(tsk);  /* sets PF_EXITING */
 
 	acct_update_integrals(tsk);
-	group_dead = atomic_dec_and_test(&tsk->signal->live);
 	if (group_dead) {
 		/*
 		 * If the last thread of global init has exited, panic
diff --git a/kernel/fork.c b/kernel/fork.c
index 99076dbe27d8..4c361d2bdc12 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1861,7 +1861,6 @@ static int copy_signal(unsigned long clone_flags, struct task_struct *tsk)
 		return -ENOMEM;
 
 	sig->nr_threads = 1;
-	sig->quick_threads = 1;
 	atomic_set(&sig->live, 1);
 	refcount_set(&sig->sigcnt, 1);
 
@@ -2590,7 +2589,6 @@ __latent_entropy struct task_struct *copy_process(
 			__this_cpu_inc(process_counts);
 		} else {
 			current->signal->nr_threads++;
-			current->signal->quick_threads++;
 			atomic_inc(&current->signal->live);
 			refcount_inc(&current->signal->sigcnt);
 			task_join_group_stop(p);
-- 
2.25.1.362.g51ebf55



