Return-Path: <linux-kernel+bounces-448222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34FED9F3D1F
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 22:57:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B525C1884BCF
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 21:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFB111D5CF2;
	Mon, 16 Dec 2024 21:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WvyhpoNT"
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D13F1D432F
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 21:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734386265; cv=none; b=G+SNmXuGpTMBatjap+LBfHag4pe3PQnP2+pEuqAmIiekjECruz9DhkMwJhugZm3qrPVKSR1a0wszGjw2Z5z8dck4qNUblA6lljGm2hM6PYJsVW1Rplpn9kPfvTwpwUMwnu+AacPeAUsaEOHEonB68xZtBcPeKM9GAAAc+q34Yd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734386265; c=relaxed/simple;
	bh=hirHr4W8Q6ksKkZKc4EIV/ko385cp3mjedG34EMDZtU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MmrBhYvfhfedPOdgLbYs/V2xE/Oyg43ROgKKIrIq9kdbMQYEU7+owMwEp1/CZiKlZWumsNKNv+hy+oeySvVeYDeSbb3m7NNooMbMx9uq6eX60+fH/MMhoGJTlBBNgq6MRh8X5qhzbmjsfljlkKy1m/IyCSMx+YvCZJBfU1aP0Ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WvyhpoNT; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4679b5c66d0so21841cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 13:57:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734386261; x=1734991061; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5T5roncOghweZCeQmSlAea4USG1OweAi+z5lLSWaOYw=;
        b=WvyhpoNTE6Ta0SPEFDbtVl68y5xMo4PQfP49eNOyAAZIN8uQWkg4Ck77jAgemc0ych
         pDiMx85GzziXVfK3nbYcI+JGyLv1Y8f/o0YYMo1vGxLGupkl2bJ5OipDafhIkwAazE6A
         wPyC3FkQ/Vf9DkmYSrgQsm0We/4Ac2d4ry1CHxbP9LbpwM9N0ZTKn5VRfA1+dSaZ7cPh
         n4YfJRZsbWZG46p5gxbihtOc62VOSp9l6OKt8eK2JwNHB39Gw9HX2Dch0QX77ux908MC
         ZHiorvHx96cpJa8Hu0WOPjz4LSKeBRwC6Fy3iEj7ECtJCl03Gt0oGSuAMccPqEuqN7hh
         aHOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734386261; x=1734991061;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5T5roncOghweZCeQmSlAea4USG1OweAi+z5lLSWaOYw=;
        b=IlTrMOw26sPBNwsc4XRjVDYjfmlToxV6oUAKAHkuNens/oUrfDe9kVkwKXe/h/mM8I
         plBYdNkr9GVRoecyBrpLvn4/sENBnMvRKjUd5R6YPQw+xk+HDYMFZEZj8tcALFuOOGbC
         23BxHgi5oS0jT5uz5ikczq8FyZfoMzCqiaNOSVraKIjWEp8kBcKEZGAodyz1RAyjTbLy
         qV2xOuwfmDtq79aKRNKf7BnQMiV/JQ1GlUhcStTAZRHCc7L+rPijkZWO3QZu0CUE69qh
         gchkg04XZXZKqbmFGNRFhSlcnGuYR8kj/w4bd8H+oiPVGVYpCMNF7YtpnehDOZStPf0S
         Ytjg==
X-Forwarded-Encrypted: i=1; AJvYcCWIC0qjEqJoXnWc8j5g3uvXEXCj5zhZX96omZyIvsNm/J3wJJH4jeoGC0DqKL4UoEXm3jTFWVpdsLmHTsQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz42zSX9nu1Zz+JL3ARN4QqBqwei4LXqKP2UoJNF8cbhB34iV04
	LXbQRFCNEbEEHuOQz4LvKsz8tgUt5Gvs6N01OzpICTx/COpqBtKPDssXeW4fUCs6cmxiVhUDxfq
	vTFgHvitddaF3aeGfuRabaMQE6NcNlYShl2md
X-Gm-Gg: ASbGncvyOk9CKIoAncDhxzd+X/33qOt3cke0AXBTA2VHTn0JcAplZWRhhj97RWsCJcz
	Q89VOhRqFvXPd7QhS2cHEb6sm/u2BYNL95nk3ZQ==
X-Google-Smtp-Source: AGHT+IFrMpdfUGm37FvnuIHqb4P8MJaEtKV+fo4HiTzztMreBEY3Uftz39OoGg7QpOm/Z5TrOM4DCy0JCcTHtSqaVjo=
X-Received: by 2002:a05:622a:210:b0:467:5fea:d4c4 with SMTP id
 d75a77b69052e-468fb142301mr79521cf.27.1734386261193; Mon, 16 Dec 2024
 13:57:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241216192419.2970941-1-surenb@google.com> <20241216192419.2970941-12-surenb@google.com>
 <20241216211635.GC9803@noisy.programming.kicks-ass.net> <20241216211826.GA33253@noisy.programming.kicks-ass.net>
In-Reply-To: <20241216211826.GA33253@noisy.programming.kicks-ass.net>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 16 Dec 2024 13:57:29 -0800
Message-ID: <CAJuCfpGtOXq+FOvJzTifmSdDXzpj=abxK=FjYKDmHugA-eudGw@mail.gmail.com>
Subject: Re: [PATCH v6 11/16] mm: enforce vma to be in detached state before freeing
To: Peter Zijlstra <peterz@infradead.org>
Cc: akpm@linux-foundation.org, willy@infradead.org, liam.howlett@oracle.com, 
	lorenzo.stoakes@oracle.com, mhocko@suse.com, vbabka@suse.cz, 
	hannes@cmpxchg.org, mjguzik@gmail.com, oliver.sang@intel.com, 
	mgorman@techsingularity.net, david@redhat.com, peterx@redhat.com, 
	oleg@redhat.com, dave@stgolabs.net, paulmck@kernel.org, brauner@kernel.org, 
	dhowells@redhat.com, hdanton@sina.com, hughd@google.com, 
	lokeshgidra@google.com, minchan@google.com, jannh@google.com, 
	shakeel.butt@linux.dev, souravpanda@google.com, pasha.tatashin@soleen.com, 
	klarasmodin@gmail.com, corbet@lwn.net, linux-doc@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 16, 2024 at 1:18=E2=80=AFPM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Mon, Dec 16, 2024 at 10:16:35PM +0100, Peter Zijlstra wrote:
> > On Mon, Dec 16, 2024 at 11:24:14AM -0800, Suren Baghdasaryan wrote:
> > > exit_mmap() frees vmas without detaching them. This will become a pro=
blem
> > > when we introduce vma reuse. Ensure that vmas are always detached bef=
ore
> > > being freed.
> > >
> > > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > > ---
> > >  kernel/fork.c |  4 ++++
> > >  mm/vma.c      | 10 ++++++++--
> > >  2 files changed, 12 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/kernel/fork.c b/kernel/fork.c
> > > index 283909d082cb..f1ddfc7b3b48 100644
> > > --- a/kernel/fork.c
> > > +++ b/kernel/fork.c
> > > @@ -473,6 +473,10 @@ struct vm_area_struct *vm_area_dup(struct vm_are=
a_struct *orig)
> > >
> > >  void __vm_area_free(struct vm_area_struct *vma)
> > >  {
> > > +#ifdef CONFIG_PER_VMA_LOCK
> > > +   /* The vma should be detached while being destroyed. */
> > > +   VM_BUG_ON_VMA(!is_vma_detached(vma), vma);
> > > +#endif
> > >     vma_numab_state_free(vma);
> > >     free_anon_vma_name(vma);
> > >     kmem_cache_free(vm_area_cachep, vma);
> > > diff --git a/mm/vma.c b/mm/vma.c
> > > index fbd7254517d6..0436a7d21e01 100644
> > > --- a/mm/vma.c
> > > +++ b/mm/vma.c
> > > @@ -413,9 +413,15 @@ void remove_vma(struct vm_area_struct *vma, bool=
 unreachable)
> > >     if (vma->vm_file)
> > >             fput(vma->vm_file);
> > >     mpol_put(vma_policy(vma));
> > > -   if (unreachable)
> > > +   if (unreachable) {
> > > +#ifdef CONFIG_PER_VMA_LOCK
> > > +           if (!is_vma_detached(vma)) {
> > > +                   vma_start_write(vma);
> > > +                   vma_mark_detached(vma);
> > > +           }
> > > +#endif
> > >             __vm_area_free(vma);
> >
> > Again, can't you race with lockess RCU lookups?
>
> Ah, no, removing vma requires holding mmap_lock for writing and having
> the vma locked, which would ensure preceding RCU readers are complete
> (per the LOCK_OFFSET waiter thing) and new RCU readers are rejected for
> the vma sequence thing.

Correct. Once vma is detached it can't be found by new readers.
Possible existing readers are purged later in this patchset by calling
vma_ensure_detached() from vm_area_free(). I don't do that in this
patch because those existing temporary readers do not pose issues up
until we start reusing the vmas.

