Return-Path: <linux-kernel+bounces-440079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC4459EB86C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 18:37:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F742283E90
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 17:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB74E86359;
	Tue, 10 Dec 2024 17:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ywKXbqVq"
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C8C123ED70
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 17:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733852216; cv=none; b=qNOPSkaZTGoSiTiK0HKEoUXEz4iKCGs1Gkij4386ATxqToHwtoS3YD7PKxT3nld6ZMwfBgjLvEax1/4IZeEi78PAKWZWPK+EoZyctQNq9P/kNim+vODwBCjxgLlmfv41muJ0rWOkT1gPqr6Kmr0cq4EUiU9WrYuqHD70R/Zmink=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733852216; c=relaxed/simple;
	bh=YhhiMixGvVlLJwkePy9JlJsg+MFPw7Lv0z+GFGbxYIs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cSydRlBOkSPuLfMXDskjKwmyOev8A3N5lNQ3+5e8uFvTyd5DdO2Cwkw+r6RsdwR3Opq7RmY18TsVD1/dv3kr4Qx0bFg8jPNvJOuUHs1uTBHXK3WNphyxoUrqewYFnqgknkQzTwXVqLtUc+TujSVsPPEev/ERs78DPNgC1+7YlLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ywKXbqVq; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4674c22c4afso336801cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 09:36:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733852214; x=1734457014; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9hskfQXA4PE8awVm1of41udjAxAI9b55kiNR41gp9wU=;
        b=ywKXbqVqAEMJ7u/khDF2ZFBFXaKTJ7AieS5wgazXApvaxFP2ZBT+mHDl42LqYrdDuE
         +rC1n5soJ1QhC5IzlyNTp65vT/q5BJeUf2lzBBxdOIbd8vK3xbJKtuT9J6NbytjYkor3
         WFZcASdWM2xdbGIsYazCfAC0/s87JtjAiBOvLaapdFWEojo7ZkIy9rFeDNOMLxtnLstz
         xfRXePDw/JaehYL8G9BouYBgMi7z1zMdbq6Kn7pmiBPBHp8wMYw43VB2wSSM2d5chcIz
         UIxfk/dkSyr9dmT0FxWRDLEq4e7gMn2zzmtLgd2+IoCVCoDpWWiOddQyAzEdshfMvqlr
         ADNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733852214; x=1734457014;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9hskfQXA4PE8awVm1of41udjAxAI9b55kiNR41gp9wU=;
        b=TPgfLlCeQuqngt3HDFZswMWtZzQHDFye3i6ow9K+nEczy4y9Htwvdno273NVdJngHr
         KzOomXCpUhSYFSDS2Agh4K2jE3IuaVGkiv4iOfl8OrsXuk+WVhJ1kjfaKuBIwqwv7C4c
         QiR80pzNHSN82WJrJPQo5op9MPVpd/hwkR82EapBh0HEto2dFvGIB29Y2bSKGM1RGzPG
         aOlPiG8f4sipJWqQRQkEm3lepG1oviqz4/ZYTtXgaJKsuMATfTtNVpv2Os5f4u1Jw+jR
         +iNYYcRmd1dCDyZz+JKJrhwSx+fGddufkasci3XPIZtMA1xMMz21bn8IZKYjtP4elbsP
         I+Dg==
X-Forwarded-Encrypted: i=1; AJvYcCURf/w1cX/w94LLEEcu9JJdEdHtJ/qiMD+7M3yYp8U7jtiMsI9Yi3Nyga8OGvcTB1XKESjU2UZ39TtMffM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxykUwAJnrONHJ6H5n/h3qGARCXI7fIWfMx1D4MHVQlA6fjqgGd
	z74c01QtHhOm2wNtXRurhXXAPwghaA4akXfk5xEU83dmJsB49HOCXK3+mSuQFspLywK5vUw8hD5
	atBQgkz0Ay1wOGaeN8F7NTN4f3zj9nImou0PONForbMYkn0ff1m+u
X-Gm-Gg: ASbGncse+xf6XvwYe9xGa1wDFdG7abuRirclHdpCzUMxYj6MTjV68b1MC8t1ZZxl2t2
	bS4/R2aEulRtfhqfm+zNq1HHxStknaevY4EYv/6fSrGAVxPebogPvObdC9Bwunwjdaw==
X-Google-Smtp-Source: AGHT+IFtksj3bP2xqQTl0+cV3QED5U6EzcqzmOHPL6HHBxLP4L/s4UwWa56yBVIZDv6FeIPx9mwCJFKNvo7Sp+hET1I=
X-Received: by 2002:a05:622a:4087:b0:466:8c23:823a with SMTP id
 d75a77b69052e-46777658911mr4747721cf.17.1733852213659; Tue, 10 Dec 2024
 09:36:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1ba0cc57-e2ed-caa2-1241-aa5615bee01f@candelatech.com>
 <CAJuCfpGk6kyAAEUakMTNvJWmo98Gfbrk22+yZNEwO0eMbRc1Og@mail.gmail.com>
 <dcec571e-4f84-b12b-b931-4dbfb3f8bd98@candelatech.com> <CAJuCfpEwmTXkMHRdY0USwPFoWcC3d3j6r=6SRV39uP3KG6b5iA@mail.gmail.com>
 <CAJuCfpGUey5wAmL1Cgi2d-RQ=b0cqWXbo3HxvD-bomodg+GJrw@mail.gmail.com>
 <eca69b03-9b89-af2a-d1b0-38f76675b165@candelatech.com> <CAJuCfpE=bOOW=dAWCFjzkCDw3LpyoZtcgLPcequ3wsuFn8-t4A@mail.gmail.com>
 <48b36c0e-86bb-b181-4d9b-7ed50d70426f@linux.dev> <CAJuCfpGBTVjOH5sxYpEUnfim5zWH3Ttg6F4pBtk+R7AujdWuuA@mail.gmail.com>
 <464cdb19-e3d1-b0d6-15aa-3b291f90d61b@linux.dev>
In-Reply-To: <464cdb19-e3d1-b0d6-15aa-3b291f90d61b@linux.dev>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 10 Dec 2024 09:36:42 -0800
Message-ID: <CAJuCfpHovr3NL-v_Cs=eTR9cq73nTuPwwg7cKDQhORmNLwOsrA@mail.gmail.com>
Subject: Re: BISECTED: 'alloc_tag: populate memory for module tags as needed'
 crashes on boot.
To: Hao Ge <hao.ge@linux.dev>
Cc: Ben Greear <greearb@candelatech.com>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 9, 2024 at 8:21=E2=80=AFPM Hao Ge <hao.ge@linux.dev> wrote:
>
> Hi Suren and Ben
>
>
> On 12/10/24 06:33, Suren Baghdasaryan wrote:
> > On Mon, Dec 9, 2024 at 4:48=E2=80=AFAM Hao Ge <hao.ge@linux.dev> wrote:
> >> Hi Suren
> >>
> >>
> >> On 12/7/24 09:27, Suren Baghdasaryan wrote:
> >>> On Fri, Dec 6, 2024 at 4:50=E2=80=AFPM Ben Greear <greearb@candelatec=
h.com> wrote:
> >>>> On 12/6/24 16:15, Suren Baghdasaryan wrote:
> >>>>> On Fri, Dec 6, 2024 at 2:55=E2=80=AFPM Suren Baghdasaryan <surenb@g=
oogle.com> wrote:
> >>>>>> On Fri, Dec 6, 2024 at 2:43=E2=80=AFPM Ben Greear <greearb@candela=
tech.com> wrote:
> >>>>>>> On 12/6/24 14:03, Suren Baghdasaryan wrote:
> >>>>>>>> On Fri, Dec 6, 2024 at 1:50=E2=80=AFPM Ben Greear <greearb@cande=
latech.com> wrote:
> >>>>>>>>> Hello Suren,
> >>>>>>>>>
> >>>>>>>>> My system crashes on bootup, and I bisected to this commit.
> >>>>>>>>>
> >>>>>>>>> 0f9b685626daa2f8e19a9788625c9b624c223e45 is the first bad commi=
t
> >>>>>>>>> commit 0f9b685626daa2f8e19a9788625c9b624c223e45
> >>>>>>>>> Author: Suren Baghdasaryan <surenb@google.com>
> >>>>>>>>> Date:   Wed Oct 23 10:07:57 2024 -0700
> >>>>>>>>>
> >>>>>>>>>          alloc_tag: populate memory for module tags as needed
> >>>>>>>>>
> >>>>>>>>>          The memory reserved for module tags does not need to b=
e backed by physical
> >>>>>>>>>          pages until there are tags to store there.  Change the=
 way we reserve this
> >>>>>>>>>          memory to allocate only virtual area for the tags and =
populate it with
> >>>>>>>>>          physical pages as needed when we load a module.
> >>>>>>>>>
> >>>>>>>>> The crash looks like this:
> >>>>>>>>>
> >>>>>>>>> BUG: unable to handle page fault for address: fffffbfff4041000
> >>>>>>>>> #PF: supervisor read access in kernel mode
> >>>>>>>>> #PF: error_code(0x0000) - not-present page
> >>>>>>>>> PGD 44d0e7067 P4D 44d0e7067 PUD 44d0e3067 PMD 10bb38067 PTE 0
> >>>>>>>>> Oops: Oops: 0000 [#1] PREEMPT SMP KASAN
> >>>>>>>>> CPU: 0 UID: 0 PID: 319 Comm: systemd-udevd Not tainted 6.12.0-r=
c6+ #21
> >>>>>>>>> Hardware name: Default string Default string/SKYBAY, BIOS 5.12 =
02/15/2023
> >>>>>>>>> RIP: 0010:kasan_check_range+0xa5/0x190
> >>>>>>>>> Code: 8d 5a 07 4c 0f 49 da 49 c1 fb 03 45 85 db 0f 84 ce 00 00 =
00 45 89 db 4a 8d 14 d8 eb 0d 48 83 c0 08 48 39 d0 0f 84 b29
> >>>>>>>>> RSP: 0018:ffff88812c26f980 EFLAGS: 00010206
> >>>>>>>>> RAX: fffffbfff4041000 RBX: fffffbfff404101e RCX: ffffffff814ec2=
9b
> >>>>>>>>> [  OK  DX: fffffbfff4041018 RSI: 00000000000000f0 RDI: ffffffff=
a0208000
> >>>>>>>>> 0m] Finished BP: fffffbfff4041000 R08: 0000000000000001 R09: ff=
fffbfff404101d
> >>>>>>>>> ;1;39msystemd-udR10: ffffffffa02080ef R11: 0000000000000003 R12=
: ffffffffa0208000
> >>>>>>>>> ev-trig=E2=80=A6e R13: ffffc90000dac7c8 R14: ffffc90000dac7e8 R=
15: dffffc0000000000
> >>>>>>>>> - Coldplug All uFS:  00007fe869216b40(0000) GS:ffff88841da00000=
(0000) knlGS:0000000000000000
> >>>>>>>>> dev Devices.
> >>>>>>>>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >>>>>>>>> CR2: fffffbfff4041000 CR3: 0000000121e86002 CR4: 00000000003706=
f0
> >>>>>>>>> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000000000=
00
> >>>>>>>>> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000000004=
00
> >>>>>>>>> Call Trace:
> >>>>>>>>>       <TASK>
> >>>>>>>>> [  OK  ? __die+0x1f/0x60
> >>>>>>>>> 0m] Reached targ ? page_fault_oops+0x258/0x910
> >>>>>>>>> et sysi ? dump_pagetable+0x690/0x690
> >>>>>>>>> nit.target - ? search_bpf_extables+0x22/0x250
> >>>>>>>>>       System Initiali ? trace_page_fault_kernel+0x120/0x120
> >>>>>>>>> zation.
> >>>>>>>>>       ? search_bpf_extables+0x164/0x250
> >>>>>>>>>       ? kasan_check_range+0xa5/0x190
> >>>>>>>>>       ? fixup_exception+0x4d/0xc70
> >>>>>>>>>       ? exc_page_fault+0xe1/0xf0
> >>>>>>>>> [  OK  ? asm_exc_page_fault+0x22/0x30
> >>>>>>>>> 0m] Reached targ ? load_module+0x3d7b/0x7560
> >>>>>>>>> et netw ? kasan_check_range+0xa5/0x190
> >>>>>>>>> ork.target - __asan_memcpy+0x38/0x60
> >>>>>>>>>       Network.
> >>>>>>>>>       load_module+0x3d7b/0x7560
> >>>>>>>>>       ? module_frob_arch_sections+0x30/0x30
> >>>>>>>>>       ? lockdep_lock+0xbe/0x1b0
> >>>>>>>>>       ? rw_verify_area+0x18d/0x5e0
> >>>>>>>>>       ? kernel_read_file+0x246/0x870
> >>>>>>>>>       ? __x64_sys_fspick+0x290/0x290
> >>>>>>>>>       ? init_module_from_file+0xd1/0x130
> >>>>>>>>>       init_module_from_file+0xd1/0x130
> >>>>>>>>>       ? __ia32_sys_init_module+0xa0/0xa0
> >>>>>>>>>       ? lock_acquire+0x2d/0xb0
> >>>>>>>>>       ? idempotent_init_module+0x116/0x790
> >>>>>>>>>       ? do_raw_spin_unlock+0x54/0x220
> >>>>>>>>>       idempotent_init_module+0x226/0x790
> >>>>>>>>>       ? init_module_from_file+0x130/0x130
> >>>>>>>>>       ? vm_mmap_pgoff+0x203/0x2e0
> >>>>>>>>>       __x64_sys_finit_module+0xba/0x130
> >>>>>>>>>       do_syscall_64+0x69/0x160
> >>>>>>>>>       entry_SYSCALL_64_after_hwframe+0x4b/0x53
> >>>>>>>>> RIP: 0033:0x7fe869de327d
> >>>>>>>>> Code: 5d c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 =
f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 248
> >>>>>>>>> RSP: 002b:00007ffe34a828d8 EFLAGS: 00000246 ORIG_RAX: 000000000=
0000139
> >>>>>>>>> RAX: ffffffffffffffda RBX: 0000557fa8f3f3f0 RCX: 00007fe869de32=
7d
> >>>>>>>>> RDX: 0000000000000000 RSI: 00007fe869f4943c RDI: 00000000000000=
06
> >>>>>>>>> RBP: 00007fe869f4943c R08: 0000000000000000 R09: 00000000000000=
00
> >>>>>>>>> R10: 0000000000000006 R11: 0000000000000246 R12: 00000000000200=
00
> >>>>>>>>> R13: 0000557fa8f3f030 R14: 0000000000000000 R15: 0000557fa8f3d1=
10
> >>>>>>>>>       </TASK>
> >>>>>>>>> Modules linked in:
> >>>>>>>>> CR2: fffffbfff4041000
> >>>>>>>>> ---[ end trace 0000000000000000 ]---
> >>>>>>>>>
> >>>>>>>>> I suspect you only hit this with an unlucky amount of debugging=
 enabled.  The kernel config I used
> >>>>>>>>> is found here:
> >>>>>>>>>
> >>>>>>>>> http://www.candelatech.com/downloads/cfg-kasan-crash-regression=
.config
> >>>>>>>>>
> >>>>>>>>> I will be happy to test fixes.
> >>>>>>>> Hi Ben,
> >>>>>>>> Thanks for reporting the issue. Do you have these recent fixes i=
n your tree:
> >>>>>>>>
> >>>>>>>> https://lore.kernel.org/all/20241130001423.1114965-1-surenb@goog=
le.com/
> >>>>>>>> https://lore.kernel.org/all/20241205170528.81000-1-hao.ge@linux.=
dev/
> >>>>>>>>
> >>>>>>>> If not, couple you please apply them and see if the issue is sti=
ll happening?
> >>>>>>>> Thanks,
> >>>>>>>> Suren.
> >>>>>>> Hello Suren,
> >>>>>>>
> >>>>>>> Thanks for the quick response.  The first patch is already in lat=
est Linus tree,
> >>>>> Hmm. Could you please double-check which tree you are using? I don'=
t
> >>>>> see the first patch
> >>>>> (https://lore.kernel.org/all/20241130001423.1114965-1-surenb@google=
.com/)
> >>>>> in Linus' tree. Maybe you are using linux-next?
> >>>> Sorry, you are correct.  I must have mangled something when trying t=
o apply
> >>>> the patch and I didn't look hard enough when patch said changes were=
 already applied.
> >>>>
> >>>> I can re-test this next week...and for reference, kernel boots fine =
when you disable
> >>>> KASAN and other debugging.
> >>> Thanks! Please retest with this patch and let me know if you are stil=
l
> >>> having issues.
> >>> Suren.
> >> Indeed, this is a bug that still exists in another context, namely whe=
n
> >> CONFIG_KASAN_VMALLOC is not enabled.
> > Hmm. Are you able to reproduce this issue with all the fixes we had?
>
>
> Yes, I set up an x86 virtual machine and after porting both of our
> patches, I encountered a reproduction of the issue.
>
> I have also submitted a patch to fix this issue.
>
> https://lore.kernel.org/all/20241210041515.765569-1-hao.ge@linux.dev/

Thanks! I'll post my comments there.

>
> I verified it locally.
>
>
> Hi Ben
>
> Can you test with this patch?
>
>
> Thanks
>
> Best Regards
>
> Hao
>
> >
> >> We may need to look into this scenario next.
> >>
> >> Thanks
> >>
> >> Best Regards
> >>
> >> Hao
> >>
> >>>> Thanks,
> >>>> Ben
> >>>>
> >>>>
> >>>> --
> >>>> Ben Greear <greearb@candelatech.com>
> >>>> Candela Technologies Inc  http://www.candelatech.com
> >>>>
> >>>>

