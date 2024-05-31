Return-Path: <linux-kernel+bounces-197280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03BB28D68AB
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 20:05:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E3C3B287A2
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 18:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2E9617C9EB;
	Fri, 31 May 2024 18:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CM8EZ1uk"
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B06515B99F
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 18:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717178678; cv=none; b=DmGFJNNUQM92zVm6p2p0Uq17Vy6cfHMIB7WlKjoJHqdjj1PbQtf2Shu2BgM+YGYOVzZCHYzUOQXnEA+xpyzahYOCoLu/FGE3CLVolMQzH07k1EErJ4aBDpdyB+hI92VYPUEj3IjpbTeHXTtarC0Upm0KXvLkxkpBkRa+fTE0kBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717178678; c=relaxed/simple;
	bh=EzjE65Kz4LvJT4hRxLlPgk+qCuo0nSvK1ZnNuO/vDQs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Cggc3RloxDVz63tf7/aPIyQnf8IA7a4nNeBOFBuXd1vKmgA/ZSP30vvBTiqaW0MdqAu2Ca4U/GK/LuHcaJQSMDvr6hiTvV0UYlRKeDaIaAmuBsdFdOz7cr3CNfqAi5ZgEUI67ALAZOPNA7T+ozzX0doKqOIrVsNiO/qGi2U/4RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CM8EZ1uk; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-dfa72e97dfeso1033875276.1
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 11:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717178676; x=1717783476; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HfTfA1pAaQTMxSVE2Twz55nEqsHzsr+JodUe0ZaWjik=;
        b=CM8EZ1ukwGgZG+xY9cDzakQhebF8yotGttvHtk4rC71/G7iw8bvJlS8AM8PXSIw105
         GGLjQQ2hAOjP5Up1MqgjviRfPuij5uBDKRxqmg1wGp3q0T/6gfFFYx6ifHMaUvPpEvMq
         AK1SIv1cGAezS/ZuQ0LAw2odYQHBQAwGgZpzwFhRntcQuwodIE8taeqXW1PKgjiMZ9ic
         8DZFtv5pNNWz+SaCkEm+kpt7CsdPeL34fhd3ePoR4Mmh2SNC/yzUehFUHLOEcxSpWsKs
         ZDXfBVQn5pAuTX5bWiImVsP+ZgWcurzE7bh9UYOBKgqwnjIiTVGs4+TpCFA7dzPqKDkO
         QOlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717178676; x=1717783476;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HfTfA1pAaQTMxSVE2Twz55nEqsHzsr+JodUe0ZaWjik=;
        b=fcKKvQzAwrTbUqzdjrO3xj8BJkgTcEFcrCBvZ2sKnwWKzY0OgSlevaTcZ1ZKTiSafN
         YEvf+W0BzKTVD4SF1+5gyqlSQCGa8L06P9oJNmB5tfg6FDaD6CnuVVnENWkRdmKX55El
         ZSbZqK5l4oIcJCmKrwzDJpc43DNo+JBlaV4oNXk9Las7YWcuwYKcedclkgdCIUgIYYVR
         eB3PRXBrinf7DnVQOUG8gDMWPsW9DsazipaQx7l4yrnwnxgtG/IT6phkH4MJ0a/WmmDu
         1j2oSQK2T64Eu92A4wF7U+AHdikHFNnfDUwHa+GQZGpFJCYmPusG1mu4eg/4QTGQjhat
         dj7g==
X-Forwarded-Encrypted: i=1; AJvYcCX8O76yoYKGMe9/6S0O8BTNwVqqq9f+0wY1Dp8QvOohkqNoGZm/zxAqVoR0SBFHFnbiVxTzyHAcTbACsa9uOB20r0WLKe0M2LPQ470y
X-Gm-Message-State: AOJu0YznsNqKR0YlHR6hDBlpsnsv2fLyPdVbhqcvqXUyDBtO5UIggV0e
	Q1rDOTnzYjGUKBK4yObwtwiogBIfvx8/x2NBqq7XpjPrgKSLqZwMuyrnVyzDjoiGBbnq9lCnK3M
	PS8xRg7Q3LWhPXHyuTISen4nwh8E=
X-Google-Smtp-Source: AGHT+IHZ7DzbFO/XPeTe08EYDWHAjg5vZfkwMpAq2QcBpNCFaEg5A5YyrZzevmndi7U2DXiwqUlyRPv+8X4RDj+5MhI=
X-Received: by 2002:a25:c58b:0:b0:de5:5bca:ecb0 with SMTP id
 3f1490d57ef6-dfa72ec2cf9mr2624477276.0.1717178675951; Fri, 31 May 2024
 11:04:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240531092001.30428-1-byungchul@sk.com> <20240531092001.30428-10-byungchul@sk.com>
 <fab1dd64-c652-4160-93b4-7b483a8874da@intel.com>
In-Reply-To: <fab1dd64-c652-4160-93b4-7b483a8874da@intel.com>
From: Byungchul Park <lkml.byungchul.park@gmail.com>
Date: Sat, 1 Jun 2024 03:04:24 +0900
Message-ID: <CAHyrMpxETdVewTH3MCS4qPyD6Xf1zRUfWZf-8SCdpCFj2Pj_Wg@mail.gmail.com>
Subject: Re: [PATCH v11 09/12] mm: implement LUF(Lazy Unmap Flush) defering
 tlb flush when folios get unmapped
To: Dave Hansen <dave.hansen@intel.com>
Cc: Byungchul Park <byungchul@sk.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	kernel_team@skhynix.com, akpm@linux-foundation.org, ying.huang@intel.com, 
	vernhao@tencent.com, mgorman@techsingularity.net, hughd@google.com, 
	willy@infradead.org, david@redhat.com, peterz@infradead.org, luto@kernel.org, 
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, rjgolo@gmail.com
Content-Type: text/plain; charset="UTF-8"

Dave Hansen <dave.hansen@intel.com> wrote:
>
> On 5/31/24 02:19, Byungchul Park wrote:
> ..
> > diff --git a/include/linux/fs.h b/include/linux/fs.h
> > index 0283cf366c2a..03683bf66031 100644
> > --- a/include/linux/fs.h
> > +++ b/include/linux/fs.h
> > @@ -2872,6 +2872,12 @@ static inline void file_end_write(struct file *file)
> >       if (!S_ISREG(file_inode(file)->i_mode))
> >               return;
> >       sb_end_write(file_inode(file)->i_sb);
> > +
> > +     /*
> > +      * XXX: If needed, can be optimized by avoiding luf_flush() if
> > +      * the address space of the file has never been involved by luf.
> > +      */
> > +     luf_flush();
> >  }
> ..
> > +void luf_flush(void)
> > +{
> > +     unsigned long flags;
> > +     unsigned short int ugen;
> > +
> > +     /*
> > +      * Obtain the latest ugen number.
> > +      */
> > +     spin_lock_irqsave(&luf_lock, flags);
> > +     ugen = luf_gen;
> > +     spin_unlock_irqrestore(&luf_lock, flags);
> > +
> > +     check_luf_flush(ugen);
> > +}
>
> Am I reading this right?  There's now an unconditional global spinlock

It looked *too much* to split the lock to several locks as rcu does until
version 11.  However, this code introduced in v11 looks problematic.

> acquired in the sys_write() path?  How can this possibly scale?

I should find a better way.

> So, yeah, I think an optimization is absolutely needed.  But, on a more
> fundamental level, I just don't believe these patches are being tested.
> Even a simple microbenchmark should show a pretty nasty regression on
> any decently large system:
>
> > https://github.com/antonblanchard/will-it-scale/blob/master/tests/write1.c
>
> Second, I was just pointing out sys_write() as an example of how the
> page cache could change.  Couldn't a separate, read/write mmap() of the
> file do the same thing and *not* go through sb_end_write()?
>
> So:
>
>         fd = open("foo");
>         ptr1 = mmap(fd, PROT_READ);
>         ptr2 = mmap(fd, PROT_READ|PROT_WRITE);
>
>         foo = *ptr1; // populate the page cache
>         ... page cache page is reclaimed and LUF'd
>         *ptr2 = bar; // new page cache page is allocated and written to

I think this part would work but I'm not convinced.  I will check again.

>         printk("*ptr1: %d\n", *ptr1);
>
> Doesn't the printk() see stale data?
>
> I think tglx would call all of this "tinkering".  The approach to this
> series is to "fix" narrow, specific cases that reviewers point out, make
> it compile, then send it out again, hoping someone will apply it.

Sorry for not perfect work and bothering you but you know what?  I
can see what is happening in this community too.  Of course, I bet
you would post better quality mm patches from the 1st version than
me but might not in other subsystems.

> So, for me, until the approach to this series changes: NAK, for x86.

I understand why you got mad and feel sorry but I couldn't expect
the regression you mentioned above.  And I admit the patches have
had problems I couldn't find in advance until you, Hildenbrand and
Ying.  I will do better.

> Andrew, please don't take this series.  Or, if you do, please drop the
> patch enabling it on x86.

I don't want to ask to merge either, if there are still issues.

> I also have the feeling our VFS friends won't take kindly to having

That is also what I thought it was.  What should I do then?
I don't believe you do not agree with the concept itself.  Thing is
the current version is not good enough.  I will do my best by doing
what I can do.

> random luf_foo() hooks in their hot paths, optimized or not.  I don't
> see any of them on cc.

Yes.  I should've cc'd them.  I will.

        Byungchul

