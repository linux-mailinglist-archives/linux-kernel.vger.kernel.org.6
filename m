Return-Path: <linux-kernel+bounces-245943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E34192BBA4
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 15:45:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADEC7282B24
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 13:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAB1B15ECC0;
	Tue,  9 Jul 2024 13:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="liwK4rqQ"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28641145325
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 13:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720532716; cv=none; b=bGf5zmp6mp6oPe9+/DXy1HZnit0hGHT9W9j3tl4yKaZbO3juBoJRCNEbfNbqTpFbwYny0Lq55mZq/ggsYEFS+04PVSc52j/HVMKmhfanM03W+v6jVXTVHH4f37yRvqG460rsfL/n6Nf30lE9wHxtmM//M90tbIT7GeZII2dE7E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720532716; c=relaxed/simple;
	bh=aFbu6JPZTehZskTcyTBFPgbiKG+sglB5LaGksXomx4A=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JbAATR3z28ROpH0wvG1KWeTHSjejlomN8I3NhcDosVWw71Utz8FtRAlE/wnFurbBj2RJ83+Kr12LWZtU8SNU8/vvLqTxhX/AB+pzyGH8UDG47O76lkOVMXwOM3576OfSFZm6RWzbPi1ovm5y/znvmVBd4dFMn+6aWf32IM1wGGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=liwK4rqQ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 469DHa72011922;
	Tue, 9 Jul 2024 13:44:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=pp1; bh=
	7foDdIEaEZarA83YlTWrhHr9eoerSIsWhAOzAv0tLhI=; b=liwK4rqQ7AluTZr6
	+LKrd/bVOzY0KEzaWRNBY4DDhSs+AOeE67w62fMa2ln9weyUF4obFqRml6kcPz9l
	jHtgRBSFAFd/leIVGRH6l3Npsd7aBckaYEfsDuEtdQX4H4BF4ldNJLq6almPBWxq
	PYtwz7xNHKcBMAeywbQrRpfvEIX+W3ttrloNYNGp5TDGFdQ+k56w+V031ugUmqU4
	EqkHRCAVo2L2wFYFgCf9cMNma+CZYOQBEbxT+qVDXLsIrNBrC65s6F+hinpzHbSG
	lwV8qNS1Nqni9wlO5KDZpa0uU+8bSJD9lNT67m+chuMV8uPYI9yoD8kU7V5EF/2U
	dja7dA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4095p6g4t8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jul 2024 13:44:50 +0000 (GMT)
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 469DinE1017947;
	Tue, 9 Jul 2024 13:44:49 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4095p6g4t5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jul 2024 13:44:49 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 469CFoFr025952;
	Tue, 9 Jul 2024 13:44:48 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 407hrmmnw6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jul 2024 13:44:48 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 469DijcR5571106
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 9 Jul 2024 13:44:47 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 44AEF5805A;
	Tue,  9 Jul 2024 13:44:45 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 26E545803F;
	Tue,  9 Jul 2024 13:44:40 +0000 (GMT)
Received: from [9.171.46.21] (unknown [9.171.46.21])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  9 Jul 2024 13:44:39 +0000 (GMT)
Message-ID: <dc4a8671-b8c2-484f-a83c-03bfc1fbe078@linux.ibm.com>
Date: Tue, 9 Jul 2024 19:14:38 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] fs/hugetlbfs/inode.c: Ensure
 generic_hugetlb_get_unmapped_area() returns higher address than mmap_min_addr
To: Oscar Salvador <osalvador@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Muchun Song <muchun.song@linux.dev>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Ritesh Harjani <ritesh.list@gmail.com>,
        Mike Rapoport <rppt@kernel.org>, David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Tony Battersby
 <tonyb@cybernetics.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>, Andy Lutomirski <luto@kernel.org>
References: <20240709092122.41232-1-donettom@linux.ibm.com>
 <Zo0JSVzKKmG_1ADQ@localhost.localdomain>
Content-Language: en-US
From: Donet Tom <donettom@linux.ibm.com>
In-Reply-To: <Zo0JSVzKKmG_1ADQ@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: sX8uQD2cqGnSx0zO7QMgNZVXilHOgZJk
X-Proofpoint-ORIG-GUID: FVvQT8ST0Em3L7vbxTE95hA4ljwIkHqV
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
 definitions=2024-07-09_03,2024-07-09_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1011
 mlxlogscore=999 priorityscore=1501 malwarescore=0 bulkscore=0 adultscore=0
 suspectscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2406140001
 definitions=main-2407090085


On 7/9/24 15:26, Oscar Salvador wrote:
> On Tue, Jul 09, 2024 at 04:21:22AM -0500, Donet Tom wrote:
>> generic_hugetlb_get_unmapped_area() was returning an address less
>> than mmap_min_addr if the mmap argument addr, after alignment, was
>> less than mmap_min_addr, causing mmap to fail.
>>
>> This is because current generic_hugetlb_get_unmapped_area() code does
>> not take into account mmap_min_addr.
>>
>> This patch ensures that generic_hugetlb_get_unmapped_area() always returns
>> an address that is greater than mmap_min_addr. Additionally, similar to
>> generic_get_unmapped_area(), vm_end_gap() checks are included to ensure
>> that the address is within the limit.
> Hi Donet,
>
> jfyi: I am already working on other parts of the kernel to avoid hugetlb code
> duplication vs mm core.
> I am also working on getting rid of hugetlb-unmapped_area specific code
> [1].
> I still need to perform some more tests but looks promising
> code-deletion-wise:
>
>    arch/parisc/mm/hugetlbpage.c     |  23 -------
>    arch/powerpc/mm/book3s64/slice.c |  49 ++++++++------
>    arch/s390/mm/hugetlbpage.c       |  84 ------------------------
>    arch/s390/mm/mmap.c              |  14 +++-
>    arch/sparc/kernel/sys_sparc_32.c |  16 +++--
>    arch/sparc/kernel/sys_sparc_64.c |  36 ++++++++---
>    arch/sparc/mm/hugetlbpage.c      | 108 -------------------------------
>    arch/x86/kernel/sys_x86_64.c     |  27 +++++---
>    arch/x86/mm/hugetlbpage.c        | 100 ----------------------------
>    fs/hugetlbfs/inode.c             |  97 ++-------------------------
>    include/linux/hugetlb.h          |  10 +++
>    mm/mmap.c                        |  25 ++++++-
>    12 files changed, 139 insertions(+), 450 deletions(-)
>
> I plan to post it in a day or two.
>
> [1] https://github.com/leberus/linux/tree/hugetlb-unmapped-area
Thank you Oscar.

The issue I am trying to fix will also get fixed by this new changes right.
So should we drop my patch or should we continue it?

-Donet

