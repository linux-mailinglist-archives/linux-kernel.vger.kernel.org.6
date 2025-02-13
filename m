Return-Path: <linux-kernel+bounces-514069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58188A35201
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 00:07:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C43093AAAEF
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 23:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1433275401;
	Thu, 13 Feb 2025 23:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ap/H7Op9"
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FFC32753F3
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 23:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739488053; cv=none; b=CIXnXX+H+ZfLR4PIfbTJJ826F06BDIdMad7aGgFFevYyLiOcztFJMiE1NYIzziGQ/i9ENxiJx62u3O+uzgv8xb4fZsSiAmnrH5df3/Z+U1wfnurQhNzSsIUUcGS0Dwzp1ElEquf5E9+2hAN4NMjejwXenWrdmgE5sot6gG0Kszw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739488053; c=relaxed/simple;
	bh=60XrE/J6wIlwuNawEb259r4V2dGxlH4yUnxGaEbYWNs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c1joJswAxzKN/NhxAJM3P9GeGnT2G0SokcYMoMSFixF5T3lIBppaNvaT+FYqWEwE3ZXyX1FLVxe00DaY+yBqiG8tlgPTrKr0ZyKBv+sukLo0/dbzsY92AqVJykkH1+3Sl2QpJxZI2rk/YwoHmcQZYestT8GDV+EPEMSKvbwfU4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ap/H7Op9; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-868f322b8dfso406086241.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 15:07:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739488050; x=1740092850; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ckcD7kf8hbhTKxgQjWiNmXpiRbxO5jasuP7uxcmPy2A=;
        b=ap/H7Op9q5FjWIhbvxHhi7EtPPpDtoI4L34LlFn+r2kdEyBriKnUXK7iasGF75iE7O
         E2MhSmn0ToVcoava3X8YO+aQmB9sIvaSBSRxGkaj+Pvr7HJSe6c0UQKwc9yefMc3FKzp
         bcB+6NgO50jb0AlEz0lJ8DXVfqbyZ1uDX3iDk9e7BrIXjvOV9EogRMYfaKMXgqf+Lu8/
         R4LQWKglwKHIx94ZYwU8NGJ/8RsxkfPubaJ0a/ArPeuZsbgjSIN70X6N5K449Ncrci+E
         SJj7vX3TAn18Ow1b6m1VfdCq+RbLYvbTVf+43tYcwkl25fjjcYFFxuhVGvqRmbfIlZGw
         Opmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739488050; x=1740092850;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ckcD7kf8hbhTKxgQjWiNmXpiRbxO5jasuP7uxcmPy2A=;
        b=qO13XDID5Gre/+74UQ0g8yIWXgyLyYCVmoOoXXQDa7QaKhPtQsGIuAvnfZnlBxew5J
         n2EOsULM4KG4RDOZL0NyUzdWVMm4oh70XFegu2I93dZ6GKnWjJVksXmXXmh+E9a26bXJ
         IaBKKAfsL2iuRi9zlbEMO5D6ES4jeOUz/cX3oiirDfXoeGf6F3f1bJSfA01f/owH1+Dw
         BvblhJNzpyHnPYJp6J9DB4nyUjMd2K9AcUkIqB0Nkb1x7XI372+urTiaaU6NkMiu5fOr
         W5ro4G8cBERotaz9U8IMU+FSEp2o6ZbUHSEz+SEeQ0yO5m53hkAjIbtJbR+ArQqQA5Ov
         rXUA==
X-Forwarded-Encrypted: i=1; AJvYcCVlLsEenlHT2m1pg8PfXlhmYBNA7L2JLZPMZ7ZyV5pJUlbBtq7A9OdmtYXaRon01poG9/ALNzMRxoFLv+M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3KEj/JSTLJjLloYT+F8YrgQzeenVhCOXn9VFU4+5qEZE9dbx7
	eEtTvZBn8rxhEmMP1pbmSVkzy97tdabryGV0P/NDNpzAlOcIvgVYw9ddJvQ2K8xVBZxlB8dPANf
	CKNhe/K90H4vRMWFskxgqqtj/p6U=
X-Gm-Gg: ASbGncsJFTjS2YSkNhdxm2iN4RhIA8RN4NFoKL99lgvqzAncsdj5OIv9UbBjjHmS2jJ
	X4hkNyaA1mel3WEMsUGXm8KGh5Fu5lUm3mC21cc71/86aLr9ns/GmlixizMhnjhoF2LlGgtV7
X-Google-Smtp-Source: AGHT+IGRs+BkoBsAvtouPrFHW7HnicJHJ8jpxEWAuwpW1xi8ZW2LJ23bl+SEP/M/9S4ga9OTOT4n8KwOARop3H3a0E0=
X-Received: by 2002:a05:6102:d86:b0:4b2:cdf4:81f7 with SMTP id
 ada2fe7eead31-4bc054487bcmr4169348137.5.1739488049976; Thu, 13 Feb 2025
 15:07:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <44655569e3a1419f800952004f07e714@honor.com> <CAKEwX=NgTfnU8EzpPmC_h5mY1UePAPR6_W2rrBNGs3EZA96FsQ@mail.gmail.com>
 <a67e670777474ae2ad1a29707f00ea3f@honor.com>
In-Reply-To: <a67e670777474ae2ad1a29707f00ea3f@honor.com>
From: Barry Song <21cnbao@gmail.com>
Date: Fri, 14 Feb 2025 12:07:18 +1300
X-Gm-Features: AWEUYZlY7gtO0rr19Ytfl3Ld6Hz4B8ESkZMQk0sLn_tD-hLaqvoDUM53FTUDFqU
Message-ID: <CAGsJ_4zFrBNoJhedN2AiCAeHmKPk513Vfn-gmEd2wsqXTRhY4A@mail.gmail.com>
Subject: Re: [PATCH] mm: Fix possible NULL pointer dereference in __swap_duplicate
To: gaoxu <gaoxu2@honor.com>
Cc: Nhat Pham <nphamcs@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	"linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	yipengxiang <yipengxiang@honor.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 13, 2025 at 9:52=E2=80=AFPM gaoxu <gaoxu2@honor.com> wrote:
>
> >
> > On Tue, Feb 11, 2025 at 7:14=E2=80=AFPM gaoxu <gaoxu2@honor.com> wrote:
> > >
> > > swp_swap_info() may return null; it is necessary to check the return
> > > value to avoid NULL pointer dereference. The code for other calls to
> > > swp_swap_info() includes checks, and __swap_duplicate() should also
> > > include checks.
> > >
> > > The reason why swp_swap_info() returns NULL is unclear; it may be due
> > > to CPU cache issues or DDR bit flips. The probability of this issue i=
s
> > > very small, and the stack info we encountered is as follows=EF=BC=9A
> > > Unable to handle kernel NULL pointer dereference at virtual address
> > > 0000000000000058
> > > [RB/E]rb_sreason_str_set: sreason_str set null_pointer Mem abort info=
:
> > >   ESR =3D 0x0000000096000005
> > >   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
> > >   SET =3D 0, FnV =3D 0
> > >   EA =3D 0, S1PTW =3D 0
> > >   FSC =3D 0x05: level 1 translation fault Data abort info:
> > >   ISV =3D 0, ISS =3D 0x00000005, ISS2 =3D 0x00000000
> > >   CM =3D 0, WnR =3D 0, TnD =3D 0, TagAccess =3D 0
> > >   GCS =3D 0, Overlay =3D 0, DirtyBit =3D 0, Xs =3D 0 user pgtable: 4k=
 pages,
> > > 39-bit VAs, pgdp=3D00000008a80e5000 [0000000000000058]
> > > pgd=3D0000000000000000, p4d=3D0000000000000000,
> > > pud=3D0000000000000000
> > > Internal error: Oops: 0000000096000005 [#1] PREEMPT SMP Skip md ftrac=
e
> > > buffer dump for: 0x1609e0 ...
> > > pc : swap_duplicate+0x44/0x164
> > > lr : copy_page_range+0x508/0x1e78
> > > sp : ffffffc0f2a699e0
> > > x29: ffffffc0f2a699e0 x28: ffffff8a5b28d388 x27: ffffff8b06603388
> > > x26: ffffffdf7291fe70 x25: 0000000000000006 x24: 0000000000100073
> > > x23: 00000000002d2d2f x22: 0000000000000008 x21: 0000000000000000
> > > x20: 00000000002d2d2f x19: 18000000002d2d2f x18: ffffffdf726faec0
> > > x17: 0000000000000000 x16: 0010000000000001 x15: 0040000000000001
> > > x14: 0400000000000001 x13: ff7ffffffffffb7f x12: ffeffffffffffbff
> > > x11: ffffff8a5c7e1898 x10: 0000000000000018 x9 : 0000000000000006
> > > x8 : 1800000000000000 x7 : 0000000000000000 x6 : ffffff8057c01f10
> > > x5 : 000000000000a318 x4 : 0000000000000000 x3 : 0000000000000000
> > > x2 : 0000006daf200000 x1 : 0000000000000001 x0 : 18000000002d2d2f Cal=
l
> > > trace:
> > >  swap_duplicate+0x44/0x164
> > >  copy_page_range+0x508/0x1e78
> > >  copy_process+0x1278/0x21cc
> > >  kernel_clone+0x90/0x438
> > >  __arm64_sys_clone+0x5c/0x8c
> > >  invoke_syscall+0x58/0x110
> > >  do_el0_svc+0x8c/0xe0
> > >  el0_svc+0x38/0x9c
> > >  el0t_64_sync_handler+0x44/0xec
> > >  el0t_64_sync+0x1a8/0x1ac
> > > Code: 9139c35a 71006f3f 54000568 f8797b55 (f9402ea8) ---[ end trace
> > > 0000000000000000 ]--- Kernel panic - not syncing: Oops: Fatal
> > > exception
> > > SMP: stopping secondary CPUs
> > >
> > > The patch seems to only provide a workaround, but there are no more
> > > effective software solutions to handle the bit flips problem. This
> > > path will change the issue from a system crash to a process exception=
,
> > > thereby reducing the impact on the entire machine.
> > >
> > > Signed-off-by: gao xu <gaoxu2@honor.com>
> >
> > Yeah this smells like a bug. A bit strange though - I have eyeballed th=
e code, and
> > we (should have?) locked the PTE before resolving it into the swap entr=
y format.
> > Which should have been enough to prevent the swap entry from being
> > unmapped and freed up. Which should have been enough to prevent swapoff=
...?
> >
> > (are you even doing concurrent swapoff?)
> No, the swapoff operation was not executed.
> >
> > Can you provide more context? What kernel version is this, what kind of
> > workload is this, any reproducer, etc.?
> kernel version is linux 6.6,  Android15 - linux6.6.30.
>
> The issues encountered by mobile users during usage.
> The system load should not be high, as there is no info related to low
> memory found in the logs.
> The probability of this issue occurring is very low and irregular.
> We cannot reproduce the problem during stress testing in the laboratory.
>
> I found someone reporting a similar issue on the web, see:
> https://lkml.indiana.edu/hypermail/linux/kernel/2406.0/02380.html
> https://forum.proxmox.com/threads/get_swap_device-bad-swap-file-entry.155=
581/
> https://forums.unraid.net/topic/145497-server-crashes-with-repeated-get_s=
wap_device-bad-swap-file-entry-3ffffffffffff/

It might be a non-swap entry mistakenly passed to swap functions. I remembe=
r
fixing a similar issue in the Android Common Kernel 6.6:

https://android.googlesource.com/kernel/common/+/119351fe20bc73b71c6

where a migration entry is mistakenly passed to swap APIs.

In any case, we need to identify and fix the actual bug.

>
>
>

Thanks
Barry

