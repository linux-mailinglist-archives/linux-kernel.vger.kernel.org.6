Return-Path: <linux-kernel+bounces-517130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18598A37C7E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 08:49:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67FCC3A90EA
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 07:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 039F0192D70;
	Mon, 17 Feb 2025 07:49:08 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D9B715382E
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 07:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739778547; cv=none; b=H9fV64M5bzdoQwc0ZXF9WdoLIqXlvxpD43NFVEr8j/6O1JptFU+y0V9t9hJLYFYrP3iN8vm1J1Q6YxMyEQxSsYWOlfWSxa1LmZ/LlVZ7NW9W53Xhyf8htKnQ+dFKmbdmRaJ6gamx3X8Hqvon2FUTQzSpdb1+AWbqvaG6SUJ2a8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739778547; c=relaxed/simple;
	bh=PkIGx3xdUWeB/lwjT8ZJd4t+5kPoAkzHZsaol+qh+V0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=G7liWfRiM9yK99mQt3XYa94vh6fJQ3nXbdIliG3MX612a5te2DYAxHgXar6CkALu5yejJZGPOvw5434kB0NypfQl0JsnMiAK5lmzqVz0d6qFmJ7SdGs8CrkaZ1w6EIxV9va0yhpRYcFdk/BDeHY5rAO9bjxaM8/pcZdbp9oSmjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-851a991cf8bso332998239f.0
        for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2025 23:49:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739778544; x=1740383344;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TECz2zXvBDl4LBkQuaJ114CZBcWu8R2m8R3XsiCCzeg=;
        b=j+L+FylnWyD9hzeVHcpzMhYT7sYe6EaUAVbk93xuMhCTfLsCD26MWmiSU8KZ74fYwf
         DkY/W1XcQXUJrHTe7+N700a6XXRo3QHWN9Uo4VErljESE8wDYHf65+2+z3e/c9jLcrTQ
         NRtZrNopW4D03nkCuPiB6APJXKhcLIq2SR0LG4URymnPIyz34vqqbabZDM/cyDsh0pjR
         sU4agJuZYZDElZvoWoTNMI51KNfImruhBk5ASs0OE1C5uExIgdvz04LicKxEN2/7AgII
         B6lZBV3OVCCw/dGCnfmJNB0taQoKYQonWTa/IvAkSHxTa/twVEHbY4F0AeFWfNF8bTQk
         o2VA==
X-Gm-Message-State: AOJu0YzfHh2EKj2y6lDrhFGifBWNRM5oSJcicpWM1bPJx31s2Q2FJCwn
	laP3NIP0eKK3YGaSJNOyrWbTC9wUERU3Gfjnu24xgRa0INk/vE2ybT9KnIhai85Q/By8soCFfMY
	0Wl0tSIW3LZ1MSm7zprO+q+psvKWEivuUwPv/NTGoswBTMx302v9S95U=
X-Google-Smtp-Source: AGHT+IF7Vhm25I/gyux79Ait6vdbG7Tpl/nDgHw9yeILNsUijW6bXt+tArlFViR6omHJNVzMgoR5toGdkbma337oUvB9wAvytBsc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c89:b0:3d0:11a4:1f87 with SMTP id
 e9e14a558f8ab-3d281f87ae5mr49560295ab.7.1739778544236; Sun, 16 Feb 2025
 23:49:04 -0800 (PST)
Date: Sun, 16 Feb 2025 23:49:04 -0800
In-Reply-To: <20250217072635.2581421-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67b2e9f0.050a0220.173698.001e.GAE@google.com>
Subject: Re: [syzbot] [fs?] BUG: corrupted list in remove_wait_queue (2)
From: syzbot <syzbot+4e21d5f67b886a692b55@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, lizhi.xu@windriver.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

x64_sys_ppoll+0x10/0x10
[  290.731692][   T30]  do_syscall_64+0xcd/0x250
[  290.736222][   T30]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  290.742188][   T30] RIP: 0033:0x7f73a7655ad5
[  290.746833][   T30] RSP: 002b:00007ffe72d11e20 EFLAGS: 00000246 ORIG_RAX=
: 000000000000010f
[  290.755346][   T30] RAX: ffffffffffffffda RBX: 0000560ad729aee0 RCX: 000=
07f73a7655ad5
[  290.763447][   T30] RDX: 0000000000000000 RSI: 0000000000000003 RDI: 000=
0560ad729aec0
[  290.771556][   T30] RBP: 00007ffe72d12170 R08: 0000000000000008 R09: 000=
07f73a772db40
[  290.779578][   T30] R10: 00007ffe72d12170 R11: 0000000000000246 R12: 000=
0000000000000
[  290.787562][   T30] R13: 0000560aac154610 R14: 0000000000000003 R15: 000=
0000000000000
[  290.795697][   T30]  </TASK>
[  290.798731][   T30] Future hung task reports are suppressed, see sysctl =
kernel.hung_task_warnings
[  290.808055][   T30] INFO: task dhcpcd:5459 blocked for more than 147 sec=
onds.
[  290.815568][   T30]       Not tainted 6.14.0-rc3-syzkaller-g0ad2507d5d93=
-dirty #0
[  290.823253][   T30] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" d=
isables this message.
[  290.832145][   T30] task:dhcpcd          state:D stack:26496 pid:5459  t=
gid:5459  ppid:5455   task_flags:0x400140 flags:0x00000002
[  290.844203][   T30] Call Trace:
[  290.847520][   T30]  <TASK>
[  290.850575][   T30]  __schedule+0xf43/0x5890
[  290.855023][   T30]  ? __pfx___lock_acquire+0x10/0x10
[  290.860293][   T30]  ? __pfx___lock_acquire+0x10/0x10
[  290.865524][   T30]  ? __pfx___schedule+0x10/0x10
[  290.870478][   T30]  ? schedule+0x298/0x350
[  290.874855][   T30]  ? __pfx_lock_release+0x10/0x10
[  290.879964][   T30]  ? __mutex_trylock_common+0x78/0x250
[  290.885453][   T30]  ? lock_acquire+0x2f/0xb0
[  290.890068][   T30]  ? schedule+0x1fd/0x350
[  290.894446][   T30]  schedule+0xe7/0x350
[  290.898633][   T30]  schedule_preempt_disabled+0x13/0x30
[  290.904183][   T30]  __mutex_lock+0x6bd/0xb10
[  290.908716][   T30]  ? do_sys_poll+0x2d0/0xe00
[  290.913403][   T30]  ? __pfx___mutex_lock+0x10/0x10
[  290.918494][   T30]  ? __pfx_lock_release+0x10/0x10
[  290.923613][   T30]  ? trace_lock_acquire+0x14e/0x1f0
[  290.928841][   T30]  ? __might_fault+0xe3/0x190
[  290.933619][   T30]  ? do_sys_poll+0x2d0/0xe00
[  290.938227][   T30]  do_sys_poll+0x2d0/0xe00
[  290.942703][   T30]  ? kasan_save_stack+0x42/0x60
[  290.947598][   T30]  ? kasan_save_stack+0x33/0x60
[  290.952546][   T30]  ? kasan_save_track+0x14/0x30
[  290.957418][   T30]  ? kasan_save_free_info+0x3b/0x60
[  290.962730][   T30]  ? __kasan_slab_free+0x51/0x70
[  290.967708][   T30]  ? do_seccomp+0x7b6/0x2640
[  290.972379][   T30]  ? prctl_set_seccomp+0x4b/0x70
[  290.977354][   T30]  ? __pfx_do_sys_poll+0x10/0x10
[  290.982562][   T30]  ? __lock_acquire+0x15a9/0x3c40
[  290.987646][   T30]  ? _raw_spin_unlock_irq+0x23/0x50
[  290.993013][   T30]  ? lockdep_hardirqs_on+0x7c/0x110
[  290.998264][   T30]  ? _raw_spin_unlock_irq+0x2e/0x50
[  291.003613][   T30]  ? set_user_sigmask+0x217/0x2a0
[  291.008835][   T30]  ? __pfx_set_user_sigmask+0x10/0x10
[  291.014322][   T30]  ? __pfx___seccomp_filter+0x10/0x10
[  291.019761][   T30]  __x64_sys_ppoll+0x25a/0x2d0
[  291.024530][   T30]  ? __pfx___x64_sys_ppoll+0x10/0x10
[  291.029895][   T30]  ? __secure_computing+0x273/0x3f0
[  291.035156][   T30]  do_syscall_64+0xcd/0x250
[  291.039834][   T30]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  291.045747][   T30] RIP: 0033:0x7f73a7655ad5
[  291.050246][   T30] RSP: 002b:00007ffe72d11e20 EFLAGS: 00000246 ORIG_RAX=
: 000000000000010f
[  291.058866][   T30] RAX: ffffffffffffffda RBX: 0000560ad729aee0 RCX: 000=
07f73a7655ad5
[  291.066939][   T30] RDX: 0000000000000000 RSI: 0000000000000004 RDI: 000=
0560ad72a3fe0
[  291.074970][   T30] RBP: 00007ffe72d12170 R08: 0000000000000008 R09: 000=
0560aac1543d0
[  291.083120][   T30] R10: 00007ffe72d12170 R11: 0000000000000246 R12: 000=
0000000000000
[  291.091194][   T30] R13: 0000560aac154610 R14: 0000000000000003 R15: 000=
0000000000000
[  291.099293][   T30]  </TASK>
[  291.102341][   T30] Future hung task reports are suppressed, see sysctl =
kernel.hung_task_warnings
[  291.111627][   T30] INFO: task dhcpcd:5460 blocked for more than 147 sec=
onds.
[  291.118925][   T30]       Not tainted 6.14.0-rc3-syzkaller-g0ad2507d5d93=
-dirty #0
[  291.126598][   T30] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" d=
isables this message.
[  291.135463][   T30] task:dhcpcd          state:D stack:26832 pid:5460  t=
gid:5460  ppid:5455   task_flags:0x400140 flags:0x00000002
[  291.147505][   T30] Call Trace:
[  291.150846][   T30]  <TASK>
[  291.153773][   T30]  __schedule+0xf43/0x5890
[  291.158186][   T30]  ? __pfx___lock_acquire+0x10/0x10
[  291.163449][   T30]  ? __pfx___lock_acquire+0x10/0x10
[  291.168881][   T30]  ? __pfx___schedule+0x10/0x10
[  291.173882][   T30]  ? schedule+0x298/0x350
[  291.178244][   T30]  ? __pfx_lock_release+0x10/0x10
[  291.183389][   T30]  ? __mutex_trylock_common+0x78/0x250
[  291.188915][   T30]  ? lock_acquire+0x2f/0xb0
[  291.193503][   T30]  ? schedule+0x1fd/0x350
[  291.197860][   T30]  schedule+0xe7/0x350
[  291.202004][   T30]  schedule_preempt_disabled+0x13/0x30
[  291.207504][   T30]  __mutex_lock+0x6bd/0xb10
[  291.212094][   T30]  ? do_sys_poll+0x2d0/0xe00
[  291.216708][   T30]  ? __pfx___mutex_lock+0x10/0x10
[  291.221799][   T30]  ? __pfx_lock_release+0x10/0x10
[  291.226843][   T30]  ? trace_lock_acquire+0x14e/0x1f0
[  291.232148][   T30]  ? __might_fault+0xe3/0x190
[  291.236868][   T30]  ? do_sys_poll+0x2d0/0xe00
[  291.241634][   T30]  do_sys_poll+0x2d0/0xe00
[  291.246100][   T30]  ? kasan_save_stack+0x42/0x60
[  291.251100][   T30]  ? kasan_save_stack+0x33/0x60
[  291.255986][   T30]  ? kasan_save_track+0x14/0x30
[  291.260988][   T30]  ? kasan_save_free_info+0x3b/0x60
[  291.266242][   T30]  ? __kasan_slab_free+0x51/0x70
[  291.271273][   T30]  ? do_seccomp+0x7b6/0x2640
[  291.275883][   T30]  ? prctl_set_seccomp+0x4b/0x70
[  291.280932][   T30]  ? __pfx_do_sys_poll+0x10/0x10
[  291.285992][   T30]  ? __lock_acquire+0x15a9/0x3c40
[  291.291144][   T30]  ? _raw_spin_unlock_irq+0x23/0x50
[  291.296382][   T30]  ? lockdep_hardirqs_on+0x7c/0x110
[  291.301644][   T30]  ? _raw_spin_unlock_irq+0x2e/0x50
[  291.306873][   T30]  ? set_user_sigmask+0x217/0x2a0
[  291.312079][   T30]  ? __pfx_set_user_sigmask+0x10/0x10
[  291.317479][   T30]  ? __pfx___seccomp_filter+0x10/0x10
[  291.322906][   T30]  __x64_sys_ppoll+0x25a/0x2d0
[  291.327720][   T30]  ? __pfx___x64_sys_ppoll+0x10/0x10
[  291.333098][   T30]  ? __secure_computing+0x273/0x3f0
[  291.338322][   T30]  do_syscall_64+0xcd/0x250
[  291.342906][   T30]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  291.348835][   T30] RIP: 0033:0x7f73a7655ad5
[  291.353323][   T30] RSP: 002b:00007ffe72d11e20 EFLAGS: 00000246 ORIG_RAX=
: 000000000000010f
[  291.361809][   T30] RAX: ffffffffffffffda RBX: 0000560ad729aee0 RCX: 000=
07f73a7655ad5
[  291.369858][   T30] RDX: 0000000000000000 RSI: 0000000000000005 RDI: 000=
0560ad72a3fe0
[  291.377851][   T30] RBP: 00007ffe72d12170 R08: 0000000000000008 R09: 000=
0560aac1543d0
[  291.385916][   T30] R10: 00007ffe72d12170 R11: 0000000000000246 R12: 000=
0000000000000
[  291.393989][   T30] R13: 0000560aac154610 R14: 0000000000000003 R15: 000=
0000000000000
[  291.402027][   T30]  </TASK>
[  291.405086][   T30] Future hung task reports are suppressed, see sysctl =
kernel.hung_task_warnings
[  291.414264][   T30]=20
[  291.414264][   T30] Showing all locks held in the system:
[  291.422038][   T30] 1 lock held by khungtaskd/30:
[  291.426879][   T30]  #0: ffffffff8e1bc140 (rcu_read_lock){....}-{1:3}, a=
t: debug_show_all_locks+0x7f/0x390
[  291.436858][   T30] 1 lock held by udevd/5211:
[  291.441501][   T30]  #0: ffffffff8e3c1a48 (syspoll_lock){+.+.}-{4:4}, at=
: do_sys_poll+0x2d0/0xe00
[  291.450767][   T30] 1 lock held by udevd/5212:
[  291.455375][   T30]  #0: ffffffff8e3c1a48 (syspoll_lock){+.+.}-{4:4}, at=
: do_sys_poll+0x2d0/0xe00
[  291.464517][   T30] 1 lock held by udevd/5213:
[  291.469156][   T30]  #0: ffffffff8e3c1a48 (syspoll_lock){+.+.}-{4:4}, at=
: do_sys_poll+0x2d0/0xe00
[  291.478241][   T30] 1 lock held by udevd/5214:
[  291.482870][   T30]  #0: ffffffff8e3c1a48 (syspoll_lock){+.+.}-{4:4}, at=
: do_sys_poll+0x2d0/0xe00
[  291.492033][   T30] 1 lock held by udevd/5215:
[  291.496615][   T30]  #0: ffffffff8e3c1a48 (syspoll_lock){+.+.}-{4:4}, at=
: do_sys_poll+0x2d0/0xe00
[  291.505760][   T30] 1 lock held by udevd/5216:
[  291.510433][   T30]  #0: ffffffff8e3c1a48 (syspoll_lock){+.+.}-{4:4}, at=
: do_sys_poll+0x2d0/0xe00
[  291.519700][   T30] 1 lock held by udevd/5217:
[  291.524339][   T30]  #0: ffffffff8e3c1a48 (syspoll_lock){+.+.}-{4:4}, at=
: do_sys_poll+0x2d0/0xe00
[  291.533509][   T30] 1 lock held by udevd/5218:
[  291.538130][   T30]  #0: ffffffff8e3c1a48 (syspoll_lock){+.+.}-{4:4}, at=
: do_sys_poll+0x2d0/0xe00
[  291.547238][   T30] 1 lock held by udevd/5219:
[  291.551886][   T30]  #0: ffffffff8e3c1a48 (syspoll_lock){+.+.}-{4:4}, at=
: do_sys_poll+0x2d0/0xe00
[  291.561003][   T30] 1 lock held by udevd/5220:
[  291.565599][   T30]  #0: ffffffff8e3c1a48 (syspoll_lock){+.+.}-{4:4}, at=
: do_sys_poll+0x2d0/0xe00
[  291.574739][   T30] 1 lock held by udevd/5221:
[  291.579362][   T30]  #0: ffffffff8e3c1a48 (syspoll_lock){+.+.}-{4:4}, at=
: do_sys_poll+0x2d0/0xe00
[  291.588420][   T30] 1 lock held by udevd/5222:
[  291.593070][   T30]  #0: ffffffff8e3c1a48 (syspoll_lock){+.+.}-{4:4}, at=
: do_sys_poll+0x2d0/0xe00
[  291.602195][   T30] 1 lock held by dhcpcd/5439:
[  291.606873][   T30]  #0: ffffffff8e3c1a48 (syspoll_lock){+.+.}-{4:4}, at=
: do_sys_poll+0x2d0/0xe00
[  291.616059][   T30] 1 lock held by dhcpcd/5455:
[  291.620790][   T30]  #0: ffffffff8e3c1a48 (syspoll_lock){+.+.}-{4:4}, at=
: do_sys_poll+0x2d0/0xe00
[  291.629941][   T30] 1 lock held by dhcpcd/5456:
[  291.634625][   T30]  #0: ffffffff8e3c1a48 (syspoll_lock){+.+.}-{4:4}, at=
: do_sys_poll+0x2d0/0xe00
[  291.643772][   T30] 1 lock held by dhcpcd/5459:
[  291.648458][   T30]  #0: ffffffff8e3c1a48 (syspoll_lock){+.+.}-{4:4}, at=
: do_sys_poll+0x2d0/0xe00
[  291.657626][   T30] 1 lock held by dhcpcd/5460:
[  291.662340][   T30]  #0: ffffffff8e3c1a48 (syspoll_lock){+.+.}-{4:4}, at=
: do_sys_poll+0x2d0/0xe00
[  291.671689][   T30]=20
[  291.674036][   T30] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
[  291.674036][   T30]=20
[  291.682563][   T30] NMI backtrace for cpu 1
[  291.682578][   T30] CPU: 1 UID: 0 PID: 30 Comm: khungtaskd Not tainted 6=
.14.0-rc3-syzkaller-g0ad2507d5d93-dirty #0
[  291.682600][   T30] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 12/27/2024
[  291.682611][   T30] Call Trace:
[  291.682617][   T30]  <TASK>
[  291.682625][   T30]  dump_stack_lvl+0x116/0x1f0
[  291.682658][   T30]  nmi_cpu_backtrace+0x27b/0x390
[  291.682690][   T30]  ? __pfx_nmi_raise_cpu_backtrace+0x10/0x10
[  291.682715][   T30]  nmi_trigger_cpumask_backtrace+0x29c/0x300
[  291.682737][   T30]  watchdog+0xf62/0x12b0
[  291.682768][   T30]  ? __pfx_watchdog+0x10/0x10
[  291.682793][   T30]  ? lockdep_hardirqs_on+0x7c/0x110
[  291.682821][   T30]  ? __kthread_parkme+0x148/0x220
[  291.682854][   T30]  ? __pfx_watchdog+0x10/0x10
[  291.682882][   T30]  kthread+0x3af/0x750
[  291.682906][   T30]  ? __pfx_kthread+0x10/0x10
[  291.682933][   T30]  ? __pfx_kthread+0x10/0x10
[  291.682957][   T30]  ret_from_fork+0x45/0x80
[  291.682984][   T30]  ? __pfx_kthread+0x10/0x10
[  291.683004][   T30]  ret_from_fork_asm+0x1a/0x30
[  291.683036][   T30]  </TASK>
[  291.683044][   T30] Sending NMI from CPU 1 to CPUs 0:
[  291.795725][    C0] NMI backtrace for cpu 0 skipped: idling at acpi_safe=
_halt+0x1a/0x20
[  291.796705][   T30] Kernel panic - not syncing: hung_task: blocked tasks
[  291.796720][   T30] CPU: 1 UID: 0 PID: 30 Comm: khungtaskd Not tainted 6=
.14.0-rc3-syzkaller-g0ad2507d5d93-dirty #0
[  291.796745][   T30] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 12/27/2024
[  291.796759][   T30] Call Trace:
[  291.796767][   T30]  <TASK>
[  291.796776][   T30]  dump_stack_lvl+0x3d/0x1f0
[  291.796811][   T30]  panic+0x71d/0x800
[  291.796833][   T30]  ? __pfx_panic+0x10/0x10
[  291.796853][   T30]  ? __pfx__printk+0x10/0x10
[  291.796878][   T30]  ? ret_from_fork_asm+0x1a/0x30
[  291.796908][   T30]  ? irq_work_claim+0x76/0xa0
[  291.796936][   T30]  ? __pfx_nmi_raise_cpu_backtrace+0x10/0x10
[  291.796963][   T30]  ? irq_work_queue+0x2a/0x80
[  291.796990][   T30]  ? watchdog+0xdcc/0x12b0
[  291.797018][   T30]  ? watchdog+0xdbf/0x12b0
[  291.797049][   T30]  watchdog+0xddd/0x12b0
[  291.797082][   T30]  ? __pfx_watchdog+0x10/0x10
[  291.797108][   T30]  ? lockdep_hardirqs_on+0x7c/0x110
[  291.797136][   T30]  ? __kthread_parkme+0x148/0x220
[  291.797169][   T30]  ? __pfx_watchdog+0x10/0x10
[  291.797197][   T30]  kthread+0x3af/0x750
[  291.797222][   T30]  ? __pfx_kthread+0x10/0x10
[  291.797250][   T30]  ? __pfx_kthread+0x10/0x10
[  291.797273][   T30]  ret_from_fork+0x45/0x80
[  291.797311][   T30]  ? __pfx_kthread+0x10/0x10
[  291.797335][   T30]  ret_from_fork_asm+0x1a/0x30
[  291.797371][   T30]  </TASK>
[  291.939091][   T30] Kernel Offset: disabled
[  291.943412][   T30] Rebooting in 86400 seconds..


syzkaller build log:
go env (err=3D<nil>)
GO111MODULE=3D'auto'
GOARCH=3D'amd64'
GOBIN=3D''
GOCACHE=3D'/syzkaller/.cache/go-build'
GOENV=3D'/syzkaller/.config/go/env'
GOEXE=3D''
GOEXPERIMENT=3D''
GOFLAGS=3D''
GOHOSTARCH=3D'amd64'
GOHOSTOS=3D'linux'
GOINSECURE=3D''
GOMODCACHE=3D'/syzkaller/jobs/linux/gopath/pkg/mod'
GONOPROXY=3D''
GONOSUMDB=3D''
GOOS=3D'linux'
GOPATH=3D'/syzkaller/jobs/linux/gopath'
GOPRIVATE=3D''
GOPROXY=3D'https://proxy.golang.org,direct'
GOROOT=3D'/usr/local/go'
GOSUMDB=3D'sum.golang.org'
GOTMPDIR=3D''
GOTOOLCHAIN=3D'auto'
GOTOOLDIR=3D'/usr/local/go/pkg/tool/linux_amd64'
GOVCS=3D''
GOVERSION=3D'go1.22.7'
GCCGO=3D'gccgo'
GOAMD64=3D'v1'
AR=3D'ar'
CC=3D'gcc'
CXX=3D'g++'
CGO_ENABLED=3D'1'
GOMOD=3D'/syzkaller/jobs/linux/gopath/src/github.com/google/syzkaller/go.mo=
d'
GOWORK=3D''
CGO_CFLAGS=3D'-O2 -g'
CGO_CPPFLAGS=3D''
CGO_CXXFLAGS=3D'-O2 -g'
CGO_FFLAGS=3D'-O2 -g'
CGO_LDFLAGS=3D'-O2 -g'
PKG_CONFIG=3D'pkg-config'
GOGCCFLAGS=3D'-fPIC -m64 -pthread -Wl,--no-gc-sections -fmessage-length=3D0=
 -ffile-prefix-map=3D/tmp/go-build2848228343=3D/tmp/go-build -gno-record-gc=
c-switches'

git status (err=3D<nil>)
HEAD detached at f2cb035c8f
nothing to commit, working tree clean


tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
Makefile:31: run command via tools/syz-env for best compatibility, see:
Makefile:32: https://github.com/google/syzkaller/blob/master/docs/contribut=
ing.md#using-syz-env
go list -f '{{.Stale}}' ./sys/syz-sysgen | grep -q false || go install ./sy=
s/syz-sysgen
make .descriptions
tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
Makefile:31: run command via tools/syz-env for best compatibility, see:
Makefile:32: https://github.com/google/syzkaller/blob/master/docs/contribut=
ing.md#using-syz-env
bin/syz-sysgen
go fmt ./sys/... >/dev/null
touch .descriptions
GOOS=3Dlinux GOARCH=3Damd64 go build "-ldflags=3D-s -w -X github.com/google=
/syzkaller/prog.GitRevision=3Df2cb035c8f931efff4a020b164e657f16f51934b -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20250117-180932'" "-tags=
=3Dsyz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-execpr=
og github.com/google/syzkaller/tools/syz-execprog
mkdir -p ./bin/linux_amd64
g++ -o ./bin/linux_amd64/syz-executor executor/executor.cc \
	-m64 -O2 -pthread -Wall -Werror -Wparentheses -Wunused-const-variable -Wfr=
ame-larger-than=3D16384 -Wno-stringop-overflow -Wno-array-bounds -Wno-forma=
t-overflow -Wno-unused-but-set-variable -Wno-unused-command-line-argument -=
static-pie -std=3Dc++17 -I. -Iexecutor/_include   -DGOOS_linux=3D1 -DGOARCH=
_amd64=3D1 \
	-DHOSTGOOS_linux=3D1 -DGIT_REVISION=3D\"f2cb035c8f931efff4a020b164e657f16f=
51934b\"
/usr/bin/ld: /tmp/ccI4knEC.o: in function `Connection::Connect(char const*,=
 char const*)':
executor.cc:(.text._ZN10Connection7ConnectEPKcS1_[_ZN10Connection7ConnectEP=
KcS1_]+0x104): warning: Using 'gethostbyname' in statically linked applicat=
ions requires at runtime the shared libraries from the glibc version used f=
or linking


Error text is too large and was truncated, full error text is at:
https://syzkaller.appspot.com/x/error.txt?x=3D173adbf8580000


Tested on:

commit:         0ad2507d Linux 6.14-rc3
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=3D179507154deeb15=
f
dashboard link: https://syzkaller.appspot.com/bug?extid=3D4e21d5f67b886a692=
b55
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Deb=
ian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=3D11f268985800=
00


