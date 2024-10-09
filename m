Return-Path: <linux-kernel+bounces-357683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E81949973FE
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 20:04:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1717D1C24C8C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 18:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C8F11E0E18;
	Wed,  9 Oct 2024 18:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UEbWQLOd"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D35D1E04B5
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 18:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728496994; cv=none; b=LRML9LdVZKmzHKgi08AedhI/NQEZUDg7F4+OW09ijC5JVHqRZu7Z+t2IDwVJEEGwqbOjtmGZbE5JjUQeJzF8uwqntd0TzmSnIjGoJkITWqcnRSXR7ElvXGnE4WmsFWQRHKvY7aOZebEj6v73AYTMyhDi54Xb4GynZFbp4A4PGEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728496994; c=relaxed/simple;
	bh=fttGPIO4izyM9/DwZgQPiZHxDH+bedSP60NZuzpcYcc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q6PncbT+jr2H9WmiFgj1YJtZ4Syv2DaITvjU5kpu6sQeog2hBfiMV90GHSFkFiWpit/e7vetSuhYtpry+AtfjMxS00V1vlFjlYCJimeXFgaBdj7MEQC8+jUo9dpVC+FJkxW/RRNq6u+571+4CH8QhyfNOK3rkN7XLVYPYvz8pa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UEbWQLOd; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2fac3f20f1dso470591fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 11:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728496990; x=1729101790; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I/SkaWaNLkmwU2OCGNzHCKiXLzWnM9lpzvJyZhiMw04=;
        b=UEbWQLOdK2q/0+a00tHp/oYiHBwTp9EUzi2G7hQDGdEzyx3c7TpK3EARSDMbw50kEQ
         YnLIkC7mIkXxw9HWi3OiIzeDT0gvr8PwAub9PlT1EWkMFz4wLL5oScoH/HZk9uakvaHL
         9VqWH9CiFH+ZiQ3UgHY/M7kVONZE09Lry9E9goeSBYXWaLy5kudtRN1GdbVngUe77jC4
         GnNULY703wxPlzabz7IMqUmc3rMwbU2wweOgRfFKNfO8AU9IstfgU8FhRot8MjsKYobz
         iVHxH21oVkjBry8n3AWPMzrpeTbxadCGhZxqxWHiPG0im4J/seQ1+ry+n8vCS0E1bLvT
         lg8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728496990; x=1729101790;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I/SkaWaNLkmwU2OCGNzHCKiXLzWnM9lpzvJyZhiMw04=;
        b=i1WH/BtUhWbiwDq41ZQug0ro9Q8+TzK4gDPuyZ2mq7FHpJafcUCldWl1kBAn3kfv3I
         u9TLWyILtOUw/QmSD8PQC3J75ltGDwjm6usUSKjxlhevG2RPQBCK6HePnMBYNkTTlFiJ
         vq19YcgsC6f4j15lOT5H2m6Nrl0bCrsz6Bv1IHWEYACq8ZsX9fUJ+f5fG53JLvy4TZyc
         cIcRaJ8XJQEEpY3V1ce2PhhpE5H8OAqzFV3iJuvbBA9XcjLovj/SiwvUCnklRSrwbE26
         jUqUbUbcNAdrAqml8y30om7wdJWeP0JrN6SXKgXBUCeNycv+bNxsjy49fMps79ZFd/zF
         jZnw==
X-Forwarded-Encrypted: i=1; AJvYcCWxMlwz1Nlg0N26tXKN8JRz3fGX/52MOR9iMRRfjzDe/q2aAzZSASIpY52e/uN37Llj0LRhX8312TNxtUQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw169qahz3FSiTMTtSbnEe2XdQDpziCplkk0hG6hdWsgdpFrhUf
	A4xXh83dfLz4PmjdFl9FDj46FGZsqL5skdDjJ12eap4JOy8x5WJi8/GeIvM7VVFPaGHIdUwOYnS
	P3JQYLQBrsxG0i3v0r/0mtM12WppkPd0r
X-Google-Smtp-Source: AGHT+IHZyzh/Mxyi1Jxrdf5EN76MOMKzMvBl/ZzQtO/ZjtEYO/apO8MeyW8UYnHxqhIYzZDbVqSfUQmakpeRFyn35sU=
X-Received: by 2002:a2e:d01:0:b0:2f3:ee5a:ab8b with SMTP id
 38308e7fff4ca-2fb187ce9a2mr20127131fa.43.1728496989937; Wed, 09 Oct 2024
 11:03:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+G9fYvo5npQ3o_vgiOX2guHtgafRoFPL__4O8Kcwg2=ssXmKg@mail.gmail.com>
 <e718bc99-e63b-4adb-9e40-2379f48301f5@stanley.mountain> <b22dbfe2-dd29-40de-a4a3-4a0d6b55cd65@stanley.mountain>
 <62a65418-2393-40ec-b462-151605a5efcf@stanley.mountain> <CAMgjq7CapiW2h2pzcKQBhwf_5rs5fgMGHw1E2YJYwEiY6zc=LQ@mail.gmail.com>
 <892332fa-e1d0-4581-9c42-045660d7dc80@stanley.mountain>
In-Reply-To: <892332fa-e1d0-4581-9c42-045660d7dc80@stanley.mountain>
From: Kairui Song <ryncsn@gmail.com>
Date: Thu, 10 Oct 2024 02:02:52 +0800
Message-ID: <CAMgjq7B6cQ2HTPenH6BO66kLhGAPAOu0+ZKNPUhSxs8LGqAuDA@mail.gmail.com>
Subject: Re: next-20241001: WARNING: at mm/list_lru.c:77 list_lru_del
 (mm/list_lru.c:212 mm/list_lru.c:200)
To: Dan Carpenter <dan.carpenter@linaro.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Naresh Kamboju <naresh.kamboju@linaro.org>, open list <linux-kernel@vger.kernel.org>, 
	lkft-triage@lists.linaro.org, Linux Regressions <regressions@lists.linux.dev>, 
	linux-mm <linux-mm@kvack.org>, Arnd Bergmann <arnd@arndb.de>, 
	Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 10, 2024 at 12:51=E2=80=AFAM Dan Carpenter <dan.carpenter@linar=
o.org> wrote:
>
> On Thu, Oct 03, 2024 at 02:58:19AM +0800, Kairui Song wrote:
> > On Wed, Oct 2, 2024 at 7:28=E2=80=AFPM Dan Carpenter <dan.carpenter@lin=
aro.org> wrote:
> > >
> > > On Wed, Oct 02, 2024 at 02:25:34PM +0300, Dan Carpenter wrote:
> > > > On Wed, Oct 02, 2024 at 02:24:20PM +0300, Dan Carpenter wrote:
> > > > > Let's add Kairui Song to the  CC list.
> > > > >
> > > > > One simple thing is that we should add a READ_ONCE() to the compa=
rison.  Naresh,
> > > > > could you test the attached diff?  I don't know that it will fix =
it but it's
> > > > > worth checking the easy stuff first.
> > > > >
> > > >
> > > > Actually that's not right.  Let me write a different patch.
> > >
> > > Try this one.
> > >
> > > regards,
> > > dan carpenter
> > >
> > > diff --git a/mm/list_lru.c b/mm/list_lru.c
> > > index 79c2d21504a2..2c429578ed31 100644
> > > --- a/mm/list_lru.c
> > > +++ b/mm/list_lru.c
> > > @@ -65,6 +65,7 @@ lock_list_lru_of_memcg(struct list_lru *lru, int ni=
d, struct mem_cgroup *memcg,
> > >                        bool irq, bool skip_empty)
> > >  {
> > >         struct list_lru_one *l;
> > > +       long nr_items;
> > >         rcu_read_lock();
> > >  again:
> > >         l =3D list_lru_from_memcg_idx(lru, nid, memcg_kmem_id(memcg))=
;
> > > @@ -73,8 +74,9 @@ lock_list_lru_of_memcg(struct list_lru *lru, int ni=
d, struct mem_cgroup *memcg,
> > >                         spin_lock_irq(&l->lock);
> > >                 else
> > >                         spin_lock(&l->lock);
> > > -               if (likely(READ_ONCE(l->nr_items) !=3D LONG_MIN)) {
> > > -                       WARN_ON(l->nr_items < 0);
> > > +               nr_items =3D READ_ONCE(l->nr_items);
> > > +               if (likely(nr_items !=3D LONG_MIN)) {
> > > +                       WARN_ON(nr_items < 0);
> > >                         rcu_read_unlock();
> > >                         return l;
> > >                 }
> > >
> >
> > Thanks. The warning is a new added sanity check, I'm not sure if this
> > WARN_ON triggered by an existing list_lru leak or if it's a new issue.
> >
> > And unfortunately so far I can't reproduce it locally on my ARM
> > machine, it should be easily reproducible according to the
> > description. And if the WARN only triggered once, and only during
> > boot, mayce some static data wasn't initialized correctly?
>
> I have a config where it printed twice and the second time wasn't during =
boot.
>
> https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20241009/=
testrun/25363339/suite/boot/test/gcc-13-lkftconfig-rcutorture/log
>
> > Or the enablement of memcg caused some list_lru leak
> > (mem_cgroup_from_slab_obj changed from returning NULL to returning
> > actual memcg, so a item added to rootcg before will be attempt removed
> > from actual memcg, seems a real race). If it's the latter case, then
> > it's an existing issue caught by the new sanity check.
> >
> > The READ_ONCE patch may be worth trying, I'll also try to do more
> > debugging on this and try to send a fix later.
>
> The READ_ONCE() patch *seemed* to work, but the bug is intermittent so ma=
ybe it
> just changed the timing or something.  Still, I feel from a correctness
> perspective the READ_ONCE() thing is probably correct, right?
>

Yes, the READ_ONCE fix is absolutely correct.

Not sure if it's possible in theory, that the compiler or CPU will use
the old value for the `WARN`, but use a new read value for the `if` above.
This READ_ONCE will prevent that from happening, if possible.

I think we should just merge the READ_ONCE fix, and see if any more
tests expose this issue again.

