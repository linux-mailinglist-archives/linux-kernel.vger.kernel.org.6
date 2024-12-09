Return-Path: <linux-kernel+bounces-437738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21F0E9E97D7
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 14:53:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53B062834C7
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 13:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 903DC1A239D;
	Mon,  9 Dec 2024 13:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SSDkudu4"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082481581F0
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 13:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733752377; cv=none; b=WJoiE2AXZQiZBhu89SKkst++uU2Njo52pm4fS0Dljvpq2KCe+UhByooxygjLIxkoOyJD265rCJ9/uBQLuZVzqCbt8a1oUvusnRBz5HckArlFPLmaG9Dhetlzjm2zWbs3j5GEdlwNxhDmh1Gmhp3eAQTBaN8AuXX2OaJFcuPh37c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733752377; c=relaxed/simple;
	bh=traxtrByGG2l/R38xLuW4vG4Is4h2oE95jRlaRKLDOY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CFkWQczU7A5S+tLaFVGYs6MJ/FdJ3bhrzvbc3hB7fv9jdCxYFnJCmpkuQf4RexZRPdc+95dung9kQ0FH4/arkej6F4dm0GaKiOxGLjHzIwsXANmVAy2w+gSRtab7tbLiLjEouzFamv6TUcQG20yozeAurJqhe3zaUUdAe/cxKj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SSDkudu4; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5d3e638e1b4so8689a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 05:52:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733752374; x=1734357174; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Z5yTTd8HuCAJ0Vf7H0LL0ubjQfroLQI04Z2LMz1eyg=;
        b=SSDkudu4HcY9mptcChhm32MvnvTiMytq/l2eUzQdWQHZr2qeB+leSW3TizQPFASt4v
         O6HzauUSN+S/KxRp3I0gyWuKpqmAqLObtuZWqq9pO1NLtOz7s7scOz/ZKYKRMpouhDJP
         MrOOEnycW1usiBkRLHe7KNL7KWwvPXfcQ/k7f22EtIHrL/PeUS7m7Hlz4yCvB052+mka
         JQ/vClWPcrFIR/RrS5CcEPGE+K4lH1v/Kc4SXLFgbZNitd8878YSGGdXSPNLuy8F+YAe
         BBKrEVLG8FZSM793y7KNJAgB7GUpjHNBbG6HiGFJ5u3yqUNkutwBYGgb/KH2RkuhFASK
         9tjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733752374; x=1734357174;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Z5yTTd8HuCAJ0Vf7H0LL0ubjQfroLQI04Z2LMz1eyg=;
        b=uRF4D2PWq0+BF/eo9S8SUS0YrSspC2prJiUS68eIVw50Kj697Uvo4ggF3kAXO95+UC
         1nCtHdok6fDDB4vb+SdA0t3Gu7Vdc7Hq4BtxJCL9McHa7Iuny4ZBcb2lLkeoDHXNJOue
         7Jqj5wA06WzMD8xPdt65nwBGtAuENU/o0QuYoe+D8in5/07+NuYbdUz8Aiu4SX0uzRkU
         vOMrtqj4bG9tQF7js5S7+o3DUTscawlYpXCp932x7H4/VwgQr7Ab8rQe8wfMDNincNO4
         n0dUDVDD1JFudIJl11BreMIhnDDsywvUj7odCCCwty18ainlYJRHUqZDHC9BBcHOsEUZ
         lZxw==
X-Forwarded-Encrypted: i=1; AJvYcCX77dR4kGA0+qTExvUeZvQ8bLGRwEl5YOZfCuoAZz7p6D+soa7fTWD6+fnizV82+1Ujkm+JMi9OxDqesIM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZ8fHnTc9+XY+L/dQK+Q3/yZgm4tVT40iK5nhC6UA/Lq/tEi4W
	2DMvPp+CR6lwCjCIJjNeDmPSeudaRZLOrU49OU8Cx4fKzaUZ2sknmC0Uk8oz2Vhcca4Oqu6/zmb
	TvFIR3HspPvisXB814O4EoG/Zd2UKvq1Rldb3
X-Gm-Gg: ASbGncuo8za98lEE5vrKWeK+qt+U3EYoWJUzla0dnVTEMuHFuTWQihE/Vq8eKzA5msB
	K2/gQ0KeIuwKNnzGZxu8LzGEIeUZLn1Q9SQFhBNgNNMUxBIlZICvmqYpwajs=
X-Google-Smtp-Source: AGHT+IGmufIL/UdCaASQOs4rSgjZXKbwXZiwHoGPg+len/47cPa12dHDcs3iVzxewCu9YCUkwdiWYtnDWgoLQ+0PAwg=
X-Received: by 2002:a05:6402:1346:b0:5d0:b20c:205c with SMTP id
 4fb4d7f45d1cf-5d3dd9dd1a9mr138376a12.5.1733752373747; Mon, 09 Dec 2024
 05:52:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6756d273.050a0220.2477f.003d.GAE@google.com> <1b8b5d54-d667-4ca9-b831-bee4b4e74c40@lucifer.local>
In-Reply-To: <1b8b5d54-d667-4ca9-b831-bee4b4e74c40@lucifer.local>
From: Jann Horn <jannh@google.com>
Date: Mon, 9 Dec 2024 14:52:17 +0100
Message-ID: <CAG48ez1d60kH1W8uVvOh-+Vs8Jz5TX1a8LD+mh_O8_3HFHAx6w@mail.gmail.com>
Subject: Re: [syzbot] [mm?] general protection fault in find_mergeable_anon_vma
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: syzbot <syzbot+2d788f4f7cb660dac4b7@syzkaller.appspotmail.com>, 
	Liam.Howlett@oracle.com, akpm@linux-foundation.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	syzkaller-bugs@googlegroups.com, vbabka@suse.cz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 9, 2024 at 1:53=E2=80=AFPM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> On Mon, Dec 09, 2024 at 03:20:19AM -0800, syzbot wrote:
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    feffde684ac2 Merge tag 'for-6.13-rc1-tag' of git://git.=
ker..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=3D17f85fc0580=
000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D50c7a61469c=
e77e7
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3D2d788f4f7cb66=
0dac4b7
> > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for D=
ebian) 2.40
> >
> > Unfortunately, I don't have any reproducer for this issue yet.
>
> Points to this being racey.
>
> >
> > Downloadable assets:
> > disk image (non-bootable): https://storage.googleapis.com/syzbot-assets=
/7feb34a89c2a/non_bootable_disk-feffde68.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/6135c7297e8e/vmli=
nux-feffde68.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/6c154fdcc9cb=
/bzImage-feffde68.xz
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the co=
mmit:
> > Reported-by: syzbot+2d788f4f7cb660dac4b7@syzkaller.appspotmail.com
> >
> > Oops: general protection fault, probably for non-canonical address 0xdf=
fffc0000000080: 0000 [#1] PREEMPT SMP KASAN NOPTI
> > KASAN: null-ptr-deref in range [0x0000000000000400-0x0000000000000407]
>
> This doesn't make a huge amount of sense to me, the VMA is not 0x400 (1,0=
24)
> bytes in size... and the actual faulting offset seems to be 0xdffffc00000=
00080
> which is 0x80 off from some KASAN-specified value?
>
> This would be vma->vm_file. But that also doesn't really make any sense.
>
> But I wonder...
>
> I see in the report at [0] that there's a failure injection in vm_area_du=
p() on
> fork:
>
> [   73.842623][ T5318]  ? kmem_cache_alloc_noprof+0x48/0x380
> [   73.844725][ T5318]  ? __pfx___might_resched+0x10/0x10
> [   73.846687][ T5318]  should_fail_ex+0x3b0/0x4e0
> [   73.848496][ T5318]  should_failslab+0xac/0x100
> [   73.850232][ T5318]  ? vm_area_dup+0x27/0x290
> [   73.852017][ T5318]  kmem_cache_alloc_noprof+0x70/0x380
> [   73.854011][ T5318]  vm_area_dup+0x27/0x290
> [   73.855771][ T5318]  copy_mm+0xc1d/0x1f90
>
> I also see in the fork logic we have the following code on error path:
>
>         mas_set_range(&vmi.mas, mpnt->vm_start, mpnt->vm_end - 1);
>         mas_store(&vmi.mas, XA_ZERO_ENTRY);
>
> And XA_ZERO_ENTRY is 0x406.
>
> Now if _somehow_ the VMA was being looked up without XA_ZERO_ENTRY being
> properly accounted for, this might explain it, and why all the !vma logic=
 would
> be bypassed.

You fixed another issue in this area a month ago, right?
(https://project-zero.issues.chromium.org/373391951,
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3Df64e67e5d3a45a4a04286c47afade4b518acd47b,
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3D985da552a98e27096444508ce5d853244019111f)

And we came to the conclusion that MMs whose VMAs have not been
completely copied and might have XA_ZERO_ENTRY entries left should
never become visible to anything other than the MM teardown code?

> > RIP: 0010:reusable_anon_vma mm/vma.c:1837 [inline]
> > RIP: 0010:find_mergeable_anon_vma+0x1e4/0x8f0 mm/vma.c:1863
> > Code: 00 00 00 00 fc ff df 41 80 3c 06 00 74 08 4c 89 ff e8 10 39 10 00=
 4d 8b 37 4d 89 ec 49 c1 ec 03 48 b8 00 00 00 00 00 fc ff df <41> 80 3c 04 =
00 74 08 4c 89 ef e8 ed 38 10 00 49 8b 5d 00 4c 89 f7
> > RSP: 0018:ffffc9000d3df500 EFLAGS: 00010203
> > RAX: dffffc0000000000 RBX: ffffc9000d3df540 RCX: ffff88801cf80000
> > RDX: 0000000000000000 RSI: ffffffff900062a0 RDI: 0000000000000000
> > RBP: ffffc9000d3df610 R08: 0000000000000005 R09: ffffffff8bc6b642
> > R10: 0000000000000003 R11: ffff88801cf80000 R12: 0000000000000080
> > R13: 0000000000000406 R14: 0000000021000000 R15: ffff8880120d4ca0
> > FS:  00007f137f7e86c0(0000) GS:ffff88801fc00000(0000) knlGS:00000000000=
00000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 0000000020000140 CR3: 0000000040256000 CR4: 0000000000352ef0
> > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > Call Trace:
> >  <TASK>
> >  __anon_vma_prepare+0xd9/0x4a0 mm/rmap.c:199
> >  anon_vma_prepare include/linux/rmap.h:164 [inline]
> >  uprobe_write_opcode+0x1a95/0x2d80 kernel/events/uprobes.c:516
>
> Here we find the VMA via:
>
>         old_page =3D get_user_page_vma_remote(mm, vaddr, gup_flags, &vma)=
;
>
> Actually one unfortunate thing here is... ugh god.
>
> I think there might be a bug in get_user_page_vma_remote()...
>
> I will check in more detail but I don't see anything that will prevent th=
e
> mmap lock from being dropped before we perform the
> vma_lookup()... FOLL_UNLOCKABLE will be set due to the &local_lock
> shenanigans in get_user_pages_remote(), and if we get a page after a
> dropped lock and try to vma_lookup() we could be racing... :/

Hm, aren't we holding an mmap_write_lock() across the whole operation
in register_for_each_vma()? I don't think FOLL_UNLOCKABLE will be set,
the call from get_user_pages_remote() to is_valid_gup_args() passes
the caller's "locked" parameter, not &local_locked.

