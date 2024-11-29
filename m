Return-Path: <linux-kernel+bounces-413498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB16D9D19E3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 21:50:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18F67B213E8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 20:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 875EF1E1311;
	Mon, 18 Nov 2024 20:50:32 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D6B7171652
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 20:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731963032; cv=none; b=AgYRlkwTY4bvIvNc8I/obJoan0j6kGJDvpU3/rQ1KPXJeS9Rr1MF4ev86ieenNhw6j8no8g72xBV9rVBOf5NAYxdO8dZZbRgFHl+Jy1KEh+5aq8nhL09aWMbBYHfIlK3xB9BSukWNDu/yyjc2bez/ljAwhmCFql7CKN7KwTGEEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731963032; c=relaxed/simple;
	bh=dtS17xgj6T/zWINnF2DXvkoIvx7L1hZdPBbw3ouKnXg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=EqPyP5ePnsuYtphWOgqirix8vGWfXvM4PabojitSDGGTKEMmlDCLkrIl4X35nkDPWiZf0VUgRwe4FrEDafh3uPnS4OjJGMXBrvhZGqtFXYYZNNlKTdilTK3j7MAsLLS77KG98Cpu1rcWa1atEl16etal2VpYUCwmb+7+qo8VxRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a6ca616500so2103265ab.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 12:50:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731963029; x=1732567829;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LweZ6jFweraXzx1rZXPlue3Q9OUGLC/4DQnDktgiJtM=;
        b=jL3x1lxg94wVu5fSD+cL990Gye5Zb9UWnY/aHugjiB573VD5yKnlPJyFSRTyynveXr
         81aSeDDX+pB1M7Y+74oNTgfJSz7wFN4xAU1G05TlChnV9yz0FFwWQ2bR013bJwYmd00z
         MZkzC/5u/FfmAstkAEzSRhPumh2+P4fZ8FOSavkO6eLkS97rkb7tC/DrpfkNh6sUPlUl
         rMG5w3u0rcDHI4Ar2ztB1B3UNtJx0TkblkPHhO/GhQ9c2lrLHHSKqPiZCNCLFGs46Ymt
         erNqqM/roO++XRkbZXYVlQSXlj6L80IRDj0rFCJzrop3hiC+wzjEHO5AlKS5Q/rOQQDW
         WLGw==
X-Gm-Message-State: AOJu0YzIyPmjOtsI0zK01hp/dAv7V/Hq5w0eSdGZ3oCE4VMLW4kZi6zP
	zLLxdk/xAMORFF6WZC5USiznjDn40ru5rsSwSE5Owim8YcjdJsRK7KcUWGkSkRDoYU9MvnmvjNQ
	l+sCx+ETJwjf5cs+zaHdnzqgBA+4mHUZvm3AUazlTwNFV7h5Qf3Ns/MY=
X-Google-Smtp-Source: AGHT+IHuCHRfxBdJVT9kTLbK8JidUy0SYgly4v5+pmDZ3kxANxE70473p912gHh9E7sVEDHQf888FfVBXDLt5XB6RXRpsjsU0oof
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2189:b0:3a7:6dad:7ddc with SMTP id
 e9e14a558f8ab-3a76dad7fefmr29484555ab.11.1731963029684; Mon, 18 Nov 2024
 12:50:29 -0800 (PST)
Date: Mon, 18 Nov 2024 12:50:29 -0800
In-Reply-To: <000000000000932e45061d45f6e8@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <673ba895.050a0220.87769.0059.GAE@google.com>
Subject: Re: [syzbot] Re: [PATCH v5] Bluetooth: MGMT: Fix slab-use-after-free
 Read in set_powered_sync
From: syzbot <syzbot+03d6270b6425df1605bf@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: [PATCH v5] Bluetooth: MGMT: Fix slab-use-after-free Read in se=
t_powered_sync
Author: luiz.dentz@gmail.com

#syz test

On Mon, Nov 18, 2024 at 3:33=E2=80=AFPM Luiz Augusto von Dentz
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
>  net/bluetooth/mgmt.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index 1f6d083682b8..e406eb8e4327 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -1318,7 +1318,8 @@ static void mgmt_set_powered_complete(struct hci_de=
v *hdev, void *data, int err)
>         struct mgmt_mode *cp;
>
>         /* Make sure cmd still outstanding. */
> -       if (cmd !=3D pending_find(MGMT_OP_SET_POWERED, hdev))
> +       if (err =3D=3D -ECANCELED ||
> +           cmd !=3D pending_find(MGMT_OP_SET_POWERED, hdev))
>                 return;
>
>         cp =3D cmd->param;
> @@ -1351,7 +1352,13 @@ static void mgmt_set_powered_complete(struct hci_d=
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
> --
> 2.47.0
>


--=20
Luiz Augusto von Dentz

