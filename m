Return-Path: <linux-kernel+bounces-442529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 911649EDDCE
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 04:01:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5166B167FCC
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 03:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 779ED13D52B;
	Thu, 12 Dec 2024 03:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hM3U6Zvd"
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5551F60A
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 03:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733972490; cv=none; b=kI9ukd88ipatrX7Ew5vZBGwSUB9VEfa4gDB55RGolYoHxTgT7Tjkz7sSLLbC8KHunvdP98w4VIC9ZaFIGHUty8ZGAtbEBGNUwr+qJn0RmaaoLfiqx8P5X6YLXNUZidZ5XfrtELkpMOj4bf6IddRfRuuc3nOyPhA5VXgF/z1nuQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733972490; c=relaxed/simple;
	bh=Kj782q7cX4/busFyfYXHzTNL6TIc9uOw33GwG6x2Ekk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nynRzBdROBYBvDLjOucDCaFDMpDPWmI/dQhsNZn2CCTF4tC0yqUBXP8ML6I+efdRryF/8tWgCsDN4IPccoGBHEGyo+KG+sLwa3wqrnU4meIK0M/2bIZ8YqYzt7hURfbAFT1/mC6mDPJRPAGqWyh3G5Gaoi60gwI/T4Y7BV7DDhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hM3U6Zvd; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-467896541e1so79571cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 19:01:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733972488; x=1734577288; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fXguPs9/u7xacodqeOh7BKGSfUT5UVdPBVuE8pC7yn8=;
        b=hM3U6ZvdSf3s89uUk+pFRqpghlrF7vRcQDypGjgbal7RSAP/iEVMkTjAo54nshx98p
         PnyKGAemfPzREPiaCwqx3U+WSZNKPiksOgq94PI5pPzEAebwIXJhZaJEhYCXhIS3W0Te
         v5zk/E1MTDLOr/Yj1F0YUJTBS8cCVc8tQkJKJxyx+2Kg7OPOr9y/CIZFcsxb1E+lK7HJ
         uHMA0fftMQj9hyMyDsgIOTmy6QHnL02itepZ/8oWbibGvVAEfqqGIqDPKafBcWEcZj+1
         1yXJRm5xIvsZ0dmJJlaNoasl97YL9at+Esn4PDWMxsS9KMRHP3hpb+li8rZJe68xaD/4
         07aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733972488; x=1734577288;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fXguPs9/u7xacodqeOh7BKGSfUT5UVdPBVuE8pC7yn8=;
        b=rJJJEKmqpMA4nu3brmQoYLTWZfizUfcbw0tPnKeHKInXTEdtsnhh93fpFY9ckWLSWu
         AInyCO+iIGNy3nwxm60giOCnQPJur+AZQx/72e/B50LU++aIimR8hmOiLYI1b0lLgQnN
         RlAD1wUS8cBUJk35rq9UsUi54qbaAMwE+dZplJA4W27YsmQ/dTgU6NiaRWRpfY8IWRhI
         1i1oaxxR7OrRXFcUgaXeE/YdieQzGezdky3vE2UotPTWWcciIMHvonSSa3LnbHNUARou
         cWrJR7tAGb3qPGOYnh/1wHmrSftppFSypMipvtx7T7UYb6XADFQx2ROilMybdxiCPRVx
         aCyQ==
X-Forwarded-Encrypted: i=1; AJvYcCX3ppitH0ScVxJPAq7cdGBV79S+jSdAa7oBTLPGscJaq/WPzxP/SpmpkJdBljrSgP5VSw9exrgifc024AA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjUhmOH9OER8/0bOv4HgGsPKtAn0y5tXuITC2nelaYJ/9MmqtB
	01mFiBkWmYnFkdw/cf71npl8LKdfP9dhaM1+rHnPRivNrH8aacncOf3O86sJzgfr5CeZKqIpHL6
	hV7FuvdIPCDPqxjx3vb9xhELiLyTmMJzH1vYG
X-Gm-Gg: ASbGncsBtzz8wlz7ZAflfrlrPZT6T2j3LW7+gIi1Lsq616XL6BQZWsIGmrQVsH6lK0c
	aphRWMM2W+H6ylnvJ6F5f/IHC6mMz8kiGpde2hG8xxLzBPYFMl5HKxccTBOU4cdzXxxMW
X-Google-Smtp-Source: AGHT+IHpj3jpVRoMz+xnVrcuUcoE0Wz2BdvQqBZ7aptyXt8bFeS01OnOmjKmsAbYjWH2WPp11bMrk3Uw90Ab7Sp2xZw=
X-Received: by 2002:a05:622a:5a16:b0:466:923f:a749 with SMTP id
 d75a77b69052e-467981befbcmr1102041cf.15.1733972487746; Wed, 11 Dec 2024
 19:01:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241111205506.3404479-1-surenb@google.com> <20241111205506.3404479-4-surenb@google.com>
 <ZzLgZTH9v5io1Elx@casper.infradead.org> <CAJuCfpHpGSpix8+mB76Virb+HAMrOqB3wG8E4EXPrRCnBoBGeA@mail.gmail.com>
 <20241210223850.GA2484@noisy.programming.kicks-ass.net> <CAJuCfpETJZVFYwf+P=6FnY_6n8E7fQsKH6HrOV1Q_q9cFizEKw@mail.gmail.com>
 <20241211082541.GQ21636@noisy.programming.kicks-ass.net> <CAJuCfpEMYhAmOPwjGO+j1t+069MJZxUs1O1co-zJ4+vEeXCtng@mail.gmail.com>
In-Reply-To: <CAJuCfpEMYhAmOPwjGO+j1t+069MJZxUs1O1co-zJ4+vEeXCtng@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 11 Dec 2024 19:01:16 -0800
Message-ID: <CAJuCfpGOOcRAJ46sbPRoCUNuuhi2fnkM97F=CfZ1=_N5ZFUcLw@mail.gmail.com>
Subject: Re: [PATCH 3/4] mm: replace rw_semaphore with atomic_t in vma_lock
To: Peter Zijlstra <peterz@infradead.org>
Cc: Matthew Wilcox <willy@infradead.org>, akpm@linux-foundation.org, liam.howlett@oracle.com, 
	lorenzo.stoakes@oracle.com, mhocko@suse.com, vbabka@suse.cz, 
	hannes@cmpxchg.org, mjguzik@gmail.com, oliver.sang@intel.com, 
	mgorman@techsingularity.net, david@redhat.com, peterx@redhat.com, 
	oleg@redhat.com, dave@stgolabs.net, paulmck@kernel.org, brauner@kernel.org, 
	dhowells@redhat.com, hdanton@sina.com, hughd@google.com, minchan@google.com, 
	jannh@google.com, shakeel.butt@linux.dev, souravpanda@google.com, 
	pasha.tatashin@soleen.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 11, 2024 at 7:20=E2=80=AFAM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> On Wed, Dec 11, 2024 at 12:25=E2=80=AFAM Peter Zijlstra <peterz@infradead=
.org> wrote:
> >
> > On Tue, Dec 10, 2024 at 03:37:50PM -0800, Suren Baghdasaryan wrote:
> >
> > > > Replace vm_lock with vm_refcnt. Replace vm_detached with vm_refcnt =
=3D=3D 0
> > > > -- that is, attach sets refcount to 1 to indicate it is part of the=
 mas,
> > > > detached is the final 'put'.
> > >
> > > I need to double-check if we ever write-lock a detached vma. I don't
> > > think we do but better be safe. If we do then that wait-until() shoul=
d
> > > accept 0x8000'0001 as well.
> >
> > vma_start_write()
> >   __is_vma_write_locked()
> >     mmap_assert_write_locked(vma->vm_mm);
> >
> > So this really should hold afaict.
> >
> > > > RCU lookup does the inc_not_zero thing, when increment succeeds, co=
mpare
> > > > mm/addr to validate.
> > > >
> > > > vma_start_write() already relies on mmap_lock being held for writin=
g,
> > > > and thus does not have to worry about writer-vs-writer contention, =
that
> > > > is fully resolved by mmap_sem. This means we only need to wait for
> > > > readers to drop out.
> > > >
> > > > vma_start_write()
> > > >         add(0x8000'0001); // could fetch_add and double check the h=
igh
> > > >                           // bit wasn't already set.
> > > >         wait-until(refcnt =3D=3D 0x8000'0002); // mas + writer ref
> > > >         WRITE_ONCE(vma->vm_lock_seq, mm_lock_seq);
> > > >         sub(0x8000'0000);
> > > >
> > > > vma_end_write()
> > > >         put();
> > >
> > > We don't really have vma_end_write(). Instead it's vma_end_write_all(=
)
> > > which increments mm_lock_seq unlocking all write-locked VMAs.
> > > Therefore in vma_start_write() I think we can sub(0x8000'0001) at the
> > > end.
> >
> > Right, I know you don't, but you should :-), I've suggested adding this
> > before.
>
> I'll look into adding it. IIRC there was some issue with that but I
> can't recall...
>
> >
> > > > vma_start_read() then becomes something like:
> > > >
> > > >         if (vm_lock_seq =3D=3D mm_lock_seq)
> > > >           return false;
> > > >
> > > >         cnt =3D fetch_inc(1);
> > > >         if (cnt & msb || vm_lock_seq =3D=3D mm_lock_seq) {
> > > >           put();
> > > >           return false;
> > > >         }
> > > >
> > > >         return true;
> > > >
> > > > vma_end_read() then becomes:
> > > >         put();
> > > >
> > > >
> > > > and the down_read() from uffffffd requires mmap_read_lock() and thu=
s
> > > > does not have to worry about writers, it can simpy be inc() and put=
(),
> > > > no?
> > >
> > > I think your proposal should work. Let me try to code it and see if
> > > something breaks.

Ok, I tried it out and things are a bit more complex:
1. We should allow write-locking a detached VMA, IOW vma_start_write()
can be called when vm_refcnt is 0. In that situation add(0x8000'0001)
leads to "addition on 0; use-after-free". Maybe I can introduce a new
refcnt function which does not complain when adding to 0?
2. Adding 0x80000000 saturates refcnt, so I have to use a lower bit
0x40000000 to denote writers.
3. Currently vma_mark_attached() can be called on an already attached
VMA. With vma->detached being a separate attribute that works fine but
when we combine it with the vm_lock things break (extra attach would
leak into lock count). I'll see if I can catch all the cases when we
do this and clean them up (not call vma_mark_attached() when not
necessary).

> >
> > Btw, for the wait-until() and put() you can use rcuwait; that is the
> > simplest wait form we have. It's suitable because we only ever have the
> > one waiter.
>
> Yes, Davidlohr mentioned that before. I'll do that. Thanks!

