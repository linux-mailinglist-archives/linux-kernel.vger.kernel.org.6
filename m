Return-Path: <linux-kernel+bounces-527011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97705A4062C
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 09:05:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AEB2167440
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 08:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9C6B201039;
	Sat, 22 Feb 2025 08:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZgHFdpRX"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B54B7494
	for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 08:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740211386; cv=none; b=JzkkOaXPFYyxVKKtCfdoPqpykB6UWeBXbmgzGZ54SlZLvNAmjNdY1kk40gsNlplKhhhGExzEehXohy9YdS9fNiJOtM+jEpr6gnSYWz3PenL8hWB4EhONJnaWQ1F3Htpo4XtzdGmgtljNteuaY49aCiHr86RsPlpQkbPui/YgZIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740211386; c=relaxed/simple;
	bh=Avb7lJtPpTAji95YMNWrnHq3HhdeIOuJR9u3vd98Kk4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u2BMdfI8B6l7hbzC5Q4IMnnqub2atvptCgbk5lxuRgmPrFfTRmHY7Qy4Wnfx8ojcS2ziU3EojE9/jPh5Jg1IYJkADuEQoLJor+7+IQkmck2ebwE+RaLcrcjAous4WVGHBRtMGGjDVSuFWN3hHO0BJlZuWOUAyvEHHMJ1DIjLzZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZgHFdpRX; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5461cb12e39so2673656e87.2
        for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 00:03:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740211382; x=1740816182; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Os2fsuEkFh0JKJmUAnJvJ3YM3Zu/tIQHYWk9O1cYrw=;
        b=ZgHFdpRXSL0CjwHpleDfrsF0fD87cOD5SUpDNkpgR7w+8zYTUragSO4Ruuod2MUzYk
         lZ0ZA+/96HlbTxmvZxDjm8n8pTvIlXxIGxOHafIN+lKPrlt0wowZXDDYiu8tl7B14y0x
         22IChnJZV2sIom+tHjHz0tXZH445QEDArZEkRfBmW3tP9qWq8ZL5rk9/Fd4JY4eb53A7
         3t3y0QtrBX/Fb77MGdfgkLDtFuXGwdiqJmKUyM/qMLfEZHyYA5m6GAqsTUu0+PpDF6Gx
         ThCjnkQWl7mNBKZAbwySTnZjIbx4nlGInUOaQ9J5XweIBSosh93Aq0Zi+N4ERsiUYtJO
         mUtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740211382; x=1740816182;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Os2fsuEkFh0JKJmUAnJvJ3YM3Zu/tIQHYWk9O1cYrw=;
        b=bbmXENiHsC+NQyVXFnTm3XHbajoM0b7WlzWnGvSjZ31A+4+qS5QrdFp/Zw8HoK4jIH
         IclCnHejyA2cM7SRkJPK3c+sKTQaKzeLmPsGnztzbtjd4WVy1X9zJd14WQkuTxYDSw8V
         1bJQ87qAkZDWabnxfneP3RQJt4xWF7X6WIJ+phikpopZb9Oix9TyvZbOHyJSs9q61POb
         u9LxLe+ZlSTZjbFDv65dOlHroBYaMOu4VQKk1v1nsvpfSkYLE5hcQLNIhc9EMupjc0mz
         TJ72n+EoOJ5zF4py6KHcVO4xAm6+M4K7G6UkpXWcv9y3sttakJCclk1nh/akt287zu2k
         lSIg==
X-Forwarded-Encrypted: i=1; AJvYcCWux3rAIYsDOV0/uAGq3zz1R5mysrLNl5koJiPPcufQhVMEhvJ1j33r+mYkDVkeIQdTkfMFrIqEw/XKTPU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLgo67PG3WpKk1wvMy1w+qY6Yp9njInbMv9uoLbhQbCR+g7xCq
	19Z7o2VpRnqnYchYR13qzyBha8YNAjj3A65Qdc+qey7ygnvlTvJYns3BEleWiq+iPhbfAOKZPcv
	mFt17N2iehAQeHaVtlTUpgoAKC48=
X-Gm-Gg: ASbGncvYB8ZqpI8ch8rj5Zlb2njnOnWZ3khDSN9WAewPba6wRELdP/LfWHZtS6q90PP
	CRFZav0evBVA5NgwehbVkbN9R12XVLJDt4oCIhwfhJDDAlb07h9g2tcBNOS5fGbsZVCTCxnGddv
	wo0xzhsK4=
X-Google-Smtp-Source: AGHT+IFgo1h543qi0eAUe4bvaNCKelQB3okCfU4mFxeG5O+5Njw4vnQ4Au9r03h5Z157IMHeOXvZ80NjwuqpuCKzfWc=
X-Received: by 2002:a05:6512:238a:b0:545:ea9:1a1e with SMTP id
 2adb3069b0e04-54838ef5c21mr2474485e87.26.1740211382078; Sat, 22 Feb 2025
 00:03:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250222024617.2790609-1-mawupeng1@huawei.com>
 <CAMgjq7AfZnwGAHoyCEhO5p2km-gPLk65WLL+2vO1i8hQDaTy+A@mail.gmail.com> <a868e635-a86e-4dd7-8bae-c6ca94a2dc09@huawei.com>
In-Reply-To: <a868e635-a86e-4dd7-8bae-c6ca94a2dc09@huawei.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Sat, 22 Feb 2025 16:02:45 +0800
X-Gm-Features: AWEUYZnLGbycxuCxyOi4UGegDEqKEvwp222_cZnWlGFTsG4Dcgo766zj7tWUEkg
Message-ID: <CAMgjq7C7hguzq3DmR3s7=3LNGeaCC8qdmiQvLCZrdkB86=BFFw@mail.gmail.com>
Subject: Re: [PATCH] mm: swap: Avoid infinite loop if no valid swap entry
 found during do_swap_page
To: mawupeng <mawupeng1@huawei.com>
Cc: akpm@linux-foundation.org, david@redhat.com, ryan.roberts@arm.com, 
	chrisl@kernel.org, huang.ying.caritas@gmail.com, schatzberg.dan@gmail.com, 
	baohua@kernel.org, hanchuanhua@oppo.com, willy@infradead.org, 
	gaoxu2@honor.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	nphamcs@gmail.com, yosryahmed@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 22, 2025 at 3:41=E2=80=AFPM mawupeng <mawupeng1@huawei.com> wro=
te:
> On 2025/2/22 15:33, Kairui Song wrote:
> > On Sat, Feb 22, 2025 at 10:56=E2=80=AFAM Wupeng Ma <mawupeng1@huawei.co=
m> wrote:
> >>
> >> From: Ma Wupeng <mawupeng1@huawei.com>
> >>
> >> During our test, infinite loop is produced during #PF will lead to inf=
inite
> >> error log as follow:
> >>
> >>    get_swap_device: Bad swap file entry 114000000
> >>
> >> Digging into the source, we found that the swap entry is invalid due t=
o
> >> unknown reason, and this lead to invalid swap_info_struct. Excessive l=
og
> >
> > Hi Wupeng,
> >
> > What is the kernel version you are using? If it's another bug causing
> > this invalid swap entry, we should fix that bug instead, not
> > workaround it.
> >
> > This looks kind of similar to another PATCH & Bug report, corrupted
> > page table or swap entry:
> > https://lore.kernel.org/linux-mm/e223b0e6ba2f4924984b1917cc717bd5@honor=
.com/
> >
> > Might be the same kernel bug? Gaoxu mentioned the bug was observed on
> > Kernel 6.6.30 (android version), and neither of these two workarounds
> > will fix it completely, the invalid value could cause many other
> > issues too. We definitely need to find out the root cause.
>
> We are having this problem in linux-v5.10, since the log is lost and swap
> is not enabled in this machines, maybe memory corrupted in the pt.

Thanks for the info, that's very strange. Since you didn't even enable
SWAP, it must be something else corrupted the page table I think

> >
> >> printing can fill up the prioritized log space, leading to the purging=
 of
> >> originally valid logs and hindering problem troubleshooting. To make t=
his
> >> more robust, kill this task.
> >>
> >> Signed-off-by: Ma Wupeng <mawupeng1@huawei.com>
> >> ---
> >>  include/linux/swap.h | 1 +
> >>  mm/memory.c          | 9 ++++++++-
> >>  mm/swapfile.c        | 2 +-
> >>  3 files changed, 10 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/include/linux/swap.h b/include/linux/swap.h
> >> index b13b72645db3..0fa39cf66bc4 100644
> >> --- a/include/linux/swap.h
> >> +++ b/include/linux/swap.h
> >> @@ -508,6 +508,7 @@ struct backing_dev_info;
> >>  extern int init_swap_address_space(unsigned int type, unsigned long n=
r_pages);
> >>  extern void exit_swap_address_space(unsigned int type);
> >>  extern struct swap_info_struct *get_swap_device(swp_entry_t entry);
> >> +struct swap_info_struct *_swap_info_get(swp_entry_t entry);
> >>  sector_t swap_folio_sector(struct folio *folio);
> >>
> >>  static inline void put_swap_device(struct swap_info_struct *si)
> >> diff --git a/mm/memory.c b/mm/memory.c
> >> index b4d3d4893267..2d36e5a644d1 100644
> >> --- a/mm/memory.c
> >> +++ b/mm/memory.c
> >> @@ -4365,8 +4365,15 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> >>
> >>         /* Prevent swapoff from happening to us. */
> >>         si =3D get_swap_device(entry);
> >> -       if (unlikely(!si))
> >> +       if (unlikely(!si)) {
> >> +               if (unlikely(!_swap_info_get(entry)))
> >> +                       /*
> >> +                        * return VM_FAULT_SIGBUS for invalid swap ent=
ry to
> >> +                        * avoid infinite #PF.
> >> +                        */
> >> +                       ret =3D VM_FAULT_SIGBUS;
> >
> > This could lead to VM_FAULT_SIGBUS on swapoff. After swapoff
> > get_swap_device will return NULL.
>
> If swap is off, All swap pages should be swap in as expected, so
> such entry can not trigger do_swap_page?

do_swap_page may get blocked due to some random reason, and then a
concurrent swapoff could swap in the entry and disable the device.
Very unlikely to trigger but in theory possible.

