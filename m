Return-Path: <linux-kernel+bounces-366650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DBEE99F843
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 22:46:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 612691C22662
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 20:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B9EF1F81BC;
	Tue, 15 Oct 2024 20:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RxzU04ba"
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495AE1F80DD
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 20:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729025189; cv=none; b=XBLXTNbDZfzusx0unv3BNE+jVA5wf+qKhEHe63Aiv+fLo4oGsn/hm6xBruxKQosBIygzo2l2eOwiTU92hTmhiuZRDf9svyMlG+SQausM6aeQsKyzceIi1Ln6IZd0zlg3VWYPPWz/v30A0rnkruYlIkFt2m4jwwQOr5vJtvIaiwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729025189; c=relaxed/simple;
	bh=AqUdafXKTY6DDHGLzTGsizAxqmBoMgpVRl5AemWKIAg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cgrBDmxEGgerR7AxxXq5L/iE4mqiYXex604DoV3Q0K4hs8BN2rvlP9YCEdyOl16hikgdSIrOEIXEcOn3g2a285AqQyv6EbWhKHsl/hTEP1Fmqp7rLRAhJS+TapDycj4Wswt+0lqrJ5JTp1IWHUhzn/c3NHstZFsKCUAAN94xVhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RxzU04ba; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4601a471aecso868441cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 13:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729025187; x=1729629987; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hADrE+uGTtibEvTH0s90QZJmBdYKfXijYp7a8XNC0gY=;
        b=RxzU04ba3Lmk/Zs/I/wzKrca5WFbJKJ2Hg4RoTg7X3ZxloAxbQzFUXW7lOLxyUKsUC
         p3hGA/7vnFbiqrsbKh/5lNmbgijeEopsGaHaG1SEcgeHv5eNHdAk6J+4+BVhcg97dMMU
         cFurJp1CyFP/N0al4tmw3PPuqtaO5C24Ehgf/I1w6Bod+Jqmfc5H/Uvg2pVOE5RwoZF9
         UfkSfiEt0Vlt2PgAc0O+qhfJhZSbW6u/4WYRNdBvFgjMVFv7Dn4l8cTiQoMaUI9nR8hV
         lu1BMTBrgbK82iuUCPE1lSlg1hFCCuqtugju4CmEvTTM4+93wYL6A+UrqtxBwqkEZKDT
         yH8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729025187; x=1729629987;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hADrE+uGTtibEvTH0s90QZJmBdYKfXijYp7a8XNC0gY=;
        b=JPj/u1i20s0s77Kfk0ZKAvyNTTuAyWK6sb8uMd2LbLMzlri0pqgH8MgHoALX52nw1v
         78rWxdXvAasftC3iwtvS236OAJaAs8CuPqFSEHu8ENCgJ1p3aKa4reb95YZNkUG2ALYM
         Hc0yX95b237JMa6xs+JiMnKdklw/OduJOw1Tpb0zl5Pd3DPwyTUDdkvX/p1KAayRVdAV
         DQ/TobJLkZo7F0LP32lKpVmG+e7tDtLpQmbkohckRyp9JOuhO2KRsU+QK9Bc1ntdofju
         tWTdpCrVFRUxkdnUlx4HXpFV7eDi+DvKc2lBEG4xpV/SQkIwFZYfDucVQKRe20ditpxO
         fYlA==
X-Forwarded-Encrypted: i=1; AJvYcCW+eLYlfe2cbg3ylOiEPrsOWTQxOKPi/L+ybPiNpbvSpFKSO0IZUVbUKWqruvU5STn3z/m6LgN1xdKSgzs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/UYTRsx7BsUNR8OB2dOnSpFKGq5hVOKCosN6NRWsPWYQ5R6MM
	2IHK7wEt9HFiWXD9Gf86CeZRwXYcSS885/UFGRhnIC0dAk2y2Q8ZZg7Wj7uMjA==
X-Google-Smtp-Source: AGHT+IETthPrudZ1fSdhkTk5TGYZfzkYyH24kZnnVgT0XIy0sRJSH6T8V1s8YXXPWc2XhTzfDsBVJA==
X-Received: by 2002:a05:622a:47cd:b0:453:5b5a:e77c with SMTP id d75a77b69052e-4608db32e70mr907251cf.10.1729025186861;
        Tue, 15 Oct 2024 13:46:26 -0700 (PDT)
Received: from google.com (131.65.194.35.bc.googleusercontent.com. [35.194.65.131])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b1363c9d24sm108524485a.133.2024.10.15.13.46.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 13:46:26 -0700 (PDT)
Date: Tue, 15 Oct 2024 16:46:23 -0400
From: Brian Geffon <bgeffon@google.com>
To: brauner@kernel.org
Cc: bristot@redhat.com, bsegall@google.com, cmllamas@google.com,
	dietmar.eggemann@arm.com, ebiggers@kernel.org, jack@suse.cz,
	jing.xia@unisoc.com, juri.lelli@redhat.com, ke.wang@unisoc.com,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	mgorman@suse.de, mingo@redhat.com, peterz@infradead.org,
	rostedt@goodmis.org, vincent.guittot@linaro.org,
	viro@zeniv.linux.org.uk, vschneid@redhat.com,
	xuewen.yan94@gmail.com, xuewen.yan@unisoc.com,
	Benoit Lize <lizeb@google.com>
Subject: Re: [RFC PATCH] epoll: Add synchronous wakeup support for
 ep_poll_callback
Message-ID: <Zw7Un-Cr8JA4oMv0@google.com>
References: <20240426-zupfen-jahrzehnt-5be786bcdf04@brauner>
 <20240919123635.2472105-1-bgeffon@google.com>
 <CADyq12w2KRUZCu0hLA8TJH-e+766Jq_vG9SDYtDBYXzR=r9wvg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADyq12w2KRUZCu0hLA8TJH-e+766Jq_vG9SDYtDBYXzR=r9wvg@mail.gmail.com>

On Wed, Sep 25, 2024 at 02:38:02PM -0400, Brian Geffon wrote:
> I think this patch really needs help with the commit message, something like:
> 
> wait_queue_func_t accepts 4 arguments (struct wait_queue_entry
> *wq_entry, unsigned mode, int flags, void *key);
> 
> In the case of poll and select the wait queue function is pollwake in
> fs/select.c, this wake function passes
> the third argument flags as the sync parameter to the
> default_wake_function defined in kernel/sched/core.c. This
> argument is passed along to try_to_wake_up which continues to pass
> down the wake flags to select_task_rq and finally
> in the case of CFS select_task_rq_fair. In select_task_rq_fair the
> sync flag is passed down to the wake_affine_* functions
> in kernel/sched/fair.c which accept and honor the sync flag.
> 
> Epoll however when reciving the WF_SYNC flag completely drops it on
> the floor, the wakeup function used
> by epoll is defined in fs/eventpoll.c, ep_poll_callback. This callback
> receives a sync flag just like pollwake;
> however, it never does anything with it. Ultimately it wakes up the
> waiting task directly using wake_up.
> 
> This shows that there seems to be a divergence between poll/select and
> epoll regarding honoring sync wakeups.
> 
> I have tested this patch through self tests and numerous runs of the
> perf benchmarks for epoll. All tests past and
> I did not see any observable performance changes in epoll_wait.
> 
> Reviewed-by: Brian Geffon <bgeffon@google.com>
> Tested-by: Brian Geffon <bgeffon@google.com>
> Reported-by: Benoit Lize <lizeb@google.com>

Friendly ping on this. Would someone mind taking a look and picking this
up?

> 
> 
> On Thu, Sep 19, 2024 at 8:36 AM Brian Geffon <bgeffon@google.com> wrote:
> >
> > We've also observed this issue on ChromeOS, it seems like it might long-standing epoll bug as it diverges from the behavior of poll. Any chance a maintainer can take a look?
> >
> > Thanks
> > Brian
> >
> > On Fri, Apr 26, 2024 at 04:05:48PM +0800, Xuewen Yan wrote:
> > > Now, the epoll only use wake_up() interface to wake up task.
> > > However, sometimes, there are epoll users which want to use
> > > the synchronous wakeup flag to hint the scheduler, such as
> > > Android binder driver.
> > > So add a wake_up_sync() define, and use the wake_up_sync()
> > > when the sync is true in ep_poll_callback().
> > >
> > > Co-developed-by: Jing Xia <jing.xia@unisoc.com>
> > > Signed-off-by: Jing Xia <jing.xia@unisoc.com>
> > > Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
> > > ---
> > >  fs/eventpoll.c       | 5 ++++-
> > >  include/linux/wait.h | 1 +
> > >  2 files changed, 5 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/fs/eventpoll.c b/fs/eventpoll.c
> > > index 882b89edc52a..9b815e0a1ac5 100644
> > > --- a/fs/eventpoll.c
> > > +++ b/fs/eventpoll.c
> > > @@ -1336,7 +1336,10 @@ static int ep_poll_callback(wait_queue_entry_t *wait, unsigned mode, int sync, v
> > >                               break;
> > >                       }
> > >               }
> > > -             wake_up(&ep->wq);
> > > +             if (sync)
> > > +                     wake_up_sync(&ep->wq);
> > > +             else
> > > +                     wake_up(&ep->wq);
> > >       }
> > >       if (waitqueue_active(&ep->poll_wait))
> > >               pwake++;
> > > diff --git a/include/linux/wait.h b/include/linux/wait.h
> > > index 8aa3372f21a0..2b322a9b88a2 100644
> > > --- a/include/linux/wait.h
> > > +++ b/include/linux/wait.h
> > > @@ -221,6 +221,7 @@ void __wake_up_pollfree(struct wait_queue_head *wq_head);
> > >  #define wake_up_all(x)                       __wake_up(x, TASK_NORMAL, 0, NULL)
> > >  #define wake_up_locked(x)            __wake_up_locked((x), TASK_NORMAL, 1)
> > >  #define wake_up_all_locked(x)                __wake_up_locked((x), TASK_NORMAL, 0)
> > > +#define wake_up_sync(x)                      __wake_up_sync(x, TASK_NORMAL)
> > >
> > >  #define wake_up_interruptible(x)     __wake_up(x, TASK_INTERRUPTIBLE, 1, NULL)
> > >  #define wake_up_interruptible_nr(x, nr)      __wake_up(x, TASK_INTERRUPTIBLE, nr, NULL)
> > > --
> > > 2.25.1
> > >
> >

