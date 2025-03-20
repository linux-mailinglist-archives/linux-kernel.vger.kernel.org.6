Return-Path: <linux-kernel+bounces-570333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91C5EA6AF01
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 21:12:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFA5746141F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 20:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8D49229B0D;
	Thu, 20 Mar 2025 20:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UUo/Z9xC"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074C0227B9C
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 20:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742501534; cv=none; b=qIRFUpFfisWKyeJe4ryyRaVjOYvpABjV09LwDrOU8xMdvkE/Y+yl2rYm/Lj3PEBBmHjZ3sy6Dnuxnmf5cgAjDXhuvUeN2eC+suOS3UhXBO96aFSfcEJN4fq2IL190mq2mSZwkuKGJUfaGnPO7DVLQTZHgdz0HP13L2HR9iy6sZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742501534; c=relaxed/simple;
	bh=hJgaGD33I/Fuf7SL4Wo85DCFL++qlz0TC4WRKFfmwiY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gcrC6TdrCopDqli6i/j68oQebsIsXFtXSdwJCyp1YxrBY13We4DhRucQ8ssVp3EHk1JbRY7sxRNV9i/VcFRgs/ptk7e/uVBss1XZYJDTdgFSs1Enr6PI7KhbRofx5fL8pB8ErZuK11d6dog+cgLom/gis7Jq7umLJgdG1RE42pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UUo/Z9xC; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5e50bae0f5bso2816a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 13:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742501530; x=1743106330; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B1x4Sip77bRhKwudUrm/uxzVeVNaKyX906SjzDoUTfI=;
        b=UUo/Z9xCIXqtjQNLD5mHftG1p3tcCVJP72m3GLC7vpM83OvM7r5A4sxcBK1P5B/xbY
         7eaD+au7DZW+mp9VQ57N7gwU+GIvElB63oatc0AP7JL/Yto7YA5F72Ja0AxbnZOw5UIo
         k+gPoFlt71dVjDaWqUZgakliGNKHLwZOwiNQigW3FXb+OMh0nlxl9IMmaMuJ/DZQIyuH
         0/7fkO2l6Eki2unFP21eTOBw2p6yTFoJ7a9msYBD/7TpPgJGyvaJ63o3g0l8ddcProlW
         r4lW2yS6AURSro+3sbSz6vL1Y+kRQAUvgWz4EQecNNzU0clQ4YvzKmGJZXDKc+K5sIg+
         asYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742501530; x=1743106330;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B1x4Sip77bRhKwudUrm/uxzVeVNaKyX906SjzDoUTfI=;
        b=OEQwDTsMYhTcBY2S1aDzYjGeUtPHg4YLzQ2ncV+ZcgHscZoskfJs8Gj6EnTQ1n/iPG
         Yl12onNgil1ZbPKHsdjJlQhp11KtdV0Ag+8ggfAv/3VWInTW4ozucZqmnS3F0z0d2qya
         JSGIZC7JvQmgbZtq1ClJDvxGsow9ouHyxqEfJg6wsHg87BtQ7C5os7fEsPffledk9ueA
         gzzig9X6kQCH5yMzHxeclJuuxqjGdVsv/cWYjo1MJKXMWN+2ZCQLuemmxK1zwHPaoOuy
         SSPeIOBhaIjzLBkXQ00nE+LxUxqxcT7tbtlLZKlZhlucT7iUASuecNoL3+WQWDUB9qoP
         dsVg==
X-Forwarded-Encrypted: i=1; AJvYcCUKtMoUKwXK3esFMdR5VSnTkrzA/ms/R7gU5L2HQ4ap1epS6yhZ4AszH92S1nkO+/TwWzevWtw6fZbXWm8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoVPL3AQLe2QEZ32MZAAkkqHoXYbpZP8ucqOSu5PPw3kwybA0/
	dkWL6BGK7HRMBAduBE61IrNwNqG5uN3ahRDTxjGZmXLKuUAD1X3S7RXjqBlQRpORmNsdztk57j0
	+eKTNgwCUk0nrEf5tqo1EHujHGIbPM0Uq198i
X-Gm-Gg: ASbGnct+TI3R75USUBoOkMYf5EYWDnY4zt2aYiiEQtxTpq1CPfjR9XvLK+PiRJgAjKi
	jxrwOcgo5tESM/ARei0C0+1Ltso7kHDszhK7ln5HX0sqE6/jS018HVcKHOsHitGfRq8FSsdaace
	eJmwwaVTDYwK3C0aLOHyyMYYFPERROROqpbOF+3er0ptEY1VaCNCGytA==
X-Google-Smtp-Source: AGHT+IH3H/93GP64mI7VwpEHCKTXQc1J3spAOJr7x0UvpM61uGxO255UnFofpEt/8N8Vb04SGbDKq1hSDvyF4fDz95M=
X-Received: by 2002:aa7:d0d0:0:b0:5e4:9ee2:afe1 with SMTP id
 4fb4d7f45d1cf-5ebcd942a05mr24832a12.2.1742501529686; Thu, 20 Mar 2025
 13:12:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <67dc67f0.050a0220.25ae54.001e.GAE@google.com> <qn7ncujf5gkfmohf5qp3fdakrymhoapkscafqp5t2gulmgdqai@tuhu2igx33k4>
In-Reply-To: <qn7ncujf5gkfmohf5qp3fdakrymhoapkscafqp5t2gulmgdqai@tuhu2igx33k4>
From: Jann Horn <jannh@google.com>
Date: Thu, 20 Mar 2025 21:11:33 +0100
X-Gm-Features: AQ5f1Jqsf83O01Rsh9nBw38V4HH27C3Dj6gaC_Nt1u7DLeqczEG7OwPLeZzeLEo
Message-ID: <CAG48ez0S4hJyqY=zZB_AWqFKtD7KjipR22F_wz1QvWNY=3RDWA@mail.gmail.com>
Subject: Re: [syzbot] [mm?] BUG: unable to handle kernel paging request in vma_merge_existing_range
To: Pedro Falcato <pfalcato@suse.de>
Cc: syzbot <syzbot+20ed41006cf9d842c2b5@syzkaller.appspotmail.com>, 
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, 
	akpm@linux-foundation.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	syzkaller-bugs@googlegroups.com, vbabka@suse.cz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 20, 2025 at 9:02=E2=80=AFPM Pedro Falcato <pfalcato@suse.de> wr=
ote:
> On Thu, Mar 20, 2025 at 12:09:36PM -0700, syzbot wrote:
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    eb88e6bfbc0a Merge tag 'fsnotify_for_v6.14-rc7' of git:=
//g..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=3D11e6c83f980=
000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D77423669c2b=
8fa9
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3D20ed41006cf9d=
842c2b5
> > compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for=
 Debian) 2.40
> > userspace arch: i386
> >
> > Unfortunately, I don't have any reproducer for this issue yet.
> >
> > Downloadable assets:
> > disk image (non-bootable): https://storage.googleapis.com/syzbot-assets=
/7feb34a89c2a/non_bootable_disk-eb88e6bf.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/ded0ce69669f/vmli=
nux-eb88e6bf.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/6e6fa3c719e7=
/bzImage-eb88e6bf.xz
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the co=
mmit:
> > Reported-by: syzbot+20ed41006cf9d842c2b5@syzkaller.appspotmail.com
> >
> > RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
> > R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000000
> > R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> >  </TASK>
> > BUG: unable to handle page fault for address: fffffffffffffff4
> > #PF: supervisor read access in kernel mode
> > #PF: error_code(0x0000) - not-present page
> > PGD df84067 P4D df84067 PUD df86067 PMD 0
> > Oops: Oops: 0000 [#1] PREEMPT SMP KASAN NOPTI
> > CPU: 1 UID: 0 PID: 17805 Comm: syz.8.3237 Not tainted 6.14.0-rc6-syzkal=
ler-00212-geb88e6bfbc0a #0
> > Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-=
1.16.3-2~bpo12+1 04/01/2014
> > RIP: 0010:vma_merge_existing_range+0x266/0x2070 mm/vma.c:734
> > Code: e8 5f 25 ad ff 48 8b 14 24 48 b8 00 00 00 00 00 fc ff df 48 c1 ea=
 03 80 3c 02 00 0f 85 1c 19 00 00 48 8b 04 24 48 8b 74 24 08 <4c> 8b 38 4c =
89 ff e8 9f 1f ad ff 48 8b 44 24 08 49 39 c7 0f 83 db
> > RSP: 0000:ffffc9000319f988 EFLAGS: 00010246
> > RAX: fffffffffffffff4 RBX: ffffc9000319fae8 RCX: ffffffff820cd3e5
> > RDX: 1ffffffffffffffe RSI: 0000000080c2a000 RDI: 0000000000000005
> > RBP: 0000000080ce2000 R08: 0000000000000005 R09: 0000000000000000
> > R10: 0000000000000001 R11: 0000000000000001 R12: 0000000000000001
> > R13: ffffc9000319fb08 R14: ffff888025eddc98 R15: ffff88804eec0a00
> > FS:  0000000000000000(0000) GS:ffff88802b500000(0063) knlGS:00000000f51=
06b40
> > CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
> > CR2: fffffffffffffff4 CR3: 00000000614d6000 CR4: 0000000000352ef0
> > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > Call Trace:
> >  <TASK>
> >  vma_modify.constprop.0+0x87/0x410 mm/vma.c:1517
> >  vma_modify_flags_uffd+0x241/0x2e0 mm/vma.c:1598
> >  userfaultfd_clear_vma+0x91/0x130 mm/userfaultfd.c:1906
> >  userfaultfd_release_all+0x2ae/0x4c0 mm/userfaultfd.c:2024
> >  userfaultfd_release+0xf4/0x1c0 fs/userfaultfd.c:865
> >  __fput+0x3ff/0xb70 fs/file_table.c:464
> >  task_work_run+0x14e/0x250 kernel/task_work.c:227
> >  resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
> >  exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
> >  exit_to_user_mode_prepare include/linux/entry-common.h:329 [inline]
> >  __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
> >  syscall_exit_to_user_mode+0x27b/0x2a0 kernel/entry/common.c:218
> >  __do_fast_syscall_32+0x80/0x120 arch/x86/entry/common.c:390
> >  do_fast_syscall_32+0x32/0x80 arch/x86/entry/common.c:412
> >  entry_SYSENTER_compat_after_hwframe+0x84/0x8e
> > RIP: 0023:0xf7fe6579
> > Code: b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00=
 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 =
90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
> > RSP: 002b:00000000f510655c EFLAGS: 00000296 ORIG_RAX: 0000000000000135
> > RAX: 0000000000000001 RBX: 0000000080000180 RCX: 0000000000000001
> > RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> > RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
> > R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000000
> > R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> >  </TASK>
> > Modules linked in:
> > CR2: fffffffffffffff4
> > ---[ end trace 0000000000000000 ]---
> > RIP: 0010:vma_merge_existing_range+0x266/0x2070 mm/vma.c:734
> > Code: e8 5f 25 ad ff 48 8b 14 24 48 b8 00 00 00 00 00 fc ff df 48 c1 ea=
 03 80 3c 02 00 0f 85 1c 19 00 00 48 8b 04 24 48 8b 74 24 08 <4c> 8b 38 4c =
89 ff e8 9f 1f ad ff 48 8b 44 24 08 49 39 c7 0f 83 db
> > RSP: 0000:ffffc9000319f988 EFLAGS: 00010246
> > RAX: fffffffffffffff4 RBX: ffffc9000319fae8 RCX: ffffffff820cd3e5
> > RDX: 1ffffffffffffffe RSI: 0000000080c2a000 RDI: 0000000000000005
> > RBP: 0000000080ce2000 R08: 0000000000000005 R09: 0000000000000000
> > R10: 0000000000000001 R11: 0000000000000001 R12: 0000000000000001
> > R13: ffffc9000319fb08 R14: ffff888025eddc98 R15: ffff88804eec0a00
> > FS:  0000000000000000(0000) GS:ffff88802b500000(0063) knlGS:00000000f51=
06b40
> > CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
> > CR2: fffffffffffffff4 CR3: 00000000614d6000 CR4: 0000000000352ef0
> > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > ----------------
> > Code disassembly (best guess):
> >    0: e8 5f 25 ad ff          call   0xffad2564
> >    5: 48 8b 14 24             mov    (%rsp),%rdx
> >    9: 48 b8 00 00 00 00 00    movabs $0xdffffc0000000000,%rax
> >   10: fc ff df
> >   13: 48 c1 ea 03             shr    $0x3,%rdx
> >   17: 80 3c 02 00             cmpb   $0x0,(%rdx,%rax,1)
> >   1b: 0f 85 1c 19 00 00       jne    0x193d
> >   21: 48 8b 04 24             mov    (%rsp),%rax
> >   25: 48 8b 74 24 08          mov    0x8(%rsp),%rsi
> > * 2a: 4c 8b 38                mov    (%rax),%r15 <-- trapping instructi=
on
> >   2d: 4c 89 ff                mov    %r15,%rdi
> >   30: e8 9f 1f ad ff          call   0xffad1fd4
> >   35: 48 8b 44 24 08          mov    0x8(%rsp),%rax
> >   3a: 49 39 c7                cmp    %rax,%r15
> >   3d: 0f                      .byte 0xf
> >   3e: 83                      .byte 0x83
> >   3f: db                      .byte 0xdb
>
> Ahh, fun bug. This *seems* to be the bug:
>
> First, in vma_modify:
>
>         merged =3D vma_merge_existing_range(vmg);
>         if (merged)
>                 return merged;
>         if (vmg_nomem(vmg))
>                 return ERR_PTR(-ENOMEM);
>
> then, all the way up to userfaultfd_release_all (the return value propaga=
tes
> vma_modify -> vma_modify_flags_uffd -> userfaultfd_clear_vma):
>
>         prev =3D NULL;
>         for_each_vma(vmi, vma) {
>                 cond_resched();
>                 BUG_ON(!!vma->vm_userfaultfd_ctx.ctx ^
>                        !!(vma->vm_flags & __VM_UFFD_FLAGS));
>                 if (vma->vm_userfaultfd_ctx.ctx !=3D ctx) {
>                         prev =3D vma;
>                         continue;
>                 }
>
>                 vma =3D userfaultfd_clear_vma(&vmi, prev, vma,
>                                             vma->vm_start, vma->vm_end);
>                 prev =3D vma;
>         }
>
> So, if uffd gets an IS_ERR(vma), it keeps going and takes that vma as the=
 prev value,
> which leads to that ERR_PTR(-ENOMEM) deref crash (-12 =3D -ENOMEM =3D 0xf=
fffff4).
> This situation is kind of awkward because ->release() errors don't mean a=
 thing.
> So, I have another idea (pasting for syzbot) which might just be cromulen=
t.
> Untested, but thoughts?
>
> #syz test
>
> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> index d06453fa8aba..fb835d82eb84 100644
> --- a/mm/userfaultfd.c
> +++ b/mm/userfaultfd.c
> @@ -2023,6 +2023,8 @@ void userfaultfd_release_all(struct mm_struct *mm,
>
>                 vma =3D userfaultfd_clear_vma(&vmi, prev, vma,
>                                             vma->vm_start, vma->vm_end);
> +               if (WARN_ON(IS_ERR(vma)))
> +                       break;

If this WARN_ON() was ever actually hit, I think we'd leave dangling
pointers in VMAs? As much as Linus hates BUG_ON(), I personally think
that would be a situation warranting BUG_ON(), or at least
CHECK_DATA_CORRUPTION(). That said:

>                 prev =3D vma;
>         }
>         mmap_write_unlock(mm);
> diff --git a/mm/vma.c b/mm/vma.c
> index 71ca012c616c..b2167b7dc27d 100644
> --- a/mm/vma.c
> +++ b/mm/vma.c
> @@ -1517,8 +1517,16 @@ static struct vm_area_struct *vma_modify(struct vm=
a_merge_struct *vmg)
>         merged =3D vma_merge_existing_range(vmg);
>         if (merged)
>                 return merged;
> -       if (vmg_nomem(vmg))
> +       if (vmg_nomem(vmg)) {
> +               /* If we can avoid failing the whole modification
> +                * due to a merge OOM and validly keep going
> +                * (we're modifying the whole VMA), return vma intact.
> +                * It won't get merged, but such is life - we're avoiding
> +                * OOM conditions in other parts of mm/ this way */
> +               if (start <=3D vma->vm_start && end >=3D vma->vm_end)
> +                       return vma;
>                 return ERR_PTR(-ENOMEM);
> +       }

Along the lines of your idea, perhaps we could add a parameter "bool
never_fail" to vma_modify() that is passed through to
vma_merge_existing_range(), and guarantee that it never fails when
that parameter is set? Then we could also check that never_fail is
only used in cases where no split is necessary. That somewhat avoids
having this kind of check that only ever runs in error conditions...

