Return-Path: <linux-kernel+bounces-339251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4344D9861B4
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 16:59:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0260428D991
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 14:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50EA217E919;
	Wed, 25 Sep 2024 14:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="A9HbMN2x"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C290428E8
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 14:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727274766; cv=none; b=rksiATAhE3x8/5I9S3u0Dp6roAvkpZ7TsWvV3MDw2czFRQsjW9wfqIsEJLsr3AZJgDNaJWzXEJE9/NSbwMIZmOG6UXooat1C5JaMLTuCtj7tMK32QaYgnn3pBObs/IpOFZ3rlJtrdQIeTWR5vseronul5Z+/3j9dpgDUvNfXO/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727274766; c=relaxed/simple;
	bh=ZvqQmM3t4MF22OHNhVY+QsSZT8WfllQ6+fDDrss5p50=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OYpEweIIF+UBz4fVxZOI2vkw+jkBWVZYjfIyMu2d7LYtfRX5G7hpgUGBGCHvh5o6y1tQMzznw1BLX5cJLNYrbump6Kovddgykv5mSq/LoLbG7BqPRzVSPRcqDjRMwqOG2aDSd24U1175cVbKf4I9uD35E/cdZd7bLgrLjS94RPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=A9HbMN2x; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=bXPtw
	0s9wfqQG9ajXRi4cqKzBb+2ZW2KdPhxEnMTmXE=; b=A9HbMN2xD01Tx8p8dA8VY
	eeE8oWQtNZmVL9PbFcXIhU0MlRv682+UMvRQluOktPP5PQFBmF7aAGnFxozrFnlC
	+viVRc89f042tl6AAwsqVimg36ZEUsPgnHo30LI6A29ycJWwf3hPBnzAMDWHyNs1
	aE+Q0pIfGqC71uRV+9ijUM=
Received: from localhost.localdomain (unknown [193.203.214.57])
	by gzga-smtp-mta-g2-2 (Coremail) with SMTP id _____wDn9EXeHvRmGMqpJA--.33673S4;
	Wed, 25 Sep 2024 22:32:00 +0800 (CST)
From: ran xiaokai <ranxiaokai627@163.com>
To: elver@google.com,
	tglx@linutronix.de,
	dvyukov@google.com
Cc: kasan-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	Ran Xiaokai <ran.xiaokai@zte.com.cn>
Subject: [PATCH 0/4] kcsan, debugfs: fix atomic sleep by converting spinlock_t to rcu lock
Date: Wed, 25 Sep 2024 14:31:50 +0000
Message-Id: <20240925143154.2322926-1-ranxiaokai627@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDn9EXeHvRmGMqpJA--.33673S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxJF4DXr1xJr4rWw1DXF17Awb_yoW5ArWDpF
	43Gr9ayrWqq3Wavw4ay3WUtr1rJrZ3Jw1xG3s7urW7Zw1jgr12qa1Iqr10vrZ0grW0yFZr
	XFn2qrWjgw43Zw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07joGQDUUUUU=
X-CM-SenderInfo: xudq5x5drntxqwsxqiywtou0bp/1tbiqQdlTGb0HXEZbwAAsP

From: Ran Xiaokai <ran.xiaokai@zte.com.cn>

In a preempt-RT kernel, although most of the irq handler have been
converted to the threaded mode except those which have the
IRQF_NO_THREAD flag set. The hrtimer IRQ is such an example.
So kcsan report could be triggered from a HARD-irq context, this will
trigger the "sleeping function called from invalid context" bug.

[    C1] BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:48
[    C1] in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 0, name: swapper/1
[    C1] preempt_count: 10002, expected: 0
[    C1] RCU nest depth: 0, expected: 0
[    C1] no locks held by swapper/1/0.
[    C1] irq event stamp: 156674
[    C1] hardirqs last  enabled at (156673): [<ffffffff81130bd9>] do_idle+0x1f9/0x240
[    C1] hardirqs last disabled at (156674): [<ffffffff82254f84>] sysvec_apic_timer_interrupt+0x14/0xc0
[    C1] softirqs last  enabled at (0): [<ffffffff81099f47>] copy_process+0xfc7/0x4b60
[    C1] softirqs last disabled at (0): [<0000000000000000>] 0x0
[    C1] Preemption disabled at:
[    C1] [<ffffffff814a3e2a>] paint_ptr+0x2a/0x90
[    C1] CPU: 1 UID: 0 PID: 0 Comm: swapper/1 Not tainted 6.11.0+ #3
[    C1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.0-0-ga698c8995f-prebuilt.qemu.org 04/01/2014
[    C1] Call Trace:
[    C1]  <IRQ>
[    C1]  dump_stack_lvl+0x7e/0xc0
[    C1]  dump_stack+0x1d/0x30
[    C1]  __might_resched+0x1a2/0x270
[    C1]  rt_spin_lock+0x68/0x170
[    C1]  ? kcsan_skip_report_debugfs+0x43/0xe0
[    C1]  kcsan_skip_report_debugfs+0x43/0xe0
[    C1]  ? hrtimer_next_event_without+0x110/0x110
[    C1]  print_report+0xb5/0x590
[    C1]  kcsan_report_known_origin+0x1b1/0x1d0
[    C1]  kcsan_setup_watchpoint+0x348/0x650
[    C1]  __tsan_unaligned_write1+0x16d/0x1d0
[    C1]  hrtimer_interrupt+0x3d6/0x430
[    C1]  __sysvec_apic_timer_interrupt+0xe8/0x3a0
[    C1]  sysvec_apic_timer_interrupt+0x97/0xc0
[    C1]  </IRQ>

To fix this, we can not simply convert the report_filterlist_lock
to a raw_spinlock_t. In the insert_report_filterlist() path:

raw_spin_lock_irqsave(&report_filterlist_lock, flags);
  krealloc
    __do_kmalloc_node
      slab_alloc_node
        __slab_alloc
          local_lock_irqsave(&s->cpu_slab->lock, flags)

local_lock_t is now a spinlock_t which is sleepable in preempt-RT
kernel, so kmalloc() and similar functions can not be called with
a raw_spinlock_t lock held.

Instead, we can convert it to rcu lock to fix this.

Ran Xiaokai (4):
  kcsan, debugfs: Remove redundant call of kallsyms_lookup_name()
  kcsan, debugfs: refactor set_report_filterlist_whitelist() to return a
    value
  kcsan, debugfs: fix atomic sleep by converting spinlock_t to rcu lock
  kcsan, debugfs: avoid updating white/blacklist with the same value

 kernel/kcsan/debugfs.c | 192 ++++++++++++++++++++++++++++++++-----------------
 1 file changed, 125 insertions(+), 67 deletions(-)

-- 
2.15.2



