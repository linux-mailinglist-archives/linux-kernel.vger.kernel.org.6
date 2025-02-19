Return-Path: <linux-kernel+bounces-521179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48261A3B6D6
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 10:10:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C7BF3BD86F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 09:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 955291E8323;
	Wed, 19 Feb 2025 08:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ciyfwvkG"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2827C1E8331
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 08:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739955283; cv=none; b=QXSp8DbYl7EBWLJLZdaSQafkcQ6XK1iXgKcY7RsUTmSDkYvxNN1iKdjH/xXmHvfFuQXZ53vIDjyq8jKxMl+rdNJooGkcXVsiORKo/QY18NLkDuc5ukfcL56WBUxQAYRaivmvSwDhVZzc3jl1+7rtYdR/0KpX9VLB+gyf/Ecw1j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739955283; c=relaxed/simple;
	bh=hI6lzFU9GH4lhUpDYV/NVDPee81sTSfLySLouta9/2s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Oa12sjqjYfG/S/pNRHrJ884za2ElL/ykPPDPYsEJL2LipdIuZDt8a8SDt9fpoDc3fi1mmEv5/OEFLxGbea2aJpNLrPeLmqBUkSD7FgpbNtrzv9U+6+CUxjnaCcPtZI0mq54D30kK2WcxevMW0N5qOd6ac4AVdaoSlh7VYzLcKP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ciyfwvkG; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-3078fb1fa28so58538591fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 00:54:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739955280; x=1740560080; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=M7ZGnNuhN0CVE7mBuptCvnZnUrT3C/sQYpFdgDU/kXc=;
        b=ciyfwvkGxcPBp4pD2DFUu2EpIDZcliR1xjyo1b4UG7V5wsWLN+/4p/X+9LsuByyyZE
         07eC85zzSNUCr0eBEEq5Offq6l6vVD4mjrWokejkKZesNucxyj7WMEYXQm97igwbSKIm
         dJPyZ/3OPB1SPmqIEuFiIjTtQR1EkzMxKERElxRfvd/pvBqbwfWf/+MbVhVWOjIhXONu
         3cp5m+3lH703atKcSrJrsUF+p0KnuYGyZzzA0UV9WXlGtqrUFchDlpKn5vvW2EtqAaCR
         1VxpMlrpDHBXcIz/UVeI+ixEZ0JRrcYepG7KFpG6nL60aqsLqqruMEokANMK3noLkPvf
         pl4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739955280; x=1740560080;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M7ZGnNuhN0CVE7mBuptCvnZnUrT3C/sQYpFdgDU/kXc=;
        b=XKOQV6SsInFWvEzWR8qS+5IiorTAUmw8ICK0smXIC5CbzXGV5JedZt0O8XLFx16nhB
         HuvpVIaytEYByxnIXiTgJp4j/qQOvLIhTOdvs7nMIgz9VxFB+akAzNhHgogHfT2PLfgV
         Yp1G1TQBW2LAmySR9TLtfxSX0uegaHsOmdbHFLXpM+GoYem6xQliZWAhDrv1/AOfRBHd
         rX54vxjuTAACDB+zIxBSlgATo5653KfAr3A9T9z8IjUHn4IHSHUfJ9nycr/sD50AS9C4
         I+r1XwqO++nPFq9+wXB1ywYP2dGzx+KklsxJao/O9Pyz+rTJV+kVLpP/Ad7EWL5BqUOJ
         +ciw==
X-Forwarded-Encrypted: i=1; AJvYcCUA4RAcJF7BvUlmDJzuAWXoAyd8m/+cVLBzwc1BCHUY/PQSs/rmK0VeEwYJkYvwbP2dllnBlF4C296wocE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcuE0z8GkkVRS6BoL94m+nwGrGy3d8A2nHgGAHh2L7QPRxxUHY
	OIkJ7izIF3jg0AxTGR7bdBnVM2tSGoL+sXVzSkckMrg+IV8sg/H+lA3FKyY+atNJkaTimwlga42
	LEWDgwB+mr99l6A4dAio0mfrks3tTMkokPBus
X-Gm-Gg: ASbGncve1FtSK+uNOW4a5LkoKUF18/cMmcf1OSsHgE3BhGXXacSpEGw/W7nMgGEvdTC
	UMC0J0tFmc+pzKZFBkoQ3iUopORcOKJcuY1XqMLSYP5IjMOxgKb/07rzjJeoDZxZ+I7sI2LLANJ
	Z0F6g5iJJYNCGi4ky2zWElOlMNvZp8
X-Google-Smtp-Source: AGHT+IEP2+jeuwwYmMiagIAHh0VM1ScsRe90WNyN5wOQxB/zxn47k8htPTq9a+NJd6BjsC6cVYnkYzBacchoLRHJJZg=
X-Received: by 2002:a2e:9b50:0:b0:308:fd11:7715 with SMTP id
 38308e7fff4ca-30927b283e5mr50897561fa.33.1739955279996; Wed, 19 Feb 2025
 00:54:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1739894594.git.dvyukov@google.com> <607562bf50ddc81ebd404e8dc1710e5221f80342.1739894594.git.dvyukov@google.com>
 <Z7S8SAGt8blFiFTg@gourry-fedora-PF4VCD3F> <CACT4Y+Z3ismwdeqa7iMo0JVD-u-nvSmN2eS5qJ5tUqXT9NjWcw@mail.gmail.com>
 <Z7TKvdjvmtzfjza6@gourry-fedora-PF4VCD3F>
In-Reply-To: <Z7TKvdjvmtzfjza6@gourry-fedora-PF4VCD3F>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Wed, 19 Feb 2025 09:54:28 +0100
X-Gm-Features: AWEUYZme0VYqkJSfzdcPdzITmicCJ99Vg0vZCzncurdthUSOHxOZyNTjx9Mqd7I
Message-ID: <CACT4Y+ZJhCD3Y-nNKb42K0561tOceYKRNm6Yi8r9-KwoWfvkbQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] syscall_user_dispatch: Allow allowed range wrap-around
To: Gregory Price <gourry@gourry.net>
Cc: krisman@collabora.com, tglx@linutronix.de, luto@kernel.org, 
	peterz@infradead.org, keescook@chromium.org, gregory.price@memverge.com, 
	Marco Elver <elver@google.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 18 Feb 2025 at 19:00, Gregory Price <gourry@gourry.net> wrote:
>
> On Tue, Feb 18, 2025 at 06:34:34PM +0100, Dmitry Vyukov wrote:
> > On Tue, 18 Feb 2025 at 17:58, Gregory Price <gourry@gourry.net> wrote:
> > > If the intent is to load and re-use a single foreign-OS library, this
> > > change seems to be the question of "why not allow multiple ranges?",
> > > and you'd be on your way to reimplementing seccomp or BPF.
> >
> > The problem with seccomp BPF is that the filter is inherited across
> > fork/exec which can't be used with SIGSYS and fine-grained custom
> > user-space policy. USER_DISPATCH is much more flexible in this regard.
>
> It's also fundamentally not a security-sufficient interposition system.
>
> > Re allocating resources outside of monitored bounds: this is exactly
> > what syscall filtering is for, right :)
>
> No.  SUD's purpose is to catch foreign-OS syscall execution.

My understanding is that aiming at concrete end problems is not the
kernel approach and design philosophy. Instead it aims at providing
flexible _primitives_ that can be used to solve various end problems.
It's like you are not selling pencils to draw trees, instead you just
sell good pencils.

E.g. if there are 2 end problems A and B that require 98% of the same
primitives, the kernel wouldn't implement 2 completely independent
subsystems to solve A and B that duplicate 98% of the code. Instead it
would provide flexible primitives that can be used to solve A and B
(and yet unknown C and D in future).


> You *can* do hacky stuff like interposing on libc, but it you can do
> hacky things with bpf too.
>
> > If we install a filter on a library/sandbox, we can control and
> > prevent it from allocating any more executable pages outside of the
> > range.
> >
> > The motivation is sandboxing of libraries loaded within a known fixed
> > address range, while non-sandboxed code can live on both sides of the
> > sandboxed range (say, non-pie binary at lower addresses, and libc at
> > higher addresses).
>
> My question is why you aren't doing the opposite.  Exempt the known good
> ranges and hook everything else.  This actually makes it easier to
> ensure the software you're hooking doesn't escape interposition.

The restricted code is a single continuous region. Allowed code lives
on both sides (non-pie binary at the lowest addresses, dynamic libs at
the highest addresses, and there is not enough space before and after
to map a large enough contiguous region for restricted code).

> You can use the SIGSYS register data (instruction pointer) to determine
> whether to act on the syscall or pass it through.

Too expensive (few additional instructions vs microseconds for kernel
transition, sigcontext setup, and sigreturn).

> Like I said, I don't necessarily disagree with the change, just a bit
> concerned about the direction this takes SUD.  It's not a sufficient
> interface to isolate the behavior of a single library, and this change
> naturally begs the question "If we do this, why not implement an entire
> multi-range filtering system? Why stop at one range?"

That's a harder question. I think we don't need to answer it right
now. We can just consider this proposal in isolation. This is where we
stop now.
It preserves all of the existing uses intact + allows more cases with
a trivial code change (actually deleting code).

