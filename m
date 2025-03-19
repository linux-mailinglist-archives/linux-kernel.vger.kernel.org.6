Return-Path: <linux-kernel+bounces-568034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C5A5A68D40
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 13:55:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE3EE16FC62
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 12:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B52BF255241;
	Wed, 19 Mar 2025 12:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="kvPCDVX4"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3495250F8
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 12:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742388814; cv=none; b=TblsdeyLeZFe9P7J6PRuo8xaGAUoPzHzWpqhzlmpHGil0FswEKcJpW/EjO8PCgJ9/xUuJ7ucqEhGVUezotRgB8082efc3wg5fol1OA6vf/1lCvEHJuhVCbz0vQohBUyIwhb12m0APXQSJu6Uaho5sqj2vMXn7suqlQkID52ECSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742388814; c=relaxed/simple;
	bh=338OaKNj90+BaNz516Hf5a5MWt0OXgFPbuybfHomPDw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QcyqNPBUoZKY/BxKmtTIRink0pCfySzVMqU4+W4OPyVlpjJqVBDopJEwoajzG9BGUdC9YbIvVmtLBGPwpP+tVGC5T6ddXSWYj15b7VSQWS5+LWE1p8TdWSzuPpYQouywvAOazVpfRC+G6RN+QIL7eC7Zwe5GpW6cd/5s1nGr87o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=kvPCDVX4; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-307bc125e2eso76064781fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 05:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1742388810; x=1742993610; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gdbbRT580Qu8som9Q+94gaoUxidIl9ZdI8AmdFOecEw=;
        b=kvPCDVX4MhjIqwQf85LeHXbV5IJUTtFYdKC+y2O73wW9koP6dbtYtzPttC43tNXldb
         Va4X8mFfMk5r+RWNHLM/mYTOuXZlr0FtS1LmnLeqpDyfI1jpg17AYoQ8oDn/hxroaUC4
         SZTP8rPhiy+hki58QdVuLR3d9ZbKowfvB81om4DYiNpOXEmb2uOFARaAEwYKnIKOqU+W
         wnIzjRwVraAmk+PGZIQY7BL5nV+qJhA6abHRglWQViR9Mr82jujbwBHRm1GQe3oTCB1c
         r/4y6UtYAF4g5VFArvtTo2GJ0fodIIskwDl+NqHm/mFSA7FE6wBOBkxj0yxafMm3RHCM
         qzFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742388810; x=1742993610;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gdbbRT580Qu8som9Q+94gaoUxidIl9ZdI8AmdFOecEw=;
        b=it3jf+HRA/fGowtC8Dk8qTQRK7yrsY9OOjiT5BKfmR2zWlQREy06n/WBiqq1XB+XGv
         Ldjo73NuB3YwsNX29qabLML87FXnqKK7VBYau9S8CmIoSLBEJQSt76BRPH00km7Aj8h0
         HdquonNSPyyup7L5Jew7+/NjVhzjJe6GzfxmlTmjXegypPurnlU4mPGiuhdvosyGrEFR
         gfzyBeNsAAHBKMmGWf4sln/P7PtxrgNww5S6cWpRW3tqQFSjUJDJKPsnmG2UHIh/EQ7y
         VQTfQ4kNrqd2moZgKiJV9ku4mB3XdsJIabX2eIVvuHg2QvfhvMfvaI/ZcJL4n9YCpuJh
         UjHA==
X-Forwarded-Encrypted: i=1; AJvYcCUOc+z9MONcQAIxr72Q1tyeIgMcvpBCU5YAExvqOBPkujUclz1twil1ulnOBowqiZUBM8npY+IM1bTHSCI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7DEzIkJk42kAyg4PiWvS8Z+VVlGrbCeScnJM5n+5aE0JT+5PX
	i0/FE/FKzydZaNhX3i5tDgaJJpZ1sawjZHOqY2hnS13vEC+0MuC3KtV2MJ5V9vtGgadFgxLXefs
	avsLD1ulxBOCEKB7ahQWaYNa8VzPi33z0f8hBHQ==
X-Gm-Gg: ASbGncs/ix5EiVKabUaLmnHPkmL8xZfFwCH1Uj3pqlAT+anxbyu15oncQfaaeomslL2
	dIKWp81C9LZuG1h0TYd5ne3OhCsBZ8mbAS8Kav3Oz4pgCltE9ciX4Dz+AhkORf2ksFQtLjiTIxp
	uId4yXRQfFUCt/1SdkH/s76jOKshwrqFYvgxcGBtlY
X-Google-Smtp-Source: AGHT+IEue5MPU3PrM7P5n1w/XUtEMRe9CztvHOb/x9ccIXDa/TEpEX6z/VLk/2ZMWMshfhUTw5KhlQFlX9J29bAdIZA=
X-Received: by 2002:a05:6512:1090:b0:545:5a5:b69d with SMTP id
 2adb3069b0e04-54acb1d5c3emr1019159e87.31.1742388809845; Wed, 19 Mar 2025
 05:53:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250318135330.3358345-1-hezhongkun.hzk@bytedance.com>
 <Z9l-x-b9W32vE8Qn@google.com> <CACSyD1PZVVep7Do6WWOMTFr_qhzskxZtXEaqpCtk9JcR3X1L-A@mail.gmail.com>
 <Z9pWFBSdfg4lGg85@google.com>
In-Reply-To: <Z9pWFBSdfg4lGg85@google.com>
From: Zhongkun He <hezhongkun.hzk@bytedance.com>
Date: Wed, 19 Mar 2025 20:52:52 +0800
X-Gm-Features: AQ5f1JrCfe0A7QX7Ogw-Wxu_Uv7MELXV8NyoE_mruM1hLG8-Q0_vn2WF4cDoa64
Message-ID: <CACSyD1OSFiRA91UVDOkKBF0_c6y2OZWPYkmwuizjG1FnUUHdvw@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] mm: add swappiness=max arg to
 memory.reclaim for only anon reclaim
To: Yosry Ahmed <yosry.ahmed@linux.dev>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, yuzhao@google.com, 
	mhocko@suse.com, muchun.song@linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 19, 2025 at 1:29=E2=80=AFPM Yosry Ahmed <yosry.ahmed@linux.dev>=
 wrote:
>
> On Wed, Mar 19, 2025 at 10:34:54AM +0800, Zhongkun He wrote:
> > On Tue, Mar 18, 2025 at 10:10=E2=80=AFPM Yosry Ahmed <yosry.ahmed@linux=
.dev> wrote:
> > >
> > > On Tue, Mar 18, 2025 at 09:53:30PM +0800, Zhongkun He wrote:
> > > > With this patch 'commit <68cd9050d871> ("mm: add swappiness=3D arg =
to
> > > > memory.reclaim")', we can submit an additional swappiness=3D<val> a=
rgument
> > > > to memory.reclaim. It is very useful because we can dynamically adj=
ust
> > > > the reclamation ratio based on the anonymous folios and file folios=
 of
> > > > each cgroup. For example,when swappiness is set to 0, we only recla=
im
> > > > from file folios.
> > > >
> > > > However,we have also encountered a new issue: when swappiness is se=
t to
> > > > the MAX_SWAPPINESS, it may still only reclaim file folios.
> > > >
> > > > So, we hope to add a new arg 'swappiness=3Dmax' in memory.reclaim w=
here
> > > > proactive memory reclaim only reclaims from anonymous folios when
> > > > swappiness is set to max. The swappiness semantics from a user
> > > > perspective remain unchanged.
> > > >
> > > > For example, something like this:
> > > >
> > > > echo "2M swappiness=3Dmax" > /sys/fs/cgroup/memory.reclaim
> > > >
> > > > will perform reclaim on the rootcg with a swappiness setting of 'ma=
x' (a
> > > > new mode) regardless of the file folios. Users have a more comprehe=
nsive
> > > > view of the application's memory distribution because there are man=
y
> > > > metrics available. For example, if we find that a certain cgroup ha=
s a
> > > > large number of inactive anon folios, we can reclaim only those and=
 skip
> > > > file folios, because with the zram/zswap, the IO tradeoff that
> > > > cache_trim_mode or other file first logic is making doesn't hold -
> > > > file refaults will cause IO, whereas anon decompression will not.
> > > >
> > > > With this patch, the swappiness argument of memory.reclaim has a ne=
w
> > > > mode 'max', means reclaiming just from anonymous folios both in tra=
ditional
> > > > LRU and MGLRU.
> > >
> > > Is MGLRU handled in this patch?
> >
> > Yes, The value of ONLY_ANON_RECLAIM_MODE is 201, and the MGLRU select t=
he
> > evictable type like this:
> >
> > #define evictable_min_seq(min_seq, swappiness)              \
> >     min((min_seq)[!(swappiness)], (min_seq)[(swappiness) <=3D MAX_SWAPP=
INESS])
> >
> > #define for_each_evictable_type(type, swappiness)           \
> >     for ((type) =3D !(swappiness); (type) <=3D ((swappiness) <=3D
> > MAX_SWAPPINESS); (type)++)
> >
> > if the swappiness=3D0, the type is LRU_GEN_FILE(1);
> >
> > if the swappiness=3D201 (>MAX_SWAPPINESS),
> >   for ((type) =3D 0; (type) <=3D 0); (type)++)
> > The type is always LRU_GEN_ANON(0).
>
> Zhongkun, I see that you already sent a new version. Please wait until
> discussions on a patch are resolved before sending out newer versions,
> and allow more time for reviews in general.

Got it, thanks.

>
> I think this is too subtle, and it's easy to miss. Looking at the MGLRU
> code it seems like there's a lot of swappiness <=3D MAX_SWAPPINESS checks=
,
> and I am not sure why these already exist given that swappiness should
> never exceed MAX_SWAPPINESS before this change.
>
> Are there other parts of the MGLRU code that are already using
> swappiness values > MAX_SWAPPINESS?

IIUC, The MGLRU can already use the value of MAX_SWAPPINESS + 1 to
reclaim only anonymous folios. Please have a look:
 lru_gen_seq_write()->run_cmd():
    else if (swappiness > MAX_SWAPPINESS + 1)
        goto done;  /*so MAX_SWAPPINESS + 1 is OK */

in inc_min_seq():
  if (type ? swappiness > MAX_SWAPPINESS : !swappiness)
        goto done;  //skip LRU_GEN_FILE when swappiness is
                           //MAX_SWAPPINESS + 1

//Skip  LRU_GEN_FILE when swappiness is MAX_SWAPPINESS + 1.
 #define for_each_evictable_type(type, swappiness)           \
     for ((type) =3D !(swappiness); (type) <=3D ((swappiness) <=3D
    MAX_SWAPPINESS); (type)++)

So the /sys/kernel/debug/lru_gen can accept the value of swappiness + 1
for proactive reclamation, meaning it only reclaims anonymous pages.

But the above statement is just my guess. It would be great if Yu could cla=
rify.
If my description is incorrect, please correct me.

>
> Yu, could you help us making things clearer here? I would like to avoid
> relying on current implementation details that could easily be missed
> when making changes. Ideally we'd explicitly check for
> SWAPPINESS_ANON_ONLY.
>

Looking forward to Yu's reply.

Thanks.

