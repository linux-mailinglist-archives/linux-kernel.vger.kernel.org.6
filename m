Return-Path: <linux-kernel+bounces-430138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72D169E2CDF
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 21:16:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3321E283B40
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 20:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE4D91FC7FA;
	Tue,  3 Dec 2024 20:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CX+LsQp+"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F17A1FDE05
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 20:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733256966; cv=none; b=KH8WWhRd9XqBjK0XBLzVPtUjmuD9wm4V3C50BPSjoniKDNnKTCIsQB6iYhdF+khGFcNHuhCjj9GxxhQQ92wvnXmmGCi2VXXwshQixGZVA7UEoZ28c6i8vJihcH+4WkGOc5KHytdqOrENcUxh1SHPLXu5v+yiXZD2PL2k51ynQeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733256966; c=relaxed/simple;
	bh=pF+pYBn0iZOJHY49hPyr4FNRRPCBYcGD27Us9YYKANA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CSDwPU/EtAiJ2T5vJlKZQfALlSpjYfuEZ/bNB2PO27W4LopUvWt9o+zWw1w2krT/xvCrOKfW7VtWr3mXSzj2NMdn8OvrqIhs+qv+o/+lqmtvgJVHY3FR3Z7VSqvO2ICH4ADh1k+vNbk2mSBLCUy0vp/Q0L/K58HQ6EJgxzheZ2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CX+LsQp+; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-53e141f6970so1634e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 12:16:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733256962; x=1733861762; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FpBN6RiAF5UFKvq1JxlwiJmlkNltP1jl8FIcm9xzwTI=;
        b=CX+LsQp+CQHoWq2/QCD1ugyYY52hKU83WQwKy+In3Qv0YsJW0mQZ1oZCKfIZ7hV8nr
         2LrM1pPHTSa0r+ED9u3ivt0e8UXndnWw1wYvpF6IuF5XhDAWvliDdN8HvhqcMXELULWQ
         ocSrYb5+xKf1E8wqhfA76Qv4DQBYqyskpwWD79lpPJraR2hVX2C6j5F8mMjM9WL41S6d
         5EQwHEuRcvYDo6Cy4P9s/6nXCIgOBn3sGmQDGuPXrT+KJ+tYa03DPShOhfPLQ6ejQDtw
         XLfo3PupX7Rda8Fei2QB6BOH1Wb8FQl+85XcRSbXscZ70L3bZ+9mfDjV9EyOBBqjw9HP
         UDOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733256962; x=1733861762;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FpBN6RiAF5UFKvq1JxlwiJmlkNltP1jl8FIcm9xzwTI=;
        b=SptAYUK4qXHACxeU/xxMW/7libI3j5AV9N2nSj/NQXl9oVM1swbl1IYe7Ha0SyKN5w
         JULAaLFNH11N7RyqdxqiRSD6yLgjlf2tqvPCL8Qh0NmMFEsoX5MQamA6YhBepjLa0IJ1
         Tg6G1S5Vyq4xNXoPe0okP1lSh+2CxHEAheoPZJqerDBko/kLEA1xopD4EkgrvzSdFJ87
         s2NKIV+Al9lfrsOG4VOrCM7Bz9YCpfSKL/ATSA3/U9RCEMvJeH9UlIbq7pKXEEiY4Y6O
         k6LbeLzb5AywzhmbjRCmeY/jRiPwyutXEqamWE/5sr1hOI24zHyA8SGPM25nlFbVrO5i
         B4xA==
X-Forwarded-Encrypted: i=1; AJvYcCW+pd6cxgVSZM9i0b+00ola68Da7TPUTHRtNt45U3k1TnPFUaaPonEywgUNab8acHsEfehCgk/lm+Az0Bw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYcDUxUyaDHz/gNd4qV01Ouxs6bUzDShPOLO5ux5WsaZCpLuxU
	xZOWWkq+ukwo0BJdg+qdULbuUz6wSqQu8lNsBJbLae9WNmRiSHrQlDQDcvqEDA54yruyLrrSPOm
	O1VoOToTXRZszDCZCGZBT21gtpY55p2DUCGO8
X-Gm-Gg: ASbGncub+xptFOVnfGcUcpSxXIiYyHSSTtvq2D+eu7qmcijPbysAusrdpGZ5l3+gw3h
	/2Eq2nV5wJhDsgugvyIidSeAV4Hqp
X-Google-Smtp-Source: AGHT+IHPGiVLN9ZU4ADHFThS4nMBM7aAiKBNpW2JyC3K/I8r5kOZOVOKhqWTHb1Aav0mM7UXvBpEXHz2pdedGcInyLM=
X-Received: by 2002:a05:6512:252b:b0:53b:4c7c:a792 with SMTP id
 2adb3069b0e04-53e1c57eb1dmr43264e87.6.1733256962085; Tue, 03 Dec 2024
 12:16:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241202202058.3249628-1-fvdl@google.com> <3tqmyo3qqaykszxmrmkaa3fo5hndc4ok6xrxozjvlmq5qjv4cs@2geqqedyfzcf>
 <CAPTztWbmkFisL7qnmAnre5hv=UD1E60P0hr_kXNyLoQFy9OoTA@mail.gmail.com>
 <Z070YE81kJ-OnSX8@tiehlicka> <d1f224fb-c0fb-47f9-bea8-3c33137be161@oracle.com>
 <CAPTztWYnmgMNTStH_Z-012MmFDG2vDN8AU2aZRaUeLhwaR8=qg@mail.gmail.com>
In-Reply-To: <CAPTztWYnmgMNTStH_Z-012MmFDG2vDN8AU2aZRaUeLhwaR8=qg@mail.gmail.com>
From: Frank van der Linden <fvdl@google.com>
Date: Tue, 3 Dec 2024 12:15:50 -0800
Message-ID: <CAPTztWbyiE7xoLejyCZOQbv+QGYb_qt+NJp2W92kg0Rxqm29_Q@mail.gmail.com>
Subject: Re: [PATCH] mm/hugetlb: optionally pre-zero hugetlb pages
To: Joao Martins <joao.m.martins@oracle.com>
Cc: Michal Hocko <mhocko@suse.com>, Mateusz Guzik <mjguzik@gmail.com>, linux-mm@kvack.org, 
	akpm@linux-foundation.org, Muchun Song <muchun.song@linux.dev>, 
	Miaohe Lin <linmiaohe@huawei.com>, Oscar Salvador <osalvador@suse.de>, 
	David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 3, 2024 at 10:43=E2=80=AFAM Frank van der Linden <fvdl@google.c=
om> wrote:
>
> On Tue, Dec 3, 2024 at 6:26=E2=80=AFAM Joao Martins <joao.m.martins@oracl=
e.com> wrote:
> >
> > On 03/12/2024 12:06, Michal Hocko wrote:
> > > On Mon 02-12-24 14:50:49, Frank van der Linden wrote:
> > >> On Mon, Dec 2, 2024 at 1:58=E2=80=AFPM Mateusz Guzik <mjguzik@gmail.=
com> wrote:
> > >>> Any games with "background zeroing" are notoriously crappy and I wo=
uld
> > >>> argue one should exhaust other avenues before going there -- at the=
 end
> > >>> of the day the cost of zeroing will have to get paid.
> > >>
> > >> I understand that the concept of background prezeroing has been, and
> > >> will be, met with some resistance. But, do you have any specific
> > >> concerns with the patch I posted? It's pretty well isolated from the
> > >> rest of the code, and optional.
> > >
> > > The biggest concern I have is that the overhead is payed by everybody=
 on
> > > the system - it is considered to be a system overhead regardless only
> > > part of the workload benefits from hugetlb pages. In other words the
> > > workload using those pages is not accounted for the use completely.
> > >
> > > If the startup latency is a real problem is there a way to workaround
> > > that in the userspace by preallocating hugetlb pages ahead of time
> > > before those VMs are launched and hand over already pre-allocated pag=
es?
> >
> > It should be relatively simple to actually do this. Me and Mike had exp=
erimented
> > ourselves a couple years back but we never had the chance to send it ov=
er. IIRC
> > if we:
> >
> > - add the PageZeroed tracking bit when a page is zeroed
> > - clear it in the write (fixup/non-fixup) fault-path
> >
> > [somewhat similar to this series I suspect]
> >
> > Then what's left is to change the lookup of free hugetlb pages
> > (dequeue_hugetlb_folio_node_exact() I think) to search first for non-ze=
roed
> > pages. Provided we don't track its 'cleared' state, there's no UAPI cha=
nge in
> > behaviour. A daemon can just allocate/mmap+touch/etc them with read-onl=
y and
> > free them back 'as zeroed' to implement a userspace scrubber. And in pr=
inciple
> > existing apps should see no difference. The amount of changes is conseq=
uently
> > significantly smaller (or it looked as such in a quick PoC years back).
>
> This would work, and is easy to do, but:
>   * You now have a userspace daemon that depends on kernel-internal behav=
ior.
>   * It has no way to track how much work is left to do or what needs
> to be done (unless it is part of an application that is the only user
> of hugetlbfs on the system).
>
> >
> > Something extra on the top would perhaps be the ability so select a loo=
kup
> > heuristic such that we can pick the search method of
> > non-zero-first/only-nonzero/zeroed pages behind ioctl() (or a better ge=
neric
> > UAPI) to allow a scrubber to easily coexist with hugepage user (e.g. a =
VMM, etc)
> > without too much of a dance.
>
> Again, that would probably work, but if you take a step back: you now
> have a kernel behavior that can be guided in certain directions, but
> no guarantees and no stats to see if things are working out. And an
> explicit allocation method option (basically: take from the head or
> the tail of the freelist). The picture is getting murkier. At least
> with the patch I sent you have a clearly defined, optional, behavior
> that can be switched on or off, and stats to see if it's working.
>
> I do understand the argument against having pre-zeroing not being
> accounted to the current thread. I would counter that benefiting from
> work by kernel threads is not unheard of in the kernel today already.
> Also, the other proposals so far also have another thread doing the
> zeroing - it just is explicitly started by userspace. So, the cost is
> still not paid by the user of the pages. You just end up with
> explicitly controlling who does pay the cost. Which I suppose is
> better, but it's still not trivial to get it completely right (you
> perhaps could do it at the container level with some trickery).
>
> What we have done so far is to bind the khzerod threads introduced in
> this patch to CPUs in such a way that it doesn't interfere with the
> rest of the system. Which you would also have to do with any userspace
> solution.
>
> Again, this is optional - if you are a system manager who prefers to
> have the resources used by zeroing hugetlb pages to be explicitly
> accounted to the actual user, you can not enable this behavior (it's
> off by default).
>
> I guess I can summarize my thoughts like this: while I understand the
> argument against doing this outside of the context of the actual user
> of the pages, this is 1) optional, and 2) so far the other solutions
> introduce interfaces that I don't think are that great, or would
> require maintaining a hugetlb 'shadow pool' in userspace through
> hugetlbfs files.

One more thing: any userspace solution has one basic problem: the
hugetlb pages will be unavailable while they are being zeroed out, as
the userspace process or thread will have to map+touch them, taking
them off the freelist. So now another process that needs the hugetlb
pages, expecting them to be there based on initial configuration and
what it's done so far, may end up getting unexpected -ENOMEM because
one or more pages have been temporarily allocated by userspace prezero
threads.

My patch doesn't have that issue - the pages stay on the freelist, the
total number of available pages does not change. In the rare case that
a freshly allocated page is being prezeroed, you'll just have to wait
until it's done (taking up no more time than doing it yourself).

Now, you can implement something like this in userspace (if I get
-ENOMEM, check with the prezero thread or process), but it's not
great.

- Frank

