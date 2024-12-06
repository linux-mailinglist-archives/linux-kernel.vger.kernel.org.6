Return-Path: <linux-kernel+bounces-435769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93FBB9E7C06
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 23:55:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22A801881B01
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 22:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E3C41FBE80;
	Fri,  6 Dec 2024 22:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sBZWNPPP"
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9208222C6D9
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 22:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733525721; cv=none; b=jhiUK0mkkOMmpgvWSMCSpDl+TbeTB3E9GChbKQIHBB3Qqdki9lDbr8OcuVw48Iu2n7u3HXjO6d3quhgSpyUj1FmIUAfckZVkdDVe3v+inTpTF4mX0FBDluqO1m3dTKlGP9UiqrpG9x1gBgqNDOQrQxFig2UhKjpuFoEikIZ+ex0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733525721; c=relaxed/simple;
	bh=4AYl7xJPWm40bfZRfOupUYiy8cgMhFivrLhnulB3VRw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n0Wc42hQnsCg1y3Z4c03zqaZh/uu/0mI12aP4W28Y5WFqabpO1R0Ekminlcl4ipZKNCW9tfIn0LfX8EzWPFyvTmnZYQb/hk98QQbPwR+UUff7YN3ft/q2FpBkmcxECH44KWbF5zV0dn1I6kduswCcsWEwttRLciNSJSMjTmVtgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sBZWNPPP; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4674c22c4afso15121cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 14:55:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733525718; x=1734130518; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tml4+qE6PvbScdcpvMLOjl59NJkkMkqEfp1ITUDHazo=;
        b=sBZWNPPPb06tnciz8bw0n7p8h9hIXP1+tQU1zOhSDQ5BBTe38wm6nz4ZPB2mTWgL+M
         jo/ss/Ytow+qWwyMoo3RERdMJhMJdGLK7jG04Givca4ZLtUj4tacrNcHHcEGs8TqOr8a
         M2EYBZQBHBe9yjg73B5x4/oj7iy1dl/bA5IPc8LIuwVADk+i14+2IUesPMzprnuAcxNk
         GIZLwI/kOMhqiAi1rVkbdtwMAMMT/Hpb8ObErUdssqu28YJnRD6o98cJrd5v/ClgkGd7
         POuqU7xUEn1rnANHdUpL89rNNC1gXcVMmPXcvhB+PuB2qlQEW0vzZZ1v7uCk4BVhsaNR
         4hGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733525718; x=1734130518;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tml4+qE6PvbScdcpvMLOjl59NJkkMkqEfp1ITUDHazo=;
        b=mAr/9WYh78IHyuwkZUoqDfT24Y9ePevd71OMmoOnCOWgqJA6u7ocxil4BfY4rjPTAB
         DtuHrcnabk1rRCF08PHQ6FSu6uF4gF1XoU5VUXN+P4jtgSlLZaleZNsUqPFop1edGP/2
         9XyWgJclsDSME97htxvA7U2ncMf3LzYrVPs9h+fm2vD/dyyfRxXe6sNAQBt2j9178184
         rWcCk3XVwWiGgm9ff5AHRRaY35H47/ydTgxRZBK9bBFJiizdRNsvy6/xK4zlHaqgnIbI
         GCeIGa/NL23/qd66Z//iqbL+3dutG7QzKsDurPdahj5aHSxM1QYMw0aYjGmq/V9ze3Fq
         sa9g==
X-Gm-Message-State: AOJu0Yz0By/FFrKIMEpvfW5GCBS2UNRvJcj/8Uu4nEz9NZGBqXlIKY+b
	zR9IuQ8ZC5NvoEgTgsLabbySuH3pztjrhTzT4RkAQtoq5OvwTxPfR/1jsm81BJkGvxxe226ejnA
	DFOcVX+uE+XRBqRiSSlzKt5Z5olQN8/DXvzjb
X-Gm-Gg: ASbGnctYAQzh92uV5okEXmYUNRx8+4b2vqgcpOh+zrlRPVsPYt7iARI9ZfJbZkaSouw
	PTkxBAz6Hn9yc0mb1vN2VA2y9FXKf0n8=
X-Google-Smtp-Source: AGHT+IHxohjYamUwZl8VXjB34ejjJPzlsi5kiaS/gshuUyhGilU3HH5Hctfi9uHSblcGzcE0pX5oJm8D59cWupmVVBM=
X-Received: by 2002:a05:622a:250c:b0:463:95e2:71f8 with SMTP id
 d75a77b69052e-4674c767912mr159871cf.15.1733525717821; Fri, 06 Dec 2024
 14:55:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1ba0cc57-e2ed-caa2-1241-aa5615bee01f@candelatech.com>
 <CAJuCfpGk6kyAAEUakMTNvJWmo98Gfbrk22+yZNEwO0eMbRc1Og@mail.gmail.com> <dcec571e-4f84-b12b-b931-4dbfb3f8bd98@candelatech.com>
In-Reply-To: <dcec571e-4f84-b12b-b931-4dbfb3f8bd98@candelatech.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 6 Dec 2024 14:55:06 -0800
Message-ID: <CAJuCfpEwmTXkMHRdY0USwPFoWcC3d3j6r=6SRV39uP3KG6b5iA@mail.gmail.com>
Subject: Re: BISECTED: 'alloc_tag: populate memory for module tags as needed'
 crashes on boot.
To: Ben Greear <greearb@candelatech.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 6, 2024 at 2:43=E2=80=AFPM Ben Greear <greearb@candelatech.com>=
 wrote:
>
> On 12/6/24 14:03, Suren Baghdasaryan wrote:
> > On Fri, Dec 6, 2024 at 1:50=E2=80=AFPM Ben Greear <greearb@candelatech.=
com> wrote:
> >>
> >> Hello Suren,
> >>
> >> My system crashes on bootup, and I bisected to this commit.
> >>
> >> 0f9b685626daa2f8e19a9788625c9b624c223e45 is the first bad commit
> >> commit 0f9b685626daa2f8e19a9788625c9b624c223e45
> >> Author: Suren Baghdasaryan <surenb@google.com>
> >> Date:   Wed Oct 23 10:07:57 2024 -0700
> >>
> >>       alloc_tag: populate memory for module tags as needed
> >>
> >>       The memory reserved for module tags does not need to be backed b=
y physical
> >>       pages until there are tags to store there.  Change the way we re=
serve this
> >>       memory to allocate only virtual area for the tags and populate i=
t with
> >>       physical pages as needed when we load a module.
> >>
> >> The crash looks like this:
> >>
> >> BUG: unable to handle page fault for address: fffffbfff4041000
> >> #PF: supervisor read access in kernel mode
> >> #PF: error_code(0x0000) - not-present page
> >> PGD 44d0e7067 P4D 44d0e7067 PUD 44d0e3067 PMD 10bb38067 PTE 0
> >> Oops: Oops: 0000 [#1] PREEMPT SMP KASAN
> >> CPU: 0 UID: 0 PID: 319 Comm: systemd-udevd Not tainted 6.12.0-rc6+ #21
> >> Hardware name: Default string Default string/SKYBAY, BIOS 5.12 02/15/2=
023
> >> RIP: 0010:kasan_check_range+0xa5/0x190
> >> Code: 8d 5a 07 4c 0f 49 da 49 c1 fb 03 45 85 db 0f 84 ce 00 00 00 45 8=
9 db 4a 8d 14 d8 eb 0d 48 83 c0 08 48 39 d0 0f 84 b29
> >> RSP: 0018:ffff88812c26f980 EFLAGS: 00010206
> >> RAX: fffffbfff4041000 RBX: fffffbfff404101e RCX: ffffffff814ec29b
> >> [  OK  DX: fffffbfff4041018 RSI: 00000000000000f0 RDI: ffffffffa020800=
0
> >> 0m] Finished BP: fffffbfff4041000 R08: 0000000000000001 R09: fffffbfff=
404101d
> >> ;1;39msystemd-udR10: ffffffffa02080ef R11: 0000000000000003 R12: fffff=
fffa0208000
> >> ev-trig=E2=80=A6e R13: ffffc90000dac7c8 R14: ffffc90000dac7e8 R15: dff=
ffc0000000000
> >> - Coldplug All uFS:  00007fe869216b40(0000) GS:ffff88841da00000(0000) =
knlGS:0000000000000000
> >> dev Devices.
> >> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >> CR2: fffffbfff4041000 CR3: 0000000121e86002 CR4: 00000000003706f0
> >> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> >> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> >> Call Trace:
> >>    <TASK>
> >> [  OK  ? __die+0x1f/0x60
> >> 0m] Reached targ ? page_fault_oops+0x258/0x910
> >> et sysi ? dump_pagetable+0x690/0x690
> >> nit.target - ? search_bpf_extables+0x22/0x250
> >>    System Initiali ? trace_page_fault_kernel+0x120/0x120
> >> zation.
> >>    ? search_bpf_extables+0x164/0x250
> >>    ? kasan_check_range+0xa5/0x190
> >>    ? fixup_exception+0x4d/0xc70
> >>    ? exc_page_fault+0xe1/0xf0
> >> [  OK  ? asm_exc_page_fault+0x22/0x30
> >> 0m] Reached targ ? load_module+0x3d7b/0x7560
> >> et netw ? kasan_check_range+0xa5/0x190
> >> ork.target - __asan_memcpy+0x38/0x60
> >>    Network.
> >>    load_module+0x3d7b/0x7560
> >>    ? module_frob_arch_sections+0x30/0x30
> >>    ? lockdep_lock+0xbe/0x1b0
> >>    ? rw_verify_area+0x18d/0x5e0
> >>    ? kernel_read_file+0x246/0x870
> >>    ? __x64_sys_fspick+0x290/0x290
> >>    ? init_module_from_file+0xd1/0x130
> >>    init_module_from_file+0xd1/0x130
> >>    ? __ia32_sys_init_module+0xa0/0xa0
> >>    ? lock_acquire+0x2d/0xb0
> >>    ? idempotent_init_module+0x116/0x790
> >>    ? do_raw_spin_unlock+0x54/0x220
> >>    idempotent_init_module+0x226/0x790
> >>    ? init_module_from_file+0x130/0x130
> >>    ? vm_mmap_pgoff+0x203/0x2e0
> >>    __x64_sys_finit_module+0xba/0x130
> >>    do_syscall_64+0x69/0x160
> >>    entry_SYSCALL_64_after_hwframe+0x4b/0x53
> >> RIP: 0033:0x7fe869de327d
> >> Code: 5d c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 8=
9 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 248
> >> RSP: 002b:00007ffe34a828d8 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
> >> RAX: ffffffffffffffda RBX: 0000557fa8f3f3f0 RCX: 00007fe869de327d
> >> RDX: 0000000000000000 RSI: 00007fe869f4943c RDI: 0000000000000006
> >> RBP: 00007fe869f4943c R08: 0000000000000000 R09: 0000000000000000
> >> R10: 0000000000000006 R11: 0000000000000246 R12: 0000000000020000
> >> R13: 0000557fa8f3f030 R14: 0000000000000000 R15: 0000557fa8f3d110
> >>    </TASK>
> >> Modules linked in:
> >> CR2: fffffbfff4041000
> >> ---[ end trace 0000000000000000 ]---
> >>
> >> I suspect you only hit this with an unlucky amount of debugging enable=
d.  The kernel config I used
> >> is found here:
> >>
> >> http://www.candelatech.com/downloads/cfg-kasan-crash-regression.config
> >>
> >> I will be happy to test fixes.
> >
> > Hi Ben,
> > Thanks for reporting the issue. Do you have these recent fixes in your =
tree:
> >
> > https://lore.kernel.org/all/20241130001423.1114965-1-surenb@google.com/
> > https://lore.kernel.org/all/20241205170528.81000-1-hao.ge@linux.dev/
> >
> > If not, couple you please apply them and see if the issue is still happ=
ening?
> > Thanks,
> > Suren.
>
> Hello Suren,
>
> Thanks for the quick response.  The first patch is already in latest Linu=
s tree,
> and I applied the second one manually.  The kernel still crashes:

Ok, I'll try to reproduce and troubleshoot it. Thanks!

>
> (gdb) l *(load_module+0x3c46)
> 0xffffffff814f30d6 is in load_module (/home/greearb/git/linux-2.6/kernel/=
module/main.c:2624).
> 2619                            if (i =3D=3D info->index.mod &&
> 2620                               (WARN_ON_ONCE(shdr->sh_size !=3D sizeo=
f(struct module)))) {
> 2621                                    ret =3D -ENOEXEC;
> 2622                                    goto out_err;
> 2623                            }
> 2624                            memcpy(dest, (void *)shdr->sh_addr, shdr-=
>sh_size);
> 2625                    }
> 2626                    /*
> 2627                     * Update the userspace copy's ELF section addres=
s to point to
> 2628                     * our newly allocated memory as a pure convenien=
ce so that
> (gdb)
>
> (gdb) l *(__asan_memcpy+0x38)
> 0xffffffff81b39268 is in __asan_memcpy (/home/greearb/git/linux-2.6/mm/ka=
san/shadow.c:105).
> 100     EXPORT_SYMBOL(__asan_memmove);
> 101     #endif
> 102
> 103     void *__asan_memcpy(void *dest, const void *src, ssize_t len)
> 104     {
> 105             if (!kasan_check_range(src, len, false, _RET_IP_) ||
> 106                 !kasan_check_range(dest, len, true, _RET_IP_))
> 107                     return NULL;
> 108
> 109             return __memcpy(dest, src, len);
> (gdb)
>
> (gdb) l *(kasan_check_range+0xa5)
> 0xffffffff81b386f5 is in kasan_check_range (/home/greearb/git/linux-2.6/m=
m/kasan/generic.c:116).
> 111                     start +=3D prefix;
> 112             }
> 113
> 114             words =3D (end - start) / 8;
> 115             while (words) {
> 116                     if (unlikely(*(u64 *)start))
> 117                             return bytes_is_nonzero(start, 8);
> 118                     start +=3D 8;
> 119                     words--;
> 120             }
> (gdb)
>
>
> BUG: unable to handle page fault for address: fffffbfff4041000
> #PF: supervisor read access in kernel mode
> #PF: error_code(0x0000) - not-present page
> PGD 44d0e7067 P4D 44d0e7067 PUD 44d0e3067 PMD 10bb3d067 PTE 0
> Oops: Oops: 0000 [#1] PREEMPT SMP KASAN
> CPU: 7 UID: 0 PID: 319 Comm: systemd-udevd Not tainted 6.13.0-rc1+ #24
> Hardware name: Default string Default string/SKYBAY, BIOS 5.12 02/15/2023
> RIP: 0010:kasan_check_range+0xa5/0x190
> Code: 8d 5a 07 4c 0f 49 da 49 c1 fb 03 45 85 db 0f 84 ce 00 00 00 45 89 d=
b 4a 8d 14 d8 eb 0d 48 83 c0 08 48 39 d0 0f 84 b29
> RSP: 0018:ffff88812d3ef980 EFLAGS: 00010206
> RAX: fffffbfff4041000 RBX: fffffbfff404101e RCX: ffffffff814f30d6
> RDX: fffffbfff4041018 RSI: 00000000000000f0 RDI: ffffffffa0208000
> [  OK  BP: fffffbfff4041000 R08: 0000000000000001 R09: fffffbfff404101d
> 0m] Finished 10: ffffffffa02080ef R11: 0000000000000003 R12: ffffffffa020=
8000
> ;1;39msystemd-udR13: ffffc90000dac930 R14: ffffc90000dac950 R15: dffffc00=
00000000
> ev-trig=E2=80=A6e FS:  00007fc25423bb40(0000) GS:ffff88841dd80000(0000) k=
nlGS:0000000000000000
> - Coldplug All uCS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: fffffbfff4041000 CR3: 0000000128ef4003 CR4: 00000000003706f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>   <TASK>
>   ? __die+0x1f/0x60
>   ? page_fault_oops+0x258/0x910
>   ? dump_pagetable+0x690/0x690
>   ? search_bpf_extables+0x22/0x250
>   ? show_ldttss+0x230/0x230
>   ? search_bpf_extables+0x164/0x250
>   ? kasan_check_range+0xa5/0x190
>   ? fixup_exception+0x4d/0xc70
>   ? exc_page_fault+0xe1/0xf0
>   ? asm_exc_page_fault+0x22/0x30
>   ? load_module+0x3c46/0x8680
>   ? kasan_check_range+0xa5/0x190
>   __asan_memcpy+0x38/0x60
>   load_module+0x3c46/0x8680
>   ? __kernel_read+0x270/0x9f0
>   ? module_frob_arch_sections+0x30/0x30
>   ? lockdep_lock+0xbe/0x1b0
>   ? rw_verify_area+0x18d/0x5e0
>   ? kernel_read_file+0x246/0x870
>   ? __x64_sys_fspick+0x290/0x290
>   ? init_module_from_file+0xd1/0x130
>   init_module_from_file+0xd1/0x130
>   ? __ia32_sys_init_module+0xa0/0xa0
>   ? lock_acquire+0x2d/0xb0
>   ? idempotent_init_module+0x10d/0x780
>   ? do_raw_spin_unlock+0x54/0x220
>   idempotent_init_module+0x21d/0x780
>   ? init_module_from_file+0x130/0x130
>   ? __fget_files+0x1a5/0x2d0
>   __x64_sys_finit_module+0xbe/0x130
>   do_syscall_64+0x69/0x160
>   entry_SYSCALL_64_after_hwframe+0x4b/0x53
> RIP: 0033:0x7fc254e0827d
> Code: 5d c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f=
7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 248
> RSP: 002b:00007ffe1750a718 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
> RAX: ffffffffffffffda RBX: 000055da274c5500 RCX: 00007fc254e0827d
> RDX: 0000000000000000 RSI: 00007fc254f6e43c RDI: 0000000000000006
> RBP: 00007fc254f6e43c R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000006 R11: 0000000000000246 R12: 0000000000020000
> R13: 000055da2749cbb0 R14: 0000000000000000 R15: 000055da274c44a0
>   </TASK>
> Modules linked in:
> CR2: fffffbfff4041000
> ---[ end trace 0000000000000000 ]---
>
> Thanks,
> Ben
>
> --
> Ben Greear <greearb@candelatech.com>
> Candela Technologies Inc  http://www.candelatech.com
>
>

