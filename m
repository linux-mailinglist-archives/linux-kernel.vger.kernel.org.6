Return-Path: <linux-kernel+bounces-290710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC3DB9557B5
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 13:58:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63A38282B1C
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 11:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93A24149E1A;
	Sat, 17 Aug 2024 11:58:28 +0000 (UTC)
Received: from mail78-36.sinamail.sina.com.cn (mail78-36.sinamail.sina.com.cn [219.142.78.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0804256E
	for <linux-kernel@vger.kernel.org>; Sat, 17 Aug 2024 11:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=219.142.78.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723895908; cv=none; b=lZt+py+cs32us5bN2CiY35C36sf7rBYMS897huShyKvstBplAqXKOhFLExb4alhyonPBKicmSwDenokVWH49jkABYqOdgGMlcqNpsR0U+cJeavtFxMIaF07Hl/pmTwy261mB9ivJAMdogPqdP/gFVDREhZfa5uZvUyd4Wd4G8Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723895908; c=relaxed/simple;
	bh=1QH5taJkgIXKQJYzG0oh4xOmW83hBH5xBKkI8RmY4EE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eXE5yup9PNwHjCTaiwNqqKxSOLIsXaL82VTwuqXRb6tdpAzgIzSYFQPvJQ6RBviPTlz/wOe8b6K3F5UgXGzAo/RiJAMWWOAlsGtO5Cd8SdxbgDyQtGPwYevIOjTNrI6m2ra8a2Bq+MfHYqXyJ6oFQizmv0aWm8Piq2eJjhZ6EdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=219.142.78.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.88.51.198])
	by sina.com (10.185.250.24) with ESMTP
	id 66C0904D0000581A; Sat, 17 Aug 2024 19:58:11 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 34633710748488
X-SMAIL-UIID: 259B59B2E7F14EB586AA0041355CE08F-20240817-195811-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+ca14b36a46a8c541b509@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [cgroups?] possible deadlock in task_rq_lock
Date: Sat, 17 Aug 2024 19:57:56 +0800
Message-Id: <20240817115756.672-1-hdanton@sina.com>
In-Reply-To: <00000000000092ef86061fdb849b@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 16 Aug 2024 23:52:22 -0700
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    367b5c3d53e5 Add linux-next specific files for 20240816
> git tree:       linux-next
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=142413c5980000

#syz test linux-next  367b5c3d53e5

--- x/kernel/sched/deadline.c
+++ y/kernel/sched/deadline.c
@@ -1498,6 +1498,9 @@ static void update_curr_dl_se(struct rq
 	 * starting a new period, pushing the activation.
 	 */
 	if (dl_se->dl_defer && dl_se->dl_throttled && dl_runtime_exceeded(dl_se)) {
+		bool lock = rq != dl_se->rq;
+		struct rq_flags rf;
+		struct rq *__rq = dl_se->rq;
 		/*
 		 * If the server was previously activated - the starving condition
 		 * took place, it this point it went away because the fair scheduler
@@ -1508,7 +1511,11 @@ static void update_curr_dl_se(struct rq
 
 		hrtimer_try_to_cancel(&dl_se->dl_timer);
 
+		if (lock)
+			rq_lock(__rq, &rf);
 		replenish_dl_new_period(dl_se, dl_se->rq);
+		if (lock)
+			rq_unlock(__rq, &rf);
 
 		/*
 		 * Not being able to start the timer seems problematic. If it could not
--- x/kernel/workqueue.c
+++ y/kernel/workqueue.c
@@ -5653,6 +5653,7 @@ static struct workqueue_struct *__alloc_
 	wq = kzalloc(wq_size, GFP_KERNEL);
 	if (!wq)
 		return NULL;
+	wq_init_lockdep(wq);
 
 	if (flags & WQ_UNBOUND) {
 		wq->unbound_attrs = alloc_workqueue_attrs();
@@ -5757,10 +5758,6 @@ struct workqueue_struct *alloc_workqueue
 	va_start(args, max_active);
 	wq = __alloc_workqueue(fmt, flags, max_active, args);
 	va_end(args);
-	if (!wq)
-		return NULL;
-
-	wq_init_lockdep(wq);
 
 	return wq;
 }
--

