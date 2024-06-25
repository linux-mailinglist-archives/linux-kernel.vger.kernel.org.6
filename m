Return-Path: <linux-kernel+bounces-229734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B692191735E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 23:25:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C1F3281E63
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 21:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E54C17E46D;
	Tue, 25 Jun 2024 21:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VuZaEtj5"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A872D176252
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 21:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719350717; cv=none; b=KnPqeLgjjijQzf1l7fU5skDLBXgKwG/LypEhyRf3uGf6j8ru3WoY8I15Ir1/CS+QyKobS+bS9JqlVi2oA3egZQjGRv+YyLwzptj3dghBI/q4TU3QeeekkMEXGhtKELzZaBzmOc3VZyqGdyeSzW2HIbWkdHz0y2h8/Qo0Q+lF/7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719350717; c=relaxed/simple;
	bh=r2nKpI1QhRDiz0AIUr6dLuT5KkDGFiB0nn/OHOxptIg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mkelri10TTQsuhwWyUSpOAhY9QScMjxHiualYrB026M7FvEgBKy8eMK5MPV8USHvlKA4fYC7sIFgZxDT+FxUuc7MZYb1RxCgFh1nPALPX0iwOs0jp4Y2WRVROXnaWNmAdCRyxU2LPlAGCxprCjlEu3DmBspNPhyUXNWEzJGmJoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VuZaEtj5; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a6fe617966fso361222266b.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 14:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719350714; x=1719955514; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r2nKpI1QhRDiz0AIUr6dLuT5KkDGFiB0nn/OHOxptIg=;
        b=VuZaEtj5rfgztSxFp4VLSq2mADreuZPglhY3IxFBidggghNXJZ6qG8nMfpH84AGKEU
         2pS9hZ5VDbJgaRbJsJ5O4a7Wjl07wDhKFTJ8zyIUET29jfZJOdRL9J5LxVdUEiz2UNkl
         /wXqtq5QEuez9ASvfmrRqQrms8P3zYeUiL+6NLA3zKT+CkdppZ2Nlw/qxwbWlwnBqCtN
         +nZQ57dmIUKmzbi0NBQ0VIWCpntBSrkZEx9JX/1WQ9kFcXqDboVVeaPNVJbPxZUQtl53
         qVXjK7gWr3+UKRns4KlXjS7zQDzB56ntIX4rsk/34gXC5YXVwePgokZcj+dzZQz4DnZg
         rBnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719350714; x=1719955514;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r2nKpI1QhRDiz0AIUr6dLuT5KkDGFiB0nn/OHOxptIg=;
        b=edt/QHaQjkbNOnApD9c5icuIqRr/AGxRQxNFAIziqJ9YzU3lv+V1R0uGwlOYVYV0Wu
         3mzOyGwIarPgHMaqyOLWPT2dGFGvFh6WpP1qlD1y03TLvve9SvN0gzMz7yyJDYj/PNdu
         XagkOkyqFEySUobbfM1yVRrS4co3HKsHg5OvnzDRDLLy/JfUEH3psVpUiAP4x1Lf3JZM
         UTHFyVcV0aUdNZIIzmopuQ66ywsahM47ITHMy0HDSYiRNbUtvj453xAkbkLlkf5n1y70
         byuVlx5ilXE3PSxQj78o4fRyX1+olP38ZbhaLleE0zSI9ZGMZu1IuxEGNl0U6BazBk6F
         ajpw==
X-Forwarded-Encrypted: i=1; AJvYcCXPEtgzqAvNbV4tntrnGhdqUU8jt5IBxhFckD4KGX5hP6WbuFgYcrMIdbgHh4Og+Q7hL2euzlr4Vu1bu9tbM/BQoYtdX7IWOp+6z0tY
X-Gm-Message-State: AOJu0YwIGJIIg+omGdqVScRTVSftxoz9SgPCd6kj1ivJiDklQDWtVKOT
	8LBBkBfvno9Hy17o90DNhIWCtdACRwe24bniH92gWQHkAXYlwsWiSrBkV+q3myamBtAiZh32TO6
	80kkKQW3PJ5QtWf7ny7anDhNVplmhjgDQnmp9
X-Google-Smtp-Source: AGHT+IEH5SQT0BSWNwtzH1MmW/zob6h/XOBPfp32D/tXHtok0ERfuzb089Zk4lxI9x0o5cEi2GptQc64uRehiKZE0Os=
X-Received: by 2002:a17:907:a60c:b0:a6f:e111:a152 with SMTP id
 a640c23a62f3a-a7245c48345mr567878466b.62.1719350713495; Tue, 25 Jun 2024
 14:25:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a45ggqu6jcve44y7ha6m6cr3pcjc3xgyomu4ml6jbsq3zv7tte@oeovgtwh6ytg>
 <CAJD7tkZT_2tyOFq5koK0djMXj4tY8BO3CtSamPb85p=iiXCgXQ@mail.gmail.com>
 <qolg56e7mjloynou6j7ar7xzefqojp4cagzkb3r6duoj5i54vu@jqhi2chs4ecj>
 <CAJD7tka0b52zm=SjqxO-gxc0XTib=81c7nMx9MFNttwVkCVmSg@mail.gmail.com>
 <u3jrec5n42v35f3xiigfqabajjt4onh44eyfajewnzbfqxaekw@5x2daobkkbxh>
 <CAJD7tkaMeevj2TS_aRj_WXVi26CuuBrprYwUfQmszJnwqqJrHw@mail.gmail.com>
 <d3b5f10a-2649-446c-a6f9-9311f96e7569@kernel.org> <CAJD7tkZ0ReOjoioACyxQ848qNMh6a93hH616jNPgX3j72thrLg@mail.gmail.com>
 <zo6shlmgicfgqdjlfbeylpdrckpaqle7gk6ksdik7kqq7axgl6@65q4m73tgnp3>
 <CAJD7tkZ_aba9N9Qe8WeaLcp_ON_jQvuP9dg4tW0919QbCLLTMA@mail.gmail.com> <ntpnm3kdpqexncc4hz4xmfliay3tmbasxl6zatmsauo3sruwf3@zcmgz7oq5huy>
In-Reply-To: <ntpnm3kdpqexncc4hz4xmfliay3tmbasxl6zatmsauo3sruwf3@zcmgz7oq5huy>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Tue, 25 Jun 2024 14:24:35 -0700
Message-ID: <CAJD7tkYqF0pmnw+PqmzPGh7NLeM2KfCwKLMhkFw3sxBOZ3biAA@mail.gmail.com>
Subject: Re: [PATCH V2] cgroup/rstat: Avoid thundering herd problem by kswapd
 across NUMA nodes
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, tj@kernel.org, cgroups@vger.kernel.org, 
	hannes@cmpxchg.org, lizefan.x@bytedance.com, longman@redhat.com, 
	kernel-team@cloudflare.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 25, 2024 at 2:20=E2=80=AFPM Shakeel Butt <shakeel.butt@linux.de=
v> wrote:
>
> On Tue, Jun 25, 2024 at 01:45:00PM GMT, Yosry Ahmed wrote:
> > On Tue, Jun 25, 2024 at 9:21=E2=80=AFAM Shakeel Butt <shakeel.butt@linu=
x.dev> wrote:
> > >
> > > On Tue, Jun 25, 2024 at 09:00:03AM GMT, Yosry Ahmed wrote:
> > > [...]
> > > >
> > > > My point is not about accuracy, although I think it's a reasonable
> > > > argument on its own (a lot of things could change in a short amount=
 of
> > > > time, which is why I prefer magnitude-based ratelimiting).
> > > >
> > > > My point is about logical ordering. If a userspace program reads th=
e
> > > > stats *after* an event occurs, it expects to get a snapshot of the
> > > > system state after that event. Two examples are:
> > > >
> > > > - A proactive reclaimer reading the stats after a reclaim attempt t=
o
> > > > check if it needs to reclaim more memory or fallback.
> > > > - A userspace OOM killer reading the stats after a usage spike to
> > > > decide which workload to kill.
> > > >
> > > > I listed such examples with more detail in [1], when I removed
> > > > stats_flush_ongoing from the memcg code.
> > > >
> > > > [1]https://lore.kernel.org/lkml/20231129032154.3710765-6-yosryahmed=
@google.com/
> > >
> > > You are kind of arbitrarily adding restrictions and rules here. Why n=
ot
> > > follow the rules of a well established and battle tested stats infra
> > > used by everyone i.e. vmstats? There is no sync flush and there are
> > > frequent async flushes. I think that is what Jesper wants as well.
> >
> > That's how the memcg stats worked previously since before rstat and
> > until the introduction of stats_flush_ongoing AFAICT. We saw an actual
> > behavioral change when we were moving from a pre-rstat kernel to a
> > kernel with stats_flush_ongoing. This was the rationale when I removed
> > stats_flush_ongoing in [1]. It's not a new argument, I am just
> > reiterating what we discussed back then.
>
> In my reply above, I am not arguing to go back to the older
> stats_flush_ongoing situation. Rather I am discussing what should be the
> best eventual solution. From the vmstats infra, we can learn that
> frequent async flushes along with no sync flush, users are fine with the
> 'non-determinism'. Of course cgroup stats are different from vmstats
> i.e. are hierarchical but I think we can try out this approach and see
> if this works or not.

If we do not do sync flushing, then the same problem that happened
with stats_flush_ongoing could occur again, right? Userspace could
read the stats after an event, and get a snapshot of the system before
that event.

Perhaps this is fine for vmstats if it has always been like that (I
have no idea), or if no users make assumptions about this. But for
cgroup stats, we have use cases that rely on this behavior.

>
> BTW it seems like this topic should be discussed be discussed
> face-to-face over vc or LPC. What do you folks thing?

I am not going to be at LPC, but I am happy to discuss this over VC.

