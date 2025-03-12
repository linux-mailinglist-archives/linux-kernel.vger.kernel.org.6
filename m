Return-Path: <linux-kernel+bounces-558006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A9919A5E056
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 16:27:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AD551895B59
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 15:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 302CD23F38A;
	Wed, 12 Mar 2025 15:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="LNPHEaG9"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 186A11422DD
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 15:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741793245; cv=none; b=LOPsdd7app/PFEY4l1kXWcovApIm86rgu177ZdoXn0ziMdB8Q+gw5kkB393oN51MTN4u8p6C+RpUHyn74b+QJXc44sOTT//zE43NwCchIqV3QQrwgadIklKxxItb9vC70fkWjXi0WEMKDaPeVnRRQqfD42SjklDelN1d5dZKrSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741793245; c=relaxed/simple;
	bh=wiTciTG7c0gbv9O4jp5k8kB2u1ZVph3PvRvBPEV6tas=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RrU4bbfLckuR8YMYJD6SvKOxByIa/My3YPBhkPjFJQBv2buZBlBm/GD8A2cSCdicfqmXjt7BZ6KoZW/TLjaxEdrbIv08fINXsbouEVcZjNNGw6TQ+XIY9OkJka9Db9I7tAAeemHJMJDWkCjfWvUWctkciOBnk1rXMDnwGY+Z/Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=LNPHEaG9; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52CCdpoA002855;
	Wed, 12 Mar 2025 15:27:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=SSN6kl
	QU3Lfa89SnGqZVCjQNXAaPadcQkryGW51WD28=; b=LNPHEaG9CCLUyol0cYsSf1
	Vjd7HHc1x/ZgFemjUnLqhwEw69ieadVX1w7tSxO84w1KLnjMGc1Wb7Po1cAtZ9mG
	+33hdKrPrBbQp+tiZjIfzbgYssyCzkILHE8Ye2KCTpJqoekGYF6ExEIOc7A3ueX2
	GZ1AH5OOWvzMfFwPicLqbAH1J1KPUju/wvwL56ogm/CcTQsOAk7feTAoak71/Iqa
	QgBbRy3dF9c0QfGbh4KDz8ZZ/LaOFwZ99JdDkZ8/+uRHz5Y5FRlpGoRMv4k/cmmX
	OYQTT7hmogguE/3oQBh0CA6FwpZN7ipeV7Ta2ZiG5OXQ3WJL/R+17DWcXcW2Wj5A
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45avbpmps7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Mar 2025 15:27:06 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52CDfCRY026099;
	Wed, 12 Mar 2025 15:27:05 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 45atspct10-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Mar 2025 15:27:05 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52CFR4QO57868552
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Mar 2025 15:27:04 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3244458052;
	Wed, 12 Mar 2025 15:27:04 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 738675805A;
	Wed, 12 Mar 2025 15:27:00 +0000 (GMT)
Received: from [9.61.69.177] (unknown [9.61.69.177])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Mar 2025 15:27:00 +0000 (GMT)
Message-ID: <d7d284ac-a8d1-4f9d-901c-424dccc5a1b1@linux.ibm.com>
Date: Wed, 12 Mar 2025 20:56:58 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: remove multipath module parameter
To: John Meneghini <jmeneghi@redhat.com>, Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>,
        Sagi Grimberg <sagi@grimberg.me>, bmarzins@redhat.com,
        Bryan Gurney <bgurney@redhat.com>, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org, Marco Patalano <mpatalan@redhat.com>,
        axboe@kernel.dk, Randy Jennings <randyj@purestorage.com>
References: <Z8hrJ5JVqi7TgFCn@kbusch-mbp> <20250305235119.GB896@lst.de>
 <Z8jk-D3EjEdyBIU5@kbusch-mbp> <20250306000348.GA1233@lst.de>
 <1ffebf60-5672-4cd0-bb5a-934376c16694@suse.de>
 <20250306141837.GA21353@lst.de> <Z8m4vzE36UHWjwep@kbusch-mbp>
 <20250306151654.GA22810@lst.de> <Z8pB9jQALxMN6WaA@kbusch-mbp>
 <b2c9df64-0afc-46cd-9e8d-6a3f41a4f1c7@linux.ibm.com>
 <Z8sUB2bbbMsurZmu@kbusch-mbp>
 <69cdaf9d-2fb4-4ee0-9c32-cc946405a23a@linux.ibm.com>
 <01d799d1-fc93-4285-aa8f-89ac2d01478b@redhat.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <01d799d1-fc93-4285-aa8f-89ac2d01478b@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: r6vJbcw2bvB4WlR3SZtMe9f1qxIekOde
X-Proofpoint-GUID: r6vJbcw2bvB4WlR3SZtMe9f1qxIekOde
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-12_05,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 spamscore=0
 mlxlogscore=999 malwarescore=0 impostorscore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503120105



On 3/12/25 9:17 AM, John Meneghini wrote:
> On 3/9/25 1:23 PM, Nilay Shroff wrote:
>>> It honestly has potential to solve some real problems, like
>>> re-enumeration triggered by a link reset on an in-use drive. You'd
>>> currently need to close the old handle and open a new on, even though
>>> it's the same device. It may not even be possible to do that if that
>>> device contains your root partition, and then you can only power cycle.
>>>
>>> The downside is we wouldn't get the short cut to blk_mq_submit_bio. We'd
>>> instead stack that atop an indirect call, so it's not free.
>>>
>> Yes agreed however it seems advantages of using an indirect call outweighs
>> using the short cut to blk_mq_submit_bio. Moreover it seems the cost of
>> indirect call is trivial because we already cache the nexthop.
>>
>> I integrated your proposed patch (with few trivial additional changes on top)
>> and I see that it's coming out nicely. I ran few tests and confirmed it's
>> working well. However, in the proposed patch we*always* delay (~10 sec) the
> Have you tested this with a NVMe-oF controller... yet?
Not on real target. But tested it against blktests which has few NVMeOF 
test cases though it uses loopback interface.
> 
> Where did the number 10 seconds come from?
That was probably used as hard coded value for POC. However, we shall be able to
configure that.
> 
>> removal of multipath head node. That means that even while removing the
>> nvme module (rmmod nvme) or if user delete/detache the namespace, we delay
>> the removal of head node but that may not be what we want. So I'd suggest
>> instead, delayed removal of multipath head not shall be configurable using a
>> sysfs attribute. With this attribute then we shall let user opt for pinning
>> the head node (with optional delayed time as well?). And it's only when user
> 
> So be aware the TP-4129 is adding a CQT parameter which does almost exactly this.
> 
>> shows the intent to pin the node we should delay its removal. This is what
>> exactly (pinning of head node) Christoph's proposed patch implements. So I'd
>> suggest a bit of amalgamation of yours as well as Christoph patch to implement
>> this change.
> 
> Please cc: me on your patches Nilay, I'd like to test them with my NVMe-oF testbed.
> 
Sure, I will keep you in Cc when I send the patch. 

Thanks,
--Nilay


