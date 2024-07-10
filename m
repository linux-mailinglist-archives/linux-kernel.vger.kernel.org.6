Return-Path: <linux-kernel+bounces-247015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81C0192C9F9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 06:44:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A50151C2297F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 04:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DA9F3FB01;
	Wed, 10 Jul 2024 04:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pas7lENJ"
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA661EEF8
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 04:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720586680; cv=none; b=blblvkcDqwvLYB9vZQCtWLECBEj7Z0mpMhJFUSEKkQIfq0Ry32qmlmA6rwViAW1s1mNXPI3HzvgssSlcgWytrUJWHyt4cewpH2tSAym1gTR/MRKQ/bqmMbWI8FkHO4htN98Xg2RvsCv8tw/p0qTlLrQyylLmzTOn97tvR8pi8GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720586680; c=relaxed/simple;
	bh=/1DIAnSM+aFxWhpzQpOdgN687Tss4bIVrP3TTlRfQ64=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gMQ/I0Pze6igwu3Uut9oupItpKZvkDwVBkaM3W682LzIC7HWo7R15Kiz6zUtMkk+g3smFeBS1qPpiyaYP5QTvSAvW3oNC9B1DIxFsm+RDtbc6K3IZV8IqoDPGIKBO+kdHNFYwnSeyNHViUldC06e2VYx6vO+1Ei/v8VRRuOjoLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pas7lENJ; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-8102193c82bso1442859241.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 21:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720586677; x=1721191477; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y53NzQgMOK0rpI6ftnaa6VX6nvsG1CSTn7iwk/7Hdp8=;
        b=Pas7lENJpg8DNibDSj4VRauQRzb2elwRwvxr/YJ2tGuwnWq6ZEOA+ouMi+A5MVDRrt
         hzxV+wurC1qdtS6vXIwefXi3YmGKmTeGQm34qr0C81t2B1pAsTV0/m3y7fVGD+ByJLU0
         /ZApmlF8pqVrl3vEOe0khEZECFjmpwg5zppxDhA086PwG86k7/9uI7sMlqqahfkJNk30
         czzKA4PPyoOchrHyXKIksa1W97Egha3+XPlxm84IT7KlTjmzd3KoJXSXFB8hVzGr95fK
         pE+rf7LJoW9KuCgntgVxTBungndOg1jbkWQLiPLEaTwHIYoOUxqLdlmEsnIjGNNqK1sF
         CkRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720586677; x=1721191477;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y53NzQgMOK0rpI6ftnaa6VX6nvsG1CSTn7iwk/7Hdp8=;
        b=cpNeBSgr8XF4qOAiZFhgO6Xw2cLuVoa9l8jqif3DKrc++eM+Q0bNaUCgwYy3SUiGmg
         rhJ7N/G3SsErKSFUhAjwvZxYIQVoD+TAr1m1vYkMrFlOdVOW/cobCr3A+3LMaJAZaZZ5
         tJIi2aUQBgLcqw8DSxW/iI3o/6g2fwxof3HRqdHHu0FHHWxAVbX+VH1OmC3+slVeMtZ6
         eNNBivR53fWZxou3kOAOtMbYH9HqWwIHFopt3oaN0Y2hBUVgx1ItvpuHJJ3iNC+Dp4iE
         kooyCmbZ4MBU8owYfBoKnngsqioLnx/l/0qdCn33oJH0wbjySqbjw0iqeVy9CVexLa2a
         9zfQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1/OrNtXDCH+U4yLfMgv5KoMGbFBj3MKf0Y75ahhHHwNEBeJRXpoCEGNVeDSd18hqyRCp6rMexXgP7SGhLP0WLOsDBq1dRpDVFw24W
X-Gm-Message-State: AOJu0Yw3fFsz8Tcoworzq6QZAGMBzbuzp6gFWETT7HK6m8hwsqgmhXVw
	aXtJAAIQw5eSkDmpi38zRrox9J075bcynCZVgfOt7whl3wG/9zsmlmdOOJGRfTqB666y3wPCAXe
	3ZI1sGHgwEhL2Z+qWnHwPFUPbRIM=
X-Google-Smtp-Source: AGHT+IGxRAGjwgygmRWdYGw6icPX2MCh/jShZgkxGy5unZ57KvTs89yesiUcVhrx3Kk30qHOjWE3bwPBNrFc0vB5sHE=
X-Received: by 2002:a05:6102:c86:b0:48c:3174:e8a5 with SMTP id
 ada2fe7eead31-490322109fbmr5848222137.29.1720586677210; Tue, 09 Jul 2024
 21:44:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240709142312.372b20d49c6a97ecd2cd9904@linux-foundation.org>
 <20240710033212.36497-1-21cnbao@gmail.com> <dc2c3395-e514-40ad-b9d8-b76cf04ba0df@redhat.com>
 <CAGsJ_4zkt5wKk-JhEpZgqpQgNK--50jwpZFK4E_eXgBpKkMKmQ@mail.gmail.com> <9d77dc44-f61c-4e52-938f-c268daf0e169@redhat.com>
In-Reply-To: <9d77dc44-f61c-4e52-938f-c268daf0e169@redhat.com>
From: Barry Song <21cnbao@gmail.com>
Date: Wed, 10 Jul 2024 16:44:25 +1200
Message-ID: <CAGsJ_4z6kv=KhZ=DY-puG0uVosEPWx2=CNH0TGBG4W9tZoW+NA@mail.gmail.com>
Subject: Re: [PATCH v7] mm: shrink skip folio mapped by an exiting process
To: David Hildenbrand <david@redhat.com>
Cc: akpm@linux-foundation.org, justinjiang@vivo.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, opensource.kernel@vivo.com, 
	willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 10, 2024 at 4:04=E2=80=AFPM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 10.07.24 06:02, Barry Song wrote:
> > On Wed, Jul 10, 2024 at 3:59=E2=80=AFPM David Hildenbrand <david@redhat=
.com> wrote:
> >>
> >> On 10.07.24 05:32, Barry Song wrote:
> >>> On Wed, Jul 10, 2024 at 9:23=E2=80=AFAM Andrew Morton <akpm@linux-fou=
ndation.org> wrote:
> >>>>
> >>>> On Tue,  9 Jul 2024 20:31:15 +0800 Zhiguo Jiang <justinjiang@vivo.co=
m> wrote:
> >>>>
> >>>>> The releasing process of the non-shared anonymous folio mapped sole=
ly by
> >>>>> an exiting process may go through two flows: 1) the anonymous folio=
 is
> >>>>> firstly is swaped-out into swapspace and transformed into a swp_ent=
ry
> >>>>> in shrink_folio_list; 2) then the swp_entry is released in the proc=
ess
> >>>>> exiting flow. This will result in the high cpu load of releasing a
> >>>>> non-shared anonymous folio mapped solely by an exiting process.
> >>>>>
> >>>>> When the low system memory and the exiting process exist at the sam=
e
> >>>>> time, it will be likely to happen, because the non-shared anonymous
> >>>>> folio mapped solely by an exiting process may be reclaimed by
> >>>>> shrink_folio_list.
> >>>>>
> >>>>> This patch is that shrink skips the non-shared anonymous folio sole=
ly
> >>>>> mapped by an exting process and this folio is only released directl=
y in
> >>>>> the process exiting flow, which will save swap-out time and allevia=
te
> >>>>> the load of the process exiting.
> >>>>
> >>>> It would be helpful to provide some before-and-after runtime
> >>>> measurements, please.  It's a performance optimization so please let=
's
> >>>> see what effect it has.
> >>>
> >>> Hi Andrew,
> >>>
> >>> This was something I was curious about too, so I created a small test=
 program
> >>> that allocates and continuously writes to 256MB of memory. Using QEMU=
, I set
> >>> up a small machine with only 300MB of RAM to trigger kswapd.
> >>>
> >>> qemu-system-aarch64 -M virt,gic-version=3D3,mte=3Doff -nographic \
> >>>    -smp cpus=3D4 -cpu max \
> >>>    -m 300M -kernel arch/arm64/boot/Image
> >>>
> >>> The test program will be randomly terminated by its subprocess to tri=
gger
> >>> the use case of this patch.
> >>>
> >>> #include <stdio.h>
> >>> #include <stdlib.h>
> >>> #include <unistd.h>
> >>> #include <string.h>
> >>> #include <sys/types.h>
> >>> #include <sys/wait.h>
> >>> #include <time.h>
> >>> #include <signal.h>
> >>>
> >>> #define MEMORY_SIZE (256 * 1024 * 1024)
> >>>
> >>> unsigned char *memory;
> >>>
> >>> void allocate_and_write_memory()
> >>> {
> >>>       memory =3D (unsigned char *)malloc(MEMORY_SIZE);
> >>>       if (memory =3D=3D NULL) {
> >>>           perror("malloc");
> >>>           exit(EXIT_FAILURE);
> >>>       }
> >>>
> >>>       while (1)
> >>>           memset(memory, 0x11, MEMORY_SIZE);
> >>> }
> >>>
> >>> int main()
> >>> {
> >>>       pid_t pid;
> >>>       srand(time(NULL));
> >>>
> >>>       pid =3D fork();
> >>>
> >>>       if (pid < 0) {
> >>>           perror("fork");
> >>>           exit(EXIT_FAILURE);
> >>>       }
> >>>
> >>>       if (pid =3D=3D 0) {
> >>>           int delay =3D (rand() % 10000) + 10000;
> >>>           usleep(delay * 1000);
> >>>
> >>>        /* kill parent when it is busy on swapping */
> >>>           kill(getppid(), SIGKILL);
> >>>           _exit(0);
> >>>       } else {
> >>>           allocate_and_write_memory();
> >>>
> >>>           wait(NULL);
> >>>
> >>>           free(memory);
> >>>       }
> >>>
> >>>       return 0;
> >>> }
> >>>
> >>> I tracked the number of folios that could be redundantly
> >>> swapped out by adding a simple counter as shown below:
> >>>
> >>> @@ -879,6 +880,9 @@ static bool folio_referenced_one(struct folio *fo=
lio,
> >>>                       check_stable_address_space(vma->vm_mm)) &&
> >>>                       folio_test_swapbacked(folio) &&
> >>>                       !folio_likely_mapped_shared(folio)) {
> >>> +                       static long i, size;
> >>> +                       size +=3D folio_size(folio);
> >>> +                       pr_err("index: %d skipped folio:%lx total siz=
e:%d\n", i++, (unsigned long)folio, size);
> >>>                           pra->referenced =3D -1;
> >>>                           page_vma_mapped_walk_done(&pvmw);
> >>>                           return false;
> >>>
> >>>
> >>> This is what I have observed:
> >>>
> >>> / # /home/barry/develop/linux/skip_swap_out_test
> >>> [   82.925645] index: 0 skipped folio:fffffdffc0425400 total size:655=
36
> >>> [   82.925960] index: 1 skipped folio:fffffdffc0425800 total size:131=
072
> >>> [   82.927524] index: 2 skipped folio:fffffdffc0425c00 total size:196=
608
> >>> [   82.928649] index: 3 skipped folio:fffffdffc0426000 total size:262=
144
> >>> [   82.929383] index: 4 skipped folio:fffffdffc0426400 total size:327=
680
> >>> [   82.929995] index: 5 skipped folio:fffffdffc0426800 total size:393=
216
> >>> ...
> >>> [   88.469130] index: 6112 skipped folio:fffffdffc0390080 total size:=
97230848
> >>> [   88.469966] index: 6113 skipped folio:fffffdffc038d000 total size:=
97296384
> >>> [   89.023414] index: 6114 skipped folio:fffffdffc0366cc0 total size:=
97300480
> >>>
> >>> I observed that this patch effectively skipped 6114 folios (either 4K=
B or 64KB
> >>> mTHP), potentially reducing the swap-out by up to 92MB (97,300,480 by=
tes) during
> >>> the process exit.
> >>>
> >>> Despite the numerous mistakes Zhiguo made in sending this patch, it i=
s still
> >>> quite valuable. Please consider pulling his v9 into the mm tree for t=
esting.
> >>
> >> BTW, we dropped the folio_test_anon() check, but what about shmem? The=
y
> >> also do __folio_set_swapbacked()?
> >
> > my point is that the purpose is skipping redundant swap-out, if shmem i=
s single
> > mapped, they could be also skipped.
>
> But they won't get necessarily *freed* when unmapping them. They might
> just continue living in tmpfs? where some other process might just map
> them later?
>

You're correct. I overlooked this aspect, focusing on swap and thinking of =
shmem
solely in terms of swap.

> IMHO, there is a big difference here between anon and shmem. (well,
> anon_shmem would actually be different :) )

Even though anon_shmem behaves similarly to anonymous memory when
releasing memory, it doesn't seem worth the added complexity?

So unfortunately it seems Zhiguo still needs v10 to take folio_test_anon()
back? Sorry for my bad, Zhiguo.

>
> --
> Cheers,
>
> David / dhildenb
>

Thanks
Barry

