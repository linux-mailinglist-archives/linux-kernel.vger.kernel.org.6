Return-Path: <linux-kernel+bounces-376905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F065F9AB741
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 21:58:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C5901C234E0
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 19:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D50C1CBE84;
	Tue, 22 Oct 2024 19:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iMuhhWjM"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4BA14A08E
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 19:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729627088; cv=none; b=SiQVWSmOCIxL/c+I+xM5Div7XhCvmo08H6l0qRF2l5lvWts5P6TB0tSxmxCQPtF5bQtnbDZwVqvpDdqmjZNCq0ck0QUcQzA7aVdYinN8dsUtz7HPx/wcHwcvExieNJUzMidV4cyfSg96k/SxH2hE82O8spElypcON+sou4BdcCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729627088; c=relaxed/simple;
	bh=kHNlif6cjYs9/oj4JCA1v8vIFas5umqpX2pekemr/X8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QIVlJK1karGBS3+bn5xqiFjqw+iPlLybxZyndQqYhv0aDykOoMbqk9rv/2d7lhwdn767o2dUWtTeNPTB1ae2w4kKLMVgI1m9Kkv4hyk2rjpH7dqlQnz5AvyIrbSdurpCCwL0Rk1F+kYgw258IuzhvBk8joLGf8pUeTX8fbPc43E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iMuhhWjM; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-71e4c2e36daso138386b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 12:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729627086; x=1730231886; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=W7d2e4WYCIynonTIH0zxJO0Lk6GPgFR5L+vX7RuRnGA=;
        b=iMuhhWjMLnphiieuwhWMijfv9AKVpcKuQjI/Z89DQik7YLuMsyyCJcnTSlxrU0uU4Z
         8qVRSeGX9W8s1ZYb4dhpKx0u1m3t+KkutKl76l7UglzsNO5mdV80hkm/W56ZMMrbkGsp
         bVtBViDHguQI6KqjtRmfVwFcS7JRhyAn96a7xklOgrya7UoQkYqcFtO+uWrkiRTqQoW8
         NlE3x8+gLAsP/De/SD8jFWJNHRh/ea7nlt31NlgAuV1qvfCn3tuB9/JnoDsIOJalNtQv
         gmzNNOykebacQuTD4J3VvsiG2PDxt6jKbDO8mhXeq0cPNgtW26PYRF1lUReT5CQ2U5zC
         B/xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729627087; x=1730231887;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W7d2e4WYCIynonTIH0zxJO0Lk6GPgFR5L+vX7RuRnGA=;
        b=cH089Oze70A2hf69VnbgF3PgD99ujJ77BCokigpCkpL10+aECF9zII9wjO1G5gA7cT
         R0ZRvpbqBubh1E00MOS9Bk5tYTc0AUT3F91XSWVPFjTe34G5ixaKl3WJcjlFh0HOthFP
         2luGPSZ3Sin3aB6fLckKAhRxjPAvFGzGkBAPDx8qPeMk2gvNQdBTjkNpsu99V6YRPYn+
         6qI7lQSqz16CQ8I6dOwSk+ukPtnJRGb3Y/GeYb4HCd7HT3yasHI2wRiX4s565D9dFkM+
         40w/rY5N/q4hjPugfJkD/9ocesqXPAx5Q47yevNLOL/uNJNBvU09YW9R8UR+60f0s4XQ
         M12A==
X-Forwarded-Encrypted: i=1; AJvYcCXGJ2ioBdu2bakHlXX/yJgzQ4jqsHeaBp5YI8mmwp/Fa+nXjt7MHJBgDXWL8PXaDDyvQRHwLqFg9TPNPU4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJQ3Za1sr2VWUFZZjtczRCt5DUQmIot1SFQaM4KaWydlByXMAy
	ZSwHt0xBAp5NHL+I2iv3ZXi4OmUk5ZRBpqOcflzXXaEdIZE0tqH1XnCpWgjlMbG0ki8NFwyuptl
	842KEmkZyIStNcQZofQ0dXV9U6j7zGqxlfEjuu17kjOql8O6wO6e1
X-Google-Smtp-Source: AGHT+IF9DMOq1XVKaG7eCM6jY5K4ny8vgDdDCrxWinu3p5N6fv4yUxKd1ZZ3CmvP/ZK4QISK3iFh6OwhNszwUCuwYFg=
X-Received: by 2002:a05:6a00:76a5:b0:71e:66e6:ca17 with SMTP id
 d2e1a72fcca58-71edc1dfedbmr5525106b3a.9.1729627086288; Tue, 22 Oct 2024
 12:58:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <66f6c7d4.050a0220.38ace9.0026.GAE@google.com> <CAG_fn=XExLPpgq73V-D_NL9Ebp9n965=PeaZPXwfqstN7DRoBQ@mail.gmail.com>
 <20241022113131.GD16066@noisy.programming.kicks-ass.net> <ZxerZIxg8kAMCvYc@elver.google.com>
 <20241022191244.GB9657@noisy.programming.kicks-ass.net>
In-Reply-To: <20241022191244.GB9657@noisy.programming.kicks-ass.net>
From: Marco Elver <elver@google.com>
Date: Tue, 22 Oct 2024 21:57:28 +0200
Message-ID: <CANpmjNMgjUi28BLk-uQQpqZ_RnB9sRtHpvymCPjpqrG=sQqGRA@mail.gmail.com>
Subject: Re: [syzbot] [kernel?] KCSAN: assert: race in dequeue_entities
To: Peter Zijlstra <peterz@infradead.org>
Cc: paulmck@kernel.org, Alexander Potapenko <glider@google.com>, 
	syzbot <syzbot+0ec1e96c2cdf5c0e512a@syzkaller.appspotmail.com>, 
	audit@vger.kernel.org, eparis@redhat.com, linux-kernel@vger.kernel.org, 
	paul@paul-moore.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 22 Oct 2024 at 21:12, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Oct 22, 2024 at 03:40:52PM +0200, Marco Elver wrote:
>
> > Which gives us:
> >
> >  | ==================================================================
> >  | BUG: KCSAN: assert: race in dequeue_entities / ttwu_do_activate
> >  |
> >  | write (marked) to 0xffff9e100329c628 of 4 bytes by interrupt on cpu 0:
> >  |  activate_task kernel/sched/core.c:2064 [inline]
> >
> > This is this one:
> >
> >       void activate_task(struct rq *rq, struct task_struct *p, int flags)
> >       {
> >               if (task_on_rq_migrating(p))
> >                       flags |= ENQUEUE_MIGRATED;
> >               if (flags & ENQUEUE_MIGRATED)
> >                       sched_mm_cid_migrate_to(rq, p);
> >
> >               enqueue_task(rq, p, flags);
> >
> >               WRITE_ONCE(p->on_rq, TASK_ON_RQ_QUEUED);
> >               ASSERT_EXCLUSIVE_WRITER(p->on_rq);
> >       }
> >
> >  |  ttwu_do_activate+0x153/0x3e0 kernel/sched/core.c:3671
> >  |  ttwu_queue kernel/sched/core.c:3944 [inline]
> >  |  try_to_wake_up+0x60f/0xaf0 kernel/sched/core.c:4270
>
> >  | assert no writes to 0xffff9e100329c628 of 4 bytes by task 10571 on cpu 3:
> >  |  __block_task kernel/sched/sched.h:2770 [inline]
> >
> > And that's:
> >
> >       static inline void __block_task(struct rq *rq, struct task_struct *p)
> >       {
> >               WRITE_ONCE(p->on_rq, 0);
> >               ASSERT_EXCLUSIVE_WRITER(p->on_rq);
> >               if (p->sched_contributes_to_load)
> >                       rq->nr_uninterruptible++;
> >
> >  |  dequeue_entities+0xd83/0xe70 kernel/sched/fair.c:7177
> >  |  pick_next_entity kernel/sched/fair.c:5627 [inline]
> >  |  pick_task_fair kernel/sched/fair.c:8856 [inline]
> >  |  pick_next_task_fair+0xaf/0x710 kernel/sched/fair.c:8876
> >  |  __pick_next_task kernel/sched/core.c:5955 [inline]
> >  |  pick_next_task kernel/sched/core.c:6477 [inline]
> >  |  __schedule+0x47a/0x1130 kernel/sched/core.c:6629
> >  |  __schedule_loop kernel/sched/core.c:6752 [inline]
> >  |  schedule+0x7b/0x130 kernel/sched/core.c:6767
>
>
> So KCSAn is trying to tell me these two paths run concurrently on the
> same 'p' ?!? That would be a horrible bug -- both these call chains
> should be holding rq->__lock (for task_rq(p)).

Yes correct.

And just to confirm this is no false positive, the way KCSAN works
_requires_ the race to actually happen before it reports anything;
this can also be seen in Alexander's report with just 1 stack trace
where it saw the value transition from 0 to 1 (TASK_ON_RQ_QUEUED) but
didn't know who did the write because kernel/sched was uninstrumented.

