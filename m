Return-Path: <linux-kernel+bounces-385945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0CF09B3D64
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 23:03:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FC8D289835
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 22:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83EEE1F4267;
	Mon, 28 Oct 2024 21:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kruces-com.20230601.gappssmtp.com header.i=@kruces-com.20230601.gappssmtp.com header.b="VrNPN6eB"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E658C1F4263
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 21:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730152581; cv=none; b=JL3/IC7JdsGd5WJoZcwKKVVZ/EVe+3iI3lsg9rHDVXcNu7WUEOHsye8S517iojy2AvNZi4CjuxrHg5P+N2ORAgCRSFJudcdNbV4Wsf1g5OH3O+ViDI881AhyOxDOgHCXYDkR5/3q/NQFxZoP4qaZCmCAWnxBcws1SB7Gkxq0nec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730152581; c=relaxed/simple;
	bh=b3YInCy/u1fqsZj0Shaluhv41U/l3cQiYFh5DB7oUVw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=fig7cqXuB/S0yZpRFaig7LiEiSSDT6WMkRP1xK78Zl0YNb+17MwSIroEAGIFq6ABhuGNGngY4O2Zt266wyqEFpb2uWalUO/JgRSOx+rSuw7Tmwmf5C5Usoe7m8LcMWERC63FeFPh1AF7fp7g14twBKzPm2E54XYIrXa6Ayi4Wy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kruces.com; spf=pass smtp.mailfrom=kruces.com; dkim=pass (2048-bit key) header.d=kruces-com.20230601.gappssmtp.com header.i=@kruces-com.20230601.gappssmtp.com header.b=VrNPN6eB; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kruces.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kruces.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a99e3b3a411so932492166b.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 14:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kruces-com.20230601.gappssmtp.com; s=20230601; t=1730152577; x=1730757377; darn=vger.kernel.org;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b3YInCy/u1fqsZj0Shaluhv41U/l3cQiYFh5DB7oUVw=;
        b=VrNPN6eBpbS9Ktnk2ojbrEQJP4YKCD9oSFgmJBroeg/FZqegrqHouz7+Z/0SzhO9KP
         uhuZWOF+zT//ZOzFGne+9CsRVP/gbT/0BWFSOskaOn0R2DBeEoka1PJD+uE0Esv13LfQ
         B8//tqi7mUhwuNZXxuIhh0cQr/yqAVXvOCkhA+dsT8h2fU3bppmBbn523D+mYH1OKnx7
         tfltP/n9NfHTHqChh2QP99YUj+mxrtt5bW8UUiiZQ+CUSahb+QhLNDf+pi6G5KS8qx8a
         el94jZRt8o2/RNvNBA0M8ypY2t097sUI8AURzIvKHBUN1p6bAAduhuiqa2ZtwI7jb1sF
         Z4xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730152577; x=1730757377;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=b3YInCy/u1fqsZj0Shaluhv41U/l3cQiYFh5DB7oUVw=;
        b=oQ1GY0d7A8f8lOao1D4vr2tA4Jw6OIQ7g0Hrz8JMIEDFaopRg7fg/Ltgir+PbgWx3V
         c9GCJK7GxkOOZQYdmnUih4i3MOnV7EfqQQAHZwwBFcowvLyzfq8TvkNalTACaKs9TZyT
         QDJTXWgSuuXTUVezOKuQf7a73ewS5Lmm/XzlHmzFd82cYm+MO/PQZ7Fej+1cGc8Ufn1s
         y+jsXCd5YMnrCbY6naNj0cLITtXt5FCba0027Zu6Sn+tUb2zljGQqT/u9NCQkUmLKBGB
         CcO4K7gFOFF2FGqvgfkQleUk4+6EZP3kkHQOUuc6+FVESunX9M7DwbYMhnM9IYElxzwg
         l5Mg==
X-Forwarded-Encrypted: i=1; AJvYcCVuxNrhEaQ4peWLzxOi3NfGqEbR0OA2TbDSjm/E6CFS6o4w7JDBaBVtdIZxtVXiWrg8684TJBw4jryheaI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3+QksAgD0oXevNLojdcdlGeWY33UiJvLrSDSiuAwnuzW1aAJn
	KdV6G5zdSmDBuRARXsM+SJGsuY5Z/RaKhWNN9nnRYD4mPAkV2JeeUwRBW0M6ypM=
X-Google-Smtp-Source: AGHT+IERPrEOhpPVB7RdZhvQZ/Zjp5f2pTrwA6ldA/PVGUWSwSABELjXqI9J3It3J6qGSNvLvWOPdg==
X-Received: by 2002:a17:906:6a14:b0:a99:4e74:52aa with SMTP id a640c23a62f3a-a9e22b3b4acmr109292766b.33.1730152576931;
        Mon, 28 Oct 2024 14:56:16 -0700 (PDT)
Received: from localhost (89-23-255-189.ip4.fiberby.net. [89.23.255.189])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b1f29a934sm409096466b.118.2024.10.28.14.56.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Oct 2024 14:56:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 28 Oct 2024 22:56:14 +0100
Message-Id: <D57RWGA2IIFD.2EWIDM7HVYF5U@kruces.com>
Subject: Re: [RFC PATCH v3 0/4] Support large folios for tmpfs
Cc: "Matthew Wilcox" <willy@infradead.org>, <akpm@linux-foundation.org>,
 <hughd@google.com>, <wangkefeng.wang@huawei.com>, <21cnbao@gmail.com>,
 <ryan.roberts@arm.com>, <ioworker0@gmail.com>, <linux-mm@kvack.org>,
 <linux-kernel@vger.kernel.org>, "Kirill A . Shutemov"
 <kirill.shutemov@linux.intel.com>
To: "David Hildenbrand" <david@redhat.com>, "Baolin Wang"
 <baolin.wang@linux.alibaba.com>, "Daniel Gomez" <da.gomez@samsung.com>,
 "Kirill A. Shutemov" <kirill@shutemov.name>
From: "Daniel Gomez" <d@kruces.com>
X-Mailer: aerc 0.18.2
References: <cover.1728548374.git.baolin.wang@linux.alibaba.com>
 <Zw_IT136rxW_KuhU@casper.infradead.org>
 <e1b6fa05-019c-4a40-afc0-bc1efd15ad42@linux.alibaba.com>
 <6dohx7zna7x6hxzo4cwnwarep3a7rohx4qxubds3uujfb7gp3c@2xaubczl2n6d>
 <8e48cf24-83e1-486e-b89c-41edb7eeff3e@linux.alibaba.com>
 <CGME20241021085439eucas1p10a0b6e7c3b0ace3c9a0402427595875a@eucas1p1.samsung.com> <ppgciwd7cxmeqssryshe42lxwb4sdzr6gjhwwbotw4gx2l7vi5@7y4hedxpf4nx> <D51IU4N746MI.FDS6C7GYO4RP@samsung.com> <c59f2881-fbbb-41b1-830d-9d81f36ecc0b@linux.alibaba.com> <486a72c6-5877-4a95-a587-2a32faa8785d@redhat.com> <7eb412d1-f90e-4363-8c7b-072f1124f8a6@linux.alibaba.com> <1b0f9f94-06a6-48ac-a68e-848bce1008e9@redhat.com> <D53Z7I8D6MRB.XN14XUEFQFG7@kruces.com> <cbadd5fe-69d5-4c21-8eb8-3344ed36c721@redhat.com>
In-Reply-To: <cbadd5fe-69d5-4c21-8eb8-3344ed36c721@redhat.com>

On Fri Oct 25, 2024 at 10:21 PM CEST, David Hildenbrand wrote:
> Sorry for the late reply!
>
> >>>>> IMHO, as I discussed with Kirill, we still need maintain compatibil=
ity
> >>>>> with the 'huge=3D' mount option. This means that if 'huge=3Dnever' =
is set
> >>>>> for tmpfs, huge page allocation will still be prohibited (which can
> >>>>> address Hugh's request?). However, if 'huge=3D' is not set, we can
> >>>>> allocate large folios based on the write size.
> >=20
> > So, in order to make tmpfs behave like other filesystems, we need to
> > allocate large folios by default. Not setting 'huge=3D' is the same as
> > setting it to 'huge=3Dnever' as per documentation. But 'huge=3D' is mea=
nt to
> > control THP, not large folios, so it should not have a conflict here, o=
r
> > else, what case are you thinking?
>
> I think we really have to move away from "huge/thp =3D=3D PMD", that's a=
=20
> historical artifact. Everything else will simply be inconsistent and=20
> confusing in the future -- and I don't see any real need for that. For=20
> anonymous memory and anon shmem we managed the transition. (there is a=20
> longer writeup from me about this topic, so I won't go into detail).
>
>
> I think I raised this in the past, but tmpfs/shmem is just like any=20
> other file system .. except it sometimes really isn't and behaves much=20
> more like (swappable) anonymous memory. (or mlocked files)
>
> There are many systems out there that run without swap enabled, or with=
=20
> extremely minimal swap (IIRC until recently kubernetes was completely=20
> incompatible with swapping). Swap can even be disabled today for shmem=20
> using a mount option.
>
> That's a big difference to all other file systems where you are=20
> guaranteed to have backend storage where you can simply evict under=20
> memory pressure (might temporarily fail, of course).
>
> I *think* that's the reason why we have the "huge=3D" parameter that also=
=20
> controls the THP allocations during page faults (IOW possible memory=20
> over-allocation). Maybe also because it was a new feature, and we only=20
> had a single THP size.
>
> There is, of course also the "fallocate() might not free up memory if=20
> there is an unexpected reference on the page because splitting it will=20
> fail" problem, that even exists when not over-allocating memory in the=20
> first place ...
>
>
> So ...I don't think tmpfs behaves like other file system in some cases.=
=20
> And I don't think ignoring these points is a good idea.

Assuming a system without swap, what's the difference you are concern
about between using the current tmpfs allocation method vs large folios
implementation?

>
> Fortunately I don't maintain that code :)
>
>
> If we don't want to go with the shmem_enabled toggles, we should=20
> probably still extend the documentation to cover "all THP sizes", like=20
> we did elsewhere.
>
> huge=3Dnever: no THPs of any size
> huge=3Dalways: THPs of any size (fault/write/etc)
> huge=3Dfadvise: like "always" but only with fadvise/madvise
> huge=3Dwithin_size: like "fadvise" but respect i_size
>
> We could think about adding a "nowaste" extension and try make it the=20
> default.
>
> For example
>
> "huge=3Dalways:nowaste: THPs of any size as long as we don't over-allocat=
e=20
> memory (write)"

This is the default behaviour in other fs too. I don't think is
necessary to make it explicit.

>
> The sysfs toggles have their beauty as well and could be useful (I'm=20
> pretty sure they will be useful :) ):
>
> "huge=3Dalways;sysfs": THPs of any size (fault/write/etc) as configured i=
n=20
> sysfs.
>
> Too many options here to explore, too little time I have to spend on=20
> this. Just to throw out some ideas.
>
> What I can really suggest is not making this one of the remaining=20
> interfaces where "huge" means "PMD-sized" once other sizes exist.
>
> >=20
> >>>>
> >>>> I consider allocating large folios in shmem/tmpfs on the write path =
less
> >>>> controversial than allocating them on the page fault path -- especia=
lly
> >>>> as long as we stay within the size to-be-written.
> >>>>
> >>>> I think in RHEL THP on shmem/tmpfs are disabled as default (e.g.,
> >>>> shmem_enabled=3Dnever). Maybe because of some rather undesired
> >>>> side-effects (maybe some are historical?): I recall issues with VMs =
with
> >>>> THP+ memory ballooning, as we cannot reclaim pages of folios if
> >>>> splitting fails). I assume most of these problematic use cases don't=
 use
> >>>> tmpfs as an ordinary file system (write()/read()), but mmap() the wh=
ole
> >>>> thing.
> >>>>
> >>>> Sadly, I don't find any information about shmem/tmpfs + THP in the R=
HEL
> >>>> documentation; most documentation is only concerned about anon THP.
> >>>> Which makes me conclude that they are not suggested as of now.
> >>>>
> >>>> I see more issues with allocating them on the page fault path and no=
t
> >>>> having a way to disable it -- compared to allocating them on the wri=
te()
> >>>> path.
> >>>
> >>> I may not understand your issues. IIUC, you can disable allocating hu=
ge
> >>> pages on the page fault path by using the 'huge=3Dnever' mount option=
 or
> >>> setting shmem_enabled=3Ddeny. No?
> >>
> >> That's what I am saying: if there is some way to disable it that will
> >> keep working, great.
> >=20
> > I agree. That aligns with what I recall Hugh requested. However, I
> > believe if that is the way to go, we shouldn't limit it to tmpfs.
> > Otherwise, why should tmpfs be prevented from allocating large folios i=
f
> > other filesystems in the system are allowed to allocate them?
>
> See above. On systems without/little swap you might not want them for=20
> shmem/tmpfs, but would happily use them elsewhere.
>
> The "write() won't waste memory" case is really interesting, the=20
> "fallocate cannot free the memory" still exists. A shrinker might help.

The previous implementation with large folios allocation was wrong
and was actually wasting memory by rounding up while trying to find
the order. Matthew already pointed it out [1]. So, with that fixed, we
should not end up wasting memory.

https://lore.kernel.org/all/ZvVQoY8Tn_BNc79T@casper.infradead.org/


