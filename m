Return-Path: <linux-kernel+bounces-310255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CDC6967712
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 16:26:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CB37281D06
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 14:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86FEE18132F;
	Sun,  1 Sep 2024 14:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VWU9iWS9"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991D123AB
	for <linux-kernel@vger.kernel.org>; Sun,  1 Sep 2024 14:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725200806; cv=none; b=IbggydfZPANapmpCYn3ptOGfUqFrKoB0vJIYUYd8LYxMxqKD9bBE6pSPb9BHNu9MdlWlvF12+QMPgFKznkejkU2FB4Eh9mOUXv+s3h//AXwXtbH+J8JGMffZhaJR6DBP/UTLuugI/3NS/omHgGUERARtdMB6Vcl/cZTIbHRmO3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725200806; c=relaxed/simple;
	bh=5tkOh9Mr+FDiVR2Br/fv2eu3xB3uJlL+YSg4mxuYCJE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Th6grLsr6PlXXK6gL4TIv084wD80kvhp1sGJCvXPeu99KYQ98AuCRtgCxY9W/xiu4rj5Ym9UdI1GEkKU4QjbJvwNf+dptF191YOnxQ0yLsU4ArBRKAnPMrrSxOhoIz+1FujNKJBi2+v5JVinVM2ZK4r3Drez2ZVXA/FML1J6UAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=VWU9iWS9; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47VMTC6n002312;
	Sun, 1 Sep 2024 14:25:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:subject:to:cc:references:reply-to
	:from:in-reply-to:content-type:content-transfer-encoding; s=pp1;
	 bh=BEQB3l9SYwu4WAUshnmcC9Ae+9yNAMi2AdQ0YNnc8mU=; b=VWU9iWS9/354
	tEIEYAt1oQxESssDo5PWPYEfw376qKwtIkuIhWZse4hHaTj7WweaawRpbDtpCJ7s
	/QhXKVUnV/O/RBLkGwekQsMoSI8RCm4BjvQ5ZJEzPL3/yslecr5LPFdSFf8iieOg
	sS8vnAtXJ4e2y+9bk5iUCdLy16is2vAegUzpMNNesDfz/aHVgu8zUi6FnWWbdKje
	YryCgGZjHjuq67wZYfnDmReN4aA7U+LA+8hSquyafYE7JW+HnoTW8mBZRty3xqk9
	VmAQiXIpm0duYhRzEflZdWUCbD+NYjzDUvowHwesb4JSVf3SZJmlUnoa1CE6SsXh
	JbSZ4/uYng==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41btp953ws-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 01 Sep 2024 14:25:56 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 481EPtpD030557;
	Sun, 1 Sep 2024 14:25:55 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41btp953wp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 01 Sep 2024 14:25:55 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 481ANJfa000438;
	Sun, 1 Sep 2024 14:25:54 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 41cdguadta-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 01 Sep 2024 14:25:54 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 481EPsZw48234904
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 1 Sep 2024 14:25:54 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0F6B058053;
	Sun,  1 Sep 2024 14:25:54 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5BA2B58043;
	Sun,  1 Sep 2024 14:25:48 +0000 (GMT)
Received: from [9.43.44.227] (unknown [9.43.44.227])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Sun,  1 Sep 2024 14:25:47 +0000 (GMT)
Message-ID: <e915c024-9a53-4736-9194-988e5cdd06a3@linux.ibm.com>
Date: Sun, 1 Sep 2024 19:55:46 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched: fix warning in sched_setaffinity
To: Josh Don <joshdon@google.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org, Waiman Long <longman@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Madadi Vineeth Reddy <vineethr@linux.ibm.com>
References: <20240829220427.2764399-1-joshdon@google.com>
Content-Language: en-US
Reply-To: 20240829220427.2764399-1-joshdon@google.com
From: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
In-Reply-To: <20240829220427.2764399-1-joshdon@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: NQUWdtvcZfHOjS03YzmNEs7LiK3DZW91
X-Proofpoint-ORIG-GUID: Yg26Q_1WRyq-RQmbsekXNGfUcxt13sJx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-09-01_02,2024-08-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0 spamscore=0
 malwarescore=0 mlxlogscore=999 adultscore=0 mlxscore=0 suspectscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2409010120

Hi Josh Don,

On 30/08/24 03:34, Josh Don wrote:
> Commit 8f9ea86fdf99b added some logic to sched_setaffinity that included
> a WARN when a per-task affinity assignment races with a cpuset update.
> 
> Specifically, we can have a race where a cpuset update results in the
> task affinity no longer being a subset of the cpuset. That's fine; we
> have a fallback to instead use the cpuset mask. However, we have a WARN
> set up that will trigger if the cpuset mask has no overlap at all with
> the requested task affinity. This shouldn't be a warning condition; its
> trivial to create this condition.
> 
> Reproduced the warning by the following setup:
> 
> - $PID inside a cpuset cgroup
> - another thread repeatedly switching the cpuset cpus from 1-2 to just 1
> - another thread repeatedly setting the $PID affinity (via taskset) to 2
> 

I was testing the patch using the following two scripts run concurrently:

Script 1:
while true; do
    echo 1 > /sys/fs/cgroup/test_group/cpuset.cpus;
    echo 1-2 > /sys/fs/cgroup/test_group/cpuset.cpus;
done

Script 2:
while true; do
    sudo taskset -p 0x2 $$;
done

However, I am unable to trigger the warning in dmesg on the unpatched kernel.
I was expecting to see the warning as described, but it doesn't seem to appear.

Additionally, I also tried the following script to increase the chances of
triggering the race condition:

while true; do
    echo 1 > /sys/fs/cgroup/test_group/cpuset.cpus;
    sudo taskset -p 0x2 $$;
    sleep 0.1;
    echo 1-2 > /sys/fs/cgroup/test_group/cpuset.cpus;
done

Despite this, the warning still does not appear in dmesg.

Am I missing something in my testing approach, or is there a different setup
required to reproduce the issue?

Thanks and Regards
Madadi Vineeth Reddy

> Fixes: 8f9ea86fdf99b ("sched: Always preserve the user requested cpumask")
> Signed-off-by: Josh Don <joshdon@google.com>


