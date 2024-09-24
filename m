Return-Path: <linux-kernel+bounces-337565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B104D984BB7
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 21:40:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71104283FC4
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 19:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E44F13A25F;
	Tue, 24 Sep 2024 19:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b="mcyL+s9i";
	dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b="SGaMj6Ou"
Received: from e3i110.smtp2go.com (e3i110.smtp2go.com [158.120.84.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989DB12F5A5
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 19:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.120.84.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727206848; cv=none; b=mV/I+iO34y6EPy1ECP6Bosc/94P1lXlPPA8Df6VNznqeFn/vPBa5Uu1H0lqswO+csuNvIUVWCYIgX1qiror97lZR7jASiBqkBsGJuG6C0WG1hCR+tAVaJMDMRHAlTCQzFp2SNYzG+VWEwUJe4yOZKINdNjPF7wYX4fQqW/SCBCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727206848; c=relaxed/simple;
	bh=bv6/yP+3GsD9E4dCyFq3/EAghWl1KfvjbhuV5oaCHAA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OUUcPS9c+XjY/ssx7/w02L3xGnZvZe98C5SJClbteMPOe5s8AZOPAbxwhb82i/A1UwKyXLFq9Zasnh9hCDuPnEPpv7UEAzYJDudUcvyaJOhx7gZksBZnOPRGs683xb6uS5k4SIyGyBZDaFYbgmb8kKjsSsvYBrj4PZKLEAhzQFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt; spf=pass smtp.mailfrom=em510616.triplefau.lt; dkim=pass (2048-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b=mcyL+s9i; dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b=SGaMj6Ou; arc=none smtp.client-ip=158.120.84.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em510616.triplefau.lt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smtpservice.net;
 i=@smtpservice.net; q=dns/txt; s=a1-4; t=1727206842; h=feedback-id :
 x-smtpcorp-track : date : message-id : to : subject : from : reply-to
 : sender : list-unsubscribe : list-unsubscribe-post;
 bh=ZAFC15upJHpYWIyEc4vqiTRRNBTzf2DlM6fPlb+qayY=;
 b=mcyL+s9ikA7yrkH7c0pD/e/Ln1IB44wUKcJ7FZ4LfYGy1VurRnNT/s3qSfrOjNQrjreVz
 6rd1K7TxHEuWRfY5y7NjGUPU9InOXkxPBknzfSZswNu2FXAOrnaP+s417Y0Wwf4wYMiCJ8Z
 SP3p4ctfDPy1gmVqHtJLvB6eEnOLAFyS5iUQXgT9Rft1GPXRifVnSA6aZ6Gel4FO2+FsamP
 9boPGO68R+n+k+dz7Pv4vTsZdaK92IrnlE0LaRDI86HAljU3zMBzzDRvOKM58sK8+86Xx3C
 6P9GNp4/ylQKJdWNLW9T+QvbABi8XfPQODYqd1vgtGJwPsGr07vtKyvGZovw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=triplefau.lt;
 i=@triplefau.lt; q=dns/txt; s=s510616; t=1727206842; h=from : subject
 : to : message-id : date;
 bh=ZAFC15upJHpYWIyEc4vqiTRRNBTzf2DlM6fPlb+qayY=;
 b=SGaMj6OuCo0vD4VAXp4Lc2JJxXF3EclDD8434iL9APP1jV2oDd6NYTZXc6gTWBeMotmfF
 KLRAmmGMrVWUyntzvs0o/VKHU49w/dNEweb1p7fLS4YIpNRMb05SUQxqu38ny59zvYInxt4
 UP89SyE9kH37O/MdLNEQ10O6UAUV58e6dWXN503oF6u0nz3oyFaNwAzQTvnuG5nvny8cUJm
 Vc3uuRqIrQ38cgse2+pYu0pYpcf47vt66xU9Nmu42BqHKx2ybMQqpWHSzQnnylr+XiEFAs0
 edDmoEHh1cUTzBaHiZ6ufuQk8cUlinHDtEIKSpWGIWwO9QfSSe8icrL7WocA==
Received: from [10.12.239.196] (helo=localhost)
	by smtpcorp.com with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97.1-S2G)
	(envelope-from <repk@triplefau.lt>)
	id 1stBOo-AIkwcC8mZ9b-HsRu;
	Tue, 24 Sep 2024 19:40:38 +0000
From: Remi Pommarel <repk@triplefau.lt>
To: ath11k@lists.infradead.org,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Kalle Valo <kvalo@kernel.org>,
	Jeff Johnson <jjohnson@kernel.org>,
	Praneesh P <quic_ppranees@quicinc.com>,
	Remi Pommarel <repk@triplefau.lt>
Subject: [PATCH v2] wifi: ath11k: Fix invalid ring usage in full monitor mode
Date: Tue, 24 Sep 2024 21:41:19 +0200
Message-Id: <20240924194119.15942-1-repk@triplefau.lt>
X-Mailer: git-send-email 2.40.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse: Please forward a copy of this message, including all headers, to <abuse-report@smtp2go.com>
Feedback-ID: 510616m:510616apGKSTK:510616sosVF_l1gq
X-smtpcorp-track: 0v7jC1OKg6oj.qu73QVL_z4z2.L6s0GgzWcB2

On full monitor HW the monitor destination rxdma ring does not have the
same descriptor format as in the "classical" mode. The full monitor
destination entries are of hal_sw_monitor_ring type and fetched using
ath11k_dp_full_mon_process_rx while the classical ones are of type
hal_reo_entrance_ring and fetched with ath11k_dp_rx_mon_dest_process.

Although both hal_sw_monitor_ring and hal_reo_entrance_ring are of same
size, the offset to useful info (such as sw_cookie, paddr, etc) are
different. Thus if ath11k_dp_rx_mon_dest_process gets called on full
monitor destination ring, invalid skb buffer id will be fetched from DMA
ring causing issues such as the following rcu_sched stall:

 rcu: INFO: rcu_sched self-detected stall on CPU
 rcu:     0-....: (1 GPs behind) idle=c67/0/0x7 softirq=45768/45769 fqs=1012
  (t=2100 jiffies g=14817 q=8703)
 Task dump for CPU 0:
 task:swapper/0       state:R  running task     stack: 0 pid:    0 ppid:     0 flags:0x0000000a
 Call trace:
  dump_backtrace+0x0/0x160
  show_stack+0x14/0x20
  sched_show_task+0x158/0x184
  dump_cpu_task+0x40/0x4c
  rcu_dump_cpu_stacks+0xec/0x12c
  rcu_sched_clock_irq+0x6c8/0x8a0
  update_process_times+0x88/0xd0
  tick_sched_timer+0x74/0x1e0
  __hrtimer_run_queues+0x150/0x204
  hrtimer_interrupt+0xe4/0x240
  arch_timer_handler_phys+0x30/0x40
  handle_percpu_devid_irq+0x80/0x130
  handle_domain_irq+0x5c/0x90
  gic_handle_irq+0x8c/0xb4
  do_interrupt_handler+0x30/0x54
  el1_interrupt+0x2c/0x4c
  el1h_64_irq_handler+0x14/0x1c
  el1h_64_irq+0x74/0x78
  do_raw_spin_lock+0x60/0x100
  _raw_spin_lock_bh+0x1c/0x2c
  ath11k_dp_rx_mon_mpdu_pop.constprop.0+0x174/0x650
  ath11k_dp_rx_process_mon_status+0x8b4/0xa80
  ath11k_dp_rx_process_mon_rings+0x244/0x510
  ath11k_dp_service_srng+0x190/0x300
  ath11k_pcic_ext_grp_napi_poll+0x30/0xc0
  __napi_poll+0x34/0x174
  net_rx_action+0xf8/0x2a0
  _stext+0x12c/0x2ac
  irq_exit+0x94/0xc0
  handle_domain_irq+0x60/0x90
  gic_handle_irq+0x8c/0xb4
  call_on_irq_stack+0x28/0x44
  do_interrupt_handler+0x4c/0x54
  el1_interrupt+0x2c/0x4c
  el1h_64_irq_handler+0x14/0x1c
  el1h_64_irq+0x74/0x78
  arch_cpu_idle+0x14/0x20
  do_idle+0xf0/0x130
  cpu_startup_entry+0x24/0x50
  rest_init+0xf8/0x104
  arch_call_rest_init+0xc/0x14
  start_kernel+0x56c/0x58c
  __primary_switched+0xa0/0xa8

Thus ath11k_dp_rx_mon_dest_process(), which use classical destination
entry format, should no be called on full monitor capable HW.

Fixes: 67a9d399fcb0 ("ath11k: enable RX PPDU stats in monitor co-exist mode")
Signed-off-by: Remi Pommarel <repk@triplefau.lt>
---
v2: set ppdu_status to DP_PPDU_STATUS_DONE as suggested by
    https://lore.kernel.org/ath11k/d376023d-267a-4512-8749-f816fefeb842@quicinc.com/

 drivers/net/wireless/ath/ath11k/dp_rx.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.c b/drivers/net/wireless/ath/ath11k/dp_rx.c
index c087d8a0f5b2..40088e62572e 100644
--- a/drivers/net/wireless/ath/ath11k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
@@ -5291,8 +5291,11 @@ int ath11k_dp_rx_process_mon_status(struct ath11k_base *ab, int mac_id,
 		    hal_status == HAL_TLV_STATUS_PPDU_DONE) {
 			rx_mon_stats->status_ppdu_done++;
 			pmon->mon_ppdu_status = DP_PPDU_STATUS_DONE;
-			ath11k_dp_rx_mon_dest_process(ar, mac_id, budget, napi);
-			pmon->mon_ppdu_status = DP_PPDU_STATUS_START;
+			if (!ab->hw_params.full_monitor_mode) {
+				ath11k_dp_rx_mon_dest_process(ar, mac_id,
+							      budget, napi);
+				pmon->mon_ppdu_status = DP_PPDU_STATUS_START;
+			}
 		}
 
 		if (ppdu_info->peer_id == HAL_INVALID_PEERID ||
-- 
2.46.0


