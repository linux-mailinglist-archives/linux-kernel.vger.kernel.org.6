Return-Path: <linux-kernel+bounces-184217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24B748CA476
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 00:30:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 489FD1C21113
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 22:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 918F53BB4D;
	Mon, 20 May 2024 22:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jar92hOn"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF7AA929
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 22:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716244224; cv=none; b=mWS63yXDKG+RBFUHgBNvBS88md4+f2rYKEyeyMxjVtEpd5t3OcT6baLaWQG7llF4N6HWwd0ZbIbsuYXawjcSvZGdFStY87xm7bxliyAljlUxrefNILwRuVBTZjbtxdxsnS51AQxcekVqlvrI5F5f+jUaAsIsuWfJhVhRcx+zxYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716244224; c=relaxed/simple;
	bh=88sBaM9c/lFm72joDHCx2YS7aISJsmZbK2zQBM05g6I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xv0HCA1j15kjSorTKHX4wZ4C5DECQoiLEYslsqBHSQHhMc9Ia11K5jJS8l0HjvSbVvMX9zHh9BAIlquopitmhiz/ODr8EQbYlJf/3xlqR7lZJ9UrkWs3cFy+mAA59Er0nz8tXESInX9tkhXkNRGXq9FqKD+EScCpAisyE3dtgbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jar92hOn; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1ee7963db64so22444345ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 15:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716244220; x=1716849020; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EwsBu5PYWrTFPJ0bre84b7wUfl6breTdrE2WqkfWz3k=;
        b=Jar92hOnO6jgCf1zFEp9Zcr49HtMcKAJVFlS2twWzTmi9MdShE1WibCwqTOQk+nGCZ
         PWy0YBgWSCZzmCMdC0sIfr7U6oU0gLbDC98rzJwQNUOaJ28KG7kPU8jWDbVILQUz9PZ7
         xgIoDNBLunIVGP2SOiuQ8BN2pm4NAHo0stWRZMaUSF71OFJRh7Vmkr+uGzCcstrZap2Z
         ioQzzgd6DnqchFwiFyrNa20r4NdGzeo3uY0GC+eS2Z0MHszqIQxLOKu6UYuASqS0NCQi
         WlPEvq3Dlcv2lPjOYBgF+z45VZDLljcI0DZ2CCXS5/NUKbzZaMxVjIDEsic1ZOIMQICj
         fsCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716244220; x=1716849020;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EwsBu5PYWrTFPJ0bre84b7wUfl6breTdrE2WqkfWz3k=;
        b=BMeDvKjnNP6n4nh/t9Rl5ON0ZEFDLvxsJ7tqtqb2hsn8vd1AjmGJ42rsoWPW/h31zi
         6rPBOSFHIrkbU4ZPkg1EUNWmOzdUPYahgz/G/Oq3EDxTFdQhmSPiEKhEEI6wsyh7AnT+
         p0593qfy2iKVmHp6JmJrYvjWkGurt4FDO/WUycXRNascuN5+6Ncxzyb1cKQbe5QgzBZv
         wmzZvrTn62ISINdNEkeV3hYGtTW6F9LynKgjrk8e/Lhp0cxN6eiJC5l7qofV/qrjLuRB
         quliAPsdeclI5zukYox14IGP0Xklket1GSeG0FfwsWN7NeCJ1lKDSr90tdrEYLLdTe4W
         BU2Q==
X-Forwarded-Encrypted: i=1; AJvYcCV9YiN2YClXSo4pYQ/TUmHY7yLJlzsLdRjPbGJyP+b6TLavqwWfntYAGg65t6jAgTmxZ05NGXhtVNWjrFBOqpgRRrTgclvtxk5XVXmP
X-Gm-Message-State: AOJu0YxWLaC6XLVBDMx8Yp1DjB1H+/FhDsoS4M9TrSECrOvdhYEmzPXQ
	mg3HbGeuVmKCRbgnSqiKoBf9ncHPBSZ2Uo/26E9xnBhzGC51QaoY
X-Google-Smtp-Source: AGHT+IF+yCrFPT4Y/UkNVNB/61VKnO2sVY/0KbF5gBQyzdY5StJyVD72Et7ULze7+CHeLI7sFuuq4Q==
X-Received: by 2002:a17:902:f549:b0:1f3:7cf:b881 with SMTP id d9443c01a7336-1f307cfbb77mr30780875ad.50.1716244220281;
        Mon, 20 May 2024 15:30:20 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0bad886csm209028305ad.70.2024.05.20.15.30.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 15:30:19 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 20 May 2024 12:30:18 -1000
From: Tejun Heo <tj@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jan Engelhardt <jengelh@inai.de>, Craig Small <csmall@enc.com.au>,
	Yafang Shao <laoar.shao@gmail.com>, linux-kernel@vger.kernel.org,
	Lai Jiangshan <jiangshanlai@gmail.com>
Subject: [PATCH workqueue/for-6.10-fixes] workqueue: Refactor worker ID
 formatting and make wq_worker_comm() use full ID string
Message-ID: <ZkvO-h7AsWnj4gaZ@slm.duckdns.org>
References: <o89373n4-3oq5-25qr-op7n-55p9657r96o8@vanv.qr>
 <CAHk-=wjxdtkFMB8BPYpU3JedjAsva3XXuzwxtzKoMwQ2e8zRzw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjxdtkFMB8BPYpU3JedjAsva3XXuzwxtzKoMwQ2e8zRzw@mail.gmail.com>

Currently, worker ID formatting is open coded in create_worker(),
init_rescuer() and worker_thread() (for %WORKER_DIE case). The formatted ID
is saved into task->comm and wq_worker_comm() uses it as the base name to
append extra information to when generating the name to be shown as.

However, TASK_COMM_LEN is only 16 leading to badly truncated names for
rescuers. For example, the rescuer for the inet_frag_wq workqueue becomes:

  $ ps -ef | grep '[k]worker/R-inet'
  root         483       2  0 Apr26 ?        00:00:00 [kworker/R-inet_]

Even for non-rescue workers, it's easy to run over 15 characters on
moderately large machines.

Fit it by consolidating worker ID formatting into a new helper
format_worker_id() and calling it from wq_worker_comm() to obtain the
untruncated worker ID.

  $ ps -ef | grep '[k]worker/R-inet'
  root          60       2  0 12:10 ?        00:00:00 [kworker/R-inet_frag_wq]

Signed-off-by: Tejun Heo <tj@kernel.org>
Reported-by: Jan Engelhardt <jengelh@inai.de>
Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
---
(cc'ing LKML and Lai)

On Mon, May 20, 2024 at 10:17:00AM -0700, Linus Torvalds wrote:
> Oh well. I suspect this would be trivial to fix. I think the
> get_kthread_comm() should use the full name, and only *then* attach
> the extra worker pool information if it exists..
> 
> Tejun?

Yeah, looks like even the unbound worker IDs are getting truncated on larger
machines. This patch should fix it. I'll apply it to wq/for-6.10-fixes soon.

> Also, independently of the WQ worker issue, I do think we could
> possibly expand TASK_COMM_LEN a bit more. 16 bytes is too short for
> user-level names too, and while it's seldom used for 'ps', it's
> visible in things like oops messages etc where it gets truncated.

That'd be great. ISTR this being discussed a while ago. Am I imagining that
we were going to raise this to 32?

Thanks.

 kernel/workqueue.c |   51 ++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 34 insertions(+), 17 deletions(-)

--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -125,6 +125,7 @@ enum wq_internal_consts {
 	HIGHPRI_NICE_LEVEL	= MIN_NICE,
 
 	WQ_NAME_LEN		= 32,
+	WORKER_ID_LEN		= 10 + WQ_NAME_LEN, /* "kworker/R-" + WQ_NAME_LEN */
 };
 
 /*
@@ -2742,6 +2743,26 @@ static void worker_detach_from_pool(stru
 		complete(detach_completion);
 }
 
+static int format_worker_id(char *buf, size_t size, struct worker *worker,
+			    struct worker_pool *pool)
+{
+	if (worker->rescue_wq)
+		return scnprintf(buf, size, "kworker/R-%s",
+				 worker->rescue_wq->name);
+
+	if (pool) {
+		if (pool->cpu >= 0)
+			return scnprintf(buf, size, "kworker/%d:%d%s",
+					 pool->cpu, worker->id,
+					 pool->attrs->nice < 0  ? "H" : "");
+		else
+			return scnprintf(buf, size, "kworker/u%d:%d",
+					 pool->id, worker->id);
+	} else {
+		return scnprintf(buf, size, "kworker/dying");
+	}
+}
+
 /**
  * create_worker - create a new workqueue worker
  * @pool: pool the new worker will belong to
@@ -2758,7 +2779,6 @@ static struct worker *create_worker(stru
 {
 	struct worker *worker;
 	int id;
-	char id_buf[23];
 
 	/* ID is needed to determine kthread name */
 	id = ida_alloc(&pool->worker_ida, GFP_KERNEL);
@@ -2777,17 +2797,14 @@ static struct worker *create_worker(stru
 	worker->id = id;
 
 	if (!(pool->flags & POOL_BH)) {
-		if (pool->cpu >= 0)
-			snprintf(id_buf, sizeof(id_buf), "%d:%d%s", pool->cpu, id,
-				 pool->attrs->nice < 0  ? "H" : "");
-		else
-			snprintf(id_buf, sizeof(id_buf), "u%d:%d", pool->id, id);
+		char id_buf[WORKER_ID_LEN];
 
+		format_worker_id(id_buf, sizeof(id_buf), worker, pool);
 		worker->task = kthread_create_on_node(worker_thread, worker,
-					pool->node, "kworker/%s", id_buf);
+						      pool->node, "%s", id_buf);
 		if (IS_ERR(worker->task)) {
 			if (PTR_ERR(worker->task) == -EINTR) {
-				pr_err("workqueue: Interrupted when creating a worker thread \"kworker/%s\"\n",
+				pr_err("workqueue: Interrupted when creating a worker thread \"%s\"\n",
 				       id_buf);
 			} else {
 				pr_err_once("workqueue: Failed to create a worker thread: %pe",
@@ -3350,7 +3367,6 @@ woke_up:
 		raw_spin_unlock_irq(&pool->lock);
 		set_pf_worker(false);
 
-		set_task_comm(worker->task, "kworker/dying");
 		ida_free(&pool->worker_ida, worker->id);
 		worker_detach_from_pool(worker);
 		WARN_ON_ONCE(!list_empty(&worker->entry));
@@ -5542,6 +5558,7 @@ static int wq_clamp_max_active(int max_a
 static int init_rescuer(struct workqueue_struct *wq)
 {
 	struct worker *rescuer;
+	char id_buf[WORKER_ID_LEN];
 	int ret;
 
 	if (!(wq->flags & WQ_MEM_RECLAIM))
@@ -5555,7 +5572,9 @@ static int init_rescuer(struct workqueue
 	}
 
 	rescuer->rescue_wq = wq;
-	rescuer->task = kthread_create(rescuer_thread, rescuer, "kworker/R-%s", wq->name);
+	format_worker_id(id_buf, sizeof(id_buf), rescuer, NULL);
+
+	rescuer->task = kthread_create(rescuer_thread, rescuer, "%s", id_buf);
 	if (IS_ERR(rescuer->task)) {
 		ret = PTR_ERR(rescuer->task);
 		pr_err("workqueue: Failed to create a rescuer kthread for wq \"%s\": %pe",
@@ -6384,19 +6403,15 @@ void show_freezable_workqueues(void)
 /* used to show worker information through /proc/PID/{comm,stat,status} */
 void wq_worker_comm(char *buf, size_t size, struct task_struct *task)
 {
-	int off;
-
-	/* always show the actual comm */
-	off = strscpy(buf, task->comm, size);
-	if (off < 0)
-		return;
-
 	/* stabilize PF_WQ_WORKER and worker pool association */
 	mutex_lock(&wq_pool_attach_mutex);
 
 	if (task->flags & PF_WQ_WORKER) {
 		struct worker *worker = kthread_data(task);
 		struct worker_pool *pool = worker->pool;
+		int off;
+
+		off = format_worker_id(buf, size, worker, pool);
 
 		if (pool) {
 			raw_spin_lock_irq(&pool->lock);
@@ -6415,6 +6430,8 @@ void wq_worker_comm(char *buf, size_t si
 			}
 			raw_spin_unlock_irq(&pool->lock);
 		}
+	} else {
+		strscpy(buf, task->comm, size);
 	}
 
 	mutex_unlock(&wq_pool_attach_mutex);

