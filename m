Return-Path: <linux-kernel+bounces-576018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB9FBA709FA
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 20:10:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2460B173C1B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 19:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6BFB1B413D;
	Tue, 25 Mar 2025 19:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="IzoZA7ry"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BAA91A83ED
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 19:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742929503; cv=none; b=ZZkF9aZJEAff6iTnMiW/fHQdMWpjhyqhWF4GY1wk0Y+PfUH2VFxOU42DYhomi+WAWJICAUkIdzEHLSTZAMHPReSmriUQXK5J202hgWX+4SUBgRljtI3ISdnyNjvQdkmrwexmCYkj0DOTlnkF4J3LUt7CyEZQ0f0ogcdQajx594Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742929503; c=relaxed/simple;
	bh=wD4/URckOJ5133UcerSShorTazQTo5w/EDTu96JI6k8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=pdF53gyaheT/NT5LjqJjT6W04zXpUrhUPZzkvJ8UTZUE0zDhStd/knwuZZgOFCLav3N0+/VC1PcwEXEAwTUgmqTIqSmbDyhSXa6gHaFxYBUCIL9AaMV3RzdPJ38Rpib9nRFnhxgnnGwGxGE+f3ix2QPx1g6JVAmt3CsyQU/3UDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=IzoZA7ry; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52PEAq1m025977;
	Tue, 25 Mar 2025 19:04:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=/K6e/+
	Y0w76cVJRh2IhrsTq38O1z7wgH43Nhxih0k38=; b=IzoZA7rytZuP7TruQ11nZ9
	rjkTZe3WXth2yWBfPnIppPjdZ6n//jpSv+tPhCFPRIjRWg/9+LPGr8XtfIStS4Jm
	50PGmBcVVAlgTYzBgXAyRmWLdDR72clLFxPYf7HWqRRejK+SvZXI6P1GRyHfaQh0
	HyF+1pAQ0EWMCB4OdAHeilqvqmC1og5evutN49DJkitxT6IkSNGnxyizItdrcnNT
	byEzc/tPvZArw9zMAUvM4e/BHXkTfW+uWpv5NndGSdOqTEJRyrpF3sCMfWeoov5y
	7M1FxjzbaRshMdVvw2YmEsBiGwqWNB0REqKBaULuhmaJLpFP0LKh/G1WgK2pw3/Q
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45kmva4h6d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Mar 2025 19:04:31 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52PFuFRX030325;
	Tue, 25 Mar 2025 19:04:30 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 45j7htd3yy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Mar 2025 19:04:30 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52PJ4Skj51511716
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Mar 2025 19:04:28 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B8B212004B;
	Tue, 25 Mar 2025 19:04:28 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 87AAC20040;
	Tue, 25 Mar 2025 19:04:24 +0000 (GMT)
Received: from [9.67.11.207] (unknown [9.67.11.207])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 25 Mar 2025 19:04:24 +0000 (GMT)
Message-ID: <587d45c3-2098-4914-9dfc-275b5d0b9bb7@linux.ibm.com>
Date: Wed, 26 Mar 2025 00:34:23 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 00/21] futex: Add support task local hash maps,
 FUTEX2_NUMA and FUTEX2_MPOL
From: Shrikanth Hegde <sshegde@linux.ibm.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Schneider <vschneid@redhat.com>,
        Waiman Long <longman@redhat.com>, linux-kernel@vger.kernel.org,
        "Nysal Jan K.A." <nysal@linux.ibm.com>
References: <20250312151634.2183278-1-bigeasy@linutronix.de>
 <0713a015-b8dc-49db-a329-30891a10378c@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <0713a015-b8dc-49db-a329-30891a10378c@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: tJrgVF6mfYVMk_ggXMk9dHcvQPVRcxEx
X-Proofpoint-GUID: tJrgVF6mfYVMk_ggXMk9dHcvQPVRcxEx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-25_08,2025-03-25_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 spamscore=0
 phishscore=0 clxscore=1015 mlxlogscore=999 bulkscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503250129

Hi Sebastian.

On 3/18/25 18:54, Shrikanth Hegde wrote:
> 
>> The complete tree is at
>>     https://git.kernel.org/pub/scm/linux/kernel/git/bigeasy/ 
>> staging.git/log/?h=futex_local_v10
>>     https://git.kernel.org/pub/scm/linux/kernel/git/bigeasy/ 
>> staging.git futex_local_v10
>>
> 
> Hi Sebastian. Thanks for working on this (along with bringing back 
> FUTEX2 NUMA) which
> might help large systems with many futexes.
> 
> I tried this in one of our systems(Single NUMA, 80 CPUs), I see 
> significant reduction in futex/hash.
> Maybe i am missing some config or doing something stupid w.r.t to 
> benchmarking.
> I am trying to understand this stuff.
> 
> I ran "perf bench futex all" as is. No change has been made to perf.
> =========================================
> Without patch: at 6575d1b4a6ef3336608127c704b612bc5e7b0fdc
> # Running futex/hash benchmark...
> Run summary [PID 45758]: 80 threads, each operating on 1024 [private] 
> futexes for 10 secs.
> Averaged 1556023 operations/sec (+- 0.08%), total secs = 10   <<--- 1.5M
> 
> =========================================
> With the Series: I had to make PR_FUTEX_HASH=78 since 77 is used for 
> TIMERs.
> 
> # Running futex/hash benchmark...
> Run summary [PID 8644]: 80 threads, each operating on 1024 [private] 
> futexes for 10 secs.
> Averaged 150382 operations/sec (+- 0.42%), total secs = 10   <<-- 0.15M, 
> close to 10x down.
> 
> =========================================
> 
> Did try a git bisect based on the futex/hash numbers. It narrowed it to 
> this one.
> first bad commit: [5dc017a816766be47ffabe97b7e5f75919756e5c] futex: 
> Allow automatic allocation of process wide futex hash.
> 
> Is this expected given the complexity of hash function change?

So, did some more bench-marking using the same perf futex hash.
I see that perf creates N threads and binds each thread to a CPU and then
calls futex_wait such that it never blocks. It always returns EWOULDBLOCK.
only futex_hash is exercised.

Numbers with different threads. (private futexes)
threads		baseline		with series    (ratio)
1		3386265			3266560		0.96	
10		1972069			 821565		0.41
40		1580497			 277900		0.17
80		1555482			 150450		0.096


With Shared Futex: (-s option)
Threads		baseline		with series    (ratio)
80		590144			 585067		0.99

After looking into code, and after some hacking, could get the
performance back with below change. this is likely functionally not correct.
the reason for below change is,

1. perf report showed significant time in futex_private_hash_put.
    so removed rcu usage for users. that brought some improvements.
    from 150k to 300k. Is there a better way to do this users protection?

2. Since number of buckets would be less by default, this would cause hb
    collision. This was seen by queued_spin_lock_slowpath. Increased the hash
    bucket size what was before the series. That brought the numbers back to
    1.5M. This could be achieved with prctl in perf/bench/futex-hash.c i guess.

Note: Just increasing the hash bucket size without point 1, didn't matter much.

-------
diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index 363a7692909d..7d01bf8caa13 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -65,7 +65,7 @@ static struct {
  #define futex_queues	(__futex_data.queues)
  
  struct futex_private_hash {
-	rcuref_t	users;
+	int	users;
  	unsigned int	hash_mask;
  	struct rcu_head	rcu;
  	void		*mm;
@@ -200,7 +200,7 @@ static bool __futex_pivot_hash(struct mm_struct *mm,
  	fph = rcu_dereference_protected(mm->futex_phash,
  					lockdep_is_held(&mm->futex_hash_lock));
  	if (fph) {
-		if (!rcuref_is_dead(&fph->users)) {
+		if (!(fph->users)) {
  			mm->futex_phash_new = new;
  			return false;
  		}
@@ -247,7 +247,7 @@ struct futex_private_hash *futex_private_hash(void)
  		if (!fph)
  			return NULL;
  
-		if (rcuref_get(&fph->users))
+		if ((fph->users))
  			return fph;
  	}
  	futex_pivot_hash(mm);
@@ -256,7 +256,7 @@ struct futex_private_hash *futex_private_hash(void)
  
  bool futex_private_hash_get(struct futex_private_hash *fph)
  {
-	return rcuref_get(&fph->users);
+	return !!(fph->users);
  }
  
  void futex_private_hash_put(struct futex_private_hash *fph)
@@ -265,7 +265,7 @@ void futex_private_hash_put(struct futex_private_hash *fph)
  	 * Ignore the result; the DEAD state is picked up
  	 * when rcuref_get() starts failing via rcuref_is_dead().
  	 */
-	if (rcuref_put(&fph->users))
+	if ((fph->users))
  		wake_up_var(fph->mm);
  }
  
@@ -1509,7 +1509,7 @@ void futex_hash_free(struct mm_struct *mm)
  	kvfree(mm->futex_phash_new);
  	fph = rcu_dereference_raw(mm->futex_phash);
  	if (fph) {
-		WARN_ON_ONCE(rcuref_read(&fph->users) > 1);
+		WARN_ON_ONCE((fph->users) > 1);
  		kvfree(fph);
  	}
  }
@@ -1524,7 +1524,7 @@ static bool futex_pivot_pending(struct mm_struct *mm)
  		return false;
  
  	fph = rcu_dereference(mm->futex_phash);
-	return !rcuref_read(&fph->users);
+	return !!(fph->users);
  }
  
  static bool futex_hash_less(struct futex_private_hash *a,
@@ -1576,7 +1576,7 @@ static int futex_hash_allocate(unsigned int hash_slots, bool custom)
  	if (!fph)
  		return -ENOMEM;
  
-	rcuref_init(&fph->users, 1);
+	fph->users = 1;
  	fph->hash_mask = hash_slots ? hash_slots - 1 : 0;
  	fph->custom = custom;
  	fph->mm = mm;
@@ -1671,6 +1671,8 @@ int futex_hash_allocate_default(void)
  	if (current_buckets >= buckets)
  		return 0;
  
+	buckets = 32768;
+
  	return futex_hash_allocate(buckets, false);
  }
  
@@ -1732,6 +1734,8 @@ static int __init futex_init(void)
  	hashsize = max(4, hashsize);
  	hashsize = roundup_pow_of_two(hashsize);
  #endif
+	hashsize = 32768;
+
  	futex_hashshift = ilog2(hashsize);
  	size = sizeof(struct futex_hash_bucket) * hashsize;
  	order = get_order(size);


