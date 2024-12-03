Return-Path: <linux-kernel+bounces-428851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 331539E1436
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 08:31:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B16F4166170
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 07:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CD9F192D7B;
	Tue,  3 Dec 2024 07:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="nG8nEpP/"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C8D7126BF1
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 07:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733211060; cv=none; b=b2BW60zQa3fCNC6WdNDmL9OlxWrwJlPrg0lfrFa33n1KAVtzv3PTr02noDkxK6vMu/6wHTGx/K/CFc+NopOaKAvv0NQXVIIarc/h09YyOFxicjjdj07BWTjNwD9tbvQ5K4EFBZRJyc0mh5oSbS6EtYS/kJQKwOWodzKRmUPPDSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733211060; c=relaxed/simple;
	bh=w5PVXTCRaDAfP69h6XQKxdU+wqKsnZ41X/UVyvp0+6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nilhpnTvurhcDQQDzgXsOpcXSRwpcOUelk7im8XXmVzE3hIbbU3/AegfEXnyE60EdA7TD3kiMDwJunQ8BNNjc5FS7iauQL0X/rRWeU9uI7161HzujYCBtnxGJ9ezARaou8ur29lVTx4E9A7ruIIi7VGwDkzrE6IdU6RP/46KPII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=nG8nEpP/; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 032F43F626
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 07:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1733211054;
	bh=sJwi0UaQ+bRbBkXFMHPGydEM4a/idPMJJL4GYObxAII=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=nG8nEpP/s6wj9m+V5GY8vREDpZHP6OrtjVtVHpK/gZOZ5q8rJv+wtthJFD7xSLPGw
	 DM5VVkoohU42S/w8xuH48yBhuFouhXLXB4Vg3H0KBJSr+2ZZTI5cnxDeVBxTXaW3Ry
	 sgNs+9Qaz25tSiLfejk5BN+ceUcKUAc/K+evRDmJlkN2rddv1NHYMmSkXX0HdvdBAG
	 AP3gdLc7HzCvyajFjNKWWWhQ42vSyGrEZJa3xrfaUr+ALE0ip8PAgySi62+43vwUao
	 AcOwJqKWuHHU8xHof239yFtrJ89o4BO/WAKkBCALQH4LLAOlEXySaOdDAPCdwOyhjd
	 JBgzRP1u/mDxg==
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2157b83f656so29819115ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 23:30:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733211052; x=1733815852;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sJwi0UaQ+bRbBkXFMHPGydEM4a/idPMJJL4GYObxAII=;
        b=vwF+2jEG19Y5WtiCmnbqYIifetEaHyGc1hCxAJx27JR0qOuwm90S1tp8IUZFUv0g1V
         2j3N307nmYPT61xDIFQz+qASMomzhWWo5bUfirxov1ltzcJGFTUVAKc7N9Qc48oSRpgq
         TkIXYhzkvoFEohAjzyxx2ikQ4x3Aquz/mtFRS65kGJzAmvxjQO+Pr1hbtVwaE8Kx6R48
         L8/N7TqxGDpgJFUvziZ0M0ksRnredyTkRZza9MovdF1MIHEOc5WYSjuy3NV9pbBHer8H
         31N/BRHCxxsb2MyWTQIJ+QDj8QUzwv58jYPIkBIq5iOHEFjZn2q4+CbuWxXAxTNoHqGJ
         HPRw==
X-Forwarded-Encrypted: i=1; AJvYcCWQjS734NQ979OHRqcxD3dD4eUpy+bCTxT2JhN6ima6mb+kd+MWpkPfcbUMY14ne+W7BEgScEcwlqd5EYM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxj8FDnabZWGOpeLJkSH4rR4CxjF1pRd1bXDmTchox9Teu8mpWg
	7kS24nqxmh0V10Nb6bQj+E5J68JRdhyziYWDLz2GXMm/BN0OiO2/NvtoUv0ACDqi46doucFLuSt
	HYOGbaOtnMShJk5tDKKiOoQTiZZtYsO3WEqSCxnrSzTKAnDvDLfCb/K01UkTpljo70axK9N9ZRv
	naug==
X-Gm-Gg: ASbGncvEdDPpwtN4NJZ0EYwvDJd6OSONzYJzm6u7dZ8KVW83xXf44agYTmmYgmUI6h7
	BWDWHoru6bVWdL7PckMO+m1QRHiLJLKWyWBg/4WdZjPTU9vFZOqZf/nT4Y4JaQOzVYyfKZO8N9E
	NtasrShVzFdAt14hwWLNi9OCrqFczeN51YXmWd8M/y8UHKs8hUMgOwq8OQCHNlumC5frGLUPKyx
	trplnHw7IgR+rrILXyBiPtTaOLe7M8bciZC4FRH3/ffD9sU0nulNeXWsSS9VXFeLkkC
X-Received: by 2002:a17:902:e743:b0:214:f87b:9dfb with SMTP id d9443c01a7336-215bd21460bmr21475155ad.30.1733211052494;
        Mon, 02 Dec 2024 23:30:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF17YleowmZjFXa6F1AEvPi0Shn5zlI9KQ7K0jww9WCbRYjy1aiG2U/S1fUbvvqXxrXVFsH3g==
X-Received: by 2002:a17:902:e743:b0:214:f87b:9dfb with SMTP id d9443c01a7336-215bd21460bmr21474855ad.30.1733211052117;
        Mon, 02 Dec 2024 23:30:52 -0800 (PST)
Received: from localhost.localdomain ([240f:74:7be:1:b2b6:e8c2:50d0:c558])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21586d40afasm35735165ad.270.2024.12.02.23.30.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 23:30:51 -0800 (PST)
From: Koichiro Den <koichiro.den@canonical.com>
To: virtualization@lists.linux.dev
Cc: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	jiri@resnulli.us,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net-next v2 0/5] virtio_net: correct netdev_tx_reset_queue() invocation points
Date: Tue,  3 Dec 2024 16:30:20 +0900
Message-ID: <20241203073025.67065-1-koichiro.den@canonical.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When virtnet_close is followed by virtnet_open, some TX completions can
possibly remain unconsumed, until they are finally processed during the
first NAPI poll after the netdev_tx_reset_queue(), resulting in a crash
[1]. Commit b96ed2c97c79 ("virtio_net: move netdev_tx_reset_queue() call
before RX napi enable") was not sufficient to eliminate all BQL crash
cases for virtio-net.

This issue can be reproduced with the latest net-next master by running:
`while :; do ip l set DEV down; ip l set DEV up; done` under heavy network
TX load from inside the machine.

This patch series resolves the issue and also addresses similar existing
problems:

(a). Drop netdev_tx_reset_queue() from open/close path. This eliminates the
     BQL crashes due to the problematic open/close path.

(b). As a result of (a), netdev_tx_reset_queue() is now explicitly required
     in freeze/restore path. Add netdev_tx_reset_queue() to
     free_unused_bufs().

(c). Fix missing resetting in virtnet_tx_resize().
     virtnet_tx_resize() has lacked proper resetting since commit
     c8bd1f7f3e61 ("virtio_net: add support for Byte Queue Limits").

(d). Fix missing resetting in the XDP_SETUP_XSK_POOL path.
     Similar to (c), this path lacked proper resetting. Call
     netdev_tx_reset_queue() when virtqueue_reset() has actually recycled
     unused buffers.

This patch series consists of five commits:
  [1/5]: Resolves (a) and (b).
  [2/5]: Prerequisite for (c).
  [3/5]: Resolves (c).
  [4/5]: Preresuisite for (d).
  [5/5]: Resolves (d).

Changes for v2:
  - add tx queue resetting for (b) to (d) above

v1: https://lore.kernel.org/all/20241130181744.3772632-1-koichiro.den@canonical.com/


[1]:
------------[ cut here ]------------
kernel BUG at lib/dynamic_queue_limits.c:99!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
CPU: 7 UID: 0 PID: 1598 Comm: ip Tainted: G    N 6.12.0net-next_main+ #2
Tainted: [N]=TEST
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), \
BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
RIP: 0010:dql_completed+0x26b/0x290
Code: b7 c2 49 89 e9 44 89 da 89 c6 4c 89 d7 e8 ed 17 47 00 58 65 ff 0d
4d 27 90 7e 0f 85 fd fe ff ff e8 ea 53 8d ff e9 f3 fe ff ff <0f> 0b 01
d2 44 89 d1 29 d1 ba 00 00 00 00 0f 48 ca e9 28 ff ff ff
RSP: 0018:ffffc900002b0d08 EFLAGS: 00010297
RAX: 0000000000000000 RBX: ffff888102398c80 RCX: 0000000080190009
RDX: 0000000000000000 RSI: 000000000000006a RDI: 0000000000000000
RBP: ffff888102398c00 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000000000ca R11: 0000000000015681 R12: 0000000000000001
R13: ffffc900002b0d68 R14: ffff88811115e000 R15: ffff8881107aca40
FS:  00007f41ded69500(0000) GS:ffff888667dc0000(0000)
knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000556ccc2dc1a0 CR3: 0000000104fd8003 CR4: 0000000000772ef0
PKRU: 55555554
Call Trace:
 <IRQ>
 ? die+0x32/0x80
 ? do_trap+0xd9/0x100
 ? dql_completed+0x26b/0x290
 ? dql_completed+0x26b/0x290
 ? do_error_trap+0x6d/0xb0
 ? dql_completed+0x26b/0x290
 ? exc_invalid_op+0x4c/0x60
 ? dql_completed+0x26b/0x290
 ? asm_exc_invalid_op+0x16/0x20
 ? dql_completed+0x26b/0x290
 __free_old_xmit+0xff/0x170 [virtio_net]
 free_old_xmit+0x54/0xc0 [virtio_net]
 virtnet_poll+0xf4/0xe30 [virtio_net]
 ? __update_load_avg_cfs_rq+0x264/0x2d0
 ? update_curr+0x35/0x260
 ? reweight_entity+0x1be/0x260
 __napi_poll.constprop.0+0x28/0x1c0
 net_rx_action+0x329/0x420
 ? enqueue_hrtimer+0x35/0x90
 ? trace_hardirqs_on+0x1d/0x80
 ? kvm_sched_clock_read+0xd/0x20
 ? sched_clock+0xc/0x30
 ? kvm_sched_clock_read+0xd/0x20
 ? sched_clock+0xc/0x30
 ? sched_clock_cpu+0xd/0x1a0
 handle_softirqs+0x138/0x3e0
 do_softirq.part.0+0x89/0xc0
 </IRQ>
 <TASK>
 __local_bh_enable_ip+0xa7/0xb0
 virtnet_open+0xc8/0x310 [virtio_net]
 __dev_open+0xfa/0x1b0
 __dev_change_flags+0x1de/0x250
 dev_change_flags+0x22/0x60
 do_setlink.isra.0+0x2df/0x10b0
 ? rtnetlink_rcv_msg+0x34f/0x3f0
 ? netlink_rcv_skb+0x54/0x100
 ? netlink_unicast+0x23e/0x390
 ? netlink_sendmsg+0x21e/0x490
 ? ____sys_sendmsg+0x31b/0x350
 ? avc_has_perm_noaudit+0x67/0xf0
 ? cred_has_capability.isra.0+0x75/0x110
 ? __nla_validate_parse+0x5f/0xee0
 ? __pfx___probestub_irq_enable+0x3/0x10
 ? __create_object+0x5e/0x90
 ? security_capable+0x3b/0x7[I0
 rtnl_newlink+0x784/0xaf0
 ? avc_has_perm_noaudit+0x67/0xf0
 ? cred_has_capability.isra.0+0x75/0x110
 ? stack_depot_save_flags+0x24/0x6d0
 ? __pfx_rtnl_newlink+0x10/0x10
 rtnetlink_rcv_msg+0x34f/0x3f0
 ? do_syscall_64+0x6c/0x180
 ? entry_SYSCALL_64_after_hwframe+0x76/0x7e
 ? __pfx_rtnetlink_rcv_msg+0x10/0x10
 netlink_rcv_skb+0x54/0x100
 netlink_unicast+0x23e/0x390
 netlink_sendmsg+0x21e/0x490
 ____sys_sendmsg+0x31b/0x350
 ? copy_msghdr_from_user+0x6d/0xa0
 ___sys_sendmsg+0x86/0xd0
 ? __pte_offset_map+0x17/0x160
 ? preempt_count_add+0x69/0xa0
 ? __call_rcu_common.constprop.0+0x147/0x610
 ? preempt_count_add+0x69/0xa0
 ? preempt_count_add+0x69/0xa0
 ? _raw_spin_trylock+0x13/0x60
 ? trace_hardirqs_on+0x1d/0x80
 __sys_sendmsg+0x66/0xc0
 do_syscall_64+0x6c/0x180
 entry_SYSCALL_64_after_hwframe+0x76/0x7e
RIP: 0033:0x7f41defe5b34
Code: 15 e1 12 0f 00 f7 d8 64 89 02 b8 ff ff ff ff eb bf 0f 1f 44 00 00
f3 0f 1e fa 80 3d 35 95 0f 00 00 74 13 b8 2e 00 00 00 0f 05 <48> 3d 00
f0 ff ff 77 4c c3 0f 1f 00 55 48 89 e5 48 83 ec 20 89 55
RSP: 002b:00007ffe5336ecc8 EFLAGS: 00000202 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f41defe5b34
RDX: 0000000000000000 RSI: 00007ffe5336ed30 RDI: 0000000000000003
RBP: 00007ffe5336eda0 R08: 0000000000000010 R09: 0000000000000001
R10: 00007ffe5336f6f9 R11: 0000000000000202 R12: 0000000000000003
R13: 0000000067452259 R14: 0000556ccc28b040 R15: 0000000000000000
 </TASK>
[...]
---[ end Kernel panic - not syncing: Fatal exception in interrupt ]---


Koichiro Den (5):
  virtio_net: correct netdev_tx_reset_queue() invocation point
  virtio_ring: add 'flushed' as an argument to virtqueue_resize()
  virtio_net: add missing netdev_tx_reset_queue() to virtnet_tx_resize()
  virtio_ring: add 'flushed' as an argument to virtqueue_reset()
  virtio_net: add missing netdev_tx_reset_queue to
    virtnet_sq_bind_xsk_pool()

 drivers/net/virtio_net.c     | 18 +++++++++++++-----
 drivers/virtio/virtio_ring.c | 13 +++++++++++--
 include/linux/virtio.h       |  6 ++++--
 3 files changed, 28 insertions(+), 9 deletions(-)

-- 
2.43.0


