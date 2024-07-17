Return-Path: <linux-kernel+bounces-255385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 34CE1934020
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 18:05:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8592DB220BC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 16:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2760A181BA2;
	Wed, 17 Jul 2024 16:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UU5SZjmq"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A241A1D69E
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 16:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721232293; cv=none; b=bzC0/ajWanvs1MESUzzJGth3+4Q2/MZg+scwHmQE1Cwq6MHG5vO6domwfFZYLVbOvKi+Ikc4oQ7ZsL/oqiILVoOscg7Iyed5CayrmVzKcFOd/8GqTgIUm4VN7NBE/nUm/793jp+xaEtFL/10kDjjJ/CHf39H7JFIu+BQAAeQnJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721232293; c=relaxed/simple;
	bh=AoAZcZDBufYR6+8XmPD3d85dxJzmXDI3rW9IHEM0hhM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CQdQz3hHtMemnGR2ZYUUzEM6igi9xdryVX6PvMU9soqeSbX5JHf056kHXeKY0Vm6JpwyQW0lVLEQ9OMhuwB1BPuu1DPBh8u7wcyOYmF9KuTG8AlffTOBAgJiQhoBgefkElSn+ADbxm4lL1W8+lXa7VQO0+0iLcQVXZsDf5LZF0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UU5SZjmq; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a77baa87743so749573266b.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 09:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721232289; x=1721837089; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XKIjwSAQrkgMVgtHKV1uhwl6zysvp7/fR9dohyVGsJc=;
        b=UU5SZjmqxuGffg/iAIvKWIXjPjv2y9wIbhoGB/OgJtOvWL0aVeMdYDV2DUkM4iLQPq
         4dYEVMVlRKPS69a80aZP3O/Xef450tZrcyUq7w/ZPsvRzU1VH5gJqCsB+scDoHAqimdS
         7ZlF0ZqY3G7Ge/esPnWGxHlGnkOmGFrc1FU9RwmEAGNU41mJhvSJAATjsWcRntIEUqkj
         A3hAfVxkRdj8oIvLitGYthwfyIgd48Zk97nJUNfursU8yhliLMRiBzhdK2uih0y+CQIQ
         aNFOa/Qmy1Rpi7kCFKC3unZsTl4BFGUuwUvig5dNv9xDv3WRyDxUBdPj/bd6LTreNOJ8
         +/HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721232289; x=1721837089;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XKIjwSAQrkgMVgtHKV1uhwl6zysvp7/fR9dohyVGsJc=;
        b=YgWrOOlRucobrSScKmudTeMooW4bDVXNrTso9LF1V97qhrhCLCEx0BW6JRDk9adtPF
         dSWxjkwm3cqHk0QT282Iy78hVij8/LKtNDW7TSTPYlK0cz9nApz8neJuFJUqHTJZV2Dy
         67g5KCrrWVjiAeZjNcG+dPNJP6UDVqbatUz6n5QWJ35i1lMog9/ozgHuqr0Q34HIjPIo
         n8IUh6Qz3js+sQegK7Zta+qkPXHiny19+0EUYixevwxT6zMY1TTQ4GcjZLJwj0m5Zj1a
         j7gFNq4O925B1SlKqf3K/ShO71A1FSQ/fgWv+3qSCtFebTkumD1arWfMrlgYNLFf/Uhr
         36BA==
X-Forwarded-Encrypted: i=1; AJvYcCWHAIxXNpCc8wJ4rQ6v51deMmsf035wDBP/eTplD83d9ANW/b1xl4nWfs54bX0CnTUGfxvqBEfZ9zMmQ/fZA54nhHa0giJ/LHzuboQS
X-Gm-Message-State: AOJu0YzzUC1DD22K9Fnd3oMMkzugLKR6Ki6Nn+xii6BpO0cdEvuNEdMG
	QZsyYIJ7NX/ipm+fkto+OoZWpsHO54JTDsLlELTqjgdhG9WjcC2HVAihpY/KTufURCzYmUuzx9Q
	lMQ2sQ2k7lHo3aIcXfMcHY8Twe1dJNroDlFb6
X-Google-Smtp-Source: AGHT+IE+KGZPn8v42uAvYqn/WiCl5jZpR4/bzecrp0HAsD5IbBc4tqOnEKm34cqpnXBi+3JZQ/CJ/A4sgAhzyL14cIU=
X-Received: by 2002:a17:906:718:b0:a6f:b885:2042 with SMTP id
 a640c23a62f3a-a7a011e5186mr164953166b.18.1721232288273; Wed, 17 Jul 2024
 09:04:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <171952310959.1810550.17003659816794335660.stgit@firesoul>
 <171952312320.1810550.13209360603489797077.stgit@firesoul>
 <4n3qu75efpznkomxytm7irwfiq44hhi4hb5igjbd55ooxgmvwa@tbgmwvcqsy75>
 <7ecdd625-37a0-49f1-92fc-eef9791fbe5b@kernel.org> <9a7930b9-dec0-418c-8475-5a7e18b3ec68@kernel.org>
 <CAJD7tkYX9OaAyWg=L_5v7GaKtKmptPpMGJh7Org5tcY4D-YnCw@mail.gmail.com> <e656b89a-1dcd-4fcc-811a-a7222232acc7@kernel.org>
In-Reply-To: <e656b89a-1dcd-4fcc-811a-a7222232acc7@kernel.org>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Wed, 17 Jul 2024 09:04:07 -0700
Message-ID: <CAJD7tkZg4N9k7dUnTSJ06fjPdB9Ei=6JDjHW5UU_J91euyboSw@mail.gmail.com>
Subject: Re: [PATCH V4 2/2] cgroup/rstat: Avoid thundering herd problem by
 kswapd across NUMA nodes
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: Shakeel Butt <shakeel.butt@linux.dev>, tj@kernel.org, cgroups@vger.kernel.org, 
	hannes@cmpxchg.org, lizefan.x@bytedance.com, longman@redhat.com, 
	kernel-team@cloudflare.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 17, 2024 at 12:46=E2=80=AFAM Jesper Dangaard Brouer <hawk@kerne=
l.org> wrote:
>
>
>
> On 16/07/2024 23.54, Yosry Ahmed wrote:
> > On Mon, Jul 8, 2024 at 8:26=E2=80=AFAM Jesper Dangaard Brouer <hawk@ker=
nel.org> wrote:
> >>
> >>
> >> On 28/06/2024 11.39, Jesper Dangaard Brouer wrote:
> >>>
> >>>
> >>> On 28/06/2024 01.34, Shakeel Butt wrote:
> >>>> On Thu, Jun 27, 2024 at 11:18:56PM GMT, Jesper Dangaard Brouer wrote=
:
> >>>>> Avoid lock contention on the global cgroup rstat lock caused by ksw=
apd
> >>>>> starting on all NUMA nodes simultaneously. At Cloudflare, we observ=
ed
> >>>>> massive issues due to kswapd and the specific mem_cgroup_flush_stat=
s()
> >>>>> call inlined in shrink_node, which takes the rstat lock.
> >>>>>
> >> [...]
> >>>>>    static void cgroup_base_stat_flush(struct cgroup *cgrp, int cpu)=
;
> >>>>> @@ -312,6 +315,45 @@ static inline void __cgroup_rstat_unlock(struc=
t
> >>>>> cgroup *cgrp, int cpu_in_loop)
> >>>>>        spin_unlock_irq(&cgroup_rstat_lock);
> >>>>>    }
> >>>>> +#define MAX_WAIT    msecs_to_jiffies(100)
> >>>>> +/* Trylock helper that also checks for on ongoing flusher */
> >>>>> +static bool cgroup_rstat_trylock_flusher(struct cgroup *cgrp)
> >>>>> +{
> >>>>> +    bool locked =3D __cgroup_rstat_trylock(cgrp, -1);
> >>>>> +    if (!locked) {
> >>>>> +        struct cgroup *cgrp_ongoing;
> >>>>> +
> >>>>> +        /* Lock is contended, lets check if ongoing flusher is alr=
eady
> >>>>> +         * taking care of this, if we are a descendant.
> >>>>> +         */
> >>>>> +        cgrp_ongoing =3D READ_ONCE(cgrp_rstat_ongoing_flusher);
> >>>>> +        if (cgrp_ongoing && cgroup_is_descendant(cgrp, cgrp_ongoin=
g)) {
> >>>>
> >>>> I wonder if READ_ONCE() and cgroup_is_descendant() needs to happen
> >>>> within in rcu section. On a preemptable kernel, let's say we got
> >>>> preempted in between them, the flusher was unrelated and got freed
> >>>> before we get the CPU. In that case we are accessing freed memory.
> >>>>
> >>>
> >>> I have to think about this some more.
> >>>
> >>
> >> I don't think this is necessary. We are now waiting (for completion) a=
nd
> >> not skipping flush, because as part of take down function
> >> cgroup_rstat_exit() is called, which will call cgroup_rstat_flush().
> >>
> >>
> >>    void cgroup_rstat_exit(struct cgroup *cgrp)
> >>    {
> >>          int cpu;
> >>          cgroup_rstat_flush(cgrp);
> >>
> >>
> >
> > Sorry for the late response, I was traveling for a bit. I will take a
> > look at your most recent version shortly. But I do have a comment
> > here.
> >
> > I don't see how this addresses Shakeel's concern. IIUC, if the cgroup
> > was freed after READ_ONCE() (and cgroup_rstat_flush() was called),
> > then cgroup_is_descendant() will access freed memory. We are not
> > holding the lock here so we are not preventing cgroup_rstat_flush()
> > from being called for the freed cgroup, right?
>
> If we go back to only allowing root-cgroup to be ongoing-flusher, then
> we could do a cgroup_rstat_flush(root) in cgroup_rstat_exit() to be sure
> nothing is left waiting for completion scheme. Right?

I am still not sure I understand how this helps.

We still need to call cgroup_is_descendant() because in cgroup v1 we
may have multiple root cgroups, right?

So it is still possible that the cgroup is freed after READ_ONCE() and
cgroup_is_descendant() accesses freed memory. Unless of course we have
other guarantees that the root cgroups will not go away.

Since at this point we are not holding the rstat lock, or actually
waiting for the ongoing flush (yet), I don't see how any
cgroup_rstat_flush() calls in the cgroup exit paths will help.

I actually think RCU may not help either for non-root cgroups, because
we call cgroup_rstat_flush() in cgroup_rstat_exit(), which is called
*after* the RCU grace period, and the cgroup is freed right away after
that. We may need to replace kfree(cgrp) with kfree_rcu(cgrp) in
css_free_rwork_fn().

>
> IMHO the code is getting too complicated with sub-cgroup's as ongoing
> flushers which also required having 'completion' queues per cgroup.
> We should go back to only doing this for the root-cgroup.

Because of multiple root cgroups in cgroup v1, we may still need that
anyway, right?

Please let me know if I am missing something.

