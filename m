Return-Path: <linux-kernel+bounces-209860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F5A4903BF6
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 14:31:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 476F11C219DC
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 12:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15BE917C211;
	Tue, 11 Jun 2024 12:31:07 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C56217C20A
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 12:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718109065; cv=none; b=dMLdaROdbhCcCzplmJyTrhNHYWqsU0x8g6/D8ZwEXA44UCGa4CYqgwsxrVDu0GmFW2eDlEPBqpgzwYXefkp6DRAn/PtMiDiQkLvixvznug3k+VuxIJq9KWpz9jOoV2M8f63z7GdV4BYo3h5+y0uO66Rnyd48OsS8zuIEMxlXgSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718109065; c=relaxed/simple;
	bh=+LpCxicgrpS1Y43PaCwxhuWi5NkmObyJ6Jey6DBbCuE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=iFzR8YjiqDx05Fv0nSgCQlXR8g2yqsP67AGdEPwIEGs72I/VKGwW27rRR5D2lbHYDdTB9mWqS3FyJPtRHJdScUtSnWvw3ijXUN+eDB/XN9WkxZzJlHAghZc+gvXrxy5O2pvLrlF+ba70gmL30VG9KIpa8OBQ3qec84Af913rxDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-375c390cedeso2781075ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 05:31:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718109063; x=1718713863;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3iTBk5f04m+d8fEdI3p1kdZv8FluL/zH/1ktqP7Kduc=;
        b=BFE/AIsd82kHsYDgm81HYlxhwwOxhnmrT4gC3siEPNcGuO5GBrNxhHiiyDRQBZEzxN
         V6nsJxADajVSuv0bNKcjTRUqICcqUE8jheyzEKZroFJ74/58AVmUKbR6H7NbZY/83jJs
         Q/nt3+MshIvtzK2E7o2Q7FMOg3kPt2TiYR7xL6hO9jKIvN+Mzhlv4N2MssJfj/paexZA
         Kau6HBjXPw7EW1+kJBvFPTAv0BgfRUWHeIYmM44MxR5eFO59l81dbnGMsRB/aqJ/G8nM
         znqWAQJj3cUfwe6u1OBO4HtPXvItch9UVyDIUPdaulgglKNcZjdR9RGml1N8Trfx/ZX8
         HTYw==
X-Gm-Message-State: AOJu0YxO6YD6xH6Nxr+xfa+m9mmz9dXHKKh9z+tzuIeoQgp5Y7BCxFLE
	OW6AdSFa4NwQtuVad6gQGw27YOM8dOil8mm+N8de+q5JPm12WAW3BVCunIHmkpKeoaoKGk/LmeL
	WV5sbh63lk3tcauls6RqAi6kVBkzuP+eTNG729q8kOP3Uj0Tyqfv4MTE=
X-Google-Smtp-Source: AGHT+IFOSZp7t0cpEbVwiIMvapZ55SGIkAvOeNFuz69qMV7ybLcrwwkNUZVYWnV0LCWNJXMSKoW6eWNzCh+WagZAKgviFSEYqv/z
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a4c:b0:375:a202:2544 with SMTP id
 e9e14a558f8ab-375a2022843mr4369645ab.3.1718109063214; Tue, 11 Jun 2024
 05:31:03 -0700 (PDT)
Date: Tue, 11 Jun 2024 05:31:03 -0700
In-Reply-To: <PN2PR01MB4891E10D8A477396E9E2EF5AFCC72@PN2PR01MB4891.INDPRD01.PROD.OUTLOOK.COM>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000066065f061a9c7038@google.com>
Subject: Re: [syzbot] [bpf?] KMSAN: uninit-value in htab_lru_percpu_map_lookup_percpu_elem
From: syzbot <syzbot+1971e47e5210c718db3c@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	wojciech.gladysz@infogain.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

tack depth: 8144 bytes left
[   55.419101][ T4450] EXT4-fs (sda1): re-mounted 5941fea2-f5fa-4b4e-b5ef-9=
af118b27b95 r/w. Quota mode: none.
mount: mounting smackfs on /sys/fs/smackfs failed: No such file or director=
y
mount: mounting selinuxfs on /sys/fs/selinux failed: No such file or direct=
ory
[   55.779289][ T4453] mount (4453) used greatest stack depth: 5568 bytes l=
eft
Starting syslogd: OK
Starting acpid: OK
Starting klogd: OK
Running sysctl: OK
Populating /dev using udev: [   59.585501][ T4483] udevd[4483]: starting ve=
rsion 3.2.11
[   63.130230][ T4484] udevd[4484]: starting eudev-3.2.11
[   63.142629][ T4483] udevd (4483) used greatest stack depth: 5376 bytes l=
eft
[   96.265218][ T1224] net_ratelimit: 2 callbacks suppressed
[   96.265294][ T1224] aoe: packet could not be sent on lo.  consider incre=
asing tx_queue_len
[   96.280260][ T1224] aoe: packet could not be sent on bond0.  consider in=
creasing tx_queue_len
[   96.289350][ T1224] aoe: packet could not be sent on dummy0.  consider i=
ncreasing tx_queue_len
[   96.298544][ T1224] aoe: packet could not be sent on eql.  consider incr=
easing tx_queue_len
[   96.307476][ T1224] aoe: packet could not be sent on ifb0.  consider inc=
reasing tx_queue_len
[   96.316489][ T1224] aoe: packet could not be sent on ifb1.  consider inc=
reasing tx_queue_len
[   96.325548][ T1224] aoe: packet could not be sent on eth0.  consider inc=
reasing tx_queue_len
[   96.334622][ T1224] aoe: packet could not be sent on wlan0.  consider in=
creasing tx_queue_len
[   96.343626][ T1224] aoe: packet could not be sent on wlan1.  consider in=
creasing tx_queue_len
[   96.352793][ T1224] aoe: packet could not be sent on hwsim0.  consider i=
ncreasing tx_queue_len
done
Starting system message bus: done
Starting iptables: OK
Starting network: OK
Starting dhcpcd...
dhcpcd-9.4.1 starting
dev: loaded udev
DUID 00:04:98:24:4c:28:99:7c:d9:70:fe:51:ca:fe:56:33:2c:7d
forked to background, child pid 4696
[  111.030473][ T4697] 8021q: adding VLAN 0 to HW filter on device bond0
[  111.100696][ T4697] eql: remember to turn off Van-Jacobson compression o=
n your slave devices
[  111.616746][   T10] cfg80211: failed to load regulatory.db
Starting sshd: [  113.281387][ T4783] sshd (4783) used greatest stack depth=
: 4392 bytes left
OK


syzkaller

syzkaller login: [  114.141307][    C0] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[  114.148674][    C0] BUG: KMSAN: uninit-value in receive_buf+0x25e3/0x5fd=
0
[  114.155836][    C0]  receive_buf+0x25e3/0x5fd0
[  114.160622][    C0]  virtnet_poll+0xd1c/0x23c0
[  114.165429][    C0]  __napi_poll+0xe7/0x980
[  114.170059][    C0]  net_rx_action+0x82a/0x1850
[  114.174955][    C0]  handle_softirqs+0x1ce/0x800
[  114.179889][    C0]  __irq_exit_rcu+0x68/0x120
[  114.184692][    C0]  irq_exit_rcu+0x12/0x20
[  114.189250][    C0]  common_interrupt+0x94/0xa0
[  114.194165][    C0]  asm_common_interrupt+0x2b/0x40
[  114.199461][    C0]  virt_to_page_or_null+0xf0/0x150
[  114.204769][    C0]  kmsan_get_metadata+0x146/0x1d0
[  114.209965][    C0]  kmsan_get_shadow_origin_ptr+0x38/0xb0
[  114.215799][    C0]  __msan_metadata_ptr_for_load_8+0x24/0x40
[  114.221887][    C0]  is_last_task_frame+0x62/0x420
[  114.227000][    C0]  unwind_next_frame+0x9d/0x470
[  114.231997][    C0]  arch_stack_walk+0x1ec/0x2d0
[  114.237029][    C0]  stack_trace_save+0xaa/0xe0
[  114.241881][    C0]  kmsan_internal_chain_origin+0x57/0xd0
[  114.247698][    C0]  kmsan_internal_memmove_metadata+0x17b/0x230
[  114.254063][    C0]  __msan_memcpy+0x108/0x1c0
[  114.258744][    C0]  sock_write_iter+0x38e/0x3d0
[  114.263898][    C0]  vfs_write+0xb38/0x1550
[  114.268406][    C0]  ksys_write+0x20f/0x4c0
[  114.272940][    C0]  __x64_sys_write+0x93/0xe0
[  114.277742][    C0]  x64_sys_call+0x3093/0x3b90
[  114.283323][    C0]  do_syscall_64+0xcd/0x1e0
[  114.288178][    C0]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  114.294332][    C0]=20
[  114.296980][    C0] Uninit was created at:
[  114.301397][    C0]  __alloc_pages_noprof+0x9d6/0xe70
[  114.306908][    C0]  alloc_pages_mpol_noprof+0x299/0x990
[  114.312874][    C0]  alloc_pages_noprof+0x1bf/0x1e0
[  114.318109][    C0]  skb_page_frag_refill+0x2bf/0x7c0
[  114.323487][    C0]  virtnet_rq_alloc+0x43/0xbb0
[  114.328434][    C0]  try_fill_recv+0x3f0/0x2f50
[  114.333556][    C0]  virtnet_open+0x1cc/0xb00
[  114.338238][    C0]  __dev_open+0x546/0x6f0
[  114.342858][    C0]  __dev_change_flags+0x309/0x9a0
[  114.348074][    C0]  dev_change_flags+0x8e/0x1d0
[  114.353097][    C0]  devinet_ioctl+0x13ec/0x22c0
[  114.358127][    C0]  inet_ioctl+0x4bd/0x6d0
[  114.362784][    C0]  sock_do_ioctl+0xb7/0x540
[  114.367599][    C0]  sock_ioctl+0x727/0xd70
[  114.372193][    C0]  __se_sys_ioctl+0x261/0x450
[  114.377188][    C0]  __x64_sys_ioctl+0x96/0xe0
[  114.382012][    C0]  x64_sys_call+0x18c0/0x3b90
[  114.387389][    C0]  do_syscall_64+0xcd/0x1e0
[  114.392122][    C0]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  114.398360][    C0]=20
[  114.400882][    C0] CPU: 0 PID: 4697 Comm: dhcpcd Not tainted 6.10.0-rc3=
-syzkaller-00001-g956a9878a570 #0
[  114.410797][    C0] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 04/02/2024
[  114.421038][    C0] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[  114.428277][    C0] Disabling lock debugging due to kernel taint
[  114.434617][    C0] Kernel panic - not syncing: kmsan.panic set ...
[  114.441168][    C0] CPU: 0 PID: 4697 Comm: dhcpcd Tainted: G    B       =
       6.10.0-rc3-syzkaller-00001-g956a9878a570 #0
[  114.452775][    C0] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 04/02/2024
[  114.462940][    C0] Call Trace:
[  114.466456][    C0]  <IRQ>
[  114.469372][    C0]  dump_stack_lvl+0x216/0x2d0
[  114.474259][    C0]  ? kmsan_get_shadow_origin_ptr+0x4d/0xb0
[  114.480223][    C0]  dump_stack+0x1e/0x30
[  114.484499][    C0]  panic+0x4e2/0xcd0
[  114.488493][    C0]  ? kmsan_get_metadata+0x51/0x1d0
[  114.493722][    C0]  kmsan_report+0x2d5/0x2e0
[  114.498385][    C0]  ? kmsan_get_shadow_origin_ptr+0x4d/0xb0
[  114.504323][    C0]  ? kmsan_get_metadata+0x146/0x1d0
[  114.509625][    C0]  ? __msan_warning+0x95/0x120
[  114.514761][    C0]  ? receive_buf+0x25e3/0x5fd0
[  114.519656][    C0]  ? virtnet_poll+0xd1c/0x23c0
[  114.524559][    C0]  ? __napi_poll+0xe7/0x980
[  114.529199][    C0]  ? net_rx_action+0x82a/0x1850
[  114.534316][    C0]  ? handle_softirqs+0x1ce/0x800
[  114.539583][    C0]  ? __irq_exit_rcu+0x68/0x120
[  114.544544][    C0]  ? irq_exit_rcu+0x12/0x20
[  114.549164][    C0]  ? common_interrupt+0x94/0xa0
[  114.554156][    C0]  ? asm_common_interrupt+0x2b/0x40
[  114.559485][    C0]  ? virt_to_page_or_null+0xf0/0x150
[  114.564878][    C0]  ? kmsan_get_metadata+0x146/0x1d0
[  114.570183][    C0]  ? kmsan_get_shadow_origin_ptr+0x38/0xb0
[  114.576101][    C0]  ? __msan_metadata_ptr_for_load_8+0x24/0x40
[  114.582270][    C0]  ? is_last_task_frame+0x62/0x420
[  114.587529][    C0]  ? unwind_next_frame+0x9d/0x470
[  114.592633][    C0]  ? arch_stack_walk+0x1ec/0x2d0
[  114.597935][    C0]  ? stack_trace_save+0xaa/0xe0
[  114.602932][    C0]  ? kmsan_internal_chain_origin+0x57/0xd0
[  114.609058][    C0]  ? kmsan_internal_memmove_metadata+0x17b/0x230
[  114.615513][    C0]  ? __msan_memcpy+0x108/0x1c0
[  114.620375][    C0]  ? sock_write_iter+0x38e/0x3d0
[  114.625423][    C0]  ? vfs_write+0xb38/0x1550
[  114.630144][    C0]  ? ksys_write+0x20f/0x4c0
[  114.634752][    C0]  ? __x64_sys_write+0x93/0xe0
[  114.639611][    C0]  ? x64_sys_call+0x3093/0x3b90
[  114.644574][    C0]  ? do_syscall_64+0xcd/0x1e0
[  114.649357][    C0]  ? entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  114.655580][    C0]  ? kmsan_get_metadata+0x146/0x1d0
[  114.661089][    C0]  ? kmsan_get_metadata+0x146/0x1d0
[  114.666460][    C0]  ? page_to_skb+0xdae/0x1620
[  114.671465][    C0]  ? kmsan_get_metadata+0x146/0x1d0
[  114.676893][    C0]  __msan_warning+0x95/0x120
[  114.681587][    C0]  receive_buf+0x25e3/0x5fd0
[  114.686629][    C0]  ? kmsan_get_metadata+0x146/0x1d0
[  114.692034][    C0]  ? kmsan_get_shadow_origin_ptr+0x4d/0xb0
[  114.697966][    C0]  virtnet_poll+0xd1c/0x23c0
[  114.702687][    C0]  ? __pfx_virtnet_poll+0x10/0x10
[  114.707811][    C0]  __napi_poll+0xe7/0x980
[  114.712253][    C0]  ? kmsan_get_metadata+0x146/0x1d0
[  114.717564][    C0]  net_rx_action+0x82a/0x1850
[  114.722441][    C0]  ? sched_clock_cpu+0x55/0x870
[  114.727421][    C0]  ? __pfx_net_rx_action+0x10/0x10
[  114.732628][    C0]  handle_softirqs+0x1ce/0x800
[  114.737611][    C0]  __irq_exit_rcu+0x68/0x120
[  114.742301][    C0]  irq_exit_rcu+0x12/0x20
[  114.746720][    C0]  common_interrupt+0x94/0xa0
[  114.751524][    C0]  </IRQ>
[  114.754533][    C0]  <TASK>
[  114.757619][    C0]  asm_common_interrupt+0x2b/0x40
[  114.762781][    C0] RIP: 0010:virt_to_page_or_null+0xf0/0x150
[  114.768821][    C0] Code: f6 c0 08 75 15 48 c1 ea 15 48 8b 76 08 83 e2 3=
f 31 c9 48 0f a3 56 10 0f 92 c1 65 ff 0d 11 43 c5 7d 74 4d 65 ff 0d 08 43 c=
5 7d <85> c9 0f 84 3b ff ff ff 48 81 ff 00 00 00 80 72 09 48 8b 0d 78 74
[  114.788641][    C0] RSP: 0018:ffff8881160076b0 EFLAGS: 00000286
[  114.794817][    C0] RAX: ffff888194a30020 RBX: ffff888114a30020 RCX: 000=
0000000000001
[  114.802961][    C0] RDX: 0000000114a30020 RSI: ffff88813fff9220 RDI: fff=
f888114a30020
[  114.811014][    C0] RBP: ffff8881160076b0 R08: ffffea000000000f R09: fff=
f888116004000
[  114.819084][    C0] R10: ffff888116007818 R11: ffffffff81935550 R12: 000=
0000000000000
[  114.827135][    C0] R13: 0000000000000000 R14: 0000000000000000 R15: fff=
f888114a30020
[  114.835190][    C0]  ? __pfx_stack_trace_consume_entry+0x10/0x10
[  114.841475][    C0]  kmsan_get_metadata+0x146/0x1d0
[  114.846629][    C0]  kmsan_get_shadow_origin_ptr+0x38/0xb0
[  114.852370][    C0]  __msan_metadata_ptr_for_load_8+0x24/0x40
[  114.858386][    C0]  is_last_task_frame+0x62/0x420
[  114.863429][    C0]  ? kmsan_get_shadow_origin_ptr+0x4d/0xb0
[  114.869401][    C0]  unwind_next_frame+0x9d/0x470
[  114.874444][    C0]  arch_stack_walk+0x1ec/0x2d0
[  114.879348][    C0]  ? do_syscall_64+0xcd/0x1e0
[  114.884168][    C0]  ? __pfx_stack_trace_consume_entry+0x10/0x10
[  114.890569][    C0]  stack_trace_save+0xaa/0xe0
[  114.895448][    C0]  kmsan_internal_chain_origin+0x57/0xd0
[  114.901315][    C0]  ? kmsan_internal_chain_origin+0x57/0xd0
[  114.907242][    C0]  ? kmsan_internal_memmove_metadata+0x17b/0x230
[  114.913797][    C0]  ? __msan_memcpy+0x108/0x1c0
[  114.918732][    C0]  ? sock_write_iter+0x38e/0x3d0
[  114.923798][    C0]  ? vfs_write+0xb38/0x1550
[  114.928458][    C0]  ? ksys_write+0x20f/0x4c0
[  114.933071][    C0]  ? __x64_sys_write+0x93/0xe0
[  114.937962][    C0]  ? x64_sys_call+0x3093/0x3b90
[  114.943128][    C0]  ? do_syscall_64+0xcd/0x1e0
[  114.947923][    C0]  ? kmsan_get_metadata+0x146/0x1d0
[  114.953292][    C0]  ? kmsan_internal_set_shadow_origin+0x69/0x100
[  114.959771][    C0]  ? kmsan_get_metadata+0x146/0x1d0
[  114.965109][    C0]  ? kmsan_get_metadata+0x146/0x1d0
[  114.970431][    C0]  ? kmsan_get_shadow_origin_ptr+0x4d/0xb0
[  114.976472][    C0]  ? unix_dgram_sendmsg+0xd93/0x2ce0
[  114.981868][    C0]  ? aa_sk_perm+0x881/0xd90
[  114.986487][    C0]  ? kmsan_get_metadata+0x146/0x1d0
[  114.991792][    C0]  ? kmsan_get_shadow_origin_ptr+0x4d/0xb0
[  114.997731][    C0]  ? kmsan_get_metadata+0x146/0x1d0
[  115.003121][    C0]  kmsan_internal_memmove_metadata+0x17b/0x230
[  115.009411][    C0]  __msan_memcpy+0x108/0x1c0
[  115.014216][    C0]  sock_write_iter+0x38e/0x3d0
[  115.019109][    C0]  vfs_write+0xb38/0x1550
[  115.023542][    C0]  ? __pfx_sock_write_iter+0x10/0x10
[  115.029014][    C0]  ksys_write+0x20f/0x4c0
[  115.033533][    C0]  __x64_sys_write+0x93/0xe0
[  115.038236][    C0]  x64_sys_call+0x3093/0x3b90
[  115.043164][    C0]  do_syscall_64+0xcd/0x1e0
[  115.047796][    C0]  ? clear_bhb_loop+0x25/0x80
[  115.052625][    C0]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  115.058663][    C0] RIP: 0033:0x7f96e0e10bf2
[  115.063173][    C0] Code: 89 c7 48 89 44 24 08 e8 7b 34 fa ff 48 8b 44 2=
4 08 48 83 c4 28 c3 c3 64 8b 04 25 18 00 00 00 85 c0 75 20 b8 01 00 00 00 0=
f 05 <48> 3d 00 f0 ff ff 76 6f 48 8b 15 07 a2 0d 00 f7 d8 64 89 02 48 83
[  115.082994][    C0] RSP: 002b:00007fffc25d6c88 EFLAGS: 00000246 ORIG_RAX=
: 0000000000000001
[  115.091610][    C0] RAX: ffffffffffffffda RBX: 00007f96e0eec4c0 RCX: 000=
07f96e0e10bf2
[  115.099666][    C0] RDX: 0000000000000020 RSI: 00005598f18db020 RDI: 000=
0000000000002
[  115.108056][    C0] RBP: 0000000000000020 R08: 0000000000000000 R09: 000=
0000000000000
[  115.116367][    C0] R10: 00007fffc25d7a50 R11: 0000000000000246 R12: 000=
0000000000020
[  115.124456][    C0] R13: 00005598f18db020 R14: 0000000000000000 R15: 000=
0000000000000
[  115.132580][    C0]  </TASK>
[  115.136102][    C0] Kernel Offset: disabled
[  115.140501][    C0] Rebooting in 86400 seconds..


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
 -ffile-prefix-map=3D/tmp/go-build3221393454=3D/tmp/go-build -gno-record-gc=
c-switches'

git status (err=3D<nil>)
HEAD detached at c8349e4853
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
/syzkaller/prog.GitRevision=3Dc8349e48534ea6d8f01515335d95de8ebf5da8df -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20240412-102842'" "-tags=
=3Dsyz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-fuzzer=
 github.com/google/syzkaller/syz-fuzzer
GOOS=3Dlinux GOARCH=3Damd64 go build "-ldflags=3D-s -w -X github.com/google=
/syzkaller/prog.GitRevision=3Dc8349e48534ea6d8f01515335d95de8ebf5da8df -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20240412-102842'" "-tags=
=3Dsyz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-execpr=
og github.com/google/syzkaller/tools/syz-execprog
GOOS=3Dlinux GOARCH=3Damd64 go build "-ldflags=3D-s -w -X github.com/google=
/syzkaller/prog.GitRevision=3Dc8349e48534ea6d8f01515335d95de8ebf5da8df -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20240412-102842'" "-tags=
=3Dsyz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-stress=
 github.com/google/syzkaller/tools/syz-stress
mkdir -p ./bin/linux_amd64
gcc -o ./bin/linux_amd64/syz-executor executor/executor.cc \
	-m64 -O2 -pthread -Wall -Werror -Wparentheses -Wunused-const-variable -Wfr=
ame-larger-than=3D16384 -Wno-stringop-overflow -Wno-array-bounds -Wno-forma=
t-overflow -Wno-unused-but-set-variable -Wno-unused-command-line-argument -=
static-pie -fpermissive -w -DGOOS_linux=3D1 -DGOARCH_amd64=3D1 \
	-DHOSTGOOS_linux=3D1 -DGIT_REVISION=3D\"c8349e48534ea6d8f01515335d95de8ebf=
5da8df\"


Error text is too large and was truncated, full error text is at:
https://syzkaller.appspot.com/x/error.txt?x=3D1344182e980000


Tested on:

commit:         956a9878 kernel/bpf: KMSAN: uninit-value in htab_lru_p..
git tree:       https://linux.googlesource.com/linux/kernel/git/torvalds/li=
nux
kernel config:  https://syzkaller.appspot.com/x/.config?x=3D3486f1660f47f85=
5
dashboard link: https://syzkaller.appspot.com/bug?extid=3D1971e47e5210c718d=
b3c
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debia=
n) 2.40

Note: no patches were applied.

