Return-Path: <linux-kernel+bounces-379745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C662D9AE312
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 12:52:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6FF31C2233A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 10:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E48CF1C75EB;
	Thu, 24 Oct 2024 10:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kruces-com.20230601.gappssmtp.com header.i=@kruces-com.20230601.gappssmtp.com header.b="Rnn2ki3s"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481F9167D80
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 10:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729767173; cv=none; b=Fm8rFUHHGGbvOkcL2d3d0bXrkUvx2L67a8cNBa9OyXY9ZDzvvkBusP/XFrOaFfFnp/LjDcHzcODWJAwtyzkpZMSMCI7bVcCg4Dx7leBfEQA60w3kFcEuyGu/6VGfl7gMgkn4rARZyxBb0kHEUej6Wx4rBbAuRlcwvLzCwaUXuyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729767173; c=relaxed/simple;
	bh=jyYD8uR6VgC8lK/BK1I+6pBahtt51XbNxjWzuzB5+BM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=SZRCb2tLX0KO/5Fib+xTsGZQ1bauQ76RkGSSM0XtD+c1ob11myzcZ9hINqm0eOGnQilkPdP5vaGubh0MSAfqdasFwFvatB2XWtB2zv6cSam41AAdzU6Uhl9iDXVDO2oUh0SRNT1jAPDtEGg2MMaZyLrT9R7CfxtCag6gfVKDkvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kruces.com; spf=pass smtp.mailfrom=kruces.com; dkim=pass (2048-bit key) header.d=kruces-com.20230601.gappssmtp.com header.i=@kruces-com.20230601.gappssmtp.com header.b=Rnn2ki3s; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kruces.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kruces.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5cb72918bddso994132a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 03:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kruces-com.20230601.gappssmtp.com; s=20230601; t=1729767168; x=1730371968; darn=vger.kernel.org;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J2jK48K5rMf9PM6EZMKUSQBND1vGsRxeS6yIIGOf0RE=;
        b=Rnn2ki3s/AqjX3E/u07bA3Mg6iRqHEQzAko4/drvhygXFHnxBrdAHKS5EOLMdvp4cj
         pk8IJmIFqAlEo7zNKRkoiLWwH1BwUm7feurtd/h+E7bzdrX/wxg3Cnfx2zsc3Jc15H2M
         Yr8P6h/ryBKG9HEOQne2n7bdQdtuIoHRxQUXEkrcO/JSmnG+nIga/SoJRsQwO0thHeFQ
         pmvApvqAa86olbI1H25fMZCKv1Rd5Xe609X8NpYxE9Tt8jPGKgbVHG/lJswsov50MSv8
         40XcQFtkWs2SU8q4RJoBsd1jHL0YFYLunrU7Jh/PvskM1PatoXbX6aEYmkMcNQoAUDx9
         iUMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729767168; x=1730371968;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=J2jK48K5rMf9PM6EZMKUSQBND1vGsRxeS6yIIGOf0RE=;
        b=sjrIg2Ys8XRK+RmPXvs6wc64Lg4bNF94CPcQ7SWcbTDnWsiV0W3zSFbuhemjGUtFHy
         XbiBthTvB5KTiAhpYtmaTiFQ31B/J7v43oghv/Fi58Zq/CflqaRTFfOL+cZ42RDwau5r
         FScWgKnnZfrcx8YBfH3TEW6rKurWg2a9hPfgTWZi2wn3X06aXtq8wQpzJRGm2m+s6s3m
         gW5yFLwvKTNNqt9PMfpTq5fan52f0AzhKHEqdREYb00j9biYyiztJ6k7OmjqcBroBUCf
         2vnfWVpeCVgb4kbY6l7SBLPkxDpt5Z+4h15bNXSB18hOD7e0bKm9ROltiTVl8POYpWWS
         XVrw==
X-Forwarded-Encrypted: i=1; AJvYcCV+6E2dxCZJGIpCI6Kub7xPWnAsKWderT+M6tKqdMAd1gl9G+g+WEXzyTpTYX02+3jlpFHx0+bWko8w4rw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuQlNeNF6HCm8111pSthhzv9VYB34XHP3h6r3yg6yuv5zQM+TQ
	Cqe/zrLbJXEx85+ZZrSJ5DOd02m1MTvVUgokEvsOl8sNjZRcnIDAr/d+kI9n5DY2dgyc9WQOpk1
	J
X-Google-Smtp-Source: AGHT+IEnSf1hdbNIqPwxL30tQa/ozUeZocqJqjScDoLB3huUD5IaauOrOfS6UWSad94b31sfV703Ug==
X-Received: by 2002:a05:6402:13cc:b0:5c5:b9bb:c65a with SMTP id 4fb4d7f45d1cf-5cb8ac2d6fbmr4475663a12.1.1729767168144;
        Thu, 24 Oct 2024 03:52:48 -0700 (PDT)
Received: from localhost ([194.62.217.67])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cb66c73b50sm5500642a12.97.2024.10.24.03.52.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Oct 2024 03:52:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 24 Oct 2024 12:52:46 +0200
Message-Id: <D53ZAA760YS1.B4SVBIPY8MTV@kruces.com>
Subject: Re: [RFC PATCH v3 0/4] Support large folios for tmpfs
Cc: "Matthew Wilcox" <willy@infradead.org>, <akpm@linux-foundation.org>,
 <hughd@google.com>, <wangkefeng.wang@huawei.com>, <21cnbao@gmail.com>,
 <ryan.roberts@arm.com>, <ioworker0@gmail.com>, <linux-mm@kvack.org>,
 <linux-kernel@vger.kernel.org>, "Kirill A . Shutemov"
 <kirill.shutemov@linux.intel.com>
To: "Daniel Gomez" <d@kruces.com>, "David Hildenbrand" <david@redhat.com>,
 "Baolin Wang" <baolin.wang@linux.alibaba.com>, "Daniel Gomez"
 <da.gomez@samsung.com>, "Kirill A. Shutemov" <kirill@shutemov.name>
From: "Daniel Gomez" <d@kruces.com>
X-Mailer: aerc 0.18.2
References: <cover.1728548374.git.baolin.wang@linux.alibaba.com>
 <Zw_IT136rxW_KuhU@casper.infradead.org>
 <e1b6fa05-019c-4a40-afc0-bc1efd15ad42@linux.alibaba.com>
 <6dohx7zna7x6hxzo4cwnwarep3a7rohx4qxubds3uujfb7gp3c@2xaubczl2n6d>
 <8e48cf24-83e1-486e-b89c-41edb7eeff3e@linux.alibaba.com>
 <CGME20241021085439eucas1p10a0b6e7c3b0ace3c9a0402427595875a@eucas1p1.samsung.com> <ppgciwd7cxmeqssryshe42lxwb4sdzr6gjhwwbotw4gx2l7vi5@7y4hedxpf4nx> <D51IU4N746MI.FDS6C7GYO4RP@samsung.com> <c59f2881-fbbb-41b1-830d-9d81f36ecc0b@linux.alibaba.com> <486a72c6-5877-4a95-a587-2a32faa8785d@redhat.com> <7eb412d1-f90e-4363-8c7b-072f1124f8a6@linux.alibaba.com> <1b0f9f94-06a6-48ac-a68e-848bce1008e9@redhat.com> <D53Z7I8D6MRB.XN14XUEFQFG7@kruces.com>
In-Reply-To: <D53Z7I8D6MRB.XN14XUEFQFG7@kruces.com>

On Thu Oct 24, 2024 at 12:49 PM CEST, Daniel Gomez wrote:
> On Wed Oct 23, 2024 at 11:27 AM CEST, David Hildenbrand wrote:
> > On 23.10.24 10:04, Baolin Wang wrote:
> > >=20
> > >=20
> > > On 2024/10/22 23:31, David Hildenbrand wrote:
> > >> On 22.10.24 05:41, Baolin Wang wrote:
> > >>>
> > >>>
> > >>> On 2024/10/21 21:34, Daniel Gomez wrote:
> > >>>> On Mon Oct 21, 2024 at 10:54 AM CEST, Kirill A. Shutemov wrote:
> > >>>>> On Mon, Oct 21, 2024 at 02:24:18PM +0800, Baolin Wang wrote:
> > >>>>>>
> > >>>>>>
> > >>>>>> On 2024/10/17 19:26, Kirill A. Shutemov wrote:
> > >>>>>>> On Thu, Oct 17, 2024 at 05:34:15PM +0800, Baolin Wang wrote:
> > >>>>>>>> + Kirill
> > >>>>>>>>
> > >>>>>>>> On 2024/10/16 22:06, Matthew Wilcox wrote:
> > >>>>>>>>> On Thu, Oct 10, 2024 at 05:58:10PM +0800, Baolin Wang wrote:
> > >>>>>>>>>> Considering that tmpfs already has the 'huge=3D' option to
> > >>>>>>>>>> control the THP
> > >>>>>>>>>> allocation, it is necessary to maintain compatibility with t=
he
> > >>>>>>>>>> 'huge=3D'
> > >>>>>>>>>> option, as well as considering the 'deny' and 'force' option
> > >>>>>>>>>> controlled
> > >>>>>>>>>> by '/sys/kernel/mm/transparent_hugepage/shmem_enabled'.
> > >>>>>>>>>
> > >>>>>>>>> No, it's not.=C2=A0 No other filesystem honours these setting=
s.
> > >>>>>>>>> tmpfs would
> > >>>>>>>>> not have had these settings if it were written today.=C2=A0 I=
t should
> > >>>>>>>>> simply
> > >>>>>>>>> ignore them, the way that NFS ignores the "intr" mount option
> > >>>>>>>>> now that
> > >>>>>>>>> we have a better solution to the original problem.
> > >>>>>>>>>
> > >>>>>>>>> To reiterate my position:
> > >>>>>>>>>
> > >>>>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0 - When using tmpfs as a filesystem,=
 it should behave like
> > >>>>>>>>> other
> > >>>>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 filesystems.
> > >>>>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0 - When using tmpfs to implement MAP=
_ANONYMOUS | MAP_SHARED,
> > >>>>>>>>> it should
> > >>>>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 behave like anonymous m=
emory.
> > >>>>>>>>
> > >>>>>>>> I do agree with your point to some extent, but the =E2=80=98hu=
ge=3D=E2=80=99 option
> > >>>>>>>> has
> > >>>>>>>> existed for nearly 8 years, and the huge orders based on write
> > >>>>>>>> size may not
> > >>>>>>>> achieve the performance of PMD-sized THP in some scenarios, su=
ch
> > >>>>>>>> as when the
> > >>>>>>>> write length is consistently 4K. So, I am still concerned that
> > >>>>>>>> ignoring the
> > >>>>>>>> 'huge' option could lead to compatibility issues.
> > >>>>>>>
> > >>>>>>> Yeah, I don't think we are there yet to ignore the mount option=
.
> > >>>>>>
> > >>>>>> OK.
> > >>>>>>
> > >>>>>>> Maybe we need to get a new generic interface to request the sem=
antics
> > >>>>>>> tmpfs has with huge=3D on per-inode level on any fs. Like a set=
 of
> > >>>>>>> FADV_*
> > >>>>>>> handles to make kernel allocate PMD-size folio on any allocatio=
n
> > >>>>>>> or on
> > >>>>>>> allocations within i_size. I think this behaviour is useful bey=
ond
> > >>>>>>> tmpfs.
> > >>>>>>>
> > >>>>>>> Then huge=3D implementation for tmpfs can be re-defined to set =
these
> > >>>>>>> per-inode FADV_ flags by default. This way we can keep tmpfs
> > >>>>>>> compatible
> > >>>>>>> with current deployments and less special comparing to rest of
> > >>>>>>> filesystems on kernel side.
> > >>>>>>
> > >>>>>> I did a quick search, and I didn't find any other fs that requir=
e
> > >>>>>> PMD-sized
> > >>>>>> huge pages, so I am not sure if FADV_* is useful for filesystems
> > >>>>>> other than
> > >>>>>> tmpfs. Please correct me if I missed something.
> > >>>>>
> > >>>>> What do you mean by "require"? THPs are always opportunistic.
> > >>>>>
> > >>>>> IIUC, we don't have a way to hint kernel to use huge pages for a
> > >>>>> file on
> > >>>>> read from backing storage. Readahead is not always the right way.
> > >>>>>
> > >>>>>>> If huge=3D is not set, tmpfs would behave the same way as the r=
est of
> > >>>>>>> filesystems.
> > >>>>>>
> > >>>>>> So if 'huge=3D' is not set, tmpfs write()/fallocate() can still
> > >>>>>> allocate large
> > >>>>>> folios based on the write size? If yes, that means it will chang=
e the
> > >>>>>> default huge behavior for tmpfs. Because previously having 'huge=
=3D'
> > >>>>>> is not
> > >>>>>> set means the huge option is 'SHMEM_HUGE_NEVER', which is simila=
r
> > >>>>>> to what I
> > >>>>>> mentioned:
> > >>>>>> "Another possible choice is to make the huge pages allocation ba=
sed
> > >>>>>> on write
> > >>>>>> size as the *default* behavior for tmpfs, ..."
> > >>>>>
> > >>>>> I am more worried about breaking existing users of huge pages. So
> > >>>>> changing
> > >>>>> behaviour of users who don't specify huge is okay to me.
> > >>>>
> > >>>> I think moving tmpfs to allocate large folios opportunistically by
> > >>>> default (as it was proposed initially) doesn't necessary conflict =
with
> > >>>> the default behaviour (huge=3Dnever). We just need to clarify that=
 in
> > >>>> the documentation.
> > >>>>
> > >>>> However, and IIRC, one of the requests from Hugh was to have a way=
 to
> > >>>> disable large folios which is something other FS do not have contr=
ol
> > >>>> of as of today. Ryan sent a proposal to actually control that glob=
ally
> > >>>> but I think it didn't move forward. So, what are we missing to go =
back
> > >>>> to implement large folios in tmpfs in the default case, as any oth=
er fs
> > >>>> leveraging large folios?
> > >>>
> > >>> IMHO, as I discussed with Kirill, we still need maintain compatibil=
ity
> > >>> with the 'huge=3D' mount option. This means that if 'huge=3Dnever' =
is set
> > >>> for tmpfs, huge page allocation will still be prohibited (which can
> > >>> address Hugh's request?). However, if 'huge=3D' is not set, we can
> > >>> allocate large folios based on the write size.
>
> So, in order to make tmpfs behave like other filesystems, we need to
> allocate large folios by default. Not setting 'huge=3D' is the same as
> setting it to 'huge=3Dnever' as per documentation. But 'huge=3D' is meant=
 to
> control THP, not large folios, so it should not have a conflict here, or
> else, what case are you thinking?
>
> So, to make tmpfs behave like other filesystems, we need to allocate
> large folios by default. According to the documentation, not setting
> 'huge=3D' is the same as setting 'huge=3Dnever.' However, 'huge=3D' is
> intended to control THP, not large folios, so there shouldn't be
> a conflict in this case. Can you clarify what specific scenario or
> conflict you're considering here? Perhaps when large folios order is the
> same as PMD-size?

Sorry for duplicate paragraph.

>
> > >>
> > >> I consider allocating large folios in shmem/tmpfs on the write path =
less
> > >> controversial than allocating them on the page fault path -- especia=
lly
> > >> as long as we stay within the size to-be-written.
> > >>
> > >> I think in RHEL THP on shmem/tmpfs are disabled as default (e.g.,
> > >> shmem_enabled=3Dnever). Maybe because of some rather undesired
> > >> side-effects (maybe some are historical?): I recall issues with VMs =
with
> > >> THP+ memory ballooning, as we cannot reclaim pages of folios if
> > >> splitting fails). I assume most of these problematic use cases don't=
 use
> > >> tmpfs as an ordinary file system (write()/read()), but mmap() the wh=
ole
> > >> thing.
> > >>
> > >> Sadly, I don't find any information about shmem/tmpfs + THP in the R=
HEL
> > >> documentation; most documentation is only concerned about anon THP.
> > >> Which makes me conclude that they are not suggested as of now.
> > >>
> > >> I see more issues with allocating them on the page fault path and no=
t
> > >> having a way to disable it -- compared to allocating them on the wri=
te()
> > >> path.
> > >=20
> > > I may not understand your issues. IIUC, you can disable allocating hu=
ge
> > > pages on the page fault path by using the 'huge=3Dnever' mount option=
 or
> > > setting shmem_enabled=3Ddeny. No?
> >
> > That's what I am saying: if there is some way to disable it that will=
=20
> > keep working, great.
>
> I agree. That aligns with what I recall Hugh requested. However, I
> believe if that is the way to go, we shouldn't limit it to tmpfs.
> Otherwise, why should tmpfs be prevented from allocating large folios if
> other filesystems in the system are allowed to allocate them? I think,
> if we want to disable large folios we should make it more generic,
> something similar to Ryan's proposal [1] for controlling folio sizes.
>
> [1] https://lore.kernel.org/all/20240717071257.4141363-1-ryan.roberts@arm=
.com/
>
> That said, there has already been disagreement on this point here [2].
>
> [2] https://lore.kernel.org/all/ZvVRiJYfaXD645Nh@casper.infradead.org/


