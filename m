Return-Path: <linux-kernel+bounces-340462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C41639873C1
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 14:42:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC0851C22950
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 12:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EBAE3FF1;
	Thu, 26 Sep 2024 12:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="k47EDzKr"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C5227470
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 12:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727354567; cv=none; b=iZ6W9b4y9XK26JReIg0mrbopzjvC5chFMlYb5FHZvgoSf6fBZW92ue8n630zDJHNeGjudj5nl7cFWWXt+tlkrJkzUtUMNfjg8TSZqcwRFO+Ol1YqDSXnc04uaAiAU0fwa0pB2WSFsZU03RTm9O/6sF+K4tozfoqfjaM3GLntYJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727354567; c=relaxed/simple;
	bh=tCqmyyujdJNhl2uOUqC8yfoyou0bmmDfM0lH9QJ0Wp0=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=R36ve7jZJqqAukLCzmT1wlJZgUeVPwXNLGkf/h1Kyyp5elFj14Q9EEoWItU0WF6YH7IzPUgnNeUIUhLqhZINk0bgiYJd873qQKvyAKvxVMUY3P287KLk+GQwR81HtQcMl6DuP8uZrrJuV8VVfDjEjSTOryq7yOumuj6dBiEN9Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=k47EDzKr; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48Q6vARd004173;
	Thu, 26 Sep 2024 12:42:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
	:from:to:cc:subject:message-id:content-type:mime-version; s=pp1;
	 bh=p0EPlEY9QhbUEi9ipluqDBD3QfVCCAhUCaX2s1MozUE=; b=k47EDzKrU63w
	PNUzlWdvguSa4l6M9KgwPKM73L22LBVoVOEZxoxffmGvAUfEizqYC96UbICCjpoT
	7enEkGb7LJjqnFLr1KNmRitMGogsRGnp+dzKcd15gqmUoiy2wLhP4WiH0hjjcIok
	W/BROTlLf0z0fwrMl7cvEIUPQqF+qB38aDylKc7RKLu2zQ/kzwkstQ8kA22HeQkt
	5+jHkKzLCM7xxKSvN+5/PFAs7GInzQv8O3ErDGy3vp76V7bRmHELxQ5lrQYN9css
	7+wDObKt9qxALtuxdmyjz9wCWE4aLOoQ7Rh2w6fznubPTZxa1CCub/uIsw0kTV8E
	gsNBFcBH+g==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41snnapjht-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Sep 2024 12:42:31 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 48QCgVkn025371;
	Thu, 26 Sep 2024 12:42:31 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41snnapjhp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Sep 2024 12:42:31 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48QBhqnE013933;
	Thu, 26 Sep 2024 12:42:29 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41t9yn79cj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Sep 2024 12:42:29 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 48QCgRhv30671246
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Sep 2024 12:42:27 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B242420040;
	Thu, 26 Sep 2024 12:42:27 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 28A212004B;
	Thu, 26 Sep 2024 12:42:25 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.124.214.120])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 26 Sep 2024 12:42:24 +0000 (GMT)
Date: Thu, 26 Sep 2024 18:12:19 +0530
From: Vishal Chourasia <vishalc@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>
Subject: sched/fair: Kernel panics in pick_next_entity
Message-ID: <ZvVWq3WM6zVza_mD@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: lqCx899cdlrf7jwxYT1TN_sOzOfjjkWS
X-Proofpoint-ORIG-GUID: j_Lm6MyMH6yQ3oB4gdRi-3KOpe1khITz
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-26_04,2024-09-26_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 mlxscore=0 mlxlogscore=999 spamscore=0 impostorscore=0 priorityscore=1501
 phishscore=0 bulkscore=0 clxscore=1011 lowpriorityscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2409260085

I've noticed a kernel panic consistently occurring on the mainline v6.11
kernel (see attached dmesg log below). 

The panic occurs almost every time I build the Linux kernel from source.

Steps to Reproduce:

make clean
./scripts/config -e LOCALVERSION_AUTO
./scripts/config --set-str LOCALVERSION -master-with-print
make localmodconfig
make -j8 -s vmlinux modules

>From my investigation, it seems that the function pick_eevdf() can return NULL.
Commit f12e1488 ("sched/fair: Prepare pick_next_task() for delayed dequeue") 
introduces an access on the return value of pick_eevdf(). If 'se' was NULL, 
it can lead to a null pointer dereference. 

# objdump -S vmlinux | grep -C 5 c0000000001cfebc
c0000000001cfeb0:       00 00 00 60     nop
        struct sched_entity *se = pick_eevdf(cfs_rq);
c0000000001cfeb4:       78 f3 c3 7f     mr      r3,r30
c0000000001cfeb8:       01 46 ff 4b     bl      c0000000001c44b8 <pick_eevdf+0x8>
        if (se->sched_delayed) {
c0000000001cfebc:       51 00 23 89     lbz     r9,81(r3)  <<<<<<
        struct sched_entity *se = pick_eevdf(cfs_rq);
c0000000001cfec0:       78 1b 7f 7c     mr      r31,r3
        if (se->sched_delayed) {
c0000000001cfec4:       00 00 09 2c     cmpwi   r9,0
c0000000001cfec8:       98 00 82 40     bne     c0000000001cff60 <pick_next_entity+0xe0>

r3 is NULL which can be verified from the register context shared in the
dmesg logs

Here is the state of my git repository:
# git log --oneline
684a64bf32b6 (HEAD -> master, origin/master, origin/HEAD) Merge tag 'nfs-for-6.12-1' of git://git.linux-nfs.org/projects/anna/linux-nfs
f7fccaa77271 Merge tag 'fuse-update-6.12' of git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse
4165cee7ecb1 Merge tag 'exfat-for-6.12-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/linkinjeon/exfat
79952bdcbcea Merge tag 'f2fs-for-6.12-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs
fa8380a06bd0 Merge tag 'bpf-next-6.12-struct-fd' of git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next
68e5c7d4cefb Merge tag 'kbuild-v6.12' of git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild
7f8de2bf0725 Merge tag 'linux-cpupower-6.12-rc1-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux
cd3d64772981 Merge tag 'i3c/for-6.12' of git://git.kernel.org/pub/scm/linux/kernel/git/i3c/linux


To determine why pick_eevdf() would return NULL, I added a few printk statements
Based on one of the printk logs in the shared dmesg log, it appears that if
pick_eevdf() is called for a 'cfs_rq' whose 'cfs_rq->curr' is NULL and there
are no eligible entities on that 'cfs_rq', it will return NULL. 

# git diff
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 225b31aaee55..8c5b96f1cd49 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -48,6 +48,7 @@
 #include <linux/ratelimit.h>
 #include <linux/task_work.h>
 #include <linux/rbtree_augmented.h>
+#include <linux/delay.h>

 #include <asm/switch_to.h>

@@ -907,16 +908,25 @@ struct sched_entity *__pick_first_entity(struct cfs_rq *cfs_rq)
 static struct sched_entity *pick_eevdf(struct cfs_rq *cfs_rq)
 {
        struct rb_node *node = cfs_rq->tasks_timeline.rb_root.rb_node;
+       struct rb_node *tmpnode = node;
        struct sched_entity *se = __pick_first_entity(cfs_rq);
+       struct sched_entity *tmpse = se;
        struct sched_entity *curr = cfs_rq->curr;
+       struct sched_entity *tmpcurr = curr;
        struct sched_entity *best = NULL;
-
+       struct sched_entity *tmp = NULL;
        /*
         * We can safely skip eligibility check if there is only one entity
         * in this cfs_rq, saving some cycles.
         */
-       if (cfs_rq->nr_running == 1)
-               return curr && curr->on_rq ? curr : se;
+       if (cfs_rq->nr_running == 1) {
+               tmp = curr && curr->on_rq ? curr : se;
+               if (!tmp) {
+                       printk(KERN_INFO "pick_eevdf curr: %p, se: %p\n", curr, se);
+                       mdelay(10);
+               }
+               return tmp;
+       }

        if (curr && (!curr->on_rq || !entity_eligible(cfs_rq, curr)))
                curr = NULL;
@@ -966,6 +976,11 @@ static struct sched_entity *pick_eevdf(struct cfs_rq *cfs_rq)
        if (!best || (curr && entity_before(curr, best)))
                best = curr;

+       if (!best) {
+               printk(KERN_INFO "best=%p, curr=%p, se=%p, node=%p ocrr=%p, ose=%p, onode=%p\n", best, curr, se, node, tmpcurr, tmpse, tmpnode);
+               mdelay(10);
+       }
+
        return best;
 }

From the logs below:
[ 1355.763494] best=0000000000000000, curr=0000000000000000, se=00000000be02c573, node=0000000000000000 ocrr=0000000000000000, ose=00000000b1d4c4d5, onode=0000000023eb8c00

I have not been able to think of a quick reproducer to trigger a panic
for this case. Hoping if someone can guide me on this.

Note: The following dmesg log also contains a warning reported too. Panic
happens later.

------------[ cut here ]------------
!se->on_rq
WARNING: CPU: 1 PID: 92333 at kernel/sched/fair.c:705 update_entity_lag+0xcc/0xf0
Modules linked in: binfmt_misc bonding tls rfkill ibmveth pseries_rng vmx_crypto nd_pmem nd_btt dax_pmem loop nfnetlink xfs sd_mod papr_scm libnvdimm ibmvscsi scsi_transport_srp pseries_wdt dm_mirror dm_region_hash dm_log dm_mod fuse
CPU: 1 UID: 0 PID: 92333 Comm: genksyms Tainted: G        W          6.11.0-master-with-print-10547-g684a64bf32b6-dirty #64
Tainted: [W]=WARN
Hardware name: IBM,9080-HEX POWER10 (architected) hv:phyp pSeries
NIP:  c0000000001cdfcc LR: c0000000001cdfc8 CTR: 0000000000000000
REGS: c00000005c62ee50 TRAP: 0700   Tainted: G        W           (6.11.0-master-with-print-10547-g684a64bf32b6-dirty)
MSR:  8000000000029033 <SF,EE,ME,IR,DR,RI,LE>  CR: 24002222  XER: 00000005
CFAR: c000000000156a10 IRQMASK: 1
GPR00: c0000000001cdfc8 c00000005c62f0f0 c000000001b57400 000000000000000a
GPR04: 00000000ffff7fff c00000005c62eee0 c00000005c62eed8 00000007fb050000
GPR08: 0000000000000027 0000000000000000 0000000000000000 c000000002758de0
GPR12: c000000002a18d88 c0000007fffef480 0000000000000000 0000000000000000
GPR16: c000000002c56d40 0000000000000000 c00000005c62f5b4 0000000000000000
GPR20: fffffffffffffdef 0000000000000000 0000000000000002 c000000003cd7300
GPR24: 0000000000000000 0000000000000008 c0000007fd1d3f80 0000000000000000
GPR28: 0000000000000001 0000000000000009 c0000007fd1d4080 c0000000656a0000
NIP [c0000000001cdfcc] update_entity_lag+0xcc/0xf0
LR [c0000000001cdfc8] update_entity_lag+0xc8/0xf0
Call Trace:
[c00000005c62f0f0] [c0000000001cdfc8] update_entity_lag+0xc8/0xf0 (unreliable)
[c00000005c62f160] [c0000000001cea80] dequeue_entity+0xb0/0x6d0
[c00000005c62f1f0] [c0000000001cf8b0] dequeue_entities+0x150/0x600
[c00000005c62f2c0] [c0000000001d02a8] dequeue_task_fair+0x158/0x2e0
[c00000005c62f300] [c0000000001b5ea4] dequeue_task+0x64/0x200
[c00000005c62f380] [c0000000001cc950] detach_tasks+0x140/0x420
[c00000005c62f3f0] [c0000000001d6044] sched_balance_rq+0x214/0x7c0
[c00000005c62f550] [c0000000001d6830] sched_balance_newidle+0x240/0x630
[c00000005c62f640] [c0000000001d6d0c] pick_next_task_fair+0x7c/0x4a0
[c00000005c62f6d0] [c0000000001afc50] __pick_next_task+0x60/0x2d0
[c00000005c62f730] [c0000000010e8ce8] __schedule+0x198/0x840
[c00000005c62f810] [c0000000010e93d0] schedule+0x40/0x110
[c00000005c62f880] [c00000000064c574] pipe_read+0x424/0x6a0
[c00000005c62f960] [c00000000063a0fc] vfs_read+0x30c/0x3d0
[c00000005c62fa10] [c00000000063adf4] ksys_read+0x104/0x160
[c00000005c62fa60] [c000000000031678] system_call_exception+0x138/0x2d0
[c00000005c62fe50] [c00000000000cedc] system_call_vectored_common+0x15c/0x2ec
--- interrupt: 3000 at 0x7fffb8f4a0c4
NIP:  00007fffb8f4a0c4 LR: 00007fffb8f4a0c4 CTR: 0000000000000000
REGS: c00000005c62fe80 TRAP: 3000   Tainted: G        W           (6.11.0-master-with-print-10547-g684a64bf32b6-dirty)
MSR:  800000000280f033 <SF,VEC,VSX,EE,PR,FP,ME,IR,DR,RI,LE>  CR: 48004222  XER: 00000000
IRQMASK: 0
GPR00: 0000000000000003 00007fffe27ca2d0 00007fffb9067100 0000000000000000
GPR04: 000000003076051b 0000000000002000 00007fffb9060b50 0000000000000000
GPR08: 000000000000006f 0000000000000000 0000000000000000 0000000000000000
GPR12: 0000000000000000 00007fffb917a560 000000000000000b 0000000000000000
GPR16: 00007fffb9173570 0000000000002000 000000000000000c 000000000000000b
GPR20: 00000000307604c0 0000000030762509 00000000100484e8 0000000030762515
GPR24: 0000000010022b80 0000000000000000 0000000000000005 0000000000002000
GPR28: 000000003076051b 0000000000002000 00007fffb905e508 00007fffb9060b50
NIP [00007fffb8f4a0c4] 0x7fffb8f4a0c4
LR [00007fffb8f4a0c4] 0x7fffb8f4a0c4
--- interrupt: 3000
Code: 4e800020 3d220104 89297c19 2c090000 4082ff8c 3c62ff99 39200001 3d420104 38632d90 992a7c19 4bf88965 60000000 <0fe00000> 4bffff68 60000000 60000000
---[ end trace 0000000000000000 ]---
best=0000000000000000, curr=0000000000000000, se=00000000be02c573, node=0000000000000000 ocrr=0000000000000000, ose=00000000b1d4c4d5, onode=0000000023eb8c00
Kernel attempted to read user page (51) - exploit attempt? (uid: 0)
BUG: Kernel NULL pointer dereference on read at 0x00000051
Faulting instruction address: 0xc0000000001cfebc
Oops: Kernel access of bad area, sig: 11 [#1]
LE PAGE_SIZE=64K MMU=Radix SMP NR_CPUS=2048 NUMA pSeries
Modules linked in: binfmt_misc bonding tls rfkill ibmveth pseries_rng vmx_crypto nd_pmem nd_btt dax_pmem loop nfnetlink xfs sd_mod papr_scm libnvdimm ibmvscsi scsi_transport_srp pseries_wdt dm_mirror dm_region_hash dm_log dm_mod fuse
CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Tainted: G        W          6.11.0-master-with-print-10547-g684a64bf32b6-dirty #64
Tainted: [W]=WARN
Hardware name: IBM,9080-HEX POWER10 (architected) 0x800200 0xf000006 of:IBM,FW1060.00 (NH1060_012) hv:phyp pSeries
NIP:  c0000000001cfebc LR: c0000000001cfebc CTR: 0000000000000000
REGS: c000000002c13950 TRAP: 0300   Tainted: G        W           (6.11.0-master-with-print-10547-g684a64bf32b6-dirty)
MSR:  800000000280b033 <SF,VEC,VSX,EE,FP,ME,IR,DR,RI,LE>  CR: 44022282  XER: 0000000d
CFAR: c0000000001c4758 DAR: 0000000000000051 DSISR: 40000000 IRQMASK: 1
GPR00: c0000000001cfebc c000000002c13bf0 c000000001b57400 0000000000000000
GPR04: c0000007fd147108 c0000007fd1cd600 c000000002c13968 00000007fafb0000
GPR08: 0000000000000027 00000000004e2002 0000896cdac1f9a0 0000000000002000
GPR12: c000000002a18d88 c000000002f10000 0000000000000000 00000007fffe0000
GPR16: 00000007fffd0000 0000000000000000 00000007fffe0114 0000000000000000
GPR20: 0000000000000000 0000000000000000 c0000000010e95ec c000000002bd6380
GPR24: c000000002bd6da8 c000000002c524e8 0000000000000000 c000000002bd6380
GPR28: c000000002bd6380 c0000007fd1d3f80 c0000007fd1d4080 c0000007fd1d3f80
NIP [c0000000001cfebc] pick_next_entity+0x3c/0x180
LR [c0000000001cfebc] pick_next_entity+0x3c/0x180
Call Trace:
[c000000002c13bf0] [c0000000001cfebc] pick_next_entity+0x3c/0x180 (unreliable)
[c000000002c13c70] [c0000000001d0064] pick_task_fair+0x64/0x130
[c000000002c13cb0] [c0000000001d6cd8] pick_next_task_fair+0x48/0x4a0
[c000000002c13d40] [c0000000001afc50] __pick_next_task+0x60/0x2d0
[c000000002c13da0] [c0000000010e8ce8] __schedule+0x198/0x840
[c000000002c13e80] [c0000000010e95ec] schedule_idle+0x3c/0x70
[c000000002c13eb0] [c0000000001eb1d0] do_idle+0x160/0x1b0
[c000000002c13f00] [c0000000001eb4d0] cpu_startup_entry+0x50/0x60
[c000000002c13f30] [c0000000000110e8] rest_init+0xf0/0xf4
[c000000002c13f60] [c0000000020053a4] do_initcalls+0x0/0x190
[c000000002c13fe0] [c00000000000e788] start_here_common+0x1c/0x20
Code: 60000000 7c0802a6 fba1ffe8 fbc1fff0 fbe1fff8 7c7d1b78 7c9e2378 f8010010 f821ff81 60000000 7fc3f378 4bff4601 <89230051> 7c7f1b78 2c090000 40820098
---[ end trace 0000000000000000 ]---
pstore: backend (nvram) writing error (-1)

Kernel panic - not syncing: Fatal exception
Rebooting in 10 seconds..


