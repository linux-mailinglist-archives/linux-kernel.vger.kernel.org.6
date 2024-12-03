Return-Path: <linux-kernel+bounces-430022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2FA29E2B30
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 19:44:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 887A9284F59
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 18:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14E0F1FECDC;
	Tue,  3 Dec 2024 18:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o0lAqsNO"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9711FE467
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 18:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733251439; cv=none; b=YW1b/HI2JMaTuLawAiiGagCp0Wp9YrQmtCDTZgVkNDyw9fVXC4evI174yusHjyRjYlVTOF3bAX7PmnvuxELUlqTfF55ahDIyaTYYvBHogXzS2JG1KD+sOdSu3RmyP7qrCWTLLxzbs6I39ry6yqo06dMbZ951E7R19s5oTwe/lrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733251439; c=relaxed/simple;
	bh=N4xXJylFZqlsahnMeoivnIPjXugVik2yDGL6h+UJAIw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QBqX20gPIJr21TicAhfIwZDfoLcR5apjt9xZwGTNuTphdK3oA1gtB/d/FZFJd7kLBSEcYDFrMS1rVkW63U3+sbtfGuBGNMMqU26jWlPnL9dbzLSud4L2Ae2NRV3uC4uwQv2sFRIpeChsY2d1GVtTGi9W/LF12XrNkp/dh9tusbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=o0lAqsNO; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-53dd5f68c33so956e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 10:43:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733251435; x=1733856235; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+YWgVPK/SpoACBIKJFxQCjuZ+EEWYYEXx3gjh4xmrLI=;
        b=o0lAqsNO/6iNNxECqaesmNmAowqA63SHzpS3ynBVsO08E5V3BFF0AxdlPdeGDIlVSe
         OQm2JWFkxfW76lqVaupbSYseuIGfMh+rxVAQJ+0Cy2h/M49Qq7RF10NlRQl7UekyfXlv
         8Uqi7oZ3LIRyglom+GYKk0782yMMxqvKR4Bl2kQ6wUxQ+5jf+PQahmf92ZfxUWpJPBY+
         lZJXgh68LpmG6QHdFIUEH+j2KXA3xsGdY3ozIOOzZtPU63mxdWTjFeOZetA6phrXWFcM
         qCpR2Xc4iBYmCt5zjbz7xJhd9aza4x8OoTRqH6BYgA6moJVw0DdEwwjdv+tgPK62/m6C
         gjDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733251435; x=1733856235;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+YWgVPK/SpoACBIKJFxQCjuZ+EEWYYEXx3gjh4xmrLI=;
        b=sxEXQBrGnSxzBpNjrsSQhbY2H06jyQ517PEhZkrXqEVfYncyLFTrovbdBk87OLMDmQ
         fwxs5fTK42CRXBEYvtb58omsqjAn4XResawjuQGK0BmJuaiZFUatR03i/bsQk6u/CRxq
         bdojn0RpCkiEZolfOtH7aP0RfFYM20PCBCccuQCWhLbDC2G5PPNc3eAI5G1mRj2sJm9d
         Fvcj/1Tb9lvhWxa9Eo/sNOdve7zGZfXxwTMtQ6FBL4CH0qoFXQYQa/sGsU3kYVTksIb6
         cU/TIQNWvMysASIL1JdGQ8CE2muj2ml/LU5+UaOmSlmao7e1I4JxHr40R3his66btBvj
         g4EQ==
X-Forwarded-Encrypted: i=1; AJvYcCVUhtj7XehkbxHcVUzPCYRr2wFFPk64ej+y4C7rVsk/uM7RuOoNgU+9X2gKqL2l7ohM+OsSKHH7/y3ZngU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjIsWGrWnANKkjQ4qDs9Qou3adL4k+f6NY8WahtzoH7R5Jp5a2
	IAdRJ6eX9n0wBB1wOCOGe9hLzJi41SoGSJUySv7euUwDTJHfBzoJ2ipCTiGdTp42lNYTcnLKpvN
	fD0elmc/Pja6rpIawQrvv5rcWNZjElwggNUuu
X-Gm-Gg: ASbGnctXxJrD6kjl/vQ5Obb4XR7Izk28B+IHSdk3gES8XGC5b/cWP9Cw8z3SMdLL26d
	IY4vTKVvOlUDLZQksCiXT+o67WPYE
X-Google-Smtp-Source: AGHT+IHQGk/5NHJx9Qv8zG7XVG5iZYG6w0hBvWOe/S7jbkmz5Xy2Mtt2Pp+kLrED+4ngNlmDPTOw3wpvxhPeLdNe3MY=
X-Received: by 2002:a05:6512:6207:b0:53d:f58a:2f81 with SMTP id
 2adb3069b0e04-53e134b225dmr205818e87.5.1733251434202; Tue, 03 Dec 2024
 10:43:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241202202058.3249628-1-fvdl@google.com> <3tqmyo3qqaykszxmrmkaa3fo5hndc4ok6xrxozjvlmq5qjv4cs@2geqqedyfzcf>
 <CAPTztWbmkFisL7qnmAnre5hv=UD1E60P0hr_kXNyLoQFy9OoTA@mail.gmail.com>
 <Z070YE81kJ-OnSX8@tiehlicka> <d1f224fb-c0fb-47f9-bea8-3c33137be161@oracle.com>
In-Reply-To: <d1f224fb-c0fb-47f9-bea8-3c33137be161@oracle.com>
From: Frank van der Linden <fvdl@google.com>
Date: Tue, 3 Dec 2024 10:43:42 -0800
Message-ID: <CAPTztWYnmgMNTStH_Z-012MmFDG2vDN8AU2aZRaUeLhwaR8=qg@mail.gmail.com>
Subject: Re: [PATCH] mm/hugetlb: optionally pre-zero hugetlb pages
To: Joao Martins <joao.m.martins@oracle.com>
Cc: Michal Hocko <mhocko@suse.com>, Mateusz Guzik <mjguzik@gmail.com>, linux-mm@kvack.org, 
	akpm@linux-foundation.org, Muchun Song <muchun.song@linux.dev>, 
	Miaohe Lin <linmiaohe@huawei.com>, Oscar Salvador <osalvador@suse.de>, 
	David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 3, 2024 at 6:26=E2=80=AFAM Joao Martins <joao.m.martins@oracle.=
com> wrote:
>
> On 03/12/2024 12:06, Michal Hocko wrote:
> > On Mon 02-12-24 14:50:49, Frank van der Linden wrote:
> >> On Mon, Dec 2, 2024 at 1:58=E2=80=AFPM Mateusz Guzik <mjguzik@gmail.co=
m> wrote:
> >>> Any games with "background zeroing" are notoriously crappy and I woul=
d
> >>> argue one should exhaust other avenues before going there -- at the e=
nd
> >>> of the day the cost of zeroing will have to get paid.
> >>
> >> I understand that the concept of background prezeroing has been, and
> >> will be, met with some resistance. But, do you have any specific
> >> concerns with the patch I posted? It's pretty well isolated from the
> >> rest of the code, and optional.
> >
> > The biggest concern I have is that the overhead is payed by everybody o=
n
> > the system - it is considered to be a system overhead regardless only
> > part of the workload benefits from hugetlb pages. In other words the
> > workload using those pages is not accounted for the use completely.
> >
> > If the startup latency is a real problem is there a way to workaround
> > that in the userspace by preallocating hugetlb pages ahead of time
> > before those VMs are launched and hand over already pre-allocated pages=
?
>
> It should be relatively simple to actually do this. Me and Mike had exper=
imented
> ourselves a couple years back but we never had the chance to send it over=
. IIRC
> if we:
>
> - add the PageZeroed tracking bit when a page is zeroed
> - clear it in the write (fixup/non-fixup) fault-path
>
> [somewhat similar to this series I suspect]
>
> Then what's left is to change the lookup of free hugetlb pages
> (dequeue_hugetlb_folio_node_exact() I think) to search first for non-zero=
ed
> pages. Provided we don't track its 'cleared' state, there's no UAPI chang=
e in
> behaviour. A daemon can just allocate/mmap+touch/etc them with read-only =
and
> free them back 'as zeroed' to implement a userspace scrubber. And in prin=
ciple
> existing apps should see no difference. The amount of changes is conseque=
ntly
> significantly smaller (or it looked as such in a quick PoC years back).

This would work, and is easy to do, but:
  * You now have a userspace daemon that depends on kernel-internal behavio=
r.
  * It has no way to track how much work is left to do or what needs
to be done (unless it is part of an application that is the only user
of hugetlbfs on the system).

>
> Something extra on the top would perhaps be the ability so select a looku=
p
> heuristic such that we can pick the search method of
> non-zero-first/only-nonzero/zeroed pages behind ioctl() (or a better gene=
ric
> UAPI) to allow a scrubber to easily coexist with hugepage user (e.g. a VM=
M, etc)
> without too much of a dance.

Again, that would probably work, but if you take a step back: you now
have a kernel behavior that can be guided in certain directions, but
no guarantees and no stats to see if things are working out. And an
explicit allocation method option (basically: take from the head or
the tail of the freelist). The picture is getting murkier. At least
with the patch I sent you have a clearly defined, optional, behavior
that can be switched on or off, and stats to see if it's working.

I do understand the argument against having pre-zeroing not being
accounted to the current thread. I would counter that benefiting from
work by kernel threads is not unheard of in the kernel today already.
Also, the other proposals so far also have another thread doing the
zeroing - it just is explicitly started by userspace. So, the cost is
still not paid by the user of the pages. You just end up with
explicitly controlling who does pay the cost. Which I suppose is
better, but it's still not trivial to get it completely right (you
perhaps could do it at the container level with some trickery).

What we have done so far is to bind the khzerod threads introduced in
this patch to CPUs in such a way that it doesn't interfere with the
rest of the system. Which you would also have to do with any userspace
solution.

Again, this is optional - if you are a system manager who prefers to
have the resources used by zeroing hugetlb pages to be explicitly
accounted to the actual user, you can not enable this behavior (it's
off by default).

I guess I can summarize my thoughts like this: while I understand the
argument against doing this outside of the context of the actual user
of the pages, this is 1) optional, and 2) so far the other solutions
introduce interfaces that I don't think are that great, or would
require maintaining a hugetlb 'shadow pool' in userspace through
hugetlbfs files.

- Frank

