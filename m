Return-Path: <linux-kernel+bounces-418232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 529539D5EE9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 13:38:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBE691F237B2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 12:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFF541DE8AF;
	Fri, 22 Nov 2024 12:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jWGDWJAm"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9045818A6C4
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 12:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732279131; cv=none; b=OJnHWBVbYb9NWqh/BDfxL8sijZxIiJWF6UaFrOqyEM57/ErTgvdwYuhSAsY4EJYp16cU9hY/U5Suylwk2yMXWhmaYfXInNRrhqo/sT/TsOS50yB9e06irj/Z9KolRLz7YG8vXf9D6k0ynT/oz0+NUT+nNX9yiGEuVyHpxiDrZ64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732279131; c=relaxed/simple;
	bh=gQVEHKvau/xfbI1Aj9iTjy/Q5BenIDfUvJiRt2Fhd8k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pTQVNrifsTfbEmT28AqVa9IjGIMjlnEILZMyrY2y9OzP3oNJiSDd0RZuVXpLCrkAzV8bwtwbLdPn5EXQpSNCcSBHchz6l064cyH7JbOrqHLuWztzfZvx2fBMlI1qoW2WBCfHSlMRWPgkPsCUyl2GKwerhwtKuW8kqenVFrEt0eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jWGDWJAm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732279128;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pb+ff1D/0TtpaXGe7UWNVLwVnoQ25lXbKuGb4Qog/nc=;
	b=jWGDWJAmtnoLv//shhCv15KXbUFmVZg+J/AjogZIb859YRSCWiQCzpTDhii8bWmSo23SW4
	eAme/1EpX9YPiv77vXWf2haw97qJfW66hhhNweYIGze86M+cJczrGy9/GrnWUSCcvw0E1e
	SCTH7YbStmkFVCS2nNT2P0jzSY9Tey4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-443-ujmeOmmcMdyqbBElxd9-Gg-1; Fri,
 22 Nov 2024 07:38:43 -0500
X-MC-Unique: ujmeOmmcMdyqbBElxd9-Gg-1
X-Mimecast-MFC-AGG-ID: ujmeOmmcMdyqbBElxd9-Gg
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 89EC619560BD;
	Fri, 22 Nov 2024 12:38:41 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.187])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id DEF9130000DF;
	Fri, 22 Nov 2024 12:38:38 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri, 22 Nov 2024 13:38:21 +0100 (CET)
Date: Fri, 22 Nov 2024 13:38:17 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Anthony Mallet <anthony.mallet@laas.fr>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	linux-kernel@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>,
	Marco Elver <elver@google.com>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: posix timer freeze after some random time, under pthread
 create/destroy load
Message-ID: <20241122123817.GC24815@redhat.com>
References: <26411.57288.238690.681680@gargle.gargle.HOWL>
 <Zz95qDPU2wcEp26r@localhost.localdomain>
 <20241122082407.GA14342@redhat.com>
 <Z0BliWkMHHzohMt3@pavilion.home>
 <20241122114949.GA24815@redhat.com>
 <Z0BylnuVaxwCNP9n@pavilion.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z0BylnuVaxwCNP9n@pavilion.home>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 11/22, Frederic Weisbecker wrote:
>
> Le Fri, Nov 22, 2024 at 12:49:50PM +0100, Oleg Nesterov a écrit :
> > On 11/22, Frederic Weisbecker wrote:
> > >
> > >
> > > Right, I don't mind either way,
> >
> > Me too, so feel free to ignore,
> >
> > > though if it's past PF_EXITING,
> > > complete_signal() -> wants_signal() will defer to another thread anyway, right?
> >
> > Right. So I think it would be better to rely on complete_signal() in this
> > case even if the current logic is very simple and dumb.
>
> Just to make sure I understand correctly, this means you'd prefer to keep
> the PF_EXITING test?

No, sorry for confusion ;)

I'd prefer to check t->exit_state in send_sigqueue() and let complete_signal()
pick another thread if "t->flags & PF_EXITING" is already set.

But I am fine either way, up to you.

I guess we can even avoid the additional check altogether, something like below.
Again, up to you. Your approach looks simpler and doesn't need more comments.

Oleg.

--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1966,7 +1966,7 @@ int send_sigqueue(struct sigqueue *q, struct pid *pid, enum pid_type type)
 {
 	int sig = q->info.si_signo;
 	struct sigpending *pending;
-	struct task_struct *t;
+	struct task_struct *g, *t;
 	unsigned long flags;
 	int ret, result;
 
@@ -1989,12 +1989,12 @@ int send_sigqueue(struct sigqueue *q, struct pid *pid, enum pid_type type)
 	 * the same thread group as the target process, which avoids
 	 * unnecessarily waking up a potentially idle task.
 	 */
-	t = pid_task(pid, type);
-	if (!t)
+	g = t = pid_task(pid, type);
+	if (!g)
 		goto ret;
 	if (type != PIDTYPE_PID && same_thread_group(t, current))
 		t = current;
-	if (!likely(lock_task_sighand(t, &flags)))
+	if (!likely(lock_task_sighand(g, &flags)))
 		goto ret;
 
 	ret = 1; /* the signal is ignored */
@@ -2022,7 +2022,7 @@ int send_sigqueue(struct sigqueue *q, struct pid *pid, enum pid_type type)
 	result = TRACE_SIGNAL_DELIVERED;
 out:
 	trace_signal_generate(sig, &q->info, t, type != PIDTYPE_PID, result);
-	unlock_task_sighand(t, &flags);
+	unlock_task_sighand(g, &flags);
 ret:
 	rcu_read_unlock();
 	return ret;


