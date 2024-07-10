Return-Path: <linux-kernel+bounces-247135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA25E92CBB1
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 09:12:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 297801F24124
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 07:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCEC582D94;
	Wed, 10 Jul 2024 07:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e8JSDYvn"
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AFD882877
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 07:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720595503; cv=none; b=Iia1MLeM8fWVVRd8e/5IlOYy+d4IQG17wpvwhFzQ01VsSsK4MDUIWO4XjpFpvbVft3PPn7shdEllsWpXWC57KIhBcQ4qksW7qTT7DIS9svPedx6pDbRLLzCBYLLfXRDbWa9t14kwWWqDE11dUiYG00QH6hiMYNLKxLpRc726p64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720595503; c=relaxed/simple;
	bh=WKwVkyeloxz7aqvt/RbuzbHWOr70GQmZYCrNVVX/kWU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TMSmmArRzrz0qpkoMcx5TmgbTyBUnWgN1udscPKygRJO1+nadSA4r/Lo02a7aiWFhosVOLSmPtrKFq7hLbt3RLgU3i29689knXf6N2M6cQOfhllpt6qB3ExQHLsdckVFU62S8RljeX5ggTYCI5gdvvDHxF4Bx+70t2q0S8i7IJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e8JSDYvn; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-4e7eadf3668so2377649e0c.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 00:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720595501; x=1721200301; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=He2L5WrIWi5QoCXzzcw2qnnMDdoTPVxOHG3qIMG7HS8=;
        b=e8JSDYvnk9zusv7lkaLrtSue3bA3CRy3Fxs/oQJcpxWhx+SdtloKIv85sWInfA6C8t
         Ma3Kix2Pphea16mx4/H+LI6E+W4eDJo5+28Z/CDCNH+ByfUHDNeDRLGTR1k/MzSiM5e3
         DoBKpvMbPpIG2OhhlbbwJQWvPbkiLt8K3UZpgT3AEAwUWvcDOi1zffM7uJZk5isTA4lP
         tGdyG4s/ljTu8Phkoo9isPG1dFQ5lMcDWQlm1NSwSD43VTW15eYmcm8MgItwfV77c1SP
         L1oC2UQXDNYRpI40JFWrh2nD91Rt/X3+f8PcEO7fAAvfQDIC3yA1QePk8tQd/1qByfZ/
         JTwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720595501; x=1721200301;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=He2L5WrIWi5QoCXzzcw2qnnMDdoTPVxOHG3qIMG7HS8=;
        b=QffDML1pyOl9F7/t/qOa8BV6rTY1xRcXIkRVXKGjmYSDb/5tQo0UQvgJOCEPlDTWYU
         0kh6/acfARIjem1AopBdp3sFMc4hRNL/cjX5Iyo2QpwBGMSNWo4skjCjAeX51Ow5YimH
         N6VTmVemB52lbk2UGo5Zk4Ll+snmj8tYkDvbfUw/xpiC9ULwNhGDPI4rGqKW2zwJ28D4
         YZjP9ze8NhiSa1PiTg5t5mrgFR62DAnSgcK88jY1SBlJo+OhJoYkAhfOY2yksle9WDF+
         K3BPSx8VpkyHMm9jbIdE6CYyzAcORU5S9L9zVlkujG96/ZcRbHOElZGjlidw8/1SwL6y
         K0Dw==
X-Forwarded-Encrypted: i=1; AJvYcCVOcqTa2bCcSbVnU18BZH/dQLdcRhmIEYJvVLbkuuSbw7R65EF/Mnyp+VPeJc0dU5A4R8WU/O/561vbG2VkbThhZnyonhY+ADU9SZEv
X-Gm-Message-State: AOJu0YzWNMtaZbPfDtLCr95ur3xWDR7Rzcn0qaXMBYytUyzIonPRVEP8
	NIA5jpumMXnouevzL0FG57vg69nsRGxBCUHJNcEEVWksxXex7AUF+quPwDvyQdKtLSGvuoz6IXl
	B+6ETwUlPM+mntDzjMx55d3fjvUQ=
X-Google-Smtp-Source: AGHT+IFAjl4gZJyeHnaT6uSffenpdOL61wv9ZowgTtk/gj4Lcvq45arB9s57StgvMBPiEfJeRBRK9ObdOT9pToW8jKg=
X-Received: by 2002:a05:6122:4114:b0:4f3:1e1:f10e with SMTP id
 71dfb90a1353d-4f33f2293c3mr6198768e0c.9.1720595501004; Wed, 10 Jul 2024
 00:11:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240709142312.372b20d49c6a97ecd2cd9904@linux-foundation.org>
 <20240710033212.36497-1-21cnbao@gmail.com> <dc2c3395-e514-40ad-b9d8-b76cf04ba0df@redhat.com>
 <CAGsJ_4zkt5wKk-JhEpZgqpQgNK--50jwpZFK4E_eXgBpKkMKmQ@mail.gmail.com>
 <9d77dc44-f61c-4e52-938f-c268daf0e169@redhat.com> <CAGsJ_4z6kv=KhZ=DY-puG0uVosEPWx2=CNH0TGBG4W9tZoW+NA@mail.gmail.com>
 <db98cf80-6755-4083-83d7-cd750fd029b6@vivo.com>
In-Reply-To: <db98cf80-6755-4083-83d7-cd750fd029b6@vivo.com>
From: Barry Song <21cnbao@gmail.com>
Date: Wed, 10 Jul 2024 19:11:29 +1200
Message-ID: <CAGsJ_4ze50AYaBnAAt=pyZ0rWQ6scpeuYaFiqJfGeibET+anKg@mail.gmail.com>
Subject: Re: [PATCH v7] mm: shrink skip folio mapped by an exiting process
To: zhiguojiang <justinjiang@vivo.com>
Cc: David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, opensource.kernel@vivo.com, 
	willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 10, 2024 at 6:47=E2=80=AFPM zhiguojiang <justinjiang@vivo.com> =
wrote:
>
>
>
> =E5=9C=A8 2024/7/10 12:44, Barry Song =E5=86=99=E9=81=93:
> > [Some people who received this message don't often get email from 21cnb=
ao@gmail.com. Learn why this is important at https://aka.ms/LearnAboutSende=
rIdentification ]
> >
> > On Wed, Jul 10, 2024 at 4:04=E2=80=AFPM David Hildenbrand <david@redhat=
.com> wrote:
> >> On 10.07.24 06:02, Barry Song wrote:
> >>> On Wed, Jul 10, 2024 at 3:59=E2=80=AFPM David Hildenbrand <david@redh=
at.com> wrote:
> >>>> On 10.07.24 05:32, Barry Song wrote:
> >>>>> On Wed, Jul 10, 2024 at 9:23=E2=80=AFAM Andrew Morton <akpm@linux-f=
oundation.org> wrote:
> >>>>>> On Tue,  9 Jul 2024 20:31:15 +0800 Zhiguo Jiang <justinjiang@vivo.=
com> wrote:
> >>>>>>
> >>>>>>> The releasing process of the non-shared anonymous folio mapped so=
lely by
> >>>>>>> an exiting process may go through two flows: 1) the anonymous fol=
io is
> >>>>>>> firstly is swaped-out into swapspace and transformed into a swp_e=
ntry
> >>>>>>> in shrink_folio_list; 2) then the swp_entry is released in the pr=
ocess
> >>>>>>> exiting flow. This will result in the high cpu load of releasing =
a
> >>>>>>> non-shared anonymous folio mapped solely by an exiting process.
> >>>>>>>
> >>>>>>> When the low system memory and the exiting process exist at the s=
ame
> >>>>>>> time, it will be likely to happen, because the non-shared anonymo=
us
> >>>>>>> folio mapped solely by an exiting process may be reclaimed by
> >>>>>>> shrink_folio_list.
> >>>>>>>
> >>>>>>> This patch is that shrink skips the non-shared anonymous folio so=
lely
> >>>>>>> mapped by an exting process and this folio is only released direc=
tly in
> >>>>>>> the process exiting flow, which will save swap-out time and allev=
iate
> >>>>>>> the load of the process exiting.
> >>>>>> It would be helpful to provide some before-and-after runtime
> >>>>>> measurements, please.  It's a performance optimization so please l=
et's
> >>>>>> see what effect it has.
> >>>>> Hi Andrew,
> >>>>>
> >>>>> This was something I was curious about too, so I created a small te=
st program
> >>>>> that allocates and continuously writes to 256MB of memory. Using QE=
MU, I set
> >>>>> up a small machine with only 300MB of RAM to trigger kswapd.
> >>>>>
> >>>>> qemu-system-aarch64 -M virt,gic-version=3D3,mte=3Doff -nographic \
> >>>>>     -smp cpus=3D4 -cpu max \
> >>>>>     -m 300M -kernel arch/arm64/boot/Image
> >>>>>
> >>>>> The test program will be randomly terminated by its subprocess to t=
rigger
> >>>>> the use case of this patch.
> >>>>>
> >>>>> #include <stdio.h>
> >>>>> #include <stdlib.h>
> >>>>> #include <unistd.h>
> >>>>> #include <string.h>
> >>>>> #include <sys/types.h>
> >>>>> #include <sys/wait.h>
> >>>>> #include <time.h>
> >>>>> #include <signal.h>
> >>>>>
> >>>>> #define MEMORY_SIZE (256 * 1024 * 1024)
> >>>>>
> >>>>> unsigned char *memory;
> >>>>>
> >>>>> void allocate_and_write_memory()
> >>>>> {
> >>>>>        memory =3D (unsigned char *)malloc(MEMORY_SIZE);
> >>>>>        if (memory =3D=3D NULL) {
> >>>>>            perror("malloc");
> >>>>>            exit(EXIT_FAILURE);
> >>>>>        }
> >>>>>
> >>>>>        while (1)
> >>>>>            memset(memory, 0x11, MEMORY_SIZE);
> >>>>> }
> >>>>>
> >>>>> int main()
> >>>>> {
> >>>>>        pid_t pid;
> >>>>>        srand(time(NULL));
> >>>>>
> >>>>>        pid =3D fork();
> >>>>>
> >>>>>        if (pid < 0) {
> >>>>>            perror("fork");
> >>>>>            exit(EXIT_FAILURE);
> >>>>>        }
> >>>>>
> >>>>>        if (pid =3D=3D 0) {
> >>>>>            int delay =3D (rand() % 10000) + 10000;
> >>>>>            usleep(delay * 1000);
> >>>>>
> >>>>>         /* kill parent when it is busy on swapping */
> >>>>>            kill(getppid(), SIGKILL);
> >>>>>            _exit(0);
> >>>>>        } else {
> >>>>>            allocate_and_write_memory();
> >>>>>
> >>>>>            wait(NULL);
> >>>>>
> >>>>>            free(memory);
> >>>>>        }
> >>>>>
> >>>>>        return 0;
> >>>>> }
> >>>>>
> >>>>> I tracked the number of folios that could be redundantly
> >>>>> swapped out by adding a simple counter as shown below:
> >>>>>
> >>>>> @@ -879,6 +880,9 @@ static bool folio_referenced_one(struct folio *=
folio,
> >>>>>                        check_stable_address_space(vma->vm_mm)) &&
> >>>>>                        folio_test_swapbacked(folio) &&
> >>>>>                        !folio_likely_mapped_shared(folio)) {
> >>>>> +                       static long i, size;
> >>>>> +                       size +=3D folio_size(folio);
> >>>>> +                       pr_err("index: %d skipped folio:%lx total s=
ize:%d\n", i++, (unsigned long)folio, size);
> >>>>>                            pra->referenced =3D -1;
> >>>>>                            page_vma_mapped_walk_done(&pvmw);
> >>>>>                            return false;
> >>>>>
> >>>>>
> >>>>> This is what I have observed:
> >>>>>
> >>>>> / # /home/barry/develop/linux/skip_swap_out_test
> >>>>> [   82.925645] index: 0 skipped folio:fffffdffc0425400 total size:6=
5536
> >>>>> [   82.925960] index: 1 skipped folio:fffffdffc0425800 total size:1=
31072
> >>>>> [   82.927524] index: 2 skipped folio:fffffdffc0425c00 total size:1=
96608
> >>>>> [   82.928649] index: 3 skipped folio:fffffdffc0426000 total size:2=
62144
> >>>>> [   82.929383] index: 4 skipped folio:fffffdffc0426400 total size:3=
27680
> >>>>> [   82.929995] index: 5 skipped folio:fffffdffc0426800 total size:3=
93216
> >>>>> ...
> >>>>> [   88.469130] index: 6112 skipped folio:fffffdffc0390080 total siz=
e:97230848
> >>>>> [   88.469966] index: 6113 skipped folio:fffffdffc038d000 total siz=
e:97296384
> >>>>> [   89.023414] index: 6114 skipped folio:fffffdffc0366cc0 total siz=
e:97300480
> >>>>>
> >>>>> I observed that this patch effectively skipped 6114 folios (either =
4KB or 64KB
> >>>>> mTHP), potentially reducing the swap-out by up to 92MB (97,300,480 =
bytes) during
> >>>>> the process exit.
> >>>>>
> >>>>> Despite the numerous mistakes Zhiguo made in sending this patch, it=
 is still
> >>>>> quite valuable. Please consider pulling his v9 into the mm tree for=
 testing.
> >>>> BTW, we dropped the folio_test_anon() check, but what about shmem? T=
hey
> >>>> also do __folio_set_swapbacked()?
> >>> my point is that the purpose is skipping redundant swap-out, if shmem=
 is single
> >>> mapped, they could be also skipped.
> >> But they won't get necessarily *freed* when unmapping them. They might
> >> just continue living in tmpfs? where some other process might just map
> >> them later?
> >>
> > You're correct. I overlooked this aspect, focusing on swap and thinking=
 of shmem
> > solely in terms of swap.
> >
> >> IMHO, there is a big difference here between anon and shmem. (well,
> >> anon_shmem would actually be different :) )
> > Even though anon_shmem behaves similarly to anonymous memory when
> > releasing memory, it doesn't seem worth the added complexity?
> >
> > So unfortunately it seems Zhiguo still needs v10 to take folio_test_ano=
n()
> > back? Sorry for my bad, Zhiguo.
> If folio_test_anon(folio) && folio_test_swapbacked(folio) condition is
> used, can
> it means that the folio is anonymous anther than shmem definitely? So doe=
s
> folio_likely_mapped_shared() need to be removed?

No, shared memory (shmem) isn't necessarily shared, and private anonymous
memory isn't necessarily unshared. There is no direct relationship between
them.

In the case of a fork, your private anonymous folio can be shared by
two or more processes before CoW.

> >
> >> --
> >> Cheers,
> >>
> >> David / dhildenb
> >>
> > Thanks
> > Barry
> Thanks
> Zhiguo
>

