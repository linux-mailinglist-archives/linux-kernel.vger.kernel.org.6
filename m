Return-Path: <linux-kernel+bounces-268979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70BA0942BDB
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 12:22:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AA87282EC9
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 10:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFF5B1AC450;
	Wed, 31 Jul 2024 10:22:35 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D9D1AC448
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 10:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722421355; cv=none; b=OL9Z7FPYnk9ezGEHehJN79SsxkZZvPkuzB56uMYFUJ59uDXM/LLTu5MIdEVYObwj1jWM0eD/mqIbv0+xLltVBMqZsyGACd8nELdBZ8ifIAdcBkaOnm2chHk14PHt6dKLbdp1FIwwdHCWU/ymkGjmJbA8tUYqM4BeLxJ6KypbgrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722421355; c=relaxed/simple;
	bh=2QIVfWw+izX2Q9sW6wEFXb6cVCKckp1adDc8HzFw+2A=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YafLlYHJtJ4mewxXCDlb8Wdu2yqmoeyK40vpVoEUGFQ/Ca4sEps2Qzuiaop4iNhmHyDvxbwoW6J8py+s8lXBaOrSPbMt3gnuglkd2zNAq1wpLUm/cKnwzUWYuQGd4U3KbfoD41k7ltSSyk2kv7Yq+19S5dOoGO/7Js+dDhkblU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4WYp2D5kJhz1j6LY;
	Wed, 31 Jul 2024 18:17:56 +0800 (CST)
Received: from dggpeml500003.china.huawei.com (unknown [7.185.36.200])
	by mail.maildlp.com (Postfix) with ESMTPS id 837DA14037C;
	Wed, 31 Jul 2024 18:22:30 +0800 (CST)
Received: from huawei.com (10.44.142.84) by dggpeml500003.china.huawei.com
 (7.185.36.200) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 31 Jul
 2024 18:22:30 +0800
From: Yu Liao <liaoyu15@huawei.com>
To: <tglx@linutronix.de>, <00107082@163.com>
CC: <liaoyu15@huawei.com>, <liwei391@huawei.com>,
	<linux-kernel@vger.kernel.org>, <x86@kernel.org>
Subject: [PATCH] tick/broadcast: Fix smp_processor_id()-in-preemptible warnings
Date: Wed, 31 Jul 2024 18:19:28 +0800
Message-ID: <20240731101928.132591-1-liaoyu15@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500003.china.huawei.com (7.185.36.200)

David reports that commit f7d43dd206e7 ("tick/broadcast: Make takeover
of broadcast hrtimer reliable") introduced the following splat with
CONFIG_DEBUG_PREEMPT enabled:

 [ 1734.414952] BUG: using smp_processor_id() in preemptible [00000000] code: systemd-sleep/4619
 [ 1734.414957] caller is hotplug_cpu__broadcast_tick_pull+0x1c/0xc0
 [ 1734.414964] CPU: 0 UID: 0 PID: 4619 Comm: systemd-sleep Tainted: P           OE      6.11.0-rc1-linan-4 #292
 [ 1734.414968] Tainted: [P]=PROPRIETARY_MODULE, [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
 [ 1734.414969] Hardware name: Micro-Star International Co., Ltd. MS-7B89/B450M MORTAR MAX (MS-7B89), BIOS 2.80 06/10/2020
 [ 1734.414970] Call Trace:
 [ 1734.414974]  <TASK>
 [ 1734.414978]  dump_stack_lvl+0x60/0x80
 [ 1734.414982]  check_preemption_disabled+0xce/0xe0
 [ 1734.414987]  hotplug_cpu__broadcast_tick_pull+0x1c/0xc0
 [ 1734.414996]  takedown_cpu+0x97/0x130
 [ 1734.414999]  cpuhp_invoke_callback+0xf8/0x450

this_cpu_ptr() calls smp_processor_id() in a preemptible context. Fix
this by moving the this_cpu operation to interrupt disable code segment.

Also, use __this_cpu_read() instead of this_cpu_ptr() to save a few
instructions.

this_cpu_ptr(&tick_cpu_device):
  callq  0xffffffff81ef4a30 <debug_smp_processor_id>
  mov    $0x20b60,%r12
  mov    %eax,%eax
  add    -0x7d7cb4e0(,%rax,8),%r12
  callq  0xffffffff81ef4a30 <debug_smp_processor_id>
  mov    %eax,%eax
  lock btr %rax,0x23f5fc6(%rip)
  mov    (%r12),%rax
  mov    $0x1,%esi
  mov    0x18(%rax),%rdi

__this_cpu_read(tick_cpu_device.evtdev):
  mov    $0xffffffff82742a33,%rdi
  callq  0xffffffff81ef4a60 <__this_cpu_preempt_check>
  mov    %gs:0x7eed2098(%rip),%r12        # 0x20b60 <tick_cpu_device>
  callq  0xffffffff81ef4a30 <debug_smp_processor_id>
  mov    %eax,%eax
  lock btr %rax,0x23f5fc8(%rip)
  mov    0x18(%r12),%rdi
  mov    $0x1,%esi

Fixes: f7d43dd206e7 ("tick/broadcast: Make takeover of broadcast hrtimer reliable")
Reported-by: David Wang <00107082@163.com>
Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Yu Liao <liaoyu15@huawei.com>
---
 kernel/time/tick-broadcast.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/time/tick-broadcast.c b/kernel/time/tick-broadcast.c
index b4843099a8da..85f7d0017e90 100644
--- a/kernel/time/tick-broadcast.c
+++ b/kernel/time/tick-broadcast.c
@@ -1141,7 +1141,6 @@ void tick_broadcast_switch_to_oneshot(void)
 #ifdef CONFIG_HOTPLUG_CPU
 void hotplug_cpu__broadcast_tick_pull(int deadcpu)
 {
-	struct tick_device *td = this_cpu_ptr(&tick_cpu_device);
 	struct clock_event_device *bc;
 	unsigned long flags;
 
@@ -1167,8 +1166,10 @@ void hotplug_cpu__broadcast_tick_pull(int deadcpu)
 		 * device to avoid the starvation.
 		 */
 		if (tick_check_broadcast_expired()) {
+			struct clock_event_device *dev = __this_cpu_read(tick_cpu_device.evtdev);
+
 			cpumask_clear_cpu(smp_processor_id(), tick_broadcast_force_mask);
-			tick_program_event(td->evtdev->next_event, 1);
+			tick_program_event(dev->next_event, 1);
 		}
 
 		/* This moves the broadcast assignment to this CPU: */
-- 
2.33.0


