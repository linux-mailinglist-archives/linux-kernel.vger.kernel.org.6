Return-Path: <linux-kernel+bounces-277028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C302E949B47
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 00:25:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B5AB1C22B0E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 22:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08024171658;
	Tue,  6 Aug 2024 22:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3Esf71gi"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 851133612D
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 22:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722983112; cv=none; b=Qt8R/cDbgnP1c0pv948EWNYTA/zjWYYbIosYK+7Zmy6LtzevHRLPQ7FapDCDHJZYC3PsmbSq+2x61LChUMCtme73+6aHHSW+k0QqOdC/wDKDGzwYKwsZcMU12mx13S9SS9Er+BmmgYxm3yyXgjLlJEUXLy35GUOa8mOJc0+yV2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722983112; c=relaxed/simple;
	bh=Xl54JjFemnY92XFUwaYBnoAmRg4vFTl6n9wSIt6MqVc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aRgXFlJHrRg5quN2mINfgn4fu52qHcFxN6h1HHZhz+D8WQ8lRkIKUkbhHG1NHQz/idlmIoNsMF1gCMNyMqWtpcT551MdXyhIhzfnhMprwcnyGqI4G1YXlDVocfxAdYZ+aWeGorU/NNdaksjpczUrAJB/3XBatc7fRP6roOVvhfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3Esf71gi; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5a28b61b880so22996a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 15:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722983109; x=1723587909; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PNgrijtfaAhcGE8aUaJ4GdZwwdXwIst9SSN5fUKHNMo=;
        b=3Esf71giIS0WI9ru2NWDBFn70d+qiGcO9WQ2ongIt62WRAuau0OylL1sd/4Db6nXrU
         yTwM86wNUl4gYPXumCY8T+l87U0CxxmysBEY7bv2QRQPckRi6wQwbFrhRTTPwq354K+e
         SDuiNqBtwK8VZc7ObPFR7aQzK6bIO9UMYuC1C8wuIh+OoAwd0sU65zFfv3OjZPy8bL7s
         FQq58yGyH/VeNyYfSK1gKllSVSVZLcrPBYIdOauLRqV09VWJ2pj5tgc2p+t9E0QYsi+X
         8HLk6D84d2PPJq4dd5MM4dvm2HgI5Gz0WWBK/azG5bAZnPyePnmmB8ziWy9ruxAKOUFa
         gPRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722983109; x=1723587909;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PNgrijtfaAhcGE8aUaJ4GdZwwdXwIst9SSN5fUKHNMo=;
        b=qzmGNuOy7SQwYhMmIEqO5jEjl0TiA/K3V0DSqFbtDDzy54wMJN3SUSRMQrbvlGSyjp
         hrAZB4orUYlCTgMU1dVQNfv/Hx6JnZdotz8mNGa4drL1a8KpSFjQ07/NOWrcBNSdbMiB
         hDtreH4QpdwF92LBDUcS0TlzZ/XQUbBinlCBOrJZPXV6Fds6fZm5kXD7DFhB+P4cEH+X
         Y+GNynw+vid1UeePpSDhUDD6nwbbiRTdpV1kdxBxyl8UQup70dYXLydMDD1SLnhZa5de
         E33KZmmx97qF0ru+S38PSwYL4DMnjvWZIeytOkqOFJYw6zeoEDNrGBYKCjOh3uT/Dv6r
         x1HQ==
X-Forwarded-Encrypted: i=1; AJvYcCVCB/7x7qDPZURXvkYK6Fa7F5Kj1sDZi/45+RskWJDt6FJpz93qDxf1dXJZ4OoJN5ZCMP+uvGkhivOuL/P6UfNroYxhta4b4PFvHr7z
X-Gm-Message-State: AOJu0YzvL9sucT8iZDmHE8Ti5hT5HpqqTQjLz8JjuFLaC0fPjjhIJ9M5
	9GP2Ia+dXtKP+JENb0F4GIrkE0vRKBGEzmhMPb+VjlNoLeFJZ6DXtwT/Ej9cCq4M/EOp2/IAOnh
	N7VTteCm4aD/+vhvBN8qx9ZdJLsFcqRn2sxDG
X-Google-Smtp-Source: AGHT+IFtZNnOWWz7icrHeWYMQASt0K6txJPjEkGC1I5ErZXHaRJlYa9qwGLVIT0ocvIR1sY7iNfRx+4F+UFVJMAB/JY=
X-Received: by 2002:a05:6402:280a:b0:58b:93:b623 with SMTP id
 4fb4d7f45d1cf-5bba35729c9mr33913a12.5.1722983108317; Tue, 06 Aug 2024
 15:25:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240806212808.1885309-1-pedro.falcato@gmail.com>
In-Reply-To: <20240806212808.1885309-1-pedro.falcato@gmail.com>
From: Jeff Xu <jeffxu@google.com>
Date: Tue, 6 Aug 2024 15:24:30 -0700
Message-ID: <CALmYWFuN5SxCrkFfgeP_uFThz-a=+VExjy2eqn5tQZSyaCjswg@mail.gmail.com>
Subject: Re: [PATCH 0/7] mm: Optimize mseal checks
To: Pedro Falcato <pedro.falcato@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, oliver.sang@intel.com, 
	torvalds@linux-foundation.org, Michael Ellerman <mpe@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 6, 2024 at 2:28=E2=80=AFPM Pedro Falcato <pedro.falcato@gmail.c=
om> wrote:
>
> Optimize mseal checks by removing the separate can_modify_mm() step, and
> just doing checks on the individual vmas, when various operations are
> themselves iterating through the tree. This provides a nice speedup.
>
> While I was at it, I found that is_madv_discard() was completely bogus.
>
Thanks for catching this!
Is it possible to separate this fix out from this series and send it
separately and merge first ?

> Note that my series ignores arch_unmap(), which seems to generally be wha=
t we're trending towards[2]. It should
> be applied on top of any powerpc vdso ->close patch to avoid regressions =
on the PPC architecture. No other
> architecture seems to use arch_unmap.
>
> Note2: This series does not pass all mseal_tests on my end (test_seal_mre=
map_move_dontunmap_anyaddr fails twice). But the
> top of Linus's tree does not pass these for me either (neither does my Ar=
ch Linux 6.10.2 kernel),
> for some reason (mremap regression?).
>
I just sync to Linus's main and I was able to run the test (except two
pkeys related test are skipped because I m on VM)

> will-it-scale mmap1_process[1] -t 1 results:
>
> commit 3450fe2b574b4345e4296ccae395149e1a357fee:
>
> min:277605 max:277605 total:277605
> min:281784 max:281784 total:281784
> min:277238 max:277238 total:277238
> min:281761 max:281761 total:281761
> min:274279 max:274279 total:274279
> min:254854 max:254854 total:254854
> measurement
> min:269143 max:269143 total:269143
> min:270454 max:270454 total:270454
> min:243523 max:243523 total:243523
> min:251148 max:251148 total:251148
> min:209669 max:209669 total:209669
> min:190426 max:190426 total:190426
> min:231219 max:231219 total:231219
> min:275364 max:275364 total:275364
> min:266540 max:266540 total:266540
> min:242572 max:242572 total:242572
> min:284469 max:284469 total:284469
> min:278882 max:278882 total:278882
> min:283269 max:283269 total:283269
> min:281204 max:281204 total:281204
>
> After this patch set:
>
> min:280580 max:280580 total:280580
> min:290514 max:290514 total:290514
> min:291006 max:291006 total:291006
> min:290352 max:290352 total:290352
> min:294582 max:294582 total:294582
> min:293075 max:293075 total:293075
> measurement
> min:295613 max:295613 total:295613
> min:294070 max:294070 total:294070
> min:293193 max:293193 total:293193
> min:291631 max:291631 total:291631
> min:295278 max:295278 total:295278
> min:293782 max:293782 total:293782
> min:290361 max:290361 total:290361
> min:294517 max:294517 total:294517
> min:293750 max:293750 total:293750
> min:293572 max:293572 total:293572
> min:295239 max:295239 total:295239
> min:292932 max:292932 total:292932
> min:293319 max:293319 total:293319
> min:294954 max:294954 total:294954
>
> This was a Completely Unscientific test but seems to show there were arou=
nd 5-10% gains on ops per second.
>
> [1]: mmap1_process does mmap and munmap in a loop. I didn't bother testin=
g multithreading cases.
> [2]: https://lore.kernel.org/all/87o766iehy.fsf@mail.lhotse/
> Link: https://lore.kernel.org/all/202408041602.caa0372-oliver.sang@intel.=
com/
>
> Pedro Falcato (7):
>   mm: Move can_modify_vma to mm/internal.h
>   mm/munmap: Replace can_modify_mm with can_modify_vma
>   mm/mprotect: Replace can_modify_mm with can_modify_vma
>   mm/mremap: Replace can_modify_mm with can_modify_vma
>   mseal: Fix is_madv_discard()
>   mseal: Replace can_modify_mm_madv with a vma variant
>   mm: Remove can_modify_mm()
>
>  mm/internal.h | 30 ++++++++++++++++------
>  mm/madvise.c  | 13 +++-------
>  mm/mmap.c     | 36 ++++++++++-----------------
>  mm/mprotect.c | 12 +++------
>  mm/mremap.c   | 33 ++++++------------------
>  mm/mseal.c    | 69 +++++++++++----------------------------------------
>  6 files changed, 63 insertions(+), 130 deletions(-)
>
> --
> 2.46.0
>

