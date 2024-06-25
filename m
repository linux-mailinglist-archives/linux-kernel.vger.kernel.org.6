Return-Path: <linux-kernel+bounces-229020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9C3C9169CC
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 16:05:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D534B2199D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 14:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D513E15FCE9;
	Tue, 25 Jun 2024 14:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OjeEQwPm"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D991B7F7
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 14:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719324302; cv=none; b=c/wBhOZHa8mWl2LmCbM23ZXYZlWkM96hgjob2+k9r274wZ3TAOfw4LwGXWLwq9IoTU7I4EpyDNn8gAI60ByUXwp65LdO1G+P+2NxBBarrCwv9ZnhNmro6rgBNj5MtP47OY+UwGFEN598B+UrQgDMDFUhKZMUn7akhVxTBADiR3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719324302; c=relaxed/simple;
	bh=rZcBVQ19I8Yf7EoJttJjrVG42Lecd+vEbddhR/i6kRA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=pamKwugp/LC3PUUa3GCq7l/ASUZAt6xnhNM9Gc5g9p6L56S/iBZbVbPo4Dq17p/K0n/5Y7wHmJq3GwGlVJHhvsz3cQLWC2iIu+b4fx1EkLEDPbzoJBFOH/g2LcM1FEzO7sZi2oHNApPULXxnwQrM2dk248PY4tFPsKspbvuUCOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OjeEQwPm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719324299;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=RdX/8WxWwn00qAhaekW/Jwqf7v/oK5wA8fQVoOY2kQA=;
	b=OjeEQwPmDJQnIeVDKvzU6piZgBzOGugd+630n7NuczHEHd7w1TWs52nUsjcEdnqAaxuT9Z
	iv9r36ZMsqwtLhT3mTfSbbFFzgkIKLleSJZmH1vWJYpNXkmJcJbMLco1b4n4z2yrP+KaSS
	oJSl3V58FXuE55xeAV5Kn1VzTSg5Les=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-522-qrv6dalzNfO5HAZqpVJ2Xw-1; Tue,
 25 Jun 2024 10:04:55 -0400
X-MC-Unique: qrv6dalzNfO5HAZqpVJ2Xw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E83911955D9C;
	Tue, 25 Jun 2024 14:04:47 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.198])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 12BA4195605B;
	Tue, 25 Jun 2024 14:04:45 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue, 25 Jun 2024 16:03:14 +0200 (CEST)
Date: Tue, 25 Jun 2024 16:03:11 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] coredump: simplify zap_process()
Message-ID: <20240625140311.GA20787@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

After the commit 0258b5fd7c71 ("coredump: Limit coredumps to a single
thread group") zap_process() doesn't need the "task_struct *start" arg,
zap_threads() can pass "signal_struct *signal" instead.

This simplifies the code and allows to use __for_each_thread() which
is slightly more efficient.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 fs/coredump.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index a57a06b80f57..4dc5140bac3f 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -361,17 +361,16 @@ static int format_corename(struct core_name *cn, struct coredump_params *cprm,
 	return ispipe;
 }
 
-static int zap_process(struct task_struct *start, int exit_code)
+static int zap_process(struct signal_struct *signal, int exit_code)
 {
 	struct task_struct *t;
 	int nr = 0;
 
-	/* Allow SIGKILL, see prepare_signal() */
-	start->signal->flags = SIGNAL_GROUP_EXIT;
-	start->signal->group_exit_code = exit_code;
-	start->signal->group_stop_count = 0;
+	signal->flags = SIGNAL_GROUP_EXIT;
+	signal->group_exit_code = exit_code;
+	signal->group_stop_count = 0;
 
-	for_each_thread(start, t) {
+	__for_each_thread(signal, t) {
 		task_clear_jobctl_pending(t, JOBCTL_PENDING_MASK);
 		if (t != current && !(t->flags & PF_POSTCOREDUMP)) {
 			sigaddset(&t->pending.signal, SIGKILL);
@@ -391,8 +390,9 @@ static int zap_threads(struct task_struct *tsk,
 
 	spin_lock_irq(&tsk->sighand->siglock);
 	if (!(signal->flags & SIGNAL_GROUP_EXIT) && !signal->group_exec_task) {
+		/* Allow SIGKILL, see prepare_signal() */
 		signal->core_state = core_state;
-		nr = zap_process(tsk, exit_code);
+		nr = zap_process(signal, exit_code);
 		clear_tsk_thread_flag(tsk, TIF_SIGPENDING);
 		tsk->flags |= PF_DUMPCORE;
 		atomic_set(&core_state->nr_threads, nr);
-- 
2.25.1.362.g51ebf55



