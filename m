Return-Path: <linux-kernel+bounces-175379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95C6F8C1EB2
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 09:11:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5030A283C1B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 07:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A883153BE2;
	Fri, 10 May 2024 07:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fc8ZH+SQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4902515B147
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 07:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715325067; cv=none; b=ZC25IGf6ryDVm3kZAdDmR8nm/04ITItELX4INPqEIBCKq90h2t8SQM3dpGooVMbJX3w0febzjfx4vhXDbY04l053IEwhkLJSsg3u6tRl9dK8loQhV5PFZijwGbJFM7by/hWbyczybcRTZ30mqeETDIlEblF/6tK++qnJBwY74SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715325067; c=relaxed/simple;
	bh=Z9ApargRseOze0lK8nAdGp6lAx3o/KGDjDeb4qiKKMg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OI4ZsJ0zSJvAnGFMQ8rSHZzgsPEtrMMw7IjP/cPXoFt0zYOT3zLekCj8zf+aoa01lixfwREprLDpLU7sNrs1BIkg+9tnQDlcL2toHGWCQlU/fZspLgHFStsJ5UimmDuDnsY05/J5kGV0d4IEQ+19pVzSR5iHVX0XQkkWklaBi68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fc8ZH+SQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB230C4AF0A
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 07:11:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715325066;
	bh=Z9ApargRseOze0lK8nAdGp6lAx3o/KGDjDeb4qiKKMg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=fc8ZH+SQsgdJVx0arRPTSzS8k9BzelNIFR6Fl+f0sIlZv8Zrf0VwCEntmkBty1ijd
	 JKlUxuHh0uMzN/jmr5DC8urZdNthfEPeUJJP/To2HRGR8A/3q0elOufGSR93FZ1oDE
	 3215IsTYvZ7Rc9RuvaJtuXkV6j9tAleuXqsA20StgN5R5UJyOFgzgOYhyBUSO2nrWJ
	 0nkyxeM073NEOWedWyuU9M5R24oYoPjkhVZAW0L/wv9YTGy8QM1m2hNkwA/gvbf5yU
	 jCtd70dxGd+68KI1QuC+7W5b9h6qhlrtPn9qxPts/jRb0rSU06lxbBZi6VUFi+Iakq
	 ipzea0SE6ER5A==
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-36c703d13e6so7162875ab.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 00:11:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUuSn4JEWHiQgtbb2fSCgJcKFrAPzlOD0AnxxnDW6gAXFkZWAZAcILE2cumZhBr1ODgBSDwjGU7HOGoKqI5aY4MUpNRUvxIGy529nZl
X-Gm-Message-State: AOJu0YwGFB7sEQBm+p2GINd4IoQa1Z7G/mtMz3woEj3dT6c13Nv2iPGs
	z3ucA2NZ8LdfRRoUsCz3hKmYsEZFoRAPUWC2zz2jazEH4QENvGV+tH17pGAnWMH/6ohWbW2CIBi
	Z7DxiAGjwehQrrIJw9RarptMVLK/IYvUquNXH
X-Google-Smtp-Source: AGHT+IG1x0iEXhiDjKzCvD3azTG3/Qn0LkuU9YYEsZbRyOeqsBhhwiMjUdwYX5Ga7VuaUTtqX3k5b2AUsfl/5xfGC8s=
X-Received: by 2002:a05:6e02:1c88:b0:36c:84e0:252d with SMTP id
 e9e14a558f8ab-36cc1501b7fmr21479035ab.27.1715325066029; Fri, 10 May 2024
 00:11:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240509034138.2207186-1-roman.gushchin@linux.dev>
 <jf44dfyaenz6xmn2hcodaginrshw5d5hfhmakdxtj4x6szk6b2@cr2rxamkgj2m> <edff9a60-a77f-bc6c-3d07-4f96a97f1e38@google.com>
In-Reply-To: <edff9a60-a77f-bc6c-3d07-4f96a97f1e38@google.com>
From: Chris Li <chrisl@kernel.org>
Date: Fri, 10 May 2024 00:10:53 -0700
X-Gmail-Original-Message-ID: <CAF8kJuPpuRezs-HwF7E4a_GaLU55GoSvQfYVK3=ga+ZiJ5kFtQ@mail.gmail.com>
Message-ID: <CAF8kJuPpuRezs-HwF7E4a_GaLU55GoSvQfYVK3=ga+ZiJ5kFtQ@mail.gmail.com>
Subject: Re: [PATCH rfc 0/9] mm: memcg: separate legacy cgroup v1 code and put
 under config option
To: David Rientjes <rientjes@google.com>
Cc: Shakeel Butt <shakeel.butt@linux.dev>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, Muchun Song <muchun.song@linux.dev>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	gthelen@google.coma
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 9, 2024 at 7:59=E2=80=AFPM David Rientjes <rientjes@google.com>=
 wrote:
>
> On Wed, 8 May 2024, Shakeel Butt wrote:
>
> > Hi Roman,
> >
> > A very timely and important topic and we should definitely talk about i=
t
> > during LSFMM as well. I have been thinking about this problem for quite
> > sometime and I am getting more and more convinced that we should aim to
> > completely deprecate memcg-v1.
> >
>
> I think this would be a very worthwhile discussion at LSF/MM, I'm not sur=
e
> if it would be too late for someone to make a formal proposal for it to b=
e
> included in the schedule.  Michal would know if there is a opportunity.
>
> I say that in light of
> https://lore.kernel.org/bpf/ZjL5b-zipMrV2JSg@archie.me/T/#mb6c21b09543c43=
4dd85e718a8ecf5ca6485e6d07
> as well for the whole cgroup v1 -> v2 transition.
>
> Chris, now cc'd, would know best about all of the dependencies that Googl=
e
> has for memcg specifically.

Thanks David,

Yes, I am very interested in that cgroup v1 -> v2 transition discussion.
>
> > More specifically:
> >
> > 1. What are the memcg-v1 features which have no alternative in memcg-v2
> > and are blocker for memcg-v1 users? (setting aside the cgroup v2
> > structual restrictions)

In the list mentioned by Roman: "soft limit reclaim, oom handling in usersp=
ace,
complicated event notification system, charge migration."

The "oom.control" and leak of user space oom control is a big one for googl=
e.
Some test frameworks also use "memory.force_empty".
Soft limit reclaim and charge migration is also used.

There is also the combined "memsw" limit enforcement. Google has some
internal work around for V2 but it would be good if that upstream can
support it directly.

BTW, I know you are not looking for the "cgroup v2 structure restrictions".
Two cgroup controllers that can't have different sets of processes is
a bit too restrictive.

That is what I recall right now, I might be missing some small odd items.

Anyway, glad to join the discussion if there is a session.

Chris


Chris
> >
> > 2. What are unused memcg-v1 features which we should start deprecating?
> >
> > IMO we should systematically start deprecating memcg-v1 features and
> > start unblocking the users stuck on memcg-v1.
> >
> > Now regarding the proposal in this series, I think it can be a first
> > step but should not give an impression that we are done. The only
> > concern I have is the potential of "out of sight, out of mind" situatio=
n
> > with this change but if we keep the momentum of deprecation of memcg-v1
> > it should be fine.
> >
> > I have CCed Greg and David from Google to get their opinion on what
> > memcg-v1 features are blocker for their memcg-v2 migration and if they
> > have concern in deprecation of memcg-v1 features.
> >
> > Anyone else still on memcg-v1, please do provide your input.
> >
> > thanks,
> > Shakeel
> >

