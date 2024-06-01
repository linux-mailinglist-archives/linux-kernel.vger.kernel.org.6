Return-Path: <linux-kernel+bounces-197625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B3548D6D36
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 02:59:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65C6E1C219D5
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 00:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55E8F4690;
	Sat,  1 Jun 2024 00:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UyKSuw3W"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2DEDA38
	for <linux-kernel@vger.kernel.org>; Sat,  1 Jun 2024 00:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717203578; cv=none; b=nmJmMxcuimDF72EzSJDmJCOjjgYiE4bYPuMoLnaBs6IRNnK5e7YnvxPb6eR44mvBbHYtYyQDpTYve/qlYJiGyEEMmVLJyn9CLrtXK93H1mo5o6Ax6n1ZF+M3yqxL8Ky7V12CowhTHQgnyhzww0hV7VwzBgmKCysWJOhLxcoS9bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717203578; c=relaxed/simple;
	bh=daHGbC6GayCEq44f0zX+SRWAHrGGSVaTCEWXIIjZl/Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=URb22O5hvrcURgNOrCEBn0jpT6LjzETnJ4px7xASJLGpgrc8UNmghKkvb8A8AbbaW40Pd8s/+kQWN86l8xXZ3ba05aD0J+7wswZFErM9OImprL381jHh8ZJpFlXvwRYUUogG5UZMjrzVw/9rvjqaIpS5KgtkXmVKWYheloKL5ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UyKSuw3W; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2e73359b900so30272311fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 17:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717203575; x=1717808375; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4c1H1czvW5wu5dZLp5czTd3lmrqNcfjJq6zE2Ej+bK8=;
        b=UyKSuw3WC+P4SluOnWylG9U2pia64qApj7lo5Bn1vNoM9HpmY2vJynzcUWsRMQ98/I
         zWFK7lP1iWzbSUaN4KSEtcx9IC8ah+3uPbrQNecXocDltSfCNQfpaL5tsZpkMKxHmzbw
         /wnsuD15wUGUwHf49AIRvP9fDOwBFptET2w7AdaYY5G/B2z0ZKkfVQ9dbX1lsr/dF340
         RtLFupi3YBYVgRqWL1yf3J9nvsYZKOlGy4F0+imkjNFhlPtwsFiMY/YxxKuD0pLrsfhg
         KVd2Snx9ZOww69UQtOsSFzK97a1O3Z0wX2M/T7cxh/+wQgHdn0A+WWyZVu9uqBkzSOra
         LECA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717203575; x=1717808375;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4c1H1czvW5wu5dZLp5czTd3lmrqNcfjJq6zE2Ej+bK8=;
        b=FXojhU8/RrD1NQQS2RLxGJ7xUwSjXz/fOLfWVdZXl3HVH3vl3jsRHtzVuuvO6yzxxo
         nRXJxniWaMl0Jo58oVl7ZLD1SRC7pQa6XFm7rieMbEDK3U4zyJQjKLM2OSnXE/MqB8hs
         3fnm0CzkctSq0kjiY3oUOStdy77jtS+BHWz6BNx4GRay8fwT2YTkcXgBq80eWItL9ij2
         2ZyYBnM0JKikZ3yfqcHlORMzcXJgQJIixr4ZzVc96Go8pHkF9dcVzk7IAw50WGUKxfkX
         qrYvc/MT+sb31kkaGs/xlw0UMjKY8vjkfk0roKQ6q0TR6lqBZ0/4s/NVNb5I7enzG5dW
         n4rA==
X-Forwarded-Encrypted: i=1; AJvYcCUu/NTgDjcEroRk9QLcO2QJkk7j1sjiS48rwMoDjaZWduuOJwH5B/zXOFwx3cMbt83pTL61zf2a4HjiF37BMtvuoyCgE1z+4kk/IndU
X-Gm-Message-State: AOJu0YxnDNemNskKCPPjch81FIpVh/C8tphU4g8CMGco7sUy7fF4SXdq
	62Zc5ngbtjQAvjJpOP8PTAF+s5j7bcwJcQTX3Vt2pXDUwudkRHn5m6jb+kyz78NyOEA7V/9mFE6
	0cHuhIX8BaVH4WUFfQypf4cTcbdQ=
X-Google-Smtp-Source: AGHT+IHeoalXtZ3m7YrazfHsP5LzCh2JGOqNV7G4XfGNDHFGYgwWm2xv+wPuIMhJJDh5SJTmRIOAomfVKcyaXijLOF0=
X-Received: by 2002:a2e:9054:0:b0:2d6:c43e:f0b3 with SMTP id
 38308e7fff4ca-2ea951d21f8mr19580481fa.50.1717203574325; Fri, 31 May 2024
 17:59:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202405311534.86cd4043-lkp@intel.com> <CAHbLzkpMhEuGkQDGWrK1LhvZ-ZxTJkV1xjmn-nRGZMH4U+F5ZA@mail.gmail.com>
 <890e5a79-8574-4a24-90ab-b9888968d5e5@redhat.com> <ZlpcRnuZUEYJJ0JA@x1n> <CAHbLzkrRw-xf819gYJwRQ=-u971LQYnB2FNJMkN=s6u-pJ4Z8g@mail.gmail.com>
In-Reply-To: <CAHbLzkrRw-xf819gYJwRQ=-u971LQYnB2FNJMkN=s6u-pJ4Z8g@mail.gmail.com>
From: Yang Shi <shy828301@gmail.com>
Date: Fri, 31 May 2024 17:59:22 -0700
Message-ID: <CAHbLzkoB+oFTxtVYpeXQvko2q9HUVzUYrr83S6M6PUmXDQpkag@mail.gmail.com>
Subject: Re: [linus:master] [mm] efa7df3e3b: kernel_BUG_at_include/linux/page_ref.h
To: Peter Xu <peterx@redhat.com>
Cc: David Hildenbrand <david@redhat.com>, kernel test robot <oliver.sang@intel.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Vivek Kasireddy <vivek.kasireddy@intel.com>, 
	Rik van Riel <riel@surriel.com>, oe-lkp@lists.linux.dev, lkp@intel.com, 
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	Matthew Wilcox <willy@infradead.org>, Christopher Lameter <cl@linux.com>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 31, 2024 at 5:01=E2=80=AFPM Yang Shi <shy828301@gmail.com> wrot=
e:
>
> On Fri, May 31, 2024 at 4:25=E2=80=AFPM Peter Xu <peterx@redhat.com> wrot=
e:
> >
> > On Fri, May 31, 2024 at 07:46:41PM +0200, David Hildenbrand wrote:
> > > try_grab_folio()->try_get_folio()->folio_ref_try_add_rcu()
> > >
> > > Is called (mm-unstable) from:
> > >
> > > (1) gup_fast function, here IRQs are disable
> > > (2) gup_hugepte(), possibly problematic
> > > (3) memfd_pin_folios(), possibly problematic
> > > (4) __get_user_pages(), likely problematic
> > >
> > > (1) should be fine.
> > >
> > > (2) is possibly problematic on the !fast path. If so, due to commit
> > >     a12083d721d7 ("mm/gup: handle hugepd for follow_page()") ? CCing =
Peter.
> > >
> > > (3) is possibly wrong. CCing Vivek.
> > >
> > > (4) is what we hit here
> >
> > I guess it was overlooked because try_grab_folio() didn't have any comm=
ent
> > or implication on RCU or IRQ internal helpers being used, hence a bit
> > confusing.  E.g. it has different context requirement on try_grab_page(=
),
> > even though they look like sister functions.  It might be helpful to ha=
ve a
> > better name, something like try_grab_folio_rcu() in this case.
> >
> > Btw, none of above cases (2-4) have real bug, but we're looking at some=
 way
> > to avoid triggering the sanity check, am I right?  I hope besides the h=
ost
> > splash I didn't overlook any other side effect this issue would cause, =
and
> > the splash IIUC should so far be benign, as either gup slow (2,4) or th=
e
> > newly added memfd_pin_folios() (3) look like to have the refcount stabl=
ized
> > anyway.
> >
> > Yang's patch in the other email looks sane to me, just that then we'll =
add
> > quite some code just to avoid this sanity check in paths 2-4 which seem=
s
> > like an slight overkill.
> >
> > One thing I'm thinking is whether folio_ref_try_add_rcu() can get rid o=
f
> > its RCU limitation. It boils down to whether we can use atomic_add_unle=
ss()
> > on TINY_RCU / UP setup too?  I mean, we do plenty of similar things
> > (get_page_unless_zero, etc.) in generic code and I don't understand why
> > here we need to treat folio_ref_try_add_rcu() specially.
> >
> > IOW, the assertions here we added:
> >
> >         VM_BUG_ON(!in_atomic() && !irqs_disabled());
> >
> > Is because we need atomicity of below sequences:
> >
> >         VM_BUG_ON_FOLIO(folio_ref_count(folio) =3D=3D 0, folio);
> >         folio_ref_add(folio, count);
> >
> > But atomic ops avoids it.
>
> Yeah, I didn't think of why atomic can't do it either. But is it
> written in this way because we want to catch the refcount =3D=3D 0 case
> since it means a severe bug? Did we miss something?

Thought more about it and disassembled the code. IIUC, this is an
optimization for non-SMP kernel. When in rcu critical section or irq
is disabled, we just need an atomic add instruction.
folio_ref_add_unless() would yield more instructions, including branch
instruction. But I'm wondering how useful it would be nowadays. Is it
really worth the complexity? AFAIK, for example, ARM64 has not
supported non-SMP kernel for years.

My patch actually replaced all folio_ref_add_unless() to
folio_ref_add() for slow paths, so it is supposed to run faster, but
we are already in slow path, it may be not measurable at all. So
having more simple and readable code may outweigh the potential slight
performance gain in this case?

>
> >
> > This chunk of code was (mostly) originally added in 2008 in commit
> > e286781d5f2e ("mm: speculative page references").
> >
> > In short, I'm wondering whether something like below would make sense a=
nd
> > easier:
> >
> > =3D=3D=3D8<=3D=3D=3D
> > diff --git a/include/linux/page_ref.h b/include/linux/page_ref.h
> > index 1acf5bac7f50..c89a67d239d1 100644
> > --- a/include/linux/page_ref.h
> > +++ b/include/linux/page_ref.h
> > @@ -258,26 +258,9 @@ static inline bool folio_try_get(struct folio *fol=
io)
> >         return folio_ref_add_unless(folio, 1, 0);
> >  }
> >
> > -static inline bool folio_ref_try_add_rcu(struct folio *folio, int coun=
t)
> > -{
> > -#ifdef CONFIG_TINY_RCU
> > -       /*
> > -        * The caller guarantees the folio will not be freed from inter=
rupt
> > -        * context, so (on !SMP) we only need preemption to be disabled
> > -        * and TINY_RCU does that for us.
> > -        */
> > -# ifdef CONFIG_PREEMPT_COUNT
> > -       VM_BUG_ON(!in_atomic() && !irqs_disabled());
> > -# endif
> > -       VM_BUG_ON_FOLIO(folio_ref_count(folio) =3D=3D 0, folio);
> > -       folio_ref_add(folio, count);
> > -#else
> > -       if (unlikely(!folio_ref_add_unless(folio, count, 0))) {
> > -               /* Either the folio has been freed, or will be freed. *=
/
> > -               return false;
> > -       }
> > -#endif
> > -       return true;
> > +static inline bool folio_ref_try_add(struct folio *folio, int count)
> > +{
> > +       return folio_ref_add_unless(folio, count, 0);
> >  }
> >
> >  /**
> > @@ -305,7 +288,7 @@ static inline bool folio_ref_try_add_rcu(struct fol=
io *folio, int count)
> >   */
> >  static inline bool folio_try_get_rcu(struct folio *folio)
> >  {
> > -       return folio_ref_try_add_rcu(folio, 1);
> > +       return folio_ref_try_add(folio, 1);
> >  }
> >
> >  static inline int page_ref_freeze(struct page *page, int count)
> > diff --git a/mm/gup.c b/mm/gup.c
> > index e17466fd62bb..17f89e8d31f1 100644
> > --- a/mm/gup.c
> > +++ b/mm/gup.c
> > @@ -78,7 +78,7 @@ static inline struct folio *try_get_folio(struct page=
 *page, int refs)
> >         folio =3D page_folio(page);
> >         if (WARN_ON_ONCE(folio_ref_count(folio) < 0))
> >                 return NULL;
> > -       if (unlikely(!folio_ref_try_add_rcu(folio, refs)))
> > +       if (unlikely(!folio_ref_try_add(folio, refs)))
> >                 return NULL;
> >
> >         /*
> > =3D=3D=3D8<=3D=3D=3D
> >
> > So instead of adding new code, we fix it by removing some.  There might=
 be
> > some implication on TINY_RCU / UP config on using the atomic_add_unless=
()
> > to replace one atomic_add(), but I'm not sure whether that's a major is=
sue.
> >
> > The benefit is try_get_folio() then don't need a renaming then, because=
 the
> > rcu implication just went away.
> >
> > Thanks,
> >
> > --
> > Peter Xu
> >

