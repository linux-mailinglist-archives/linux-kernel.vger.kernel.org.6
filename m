Return-Path: <linux-kernel+bounces-518264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20FEFA38C92
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 20:41:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28FD33AEC98
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 19:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 777DB237179;
	Mon, 17 Feb 2025 19:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gixUQmaO"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F334A226865
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 19:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739821268; cv=none; b=AP/ge93HiRojHzb6UdAB4yrcybWGiTMCiqm22WevX9P+HsIXbM0MHDwB+HN8yi4ZiWY/x1zrW0sUdK+u83TyU2pd7BqYQU5jViNuPYRKvV1htZMXCNdBLJAeq+uPePDQhKMk1n7tYe7U74L1GMDdudSbjgTvaKNmoE0GYdy4G7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739821268; c=relaxed/simple;
	bh=fZqtRM8RT1iWTUKXobHF6k5WgJxBwB9Q4GBzecCtjxU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZiHHihi9Z9qOhYtB6zyeSZNBn2szuCg4nzrC14fsacQxNrMz9o8mr50g/vyNkGJ3P0k6sdqvhIwxoryIBKA/a8PX0UD87jbsyw8K6xdJoKnOQ/Zd7kO8cshovl+qa6FHHHEVH1QBi30UNcvtOwyBzn8jny+hEcBQZoK2tAUPScQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gixUQmaO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739821266;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=//bCVclOlkTbOALtHecBUWQzL7Q3Fqbtw0DYb0DfT7o=;
	b=gixUQmaOU+TkvoDNR+rnABK1qeB0d3f/37eNoeVa+vSdyAY0GFdVCHxDMg65HZVRbgqVQC
	X86202JoKBEihL9Ksupo91dft/ndrppDKsb97dL+pwNYP5ry5oAa/9qJrIWjDZduCz5fW6
	pjRAgYhbFzECZQc+Aa9DOIKmatUq9PU=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-q5-27B6aOSufKvLkOq7l0g-1; Mon, 17 Feb 2025 14:41:04 -0500
X-MC-Unique: q5-27B6aOSufKvLkOq7l0g-1
X-Mimecast-MFC-AGG-ID: q5-27B6aOSufKvLkOq7l0g_1739821264
Received: by mail-yb1-f198.google.com with SMTP id 3f1490d57ef6-e549b6c54a0so6597028276.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 11:41:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739821264; x=1740426064;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=//bCVclOlkTbOALtHecBUWQzL7Q3Fqbtw0DYb0DfT7o=;
        b=ggDG35qS1+qai3ZuPWyzgtT7E6l5uBeKzFBBYG3+xZNZoNUPgeunG9oqtvze0Nr9rJ
         ASLMrYTmuhoWfvAHD5oO6hMdcO9JqDTePQUBbeXxYpTg4ndmjZ0q6FbWQSvJb5py7eS9
         yotEw9YPyEouqStjNlkVufLEjlLNY+mT1fCK1/msY++ftH6TSa0P7B7yWndx6kWUAF+9
         P9ww+xmHHekVL7q8rQYYM5UZEo53C3u/8Bz7j2qJgDLRUGYc7CIX5ppZYe7GFsuuz723
         HioTwIv2Y9dTS1JvoR1innN/2/A+pXI/YuHM3l6HaTaLzTq7Ij1D3Jhr/LMo8Yl6E4L2
         fa1w==
X-Gm-Message-State: AOJu0YyqfH/z0bz+qGvMmgc2k22s8kCFB7DzFkUvVC252jz3QF78V2pz
	QlzWgqi+WDpsHH1kObiojCkkby0Ttx5PXkDpPnY/ZoPGD/bXcOh3CvjC7NBEL9H+JqOiRZKsfxn
	H2qyQaXoED7E8XiWNhaWVrroFJNR5iy2cU0g3ZqbT1a/kqAowcWeaMtAz2mVPiCjqQd7FnYuXls
	hg2nL+KlewA6G6rJib7qpV1OFbCw2NnHi2IPDk
X-Gm-Gg: ASbGnctZ7hnWwhsuPNmVhYb9cCD1DACf9VPzTR5fZjjETdFs3mQcfifmLqfXuQRbwsE
	joafxcIxLihsouoNpA2E8gImMH+05O9MXIx0CDZzhBptfW/WeXNQZLaobWcMtvU0F/L1LgVQBQq
	E=
X-Received: by 2002:a05:6902:1245:b0:e57:38e8:e484 with SMTP id 3f1490d57ef6-e5dc906a6efmr8517681276.25.1739821264176;
        Mon, 17 Feb 2025 11:41:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEvnPQwnilhWswjs0ZcxjcGnVjg3Ge6f8VbjDNzW12TGEGsZB+XKpaQjNK13699ME9n3+vuSW3RJklFy1lTMg0=
X-Received: by 2002:a05:6902:1245:b0:e57:38e8:e484 with SMTP id
 3f1490d57ef6-e5dc906a6efmr8517645276.25.1739821263702; Mon, 17 Feb 2025
 11:41:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250211004054.222931-1-npache@redhat.com> <20250211004054.222931-6-npache@redhat.com>
 <3ef9a5f3-2d63-46db-b0b5-d6f7e78c7888@gmail.com>
In-Reply-To: <3ef9a5f3-2d63-46db-b0b5-d6f7e78c7888@gmail.com>
From: Nico Pache <npache@redhat.com>
Date: Mon, 17 Feb 2025 12:40:38 -0700
X-Gm-Features: AWEUYZkcwmtHBdpmUwP7X7Kw49HJAvQ6nyZR8Z4XfpL2-Rs1JAFL0zufMEm8KSA
Message-ID: <CAA1CXcA7aG9MixWVX8vrTthayah0CXb9-HvKx-hU_wRYQ1fPxQ@mail.gmail.com>
Subject: Re: [RFC v2 5/5] mm: document mTHP defer setting
To: Usama Arif <usamaarif642@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, ryan.roberts@arm.com, 
	anshuman.khandual@arm.com, catalin.marinas@arm.com, cl@gentwo.org, 
	vbabka@suse.cz, mhocko@suse.com, apopple@nvidia.com, 
	dave.hansen@linux.intel.com, will@kernel.org, baohua@kernel.org, jack@suse.cz, 
	srivatsa@csail.mit.edu, haowenchao22@gmail.com, hughd@google.com, 
	aneesh.kumar@kernel.org, yang@os.amperecomputing.com, peterx@redhat.com, 
	ioworker0@gmail.com, wangkefeng.wang@huawei.com, ziy@nvidia.com, 
	jglisse@google.com, surenb@google.com, vishal.moola@gmail.com, 
	zokeefe@google.com, zhengqi.arch@bytedance.com, jhubbard@nvidia.com, 
	21cnbao@gmail.com, willy@infradead.org, kirill.shutemov@linux.intel.com, 
	david@redhat.com, aarcange@redhat.com, raquini@redhat.com, dev.jain@arm.com, 
	sunnanyong@huawei.com, audra@redhat.com, akpm@linux-foundation.org, 
	rostedt@goodmis.org, mathieu.desnoyers@efficios.com, tiwai@suse.de, 
	baolin.wang@linux.alibaba.com, corbet@lwn.net, shuah@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 17, 2025 at 8:14=E2=80=AFAM Usama Arif <usamaarif642@gmail.com>=
 wrote:
>
>
>
> On 11/02/2025 00:40, Nico Pache wrote:
> > Now that we have mTHP support in khugepaged, lets add it to the
> > transhuge admin guide to provide proper guidance.
> >
>
> I think you should move this patch to the mTHP khugepaged series, and jus=
t send
> THP=3Ddefer separately from mTHP khguepaged.
>
> > Signed-off-by: Nico Pache <npache@redhat.com>
> > ---
> >  Documentation/admin-guide/mm/transhuge.rst | 22 ++++++++++++++++------
> >  1 file changed, 16 insertions(+), 6 deletions(-)
> >
> > diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation=
/admin-guide/mm/transhuge.rst
> > index b3b18573bbb4..99ba3763c1c4 100644
> > --- a/Documentation/admin-guide/mm/transhuge.rst
> > +++ b/Documentation/admin-guide/mm/transhuge.rst
> > @@ -63,7 +63,7 @@ often.
> >  THP can be enabled system wide or restricted to certain tasks or even
> >  memory ranges inside task's address space. Unless THP is completely
> >  disabled, there is ``khugepaged`` daemon that scans memory and
> > -collapses sequences of basic pages into PMD-sized huge pages.
> > +collapses sequences of basic pages into huge pages.
> >
> >  The THP behaviour is controlled via :ref:`sysfs <thp_sysfs>`
> >  interface and using madvise(2) and prctl(2) system calls.
> > @@ -103,8 +103,8 @@ madvise(MADV_HUGEPAGE) on their critical mmapped re=
gions.
> >  Applications that would like to benefit from THPs but would still like=
 a
> >  more memory conservative approach can choose 'defer'. This avoids
> >  inserting THPs at the page fault handler unless they are MADV_HUGEPAGE=
.
> > -Khugepaged will then scan the mappings for potential collapses into PM=
D
> > -sized pages. Admins using this the 'defer' setting should consider
> > +Khugepaged will then scan the mappings for potential collapses into (m=
)THP
> > +pages. Admins using this the 'defer' setting should consider
> >  tweaking khugepaged/max_ptes_none. The current default of 511 may
> >  aggressively collapse your PTEs into PMDs. Lower this value to conserv=
e
> >  more memory (ie. max_ptes_none=3D64).
> > @@ -119,11 +119,14 @@ Global THP controls
> >
> >  Transparent Hugepage Support for anonymous memory can be entirely disa=
bled
> >  (mostly for debugging purposes) or only enabled inside MADV_HUGEPAGE
> > -regions (to avoid the risk of consuming more memory resources) or enab=
led
> > -system wide. This can be achieved per-supported-THP-size with one of::
> > +regions (to avoid the risk of consuming more memory resources), defere=
d to
> > +khugepaged, or enabled system wide.
> > +
> > +This can be achieved per-supported-THP-size with one of::
> >
> >       echo always >/sys/kernel/mm/transparent_hugepage/hugepages-<size>=
kB/enabled
> >       echo madvise >/sys/kernel/mm/transparent_hugepage/hugepages-<size=
>kB/enabled
> > +     echo defer >/sys/kernel/mm/transparent_hugepage/hugepages-<size>k=
B/enabled
> >       echo never >/sys/kernel/mm/transparent_hugepage/hugepages-<size>k=
B/enabled
> >
> >  where <size> is the hugepage size being addressed, the available sizes
> > @@ -155,6 +158,13 @@ hugepage sizes have enabled=3D"never". If enabling=
 multiple hugepage
> >  sizes, the kernel will select the most appropriate enabled size for a
> >  given allocation.
> >
> > +khugepaged use max_ptes_none scaled to the order of the enabled mTHP s=
ize to
> > +determine collapses. When using mTHPs its recommended to set max_ptes_=
none low.
> > +Ideally less than HPAGE_PMD_NR / 2 (255 on 4k page size). This will pr=
event
> > +undesired "creep" behavior that leads to continously collapsing to a l=
arger
> > +mTHP size. max_ptes_shared and max_ptes_swap have no effect when colla=
psing to a
> > +mTHP, and mTHP collapse will fail on shared or swapped out pages.
> > +
>
> This paragraph definitely belongs in the khugepaged series, as it doesn't=
 have anything
> to do with THP=3Ddefer.
>
> re "Ideally less than HPAGE_PMD_NR / 2",
> what if you are running on amd, and using 16K and 2M THP=3Dalways only as=
, thats where
> the most TLB benefit is. Than this recommendation doesnt make sense?

That may be correct, I believe the creep requires two adjacent mTHP
levels ( ie 512kb, 1024kb) to be enabled for the issue to really
present. Although with max_ptes_none=3D511, you will almost always
satisfy the collapse request, so your 16Kb mTHPs will be promoted to
PMDs. I dont believe 511 is a good default if using mTHPs.
>
> Also even if you have all mTHP sizes as always, shouldnt you start by col=
lapsing to
> the largest THP size first? (I haven't reviewed the khugepaged series yet=
, so might
> be have been discussed there, I will try and review it).

We do start at the largest first. The creep happens on a second pass
of the PMD, not immediately in the same collapse.

>
> Did you see the creep behavior you mentioned in your experiments?

Yes, I provided an example of how it happens here.
https://lore.kernel.org/lkml/CAA1CXcDiGLD=3DdZpFRyAuz4TLrVZZYGp=3Du7=3DZ9Q+=
g9RXbf-s2nA@mail.gmail.com/

>
>
> >  It's also possible to limit defrag efforts in the VM to generate
> >  anonymous hugepages in case they're not immediately free to madvise
> >  regions or to never try to defrag memory and simply fallback to regula=
r
> > @@ -318,7 +328,7 @@ Alternatively, each supported anonymous THP size ca=
n be controlled by
> >  passing ``thp_anon=3D<size>[KMG],<size>[KMG]:<state>;<size>[KMG]-<size=
>[KMG]:<state>``,
> >  where ``<size>`` is the THP size (must be a power of 2 of PAGE_SIZE an=
d
> >  supported anonymous THP)  and ``<state>`` is one of ``always``, ``madv=
ise``,
> > -``never`` or ``inherit``.
> > +``defer``, ``never`` or ``inherit``.
> >
> >  For example, the following will set 16K, 32K, 64K THP to ``always``,
> >  set 128K, 512K to ``inherit``, set 256K to ``madvise`` and 1M, 2M
>


