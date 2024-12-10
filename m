Return-Path: <linux-kernel+bounces-439866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48AF29EB52D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 16:38:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EDA01884AB7
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 15:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8E801BAED6;
	Tue, 10 Dec 2024 15:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WGIyULlx"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E08F1ABEC9
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 15:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733845113; cv=none; b=A8ozBARsAhO8N9o/DwNqjkuZ30xtd6jDXE2SsMZGS0hn9LJyVp0LXRXHH4Yh8Yb0ETy0pIeLG/2qvevjb7n/SwAIXUO3tdTOeF0F20tYsJixYaFCZzriv4kZ/BW+7ZgJ5iXw2xOrVi0gVBcu82SoyrULG8eoC/cHN8H5+1E/VO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733845113; c=relaxed/simple;
	bh=qkaUXye/Hr5o5ZH8Q4e48YdxLYD++aU6miyQ6jV7+w4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S9PUBwVjsCXfXPLLZowpUI6NmG4omm1pLJiTNquGRUvz8CYCaOYyWXGa5io2oxd09JRxITWbRA6MEnqQsNxzHApSIQ9ZGJTLd57Co2vryTuoGHWKgVlYCix6fSylswYzpyG0twVTXLOt8hCoXOPAGCEJm/GWYVAolZ1pRyIGzng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WGIyULlx; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BADrZOr003958;
	Tue, 10 Dec 2024 15:38:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=LlQJnl
	AfY7TdEgoNcgk9Xd91+IFa/vN6ToMLC6Qp194=; b=WGIyULlx7jsJA1747TYh2b
	WW5VIdoSMnOjLFFlUHBYgDypmfjEr5hLxjIxJi2Z4eaTgFQGCQC1j6ttfsgfE1/t
	i60VXYtKCebT6VPxu5xODhIeYNewA5aQe5oJDAdgr4Cymx6UGroSgEtG7RRgb6GT
	BLNX6NrE0D0C5NJcsXTmgjH+5cWK7xSDHkQj308eWnHsW7X2rQGhtmeOuaOFEH6K
	dnPeOh0j09GEUxV9jSN4iFU8kZ+dCrC9V4tcnBZYgoIJd674jfYS+GyfrVtKMoER
	SQvJ77POfEklxMxxj+zt4KwAtvmKTzY3BCev1RF1KtXAfppb39GFuNNLRJEdwS6g
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43ce0xetk9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Dec 2024 15:38:12 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4BAFTLAX026294;
	Tue, 10 Dec 2024 15:38:11 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43ce0xetk6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Dec 2024 15:38:11 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BADNnQR017428;
	Tue, 10 Dec 2024 15:38:11 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 43d3d1kvnp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Dec 2024 15:38:11 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BAFc7nA64487848
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Dec 2024 15:38:07 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 84ADE20043;
	Tue, 10 Dec 2024 15:38:07 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2B24020040;
	Tue, 10 Dec 2024 15:38:04 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.124.213.186])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 10 Dec 2024 15:38:03 +0000 (GMT)
Date: Tue, 10 Dec 2024 21:08:01 +0530
From: Vishal Chourasia <vishalc@linux.ibm.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        vschneid@redhat.com, sshegde@linux.ibm.com, srikar@linux.ibm.com,
        vineethr@linux.ibm.com, zhangqiao22@huawei.com
Subject: Re: [PATCH v3] sched/fair: Fix CPU bandwidth limit bypass during CPU
 hotplug
Message-ID: <Z1hgWWpGjqFNxtjg@linux.ibm.com>
References: <20241210102346.228663-2-vishalc@linux.ibm.com>
 <20241210144307.GV35539@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241210144307.GV35539@noisy.programming.kicks-ass.net>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: xZPT2nQvk1JpDzvZqJH7MiJ4pWE_KcOm
X-Proofpoint-ORIG-GUID: r4ekgwlTMMgriDbZ47kbTOts6t-hJ0M5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 clxscore=1015 impostorscore=0 mlxscore=0 mlxlogscore=999
 priorityscore=1501 malwarescore=0 adultscore=0 bulkscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412100115

On Tue, Dec 10, 2024 at 03:43:07PM +0100, Peter Zijlstra wrote:
> On Tue, Dec 10, 2024 at 03:53:47PM +0530, Vishal Chourasia wrote:
> > CPU controller limits are not properly enforced during CPU hotplug
> > operations, particularly during CPU offline. When a CPU goes offline,
> > throttled processes are unintentionally being unthrottled across all CPUs
> > in the system, allowing them to exceed their assigned quota limits.
> > 
> > Consider below for an example,
> > 
> > Assigning 6.25% bandwidth limit to a cgroup
> > in a 8 CPU system, where, workload is running 8 threads for 20 seconds at
> > 100% CPU utilization, expected (user+sys) time = 10 seconds.
> > 
> > $ cat /sys/fs/cgroup/test/cpu.max
> > 50000 100000
> > 
> > $ ./ebizzy -t 8 -S 20        // non-hotplug case
> > real 20.00 s
> > user 10.81 s                 // intended behaviour
> > sys   0.00 s
> > 
> > $ ./ebizzy -t 8 -S 20        // hotplug case
> > real 20.00 s
> > user 14.43 s                 // Workload is able to run for 14 secs
> > sys   0.00 s                 // when it should have only run for 10 secs
> > 
> > During CPU hotplug, scheduler domains are rebuilt and cpu_attach_domain
> > is called for every active CPU to update the root domain. That ends up
> > calling rq_offline_fair which un-throttles any throttled hierarchies.
> > 
> > Unthrottling should only occur for the CPU being hotplugged to allow its
> > throttled processes to become runnable and get migrated to other CPUs.
> > 
> > With current patch applied,
> > $ ./ebizzy -t 8 -S 20        // hotplug case
> > real 21.00 s
> > user 10.16 s                 // intended behaviour
> > sys   0.00 s
> > 
> > Note: hotplug operation (online, offline) was performed in while(1) loop
> > 
> > Signed-off-by: Vishal Chourasia <vishalc@linux.ibm.com>
> > Tested-by: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
> 
> Did you mean this?
Yes, essentially this.
I will post another version.


>·· 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 2c4ebfc82917..b6afb8337e73 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6696,6 +6696,9 @@ static void __maybe_unused unthrottle_offline_cfs_rqs(struct rq *rq)
>  
>  	lockdep_assert_rq_held(rq);
>  
> +	if (cpumask_test_cpu(cpu_of(rq), cpu_active_mask))
> +		return;
> +
>  	/*
>  	 * The rq clock has already been updated in the
>  	 * set_rq_offline(), so we should skip updating


What should be done for the case when the hotplugged CPU's cfs_rq has
plenty of runtime_remaining?

I have three choices
1) set it to 1 (no change required in current code)
2) skip reset, runtime_remaining will not be touched (similar to current patch)
3) return excess runtime to the global runtime (will require taking lock)

Thanks
- vishalc



