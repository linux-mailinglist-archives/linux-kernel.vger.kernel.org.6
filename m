Return-Path: <linux-kernel+bounces-204390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9683E8FE817
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 15:44:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB90D1F23C7E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 13:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEFBD196436;
	Thu,  6 Jun 2024 13:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AmaoXa8o"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBCDA195B10
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 13:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717681456; cv=none; b=gQpOSZPeJAbUmjY7pPNX7zAYC2GXdAxziAdivCHwvUP8sf+4MbtFSRYyGCaMOvOLxDshdyceJOzvEmwX2za8KwOWm2HrFRB4mpGwXCN5axA/g1ij/+O+2gZmPQ+dCAQ5PDnz8M3U+ME119rN7q6xNzoRIUd6+cstYVEgIrbQK1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717681456; c=relaxed/simple;
	bh=x70qrFP8YdgU6ZzDc2Qh0oJz2y3d+MS9LEsUTiW/pao=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=psPQ2nLnDZFJdkEkgflhWqc4noAVi9wsl03ULObVSNXEqpa+aMsQLjugEHwgUTckthu8hZHqE8YwzLqNr5QrhxyYSYuoboQMZ7ury0VwxU98830QegFKr0F8zWw3hmBUSG9bet57/wTti+yrHOqcYsZUTa2aoMLeVZRX3sCHJ0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AmaoXa8o; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717681453;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GIA4Xq4RyKQioAo4YvvYhNdjUMLqmaRaBnm9/IRRWjk=;
	b=AmaoXa8oQ0qgIC/4hZ1PG2kpdC67GbiY+jkHTkqX4d5CMdaCEywQe4y0H35e1Sac2dP2/u
	/9C2je0wkGW9HAw05wRZeP8+hMqUbWNLFLR4YOuLI0tcwMPFv67UNwVM7ehWiVZgc5gftY
	r8u9nMNdtYJI4mQjbj2Qe8b9kRh7H/k=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-128-JoUqdvjwM7O5BOEoXH6CoA-1; Thu, 06 Jun 2024 09:44:12 -0400
X-MC-Unique: JoUqdvjwM7O5BOEoXH6CoA-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2c1afd956a6so899212a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 06:44:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717681450; x=1718286250;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GIA4Xq4RyKQioAo4YvvYhNdjUMLqmaRaBnm9/IRRWjk=;
        b=soAOG+AMu6vySK2j1nO/Y7PgupKPaxEMu5SpJbx9dV2mun2zy2EygwwWRj2ZPEQBnY
         9AI3LzWlAxbTHPbAfkSHCBaCr06LsX//L2lFOLlIR2ClI3FJvdstLarSkchQw+85pDwL
         DjlXCfk5Qqc9Kb0nceRyKi0F8QvCskHRJYPzBW+g3RjnBxe20WgUwd6r+un6k8EzZZJ/
         xnekHE2nrWOb3yulBSZ41s+Ef/oiPxK1gQkqRIapUCPpnIcTArpo6X9oOrli6i0LZ+jP
         vtGDXKBqGAE2ZJdfM+mEnwH2qtAXqFPuN5fcUeNAxGSH4fzkWfDLSvoFTWaM5HXXxKjS
         iPiQ==
X-Forwarded-Encrypted: i=1; AJvYcCWbfgBwMfAZf8zy7BefqqQDpot/dUdBt8Xkm8UxetG/OUPBg8eWkGivjxoIR21F0M7iHYX9hXPktUXeWbo3sNRzlB9PFJn4djg7Q2OV
X-Gm-Message-State: AOJu0YzpNZczdfe8FuswYBWMR/kahQ6OjG0R7q4nFgncWezwHLi/e9oI
	hiJvosnmTJM+/CgeWR0Ty6F26Mm64LJjtSsm2ndvDtkvJC9yDJrLzSfHoniHGunfeckhx1Iy++1
	JOpsCJ1GG2X3evKgAf8Pg8bCtMIxCMjl092Ji80nxdhL5LMVPQbOkHshIwHX6e82a/JQVYY4qAy
	ZPUDgkCKvz1C1bPafq4lueg6vu3X8L320haNNXrZQB++S6vaSeYtcV
X-Received: by 2002:a17:90a:7e95:b0:2c1:e486:c9bb with SMTP id 98e67ed59e1d1-2c27db21f80mr5648903a91.21.1717681450321;
        Thu, 06 Jun 2024 06:44:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEDRD8+qgvAJZCTig5Pgkkjgd/Hg4BvP9a/4Dqjhg2GjacgNtk5c+zymrkVs1r8eRSMUsoa+h8I//w0u8PwfXc=
X-Received: by 2002:a17:90a:7e95:b0:2c1:e486:c9bb with SMTP id
 98e67ed59e1d1-2c27db21f80mr5648878a91.21.1717681449872; Thu, 06 Jun 2024
 06:44:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240529095313.2568595-1-linan666@huaweicloud.com>
 <Zl0QpCbYVHIkKa/H@fedora> <225f4c8e-0e2c-8f4b-f87d-69f4677af572@huaweicloud.com>
 <CAGVVp+XD5MbYOWL4pbLMxXL0yNKO5NJ84--=KVnW6w5-GF7Drw@mail.gmail.com>
 <918f128b-f752-2d66-ca60-7d9c711ed928@huaweicloud.com> <CAGVVp+V6XGmE_LyOYM3z8cEOzkvQZy=2Fnr5V3G4+DchxAz3Qw@mail.gmail.com>
 <ZmA0Se+t/LZihBKp@fedora> <CAGVVp+WoBochfQvLgAVbpWFv6JVAfQVkPwWDG8mBxqgGK-NDbg@mail.gmail.com>
 <2c46587e-0621-b21e-fbc1-fd69e87def03@huaweicloud.com>
In-Reply-To: <2c46587e-0621-b21e-fbc1-fd69e87def03@huaweicloud.com>
From: Changhui Zhong <czhong@redhat.com>
Date: Thu, 6 Jun 2024 21:43:58 +0800
Message-ID: <CAGVVp+WdWxAZdhpuDTuMvb+JvX-Ji9B+A4+Pv49JXLiXM++DHQ@mail.gmail.com>
Subject: Re: [PATCH] ublk_drv: fix NULL pointer dereference in ublk_ctrl_start_recovery()
To: Li Nan <linan666@huaweicloud.com>
Cc: Ming Lei <ming.lei@redhat.com>, axboe@kernel.dk, ZiyangZhang@linux.alibaba.com, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, yukuai3@huawei.com, 
	yi.zhang@huawei.com, houtao1@huawei.com, yangerkun@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 6, 2024 at 4:05=E2=80=AFPM Li Nan <linan666@huaweicloud.com> wr=
ote:
>
>
>
> =E5=9C=A8 2024/6/6 12:48, Changhui Zhong =E5=86=99=E9=81=93:
>
> [...]
>
> >>
> >> Hi Changhui,
> >>
> >> The hang is actually expected because recovery fails.
> >>
> >> Please pull the latest ublksrv and check if the issue can still be
> >> reproduced:
> >>
> >> https://github.com/ublk-org/ublksrv
> >>
> >> BTW, one ublksrv segfault and two test cleanup issues are fixed.
> >>
> >> Thanks,
> >> Ming
> >>
> >
> > Hi,Ming and Nan
> >
> > after applying the new patch and pulling the latest ublksrv,
> > I ran the test for 4 hours and did not observe any task hang.
> > the test results looks good=EF=BC=81
> >
> > Thanks=EF=BC=8C
> > Changhui
> >
> >
> > .
>
> Thanks for you test!
>
> However, I got a NULL pointer dereference bug with ublksrv. It is not
> introduced by this patch. It seems io was issued after deleting disk. And
> it can be reproduced by:
>
>    while true; do make test T=3Dgeneric/004; done
>

Hi,Nan

I can not reproduce this issue with repo
https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/log/?=
h=3Dfor-next
,
which kernel repo do you using for test?

Thanks,
Changhui

> [ 1524.286485] running generic/004
> [ 1529.110875] blk_print_req_error: 109 callbacks suppressed
> [ 1529.110881] I/O error, dev ublkb0, sector 164512 op 0x0:(READ) flags 0=
x0
> phys_seg 9 prio class 0
> [ 1529.113801] I/O error, dev ublkb0, sector 161000 op 0x0:(READ) flags 0=
x0
> phys_seg 6 prio class 0
> [ 1529.114711] I/O error, dev ublkb0, sector 164576 op 0x1:(WRITE) flags
> 0x8800 phys_seg 7 prio class 0
> [ 1529.117441] I/O error, dev ublkb0, sector 164632 op 0x1:(WRITE) flags
> 0x8800 phys_seg 8 prio class 0
> [ 1529.118400] I/O error, dev ublkb0, sector 164584 op 0x0:(READ) flags 0=
x0
> phys_seg 8 prio class 0
> [ 1529.119314] I/O error, dev ublkb0, sector 161176 op 0x1:(WRITE) flags
> 0x8800 phys_seg 10 prio class 0
> [ 1529.120274] I/O error, dev ublkb0, sector 165136 op 0x1:(WRITE) flags
> 0x8800 phys_seg 6 prio class 0
> [ 1529.121213] I/O error, dev ublkb0, sector 165184 op 0x1:(WRITE) flags
> 0x8800 phys_seg 10 prio class 0
> [ 1529.122166] I/O error, dev ublkb0, sector 161256 op 0x1:(WRITE) flags
> 0x8800 phys_seg 5 prio class 0
> [ 1529.123101] I/O error, dev ublkb0, sector 161048 op 0x0:(READ) flags 0=
x0
> phys_seg 11 prio class 0
> [ 1536.366869] blk_print_req_error: 181 callbacks suppressed
> [ 1536.366885] I/O error, dev ublkb0, sector 181496 op 0x1:(WRITE) flags
> 0x8800 phys_seg 9 prio class 0
> [ 1536.368449] I/O error, dev ublkb0, sector 181568 op 0x1:(WRITE) flags
> 0x8800 phys_seg 5 prio class 0
> [ 1536.369398] I/O error, dev ublkb0, sector 181608 op 0x1:(WRITE) flags
> 0x8800 phys_seg 10 prio class 0
> [ 1536.370351] I/O error, dev ublkb0, sector 180976 op 0x0:(READ) flags 0=
x0
> phys_seg 7 prio class 0
> [ 1536.371266] I/O error, dev ublkb0, sector 183696 op 0x1:(WRITE) flags
> 0x8800 phys_seg 9 prio class 0
> [ 1536.372217] I/O error, dev ublkb0, sector 175112 op 0x1:(WRITE) flags
> 0x8800 phys_seg 5 prio class 0
> [ 1536.373168] I/O error, dev ublkb0, sector 183768 op 0x1:(WRITE) flags
> 0x8800 phys_seg 8 prio class 0
> [ 1536.374120] I/O error, dev ublkb0, sector 175152 op 0x1:(WRITE) flags
> 0x8800 phys_seg 5 prio class 0
> [ 1536.375070] I/O error, dev ublkb0, sector 181032 op 0x0:(READ) flags 0=
x0
> phys_seg 8 prio class 0
> [ 1536.375977] I/O error, dev ublkb0, sector 181096 op 0x0:(READ) flags 0=
x0
> phys_seg 8 prio class 0
> [ 1541.171010] BUG: kernel NULL pointer dereference, address: 00000000000=
00000
> [ 1541.171734] #PF: supervisor write access in kernel mode
> [ 1541.172271] #PF: error_code(0x0002) - not-present page
> [ 1541.172798] PGD 0 P4D 0
> [ 1541.173065] Oops: Oops: 0002 [#1] PREEMPT SMP
> [ 1541.173515] CPU: 0 PID: 43707 Comm: ublk Not tainted
> 6.9.0-next-20240523-00004-g9bc7e95c7323 #454
> [ 1541.174417] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIO=
S
> 1.16.1-2.fc37 04/01/2014
> [ 1541.175311] RIP: 0010:io_fallback_tw+0x252/0x300
> [ 1541.175808] Code: ff 48 83 05 ef 7f 45 0c 01 e9 f7 fe ff ff 5b 48 83 0=
5
> 31 80 45 0c 01 5d 41 5c 41 5d c3 48 83 05 0b 4d 45 0c 01 49 8b 44 24 20
> <3e> 48 83 0c
> [ 1541.177682] RSP: 0018:ffffc900036bbd00 EFLAGS: 00010202
> [ 1541.178221] RAX: 0000000000000000 RBX: 0000000000000000 RCX:
> 0000000000100001
> [ 1541.178947] RDX: ffff888177180000 RSI: 0000000000000001 RDI:
> ffff88817727d000
> [ 1541.179669] RBP: ffff8881345da290 R08: 0000000000100001 R09:
> 0000000000000000
> [ 1541.180393] R10: 0000000000000000 R11: 0000000000000000 R12:
> ffff888173324800
> [ 1541.181120] R13: 0000000000000001 R14: ffff888177180000 R15:
> 0000000000000008
> [ 1541.181852] FS:  0000000000000000(0000) GS:ffff88842fc00000(0000)
> knlGS:0000000000000000
> [ 1541.182666] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 1541.183256] CR2: 0000000000000000 CR3: 00000001718bc004 CR4:
> 0000000000770ef0
> [ 1541.183978] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
> 0000000000000000
> [ 1541.184683] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
> 0000000000000400
> [ 1541.185392] PKRU: 55555554
> [ 1541.185668] Call Trace:
> [ 1541.185927]  <TASK>
> [ 1541.186148]  ? show_regs+0x83/0x90
> [ 1541.186497]  ? __die_body+0x22/0x90
> [ 1541.186862]  ? __die+0x35/0x50
> [ 1541.187184]  ? page_fault_oops+0x1cc/0x630
> [ 1541.187604]  ? pick_eevdf+0x65/0x210
> [ 1541.187979]  ? check_preempt_wakeup_fair+0x283/0x300
> [ 1541.188483]  ? xfs_iext_lookup_extent+0xa4/0x2e0
> [ 1541.188967]  ? do_user_addr_fault+0x118/0xab0
> [ 1541.189418]  ? exc_page_fault+0xde/0x390
> [ 1541.189825]  ? asm_exc_page_fault+0x22/0x30
> [ 1541.190247]  ? io_fallback_tw+0x252/0x300
> [ 1541.190652]  tctx_task_work_run+0x181/0x1c0
> [ 1541.191090]  tctx_task_work+0x3f/0x80
> [ 1541.191473]  task_work_run+0x81/0xf0
> [ 1541.191841]  do_exit+0x53e/0x1360
> [ 1541.192179]  ? tctx_task_work+0x3f/0x80
> [ 1541.192578]  do_group_exit+0x34/0xc0
> [ 1541.192953]  get_signal+0xe10/0xe20
> [ 1541.193317]  ? blk_finish_plug+0x30/0x50
> [ 1541.193730]  ? io_submit_sqes+0x9e0/0xd70
> [ 1541.194133]  arch_do_signal_or_restart+0x32/0x400
> [ 1541.194607]  ? __do_sys_io_uring_enter+0x170/0x8d0
> [ 1541.195097]  syscall_exit_to_user_mode+0x2a1/0x430
> [ 1541.195591]  do_syscall_64+0xb9/0x240
> [ 1541.195973]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
> [ 1541.196489] RIP: 0033:0x7fcc6c8b34a5
> [ 1541.196863] Code: Unable to access opcode bytes at 0x7fcc6c8b347b.
> [ 1541.197490] RSP: 002b:00007fcc6c1ffd38 EFLAGS: 00000202 ORIG_RAX:
> 00000000000001aa
> [ 1541.198257] RAX: 000000000000003c RBX: 0000000000000000 RCX:
> 00007fcc6c8b34a5
> [ 1541.198984] RDX: 0000000000000001 RSI: 000000000000003c RDI:
> 0000000000000000
> [ 1541.199711] RBP: 00007fcc64002f68 R08: 00007fcc6c1ffd70 R09:
> 0000000000000018
> [ 1541.200438] R10: 0000000000000019 R11: 0000000000000202 R12:
> 00007fcc6c1ffd90
> [ 1541.201165] R13: 0000000000000000 R14: 0000000000000000 R15:
> 00000000000001aa
> [ 1541.202228]  </TASK>
> [ 1541.202465] Modules linked in:
> [ 1541.202798] CR2: 0000000000000000
> [ 1541.203143] ---[ end trace 0000000000000000 ]---
>
> --
> Thanks,
> Nan
>


