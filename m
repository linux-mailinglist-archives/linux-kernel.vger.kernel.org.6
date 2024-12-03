Return-Path: <linux-kernel+bounces-428852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FB399E1432
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 08:31:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9AD91B21751
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 07:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69FFD1ABEBD;
	Tue,  3 Dec 2024 07:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="eLylPdfC"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E0718DF81
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 07:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733211062; cv=none; b=I77MjIQVo6hZ/uLECTup6OmjUeAegDaJXyU8EV23BEkBdocceiLytWJFuM2KYz6T+m0Lm1/P4NJdkjS3WMF94rCn6i5/6gtUFXa8ZzT+Js23hj/8PNhvnufTR7Jw/urPozFPp7sM1QfRUp2hJCDwQPHC76GoxC7HmdrcnogOdbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733211062; c=relaxed/simple;
	bh=hM3TSWI+eWAZK1GQuQ4ljeW5GtUNvTvSlHAiQfkse1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GKS3bV9sCjHyVMvalPWjOv76k0ECuoNYrj53tnoCVwh6g27SJuLfKYbn/co0nw+cEtI96hBD4fEoHETxM9GBxH9R1BKXCnklTSjHAY4XL0SbJLcBvNAMjJHR1ntiZocIfQ9jRG1AH59aggKGpTfy3Tff6FwNiVpYaIMGiUtYIOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=eLylPdfC; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id DE7B33F297
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 07:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1733211057;
	bh=rn0yafvxR+rgXFWM/3BvoQL8ErZXVisWsjUhy9aKjNw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=eLylPdfCPhiV1N1U4BnwTPiks3Cahm9jHCg1BNTld7pk2v7yIb05L14xihxGssrMH
	 sY4agVdUgDdmrcGL6BsR/X/DeZKkpJSFs+v9ffK+wNPdujR/7u27Etp0K+UWNJx72P
	 XxHYQZTDbk13EIE5b6JnY2ZX2HBNOlwGhV7RZG/ZFCwfK9l4q38Hv3p/3/BUXYDg8B
	 QGRdPnVVHS41Errntq0xGbOfw1JidVoUxsFLeefo84tfeMVHyn9WT0d1yXATe/cEr+
	 8flhVRaK6Dfcw7vqrJsXGbU+obNRtOfyMV4WmnL1Go1CQ2UU8xfuKJTrafH04PVuFY
	 ttnTpb5IFEFdw==
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2150e4a9f3cso45215395ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 23:30:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733211056; x=1733815856;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rn0yafvxR+rgXFWM/3BvoQL8ErZXVisWsjUhy9aKjNw=;
        b=Gx45ZHgIcQl4El7pqAEiA3rbBqrbFymwLpjt4L8JRlAr1lA+f4ee62yolmfAxcJUSC
         /fF0iseo9kLAnEavhSMg3+WWwC6asnlTsprwo0CENefKuvjVeAq0J5C94hHKz2FDln8L
         bYa6vMmq3cxInK0OSjIdzQdelji34IGLjRODwf1MdGy7lBSTVMXmeN4HkORL/YQ4ucZQ
         o/OFjokWkktfTfNCJr+BqsDXLnWJ9EGgh+wjP+hVr3q70A9g8ylceVANiUK4HLEJRlFA
         SrNHNFGrrqCI8Cn5JCda9ITVyUp06LjViQDnuxVriim6thO/reiGQh0ZrzWogCJEBgdG
         qDjA==
X-Forwarded-Encrypted: i=1; AJvYcCVfEOvgLmU3N0y55nBeSgFezOeLhgxO+gD9LV/XxWjmAspJPEHXFcqGMjEFSLHiqIcoxwFSSQhl68jGwrc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzr56K9c7RgcYM1PlpwQHw9KiRua2vR+JQ5FAzM8QKu37tz6R57
	XKVTrKdUZAzBs5tdUZl+HvcFSWGijprHR70iJ+CkIGY/B0NKJHaZz1ud+DfkUGgyJnkYs7UtUSA
	quOUrzOj+Q715qPixX5b8wLBBiBzHy4/IqPthWyGQmi2lCfnf68UzheW6I25mMTJs4b3X0qQP0Q
	M+SA==
X-Gm-Gg: ASbGncusQzO+lPrBDm2CpubR1s6QcKvnMKU/uA6CVzyndPDr8Zq8gO+6OrBomqRyo9K
	Qv/DhrsUaR+to4OTDXqxWT5oPkn80j29qvQ510t3/3kFFGLUXEHjjNhlpjHg4uTSGkrFqitrgsZ
	nwVe/MCoCta1/PNwBTfnZ78bHNLnXqOrKko7VKJsa+NvGrejBDr41Moz0//EHrptlW2V4F+NVWE
	8IKa6N1QGrVGRENrOtyxhqdBLXd5wbi+B8SjfSOHxL2AEiYP4AEtq+iwLaP+vJccmQE
X-Received: by 2002:a17:903:191:b0:215:7cd2:1132 with SMTP id d9443c01a7336-215bd0e7d81mr19717645ad.29.1733211056438;
        Mon, 02 Dec 2024 23:30:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG7gi3gIAf+lQKauh1LZNO6nUm9eJREawvVeJIpAEFisTXFFb5l8sD9JG8LDx7etuoxazJyYg==
X-Received: by 2002:a17:903:191:b0:215:7cd2:1132 with SMTP id d9443c01a7336-215bd0e7d81mr19717435ad.29.1733211056018;
        Mon, 02 Dec 2024 23:30:56 -0800 (PST)
Received: from localhost.localdomain ([240f:74:7be:1:b2b6:e8c2:50d0:c558])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21586d40afasm35735165ad.270.2024.12.02.23.30.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 23:30:55 -0800 (PST)
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
Subject: [PATCH net-next v2 1/5] virtio_net: correct netdev_tx_reset_queue() invocation point
Date: Tue,  3 Dec 2024 16:30:21 +0900
Message-ID: <20241203073025.67065-2-koichiro.den@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241203073025.67065-1-koichiro.den@canonical.com>
References: <20241203073025.67065-1-koichiro.den@canonical.com>
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

netdev_tx_reset_queue() can actually be dropped from virtnet_open path;
the device is not stopped in any case. For BQL core part, it's just like
traffic nearly ceases to exist for some period. For stall detector added
to BQL, even if virtnet_close could somehow lead to some TX completions
delayed for long, followed by virtnet_open, we can just take it as stall
as mentioned in commit 6025b9135f7a ("net: dqs: add NIC stall detector
based on BQL"). Note also that users can still reset stall_max via sysfs.

So, drop netdev_tx_reset_queue() from virtnet_enable_queue_pair(). This
eliminates the BQL crashes. Note that netdev_tx_reset_queue() is now
explicitly required in freeze/restore path, so this patch adds it to
free_unused_bufs().

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
 ? security_capable+0x3b/0x70
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

Fixes: c8bd1f7f3e61 ("virtio_net: add support for Byte Queue Limits")
Cc: <stable@vger.kernel.org> # v6.11+
Signed-off-by: Koichiro Den <koichiro.den@canonical.com>
---
 drivers/net/virtio_net.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 64c87bb48a41..48ce8b3881b6 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -3054,7 +3054,6 @@ static int virtnet_enable_queue_pair(struct virtnet_info *vi, int qp_index)
 	if (err < 0)
 		goto err_xdp_reg_mem_model;
 
-	netdev_tx_reset_queue(netdev_get_tx_queue(vi->dev, qp_index));
 	virtnet_napi_enable(vi->rq[qp_index].vq, &vi->rq[qp_index].napi);
 	virtnet_napi_tx_enable(vi, vi->sq[qp_index].vq, &vi->sq[qp_index].napi);
 
@@ -6243,6 +6242,7 @@ static void free_unused_bufs(struct virtnet_info *vi)
 		struct virtqueue *vq = vi->sq[i].vq;
 		while ((buf = virtqueue_detach_unused_buf(vq)) != NULL)
 			virtnet_sq_free_unused_buf(vq, buf);
+		netdev_tx_reset_queue(netdev_get_tx_queue(vi->dev, i));
 		cond_resched();
 	}
 
-- 
2.43.0


