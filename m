Return-Path: <linux-kernel+bounces-255517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 135F19341AE
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 19:50:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 369781C22FCC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 17:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6171181D07;
	Wed, 17 Jul 2024 17:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SDZmri4L"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA341181B9A
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 17:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721238602; cv=none; b=UqRnR9hrh13hnX3JBT3DfK75xOAQs/lWyr564Pn2s9MoFl5ePX+pb02b5KgT8/vDWqtUQNSo+h89X4xroXYzfhwwgwwuAw3HpnolbCioR98gv3aBGsuuR+Ze1onG2z8oKnM5xvCrG4yd0ELyj47Bvc6Uz7PbR+JQXPS/GwveVtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721238602; c=relaxed/simple;
	bh=5Sc7SWPhiTVoDUs92LlD0b7Mdip3KsjSSt5cmhbSlRk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MWvD+q+Vc6mZaTiBME+hTt7oKdmxaCBCramHIZB41GnMB7VuK6FccrUpXoym0yW4oFnoJWwgc/60e33LTBLiwlHqfkJJLgALF4mG/ARlT6kFgkzj42fc2H/rwykZcvQzbR3H0XppxMPnONVrb12PtivRhK26ZGy3EeYsJo/E+EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SDZmri4L; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1fc491f9b55so10523515ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 10:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721238600; x=1721843400; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yv2W2PsgVycJ4qJVjXgYbXxGqQRou0OAMxJ2krhSKXI=;
        b=SDZmri4LTULxj4Lt+3kU/O45tttaM81m8Xc9TW/FgZE4vN4cH8bmjYA09PsWrvH8rG
         22g25TX3MCk5X9gvJdESss4cuWeosOXB0TCTtrD9+aRRqum/iwgWb2k2r5QZUgzlFjwA
         Xbqf4VYUU8jUvEf8Iy2YAASI5d6riZGANugRCEC5HbLp15FBcwetomenO5ioRW3itHGx
         UhO8+adzFURRIghBEoEitvAkuwdvrn+7wHT+Vk8mQDWW5Ni9tczB/+vsrPjaTmnhSWqm
         X7vNcQXRHSJbjrGgts+hh7nQV/SJU4OoH1U5/K/QTFtX3u/rkAqxoQFuX7E+rO5djZGL
         mFuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721238600; x=1721843400;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yv2W2PsgVycJ4qJVjXgYbXxGqQRou0OAMxJ2krhSKXI=;
        b=gVgN3NaFVE8oWzu4rYIy+7RNDwY8XmcdO8rhj850iB97/MdPVCNQpyUAyBK6xXfQit
         uAPPGKWPvDUROaLLuDmYZEyIqhFC+DIzG2cYjCVavTapxN1uZNtrajX0bstA3DN3cKxS
         3059DL8L9DE6y8c6C27JHdUb2XXvDIfLQGInDeM3jxfMbdT1d1F9yY6DqZ9MZsBWHQyP
         xvE4r7+FHlvN/1H/XhFE5M466L99DMFc9sUrG66yLPV+WanW5PgcvYidcar8C1tOg4gh
         PauE6tTLtwcgNMINbJx//0M98bhBwd/wP37iiEs3ips004ZQxkqLrB+OgLNL7d5r7VSX
         Zglg==
X-Forwarded-Encrypted: i=1; AJvYcCWLx0By8R4E6pNJnbwSzvC1i6PZyzi6zHOaOwKHLgxX083M6lO6e+8wJhn+ZN79J4ur3+4mIK9CpJGLrvnjtPpHk83gMsQpB0sLEjEu
X-Gm-Message-State: AOJu0Yyxc9mKzKmo7TwoK2eNaqXfAIci103zhjw36Gh6oNAVZv1zdtZT
	lIsqRX9SXibkDWqShKJiYf2e85oEpPxjehPEptoLqntpb0Aab78xkvdnvw==
X-Google-Smtp-Source: AGHT+IH+6X0aKtA5vUJlEhakPU2VynopJMbJp9b8iOXbRkSa9dZyI2XioGqLe1pLpLsxwpRlNRkF5Q==
X-Received: by 2002:a17:902:f68d:b0:1fc:4b33:2d24 with SMTP id d9443c01a7336-1fc4e68a8cdmr20765765ad.52.1721238599879;
        Wed, 17 Jul 2024 10:49:59 -0700 (PDT)
Received: from localhost (dhcp-141-239-149-160.hawaiiantel.net. [141.239.149.160])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fc0bc382dbsm77840155ad.197.2024.07.17.10.49.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 10:49:59 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 17 Jul 2024 07:49:58 -1000
From: Tejun Heo <tj@kernel.org>
To: "Zhangqiao (2012 lab)" <zhangqiao22@huawei.com>
Cc: void@manifault.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH sched_ext/for-6.11] sched_ext: Reverting @p->sched_class
 if @p->disallow is set
Message-ID: <ZpgERphu--gPn235@slm.duckdns.org>
References: <20240711110720.1285-1-zhangqiao22@huawei.com>
 <ZpArK0qxZZI-0ykt@slm.duckdns.org>
 <ba2702f9-f66e-498b-853c-d23f1f9191bc@huawei.com>
 <ZpbclgFjf_q6PSd1@slm.duckdns.org>
 <cd3fa16d-5a70-4c85-a591-fa4fa481f50b@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cd3fa16d-5a70-4c85-a591-fa4fa481f50b@huawei.com>

On Wed, Jul 17, 2024 at 10:01:13AM +0800, Zhangqiao (2012 lab) wrote:
> > Ah, I see what you mean. I was referring to the classs switching operations
> > in scx_ops_enable(). You're looking at the fork path. I don't think we can
> 
> Yes, i was referring to the fork path.
> 
> > switch sched_class at that point and the .disallow mechanism is there to
> > allow the scheduler to filter out tasks on scheduler start. I'll update the
> > code so that .disallow is only allowed during the initial attach.

So, something like this.

Thanks.

diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
index 593d2f4909dd..a4aa516cee7d 100644
--- a/include/linux/sched/ext.h
+++ b/include/linux/sched/ext.h
@@ -181,11 +181,12 @@ struct sched_ext_entity {
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
index da9cac6b6cc2..cf60474efa75 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -3399,18 +3399,17 @@ static int scx_ops_init_task(struct task_struct *p, struct task_group *tg, bool
 
 	scx_set_task_state(p, SCX_TASK_INIT);
 
-	if (p->scx.disallow) {
+	if (!fork && p->scx.disallow) {
 		struct rq *rq;
 		struct rq_flags rf;
 
 		rq = task_rq_lock(p, &rf);
 
 		/*
-		 * We're either in fork or load path and @p->policy will be
-		 * applied right after. Reverting @p->policy here and rejecting
-		 * %SCHED_EXT transitions from scx_check_setscheduler()
-		 * guarantees that if ops.init_task() sets @p->disallow, @p can
-		 * never be in SCX.
+		 * We're in the load path and @p->policy will be applied right
+		 * after. Reverting @p->policy here and rejecting %SCHED_EXT
+		 * transitions from scx_check_setscheduler() guarantees that if
+		 * ops.init_task() sets @p->disallow, @p can never be in SCX.
 		 */
 		if (p->policy == SCHED_EXT) {
 			p->policy = SCHED_NORMAL;
@@ -3418,6 +3417,9 @@ static int scx_ops_init_task(struct task_struct *p, struct task_group *tg, bool
 		}
 
 		task_rq_unlock(rq, p, &rf);
+	} else if (p->scx.disallow) {
+		scx_ops_error("ops.init_task() set task->scx.disallow for %s[%d] during fork",
+			      p->comm, p->pid);
 	}
 
 	p->scx.flags |= SCX_TASK_RESET_RUNNABLE_AT;

-- 
tejun

