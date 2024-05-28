Return-Path: <linux-kernel+bounces-192716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E01C98D212A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 18:05:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53CC81F26B15
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 16:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E502171E6A;
	Tue, 28 May 2024 16:05:08 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 575D016C688
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 16:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716912307; cv=none; b=iOOjeI/YtfjDpVuzLoGScM2Ba31dUxpHio4CMroR1JeOpVhwPcTytT+6xFtfqCDqtFOe7pwaWIusylkUlOpYxA2LlBIvgDRvx5yD5JiNx/wNa+blMMM70vWFMVU96r+0XGhkSCZyJ3/YV8PrXCC2cZaBGE+eBGpdcusGAFMTT7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716912307; c=relaxed/simple;
	bh=0S8vU4RYJGojMD9Y1Ik8Q+H62v98WRtpGJybC8bJE7o=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ouHY6gGWqf2GZARbovuMHs2EZ7PyeaiB0OIQM+eam6hXtfloZKmmrPrLMWJF3gTiUJ3F1LZoy6ZUgvMjL+InupltU28xK2PnzbI0lvAOnKEMSwLq6zVJDyG3KwNZ1XoH7h2GXSj5hGGMZwxEKigq3/ZrmjzK2NTe3nk7ovrcZ24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-37450b16f7cso9568015ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 09:05:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716912304; x=1717517104;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yTd/rmyh3mN7rvK3bwgGJ3YcA1Bf0+Fxqg/7bGHqhJQ=;
        b=jijhNTbl42fxc+sF8DSwbCZtCsZQIcq0mId4QNVG8konDhUTa1AFtOpTicQ8NLM9+P
         A879TDrjAphNhgdAB5PHXPHN6o+Wf0HCvyqET2qyeVaQNJJ2m6vL/A9QG/tkjQIuJ23b
         XkysHJFr6vB2MQMJRgMB6aXDdPaWqE/kWnSF6B8dpmLy7GORHqmpFJoJ/7MRsbiqfijd
         B9YZ1ciUZtS3NcYPbluXOJ0mag+3YnLX1MFKNugDPgyiNLUYp+e69u8hyzelTIMGx+Vs
         0pd6F8RXMXbdo54pVNf6vhQZ/dSUItbMbh/CCu0ytUbCU6MD+XVfc+B5FA9ZwX/26oQL
         vzZg==
X-Forwarded-Encrypted: i=1; AJvYcCUUU3h3HoQqRgg3Q8ZHA3ZDKcgsnAO0JSmdBg2WTtkU3EbTCrvFMhuWE/+9BdV4NclaYyPsEb7rinCEUwIA+xH+mIo8Ppcly5s28XH0
X-Gm-Message-State: AOJu0YxpMAGFioB6fF3KFfPG6VB+xj7Aj43jsee037tM3yXq6UK/Oidy
	LaATBjVOmf1kicS5aXxzRxT8/T8UZHsBFf4D3e2FgSuPkJ2G3rXsSCRtLS2bJEDsveLIriVrGku
	ogIozjYKIyz4UXNlFeFyWb8sIT+KsoziG3lYdFW+DZn7Rq3LjvN+mfgc=
X-Google-Smtp-Source: AGHT+IGUZrZF4iBlR5YxCr/y+75W+JzGUoQA8hwedZNG4VOt6RflXoPw9nGqBztHDITqLeIFgzBFfz6mDAsSILojcx96ObAMsitU
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cda6:0:b0:374:5d81:9136 with SMTP id
 e9e14a558f8ab-3745d8193d4mr3017585ab.0.1716912304528; Tue, 28 May 2024
 09:05:04 -0700 (PDT)
Date: Tue, 28 May 2024 09:05:04 -0700
In-Reply-To: <tencent_9FA58DAAA5CF0D8B9250DDB2DDF4192FCF07@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000005af05061985cc7a@google.com>
Subject: Re: [syzbot] [input?] [usb?] KMSAN: uninit-value in asus_report_fixup
From: syzbot <syzbot+07762f019fd03d01f04c@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

ALSA device list:
[   50.739608][    T1]   #0: Dummy 1
[   50.745017][    T1]   #1: Loopback 1
[   50.749742][    T1]   #2: Virtual MIDI Card 1
[   50.763313][  T778] platform regulatory.0: Direct firmware load for regu=
latory.db failed with error -2
[   50.774859][  T778] platform regulatory.0: Falling back to sysfs fallbac=
k for: regulatory.db
[   50.785859][    T1] md: Waiting for all devices to be available before a=
utodetect
[   50.794992][    T1] md: If you don't use raid, use raid=3Dnoautodetect
[   50.802100][    T1] md: Autodetecting RAID arrays.
[   50.807598][    T1] md: autorun ...
[   50.811722][    T1] md: ... autorun DONE.
[   50.909158][    T1] EXT4-fs (sda1): mounted filesystem 5941fea2-f5fa-4b4=
e-b5ef-9af118b27b95 ro with ordered data mode. Quota mode: none.
[   50.924682][    T1] VFS: Mounted root (ext4 filesystem) readonly on devi=
ce 8:1.
[   50.979361][    T1] devtmpfs: mounted
[   51.243177][    T1] Freeing unused kernel image (initmem) memory: 37100K
[   51.255037][    T1] Write protecting the kernel read-only data: 262144k
[   51.302877][    T1] Freeing unused kernel image (rodata/data gap) memory=
: 1792K
[   52.995659][    T1] x86/mm: Checked W+X mappings: passed, no W+X pages f=
ound.
[   53.007236][    T1] x86/mm: Checking user space page tables
[   54.561678][    T1] x86/mm: Checked W+X mappings: passed, no W+X pages f=
ound.
[   54.571441][    T1] Failed to set sysctl parameter 'kernel.hung_task_all=
_cpu_backtrace=3D1': parameter not found
[   54.593763][    T1] Failed to set sysctl parameter 'max_rcu_stall_to_pan=
ic=3D1': parameter not found
[   54.605883][    T1] Run /sbin/init as init process
[   56.271672][ T4452] mount (4452) used greatest stack depth: 8096 bytes l=
eft
[   56.349940][ T4453] EXT4-fs (sda1): re-mounted 5941fea2-f5fa-4b4e-b5ef-9=
af118b27b95 r/w. Quota mode: none.
mount: mounting smackfs on /sys/fs/smackfs failed: No such file or director=
y
mount: mounting selinuxfs on /sys/fs/selinux failed: No such file or direct=
ory
[   56.692709][ T4456] mount (4456) used greatest stack depth: 5536 bytes l=
eft
Starting syslogd: OK
Starting acpid: OK
Starting klogd: OK
Running sysctl: OK
Populating /dev using udev: [   60.747411][ T4486] udevd[4486]: starting ve=
rsion 3.2.11
[   64.471349][ T4488] udevd[4488]: starting eudev-3.2.11
[   64.483735][ T4486] udevd (4486) used greatest stack depth: 5080 bytes l=
eft
done
Starting system message bus: done
Starting iptables: OK
Starting network: OK
Starting dhcpcd...
dhcpcd-9.4.1 starting
dev: loaded udev
DUID 00:04:ee:6e:2e:e3:62:a1:1e:1b:9d:a6:87:1c:6e:7e:27:0f
[  111.688537][  T778] cfg80211: failed to load regulatory.db
forked to background, child pid 4700
[  113.204518][ T4701] 8021q: adding VLAN 0 to HW filter on device bond0
[  113.261553][ T4701] eql: remember to turn off Van-Jacobson compression o=
n your slave devices
[  113.705664][    C0] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[  113.713710][    C0] BUG: KMSAN: uninit-value in receive_buf+0x25e3/0x5fd=
0
[  113.721249][    C0]  receive_buf+0x25e3/0x5fd0
[  113.726871][    C0]  virtnet_poll+0xd1c/0x23c0
[  113.732720][    C0]  __napi_poll+0xe7/0x980
[  113.737602][    C0]  net_rx_action+0x82a/0x1850
[  113.742969][    C0]  handle_softirqs+0x1d8/0x810
[  113.748254][    C0]  __irq_exit_rcu+0x68/0x120
[  113.753244][    C0]  irq_exit_rcu+0x12/0x20
[  113.758091][    C0]  common_interrupt+0x94/0xa0
[  113.763187][    C0]  asm_common_interrupt+0x2b/0x40
[  113.769022][    C0]  __msan_get_context_state+0x2b/0x40
[  113.774745][    C0]  filter_irq_stacks+0x20/0x1a0
[  113.780317][    C0]  stack_depot_save_flags+0x2c/0x6e0
[  113.786314][    C0]  stack_depot_save+0x12/0x20
[  113.791479][    C0]  __msan_poison_alloca+0x106/0x1b0
[  113.797810][    C0]  rtnl_fill_link_ifmap+0x3d/0x2d0
[  113.803235][    C0]  rtnl_fill_ifinfo+0x2842/0x2d00
[  113.808831][    C0]  rtnl_dump_ifinfo+0x985/0x2040
[  113.814347][    C0]  netlink_dump+0xaa0/0x15b0
[  113.819296][    C0]  netlink_recvmsg+0xc5f/0x1610
[  113.824980][    C0]  sock_recvmsg+0x2c4/0x340
[  113.830086][    C0]  ____sys_recvmsg+0x18a/0x620
[  113.835352][    C0]  ___sys_recvmsg+0x223/0x840
[  113.840392][    C0]  __x64_sys_recvmsg+0x304/0x4a0
[  113.845552][    C0]  x64_sys_call+0x38ff/0x3b50
[  113.850557][    C0]  do_syscall_64+0xcf/0x1e0
[  113.855339][    C0]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  113.861603][    C0]=20
[  113.864026][    C0] Uninit was created at:
[  113.868730][    C0]  __alloc_pages_noprof+0x9d6/0xe70
[  113.874561][    C0]  alloc_pages_mpol_noprof+0x299/0x990
[  113.880362][    C0]  alloc_pages_noprof+0x1bf/0x1e0
[  113.885777][    C0]  skb_page_frag_refill+0x2bf/0x7c0
[  113.891268][    C0]  virtnet_rq_alloc+0x43/0xbb0
[  113.896445][    C0]  try_fill_recv+0x3f0/0x2f50
[  113.901560][    C0]  virtnet_open+0x1cc/0xb00
[  113.906402][    C0]  __dev_open+0x546/0x6f0
[  113.911394][    C0]  __dev_change_flags+0x309/0x9a0
[  113.916674][    C0]  dev_change_flags+0x8e/0x1d0
[  113.921709][    C0]  devinet_ioctl+0x13ec/0x22c0
[  113.926856][    C0]  inet_ioctl+0x4bd/0x6d0
[  113.931354][    C0]  sock_do_ioctl+0xb7/0x540
[  113.936741][    C0]  sock_ioctl+0x727/0xd70
[  113.941310][    C0]  __se_sys_ioctl+0x261/0x450
[  113.946355][    C0]  __x64_sys_ioctl+0x96/0xe0
[  113.951792][    C0]  x64_sys_call+0x1883/0x3b50
[  113.957744][    C0]  do_syscall_64+0xcf/0x1e0
[  113.962489][    C0]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  113.968805][    C0]=20
[  113.971339][    C0] CPU: 0 PID: 4701 Comm: dhcpcd Not tainted 6.9.0-syzk=
aller-10219-g70ec81c2e2b4-dirty #0
[  113.982140][    C0] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 04/02/2024
[  113.993753][    C0] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[  114.001533][    C0] Disabling lock debugging due to kernel taint
[  114.009462][    C0] Kernel panic - not syncing: kmsan.panic set ...
[  114.016998][    C0] CPU: 0 PID: 4701 Comm: dhcpcd Tainted: G    B       =
       6.9.0-syzkaller-10219-g70ec81c2e2b4-dirty #0
[  114.029845][    C0] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 04/02/2024
[  114.041448][    C0] Call Trace:
[  114.045419][    C0]  <IRQ>
[  114.048629][    C0]  dump_stack_lvl+0x216/0x2d0
[  114.053807][    C0]  ? kmsan_get_shadow_origin_ptr+0x4d/0xb0
[  114.060387][    C0]  dump_stack+0x1e/0x30
[  114.065183][    C0]  panic+0x4e2/0xcd0
[  114.069306][    C0]  ? kmsan_get_metadata+0xb1/0x1d0
[  114.074868][    C0]  kmsan_report+0x2d5/0x2e0
[  114.079600][    C0]  ? kmsan_get_metadata+0x146/0x1d0
[  114.085029][    C0]  ? kmsan_get_metadata+0x146/0x1d0
[  114.090574][    C0]  ? __msan_warning+0x95/0x120
[  114.095997][    C0]  ? receive_buf+0x25e3/0x5fd0
[  114.101178][    C0]  ? virtnet_poll+0xd1c/0x23c0
[  114.106946][    C0]  ? __napi_poll+0xe7/0x980
[  114.111703][    C0]  ? net_rx_action+0x82a/0x1850
[  114.117078][    C0]  ? handle_softirqs+0x1d8/0x810
[  114.122327][    C0]  ? __irq_exit_rcu+0x68/0x120
[  114.127651][    C0]  ? irq_exit_rcu+0x12/0x20
[  114.132722][    C0]  ? common_interrupt+0x94/0xa0
[  114.137888][    C0]  ? asm_common_interrupt+0x2b/0x40
[  114.143487][    C0]  ? __msan_get_context_state+0x2b/0x40
[  114.149332][    C0]  ? filter_irq_stacks+0x20/0x1a0
[  114.154699][    C0]  ? stack_depot_save_flags+0x2c/0x6e0
[  114.160497][    C0]  ? stack_depot_save+0x12/0x20
[  114.165739][    C0]  ? __msan_poison_alloca+0x106/0x1b0
[  114.171348][    C0]  ? rtnl_fill_link_ifmap+0x3d/0x2d0
[  114.177051][    C0]  ? rtnl_fill_ifinfo+0x2842/0x2d00
[  114.183163][    C0]  ? rtnl_dump_ifinfo+0x985/0x2040
[  114.188658][    C0]  ? netlink_dump+0xaa0/0x15b0
[  114.193597][    C0]  ? netlink_recvmsg+0xc5f/0x1610
[  114.198816][    C0]  ? sock_recvmsg+0x2c4/0x340
[  114.203960][    C0]  ? ____sys_recvmsg+0x18a/0x620
[  114.209989][    C0]  ? ___sys_recvmsg+0x223/0x840
[  114.215687][    C0]  ? __x64_sys_recvmsg+0x304/0x4a0
[  114.221034][    C0]  ? x64_sys_call+0x38ff/0x3b50
[  114.226249][    C0]  ? do_syscall_64+0xcf/0x1e0
[  114.231207][    C0]  ? entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  114.237587][    C0]  ? kmsan_get_metadata+0x146/0x1d0
[  114.243236][    C0]  ? kmsan_get_metadata+0x146/0x1d0
[  114.248644][    C0]  ? page_to_skb+0xdae/0x1620
[  114.253659][    C0]  ? kmsan_get_metadata+0x146/0x1d0
[  114.259661][    C0]  __msan_warning+0x95/0x120
[  114.264815][    C0]  receive_buf+0x25e3/0x5fd0
[  114.269784][    C0]  ? kmsan_get_metadata+0x146/0x1d0
[  114.275965][    C0]  ? kmsan_get_shadow_origin_ptr+0x4d/0xb0
[  114.282750][    C0]  virtnet_poll+0xd1c/0x23c0
[  114.287998][    C0]  ? __pfx_virtnet_poll+0x10/0x10
[  114.293342][    C0]  __napi_poll+0xe7/0x980
[  114.298091][    C0]  ? kmsan_get_metadata+0x146/0x1d0
[  114.303971][    C0]  net_rx_action+0x82a/0x1850
[  114.309134][    C0]  ? sched_clock_cpu+0x55/0x870
[  114.314233][    C0]  ? __pfx_net_rx_action+0x10/0x10
[  114.319884][    C0]  handle_softirqs+0x1d8/0x810
[  114.324898][    C0]  __irq_exit_rcu+0x68/0x120
[  114.329699][    C0]  irq_exit_rcu+0x12/0x20
[  114.334253][    C0]  common_interrupt+0x94/0xa0
[  114.339240][    C0]  </IRQ>
[  114.342278][    C0]  <TASK>
[  114.345577][    C0]  asm_common_interrupt+0x2b/0x40
[  114.350950][    C0] RIP: 0010:__msan_get_context_state+0x2b/0x40
[  114.357416][    C0] Code: 0f 1e fa 55 48 89 e5 65 8b 05 49 7b c4 7d a9 0=
0 01 ff 00 74 15 65 48 8b 05 92 76 bb 7d 48 8d 80 c0 1b 0a 00 5d c3 cc cc c=
c cc <65> 48 8b 04 25 80 5e 0a 00 48 05 40 0b 00 00 5d c3 cc cc cc cc 90
[  114.377420][    C0] RSP: 0018:ffff88811906b260 EFLAGS: 00000246
[  114.383681][    C0] RAX: 0000000080000000 RBX: ffff88811906b350 RCX: 000=
0000000000001
[  114.391913][    C0] RDX: 0000000000000020 RSI: 0000000000000004 RDI: fff=
f88811906b350
[  114.400132][    C0] RBP: ffff88811906b260 R08: ffffffff8c92e59b R09: 000=
0000000000000
[  114.408277][    C0] R10: ffff888115b33798 R11: ffffffff8da96b10 R12: fff=
f88811906b3b0
[  114.416421][    C0] R13: 0000000000000000 R14: 0000000000000004 R15: 000=
0000000000246
[  114.424568][    C0]  ? __pfx_inet6_fill_link_af+0x10/0x10
[  114.430580][    C0]  ? rtnl_fill_ifinfo+0x27fb/0x2d00
[  114.435997][    C0]  filter_irq_stacks+0x20/0x1a0
[  114.441101][    C0]  ? kmsan_internal_set_shadow_origin+0x66/0xe0
[  114.447597][    C0]  ? kmsan_get_metadata+0x146/0x1d0
[  114.453118][    C0]  stack_depot_save_flags+0x2c/0x6e0
[  114.458683][    C0]  ? kmsan_get_metadata+0x146/0x1d0
[  114.464102][    C0]  stack_depot_save+0x12/0x20
[  114.469036][    C0]  __msan_poison_alloca+0x106/0x1b0
[  114.474462][    C0]  ? rtnl_fill_link_ifmap+0x3d/0x2d0
[  114.480083][    C0]  ? rtnl_fill_ifinfo+0x2842/0x2d00
[  114.485584][    C0]  rtnl_fill_link_ifmap+0x3d/0x2d0
[  114.490942][    C0]  rtnl_fill_ifinfo+0x2842/0x2d00
[  114.496196][    C0]  ? kmsan_get_metadata+0x146/0x1d0
[  114.501884][    C0]  rtnl_dump_ifinfo+0x985/0x2040
[  114.507588][    C0]  ? __x64_sys_recvmsg+0x304/0x4a0
[  114.513055][    C0]  ? should_fail_ex+0x4a/0x800
[  114.518157][    C0]  ? kmsan_get_metadata+0x146/0x1d0
[  114.523666][    C0]  ? kmsan_get_shadow_origin_ptr+0x4d/0xb0
[  114.530413][    C0]  ? __pfx_rtnl_dump_ifinfo+0x10/0x10
[  114.536490][    C0]  ? __pfx_rtnl_dump_ifinfo+0x10/0x10
[  114.542236][    C0]  netlink_dump+0xaa0/0x15b0
[  114.547420][    C0]  netlink_recvmsg+0xc5f/0x1610
[  114.553997][    C0]  ? __pfx_netlink_recvmsg+0x10/0x10
[  114.560431][    C0]  ? __pfx_netlink_recvmsg+0x10/0x10
[  114.566090][    C0]  sock_recvmsg+0x2c4/0x340
[  114.570832][    C0]  ____sys_recvmsg+0x18a/0x620
[  114.576080][    C0]  ? kmsan_get_shadow_origin_ptr+0x4d/0xb0
[  114.582080][    C0]  ? kmsan_get_metadata+0x146/0x1d0
[  114.587555][    C0]  ___sys_recvmsg+0x223/0x840
[  114.592520][    C0]  ? kmsan_get_metadata+0x146/0x1d0
[  114.598101][    C0]  ? kmsan_get_shadow_origin_ptr+0x4d/0xb0
[  114.604154][    C0]  ? kmsan_get_metadata+0x146/0x1d0
[  114.610172][    C0]  ? kmsan_get_shadow_origin_ptr+0x4d/0xb0
[  114.616296][    C0]  __x64_sys_recvmsg+0x304/0x4a0
[  114.622011][    C0]  ? kmsan_get_shadow_origin_ptr+0x4d/0xb0
Starting sshd: [  114.628177][    C0]  x64_sys_call+0x38ff/0x3b50
[  114.634356][    C0]  do_syscall_64+0xcf/0x1e0
[  114.639066][    C0]  ? clear_bhb_loop+0x25/0x80
[  114.644087][    C0]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  114.650283][    C0] RIP: 0033:0x7f0e1c10791e
[  114.654855][    C0] Code: ff 89 ef 48 89 04 24 e8 4f 57 f9 ff 48 8b 04 2=
4 48 83 c4 30 5d c3 c3 64 8b 04 25 18 00 00 00 85 c0 75 21 b8 2f 00 00 00 0=
f 05 <48> 3d 00 f0 ff ff 76 70 48 8b 15 db c4 0c 00 f7 d8 64 89 02 48 83
[  114.675121][    C0] RSP: 002b:00007ffc9d177108 EFLAGS: 00000246 ORIG_RAX=
: 000000000000002f
[  114.684538][    C0] RAX: ffffffffffffffda RBX: 00007ffc9d178230 RCX: 000=
07f0e1c10791e
[  114.692957][    C0] RDX: 0000000000000000 RSI: 00007ffc9d178150 RDI: 000=
0000000000005
[  114.701110][    C0] RBP: 00007ffc9d1781c0 R08: 0000000000000000 R09: 000=
0000000000400
[  114.709257][    C0] R10: 0000000000000101 R11: 0000000000000246 R12: 000=
0000000000f00
[  114.717904][    C0] R13: 00007ffc9d178134 R14: 00007ffc9d178150 R15: 000=
07ffc9d178140
[  114.726053][    C0]  </TASK>
[  114.729581][    C0] Kernel Offset: disabled
[  114.733979][    C0] Rebooting in 86400 seconds..


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
GOMODCACHE=3D'/syzkaller/jobs-2/linux/gopath/pkg/mod'
GONOPROXY=3D''
GONOSUMDB=3D''
GOOS=3D'linux'
GOPATH=3D'/syzkaller/jobs-2/linux/gopath'
GOPRIVATE=3D''
GOPROXY=3D'https://proxy.golang.org,direct'
GOROOT=3D'/usr/local/go'
GOSUMDB=3D'sum.golang.org'
GOTMPDIR=3D''
GOTOOLCHAIN=3D'auto'
GOTOOLDIR=3D'/usr/local/go/pkg/tool/linux_amd64'
GOVCS=3D''
GOVERSION=3D'go1.21.4'
GCCGO=3D'gccgo'
GOAMD64=3D'v1'
AR=3D'ar'
CC=3D'gcc'
CXX=3D'g++'
CGO_ENABLED=3D'1'
GOMOD=3D'/syzkaller/jobs-2/linux/gopath/src/github.com/google/syzkaller/go.=
mod'
GOWORK=3D''
CGO_CFLAGS=3D'-O2 -g'
CGO_CPPFLAGS=3D''
CGO_CXXFLAGS=3D'-O2 -g'
CGO_FFLAGS=3D'-O2 -g'
CGO_LDFLAGS=3D'-O2 -g'
PKG_CONFIG=3D'pkg-config'
GOGCCFLAGS=3D'-fPIC -m64 -pthread -Wl,--no-gc-sections -fmessage-length=3D0=
 -ffile-prefix-map=3D/tmp/go-build2172495115=3D/tmp/go-build -gno-record-gc=
c-switches'

git status (err=3D<nil>)
HEAD detached at c0f1611a3
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
touch .descriptions
GOOS=3Dlinux GOARCH=3Damd64 go build "-ldflags=3D-s -w -X github.com/google=
/syzkaller/prog.GitRevision=3Dc0f1611a36d66bb0bb8e2f294b97fb685bfc5f9c -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20240517-125934'" "-tags=
=3Dsyz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-fuzzer=
 github.com/google/syzkaller/syz-fuzzer
GOOS=3Dlinux GOARCH=3Damd64 go build "-ldflags=3D-s -w -X github.com/google=
/syzkaller/prog.GitRevision=3Dc0f1611a36d66bb0bb8e2f294b97fb685bfc5f9c -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20240517-125934'" "-tags=
=3Dsyz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-execpr=
og github.com/google/syzkaller/tools/syz-execprog
mkdir -p ./bin/linux_amd64
gcc -o ./bin/linux_amd64/syz-executor executor/executor.cc \
	-m64 -std=3Dc++11 -I. -Iexecutor/_include -O2 -pthread -Wall -Werror -Wpar=
entheses -Wunused-const-variable -Wframe-larger-than=3D16384 -Wno-stringop-=
overflow -Wno-array-bounds -Wno-format-overflow -Wno-unused-but-set-variabl=
e -Wno-unused-command-line-argument -static-pie -fpermissive -w -DGOOS_linu=
x=3D1 -DGOARCH_amd64=3D1 \
	-DHOSTGOOS_linux=3D1 -DGIT_REVISION=3D\"c0f1611a36d66bb0bb8e2f294b97fb685b=
fc5f9c\"


Error text is too large and was truncated, full error text is at:
https://syzkaller.appspot.com/x/error.txt?x=3D168f1592980000


Tested on:

commit:         70ec81c2 Merge tag 'linux_kselftest-next-6.10-rc1-fixe..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/li=
nux.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dd66c5ffb962c9d5=
b
dashboard link: https://syzkaller.appspot.com/bug?extid=3D07762f019fd03d01f=
04c
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debia=
n) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=3D10d50ad29800=
00


