Return-Path: <linux-kernel+bounces-395617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90D1E9BC09B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 23:09:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46A5E1F22A08
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 22:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19A191FDF84;
	Mon,  4 Nov 2024 22:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uSLckBCh"
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DBC41CC896
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 22:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730758130; cv=none; b=VfVz6iQGSPrh8W4MLprKCRn9C2dFBa8HWl7H2s3VmlMxsyR/MwV9peqBaTCqMArzlartTZ8sP/vsNmuhowMw9gKubgQQK4yBoIEf68IktuUEVjT2Glx1P7oN0tusLtm2W0AavuucL+0anMLtD3BvHlJzf83U0c2+gE3jefoCyeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730758130; c=relaxed/simple;
	bh=9yjeDW7FoGcBbhm0devgQq4gJaurLSzw3WjNMqN4Dig=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lBKm2h8Rb3SWAe4ZI0KyuysqQQgqxpLi64AkFSnlHMcQUp+coXlaWckrDv4jbwLeteTNpDbPWQiujoHO6QRMHDVQjSlYMefEq3y/HperFjhYs80spLj4tXaIePjvLqfxBapYmJ0iq9zHlMwNfJBSZw5aiHMk2HAl+QWTVohOwzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uSLckBCh; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-71815313303so2341276a34.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 14:08:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730758127; x=1731362927; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RZeJLhuGWwBpR2tgn/q1fig0IFTgvv0Juwu0EbDl2cM=;
        b=uSLckBChR4CZ8NkFOf1nqPO2CHNER3OOygaKDRVqNGI/tJY4BKAa0mSQFMk8wxDWSB
         dwyv4NE/cnoJXExoJGNyMn+NJGdgl5ybRDbMR6KTWbVqTl/IyZVm4V5k7gkzhqRr2rRf
         xUceynD4sniCFgI1dThsELe9pb4QHfGBZ9s+AbZxOWDvbDqfatPrE2y04NZMuD1xesG7
         nlbhfm5zm/evzmaZNTVY0QilLB76DoxcRKGLTVsokzz/1bRLG3SzoTmxIF1pvtGbLkPk
         Jt6VaDAJajmmnEe870TxtCoRryRic9MDfZi+YAfBy/guqVZ12Ktb36DLrwmWdFpl6vbj
         9oRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730758127; x=1731362927;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RZeJLhuGWwBpR2tgn/q1fig0IFTgvv0Juwu0EbDl2cM=;
        b=cITOeglNxZk20hPsrr4KgPYQZBckAqvxcTRKXLx3Pew1zvJoOLXzqqA6Z1QzMuoxFP
         mokLa4sOfIW/4rjDPydko8i3BnvoqyOBhoeQltwweRv5yd2SAYpe0CKYHeaahuDQV3gH
         xVohFcH7IzID49NHZtWvgYWl/ZoY7tM+oP9KpD2w1IzR3JxU3ZIowjj4bvrB6i2QFZKf
         W0Ksr4mh/S10ZSTdRuXGTmGII4DIZahuxCp17dIeaimkZGsQDYrnnNmkQheisz4GoKO/
         89D8+8ATFZ8wC6O9BonIp0z0q97AN3UkxdEYJbd82fubzPAmi+8Ypz2l/ERIck/Bum1U
         xfGw==
X-Forwarded-Encrypted: i=1; AJvYcCVF16KzJG6oTSEItBq7Q3GlgvVNS6D/oexF9PPRqkUUkW8zQE2wmCjQN5SfdfRP549bpzAcJEs07pxUtKg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBCSDxKIsZG6VdWVqG4/TtD9gOukyOpsR+14WVdaZAkR1Btn6e
	kP4K+1i7Bc8/OdtBOK1i7msZVf7B3RXcwS4EZfR18+xSwA8Sv5273cWUukylW+2IDT2Z9uosNSg
	9l3yiyP/cotb4OUFYh1MB/znjaVUfy8VL/bqQ
X-Google-Smtp-Source: AGHT+IFln5ARziviEZ5W8gZPhQEpbPGFJcy1tmyEkI9GsLY6a3qE2HayVDbKUpLBXHlxdIKA1VRIzX1NSAfBlC47kKc=
X-Received: by 2002:a05:6358:7254:b0:1ad:10eb:cd39 with SMTP id
 e5c5f4694b2df-1c3f9f7979amr1643843155d.26.1730758126978; Mon, 04 Nov 2024
 14:08:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241025012304.2473312-1-shakeel.butt@linux.dev>
 <20241025012304.2473312-6-shakeel.butt@linux.dev> <iwmabnye3nl4merealrawt3bdvfii2pwavwrddrqpraoveet7h@ezrsdhjwwej7>
 <CAOUHufZexpg-m5rqJXUvkCh5nS6RqJYcaS9b=xra--pVnHctPA@mail.gmail.com>
 <ZykEtcHrQRq-KrBC@google.com> <20241104133834.e0e138038a111c2b0d20bdde@linux-foundation.org>
 <CAOUHufbA6GN=k3baYdvLN_xSQvX0UgA7OCeqT8TsWLEW7o=y9w@mail.gmail.com>
In-Reply-To: <CAOUHufbA6GN=k3baYdvLN_xSQvX0UgA7OCeqT8TsWLEW7o=y9w@mail.gmail.com>
From: Yu Zhao <yuzhao@google.com>
Date: Mon, 4 Nov 2024 15:08:09 -0700
Message-ID: <CAOUHufZ=SMN=GWMjvpDxiXxyMAvDDc4eEzYvAWP4=7atT7SX7g@mail.gmail.com>
Subject: Re: [PATCH v1 5/6] memcg-v1: no need for memcg locking for MGLRU
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Shakeel Butt <shakeel.butt@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Hugh Dickins <hughd@google.com>, 
	Yosry Ahmed <yosryahmed@google.com>, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-doc@vger.kernel.org, Meta kernel team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 4, 2024 at 3:04=E2=80=AFPM Yu Zhao <yuzhao@google.com> wrote:
>
> On Mon, Nov 4, 2024 at 2:38=E2=80=AFPM Andrew Morton <akpm@linux-foundati=
on.org> wrote:
> >
> > On Mon, 4 Nov 2024 10:30:29 -0700 Yu Zhao <yuzhao@google.com> wrote:
> >
> > > On Sat, Oct 26, 2024 at 09:26:04AM -0600, Yu Zhao wrote:
> > > > On Sat, Oct 26, 2024 at 12:34=E2=80=AFAM Shakeel Butt <shakeel.butt=
@linux.dev> wrote:
> > > > >
> > > > > On Thu, Oct 24, 2024 at 06:23:02PM GMT, Shakeel Butt wrote:
> > > > > > While updating the generation of the folios, MGLRU requires tha=
t the
> > > > > > folio's memcg association remains stable. With the charge migra=
tion
> > > > > > deprecated, there is no need for MGLRU to acquire locks to keep=
 the
> > > > > > folio and memcg association stable.
> > > > > >
> > > > > > Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> > > > >
> > > > > Andrew, can you please apply the following fix to this patch afte=
r your
> > > > > unused fixup?
> > > >
> > > > Thanks!
> > >
> > > syzbot caught the following:
> > >
> > >   WARNING: CPU: 0 PID: 85 at mm/vmscan.c:3140 folio_update_gen+0x23d/=
0x250 mm/vmscan.c:3140
> > >   ...
> > >
> > > Andrew, can you please fix this in place?
> >
> > OK, but...
> >
> > > --- a/mm/vmscan.c
> > > +++ b/mm/vmscan.c
> > > @@ -3138,7 +3138,6 @@ static int folio_update_gen(struct folio *folio=
, int gen)
> > >       unsigned long new_flags, old_flags =3D READ_ONCE(folio->flags);
> > >
> > >       VM_WARN_ON_ONCE(gen >=3D MAX_NR_GENS);
> > > -     VM_WARN_ON_ONCE(!rcu_read_lock_held());
> > >
> > >       do {
> > >               /* lru_gen_del_folio() has isolated this page? */
> >
> > it would be good to know why this assertion is considered incorrect?
>
> The assertion was caused by the patch in this thread. It used to
> assert that a folio must be protected from charge migration. Charge
> migration is removed by this series, and as part of the effort, this
> patch removes the RCU lock.
>
> > And a link to the sysbot report?
>
> https://syzkaller.appspot.com/bug?extid=3D24f45b8beab9788e467e

Or this link would work better:

https://lore.kernel.org/lkml/67294349.050a0220.701a.0010.GAE@google.com/

