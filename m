Return-Path: <linux-kernel+bounces-379739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E1389AE302
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 12:49:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F2A31C21EC6
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 10:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DA241C4A3E;
	Thu, 24 Oct 2024 10:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kruces-com.20230601.gappssmtp.com header.i=@kruces-com.20230601.gappssmtp.com header.b="PCpxoOol"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 650D81C4A0D
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 10:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729766956; cv=none; b=axbZU5+AdttNiOJ9rcqDgRQ655X5qE6vtEbBXKTqsU6ayk6LSCZMiXgrgCRdfFJ5awWt/gBXP+PIAU9jbA4mixTWZztJav+M2tja57M07UqC8D86IAYD3YmikZyixctunZHHsP/DEmYWFgC92bfmOrxL+FlRbuJkijUiFFekyag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729766956; c=relaxed/simple;
	bh=SzOTHHdZxLAtU/8t89ECbl5Qg6GeFHXZnadwvoSu+Ws=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Subject:Cc:
	 References:In-Reply-To; b=evIREOKYKuzUjZF5jKf3XWKfTDkeehQ2N/aR+PkAxbQZGMfEjjGk0PpWDZZxs7/pv1XNbuB0DMlKjTzd3uiJ2JiKh3ur//CewIyQyN+24LfZQ5P+pgiRqejNwP5CR21+5SDe2D29GsTrqEXqDS0oTty8nAefpI4afTkgmTn/g3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kruces.com; spf=pass smtp.mailfrom=kruces.com; dkim=pass (2048-bit key) header.d=kruces-com.20230601.gappssmtp.com header.i=@kruces-com.20230601.gappssmtp.com header.b=PCpxoOol; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kruces.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kruces.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a9a0ec0a94fso95454966b.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 03:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kruces-com.20230601.gappssmtp.com; s=20230601; t=1729766951; x=1730371751; darn=vger.kernel.org;
        h=in-reply-to:references:cc:subject:from:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4D6nfgZG6k1+7ANic9oQcEiK3B/zcbyldSedO3fEu+0=;
        b=PCpxoOol5S9qfhYM1w/tEYJ1XNxG7Qo3jdQd9zpEPwJJpdr9s6LvWCc/vfuo6Rf/q/
         8WeCZBm5KNQYV7HHMPj/bYCIlrdtUXBySTnaQtnyedtg6M1knmODF32lwHImbSoXxJmc
         E/1Hiq6MBLFRljxROKr9C91XBDdZ/xVx63yD5J85U3+miVBZ/UFl89eyuJfMvtfqNiM2
         iwq+zeXxESBUQDGmNF3akhTkisTdyhbsXO6UiBwCmJD/6AWFpHktppFv8/8MZOppTbLL
         SItg/zSQs9umzm0LZ0cANZlZmMd5Y+nuUCItdcpzy2uYqZAuPkmtIgFCnMtejDRnZlYW
         kcRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729766951; x=1730371751;
        h=in-reply-to:references:cc:subject:from:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4D6nfgZG6k1+7ANic9oQcEiK3B/zcbyldSedO3fEu+0=;
        b=wOCqf05Evi9jHaXLc3FSoEiBoII8JngNq9ZLWZI+b6DYlN8ES/qR8DfDotXvTzMH7S
         SB7LfeHrnzU6wdzu4EMlGe+uABzuDgS3SEZxmB/TqKHrDGrqNXwGkUeJiebsx4GwZxZp
         I890lWTPbm+2h/CNgC5myA3MtuzyvXvfncZ5U13n6F9Drji6SoETf3nos87oomMd7nY/
         qIsm/KHUfGVR26VQahH2JfI2h5OFJPnLIuNZXGogrV872N3PWVUSE5/m30n5libDEJsq
         T13qtl79/S4WCDC33vuFw3eMRjzzcXJagPLAgoyq6FcX4gBhv1O8Big3VSaT+Oo5yspf
         iFng==
X-Forwarded-Encrypted: i=1; AJvYcCV76n25SfI4NpLNo86EA/as/wruIDK+8DOwi6jQoGvyShf4yFMm+7U09bqnhnGUh3W2O1HVw4gJlTqNI24=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQvQPDdWQ2rc7RScehHvKz/jqcHsSxOJ56uSahSjUlg3KPs4Md
	jrjHYC8HUViPLOJPvIAyLanfbjeNrhjX2IlCW0DBEDpT18REbqNSPTlEO67zwus=
X-Google-Smtp-Source: AGHT+IFTS0CFhCVOQh82+3UorX4rsLbvWN28RiSdZKLEiH//znH8/4KpGPi7VYCl54OK27wN3SXc2g==
X-Received: by 2002:a17:907:7f24:b0:a9a:1094:55de with SMTP id a640c23a62f3a-a9ad27127d2mr148079966b.13.1729766951262;
        Thu, 24 Oct 2024 03:49:11 -0700 (PDT)
Received: from localhost ([194.62.217.67])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a91370e9csm600816666b.136.2024.10.24.03.49.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Oct 2024 03:49:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 24 Oct 2024 12:49:09 +0200
Message-Id: <D53Z7I8D6MRB.XN14XUEFQFG7@kruces.com>
To: "David Hildenbrand" <david@redhat.com>, "Baolin Wang"
 <baolin.wang@linux.alibaba.com>, "Daniel Gomez" <da.gomez@samsung.com>,
 "Kirill A. Shutemov" <kirill@shutemov.name>
From: "Daniel Gomez" <d@kruces.com>
Subject: Re: [RFC PATCH v3 0/4] Support large folios for tmpfs
Cc: "Matthew Wilcox" <willy@infradead.org>, <akpm@linux-foundation.org>,
 <hughd@google.com>, <wangkefeng.wang@huawei.com>, <21cnbao@gmail.com>,
 <ryan.roberts@arm.com>, <ioworker0@gmail.com>, <linux-mm@kvack.org>,
 <linux-kernel@vger.kernel.org>, "Kirill A . Shutemov"
 <kirill.shutemov@linux.intel.com>
X-Mailer: aerc 0.18.2
References: <cover.1728548374.git.baolin.wang@linux.alibaba.com>
 <Zw_IT136rxW_KuhU@casper.infradead.org>
 <e1b6fa05-019c-4a40-afc0-bc1efd15ad42@linux.alibaba.com>
 <6dohx7zna7x6hxzo4cwnwarep3a7rohx4qxubds3uujfb7gp3c@2xaubczl2n6d>
 <8e48cf24-83e1-486e-b89c-41edb7eeff3e@linux.alibaba.com>
 <CGME20241021085439eucas1p10a0b6e7c3b0ace3c9a0402427595875a@eucas1p1.samsung.com> <ppgciwd7cxmeqssryshe42lxwb4sdzr6gjhwwbotw4gx2l7vi5@7y4hedxpf4nx> <D51IU4N746MI.FDS6C7GYO4RP@samsung.com> <c59f2881-fbbb-41b1-830d-9d81f36ecc0b@linux.alibaba.com> <486a72c6-5877-4a95-a587-2a32faa8785d@redhat.com> <7eb412d1-f90e-4363-8c7b-072f1124f8a6@linux.alibaba.com> <1b0f9f94-06a6-48ac-a68e-848bce1008e9@redhat.com>
In-Reply-To: <1b0f9f94-06a6-48ac-a68e-848bce1008e9@redhat.com>

On Wed Oct 23, 2024 at 11:27 AM CEST, David Hildenbrand wrote:
> On 23.10.24 10:04, Baolin Wang wrote:
> >=20
> >=20
> > On 2024/10/22 23:31, David Hildenbrand wrote:
> >> On 22.10.24 05:41, Baolin Wang wrote:
> >>>
> >>>
> >>> On 2024/10/21 21:34, Daniel Gomez wrote:
> >>>> On Mon Oct 21, 2024 at 10:54 AM CEST, Kirill A. Shutemov wrote:
> >>>>> On Mon, Oct 21, 2024 at 02:24:18PM +0800, Baolin Wang wrote:
> >>>>>>
> >>>>>>
> >>>>>> On 2024/10/17 19:26, Kirill A. Shutemov wrote:
> >>>>>>> On Thu, Oct 17, 2024 at 05:34:15PM +0800, Baolin Wang wrote:
> >>>>>>>> + Kirill
> >>>>>>>>
> >>>>>>>> On 2024/10/16 22:06, Matthew Wilcox wrote:
> >>>>>>>>> On Thu, Oct 10, 2024 at 05:58:10PM +0800, Baolin Wang wrote:
> >>>>>>>>>> Considering that tmpfs already has the 'huge=3D' option to
> >>>>>>>>>> control the THP
> >>>>>>>>>> allocation, it is necessary to maintain compatibility with the
> >>>>>>>>>> 'huge=3D'
> >>>>>>>>>> option, as well as considering the 'deny' and 'force' option
> >>>>>>>>>> controlled
> >>>>>>>>>> by '/sys/kernel/mm/transparent_hugepage/shmem_enabled'.
> >>>>>>>>>
> >>>>>>>>> No, it's not.=C2=A0 No other filesystem honours these settings.
> >>>>>>>>> tmpfs would
> >>>>>>>>> not have had these settings if it were written today.=C2=A0 It =
should
> >>>>>>>>> simply
> >>>>>>>>> ignore them, the way that NFS ignores the "intr" mount option
> >>>>>>>>> now that
> >>>>>>>>> we have a better solution to the original problem.
> >>>>>>>>>
> >>>>>>>>> To reiterate my position:
> >>>>>>>>>
> >>>>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0 - When using tmpfs as a filesystem, i=
t should behave like
> >>>>>>>>> other
> >>>>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 filesystems.
> >>>>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0 - When using tmpfs to implement MAP_A=
NONYMOUS | MAP_SHARED,
> >>>>>>>>> it should
> >>>>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 behave like anonymous mem=
ory.
> >>>>>>>>
> >>>>>>>> I do agree with your point to some extent, but the =E2=80=98huge=
=3D=E2=80=99 option
> >>>>>>>> has
> >>>>>>>> existed for nearly 8 years, and the huge orders based on write
> >>>>>>>> size may not
> >>>>>>>> achieve the performance of PMD-sized THP in some scenarios, such
> >>>>>>>> as when the
> >>>>>>>> write length is consistently 4K. So, I am still concerned that
> >>>>>>>> ignoring the
> >>>>>>>> 'huge' option could lead to compatibility issues.
> >>>>>>>
> >>>>>>> Yeah, I don't think we are there yet to ignore the mount option.
> >>>>>>
> >>>>>> OK.
> >>>>>>
> >>>>>>> Maybe we need to get a new generic interface to request the seman=
tics
> >>>>>>> tmpfs has with huge=3D on per-inode level on any fs. Like a set o=
f
> >>>>>>> FADV_*
> >>>>>>> handles to make kernel allocate PMD-size folio on any allocation
> >>>>>>> or on
> >>>>>>> allocations within i_size. I think this behaviour is useful beyon=
d
> >>>>>>> tmpfs.
> >>>>>>>
> >>>>>>> Then huge=3D implementation for tmpfs can be re-defined to set th=
ese
> >>>>>>> per-inode FADV_ flags by default. This way we can keep tmpfs
> >>>>>>> compatible
> >>>>>>> with current deployments and less special comparing to rest of
> >>>>>>> filesystems on kernel side.
> >>>>>>
> >>>>>> I did a quick search, and I didn't find any other fs that require
> >>>>>> PMD-sized
> >>>>>> huge pages, so I am not sure if FADV_* is useful for filesystems
> >>>>>> other than
> >>>>>> tmpfs. Please correct me if I missed something.
> >>>>>
> >>>>> What do you mean by "require"? THPs are always opportunistic.
> >>>>>
> >>>>> IIUC, we don't have a way to hint kernel to use huge pages for a
> >>>>> file on
> >>>>> read from backing storage. Readahead is not always the right way.
> >>>>>
> >>>>>>> If huge=3D is not set, tmpfs would behave the same way as the res=
t of
> >>>>>>> filesystems.
> >>>>>>
> >>>>>> So if 'huge=3D' is not set, tmpfs write()/fallocate() can still
> >>>>>> allocate large
> >>>>>> folios based on the write size? If yes, that means it will change =
the
> >>>>>> default huge behavior for tmpfs. Because previously having 'huge=
=3D'
> >>>>>> is not
> >>>>>> set means the huge option is 'SHMEM_HUGE_NEVER', which is similar
> >>>>>> to what I
> >>>>>> mentioned:
> >>>>>> "Another possible choice is to make the huge pages allocation base=
d
> >>>>>> on write
> >>>>>> size as the *default* behavior for tmpfs, ..."
> >>>>>
> >>>>> I am more worried about breaking existing users of huge pages. So
> >>>>> changing
> >>>>> behaviour of users who don't specify huge is okay to me.
> >>>>
> >>>> I think moving tmpfs to allocate large folios opportunistically by
> >>>> default (as it was proposed initially) doesn't necessary conflict wi=
th
> >>>> the default behaviour (huge=3Dnever). We just need to clarify that i=
n
> >>>> the documentation.
> >>>>
> >>>> However, and IIRC, one of the requests from Hugh was to have a way t=
o
> >>>> disable large folios which is something other FS do not have control
> >>>> of as of today. Ryan sent a proposal to actually control that global=
ly
> >>>> but I think it didn't move forward. So, what are we missing to go ba=
ck
> >>>> to implement large folios in tmpfs in the default case, as any other=
 fs
> >>>> leveraging large folios?
> >>>
> >>> IMHO, as I discussed with Kirill, we still need maintain compatibilit=
y
> >>> with the 'huge=3D' mount option. This means that if 'huge=3Dnever' is=
 set
> >>> for tmpfs, huge page allocation will still be prohibited (which can
> >>> address Hugh's request?). However, if 'huge=3D' is not set, we can
> >>> allocate large folios based on the write size.

So, in order to make tmpfs behave like other filesystems, we need to
allocate large folios by default. Not setting 'huge=3D' is the same as
setting it to 'huge=3Dnever' as per documentation. But 'huge=3D' is meant t=
o
control THP, not large folios, so it should not have a conflict here, or
else, what case are you thinking?

So, to make tmpfs behave like other filesystems, we need to allocate
large folios by default. According to the documentation, not setting
'huge=3D' is the same as setting 'huge=3Dnever.' However, 'huge=3D' is
intended to control THP, not large folios, so there shouldn't be
a conflict in this case. Can you clarify what specific scenario or
conflict you're considering here? Perhaps when large folios order is the
same as PMD-size?

> >>
> >> I consider allocating large folios in shmem/tmpfs on the write path le=
ss
> >> controversial than allocating them on the page fault path -- especiall=
y
> >> as long as we stay within the size to-be-written.
> >>
> >> I think in RHEL THP on shmem/tmpfs are disabled as default (e.g.,
> >> shmem_enabled=3Dnever). Maybe because of some rather undesired
> >> side-effects (maybe some are historical?): I recall issues with VMs wi=
th
> >> THP+ memory ballooning, as we cannot reclaim pages of folios if
> >> splitting fails). I assume most of these problematic use cases don't u=
se
> >> tmpfs as an ordinary file system (write()/read()), but mmap() the whol=
e
> >> thing.
> >>
> >> Sadly, I don't find any information about shmem/tmpfs + THP in the RHE=
L
> >> documentation; most documentation is only concerned about anon THP.
> >> Which makes me conclude that they are not suggested as of now.
> >>
> >> I see more issues with allocating them on the page fault path and not
> >> having a way to disable it -- compared to allocating them on the write=
()
> >> path.
> >=20
> > I may not understand your issues. IIUC, you can disable allocating huge
> > pages on the page fault path by using the 'huge=3Dnever' mount option o=
r
> > setting shmem_enabled=3Ddeny. No?
>
> That's what I am saying: if there is some way to disable it that will=20
> keep working, great.

I agree. That aligns with what I recall Hugh requested. However, I
believe if that is the way to go, we shouldn't limit it to tmpfs.
Otherwise, why should tmpfs be prevented from allocating large folios if
other filesystems in the system are allowed to allocate them? I think,
if we want to disable large folios we should make it more generic,
something similar to Ryan's proposal [1] for controlling folio sizes.

[1] https://lore.kernel.org/all/20240717071257.4141363-1-ryan.roberts@arm.c=
om/

That said, there has already been disagreement on this point here [2].

[2] https://lore.kernel.org/all/ZvVRiJYfaXD645Nh@casper.infradead.org/

