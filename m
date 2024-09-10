Return-Path: <linux-kernel+bounces-323686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2390E9741CC
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 20:14:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55AFD1C255A8
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 18:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F15E1A4E6B;
	Tue, 10 Sep 2024 18:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="abLtyT08"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 398AE1A3BAC
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 18:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725992054; cv=none; b=ABIi2sPxNvp8PJ7lGDifLFO5D4YpqxhMjRzYKC/EDczFreglRW3uaZLyYQzwPrNq9Wr6mdrILR3l1/xbKzpkW7VQTPkZGuDQUpqMtf9bqNzFrppgUfBNrmuqQIVauqQYN7kUg5s/5v96t9eQhFBrVqmLh+Om6UC4YYpoXH9pT80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725992054; c=relaxed/simple;
	bh=PN/bOVC7EhD+DKOp8i3e+Nf4juy6xA9SZtiS34NdjWg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D6QwxODRJ+vyWrf9FNlfSCXaSu6nUy8PDxRUJjHfKTKhr/yZJjpKhLmjXgU+QfKvkDPUeBZeH5ER1B8bmtQV//IqZjITk6gPKwtA2pL3NpDBMrASEBsVZMtuQhhVt/ZxL85kSMPmkQixKzZDcxJTLErnRsWl0z1k52IqT4ZwTGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=abLtyT08; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5356a2460ceso31618e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 11:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725992051; x=1726596851; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PN/bOVC7EhD+DKOp8i3e+Nf4juy6xA9SZtiS34NdjWg=;
        b=abLtyT0856J3HiEMvWqwwBa1k6zmHgTCdGHw5zBu+zunSbmN2sOPwnmyinZH+nj7Cg
         kFm/iWQ9/CxrPl15wLJNFAZ2yxRlZIXoB4XXaS91DTIMr6PTRyGBhmcCIbHgPiyksVaw
         p3TRE9KPKKDaQqpuN0jNnZWc2BesLo46xQLO7Z/LteItYbhQMTv0WUcVh/VmP8rUSF94
         gkewLIDoGe9X5du//E3Y+ijhhEZgShqpd391R9IMGgLQO/FRi8r2+gwAGXPHFunErljw
         bAwBBDRBkev0NhqgZ+Nnzxcr1LPk5Ov7/dITj6b/8k+k3i0b3ZA9fe0yerNkZdPwpMHG
         LK2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725992051; x=1726596851;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PN/bOVC7EhD+DKOp8i3e+Nf4juy6xA9SZtiS34NdjWg=;
        b=MNs7MKwCGkT8KGfZfAqwQdy6I6R5eZikR58iO8xfRCwgg+QwRyHJmYv0Y41GBQVYI3
         eJYuDwrLxb8VghCLwmCbePqW3dnwB8gXUhloOFijLoIPRG21r56pb7nea79F3UknEHZ2
         Q/43b+2DRBXWZ/m1vhJhtygHsL1bYQvtfLkF94OgE8cGrFnTqSeo8E2aONPapZkUCjdR
         kNScULD/cz3GW5LjFRbVWStsveIypyEksa3BIoWFhR182Td0hf3WYz6TNmv8Bz0cHiYu
         Ah/3sfXrcOrOKwcjrQBnkbgpmO1EQ8lE3hoa8HepyEQ41aUEoEwo25fkQnaXnsUNjBCc
         MQKA==
X-Forwarded-Encrypted: i=1; AJvYcCVVOANUeGtmO5/qH5ViT/O4HMK/YCs4BcLKFpvB75+MENk8SyAM6EsjnQ9XXyFaezUWHStmr05KbfR4OG8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw47Ri08/uk28qxtimkwrB98hfWjPBVEW7H2RPPiVqloFs+MsCQ
	RdRdp4RkbJKM2XxQqAOtIv6Ib+dHk7638XLSQBQP5I/JW2XNAlLnAs1opUlNY1qj3zlPzFFRsk1
	7+wxpHDxanC+zFaPdFLHEc+ymYap02AdFxQk3n6J1uYZxmOAy1h9RDhw=
X-Google-Smtp-Source: AGHT+IHJzZW54ZelEpqtjg5sNSpim2OEz6bcZdRlXJladf0hM3rQAiAdQOYywo77wa6LK0FC2fDMu1023QrWMkIipaU=
X-Received: by 2002:a05:6512:318e:b0:536:52dc:291f with SMTP id
 2adb3069b0e04-536743b4463mr19813e87.1.1725992050488; Tue, 10 Sep 2024
 11:14:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240906051205.530219-1-andrii@kernel.org> <CAG48ez1+Y+ifc3HfG=E5j+g=RwtzH2TiE4mAC2TZxS52idkRZg@mail.gmail.com>
 <CAEf4BzazZSUtJ9vPd6Xj4539MCebctOZJmO7xmdUhoQiv5mBFg@mail.gmail.com>
In-Reply-To: <CAEf4BzazZSUtJ9vPd6Xj4539MCebctOZJmO7xmdUhoQiv5mBFg@mail.gmail.com>
From: Jann Horn <jannh@google.com>
Date: Tue, 10 Sep 2024 20:13:32 +0200
Message-ID: <CAG48ez2+v4pADNgUjdq8aOvyJAUHOudSre=Q5RpN1sfj2aByaw@mail.gmail.com>
Subject: Re: [PATCH 0/2] uprobes,mm: speculative lockless VMA-to-uprobe lookup
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org, 
	peterz@infradead.org, oleg@redhat.com, rostedt@goodmis.org, 
	mhiramat@kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	jolsa@kernel.org, paulmck@kernel.org, willy@infradead.org, surenb@google.com, 
	akpm@linux-foundation.org, linux-mm@kvack.org, mjguzik@gmail.com, 
	brauner@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 10, 2024 at 7:58=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
> On Tue, Sep 10, 2024 at 9:06=E2=80=AFAM Jann Horn <jannh@google.com> wrot=
e:
> > On Fri, Sep 6, 2024 at 7:12=E2=80=AFAM Andrii Nakryiko <andrii@kernel.o=
rg> wrote:
> > > Implement speculative (lockless) resolution of VMA to inode to uprobe=
,
> > > bypassing the need to take mmap_lock for reads, if possible. Patch #1=
 by Suren
> > > adds mm_struct helpers that help detect whether mm_struct were change=
d, which
> > > is used by uprobe logic to validate that speculative results can be t=
rusted
> > > after all the lookup logic results in a valid uprobe instance.
> >
> > Random thought: It would be nice if you could skip the MM stuff
> > entirely and instead go through the GUP-fast path, but I guess going
> > from a uprobe-created anon page to the corresponding uprobe is hard...
> > but maybe if you used the anon_vma pointer as a lookup key to find the
> > uprobe, it could work? Though then you'd need hooks in the anon_vma
> > code... maybe not such a great idea.
>
> So I'm not crystal clear on all the details here, so maybe you can
> elaborate a bit. But keep in mind that a) there could be multiple
> uprobes within a single user page, so lookup has to take at least
> offset within the page into account somehow. But also b) single uprobe

I think anonymous pages have the same pgoff numbering as file pages;
so the page's mapping and pgoff pointers together should almost give
you the same amount of information as what you are currently looking
for (the file and the offset inside it), except that you'd get an
anon_vma pointer corresponding to the file instead of directly getting
the file.

> can be installed in many independent anon VMAs across many processes.
> So anon vma itself can't be part of the key.

Yeah, I guess to make that work you'd have to somehow track which
anon_vmas exist for which mappings.

(An anon_vma is tied to one specific file, see anon_vma_compatible().)

> Though maybe we could have left some sort of "cookie" stashed
> somewhere to help with lookup. But then again, multiple uprobes per
> page.
>
> It does feel like lockless VMA to inode resolution would be a cleaner
> solution, let's see if we can get there somehow.

Mh, yes, I was just thinking it would be nice if we could keep this
lockless complexity out of the mmap locking code... but I guess it's
not much more straightforward than what you're doing.

