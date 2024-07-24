Return-Path: <linux-kernel+bounces-260623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1590893ABE3
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 06:16:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C015C284891
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 04:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 145FA20B28;
	Wed, 24 Jul 2024 04:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UF+AEkt6"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2DF3F8E4
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 04:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721794576; cv=none; b=CbOZxpaFqDe1qgnMaTTuk9HKDHiMWP6M46IypPV+q6Vk9XIvyu1tJOfL7+8/61nPEfo+MirWc+MXB4dav7pd0kZaegL39swQuLt4yWiflzQp7ftvU+3nPech0dtgkqGCgES2AAjY3cplOg3TMxvcuA4P+7hsQ27T1cdDmMAVntg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721794576; c=relaxed/simple;
	bh=RN3gny0RM+0+kGKt+d45Q48PUb3VYnpxhylDlgCjtwA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FeDdK03QhvLF4kh/q4J9fdR2Vr/j4SJ0qbpxAurchdOc1OjwXwh5YGmV59Nlzhj0rdQIl0o0+bBnBEMAC+9abguLBPz15Bu5DN56YNiB80s+YOUvePBk8fjmEV7Pvz36xM8tK50TQekSUXQGeYF47w6QXZxRqQYAoGfCiuPoE3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UF+AEkt6; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5a869e3e9dfso9272a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 21:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721794573; x=1722399373; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iwS1/cFeNKL22fZ+xHmBTjWUvBFhF8oHEUfTzIr+zi8=;
        b=UF+AEkt6iqmTKd/3AXD1UMuy5ugJxXYmw3zg7AW1unxfQPQ8t4ydJLdXx/3FLe3G2m
         xkrNleoMl5f8pkIy9UX4xtJ4mL7vjMIp5uy/sXAFRlwnmVPyeVpZ3dKNxEp00z7XXos1
         aqhNbc2+tf+9dovwy8VEqfe9x1MmEDVG2TOTyqIOCoDPi2IIqL2vOAaII102MV+I4CQi
         r9AV4Z3e5h6MNpgJZHk6B5xVi/ckAsyRf40402d4IhsXWRchhhKsLfuJQhZC3xRkLJrS
         IzqkW7VU/u5cN0kWNgAvbE0ZTm/+8XxnzRNWDehJGTiOPj2Esq1BehGAR4R+ihnT7h0e
         utzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721794573; x=1722399373;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iwS1/cFeNKL22fZ+xHmBTjWUvBFhF8oHEUfTzIr+zi8=;
        b=SFxptbaSwvCftKObECtF+FNdb1nlBUJAeKlj00COKaTq/3ZlVNo7GkDvHm5unfkRx2
         4oajmUnsx0W3jNyzcrq/5uzncoZZEd4y7ZXq5Nj+Pn3v/wcM4OPLB9O/hw8GPIM7Ub2k
         XjzB1u0Dizc2REYuhGG5rDAOOetPhkLmBn0Lvgwy4Xird010gzMYRx5sXSLPqXPY4Kn4
         DN8bEn/Z9B43x5d0sB4Vd+1SNUz09LeLuWwbykH6qK7pG++/jZAsVwNvqnz+5v6HUu5J
         ruPOyZQJ0LPl2Fi6e4qaljl9UiDzgijZyN2IF2/hzsGVImGVBXS1WditX5UEPIyfK0cA
         1J8w==
X-Forwarded-Encrypted: i=1; AJvYcCWWrEmTSAKTCu2njOSKKtcCyIUxaPBIa2l8yEIMiBAyMsd3kNfLbzLKPZfmPDwAuayI4DLBYNTnVJbZFQf/OjafkJBBlmqff6kM4cvY
X-Gm-Message-State: AOJu0YweAIwK5GvuYJbtuh/SeSoLwNxWmpam7Ipxa+7SM/HwOPUK/TD0
	PsDFu+kWLpYJFNUp9azSiTAfh/YJvxxiD1Tq8bjg3bkxGnnJNqtbO+ubRBtB6RpjyOltM/Yi3gz
	4vM23M48vE2WYyyv7XHM4YoSLv8nCnE6Mvpy7
X-Google-Smtp-Source: AGHT+IGIyuI1/PYRmlck9vsU+FOC6p3INSYuEJHv/pe5uy6Gyvsvi7ks77SqXqU8Zd6gSPAF7BiO8luHqSfZLyd6PHc=
X-Received: by 2002:a05:6402:5211:b0:57c:c3a7:dab6 with SMTP id
 4fb4d7f45d1cf-5aacbacdc15mr162980a12.3.1721794572376; Tue, 23 Jul 2024
 21:16:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240720173543.897972-1-jglisse@google.com> <0c390494-e6ba-4cde-aace-cd726f2409a1@redhat.com>
 <CAPTQFZSgNHEE0Ub17=kfF-W64bbfRc4wYijTkG==+XxfgcocOQ@mail.gmail.com> <6be6453a-15ce-4305-9a7c-a66e57564785@redhat.com>
In-Reply-To: <6be6453a-15ce-4305-9a7c-a66e57564785@redhat.com>
From: Jerome Glisse <jglisse@google.com>
Date: Tue, 23 Jul 2024 21:15:59 -0700
Message-ID: <CAPTQFZS7KTTor+CHyzwE8hVVZo04haWsyTHhN9+Hy35PVZ6O1w@mail.gmail.com>
Subject: Re: [PATCH] mm: fix maxnode for mbind(), set_mempolicy() and migrate_pages()
To: David Hildenbrand <david@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 23 Jul 2024 at 10:37, David Hildenbrand <david@redhat.com> wrote:
>
> On 23.07.24 18:33, Jerome Glisse wrote:
> > On Mon, 22 Jul 2024 at 06:09, David Hildenbrand <david@redhat.com> wrot=
e:
> >>
> >> On 20.07.24 19:35, Jerome Glisse wrote:
> >>> Because maxnode bug there is no way to bind or migrate_pages to the
> >>> last node in multi-node NUMA system unless you lie about maxnodes
> >>> when making the mbind, set_mempolicy or migrate_pages syscall.
> >>>
> >>> Manpage for those syscall describe maxnodes as the number of bits in
> >>> the node bitmap ("bit mask of nodes containing up to maxnode bits").
> >>> Thus if maxnode is n then we expect to have a n bit(s) bitmap which
> >>> means that the mask of valid bits is ((1 << n) - 1). The get_nodes()
> >>> decrement lead to the mask being ((1 << (n - 1)) - 1).
> >>>
> >>> The three syscalls use a common helper get_nodes() and first things
> >>> this helper do is decrement maxnode by 1 which leads to using n-1 bit=
s
> >>> in the provided mask of nodes (see get_bitmap() an helper function to
> >>> get_nodes()).
> >>>
> >>> The lead to two bugs, either the last node in the bitmap provided wil=
l
> >>> not be use in either of the three syscalls, or the syscalls will erro=
r
> >>> out and return EINVAL if the only bit set in the bitmap was the last
> >>> bit in the mask of nodes (which is ignored because of the bug and an
> >>> empty mask of nodes is an invalid argument).
> >>>
> >>> I am surprised this bug was never caught ... it has been in the kerne=
l
> >>> since forever.
> >>
> >> Let's look at QEMU: backends/hostmem.c
> >>
> >>       /*
> >>        * We can have up to MAX_NODES nodes, but we need to pass maxnod=
e+1
> >>        * as argument to mbind() due to an old Linux bug (feature?) whi=
ch
> >>        * cuts off the last specified node. This means backend->host_no=
des
> >>        * must have MAX_NODES+1 bits available.
> >>        */
> >>
> >> Which means that it's been known for a long time, and the workaround
> >> seems to be pretty easy.
> >>
> >> So I wonder if we rather want to update the documentation to match rea=
lity.
> >
> > [Sorry resending as text ... gmail insanity]
> >
> > I think it is kind of weird if we ask to supply maxnodes+1 to work
> > around the bug. If we apply this patch qemu would continue to work as
> > is while fixing users that were not aware of that bug. So I would say
> > applying this patch does more good. Long term qemu can drop its
> > workaround or keep it for backward compatibility with old kernel.
>
> Not really, unfortunately. The thing is that it requires a lot more
> effort to sense support than simply pass maxnodes+1. So unless you know
> exactly on which minimum kernel version your software runs (barely
> happens), you will simply apply the workaround.

The point I was trying to make is that working applications do not
need to change
their code; a patched or unpatched kernel will not change their behavior in=
 any
way and thus they will continue working regardless of whether the kernel as
the patch.

While applications that are not as smart will keep miss-behaving until some=
one
fixes the application. So to me it looks like the patch brings good to
people without
arming any existing folks.

Fix in one place versus wait for people to fix their code ...


> I would assume that each and every sane user out there does that
> already, judging that even that QEMU code is 10 years old (!).

I took a look at some code I have access to and it is not the case
everywhere ...

>
> In any case, we have to document that behavior that existed since the
> very beginning. Because it would be even *worse* if someone would
> develop against a new kernel and would get a bunch of bug reports when
> running on literally every old kernel out there :)
>
> So my best guess is that long-term it will create more issues when we
> change the behavior ... but in any case we have to update the man pages.

No it would not, if you had the fix and did not modify applications
that are smart about it then nothing would change. Applications that
are smart will work the same on both patched and unpatched kernels
while applications that have the bug will suddenly have the behaviour
they would have expected from the documentation.

Thank you,
J=C3=A9r=C3=B4me

