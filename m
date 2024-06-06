Return-Path: <linux-kernel+bounces-204842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03ECF8FF425
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 19:55:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 640ADB24BA0
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 17:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD0CE199239;
	Thu,  6 Jun 2024 17:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UFz6Ngti"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A582AD33
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 17:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717696542; cv=none; b=L8/IWLFi9sVJWoo6Seyjz8tb0Lm/EXVa01HsZgYgo+HasiU0DCwssBztIz4Trwee+P58Snl+xM3QmobyTvtHnLs7KDWhN2t2kywWZX/TbeCOQmcvAwq3jszMlh7/06caE6Ng7VXr7zpIinaOoQgGxadCYJLYMyKABZI+JzZ8aEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717696542; c=relaxed/simple;
	bh=/yCc8X23HbQjK6B0gNq9QaoLe3NQmV9C/0upEheNEK8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HE+yh4UXPBNgAGHijP8DEU+pv8JLQgM0kLvN/zCyGv+kbi5F23aF9f/p1YUf7BURc967yE0Yx0MoLcX6qB+dr5MmPA+pOrdQiSNh7A89eAa8hMLV9vFb6JUf7XvpQEApBV/JorJy1nZ+62tGp1EzCn1+wUsjr6KswAQcDR0u5Yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UFz6Ngti; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4215b888eabso7115e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 10:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717696539; x=1718301339; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=70T0ZceHUGMDadFXNyVFFMOsXxBYbdVP4L874egq+7s=;
        b=UFz6NgtiyFDHL/4b2Yf9GMkkuglQ2MLasuAKwKAy5njjO6XEfznSZNy3KjVd7tx3JG
         Y4fHtPEK1TmkbTAApA7qu44OTRc6yBEebUPeyN6wrocRYBw639PiXzclUHEOJWD3NPg7
         dO4hGmjJFtu6XRUVvHZnd1aokM5HPkU6pAxLXZEgx+Ahf79/mSmdzfWibaXkV2sMhx31
         0ZZ+CoRkSidqVjxBuSo0npDWH2pysrkwUdj3w72bNCd98M9yADu+8U4FOBVhpGce5v3J
         wbySSU7tE4AakQsnJ7y/MVpDHvdtCrNkPG+4fFzTUIVrOMI6zCdZYHHXqQNqMWtgr9Em
         dhsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717696539; x=1718301339;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=70T0ZceHUGMDadFXNyVFFMOsXxBYbdVP4L874egq+7s=;
        b=Dn9o6aZLI3ZwMKlNp6OzXXF8v9AIuyyq+l41OPBoks8TsFNHI1i4Fd2D2s3I4DAHir
         BnmgYpTfm1/RzOx3RXi31+yu6j75L1/Jri8sHq34yOatTNhHuLr9yDTqHas6Eqyr0dYU
         /Srmw5gxarmAvdS/KJseLqfmqu0rJHGHiG01pRq2TR+G1+UWBz/Dgi9yagB+NGDSbF6o
         FRoPJTyUsjupYZuMWT2BXMlcgUAwIgRG7OSoXPUM0IJxo3YDFxf7LiMirspiR5BABV78
         cGgB2b/JpY+QwBUhnjLrCJJIN4Te8KwbeO0IX9ObqZNOa09svTc5Au+Wsvag8wSSrL1A
         8PoA==
X-Forwarded-Encrypted: i=1; AJvYcCVDgTBT/nZiwjkjBBPJLfPLWuecRTiuI61jXaBKLO/5Plj4Zk95zUZlkPjTn4jAXhidAHIALxnqlytRrPY3MPejRsZwY8m6NYHgwZsw
X-Gm-Message-State: AOJu0YzSBhOk9NhAz9GwnGUQw2vO8VOjDN7I1IpopdZRqLBia/QbEA4r
	gXkhicZb636Ck2HitzNZkejXOML3oxV1CJcn8At3MHduGefNoepTQmIbkdyHPzbCEnOsZwMg29i
	9uxcgTweecvfAyZRhvnlwGSeS5M2akUhkX+Uc
X-Google-Smtp-Source: AGHT+IFZtJxK7Ij2aoXQ49eZ6ipGl1snqySio37b8bnykUERrojlAvUSBz+QPxv9HYNFs66SlKfYn193ri6nP3w5/YA=
X-Received: by 2002:a05:600c:1c90:b0:421:5288:8360 with SMTP id
 5b1f17b1804b1-4215b327e13mr2782465e9.0.1717696538477; Thu, 06 Jun 2024
 10:55:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240508202111.768b7a4d@yea> <20240515224524.1c8befbe@yea>
 <CAOUHufZ-9NmzOKjLedvZFp0=N0LvRZn77qC6k1WXK+NHtKr=0w@mail.gmail.com>
 <CAOUHufZ36rQc8AfLtRv2QrEareysdvbprAEO5XkcG-FeDOxFLA@mail.gmail.com>
 <20240602200332.3e531ff1@yea> <20240604001304.5420284f@yea>
 <CAJD7tkbCRLdy0vD2Pd17fNrxHgkzW1VucN4qMkohLFLBLaaeCQ@mail.gmail.com>
 <20240604134458.3ae4396a@yea> <CAJD7tkYjJJGthQ_8NukGw6Q9EYbLA=8sAH_7=B90KXEL6HWdSw@mail.gmail.com>
 <CAOUHufa0Fpj6SjNgB-z0n5Jg63q1ewkbOAU65forpDwQVs45qg@mail.gmail.com>
 <CAJD7tkb=5GJ9SNUwDsu1Zy3Tus4rjsNo60Hg9N7=gGth409Diw@mail.gmail.com>
 <CAOUHufb6zXr14Wm3T-4-OJh7iAq+vzDKwVYfHLhMMt96SpiZXg@mail.gmail.com>
 <CAJD7tkZ+QY55GTzW9A7ZCm=rxAEfrW76cWXf8o5nwiKSXp8z=w@mail.gmail.com>
 <20240604231019.18e2f373@yea> <CAJD7tkYq5u7B+0UH2XKpeWJnUxoO2kJ1_XZ2JOgYpyNEVR7u0g@mail.gmail.com>
 <20240606010431.2b33318c@yea> <CAJD7tkbhWYzx=6YmzAh0F+cK-_Bn8mPOH7gMbQS7YVXmaFSgFg@mail.gmail.com>
 <CAPpoddc2vOLdQJ7HwG7x+=oZsTz221+YJcNbUtKvPjA9AyeY2w@mail.gmail.com> <CAJD7tkb2b0+4_m0gb8DKSTtRwtC2GMa9NF5RuGKhXJARYHK0gw@mail.gmail.com>
In-Reply-To: <CAJD7tkb2b0+4_m0gb8DKSTtRwtC2GMa9NF5RuGKhXJARYHK0gw@mail.gmail.com>
From: Yu Zhao <yuzhao@google.com>
Date: Thu, 6 Jun 2024 11:55:00 -0600
Message-ID: <CAOUHufZ_dKpts4uW4Xg3jVYnX5Z5MN9U9icxhP0Nmz7QnqurBQ@mail.gmail.com>
Subject: Re: kswapd0: page allocation failure: order:0, mode:0x820(GFP_ATOMIC),
 nodemask=(null),cpuset=/,mems_allowed=0 (Kernel v6.5.9, 32bit ppc)
To: Yosry Ahmed <yosryahmed@google.com>, Takero Funaki <flintglass@gmail.com>
Cc: Erhard Furtner <erhard_f@mailbox.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, Johannes Weiner <hannes@cmpxchg.org>, 
	Nhat Pham <nphamcs@gmail.com>, Chengming Zhou <chengming.zhou@linux.dev>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Minchan Kim <minchan@kernel.org>, 
	"Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 6, 2024 at 11:42=E2=80=AFAM Yosry Ahmed <yosryahmed@google.com>=
 wrote:
>
> On Thu, Jun 6, 2024 at 10:14=E2=80=AFAM Takero Funaki <flintglass@gmail.c=
om> wrote:
> >
> > 2024=E5=B9=B46=E6=9C=886=E6=97=A5(=E6=9C=A8) 8:42 Yosry Ahmed <yosryahm=
ed@google.com>:
> >
> > > I think there are multiple ways to go forward here:
> > > (a) Make the number of zpools a config option, leave the default as
> > > 32, but allow special use cases to set it to 1 or similar. This is
> > > probably not preferable because it is not clear to users how to set
> > > it, but the idea is that no one will have to set it except special us=
e
> > > cases such as Erhard's (who will want to set it to 1 in this case).
> > >
> > > (b) Make the number of zpools scale linearly with the number of CPUs.
> > > Maybe something like nr_cpus/4 or nr_cpus/8. The problem with this
> > > approach is that with a large number of CPUs, too many zpools will
> > > start having diminishing returns. Fragmentation will keep increasing,
> > > while the scalability/concurrency gains will diminish.
> > >
> > > (c) Make the number of zpools scale logarithmically with the number o=
f
> > > CPUs. Maybe something like 4log2(nr_cpus). This will keep the number
> > > of zpools from increasing too much and close to the status quo. The
> > > problem is that at a small number of CPUs (e.g. 2), 4log2(nr_cpus)
> > > will actually give a nr_zpools > nr_cpus. So we will need to come up
> > > with a more fancy magic equation (e.g. 4log2(nr_cpus/4)).
> > >
> >
> > I just posted a patch to limit the number of zpools, with some
> > theoretical background explained in the code comments. I believe that
> > 2 * CPU linearly is sufficient to reduce contention, but the scale can
> > be reduced further. All CPUs are trying to allocate/free zswap is
> > unlikely to happen.
> >  How many concurrent accesses were the original 32 zpools supposed to
> > handle? I think it was for 16 cpu or more. or nr_cpus/4 would be
> > enough?
>
> We use 32 zpools on machines with 100s of CPUs. Two zpools per CPU is
> an overkill imo.

Not to choose a camp; just a friendly note on why I strongly disagree
with the N zpools per CPU approach:
1. It is fundamentally flawed to assume the system is linear;
2. Nonlinear systems usually have diminishing returns.

For Google data centers, using nr_cpus as the scaling factor had long
passed the acceptable ROI threshold. Per-CPU data, especially when
compounded per memcg or even per process, is probably the number-one
overhead in terms of DRAM efficiency.



> I have further comments that I will leave on the patch, but I mainly
> think this should be driven by real data, not theoretical possibility
> of lock contention.

