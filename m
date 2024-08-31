Return-Path: <linux-kernel+bounces-309840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B66C9670F5
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 12:49:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5C04283A7E
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 10:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8797617BB3E;
	Sat, 31 Aug 2024 10:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lZYSDMRL"
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B1C41BDDB
	for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 10:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725101388; cv=none; b=hFRNqUuSUylZ3iu9EGYJ+tmPJbuNPe2+liIvrnYN5EGU1gC23NW8ZeGg9mbhvASYcAk+faI3OPLf9BKbViB1HGav9T/bpFVlps6wJNcKpFJpDyNd8kYadPYwrg/lcEWYCLKQf/z9ebKaIVQUQEgCq9BvVIu0JRwRFhSvKw9D2os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725101388; c=relaxed/simple;
	bh=u8H659J52SezNhBr2dXakaDXXf6AdZXUY3t9RClnEuI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n2SF3tzsPdFrhkIy8cdUk2tbCZmjtovk0CMyzieOvKiPo5ZqpJM94kffRlq570VHkWCjMK+4OeXgHG1tdnpQY2WDXx3bASBaZJUi46Qo6F232QO9dhS8G6EEtY0giBVwldolTcntn+D5ZupFaZl2ukz8TmNbpcINY9htP3fs7qM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lZYSDMRL; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-498db1fe5ccso947009137.0
        for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 03:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725101386; x=1725706186; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PLlRZBudcu0lYfVZFrWfCDmNfufwcjnWFsmygXQl1x4=;
        b=lZYSDMRLvI6A+9qZEthL2wf3/HHafe9GDPFdYJtAemM9o5ogm7RS7VMaCTw2qI81Z1
         S4Q9O1FGaLeCfmVRXqyRPkVV6zxW0RqYO1dJxovPlgGzOxIP+3V1LNiVck9482qAssh5
         nD8qZc3fwpq8pZxjjTyjaLfCpjWCWHXt0u9zOmnMNoz5DjyKegokVkAGL2pFEogAN2HL
         ujO38OIpn9lX48FM2i3AH5sX0r3qz/un3W0dfFFpMRGvMDBCoYkXehbrx2RVzcU+c0Z2
         7OAZVRSFb8Ih41FotR6tsUVYUOmntKleQ9AaYq3+EbY2gtbrPg5Xh6Z5fCWr+fomz+w9
         atjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725101386; x=1725706186;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PLlRZBudcu0lYfVZFrWfCDmNfufwcjnWFsmygXQl1x4=;
        b=c79ZFkpWCFWFvhF+ZcpbwvkDh62AYfPKjUfFce9kM4TTfneZITvuJbXiSL/z1X1/Hy
         wj7fv9K6+qSZVopVaaoPSbzYjC8DV34grnrFwzpNtCnVHo4xrRASjbYTLjFCJTNXG3vJ
         vbNLGiqfSsHbkVSH/JLaScv1cSB4ydWwkzXjBT07IkKGvgm7drpfhz3RyzDz/p3MHpJg
         MjnTcOc98WkacpZFUfowfHiuWW+VLReZT8pdw2fBSZi558BQJzO9lHYeWN4xH9PpD36b
         etlTxDW9tCupILeOdDttlqVZ6/PBlwZnefa6JjXAFp1Xv0ZkTAFjGCTbhemnNUxYyQua
         PMFg==
X-Forwarded-Encrypted: i=1; AJvYcCUR5hs71N7f2/RCQWSb0xg+JdbbIzZQBDin3q3wgBhgRtrtwvmRtlo3lNVxtz8pQcZjN5B2sRAYaDMqZ3s=@vger.kernel.org
X-Gm-Message-State: AOJu0YylfEtvv1ZWTQ4vATldzJG1auzE+uYtGZmnROB9roT2IGr8XaZV
	sG7xe8Oml0FHahUFMdR16RpKPsXb9rUh/UrLCkFcvtgeVtmdvVRgMvl0ZoIhwjSMJq5fhEbdaVW
	A2+T3HTJ8GkSZ6v/C0rGZtsQ0q0k=
X-Google-Smtp-Source: AGHT+IEbgi2v55hfNr0CeIbACWF0+0xRFrStO00QvCRxZUHHOS2FEhf1wvy5Xk+4HS1m94JXW/VS6KInFm7xT2jRt5A=
X-Received: by 2002:a05:6102:6cd:b0:48f:3df9:ff9 with SMTP id
 ada2fe7eead31-49a5ae39a41mr10736962137.8.1725101385948; Sat, 31 Aug 2024
 03:49:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240831092339.66085-1-21cnbao@gmail.com> <d0b826c1-8577-46f8-8e4c-ca2b72554819@redhat.com>
 <CAGsJ_4ynOeOaRb3=xBc1uETn9oLTkSpZGoEYGpTeJ1F4uqB7bA@mail.gmail.com>
 <b7853f0f-7044-4c49-931c-c61900229b19@redhat.com> <CAGsJ_4wwg-f32e=xSHn+Rxv5k7H6VXhUu3+v_ZOShL_mGn2Xew@mail.gmail.com>
 <36933711-ae0f-468c-93bd-d6a67d974c9d@redhat.com>
In-Reply-To: <36933711-ae0f-468c-93bd-d6a67d974c9d@redhat.com>
From: Barry Song <21cnbao@gmail.com>
Date: Sat, 31 Aug 2024 22:49:30 +1200
Message-ID: <CAGsJ_4wzqK7Typyg1Nx9NCw5A5-1CjVp8LMR3CeGJNJ_UDKAQQ@mail.gmail.com>
Subject: Re: [PATCH RFC] mm: entirely reuse the whole anon mTHP in do_wp_page
To: David Hildenbrand <david@redhat.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Barry Song <v-songbaohua@oppo.com>, 
	Chuanhua Han <hanchuanhua@oppo.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Zi Yan <ziy@nvidia.com>, Chris Li <chrisl@kernel.org>, 
	Kairui Song <kasong@tencent.com>, Kalesh Singh <kaleshsingh@google.com>, 
	Suren Baghdasaryan <surenb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 31, 2024 at 10:29=E2=80=AFPM David Hildenbrand <david@redhat.co=
m> wrote:
>
> On 31.08.24 12:21, Barry Song wrote:
> > On Sat, Aug 31, 2024 at 10:07=E2=80=AFPM David Hildenbrand <david@redha=
t.com> wrote:
> >>
> >> On 31.08.24 11:55, Barry Song wrote:
> >>> On Sat, Aug 31, 2024 at 9:44=E2=80=AFPM David Hildenbrand <david@redh=
at.com> wrote:
> >>>>
> >>>> On 31.08.24 11:23, Barry Song wrote:
> >>>>> From: Barry Song <v-songbaohua@oppo.com>
> >>>>>
> >>>>> On a physical phone, it's sometimes observed that deferred_split
> >>>>> mTHPs account for over 15% of the total mTHPs. Profiling by Chuanhu=
a
> >>>>> indicates that the majority of these originate from the typical for=
k
> >>>>> scenario.
> >>>>> When the child process either execs or exits, the parent process sh=
ould
> >>>>> ideally be able to reuse the entire mTHP. However, the current kern=
el
> >>>>> lacks this capability and instead places the mTHP into split_deferr=
ed,
> >>>>> performing a CoW (Copy-on-Write) on just a single subpage of the mT=
HP.
> >>>>>
> >>>>>     main()
> >>>>>     {
> >>>>>     #define SIZE 1024 * 1024UL
> >>>>>             void *p =3D malloc(SIZE);
> >>>>>             memset(p, 0x11, SIZE);
> >>>>>             if (fork() =3D=3D 0)
> >>>>>                     exec(....);
> >>>>>            /*
> >>>>>          * this will trigger cow one subpage from
> >>>>>          * mTHP and put mTHP into split_deferred
> >>>>>          * list
> >>>>>          */
> >>>>>         *(int *)(p + 10) =3D 10;
> >>>>>         printf("done\n");
> >>>>>         while(1);
> >>>>>     }
> >>>>>
> >>>>> This leads to two significant issues:
> >>>>>
> >>>>> * Memory Waste: Before the mTHP is fully split by the shrinker,
> >>>>> it wastes memory. In extreme cases, such as with a 64KB mTHP,
> >>>>> the memory usage could be 64KB + 60KB until the last subpage
> >>>>> is written, at which point the mTHP is freed.
> >>>>>
> >>>>> * Fragmentation and Performance Loss: It destroys large folios
> >>>>> (negating the performance benefits of CONT-PTE) and fragments memor=
y.
> >>>>>
> >>>>> To address this, we should aim to reuse the entire mTHP in such cas=
es.
> >>>>>
> >>>>> Hi David,
> >>>>>
> >>>>> I=E2=80=99ve renamed wp_page_reuse() to wp_folio_reuse() and added =
an
> >>>>> entirely_reuse argument because I=E2=80=99m not sure if there are s=
till cases
> >>>>> where we reuse a subpage within an mTHP. For now, I=E2=80=99m setti=
ng
> >>>>> entirely_reuse to true only for the newly supported case, while all
> >>>>> other cases still get false. Please let me know if this is incorrec=
t=E2=80=94if
> >>>>> we don=E2=80=99t reuse subpages at all, we could remove the argumen=
t.
> >>>>
> >>>> See [1] I sent out this week, that is able to reuse even without
> >>>> scanning page tables. If we find the the folio is exclusive we could=
 try
> >>>> processing surrounding PTEs that map the same folio.
> >>>>
> >>>> [1] https://lkml.kernel.org/r/20240829165627.2256514-1-david@redhat.=
com
> >>>
> >>> Great! It looks like I missed your patch again. Since you've implemen=
ted this
> >>> in a better way, I=E2=80=99d prefer to use your patchset.
> >>
> >> I wouldn't say better, just more universally. And while taking care of
> >> properly sync'ing the mapcount vs. refcount :P
> >>
> >>>
> >>> I=E2=80=99m curious about how you're handling ptep_set_access_flags_n=
r() or similar
> >>> things because I couldn=E2=80=99t find the related code in your patch=
 10/17:
> >>>
> >>> [PATCH v1 10/17] mm: COW reuse support for PTE-mapped THP with CONFIG=
_MM_ID
> >>>
> >>> Am I missing something?
> >>
> >> The idea is to keep individual write faults as fast as possible. So th=
e
> >> patch set keeps it simple and only reuses a single PTE at a time,
> >> setting that one PAE and mapping it writable.
> >
> > I got your point, thanks! as anyway the mTHP has been exclusive,
> > so the following nr-1 minor page faults will set their particular PTE
> > to writable one by one.
>
> Yes, assuming you would get these page faults, and assuming you would
> get them in the near future.
>
> >
> >>
> >> As the patch states, it might be reasonable to optimize some cases,
> >> maybe also only on some architectures. For example to fault-around and
> >> map the other ones writable as well. It might not always be desirable
> >> though, especially not for larger folios.
> >
> > as anyway, the mTHP has been entirely exclusive, setting all PTEs
> > directly to writable should help reduce nr - 1 minor page faults and
> > ideally help reduce CONTPTE unfold and fold?
>
> Yes, doing that on CONTPTE granularity would very likely make sense. For
> anything bigger than that, I am not sure.
>
> Assuming we have a 1M folio mapped by PTEs. Trying to fault-around in
> aligned CONTPTE granularity likely makes sense. Bigger than that, I am
> not convinced.
>

I see. maybe we can have something like:

static bool pte_fault_around_estimate(int nr)
{
       if (nr / arch_batched_ptes_nr() < 16)
             return true;

       return false;
}

if (pte_fault_around_estimate(folio_nr_pages(folio)))
       set all ptes;

for arm64, arch_batched_ptes_nr()  =3D=3D 16. for
arch without cont-pte or similar things,
arch_batched_ptes_nr()  =3D=3D 1.

Just some rough ideas; all the naming might be quite messy.

at least, we won't lose the benefit of reduced TLB miss
before all nr_pages are written for aarch64 :-)

> >
> > What is the downside to doing that? I also don't think mapping them
> > all together will waste memory?
>
> No, it's all about increasing the latency of individual write faults.
>

i see, i assume it won't be worse than the current case where we have to
allocate small folios and copy? and folio allocation can even further incur
direct reclamation?

> --
> Cheers,
>
> David / dhildenb
>

Thanks
Barry

