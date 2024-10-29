Return-Path: <linux-kernel+bounces-386878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 519059B48F4
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 13:05:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67D3B1C228F6
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 12:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BFF1206043;
	Tue, 29 Oct 2024 12:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b="GMEAh8qd"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92FD205ACE
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 12:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730203437; cv=none; b=YMXcbgmt12dBJe60RB4l/RAe9PJT1OFE8/BTnAvmjn96j2GoLdVtW4UsqqQdFw/nkfd4IfeMTYNYOBqMe4h9ErgAUpIIK6rcGVcWvmAXDvMA6u/ITrcM8AnuG5iIzpMGfAASHkOJleVCpVp1XsxgJ+sw3QpPKRBpfODv+DjroIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730203437; c=relaxed/simple;
	bh=Zrcq0Nidv8F0rmXB/0vA+ojiznEbJ3tbAce3QHjWNTw=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=HIVl8YB3OeqFjtmYNjfiwRfIxnldTBoFTa5zVy+IHcm9TCA2X+csW4HEiRSupdTZL/hWOzOdAQv4Q8epOMgInC8fGR0HxGS9PWzlWxvCaI38e5ZkZPz3xXIyA/Jp4zPeKGJdHqB1qKCPBvaNXpy+/TPaRX6I6PsTZCf+YmwSmzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b=GMEAh8qd; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1730203431; x=1730808231; i=efault@gmx.de;
	bh=7TJGnw7HQpbz5JPecEIdOAsD1dFtavTWhS17NgoMQSs=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:
	 Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=GMEAh8qdr3gu36Z32LW9RGD5fjr9fyZnB8ZGsKsncdLFIWo6SSPaeDyccGFlLs9e
	 N04Un7ahCyvque1IDqDZBndZWbv3pbSBJscHv9bqn9Zqwe02VXeL621VCQk135Ytm
	 Alsi8CFa/lN243tRYLkn7qZAWm8/dNO2ILUYu7/hL/hykgbfbuvMxTeB5TqLuyyBz
	 Iz8o8JhndGZn2Vi6AdM97FeJcE4JxdzOwVRtOdwD8emWYWJLjYMI3XupGcLVrmbCd
	 PlSbWsYz3j9rG4oOG98+NVN3wQkTL/D1DK26HEGv4ch5SngGBKnqNpzV+lx/ky+sb
	 MARga5Lq9bgFLIKDHA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from homer.fritz.box ([91.212.106.134]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N9MpS-1tt5wQ3d5w-0105SF; Tue, 29
 Oct 2024 13:03:50 +0100
Message-ID: <88ae633aa910c7e320b89e5f4779d472f7cffffb.camel@gmx.de>
Subject: regression: mm: vmscan:  -  size XL irqoff time increase v6.10+
From: Mike Galbraith <efault@gmx.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Date: Tue, 29 Oct 2024 13:03:49 +0100
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:AZUAt9ouII00XKXGOJJ4IV3x6NZynmFmY+b3uKiBeauw1vaWsgP
 eNVghYRPmznaWtNkgapPnruASvYG0nov5Z/buLIxDSW5q1a7QA1uFU9WXHRNBojez66WJFA
 7ynZX54V9l7JCJgL588mvS7Iztg0UxuWV/KahU22g0ri7scNAA6cwh91JQNxh7vtviFjNFc
 gm5Mwf6pXmnsf2cpXlCjw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:E3XqM1AUHkE=;vFqsZhCkvwF5f3BiCW9VW7M7rPH
 xWonv5o7DRNjkcCzaMDUXlOY7090tCQIT99T/kKefE2PIEDRHd6O7gaV5d8LaFRgxKL0vJHWz
 pQJiLru+5STRdChyEgS1V5YWYi6LIuVJa8kaSD7/AVeZS22noXD1QZBWUxZsZCZoKNmNYheY+
 D3mzaVQggtrjh+DmYla1SDKET2X4ivewsDw9dbipRMwNAswD9Qf7WqSILmqAH9QQ5+hSKh/XD
 wz05sIGprdCZwQeq0a3GM52VhcjOa9sCB8+xPfXJc3CmnnkJH2zbrlzSKz3G858RAEs7HSSkT
 oxqLVW/zYYr47teJl2YmZTwXJrk7fYQud4CFNAYVIzAtkknJFf6oF79WWj03aTHHkkJ8WKexI
 6LXjMB3KZsQpvlh0vOnTyqfhzg9l+CHQ+JCAzONBQhFQeUiMKa507yeuYw2jk5CVVai5QsvUJ
 7fiFjop78ddDeiomopvAn77zUp3/ZnLALSszgKFh0IO+tDnGl82/uo8yY0aK2x/OZeHIRudJX
 JbhN2NOVjQnWS+gmYIgokL1H1R5PpPLoiPkZJRoKRO+P5TcenhhYiWzXKDqg3M7rkcDXds7th
 d82shHG2TC+/eQplMYtVcTwHdGuUJHEqe/v/joQ4YYXXZOjK3VJxp2cQSELNnPTsjVwgel8RF
 fA1CDiEYsnTIQ2y28NxemxHPWuitGbT5UEDlwNq0XQtuO+x7SlKQGQIg1RQajReJjF4nyh6Lu
 XD8h3gfvtj4OojA0RUrn0H2aPri1qvhzPzbWsXEwKlb74FpqG6DI2mfwKdkRdLGgX/k/gi/9H
 Ylb9bZFNouyBmoKg/NcYGliQ==

Greetings,

I've noticed size XL cyclictest -Smp99 wakeup latency spikes for some
time now, but due to bandwidth etc (ie laziness), never got around to
taking a peek until today.

Seems isolate_lru_folios() in v6.10+ holds off irqs far longer, roughly
an order of magnitude over v6.9 for my old i7-4790 desktop box.

	-Mike

test log - scroll fast

cyclictest -Smp99 vs HDD (spinning rust) IO, osc kernel build/packaging
in one HD and bonnie in another makes spikes nicely repeatable.

6.12.0-rc5
T: 0 ( 4541) P:99 I:1000 C: 773124 Min:      1 Act:    6 Avg:    3 Max:   =
53381
T: 1 ( 4542) P:99 I:1500 C: 515381 Min:      1 Act:    7 Avg:    3 Max:   =
60119
T: 2 ( 4543) P:99 I:2000 C: 386465 Min:      1 Act:    5 Avg:    4 Max:   =
67469
T: 3 ( 4544) P:99 I:2500 C: 309182 Min:      1 Act:    7 Avg:    4 Max:   =
65534
T: 4 ( 4545) P:99 I:3000 C: 257682 Min:      1 Act:    6 Avg:    4 Max:   =
57776
T: 5 ( 4546) P:99 I:3500 C: 220874 Min:      1 Act:    4 Avg:    4 Max:   =
64737
T: 6 ( 4547) P:99 I:4000 C: 193289 Min:      1 Act:    6 Avg:    4 Max:   =
52567
T: 7 ( 4548) P:99 I:4500 C: 171799 Min:      1 Act:    6 Avg:    5 Max:   =
52606

6.6.58-stable
T: 0 ( 4928) P:99 I:1000 C: 824721 Min:      1 Act:    5 Avg:    3 Max:   =
 4619
T: 1 ( 4929) P:99 I:1500 C: 549816 Min:      1 Act:    7 Avg:    3 Max:   =
 5308
T: 2 ( 4930) P:99 I:2000 C: 412364 Min:      1 Act:    5 Avg:    3 Max:   =
 5305
T: 3 ( 4931) P:99 I:2500 C: 329892 Min:      1 Act:    5 Avg:    3 Max:   =
 3160
T: 4 ( 4932) P:99 I:3000 C: 274909 Min:      1 Act:    6 Avg:    3 Max:   =
 4044
T: 5 ( 4933) P:99 I:3500 C: 235637 Min:      1 Act:    6 Avg:    3 Max:   =
 3922
T: 6 ( 4934) P:99 I:4000 C: 206183 Min:      1 Act:    5 Avg:    3 Max:   =
 2811
T: 7 ( 4935) P:99 I:4500 C: 183274 Min:      1 Act:    6 Avg:    3 Max:   =
 3678

6.11.5-stable
T: 0 ( 8318) P:99 I:1000 C: 734458 Min:      0 Act:    4 Avg:    4 Max:   =
61030
T: 1 ( 8319) P:99 I:1500 C: 489879 Min:      1 Act:    5 Avg:    4 Max:   =
51595
T: 2 ( 8320) P:99 I:2000 C: 367286 Min:      1 Act:    5 Avg:    5 Max:   =
62361
T: 3 ( 8321) P:99 I:2500 C: 293937 Min:      1 Act:    6 Avg:    5 Max:   =
60837
T: 4 ( 8322) P:99 I:3000 C: 244935 Min:      1 Act:    6 Avg:    6 Max:   =
59312
T: 5 ( 8323) P:99 I:3500 C: 209981 Min:      1 Act:    9 Avg:    5 Max:   =
62318
T: 6 ( 8324) P:99 I:4000 C: 183701 Min:      1 Act:    7 Avg:    7 Max:   =
78961
T: 7 ( 8325) P:99 I:4500 C: 163241 Min:      1 Act:    7 Avg:    9 Max:   =
59300

6.10.14-stable
T: 0 ( 4318) P:99 I:1000 C: 788179 Min:      0 Act:    6 Avg:    3 Max:   =
63290
T: 1 ( 4319) P:99 I:1500 C: 525458 Min:      1 Act:    6 Avg:    3 Max:   =
64128
T: 2 ( 4320) P:99 I:2000 C: 394070 Min:      1 Act:    6 Avg:    4 Max:   =
58836
T: 3 ( 4321) P:99 I:2500 C: 315317 Min:      0 Act:    8 Avg:    3 Max:   =
55249
T: 4 ( 4322) P:99 I:3000 C: 262773 Min:      1 Act:    7 Avg:    3 Max:   =
50339
T: 5 ( 4323) P:99 I:3500 C: 225239 Min:      0 Act:    6 Avg:    3 Max:   =
52687
T: 6 ( 4324) P:99 I:4000 C: 197054 Min:      1 Act:    6 Avg:    4 Max:   =
64231
T: 7 ( 4325) P:99 I:4500 C: 175170 Min:      1 Act:    7 Avg:    4 Max:   =
54302

6.9.12-stable
T: 0 (24683) P:99 I:1000 C: 785036 Min:      1 Act:    6 Avg:    2 Max:   =
 1771
T: 1 (24684) P:99 I:1500 C: 523355 Min:      1 Act:    5 Avg:    3 Max:   =
 1958
T: 2 (24685) P:99 I:2000 C: 392516 Min:      1 Act:    4 Avg:    3 Max:   =
 2317
T: 3 (24686) P:99 I:2500 C: 314013 Min:      1 Act:    7 Avg:    3 Max:   =
  786
T: 4 (24687) P:99 I:3000 C: 261677 Min:      1 Act:    5 Avg:    3 Max:   =
  840
T: 5 (24688) P:99 I:3500 C: 224294 Min:      1 Act:    6 Avg:    3 Max:   =
  960
T: 6 (24689) P:99 I:4000 C: 196257 Min:      1 Act:    6 Avg:    3 Max:   =
  627
T: 7 (24690) P:99 I:4500 C: 174449 Min:      1 Act:    6 Avg:    3 Max:   =
 6327

Ok, size mondo spikes begin at v6.10

# tracer: wakeup_rt
#
# wakeup_rt latency trace v1.1.5 on 6.10.14-stable
# --------------------------------------------------------------------
# latency: 55060 us, #343/343, CPU#4 | (M:desktop VP:0, KP:0, SP:0 HP:0 #P=
:8)
#    -----------------
#    | task: cyclictest-8238 (uid:0 nice:0 policy:1 rt_prio:99)
#    -----------------
#
#                    _------=3D> CPU#
#                   / _-----=3D> irqs-off/BH-disabled
#                  | / _----=3D> need-resched
#                  || / _---=3D> hardirq/softirq
#                  ||| / _--=3D> preempt-depth
#                  |||| / _-=3D> migrate-disable
#                  ||||| /     delay
#  cmd     pid     |||||| time  |   caller
#     \   /        ||||||  \    |    /
   <...>-88        4dNh..    0us :       88:120:R   + [004]    8238:  0:R =
cyclictest
   <...>-88        4dNh..    8us : <stack trace>
 =3D> __ftrace_trace_stack+0x115/0x140
 =3D> probe_wakeup+0x2ac/0x330
 =3D> ttwu_do_activate+0xda/0x1c0
 =3D> try_to_wake_up+0x390/0x470
 =3D> hrtimer_wakeup+0x1e/0x30
 =3D> __hrtimer_run_queues+0xfc/0x200
 =3D> hrtimer_interrupt+0xea/0x250
 =3D> __sysvec_apic_timer_interrupt+0x44/0xe0
 =3D> sysvec_apic_timer_interrupt+0x4b/0x90
 =3D> asm_sysvec_apic_timer_interrupt+0x16/0x20
 =3D> shrink_inactive_list+0x0/0x3e0
 =3D> shrink_lruvec+0x2fc/0x470
 =3D> shrink_node+0x1db/0x4a0
 =3D> balance_pgdat+0x278/0x5b0
 =3D> kswapd+0x10e/0x310
 =3D> kthread+0xc7/0xf0
 =3D> ret_from_fork+0x2d/0x50
 =3D> ret_from_fork_asm+0x11/0x20
   <...>-88        4dNh..    8us : 0
   <...>-88        4dNh..    8us : task_woken_rt+0x0/0x60 <-ttwu_do_activa=
te+0x87/0x1c0
   <...>-88        4dNh..    9us : _raw_spin_unlock_irqrestore+0x0/0x20 <-=
try_to_wake_up+0x3b4/0x470
   <...>-88        4dNh..    9us : _raw_spin_lock_irq+0x0/0x20 <-__hrtimer=
_run_queues+0x109/0x200
   <...>-88        4dNh..    9us : hrtimer_update_next_event+0x0/0x50 <-hr=
timer_interrupt+0xf2/0x250
   <...>-88        4dNh..    9us : __hrtimer_get_next_event+0x0/0x70 <-hrt=
imer_update_next_event+0x24/0x50
   <...>-88        4dNh..    9us : __hrtimer_next_event_base+0x0/0xb0 <-__=
hrtimer_get_next_event+0x60/0x70
   <...>-88        4dNh..    9us : __hrtimer_get_next_event+0x0/0x70 <-hrt=
imer_update_next_event+0x38/0x50
   <...>-88        4dNh..    9us : __hrtimer_next_event_base+0x0/0xb0 <-hr=
timer_update_next_event+0x38/0x50
   <...>-88        4dNh..    9us : _raw_spin_unlock_irqrestore+0x0/0x20 <-=
hrtimer_interrupt+0x10a/0x250
   <...>-88        4dNh..   10us : tick_program_event+0x0/0x70 <-hrtimer_i=
nterrupt+0x118/0x250
   <...>-88        4dNh..   10us : clockevents_program_event+0x0/0xe0 <-hr=
timer_interrupt+0x118/0x250
   <...>-88        4dNh..   10us : ktime_get+0x0/0xc0 <-clockevents_progra=
m_event+0x78/0xe0
   <...>-88        4dNh..   10us : lapic_next_deadline+0x0/0x40 <-clockeve=
nts_program_event+0xad/0xe0
   <...>-88        4dNh..   10us : irq_exit_rcu+0x0/0xa0 <-sysvec_apic_tim=
er_interrupt+0x50/0x90
   <...>-88        4dN...   10us : idle_cpu+0x0/0x40 <-irq_exit_rcu+0x3b/0=
xa0
   <...>-88        4.N...   11us : shrink_inactive_list+0x0/0x3e0 <-shrink=
_lruvec+0x2fc/0x470
   <...>-88        4.N...   11us : lru_add_drain+0x0/0x20 <-shrink_inactiv=
e_list+0xee/0x3e0
   <...>-88        4.N...   11us : lru_add_drain_cpu+0x0/0x100 <-lru_add_d=
rain+0x11/0x20
   <...>-88        4.N...   11us : mlock_drain_local+0x0/0x30 <-shrink_ina=
ctive_list+0xee/0x3e0
   <...>-88        4.N...   11us : _raw_spin_lock_irq+0x0/0x20 <-shrink_in=
active_list+0xf6/0x3e0
   <...>-88        4dN...   11us*: isolate_lru_folios+0x0/0x390 <-shrink_i=
nactive_list+0x110/0x3e0  <=3D=3D hmmm
   <...>-88        4dN... 54984us : __mod_node_page_state+0x0/0x70 <-isola=
te_lru_folios+0x289/0x390 <=3D=3D artifact.. but repeats
   <...>-88        4dN... 54985us : __mod_zone_page_state+0x0/0x60 <-isola=
te_lru_folios+0x297/0x390
   <...>-88        4dN... 54985us : __mod_node_page_state+0x0/0x70 <-shrin=
k_inactive_list+0x12b/0x3e0
   <...>-88        4dN... 54986us : irq_enter_rcu+0x0/0x60 <-sysvec_apic_t=
imer_interrupt+0x43/0x90
   <...>-88        4dNh.. 54986us : __sysvec_apic_timer_interrupt+0x0/0xe0=
 <-sysvec_apic_timer_interrupt+0x4b/0x90
   <...>-88        4dNh.. 54986us : hrtimer_interrupt+0x0/0x250 <-__sysvec=
_apic_timer_interrupt+0x44/0xe0

trace_printk time.

patches/xx
=2D--
 mm/vmscan.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

=2D-- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -56,6 +56,7 @@
 #include <linux/khugepaged.h>
 #include <linux/rculist_nulls.h>
 #include <linux/random.h>
+#include <linux/sched/clock.h>

 #include <asm/tlbflush.h>
 #include <asm/div64.h>
@@ -1620,6 +1621,9 @@ static unsigned long isolate_lru_folios(
 	unsigned long skipped =3D 0;
 	unsigned long scan, total_scan, nr_pages;
 	LIST_HEAD(folios_skipped);
+	int cpu =3D raw_smp_processor_id();
+	u64 then =3D cpu_clock(cpu), this;
+	static u64 max =3D 0;

 	total_scan =3D 0;
 	scan =3D 0;
@@ -1697,6 +1701,12 @@ static unsigned long isolate_lru_folios(
 	trace_mm_vmscan_lru_isolate(sc->reclaim_idx, sc->order, nr_to_scan,
 				    total_scan, skipped, nr_taken, lru);
 	update_lru_sizes(lruvec, lru, nr_zone_taken);
+	this =3D cpu_clock(cpu) - then;
+	if (this > max) {
+		max =3D this;
+		if (max > 1000)
+			trace_printk("new record: %Lu us\n", max/1000UL);
+	}
 	return nr_taken;
 }

6.10.14-stable +xx
T: 0 ( 6009) P:99 I:1000 C: 392693 Min:      0 Act:    6 Avg:    3 Max:   =
58348
T: 1 ( 6010) P:99 I:1500 C: 261247 Min:      0 Act:   12 Avg:    7 Max:   =
72563
T: 2 ( 6011) P:99 I:2000 C: 196226 Min:      0 Act:    7 Avg:    5 Max:   =
72367
T: 3 ( 6012) P:99 I:2500 C: 156939 Min:      0 Act:    8 Avg:    7 Max:   =
66426
T: 4 ( 6013) P:99 I:3000 C: 130563 Min:      1 Act:    8 Avg:   13 Max:   =
72005
T: 5 ( 6014) P:99 I:3500 C: 112231 Min:      1 Act:    6 Avg:    5 Max:   =
62329
T: 6 ( 6015) P:99 I:4000 C:  98159 Min:      1 Act:    4 Avg:    6 Max:   =
62539
T: 7 ( 6016) P:99 I:4500 C:  87314 Min:      1 Act:    8 Avg:    4 Max:   =
51182

homer:..debug/tracing # tail -5 trace
         kswapd0-91      [004] d....   518.224557: isolate_lru_folios: new=
 record: 52169 us
         kswapd0-91      [001] d....   520.001208: isolate_lru_folios: new=
 record: 61611 us
         kswapd0-91      [001] d....   520.390120: isolate_lru_folios: new=
 record: 72501 us
         kswapd0-91      [001] d....   520.463310: isolate_lru_folios: new=
 record: 72639 us
         kswapd0-91      [001] d....   520.607071: isolate_lru_folios: new=
 record: 72707 us

6.12.0.g81983758-master

# tracer: irqsoff
#
# irqsoff latency trace v1.1.5 on 6.12.0.g81983758-master
# --------------------------------------------------------------------
# latency: 49040 us, #8/8, CPU#1 | (M:desktop VP:0, KP:0, SP:0 HP:0 #P:8)
#    -----------------
#    | task: kswapd0-91 (uid:0 nice:0 policy:0 rt_prio:0)
#    -----------------
#  =3D> started at: _raw_spin_lock_irq+0x1a/0x40
#  =3D> ended at:   shrink_inactive_list+0x165/0x420
#
#
#                    _------=3D> CPU#
#                   / _-----=3D> irqs-off/BH-disabled
#                  | / _----=3D> need-resched
#                  || / _---=3D> hardirq/softirq
#                  ||| / _--=3D> preempt-depth
#                  |||| / _-=3D> migrate-disable
#                  ||||| /     delay
#  cmd     pid     |||||| time  |   caller
#     \   /        ||||||  \    |    /
 kswapd0-91        1d....    0us : _raw_spin_lock_irq+0x1a/0x40
 kswapd0-91        1d....    0us*: isolate_lru_folios+0x0/0x380 <-shrink_i=
nactive_list+0x106/0x420
 kswapd0-91        1d.... 49039us : __mod_node_page_state+0x0/0x70 <-isola=
te_lru_folios+0x288/0x380  <=3D=3D yup
 kswapd0-91        1d.... 49039us : __mod_zone_page_state+0x0/0x60 <-isola=
te_lru_folios+0x296/0x380
 kswapd0-91        1d.... 49040us : __mod_node_page_state+0x0/0x70 <-shrin=
k_inactive_list+0x11e/0x420
 kswapd0-91        1d.... 49040us : shrink_inactive_list+0x165/0x420
 kswapd0-91        1d.... 49040us : tracer_hardirqs_on+0xbb/0xd0 <-shrink_=
inactive_list+0x165/0x420
 kswapd0-91        1d.... 49048us : <stack trace>
 =3D> shrink_lruvec+0x2fc/0x470
 =3D> shrink_node+0x1dd/0x4b0
 =3D> balance_pgdat+0x280/0x5c0
 =3D> kswapd+0x10f/0x320
 =3D> kthread+0xb7/0xe0
 =3D> ret_from_fork+0x2d/0x50
 =3D> ret_from_fork_asm+0x11/0x20

gitk...

hm, 5ed890ce5147 mm: vmscan: avoid split during shrink_folio_list()

v6.9-rc4-254-g845982eb264b (without)
homer:..debug/tracing # tail -5 trace
         kswapd0-88      [005] d....   254.583681: isolate_lru_folios: new=
 record: 1545 us
         kswapd0-88      [003] dn...   318.694640: isolate_lru_folios: new=
 record: 36025 us
         kswapd0-88      [003] dn...   560.700168: isolate_lru_folios: new=
 record: 48922 us
         kswapd0-88      [002] d....   652.526922: isolate_lru_folios: new=
 record: 56143 us
         kswapd0-88      [002] d....   652.588941: isolate_lru_folios: new=
 record: 56638 us

meh, still way too wide.. not as wide though.

v6.9-rc4-255-g5ed890ce5147 (with)
homer:..debug/tracing # tail -5 trace
         kswapd0-88      [006] d....   301.719781: isolate_lru_folios: new=
 record: 19 us
         kswapd0-88      [002] d....   305.202140: isolate_lru_folios: new=
 record: 36446 us
         kswapd0-88      [005] dn...   339.858760: isolate_lru_folios: new=
 record: 59762 us
         kswapd0-88      [007] d....   583.350733: isolate_lru_folios: new=
 record: 73866 us
         kswapd0-88      [005] d....   604.445868: isolate_lru_folios: new=
 record: 75636 us

6.9.12-stable +xx
homer:..debug/tracing # tail -5 trace
         kswapd0-91      [003] d....   791.301680: isolate_lru_folios: new=
 record: 378 us
         kswapd0-91      [006] d....  1592.777235: isolate_lru_folios: new=
 record: 2358 us
         kswapd0-91      [004] d....  1879.108874: isolate_lru_folios: new=
 record: 2528 us
         kswapd0-91      [001] d....  1883.635762: isolate_lru_folios: new=
 record: 3535 us
         kswapd0-91      [002] d....  1911.251376: isolate_lru_folios: new=
 record: 5486 us

pass it on, poke later.. maybe.. lazy sod

