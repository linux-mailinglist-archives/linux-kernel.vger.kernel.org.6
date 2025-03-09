Return-Path: <linux-kernel+bounces-553230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 253F0A58614
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 18:24:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8FF27A53B8
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 17:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFE4E1DF756;
	Sun,  9 Mar 2025 17:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nYsHWZq0"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0AC1DC9AB
	for <linux-kernel@vger.kernel.org>; Sun,  9 Mar 2025 17:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741541032; cv=none; b=mIvLZQPq/3MfYEwgDcIpv5uGIra3uhFtgGYgYSeD779QUl18gzeclg8lwM6vxGgePJdxJTBAXzMnTQWcBX9iGYM7t7Fa2wUeSTphObxkYBKHaikeP7/14UoYs4St+Lanycyo1mbyOVRySIb2wtQY3Ptm8IfSFULswpQOIawTQiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741541032; c=relaxed/simple;
	bh=Sn4hVcxAE+Kinfq/pEGM3JWrJwXvS/+f45xUn/rYrMQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cIN/BYHOk9w3D7xDezF820CMDshId4PoJqdI/c/wIdWzJlYpu2sZypPr9PQ70vX7zDn8j+FUzk4Cr9d7bxYnU9ASWV/SRxVy9/nsbt7rQgvi8Jtedy7pK+dXEDsvhleZAR90/h+gCuu7UTkXgT7iuEIgkzMAhMoJ2fOA0q3lDs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nYsHWZq0; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 529EJ9Zc008865;
	Sun, 9 Mar 2025 17:23:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=PtdvZx
	kTWg+hn6Jwp141v7J4xwVGDYz1fymKONyuMBM=; b=nYsHWZq0oBObYD0Zo73M+y
	T/vk08GBYur2h0a24n9TNfDgtvsK2k0nKd0KNZtBZ1Dld96Hvil3uDY5cpEfKyNT
	m06lAMzLPyPrj+gknl5K7UQv9sE0TEBrH9WdpQyTUn7YK3Y88q6U+I6Ae8PNHE/M
	iSHxphtY7R7SYlw6WtyhOfGQAhTTkzTUzevK60kQaqRJ/5Al4F9S/kUuvVyqJ+mV
	bcqvGm7PrXRXaOuo1or3YiTR2RB9vb3y7zE3cCsLLS8d2lbReJ5dWFouPYFZOpfF
	QpwA3shrkBaJFsb1R+32HNb5kYyb17bUTnc6upZ/0cfWXr7SpMLWKcMmRVFuWP7g
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4593c8t0fx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 09 Mar 2025 17:23:27 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 529GkqoR027631;
	Sun, 9 Mar 2025 17:23:26 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4591qkasaw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 09 Mar 2025 17:23:26 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 529HNPsQ23593718
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 9 Mar 2025 17:23:25 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0A93A58054;
	Sun,  9 Mar 2025 17:23:25 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E05B55805E;
	Sun,  9 Mar 2025 17:23:20 +0000 (GMT)
Received: from [9.61.180.35] (unknown [9.61.180.35])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Sun,  9 Mar 2025 17:23:20 +0000 (GMT)
Message-ID: <69cdaf9d-2fb4-4ee0-9c32-cc946405a23a@linux.ibm.com>
Date: Sun, 9 Mar 2025 22:53:19 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: remove multipath module parameter
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>,
        Sagi Grimberg <sagi@grimberg.me>, John Meneghini <jmeneghi@redhat.com>,
        bmarzins@redhat.com, Bryan Gurney <bgurney@redhat.com>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Marco Patalano <mpatalan@redhat.com>, axboe@kernel.dk
References: <Z8hrJ5JVqi7TgFCn@kbusch-mbp> <20250305235119.GB896@lst.de>
 <Z8jk-D3EjEdyBIU5@kbusch-mbp> <20250306000348.GA1233@lst.de>
 <1ffebf60-5672-4cd0-bb5a-934376c16694@suse.de>
 <20250306141837.GA21353@lst.de> <Z8m4vzE36UHWjwep@kbusch-mbp>
 <20250306151654.GA22810@lst.de> <Z8pB9jQALxMN6WaA@kbusch-mbp>
 <b2c9df64-0afc-46cd-9e8d-6a3f41a4f1c7@linux.ibm.com>
 <Z8sUB2bbbMsurZmu@kbusch-mbp>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <Z8sUB2bbbMsurZmu@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 97Nwgp6iI6A8K4yvFChtNQReyNSrkjeF
X-Proofpoint-GUID: 97Nwgp6iI6A8K4yvFChtNQReyNSrkjeF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-09_06,2025-03-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 mlxlogscore=999 priorityscore=1501 lowpriorityscore=0 mlxscore=0
 impostorscore=0 bulkscore=0 clxscore=1015 spamscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503090138



On 3/7/25 9:13 PM, Keith Busch wrote:
> On Fri, Mar 07, 2025 at 08:49:09PM +0530, Nilay Shroff wrote:
>> On 3/7/25 6:16 AM, Keith Busch wrote:
>> I think always creating multipath head node even for the disk which doesn't 
>> have CMIC/NMIC capability should be useful. That way, we may then be able 
>> to remove multipath module parameter? In fact, you already mentioned about
>> it in one of your previous message. I see two approaches (one of them you 
>> proposed and another one Christoph proposed: 
>> https://lore.kernel.org/linux-nvme/Y+1aKcQgbskA2tra@kbusch-mbp.dhcp.thefacebook.com/). 
>>
>> Maybe in first cut we should create multipath head disk node always for 
>> single/multi ported NVMe disk. Later we may enhance it and allow pinning the 
>> head node for hotplug events so that head node dev name remains consistent 
>> across disk add/remove hotplug events.
> 
> It honestly has potential to solve some real problems, like
> re-enumeration triggered by a link reset on an in-use drive. You'd
> currently need to close the old handle and open a new on, even though
> it's the same device. It may not even be possible to do that if that
> device contains your root partition, and then you can only power cycle.
> 
> The downside is we wouldn't get the short cut to blk_mq_submit_bio. We'd
> instead stack that atop an indirect call, so it's not free.
> 
Yes agreed however it seems advantages of using an indirect call outweighs 
using the short cut to blk_mq_submit_bio. Moreover it seems the cost of 
indirect call is trivial because we already cache the nexthop. 

I integrated your proposed patch (with few trivial additional changes on top) 
and I see that it's coming out nicely. I ran few tests and confirmed it's 
working well. However, in the proposed patch we *always* delay (~10 sec) the
removal of multipath head node. That means that even while removing the
nvme module (rmmod nvme) or if user delete/detache the namespace, we delay 
the removal of head node but that may not be what we want. So I'd suggest 
instead, delayed removal of multipath head not shall be configurable using a
sysfs attribute. With this attribute then we shall let user opt for pinning 
the head node (with optional delayed time as well?). And it's only when user 
shows the intent to pin the node we should delay its removal. This is what 
exactly (pinning of head node) Christoph's proposed patch implements. So I'd 
suggest a bit of amalgamation of yours as well as Christoph patch to implement
this change. 

If you and Christoph are busy with other work then in that case I'll be glad
to pursue this further if you agree.

Thanks,
--Nilay


