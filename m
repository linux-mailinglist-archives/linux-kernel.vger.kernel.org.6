Return-Path: <linux-kernel+bounces-392416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C0389B93E4
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 16:02:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84EB71F2123E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 15:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 008681AAE05;
	Fri,  1 Nov 2024 15:01:53 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA2612AAE2
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 15:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730473312; cv=none; b=o3p5r+/YOpOofUpQT5/omlT3OBeYSISU5Go3BIFzIC6grMxwSbq0w4vCvLLMVx+TZ77hdsAYXWQbGokEr3qYyMQRNnS2vQAJo29CvjltfQGPhqK1lu/zKsvKSqtHhJpTib5aR7WTVpiSLQ7R7TUyPDKaq1dySawAEVML5/zkoXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730473312; c=relaxed/simple;
	bh=S8Y/Jh/9Oa1H6kt6NE2UoA1Ps9O0A0cpZY56bsjqbR0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=iFO3R52qm58v+YX/JKkASUxZBd7agGDuswpWlxFwfi5vytvT+AKZoTamKjJ4msllN6Knuk86sAC9chrJtt0d+vXri913/iy9CnuMg99xWwC5l598i+/EKcr/UxUaNTreDBArVkP+QKfIdNDb53ERw7WeNnhuviz8AY+raWr7X8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a3b2aee1a3so21095865ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 08:01:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730473309; x=1731078109;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0fERWfiSHKHQLI5mx+2uoVkoK+FP3Cx0uPNDWNmP864=;
        b=wCGgd41dGltkzf3z/WRcLksd2etG9A4tTvba5Q9m+LjGNIpMIxfHh5rlg++vAqk3mB
         CK1WrCTt+YB/XSN24zrMhzcok5iQsbQqRyBLvKps7fb9WNlTsc991iMRDM1avDc0JUwf
         Cm6MtxAnXRNasYnwXUmafPxSwCN00rgzl5y0KjA21KCbP9AJhL+WGSATz3tp/Lgi0P4y
         Ue4o1S6Q3FilVL/YgpvpZlmLfP38x4EvcwBAI5GKtv5xmbqvnS+St/5vQEBPYNlhWt8R
         6Ra/0vzzm4sys4v+9qqrBcUmqf09ZQrHsIGcMki8Gyz22hywXk9JtS1JRaCr6zhbWaD5
         u38w==
X-Gm-Message-State: AOJu0YwW9qdPeo3A1KoWyRg+KbaOBigGG7hk/vGWtK3atnaAfHzShwlv
	MG+MDX06W+NmENVyFOl/H7BbtFjdQV3FTgvcUQo84OUC+VvwomsXc4zPyg7G0Um8Vd8s/+Xuktz
	lWdY94G0Amn44tjXYDx1kdtkgg1E9cyZDV2vxRn6jRIeKvI99UgOzU9w=
X-Google-Smtp-Source: AGHT+IFHaQ9ESaAIRBbeXtdrMlUNLRBA2RxS+D0hUNiRg9KPIpruN68D3MveqrnS7cdjIXGTfLCjjPQyaaVQFiSIrLfFpsdvilH0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2163:b0:39f:5efe:ae73 with SMTP id
 e9e14a558f8ab-3a5e2436614mr126167555ab.5.1730473309209; Fri, 01 Nov 2024
 08:01:49 -0700 (PDT)
Date: Fri, 01 Nov 2024 08:01:49 -0700
In-Reply-To: <000000000000afab690616b12f99@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6724ed5d.050a0220.35b515.0173.GAE@google.com>
Subject: Re: [syzbot] Re: [PATCH v2] Bluetooth: fix use-after-free in device_for_each_child()
From: syzbot <syzbot+6cf5652d3df49fae2e3f@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: [PATCH v2] Bluetooth: fix use-after-free in device_for_each_ch=
ild()
Author: luiz.dentz@gmail.com

#syz test

On Fri, Nov 1, 2024 at 7:44=E2=80=AFAM Dmitry Antipov <dmantipov@yandex.ru>=
 wrote:
>
> Syzbot has reported the following KASAN splat:
>
> BUG: KASAN: slab-use-after-free in device_for_each_child+0x18f/0x1a0
> Read of size 8 at addr ffff88801f605308 by task kbnepd bnep0/4980
>
> CPU: 0 UID: 0 PID: 4980 Comm: kbnepd bnep0 Not tainted 6.12.0-rc4-00161-g=
ae90f6a6170d #1
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-2.fc40=
 04/01/2014
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0x100/0x190
>  ? device_for_each_child+0x18f/0x1a0
>  print_report+0x13a/0x4cb
>  ? __virt_addr_valid+0x5e/0x590
>  ? __phys_addr+0xc6/0x150
>  ? device_for_each_child+0x18f/0x1a0
>  kasan_report+0xda/0x110
>  ? device_for_each_child+0x18f/0x1a0
>  ? __pfx_dev_memalloc_noio+0x10/0x10
>  device_for_each_child+0x18f/0x1a0
>  ? __pfx_device_for_each_child+0x10/0x10
>  pm_runtime_set_memalloc_noio+0xf2/0x180
>  netdev_unregister_kobject+0x1ed/0x270
>  unregister_netdevice_many_notify+0x123c/0x1d80
>  ? __mutex_trylock_common+0xde/0x250
>  ? __pfx_unregister_netdevice_many_notify+0x10/0x10
>  ? trace_contention_end+0xe6/0x140
>  ? __mutex_lock+0x4e7/0x8f0
>  ? __pfx_lock_acquire.part.0+0x10/0x10
>  ? rcu_is_watching+0x12/0xc0
>  ? unregister_netdev+0x12/0x30
>  unregister_netdevice_queue+0x30d/0x3f0
>  ? __pfx_unregister_netdevice_queue+0x10/0x10
>  ? __pfx_down_write+0x10/0x10
>  unregister_netdev+0x1c/0x30
>  bnep_session+0x1fb3/0x2ab0
>  ? __pfx_bnep_session+0x10/0x10
>  ? __pfx_lock_release+0x10/0x10
>  ? __pfx_woken_wake_function+0x10/0x10
>  ? __kthread_parkme+0x132/0x200
>  ? __pfx_bnep_session+0x10/0x10
>  ? kthread+0x13a/0x370
>  ? __pfx_bnep_session+0x10/0x10
>  kthread+0x2b7/0x370
>  ? __pfx_kthread+0x10/0x10
>  ret_from_fork+0x48/0x80
>  ? __pfx_kthread+0x10/0x10
>  ret_from_fork_asm+0x1a/0x30
>  </TASK>
>
> Allocated by task 4974:
>  kasan_save_stack+0x30/0x50
>  kasan_save_track+0x14/0x30
>  __kasan_kmalloc+0xaa/0xb0
>  __kmalloc_noprof+0x1d1/0x440
>  hci_alloc_dev_priv+0x1d/0x2820
>  __vhci_create_device+0xef/0x7d0
>  vhci_write+0x2c7/0x480
>  vfs_write+0x6a0/0xfc0
>  ksys_write+0x12f/0x260
>  do_syscall_64+0xc7/0x250
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> Freed by task 4979:
>  kasan_save_stack+0x30/0x50
>  kasan_save_track+0x14/0x30
>  kasan_save_free_info+0x3b/0x60
>  __kasan_slab_free+0x4f/0x70
>  kfree+0x141/0x490
>  hci_release_dev+0x4d9/0x600
>  bt_host_release+0x6a/0xb0
>  device_release+0xa4/0x240
>  kobject_put+0x1ec/0x5a0
>  put_device+0x1f/0x30
>  vhci_release+0x81/0xf0
>  __fput+0x3f6/0xb30
>  task_work_run+0x151/0x250
>  do_exit+0xa79/0x2c30
>  do_group_exit+0xd5/0x2a0
>  get_signal+0x1fcd/0x2210
>  arch_do_signal_or_restart+0x93/0x780
>  syscall_exit_to_user_mode+0x140/0x290
>  do_syscall_64+0xd4/0x250
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> In 'hci_conn_del_sysfs()', 'device_unregister()' may be called when
> an underlying (kobject) reference counter is greater than 1. This
> means that reparenting (happened when the device is actually freed)
> is delayed and, during that delay, parent controller device (hciX)
> may be deleted. Since the latter may create a dangling pointer to
> freed parent, avoid that scenario by reparenting to NULL explicitly.
>
> Reported-by: syzbot+6cf5652d3df49fae2e3f@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D6cf5652d3df49fae2e3f
> Fixes: a85fb91e3d72 ("Bluetooth: Fix double free in hci_conn_cleanup")
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> ---
> v2: reparent per-connection 'struct device' explicitly
> ---
>  net/bluetooth/hci_sysfs.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/net/bluetooth/hci_sysfs.c b/net/bluetooth/hci_sysfs.c
> index 367e32fe30eb..80ac537fa500 100644
> --- a/net/bluetooth/hci_sysfs.c
> +++ b/net/bluetooth/hci_sysfs.c
> @@ -73,6 +73,8 @@ void hci_conn_del_sysfs(struct hci_conn *conn)
>                 return;
>         }
>
> +       device_move(&conn->dev, NULL, DPM_ORDER_DEV_LAST);
> +
>         while (1) {
>                 struct device *dev;
>
> --
> 2.47.0
>


--=20
Luiz Augusto von Dentz

