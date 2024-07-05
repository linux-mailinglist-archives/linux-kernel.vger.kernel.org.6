Return-Path: <linux-kernel+bounces-242742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16B08928C75
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 18:48:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B48481F24D29
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 16:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 490F016D30D;
	Fri,  5 Jul 2024 16:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XrzlpYRI"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 272F816A956
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 16:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720198129; cv=none; b=eZ9Qz9XaL5nGbK4esjQPAipm82rLf5lmmYdZmwAtfhjJcdtNIuApUMbO6EdwnSCJlM/Lwn8xZ8vD4ch7BgafjE3g851nSnSx0vTPJmaelEpjIyAbVWxlyNv662qb33QhG5Xl3Q5h6q5OZc5DrmP7XQ2fvxm69o+qndqqSCDooX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720198129; c=relaxed/simple;
	bh=pfBpWEMmzVFUDopMkHG1PutRvRZVFo9BARNRDYrFXtE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eTVGYTvCsvlRZcMtSG0GThvlW8wFIltH2O7NmV0Euf4vb5ACYMLI9ZPZZBUvVcjpmNkcGSV6ILEYUcnSVvKC6EyH0zFnJR/X97HBPVMqXvf/h5Cwu0g/FMNBH2MTafkqQfwbjo6ImQIGX7hK4r1ufuMTabMYSJFleiowXgK8vQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=XrzlpYRI; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 465GRR9t007184;
	Fri, 5 Jul 2024 16:48:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=a
	IdtEz/ceNHX6TjIUu0L4V6JPzYwy3OzJfwnmxjuk0o=; b=XrzlpYRI4fC2mqV/+
	Hkb8AcHue/X4i2kwMa/+2r5dwVdVI/8iH6aBT+ZbI94P1LCALGM19s/hU3U1vbdd
	bfIAidjDunLgbhlSRj8buSLNbTrXAndkQal83vjHWBlPW5N6tEOg7kY5ecEcthn8
	vLt3rykROTJUarmMZDC7xhgxujjYVx0Z9qjR+FO5c8lBfc+Kcc23HJeG9nVHquFv
	JWlx62Yc3FhcuBsq0Cbs3Y7tgaNeolgWPRFTRCulK3AmQGv2DZtETFNOO97L853C
	ddJDcIYYnYw7b4oAqgC/x5zNmMyUe/eUYHucuvvqROLQ//1ZCf37VJDoz8gvNRhV
	cc+8Q==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 406j6a0by8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Jul 2024 16:48:19 +0000 (GMT)
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 465GmIcH006669;
	Fri, 5 Jul 2024 16:48:18 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 406j6a0by6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Jul 2024 16:48:18 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 465E8Mss026393;
	Fri, 5 Jul 2024 16:48:17 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 402wkqees2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Jul 2024 16:48:17 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 465GmED411993614
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 5 Jul 2024 16:48:16 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 361FC58062;
	Fri,  5 Jul 2024 16:48:14 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CFDCC58068;
	Fri,  5 Jul 2024 16:48:08 +0000 (GMT)
Received: from [9.179.4.203] (unknown [9.179.4.203])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  5 Jul 2024 16:48:08 +0000 (GMT)
Message-ID: <ed11cb24-acc6-4d1d-a559-0708cdc4786b@linux.ibm.com>
Date: Fri, 5 Jul 2024 22:18:01 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs/hugetlbfs/inode.c: Ensure
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
        Alexei Starovoitov <ast@kernel.org>, Andy Lutomirski <luto@kernel.org>,
        jj@black.fi.intel.com
References: <20240705071150.84972-1-donettom@linux.ibm.com>
 <n5jwq5uq3hrgu3ksyg34tjtl3hw5izpc5s5lac4pkjfjt2tf22@co5rgjcznsma>
Content-Language: en-US
From: Donet Tom <donettom@linux.ibm.com>
In-Reply-To: <n5jwq5uq3hrgu3ksyg34tjtl3hw5izpc5s5lac4pkjfjt2tf22@co5rgjcznsma>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: B5HTZE9k8iN5lvA3x2_wO1SGwrYIw4QR
X-Proofpoint-ORIG-GUID: BaRYynCNqe_F5ZTnlMl55fvDEov7zx1V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-05_12,2024-07-05_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 phishscore=0 priorityscore=1501 clxscore=1011 spamscore=0 malwarescore=0
 impostorscore=0 suspectscore=0 mlxlogscore=771 lowpriorityscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407050118


On 7/5/24 17:53, Kirill A . Shutemov wrote:
> On Fri, Jul 05, 2024 at 02:11:50AM -0500, Donet Tom wrote:
>> diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
>> index 412f295acebe..428fd2f0e4c4 100644
>> --- a/fs/hugetlbfs/inode.c
>> +++ b/fs/hugetlbfs/inode.c
>> @@ -228,7 +228,7 @@ generic_hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
>>   
>>   	if (len & ~huge_page_mask(h))
>>   		return -EINVAL;
>> -	if (len > TASK_SIZE)
>> +	if (len > mmap_end - mmap_min_addr)
>>   		return -ENOMEM;
>>   
>>   	if (flags & MAP_FIXED) {
>> @@ -240,7 +240,7 @@ generic_hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
>>   	if (addr) {
>>   		addr = ALIGN(addr, huge_page_size(h));
>>   		vma = find_vma(mm, addr);
>> -		if (mmap_end - len >= addr &&
>> +		if (mmap_end - len >= addr && addr >= mmap_min_addr &&
>>   		    (!vma || addr + len <= vm_start_gap(vma)))
>>   			return addr;
>>   	}
> There's more difference with generic_get_unmapped_area() than what you are
> fixing. I think we also need vm_end_gap() here.
Thank you for your comment. I will add this change and send V2.

-Donet
>
> Hugetlb code duplication is annoying.
>

