Return-Path: <linux-kernel+bounces-246029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 08FEB92BCE7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 16:28:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B10C71F229D8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 14:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABDDD1940B2;
	Tue,  9 Jul 2024 14:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZvgKn3I8"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3407015749F
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 14:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720535247; cv=none; b=Vrnfu05cXM6ckf8ZgKnadBh49gMhNU4wecT1fSynkOpcr+dl957Yr3BC7gYhIMpO66wxVgKVvWsj6IGmRRCFG49TKo3zorOj9bBQyIz340fIT6qq80HJYhUITCCtWumtCs6Sz3d8moiKocGcIcV8cA+nE7rSkkI4aFHOe9ls7F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720535247; c=relaxed/simple;
	bh=Y6OoUtinpMETnWd0YGmkmPcAttvftyJBVsRduasg6Cc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UchxVfkJ144p5m4u+x86f7nlgGPEOgBvEKYzkwUU8JZUViIXZl3r1D7D9FAyPo41jyA+SASypNoIW9bs+UzhHxZnMC6kzimNm3sjPlelArHYrvevfgt5ELFhh8QY0a7xrq+r3zyInImfM6mpQnPrVd7AovydWuIXetUmfwH+Cww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ZvgKn3I8; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 469Comf9030013;
	Tue, 9 Jul 2024 14:27:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=Y
	6OoUtinpMETnWd0YGmkmPcAttvftyJBVsRduasg6Cc=; b=ZvgKn3I8+ks5Lga2O
	9OBuGcCkNS0YfGY3z0LVe4VMAJgh12W/kK8dr6k1TKfN9ku8NW3LFf7ped21jty9
	IqjUohSxpV+c1v3CvOvjt9fEdNl8F8uyzxmZhPChld21ue9QU62YrvvnohQJEbOH
	Cadsg0BH6BxaaJyp+fEjM7H1suEfE1OAOTTWZLlSQh+6a6ix6Volq/J7jBhHVSun
	lfJjBKmqaqO8SqiQ65R8zz8zezea/P5/AYCJVGk62qaIIfydkvqKbf7J+Cnzbzgs
	gHFIBQgsW/zKVo6UheSkQFleU/y8NkGh0Io6fYs3OusFhMFk8YdvWq8EieTempLI
	CNqpw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 408nuxab1x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jul 2024 14:27:10 +0000 (GMT)
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 469ER9aJ013428;
	Tue, 9 Jul 2024 14:27:09 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 408nuxab1v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jul 2024 14:27:09 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 469D8fsB006896;
	Tue, 9 Jul 2024 14:27:08 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 407jfmcnqj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jul 2024 14:27:08 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 469ER5Mn49676944
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 9 Jul 2024 14:27:08 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E79AF5807B;
	Tue,  9 Jul 2024 14:27:03 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 290F158060;
	Tue,  9 Jul 2024 14:26:59 +0000 (GMT)
Received: from [9.171.46.21] (unknown [9.171.46.21])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  9 Jul 2024 14:26:58 +0000 (GMT)
Message-ID: <978add3e-754c-4519-a511-117051519a70@linux.ibm.com>
Date: Tue, 9 Jul 2024 19:56:57 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
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
 <dc4a8671-b8c2-484f-a83c-03bfc1fbe078@linux.ibm.com>
 <Zo1DEjDawvmeqwRH@localhost.localdomain>
Content-Language: en-US
From: Donet Tom <donettom@linux.ibm.com>
In-Reply-To: <Zo1DEjDawvmeqwRH@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: jh-qzAVYjFfZft_wE6GxEbdUmGzM2d8q
X-Proofpoint-ORIG-GUID: 9-30sL8YaU3OqFBW56jR87MfhEyhmXlV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-09_04,2024-07-09_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 impostorscore=0 mlxscore=0 lowpriorityscore=0
 clxscore=1015 suspectscore=0 bulkscore=0 mlxlogscore=575 phishscore=0
 malwarescore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407090093


On 7/9/24 19:32, Oscar Salvador wrote:
> On Tue, Jul 09, 2024 at 07:14:38PM +0530, Donet Tom wrote:
>> Thank you Oscar.
> Hi Donet,
>
>> The issue I am trying to fix will also get fixed by this new changes right.
>> So should we drop my patch or should we continue it?
> I would keep this patch as it is easier to backport as a small fixup.
OK thanks.
>
> Thanks
>

