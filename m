Return-Path: <linux-kernel+bounces-548215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB2F2A541D4
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 05:48:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B2CC188E83F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 04:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F526199238;
	Thu,  6 Mar 2025 04:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fK+ZTqa0"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A187FD
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 04:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741236532; cv=none; b=omWth5GbWlMuYZ1tTHdreutVbW3EivGy6/r1c9kxKHkS6z3jZj9GBHZMqQTfaIB7/f+y5b5kFqwGvdn7XCX2q7+2JH6cUyrB+9TaZNwrO8wqdfujZXfttdcRG6wqpd3JVuHoxntFvF72HmoaprN/brNaFwk/9gKIlMO+iL2lnog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741236532; c=relaxed/simple;
	bh=/RLhckEvknyPIuDLWygMxijGKZQrmwdEnzAEyBcI+4E=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Z14Uf7A2n9BgC/GwgpqxGhksrwzIoUWVbYu86z4ImOvsoVgL9Vqkd6qckUdl8dMWbYhw62tZh3XgFp88jVvsMef+KJ2vkp0rlVxIS+v5QM1eH4K/RgmawsmhDSx9CDuYiaK5T562a/37Z0C/02w4wmOG0obE7IhQu5x+ugwK0dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fK+ZTqa0; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 525Kcxk9028695;
	Thu, 6 Mar 2025 04:48:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=4X/CoW
	babJva0wcKAJX50W2hG5IeeQQ0zM6RIVXoD7s=; b=fK+ZTqa06jDaMSzjkvFoDy
	W4/CCJ86oUe85hnB3ck11sh8oMKuqQJn9Ad0Yx9lqAM9ufz5xatrwtGGvHbLValR
	Bunm44FxMt6ml+GkzDfhWvo8LX6yAsVq/AxVjwbUqm6Vp/8Akimv0oEdziMjf5MC
	UasYX+Eq6Ax2Nq/QariwHhuApfW3FuYUvtA/QysLMAiSbXZmROoFLppfB611QwEU
	Bmbns8NtdXiQ9l7WjORvpwlADxQhO2RLjmotioWWGi3frER5Gp4o/yleSzuQmuGw
	uoyCTSAFsnavXI6NAisgZELMg7X3vzBEsauPC/3T9q2d1xb+WhmqQ59HlIPmFHmg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 456wu01p24-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Mar 2025 04:48:13 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 5264jECB006825;
	Thu, 6 Mar 2025 04:48:12 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 456wu01p23-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Mar 2025 04:48:12 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5261H08u013805;
	Thu, 6 Mar 2025 04:48:12 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 454e2kxneq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Mar 2025 04:48:12 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5264mBKm24773120
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 6 Mar 2025 04:48:11 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CEAC35805C;
	Thu,  6 Mar 2025 04:48:11 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0EBE958054;
	Thu,  6 Mar 2025 04:48:07 +0000 (GMT)
Received: from li-c18b6acc-24ee-11b2-a85c-81492619bda1.ibm.com (unknown [9.39.18.221])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  6 Mar 2025 04:48:06 +0000 (GMT)
Message-ID: <172769aab6901361f992a4ca67dd5dd8864f43ba.camel@linux.ibm.com>
Subject: Re: [PATCH 1/1] sched/fair: Fix invalid pointer dereference in
 child_cfs_rq_on_list()
From: Aboorva Devarajan <aboorvad@linux.ibm.com>
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com, riel@surriel.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        vschneid@redhat.com, odin@uged.al, linux-kernel@vger.kernel.org
Date: Thu, 06 Mar 2025 10:18:04 +0530
In-Reply-To: <f1bf21e6-4fd3-4f97-b28f-b0e8dc37ff91@arm.com>
References: <20250304170007.245261-1-aboorvad@linux.ibm.com>
	 <CAKfTPtCJKkwFeMKUrD3o224Nz4N+1qjtq0LvL945k9tJ8t8h-g@mail.gmail.com>
	 <f1bf21e6-4fd3-4f97-b28f-b0e8dc37ff91@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: -OMTedxBvcznT2QOWSyxCk7hNMmTEb1R
X-Proofpoint-ORIG-GUID: akJXhoAYz05ayWYSmxi6BMTO-O7YiZPh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-06_02,2025-03-05_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0
 bulkscore=0 adultscore=0 spamscore=0 mlxlogscore=999 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503060025

On Wed, 2025-03-05 at 10:23 +0100, Dietmar Eggemann wrote:
> On 05/03/2025 09:21, Vincent Guittot wrote:
> > On Tue, 4 Mar 2025 at 18:00, Aboorva Devarajan <aboorvad@linux.ibm.com>=
 wrote:
> > >=20
> > > In child_cfs_rq_on_list(), leaf_cfs_rq_list.prev is expected to point=
 to
> > > a valid cfs_rq->leaf_cfs_rq_list in the hierarchy. However, when acce=
ssed
> > > from the first node in a list, leaf_cfs_rq_list.prev can incorrectly =
point
> > > back to the list head (rq->leaf_cfs_rq_list) instead of another
> > > cfs_rq->leaf_cfs_rq_list.
> > >=20
> > > The function does not handle this case, leading to incorrect pointer
> > > calculations and unintended memory accesses, which can result in a ke=
rnel
> > > crash.
> > >=20
> > > A recent attempt to reorder fields in struct rq exposed this issue by
> > > modifying memory offsets and affecting how pointer computations are
> > > resolved. While the problem existed before, it was previously masked =
by
> > > specific field arrangement. The reordering caused erroneous pointer
> > > accesses, leading to a NULL dereference and a crash, as seen in the
>=20
> I'm running tip/sched/core on arm64 and I still only see the wrong
> pointer for 'prev_cfs_rq->tg->parent' in the 'prev =3D=3D
> &rq->leaf_cfs_rq_list' case?
>=20
> ...
> cpu=3D5 prev_cfs_rq->tg=3Dffff00097efb63a0 parent=3D0000000000000010
> cfs_rq->tg=3Dffff000802084000
> ...
>=20

Hi Dietmar,

Yes, you are right, I meant that we will still have invalid pointers and us=
e it=20
silently in the vanilla kernel, but it won't always lead to a crash.

The crash in this specific case happens if `prev_cfs_rq->tg` points to a me=
mory
location that cannot be de-referenced. Otherwise, the function de-reference=
s and
uses memory locations that are not valid but did not cause a visible failur=
e so far.

Here are more details on what I meant by reordering the runqueue:

With the system and kernel configuration, I encountered the crash while try=
ing
to reorder the runqueue structure, here is the minimal change that caused t=
he
crash on top of v6.14-rc5 kernel:

---
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index c8512a9fb022..597c1e6a9b5d 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1143,8 +1143,8 @@ struct rq {
=20
 #ifdef CONFIG_FAIR_GROUP_SCHED
        /* list of leaf cfs_rq on this CPU: */
+       struct list_head        *tmp_alone_branch;
        struct list_head        leaf_cfs_rq_list;
-       struct list_head        *tmp_alone_branch;
 #endif /* CONFIG_FAIR_GROUP_SCHED */
---

Here is the crash signature:

[    1.114431][  T552] Kernel attempted to read user page (10000012f) - exp=
loit attempt? (uid: 0)
[    1.114440][  T552] BUG: Unable to handle kernel data access on read at =
0x10000012f
[    1.114446][  T552] Faulting instruction address: 0xc0000000001c1044
[    1.116344][  T241] pstore: backend (nvram) writing error (-1)
[    1.116351][  T241]=20
[    1.116354][  T552] Oops: Kernel access of bad area, sig: 11 [#2]
[    1.116354][  T241] note: kworker/44:0[241] exited with irqs disabled
[    1.116356][  T552] LE PAGE_SIZE=3D64K MMU=3DRadix SMP NR_CPUS=3D2048 NU=
MA pSeries
[    1.116368][  T552] Modules linked in: autofs4
[    1.116374][  T552] CPU: 73 UID: 0 PID: 552 Comm: kworker/73:1 Tainted: =
G      D            6.14.0-rc5-dirty #193
[    1.116381][  T552] Tainted: [D]=3DDIE
[    1.116384][  T552] Hardware name: IBM,9080-HEX POWER10 (architected) 0x=
800200 0xf000006 of:IBM,FW1060.00 (NH1060_012) hv:phyp pSeries
[    1.116391][  T552] NIP:  c0000000001c1044 LR: c0000000001c0f98 CTR: c00=
0000000027ad4
[    1.116396][  T552] REGS: c000000076627870 TRAP: 0300   Tainted: G      =
D             (6.14.0-rc5-dirty)
[    1.116401][  T552] MSR:  800000000280b033 <SF,VEC,VSX,EE,FP,ME,IR,DR,RI=
,LE>  CR: 48008202  XER: 20040154
...
[    1.116467][  T552] NIP [c0000000001c1044] sched_balance_update_blocked_=
averages+0x35c/0x88c
[    1.116474][  T552] LR [c0000000001c0f98] sched_balance_update_blocked_a=
verages+0x2b0/0x88c

~~~~

Before reordering, struct rq and cfs_rq had the following memory layout
(snippet from pahole):

struct rq {
	...                                                 (offset  bytes)
	struct list_head           leaf_cfs_rq_list;     /*  4048    16 */
	struct list_head *         tmp_alone_branch;     /*  4064     8 */
	unsigned int               nr_uninterruptible;   /*  4072     4 */
	...
}
struct cfs_rq {
	...
	struct list_head           leaf_cfs_rq_list;     /*   456    16 */
	struct task_group *        tg;                   /*   472     8 */
	...
}

In child_cfs_rq_on_list(), `prev_cfs_rq` is computed using the `container_o=
f`
macro:

prev_cfs_rq =3D container_of(prev, struct cfs_rq, leaf_cfs_rq_list);

Since `prev =3D=3D &rq->leaf_cfs_rq_list`, this results in:

prev_cfs_rq =3D rq->leaf_cfs_rq_list -  456 (offset of leaf_cfs_rq_list in =
cfs_rq)

Then, `prev_cfs_rq->tg` is accessed at an offset of 472 bytes from base cfs=
_rq:

prev_cfs_rq->tg =3D (rq->leaf_cfs_rq_list - 456) + 472
                 =3D rq->leaf_cfs_rq_list + 16
                 =3D rq->tmp_alone_branch

Since `tmp_alone_branch` is always at this point a valid pointer, dereferen=
cing
`prev_cfs_rq->tg->parent` doesn't cause a crash, even though it is not
a valid task_group pointer.

~~~~

After reordering, the layout of `struct rq` changed as follows:

struct rq {
	...                                                (offset  bytes)
	struct list_head *         tmp_alone_branch;     /*  4048     8 */ -> this=
 is shuffled up
	struct list_head           leaf_cfs_rq_list;     /*  4056    16 */
	unsigned int               nr_uninterruptible;   /*  4072     4 */
	...
}

The layout of `struct cfs_rq` is unchanged.

Now, when the same pointer arithmetic is performed:

prev_cfs_rq =3D rq->leaf_cfs_rq_list - 456

prev_cfs_rq->tg =3D (rq->leaf_cfs_rq_list - 456) + 472
                 =3D rq->leaf_cfs_rq_list + 16
                 =3D rq->nr_uninterruptible        # now this mem location =
corresponds to nr_uninterruptible.

Since nr_uninterruptible is an integer rather than a de-referenceable point=
er, I presume because of
this, de-referencing parent from prev_cfs_rq->tg results in a crash. Otherw=
ise,
incorrect pointers are silently used without a visible failure.


But looks like a patch similar to this is merged yesterday [1], so this can
be ignored :)


[1] https://lore.kernel.org/all/174119292742.14745.16827644501260146974.tip=
-bot2@tip-bot2/

Thanks,
Aboorva


> > > ...
> > >=20
>=20


