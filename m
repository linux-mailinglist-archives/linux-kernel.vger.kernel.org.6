Return-Path: <linux-kernel+bounces-550832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C541A5649E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 11:07:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABE373A7DC0
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 10:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2B8720D4F4;
	Fri,  7 Mar 2025 10:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ShlAUEZS"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE89A19CC05
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 10:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741342038; cv=none; b=HI3PKmTzye0rDoikoKTZA53aokqpxqG7lP/p3uoVnUvMkNUavJv5Luz3wQxGcLlmTxZpndpUEujZG4PkFDcYlR91nTQmEZER4FuDR4z8eh7DP0ElaTOqYZMcHpfURBLTXV4LTTD6A6AwypX+w/keaWmnmCajzFC8DsvO7yltWp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741342038; c=relaxed/simple;
	bh=9CYg+Qp7lU8kNLTx2Bw5MXxd5kgzHi9PQLQC6SyEclI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ALvOtCrKlFFsqjJloraHCpzhJJpsJGvfdpLXff6n8KH8kfBquIltC4/8aBNaucRFVU3kpKhVDp7Nv2+KfJD7MT6Jmee+PepcKINnsDkdhvRcEZ51V9x3iTMQtZFEJw10yqOwtRtSWA58rrBglzmYNVJkd+R2wp3Z8NiR/UKi0j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ShlAUEZS; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52784BTx011804;
	Fri, 7 Mar 2025 10:06:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=pp1;
	 bh=P5Y9iRYBc9+d0/TmKunKD0K+iQDXvFTQydolB02uE+M=; b=ShlAUEZSjFIB
	h/nKzvrzvt1yeasVSaOg/TwYTGUu7cDWs2cTdytPgQoCMscc6mDb9ftYPCmhEYAv
	HpSg48Z21mDM6z9PIFOQY7E9JbtK3uwZK2fIeTw5TJ90BYmRpQarm+NPrBs0NFxj
	RsjLvgx4s7YHFPdxvlX7+ac/j6P5RO9C2vBWpyw+g1C5YrnA60I73VjEwuKFJh1d
	5WBcp00Zj5OzDHN82sB1+sj69uuI2T4VDIAyCX/lyVUKlVwcDCqAyKVwDHhV9DCr
	1I57AOBbpCGs6/vrFRL1Bi9rtIibKtmrTzjY8AyAzrKXGfU9yEyOyQSoVKHk/tmb
	7JM0LW1lng==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 457k45b1pc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Mar 2025 10:06:27 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 527A6Re5004689;
	Fri, 7 Mar 2025 10:06:27 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 457k45b1p7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Mar 2025 10:06:27 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5278FYBa025026;
	Fri, 7 Mar 2025 10:06:26 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 454f92dmbs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Mar 2025 10:06:26 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 527A6OsO27919060
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 7 Mar 2025 10:06:24 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7180D58056;
	Fri,  7 Mar 2025 10:06:24 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 69EB958067;
	Fri,  7 Mar 2025 10:06:15 +0000 (GMT)
Received: from [9.43.47.115] (unknown [9.43.47.115])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  7 Mar 2025 10:06:15 +0000 (GMT)
Message-ID: <5291cd17-cdf5-4d66-8109-be27a4d2048a@linux.ibm.com>
Date: Fri, 7 Mar 2025 15:36:13 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/2] Improving topology_span_sane
To: Steve Wahl <steve.wahl@hpe.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org, Naman Jain <namjain@linux.microsoft.com>,
        Saurabh Singh Sengar <ssengar@linux.microsoft.com>,
        srivatsa@csail.mit.edu, Michael Kelley <mhklinux@outlook.com>,
        Russ Anderson <rja@hpe.com>, Dimitri Sivanich <sivanich@hpe.com>,
        K Prateek Nayak
 <kprateek.nayak@amd.com>,
        Vishal Chourasia <vishalc@linux.ibm.com>, samir <samir@linux.ibm.com>,
        Madadi Vineeth Reddy <vineethr@linux.ibm.com>
References: <20250304160844.75373-1-steve.wahl@hpe.com>
Content-Language: en-US
From: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
Reply-To: 20250304160844.75373-1-steve.wahl@hpe.com
In-Reply-To: <20250304160844.75373-1-steve.wahl@hpe.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: DPCFXUVyqZ0hws5HqTPRZBepD_4NOKa8
X-Proofpoint-GUID: c-8Eq-73TaN2WwUmGwOLvs_VlHYICJO5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-07_04,2025-03-06_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 mlxlogscore=774 mlxscore=0 adultscore=0 clxscore=1011 impostorscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503070071

Hi Steve,

On 04/03/25 21:38, Steve Wahl wrote:
> toplogy_span_sane() has an O(N^2) algorithm that takes an inordinate
> amount of time on systems with a large number of cpus.
> 
> The first patch in this series replaces the algorithm used with a O(N)
> method that should exactly duplicate the previous code's results.
> 
> The second patch simplifies the first, taking a similar amount of time
> to run, but potentially has different results than previous code under
> situations believed to not truly exist, like a CPU not being included
> in its own span.

I have reviewed the proposed approach for the topology sanity check and
it looks good to me.

I have also tested the patch on a Power10 system with 12 cores (96 CPUs).
The average CPU hotplug latency decreased by around 10%.

Therefore,

Reviewed-by: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
Tested-by: Madadi Vineeth Reddy <vineethr@linux.ibm.com>

Thanks,
Madadi Vineeth Reddy

> 
> Version 1:
>   * Original patch
> 
> Version 2:
> 
>   * Adopted simplifications from K Prateek Nayak,and fixed use of
>     num_possible_cpus().
> 
> Version 3:
> 
>   * Undid the simplifications from version 2 when noticed that results
>     could differ from original code; kept num_possible_cpus() fix.
> 
> Version 4:
> 
>   * Turned the patch into a series of 2, the second re-introduces the
>     simplifications, and includes further simplification suggested by
>     Valentin Schneider in the discussion for Version 2.
> 
> Steve Wahl (2):
>   sched/topology: improve topology_span_sane speed
>   sched/topology: Refinement to topology_span_sane speedup
> 
>  kernel/sched/topology.c | 73 +++++++++++++++++++++++++++--------------
>  1 file changed, 48 insertions(+), 25 deletions(-)
> 


