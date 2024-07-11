Return-Path: <linux-kernel+bounces-249212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54C0992E88F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 14:52:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC6E7B25FCE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 12:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5B2515D5A4;
	Thu, 11 Jul 2024 12:52:11 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7FA1E892
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 12:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720702331; cv=none; b=XoKdfGaFEn18sIWjkEbmLhjH8rFTsuD0PO9p2V3Ifv+qVQup1q+uVu4k8mMjuzdjX4Swz6CXGv5WtkGgArfBAJStEkV2+5mdp5/30HxJ9E8Qn0YYMfTB8joyLUaONkoEi5LAA2CtB5ntZSgh0tOiQe5Vdd48is7MpiRAANzaGNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720702331; c=relaxed/simple;
	bh=EeZp5cBT2dg/F6gWl/xazDokgGm++c0kuRd4tNsbtMQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eTMmJPxjdMoNgi9uiUjXaxsFPOeDkoYLNx4f3lPE0wSn7yMwFmk2nkkKbPC4e3+l1eZKsJYhOW516O5QS47fWvkanm8anYw4/EBdT9otbJtRzoLlT3iGd2pmeLHVYsNoID5moDlLBfbR+0LmqY+/9xpXtDkx+q0A9plmRbI+kzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WKZNj65nhznZvB;
	Thu, 11 Jul 2024 20:51:33 +0800 (CST)
Received: from dggpeml500003.china.huawei.com (unknown [7.185.36.200])
	by mail.maildlp.com (Postfix) with ESMTPS id 0861F180087;
	Thu, 11 Jul 2024 20:52:03 +0800 (CST)
Received: from huawei.com (10.44.142.84) by dggpeml500003.china.huawei.com
 (7.185.36.200) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 11 Jul
 2024 20:52:02 +0800
From: Yu Liao <liaoyu15@huawei.com>
To: <linux-kernel@vger.kernel.org>, <tglx@linutronix.de>
CC: <liaoyu15@huawei.com>, <liwei391@huawei.com>, <wangxiongfeng2@huawei.com>,
	<yangyicong@huawei.com>, <frederic@kernel.org>, <mingo@kernel.org>
Subject: [PATCH v2] tick/broadcast: Ensure the timer device of hrtimer broadcast is enabled
Date: Thu, 11 Jul 2024 20:48:43 +0800
Message-ID: <20240711124843.64167-1-liaoyu15@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500003.china.huawei.com (7.185.36.200)

It was found that running the LTP hotplug stress test on a aarch64
machine could produce rcu_sched stall warnings.

The issue is the following:

CPU1 (owns the broadcast hrtimer)	CPU2

				tick_broadcast_enter()
				  //shutdown local timer device
				  broadcast_shutdown_local()
				...
				tick_broadcast_exit()
				  clockevents_switch_state(dev, CLOCK_EVT_STATE_ONESHOT)
				  //timer device remains shutdown
				  cpumask_set_cpu(cpu, tick_broadcast_force_mask)

				initiates offlining of CPU1
take_cpu_down()
/*
 * CPU1 shuts down and does not
 * send broadcast IPI anymore
 */
				takedown_cpu()
				  hotplug_cpu__broadcast_tick_pull()
				    //move broadcast hrtimer to this CPU
				    clockevents_program_event()
				      bc_set_next()
					hrtimer_start()
					/*
					 * timer device remains shutdown,
					 * because only the first expiring
					 * timer will trigger clockevent
					 * device reprogramming
					 */

What happens is that CPU2 exits broadcast mode with force bit set, then
we don't reprogram the local timer device and expect to handle the
expired event by broadcast mechanism, but this can not be done because
CPU1 is offlined by CPU2. We switch the clockevent to ONESHOT state,
but some device like arm arch timer don't implement set_state_oneshot
handler, so the switch operation does nothing but change the value
of dev->state_use_accessors.

After CPU2 takes over the broadcast duty, CPU2 is also unable to handle
broadcasting by itself because the local timer device is still shutdown,
due to only the first expiring timer will trigger clockevent device
reprogramming. The worst result is all CPUs are stucked.

Fix this issue by reprogramming the local timer device if the clockevent
device of the CPU that owns broadcast timer is shutdown. As we owns
broadcast timer, clear the force mask bit.

Signed-off-by: Yu Liao <liaoyu15@huawei.com>
---
Changes in v2:
 - Move the check to hotplug_cpu__broadcast_tick_pull()
 - Remove the conditon 'expires >= next_event'
 - Link to v1: https://lore.kernel.org/all/20231218025844.55675-1-liaoyu15@huawei.com/

 kernel/time/tick-broadcast.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/kernel/time/tick-broadcast.c b/kernel/time/tick-broadcast.c
index 771d1e040303..0edff1e46b7c 100644
--- a/kernel/time/tick-broadcast.c
+++ b/kernel/time/tick-broadcast.c
@@ -1141,6 +1141,7 @@ void tick_broadcast_switch_to_oneshot(void)
 #ifdef CONFIG_HOTPLUG_CPU
 void hotplug_cpu__broadcast_tick_pull(int deadcpu)
 {
+	struct tick_device *td = this_cpu_ptr(&tick_cpu_device);
 	struct clock_event_device *bc;
 	unsigned long flags;
 
@@ -1148,6 +1149,21 @@ void hotplug_cpu__broadcast_tick_pull(int deadcpu)
 	bc = tick_broadcast_device.evtdev;
 
 	if (bc && broadcast_needs_cpu(bc, deadcpu)) {
+		/*
+		 * If the broadcast force bit is set, then we haven't
+		 * reprogrammed local timer device, so it remains shutdowned.
+		 * clockevents_program_event() will start a hrtimer when
+		 * the broadcast device is based on hrtimer, and only the
+		 * first expiring timer will trigger clockevent device
+		 * reprogramming.
+		 *
+		 * Reprogram the cpu local timer device to avoid it being shut down.
+		 */
+		if (tick_check_broadcast_expired()) {
+			cpumask_clear_cpu(smp_processor_id(), tick_broadcast_force_mask);
+			tick_program_event(td->evtdev->next_event, 1);
+		}
+
 		/* This moves the broadcast assignment to this CPU: */
 		clockevents_program_event(bc, bc->next_event, 1);
 	}
-- 
2.33.0


