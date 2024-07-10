Return-Path: <linux-kernel+bounces-248341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7559492DBE5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 00:29:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C25C2861E5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 22:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EC7E1494CE;
	Wed, 10 Jul 2024 22:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="T6z+AU0s"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA3114AD3D
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 22:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720650583; cv=none; b=Ws1TpHYTs+fMHLaKJzEWlefayiGzg9yzkzxJto51SeyCXCo6gMErU/qnqGy+laDpDh/SVz7hAcTR/KTbBUdZy3ZPyT7rYrMG32Hfd/5QsgOMdMqkE1I663lpaF/6b6Cx0i7N+NI1YuQ8PV8TvVt6tb3C0dawekeEdnnDnm+bC5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720650583; c=relaxed/simple;
	bh=rsM6wOIIuPtiTXHYi0ZYdEkTXszm2PRQO/8IL35wGpA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rwxr9na9Xl0bWAOIPCSxO2XnGm0ZllFaiiZkTTnX2YTjzZCrufonaarirPcGadzst6OdzLt85hrCC4R2i3am11TzHy2zMcmhQAUqRDb+Rw++Yw0ICOV2qgPncKlF/NdFy16wza+h79mkG5uoRW0Bj/1VdH4WfnwCreDsPAR7OmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=T6z+AU0s; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2c2c6b27428so229452a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 15:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1720650579; x=1721255379; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4NTgih/I/qtspn9wPSsT5PQdbbKiYuSLrBWTOJWi/Yo=;
        b=T6z+AU0s8w6gBLmADCXNMWbBsHGbY+tyinUxuEH/OO0q6Wg9FiImX3vui2ZkY52XYR
         wWiDFDtWYaCfgTLpPuoTndyQ1H3OQ6FJq3XrLMTPwRdVoqhb3VUvEM+74iSgFLMA9J+1
         SK9SJFvC22mefOQz4eKZTJxqesD3Ej5lDMMmwARPCJgeOne4FP7n8vXLcZ36XmwAAwNS
         unRhQqWMH2LSDrhlNlVR5B/scKOSiQr5zz5h4zxMcZhkgK9WJ1vGhnfNmQZLd9/nTMZ6
         dD1DZaZYuPij2sCklOStYQz5FRDCMZU5LS3zf1sqpycORsqKxsvt1s698FlcY5eTZoAx
         /J2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720650579; x=1721255379;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4NTgih/I/qtspn9wPSsT5PQdbbKiYuSLrBWTOJWi/Yo=;
        b=nRc2VGVVivhfDoj74HfHDqXQTPzpfFuGrB33qFq42VyBKa9VCpzaAPxDtu546HBQNq
         IFStaTT+qNlf1HWzmUdGRx4VjrX2XKVvCU8YTw0NCKrcq3UgUevgR3bdGQhP/vmRGxJ5
         LS0UIwZisdMI328wQmCn0o+NaPb1RknBUTELs2tLygj5MarOzN4r9+BGAMfKgrPSDv0N
         74Cv5wsCkX8bo6pGi+MRkZzCfRXPtiR7/epoFHtWyz2yewrCtk0uouwN1D9tjm1T0Qm5
         CMW0yMr6EfbhRw284tkgwf50s/MYhnNFjAwlZikxsxMHogtw1Um2Y6A49l7vpG/cfyaB
         4HWQ==
X-Forwarded-Encrypted: i=1; AJvYcCWWfqd3G6E7bA/ylCft49+a6xX7P94O+UOZCkObDpo3ecVDmRMNh7yG+IzNmVQt4R1+FLECkGgkB5IWkqs4iXHcJblqngVzPLDuj40v
X-Gm-Message-State: AOJu0YxivOYxvhIe0WfcEYgEeTWbP2uA4n0pFIbP8ulkcNj1IpleQZFN
	9TmeBDvh9Z8cvVU4iaRY6LmU7BN6Svon3OZCQg6KnjhdW0M/tnqFO48+LFmbXkclf2Z/O0ib4GY
	NBF+V9e4Z5s0Kz7lfoYPRzcfc2RJ15i6SnrEXRg==
X-Google-Smtp-Source: AGHT+IEG0fJWzbKu94wc/lGrrWrq4ZTcQCHpdjfNmMcuIOCOrmIosFxlMKcxuEkUwIgTY3hOtUi5EqpS3gyOLgsysHw=
X-Received: by 2002:a17:90a:9a81:b0:2c9:60ea:2f11 with SMTP id
 98e67ed59e1d1-2ca35bd24a5mr5291639a91.1.1720650579090; Wed, 10 Jul 2024
 15:29:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240708232302.15267-1-cachen@purestorage.com>
 <20240708232302.15267-2-cachen@purestorage.com> <CAM9d7cisBvfLTzNp8=0SG6g3CA9zJFNayjopSEDX0fxRyG05UA@mail.gmail.com>
In-Reply-To: <CAM9d7cisBvfLTzNp8=0SG6g3CA9zJFNayjopSEDX0fxRyG05UA@mail.gmail.com>
From: Casey Chen <cachen@purestorage.com>
Date: Wed, 10 Jul 2024 15:29:27 -0700
Message-ID: <CALCePG0_PpwKK_=YrpCGr-j51dG8xtDP-yzBYGeLwphscFobRg@mail.gmail.com>
Subject: Re: [PATCH 1/1] perf tool: fix handling NULL al->maps returned from thread__find_map
To: Namhyung Kim <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	yzhong@purestorage.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 8, 2024 at 10:01=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> Hello,
>
> On Mon, Jul 8, 2024 at 4:23=E2=80=AFPM Casey Chen <cachen@purestorage.com=
> wrote:
> >
> > With 0dd5041c9a0e ("perf addr_location: Add init/exit/copy functions"),
> > thread__find_map() would return with al->maps or al->map being NULL
> > when cpumode is 3 (macro PERF_RECORD_MISC_HYPERVISOR),
> > later deferencing on it would crash.
> >
> > Fix callers of thread__find_map() or thread__find_symbol() to handle
> > this.
>
> It looks like you drop the callchain if it doesn't find a map/symbol.
> Can we keep the entries with raw hex numbers instead?
>
In add_callchain_ip(), my change let it return if either al.maps is
NULL or al.map is NULL after thread__find_symbol(), I'm not sure what
else can add_callchain_ip() could do to keep raw hex numbers. If it
proceeds, al.sym is NULL, the code inside 'if (al.sym !=3D NULL)' would
skip. callchain_srcline() would return NULL. chain_cursor_append()
would append a node whose ms.maps/ ms.map are NULL. Later
dereferencing them would cause trouble. But we could add other
information to the node, like ip, branch, nr_loop_iter, iter_cycles,
branch_from, are these information good to have ? but how to avoid
dereferencing NULL maps/map later.

Thanks
Casey

> Thanks,
> Namhyung
>
> > ---
> >  tools/perf/arch/powerpc/util/skip-callchain-idx.c | 10 ++++++----
> >  tools/perf/util/machine.c                         |  5 +++++
> >  tools/perf/util/unwind-libdw.c                    |  6 ++++--
> >  3 files changed, 15 insertions(+), 6 deletions(-)
> >
> > diff --git a/tools/perf/arch/powerpc/util/skip-callchain-idx.c b/tools/=
perf/arch/powerpc/util/skip-callchain-idx.c
> > index 5f3edb3004d8..25b0804df4c4 100644
> > --- a/tools/perf/arch/powerpc/util/skip-callchain-idx.c
> > +++ b/tools/perf/arch/powerpc/util/skip-callchain-idx.c
> > @@ -255,13 +255,14 @@ int arch_skip_callchain_idx(struct thread *thread=
, struct ip_callchain *chain)
> >
> >         thread__find_symbol(thread, PERF_RECORD_MISC_USER, ip, &al);
> >
> > -       if (al.map)
> > -               dso =3D map__dso(al.map);
> > +       if (!al.map)
> > +               goto out;
> > +
> > +       dso =3D map__dso(al.map);
> >
> >         if (!dso) {
> >                 pr_debug("%" PRIx64 " dso is NULL\n", ip);
> > -               addr_location__exit(&al);
> > -               return skip_slot;
> > +               goto out;
> >         }
> >
> >         rc =3D check_return_addr(dso, map__start(al.map), ip);
> > @@ -282,6 +283,7 @@ int arch_skip_callchain_idx(struct thread *thread, =
struct ip_callchain *chain)
> >                 skip_slot =3D 3;
> >         }
> >
> > +out:
> >         addr_location__exit(&al);
> >         return skip_slot;
> >  }
> > diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> > index 8477edefc299..fa4037d7f3d4 100644
> > --- a/tools/perf/util/machine.c
> > +++ b/tools/perf/util/machine.c
> > @@ -2098,7 +2098,12 @@ static int add_callchain_ip(struct thread *threa=
d,
> >                         }
> >                         goto out;
> >                 }
> > +
> >                 thread__find_symbol(thread, *cpumode, ip, &al);
> > +               if (!al.maps || !al.map) {
> > +                       err =3D 1;
> > +                       goto out;
> > +               }
> >         }
> >
> >         if (al.sym !=3D NULL) {
> > diff --git a/tools/perf/util/unwind-libdw.c b/tools/perf/util/unwind-li=
bdw.c
> > index b38d322734b4..fb038ef55be2 100644
> > --- a/tools/perf/util/unwind-libdw.c
> > +++ b/tools/perf/util/unwind-libdw.c
> > @@ -53,8 +53,10 @@ static int __report_module(struct addr_location *al,=
 u64 ip,
> >          */
> >         thread__find_symbol(ui->thread, PERF_RECORD_MISC_USER, ip, al);
> >
> > -       if (al->map)
> > -               dso =3D map__dso(al->map);
> > +       if (!al->map)
> > +               return -1;
> > +
> > +       dso =3D map__dso(al->map);
> >
> >         if (!dso)
> >                 return 0;
> > --
> > 2.45.2
> >
> >

