Return-Path: <linux-kernel+bounces-271917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3B689454F0
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 01:33:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E34061C22DC1
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 23:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7254414D2AB;
	Thu,  1 Aug 2024 23:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O66wvaLL"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 162C913E04C
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 23:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722555183; cv=none; b=Tm+xKHTEjenLPMheMpjYxBcoWhBBX3Pa8VfWSg3aKMnrz1zflMi1dIj1qLvfK4onGl3LN4vrVGOpiHYDCtqm4Sw9ijZAAH31MY6m8nI03v9mNeVIWoIE8L8uitmldri1yDBwmlECU/vDh976G7hdVIjsjwiEmzHGtwfEy19nHG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722555183; c=relaxed/simple;
	bh=dUmTOircfr5/DdVYMD6EeTFH0jUdNMoRbQWH/ot3380=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=huShdoF5le1dvcGqfOb0CU6oQi/fFC3/bxMuXJK9kV8Xf6bjALPagXju16C2t8uAqkuMrMFyAxVBIGdJinR1fjldiGuCjjd2jYdqwYgttkDeUHnZj1is09y5LdkdF+TsAth9sQpZtKyNmm/sTzMRtpyRF7/5G3meYHhcuO4z4Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O66wvaLL; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1fc47abc040so52420525ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 16:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722555181; x=1723159981; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zgM+QGE9YeFKh5UVWszkhwDFuBiGzO/YF4o1+I6OQ4g=;
        b=O66wvaLLSYzz9koeDLd+MykdHSwxa8aKzR5RfIEHyk4MJyV+u+aKOvWab/ZvYWjUbp
         FJVdKLhoAdqw0+JBiboZJG9FloUepUJlzXhos/a2U+H3ZlorMYLwOQ9WUurqGVZQOFDt
         AeuJxkSGj1V+rrGvhnjTCLo8plQnZK61G28IajEpSIMFi1TxDbunOUqFYw/5gT2uUJhN
         lBkFkcoXebsIWDZE2t+j2vu6X2DWoEDK35WmPc7ykjYYn3GMKZVVQJWIClxogKSzrx/5
         hO7rvWamWUN4aSJBXYrEbnm9pl27iiBjYDnOKaqMSziJtwws+9fnSQyJEClaOaveVy5h
         Bqeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722555181; x=1723159981;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zgM+QGE9YeFKh5UVWszkhwDFuBiGzO/YF4o1+I6OQ4g=;
        b=twr/YV12hJyKXcrnqnprlFQCwP3b/Lv0CwcxUU8vs3i2SDF3kngD5cuy31CYompA3U
         e2Ga6eHtYzdVcOMete1uBbHUXKSf3DYMzMOJh2pA6oczWTAyEtmIPPphWrDyMIZetpjz
         0CymCAzVQd8nlw0JM7/Seo1oAvwT9zpsLLVIEUJxFdqB9g43x7GMr5fe3ZR8wiVJT5zy
         IoiuHLBMQByIsT6PbqRE5rrQn+idJ2TTi6dB4vOze5XMPAPFlquL1Ems7+B7uNrPIlXA
         ILCq5qCOTXh0OSMepOLym9yufQ1opLnih/edFLgKgbejiRI++210/fqOZGxPAonqTk5O
         7YVQ==
X-Forwarded-Encrypted: i=1; AJvYcCWfeqJ/GYUyhEr/fmhTkJIAVeuY6QyOpTm8XTMqPA7J3XQd/VlWz4ZwI+HfDP8FRb3jQVejRmqe9sG/qqYIz3ZlOb5WaCP+e4ZIqikt
X-Gm-Message-State: AOJu0Yx73vUaf56DtdiN/YU2uUzugcRVRqcDgxFoJePwzzMYx7K7ImEZ
	UOybfUPNn4PcLONnT+fcJdC1+jSP3ZjVi/urxE5jfKXDBycoYw16
X-Google-Smtp-Source: AGHT+IHOzw9uynaBNany4i42JhMkcfrgZFturzOom/xQpzt5OL/yPZi+CoQJ4MySUd1+Z6+e2gLTZw==
X-Received: by 2002:a17:902:ea08:b0:1fd:acd1:b63a with SMTP id d9443c01a7336-1ff5747e911mr22848785ad.50.1722555181057;
        Thu, 01 Aug 2024 16:33:01 -0700 (PDT)
Received: from localhost (dhcp-141-239-149-160.hawaiiantel.net. [141.239.149.160])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff58f214bfsm4622715ad.24.2024.08.01.16.33.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 16:33:00 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Thu, 1 Aug 2024 13:32:59 -1000
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>
Cc: "Zhangqiao (2012 lab)" <zhangqiao22@huawei.com>,
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: [PATCH v2 sched_ext/for-6.12] sched_ext: Allow p->scx.disallow only
 while loading
Message-ID: <ZqwbK9m6ATnyYxHS@slm.duckdns.org>
References: <20240711110720.1285-1-zhangqiao22@huawei.com>
 <ZpArK0qxZZI-0ykt@slm.duckdns.org>
 <ba2702f9-f66e-498b-853c-d23f1f9191bc@huawei.com>
 <ZpbclgFjf_q6PSd1@slm.duckdns.org>
 <cd3fa16d-5a70-4c85-a591-fa4fa481f50b@huawei.com>
 <ZpgERphu--gPn235@slm.duckdns.org>
 <7d39f26d-3c9f-4ee4-977c-87f9bed0bac1@huawei.com>
 <ZqqNLNWLfjsJ2E02@slm.duckdns.org>
 <20240731203344.GA42857@maniforge>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240731203344.GA42857@maniforge>

From 1232da7eced620537a78f19c8cf3d4a3508e2419 Mon Sep 17 00:00:00 2001
From: Tejun Heo <tj@kernel.org>
Date: Wed, 31 Jul 2024 09:14:52 -1000

p->scx.disallow provides a way for the BPF scheduler to reject certain tasks
from attaching. It's currently allowed for both the load and fork paths;
however, the latter doesn't actually work as p->sched_class is already set
by the time scx_ops_init_task() is called during fork.

This is a convenience feature which is mostly useful from the load path
anyway. Allow it only from the load path.

v2: Trigger scx_ops_error() iff @p->policy == SCHED_EXT to make it a bit
    easier for the BPF scheduler (David).

Signed-off-by: Tejun Heo <tj@kernel.org>
Reported-by: "Zhangqiao (2012 lab)" <zhangqiao22@huawei.com>
Link: http://lkml.kernel.org/r/20240711110720.1285-1-zhangqiao22@huawei.com
Fixes: 7bb6f0810ecf ("sched_ext: Allow BPF schedulers to disallow specific tasks from joining SCHED_EXT")
Signed-off-by: Tejun Heo <tj@kernel.org>
---
David, how does this look?

Thanks.

 include/linux/sched/ext.h | 11 ++++++-----
 kernel/sched/ext.c        | 35 ++++++++++++++++++++---------------
 2 files changed, 26 insertions(+), 20 deletions(-)

diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
index 26e1c33bc844..69f68e2121a8 100644
--- a/include/linux/sched/ext.h
+++ b/include/linux/sched/ext.h
@@ -179,11 +179,12 @@ struct sched_ext_entity {
 	 * If set, reject future sched_setscheduler(2) calls updating the policy
 	 * to %SCHED_EXT with -%EACCES.
 	 *
-	 * If set from ops.init_task() and the task's policy is already
-	 * %SCHED_EXT, which can happen while the BPF scheduler is being loaded
-	 * or by inhering the parent's policy during fork, the task's policy is
-	 * rejected and forcefully reverted to %SCHED_NORMAL. The number of
-	 * such events are reported through /sys/kernel/debug/sched_ext::nr_rejected.
+	 * Can be set from ops.init_task() while the BPF scheduler is being
+	 * loaded (!scx_init_task_args->fork). If set and the task's policy is
+	 * already %SCHED_EXT, the task's policy is rejected and forcefully
+	 * reverted to %SCHED_NORMAL. The number of such events are reported
+	 * through /sys/kernel/debug/sched_ext::nr_rejected. Setting this flag
+	 * during fork is not allowed.
 	 */
 	bool			disallow;	/* reject switching into SCX */
 
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 6f7c7d8b56de..938830121a32 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -3396,24 +3396,29 @@ static int scx_ops_init_task(struct task_struct *p, struct task_group *tg, bool
 	scx_set_task_state(p, SCX_TASK_INIT);
 
 	if (p->scx.disallow) {
-		struct rq *rq;
-		struct rq_flags rf;
+		if (!fork) {
+			struct rq *rq;
+			struct rq_flags rf;
 
-		rq = task_rq_lock(p, &rf);
+			rq = task_rq_lock(p, &rf);
 
-		/*
-		 * We're either in fork or load path and @p->policy will be
-		 * applied right after. Reverting @p->policy here and rejecting
-		 * %SCHED_EXT transitions from scx_check_setscheduler()
-		 * guarantees that if ops.init_task() sets @p->disallow, @p can
-		 * never be in SCX.
-		 */
-		if (p->policy == SCHED_EXT) {
-			p->policy = SCHED_NORMAL;
-			atomic_long_inc(&scx_nr_rejected);
-		}
+			/*
+			 * We're in the load path and @p->policy will be applied
+			 * right after. Reverting @p->policy here and rejecting
+			 * %SCHED_EXT transitions from scx_check_setscheduler()
+			 * guarantees that if ops.init_task() sets @p->disallow,
+			 * @p can never be in SCX.
+			 */
+			if (p->policy == SCHED_EXT) {
+				p->policy = SCHED_NORMAL;
+				atomic_long_inc(&scx_nr_rejected);
+			}
 
-		task_rq_unlock(rq, p, &rf);
+			task_rq_unlock(rq, p, &rf);
+		} else if (p->policy == SCHED_EXT) {
+			scx_ops_error("ops.init_task() set task->scx.disallow for %s[%d] during fork",
+				      p->comm, p->pid);
+		}
 	}
 
 	p->scx.flags |= SCX_TASK_RESET_RUNNABLE_AT;
-- 
2.45.2


