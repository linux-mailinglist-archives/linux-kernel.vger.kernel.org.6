Return-Path: <linux-kernel+bounces-341668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B636998834D
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 13:28:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C0D528158C
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 11:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5F8B189B88;
	Fri, 27 Sep 2024 11:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TKNPEhn2"
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC8A188CA8
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 11:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727436478; cv=none; b=U9yt6+m48Alkde0JWtowMS9GOdqQNMarB4Zn+J1GoN3Ev69jJj4tcg7wkttQV86gDWzgn+X8vL0O5lEeygN9krv3SX0n9PwnGnR1vY7tWQUEOdholXQXDlOckfMWjDN6dhRCMC75pdsWK1oRKkp9J67JBoP5hCHuzBCSFVCvMi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727436478; c=relaxed/simple;
	bh=8B+ad1Q/3+1zp07eWXPadLYR5Rd10n7gDBoh3D3c0yY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c1g4T6ydPGhlpnQnOipsHkxghSgkEXrucnwSthEJtp8W38tvuvm4vmHH/WEv7raY2POCtXwsA3Iz+ONtFzPRskjdTabbQqtVz75O1MlrDf6v7rAKEPEUSNjPiV7B6H26mRxmLQrzzYMbeZBB7Tg6Nxa+v6cM7IGbJOL4LD/rzrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TKNPEhn2; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-82ce603d8b5so90178139f.0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 04:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727436475; x=1728041275; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R3pQvLMxC++GIolwaaxcqiogay+HHl6HUusxRKHaOW4=;
        b=TKNPEhn2qxrwue68jV+gVkLl6WmveLE4aPgGvnVvRPSToo7l75lJKqklVTUeE63w41
         CSOQESrNwbfdPeCAPd5uBiuGHKtRhkJVZCXP+JtT+n3XFUXOigZ3KnpE2buC843Imc5q
         KmqJM5e1Bh7M+G6bdWIFjBhLlo6+YaQRqbGJS8FGK80W6gmyLuici0pHgBUHZ8QCFELz
         +PX1NRmJIfhdQ36j0tyBty/lDKgGBJcRB5iZC0c7aFK4NutcDXbYED4vunR9B3f1F7jf
         7nGG/hmQoiRfAl45+ksZc6CfcUsMRKDkfHyjIrLSY+kKtmey3nWcAcL47UEXBLh6nbgX
         twTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727436475; x=1728041275;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R3pQvLMxC++GIolwaaxcqiogay+HHl6HUusxRKHaOW4=;
        b=gAhBA64Y1RgbI6MbFYwFrSOJskc0Ho7awuYAdYBo7IaC9w6PjyNcMHSWhs3/AXUmaE
         NcIcKsBpyRSgnCu7qqA0jvDit2EWwA1L3L0irDElyF2cfj334xUx2kdXICK+LwIEZH6e
         vFmHgsCSbSCFmE97+/IqwXT66C4T3xZmv2mi8jckC1yaUZuOSBgWE7XsNIx9zIg970+x
         lcYDV/CaFuJycN2EZV33OUp083UBHceXpR0nvA9P0PvkujOaomeC1HciE6YMdTjHuAsg
         oxvkkeilvMRbXEkz8+FSLXempvMeDIcJ+OXPHCq7bG8c1chxMpGe0sOpdoSU4jTaUszR
         k0hQ==
X-Forwarded-Encrypted: i=1; AJvYcCVIB8einYLynLmuBPRJ10nAD6wyNYmGho+E4bbdOtdi37iSGVyrj8eEwkEOUUcA3Lv4Xdbj223Eglgyay0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXokOPNhDNvQ9WVPFTllG69Norw4AwLLXikyw81DRe4FpHSYap
	2Lj4GJ56kH7PDFdbcGimisLMADmeg2YSriVA25AMqQTwR2fj6h530or+f4ZlhDYfWPG1w3POmUb
	qpGEdpUy8kA8aR1YxWk+IDmqlPDHLC/VYwhpA
X-Google-Smtp-Source: AGHT+IEHQPDSDbVFnq3KfVY8jOwatm+ukKo7jZ4GXrhV+MKR1PcVQVa40OnVm70WUVYVDvAS8PV5MVSYM3gwWYlMw5M=
X-Received: by 2002:a05:6602:6a8c:b0:831:fe52:c602 with SMTP id
 ca18e2360f4ac-8349327138amr272174539f.15.1727436475377; Fri, 27 Sep 2024
 04:27:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <66f5a0ca.050a0220.46d20.0002.GAE@google.com> <CANn89iKLTNs5LAuSz6xeKB39hQ2FOEJNmffZsv1F3iNHqXe0tQ@mail.gmail.com>
 <20240927110422.1084-1-hdanton@sina.com> <CANn89iLKhw-X-gzCJHgpEXe-1WuqTmSWLGOPf5oy1ZMkWyW9_w@mail.gmail.com>
In-Reply-To: <CANn89iLKhw-X-gzCJHgpEXe-1WuqTmSWLGOPf5oy1ZMkWyW9_w@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 27 Sep 2024 13:27:40 +0200
Message-ID: <CANn89iLGfEe6HM=2E1wjU89eeS1YwnPcCHpgZqQ=dWuaGV2k+A@mail.gmail.com>
Subject: Re: [syzbot] [net?] INFO: task hung in new_device_store (5)
To: Hillf Danton <hdanton@sina.com>
Cc: syzbot <syzbot+05f9cecd28e356241aba@syzkaller.appspotmail.com>, 
	linux-kernel@vger.kernel.org, 
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Boqun Feng <boqun.feng@gmail.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 27, 2024 at 1:24=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Fri, Sep 27, 2024 at 1:05=E2=80=AFPM Hillf Danton <hdanton@sina.com> w=
rote:
> >
> > On Thu, 26 Sep 2024 22:14:14 +0200 Eric Dumazet <edumazet@google.com>
> > > On Thu, Sep 26, 2024 at 7:58=E2=80=AFPM syzbot wrote:
> > > >
> > > > Hello,
> > > >
> > > > syzbot found the following issue on:
> > > >
> > > > HEAD commit:    97d8894b6f4c Merge tag 'riscv-for-linus-6.12-mw1' o=
f git:/..
> > > > git tree:       upstream
> > > > console output: https://syzkaller.appspot.com/x/log.txt?x=3D12416a2=
7980000
> > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dbc30a30=
374b0753
> > > > dashboard link: https://syzkaller.appspot.com/bug?extid=3D05f9cecd2=
8e356241aba
> > > > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils f=
or Debian) 2.40
> > > >
> > > > Unfortunately, I don't have any reproducer for this issue yet.
> > > >
> > > > Downloadable assets:
> > > > disk image: https://storage.googleapis.com/syzbot-assets/bd119f4fdc=
08/disk-97d8894b.raw.xz
> > > > vmlinux: https://storage.googleapis.com/syzbot-assets/4d0bfed66f93/=
vmlinux-97d8894b.xz
> > > > kernel image: https://storage.googleapis.com/syzbot-assets/0f9223ac=
9bfb/bzImage-97d8894b.xz
> > > >
> > > > IMPORTANT: if you fix the issue, please add the following tag to th=
e commit:
> > > > Reported-by: syzbot+05f9cecd28e356241aba@syzkaller.appspotmail.com
> > > >
> > > > INFO: task syz-executor:9916 blocked for more than 143 seconds.
> > > >       Not tainted 6.11.0-syzkaller-10045-g97d8894b6f4c #0
> > > > "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this me=
ssage.
> > > > task:syz-executor    state:D stack:21104 pid:9916  tgid:9916  ppid:=
1      flags:0x00000004
> > > > Call Trace:
> > > >  <TASK>
> > > >  context_switch kernel/sched/core.c:5315 [inline]
> > > >  __schedule+0x1895/0x4b30 kernel/sched/core.c:6674
> > > >  __schedule_loop kernel/sched/core.c:6751 [inline]
> > > >  schedule+0x14b/0x320 kernel/sched/core.c:6766
> > > >  schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6823
> > > >  __mutex_lock_common kernel/locking/mutex.c:684 [inline]
> > > >  __mutex_lock+0x6a7/0xd70 kernel/locking/mutex.c:752
> > > >  new_device_store+0x1b4/0x890 :166
> > > >  kernfs_fop_write_iter+0x3a2/0x500 fs/kernfs/file.c:334
> > > >  new_sync_write fs/read_write.c:590 [inline]
> > > >  vfs_write+0xa6f/0xc90 fs/read_write.c:683
> > > >  ksys_write+0x183/0x2b0 fs/read_write.c:736
> > > >  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> > > >  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
> > > >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > > > RIP: 0033:0x7f8310d7c9df
> > > > RSP: 002b:00007ffe830a52e0 EFLAGS: 00000293 ORIG_RAX: 0000000000000=
001
> > > > RAX: ffffffffffffffda RBX: 0000000000000005 RCX: 00007f8310d7c9df
> > > > RDX: 0000000000000003 RSI: 00007ffe830a5330 RDI: 0000000000000005
> > > > RBP: 00007f8310df1c39 R08: 0000000000000000 R09: 00007ffe830a5137
> > > > R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000003
> > > > R13: 00007ffe830a5330 R14: 00007f8311a64620 R15: 0000000000000003
> > > >  </TASK>
> > >
> > > typical sysfs deadlock ?
> > >
> > > diff --git a/drivers/net/netdevsim/bus.c b/drivers/net/netdevsim/bus.=
c
> > > index 64c0cdd31bf85468ce4fa2b2af5c8aff4cfba897..3bf0ce52d71653fd9b8c7=
52d52d0b5b7e19042d8
> > > 100644
> > > --- a/drivers/net/netdevsim/bus.c
> > > +++ b/drivers/net/netdevsim/bus.c
> > > @@ -163,7 +163,9 @@ new_device_store(const struct bus_type *bus, cons=
t
> > > char *buf, size_t count)
> > >                 return -EINVAL;
> > >         }
> > >
> > > -       mutex_lock(&nsim_bus_dev_list_lock);
> > > +       if (!mutex_trylock(&nsim_bus_dev_list_lock))
> > > +               return restart_syscall();
> > > +
> > >         /* Prevent to use resource before initialization. */
> > >         if (!smp_load_acquire(&nsim_bus_enable)) {
> > >                 err =3D -EBUSY;
> > >
> > >
> > > >
> > > > Showing all locks held in the system:
> > ...
> > > > 4 locks held by syz-executor/9916:
> > > >  #0: ffff88807ca86420 (sb_writers#8){.+.+}-{0:0}, at: file_start_wr=
ite include/linux/fs.h:2930 [inline]
> > > >  #0: ffff88807ca86420 (sb_writers#8){.+.+}-{0:0}, at: vfs_write+0x2=
24/0xc90 fs/read_write.c:679
> > > >  #1: ffff88802e71e488 (&of->mutex){+.+.}-{3:3}, at: kernfs_fop_writ=
e_iter+0x1ea/0x500 fs/kernfs/file.c:325
> > > >  #2: ffff888144ff5968 (kn->active#50){.+.+}-{0:0}, at: kernfs_fop_w=
rite_iter+0x20e/0x500 fs/kernfs/file.c:326
> > > >  #3: ffffffff8f56d3e8 (nsim_bus_dev_list_lock){+.+.}-{3:3}, at: new=
_device_store+0x1b4/0x890 drivers/net/netdevsim/bus.c:166
> >
> > syz-executor/9916 is lock waiter, and
> >
> > > > 7 locks held by syz-executor/9976:
> > > >  #0: ffff88807ca86420 (sb_writers#8){.+.+}-{0:0}, at: file_start_wr=
ite include/linux/fs.h:2930 [inline]
> > > >  #0: ffff88807ca86420 (sb_writers#8){.+.+}-{0:0}, at: vfs_write+0x2=
24/0xc90 fs/read_write.c:679
> > > >  #1: ffff88807abc2888 (&of->mutex){+.+.}-{3:3}, at: kernfs_fop_writ=
e_iter+0x1ea/0x500 fs/kernfs/file.c:325
> > > >  #2: ffff888144ff5a58 (kn->active#49){.+.+}-{0:0}, at: kernfs_fop_w=
rite_iter+0x20e/0x500 fs/kernfs/file.c:326
> > > >  #3: ffffffff8f56d3e8 (nsim_bus_dev_list_lock){+.+.}-{3:3}, at: del=
_device_store+0xfc/0x480 drivers/net/netdevsim/bus.c:216
> > > >  #4: ffff888060f5a0e8 (&dev->mutex){....}-{3:3}, at: device_lock in=
clude/linux/device.h:1014 [inline]
> > > >  #4: ffff888060f5a0e8 (&dev->mutex){....}-{3:3}, at: __device_drive=
r_lock drivers/base/dd.c:1095 [inline]
> > > >  #4: ffff888060f5a0e8 (&dev->mutex){....}-{3:3}, at: device_release=
_driver_internal+0xce/0x7c0 drivers/base/dd.c:1293
> > > >  #5: ffff888060f5b250 (&devlink->lock_key#40){+.+.}-{3:3}, at: nsim=
_drv_remove+0x50/0x160 drivers/net/netdevsim/dev.c:1672
> > > >  #6: ffffffff8fccdc48 (rtnl_mutex){+.+.}-{3:3}, at: nsim_destroy+0x=
71/0x5c0 drivers/net/netdevsim/netdev.c:773
> >
> > syz-executor/9976 is lock owner. Given both waiter and owner printed,
> > the proposed trylock looks like the typical paperover at least from a
> > hoofed skull because of no real deadlock detected.
>
> I suggest you look at why we have to use rtnl_trylock()
>
> If you know better, please send patches to remove all instances.

The real bug is that  drivers/net/netdevsim uses sysfs to create and
delete network devices, this was a poor choice.

