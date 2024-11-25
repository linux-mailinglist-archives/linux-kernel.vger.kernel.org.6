Return-Path: <linux-kernel+bounces-421598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E73C9D8D68
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 21:32:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C287728713A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 20:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30D4E1B983F;
	Mon, 25 Nov 2024 20:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aZ2NN0bT"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE8B6F06D
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 20:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732566714; cv=none; b=SEbKwwFHJ/ZSoUwoMnfDvmVogq8RGdem7zWqNggjBArVAY44KYGSVFUkz3SRDifza8fBQg6BFoQhyxeg3C/1nWfXX9Pj7o4/6fr0+jD3BBlp/beXMMLlNT3MBnDtASpF7bAxsAYffy2UiWMZNWQ8uRmm4/ALYbRKFqxryQ3q6QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732566714; c=relaxed/simple;
	bh=3y6V5xZiKfxWwSM+Q5xnh3mfjccV9GX03ldgQt17L7I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qN71lOVBGhX91PzteWPM85V4wmk/rRDYX5RJQR33qwI2VZHCjI6lpUXr4ZBwOWrQKPtAMy6hGY/1ljn4Q+DhB9UbQFadu1pMqEy2U3oDAJiGbWiWEVTEc4QtUT3fv1r1bDzSba6KRP9ESJHOokQqANTT0wUKStkJ7qN/tI2HmTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aZ2NN0bT; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4668194603cso42291cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 12:31:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732566712; x=1733171512; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Ab/QR87gHQWLvLxH20mfzD3ANxyoigyKfQaJpRefi4=;
        b=aZ2NN0bTRM/HkF/o8vdH2vL9fxsxPav6LNTs8LBQO+q/rvVb+AEz0u9yjYbuQkQ2rg
         /LOBEg3+h+yYzCHzQE+F30yYVrI+6OXH/5cvgSkJdWcu89N9Ean3teK/5OW6e5mGhElD
         iLa9hTDB56zMyU0F788W5cMdjed9W3BwVbMd0mxDVkffzblvqeqRbVIfgI4emhJ/OAAv
         B48BC8mkxyxyimwXEyxoAMAIoLktaMsUhxspxI10MQnNCtC237ugi7OHM5dp3qj21jH+
         YtKwAa4lfYJQRA/bbcJorXgmgz8X/Dl51xwwUUCv8AAMSaUWcQ9JPA+UWBW4eRVdATV5
         CRyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732566712; x=1733171512;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1Ab/QR87gHQWLvLxH20mfzD3ANxyoigyKfQaJpRefi4=;
        b=UygFU2utPxdc6PiaXsXIylkznQf2m7XVuHAYbrwJ14qr+Rnm6KgbKpL/M42LwautDA
         wBJ9Q0ahtbYs0R2qb+14n5oG85zuEfRl1H4oV4xw6szz/cXD9vAqkoF76eoAI2luWDxR
         82zHBQ2I85CjX7Xp6hD5IjsOR3+SphNOvazyQnEuNbIr94tr9Jd+LBurp/KltB41ghPN
         17tFoeLm2wvoDK2AyHaUvAtcXRUO9MYTAiaGM45KIF0sDTPpbhB9sSNkimk44MAtkwS3
         H5gvdJqoFoQ6Fq3Y4uPnyCcg8SipwwddciVNq70z7XNZGvTmq3WQs4cKKIuifE9To0nK
         a4GQ==
X-Forwarded-Encrypted: i=1; AJvYcCVhXTGGUXI3YtJC4qrhEqLukNn/FfgCrdQhHAxSBlv1x0x1Rstk4cfeePSDf57jhmTuIQGAY1RbHn2WRxY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqxsOgjKPhZkU2NStFO3tyo4COkCSZv/54AIff9jNRLlwrddAM
	H+ZQAgengK9MBj1pk6FrvLih/Fw1TlzouuXKir3EaWrEO2QZpERX4sf2YKAQzrs/eqFe8xxSzct
	MJ9fwQxjowrhCn0D06g+OiGBl6CA3MBudYAQH
X-Gm-Gg: ASbGncsk+mFmV60CWL7EX1YVWd2LOYxkvuYsWAAzDdsTrlI7wGwW4ev9h7RtRQQ6QnQ
	ZhTciSxJXgPclXlh0hz0GTiyX/gmlW/Y=
X-Google-Smtp-Source: AGHT+IFDJT5MZI5hdeyw/bAOG9V5fSlHAqmK9qtrvQPcwnXLXhuZ0emMvJGoRrA+cEkJPt1VYLUKL0UCigT7m8VN/VY=
X-Received: by 2002:a05:622a:1c0b:b0:466:9660:18a2 with SMTP id
 d75a77b69052e-466a4821350mr483581cf.16.1732566711535; Mon, 25 Nov 2024
 12:31:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241124074318.399027-1-00107082@163.com> <CAJuCfpHviS-pw=2=BNTxp1TnphjuiqWGgZnq84EHvbz08iQ6eg@mail.gmail.com>
 <70bad55f.b656.19362cca6ee.Coremail.00107082@163.com> <CAJuCfpHho8se-f4cnvk0g1YLNzhvG3q8QTYmvMmweUnGAhtA=g@mail.gmail.com>
In-Reply-To: <CAJuCfpHho8se-f4cnvk0g1YLNzhvG3q8QTYmvMmweUnGAhtA=g@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 25 Nov 2024 12:31:39 -0800
Message-ID: <CAJuCfpEP-xMzHonsE3uV1uYahXehR007B5QX9KjdZdHBWyrXwQ@mail.gmail.com>
Subject: Re: Abnormal values show up in /proc/allocinfo
To: David Wang <00107082@163.com>
Cc: kent.overstreet@linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 25, 2024 at 9:31=E2=80=AFAM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> On Mon, Nov 25, 2024 at 2:10=E2=80=AFAM David Wang <00107082@163.com> wro=
te:
> >
> >
> > Hi,
> >
> > Some update
> >
> > I reproduce the abnormal values of "func:compaction_alloc" today, just =
once. But I have not found a deterministic procedure yet.
> > Seems to me, it happens when kcompactd starts to work
> >
> >     ret_from_fork(100.000% 57/57)
> >         kthread(100.000% 57/57)
> >             kcompactd(100.000% 57/57)
> >                 compact_node(100.000% 57/57)
> >                     compact_zone(100.000% 57/57)
> >                         migrate_pages(100.000% 57/57)
> >                             migrate_pages_batch(100.000% 57/57)
> >                                 compaction_alloc(100.000% 57/57)
> >
> >
> > Maybe, kcompactd mess up information needed by memory tracking? Just a =
wild guess.
> > And those negative signed values, and underflowed unsigned values could=
 also be the side-effect of memory compaction.
> > A wilder guess....
>
> Ok, thanks! I think that's enough for me to start digging. Will post
> an update once I find something.
> Thanks,
> Suren.
>
> >
> >
> >
> > FYI
> > David
> >
> >
> >
> >
> > At 2024-11-25 08:35:54, "Suren Baghdasaryan" <surenb@google.com> wrote:
> > >On Sat, Nov 23, 2024 at 11:43=E2=80=AFPM David Wang <00107082@163.com>=
 wrote:
> > >>
> > >> Hi,
> > >>
> > >> I am running 6.12.0 for a week, and today I notice several strange
> > >> items in /proc/allocinfo:
> > >>
> > >>        -4096 18446744073709551615 mm/filemap.c:3787 func:do_read_cac=
he_folio
> > >>  -1946730496 18446744073709076340 mm/filemap.c:1952 func:__filemap_g=
et_folio
> > >>   -903294976 18446744073709331085 mm/readahead.c:263 func:page_cache=
_ra_unbounded
> > >>   -353054720 18446744073709465421 mm/shmem.c:1769 func:shmem_alloc_f=
olio
> > >>  10547565210        0 mm/compaction.c:1880 func:compaction_alloc
> > >>   -156487680 18446744073709513411 mm/memory.c:1064 func:folio_preall=
oc
> > >>  -2422685696 18446744073708960140 mm/memory.c:1062 func:folio_preall=
oc
> > >>  -2332479488 18446744073708982163 fs/btrfs/extent_io.c:635 [btrfs] f=
unc:btrfs_alloc_page_array
> > >>
> > >> some values are way too large, seems like corrupted/uninitialized, a=
nd values for compaction_alloc
> > >> are inconsistent: non-zero size with zero count.
> > >>
> > >> I do not know when those data became this strange, and I have not re=
boot my system yet.
> > >> Do you guys need extra information before I reboot my system and sta=
rted to try reproducing?
> > >
> > >Hi David,
> > >Thanks for reporting. Can you share your .config file? Also, do you
> > >see these abnormal values shortly after boot or does it take time for
> > >them to get into abnormal state?
> > >I'll take a look on Monday and see if there is an obvious issue and if
> > >I can reproduce this.

Hi David,
Could you please check if you have this fix:

ed265529d39a "mm/codetag: fix arg in pgalloc_tag_copy alloc_tag_sub"

It was merged after v6.12-rc6 and it fixes an accounting bug inside
pgalloc_tag_copy(), which is used during compaction.
Thanks,
Suren.


https://lore.kernel.org/all/20240906042108.1150526-3-yuzhao@google.com/
https://lore.kernel.org/all/20241022232440.334820-1-souravpanda@google.com/

> > >Thanks,
> > >Suren.
> > >
> > >>
> > >>
> > >> Thanks
> > >> David
> > >>
> > >>
> > >>
> > >>

