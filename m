Return-Path: <linux-kernel+bounces-384683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA7369B2D2C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 11:45:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C31C91C21917
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 10:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04D261D95A1;
	Mon, 28 Oct 2024 10:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qLNLtPAF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RMcTOJSu"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70BD21D88AC
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 10:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730112227; cv=none; b=Y43v6bRAF0bQkMibRwM7IZ/nxKYIJd+CldrYwyvq/8E/pV7DjD5J3WnlH04OVqOQQeGwQG21G6uWvJEuDvE6iMtL2KRcEBfyorE5vNG9idFbNN4WtPDr8fz46SWSmXEeY1nDtlbv68hWI3tlAWGXTM28PV3yFLFoGL7CfNbOCkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730112227; c=relaxed/simple;
	bh=p87L0U/wfgeWAEMV0TRvnldY0DFh6yspZEZFR/aI/jI=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=cfHYdl5qH/vor4ruLqdx1RF7JmIMeSCUf6qPaKOyweFSrsm8YbRfIGQY37/6Rtkic17UFxjw1CmIV/vBN56zM8RYdD2cXCDsuQVE2NEvfqaJ03coJMZ1+2NdKY5fgcBVWgCIfG22Cg/igzh3p2LB1xpT0ZLMQ4LgMD17eJ6q8Q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qLNLtPAF; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RMcTOJSu; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20241028103142.423153706@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730112223;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=8V9BMISLe+emg3tqf6WBDnIjWn20ZCDDb1a0hEN5uUQ=;
	b=qLNLtPAFOUQqVGi9YaQuXAvmlhkZXUc5MY2L3mUxrd0zQrBAwdSh3dFrfGnegyUoaDUNOL
	FcGqQvwf/SsjGVnNTzsHXIo5kesoeapMfMqoRxuWkygF0228NlGRUUulBoBuHIfUxeMDMS
	QM7MPW4SKUJLW3jU/1jSoIOJDn2saYfDpNvBI7t3EOBP3sUGcEVXwPWXzTGIL5MlQTBuCq
	MScWBZvt+cOQLTmexKDZjuYe2oQzAg8JMY5ErRkSpJAnVNUxkna0HrpObbcKvcTxAKwbiV
	BQvULmC7B1kBNqKmgokT0B8Ek58nopQNq9x2Sz9JwV9zCk7X/qP3e/oM9lDIYQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730112223;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=8V9BMISLe+emg3tqf6WBDnIjWn20ZCDDb1a0hEN5uUQ=;
	b=RMcTOJSuPsXLBGtu+xnTbDBPjkc+ZnBCqYfj+5Na8Ao+PgNp3ENrq7JtFfkkK2djbXG0PI
	Ve1rODsJ454IqADQ==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
 Tejun Heo <tj@kernel.org>,
 David Vernet <void@manifault.com>,
 Ingo Molnar <mingo@kernel.org.com>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>,
 Valentin Schneider <vschneid@redhat.com>,
 Ingo Molnar <mingo@kernel.org>
Subject: [patch 2/2] sched/ext: Remove sched_fork() hack
References: <20241028103006.008053168@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Mon, 28 Oct 2024 11:43:43 +0100 (CET)

Instead of solving the underlying problem of the double invocation of
__sched_fork() for idle tasks, sched-ext decided to hack around the issue
by partially clearing out the entity struct to preserve the already
enqueued node. A provided analysis and solution has been ignored for four
months.

Now that someone else has taken care of cleaning it up, remove the
disgusting hack and clear out the full structure.

Fixes: f0e1a0643a59 ("sched_ext: Implement BPF extensible scheduler class")
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>
Cc: Ingo Molnar <mingo@kernel.org.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ben Segall <bsegall@google.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Valentin Schneider <vschneid@redhat.com>
---
 kernel/sched/ext.c |    7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -3548,12 +3548,7 @@ static void scx_ops_exit_task(struct tas
 
 void init_scx_entity(struct sched_ext_entity *scx)
 {
-	/*
-	 * init_idle() calls this function again after fork sequence is
-	 * complete. Don't touch ->tasks_node as it's already linked.
-	 */
-	memset(scx, 0, offsetof(struct sched_ext_entity, tasks_node));
-
+	memset(scx, 0, sizeof(*scx));
 	INIT_LIST_HEAD(&scx->dsq_list.node);
 	RB_CLEAR_NODE(&scx->dsq_priq);
 	scx->sticky_cpu = -1;


