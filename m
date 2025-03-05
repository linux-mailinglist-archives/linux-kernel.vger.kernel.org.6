Return-Path: <linux-kernel+bounces-546522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 804C9A4FBA9
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 11:20:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 770B116BE6E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 10:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 096AC207650;
	Wed,  5 Mar 2025 10:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="MV92NERB"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B58F92063E9
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 10:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741169981; cv=none; b=pmn7UDqkgwXJJFKrIPqsWy98OCIKNJ3tjOpyD/JN7OZbUSgQ2OTU/+lv2wfwPCtoDW/vTA+jHhULAXERuUrMdvtnILpErgWZgEOB7JLxPeVlTDeyOeJ5FKWjG0YB97Hpy7hxXAYobtmja8Z3IBGrvAGQGGpd06CJZOPQMc0bJLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741169981; c=relaxed/simple;
	bh=SSBDIEfPeXh82clN1D5tFERRBr2G/lupGUTvkI7+IiE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LNfZsIDy+WOpeyUvvLymrLOkuHM4pvM3BqVe+BgWIu3B1Fucnjv6u/OE4xh5aBA6EDzJeK1kocs5jqGvedwU70gnkp1M1itze/nlY8TMDagVGWLRM6Y8MtPsf7RT2m5OpYehjv6sjur41NwufGdKsiw3ZcDpTMW+G+HIJNMjuhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=MV92NERB; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 524L7PdH006698;
	Wed, 5 Mar 2025 10:18:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=SSBDIE
	fPeXh82clN1D5tFERRBr2G/lupGUTvkI7+IiE=; b=MV92NERBvwhHDqMhgdPfwi
	808UFzFrjEmd+t6u96F4I66jodOktRoXdi5Anob+lGhdsJtQQqCQOApcUOHm1cFM
	DGZeRXwppVZiJFFD7fE9edKvqMtFnCnIPhAUV8ORnJbTcudXnj5dwhDmRv4eYktN
	jclGKDPABRPyaB+ZEkD4i5Ugt0p6PIHdgUrBfiSdQfl549KFUymqODv8saf17/li
	8DQbrQvax/hCYa4kEtHOxSw0Cc4LYmkjb9yeTiqEVnOjaDQO0uAUwWASr/Wg6LiW
	/bnm2KNc787aJK1Chur2GnVqnhQ+UC1xlDZwQB3MSPZWqB2AEJ5tuiFix/pdKuXA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4561j359nm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Mar 2025 10:18:33 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 525A4Jcu027334;
	Wed, 5 Mar 2025 10:18:32 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4561j359ng-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Mar 2025 10:18:32 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52594DkB025016;
	Wed, 5 Mar 2025 10:18:31 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 454f921tx2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Mar 2025 10:18:31 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 525AIVwf21758696
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Mar 2025 10:18:31 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3585F58053;
	Wed,  5 Mar 2025 10:18:31 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E6F1758043;
	Wed,  5 Mar 2025 10:18:26 +0000 (GMT)
Received: from li-c18b6acc-24ee-11b2-a85c-81492619bda1.ibm.com (unknown [9.124.217.27])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  5 Mar 2025 10:18:26 +0000 (GMT)
Message-ID: <7bb9f62885d138658c853d9c915f15438ba3755a.camel@linux.ibm.com>
Subject: Re: [PATCH 1/1] sched/fair: Fix invalid pointer dereference in
 child_cfs_rq_on_list()
From: Aboorva Devarajan <aboorvad@linux.ibm.com>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        riel@surriel.com, dietmar.eggemann@arm.com, rostedt@goodmis.org,
        bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, odin@uged.al,
        linux-kernel@vger.kernel.org
Date: Wed, 05 Mar 2025 15:48:25 +0530
In-Reply-To: <CAKfTPtCJKkwFeMKUrD3o224Nz4N+1qjtq0LvL945k9tJ8t8h-g@mail.gmail.com>
References: <20250304170007.245261-1-aboorvad@linux.ibm.com>
	 <CAKfTPtCJKkwFeMKUrD3o224Nz4N+1qjtq0LvL945k9tJ8t8h-g@mail.gmail.com>
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
X-Proofpoint-GUID: Z-Tt4-kHBBT7OrXSP28ffX_HvOJljjTg
X-Proofpoint-ORIG-GUID: f7srMis_UZdL6OHo7e5luS9UI3vpvU-g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-05_03,2025-03-05_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 spamscore=0 mlxlogscore=421 phishscore=0 clxscore=1015
 priorityscore=1501 adultscore=0 mlxscore=0 bulkscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503050079

On Wed, 2025-03-05 at 09:21 +0100, Vincent Guittot wrote:
> On Tue, 4 Mar 2025 at 18:00, Aboorva Devarajan <aboorvad@linux.ibm.com> w=
rote:
> >=20
> > In child_cfs_rq_on_list(), leaf_cfs_rq_list.prev is expected to point t=
o
> > a valid cfs_rq->leaf_cfs_rq_list in the hierarchy. However, when access=
ed
> > from the first node in a list, leaf_cfs_rq_list.prev can incorrectly po=
int
> > back to the list head (rq->leaf_cfs_rq_list) instead of another
> > cfs_rq->leaf_cfs_rq_list.
> >=20
> > The function does not handle this case, leading to incorrect pointer
> > calculations and unintended memory accesses, which can result in a kern=
el
> > crash.
> >=20
> > A recent attempt to reorder fields in struct rq exposed this issue by
> > modifying memory offsets and affecting how pointer computations are
> > resolved. While the problem existed before, it was previously masked by
> > specific field arrangement. The reordering caused erroneous pointer
> > accesses, leading to a NULL dereference and a crash, as seen in the
> > following trace:
> >=20
> > [=C2=A0=C2=A0=C2=A0 2.152852] Call Trace:
> > [=C2=A0=C2=A0=C2=A0 2.152855] __update_blocked_fair+0x45c/0x6a0 (unreli=
able)
> > [=C2=A0=C2=A0=C2=A0 2.152862] sched_balance_update_blocked_averages+0x1=
1c/0x24c
> > [=C2=A0=C2=A0=C2=A0 2.152869] sched_balance_softirq+0x60/0x9c
> > [=C2=A0=C2=A0=C2=A0 2.152876] handle_softirqs+0x148/0x3b4
> > [=C2=A0=C2=A0=C2=A0 2.152884] do_softirq_own_stack+0x40/0x54
> > [=C2=A0=C2=A0=C2=A0 2.152891] __irq_exit_rcu+0x18c/0x1b4
> > [=C2=A0=C2=A0=C2=A0 2.152897] irq_exit+0x20/0x38
> > [=C2=A0=C2=A0=C2=A0 2.152903] timer_interrupt+0x174/0x30c
> > [=C2=A0=C2=A0=C2=A0 2.152910] decrementer_common_virt+0x28c/0x290
> > [=C2=A0=C2=A0=C2=A0 2.059873] systemd[1]: Hostname set to ...
> > [=C2=A0=C2=A0=C2=A0 2.152682] BUG: Unable to handle kernel data access =
on read at 0x100000125
> > [=C2=A0=C2=A0=C2=A0 2.152717] Faulting instruction address: 0xc00000000=
01c0270
> > [=C2=A0=C2=A0=C2=A0 2.152724] Oops: Kernel access of bad area, sig: 7 [=
#1]
> > ..
> >=20
> > To fix this, introduce a check to detect when prev points to the list h=
ead
> > (&rq->leaf_cfs_rq_list). If this condition is met, return early to prev=
ent
> > the use of an invalid prev_cfs_rq.
> >=20
> > Fixes: fdaba61ef8a2 ("sched/fair: Ensure that the CFS parent is added a=
fter unthrottling")
> > Signed-off-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
> > ---
> > =C2=A0kernel/sched/fair.c | 7 +++++--
> > =C2=A01 file changed, 5 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 1c0ef435a7aa..a4daa7a9af0b 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -4045,12 +4045,15 @@ static inline bool child_cfs_rq_on_list(struct =
cfs_rq *cfs_rq)
> > =C2=A0{
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct cfs_rq *prev_cfs_rq;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct list_head *prev;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct rq *rq;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rq =3D rq_of(cfs_rq);
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (cfs_rq->on_list) {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 prev =3D cfs_rq->leaf_cfs_rq_list.prev;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 if (prev =3D=3D &rq->leaf_cfs_rq_list)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return fals=
e;
>=20
> what about the else case below , prev can also point to rq->leaf_cfs_rq_l=
ist

Hi Vincent,

Thanks for the comments, yes indeed `rq->tmp_alone_branch` canpoint to `rq-=
>leaf_cfs_rq_list`

I overlooked this and assumed that as long as we have at least one cfs_rq, =
tmp_alone_branch
would always point to a valid list node (cfs_rq->leaf_cfs_rq_list).

I will send a v2 with the changes to carry out the correctness check uncond=
itionally.


> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 struct rq *rq =3D rq_of(cfs_rq);
> > -
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 prev =3D rq->tmp_alone_branch;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> >=20
> > --
> > 2.43.5
> >=20

- Aboorva

