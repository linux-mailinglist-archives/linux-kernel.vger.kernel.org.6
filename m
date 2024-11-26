Return-Path: <linux-kernel+bounces-422496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C66829D9A5D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 16:24:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD3BDB2A1D8
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 15:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A468C1D47DC;
	Tue, 26 Nov 2024 15:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GxBIehmb"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6CA17591
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 15:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732634464; cv=none; b=IesY7xWNBjvozP7tn0REfbcaJVFZ0U+4jYhJg6zEmICmI0OyfWRQyrvjRGK5ajnMwLd5kiT/dw17Op5z5GC59Zk4ZkY3A9lAVsPcLSeNgRm4nRFBYblmxGc3b+DSiC84ur4V+Cjx3YyDrFc64KZ6ZZVus3fL5FJ7FH/NtEctus4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732634464; c=relaxed/simple;
	bh=ouWttTo0AhF1OqG53WNkuxUUpcHxoGrlNCLrfAq57iY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aKHCfqNkqJlk4D2OfrGWDgLzxvSGu6bGIFuvAImT1fZdwKnUfQV0MqChRD0IrSD3duPZ16keZPCjinZILpnSQSEDByMyRwrzJevE+O34cIOCtMdN5Qb28qTR0kXN6QmX2/33VaVHvSL2iYTT1do+75Cs7OQnT861NbWT6r20R0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=GxBIehmb; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AQD8XtR024921;
	Tue, 26 Nov 2024 15:20:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=a/41Cw
	2xsgHHvD6/L1ZIPHaAhRs0kYK1wbiTLE89PDY=; b=GxBIehmbDJmTIeKBxyqskd
	Lp2bYDBR06lKr/+XjIKZU2mqBqqkPgouonXKI3u7ny8nVQbyENRu6ZzvAB/GYzoO
	KHaGUExQiy3vbt0T9I2RFvFnDQgh+q2EvxgLz9oTR6nrret0TmvD3dVSZNuNtQ1d
	mspRlXToNmXwJynQ63BAUjisQcSXjzdFXBTy+PhWxX9Cm5e+ZqLpqA7gwAi5r8d9
	xLBRHSvzyIjjUcOaAw0Zed7X9hi2sZUOi+1NBazOiJCXO2bfWtyeoAqK+Pun6MBN
	7AVf43TgxrzS6hxoqzWza8IpN/mtOXWDXhk5xpchDDyQCnTeKjd6R2GryBzhIUWw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43386neqs3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Nov 2024 15:20:46 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4AQEnxkh015962;
	Tue, 26 Nov 2024 15:20:45 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43386neqs1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Nov 2024 15:20:45 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4AQE04xx008861;
	Tue, 26 Nov 2024 15:20:44 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 433scrvqxy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Nov 2024 15:20:44 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4AQFKiqd21430904
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 26 Nov 2024 15:20:44 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DE8175805F;
	Tue, 26 Nov 2024 15:20:43 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4B2E158055;
	Tue, 26 Nov 2024 15:20:41 +0000 (GMT)
Received: from [9.171.29.84] (unknown [9.171.29.84])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 26 Nov 2024 15:20:40 +0000 (GMT)
Message-ID: <b62d1b50-d20b-458f-8916-2abe34fe3d1a@linux.ibm.com>
Date: Tue, 26 Nov 2024 20:50:39 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Removed unused argument vma from migrate_misplaced_folio
To: Baolin Wang <baolin.wang@linux.alibaba.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, David Hildenbrand <david@redhat.com>
Cc: Ritesh Harjani <ritesh.list@gmail.com>, Zi Yan <ziy@nvidia.com>
References: <20241125075731.176573-1-donettom@linux.ibm.com>
 <510ac095-89c5-4c3d-b5b7-015d028f7ed2@linux.alibaba.com>
Content-Language: en-US
From: Donet Tom <donettom@linux.ibm.com>
In-Reply-To: <510ac095-89c5-4c3d-b5b7-015d028f7ed2@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: LxnG_fsQXoCJtinHPLFjYNjTjaoaK_sb
X-Proofpoint-ORIG-GUID: F-1IicA2BkRA-SzMM6hTOyujKkqJCuUX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 mlxlogscore=620 suspectscore=0 impostorscore=0 malwarescore=0 spamscore=0
 clxscore=1015 adultscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2411260121


On 11/26/24 19:28, Baolin Wang wrote:
>
>
> On 2024/11/25 15:57, Donet Tom wrote:
>> Commit ee86814b0562 ("mm/migrate: move NUMA hinting fault folio
>> isolation + checks under PTL") removed the code that had used
>> the vma argument in migrate_misplaced_folio.
>>
>> Since the vma argument was no longer used in migrate_misplaced_folio,
>> this patch removed it.
>>
>> Signed-off-by: Donet Tom <donettom@linux.ibm.com>
>
> Better to add 'mm:' prefix for the subject line to identify the 
> subsytem, otherwise look good to me.

Thank you. I will send a V2 with the prefix.

>
> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>

