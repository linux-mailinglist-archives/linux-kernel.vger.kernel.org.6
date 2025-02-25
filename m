Return-Path: <linux-kernel+bounces-531891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF299A44651
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 17:39:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 041851737ED
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 16:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A712C1865E2;
	Tue, 25 Feb 2025 16:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NkCpq6uI"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A15175D5D
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 16:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740501392; cv=none; b=HxB6ncuJghK7E9OH81Qb3ygaWwxo+HapoX6rYyTJ1h53psDdU5GDadqcvZc4CiUky9TATb0jBPW40ZMsbpCOmrKm6CVVlcEpynSDtmeEU7HAlukPOVHk+i3lmy02DxgboGWKIyL5hBFNiIvkEcalHpPz2KhmaRNZPYmvCUrRznE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740501392; c=relaxed/simple;
	bh=bWOlvCKoR2I0cAuzAJUDNhUDJULknMjTjASxL6OoCqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eX1NtifMLphyigVwNgLmuXF+LdWDuVynhtf/ztnXEtDsxQ/b2J1MTqgiIxK29qnkEZpS8BbBN0l7GXJgTWjWjVbhe/J2M5ziXmLo4jBG72c2DmvKGHWBcf8hxTlkzyBeP70/2O3+XvE3Dw+PgXBjmbUKpMWDGVz0capviCOgPWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NkCpq6uI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740501389;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GXy1eV7pOVh2nuyHy2Hir2zwnR7Ervc2YgoUJkp+6Qc=;
	b=NkCpq6uIYndAZnVUMEHvhgnCUTKTvtywKHnjkSv53m8FIZ7y/VCUaxm10J82HTFvhosCO6
	9Xxe8ZDTM5asbwiPhk49cRqQ4+B1Q2Uupntp+5AM/bK0y7G3VW3uAGc/cvaGwTnOmeBm7b
	91KrNrbtK+EiHjiSuhG24Q46ReZ2mSw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-306-uJ1mM8kiMGaebtzWqsUbHw-1; Tue,
 25 Feb 2025 11:36:25 -0500
X-MC-Unique: uJ1mM8kiMGaebtzWqsUbHw-1
X-Mimecast-MFC-AGG-ID: uJ1mM8kiMGaebtzWqsUbHw_1740501384
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6F80319783B3;
	Tue, 25 Feb 2025 16:36:24 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.211])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 724291800352;
	Tue, 25 Feb 2025 16:36:21 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue, 25 Feb 2025 17:35:54 +0100 (CET)
Date: Tue, 25 Feb 2025 17:35:50 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-kernel@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Waiman Long <longman@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] task_work: Consume only item at a time while invoking
 the callbacks.
Message-ID: <20250225163549.GB29585@redhat.com>
References: <20250221170530.L3yMvO0i@linutronix.de>
 <20250223224014.GC23282@redhat.com>
 <Z73Tj3SAzNjaHwV3@localhost.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z73Tj3SAzNjaHwV3@localhost.localdomain>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On 02/25, Frederic Weisbecker wrote:
>
> Le Sun, Feb 23, 2025 at 11:40:15PM +0100, Oleg Nesterov a écrit :
> >
> > I'll try to find and read the previous discussions tomorrow, but iirc Frederic
> > had another solution?
>
> This:
>
> 	https://lore.kernel.org/all/Zx-B0wK3xqRQsCOS@localhost.localdomain/
>
> Though I'm not entirely happy with it either.

Yes, thanks...

Can we do something else and avoid this rcuwait_wait_event() altogether?

To simplify the discussion, suppose we add a global XXX_LOCK. Just in
case, of course we shouldn't do this ;) But lets suppose we do.

Now, can _something_ like the (incomplete, ugly as hell) patch below work?

Oleg.
---

--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -5304,12 +5304,12 @@ static void perf_pending_task_sync(struct perf_event *event)
 		return;
 	}
 
-	/*
-	 * All accesses related to the event are within the same RCU section in
-	 * perf_pending_task(). The RCU grace period before the event is freed
-	 * will make sure all those accesses are complete by then.
-	 */
-	rcuwait_wait_event(&event->pending_work_wait, !event->pending_work, TASK_UNINTERRUPTIBLE);
+	spin_lock(XXX_LOCK);
+	if (event->pending_work) {
+		local_dec(&event->ctx->nr_no_switch_fast);
+		event->pending_work = -1;
+	}
+	spin_unlock(XXX_LOCK);
 }
 
 static void _free_event(struct perf_event *event)
@@ -5369,7 +5369,15 @@ static void _free_event(struct perf_event *event)
 	exclusive_event_destroy(event);
 	module_put(event->pmu->module);
 
-	call_rcu(&event->rcu_head, free_event_rcu);
+	bool free = true;
+	spin_lock(XXX_LOCK)
+	if (event->pending_work == -1) {
+		event->pending_work = -2;
+		free = false;
+	}
+	spin_unlock(XXX_LOCK);
+	if (free)
+		call_rcu(&event->rcu_head, free_event_rcu);
 }
 
 /*
@@ -6981,7 +6989,14 @@ static void perf_pending_task(struct callback_head *head)
 {
 	struct perf_event *event = container_of(head, struct perf_event, pending_task);
 	int rctx;
+	bool free = false;
 
+	spin_lock(XXX_LOCK);
+	if ((int)event->pending_work < 0) {
+		free = event->pending_work == -2u;
+		event->pending_work = 0;
+		goto unlock;
+	}
 	/*
 	 * All accesses to the event must belong to the same implicit RCU read-side
 	 * critical section as the ->pending_work reset. See comment in
@@ -7004,6 +7019,12 @@ static void perf_pending_task(struct callback_head *head)
 
 	if (rctx >= 0)
 		perf_swevent_put_recursion_context(rctx);
+
+unlock:
+	spin_unlock(XXX_LOCK);
+
+	if (free)
+		call_rcu(&event->rcu_head, free_event_rcu);
 }
 
 #ifdef CONFIG_GUEST_PERF_EVENTS


