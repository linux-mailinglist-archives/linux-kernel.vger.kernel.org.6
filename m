Return-Path: <linux-kernel+bounces-188620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 460E38CE479
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 12:53:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68C161C20C10
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 10:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E05BF8595A;
	Fri, 24 May 2024 10:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GJiY9CD4"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C8685948
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 10:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716548013; cv=none; b=IIeZx2LN2kcbgYW7bRsPs0SNrVeMpQNPRDBzuK4w98F2gYrEKH1u1WALqof2w+2Hf8oiixdonCQbxexsZ4GP5IntSlPS/AQqK2jj9C/QkL0NwPc52nt1veDbrQzJ2qwgbHifetIJPYqwnZuH1V+89lEfhEAtAlQmO+BiycIg0Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716548013; c=relaxed/simple;
	bh=8KfPxj52yS3hgd4q7Xf38W0d1NbXsaSF6pe+b8xCFaw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uXUp3GSPSDqDP9IULXJNY5odcsevcJntGpWmiAlAQPyzOYF3hS9eT2BKblrlbzUcQ1k40h6WPQ6Q4MgEbStE5vIB4MX9dUDnZcbLhcL/QN3iXb4P7MU3ADa/4DtWi7Jrzbll/GTc21d3/WL3OOFOgO+oS9fnQc7XvllCiFS4liU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=GJiY9CD4; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44OApM54026188;
	Fri, 24 May 2024 10:52:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=HOnrwaNy9ykjvlqstNgtIESB5QlN4FiK4G2SSvvccsw=;
 b=GJiY9CD4lX8MRRzkAuw9Pi5E/gP3XWhIWcDlJibkehg0LHv8HFMpNTtg5cl50v9GO9eD
 xcCRPADcF7mGeGXpNTSE91f9udsDXzRwAdpJinLK5BA7hSQe9eOzN8jE093Q9psVBWw3
 o+CAxl3tUI7widPemvUBagBkriDrBDWcipKO3GfZ0D+eLBwnMJUfkNhBfJVCvdpdVT3X
 WOdZRkTue9hesUMKUvzhyiQGkTi0eimz31WqYgbrXmf3KYZtIB0Xq69gaaAPMRAjPSjg
 Biai/SG4R81y9XZtTkd31RZICIXOtxWPeXeZZ9DBsToDs8iKjFxr5+PUExM83h9jMwEP Qg== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yascp00hk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 May 2024 10:52:53 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44OAqrAA028394;
	Fri, 24 May 2024 10:52:53 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yascp00he-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 May 2024 10:52:52 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 44O9R6Ms026478;
	Fri, 24 May 2024 10:52:52 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3y785n01ct-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 May 2024 10:52:52 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 44OAqm6o15466964
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 May 2024 10:52:50 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1E8A220043;
	Fri, 24 May 2024 10:52:48 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3678320040;
	Fri, 24 May 2024 10:52:42 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.171.63.30])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 24 May 2024 10:52:41 +0000 (GMT)
Date: Fri, 24 May 2024 16:22:39 +0530
From: Vishal Chourasia <vishalc@linux.ibm.com>
To: Cheng Yu <serein.chengyu@huawei.com>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        changhuaixin@linux.alibaba.com, shanpeic@linux.alibaba.com,
        dtcccc@linux.alibaba.com, tj@kernel.org, linux-kernel@vger.kernel.org,
        zhangqiao22@huawei.com, judy.chenhui@huawei.com, yusongping@huawei.com,
        zhaowenhui8@huawei.com, liaoqixin@huawei.com
Subject: Re: [PATCH 0/2] cgroup cpu: set burst to zero when cfs bandwidth is
Message-ID: <ZlBxUB-bQ2lvxumP@linux.ibm.com>
References: <20240522031007.643498-1-serein.chengyu@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240522031007.643498-1-serein.chengyu@huawei.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: M2KJPMt5AhSPf8Lvm33VXD7qv5WCBzBN
X-Proofpoint-ORIG-GUID: MLbC9L6l5KqK3A7dZ4CV6QKvMKBfkSdq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-24_04,2024-05-23_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 spamscore=0 adultscore=0 mlxscore=0 suspectscore=0
 bulkscore=0 clxscore=1011 mlxlogscore=721 lowpriorityscore=0
 malwarescore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2405010000 definitions=main-2405240076

On Wed, May 22, 2024 at 11:10:05AM +0800, Cheng Yu wrote:
> In the cgroup cpu subsystem, when we remove the restriction on cfs
> bandwidth, the burst feature is also turned off. At that time, we expect
> that the value of burst is zero.
> 
> Patch 1 fixes it in cgroup v1 by Zhao Wenhui and patch 2 fixes it in
> cgroup v2.
> 
> Cheng Yu (1):
>   sched/fair: set burst to zero when set max to cpu.max
> 
> Zhao Wenhui (1):
>   sched/fair: limit burst to zero when cfs bandwidth is turned off
> 

## Before patch
# uname -r
6.9.0-12124-g6d69b6c12fce-dirty
# mkdir test
# cd test/
# cat cpu.max cpu.max.burst
max 100000
0
# echo 10000000 > cpu.max.burst
# echo 1000000000000 > cpu.max.burst
# cat cpu.max cpu.max.burst
max 100000
1000000000000
# echo "1000 100000" > cpu.max
-bash: echo: write error: Invalid argument
# echo 1000 > cpu.max.burst
# echo "1000 100000" > cpu.max
# cat cpu.max cpu.max.burst
1000 100000
1000

## After patch

# uname -r
6.9.0-12126-g7eb1a247b675-dirty
# mkdir test
# cd test/
# cat cpu.max cpu.max.burst
max 100000
0
# echo 1134535435 > cpu.max.burst
-bash: echo: write error: Invalid argument
# echo 1 > cpu.max.burst
-bash: echo: write error: Invalid argument
# echo -1 > cpu.max.burst
-bash: echo: write error: Invalid argument
# echo "10000 100000" > cpu.max
# echo 1000 > cpu.max.burst
# cat cpu.max cpu.max.burst
10000 100000
1000
# echo "max 100000" > cpu.max
# cat cpu.max cpu.max.burst
max 100000
0

# git log --oneline
7eb1a247b6753 (HEAD) sched/fair: set burst to zero when set max to cpu.max
421647086da9e sched/fair: limit burst to zero when cfs bandwidth is turned off
6d69b6c12fce4 (origin/master, origin/HEAD, master) Merge tag 'nfs-for-6.10-1' o

Now, the burst value can only be set after setting 
the quota. This change also prevents setting excessively
large burst values.

Thank you the fix.

Tested-by: Vishal Chourasia <vishalc@linux.ibm.com>

>  kernel/sched/core.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
> 
> -- 
> 2.25.1
> 

