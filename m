Return-Path: <linux-kernel+bounces-231660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10F30919B94
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 02:03:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAD34283359
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 00:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB8542C9D;
	Thu, 27 Jun 2024 00:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CGUtn3Zy"
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB3D629
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 00:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719446594; cv=none; b=m4Ky4IcdIuYRizRLyGJqaj8ayHljxPzWJ7WepoKx7gRM9kWYdqfnxcSQ81lcJNTHKKzaFMu6Xm2LXE8reJSfeNO3HTf/jyj8ZIuodMiI8i+ZVMC9gJDyDgoHk1r9zI+yiQNBiNw26Q3tFN7yeq9CJ0R/Jn7QB9GX1q589TsnaGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719446594; c=relaxed/simple;
	bh=uFsXPUOM7t0SAHjxeAnchT5Pm+ySSFR3H/fDdydBSGE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p6PHcSD+YOs/nwAu/ZmYS+F8WjNk3kTEyRLJKLeSdqlnXnc1KYm1ejHO8uUE8FAM9kOhIq3XBkmK290sv30nE9buXmQ4DqPRHVlGPYFDoVx9m2MzTFCPcL4No1UK2uhrihQr+aS2ycpaBb4Qm/o7xx2NPTgkv9rUzaOLjaFkSGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CGUtn3Zy; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-4ef662a4725so1976828e0c.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 17:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719446591; x=1720051391; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CaBxld+J1XwtA8Cr0D6dJ73bFize85s5kEmh+05NRl0=;
        b=CGUtn3ZyyePIuE0Cu/JI4fNE5D+DPy2PyKCPYRavXXVtNxUSWN6ozW1+DZhVuvNYfY
         IZp/dOeDSyxB64DvvpvNpBvHfyXwbJh+yGqAJXQOmFzADQfCzhVoknIlklOWe8G3J6qe
         w9CGP7/EdsdnyBlQhNWP/oop7fLE8cfyi6fdI2MeZGOV8tRde2+ks3thjIOJRprQ4jWz
         +JnJSlk+fhzxskC4++12IIe5RGG3Fu8/x93aLEcntoAJDnfmVQ5OGM5DJu6FhJvC+S8n
         sw9HDoKV8/aKwvLmsYarPt/7R4dlaZY4uytBY2WDyEfJY4cW+C7CATGaAq1zjqRNoRld
         uoVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719446591; x=1720051391;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CaBxld+J1XwtA8Cr0D6dJ73bFize85s5kEmh+05NRl0=;
        b=wIAikbyP5duW3wJePZvNMC3ZHM0p34g6p2OmZumjluussyQN4IAN5XDWDOtcm01648
         w3w8L2ai8PoS5RWyhvciC0O0pPCmyN7Sxaz74dujaVX0iAUKCFU1aj4+2IifYwAWK+jd
         3/B7OoQOiZhhrWTPXx0G2+GrNLT7+MCCKuLiDIuQ93+XCo4LILuiVsdopd71S5ibrpiy
         netFOatSvrNLUBqsGNMA+4w0Q9rVQOcxIYNskgqb64iH9Dm02B9BRQniBsaqXP3fgnSs
         j3XjgImjAqFXwnxP3CmaV+RFREvqZ5w3BrPVQK05vI+WQ81RKVZC5ncz1tyYxk3r1SrZ
         N2uA==
X-Forwarded-Encrypted: i=1; AJvYcCVSkmzC18UspMOWQ8EJbUFQGqUCrB/koaAnOGvix1c/c325fE8b9B1fQKFKOKaC99uO+Cf0Ekg9biYhbKbATKpfxOlBHHETaQApOcYZ
X-Gm-Message-State: AOJu0YxYod56Xmxn9BWF3lwqibSs38Lrdqjv2Py+ZCVNEacThil8XxTo
	4wp9X20M9Wh3UHfQZV8nZkN+ohMoRbgy6JGrV+GiQwx9+cVm6+qdVN0+tjKejUBgYa5/rtlafbO
	iJAlrRXigGTpQAQGlAP0I96g92gk=
X-Google-Smtp-Source: AGHT+IGJ1AunyRMi67T3jIWGi3K4o1jVtC9XwdtFVTOCOvFMCxLgGqIjW0q5It6QXxQ1QD2nsmxeWWbUHEwn/FYlTvY=
X-Received: by 2002:a05:6122:3117:b0:4ec:f8f0:7175 with SMTP id
 71dfb90a1353d-4ef6a73183bmr11384328e0c.11.1719446590855; Wed, 26 Jun 2024
 17:03:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240622071231.576056-1-21cnbao@gmail.com> <557d7f05-6ba9-482d-b3fb-29eb72cdf09c@arm.com>
 <CAGsJ_4zQ0vjX1UM62o0Wsgh9XYW0SGv2cyG5gUpbP_+Tx3WZLg@mail.gmail.com>
 <76876c5f-f769-43f1-ad53-a4af288af467@arm.com> <CAGsJ_4zpn5dMNNNcVcMngT-mJpWV-bzUV+RfQaLLjxMC73xfig@mail.gmail.com>
 <f9fde05b-0340-49fc-92f9-7fa091580444@arm.com>
In-Reply-To: <f9fde05b-0340-49fc-92f9-7fa091580444@arm.com>
From: Barry Song <21cnbao@gmail.com>
Date: Thu, 27 Jun 2024 12:02:59 +1200
Message-ID: <CAGsJ_4xf_s57g5NmxbzFSZqyU05n4CoF5PFTZO73CE4CmB9fEw@mail.gmail.com>
Subject: Re: [PATCH v2 0/1] tools/mm: Introduce a tool to assess swap entry
 allocation for thp_swapout
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: akpm@linux-foundation.org, chrisl@kernel.org, linux-mm@kvack.org, 
	david@redhat.com, hughd@google.com, kaleshsingh@google.com, 
	kasong@tencent.com, linux-kernel@vger.kernel.org, v-songbaohua@oppo.com, 
	ying.huang@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 25, 2024 at 8:11=E2=80=AFPM Ryan Roberts <ryan.roberts@arm.com>=
 wrote:
>
> On 25/06/2024 01:11, Barry Song wrote:
> > On Mon, Jun 24, 2024 at 10:35=E2=80=AFPM Ryan Roberts <ryan.roberts@arm=
.com> wrote:
> >>
> >> On 24/06/2024 09:42, Barry Song wrote:
> >>> On Mon, Jun 24, 2024 at 8:26=E2=80=AFPM Ryan Roberts <ryan.roberts@ar=
m.com> wrote:
> >>>>
> >>>> On 22/06/2024 08:12, Barry Song wrote:
> >>>>> From: Barry Song <v-songbaohua@oppo.com>
> >>>>>
> >>>>> -v2:
> >>>>>  * add swap-in which can either be aligned or not aligned, by "-a";
> >>>>>    Ying;
> >>>>>  * move the program to tools/mm; Ryan;
> >>>>>  * try to simulate the scenarios swap is full. Chris;
> >>>>>
> >>>>> -v1:
> >>>>>  https://lore.kernel.org/linux-mm/20240620002648.75204-1-21cnbao@gm=
ail.com/
> >>>>>
> >>>>> I tested Ryan's RFC patchset[1] and Chris's v3[2] using this v2 too=
l:
> >>>>> [1] https://lore.kernel.org/linux-mm/20240618232648.4090299-1-ryan.=
roberts@arm.com/
> >>>>> [2] https://lore.kernel.org/linux-mm/20240614-swap-allocator-v2-0-2=
a513b4a7f2f@kernel.org/
> >>>>>
> >>>>> Obviously, we're rarely hitting 100% even in the worst case without=
 "-a" and with
> >>>>> "-s," which is good news!
> >>>>> If swapin is aligned w/ "-a" and w/o "-s", both Chris's and Ryan's =
patches show
> >>>>> a low fallback ratio though Chris's has the numbers above 0% but Ry=
an's are 0%
> >>>>> (value A).
> >>>>>
> >>>>> The bad news is that unaligned swapin can significantly increase th=
e fallback ratio,
> >>>>> reaching up to 85% for Ryan's patch and 95% for Chris's patchset wi=
thout "-s." Both
> >>>>> approaches approach 100% without "-a" and with "-s" (value B).
> >>>>>
> >>>>> I believe real workloads should yield a value between A and B. With=
out "-a," and
> >>>>> lacking large folios swap-in, this tool randomly swaps in small fol=
ios without
> >>>>> considering spatial locality, which is a factor present in real wor=
kloads. This
> >>>>> typically results in values higher than A and lower than B.
> >>>>>
> >>>>> Based on the below results, I believe that:
> >>>>
> >>>> Thanks for putting this together and providing such detailed results=
!
> >>>>
> >>>>> 1. We truly require large folio swap-in to achieve comparable resul=
ts with
> >>>>> aligned swap-in(based on the result w/o and w/ "-a")
> >>>>
> >>>> I certainly agree that as long as we require a high order swap entry=
 to be
> >>>> contiguous in the backing store then it looks like we are going to n=
eed large
> >>>> folio swap-in to prevent enormous fragmentation. I guess Chris's pro=
posed layer
> >>>> of indirection to allow pages to be scattered in the backing store w=
ould also
> >>>> solve the problem? Although, I'm not sure this would work well for z=
Ram?
> >>>
> >>> The challenge is that we also want to take advantage of improving zsm=
alloc
> >>> to save compressed multi-pages. However, it seems quite impossible fo=
r
> >>> zsmalloc to achieve this for a mTHP is scattered but not put together=
 in
> >>> zRAM.
> >>
> >> Yes understood. I finally got around to watching the lsfmm videos; I b=
elieve the
> >> suggested solution with a fs-like approach would be to let the fs hand=
le the
> >> compression, which means compressing extents? So even with that approa=
ch,
> >> presumably its still valuable to be able to allocate the biggest exten=
ts possible.
> >>
> >>>
> >>>>
> >>>> Perhaps another way of looking at this is that we are doing a bad jo=
b of
> >>>> selecting when to use an mTHP and when not to use one in the first p=
lace;
> >>>> ideally the workload would access the data across the entire mTHP wi=
th high
> >>>> temporal locality? In that case, we would expect the whole mTHP to b=
e swapped in
> >>>> even with the current page-by-page approach. Figuring out this "auto=
 sizing"
> >>>> seems like an incredibly complex problem to solve though.
> >>>
> >>> The good news is that this is exactly what we're implementing in our =
products,
> >>> and it has been deployed on millions of phones.
> >>>
> >>>   *  Allocate mTHP and swap in the entire mTHP  in do_swap_page();
> >>>   *  If mTHP allocation fails, allocate 16 pages to swap-in in do_swa=
p_page();
> >>
> >> I think we were talking cross-purposes here. What I meant was that in =
an ideal
> >> world we would only allocate a (64K) mTHP for a page fault if we had c=
onfidence
> >> (via some heuristic) that the virtual 64K area was likely to always be=
 accessed
> >> together, else just allocate a small folio. i.e. choose the folio size=
 to cover
> >> a single object from user space's PoV. That would have the side effect=
 that a
> >> page-by-page swap-in approach (the current approach in mainline) would=
 still
> >> effectively result in swapping in the whole folio and therefore reduce
> >> fragementation in the swap file. (Or thinking about it slightly differ=
ently, it
> >> would give us confidence to always swap-in a large folio at a time, be=
cause we
> >> know its all highly likely to get used in the near future).
> >>
> >> I suspect this is a moot point though, because divinging a suitable he=
uristic
> >> with low overhead is basically impossible.
> >>
> >>>
> >>> To be honest, we haven't noticed a visible increase in memory footpri=
nt. This is
> >>> likely because Android's anonymous memory exhibits good spatial local=
ity, and
> >>> 64KiB strikes a good balance=E2=80=94neither too large nor too small.
> >>
> >> Indeed.
> >>
> >>>
> >>> The bad news is that I haven't found a way to convince the community =
this
> >>> is universally correct.
> >>
> >> I think we will want to be pragmatic and at least implement an option =
(sysfs?)
> >> to swap-in a large folio up to a certain size; These test results clea=
rly show
> >> the value. And I believe you have real-world data for Android that sho=
ws the
> >> same thing.
> >>
> >> Just to creep the scope of this thread slightly, after watching yours =
and Yu
> >> Zhou's presentations around TAO, IIUC, even with TAO enabled, 64K foli=
o
> >> allocation fallback is still above 50%? I still believe that once the =
Android
> >> filesystems are converted to use large folios that number will improve
> >> substantially; especially if the page cache can be convinced to only a=
llocate
> >> 64K folios (with 4K fallback). At that point you're predominantly usin=
g 64K
> >> folios so intuitively there will be less fragmentation.
> >
> > Absolutely agreed. Currently, I reported an allocation fallback rate
> > slightly above 50%, but
> > this is not because TAO is ineffective. It's simply because, in the
> > test, we set up a
> > conservative 15% virtzone for mTHP. If we increase the zone, we would d=
efinitely
> > achieve a lower fallback ratio. However, the issue arises when we need
> > a large number
> > of small folios=E2=80=94 for example, for the page cache=E2=80=94becaus=
e they might
> > suffer. However,
> > we should be able to increase the percentage of the virtzone after
> > some fine-tuning, as
> > the report was based on an initial test to demonstrate that TAO can
> > provide guaranteed
> > mTHP coverage.
> >
> > If we can somehow unify the mTHP size for both the page cache and anon,=
 things
> > might improve.
>
> Indeed. And that implies we might need extra controls for the page cache,=
 which
> I don't think Willy will be a fan of. It would be good to get some fragme=
ntation
> data for Android with a file system that supports large folios, both with=
 the
> page cache folio allocation scheme as it is today, and constrained to 64K=
 and
> 4K. Rather than waiting for all the Android file systems to land support =
for
> large folios, is it possible to hand roll all the Android partitions as X=
FS?
> I've done that in the past for the user data partition at least.

It might be a good idea to evaluate page cache large folios without
waiting for EROFS
and F2FS.
I need to do more research on deploying XFS on Android before getting
back to you.

>
> >
> > Xiang promised to deliver EROFS large folio support. If we also get
> > this in f2fs, things
> > will be quite different.
>
> Excellent! So Oppo is using only erofs and f2fs? What about ext4? And all=
 the
> ancillary things like fscrypt and fsverity, etc? (I've been hand waving a=
 bit to
> this point, but it would be good to build a full list of all the componen=
ts that
> need large folio support for large folio file-backed memory to be viable =
on
> Android, if you can help enumerate that?)

We get all of tmpfs, ext4, f2fs, erofs, vfat and fuse for different folders=
.

>
> >
> >>
> >> But allocations by the page cache today start at 16K and increment by =
2 orders
> >> for every new readahead IIRC. So we end up with lots of large folio si=
zes, and
> >> presumably the potential for lots of fallbacks.
> >>
> >> All of this is just to suggest that we may end up wanting controls to =
specify
> >> which folio sizes the page cache can attempt to use. At that point, ad=
ding
> >> similar controls for swap-in doesn't feel unreasonable to me.
> >>
> >> Just my 2 cents!
> >>
> >>>
> >>>>
> >>>>> 2. We need a method to prevent small folios from scattering indiscr=
iminately
> >>>>> (based on the result "-a -s")
> >>>>
> >>>> I'm confused by this statement; as I undersand it, both my and Chris=
's patches
> >>>> already try to do this. Certainly for mine, when searching for order=
-0 space, I
> >>>> search the non-full order-0 clusters first (just like for other orde=
rs).
> >>>> Although for order-0 I will still fallback to searching any cluster =
if no space
> >>>> is found in an order-0 cluster. What more can we do?
> >>>>
> >>>> When run against your v1 of the tool with "-s" (v1 always implicily =
behaves as
> >>>> if "-a" is specified, right?) my patch gives 0% fallback. So what's =
the
> >>>> difference in v2 that causes higher fallback rate? Possibly just tha=
t
> >>>> MEMSIZE_SMALLFOLIO has grown by 3MB so that the total memory matches=
 the swap
> >>>> size (64M)?
> >>>
> >>> Exactly. From my understanding, we've reached a point where small fol=
ios are
> >>> struggling to find swap slots. Note that I always swap out mTHP befor=
e swapping
> >>> out small folios. Additionally, I have already swapped in 1MB small
> >>> folios before
> >>> swapping out, which means zRAM has 1MB-4KB of redundant space availab=
le
> >>> for mTHP to swap out.
> >>>
> >>>>
> >>>> Thanks,
> >>>> Ryan
> >>>>
> >>>>>
> >>>>> *
> >>>>> *  Test results on Ryan's patchset:
> >>>>> *
> >>>>>
> >>>>> 1. w/ -a
> >>>>> ./thp_swap_allocator_test -a
> >>>>> Iteration 1: swpout inc: 224, swpout fallback inc: 0, Fallback perc=
entage: 0.00%
> >>>>> Iteration 2: swpout inc: 231, swpout fallback inc: 0, Fallback perc=
entage: 0.00%
> >>>>> Iteration 3: swpout inc: 227, swpout fallback inc: 0, Fallback perc=
entage: 0.00%
> >>>>> Iteration 4: swpout inc: 222, swpout fallback inc: 0, Fallback perc=
entage: 0.00%
> >>>>> ...
> >>>>> Iteration 100: swpout inc: 228, swpout fallback inc: 0, Fallback pe=
rcentage: 0.00%
> >>>>>
> >>>>> 2. w/o -a
> >>>>> ./thp_swap_allocator_test
> >>>>>
> >>>>> Iteration 1: swpout inc: 208, swpout fallback inc: 25, Fallback per=
centage: 10.73%
> >>>>> Iteration 2: swpout inc: 118, swpout fallback inc: 114, Fallback pe=
rcentage: 49.14%
> >>>>> Iteration 3: swpout inc: 63, swpout fallback inc: 163, Fallback per=
centage: 72.12%
> >>>>> Iteration 4: swpout inc: 45, swpout fallback inc: 178, Fallback per=
centage: 79.82%
> >>>>> Iteration 5: swpout inc: 42, swpout fallback inc: 184, Fallback per=
centage: 81.42%
> >>>>> Iteration 6: swpout inc: 31, swpout fallback inc: 193, Fallback per=
centage: 86.16%
> >>>>> Iteration 7: swpout inc: 27, swpout fallback inc: 201, Fallback per=
centage: 88.16%
> >>>>> Iteration 8: swpout inc: 30, swpout fallback inc: 198, Fallback per=
centage: 86.84%
> >>>>> Iteration 9: swpout inc: 32, swpout fallback inc: 194, Fallback per=
centage: 85.84%
> >>>>> ...
> >>>>> Iteration 91: swpout inc: 26, swpout fallback inc: 194, Fallback pe=
rcentage: 88.18%
> >>>>> Iteration 92: swpout inc: 35, swpout fallback inc: 196, Fallback pe=
rcentage: 84.85%
> >>>>> Iteration 93: swpout inc: 33, swpout fallback inc: 191, Fallback pe=
rcentage: 85.27%
> >>>>> Iteration 94: swpout inc: 26, swpout fallback inc: 193, Fallback pe=
rcentage: 88.13%
> >>>>> Iteration 95: swpout inc: 39, swpout fallback inc: 189, Fallback pe=
rcentage: 82.89%
> >>>>> Iteration 96: swpout inc: 28, swpout fallback inc: 196, Fallback pe=
rcentage: 87.50%
> >>>>> Iteration 97: swpout inc: 25, swpout fallback inc: 194, Fallback pe=
rcentage: 88.58%
> >>>>> Iteration 98: swpout inc: 31, swpout fallback inc: 196, Fallback pe=
rcentage: 86.34%
> >>>>> Iteration 99: swpout inc: 32, swpout fallback inc: 202, Fallback pe=
rcentage: 86.32%
> >>>>> Iteration 100: swpout inc: 33, swpout fallback inc: 195, Fallback p=
ercentage: 85.53%
> >>>>>
> >>>>> 3. w/ -a and -s
> >>>>> ./thp_swap_allocator_test -a -s
> >>>>> Iteration 1: swpout inc: 224, swpout fallback inc: 0, Fallback perc=
entage: 0.00%
> >>>>> Iteration 2: swpout inc: 218, swpout fallback inc: 0, Fallback perc=
entage: 0.00%
> >>>>> Iteration 3: swpout inc: 222, swpout fallback inc: 0, Fallback perc=
entage: 0.00%
> >>>>> Iteration 4: swpout inc: 220, swpout fallback inc: 6, Fallback perc=
entage: 2.65%
> >>>>> Iteration 5: swpout inc: 206, swpout fallback inc: 16, Fallback per=
centage: 7.21%
> >>>>> Iteration 6: swpout inc: 233, swpout fallback inc: 0, Fallback perc=
entage: 0.00%
> >>>>> Iteration 7: swpout inc: 224, swpout fallback inc: 0, Fallback perc=
entage: 0.00%
> >>>>> Iteration 8: swpout inc: 228, swpout fallback inc: 0, Fallback perc=
entage: 0.00%
> >>>>> Iteration 9: swpout inc: 217, swpout fallback inc: 0, Fallback perc=
entage: 0.00%
> >>>>> Iteration 10: swpout inc: 224, swpout fallback inc: 3, Fallback per=
centage: 1.32%
> >>>>> Iteration 11: swpout inc: 211, swpout fallback inc: 12, Fallback pe=
rcentage: 5.38%
> >>>>> Iteration 12: swpout inc: 200, swpout fallback inc: 32, Fallback pe=
rcentage: 13.79%
> >>>>> Iteration 13: swpout inc: 189, swpout fallback inc: 29, Fallback pe=
rcentage: 13.30%
> >>>>> Iteration 14: swpout inc: 195, swpout fallback inc: 31, Fallback pe=
rcentage: 13.72%
> >>>>> Iteration 15: swpout inc: 198, swpout fallback inc: 27, Fallback pe=
rcentage: 12.00%
> >>>>> Iteration 16: swpout inc: 201, swpout fallback inc: 17, Fallback pe=
rcentage: 7.80%
> >>>>> Iteration 17: swpout inc: 206, swpout fallback inc: 6, Fallback per=
centage: 2.83%
> >>>>> Iteration 18: swpout inc: 220, swpout fallback inc: 14, Fallback pe=
rcentage: 5.98%
> >>>>> Iteration 19: swpout inc: 181, swpout fallback inc: 45, Fallback pe=
rcentage: 19.91%
> >>>>> Iteration 20: swpout inc: 223, swpout fallback inc: 8, Fallback per=
centage: 3.46%
> >>>>> Iteration 21: swpout inc: 214, swpout fallback inc: 14, Fallback pe=
rcentage: 6.14%
> >>>>> Iteration 22: swpout inc: 195, swpout fallback inc: 31, Fallback pe=
rcentage: 13.72%
> >>>>> Iteration 23: swpout inc: 223, swpout fallback inc: 0, Fallback per=
centage: 0.00%
> >>>>> Iteration 24: swpout inc: 233, swpout fallback inc: 0, Fallback per=
centage: 0.00%
> >>>>> Iteration 25: swpout inc: 214, swpout fallback inc: 1, Fallback per=
centage: 0.47%
> >>>>> Iteration 26: swpout inc: 229, swpout fallback inc: 1, Fallback per=
centage: 0.43%
> >>>>> Iteration 27: swpout inc: 214, swpout fallback inc: 5, Fallback per=
centage: 2.28%
> >>>>> Iteration 28: swpout inc: 211, swpout fallback inc: 15, Fallback pe=
rcentage: 6.64%
> >>>>> Iteration 29: swpout inc: 188, swpout fallback inc: 40, Fallback pe=
rcentage: 17.54%
> >>>>> Iteration 30: swpout inc: 207, swpout fallback inc: 18, Fallback pe=
rcentage: 8.00%
> >>>>> Iteration 31: swpout inc: 215, swpout fallback inc: 10, Fallback pe=
rcentage: 4.44%
> >>>>> Iteration 32: swpout inc: 202, swpout fallback inc: 22, Fallback pe=
rcentage: 9.82%
> >>>>> Iteration 33: swpout inc: 223, swpout fallback inc: 0, Fallback per=
centage: 0.00%
> >>>>> Iteration 34: swpout inc: 218, swpout fallback inc: 10, Fallback pe=
rcentage: 4.39%
> >>>>> Iteration 35: swpout inc: 203, swpout fallback inc: 30, Fallback pe=
rcentage: 12.88%
> >>>>> Iteration 36: swpout inc: 214, swpout fallback inc: 14, Fallback pe=
rcentage: 6.14%
> >>>>> Iteration 37: swpout inc: 211, swpout fallback inc: 14, Fallback pe=
rcentage: 6.22%
> >>>>> Iteration 38: swpout inc: 193, swpout fallback inc: 28, Fallback pe=
rcentage: 12.67%
> >>>>> Iteration 39: swpout inc: 210, swpout fallback inc: 20, Fallback pe=
rcentage: 8.70%
> >>>>> Iteration 40: swpout inc: 223, swpout fallback inc: 5, Fallback per=
centage: 2.19%
> >>>>> Iteration 41: swpout inc: 224, swpout fallback inc: 7, Fallback per=
centage: 3.03%
> >>>>> Iteration 42: swpout inc: 200, swpout fallback inc: 23, Fallback pe=
rcentage: 10.31%
> >>>>> Iteration 43: swpout inc: 217, swpout fallback inc: 5, Fallback per=
centage: 2.25%
> >>>>> Iteration 44: swpout inc: 206, swpout fallback inc: 18, Fallback pe=
rcentage: 8.04%
> >>>>> Iteration 45: swpout inc: 210, swpout fallback inc: 11, Fallback pe=
rcentage: 4.98%
> >>>>> Iteration 46: swpout inc: 204, swpout fallback inc: 19, Fallback pe=
rcentage: 8.52%
> >>>>> Iteration 47: swpout inc: 228, swpout fallback inc: 0, Fallback per=
centage: 0.00%
> >>>>> Iteration 48: swpout inc: 219, swpout fallback inc: 2, Fallback per=
centage: 0.90%
> >>>>> Iteration 49: swpout inc: 212, swpout fallback inc: 6, Fallback per=
centage: 2.75%
> >>>>> Iteration 50: swpout inc: 207, swpout fallback inc: 15, Fallback pe=
rcentage: 6.76%
> >>>>> Iteration 51: swpout inc: 190, swpout fallback inc: 36, Fallback pe=
rcentage: 15.93%
> >>>>> Iteration 52: swpout inc: 212, swpout fallback inc: 17, Fallback pe=
rcentage: 7.42%
> >>>>> Iteration 53: swpout inc: 179, swpout fallback inc: 43, Fallback pe=
rcentage: 19.37%
> >>>>> Iteration 54: swpout inc: 225, swpout fallback inc: 0, Fallback per=
centage: 0.00%
> >>>>> Iteration 55: swpout inc: 224, swpout fallback inc: 2, Fallback per=
centage: 0.88%
> >>>>> Iteration 56: swpout inc: 220, swpout fallback inc: 8, Fallback per=
centage: 3.51%
> >>>>> Iteration 57: swpout inc: 203, swpout fallback inc: 25, Fallback pe=
rcentage: 10.96%
> >>>>> Iteration 58: swpout inc: 213, swpout fallback inc: 6, Fallback per=
centage: 2.74%
> >>>>> Iteration 59: swpout inc: 207, swpout fallback inc: 18, Fallback pe=
rcentage: 8.00%
> >>>>> Iteration 60: swpout inc: 216, swpout fallback inc: 14, Fallback pe=
rcentage: 6.09%
> >>>>> Iteration 61: swpout inc: 183, swpout fallback inc: 34, Fallback pe=
rcentage: 15.67%
> >>>>> Iteration 62: swpout inc: 184, swpout fallback inc: 39, Fallback pe=
rcentage: 17.49%
> >>>>> Iteration 63: swpout inc: 184, swpout fallback inc: 39, Fallback pe=
rcentage: 17.49%
> >>>>> Iteration 64: swpout inc: 210, swpout fallback inc: 15, Fallback pe=
rcentage: 6.67%
> >>>>> Iteration 65: swpout inc: 178, swpout fallback inc: 48, Fallback pe=
rcentage: 21.24%
> >>>>> Iteration 66: swpout inc: 188, swpout fallback inc: 30, Fallback pe=
rcentage: 13.76%
> >>>>> Iteration 67: swpout inc: 193, swpout fallback inc: 29, Fallback pe=
rcentage: 13.06%
> >>>>> Iteration 68: swpout inc: 202, swpout fallback inc: 22, Fallback pe=
rcentage: 9.82%
> >>>>> Iteration 69: swpout inc: 213, swpout fallback inc: 5, Fallback per=
centage: 2.29%
> >>>>> Iteration 70: swpout inc: 204, swpout fallback inc: 15, Fallback pe=
rcentage: 6.85%
> >>>>> Iteration 71: swpout inc: 180, swpout fallback inc: 45, Fallback pe=
rcentage: 20.00%
> >>>>> Iteration 72: swpout inc: 210, swpout fallback inc: 21, Fallback pe=
rcentage: 9.09%
> >>>>> Iteration 73: swpout inc: 216, swpout fallback inc: 7, Fallback per=
centage: 3.14%
> >>>>> Iteration 74: swpout inc: 209, swpout fallback inc: 19, Fallback pe=
rcentage: 8.33%
> >>>>> Iteration 75: swpout inc: 222, swpout fallback inc: 7, Fallback per=
centage: 3.06%
> >>>>> Iteration 76: swpout inc: 212, swpout fallback inc: 14, Fallback pe=
rcentage: 6.19%
> >>>>> Iteration 77: swpout inc: 188, swpout fallback inc: 41, Fallback pe=
rcentage: 17.90%
> >>>>> Iteration 78: swpout inc: 198, swpout fallback inc: 17, Fallback pe=
rcentage: 7.91%
> >>>>> Iteration 79: swpout inc: 209, swpout fallback inc: 16, Fallback pe=
rcentage: 7.11%
> >>>>> Iteration 80: swpout inc: 182, swpout fallback inc: 41, Fallback pe=
rcentage: 18.39%
> >>>>> Iteration 81: swpout inc: 217, swpout fallback inc: 1, Fallback per=
centage: 0.46%
> >>>>> Iteration 82: swpout inc: 225, swpout fallback inc: 3, Fallback per=
centage: 1.32%
> >>>>> Iteration 83: swpout inc: 222, swpout fallback inc: 8, Fallback per=
centage: 3.48%
> >>>>> Iteration 84: swpout inc: 201, swpout fallback inc: 21, Fallback pe=
rcentage: 9.46%
> >>>>> Iteration 85: swpout inc: 211, swpout fallback inc: 3, Fallback per=
centage: 1.40%
> >>>>> Iteration 86: swpout inc: 209, swpout fallback inc: 14, Fallback pe=
rcentage: 6.28%
> >>>>> Iteration 87: swpout inc: 181, swpout fallback inc: 42, Fallback pe=
rcentage: 18.83%
> >>>>> Iteration 88: swpout inc: 223, swpout fallback inc: 4, Fallback per=
centage: 1.76%
> >>>>> Iteration 89: swpout inc: 214, swpout fallback inc: 14, Fallback pe=
rcentage: 6.14%
> >>>>> Iteration 90: swpout inc: 192, swpout fallback inc: 33, Fallback pe=
rcentage: 14.67%
> >>>>> Iteration 91: swpout inc: 184, swpout fallback inc: 31, Fallback pe=
rcentage: 14.42%
> >>>>> Iteration 92: swpout inc: 201, swpout fallback inc: 32, Fallback pe=
rcentage: 13.73%
> >>>>> Iteration 93: swpout inc: 181, swpout fallback inc: 40, Fallback pe=
rcentage: 18.10%
> >>>>> Iteration 94: swpout inc: 211, swpout fallback inc: 14, Fallback pe=
rcentage: 6.22%
> >>>>> Iteration 95: swpout inc: 198, swpout fallback inc: 25, Fallback pe=
rcentage: 11.21%
> >>>>> Iteration 96: swpout inc: 205, swpout fallback inc: 22, Fallback pe=
rcentage: 9.69%
> >>>>> Iteration 97: swpout inc: 218, swpout fallback inc: 12, Fallback pe=
rcentage: 5.22%
> >>>>> Iteration 98: swpout inc: 203, swpout fallback inc: 25, Fallback pe=
rcentage: 10.96%
> >>>>> Iteration 99: swpout inc: 218, swpout fallback inc: 12, Fallback pe=
rcentage: 5.22%
> >>>>> Iteration 100: swpout inc: 195, swpout fallback inc: 34, Fallback p=
ercentage: 14.85%
> >>>>>
> >>>>> 4. w/o -a and w/ -s
> >>>>> thp_swap_allocator_test  -s
> >>>>> Iteration 1: swpout inc: 173, swpout fallback inc: 60, Fallback per=
centage: 25.75%
> >>>>> Iteration 2: swpout inc: 85, swpout fallback inc: 147, Fallback per=
centage: 63.36%
> >>>>> Iteration 3: swpout inc: 39, swpout fallback inc: 195, Fallback per=
centage: 83.33%
> >>>>> Iteration 4: swpout inc: 13, swpout fallback inc: 220, Fallback per=
centage: 94.42%
> >>>>> Iteration 5: swpout inc: 10, swpout fallback inc: 215, Fallback per=
centage: 95.56%
> >>>>> Iteration 6: swpout inc: 9, swpout fallback inc: 219, Fallback perc=
entage: 96.05%
> >>>>> Iteration 7: swpout inc: 6, swpout fallback inc: 217, Fallback perc=
entage: 97.31%
> >>>>> Iteration 8: swpout inc: 6, swpout fallback inc: 215, Fallback perc=
entage: 97.29%
> >>>>> Iteration 9: swpout inc: 0, swpout fallback inc: 225, Fallback perc=
entage: 100.00%
> >>>>> Iteration 10: swpout inc: 1, swpout fallback inc: 229, Fallback per=
centage: 99.57%
> >>>>> Iteration 11: swpout inc: 2, swpout fallback inc: 216, Fallback per=
centage: 99.08%
> >>>>> Iteration 12: swpout inc: 2, swpout fallback inc: 229, Fallback per=
centage: 99.13%
> >>>>> Iteration 13: swpout inc: 4, swpout fallback inc: 211, Fallback per=
centage: 98.14%
> >>>>> Iteration 14: swpout inc: 1, swpout fallback inc: 221, Fallback per=
centage: 99.55%
> >>>>> Iteration 15: swpout inc: 2, swpout fallback inc: 223, Fallback per=
centage: 99.11%
> >>>>> Iteration 16: swpout inc: 3, swpout fallback inc: 224, Fallback per=
centage: 98.68%
> >>>>> Iteration 17: swpout inc: 2, swpout fallback inc: 231, Fallback per=
centage: 99.14%
> >>>>> ...
> >>>>>
> >>>>> *
> >>>>> *  Test results on Chris's v3 patchset:
> >>>>> *
> >>>>> 1. w/ -a
> >>>>> ./thp_swap_allocator_test -a
> >>>>> Iteration 1: swpout inc: 224, swpout fallback inc: 0, Fallback perc=
entage: 0.00%
> >>>>> Iteration 2: swpout inc: 231, swpout fallback inc: 0, Fallback perc=
entage: 0.00%
> >>>>> Iteration 3: swpout inc: 227, swpout fallback inc: 0, Fallback perc=
entage: 0.00%
> >>>>> Iteration 4: swpout inc: 217, swpout fallback inc: 5, Fallback perc=
entage: 2.25%
> >>>>> Iteration 5: swpout inc: 215, swpout fallback inc: 12, Fallback per=
centage: 5.29%
> >>>>> Iteration 6: swpout inc: 213, swpout fallback inc: 14, Fallback per=
centage: 6.17%
> >>>>> Iteration 7: swpout inc: 207, swpout fallback inc: 15, Fallback per=
centage: 6.76%
> >>>>> Iteration 8: swpout inc: 193, swpout fallback inc: 33, Fallback per=
centage: 14.60%
> >>>>> Iteration 9: swpout inc: 214, swpout fallback inc: 13, Fallback per=
centage: 5.73%
> >>>>> Iteration 10: swpout inc: 199, swpout fallback inc: 25, Fallback pe=
rcentage: 11.16%
> >>>>> Iteration 11: swpout inc: 208, swpout fallback inc: 14, Fallback pe=
rcentage: 6.31%
> >>>>> Iteration 12: swpout inc: 203, swpout fallback inc: 31, Fallback pe=
rcentage: 13.25%
> >>>>> Iteration 13: swpout inc: 192, swpout fallback inc: 25, Fallback pe=
rcentage: 11.52%
> >>>>> Iteration 14: swpout inc: 193, swpout fallback inc: 36, Fallback pe=
rcentage: 15.72%
> >>>>> Iteration 15: swpout inc: 188, swpout fallback inc: 33, Fallback pe=
rcentage: 14.93%
> >>>>> ...
> >>>>>
> >>>>> It seems Chris's approach can be negatively affected even by aligne=
d swapin,
> >>>>> having a low fallback ratio but not 0% while Ryan's patchset hasn't=
 this
> >>>>> issue.
> >>>>>
> >>>>> 2. w/o -a
> >>>>> ./thp_swap_allocator_test
> >>>>> Iteration 1: swpout inc: 209, swpout fallback inc: 24, Fallback per=
centage: 10.30%
> >>>>> Iteration 2: swpout inc: 100, swpout fallback inc: 132, Fallback pe=
rcentage: 56.90%
> >>>>> Iteration 3: swpout inc: 43, swpout fallback inc: 183, Fallback per=
centage: 80.97%
> >>>>> Iteration 4: swpout inc: 30, swpout fallback inc: 193, Fallback per=
centage: 86.55%
> >>>>> Iteration 5: swpout inc: 21, swpout fallback inc: 205, Fallback per=
centage: 90.71%
> >>>>> Iteration 6: swpout inc: 10, swpout fallback inc: 214, Fallback per=
centage: 95.54%
> >>>>> Iteration 7: swpout inc: 16, swpout fallback inc: 212, Fallback per=
centage: 92.98%
> >>>>> Iteration 8: swpout inc: 9, swpout fallback inc: 219, Fallback perc=
entage: 96.05%
> >>>>> Iteration 9: swpout inc: 6, swpout fallback inc: 220, Fallback perc=
entage: 97.35%
> >>>>> Iteration 10: swpout inc: 7, swpout fallback inc: 221, Fallback per=
centage: 96.93%
> >>>>> Iteration 11: swpout inc: 7, swpout fallback inc: 222, Fallback per=
centage: 96.94%
> >>>>> Iteration 12: swpout inc: 8, swpout fallback inc: 212, Fallback per=
centage: 96.36%
> >>>>> ..
> >>>>>
> >>>>> Ryan's fallback ratio(around 85%) seems to be a little better while=
 both are much
> >>>>> worse than "-a".
> >>>>>
> >>>>> 3. w/ -a and -s
> >>>>> ./thp_swap_allocator_test -a -s
> >>>>> Iteration 1: swpout inc: 224, swpout fallback inc: 0, Fallback perc=
entage: 0.00%
> >>>>> Iteration 2: swpout inc: 213, swpout fallback inc: 5, Fallback perc=
entage: 2.29%
> >>>>> Iteration 3: swpout inc: 215, swpout fallback inc: 7, Fallback perc=
entage: 3.15%
> >>>>> Iteration 4: swpout inc: 210, swpout fallback inc: 16, Fallback per=
centage: 7.08%
> >>>>> Iteration 5: swpout inc: 212, swpout fallback inc: 10, Fallback per=
centage: 4.50%
> >>>>> Iteration 6: swpout inc: 215, swpout fallback inc: 18, Fallback per=
centage: 7.73%
> >>>>> Iteration 7: swpout inc: 181, swpout fallback inc: 43, Fallback per=
centage: 19.20%
> >>>>> Iteration 8: swpout inc: 173, swpout fallback inc: 55, Fallback per=
centage: 24.12%
> >>>>> Iteration 9: swpout inc: 163, swpout fallback inc: 54, Fallback per=
centage: 24.88%
> >>>>> Iteration 10: swpout inc: 168, swpout fallback inc: 59, Fallback pe=
rcentage: 25.99%
> >>>>> Iteration 11: swpout inc: 154, swpout fallback inc: 69, Fallback pe=
rcentage: 30.94%
> >>>>> Iteration 12: swpout inc: 166, swpout fallback inc: 66, Fallback pe=
rcentage: 28.45%
> >>>>> Iteration 13: swpout inc: 165, swpout fallback inc: 53, Fallback pe=
rcentage: 24.31%
> >>>>> Iteration 14: swpout inc: 158, swpout fallback inc: 68, Fallback pe=
rcentage: 30.09%
> >>>>> Iteration 15: swpout inc: 168, swpout fallback inc: 57, Fallback pe=
rcentage: 25.33%
> >>>>> Iteration 16: swpout inc: 165, swpout fallback inc: 53, Fallback pe=
rcentage: 24.31%
> >>>>> Iteration 17: swpout inc: 163, swpout fallback inc: 49, Fallback pe=
rcentage: 23.11%
> >>>>> Iteration 18: swpout inc: 172, swpout fallback inc: 62, Fallback pe=
rcentage: 26.50%
> >>>>> Iteration 19: swpout inc: 183, swpout fallback inc: 43, Fallback pe=
rcentage: 19.03%
> >>>>> Iteration 20: swpout inc: 158, swpout fallback inc: 73, Fallback pe=
rcentage: 31.60%
> >>>>> Iteration 21: swpout inc: 147, swpout fallback inc: 81, Fallback pe=
rcentage: 35.53%
> >>>>> Iteration 22: swpout inc: 140, swpout fallback inc: 86, Fallback pe=
rcentage: 38.05%
> >>>>> Iteration 23: swpout inc: 144, swpout fallback inc: 79, Fallback pe=
rcentage: 35.43%
> >>>>> Iteration 24: swpout inc: 132, swpout fallback inc: 101, Fallback p=
ercentage: 43.35%
> >>>>> Iteration 25: swpout inc: 133, swpout fallback inc: 82, Fallback pe=
rcentage: 38.14%
> >>>>> Iteration 26: swpout inc: 152, swpout fallback inc: 78, Fallback pe=
rcentage: 33.91%
> >>>>> Iteration 27: swpout inc: 138, swpout fallback inc: 81, Fallback pe=
rcentage: 36.99%
> >>>>> Iteration 28: swpout inc: 152, swpout fallback inc: 74, Fallback pe=
rcentage: 32.74%
> >>>>> Iteration 29: swpout inc: 153, swpout fallback inc: 75, Fallback pe=
rcentage: 32.89%
> >>>>> Iteration 30: swpout inc: 151, swpout fallback inc: 74, Fallback pe=
rcentage: 32.89%
> >>>>> ...
> >>>>>
> >>>>> Chris's approach appears to be more susceptible to negative effects=
 from
> >>>>> small folios.
> >>>>>
> >>>>> 4. w/o -a and w/ -s
> >>>>> ./thp_swap_allocator_test -s
> >>>>> Iteration 1: swpout inc: 183, swpout fallback inc: 50, Fallback per=
centage: 21.46%
> >>>>> Iteration 2: swpout inc: 75, swpout fallback inc: 157, Fallback per=
centage: 67.67%
> >>>>> Iteration 3: swpout inc: 33, swpout fallback inc: 201, Fallback per=
centage: 85.90%
> >>>>> Iteration 4: swpout inc: 11, swpout fallback inc: 222, Fallback per=
centage: 95.28%
> >>>>> Iteration 5: swpout inc: 10, swpout fallback inc: 215, Fallback per=
centage: 95.56%
> >>>>> Iteration 6: swpout inc: 7, swpout fallback inc: 221, Fallback perc=
entage: 96.93%
> >>>>> Iteration 7: swpout inc: 2, swpout fallback inc: 221, Fallback perc=
entage: 99.10%
> >>>>> Iteration 8: swpout inc: 4, swpout fallback inc: 217, Fallback perc=
entage: 98.19%
> >>>>> Iteration 9: swpout inc: 0, swpout fallback inc: 225, Fallback perc=
entage: 100.00%
> >>>>> Iteration 10: swpout inc: 3, swpout fallback inc: 227, Fallback per=
centage: 98.70%
> >>>>> Iteration 11: swpout inc: 1, swpout fallback inc: 217, Fallback per=
centage: 99.54%
> >>>>> Iteration 12: swpout inc: 2, swpout fallback inc: 229, Fallback per=
centage: 99.13%
> >>>>> Iteration 13: swpout inc: 1, swpout fallback inc: 214, Fallback per=
centage: 99.53%
> >>>>> Iteration 14: swpout inc: 2, swpout fallback inc: 220, Fallback per=
centage: 99.10%
> >>>>> Iteration 15: swpout inc: 1, swpout fallback inc: 224, Fallback per=
centage: 99.56%
> >>>>> Iteration 16: swpout inc: 3, swpout fallback inc: 224, Fallback per=
centage: 98.68%
> >>>>> ...
> >>>>>
> >>>>> Barry Song (1):
> >>>>>   tools/mm: Introduce a tool to assess swap entry allocation for
> >>>>>     thp_swapout
> >>>>>
> >>>>>  tools/mm/Makefile                  |   2 +-
> >>>>>  tools/mm/thp_swap_allocator_test.c | 233 +++++++++++++++++++++++++=
++++
> >>>>>  2 files changed, 234 insertions(+), 1 deletion(-)
> >>>>>  create mode 100644 tools/mm/thp_swap_allocator_test.c
> >>>>>
> >>>>
> >>>
> >

Thanks
Barry

