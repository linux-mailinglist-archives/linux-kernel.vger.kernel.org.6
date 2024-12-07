Return-Path: <linux-kernel+bounces-435830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C4559E7DB8
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 02:28:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6E67285A70
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 01:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D629BC13C;
	Sat,  7 Dec 2024 01:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RrJuUvL5"
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D910BE4F
	for <linux-kernel@vger.kernel.org>; Sat,  7 Dec 2024 01:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733534884; cv=none; b=Smq5m26Hd7lKmJoP+/puv/k12IZYh5z0bpAy0GYavTPmcqsxFp23s3PN/AJYa4bJgSH+fcEjJtD49GkE/cYzh/ld2bNI30NZmTB2dh4eWYwW0YHPLEEKMfyOWCgnTVIRYAY7Fvr5mHJY8zX6f+dTKIsuYYHJBY8uySEAxzN6dG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733534884; c=relaxed/simple;
	bh=lwTC6f116yl59uSY1NvRxHnDU6qKWxmbsF74tU2AqeE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lqjcCN39raDrDTdIvAwt24F1jX8+lGeUk5yUWvC8A+SwpxMQcpLJd5mGe+faiZbBpM+KehaQkQVJUNAkrbxKf3GZ0h5VnHeVqashIHbXsAwVugL86tUX0ZcUjkvByP5469SRcojkQSfGVOn+WvryAk90eYUobdsIWNejrlk8NTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RrJuUvL5; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4674c22c4afso42091cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 17:28:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733534881; x=1734139681; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3IjuAnniLgzrLnoTMO8S14VsyLMgHz4r4PBzVYFhA50=;
        b=RrJuUvL5leEZqvlOCST21EYz4XClAyIFE6fsmBKpvHQXz/z0AsH8Tig1UkUoGvSp5r
         xHe2X1FFlmNTeFwRs7tOhqayeoMC5mRlwbnvlTAzHnxb4cubb3ztwCtCmKsijWHD3llI
         /RTCjQ2GSMV4Ecolo74W3twfZatwCaVbML5UN6H4U+B/K9xPmqAnxEOVv4CRJpopePSN
         vlXXQKDYajLlyCvIv22+rT7SCQDAnuYjzDyRQJzfYbAm19q4rzyza7GNDWlsUSRmHc67
         WtRDKI7mYAgvXM8gUeTe1k6MstTkY3tFJj+LwOejQzXimYJVnToEhKaZ/xu3MN4bWSKj
         fYag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733534881; x=1734139681;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3IjuAnniLgzrLnoTMO8S14VsyLMgHz4r4PBzVYFhA50=;
        b=thx4lKO6gJlNyvB0MrEVChVFD1P3tMdcun8sQn5sVokRa/tRKapSRwMaGx/O2RLYUp
         h6DWY6V+2VSHU5KiSUYNhXu8oyN6QKcBX+/PSeLHWvFMAnqUUrQ+1pU8q6TGfFHrMTnM
         sEimjeX8BqWOENqGpXZNblVCle8JEKuvBHzrHNrq/XR6V7GvZl3I7PUbcUz0Fg/7cO25
         bl3vFFi4B9loaiCYsUkN+zlP0gI1asVMO6j9ZN1vuarE6GIbxGeFnGXDs2oIwLoRYM0Y
         79BS9Kv7RYF8vA1yIp6n5hHNikgDSyzw+AaPBRoKk5oCPZnPsLlQTTNEiF2x4qBpNVYH
         M+sQ==
X-Gm-Message-State: AOJu0Yxtwo59tCLyoyTIUwpTPDzCUFBPYNoOIhMITl9PrfiiAxvzxmab
	6WheiiDLa/VmK9qZFz2gL9lytWh/7rpIaR/lfO5hnPAWw50ECU46dQrbnb0mhtezirfcGNLsDwj
	ZjyotM0rQA/E8Eif4t5pRVi/gqCXv/8McJRPU3tgr4RvbDoefFx0j
X-Gm-Gg: ASbGnctGl8Ox0AkccDQ+eZ6lPznvXButSQCwNimoMXaAAz6+57v0cQgog6tRBdIK/Hw
	ZlslEN7dLqvBTnCdeMvpdx0SbZYwGSFM=
X-Google-Smtp-Source: AGHT+IHL/2L/adlLJiwmIdj4sXuVmE6l0issUKbFPJXaQNlQdz3kJJM+eYiu8ZZD6yzZ0TwBgEifAv53mzN5QC728t0=
X-Received: by 2002:a05:622a:1e87:b0:466:a11c:cad2 with SMTP id
 d75a77b69052e-4674c7678eamr767131cf.7.1733534880886; Fri, 06 Dec 2024
 17:28:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1ba0cc57-e2ed-caa2-1241-aa5615bee01f@candelatech.com>
 <CAJuCfpGk6kyAAEUakMTNvJWmo98Gfbrk22+yZNEwO0eMbRc1Og@mail.gmail.com>
 <dcec571e-4f84-b12b-b931-4dbfb3f8bd98@candelatech.com> <CAJuCfpEwmTXkMHRdY0USwPFoWcC3d3j6r=6SRV39uP3KG6b5iA@mail.gmail.com>
 <CAJuCfpGUey5wAmL1Cgi2d-RQ=b0cqWXbo3HxvD-bomodg+GJrw@mail.gmail.com> <eca69b03-9b89-af2a-d1b0-38f76675b165@candelatech.com>
In-Reply-To: <eca69b03-9b89-af2a-d1b0-38f76675b165@candelatech.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 6 Dec 2024 17:27:49 -0800
Message-ID: <CAJuCfpE=bOOW=dAWCFjzkCDw3LpyoZtcgLPcequ3wsuFn8-t4A@mail.gmail.com>
Subject: Re: BISECTED: 'alloc_tag: populate memory for module tags as needed'
 crashes on boot.
To: Ben Greear <greearb@candelatech.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 6, 2024 at 4:50=E2=80=AFPM Ben Greear <greearb@candelatech.com>=
 wrote:
>
> On 12/6/24 16:15, Suren Baghdasaryan wrote:
> > On Fri, Dec 6, 2024 at 2:55=E2=80=AFPM Suren Baghdasaryan <surenb@googl=
e.com> wrote:
> >>
> >> On Fri, Dec 6, 2024 at 2:43=E2=80=AFPM Ben Greear <greearb@candelatech=
.com> wrote:
> >>>
> >>> On 12/6/24 14:03, Suren Baghdasaryan wrote:
> >>>> On Fri, Dec 6, 2024 at 1:50=E2=80=AFPM Ben Greear <greearb@candelate=
ch.com> wrote:
> >>>>>
> >>>>> Hello Suren,
> >>>>>
> >>>>> My system crashes on bootup, and I bisected to this commit.
> >>>>>
> >>>>> 0f9b685626daa2f8e19a9788625c9b624c223e45 is the first bad commit
> >>>>> commit 0f9b685626daa2f8e19a9788625c9b624c223e45
> >>>>> Author: Suren Baghdasaryan <surenb@google.com>
> >>>>> Date:   Wed Oct 23 10:07:57 2024 -0700
> >>>>>
> >>>>>        alloc_tag: populate memory for module tags as needed
> >>>>>
> >>>>>        The memory reserved for module tags does not need to be back=
ed by physical
> >>>>>        pages until there are tags to store there.  Change the way w=
e reserve this
> >>>>>        memory to allocate only virtual area for the tags and popula=
te it with
> >>>>>        physical pages as needed when we load a module.
> >>>>>
> >>>>> The crash looks like this:
> >>>>>
> >>>>> BUG: unable to handle page fault for address: fffffbfff4041000
> >>>>> #PF: supervisor read access in kernel mode
> >>>>> #PF: error_code(0x0000) - not-present page
> >>>>> PGD 44d0e7067 P4D 44d0e7067 PUD 44d0e3067 PMD 10bb38067 PTE 0
> >>>>> Oops: Oops: 0000 [#1] PREEMPT SMP KASAN
> >>>>> CPU: 0 UID: 0 PID: 319 Comm: systemd-udevd Not tainted 6.12.0-rc6+ =
#21
> >>>>> Hardware name: Default string Default string/SKYBAY, BIOS 5.12 02/1=
5/2023
> >>>>> RIP: 0010:kasan_check_range+0xa5/0x190
> >>>>> Code: 8d 5a 07 4c 0f 49 da 49 c1 fb 03 45 85 db 0f 84 ce 00 00 00 4=
5 89 db 4a 8d 14 d8 eb 0d 48 83 c0 08 48 39 d0 0f 84 b29
> >>>>> RSP: 0018:ffff88812c26f980 EFLAGS: 00010206
> >>>>> RAX: fffffbfff4041000 RBX: fffffbfff404101e RCX: ffffffff814ec29b
> >>>>> [  OK  DX: fffffbfff4041018 RSI: 00000000000000f0 RDI: ffffffffa020=
8000
> >>>>> 0m] Finished BP: fffffbfff4041000 R08: 0000000000000001 R09: fffffb=
fff404101d
> >>>>> ;1;39msystemd-udR10: ffffffffa02080ef R11: 0000000000000003 R12: ff=
ffffffa0208000
> >>>>> ev-trig=E2=80=A6e R13: ffffc90000dac7c8 R14: ffffc90000dac7e8 R15: =
dffffc0000000000
> >>>>> - Coldplug All uFS:  00007fe869216b40(0000) GS:ffff88841da00000(000=
0) knlGS:0000000000000000
> >>>>> dev Devices.
> >>>>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >>>>> CR2: fffffbfff4041000 CR3: 0000000121e86002 CR4: 00000000003706f0
> >>>>> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> >>>>> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> >>>>> Call Trace:
> >>>>>     <TASK>
> >>>>> [  OK  ? __die+0x1f/0x60
> >>>>> 0m] Reached targ ? page_fault_oops+0x258/0x910
> >>>>> et sysi ? dump_pagetable+0x690/0x690
> >>>>> nit.target - ? search_bpf_extables+0x22/0x250
> >>>>>     System Initiali ? trace_page_fault_kernel+0x120/0x120
> >>>>> zation.
> >>>>>     ? search_bpf_extables+0x164/0x250
> >>>>>     ? kasan_check_range+0xa5/0x190
> >>>>>     ? fixup_exception+0x4d/0xc70
> >>>>>     ? exc_page_fault+0xe1/0xf0
> >>>>> [  OK  ? asm_exc_page_fault+0x22/0x30
> >>>>> 0m] Reached targ ? load_module+0x3d7b/0x7560
> >>>>> et netw ? kasan_check_range+0xa5/0x190
> >>>>> ork.target - __asan_memcpy+0x38/0x60
> >>>>>     Network.
> >>>>>     load_module+0x3d7b/0x7560
> >>>>>     ? module_frob_arch_sections+0x30/0x30
> >>>>>     ? lockdep_lock+0xbe/0x1b0
> >>>>>     ? rw_verify_area+0x18d/0x5e0
> >>>>>     ? kernel_read_file+0x246/0x870
> >>>>>     ? __x64_sys_fspick+0x290/0x290
> >>>>>     ? init_module_from_file+0xd1/0x130
> >>>>>     init_module_from_file+0xd1/0x130
> >>>>>     ? __ia32_sys_init_module+0xa0/0xa0
> >>>>>     ? lock_acquire+0x2d/0xb0
> >>>>>     ? idempotent_init_module+0x116/0x790
> >>>>>     ? do_raw_spin_unlock+0x54/0x220
> >>>>>     idempotent_init_module+0x226/0x790
> >>>>>     ? init_module_from_file+0x130/0x130
> >>>>>     ? vm_mmap_pgoff+0x203/0x2e0
> >>>>>     __x64_sys_finit_module+0xba/0x130
> >>>>>     do_syscall_64+0x69/0x160
> >>>>>     entry_SYSCALL_64_after_hwframe+0x4b/0x53
> >>>>> RIP: 0033:0x7fe869de327d
> >>>>> Code: 5d c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 4=
8 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 248
> >>>>> RSP: 002b:00007ffe34a828d8 EFLAGS: 00000246 ORIG_RAX: 0000000000000=
139
> >>>>> RAX: ffffffffffffffda RBX: 0000557fa8f3f3f0 RCX: 00007fe869de327d
> >>>>> RDX: 0000000000000000 RSI: 00007fe869f4943c RDI: 0000000000000006
> >>>>> RBP: 00007fe869f4943c R08: 0000000000000000 R09: 0000000000000000
> >>>>> R10: 0000000000000006 R11: 0000000000000246 R12: 0000000000020000
> >>>>> R13: 0000557fa8f3f030 R14: 0000000000000000 R15: 0000557fa8f3d110
> >>>>>     </TASK>
> >>>>> Modules linked in:
> >>>>> CR2: fffffbfff4041000
> >>>>> ---[ end trace 0000000000000000 ]---
> >>>>>
> >>>>> I suspect you only hit this with an unlucky amount of debugging ena=
bled.  The kernel config I used
> >>>>> is found here:
> >>>>>
> >>>>> http://www.candelatech.com/downloads/cfg-kasan-crash-regression.con=
fig
> >>>>>
> >>>>> I will be happy to test fixes.
> >>>>
> >>>> Hi Ben,
> >>>> Thanks for reporting the issue. Do you have these recent fixes in yo=
ur tree:
> >>>>
> >>>> https://lore.kernel.org/all/20241130001423.1114965-1-surenb@google.c=
om/
> >>>> https://lore.kernel.org/all/20241205170528.81000-1-hao.ge@linux.dev/
> >>>>
> >>>> If not, couple you please apply them and see if the issue is still h=
appening?
> >>>> Thanks,
> >>>> Suren.
> >>>
> >>> Hello Suren,
> >>>
> >>> Thanks for the quick response.  The first patch is already in latest =
Linus tree,
> >
> > Hmm. Could you please double-check which tree you are using? I don't
> > see the first patch
> > (https://lore.kernel.org/all/20241130001423.1114965-1-surenb@google.com=
/)
> > in Linus' tree. Maybe you are using linux-next?
>
> Sorry, you are correct.  I must have mangled something when trying to app=
ly
> the patch and I didn't look hard enough when patch said changes were alre=
ady applied.
>
> I can re-test this next week...and for reference, kernel boots fine when =
you disable
> KASAN and other debugging.

Thanks! Please retest with this patch and let me know if you are still
having issues.
Suren.

>
> Thanks,
> Ben
>
>
> --
> Ben Greear <greearb@candelatech.com>
> Candela Technologies Inc  http://www.candelatech.com
>
>

