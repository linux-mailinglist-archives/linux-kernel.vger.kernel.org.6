Return-Path: <linux-kernel+bounces-228100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ADA0915AD7
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 02:11:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94EAEB215E2
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 00:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79431A41;
	Tue, 25 Jun 2024 00:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BC2ikQxM"
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7F4184
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 00:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719274289; cv=none; b=qjAXneuGV2y03MizuLTCiJ8J9iA7fPVeW013d7C+MQ2mPjyL3cr49UlyznmRG6PlH6W7HtI/i7Vlnk0Rq237Cq2nlaAmRvqGwJgMlhNoKuMXRISuw8Iq/vpwxyktRmg0RN/Wou9XXmv9SVE7licqHdTLOJ+/qSpenW8TgHcP5fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719274289; c=relaxed/simple;
	bh=5ghAT0UDac0vJyfxly4a3kSDe9ckVK0MUWGzdJPUG98=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jVvolGITkf/WEYpa+unGoGERYzhgJ18iQpnuF3sjOsbjHmnkmfIXPlDm0GlqVuEXhyo0YdCD01T5EDm+dfpmeuyTs890RWuSHnGUvOgsnXsba2eil6OihmUF0xpsQ5fKsc+YpMHjr30Cy66FL2QsArTg1uTD1vPV+KOULDAGCn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BC2ikQxM; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-80f879181fcso421927241.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 17:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719274286; x=1719879086; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MusNJpw1XVghaibIeLxAOLFkloWESn0yL8ZXpqyj6GA=;
        b=BC2ikQxMMdCnhWTCX3j3XVgrJpcTjIdXTPeWo8CQxPejckghm4UzNgdLxIXUdR6Eja
         4Y1qkS90a/Y/W0NGxK0+7VfCWj4eWEsWn8sGUCuU2ChJgwqydE6Yjxz27ADuNND63Wvv
         WZnY1vvARt4HwBXx9/kTTqB3rnhfvVaxVep2e/PCiNYiAwRJBUCVS2CNm5DMmY4haPRY
         RQjXJvoipBZlyDS0SgjRM2suyknvnIU82rZUByJGNzkO4lv0aFq0aqZ2eGvzR/HOA2Lp
         r1Pzuez/jsjGjfj9UUTD6B+C3McZ5ZLQ2a7LhYdQHG8XixwSmrICNPnoUNCDTJjea73p
         itYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719274286; x=1719879086;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MusNJpw1XVghaibIeLxAOLFkloWESn0yL8ZXpqyj6GA=;
        b=C3deG99vBF6oToNrZuEMPg7IyJS49nz1DPjH8qLdjwnZsjvyPPwTGcWOWDXr5rCjEq
         y0OiyURm6mFNUg74BtBZcL8v8ZvBq3ECptzkwSfNtrYEEe0QN7XU+YaCe3Pzpkgkq5Mm
         oI9XebDOWctYPjsDW52sv3mPJ9AEO0G5TYxXzJzljrofOr7JBN1A8v8+ruUJu86THQ2H
         O+LHoZVX/5IZrOnV4u1zbNwMNIINQqta+kJ6uHy7+mWjTnpFsVIYdtBQVzbcQSNjMnHO
         SaMDRC6N4gz7U2kJCrImvAYS7vG3dJfZfDMm1l/Vf2LuX7ICGOiJNwjaYwdhNIV9t6uV
         j7aQ==
X-Forwarded-Encrypted: i=1; AJvYcCVDdPU/h4IYPj2AN/+2xC/p0FJFceaEiuYrcxmNrxCfhB0BaZzEG3eJmX4/Zs5BU59wK/6qCw652EThQTnjsms0r5wqZ1U1OT9vgE9N
X-Gm-Message-State: AOJu0YzoZrPronklGq3QEJilhRRXMGHxRx6kzMJZY/xWhTQRjVRpSOtK
	8l7H9cAL7fH+L8AkbUKNx9WHtU8lyAndES4KJQCA+oKY0t0PCTsNSGucU0GyisEwioCdBBxE4NE
	mO5kdpZO4Yf7AHS61bbTSEgEh0gs=
X-Google-Smtp-Source: AGHT+IEpB9k/XteUbLBgFzB1WTQV33603ciAAIM32u/EePcjtllCWXLO7qoiur4r9R7GtzUWLki5AJBXuSntKQ8oZa8=
X-Received: by 2002:a05:6102:3037:b0:48f:1bea:3c73 with SMTP id
 ada2fe7eead31-48f52b431e6mr4026563137.25.1719274285757; Mon, 24 Jun 2024
 17:11:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240622071231.576056-1-21cnbao@gmail.com> <557d7f05-6ba9-482d-b3fb-29eb72cdf09c@arm.com>
 <CAGsJ_4zQ0vjX1UM62o0Wsgh9XYW0SGv2cyG5gUpbP_+Tx3WZLg@mail.gmail.com> <76876c5f-f769-43f1-ad53-a4af288af467@arm.com>
In-Reply-To: <76876c5f-f769-43f1-ad53-a4af288af467@arm.com>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 25 Jun 2024 12:11:14 +1200
Message-ID: <CAGsJ_4zpn5dMNNNcVcMngT-mJpWV-bzUV+RfQaLLjxMC73xfig@mail.gmail.com>
Subject: Re: [PATCH v2 0/1] tools/mm: Introduce a tool to assess swap entry
 allocation for thp_swapout
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: akpm@linux-foundation.org, chrisl@kernel.org, linux-mm@kvack.org, 
	david@redhat.com, hughd@google.com, kaleshsingh@google.com, 
	kasong@tencent.com, linux-kernel@vger.kernel.org, v-songbaohua@oppo.com, 
	ying.huang@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 24, 2024 at 10:35=E2=80=AFPM Ryan Roberts <ryan.roberts@arm.com=
> wrote:
>
> On 24/06/2024 09:42, Barry Song wrote:
> > On Mon, Jun 24, 2024 at 8:26=E2=80=AFPM Ryan Roberts <ryan.roberts@arm.=
com> wrote:
> >>
> >> On 22/06/2024 08:12, Barry Song wrote:
> >>> From: Barry Song <v-songbaohua@oppo.com>
> >>>
> >>> -v2:
> >>>  * add swap-in which can either be aligned or not aligned, by "-a";
> >>>    Ying;
> >>>  * move the program to tools/mm; Ryan;
> >>>  * try to simulate the scenarios swap is full. Chris;
> >>>
> >>> -v1:
> >>>  https://lore.kernel.org/linux-mm/20240620002648.75204-1-21cnbao@gmai=
l.com/
> >>>
> >>> I tested Ryan's RFC patchset[1] and Chris's v3[2] using this v2 tool:
> >>> [1] https://lore.kernel.org/linux-mm/20240618232648.4090299-1-ryan.ro=
berts@arm.com/
> >>> [2] https://lore.kernel.org/linux-mm/20240614-swap-allocator-v2-0-2a5=
13b4a7f2f@kernel.org/
> >>>
> >>> Obviously, we're rarely hitting 100% even in the worst case without "=
-a" and with
> >>> "-s," which is good news!
> >>> If swapin is aligned w/ "-a" and w/o "-s", both Chris's and Ryan's pa=
tches show
> >>> a low fallback ratio though Chris's has the numbers above 0% but Ryan=
's are 0%
> >>> (value A).
> >>>
> >>> The bad news is that unaligned swapin can significantly increase the =
fallback ratio,
> >>> reaching up to 85% for Ryan's patch and 95% for Chris's patchset with=
out "-s." Both
> >>> approaches approach 100% without "-a" and with "-s" (value B).
> >>>
> >>> I believe real workloads should yield a value between A and B. Withou=
t "-a," and
> >>> lacking large folios swap-in, this tool randomly swaps in small folio=
s without
> >>> considering spatial locality, which is a factor present in real workl=
oads. This
> >>> typically results in values higher than A and lower than B.
> >>>
> >>> Based on the below results, I believe that:
> >>
> >> Thanks for putting this together and providing such detailed results!
> >>
> >>> 1. We truly require large folio swap-in to achieve comparable results=
 with
> >>> aligned swap-in(based on the result w/o and w/ "-a")
> >>
> >> I certainly agree that as long as we require a high order swap entry t=
o be
> >> contiguous in the backing store then it looks like we are going to nee=
d large
> >> folio swap-in to prevent enormous fragmentation. I guess Chris's propo=
sed layer
> >> of indirection to allow pages to be scattered in the backing store wou=
ld also
> >> solve the problem? Although, I'm not sure this would work well for zRa=
m?
> >
> > The challenge is that we also want to take advantage of improving zsmal=
loc
> > to save compressed multi-pages. However, it seems quite impossible for
> > zsmalloc to achieve this for a mTHP is scattered but not put together i=
n
> > zRAM.
>
> Yes understood. I finally got around to watching the lsfmm videos; I beli=
eve the
> suggested solution with a fs-like approach would be to let the fs handle =
the
> compression, which means compressing extents? So even with that approach,
> presumably its still valuable to be able to allocate the biggest extents =
possible.
>
> >
> >>
> >> Perhaps another way of looking at this is that we are doing a bad job =
of
> >> selecting when to use an mTHP and when not to use one in the first pla=
ce;
> >> ideally the workload would access the data across the entire mTHP with=
 high
> >> temporal locality? In that case, we would expect the whole mTHP to be =
swapped in
> >> even with the current page-by-page approach. Figuring out this "auto s=
izing"
> >> seems like an incredibly complex problem to solve though.
> >
> > The good news is that this is exactly what we're implementing in our pr=
oducts,
> > and it has been deployed on millions of phones.
> >
> >   *  Allocate mTHP and swap in the entire mTHP  in do_swap_page();
> >   *  If mTHP allocation fails, allocate 16 pages to swap-in in do_swap_=
page();
>
> I think we were talking cross-purposes here. What I meant was that in an =
ideal
> world we would only allocate a (64K) mTHP for a page fault if we had conf=
idence
> (via some heuristic) that the virtual 64K area was likely to always be ac=
cessed
> together, else just allocate a small folio. i.e. choose the folio size to=
 cover
> a single object from user space's PoV. That would have the side effect th=
at a
> page-by-page swap-in approach (the current approach in mainline) would st=
ill
> effectively result in swapping in the whole folio and therefore reduce
> fragementation in the swap file. (Or thinking about it slightly different=
ly, it
> would give us confidence to always swap-in a large folio at a time, becau=
se we
> know its all highly likely to get used in the near future).
>
> I suspect this is a moot point though, because divinging a suitable heuri=
stic
> with low overhead is basically impossible.
>
> >
> > To be honest, we haven't noticed a visible increase in memory footprint=
. This is
> > likely because Android's anonymous memory exhibits good spatial localit=
y, and
> > 64KiB strikes a good balance=E2=80=94neither too large nor too small.
>
> Indeed.
>
> >
> > The bad news is that I haven't found a way to convince the community th=
is
> > is universally correct.
>
> I think we will want to be pragmatic and at least implement an option (sy=
sfs?)
> to swap-in a large folio up to a certain size; These test results clearly=
 show
> the value. And I believe you have real-world data for Android that shows =
the
> same thing.
>
> Just to creep the scope of this thread slightly, after watching yours and=
 Yu
> Zhou's presentations around TAO, IIUC, even with TAO enabled, 64K folio
> allocation fallback is still above 50%? I still believe that once the And=
roid
> filesystems are converted to use large folios that number will improve
> substantially; especially if the page cache can be convinced to only allo=
cate
> 64K folios (with 4K fallback). At that point you're predominantly using 6=
4K
> folios so intuitively there will be less fragmentation.

Absolutely agreed. Currently, I reported an allocation fallback rate
slightly above 50%, but
this is not because TAO is ineffective. It's simply because, in the
test, we set up a
conservative 15% virtzone for mTHP. If we increase the zone, we would defin=
itely
achieve a lower fallback ratio. However, the issue arises when we need
a large number
of small folios=E2=80=94 for example, for the page cache=E2=80=94because th=
ey might
suffer. However,
we should be able to increase the percentage of the virtzone after
some fine-tuning, as
the report was based on an initial test to demonstrate that TAO can
provide guaranteed
mTHP coverage.

If we can somehow unify the mTHP size for both the page cache and anon, thi=
ngs
might improve.

Xiang promised to deliver EROFS large folio support. If we also get
this in f2fs, things
will be quite different.

>
> But allocations by the page cache today start at 16K and increment by 2 o=
rders
> for every new readahead IIRC. So we end up with lots of large folio sizes=
, and
> presumably the potential for lots of fallbacks.
>
> All of this is just to suggest that we may end up wanting controls to spe=
cify
> which folio sizes the page cache can attempt to use. At that point, addin=
g
> similar controls for swap-in doesn't feel unreasonable to me.
>
> Just my 2 cents!
>
> >
> >>
> >>> 2. We need a method to prevent small folios from scattering indiscrim=
inately
> >>> (based on the result "-a -s")
> >>
> >> I'm confused by this statement; as I undersand it, both my and Chris's=
 patches
> >> already try to do this. Certainly for mine, when searching for order-0=
 space, I
> >> search the non-full order-0 clusters first (just like for other orders=
).
> >> Although for order-0 I will still fallback to searching any cluster if=
 no space
> >> is found in an order-0 cluster. What more can we do?
> >>
> >> When run against your v1 of the tool with "-s" (v1 always implicily be=
haves as
> >> if "-a" is specified, right?) my patch gives 0% fallback. So what's th=
e
> >> difference in v2 that causes higher fallback rate? Possibly just that
> >> MEMSIZE_SMALLFOLIO has grown by 3MB so that the total memory matches t=
he swap
> >> size (64M)?
> >
> > Exactly. From my understanding, we've reached a point where small folio=
s are
> > struggling to find swap slots. Note that I always swap out mTHP before =
swapping
> > out small folios. Additionally, I have already swapped in 1MB small
> > folios before
> > swapping out, which means zRAM has 1MB-4KB of redundant space available
> > for mTHP to swap out.
> >
> >>
> >> Thanks,
> >> Ryan
> >>
> >>>
> >>> *
> >>> *  Test results on Ryan's patchset:
> >>> *
> >>>
> >>> 1. w/ -a
> >>> ./thp_swap_allocator_test -a
> >>> Iteration 1: swpout inc: 224, swpout fallback inc: 0, Fallback percen=
tage: 0.00%
> >>> Iteration 2: swpout inc: 231, swpout fallback inc: 0, Fallback percen=
tage: 0.00%
> >>> Iteration 3: swpout inc: 227, swpout fallback inc: 0, Fallback percen=
tage: 0.00%
> >>> Iteration 4: swpout inc: 222, swpout fallback inc: 0, Fallback percen=
tage: 0.00%
> >>> ...
> >>> Iteration 100: swpout inc: 228, swpout fallback inc: 0, Fallback perc=
entage: 0.00%
> >>>
> >>> 2. w/o -a
> >>> ./thp_swap_allocator_test
> >>>
> >>> Iteration 1: swpout inc: 208, swpout fallback inc: 25, Fallback perce=
ntage: 10.73%
> >>> Iteration 2: swpout inc: 118, swpout fallback inc: 114, Fallback perc=
entage: 49.14%
> >>> Iteration 3: swpout inc: 63, swpout fallback inc: 163, Fallback perce=
ntage: 72.12%
> >>> Iteration 4: swpout inc: 45, swpout fallback inc: 178, Fallback perce=
ntage: 79.82%
> >>> Iteration 5: swpout inc: 42, swpout fallback inc: 184, Fallback perce=
ntage: 81.42%
> >>> Iteration 6: swpout inc: 31, swpout fallback inc: 193, Fallback perce=
ntage: 86.16%
> >>> Iteration 7: swpout inc: 27, swpout fallback inc: 201, Fallback perce=
ntage: 88.16%
> >>> Iteration 8: swpout inc: 30, swpout fallback inc: 198, Fallback perce=
ntage: 86.84%
> >>> Iteration 9: swpout inc: 32, swpout fallback inc: 194, Fallback perce=
ntage: 85.84%
> >>> ...
> >>> Iteration 91: swpout inc: 26, swpout fallback inc: 194, Fallback perc=
entage: 88.18%
> >>> Iteration 92: swpout inc: 35, swpout fallback inc: 196, Fallback perc=
entage: 84.85%
> >>> Iteration 93: swpout inc: 33, swpout fallback inc: 191, Fallback perc=
entage: 85.27%
> >>> Iteration 94: swpout inc: 26, swpout fallback inc: 193, Fallback perc=
entage: 88.13%
> >>> Iteration 95: swpout inc: 39, swpout fallback inc: 189, Fallback perc=
entage: 82.89%
> >>> Iteration 96: swpout inc: 28, swpout fallback inc: 196, Fallback perc=
entage: 87.50%
> >>> Iteration 97: swpout inc: 25, swpout fallback inc: 194, Fallback perc=
entage: 88.58%
> >>> Iteration 98: swpout inc: 31, swpout fallback inc: 196, Fallback perc=
entage: 86.34%
> >>> Iteration 99: swpout inc: 32, swpout fallback inc: 202, Fallback perc=
entage: 86.32%
> >>> Iteration 100: swpout inc: 33, swpout fallback inc: 195, Fallback per=
centage: 85.53%
> >>>
> >>> 3. w/ -a and -s
> >>> ./thp_swap_allocator_test -a -s
> >>> Iteration 1: swpout inc: 224, swpout fallback inc: 0, Fallback percen=
tage: 0.00%
> >>> Iteration 2: swpout inc: 218, swpout fallback inc: 0, Fallback percen=
tage: 0.00%
> >>> Iteration 3: swpout inc: 222, swpout fallback inc: 0, Fallback percen=
tage: 0.00%
> >>> Iteration 4: swpout inc: 220, swpout fallback inc: 6, Fallback percen=
tage: 2.65%
> >>> Iteration 5: swpout inc: 206, swpout fallback inc: 16, Fallback perce=
ntage: 7.21%
> >>> Iteration 6: swpout inc: 233, swpout fallback inc: 0, Fallback percen=
tage: 0.00%
> >>> Iteration 7: swpout inc: 224, swpout fallback inc: 0, Fallback percen=
tage: 0.00%
> >>> Iteration 8: swpout inc: 228, swpout fallback inc: 0, Fallback percen=
tage: 0.00%
> >>> Iteration 9: swpout inc: 217, swpout fallback inc: 0, Fallback percen=
tage: 0.00%
> >>> Iteration 10: swpout inc: 224, swpout fallback inc: 3, Fallback perce=
ntage: 1.32%
> >>> Iteration 11: swpout inc: 211, swpout fallback inc: 12, Fallback perc=
entage: 5.38%
> >>> Iteration 12: swpout inc: 200, swpout fallback inc: 32, Fallback perc=
entage: 13.79%
> >>> Iteration 13: swpout inc: 189, swpout fallback inc: 29, Fallback perc=
entage: 13.30%
> >>> Iteration 14: swpout inc: 195, swpout fallback inc: 31, Fallback perc=
entage: 13.72%
> >>> Iteration 15: swpout inc: 198, swpout fallback inc: 27, Fallback perc=
entage: 12.00%
> >>> Iteration 16: swpout inc: 201, swpout fallback inc: 17, Fallback perc=
entage: 7.80%
> >>> Iteration 17: swpout inc: 206, swpout fallback inc: 6, Fallback perce=
ntage: 2.83%
> >>> Iteration 18: swpout inc: 220, swpout fallback inc: 14, Fallback perc=
entage: 5.98%
> >>> Iteration 19: swpout inc: 181, swpout fallback inc: 45, Fallback perc=
entage: 19.91%
> >>> Iteration 20: swpout inc: 223, swpout fallback inc: 8, Fallback perce=
ntage: 3.46%
> >>> Iteration 21: swpout inc: 214, swpout fallback inc: 14, Fallback perc=
entage: 6.14%
> >>> Iteration 22: swpout inc: 195, swpout fallback inc: 31, Fallback perc=
entage: 13.72%
> >>> Iteration 23: swpout inc: 223, swpout fallback inc: 0, Fallback perce=
ntage: 0.00%
> >>> Iteration 24: swpout inc: 233, swpout fallback inc: 0, Fallback perce=
ntage: 0.00%
> >>> Iteration 25: swpout inc: 214, swpout fallback inc: 1, Fallback perce=
ntage: 0.47%
> >>> Iteration 26: swpout inc: 229, swpout fallback inc: 1, Fallback perce=
ntage: 0.43%
> >>> Iteration 27: swpout inc: 214, swpout fallback inc: 5, Fallback perce=
ntage: 2.28%
> >>> Iteration 28: swpout inc: 211, swpout fallback inc: 15, Fallback perc=
entage: 6.64%
> >>> Iteration 29: swpout inc: 188, swpout fallback inc: 40, Fallback perc=
entage: 17.54%
> >>> Iteration 30: swpout inc: 207, swpout fallback inc: 18, Fallback perc=
entage: 8.00%
> >>> Iteration 31: swpout inc: 215, swpout fallback inc: 10, Fallback perc=
entage: 4.44%
> >>> Iteration 32: swpout inc: 202, swpout fallback inc: 22, Fallback perc=
entage: 9.82%
> >>> Iteration 33: swpout inc: 223, swpout fallback inc: 0, Fallback perce=
ntage: 0.00%
> >>> Iteration 34: swpout inc: 218, swpout fallback inc: 10, Fallback perc=
entage: 4.39%
> >>> Iteration 35: swpout inc: 203, swpout fallback inc: 30, Fallback perc=
entage: 12.88%
> >>> Iteration 36: swpout inc: 214, swpout fallback inc: 14, Fallback perc=
entage: 6.14%
> >>> Iteration 37: swpout inc: 211, swpout fallback inc: 14, Fallback perc=
entage: 6.22%
> >>> Iteration 38: swpout inc: 193, swpout fallback inc: 28, Fallback perc=
entage: 12.67%
> >>> Iteration 39: swpout inc: 210, swpout fallback inc: 20, Fallback perc=
entage: 8.70%
> >>> Iteration 40: swpout inc: 223, swpout fallback inc: 5, Fallback perce=
ntage: 2.19%
> >>> Iteration 41: swpout inc: 224, swpout fallback inc: 7, Fallback perce=
ntage: 3.03%
> >>> Iteration 42: swpout inc: 200, swpout fallback inc: 23, Fallback perc=
entage: 10.31%
> >>> Iteration 43: swpout inc: 217, swpout fallback inc: 5, Fallback perce=
ntage: 2.25%
> >>> Iteration 44: swpout inc: 206, swpout fallback inc: 18, Fallback perc=
entage: 8.04%
> >>> Iteration 45: swpout inc: 210, swpout fallback inc: 11, Fallback perc=
entage: 4.98%
> >>> Iteration 46: swpout inc: 204, swpout fallback inc: 19, Fallback perc=
entage: 8.52%
> >>> Iteration 47: swpout inc: 228, swpout fallback inc: 0, Fallback perce=
ntage: 0.00%
> >>> Iteration 48: swpout inc: 219, swpout fallback inc: 2, Fallback perce=
ntage: 0.90%
> >>> Iteration 49: swpout inc: 212, swpout fallback inc: 6, Fallback perce=
ntage: 2.75%
> >>> Iteration 50: swpout inc: 207, swpout fallback inc: 15, Fallback perc=
entage: 6.76%
> >>> Iteration 51: swpout inc: 190, swpout fallback inc: 36, Fallback perc=
entage: 15.93%
> >>> Iteration 52: swpout inc: 212, swpout fallback inc: 17, Fallback perc=
entage: 7.42%
> >>> Iteration 53: swpout inc: 179, swpout fallback inc: 43, Fallback perc=
entage: 19.37%
> >>> Iteration 54: swpout inc: 225, swpout fallback inc: 0, Fallback perce=
ntage: 0.00%
> >>> Iteration 55: swpout inc: 224, swpout fallback inc: 2, Fallback perce=
ntage: 0.88%
> >>> Iteration 56: swpout inc: 220, swpout fallback inc: 8, Fallback perce=
ntage: 3.51%
> >>> Iteration 57: swpout inc: 203, swpout fallback inc: 25, Fallback perc=
entage: 10.96%
> >>> Iteration 58: swpout inc: 213, swpout fallback inc: 6, Fallback perce=
ntage: 2.74%
> >>> Iteration 59: swpout inc: 207, swpout fallback inc: 18, Fallback perc=
entage: 8.00%
> >>> Iteration 60: swpout inc: 216, swpout fallback inc: 14, Fallback perc=
entage: 6.09%
> >>> Iteration 61: swpout inc: 183, swpout fallback inc: 34, Fallback perc=
entage: 15.67%
> >>> Iteration 62: swpout inc: 184, swpout fallback inc: 39, Fallback perc=
entage: 17.49%
> >>> Iteration 63: swpout inc: 184, swpout fallback inc: 39, Fallback perc=
entage: 17.49%
> >>> Iteration 64: swpout inc: 210, swpout fallback inc: 15, Fallback perc=
entage: 6.67%
> >>> Iteration 65: swpout inc: 178, swpout fallback inc: 48, Fallback perc=
entage: 21.24%
> >>> Iteration 66: swpout inc: 188, swpout fallback inc: 30, Fallback perc=
entage: 13.76%
> >>> Iteration 67: swpout inc: 193, swpout fallback inc: 29, Fallback perc=
entage: 13.06%
> >>> Iteration 68: swpout inc: 202, swpout fallback inc: 22, Fallback perc=
entage: 9.82%
> >>> Iteration 69: swpout inc: 213, swpout fallback inc: 5, Fallback perce=
ntage: 2.29%
> >>> Iteration 70: swpout inc: 204, swpout fallback inc: 15, Fallback perc=
entage: 6.85%
> >>> Iteration 71: swpout inc: 180, swpout fallback inc: 45, Fallback perc=
entage: 20.00%
> >>> Iteration 72: swpout inc: 210, swpout fallback inc: 21, Fallback perc=
entage: 9.09%
> >>> Iteration 73: swpout inc: 216, swpout fallback inc: 7, Fallback perce=
ntage: 3.14%
> >>> Iteration 74: swpout inc: 209, swpout fallback inc: 19, Fallback perc=
entage: 8.33%
> >>> Iteration 75: swpout inc: 222, swpout fallback inc: 7, Fallback perce=
ntage: 3.06%
> >>> Iteration 76: swpout inc: 212, swpout fallback inc: 14, Fallback perc=
entage: 6.19%
> >>> Iteration 77: swpout inc: 188, swpout fallback inc: 41, Fallback perc=
entage: 17.90%
> >>> Iteration 78: swpout inc: 198, swpout fallback inc: 17, Fallback perc=
entage: 7.91%
> >>> Iteration 79: swpout inc: 209, swpout fallback inc: 16, Fallback perc=
entage: 7.11%
> >>> Iteration 80: swpout inc: 182, swpout fallback inc: 41, Fallback perc=
entage: 18.39%
> >>> Iteration 81: swpout inc: 217, swpout fallback inc: 1, Fallback perce=
ntage: 0.46%
> >>> Iteration 82: swpout inc: 225, swpout fallback inc: 3, Fallback perce=
ntage: 1.32%
> >>> Iteration 83: swpout inc: 222, swpout fallback inc: 8, Fallback perce=
ntage: 3.48%
> >>> Iteration 84: swpout inc: 201, swpout fallback inc: 21, Fallback perc=
entage: 9.46%
> >>> Iteration 85: swpout inc: 211, swpout fallback inc: 3, Fallback perce=
ntage: 1.40%
> >>> Iteration 86: swpout inc: 209, swpout fallback inc: 14, Fallback perc=
entage: 6.28%
> >>> Iteration 87: swpout inc: 181, swpout fallback inc: 42, Fallback perc=
entage: 18.83%
> >>> Iteration 88: swpout inc: 223, swpout fallback inc: 4, Fallback perce=
ntage: 1.76%
> >>> Iteration 89: swpout inc: 214, swpout fallback inc: 14, Fallback perc=
entage: 6.14%
> >>> Iteration 90: swpout inc: 192, swpout fallback inc: 33, Fallback perc=
entage: 14.67%
> >>> Iteration 91: swpout inc: 184, swpout fallback inc: 31, Fallback perc=
entage: 14.42%
> >>> Iteration 92: swpout inc: 201, swpout fallback inc: 32, Fallback perc=
entage: 13.73%
> >>> Iteration 93: swpout inc: 181, swpout fallback inc: 40, Fallback perc=
entage: 18.10%
> >>> Iteration 94: swpout inc: 211, swpout fallback inc: 14, Fallback perc=
entage: 6.22%
> >>> Iteration 95: swpout inc: 198, swpout fallback inc: 25, Fallback perc=
entage: 11.21%
> >>> Iteration 96: swpout inc: 205, swpout fallback inc: 22, Fallback perc=
entage: 9.69%
> >>> Iteration 97: swpout inc: 218, swpout fallback inc: 12, Fallback perc=
entage: 5.22%
> >>> Iteration 98: swpout inc: 203, swpout fallback inc: 25, Fallback perc=
entage: 10.96%
> >>> Iteration 99: swpout inc: 218, swpout fallback inc: 12, Fallback perc=
entage: 5.22%
> >>> Iteration 100: swpout inc: 195, swpout fallback inc: 34, Fallback per=
centage: 14.85%
> >>>
> >>> 4. w/o -a and w/ -s
> >>> thp_swap_allocator_test  -s
> >>> Iteration 1: swpout inc: 173, swpout fallback inc: 60, Fallback perce=
ntage: 25.75%
> >>> Iteration 2: swpout inc: 85, swpout fallback inc: 147, Fallback perce=
ntage: 63.36%
> >>> Iteration 3: swpout inc: 39, swpout fallback inc: 195, Fallback perce=
ntage: 83.33%
> >>> Iteration 4: swpout inc: 13, swpout fallback inc: 220, Fallback perce=
ntage: 94.42%
> >>> Iteration 5: swpout inc: 10, swpout fallback inc: 215, Fallback perce=
ntage: 95.56%
> >>> Iteration 6: swpout inc: 9, swpout fallback inc: 219, Fallback percen=
tage: 96.05%
> >>> Iteration 7: swpout inc: 6, swpout fallback inc: 217, Fallback percen=
tage: 97.31%
> >>> Iteration 8: swpout inc: 6, swpout fallback inc: 215, Fallback percen=
tage: 97.29%
> >>> Iteration 9: swpout inc: 0, swpout fallback inc: 225, Fallback percen=
tage: 100.00%
> >>> Iteration 10: swpout inc: 1, swpout fallback inc: 229, Fallback perce=
ntage: 99.57%
> >>> Iteration 11: swpout inc: 2, swpout fallback inc: 216, Fallback perce=
ntage: 99.08%
> >>> Iteration 12: swpout inc: 2, swpout fallback inc: 229, Fallback perce=
ntage: 99.13%
> >>> Iteration 13: swpout inc: 4, swpout fallback inc: 211, Fallback perce=
ntage: 98.14%
> >>> Iteration 14: swpout inc: 1, swpout fallback inc: 221, Fallback perce=
ntage: 99.55%
> >>> Iteration 15: swpout inc: 2, swpout fallback inc: 223, Fallback perce=
ntage: 99.11%
> >>> Iteration 16: swpout inc: 3, swpout fallback inc: 224, Fallback perce=
ntage: 98.68%
> >>> Iteration 17: swpout inc: 2, swpout fallback inc: 231, Fallback perce=
ntage: 99.14%
> >>> ...
> >>>
> >>> *
> >>> *  Test results on Chris's v3 patchset:
> >>> *
> >>> 1. w/ -a
> >>> ./thp_swap_allocator_test -a
> >>> Iteration 1: swpout inc: 224, swpout fallback inc: 0, Fallback percen=
tage: 0.00%
> >>> Iteration 2: swpout inc: 231, swpout fallback inc: 0, Fallback percen=
tage: 0.00%
> >>> Iteration 3: swpout inc: 227, swpout fallback inc: 0, Fallback percen=
tage: 0.00%
> >>> Iteration 4: swpout inc: 217, swpout fallback inc: 5, Fallback percen=
tage: 2.25%
> >>> Iteration 5: swpout inc: 215, swpout fallback inc: 12, Fallback perce=
ntage: 5.29%
> >>> Iteration 6: swpout inc: 213, swpout fallback inc: 14, Fallback perce=
ntage: 6.17%
> >>> Iteration 7: swpout inc: 207, swpout fallback inc: 15, Fallback perce=
ntage: 6.76%
> >>> Iteration 8: swpout inc: 193, swpout fallback inc: 33, Fallback perce=
ntage: 14.60%
> >>> Iteration 9: swpout inc: 214, swpout fallback inc: 13, Fallback perce=
ntage: 5.73%
> >>> Iteration 10: swpout inc: 199, swpout fallback inc: 25, Fallback perc=
entage: 11.16%
> >>> Iteration 11: swpout inc: 208, swpout fallback inc: 14, Fallback perc=
entage: 6.31%
> >>> Iteration 12: swpout inc: 203, swpout fallback inc: 31, Fallback perc=
entage: 13.25%
> >>> Iteration 13: swpout inc: 192, swpout fallback inc: 25, Fallback perc=
entage: 11.52%
> >>> Iteration 14: swpout inc: 193, swpout fallback inc: 36, Fallback perc=
entage: 15.72%
> >>> Iteration 15: swpout inc: 188, swpout fallback inc: 33, Fallback perc=
entage: 14.93%
> >>> ...
> >>>
> >>> It seems Chris's approach can be negatively affected even by aligned =
swapin,
> >>> having a low fallback ratio but not 0% while Ryan's patchset hasn't t=
his
> >>> issue.
> >>>
> >>> 2. w/o -a
> >>> ./thp_swap_allocator_test
> >>> Iteration 1: swpout inc: 209, swpout fallback inc: 24, Fallback perce=
ntage: 10.30%
> >>> Iteration 2: swpout inc: 100, swpout fallback inc: 132, Fallback perc=
entage: 56.90%
> >>> Iteration 3: swpout inc: 43, swpout fallback inc: 183, Fallback perce=
ntage: 80.97%
> >>> Iteration 4: swpout inc: 30, swpout fallback inc: 193, Fallback perce=
ntage: 86.55%
> >>> Iteration 5: swpout inc: 21, swpout fallback inc: 205, Fallback perce=
ntage: 90.71%
> >>> Iteration 6: swpout inc: 10, swpout fallback inc: 214, Fallback perce=
ntage: 95.54%
> >>> Iteration 7: swpout inc: 16, swpout fallback inc: 212, Fallback perce=
ntage: 92.98%
> >>> Iteration 8: swpout inc: 9, swpout fallback inc: 219, Fallback percen=
tage: 96.05%
> >>> Iteration 9: swpout inc: 6, swpout fallback inc: 220, Fallback percen=
tage: 97.35%
> >>> Iteration 10: swpout inc: 7, swpout fallback inc: 221, Fallback perce=
ntage: 96.93%
> >>> Iteration 11: swpout inc: 7, swpout fallback inc: 222, Fallback perce=
ntage: 96.94%
> >>> Iteration 12: swpout inc: 8, swpout fallback inc: 212, Fallback perce=
ntage: 96.36%
> >>> ..
> >>>
> >>> Ryan's fallback ratio(around 85%) seems to be a little better while b=
oth are much
> >>> worse than "-a".
> >>>
> >>> 3. w/ -a and -s
> >>> ./thp_swap_allocator_test -a -s
> >>> Iteration 1: swpout inc: 224, swpout fallback inc: 0, Fallback percen=
tage: 0.00%
> >>> Iteration 2: swpout inc: 213, swpout fallback inc: 5, Fallback percen=
tage: 2.29%
> >>> Iteration 3: swpout inc: 215, swpout fallback inc: 7, Fallback percen=
tage: 3.15%
> >>> Iteration 4: swpout inc: 210, swpout fallback inc: 16, Fallback perce=
ntage: 7.08%
> >>> Iteration 5: swpout inc: 212, swpout fallback inc: 10, Fallback perce=
ntage: 4.50%
> >>> Iteration 6: swpout inc: 215, swpout fallback inc: 18, Fallback perce=
ntage: 7.73%
> >>> Iteration 7: swpout inc: 181, swpout fallback inc: 43, Fallback perce=
ntage: 19.20%
> >>> Iteration 8: swpout inc: 173, swpout fallback inc: 55, Fallback perce=
ntage: 24.12%
> >>> Iteration 9: swpout inc: 163, swpout fallback inc: 54, Fallback perce=
ntage: 24.88%
> >>> Iteration 10: swpout inc: 168, swpout fallback inc: 59, Fallback perc=
entage: 25.99%
> >>> Iteration 11: swpout inc: 154, swpout fallback inc: 69, Fallback perc=
entage: 30.94%
> >>> Iteration 12: swpout inc: 166, swpout fallback inc: 66, Fallback perc=
entage: 28.45%
> >>> Iteration 13: swpout inc: 165, swpout fallback inc: 53, Fallback perc=
entage: 24.31%
> >>> Iteration 14: swpout inc: 158, swpout fallback inc: 68, Fallback perc=
entage: 30.09%
> >>> Iteration 15: swpout inc: 168, swpout fallback inc: 57, Fallback perc=
entage: 25.33%
> >>> Iteration 16: swpout inc: 165, swpout fallback inc: 53, Fallback perc=
entage: 24.31%
> >>> Iteration 17: swpout inc: 163, swpout fallback inc: 49, Fallback perc=
entage: 23.11%
> >>> Iteration 18: swpout inc: 172, swpout fallback inc: 62, Fallback perc=
entage: 26.50%
> >>> Iteration 19: swpout inc: 183, swpout fallback inc: 43, Fallback perc=
entage: 19.03%
> >>> Iteration 20: swpout inc: 158, swpout fallback inc: 73, Fallback perc=
entage: 31.60%
> >>> Iteration 21: swpout inc: 147, swpout fallback inc: 81, Fallback perc=
entage: 35.53%
> >>> Iteration 22: swpout inc: 140, swpout fallback inc: 86, Fallback perc=
entage: 38.05%
> >>> Iteration 23: swpout inc: 144, swpout fallback inc: 79, Fallback perc=
entage: 35.43%
> >>> Iteration 24: swpout inc: 132, swpout fallback inc: 101, Fallback per=
centage: 43.35%
> >>> Iteration 25: swpout inc: 133, swpout fallback inc: 82, Fallback perc=
entage: 38.14%
> >>> Iteration 26: swpout inc: 152, swpout fallback inc: 78, Fallback perc=
entage: 33.91%
> >>> Iteration 27: swpout inc: 138, swpout fallback inc: 81, Fallback perc=
entage: 36.99%
> >>> Iteration 28: swpout inc: 152, swpout fallback inc: 74, Fallback perc=
entage: 32.74%
> >>> Iteration 29: swpout inc: 153, swpout fallback inc: 75, Fallback perc=
entage: 32.89%
> >>> Iteration 30: swpout inc: 151, swpout fallback inc: 74, Fallback perc=
entage: 32.89%
> >>> ...
> >>>
> >>> Chris's approach appears to be more susceptible to negative effects f=
rom
> >>> small folios.
> >>>
> >>> 4. w/o -a and w/ -s
> >>> ./thp_swap_allocator_test -s
> >>> Iteration 1: swpout inc: 183, swpout fallback inc: 50, Fallback perce=
ntage: 21.46%
> >>> Iteration 2: swpout inc: 75, swpout fallback inc: 157, Fallback perce=
ntage: 67.67%
> >>> Iteration 3: swpout inc: 33, swpout fallback inc: 201, Fallback perce=
ntage: 85.90%
> >>> Iteration 4: swpout inc: 11, swpout fallback inc: 222, Fallback perce=
ntage: 95.28%
> >>> Iteration 5: swpout inc: 10, swpout fallback inc: 215, Fallback perce=
ntage: 95.56%
> >>> Iteration 6: swpout inc: 7, swpout fallback inc: 221, Fallback percen=
tage: 96.93%
> >>> Iteration 7: swpout inc: 2, swpout fallback inc: 221, Fallback percen=
tage: 99.10%
> >>> Iteration 8: swpout inc: 4, swpout fallback inc: 217, Fallback percen=
tage: 98.19%
> >>> Iteration 9: swpout inc: 0, swpout fallback inc: 225, Fallback percen=
tage: 100.00%
> >>> Iteration 10: swpout inc: 3, swpout fallback inc: 227, Fallback perce=
ntage: 98.70%
> >>> Iteration 11: swpout inc: 1, swpout fallback inc: 217, Fallback perce=
ntage: 99.54%
> >>> Iteration 12: swpout inc: 2, swpout fallback inc: 229, Fallback perce=
ntage: 99.13%
> >>> Iteration 13: swpout inc: 1, swpout fallback inc: 214, Fallback perce=
ntage: 99.53%
> >>> Iteration 14: swpout inc: 2, swpout fallback inc: 220, Fallback perce=
ntage: 99.10%
> >>> Iteration 15: swpout inc: 1, swpout fallback inc: 224, Fallback perce=
ntage: 99.56%
> >>> Iteration 16: swpout inc: 3, swpout fallback inc: 224, Fallback perce=
ntage: 98.68%
> >>> ...
> >>>
> >>> Barry Song (1):
> >>>   tools/mm: Introduce a tool to assess swap entry allocation for
> >>>     thp_swapout
> >>>
> >>>  tools/mm/Makefile                  |   2 +-
> >>>  tools/mm/thp_swap_allocator_test.c | 233 +++++++++++++++++++++++++++=
++
> >>>  2 files changed, 234 insertions(+), 1 deletion(-)
> >>>  create mode 100644 tools/mm/thp_swap_allocator_test.c
> >>>
> >>
> >

Thanks
Barry

