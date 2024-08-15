Return-Path: <linux-kernel+bounces-288610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24D4A953C63
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 23:11:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C705E2823F9
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 21:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D84214B960;
	Thu, 15 Aug 2024 21:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bWPY312p"
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D498249F
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 21:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723756288; cv=none; b=OA7gEeUC5ildpm8OJvRHjHohp/LDE1tAXVjN/IGX0QEsuMO5Y/0VNszuqQM2qpMyPekTjEdfRE5DpaJpD5ItU3O4/rVhhTgOjKkof8FP1/hE96JoINnDKsav6F2uuf7M1tz/TyvMlaIvHN1pSx8zNo4xuonZ4U4n8m0+LOoSrjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723756288; c=relaxed/simple;
	bh=F5jZX3W4WtDlnnh2VRydovhKfM6uSIVgLEnkcnUBD+Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LvD2DTWlXVXcZWx2nAdFUY7f2VGwgjDt6YSAPcpgta5XgBHskXyyTlDHZubwkqnYFcGTRiRe/Z5Kmkhcyzamq2Xx+AWtQNzJsiN3ydC/QN2JVGZ4EpLRbP82m7GtDE2qLrxctfv7cXYo1dHvCMJIk9n2YCrg6EOqtWT/jGwJJ3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=bWPY312p; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5d5b22f97b7so1075367eaf.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 14:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1723756286; x=1724361086; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qdKF/gkZMwPX+H+11QhhQU4+WryLhYLHGOpnlPXdpLQ=;
        b=bWPY312pw9Aamj+tmGOb8RCTYk9ABh6VvgmPkWPdAzFZSiy0CqxvjzAJopiNP7rzYH
         XTgAByPDDz/yaEqGeHcVb1feRw8Nh3Xp/e5e/nfqx3RchpADPfHpHbhaD0uFk3KAM4/W
         3K9PLYzktYzRs61Vk0zyk8TI7KRR6y0fqGIMk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723756286; x=1724361086;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qdKF/gkZMwPX+H+11QhhQU4+WryLhYLHGOpnlPXdpLQ=;
        b=UQ9L0iYUUwj2x1a2JlWK9Zk55G1bHAjAHGmgzUpR4tqt6yg/Pe/sD7nK3Mmug72zBw
         U7HvrKFhop3L/lUX4feZvlzKJWxgjHsEXZDFIrlngxOCvFAtTKp5/WqO7s3jL4hD8iua
         CO/MHByb4IRjU4Jgx+ow1FV9IaG3WdLDG6J7plgi3yPdD8m82yGyOK+i6eIrgIPtlzBp
         AgcXXMGr/gqBS7SCLWdc9bXgK10zLPkqiIn5XP3u+8/M6/ex/dv2quumN/tR9Y1n8RJL
         vd0elzLuFUa5D5zZwfstoAUJrtiAOMuZhapEEHr+w31G513wJbDGYQH9zkROqSSmdG48
         hYRQ==
X-Forwarded-Encrypted: i=1; AJvYcCW71byMNAzCzCQIXI9E5Mqtd5T5NV6u8ltgESqQVlPh8B76sNOQf9NW5UavW7N6jIX4PGfWFS7AgOYJxI5lWO78dBlchDMGzWdcpCwY
X-Gm-Message-State: AOJu0Yz5ET86yBqb6ceRp2XrGpbMqlo8o9+futFF/bq/L7w8HrRH4j7S
	+b+9S+vW05QuM8ZMv5CU+w24bGPrpmGkyh1EEY4TgrKD6hDL7SjC11eKTCWJPP2Wo7v+Lt6MWv8
	aC7yDtpRLGF/UXwnljSdg22wnJfYdC/WlFkMj
X-Google-Smtp-Source: AGHT+IFJOBm7a/M1FkC0dbPS9gMvxIVi6WTkmF36w+02qnIHiiF8/SEj3MkUTd6HNVqNIRqvot9m+KwRu2bsx92JY3I=
X-Received: by 2002:a05:6870:a489:b0:268:acce:455f with SMTP id
 586e51a60fabf-2701c519f8amr834141fac.32.1723756285989; Thu, 15 Aug 2024
 14:11:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240807211309.2729719-1-pedro.falcato@gmail.com>
In-Reply-To: <20240807211309.2729719-1-pedro.falcato@gmail.com>
From: Jeff Xu <jeffxu@chromium.org>
Date: Thu, 15 Aug 2024 14:11:14 -0700
Message-ID: <CABi2SkXMs0uhYTC4XhYPrLGO5z=1MnxQB2OJ5a-Jtg32Fh21aQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] mm: Optimize mseal checks
To: Pedro Falcato <pedro.falcato@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, oliver.sang@intel.com, 
	torvalds@linux-foundation.org, jeffxu@google.com, 
	Michael Ellerman <mpe@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 7, 2024 at 2:13=E2=80=AFPM Pedro Falcato <pedro.falcato@gmail.c=
om> wrote:
>
> [based on mm-unstable, 98808d08]
>
> Optimize mseal checks by removing the separate can_modify_mm() step, and
> just doing checks on the individual vmas, when various operations are
> themselves iterating through the tree. This provides a nice speedup and r=
estores
> performance parity with pre-mseal[3].
>
> This series also depends on (and will eventually very slightly conflict w=
ith)
> the powerpc series that removes arch_unmap[2].
>
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
It is likely true that the test " was Completely Unscientific".
Without the necessary information, such as stddiv, stderr, and large
enough sample size, it is impossible to prove the test can reasonably
measure the impact of the patch. Unless you add that information, it
would be prudent to omit this test data from the cover letter.

> Oliver performed his own tests and showed[3] a similar ~5% gain in them.
>
> [1]: mmap1_process does mmap and munmap in a loop. I didn't bother testin=
g multithreading cases.
> [2]: https://lore.kernel.org/all/20240807124103.85644-1-mpe@ellerman.id.a=
u/
> [3]: https://lore.kernel.org/all/ZrMMJfe9aXSWxJz6@xsang-OptiPlex-9020/
> Link: https://lore.kernel.org/all/202408041602.caa0372-oliver.sang@intel.=
com/
>
> Changes in v2:
>  - Rebased on top of mm-unstable
>  - Removed a superfluous check in mremap (Jeff Xu)
Thanks for taking this suggestion. When I posted that comment, I was
studying the mremap change in V2, I'm not 100% sure if it is possible,
or reasonable the code is written that way (even before mseal is
added.)

This week, I wrote more self-tests [1] for the mremap to reason about
the code handling of mremap across the VMA boundary, as part of an
effort to test your patch.

During the process I realized that we can probably improve the mremap
code further, even without considering the sealing,  so I made a refactor
patch for mremap. [2].

Testing is 90% of the time, if not more, when I modify the kernel
code. If you agree with my refactor on mremap, please feel free to
rebase  or include it as part of your patch series.

Thanks
-Jeff

[1] https://lore.kernel.org/linux-mm/20240814071424.2655666-2-jeffxu@chromi=
um.org/
[2] https://lore.kernel.org/linux-mm/20240814071424.2655666-3-jeffxu@chromi=
um.org/


> Pedro Falcato (6):
>   mm: Move can_modify_vma to mm/internal.h
>   mm/munmap: Replace can_modify_mm with can_modify_vma
>   mm/mprotect: Replace can_modify_mm with can_modify_vma
>   mm/mremap: Replace can_modify_mm with can_modify_vma
>   mseal: Replace can_modify_mm_madv with a vma variant
>   mm: Remove can_modify_mm()
>
>  mm/internal.h | 30 ++++++++++++++++++++--------
>  mm/madvise.c  | 13 +++---------
>  mm/mmap.c     | 13 +-----------
>  mm/mprotect.c | 12 +++--------
>  mm/mremap.c   | 30 ++++------------------------
>  mm/mseal.c    | 55 ++++-----------------------------------------------
>  mm/vma.c      | 23 ++++++++++-----------
>  7 files changed, 49 insertions(+), 127 deletions(-)
>
>
> base-commit: 98808d08fc0f78ee638e0c0a88020fbbaf581ec6
> --
> 2.46.0
>
>

