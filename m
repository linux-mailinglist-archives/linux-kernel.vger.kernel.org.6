Return-Path: <linux-kernel+bounces-231839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79FF3919EF7
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 08:00:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 917981C2173E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 06:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 655C81CF92;
	Thu, 27 Jun 2024 06:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gCffxV56"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80242A3F
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 06:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719468045; cv=none; b=g8z1qaQo1zIngk0lDUB7goVBIgDCva0TS/LA339ob5pfi5O9GY4yeqqQkR7Umq8h1YoPbQShTru9bm5RlDw/Nygq4NOamdDXeFtLaU/dIS6dB4yj/rp0XGHbX0UjENCv/cULD/nWWg2GqnUa2lSM84qdAeWEIU82dSA/Cu4sRR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719468045; c=relaxed/simple;
	bh=Tp7ErK0RAWRHZxIGVWy7CwAmpCCROATLKKLgxpeDk8o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BzhMSYw956RAHPRmqUmjXyb/Gi6yXYprdvr6xI/F4WWGDdJCU15qDkU6wPY6OrWnXTyk3e2rVhX5++T95A6yTpSBiC+Ii/Y/I4bBO8rOb9yRazloMR8UFR/5yAhInLV5669esXxc5X1HysRz7zgkJBQstCQic6KNrchqqJetizc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gCffxV56; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45R5RxBu029477;
	Thu, 27 Jun 2024 06:00:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=0
	xR0tHs9mClySZ31dR3jVFeUkofeuAtLj2PHkle04wM=; b=gCffxV56kfznU4xZo
	roB7KrB5sPtg7KatTjysWDt76udxxPChhwCUnEgte2EH4gu+ZgcOVMViuTPONgEW
	kVCItb17T8ic7VhuDL/ptCuepHxHDc4qeUbrJ0Qc9rKPn+CpkOnGwxb2r6tKdc+w
	0aBGvaEZp3+rfVET9UQzetB8Ep/jBTTcytqBcq/HPTKW273Tthu/fQYgJI/mIIQq
	Gi5kh1COr6bLxPxK1jagldwN4lLlPBYqRHp/uRZ7ebYJVdsAAf23WIbRlMprE/tE
	2LUJU7v3EWhzGiasc20XxhzYT+Bzuny+yJJj8G7+5jJl+tNUTegqs8W+idA3tywE
	OSHjg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 400yaw0bq1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Jun 2024 06:00:36 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45R60aPJ022026;
	Thu, 27 Jun 2024 06:00:36 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 400yaw0bpy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Jun 2024 06:00:35 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45R3Wa5r008183;
	Thu, 27 Jun 2024 06:00:34 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3yx9b118rp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Jun 2024 06:00:34 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45R60VFK40370802
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Jun 2024 06:00:34 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7CCCE58054;
	Thu, 27 Jun 2024 06:00:29 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E53AF58064;
	Thu, 27 Jun 2024 06:00:27 +0000 (GMT)
Received: from [9.109.245.191] (unknown [9.109.245.191])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 27 Jun 2024 06:00:27 +0000 (GMT)
Message-ID: <4748f87e-0762-40fc-ab9e-577c9739066f@linux.ibm.com>
Date: Thu, 27 Jun 2024 11:30:26 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] mm/migrate: move NUMA hinting fault folio
 isolation + checks under PTL
To: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
References: <20240620212935.656243-1-david@redhat.com>
 <20240620212935.656243-3-david@redhat.com>
 <8f85c31a-e603-4578-bf49-136dae0d4b69@redhat.com>
Content-Language: en-US
From: Donet Tom <donettom@linux.ibm.com>
In-Reply-To: <8f85c31a-e603-4578-bf49-136dae0d4b69@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 9aSEh46fcGJ41bHlYQSuh0XRIudn5-XY
X-Proofpoint-GUID: fD3HInaw9n4W3uDLS0ODJ8G2glp2YjZz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-27_02,2024-06-25_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 mlxscore=0 phishscore=0 adultscore=0 mlxlogscore=999
 impostorscore=0 suspectscore=0 clxscore=1015 spamscore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406270043


On 6/26/24 21:52, David Hildenbrand wrote:
> On 20.06.24 23:29, David Hildenbrand wrote:
>> Currently we always take a folio reference even if migration will not
>> even be tried or isolation failed, requiring us to grab+drop an 
>> additional
>> reference.
>>
>> Further, we end up calling folio_likely_mapped_shared() while the folio
>> might have already been unmapped, because after we dropped the PTL, that
>> can easily happen. We want to stop touching mapcounts and friends from
>> such context, and only call folio_likely_mapped_shared() while the folio
>> is still mapped: mapcount information is pretty much stale and 
>> unreliable
>> otherwise.
>>
>> So let's move checks into numamigrate_isolate_folio(), rename that
>> function to migrate_misplaced_folio_prepare(), and call that function
>> from callsites where we call migrate_misplaced_folio(), but still with
>> the PTL held.
>>
>> We can now stop taking temporary folio references, and really only take
>> a reference if folio isolation succeeded. Doing the
>> folio_likely_mapped_shared() + golio isolation under PT lock is now 
>> similar
>> to how we handle MADV_PAGEOUT.
>>
>> While at it, combine the folio_is_file_lru() checks.
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>
> Donet just reported an issue. I suspect this fixes it -- in any case, 
> this is
> the right thing to do.
>
> From 0833b9896e98c8d88c521609c811a220d14a2e7e Mon Sep 17 00:00:00 2001
> From: David Hildenbrand <david@redhat.com>
> Date: Wed, 26 Jun 2024 18:14:44 +0200
> Subject: [PATCH] Fixup: mm/migrate: move NUMA hinting fault folio 
> isolation +
>  checks under PTL
>
> Donet reports an issue during NUMA migration we haven't seen previously:
>
>     [   71.422804] list_del corruption, c00c00000061b3c8->next is
>     LIST_POISON1 (5deadbeef0000100)
>     [   71.422839] ------------[ cut here ]------------
>     [   71.422843] kernel BUG at lib/list_debug.c:56!
>     [   71.422850] Oops: Exception in kernel mode, sig: 5 [#1]
>
> We forgot to convert one "return 0;" to return an error instead from
> migrate_misplaced_folio_prepare() in case the target node is nearly
> full.
>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  mm/migrate.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 8beedbb42a93..9ed43c1eea5e 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -2564,7 +2564,7 @@ int migrate_misplaced_folio_prepare(struct folio 
> *folio,
>          int z;
>
>          if (!(sysctl_numa_balancing_mode & 
> NUMA_BALANCING_MEMORY_TIERING))
> -            return 0;
> +            return -EAGAIN;
>          for (z = pgdat->nr_zones - 1; z >= 0; z--) {
>              if (managed_zone(pgdat->node_zones + z))
>                  break;
Hi David

I tested with this patch . The issue is resolved. I am not seeing the 
kernel panic.

I also tested the page migration. It working fine.

numa_pte_updates 1262330
numa_huge_pte_updates 0
numa_hint_faults 925797
numa_hint_faults_local 3780
numa_pages_migrated 327930
pgmigrate_success 822530


Thanks
Donet


>
> base-commit: 4b17ce353e02b47b00e2fe87b862f09e8b9a47e6

