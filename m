Return-Path: <linux-kernel+bounces-207104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF39E90126C
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 17:50:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B3301F2230E
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 15:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9939A179949;
	Sat,  8 Jun 2024 15:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QSzEa7kT"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B78A178379
	for <linux-kernel@vger.kernel.org>; Sat,  8 Jun 2024 15:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717861833; cv=none; b=dUjPAPExJgy1IpGIHNyLw0NasxQZIly0pPmEuWRl2/WAlDmdkMGA4kDQTQVaRs6COrUakQMLqt8+MmlIjYk0IQS0iC/GqQzhjoC+ndf3LJhTk4jxx13C7HI0tPv/ovYFmrghI126A04LajO6bQW33HfoMF+RBq8a0m3u5MpsqDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717861833; c=relaxed/simple;
	bh=8ancUU9hhNXbB4+x7qua8ta8rsrFFSFgVPiTAjOuNqY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UyTSG0Jg0RbU8UDW4JXXbIceLol0EB8fgp4pdi79HUpmkhOD/EsgpfGe8UUbUNqEVcWM4pwAMQKhln32reo3UA/tMVsiUNFjCTz9LCcym2NdZlrZlZ1GkfSMvtL4EHEXfOyGHoiifRULtbBrGleyB9UhmmEpin/eGYeWCmupc0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QSzEa7kT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717861831;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pWtXInkYT7gp35kmZ/vplCyQ6OWaROzH79A+E+0FfKc=;
	b=QSzEa7kTdF8QZFJsCAe+wCu7DaLFOzujJRPePs8cVgSWzTWekifYSFyL5DP3ANewqO/TPY
	VOhGor6YR3FNrIcNzNsMZQH9RxPadd1TsmCX3d+qQL4LwiyrwRLn++FJ1QshtlA6aUX5R7
	tuWFRr3JvnhsiuKtd7PFYCffmPLXank=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-528-P5c5lBWyPuqwSyGZYzhO9g-1; Sat,
 08 Jun 2024 11:50:19 -0400
X-MC-Unique: P5c5lBWyPuqwSyGZYzhO9g-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 87BC41956083;
	Sat,  8 Jun 2024 15:50:14 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.55])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id C6C1A19560AA;
	Sat,  8 Jun 2024 15:50:06 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sat,  8 Jun 2024 17:48:44 +0200 (CEST)
Date: Sat, 8 Jun 2024 17:48:35 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Rachel Menge <rachelmenge@linux.microsoft.com>
Cc: linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
	Wei Fu <fuweid89@gmail.com>, apais@linux.microsoft.com,
	Sudhanva Huruli <Sudhanva.Huruli@microsoft.com>,
	Jens Axboe <axboe@kernel.dk>,
	Christian Brauner <brauner@kernel.org>,
	Mike Christie <michael.christie@oracle.com>,
	Joel Granados <j.granados@samsung.com>,
	Mateusz Guzik <mjguzik@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>
Subject: [PATCH] zap_pid_ns_processes: don't send SIGKILL to sub-threads
Message-ID: <20240608154835.GD7947@redhat.com>
References: <1386cd49-36d0-4a5c-85e9-bc42056a5a38@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1386cd49-36d0-4a5c-85e9-bc42056a5a38@linux.microsoft.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

The comment above the idr_for_each_entry_continue() loop tries to explain
why we have to signal each thread in the namespace, but it is outdated.
This code no longer uses kill_proc_info(), we have a target task so we can
check thread_group_leader() and avoid the unnecessary group_send_sig_info.
Better yet, we can change pid_task() to use PIDTYPE_TGID rather than _PID,
this way it returns NULL if this pid is not a group-leader pid.

Also, change this code to check SIGNAL_GROUP_EXIT, the exiting process /
thread doesn't necessarily has a pending SIGKILL. Either way these checks
are racy without siglock, so the patch uses data_race() to shut up KCSAN.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 kernel/pid_namespace.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/kernel/pid_namespace.c b/kernel/pid_namespace.c
index 25f3cf679b35..0f9bd67c9e75 100644
--- a/kernel/pid_namespace.c
+++ b/kernel/pid_namespace.c
@@ -191,21 +191,14 @@ void zap_pid_ns_processes(struct pid_namespace *pid_ns)
 	 * The last thread in the cgroup-init thread group is terminating.
 	 * Find remaining pid_ts in the namespace, signal and wait for them
 	 * to exit.
-	 *
-	 * Note:  This signals each threads in the namespace - even those that
-	 * 	  belong to the same thread group, To avoid this, we would have
-	 * 	  to walk the entire tasklist looking a processes in this
-	 * 	  namespace, but that could be unnecessarily expensive if the
-	 * 	  pid namespace has just a few processes. Or we need to
-	 * 	  maintain a tasklist for each pid namespace.
-	 *
 	 */
 	rcu_read_lock();
 	read_lock(&tasklist_lock);
 	nr = 2;
 	idr_for_each_entry_continue(&pid_ns->idr, pid, nr) {
-		task = pid_task(pid, PIDTYPE_PID);
-		if (task && !__fatal_signal_pending(task))
+		task = pid_task(pid, PIDTYPE_TGID);
+		/* reading signal->flags is racy without sighand->siglock */
+		if (task && !(data_race(task->signal->flags) & SIGNAL_GROUP_EXIT))
 			group_send_sig_info(SIGKILL, SEND_SIG_PRIV, task, PIDTYPE_MAX);
 	}
 	read_unlock(&tasklist_lock);
-- 
2.25.1.362.g51ebf55



