Return-Path: <linux-kernel+bounces-384200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F23D9B2828
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 07:54:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2C8D1F21BAF
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 06:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 030EE18EFCD;
	Mon, 28 Oct 2024 06:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hOrQ17N0"
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB222AF07
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 06:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730098468; cv=none; b=VMTxAUjVR8+SfoHDzXzewrR+evlGEgbSPnh4yP9eITwcNfPw/EidMmS6LSsa0SmaXoL28fAESKGMxMWY6YmsXL+1/fv5HAz65pN1lxLg1NQMTBfMi/T6+UC+W7JrapHB0TzPmjjDdGBRsQHyNWgor49GJ69AWch2ZS5D9KPenB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730098468; c=relaxed/simple;
	bh=9ZAtQpPTNEsfRMrTbh4NAVEafpuE4guYI6u94sp1u6U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NoQq3W04yHiFR87QOEApjH7yZI2lPR9gOXZBkSz73q1/c/Q/0mBuaIRfve7FqalpMHwHi7UIZjn0X/hl+9oRN65qXEdudr/ejUPZmcbMZdyuF+Cdn+XeX0f3cwXqihywgohHFFQ9qHA39y/0UfDW22s8Xcik46TV9aVLHJ/bQOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hOrQ17N0; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-50fcc0cdcefso1070502e0c.0
        for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2024 23:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730098464; x=1730703264; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pMsdIVoasv1kR4dj1gBoXXP7qOYeQGF6tWAwpzEzOmk=;
        b=hOrQ17N0cjgmCSFLa6OsysjVAT0yJXGKkBnZrVokSxRh78NCY9+MWMBjR1brV7MaPX
         aVydvO2oOgwI3m8yoB7GjUA5YED/L5x8T/NWzVAG/Hjb8QLT/6O8QbHaGLL9sZE2tsbw
         QiL3invtsYFZeO9dYK2nouVIFY4exhmx8MYFFkivatOzlg0aeZs/trDd8dHUd71BW/sK
         Y2atWgXNZdfiE+Rk/wlZm+VaDwhG1UVNcGcHbWzIMUKmQr3C2jT+9J/JEdVxupHZ5M08
         9EnZEAt5i3/muV2a8grgQcDtmmUoqd7f2Rft3AAA1PZ/VSdXFlDrl3bjGIltBHWt2pFp
         lUBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730098464; x=1730703264;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pMsdIVoasv1kR4dj1gBoXXP7qOYeQGF6tWAwpzEzOmk=;
        b=bJPmevs4/lwvFqnyJaeGPRoW8lXaLH3kZe7LWSkHWkwsgwIHhiFRYz6n0lYxa5AxgR
         fd8fq8i7h8fc/4wyk/kAdC13FvHTHB1rNV7b47iK0pz+h0P7SxzsjJEo6fD4zSGEjIbs
         RWzhGNuMn9zWkBrYNt7M8mgmHmsW9SyMBU2/IOKLGlaU92n7jGLyv95qkY1ronJecFt7
         mz2lwROKGXMPMPs7MB0FV12Q7B/PVgDjqAtRrijfHECAb05Pm6y0be2lLlS7PuMtY0o/
         hmoRzjObaKNMPSS0ZTvV2KwC/gDvQLPeaf2SIplQXkUgHLUGs/tFglNbzsWSxb/Y9i3d
         PXKg==
X-Forwarded-Encrypted: i=1; AJvYcCWxxycfN2jUXeUiYg3rolrm9jKPmEFSQwjPHnpbcqttWHFl5MOmz9K7peyhcd63HmY9NaNa0St1/KPdfOM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIHpdcCLgzJzllBiMuNatOiinrFW/Ub2sOvDLXIm7/6lWjgCzn
	+EkCaBc0MPT6ZkUXC31CWR+0X8nF1kDD09snYhTsHg8jYA4DFq/qcor0Q2oLbKBS8AwCm9GRdhv
	IJfukaKBBYNWI1DhrLXR0/SjRYBw=
X-Google-Smtp-Source: AGHT+IFX02DE2OcoQSuToTTrljwmOev7tpJVDwSLFLCYWdHXiVy+zL0v0vZ5l+48cePRR8+LIRWYJFfquffz76d6j0A=
X-Received: by 2002:a05:6122:3c8d:b0:510:3a9:bb87 with SMTP id
 71dfb90a1353d-5101501368cmr3208243e0c.1.1730098463764; Sun, 27 Oct 2024
 23:54:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241016033030.36990-1-21cnbao@gmail.com> <20241016155835.8fadc58d913d9df14099514b@linux-foundation.org>
 <CAGsJ_4xYqSSUE_zq+2UWLT7UsF_ovH=+QE_va+_dcMq4fnz0rg@mail.gmail.com>
 <ZxFQTlPfR6y25cng@google.com> <CAGsJ_4zYRCotNTL2kKO202Rk2o78w5pZs25Y_iq=7OfS-KoX9w@mail.gmail.com>
 <ZxgHzUHcWvSNqXo2@google.com>
In-Reply-To: <ZxgHzUHcWvSNqXo2@google.com>
From: Barry Song <21cnbao@gmail.com>
Date: Mon, 28 Oct 2024 19:54:12 +1300
Message-ID: <CAGsJ_4zg5efUdLVh8k_BqRvtEXvKJncqP-j2=MuQvQMypm+acg@mail.gmail.com>
Subject: Re: [PATCH v2] mm: mglru: provide a separate list for lazyfree anon folios
To: Minchan Kim <minchan.kim@gmail.com>
Cc: Minchan Kim <minchan@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, yuzhao@google.com, 
	linux-mm@kvack.org, david@redhat.com, fengbaopeng@honor.com, gaoxu2@honor.com, 
	hailong.liu@oppo.com, kaleshsingh@google.com, linux-kernel@vger.kernel.org, 
	lokeshgidra@google.com, mhocko@suse.com, ngeoffray@google.com, shli@fb.com, 
	surenb@google.com, v-songbaohua@oppo.com, yipengxiang@honor.com, 
	Gao Xu <gaoxu2@hihonor.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 23, 2024 at 9:15=E2=80=AFAM Minchan Kim <minchan.kim@gmail.com>=
 wrote:
>
> Hi Barry,
>
> Sorry for slow response.
>
> On Fri, Oct 18, 2024 at 06:12:01PM +1300, Barry Song wrote:
> > On Fri, Oct 18, 2024 at 6:58=E2=80=AFAM Minchan Kim <minchan@kernel.org=
> wrote:
> > >
> > > On Thu, Oct 17, 2024 at 06:59:09PM +1300, Barry Song wrote:
> > > > On Thu, Oct 17, 2024 at 11:58=E2=80=AFAM Andrew Morton
> > > > <akpm@linux-foundation.org> wrote:
> > > > >
> > > > > On Wed, 16 Oct 2024 16:30:30 +1300 Barry Song <21cnbao@gmail.com>=
 wrote:
> > > > >
> > > > > > To address this, this patch proposes maintaining a separate lis=
t
> > > > > > for lazyfree anon folios while keeping them classified under th=
e
> > > > > > "file" LRU type to minimize code changes.
> > > > >
> > > > > Thanks.  I'll await input from other MGLRU developers before addi=
ng
> > > > > this for testing.
> > > >
> > > > Thanks!
> > > >
> > > > Hi Minchan, Yu,
> > > >
> > > > Any comments? I understand that Minchan may have a broader plan
> > > > to "enable the system to maintain a quickly reclaimable memory
> > > > pool and provide a knob for admins to control its size." While I
> > > > have no objection to that plan, I believe improving MADV_FREE
> > > > performance is a more urgent priority and a low-hanging fruit at th=
is
> > > > stage.
> > >
> > > Hi Barry,
> > >
> > > I have no idea why my email didn't send well before. I sent following
> > > reply on Sep 24. Hope it works this time.
> >
> > Hi Minchan,
> >
> > I guess not. Your *this* email ended up in my spam folder of gmail, and
> > my oppo.com account still hasn=E2=80=99t received it. Any idea why?
>
> In the end, that's my problem and don't know when it can be fixed.
> Anyway, hope again this time works.
>
> >
> > >
> > > =3D=3D=3D=3D=3D=3D &< =3D=3D=3D=3D=3D=3D
> > >
> > > My proposal involves the following:
> > >
> > > 1. Introduce an "easily reclaimable" LRU list. This list would hold p=
ages
> > >    that can be quickly freed without significant overhead.
> >
> > I assume you plan to keep both lazyfree anon pages and 'reclaimed'
> > file folios (reclaimed in the normal LRU lists but still in the easily-
> > reclaimable list) in this 'easily reclaimable' LRU list. However, I'm
> > not sure this will work, as this patch aims to help reclaim lazyfree
> > anon pages before file folios to reduce both file and anon refaults.
> > If we place 'reclaimed' file folios and lazyfree anon folios in the
> > same list, we may need to revisit how to reclaim lazyfree anon folios
> > before reclaiming the 'reclaimed' file folios.
>

Hi Minchan,

> Those reclaimed folio was already *decision-made* but just couldn't due t=
o
> the *impelementation issue*. So, that's strong candidate to be reclaimed
> as long as there is no access since then rather other candidates.

I'm not entirely clear that placing an LRU after inactive or min_gen
will provide meaningful benefits in typical scenarios. Let me give a
concrete example(to be simple, using active/inactive):

We used to have for example 1.5G active + 0.5 G inactive file, so the
length of active+inactive =3D 2G.

now we have 3 lists, for example:
1G active + 0.5G inactive + 0.5G ez_reclaimable

The total length remains 2G, which is still the size needed to keep files i=
n
the page cache for hits, so the overall size of the LRU hasn=E2=80=99t chan=
ged. The
only difference is that 0.5G has been separated from the original active +
inactive lists. By moving this 0.5G out of the normal LRU, it seems that
the CPU overhead for kswapd might increase, as the reduced size of the
normal LRU could lead to more frequent scanning operations(pretty
much like more aggressive reclamation in normal LRUs)?

On the other hand, mglru typically places items like syscall-related files
into a relatively reclaimable generation, which in a way already acts
like an ez_reclaimable generation=E2=80=94though not as "easily reclaimable=
"
compared to the dedicated ez_reclaimable list.  mglru can also compare
the relative hotness of syscall folios against mmap-ed file folios and
re-order those folios accordingly in lru.

Given that, has the value of the ez_reclaimable list diminished compared
to when we only had active and inactive lists?

>
> >
> > >
> > > 2. Implement a parameter to control the size of this list. This allow=
s for
> > >    system tuning based on available memory and performance requiremen=
ts.
> >
> > If we include only 'reclaimed' file folios in this 'easily
> > reclaimable' LRU list, the
> > parameter makes sense. However, if we also add lazyfree folios to the l=
ist, the
> > parameter becomes less meaningful since we can't predict how many
> > lazyfree anon folios user space might have. I still feel lazyfree anon =
folios
> > are different with "reclaimed" file folios (I mean reclaimed from norma=
l
> > lists but still in 'easily-reclaimable' list).
>
> I thought the ez-reclamable LRU doesn't need to be accurate since we can
> put other folios later(e.g., fadvise_dontneed but couldn't at that time)

My point is that if we set a parameter=E2=80=94say, ez_reclaimable to 500MB=
=E2=80=94
and then perform a 1GB MADV_FREE, we will still need to store the
excess MADV_FREE folios in the normal LRU unless we allow the
ez_reclaimable list to grow indefinitely.

If we permit unlimited length, then once it exceeds 500MB (for example,
due to MADV_FREE), would we stop reclaiming files from the normal LRUs
into the ez_reclaimable list since it already holds enough?

However, if we stop this process, the sorting mechanism=E2=80=94differentia=
ting
between easily reclaimable and less reclaimable folios=E2=80=94would essent=
ially
break down.

Currently, Guoxu's reported issue is that if MADV_FREE folios are positione=
d in
a relatively difficult-to-reclaim spot, like at the head of the LRU,
they may not be
reclaimed in time, while files are being aggressively reclaimed. Merging bo=
th
types of folios into a single ez_reclaimable list could still lead to
this issue.
We still need to decide whether we want to place MADV_FREE folios at the
head of the ez_reclaimable list or at the tail, even if that means ignoring
LRU inversion?

>
> >
> > >
> > > 3. Modify kswapd behavior to utilize this list. When kswapd is awaken=
ed due
> > >    to memory pressure, it should attempt to drop those pages first to=
 refill
> > >    free pages up to the high watermark by first reclaiming.
> > >
> > > 4. Before kswapd goes to sleep, it should scan the tail of the LRU li=
st and
> > >    move cold pages to the easily reclaimable list, unmapping them fro=
m the
> > >    page table.
> > >
> > > 5. Whenever page cache hit, move the page into evictable LRU.
> > >
> > > This approach allows the system to maintain a pool of readily availab=
le
> > > memory, mitigating the "aging" problem. The trade-off is the potentia=
l for
> > > minor page faults and LRU movement ovehreads if these pages in ez_rec=
laimable
> > > LRU are accessed again.
> >
> > I believe you're aware of an implementation from Samsung that uses
> > cleancache. Although it was dropped from the mainline kernel, it still
> > exists in the Android kernel. Samsung's rbincache, based on cleancache,
> > maintains a reserved memory region for holding reclaimed file folios.
> > Instead of LRU movement, rbincache uses memcpy to transfer data between
> > the pool and the page cache.
> >
> > >
> > > Furthermore, we could put some asynchrnous writeback pages(e.g., swap
> > > out or writeback the fs pages) into the list, too.
> > > Currently, what we are doing is rotate those pages back to head of LR=
U
> > > and once writeback is done, move the page to the tail of LRU again.
> > > We can simply put the page into ez_reclaimable LRU without rotating
> > > back and forth.
> >
> > If this is about establishing a pool of easily reclaimable file folios,=
 I
> > fully support the idea and am eager to try it, especially for Android,
> > where there are certainly strong use cases. However, I suspect it may
> > be controversial and could take months to gain acceptance. Therefore,
> > I=E2=80=99d prefer we first focus on landing a smaller change to addres=
s the
> > madv_free performance issue and treat that idea as a separate
> > incremental patch set.
>
> I don't want to block the improvement, Barry.
>
> The reason I suggested another LRU was actullay to prevent divergent
> between MGLRU and split-LRU and show the same behavior introducing
> additional logic in the central place.
> I don't think that's desire that a usespace hint showed different
> priority depending on admin config.

I understand your perspective. My interest in the ez_reclaimable LRU
is primarily about providing a quick method for freeing up memory
without tying it up in reservations for specific use cases.

For instance, in Samsung's implementation, there's a reserved memory
area intended for ION and DMA-BUF operations. Certain applications
can rapidly allocate these resources, and if this process is delayed,
it can adversely affect the user interface experience. To mitigate
this issue, they have established a shared reserved memory section
known as a clean cache pool, where reclaimed folios can be copied
into.

When files are read, the read path can also check this clean cache
pool; if there's a match, folios can be copied into the page
cache. Because this clean cache can be swiftly reclaimed, its
performance closely resembles that of being fully reserved.

If this type of reserved memory can help reduce I/O operations, it would
be beneficial, especially since this memory was originally set aside. In
scenarios involving ION and DMA-BUF, this memory could otherwise
go to waste.

This raises a concern: if the ez_reclaimable memory is mainly consumed
by various user scenarios (meaning all alloc_pages can access it
indiscriminately),
ION and DMA-BUF operations may find it difficult to acquire this memory in =
a
timely manner. This situation undermines the potential benefits we aim to
achieve for user experience in these scenarios.

>
> Personally, I belive that would be better to introudce a knob to
> change MADV_FREE's behavior for both LRU algorithms at the same time
> instead of only one even though we will see the LRU inversion issue.
>
> >
> > My current patch specifically targets the issue of reclaiming lazyfree
> > anon folios before reclaiming file folios. It appears your proposal is
> > independent (though related) work, and I don't believe it should delay
> > resolving the madv_free issue. Additionally, that pool doesn=E2=80=99t =
effectively
> > address the reclamation priority between files and lazyfree anon folios=
.
> >
> > In conclusion:
> >
> > 1. I agree that the pool is valuable, and I=E2=80=99d like to develop i=
t as an
> > incremental patch set. However, this is a significant step that will
> > require considerable time.
> > 2. It could be quite tricky to include both lazyfree anon folios and
> > reclaimed file folios (which are reclaimed in normal lists but not in
> > the 'easily-reclaimable' list) in the same LRU list. I=E2=80=99d prefer=
 to
> > start by replacing Samsung's rbincache to reduce file folio I/O if we
> > decide to implement the pool.
> > 3. I believe we should first focus on landing this fix patch for the
> > madv_free performance issue.
> >
> > What are your thoughts? I spoke with Yu, and he would like to hear
> > your opinion.
>
> Sure, I don't want to block any improvement but please think one more
> one more about my concern and just go with your ideas if everyone
> except me don't concern it.

I'm still grappling with these questions: Are we seeking ez_reclaimable
memory that can be equally utilized by all alloc_pages(), or is it primaril=
y
intended for specific high-priority users who previously depended on
reserved memory?

If the goal is the former, I=E2=80=99m still not completely clear on all th=
e
pros and cons.
There seem to be many issues that need careful consideration. For instance,
should we view moving from the ez_reclaimable list to the normal lists as
a refault? Or should we only consider reading from disk as a refault?

For each kswapd wake-up or direct reclamation, how much memory should
we reclaim from the ez_reclaimable list versus how much should we reclaim
from anonymous memory?

On the other hand, I definitely see the value in the latter approach, thoug=
h
it may not be suitable for all scenarios. It could be particularly benefici=
al
for users who have reserved memory for specific purposes. This reserved
memory can be repurposed as page caches when those specific applications
are not running. Once those applications are launched, the page caches can
be reclaimed at zero cost.

>
> Thank you.

Thanks
barry

