Return-Path: <linux-kernel+bounces-418579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E5799D632F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 18:33:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D0B42825BA
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 17:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF5191DEFFC;
	Fri, 22 Nov 2024 17:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="gag+zZQK"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9B0148FE8
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 17:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732296826; cv=none; b=qkwzM0VYMLSa/B8nYF5kOstOjeGUX77QoLtCBpoMiWXet0k8/NOt6VqJZaryjivFvzC7ylwB0sVn/staZUvpts78Stra7BuSle94d8D2dx/FbBRmNlPuUq6v+OSKnhlC/m5ZZUB3gkrnqQEskh9LYTG5m+wqQSHsoUk4CdePQck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732296826; c=relaxed/simple;
	bh=hJgfwHn/pGPnOwbXVXypFdwAMvKrXZT6qGDoUkHGv5g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dnaaBnTGxiiKn8e0V4Fo7eMFM0rgT0Kj/EaBkFyCgWAHFYeDJB64rYM/zXxrD+c3iCxS9wMT1HFhZmMrGuL2YeCvnUImBM2GCkoj5kK+NUpRv+3TD+Hxvs2OzAttXe1IfVDorYJLc0hINC9xjRujlq8NOzrVn72a169SQusMJqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=gag+zZQK; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-539f2b95775so3575280e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 09:33:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1732296822; x=1732901622; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hJgfwHn/pGPnOwbXVXypFdwAMvKrXZT6qGDoUkHGv5g=;
        b=gag+zZQK/Np9jmaVUx/qi47ROz/ZURIABLsO0QdLU4uwwnQrZhkr59aHxRJx9NjuU9
         lkCsa5aLfSONCWAz/fghiE3vkIlHBi1GtqYvfd1axbKin5TGrxBonlkzl7YyU6sIOAuo
         Kqepijt2MYCcVUFLteuAVEkvxGFtlKLLZa+PZjkxto1taS88JiF6rb+OxHF+9F540k4h
         rZxfNGJHkXhSPlFLcZ/AXG8fmrXheavf+kg3mREQnxVqkIPg+Hfyjuw93X88Lv4aAEPI
         2z0O2nbvPvCP1gHdn8CO8gwe8ScLfn37xToztGezBYkngg2l7LHOdkyWicDCvVolG5gj
         uPkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732296822; x=1732901622;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hJgfwHn/pGPnOwbXVXypFdwAMvKrXZT6qGDoUkHGv5g=;
        b=SO2gDjRR1W8p/xxbSkcpZKnM2goPwYPdFtxiJSGs6tQlq77BpYLDJzNmucQhkN62Nu
         EdLuPQ1BKOavXsTuZuKj1iTmp6YbMYMCmptgO3Pg4z7oNOmqnNyPSkTsB+tVgO/QVJrW
         Ix30z/3IRtuIPHqMBA7kT4SHNn3yDWPI2ZqUZmAjU2ML/vbeBVEO3+PjO8AfG1/h0Hht
         Hy0COVLPpDE6Ea7u3ZsRkl3fgSaaZErLcvhaOGkm0ZiUFmkpuzi+KkpObHQj3q/t1wsu
         ONq8LryiRRKGk5+SRWTEfM5GviG3fPRPOkP8OTtqYKtUUrWVjQFxBz74BJYCfQ7fg3Qk
         UFKg==
X-Forwarded-Encrypted: i=1; AJvYcCVX8px39bbkCu0z9V9PsOwCVqwWqtLzNAFrq3fPhkVipdd8oBypG8BvfnjFyNsi9InASOzo4pArqLHrYVM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLimWkMaCDIf1m8ktVk67HYLjcEl7txOL39kntlq9XGbJARgQA
	/1gTzfxNMk5vXPriyNsR7Mf5oaLFU5PP/xDNvT7jvpXvDrj8oS24xUvS1vGO4ZF2Y3U2g2nB2Wz
	7Kzz30E7W4qZFHsF2x6LCvVJOQFT4iLuJCwNd1yVCKHLcR+ZVTypY0Q==
X-Gm-Gg: ASbGncuGoteTQB8OH7xiKncEJhcQdu31Sc71cE3HzCZ1sXqmlUZoBx1gvGrGGrmOXcB
	5qI99Voz4DMkcKGZECOAOEFyWtTsBjw==
X-Google-Smtp-Source: AGHT+IERUtE7r6Bqkcln60OV9pXaIcD3cIqRGQlmhEr1EVe+nHDe5RTS7QaE3mWvb7ATZjzgv551surinvh9uqnPb4Q=
X-Received: by 2002:a05:6512:230b:b0:539:f10b:ff97 with SMTP id
 2adb3069b0e04-53dd39b4c39mr2976675e87.49.1732296821897; Fri, 22 Nov 2024
 09:33:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241122152856.3533625-1-neelx@suse.com> <20241122154253.GZ24774@noisy.programming.kicks-ass.net>
In-Reply-To: <20241122154253.GZ24774@noisy.programming.kicks-ass.net>
From: Daniel Vacek <neelx@suse.com>
Date: Fri, 22 Nov 2024 18:33:31 +0100
Message-ID: <CAPjX3FfDTdUvMCDJCP8tAeNeaYSWj9mSsrMmE=VP0kWAdJTSVQ@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: properly serialize the cfs_rq h_load calculation
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 22, 2024 at 4:42=E2=80=AFPM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Fri, Nov 22, 2024 at 04:28:55PM +0100, Daniel Vacek wrote:
> > Make sure the given cfs_rq's h_load is always correctly updated. This
> > prevents a race between more CPUs eventually updating the same hierarch=
y
> > of h_load_next return pointers.
>
> Is there an actual problem observed?

Well, that depends. Do we care about correct (exact) load calculation
every time?
If it's not a big deal we may just drop this patch.
I am not sure what (if any real) problems this can cause. I did not
observe any I'm aware of. Actually I should have labeled this [RFC],
but I forgot :-/

This is being called from `try_to_wake_up` =3D> `select_task_rq_fair`.
If two (or more) CPUs race to wake up =3D> `task_h_load()` *different*
tasks on the same rq (I mean the same target CPU), they may get a
wrong result if the tasks are in different cgroups. Well, wrong in a
sense the `cfs_rq->h_load` may not be up to date and the old, former
value is used for all but one of the racing cgroups (cfs_rqs).

I could detect the race collisions almost every minute on my lightly
loaded laptop (using bpftrace which admittedly opened the window a
bit, but for sure it can happen). Though I am not sure if it's a big
deal?
The `cfs_rq->h_load` will get updated the next time when the race does
not happen again. So very likely right the next time.
And we may be pretty fine eventually using the old value from time to
time. The question is are we fine with that or are we not? I guess we
are and this patch can be dropped, right?

It almost looks like the function is specifically designed this way as
we really do not care about unlikely failures because the worst can
happen is a bit older value is kept in `h_load`. It may not be even
that different to the correct value I guess and it will (most)
definitely get fixed/updated the next time.

If that is really the intention of the current design, let's just drop
this patch.

I understand that this is adding another lock into the scheduler which
is always to be well considered. But on the other hand the race is
limited to once per jiffy for a given CPU otherwise the condition
bails out early. By the nature of this race the contention should be
unlikely most of the time. With that respect I was considering just
using the rq lock, but using a dedicated one actually looked simpler
to me after all. Also the scope of the lock is clear this way. It
serves only this one purpose. Which we may not need or do not care
about after all.

Hence I'm wondering what is your opinion with regards to this?
Would we benefit from guaranteed correct calculation every time in
exchange for a little overhead?
Perhaps, can you suggest a stress test or benchmark or any workload
which heavily exercises task wake ups so that I can try to quantify
the added overhead?

--nX

