Return-Path: <linux-kernel+bounces-203892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 56FA18FE1AD
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 10:55:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A65D1B27B55
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 08:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 458DE13DDAA;
	Thu,  6 Jun 2024 08:53:06 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D520130497
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 08:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717663985; cv=none; b=l/RsNBOgxP+XyOFTSF475/htTWTWgYd/8Zc27aic8z5j/FMfJkHMHAopVMo2n7XZVF3oJoxB/Pi5432PULpmbeMxVbCtlF+WmIgNCxnc4Z0rWJY5AsRb/7/ENAhJbalUPCMgAH1loXM0Ig8EBgN742yLFLEQFKG6t/X1YPK/v54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717663985; c=relaxed/simple;
	bh=4+zMEDx9JfVQOCQfDkcMPNcKRYBqMxV+iggmlfEyOPI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=UHe4ya2PF/ROBHnR3iDtolyvFljZPdhYACyT09J3o+v0v9iz3h3v4sT6c5hPwUeNyFGFsjM26dxWsL9w3H0pAnVtLQMyYMhdBCzVzPP0U2nhtH2R/wfSHqam1dkrORphEH2+yipCTyM/ZcG1dlb0iT6RXFm39ItqHU7JYcQz1fA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7e94cac3ee5so84175739f.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 01:53:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717663982; x=1718268782;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WMsprSElVn1jUPJ2aYTVOSQiG5moV4ILc0rotZTs4bg=;
        b=vNl8SgyauzlG1EvfpWUeSgFmEUCYqjWlo7JVDFjnq0D2kVCX7AUDqiENPdCRIlhtFf
         9bM+rmEX9TqZsY32xmUvlGOHoSgBwnbr8m5x1a1RjNDqeeSqPT30qJaqXMJqquvVyahZ
         0pvtjYYmguuaFrteItnDSg4UhtpBEzvu1MBE6aKhilpGUD/C0GLAx1xOOjXjITG/uRf9
         DNp0s4evOwmM5T+bmrSCKJ0UHyWzkExXn+9EIs8NBVCX7SRRrJjCfVr6ANrgNUwiNnQf
         Na3hKr7PKI3h2CZIQ3hCKQvtFQnyjL/1YQJ+cqXNUjbqZaEkvkF4REW4JyIDLURCYHzW
         rDIQ==
X-Gm-Message-State: AOJu0YyQAFFdlpw2jPEBPJ1AnzslPM6s16pZQeKBB+/sCn1VejIrumwg
	wFkPcLOAiKfPKbxpysSnr0wqtudJjEabF+0jzU5F1XCcAnQ9wAOVulSAmx0XMNZTnIOmkO41e6M
	NcyBcRLR3ADp+qrWuKm3fKuVnvnhiSXal6z3WeDpwvcYHNFOUMy9oWU0=
X-Google-Smtp-Source: AGHT+IEGw6ogPFt7hMmYeGmKXl/myhIcwfIVoJgOojlEBQjxD/Z+nSqODFfD946qPbLqz005q2TwFMKyx0vCO21eoFTVyiEL6jB+
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:6283:b0:4b4:5d22:e7d1 with SMTP id
 8926c6da1cb9f-4b63a907f70mr191734173.4.1717663982277; Thu, 06 Jun 2024
 01:53:02 -0700 (PDT)
Date: Thu, 06 Jun 2024 01:53:02 -0700
In-Reply-To: <CAL+9cWLX1GB8ZEQaHD2dz5z=OOiKnzfuJXFZa04Lv9H4KqKW=Q@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000081ec4e061a34cf0b@google.com>
Subject: Re: [syzbot] [ext4] KMSAN: uninit-value in aes_encrypt (5)
From: syzbot <syzbot+aeb14e2539ffb6d21130@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, norkam41@gmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

d greatest stack depth: 8144 bytes left
[   54.409458][ T4445] EXT4-fs (sda1): re-mounted 5941fea2-f5fa-4b4e-b5ef-9=
af118b27b95 r/w. Quota mode: none.
mount: mounting smackfs on /sys/fs/smackfs failed: No such file or director=
y
mount: mounting selinuxfs on /sys/fs/selinux failed: No such file or direct=
ory
[   54.752888][ T4448] mount (4448) used greatest stack depth: 5568 bytes l=
eft
Starting syslogd: OK
Starting acpid: OK
Starting klogd: OK
Running sysctl: OK
Populating /dev using udev: [   58.568520][ T4478] udevd[4478]: starting ve=
rsion 3.2.11
[   62.084670][ T4479] udevd[4479]: starting eudev-3.2.11
[   62.097228][ T4478] udevd (4478) used greatest stack depth: 5160 bytes l=
eft
[   96.250159][ T1225] net_ratelimit: 2 callbacks suppressed
[   96.250230][ T1225] aoe: packet could not be sent on lo.  consider incre=
asing tx_queue_len
[   96.265039][ T1225] aoe: packet could not be sent on bond0.  consider in=
creasing tx_queue_len
[   96.274247][ T1225] aoe: packet could not be sent on dummy0.  consider i=
ncreasing tx_queue_len
[   96.283534][ T1225] aoe: packet could not be sent on eql.  consider incr=
easing tx_queue_len
[   96.292534][ T1225] aoe: packet could not be sent on ifb0.  consider inc=
reasing tx_queue_len
[   96.301553][ T1225] aoe: packet could not be sent on ifb1.  consider inc=
reasing tx_queue_len
[   96.311305][ T1225] aoe: packet could not be sent on eth0.  consider inc=
reasing tx_queue_len
[   96.320356][ T1225] aoe: packet could not be sent on wlan0.  consider in=
creasing tx_queue_len
[   96.329652][ T1225] aoe: packet could not be sent on wlan1.  consider in=
creasing tx_queue_len
[   96.338843][ T1225] aoe: packet could not be sent on hwsim0.  consider i=
ncreasing tx_queue_len
done
Starting system message bus: done
Starting iptables: OK
Starting network: OK
Starting dhcpcd...
dhcpcd-9.4.1 starting
dev: loaded udev
DUID 00:04:c7:fd:4a:df:9d:a6:e9:60:55:7b:b4:5b:1f:77:00:5c
forked to background, child pid 4692
[  109.206454][ T4693] 8021q: adding VLAN 0 to HW filter on device bond0
[  109.248494][ T4693] eql: remember to turn off Van-Jacobson compression o=
n your slave devices
[  110.193163][    C0] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[  110.200570][    C0] BUG: KMSAN: uninit-value in receive_buf+0x25e3/0x5fd=
0
[  110.207866][    C0]  receive_buf+0x25e3/0x5fd0
[  110.212658][    C0]  virtnet_poll+0xd1c/0x23c0
[  110.217587][    C0]  __napi_poll+0xe7/0x980
[  110.222127][    C0]  net_rx_action+0x82a/0x1850
[  110.227132][    C0]  handle_softirqs+0x1ce/0x800
[  110.232093][    C0]  __irq_exit_rcu+0x68/0x120
[  110.236963][    C0]  irq_exit_rcu+0x12/0x20
[  110.241471][    C0]  common_interrupt+0x94/0xa0
[  110.246533][    C0]  asm_common_interrupt+0x2b/0x40
[  110.251753][    C0]  virt_to_page_or_null+0x63/0x150
[  110.257214][    C0]  kmsan_get_metadata+0x146/0x1d0
[  110.262426][    C0]  kmsan_get_shadow_origin_ptr+0x38/0xb0
[  110.268508][    C0]  __msan_metadata_ptr_for_store_4+0x27/0x40
[  110.274681][    C0]  sha256_transform_blocks+0xb62/0x2e90
[  110.280603][    C0]  sha256_update+0x2ff/0x340
[  110.285390][    C0]  crypto_sha256_update+0x37/0x60
[  110.290776][    C0]  crypto_shash_update+0x79/0xa0
[  110.295878][    C0]  ima_calc_file_hash+0x180a/0x3c90
[  110.301343][    C0]  ima_collect_measurement+0x473/0xd30
[  110.307116][    C0]  process_measurement+0x295d/0x3f50
[  110.312632][    C0]  ima_file_check+0xb4/0x100
[  110.317592][    C0]  security_file_post_open+0x9c/0x150
[  110.323195][    C0]  path_openat+0x4da5/0x5b70
[  110.328116][    C0]  do_filp_open+0x20e/0x590
[  110.332790][    C0]  do_sys_openat2+0x1bf/0x2f0
[  110.337769][    C0]  __x64_sys_openat+0x2a1/0x310
[  110.342834][    C0]  x64_sys_call+0x128b/0x3b90
[  110.347880][    C0]  do_syscall_64+0xcd/0x1e0
[  110.352571][    C0]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  110.359359][    C0]=20
[  110.361772][    C0] Uninit was created at:
[  110.366321][    C0]  __alloc_pages_noprof+0x9d6/0xe70
[  110.371715][    C0]  alloc_pages_mpol_noprof+0x299/0x990
[  110.377535][    C0]  alloc_pages_noprof+0x1bf/0x1e0
[  110.382768][    C0]  skb_page_frag_refill+0x2bf/0x7c0
[  110.388295][    C0]  virtnet_rq_alloc+0x43/0xbb0
[  110.393231][    C0]  try_fill_recv+0x3f0/0x2f50
[  110.398234][    C0]  virtnet_open+0x1cc/0xb00
[  110.402950][    C0]  __dev_open+0x546/0x6f0
[  110.407526][    C0]  __dev_change_flags+0x309/0x9a0
[  110.412731][    C0]  dev_change_flags+0x8e/0x1d0
[  110.417804][    C0]  devinet_ioctl+0x13ec/0x22c0
[  110.422782][    C0]  inet_ioctl+0x4bd/0x6d0
[  110.427442][    C0]  sock_do_ioctl+0xb7/0x540
[  110.432118][    C0]  sock_ioctl+0x727/0xd70
[  110.436760][    C0]  __se_sys_ioctl+0x261/0x450
[  110.441605][    C0]  __x64_sys_ioctl+0x96/0xe0
[  110.446445][    C0]  x64_sys_call+0x18c0/0x3b90
[  110.451323][    C0]  do_syscall_64+0xcd/0x1e0
[  110.456170][    C0]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  110.462269][    C0]=20
[  110.464785][    C0] CPU: 0 PID: 4771 Comm: ssh-keygen Not tainted 6.10.0=
-rc2-syzkaller-00097-g2df0193e62cf #0
[  110.475212][    C0] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 04/02/2024
[  110.485516][    C0] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[  110.492710][    C0] Disabling lock debugging due to kernel taint
[  110.499145][    C0] Kernel panic - not syncing: kmsan.panic set ...
[  110.505681][    C0] CPU: 0 PID: 4771 Comm: ssh-keygen Tainted: G    B   =
           6.10.0-rc2-syzkaller-00097-g2df0193e62cf #0
[  110.517420][    C0] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 04/02/2024
[  110.527734][    C0] Call Trace:
[  110.531227][    C0]  <IRQ>
[  110.534184][    C0]  dump_stack_lvl+0x216/0x2d0
[  110.539062][    C0]  ? kmsan_get_shadow_origin_ptr+0x4d/0xb0
[  110.545091][    C0]  dump_stack+0x1e/0x30
[  110.549446][    C0]  panic+0x4e2/0xcd0
[  110.553533][    C0]  ? kmsan_get_metadata+0xe1/0x1d0
[  110.558872][    C0]  kmsan_report+0x2d5/0x2e0
[  110.563577][    C0]  ? kmsan_get_metadata+0x146/0x1d0
[  110.568991][    C0]  ? kmsan_get_shadow_origin_ptr+0x4d/0xb0
[  110.575052][    C0]  ? kmsan_get_metadata+0x146/0x1d0
[  110.580462][    C0]  ? __msan_warning+0x95/0x120
[  110.585421][    C0]  ? receive_buf+0x25e3/0x5fd0
[  110.590382][    C0]  ? virtnet_poll+0xd1c/0x23c0
[  110.595344][    C0]  ? __napi_poll+0xe7/0x980
[  110.600064][    C0]  ? net_rx_action+0x82a/0x1850
[  110.605087][    C0]  ? handle_softirqs+0x1ce/0x800
[  110.610229][    C0]  ? __irq_exit_rcu+0x68/0x120
[  110.615183][    C0]  ? irq_exit_rcu+0x12/0x20
[  110.619871][    C0]  ? common_interrupt+0x94/0xa0
[  110.624976][    C0]  ? asm_common_interrupt+0x2b/0x40
[  110.630393][    C0]  ? virt_to_page_or_null+0x63/0x150
[  110.635888][    C0]  ? kmsan_get_metadata+0x146/0x1d0
[  110.641295][    C0]  ? kmsan_get_shadow_origin_ptr+0x38/0xb0
[  110.647335][    C0]  ? __msan_metadata_ptr_for_store_4+0x27/0x40
[  110.653702][    C0]  ? sha256_transform_blocks+0xb62/0x2e90
[  110.659653][    C0]  ? sha256_update+0x2ff/0x340
[  110.664710][    C0]  ? crypto_sha256_update+0x37/0x60
[  110.670235][    C0]  ? crypto_shash_update+0x79/0xa0
[  110.675963][    C0]  ? ima_calc_file_hash+0x180a/0x3c90
[  110.681516][    C0]  ? ima_collect_measurement+0x473/0xd30
[  110.687335][    C0]  ? process_measurement+0x295d/0x3f50
[  110.693021][    C0]  ? ima_file_check+0xb4/0x100
[  110.698199][    C0]  ? security_file_post_open+0x9c/0x150
[  110.703983][    C0]  ? path_openat+0x4da5/0x5b70
[  110.708912][    C0]  ? do_filp_open+0x20e/0x590
[  110.713692][    C0]  ? do_sys_openat2+0x1bf/0x2f0
[  110.718671][    C0]  ? __x64_sys_openat+0x2a1/0x310
[  110.723932][    C0]  ? x64_sys_call+0x128b/0x3b90
[  110.728920][    C0]  ? do_syscall_64+0xcd/0x1e0
[  110.734054][    C0]  ? entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  110.740238][    C0]  ? kmsan_get_metadata+0x146/0x1d0
[  110.745543][    C0]  ? kmsan_get_metadata+0x146/0x1d0
[  110.750847][    C0]  ? page_to_skb+0xdae/0x1620
[  110.755639][    C0]  __msan_warning+0x95/0x120
[  110.760340][    C0]  receive_buf+0x25e3/0x5fd0
[  110.765033][    C0]  ? kmsan_get_metadata+0x146/0x1d0
[  110.770447][    C0]  ? kmsan_get_shadow_origin_ptr+0x4d/0xb0
[  110.776424][    C0]  virtnet_poll+0xd1c/0x23c0
[  110.781146][    C0]  ? __pfx_virtnet_poll+0x10/0x10
[  110.786270][    C0]  __napi_poll+0xe7/0x980
[  110.790708][    C0]  ? kmsan_get_metadata+0x146/0x1d0
[  110.796015][    C0]  net_rx_action+0x82a/0x1850
[  110.800811][    C0]  ? sched_clock_cpu+0x55/0x870
[  110.805780][    C0]  ? __pfx_net_rx_action+0x10/0x10
[  110.811008][    C0]  handle_softirqs+0x1ce/0x800
[  110.815973][    C0]  __irq_exit_rcu+0x68/0x120
[  110.820694][    C0]  irq_exit_rcu+0x12/0x20
[  110.825140][    C0]  common_interrupt+0x94/0xa0
[  110.829944][    C0]  </IRQ>
[  110.832924][    C0]  <TASK>
[  110.835905][    C0]  asm_common_interrupt+0x2b/0x40
[  110.841045][    C0] RIP: 0010:virt_to_page_or_null+0x63/0x150
[  110.847064][    C0] Code: cc cc 48 3d ff ff ff 1f 77 f0 48 8b 15 c6 de c=
1 0e 48 01 c2 65 ff 05 34 ad c4 7d 31 c9 48 89 d6 48 c1 ee 2e 0f 85 86 00 0=
0 00 <48> 8b 0d 7e bb a6 11 48 85 c9 74 23 48 89 d6 48 c1 ee 23 48 8b 34
[  110.867148][    C0] RSP: 0018:ffff88811fc72d98 EFLAGS: 00000246
[  110.873309][    C0] RAX: ffff88819fc73070 RBX: ffff88811fc73070 RCX: 000=
0000000000000
[  110.881392][    C0] RDX: 000000011fc73070 RSI: 0000000000000000 RDI: fff=
f88811fc73070
[  110.889444][    C0] RBP: ffff88811fc72d98 R08: ffffea000000000f R09: 000=
000007c17d933
[  110.897494][    C0] R10: 0000000000000000 R11: 00000000011600cf R12: 000=
0000000000000
[  110.905549][    C0] R13: 00000000b7197e49 R14: 0000000000000000 R15: fff=
f88811fc73070
[  110.913623][    C0]  kmsan_get_metadata+0x146/0x1d0
[  110.918772][    C0]  kmsan_get_shadow_origin_ptr+0x38/0xb0
[  110.924553][    C0]  __msan_metadata_ptr_for_store_4+0x27/0x40
[  110.930658][    C0]  sha256_transform_blocks+0xb62/0x2e90
[  110.936383][    C0]  sha256_update+0x2ff/0x340
[  110.941127][    C0]  crypto_sha256_update+0x37/0x60
[  110.946270][    C0]  ? __pfx_crypto_sha256_update+0x10/0x10
[  110.952110][    C0]  crypto_shash_update+0x79/0xa0
[  110.957145][    C0]  ima_calc_file_hash+0x180a/0x3c90
[  110.962433][    C0]  ? kmsan_get_shadow_origin_ptr+0x4d/0xb0
[  110.968379][    C0]  ? kmsan_get_metadata+0x146/0x1d0
[  110.973710][    C0]  ? kmsan_get_metadata+0x146/0x1d0
[  110.979030][    C0]  ? kmsan_get_shadow_origin_ptr+0x4d/0xb0
[  110.984967][    C0]  ? generic_fillattr+0x568/0x820
[  110.990125][    C0]  ? ext4_getattr+0xcba/0x1010
[  110.994998][    C0]  ? kmsan_get_metadata+0x146/0x1d0
[  111.000313][    C0]  ? kmsan_get_shadow_origin_ptr+0x4d/0xb0
[  111.006267][    C0]  ? ext4_file_getattr+0x27f/0x3f0
[  111.011551][    C0]  ? kmsan_get_metadata+0x146/0x1d0
[  111.016855][    C0]  ? kmsan_get_metadata+0x146/0x1d0
[  111.022199][    C0]  ? kmsan_get_shadow_origin_ptr+0x4d/0xb0
[  111.028414][    C0]  ima_collect_measurement+0x473/0xd30
[  111.033987][    C0]  ? __pfx_ext4_xattr_security_get+0x10/0x10
[  111.040104][    C0]  ? vfs_getxattr_alloc+0xb3b/0xc10
[  111.045424][    C0]  process_measurement+0x295d/0x3f50
[  111.050857][    C0]  ? kmsan_get_metadata+0x146/0x1d0
[  111.056197][    C0]  ? ima_file_check+0x41/0x100
[  111.061175][    C0]  ? kmsan_get_metadata+0x146/0x1d0
[  111.066491][    C0]  ? kmsan_get_shadow_origin_ptr+0x4d/0xb0
[  111.072421][    C0]  ? end_current_label_crit_section+0x124/0x2a0
[  111.078813][    C0]  ? kmsan_get_metadata+0x146/0x1d0
[  111.084160][    C0]  ? kmsan_get_shadow_origin_ptr+0x4d/0xb0
[  111.090080][    C0]  ? kmsan_get_metadata+0x146/0x1d0
[  111.095379][    C0]  ? kmsan_get_shadow_origin_ptr+0x4d/0xb0
[  111.101380][    C0]  ima_file_check+0xb4/0x100
[  111.106112][    C0]  ? __pfx_ima_file_check+0x10/0x10
[  111.111487][    C0]  security_file_post_open+0x9c/0x150
[  111.116988][    C0]  path_openat+0x4da5/0x5b70
[  111.121704][    C0]  do_filp_open+0x20e/0x590
[  111.126417][    C0]  do_sys_openat2+0x1bf/0x2f0
[  111.131210][    C0]  __x64_sys_openat+0x2a1/0x310
[  111.136184][    C0]  x64_sys_call+0x128b/0x3b90
[  111.140994][    C0]  do_syscall_64+0xcd/0x1e0
[  111.145640][    C0]  ? clear_bhb_loop+0x25/0x80
[  111.150465][    C0]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  111.156495][    C0] RIP: 0033:0x7f5bc4066a46
[  111.160991][    C0] Code: 10 00 00 00 44 8b 54 24 e0 48 89 44 24 c0 48 8=
d 44 24 d0 48 89 44 24 c8 44 89 c2 4c 89 ce bf 9c ff ff ff b8 01 01 00 00 0=
f 05 <48> 3d 00 f0 ff ff 76 0c f7 d8 89 05 0a 48 01 00 48 83 c8 ff c3 31
[  111.180724][    C0] RSP: 002b:00007ffeb8e017b8 EFLAGS: 00000287 ORIG_RAX=
: 0000000000000101
[  111.189424][    C0] RAX: ffffffffffffffda RBX: 00007ffeb8e01a18 RCX: 000=
07f5bc4066a46
[  111.197479][    C0] RDX: 0000000000080000 RSI: 00007ffeb8e01830 RDI: 000=
00000ffffff9c
[  111.205522][    C0] RBP: 00007ffeb8e01820 R08: 0000000000080000 R09: 000=
07ffeb8e01830
[  111.213573][    C0] R10: 0000000000000000 R11: 0000000000000287 R12: 000=
07ffeb8e01830
[  111.221646][    C0] R13: 0000000000000009 R14: 00007ffeb8e019ff R15: 000=
00000ffffffff
[  111.229808][    C0]  </TASK>
[  111.233238][    C0] Kernel Offset: disabled
[  111.237626][    C0] Rebooting in 86400 seconds..


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
 -ffile-prefix-map=3D/tmp/go-build1950147168=3D/tmp/go-build -gno-record-gc=
c-switches'

git status (err=3D<nil>)
HEAD detached at de979bc20b
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
/syzkaller/prog.GitRevision=3Dde979bc20b2b73242b7d6fbbdf614a8cb4c574f4 -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20240509-085021'" "-tags=
=3Dsyz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-fuzzer=
 github.com/google/syzkaller/syz-fuzzer
GOOS=3Dlinux GOARCH=3Damd64 go build "-ldflags=3D-s -w -X github.com/google=
/syzkaller/prog.GitRevision=3Dde979bc20b2b73242b7d6fbbdf614a8cb4c574f4 -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20240509-085021'" "-tags=
=3Dsyz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-execpr=
og github.com/google/syzkaller/tools/syz-execprog
mkdir -p ./bin/linux_amd64
gcc -o ./bin/linux_amd64/syz-executor executor/executor.cc \
	-m64 -std=3Dc++11 -I. -Iexecutor/_include -O2 -pthread -Wall -Werror -Wpar=
entheses -Wunused-const-variable -Wframe-larger-than=3D16384 -Wno-stringop-=
overflow -Wno-array-bounds -Wno-format-overflow -Wno-unused-but-set-variabl=
e -Wno-unused-command-line-argument -static-pie -fpermissive -w -DGOOS_linu=
x=3D1 -DGOARCH_amd64=3D1 \
	-DHOSTGOOS_linux=3D1 -DGIT_REVISION=3D\"de979bc20b2b73242b7d6fbbdf614a8cb4=
c574f4\"


Error text is too large and was truncated, full error text is at:
https://syzkaller.appspot.com/x/error.txt?x=3D13d54aba980000


Tested on:

commit:         2df0193e Merge tag 'thermal-6.10-rc3' of git://git.ker..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=3Ddf1f4f8393ab939=
d
dashboard link: https://syzkaller.appspot.com/bug?extid=3Daeb14e2539ffb6d21=
130
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debia=
n) 2.40

Note: no patches were applied.

