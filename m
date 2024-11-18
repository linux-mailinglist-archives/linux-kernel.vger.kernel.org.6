Return-Path: <linux-kernel+bounces-413200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3F679D14FB
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 17:05:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B482328414E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 16:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 412EC1BD9C1;
	Mon, 18 Nov 2024 16:04:53 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ADDC1A9B3D
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 16:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731945892; cv=none; b=X9OHb3QpOA6aATeP1UaEYa7lyuSXgGL7SQWi+6GCh0qdDtq9MUdxgVBSCbjp71NJ1OrxjUeo2NXAWgqfRM2uCvFCeW98ChmtUPbUxC815xiAlsrakjwTVYcCGMk6TSfRTt4eDIeqXtuhmD3wr5LnDb2nh5LSm8mhh27vqUGNBgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731945892; c=relaxed/simple;
	bh=MbEeDUK+7sQzqVdpYL/x+EY/scAZfk0h7LTV9MBQ60Y=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=oeNha6Z/sRSR0PFJwK2QO/xDz5oqsqZh7DTxgG66ITzBRb+hRgW3k9x+qYSOAFnrEwWRX5J1J1U0NuJq2sKDGmY8A5M8++EAnFZ2YusMcIQZV0GEXHbOSP4ToL0d97nYE0BH2ynkhInSQUepjYqkzQJEYrjdNXIRUVAICa8WZBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a7642d452dso12366755ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 08:04:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731945890; x=1732550690;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6jQA+cGfVLrLgVkTurM+CbVNTW/qLrVp5y/t/4/AQAU=;
        b=wE8NcyMQDT2o6kEjzYsYtKvniRGUaqUHITWmMY+JaPdTD/b+IDuonvNiyaPRdjGuFG
         322CbqxWLtjxG82/76OysumqEinLN5s2yRGORNIc7wY1DpKKp9buGPCKnc9qxwGY2hbo
         BhqeKIbKbLbdiwzU/PwsNtQWnsVfZoV1mMQ/AHyc9q9XC099KR12IStPTroTgQvOfxTA
         ejUNvbA3vmRvJZwUxntFYMR/4rL0XJVd8cUNtk1FPoce3n5qxSmP6BcuAZe+E13MV6SS
         4WZbkv09kYejZMVXMMdGrpSypJj0EFHasSLaHRYb4qQ38nPgx/2le3r0DjrBMuwAj9vH
         WZgg==
X-Gm-Message-State: AOJu0YyfXsKm50ZqEbx3luuvxGaqZfR57rREv/gPZbEiMG8CLi1IO9BB
	Q6u8/+QQ0JYbqIOuNLYpbJoXfdVhyx48sCIl5J/H92t70xFGZIUiGS8G9K7QeN2UZR7S+ShZGjA
	/xIN/aMWnGETobNfEZ36x2VYAr6hJCC4moI8xN7dVxG1x7OPwGTXuluQ=
X-Google-Smtp-Source: AGHT+IE0Oh2GcnG702XcWEn+fxkoAJ9AYaGMfXQNYzQPkqyQ8grGqJ1NsNmTpcxgivDf947miV/sMPcDI/acneUBItK+CwoWvS2y
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:88:b0:3a7:1e66:ea32 with SMTP id
 e9e14a558f8ab-3a74700ddc0mr143115925ab.10.1731945890030; Mon, 18 Nov 2024
 08:04:50 -0800 (PST)
Date: Mon, 18 Nov 2024 08:04:50 -0800
In-Reply-To: <000000000000932e45061d45f6e8@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <673b65a2.050a0220.87769.0046.GAE@google.com>
Subject: Re: [syzbot] Re: [PATCH v3] Bluetooth: MGMT: Fix slab-use-after-free
 Read in set_powered_sync
From: syzbot <syzbot+03d6270b6425df1605bf@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: [PATCH v3] Bluetooth: MGMT: Fix slab-use-after-free Read in se=
t_powered_sync
Author: luiz.dentz@gmail.com

#syz test

On Mon, Nov 18, 2024 at 10:36=E2=80=AFAM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> This fixes the following crash:
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> BUG: KASAN: slab-use-after-free in set_powered_sync+0x3a/0xc0 net/bluetoo=
th/mgmt.c:1353
> Read of size 8 at addr ffff888029b4dd18 by task kworker/u9:0/54
>
> CPU: 1 UID: 0 PID: 54 Comm: kworker/u9:0 Not tainted 6.11.0-rc6-syzkaller=
-01155-gf723224742fc #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 08/06/2024
> Workqueue: hci0 hci_cmd_sync_work
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:93 [inline]
>  dump_stack_lvl+0x241/0x360 lib/dump_stack.c:119
>  print_address_description mm/kasan/report.c:377 [inline]
>  print_report+0x169/0x550 mm/kasan/report.c:488
> q kasan_report+0x143/0x180 mm/kasan/report.c:601
>  set_powered_sync+0x3a/0xc0 net/bluetooth/mgmt.c:1353
>  hci_cmd_sync_work+0x22b/0x400 net/bluetooth/hci_sync.c:328
>  process_one_work kernel/workqueue.c:3231 [inline]
>  process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3312
>  worker_thread+0x86d/0xd10 kernel/workqueue.c:3389
>  kthread+0x2f0/0x390 kernel/kthread.c:389
>  ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
>  </TASK>
>
> Allocated by task 5247:
>  kasan_save_stack mm/kasan/common.c:47 [inline]
>  kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
>  poison_kmalloc_redzone mm/kasan/common.c:370 [inline]
>  __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:387
>  kasan_kmalloc include/linux/kasan.h:211 [inline]
>  __kmalloc_cache_noprof+0x19c/0x2c0 mm/slub.c:4193
>  kmalloc_noprof include/linux/slab.h:681 [inline]
>  kzalloc_noprof include/linux/slab.h:807 [inline]
>  mgmt_pending_new+0x65/0x250 net/bluetooth/mgmt_util.c:269
>  mgmt_pending_add+0x36/0x120 net/bluetooth/mgmt_util.c:296
>  set_powered+0x3cd/0x5e0 net/bluetooth/mgmt.c:1394
>  hci_mgmt_cmd+0xc47/0x11d0 net/bluetooth/hci_sock.c:1712
>  hci_sock_sendmsg+0x7b8/0x11c0 net/bluetooth/hci_sock.c:1832
>  sock_sendmsg_nosec net/socket.c:730 [inline]
>  __sock_sendmsg+0x221/0x270 net/socket.c:745
>  sock_write_iter+0x2dd/0x400 net/socket.c:1160
>  new_sync_write fs/read_write.c:497 [inline]
>  vfs_write+0xa72/0xc90 fs/read_write.c:590
>  ksys_write+0x1a0/0x2c0 fs/read_write.c:643
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> Freed by task 5246:
>  kasan_save_stack mm/kasan/common.c:47 [inline]
>  kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
>  kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:579
>  poison_slab_object+0xe0/0x150 mm/kasan/common.c:240
>  __kasan_slab_free+0x37/0x60 mm/kasan/common.c:256
>  kasan_slab_free include/linux/kasan.h:184 [inline]
>  slab_free_hook mm/slub.c:2256 [inline]
>  slab_free mm/slub.c:4477 [inline]
>  kfree+0x149/0x360 mm/slub.c:4598
>  settings_rsp+0x2bc/0x390 net/bluetooth/mgmt.c:1443
>  mgmt_pending_foreach+0xd1/0x130 net/bluetooth/mgmt_util.c:259
>  __mgmt_power_off+0x112/0x420 net/bluetooth/mgmt.c:9455
>  hci_dev_close_sync+0x665/0x11a0 net/bluetooth/hci_sync.c:5191
>  hci_dev_do_close net/bluetooth/hci_core.c:483 [inline]
>  hci_dev_close+0x112/0x210 net/bluetooth/hci_core.c:508
>  sock_do_ioctl+0x158/0x460 net/socket.c:1222
>  sock_ioctl+0x629/0x8e0 net/socket.c:1341
>  vfs_ioctl fs/ioctl.c:51 [inline]
>  __do_sys_ioctl fs/ioctl.c:907 [inline]
>  __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:893
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83gv
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> Reported-by: syzbot+03d6270b6425df1605bf@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D03d6270b6425df1605bf
> Fixes: 275f3f648702 ("Bluetooth: Fix not checking MGMT cmd pending queue"=
)
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
>  net/bluetooth/mgmt.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index 1f6d083682b8..3ec79c69b0ee 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -1351,7 +1351,13 @@ static void mgmt_set_powered_complete(struct hci_d=
ev *hdev, void *data, int err)
>  static int set_powered_sync(struct hci_dev *hdev, void *data)
>  {
>         struct mgmt_pending_cmd *cmd =3D data;
> -       struct mgmt_mode *cp =3D cmd->param;
> +       struct mgmt_mode *cp;
> +
> +       /* Make sure cmd still outstanding. */
> +       if (cmd !=3D pending_find(MGMT_OP_SET_POWERED, hdev))
> +               return -ECANCELED;
> +
> +       cp =3D cmd->param;
>
>         BT_DBG("%s", hdev->name);
>
> @@ -1432,6 +1438,11 @@ static void settings_rsp(struct mgmt_pending_cmd *=
cmd, void *data)
>  {
>         struct cmd_lookup *match =3D data;
>
> +       /* dequeue cmd_sync entries using cmd as data as that is about to=
 be
> +        * removed/freed.
> +        */
> +       hci_cmd_sync_dequeue(match->hdev, NULL, cmd, NULL);
> +
>         send_settings_rsp(cmd->sk, cmd->opcode, match->hdev);
>
>         list_del(&cmd->list);
> --
> 2.47.0
>


--=20
Luiz Augusto von Dentz

