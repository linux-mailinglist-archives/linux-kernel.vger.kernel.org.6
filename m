Return-Path: <linux-kernel+bounces-254847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 971B093386C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 09:59:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2CB9FB21641
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 07:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85CE4208B8;
	Wed, 17 Jul 2024 07:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="OLa17FhX"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D1B21CAB1
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 07:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721203184; cv=none; b=O8eYlxm9n5mtYOlfSNBzKrejHfi9OaQUSRC8arSXH0Dhyhu3KXYjSC9q2n7wf+ojXMmdgF/AexARVOlOrdL4SzXAGv7iSbsACfULV1DxIPkTT7a0nxhqfLSjpWmkigS9ya8HHrPUmsXlb8GGFqpsLO+XjUo+RSELV1A8OqoivdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721203184; c=relaxed/simple;
	bh=4kdHFUV5KnPKH1AMa9NEHHGe0CJaGYqG5YhtmXf9DYQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gH5H61TQbpw+eUIGmOMKJpX/EBVrS+zf6kDF5LY1udveee3COgz57SP5YS2P2pE+IYemD1cnYnMNcc3deAsEw8M+K2rYujzoi+u08qWUUSqS1GxrwUXur6RSzlvda2iZQPhJI4PbWSdoa5PPtGqN5rwNRxuOqj9DcIxu01vnIGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=OLa17FhX; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46H7R1uq008170;
	Wed, 17 Jul 2024 07:59:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=pp1; bh=
	4kdHFUV5KnPKH1AMa9NEHHGe0CJaGYqG5YhtmXf9DYQ=; b=OLa17FhX3qlrnloU
	zCQGQPKN2tnK9a6URbmmfVUik6d4q+/8t3ErcKwsuhpJaOpKVtnMBPsxe1qPLQ6i
	pA6nATcnA3e8c6SD9QzCVgLgGuLEAO/2VA+U5EXwU7Xam21anjmjhLtL14Ozz0IS
	VXL1DVlzR21OT1w+Kv6GSQe+v0xRLIZkil0182wLD5s/wj1LCldr1LKDOUd2Ixvu
	EVpLbimdqsnxBawReYk5zgu2rWJU2cTbuz2Z64joUwrNJVEX/r2T6VzzzPs3XjXD
	i3Srzjwdu9aztWOBZDUrr9xrHrCkBx1BtFFx/1D+pOGm/te+6GOS6dTDhOsavpDi
	qPJ7Hg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40e0urs341-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jul 2024 07:59:20 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 46H7xKdw023023;
	Wed, 17 Jul 2024 07:59:20 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40e0urs33y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jul 2024 07:59:20 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 46H5OHmS028837;
	Wed, 17 Jul 2024 07:59:19 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 40dwkmu53h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jul 2024 07:59:19 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 46H7xDCj31195884
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Jul 2024 07:59:15 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9514C2004B;
	Wed, 17 Jul 2024 07:59:13 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B336F20040;
	Wed, 17 Jul 2024 07:59:12 +0000 (GMT)
Received: from [9.171.86.104] (unknown [9.171.86.104])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 17 Jul 2024 07:59:12 +0000 (GMT)
Message-ID: <3976e7a9-b6a2-450c-a891-483644ee88ba@linux.ibm.com>
Date: Wed, 17 Jul 2024 09:59:12 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [linux-next:master] [mm/hugetlb_vmemmap] 875fa64577:
 vm-scalability.throughput -34.3% regression
To: Janosch Frank <frankja@linux.ibm.com>, Yu Zhao <yuzhao@google.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com,
        Linux Memory Management List <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Muchun Song <muchun.song@linux.dev>,
        David Hildenbrand <david@redhat.com>,
        Frank van der Linden <fvdl@google.com>,
        Matthew Wilcox
 <willy@infradead.org>, Peter Xu <peterx@redhat.com>,
        Yang Shi <yang@os.amperecomputing.com>, linux-kernel@vger.kernel.org,
        ying.huang@intel.com, feng.tang@intel.com, fengwei.yin@intel.com,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Marc Hartmayer <mhartmay@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>
References: <202407091001.1250ad4a-oliver.sang@intel.com>
 <3acefad9-96e5-4681-8014-827d6be71c7a@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <3acefad9-96e5-4681-8014-827d6be71c7a@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 8yuVJUFm8pcrV-ZSY9Q1gErcAlT68eLo
X-Proofpoint-ORIG-GUID: -Nx7rkw7jfYrNy8hcw7tnbrPOG_Up27z
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-17_04,2024-07-16_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 mlxscore=0 adultscore=0 impostorscore=0 spamscore=0
 mlxlogscore=826 priorityscore=1501 suspectscore=0 malwarescore=0
 clxscore=1011 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407170059

Am 17.07.24 um 09:52 schrieb Janosch Frank:
> On 7/9/24 07:11, kernel test robot wrote:
>> Hello,
>>
>> kernel test robot noticed a -34.3% regression of vm-scalability.throughput on:
>>
>>
>> commit: 875fa64577da9bc8e9963ee14fef8433f20653e7 ("mm/hugetlb_vmemmap: fix race with speculative PFN walkers")
>> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
>>
>> [still regression on linux-next/master 0b58e108042b0ed28a71cd7edf5175999955b233]
>>
> This has hit s390 huge page backed KVM guests as well.
> Our simple start/stop test case went from ~5 to over 50 seconds of runtime.

Could this be one of the synchronize_rcu calls? This patch adds lots of them. On s390 with HZ=100 those are really expensive.

