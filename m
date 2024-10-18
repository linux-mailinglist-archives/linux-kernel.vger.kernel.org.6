Return-Path: <linux-kernel+bounces-370945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 245F39A3411
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 07:12:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77D9C2850E7
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 05:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DB5A176AAF;
	Fri, 18 Oct 2024 05:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K4wr8luq"
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274F915FA92
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 05:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729228335; cv=none; b=g0QY6wtLXmj+TX8fi/oI12SpwDSx6cWAYJO81wbXAOXwZ1vgftO0r6l9pcWTqPDHhdCPgkCr2ApIbPmHXHnPU3SXniXioktzvl2REvI5/VjjA42SdvikJ2NKKM+RlxT/wBOmH8tF6mBPfaNfV0AJvunMI2nEnfruAZEShRtpYmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729228335; c=relaxed/simple;
	bh=sJLvliWfX1qICQSlJZ73qPOz+gq9mqQOahhWaLcjzdU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OW0TDknO1rj/Bul+qY1j+cLPqJcAQR3rxLNuRWNzweUtwDKx/Qggk5mod/auX+n+RZr5QPVRY7nL9F3BQ7V41X8KxyjanCrSVlOq+PV5VPzalBIl0GJMqnhvgjUzwO3gvJH1Eu2Mp+ZILvtfFPWsRBcOmHoj3/1nDi8xfcgdz48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K4wr8luq; arc=none smtp.client-ip=209.85.217.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-4a46eeb84a0so475342137.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 22:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729228333; x=1729833133; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rX73uDySRZPSnslBvrVkBMZm6qyXTok8S5JqDFCiT8c=;
        b=K4wr8luqVN6sihHVTYI8QnLA1c4NOFkeF8H6LJ0mlERlyinlSwDQWGM8N3J3cfyRvu
         0ky3iEHojL4bPenwHcdBDJZHn6BNX6JxBB8bPoVBdLrhyJYZ6n5pqz9IeaBA06rR8ySn
         gsRoD9cBecqZ/sJr20PxnUJIDt3M6mrh7lwJ1gbRU/B8ZLYBDkfr/gIcoXl/JxR3D3mF
         C24KPg7cz94XvQh+6c2cY1tarOl3B34N0Or7BF0MfGFMoizoVtMW5Q4gmlzb4bLfo9iB
         sj5kNfR5iJnqO7e6lfYR7oW2Tc5w/hpvWXJkKUAtNJ54M9FqzO/o4rE8sKuom+6YieQ4
         hXAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729228333; x=1729833133;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rX73uDySRZPSnslBvrVkBMZm6qyXTok8S5JqDFCiT8c=;
        b=IxAwuCMcg6QixeRDsESYA0iqIoLIF9rwV3gGqn5YONvyAChdCWKLTPlrJvTpflamQ1
         viYNeek0fY5jEOaI21Si43T8zNiefvB3npH6YwymM+TVSoujnTjS9ZDNbyOAdR+LOFOo
         asl8fTGXUvFxQPQnDDqRqsHfd6BWzkReTdm4kVL73/k6m1ashc/SwCqr2dRV8zgw0REW
         DUMdHDVn6KU3euge6FnmtphJAx+LehxkltqZc9nLXoI0LnuX6oHQ5oJLZF77Q85o7yHR
         Fn9aG5Ko3clD8YHFb6GrzOurK1jspm3lBM6yDyNTqhNtsbVowvl9nxJus3wC8BbDhXux
         OCkg==
X-Forwarded-Encrypted: i=1; AJvYcCVU+zz3+ymdYhr/78eEBfG1vlOVKB3wRtWklPWWIUYXLfIaxzKAtWevHbXyHQcqGQuWkoR7v7qqJhVXgco=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbvLGcuep+1d325xyUQ5PBUFVzq8OjlYLpeRdqhRh29j+iDHtY
	zXq2scNI0Td4HpE6Sma2FOd3RA+h6akwIq/Cxzycd8ImTpkQdomlWrYw+ynPYhMT5Twp6vq9mIt
	hBKQJtE50z8AVnjeKCPBDqb/Zetmihe2sOY4=
X-Google-Smtp-Source: AGHT+IEkuqHATHGcXMZRJ3fXj1L4fQ3FAVXWsPxxA8t6RbaDyMUkXQP0tYPIUPiWKOZwsP33tsZk2wl9FwH+t3bkvgQ=
X-Received: by 2002:a05:6102:b15:b0:4a5:b3e1:f28b with SMTP id
 ada2fe7eead31-4a5d6aa0dfemr564284137.1.1729228332795; Thu, 17 Oct 2024
 22:12:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241016033030.36990-1-21cnbao@gmail.com> <20241016155835.8fadc58d913d9df14099514b@linux-foundation.org>
 <CAGsJ_4xYqSSUE_zq+2UWLT7UsF_ovH=+QE_va+_dcMq4fnz0rg@mail.gmail.com> <ZxFQTlPfR6y25cng@google.com>
In-Reply-To: <ZxFQTlPfR6y25cng@google.com>
From: Barry Song <21cnbao@gmail.com>
Date: Fri, 18 Oct 2024 18:12:01 +1300
Message-ID: <CAGsJ_4zYRCotNTL2kKO202Rk2o78w5pZs25Y_iq=7OfS-KoX9w@mail.gmail.com>
Subject: Re: [PATCH v2] mm: mglru: provide a separate list for lazyfree anon folios
To: Minchan Kim <minchan@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, yuzhao@google.com, linux-mm@kvack.org, 
	david@redhat.com, fengbaopeng@honor.com, gaoxu2@honor.com, 
	hailong.liu@oppo.com, kaleshsingh@google.com, linux-kernel@vger.kernel.org, 
	lokeshgidra@google.com, mhocko@suse.com, ngeoffray@google.com, shli@fb.com, 
	surenb@google.com, v-songbaohua@oppo.com, yipengxiang@honor.com, 
	Gao Xu <gaoxu2@hihonor.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 18, 2024 at 6:58=E2=80=AFAM Minchan Kim <minchan@kernel.org> wr=
ote:
>
> On Thu, Oct 17, 2024 at 06:59:09PM +1300, Barry Song wrote:
> > On Thu, Oct 17, 2024 at 11:58=E2=80=AFAM Andrew Morton
> > <akpm@linux-foundation.org> wrote:
> > >
> > > On Wed, 16 Oct 2024 16:30:30 +1300 Barry Song <21cnbao@gmail.com> wro=
te:
> > >
> > > > To address this, this patch proposes maintaining a separate list
> > > > for lazyfree anon folios while keeping them classified under the
> > > > "file" LRU type to minimize code changes.
> > >
> > > Thanks.  I'll await input from other MGLRU developers before adding
> > > this for testing.
> >
> > Thanks!
> >
> > Hi Minchan, Yu,
> >
> > Any comments? I understand that Minchan may have a broader plan
> > to "enable the system to maintain a quickly reclaimable memory
> > pool and provide a knob for admins to control its size." While I
> > have no objection to that plan, I believe improving MADV_FREE
> > performance is a more urgent priority and a low-hanging fruit at this
> > stage.
>
> Hi Barry,
>
> I have no idea why my email didn't send well before. I sent following
> reply on Sep 24. Hope it works this time.

Hi Minchan,

I guess not. Your *this* email ended up in my spam folder of gmail, and
my oppo.com account still hasn=E2=80=99t received it. Any idea why?

>
> =3D=3D=3D=3D=3D=3D &< =3D=3D=3D=3D=3D=3D
>
> My proposal involves the following:
>
> 1. Introduce an "easily reclaimable" LRU list. This list would hold pages
>    that can be quickly freed without significant overhead.

I assume you plan to keep both lazyfree anon pages and 'reclaimed'
file folios (reclaimed in the normal LRU lists but still in the easily-
reclaimable list) in this 'easily reclaimable' LRU list. However, I'm
not sure this will work, as this patch aims to help reclaim lazyfree
anon pages before file folios to reduce both file and anon refaults.
If we place 'reclaimed' file folios and lazyfree anon folios in the
same list, we may need to revisit how to reclaim lazyfree anon folios
before reclaiming the 'reclaimed' file folios.

>
> 2. Implement a parameter to control the size of this list. This allows fo=
r
>    system tuning based on available memory and performance requirements.

If we include only 'reclaimed' file folios in this 'easily
reclaimable' LRU list, the
parameter makes sense. However, if we also add lazyfree folios to the list,=
 the
parameter becomes less meaningful since we can't predict how many
lazyfree anon folios user space might have. I still feel lazyfree anon foli=
os
are different with "reclaimed" file folios (I mean reclaimed from normal
lists but still in 'easily-reclaimable' list).

>
> 3. Modify kswapd behavior to utilize this list. When kswapd is awakened d=
ue
>    to memory pressure, it should attempt to drop those pages first to ref=
ill
>    free pages up to the high watermark by first reclaiming.
>
> 4. Before kswapd goes to sleep, it should scan the tail of the LRU list a=
nd
>    move cold pages to the easily reclaimable list, unmapping them from th=
e
>    page table.
>
> 5. Whenever page cache hit, move the page into evictable LRU.
>
> This approach allows the system to maintain a pool of readily available
> memory, mitigating the "aging" problem. The trade-off is the potential fo=
r
> minor page faults and LRU movement ovehreads if these pages in ez_reclaim=
able
> LRU are accessed again.

I believe you're aware of an implementation from Samsung that uses
cleancache. Although it was dropped from the mainline kernel, it still
exists in the Android kernel. Samsung's rbincache, based on cleancache,
maintains a reserved memory region for holding reclaimed file folios.
Instead of LRU movement, rbincache uses memcpy to transfer data between
the pool and the page cache.

>
> Furthermore, we could put some asynchrnous writeback pages(e.g., swap
> out or writeback the fs pages) into the list, too.
> Currently, what we are doing is rotate those pages back to head of LRU
> and once writeback is done, move the page to the tail of LRU again.
> We can simply put the page into ez_reclaimable LRU without rotating
> back and forth.

If this is about establishing a pool of easily reclaimable file folios, I
fully support the idea and am eager to try it, especially for Android,
where there are certainly strong use cases. However, I suspect it may
be controversial and could take months to gain acceptance. Therefore,
I=E2=80=99d prefer we first focus on landing a smaller change to address th=
e
madv_free performance issue and treat that idea as a separate
incremental patch set.

My current patch specifically targets the issue of reclaiming lazyfree
anon folios before reclaiming file folios. It appears your proposal is
independent (though related) work, and I don't believe it should delay
resolving the madv_free issue. Additionally, that pool doesn=E2=80=99t effe=
ctively
address the reclamation priority between files and lazyfree anon folios.

In conclusion:

1. I agree that the pool is valuable, and I=E2=80=99d like to develop it as=
 an
incremental patch set. However, this is a significant step that will
require considerable time.
2. It could be quite tricky to include both lazyfree anon folios and
reclaimed file folios (which are reclaimed in normal lists but not in
the 'easily-reclaimable' list) in the same LRU list. I=E2=80=99d prefer to
start by replacing Samsung's rbincache to reduce file folio I/O if we
decide to implement the pool.
3. I believe we should first focus on landing this fix patch for the
madv_free performance issue.

What are your thoughts? I spoke with Yu, and he would like to hear
your opinion.

Thanks
Barry

