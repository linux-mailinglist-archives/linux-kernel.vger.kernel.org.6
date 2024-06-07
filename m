Return-Path: <linux-kernel+bounces-205785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 30116900040
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 12:06:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A60751F24E48
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 10:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C160E15DBCB;
	Fri,  7 Jun 2024 10:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NykTiRTj"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2282823B8
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 10:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717754597; cv=none; b=Qe/Toc2ySBaUpWFOBCHpuMdARBbeylaQ3AomOhDSqoMY31RJGfruhZ2y1YQkJQ47ERsYsnN6AuDmh/53mb81N3GkUH63boWBHYNJBcDnnS8nDL4nsnSBbAXn64rQbXOboUKM5Vmdou89212GdOBhpGdyMyuZjhVhAB2fKZ1WwbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717754597; c=relaxed/simple;
	bh=y02b5KYECeWLBu5jGK71rFZC+WDrFSOF6tVbkbzDj5w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BL1QURO6tix2nB8pkhdXFePJrYgLWyxMITUTICoriksPr5W8heschFcpJIUTPTWGYu6ShlW8m4Hdc/wBVqhRp4oGA1vUoQ5nFl7ZQ8aOE1XnuEmMKYqB7wnj3jb3whH6p3Yr3awT+uDp0tuGZS5lPUe8zJ78YwEI8I72pzZmD0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=NykTiRTj; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4579p4P6025828;
	Fri, 7 Jun 2024 10:02:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc :
 content-transfer-encoding : content-type : date : from : in-reply-to :
 message-id : mime-version : references : subject : to; s=pp1;
 bh=E+DpHxmsQyuCrV2x6Tk/IH+OZ8L64f2OQiZR8iVLi8w=;
 b=NykTiRTjH8d30w+GFXNTAGLEMcucYfTv8Uad9sorKVJ9P0/uKDYhdziPs2lPnEnmTZal
 u9gJznqRq1j18sqdU4nBUiO5F6d2pxAOHuLbWmKFOAPzyK5Tm4R1ln6bYy63+Rb+cZ/N
 mBZpl2NceqiU8vRtrjtXkphxs1kr8NugdyfqG6sBtcGKcLPKSMQLAzlXkof4AzQEs2oq
 Kt9rsdG3/6xfnmQFnrsWvhVq0j3bhq2nTQAw3cwQuaLX3v9PfhFlwDcQisVnOYHoGPPN
 SPSzE4A0PfZJ9JfDUZxP3oAi9diyrFSpclvKBb/a3OwRic+9Z4+437anGt4vmZIxvVY5 oQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ykyc6g386-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Jun 2024 10:02:54 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 457A2rkj014150;
	Fri, 7 Jun 2024 10:02:53 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ykyc6g382-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Jun 2024 10:02:53 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 4578GMsd000829;
	Fri, 7 Jun 2024 10:02:52 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3ygdyug8au-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Jun 2024 10:02:52 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 457A2nxl43516382
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 7 Jun 2024 10:02:51 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3187620097;
	Fri,  7 Jun 2024 10:02:46 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 82B042009A;
	Fri,  7 Jun 2024 10:02:43 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.109.219.153])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri,  7 Jun 2024 10:02:43 +0000 (GMT)
Date: Fri, 7 Jun 2024 15:32:36 +0530
From: Saket Kumar Bhaskar <skb99@linux.ibm.com>
To: Xuewen Yan <xuewen.yan@unisoc.com>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, longman@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        ke.wang@unisoc.com, xuewen.yan94@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] sched: Clear user_cpus_ptr only when no intersection
 with the new mask
Message-ID: <ZmLavE/tO66VUP3D@linux.ibm.com>
References: <20240507072242.585-1-xuewen.yan@unisoc.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240507072242.585-1-xuewen.yan@unisoc.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: j7KcT9BH4DEQHlf-4aY5S5tPUFrx4ksW
X-Proofpoint-ORIG-GUID: 7VDtokbxprUkQ1JQqU_6VZkTxU5eWc3x
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-07_04,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 adultscore=0
 spamscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 bulkscore=0 mlxscore=0 suspectscore=0 clxscore=1011 impostorscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2406070072

On Tue, May 07, 2024 at 03:22:42PM +0800, Xuewen Yan wrote:
> The commit 851a723e45d1c("sched: Always clear user_cpus_ptr in do_set_cpu=
s_allowed()")
> would cause that online/offline cpu will produce different results
> for the !top-cpuset task.
> For example:
>=20
> If the task was running, then offline task's cpus, would lead to clear
> its user-mask.
>=20
> unisoc:/ # while true; do sleep 600; done&
> [1] 6786
> unisoc:/ # echo 6786 > /dev/cpuset/top-app/tasks
> unisoc:/ # cat /dev/cpuset/top-app/cpus
> 0-7
> unisoc:/ # cat /proc/6786/status | grep Cpus
> Cpus_allowed:   ff
> Cpus_allowed_list:      0-7
>=20
> unisoc:/ # taskset -p c0 6786
> pid 6786's current affinity mask: ff
> pid 6786's new affinity mask: c0
> unisoc:/ # cat /proc/6786/status | grep Cpus
> Cpus_allowed:   c0
> Cpus_allowed_list:      6-7
>=20
> After offline the cpu6 and cpu7, the user-mask would be cleared:
>=20
> unisoc:/ # echo 0 > /sys/devices/system/cpu/cpu7/online
> unisoc:/ # cat /proc/6786/status | grep Cpus
> Cpus_allowed:   40
> Cpus_allowed_list:      6
> ums9621_1h10:/ # echo 0 > /sys/devices/system/cpu/cpu6/online
> ums9621_1h10:/ # cat /proc/6786/status | grep Cpus
> Cpus_allowed:   3f
> Cpus_allowed_list:      0-5
>=20
> When online the cpu6/7, the user-mask can not bring back:
>=20
> unisoc:/ # echo 1 > /sys/devices/system/cpu/cpu6/online
> unisoc:/ # echo 1 > /sys/devices/system/cpu/cpu7/online
> unisoc:/ # cat /proc/6786/status | grep Cpus
> Cpus_allowed:   ff
> Cpus_allowed_list:      0-6
>=20
> However, if we offline the cpu when the task is sleeping, at this
> time, because would not call the fallback_cpu(), its user-mask will
> not be cleared.
>=20
> unisoc:/ # while true; do sleep 600; done&
> [1] 5990
> unisoc:/ # echo 5990 > /dev/cpuset/top-app/tasks
> unisoc:/ # cat /proc/5990/status | grep Cpus
> Cpus_allowed:   ff
> Cpus_allowed_list:      0-7
>=20
> unisoc:/ # taskset -p c0 5990
> pid 5990's current affinity mask: ff
> pid 5990's new affinity mask: c0
> unisoc:/ # cat /proc/5990/status | grep Cpus
> Cpus_allowed:   c0
> Cpus_allowed_list:      6-7
>=20
> unisoc:/ # echo 0 > /sys/devices/system/cpu/cpu6/online
> unisoc:/ # cat /proc/5990/status | grep Cpus
> Cpus_allowed:   80
> Cpus_allowed_list:      7
> unisoc:/ # echo 0 > /sys/devices/system/cpu/cpu7/online
> unisoc:/ # cat /proc/5990/status | grep Cpus
> Cpus_allowed:   3f
> Cpus_allowed_list:      0-5
>=20
> After 10 minutes, it was waked up, it can also keep its user-mask:
> ums9621_1h10:/ # cat /proc/5990/status | grep Cpus
> Cpus_allowed:   3f
> Cpus_allowed_list:      0-5
>=20
> And when online the cpu6/7,the user-mask could bring back.
> unisoc:/ # echo 1 > /sys/devices/system/cpu/cpu6/online
> unisoc:/ # echo 1 > /sys/devices/system/cpu/cpu7/online
> unisoc:/ # cat /proc/6786/status | grep Cpus
> Cpus_allowed:   c0
> Cpus_allowed_list:      6-7
>=20
> Indeed, there is no need to clear the user_cpus_ptr if there is an
> intersection between user_cpus_ptr and new_mask.
> So add the judgement of whether there is an intersection between them.
> Clear user_cpus_ptr only when no intersection with the new mask.
> In this way, the above problems can also be solved.
>=20
> Suggested-by: Waiman Long <longman@redhat.com>
> Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
> ---
> previous discussion:
>  https://lore.kernel.org/all/e402d623-1875-47a2-9db3-8299a54502ef@redhat.=
com/
> ---
>  kernel/sched/core.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>=20
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 7019a40457a6..bbb8e88949f4 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -2796,21 +2796,24 @@ __do_set_cpus_allowed(struct task_struct *p, stru=
ct affinity_context *ctx)
>  }
>=20=20
>  /*
> - * Used for kthread_bind() and select_fallback_rq(), in both cases the u=
ser
> - * affinity (if any) should be destroyed too.
> + * Used for kthread_bind() and select_fallback_rq().
> + * Destroy user affinity if no intersection with the new_mask.
>   */
>  void do_set_cpus_allowed(struct task_struct *p, const struct cpumask *ne=
w_mask)
>  {
>  	struct affinity_context ac =3D {
>  		.new_mask  =3D new_mask,
>  		.user_mask =3D NULL,
> -		.flags     =3D SCA_USER,	/* clear the user requested mask */
> +		.flags     =3D 0,
>  	};
>  	union cpumask_rcuhead {
>  		cpumask_t cpumask;
>  		struct rcu_head rcu;
>  	};
>=20=20
> +	if (p->user_cpus_ptr && !cpumask_intersects(p->user_cpus_ptr, new_mask))
> +		ac.flags =3D SCA_USER;	/* clear the user requested mask */
> +
>  	__do_set_cpus_allowed(p, &ac);
>=20=20
>  	/*
> --=20
> 2.25.1
>=20

Hi Xuewen,

I have a query here:

1. From the example where task is running, " while true; do sleep 600; done=
& "
   is being used, which is a sleeping task. How running task is emulated he=
re?

2. Tried without patch (6.9.0-rc4) on a 64 CPUs system. Results are:
=20=20=20
   For a task that is running:

   # stress-ng -l 100 --cpu 1
   stress-ng: info:  [2307] defaulting to a 86400 second (1 day, 0.00 secs)=
 run per stressor
   stress-ng: info:  [2307] dispatching hogs: 1 cpu
=20=20=20
   #taskset -p c0 2308
   pid 2308's current affinity mask: ffffffffffffffff
   pid 2308's new affinity mask: c0
=20=20=20
   # cat /proc/2308/status |grep Cpus
   Cpus_allowed:	00000000,000000c0
   Cpus_allowed_list:	6-7
=20=20=20
   #chcpu -d 6,7
   CPU 6 disabled
   CPU 7 disabled
=20=20=20
   After disabling CPUs 6 and 7:

   # cat /proc/2308/status |grep Cpus
   Cpus_allowed:	ffffffff,ffffffff
   Cpus_allowed_list:	0-63

   After enabling CPUs 6 and 7:

   ## chcpu -e 6,7
   CPU 6 enabled
   CPU 7 enabled
=20=20=20
   # cat /proc/2308/status |grep Cpus
   Cpus_allowed:	ffffffff,ffffffff
   Cpus_allowed_list:	0-63

   From the above output, after disabling CPUs 6 and 7, all the CPUs in the
   system are displayed rather than showing only remaining online CPUs(as=20
   shown in above example).

   For a task that is sleeping:

   # while true; do sleep 60; done&
   [1] 2541
=20=20=20
   # taskset -p c0 2541
   pid 2541's current affinity mask: ffffffffffffffff
   pid 2541's new affinity mask: c0
=20=20=20
   # cat /proc/2541/status |grep Cpus
   Cpus_allowed:	00000000,000000c0
   Cpus_allowed_list:	6-7
=20
   After disabling CPUs 6 and 7:
=20=20
   # chcpu -d 6,7
   CPU 6 disabled
   CPU 7 disabled

   # cat /proc/2541/status |grep Cpus
   Cpus_allowed:	00000000,000000c0
   Cpus_allowed_list:	6-7
=20=20=20
   After 1 minute:

   # cat /proc/2541/status |grep Cpus
   Cpus_allowed:	ffffffff,ffffffff
   Cpus_allowed_list:	0-63
=20=20=20
   # chcpu -e 6,7
   CPU 6 enabled
   CPU 7 enabled
=20=20=20
   # cat /proc/2541/status |grep Cpus
   Cpus_allowed:	ffffffff,ffffffff
   Cpus_allowed_list:	0-63

   From the above output, after disabling CPUs 6 and 7, it waked up after=20
   1 minute and Cpus_allowed_list got changed to 0-63 (which is contrary=20
   to the above example).

   So, there is some deviation in behaviour seen without the patch,=20
   than reported or am I missing something?

Thanks and regards,
Saket Kumar Bhaskar

