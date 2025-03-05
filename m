Return-Path: <linux-kernel+bounces-546542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B3D3A4FBEF
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 11:30:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99FCE3A8E86
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 10:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E17B7207656;
	Wed,  5 Mar 2025 10:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Q6UzoFVA"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A514E1D6DAA
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 10:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741170585; cv=none; b=gqY+DD5DgNONfyMCxuV3a7ta0bfyw3z9meB665DzQoYFCu46ATTETUL4oHujPP82jSSx0QUcK8pOLV/OLjN242JjLLm55hw7Nk7zclrBfVd+4LsYzig2K/YIEqav2eNr0MgnsVNU2ZeEK0mGya0mKvWbXFtf4f/J0ID26XaHyVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741170585; c=relaxed/simple;
	bh=/ssVLQjzkOF7veq0ROXGQInOSKc7khRxeWWrgBk0TQ4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jh5OatM+bXmXTL5dZC0NVg/euNlpiMgnunZFgAhJzfBEKvDW93ZIuhr3Tr2CoREbdft3GwynbT9CIZQYSKpLJ+Ze8P+HIjLMsOOgk+fw1GPFdTp2CH6rk8M/dTUhwIoOPIJlGGbhx8GOBIZ31ZvFm3XyuU1Y05cUTtTh6Aoqxnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Q6UzoFVA; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52524Ya8018845;
	Wed, 5 Mar 2025 10:29:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=/ssVLQ
	jzkOF7veq0ROXGQInOSKc7khRxeWWrgBk0TQ4=; b=Q6UzoFVATlWYQY9X5GKHKs
	Rl8OwH1UY2ySxslORXYMyGvTORe9XzsnYeHIhqhvRtUGrCebXRivDoe9u2b8V+fj
	BR0eZHipUOLzH6kjZk5SEygA1S85JAIaPtxS2NAnT3f+PAeNU3FIb9ia/gd7Y1/S
	XkIJfBH0R/hNgYj347I73aZ4ky96+BcZasq+xKzGqPzEbjjPtTMQ6fLk8vKgWXgN
	QQbS8oNgvSduMIIMN17KcIDl8a4oa3xwX+H01wQQ+qBWVzvo6IHKnbdqDI1OnQZs
	lB4+fx/6f57+krVMwKqkY1coLfESGSV58TDROWuXx0hVkBnBQPwwXmWyQ7WYCawQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4562xpmw7x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Mar 2025 10:29:02 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 525AAm9Z030868;
	Wed, 5 Mar 2025 10:29:01 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4562xpmw7v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Mar 2025 10:29:01 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5257eENd013784;
	Wed, 5 Mar 2025 10:29:00 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 454e2kt78x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Mar 2025 10:29:00 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 525ASx6D26608290
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Mar 2025 10:28:59 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 33C4A58054;
	Wed,  5 Mar 2025 10:28:59 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BCE705803F;
	Wed,  5 Mar 2025 10:28:54 +0000 (GMT)
Received: from li-c18b6acc-24ee-11b2-a85c-81492619bda1.ibm.com (unknown [9.124.217.27])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  5 Mar 2025 10:28:54 +0000 (GMT)
Message-ID: <2502514e7bf51b6466f8a2682170d7163e5f5250.camel@linux.ibm.com>
Subject: Re: [PATCH 1/1] sched/fair: Fix invalid pointer dereference in
 child_cfs_rq_on_list()
From: Aboorva Devarajan <aboorvad@linux.ibm.com>
To: Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Vincent Guittot
	 <vincent.guittot@linaro.org>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        riel@surriel.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, vschneid@redhat.com, odin@uged.al,
        linux-kernel@vger.kernel.org
Date: Wed, 05 Mar 2025 15:58:53 +0530
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
X-Proofpoint-ORIG-GUID: wCG1TqLXfsPia6sFl_1UdHC101xv7zNd
X-Proofpoint-GUID: t30njm51pL849fV-hY8jeRVerK2HWM6x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-05_04,2025-03-05_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 mlxlogscore=767 spamscore=0 bulkscore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 phishscore=0 mlxscore=0 impostorscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503050084

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

Hi Dietmar,

Thanks a lot for testing this,

I have sent an updated patch (v2) to fix this:
https://lore.kernel.org/all/20250305100854.318599-1-aboorvad@linux.ibm.com/

Can you try and see if v2 works for you?

>=20
> > > following trace:
> > >=20
> > > [=C2=A0=C2=A0=C2=A0 2.152852] Call Trace:
> > > [=C2=A0=C2=A0=C2=A0 2.152855] __update_blocked_fair+0x45c/0x6a0 (unre=
liable)
> > > [=C2=A0=C2=A0=C2=A0 2.152862] sched_balance_update_blocked_averages+0=
x11c/0x24c
> > > [=C2=A0=C2=A0=C2=A0 2.152869] sched_balance_softirq+0x60/0x9c
> > > [=C2=A0=C2=A0=C2=A0 2.152876] handle_softirqs+0x148/0x3b4
> > > [=C2=A0=C2=A0=C2=A0 2.152884] do_softirq_own_stack+0x40/0x54
> > > [=C2=A0=C2=A0=C2=A0 2.152891] __irq_exit_rcu+0x18c/0x1b4
> > > [=C2=A0=C2=A0=C2=A0 2.152897] irq_exit+0x20/0x38
> > > [=C2=A0=C2=A0=C2=A0 2.152903] timer_interrupt+0x174/0x30c
> > > [=C2=A0=C2=A0=C2=A0 2.152910] decrementer_common_virt+0x28c/0x290
> > > [=C2=A0=C2=A0=C2=A0 2.059873] systemd[1]: Hostname set to ...
> > > [=C2=A0=C2=A0=C2=A0 2.152682] BUG: Unable to handle kernel data acces=
s on read at 0x100000125
> > > [=C2=A0=C2=A0=C2=A0 2.152717] Faulting instruction address: 0xc000000=
0001c0270
> > > [=C2=A0=C2=A0=C2=A0 2.152724] Oops: Kernel access of bad area, sig: 7=
 [#1]
> > > ..
> > >=20
> > > To fix this, introduce a check to detect when prev points to the list=
 head
> > > (&rq->leaf_cfs_rq_list). If this condition is met, return early to pr=
event
> > > the use of an invalid prev_cfs_rq.
> > >=20
> > > Fixes: fdaba61ef8a2 ("sched/fair: Ensure that the CFS parent is added=
 after unthrottling")
> > > Signed-off-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
> > > ---
> > > =C2=A0kernel/sched/fair.c | 7 +++++--
> > > =C2=A01 file changed, 5 insertions(+), 2 deletions(-)
> > >=20
> > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > index 1c0ef435a7aa..a4daa7a9af0b 100644
> > > --- a/kernel/sched/fair.c
> > > +++ b/kernel/sched/fair.c
> > > @@ -4045,12 +4045,15 @@ static inline bool child_cfs_rq_on_list(struc=
t cfs_rq *cfs_rq)
> > > =C2=A0{
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct cfs_rq *prev_cfs_rq=
;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct list_head *prev;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct rq *rq;
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rq =3D rq_of(cfs_rq);
> > >=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (cfs_rq->on_list) {
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 prev =3D cfs_rq->leaf_cfs_rq_list.prev;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 if (prev =3D=3D &rq->leaf_cfs_rq_list)
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return f=
alse;
> >=20
> > what about the else case below , prev can also point to rq->leaf_cfs_rq=
_list
>=20
> Should be the same issue IMHO. I'm not seeing it on my machine=C2=A0 duri=
ng
> startup or while doing simple taskgroup tests though, 'cfs_rq->on_list'
> is always 1 so far.
>=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 struct rq *rq =3D rq_of(cfs_rq);
> > > -
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 prev =3D rq->tmp_alone_branch;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > >=20
> > > --
> > > 2.43.5
> > >=20
>=20

Regards,
Aboorva

