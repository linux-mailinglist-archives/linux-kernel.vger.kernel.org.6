Return-Path: <linux-kernel+bounces-201294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 185148FBCA4
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 21:35:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3D622841C3
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 19:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BC2514B094;
	Tue,  4 Jun 2024 19:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rd38HqNX"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8262C14AD38
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 19:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717529698; cv=none; b=Y7bZ04l2ehhatAO9FsBW9EfvrcAwSKdKftmZObXys3R5s3IsfgGTIcQ1yCy9tGcYMZQD0pwwcIF58P2b4TyDFNq8EVQ0Dz5hmNyfvO6vqUOH+fNV7nIYN9uwS92o0raWs6iBKP+3qC8D4IMpEc9BkHP8j6TxH39hkZ4io4bvUB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717529698; c=relaxed/simple;
	bh=0W6BkEPKkqDB7OjeXyv6kHnRSVj9md0RBv7x9no+QPg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MqB0jFah3SNaJL5QkZ61vV94uLt+ZE5vwtfvjJDQNHa8ISrsh4CDZbBMMEOCOV6donZ7TbVRyhe744lt61Mglqc+e9tPkVYODupHQLnsnBRHzbBOeMPyoTh17KWTR/ojynT5qw62molyVXPqhJYMUJ2G7pW3f5PJmWs6OuWjsCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rd38HqNX; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4213a2acc59so20245e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 12:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717529695; x=1718134495; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3J17X2p+cnWasKVfDXxTGf9lXe/9qGyWsLMV1FlmzFk=;
        b=rd38HqNXA1sWfeszewH7ytx/TYxyDb/urvjDRQTtjCBMXQ6CNoLRVbITOrNmRJNPYL
         ttlVhwZHXWohq43xKrguHtsrwJxJ8FfUGoOY2jcOVo+sPb0mK0WyMkYGraeBHw/kGSsk
         eWT34910ii+oyB3ET03cKgAqlYWXnuV6S+LMsxN51uGII7662M4vsGQR1IIrItqc93Zm
         JXR9gP50fLMGGyRj10RznrLUIc/rJds/xmfF1zjWBzR8drN+kQNYOtZuDgekmEra732y
         0rUzyZAzsbQ026B2ZEQWfJXXPmEpMcQdm1gU+7bsFFxcKjb2EXPNsmrq9vF1eFQ7Un8c
         gfdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717529695; x=1718134495;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3J17X2p+cnWasKVfDXxTGf9lXe/9qGyWsLMV1FlmzFk=;
        b=f+FlbHGSf0PpVLOTcGPyhNiXvpCH0UxAExLi3QxmgxQGLlY/uAnxnIBHkeSgSJV4pQ
         OOeOGtSPqG1mDdc/tcVRWErYqBczP3Nc8Lo6cMfhqAd8aB/UMlRY6LYK2m0d8YyyBoP0
         LrYGwVZmM5OkOW5Y6BYkPpmLcM9bdcGIEGC1rSJjOOEa54JjSVgudf4R3mKxd/mhf96o
         htI/uRZA4klNCgJVjAPyIWhu4psX6TM6F8Hs4cEf8yUa3JwfUZeOHxz29ygit52GBZQe
         mfeCVobFhB2WxT6AbHASwcHugczOJBO+PLqWn7WJ/XROnU/EAeOo0jyPnTO3gWKERkwu
         ZOmw==
X-Gm-Message-State: AOJu0YygibmMNGpmpPNNv48OqEEl6YHzkCOM4UNTSw25XOt8nxmVvMN1
	tNqy9pvxSsFZOyA0W3A3O3f6lKbpsIuVQCwD7kx2tUMutI2yDIVbgG8+xeOMbs92pZ6vnKDdczk
	D3Xojeu3kbeghvjpHIVJ12pPrVJ3laoTU6/g=
X-Google-Smtp-Source: AGHT+IHZefxJIph7/nZlCQTE+auVhX0kgFRSYQ1cViAchAhW9i9xDwrbT21RvmDi7CecHiftRUxHIiOBXnNp9Gj/3Q0=
X-Received: by 2002:a1c:7719:0:b0:41b:8715:1158 with SMTP id
 5b1f17b1804b1-42157050fd1mr362075e9.6.1717529693994; Tue, 04 Jun 2024
 12:34:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240507045450.895430-1-jstultz@google.com> <20240507045450.895430-7-jstultz@google.com>
 <20240604132910.25pgz3mjrnnwitve@airbuntu>
In-Reply-To: <20240604132910.25pgz3mjrnnwitve@airbuntu>
From: John Stultz <jstultz@google.com>
Date: Tue, 4 Jun 2024 12:34:42 -0700
Message-ID: <CANDhNCqrPCnNP75_MVA-+B22hrEnc=rwNb+SGdvg61NqedcU2w@mail.gmail.com>
Subject: Re: [PATCH v10 6/7] sched: Split out __schedule() deactivate task
 logic into a helper
To: Qais Yousef <qyousef@layalina.io>
Cc: LKML <linux-kernel@vger.kernel.org>, Joel Fernandes <joelaf@google.com>, 
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Valentin Schneider <vschneid@redhat.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, 
	Zimuzo Ezeozue <zezeozue@google.com>, Youssef Esmat <youssefesmat@google.com>, 
	Mel Gorman <mgorman@suse.de>, Daniel Bristot de Oliveira <bristot@redhat.com>, Will Deacon <will@kernel.org>, 
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Metin Kaya <Metin.Kaya@arm.com>, 
	Xuewen Yan <xuewen.yan94@gmail.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Thomas Gleixner <tglx@linutronix.de>, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 4, 2024 at 6:29=E2=80=AFAM Qais Yousef <qyousef@layalina.io> wr=
ote:
>
> On 05/06/24 21:54, John Stultz wrote:
> > As we're going to re-use the deactivation logic,
> > split it into a helper.
> >
> > Cc: Joel Fernandes <joelaf@google.com>
> > Cc: Qais Yousef <qyousef@layalina.io>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Juri Lelli <juri.lelli@redhat.com>
> > Cc: Vincent Guittot <vincent.guittot@linaro.org>
> > Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> > Cc: Valentin Schneider <vschneid@redhat.com>
> > Cc: Steven Rostedt <rostedt@goodmis.org>
> > Cc: Ben Segall <bsegall@google.com>
> > Cc: Zimuzo Ezeozue <zezeozue@google.com>
> > Cc: Youssef Esmat <youssefesmat@google.com>
> > Cc: Mel Gorman <mgorman@suse.de>
> > Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
> > Cc: Will Deacon <will@kernel.org>
> > Cc: Waiman Long <longman@redhat.com>
> > Cc: Boqun Feng <boqun.feng@gmail.com>
> > Cc: "Paul E. McKenney" <paulmck@kernel.org>
> > Cc: Metin Kaya <Metin.Kaya@arm.com>
> > Cc: Xuewen Yan <xuewen.yan94@gmail.com>
> > Cc: K Prateek Nayak <kprateek.nayak@amd.com>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: kernel-team@android.com
> > Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
> > Tested-by: Metin Kaya <metin.kaya@arm.com>
> > Reviewed-by: Metin Kaya <metin.kaya@arm.com>
> > Signed-off-by: John Stultz <jstultz@google.com>
> > ---
> > v6:
> > * Define function as static to avoid "no previous prototype"
> >   warnings as Reported-by: kernel test robot <lkp@intel.com>
> > v7:
> > * Rename state task_state to be more clear, as suggested by
> >   Metin Kaya
> > ---
> >  kernel/sched/core.c | 72 +++++++++++++++++++++++++++------------------
> >  1 file changed, 43 insertions(+), 29 deletions(-)
> >
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index 48f0d4b381d5..8bc5844ebab9 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -6572,6 +6572,48 @@ pick_next_task(struct rq *rq, struct task_struct=
 *prev, struct rq_flags *rf)
> >  # define SM_MASK_PREEMPT     SM_PREEMPT
> >  #endif
> >
> > +/*
> > + * Helper function for __schedule()
> > + *
> > + * If a task does not have signals pending, deactivate it and return t=
rue
> > + * Otherwise marks the task's __state as RUNNING and returns false
> > + */
> > +static bool try_to_deactivate_task(struct rq *rq, struct task_struct *=
p,
> > +                                unsigned long task_state)
> > +{
> > +     if (signal_pending_state(task_state, p)) {
> > +             WRITE_ONCE(p->__state, TASK_RUNNING);
>
> We can avoid extra indention for the other (lengthy) leg if we return her=
e?
>
> The return value is ignored for now, I don't mind keeping it but better c=
all it
> out in the commit message or when you add the new user later you can upda=
te the
> signature more easily.

Ah. Good point on both counts here. I've reworked it to use your
suggestions here.

> Generally I think patches 4, 5 and 6 could be sent as their own series wi=
th
> minor commit messages tweaks to make them more independent and I hope Ing=
o and
> Peter are okay to pick them up as they look a nice clean up in general.
>
> Anyway:
>
> Reviewed-by: Qais Yousef <qyousef@layalina.io>

Thanks so much for the review!
-john

