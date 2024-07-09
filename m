Return-Path: <linux-kernel+bounces-245936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9C8E92BB92
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 15:39:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 455921F25908
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 13:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C905B15FA7C;
	Tue,  9 Jul 2024 13:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XuSbNSMA"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64244145325
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 13:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720532346; cv=none; b=d9oeM3dixm2cLIiDxBb4UCo2FMa/yIH+zLHLgcch0WiO6OP/WQzvSzv43jt51yGwSRPovbcWL0Dlir5t5dHvnY9Soerfzesx66uJJ1m858BMrLtKz3+QTKyLm8Ukf7zk2pntaoPcABxdM5hB1ElFabXndeD3JNdRCLU+H7D1tMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720532346; c=relaxed/simple;
	bh=jKPnGQoBrFbk97WK2OFmtUmD2l6dOO/crU3Ee79CAC8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tUvqnY+8xEZuAP7BL8cDZ9+Q8TWhTmCWPXCIry7eo+BMaqoE4X1ltr1j7zVu5TcCtZ418lVwF+gCQLC2r0lowa+zFsZOW78P0anY3XpNmiycBrNjycqw6CVvnBvUvYCN593ogTJ2YntU51wckJw6frSKfGl2QQ0ma5pfZhga48Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=XuSbNSMA; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 469Av5mJ025005;
	Tue, 9 Jul 2024 13:38:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=pp1; bh=
	J1r/cqrccWxzPRbC4dc05TWsBUOiP5AFwCpN2eOktno=; b=XuSbNSMAjFop9ipr
	IZT76fQsEUJOmCjeM8VxHDZAhcI//Ffp6aWDQ4M3kq/gmNtLIH6+vgmH7EUjN01a
	L+pbMTPuaVzFmAX+Xr1L9JjF8ZKHcr+9SKZ97E8q6grKznJ186GICvXRir6whimN
	rSAaqLfXUrVkTYIdH+bM63+qdEhMImeMCPsJbuDJojlhFSK+0eeD+psWGVOnvjXe
	zyPQiV/yrgwW0uZoYqphXlgYe43MyKAC6eN1QdkcEA6yDRJ/BqLSNwn27YP64AU0
	8IOqv7YH/oRt5tjmZRwuhou5kb0Td1TjD3m0S+NOqCFvwcP99gNlFxqC6/U/2cD5
	kEeS5A==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 408nuxa65x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jul 2024 13:38:45 +0000 (GMT)
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 469Dcjnr003957;
	Tue, 9 Jul 2024 13:38:45 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 408nuxa65u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jul 2024 13:38:45 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 469DTG8u006967;
	Tue, 9 Jul 2024 13:38:44 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 407jfmce80-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jul 2024 13:38:44 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 469Dcg0X43909880
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 9 Jul 2024 13:38:44 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1189F58063;
	Tue,  9 Jul 2024 13:38:42 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 79BF65806E;
	Tue,  9 Jul 2024 13:38:37 +0000 (GMT)
Received: from [9.171.46.21] (unknown [9.171.46.21])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  9 Jul 2024 13:38:37 +0000 (GMT)
Message-ID: <2ab9d7e3-3edc-4366-9c3e-100da41c4ffc@linux.ibm.com>
Date: Tue, 9 Jul 2024 19:08:35 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] fs/hugetlbfs/inode.c: Ensure
 generic_hugetlb_get_unmapped_area() returns higher address than mmap_min_addr
To: "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Ritesh Harjani <ritesh.list@gmail.com>,
        Mike Rapoport <rppt@kernel.org>, David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Tony Battersby
 <tonyb@cybernetics.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>, Andy Lutomirski <luto@kernel.org>
References: <20240709092122.41232-1-donettom@linux.ibm.com>
 <kbypmoemiq43kuok7c3f3rxhzigpva6ov7ua2wfblkjmaccyes@6k4b37lj7msd>
Content-Language: en-US
From: Donet Tom <donettom@linux.ibm.com>
In-Reply-To: <kbypmoemiq43kuok7c3f3rxhzigpva6ov7ua2wfblkjmaccyes@6k4b37lj7msd>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: zK5dx1E790l1ZYayc8sk0DwkxIZHgQxc
X-Proofpoint-ORIG-GUID: dJJFZyVrbzwQfIvUHzyv87MYDAKDEHr2
Content-Transfer-Encoding: 8bit
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
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 impostorscore=0 mlxscore=0 lowpriorityscore=0
 clxscore=1015 suspectscore=0 bulkscore=0 mlxlogscore=844 phishscore=0
 malwarescore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407090085


On 7/9/24 16:04, Kirill A . Shutemov wrote:
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
> checks are included to maintain stack gap.
Thank you. I will update and send  V3.

-Donet
>> How to reproduce
>> ================
>>
>>   #include <stdio.h>
>>   #include <stdlib.h>
>>   #include <sys/mman.h>
>>   #include <unistd.h>
>>
>>   #define HUGEPAGE_SIZE (16 * 1024 * 1024)
>>
>>   int main() {
>>
>>      void *addr = mmap((void *)-1, HUGEPAGE_SIZE,
>>                   PROT_READ | PROT_WRITE,
>>                   MAP_SHARED | MAP_ANONYMOUS | MAP_HUGETLB, -1, 0);
>>      if (addr == MAP_FAILED) {
>>          perror("mmap");
>>          exit(EXIT_FAILURE);
>>      }
>>
>>      snprintf((char *)addr, HUGEPAGE_SIZE, "Hello, Huge Pages!");
>>
>>      printf("%s\n", (char *)addr);
>>
>>      if (munmap(addr, HUGEPAGE_SIZE) == -1) {
>>          perror("munmap");
>>          exit(EXIT_FAILURE);
>>      }
>>
>>      return 0;
>>   }
>>
>> Result without fix
>> ==================
>>   # cat /proc/meminfo |grep -i HugePages_Free
>>   HugePages_Free:       20
>>   # ./test
>>   mmap: Permission denied
>>   #
>>
>> Result with fix
>> ===============
>>   # cat /proc/meminfo |grep -i HugePages_Free
>>   HugePages_Free:       20
>>   # ./test
>>   Hello, Huge Pages!
>>   #
>>
>> V2:
>> Added vm_end_gap() check.
>>
>> V1:
>> https://lore.kernel.org/all/20240705071150.84972-1-donettom@linux.ibm.com/
>>
>> Reported-by Pavithra Prakash <pavrampu@linux.vnet.ibm.com>
>> Signed-off-by: Donet Tom <donettom@linux.ibm.com>
> Please use "hugetlbfs:" as subject prefix. No need to spell out full path.
>
> Otherwise,
>
> Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
>

