Return-Path: <linux-kernel+bounces-438508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1A199EA20B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 23:46:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EF11161F40
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 22:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA08D1A2632;
	Mon,  9 Dec 2024 22:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d819oNR7"
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461F219F117
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 22:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733783650; cv=none; b=qnM/QQqy07W+TLqQsy3AB1B1H2CleAbsRKN2ab0Ua54UPzf5nw33vxIJfkgGgC3e34ChyvR7615ZJc/WDn2h6PKYrHo37ZtskVhEBhk6o/R5q5RWn+YH5bGttEuoDuo+kEjh6GYQvkVpovzJ+NPkxWQzxckCruRYsyKzZVK++wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733783650; c=relaxed/simple;
	bh=Yy+cD3nFFYBdAd8R7f+i0EakyLe3tZ4lE0y+DohYJok=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pbXlOy4PS0o95x4JnbAWg7MlKvZESSTCUCsArKQJAnKJpRlgqjkb5rpA8t9nCkDWUK6uB6riij5NzOftwS5H64nh6sraez/H7EjRXhIDeYl/NoQI49hk6Ih2DOzackWo0c9sP7jwWt9GZMLL5gm7v0aWaAufJKB0MKt55/sX+2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d819oNR7; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4674c22c4afso56971cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 14:34:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733783647; x=1734388447; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7uW1rxD4whHkbHhGnGwyFswJhNYglKqGISTFISRJujI=;
        b=d819oNR7m0DERjQusJVIk8GgQaH2K3sHGq25e4KyGcydDsfQS/zJZoeJgridw8eT15
         MH13FVqmUEHtBfRbDdoXDDK25qgsxoiXp9uXwQDoFJ2Zfg2Q6u3Ao70/b+/mR7w6TVp1
         CFxRNRkQQXpNEyG8LQWt0ewlpfSq5OOSTDPG1s8QwCadTKHb45Mw7rrCvmCAikO4p6CY
         4xXyBBeUcVX1GgvWka+rGS9D7lD0oeNvGGXNRxgDr26R/gHJJ1Bwf70XyAKBW6Cbqa2H
         MSkQDU5wb3kWYC1uZaZtwuynHUPnnFS7HhieJ+FZ/Nw/bML+RUeJBtdl6Zooo0/z6GLv
         UMrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733783647; x=1734388447;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7uW1rxD4whHkbHhGnGwyFswJhNYglKqGISTFISRJujI=;
        b=SBc1otSYlchaotLPZW38rW3gEwiykUVxjyXPz1cqr64E/Rh5E40Mxmdo7mH0tboZfj
         nBaJKh2whqzCaOt96iD9PL5RlC4LLTE2X6Om9M3Sk7BmS19RyUIwjamPrgYPUAiRRq7M
         20zhzOR30eV1DD7uiNeg0lLuSDFvJDZTnOvZtHxbXK7ae3iy+cScDmSvri+x46JMLJ8M
         0gEl83jPHE7o6/hX1qKwFqGvg7JQx9JTvXRNDJGBSQ9lQtv8Hm0qG0r3j5Ppakqarmfd
         AaK/5bsGYWM0PlDYFT8Hx8/g/tpfeDBqgBaKEeKk5cqdmvU/80exPlmMFBEJpfqNI0+p
         Tzhg==
X-Forwarded-Encrypted: i=1; AJvYcCWe8iAch8rbGVaXQDSlG7UGi/w2aWSL+29AF3t0a1BXsT3Na3tOowbyjUriy7axO4Z7RHABnMRTtq+KkFk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyw/rHHO7lqWks7qeaM+EQtdejnzzcUm5rRF3JC/cj0VVFkgH10
	yaYvFilYkFFkG2fOAqFVr4gOCMM1zjNcIazVbWOSyc9p2tKKn9WJSxu7jUCc/ftjFypV7xpgSUd
	6rCx0GfL8/hwJV43iJUHEMiAaOKxfnrqbuetZUvYTJqMYceOZXG0Z
X-Gm-Gg: ASbGncv9LjlrBSb7FwsMlZDwpg7ItHk3Qe0pk/84s3BJHhZxYo2YKLFy1WcWeDCrVBA
	XNkT8k/tzF3yv+EAjBxAZaAayk5XetTawL1c=
X-Google-Smtp-Source: AGHT+IHEKSj4VOz/GCaS/6NAdvtZ8hLaI43obEWhjnMwiMWdtlxhVgeFFcNxI13cl5HM0ss4ey7Oj8c0GhcJfOnDU8U=
X-Received: by 2002:a05:622a:1e85:b0:466:91fd:74c0 with SMTP id
 d75a77b69052e-46776019206mr1209351cf.0.1733783646873; Mon, 09 Dec 2024
 14:34:06 -0800 (PST)
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
 <48b36c0e-86bb-b181-4d9b-7ed50d70426f@linux.dev>
In-Reply-To: <48b36c0e-86bb-b181-4d9b-7ed50d70426f@linux.dev>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 9 Dec 2024 14:33:55 -0800
Message-ID: <CAJuCfpGBTVjOH5sxYpEUnfim5zWH3Ttg6F4pBtk+R7AujdWuuA@mail.gmail.com>
Subject: Re: BISECTED: 'alloc_tag: populate memory for module tags as needed'
 crashes on boot.
To: Hao Ge <hao.ge@linux.dev>
Cc: Ben Greear <greearb@candelatech.com>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 9, 2024 at 4:48=E2=80=AFAM Hao Ge <hao.ge@linux.dev> wrote:
>
> Hi Suren
>
>
> On 12/7/24 09:27, Suren Baghdasaryan wrote:
> > On Fri, Dec 6, 2024 at 4:50=E2=80=AFPM Ben Greear <greearb@candelatech.=
com> wrote:
> >> On 12/6/24 16:15, Suren Baghdasaryan wrote:
> >>> On Fri, Dec 6, 2024 at 2:55=E2=80=AFPM Suren Baghdasaryan <surenb@goo=
gle.com> wrote:
> >>>> On Fri, Dec 6, 2024 at 2:43=E2=80=AFPM Ben Greear <greearb@candelate=
ch.com> wrote:
> >>>>> On 12/6/24 14:03, Suren Baghdasaryan wrote:
> >>>>>> On Fri, Dec 6, 2024 at 1:50=E2=80=AFPM Ben Greear <greearb@candela=
tech.com> wrote:
> >>>>>>> Hello Suren,
> >>>>>>>
> >>>>>>> My system crashes on bootup, and I bisected to this commit.
> >>>>>>>
> >>>>>>> 0f9b685626daa2f8e19a9788625c9b624c223e45 is the first bad commit
> >>>>>>> commit 0f9b685626daa2f8e19a9788625c9b624c223e45
> >>>>>>> Author: Suren Baghdasaryan <surenb@google.com>
> >>>>>>> Date:   Wed Oct 23 10:07:57 2024 -0700
> >>>>>>>
> >>>>>>>         alloc_tag: populate memory for module tags as needed
> >>>>>>>
> >>>>>>>         The memory reserved for module tags does not need to be b=
acked by physical
> >>>>>>>         pages until there are tags to store there.  Change the wa=
y we reserve this
> >>>>>>>         memory to allocate only virtual area for the tags and pop=
ulate it with
> >>>>>>>         physical pages as needed when we load a module.
> >>>>>>>
> >>>>>>> The crash looks like this:
> >>>>>>>
> >>>>>>> BUG: unable to handle page fault for address: fffffbfff4041000
> >>>>>>> #PF: supervisor read access in kernel mode
> >>>>>>> #PF: error_code(0x0000) - not-present page
> >>>>>>> PGD 44d0e7067 P4D 44d0e7067 PUD 44d0e3067 PMD 10bb38067 PTE 0
> >>>>>>> Oops: Oops: 0000 [#1] PREEMPT SMP KASAN
> >>>>>>> CPU: 0 UID: 0 PID: 319 Comm: systemd-udevd Not tainted 6.12.0-rc6=
+ #21
> >>>>>>> Hardware name: Default string Default string/SKYBAY, BIOS 5.12 02=
/15/2023
> >>>>>>> RIP: 0010:kasan_check_range+0xa5/0x190
> >>>>>>> Code: 8d 5a 07 4c 0f 49 da 49 c1 fb 03 45 85 db 0f 84 ce 00 00 00=
 45 89 db 4a 8d 14 d8 eb 0d 48 83 c0 08 48 39 d0 0f 84 b29
> >>>>>>> RSP: 0018:ffff88812c26f980 EFLAGS: 00010206
> >>>>>>> RAX: fffffbfff4041000 RBX: fffffbfff404101e RCX: ffffffff814ec29b
> >>>>>>> [  OK  DX: fffffbfff4041018 RSI: 00000000000000f0 RDI: ffffffffa0=
208000
> >>>>>>> 0m] Finished BP: fffffbfff4041000 R08: 0000000000000001 R09: ffff=
fbfff404101d
> >>>>>>> ;1;39msystemd-udR10: ffffffffa02080ef R11: 0000000000000003 R12: =
ffffffffa0208000
> >>>>>>> ev-trig=E2=80=A6e R13: ffffc90000dac7c8 R14: ffffc90000dac7e8 R15=
: dffffc0000000000
> >>>>>>> - Coldplug All uFS:  00007fe869216b40(0000) GS:ffff88841da00000(0=
000) knlGS:0000000000000000
> >>>>>>> dev Devices.
> >>>>>>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >>>>>>> CR2: fffffbfff4041000 CR3: 0000000121e86002 CR4: 00000000003706f0
> >>>>>>> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> >>>>>>> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> >>>>>>> Call Trace:
> >>>>>>>      <TASK>
> >>>>>>> [  OK  ? __die+0x1f/0x60
> >>>>>>> 0m] Reached targ ? page_fault_oops+0x258/0x910
> >>>>>>> et sysi ? dump_pagetable+0x690/0x690
> >>>>>>> nit.target - ? search_bpf_extables+0x22/0x250
> >>>>>>>      System Initiali ? trace_page_fault_kernel+0x120/0x120
> >>>>>>> zation.
> >>>>>>>      ? search_bpf_extables+0x164/0x250
> >>>>>>>      ? kasan_check_range+0xa5/0x190
> >>>>>>>      ? fixup_exception+0x4d/0xc70
> >>>>>>>      ? exc_page_fault+0xe1/0xf0
> >>>>>>> [  OK  ? asm_exc_page_fault+0x22/0x30
> >>>>>>> 0m] Reached targ ? load_module+0x3d7b/0x7560
> >>>>>>> et netw ? kasan_check_range+0xa5/0x190
> >>>>>>> ork.target - __asan_memcpy+0x38/0x60
> >>>>>>>      Network.
> >>>>>>>      load_module+0x3d7b/0x7560
> >>>>>>>      ? module_frob_arch_sections+0x30/0x30
> >>>>>>>      ? lockdep_lock+0xbe/0x1b0
> >>>>>>>      ? rw_verify_area+0x18d/0x5e0
> >>>>>>>      ? kernel_read_file+0x246/0x870
> >>>>>>>      ? __x64_sys_fspick+0x290/0x290
> >>>>>>>      ? init_module_from_file+0xd1/0x130
> >>>>>>>      init_module_from_file+0xd1/0x130
> >>>>>>>      ? __ia32_sys_init_module+0xa0/0xa0
> >>>>>>>      ? lock_acquire+0x2d/0xb0
> >>>>>>>      ? idempotent_init_module+0x116/0x790
> >>>>>>>      ? do_raw_spin_unlock+0x54/0x220
> >>>>>>>      idempotent_init_module+0x226/0x790
> >>>>>>>      ? init_module_from_file+0x130/0x130
> >>>>>>>      ? vm_mmap_pgoff+0x203/0x2e0
> >>>>>>>      __x64_sys_finit_module+0xba/0x130
> >>>>>>>      do_syscall_64+0x69/0x160
> >>>>>>>      entry_SYSCALL_64_after_hwframe+0x4b/0x53
> >>>>>>> RIP: 0033:0x7fe869de327d
> >>>>>>> Code: 5d c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8=
 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 248
> >>>>>>> RSP: 002b:00007ffe34a828d8 EFLAGS: 00000246 ORIG_RAX: 00000000000=
00139
> >>>>>>> RAX: ffffffffffffffda RBX: 0000557fa8f3f3f0 RCX: 00007fe869de327d
> >>>>>>> RDX: 0000000000000000 RSI: 00007fe869f4943c RDI: 0000000000000006
> >>>>>>> RBP: 00007fe869f4943c R08: 0000000000000000 R09: 0000000000000000
> >>>>>>> R10: 0000000000000006 R11: 0000000000000246 R12: 0000000000020000
> >>>>>>> R13: 0000557fa8f3f030 R14: 0000000000000000 R15: 0000557fa8f3d110
> >>>>>>>      </TASK>
> >>>>>>> Modules linked in:
> >>>>>>> CR2: fffffbfff4041000
> >>>>>>> ---[ end trace 0000000000000000 ]---
> >>>>>>>
> >>>>>>> I suspect you only hit this with an unlucky amount of debugging e=
nabled.  The kernel config I used
> >>>>>>> is found here:
> >>>>>>>
> >>>>>>> http://www.candelatech.com/downloads/cfg-kasan-crash-regression.c=
onfig
> >>>>>>>
> >>>>>>> I will be happy to test fixes.
> >>>>>> Hi Ben,
> >>>>>> Thanks for reporting the issue. Do you have these recent fixes in =
your tree:
> >>>>>>
> >>>>>> https://lore.kernel.org/all/20241130001423.1114965-1-surenb@google=
.com/
> >>>>>> https://lore.kernel.org/all/20241205170528.81000-1-hao.ge@linux.de=
v/
> >>>>>>
> >>>>>> If not, couple you please apply them and see if the issue is still=
 happening?
> >>>>>> Thanks,
> >>>>>> Suren.
> >>>>> Hello Suren,
> >>>>>
> >>>>> Thanks for the quick response.  The first patch is already in lates=
t Linus tree,
> >>> Hmm. Could you please double-check which tree you are using? I don't
> >>> see the first patch
> >>> (https://lore.kernel.org/all/20241130001423.1114965-1-surenb@google.c=
om/)
> >>> in Linus' tree. Maybe you are using linux-next?
> >> Sorry, you are correct.  I must have mangled something when trying to =
apply
> >> the patch and I didn't look hard enough when patch said changes were a=
lready applied.
> >>
> >> I can re-test this next week...and for reference, kernel boots fine wh=
en you disable
> >> KASAN and other debugging.
> > Thanks! Please retest with this patch and let me know if you are still
> > having issues.
> > Suren.
>
> Indeed, this is a bug that still exists in another context, namely when
> CONFIG_KASAN_VMALLOC is not enabled.

Hmm. Are you able to reproduce this issue with all the fixes we had?

>
> We may need to look into this scenario next.
>
> Thanks
>
> Best Regards
>
> Hao
>
> >> Thanks,
> >> Ben
> >>
> >>
> >> --
> >> Ben Greear <greearb@candelatech.com>
> >> Candela Technologies Inc  http://www.candelatech.com
> >>
> >>

