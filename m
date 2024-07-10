Return-Path: <linux-kernel+bounces-246970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A12492C978
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 06:02:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8311B1F241F4
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 04:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58CAA2BB04;
	Wed, 10 Jul 2024 04:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nb/zEVpo"
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1CCA15D1
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 04:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720584168; cv=none; b=GMti2D5APJjT5nSrr4Z9x874xjt6v9w7I1CZCKQRP8hmUm7K2vf8bm/QFDQpBbCDMt/rmau6KbO+O/W2K9wQofipeO4WmADvH+/BoHjOn6f/qlTc/Rfyco69aNs+sAbayOhev2xQNr1KCmWV1SKUf+C5Y32kK+eXeJbSX+2j3hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720584168; c=relaxed/simple;
	bh=VLqIfYgtMIkriI3W6P4DfLh7rhHkJEr0pG6GVPJd74Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=spNRnSuZGIh+c7dtuyugj5Y/lGake2R12iX4WPwB3uuxcONY7vxy/Fd73xCN5trhK9aGHfXEUWny5BpRGxjG5iw/e+iPvSZd0CbJhJM2NnpZ/Rv7Bm0B+5wjN5dcpOMJPxV/rYgER7auRPBY2WPVCNCWcvVWT8JnfHPnRtVgkgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nb/zEVpo; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-4f2ee3be4a1so2225026e0c.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 21:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720584166; x=1721188966; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wUOc1zhvUATC2lNy1DissAy7dipktC0MCYjVDZzv/QQ=;
        b=Nb/zEVpoF7Ko2uLC65cUo7M1NwPxgwFeRYsHIFN7RVfgbVDBGkeA9Fdk7v/J8GePKK
         dPCsmcrNR19gTTmaPGIQRvvAYJC1oc92hn2xdJ+kkG8f6pN+A+I2HLylVQchhwD1u9y/
         GkBNLFN5HKnBcvMWE0yyzuzlTFb73qJpe7KdUMKtXdts0aHgIqoTeRnyjZx2Avq6YB+n
         26xdLd3qO3woUbDbjOkJQl/N9AmZEpG+k6vsHhCxhZpwh9aIUKPDHmxDJtP6ugcNojQM
         1Z9ptl+l863vlAs9Kq7UoUubyzi1Go/uGmH45Fy5KSUpYh3EhwSu2sWQptHCu+tp/1Ud
         8yMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720584166; x=1721188966;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wUOc1zhvUATC2lNy1DissAy7dipktC0MCYjVDZzv/QQ=;
        b=OrFWHHKqb1QN9JWQAOLoWbLBoEj1l18Nd5QqUpP6b8JEGW1M9XxOvTwtlepNT76WPz
         aaxSxAGnMVCD1QdEpT5ZDYwfn4aCUzecPxJLd6fTxUENxeF0GVcUXApqqmk+Ya3JuKhy
         AzO40Kco0DwShWdwHmY3Yh/NunIM3LkF/yLnf2sroxfQQ8JxkwPfrYzsxLZuIblECqkZ
         I3D8g6oquzKZKh7lBRdQSx5fGMECJlzgI5N4BeN+pRCnzKj8PAgCUUHMNzO/+ytWVhnn
         UDeX5H5nl+430KJc3PhJDkt4QOIMdPRac/73g74nDQy/PAOfP2baWKqP9k05yOasJ1hw
         fKag==
X-Forwarded-Encrypted: i=1; AJvYcCVsNZ+eEdM6COhPvxDgbm2/ZtOMdGjp0gFo8gP0EaoDm5HqQixTJge65Y4xjm+/iImHST8BotR8NCOgWxXMOq/C4NK/6nJBrtVGhnTw
X-Gm-Message-State: AOJu0YwdUSzcvel0569mDKbXHmYXo3y/b5AtAHN4zt2jpF5kHO8+YnPG
	ZQOCq1BV7chYrEEnZAIFcMm8ra0L4Pk5S2+fSuX/ZOTMzTF6q3C6pUITnWXASUzlpAD52QzZ6jO
	guLCrLU545F40fpSa9/FszdnbNdU=
X-Google-Smtp-Source: AGHT+IEh1Tawc5szKRk5EjPSIbWX9sPL9WCeZ4VwMrOypjuvXV29AUsg6QhjnpXc2d3n9IG1X4qAhr14XzJ08u7ISbo=
X-Received: by 2002:a05:6122:910:b0:4f2:ebd9:8e12 with SMTP id
 71dfb90a1353d-4f33f24fa48mr5619965e0c.5.1720584164223; Tue, 09 Jul 2024
 21:02:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240709142312.372b20d49c6a97ecd2cd9904@linux-foundation.org>
 <20240710033212.36497-1-21cnbao@gmail.com> <dc2c3395-e514-40ad-b9d8-b76cf04ba0df@redhat.com>
In-Reply-To: <dc2c3395-e514-40ad-b9d8-b76cf04ba0df@redhat.com>
From: Barry Song <21cnbao@gmail.com>
Date: Wed, 10 Jul 2024 16:02:32 +1200
Message-ID: <CAGsJ_4zkt5wKk-JhEpZgqpQgNK--50jwpZFK4E_eXgBpKkMKmQ@mail.gmail.com>
Subject: Re: [PATCH v7] mm: shrink skip folio mapped by an exiting process
To: David Hildenbrand <david@redhat.com>
Cc: akpm@linux-foundation.org, justinjiang@vivo.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, opensource.kernel@vivo.com, 
	willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 10, 2024 at 3:59=E2=80=AFPM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 10.07.24 05:32, Barry Song wrote:
> > On Wed, Jul 10, 2024 at 9:23=E2=80=AFAM Andrew Morton <akpm@linux-found=
ation.org> wrote:
> >>
> >> On Tue,  9 Jul 2024 20:31:15 +0800 Zhiguo Jiang <justinjiang@vivo.com>=
 wrote:
> >>
> >>> The releasing process of the non-shared anonymous folio mapped solely=
 by
> >>> an exiting process may go through two flows: 1) the anonymous folio i=
s
> >>> firstly is swaped-out into swapspace and transformed into a swp_entry
> >>> in shrink_folio_list; 2) then the swp_entry is released in the proces=
s
> >>> exiting flow. This will result in the high cpu load of releasing a
> >>> non-shared anonymous folio mapped solely by an exiting process.
> >>>
> >>> When the low system memory and the exiting process exist at the same
> >>> time, it will be likely to happen, because the non-shared anonymous
> >>> folio mapped solely by an exiting process may be reclaimed by
> >>> shrink_folio_list.
> >>>
> >>> This patch is that shrink skips the non-shared anonymous folio solely
> >>> mapped by an exting process and this folio is only released directly =
in
> >>> the process exiting flow, which will save swap-out time and alleviate
> >>> the load of the process exiting.
> >>
> >> It would be helpful to provide some before-and-after runtime
> >> measurements, please.  It's a performance optimization so please let's
> >> see what effect it has.
> >
> > Hi Andrew,
> >
> > This was something I was curious about too, so I created a small test p=
rogram
> > that allocates and continuously writes to 256MB of memory. Using QEMU, =
I set
> > up a small machine with only 300MB of RAM to trigger kswapd.
> >
> > qemu-system-aarch64 -M virt,gic-version=3D3,mte=3Doff -nographic \
> >   -smp cpus=3D4 -cpu max \
> >   -m 300M -kernel arch/arm64/boot/Image
> >
> > The test program will be randomly terminated by its subprocess to trigg=
er
> > the use case of this patch.
> >
> > #include <stdio.h>
> > #include <stdlib.h>
> > #include <unistd.h>
> > #include <string.h>
> > #include <sys/types.h>
> > #include <sys/wait.h>
> > #include <time.h>
> > #include <signal.h>
> >
> > #define MEMORY_SIZE (256 * 1024 * 1024)
> >
> > unsigned char *memory;
> >
> > void allocate_and_write_memory()
> > {
> >      memory =3D (unsigned char *)malloc(MEMORY_SIZE);
> >      if (memory =3D=3D NULL) {
> >          perror("malloc");
> >          exit(EXIT_FAILURE);
> >      }
> >
> >      while (1)
> >          memset(memory, 0x11, MEMORY_SIZE);
> > }
> >
> > int main()
> > {
> >      pid_t pid;
> >      srand(time(NULL));
> >
> >      pid =3D fork();
> >
> >      if (pid < 0) {
> >          perror("fork");
> >          exit(EXIT_FAILURE);
> >      }
> >
> >      if (pid =3D=3D 0) {
> >          int delay =3D (rand() % 10000) + 10000;
> >          usleep(delay * 1000);
> >
> >       /* kill parent when it is busy on swapping */
> >          kill(getppid(), SIGKILL);
> >          _exit(0);
> >      } else {
> >          allocate_and_write_memory();
> >
> >          wait(NULL);
> >
> >          free(memory);
> >      }
> >
> >      return 0;
> > }
> >
> > I tracked the number of folios that could be redundantly
> > swapped out by adding a simple counter as shown below:
> >
> > @@ -879,6 +880,9 @@ static bool folio_referenced_one(struct folio *foli=
o,
> >                      check_stable_address_space(vma->vm_mm)) &&
> >                      folio_test_swapbacked(folio) &&
> >                      !folio_likely_mapped_shared(folio)) {
> > +                       static long i, size;
> > +                       size +=3D folio_size(folio);
> > +                       pr_err("index: %d skipped folio:%lx total size:=
%d\n", i++, (unsigned long)folio, size);
> >                          pra->referenced =3D -1;
> >                          page_vma_mapped_walk_done(&pvmw);
> >                          return false;
> >
> >
> > This is what I have observed:
> >
> > / # /home/barry/develop/linux/skip_swap_out_test
> > [   82.925645] index: 0 skipped folio:fffffdffc0425400 total size:65536
> > [   82.925960] index: 1 skipped folio:fffffdffc0425800 total size:13107=
2
> > [   82.927524] index: 2 skipped folio:fffffdffc0425c00 total size:19660=
8
> > [   82.928649] index: 3 skipped folio:fffffdffc0426000 total size:26214=
4
> > [   82.929383] index: 4 skipped folio:fffffdffc0426400 total size:32768=
0
> > [   82.929995] index: 5 skipped folio:fffffdffc0426800 total size:39321=
6
> > ...
> > [   88.469130] index: 6112 skipped folio:fffffdffc0390080 total size:97=
230848
> > [   88.469966] index: 6113 skipped folio:fffffdffc038d000 total size:97=
296384
> > [   89.023414] index: 6114 skipped folio:fffffdffc0366cc0 total size:97=
300480
> >
> > I observed that this patch effectively skipped 6114 folios (either 4KB =
or 64KB
> > mTHP), potentially reducing the swap-out by up to 92MB (97,300,480 byte=
s) during
> > the process exit.
> >
> > Despite the numerous mistakes Zhiguo made in sending this patch, it is =
still
> > quite valuable. Please consider pulling his v9 into the mm tree for tes=
ting.
>
> BTW, we dropped the folio_test_anon() check, but what about shmem? They
> also do __folio_set_swapbacked()?

my point is that the purpose is skipping redundant swap-out, if shmem is si=
ngle
mapped, they could be also skipped.

>
> --
> Cheers,
>
> David / dhildenb
>

Thanks
Barry

