Return-Path: <linux-kernel+bounces-298587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7940A95C91B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 11:20:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F66F1C22647
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 09:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 055C514A634;
	Fri, 23 Aug 2024 09:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Vhb35IvS"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 835E813C918
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 09:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724404815; cv=none; b=Kt0B/ZmP/Th8n9saZnPirPajRVcxnPYrV8TT2ars/tyErRUml2xxQyD6+9uC2R/jszDn8LMm0f2MgdljQ16fUvhpnAQzGo9lLEM/7pQcosHI/APUuJW3o1zAQL5cfLEN2mmZl/VJ4JhYF8C84m4FXYohaOe2wz7nKuaO+3mu+TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724404815; c=relaxed/simple;
	bh=HTWBX1On1OuTBnFEwzZRtEa1dUOX7E/XtzKEl3QuIGU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Mime-Version; b=DPgsX43hzkTITVl3O/xal/QzQrq4hZH9dHdY2PVqWaBmAwGv1pPJ9BS33NhINDPmTWyVcSgFOVwHc7fpJsD6+RvgL3HkGKxAdLxIXU8xoF3etvoKaxr5QYRBzuqfVrN4Kq0Tjo2BivS4HzkvIJNdfZFCp8wb7bijqp43XxGAFH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Vhb35IvS; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47N7cx0m011247;
	Fri, 23 Aug 2024 09:20:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:mime-version:content-transfer-encoding; s=pp1; bh=
	QpOZKAkolimJaval40IzxQ30xw9nekspEhc3u08JYhE=; b=Vhb35IvSmNzHLVRe
	jIx31tOTJ6wvts/HSv7Ar/WWv/3RS8HJbb/oJ/B48RkHwcqDKSP0NybqhwrjETJA
	WDjiv+Bn+9FvRepmEWkc3WdYX8onxhr0kGTcGOSzz7Gv30uypiXQxCGDrYcDzVN4
	uZSFc0/7d+R7iWRcQbK6TzuAY9K7n7I78+ElGd7ahSQ+Lb/0fuSW9PZ4HwhlgA3P
	iPmIKUu5Q+4ISpnBuHRhlEbM2c9pEQo7JGHq0jr+gk8iqlXVxP3P4DRFvqE4cQnc
	aADdEcvsp+k8OYNJMhyGppOOJqfYUbFTsy/IWa7KoaYN+poJSN6sUA2Mw+3vbUdU
	Rohh9A==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 412mc53a4t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Aug 2024 09:20:07 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 47N913kO030060;
	Fri, 23 Aug 2024 09:20:07 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4138dmrx62-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Aug 2024 09:20:07 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 47N9K4I729360818
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Aug 2024 09:20:06 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1A2E458056;
	Fri, 23 Aug 2024 09:20:04 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CA9235807B;
	Fri, 23 Aug 2024 09:20:02 +0000 (GMT)
Received: from li-34d1fccc-27cd-11b2-a85c-c167793e56f7.ibm.com (unknown [9.204.200.131])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 23 Aug 2024 09:20:02 +0000 (GMT)
Message-ID: <3da12c96daecaa055c478816f5e86c7b44a04d53.camel@linux.ibm.com>
Subject: Re: [sched_ext/for-6.11]: Issue with BPF Scheduler during CPU
 Hotplug
From: Aboorva Devarajan <aboorvad@linux.ibm.com>
To: Tejun Heo <tj@kernel.org>
Cc: void@manifault.com, linux-kernel@vger.kernel.org
Date: Fri, 23 Aug 2024 14:50:01 +0530
In-Reply-To: <ZsTwoWJQcnsJhYbe@slm.duckdns.org>
References: <8cd0ec0c4c7c1bc0119e61fbef0bee9d5e24022d.camel@linux.ibm.com>
	 <Zo3PgETt43iFersn@slm.duckdns.org>
	 <dde4b09001da2641f9679b9409727e2147c5e9a6.camel@linux.ibm.com>
	 <daf2370f5456cbf1660bbdc13621559fb3f2f6cc.camel@linux.ibm.com>
	 <Zq1NksrG9blyN-KR@slm.duckdns.org>
	 <e3069da05fb1676f8faad88b9a4dfc4a6cef4175.camel@linux.ibm.com>
	 <Zru5_UmEmWhNaPyo@slm.duckdns.org>
	 <fa56b39990dd0b90f971018f5abb7352c60af3b1.camel@linux.ibm.com>
	 <ZsTwoWJQcnsJhYbe@slm.duckdns.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-26.el8_10) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: O_j2lPzB1jZu0muOcKCAErQtYO6446AW
X-Proofpoint-GUID: O_j2lPzB1jZu0muOcKCAErQtYO6446AW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-23_06,2024-08-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 clxscore=1015 priorityscore=1501 mlxlogscore=999 adultscore=0 phishscore=0
 impostorscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408230065

On Tue, 2024-08-20 at 09:38 -1000, Tejun Heo wrote:
> On Tue, Aug 20, 2024 at 12:33:34PM +0530, Aboorva Devarajan wrote:
> > On Tue, 2024-08-13 at 09:54 -1000, Tejun Heo wrote:
> > > Hello,
> > > 
> > > On Sat, Aug 10, 2024 at 11:54:24PM +0530, Aboorva Devarajan wrote:
> > > ...
> I think this *should* fix the problem but it is rather ugly. The locking
> order is such that there's no good way out. Maybe the solution is making
> cpu_hotplug_disable() more useful. Anyways, can you test this one?
> 
> Thanks.
> 
> ---
>  kernel/sched/ext.c |   30 ++++++++++++++++++++++--------
>  1 file changed, 22 insertions(+), 8 deletions(-)
> 
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -3990,6 +3990,24 @@ static const char *scx_exit_reason(enum
>  	}
>  }
>  
> +static void block_fork_hotplug(void)
> +{
> +	while (true) {
> +		percpu_down_write(&scx_fork_rwsem);
> +		if (cpus_read_trylock())
> +			return;
> +		percpu_up_write(&scx_fork_rwsem);
> +		cpus_read_lock();
> +		cpus_read_unlock();
> +	}
> +}
> +
> +static void unblock_fork_hotplug(void)
> +{
> +	cpus_read_unlock();
> +	percpu_up_write(&scx_fork_rwsem);
> +}
> +
>  static void scx_ops_disable_workfn(struct kthread_work *work)
>  {
>  	struct scx_exit_info *ei = scx_exit_info;
> @@ -4045,8 +4063,7 @@ static void scx_ops_disable_workfn(struc
>  	 * Avoid racing against fork. See scx_ops_enable() for explanation on
>  	 * the locking order.
>  	 */
> -	percpu_down_write(&scx_fork_rwsem);
> -	cpus_read_lock();
> +	block_fork_hotplug();
>  
>  	spin_lock_irq(&scx_tasks_lock);
>  	scx_task_iter_init(&sti);
> @@ -4090,8 +4107,7 @@ static void scx_ops_disable_workfn(struc
>  	static_branch_disable_cpuslocked(&scx_builtin_idle_enabled);
>  	synchronize_rcu();
>  
> -	cpus_read_unlock();
> -	percpu_up_write(&scx_fork_rwsem);
> +	unblock_fork_hotplug();
>  
>  	if (ei->kind >= SCX_EXIT_ERROR) {
>  		pr_err("sched_ext: BPF scheduler \"%s\" disabled (%s)\n",
> @@ -4657,8 +4673,7 @@ static int scx_ops_enable(struct sched_e
>  	 *
>  	 *   scx_fork_rwsem --> pernet_ops_rwsem --> cpu_hotplug_lock
>  	 */
> -	percpu_down_write(&scx_fork_rwsem);
> -	cpus_read_lock();
> +	block_fork_hotplug();
>  
>  	check_hotplug_seq(ops);
>  
> @@ -4765,8 +4780,7 @@ static int scx_ops_enable(struct sched_e
>  
>  	spin_unlock_irq(&scx_tasks_lock);
>  	preempt_enable();
> -	cpus_read_unlock();
> -	percpu_up_write(&scx_fork_rwsem);
> +	unblock_fork_hotplug();
>  
>  	/* see above ENABLING transition for the explanation on exiting with 0 */
>  	if (!scx_ops_tryset_enable_state(SCX_OPS_ENABLED, SCX_OPS_ENABLING)) {

Hi Tejun,

I applied this patch to the almost latest sched-ext (for-6.12) branch upto
commit 89909296a51e792 ("sched_ext: Don't use double locking to migrate
tasks across CPUs") and let the test run for over 20 hours, and it completed
without any hangs on both x86 and PowerPC.

So, indeed, making sure that both scx_fork_rwsem and cpu_hotplug_lock (read)
are only held together simulataneously when they can both be acquired seems
to be resolving the deadlock.

Thanks,
Aboorva


