Return-Path: <linux-kernel+bounces-365305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74AF099E034
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 10:03:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34C7828239D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 08:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F386B1BBBCC;
	Tue, 15 Oct 2024 08:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZnTg+VYs"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981D41714C4
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 08:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728979415; cv=none; b=UT3xwiTipjxUSJqfS+UC2hxFm77RCj2PapFf78/VevMzsAtQPOc4xZ/RDYk7Fh10BeGYYnkPRqICN25zCfYtQVyD/K/S7npKD8VqhJjAT2hy4UmD9WJksE0EvubvhtT19VJ9mrO9ClGGu/JoJuN5X1KqgdHypvc7ZNbD/nMS8Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728979415; c=relaxed/simple;
	bh=EInbJTWQIXN5jkIPg2sKpT7dUQFA8FtF+mTLVVrhm0A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kw9TG2X7Q5J9IH2ZtZ2bIwm+dqcGpRAyynpLILlRY5Yn+BtXUL4bOD+0YrD+ZQpTUFCZdYJPw60YQQM24M3dhLKe7ffIOARAPgOohF5HlX4xopMu5WT2j0JUmJe862SsFWPLa5uqp+BBC4dr3Zcl+j2qiDkoisamu+ve3zEkIWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZnTg+VYs; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-539eb97f26aso2503901e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 01:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728979411; x=1729584211; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=N3sV+MUjmkm/3ouMm/VZqChWo6gbDHYg+6Mp7oGExyw=;
        b=ZnTg+VYsSV6PHM8jxNR3P1xYZp8uLraKqunRH4V5w56zdABWefNOwupQnEUEDokEJ/
         JGCs06aLbiTyCj4lHR8qDBvCz1WWy9zCK14d9bZUBjr0cNi2oIOPdDHq+sHsWbX/8Qlq
         usqWvHz5azFz1PdoB/NY9c530kHkgNdQOS2Hu54DeHUfZUprH0XBBmRWufQqqKTYThmN
         GUosmVrPkJZH1U0gfdXBPi9xrcITtwTt5qCV5AIQlNEwIc5xpvZ/hC6fDRTKMlTV3PZK
         RbE9E2sY8ZPCDn5DWr7ou/dIxsnIouZutGXv2MzXnCf6b6wyhhRhhWtu6/Y76rJGcR7i
         KQ0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728979411; x=1729584211;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N3sV+MUjmkm/3ouMm/VZqChWo6gbDHYg+6Mp7oGExyw=;
        b=ahb4BUaQ5S5AX4gVzNcVLRegT983ZWrnzJtxapnPNe2Z7Awux97fMW321BOY28NnBs
         wuVUdKIwkEJinBHN6aiU9f9jt0bH2ZbDsCLZZNg+Pgplj0D2Xov7w2r0lTh2UJyfkbvd
         lD5d84Cu9DCJHOb9XEJ8EA3JU7fqpjIEV+wS8kRqLKnkORW6oe9+V2WTKgQ8q7VtKG/b
         42TmQo4ExlGZDQP/kmUpybzA9vcN0S4QFsuT/Vz2nCi1R7RkiXZCFwBjQ4/iRQF9WlBi
         CfCKZxzWUZeQNlODFZqnf1qf3s+hjKbqdsRkWdqH6u4w4BhbVQ/IT5MiFJUjoVL0Q6Dl
         jb+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWBXX95+gr5dX0Q5PkyKtzq3riIbFT+Ey3ckJ5gHfTRQ+Ndppyvyjg+Tj4EXFHM9WJxbnsMurB3B2Neag4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy91l30/XAu58GqzDEDjlTghrcMAnwNxGpGoBcW+zfxFDHsSpRd
	Hl6GPwKKXgO3TxngMCmPvb1B903yl1q571ZcKJsrJh8I0nx84FhUcjD+Pil27gjPDiBvxGgLmuN
	5EhETSlmJc0mFVGOeZh0De960AB8fc8wpQMIx
X-Google-Smtp-Source: AGHT+IFuAWCk0O3DiGt2jLIMMRZ+47uA58eN9z+L/2D1jR0fxGLSvk7WvgKy8tyjVoe9CKGvpjScJIML7omeA5rPTic=
X-Received: by 2002:a05:6512:3f02:b0:536:5625:511a with SMTP id
 2adb3069b0e04-539da59516cmr7172856e87.47.1728979410474; Tue, 15 Oct 2024
 01:03:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241010003550.3695245-1-shakeel.butt@linux.dev>
 <CAJD7tkYq+dduc7+M=9TkR6ZAiBYrVyUsF_AuwPqaQNrsfH_qfg@mail.gmail.com>
 <20241009210848.43adb0c3@gandalf.local.home> <CAJD7tkaLQwVphoLiwh8-NTyav36_gAVdzB=gC_qXzv7ti9TzmA@mail.gmail.com>
 <mt474r4yn346in5akhyziwxrh4ip5wukh4fjbhwzfl26wq64nf@xgbv4dtfs3ak>
 <CAJD7tkYzo_K9uF7GOO3yoKzTSbFWuNTUG3O6w1VrGCQvgWhsoQ@mail.gmail.com> <cwibnvqnbtfc7sgpkidh24dcnj2xdb462rf6hndgynqezbzbaf@qog4zl25sqry>
In-Reply-To: <cwibnvqnbtfc7sgpkidh24dcnj2xdb462rf6hndgynqezbzbaf@qog4zl25sqry>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Tue, 15 Oct 2024 01:02:52 -0700
Message-ID: <CAJD7tkYhYiDj5RSvRnK7uLG82pPLv_f5c4nBgQQCGNJWn9qRjw@mail.gmail.com>
Subject: Re: [PATCH] memcg: add tracing for memcg stat updates
To: Daniel Xu <dxu@dxuuu.xyz>
Cc: Shakeel Butt <shakeel.butt@linux.dev>, Steven Rostedt <rostedt@goodmis.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, JP Kobryn <inwardvessel@gmail.com>, linux-mm@kvack.org, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Meta kernel team <kernel-team@meta.com>, bpf@vger.kernel.org, 
	Martin KaFai Lau <martin.lau@linux.dev>
Content-Type: text/plain; charset="UTF-8"

> > > > > > > @@ -682,7 +686,9 @@ void __mod_memcg_state(struct mem_cgroup *memcg, enum memcg_stat_item idx,
> > > > > > >                 return;
> > > > > > >
> > > > > > >         __this_cpu_add(memcg->vmstats_percpu->state[i], val);
> > > > > > > -       memcg_rstat_updated(memcg, memcg_state_val_in_pages(idx, val));
> > > > > > > +       val = memcg_state_val_in_pages(idx, val);
> > > > > > > +       memcg_rstat_updated(memcg, val);
> > > > > > > +       trace_mod_memcg_state(memcg, idx, val);
> > > > > >
> > > > > > Is it too unreasonable to include the stat name?
> > > > > >
> > > > > > The index has to be correlated with the kernel config and perhaps even
> > > > > > version. It's not a big deal, but if performance is not a concern when
> > > > > > tracing is enabled anyway, maybe we can lookup the name here (or in
> > > > > > TP_fast_assign()).
> > > > >
> > > > > What name? Is it looked up from idx? If so, you can do it on the reading of
> > >
> > > Does reading side mean the one reading /sys/kernel/tracing/trace will do
> > > the translation from enums to string?
> > >
> > > > > the trace event where performance is not an issue. See the __print_symbolic()
> > > > > and friends in samples/trace_events/trace-events-sample.h
> > > >
> > > > Yeah they can be found using idx. Thanks for referring us to
> > > > __print_symbolic(), I suppose for this to work we need to construct an
> > > > array of {idx, name}. I think we can replace the existing memory_stats
> > > > and memcg1_stats/memcg1_stat_names arrays with something that we can
> > > > reuse for tracing, so we wouldn't need to consume extra space.
> > > >
> > > > Shakeel, what do you think?
> > >
> > > Cc Daniel & Martin
> > >
> > > I was planning to use bpftrace which can use dwarf/btf to convert the
> > > raw int to its enum string. Martin provided the following command to
> > > extract the translation from the kernel.
> > >
> > > $ bpftool btf dump file /sys/kernel/btf/vmlinux | grep -A10 node_stat_item
> > > [2264] ENUM 'node_stat_item' encoding=UNSIGNED size=4 vlen=46
> > >         'NR_LRU_BASE' val=0
> > >         'NR_INACTIVE_ANON' val=0
> > >         'NR_ACTIVE_ANON' val=1
> > >         'NR_INACTIVE_FILE' val=2
> > >         'NR_ACTIVE_FILE' val=3
> > >         'NR_UNEVICTABLE' val=4
> > >         'NR_SLAB_RECLAIMABLE_B' val=5
> > >         'NR_SLAB_UNRECLAIMABLE_B' val=6
> > >         'NR_ISOLATED_ANON' val=7
> > >         'NR_ISOLATED_FILE' val=8
> > > ...
> > >
> > > My point is userspace tools can use existing infra to extract this
> > > information.
> > >
> > > However I am not against adding __print_symbolic() (but without any
> > > duplication), so users reading /sys/kernel/tracing/trace directly can
> > > see more useful information as well. Please post a follow up patch after
> > > this one.
> >
> > I briefly looked into this and I think it would be annoying to have
> > this, unfortunately. Even if we rework the existing arrays with memcg
> > stat names to be in a format conforming to tracing, we would need to
> > move them out to a separate header to avoid a circular dependency.
> >
> > Additionally, for __count_memcg_events() things will be more
> > complicated because the names are not in an array in memcontrol.c, but
> > we use vm_event_name() and the relevant names are part of a larger
> > array, vmstat_text, which we would need to rework similarly.
> >
> > I think this would be easier to implement if we can somehow provide a
> > callback that returns the name based on the index, rather than an
> > array. But even then, we would need to specify a different callback
> > for each event, so it won't be as simple as specifying the callback in
> > the event class.
> >
> > All in all, unless we realize there is something that is fundamentally
> > more difficult to do in userspace, I think it's not worth adding this
> > unfortunately :/
>
> Turned out to be quite straightforward to do in userspace:
> https://github.com/bpftrace/bpftrace/pull/3515 .
>
> A nice property is the resolution occurs out of line and saves the
> kernel some cycles in the fast path.

This is really neat, thanks for doing this! Native support in bpftrace
is definitely better than manually correlating the values, especially
with large enums with 10s of values like the ones we are talking about
here.

