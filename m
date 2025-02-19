Return-Path: <linux-kernel+bounces-521809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D30E6A3C286
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 15:50:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BF843BA328
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 14:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4CAC1F419B;
	Wed, 19 Feb 2025 14:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CyR4X7pU"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8BA18A959
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 14:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739976469; cv=none; b=P3ci2f6N2RfkVqvbFnz750ObPoTXxLQDwXhxL9zip4pPOF69mFrHnLv1eMKcEQuCspg8Ftvex6p0L44uV2nLr5OMqjix7ckR0NsabRGXwC49up/V6xUZNnGc76BrCZy70fLbwDcz++K0KIknns084NadYKFQRcGZGSiObyRQxP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739976469; c=relaxed/simple;
	bh=VWAB+5wF246B3sL2qm5eHiqciG27jLu7YB36Xc4E6Ts=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IqI8pWcmrEyz5tiwbFiMmnNrBvIEHfVoIKAJyN0HYOoz5ZwTXAjvMTsR/9rCSGLwG5zrXBxz2RaUhc/MDa902S4F37bgtHoa0at3z/nJyLrJBajj8jm/6pW//KF1J9Q/pa4kBvcoCCxjLnUPnQHJF5Hod+lPAxqT4+2E1sdh0wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CyR4X7pU; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51J75NsE012080;
	Wed, 19 Feb 2025 14:47:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=allqKi
	ueGaAXBRJ4vpQBjpSHtbMt9C7zoJnCo9rTS9k=; b=CyR4X7pU+uzDN3Lbv5WQ33
	uIB3iPWTGHPtXsA0t+TY7MsQyE9LoGNsv4pEKLZAX1QzumQFoXAJK1h+GFH02gs1
	qv3Qq42BrnmjbCfnTRIo2cxBquIdZl056XQrYQ33U92prBjGNUyNB8twxk5/64oe
	xg17R8HKz18n4+VUZQoI5Fn3tJ9tkz0f0kAfZweYCGii+nIuvxOJOLs/AmhoRh1f
	3We7yHC5q0+YW5STlQu7+a1nlSmL+nASqOGFStCPSheLfovMcsYPQPVSdqzjSlcS
	rm1/vS5Q9nFvrDhW9AA24fhIXpbKBdu3IELqPyNMsb5CVz4JItaUsJBOJE9sKIfg
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44w5c9bee9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Feb 2025 14:47:31 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51JDqXdf029296;
	Wed, 19 Feb 2025 14:47:30 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44w024cjj7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Feb 2025 14:47:30 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51JElUPE20251320
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Feb 2025 14:47:30 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5855C5804E;
	Wed, 19 Feb 2025 14:47:30 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0C57958054;
	Wed, 19 Feb 2025 14:47:27 +0000 (GMT)
Received: from [9.61.184.147] (unknown [9.61.184.147])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 19 Feb 2025 14:47:26 +0000 (GMT)
Message-ID: <2ff87386-c6db-4f2e-be91-213504d99a78@linux.ibm.com>
Date: Wed, 19 Feb 2025 20:17:25 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: remove multipath module parameter
To: Keith Busch <kbusch@kernel.org>, John Meneghini <jmeneghi@redhat.com>
Cc: hch@lst.de, sagi@grimberg.me, bmarzins@redhat.com,
        Bryan Gurney <bgurney@redhat.com>, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org, Marco Patalano <mpatalan@redhat.com>,
        axboe@kernel.dk
References: <20250204211158.43126-1-bgurney@redhat.com>
 <7c588344-f019-4939-8a93-0a450481d4bc@redhat.com>
 <Z7Sh-3yHbXVmRbNL@kbusch-mbp>
 <8a1730a1-1faf-4722-99e1-c3a85257b6f4@redhat.com>
 <Z7TARX-tFY3mnuU7@kbusch-mbp>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <Z7TARX-tFY3mnuU7@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 5sDdhRf2rzB5W1cUsG7tc1BiCsSpIlov
X-Proofpoint-GUID: 5sDdhRf2rzB5W1cUsG7tc1BiCsSpIlov
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-19_06,2025-02-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1011 bulkscore=0
 malwarescore=0 phishscore=0 mlxlogscore=999 adultscore=0 impostorscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502190115



On 2/18/25 10:45 PM, Keith Busch wrote:
> On Tue, Feb 18, 2025 at 11:31:58AM -0500, John Meneghini wrote:
>> On 2/18/25 10:06 AM, Keith Busch wrote:
>>> On Thu, Feb 13, 2025 at 03:37:28PM -0500, John Meneghini wrote:
>>>> Keith, Christoph and Sagi,
>>>>
>>>> This patch has been fully tested and analyzed by Red Hat's QA group and no
>>>> unexpected side effects or regressions have been found. Both NVMe/FC and NVMe/TCP
>>>> have been tested. Our QE engineer has asked me to report this upstream.
>>>
>>> What's the harm in leaving the parameter? *I* use it so I can test both
>>> ways without needing to compile multiple kernels.
>>
>> LOL.  We've been talking about this since 2017. The goal has always been to remove support for DMMP with NVMe.
> 
> I understand that disabling nvme native mp it is required for device
> mapper, and I get you want to prevent the possibility of anyone using
> dm-mp with nvme, but that isn't the only user that wants to see all
> namespace paths.
>  
Agreed! I do have nvme multi-controller disks and I toggle multipath module parameter to
test it both ways. One with each individual path to a shared namespace and another with 
a single head node path and then let IO policy determine which path to choose for sending
IO to disk. 
In fact, we have few nvme blktests which only runs if device is configured with single path
and so testing it on multi-controller nvme disk would require us to turn off multipath module
parameter. In that way this parameter is very handy. My typical way of 
toggling this parameter is:
1. disable multipath
# rmmod nvme
# rmmod nvme_core
# modprobe nvme_core multipath=0
# modprobe nvme

Now I could run all nvme blktests which require us disable multipath.

2. enable multipath:
# rmmod nvme
# rmmmod nvme_core
# modprobe nvme_core multipath=1
# modprobe nvme

Now if we get away with multipath parameter then it means we have to re-compile kernel
disabling CONFIG_NVME_MULTIPATH option and that's something we may want to avoid, 
if possible.

Having said that I'm not against this patch however we certainly have users who would 
be using multipath parameter and taking away this parameter may break those user 
application. So I'm wondering why is it not possible for RedHat to let their customer
know the fact that starting with RHEL-10, we don't support DMMP for NVMe device even
though the multipath module parameter is present?

Thanks,
--Nilay




