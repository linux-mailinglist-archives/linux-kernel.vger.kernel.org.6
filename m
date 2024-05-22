Return-Path: <linux-kernel+bounces-186070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91F9C8CBF73
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 12:48:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47BA4283956
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 10:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 735A4823AF;
	Wed, 22 May 2024 10:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rhQYOwYU"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A912F79B9D
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 10:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716374908; cv=none; b=Lfssc4nBBDwaigbaaMcOyleq/cnzodAiWPe0xHyF4kXlQuEWDqMNnguYLurXej+YpZj8tF0hVCI4MPgQsSi2y+Aoa6GZrUpTNVQ2brnDUgX6iG8ZI8S/TBmn3WjrL+AXdjn9Cr6KeW4HuV2ogfA0unA+3u0hC4lJd3jLV8SYxJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716374908; c=relaxed/simple;
	bh=jZOGcaE8g5gnpZQ5VKsDLAtpmPBsMO2QHuy9tbDm/P8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tn3BXQzRqtzIV459o+iLehJwd+AkPAHDKMXAUrIDAjHKBt12QV8zZEWQIk9anrTHM8nBGyA0ONeO2gB0KI6nptHVZEIr7QHGElhRcuInIi58b0hm50ZXLJoLZXQmotC/Qu9UmNRgCPSdkU4Ptq2w38MVMd0zgZ1ijkU+xDn/OvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rhQYOwYU; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44MAmAj7007115;
	Wed, 22 May 2024 10:48:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=MnO5tpsR4r3+7NynhxraWxXx8JLL5nemdwrIGkFkwkA=;
 b=rhQYOwYUmcE0IIGiFsqvxLMF+zaBZP8oURoSOUOO//fvpXhrLN9X7OC1TEclnl7UttLJ
 wCXa1EPoInpOx8FaZI4itM5Rae4hdRTVmh0zOBmNlUK/lih+Adzjd/RIoIfwMpCz7BWp
 t7E/lW3J/UAqfoS9c9T9+JvUHHqLol70AcO1MrkXtUSHEsfrcHgQrBCVmj6oIwTGxFnS
 RTJWD69DRVCvGTb8L9fuetlyRGytzcKy7kCA9dbvUPGZiEaGtfRM0FluYVQJwbN89Lnq
 iY/wXtaE8kor1aiLsq2X8yH9dPpHZsRPOAb0IG4iSQyXn/Cc8mGy7InoWJqnO9Ytzn+a xg== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3y9f90g00j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 May 2024 10:48:09 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44MAm9d9006936;
	Wed, 22 May 2024 10:48:09 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3y9f90g00c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 May 2024 10:48:09 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 44M7LXW8026457;
	Wed, 22 May 2024 10:48:08 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3y785mkc6d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 May 2024 10:48:08 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 44MAm5Au29033210
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 May 2024 10:48:07 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6FA3B58062;
	Wed, 22 May 2024 10:48:05 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5E05458064;
	Wed, 22 May 2024 10:48:02 +0000 (GMT)
Received: from [9.109.198.166] (unknown [9.109.198.166])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 22 May 2024 10:48:02 +0000 (GMT)
Message-ID: <b3ea2812-1110-47f6-88f0-0e9c028c350f@linux.ibm.com>
Date: Wed, 22 May 2024 16:18:00 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] nvme: multipath: Implemented new iopolicy
 "queue-depth"
To: John Meneghini <jmeneghi@redhat.com>, Sagi Grimberg <sagi@grimberg.me>,
        kbusch@kernel.org, hch@lst.de, emilne@redhat.com
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        jrani@purestorage.com, randyj@purestorage.com, hare@kernel.org
References: <20240520202045.427110-1-jmeneghi@redhat.com>
 <20240520202045.427110-2-jmeneghi@redhat.com>
 <945416af-3f8b-40b5-9681-49973beb2cb2@linux.ibm.com>
 <3b8d33db-f2c3-469a-bfa0-8fc52594f243@grimberg.me>
 <95fe3168-ec39-4932-b9fc-26484de49191@linux.ibm.com>
 <da35bc8b-6813-42c8-b446-8a07b08db156@grimberg.me>
 <073ae18a-a80e-4a95-a093-36210a3bb230@grimberg.me>
 <ba2a6973-ba58-492c-9785-31e50ab40957@grimberg.me>
 <8f5ad047-be0b-471c-a708-f2bc464d29ef@redhat.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <8f5ad047-be0b-471c-a708-f2bc464d29ef@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: sHJy-xqg1_PbHanHO_TabkWuMSHBFmlr
X-Proofpoint-ORIG-GUID: BJyu1VUwQFlY-iwp6RItYrNQYy54VONh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-22_05,2024-05-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 clxscore=1015
 malwarescore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 phishscore=0 impostorscore=0 bulkscore=0 spamscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405220074



On 5/21/24 20:14, John Meneghini wrote:
> On 5/21/24 06:16, Sagi Grimberg wrote:
>>>>
>>>> Exactly, nvme_mpath_init_ctrl resets the counter.
>>>
>>> Except you're right, the counter reset needs to move to nvme_mpath_init_identify()
>>> or some place that is called on every controller reset.
>>
>> This however raises the question of how much failover/reset tests this patch has seen...
> 
> I has received quite a bit of testing with failover and controller resets.  I shared some of the testing that was done at LSFMM last week.
> 
> It has received enough testing to make me confident that this code is safe.  That is: it won't panic, corrupt data, or otherwise do any harm.  We believe the error paths will not be affected by this change... but I agree that running the error paths could negatively impact the accuracy of the nr_active counters... which could lead to an inaccurate outcome with the queue-depth policy.
> 
> I agree the nr_counter initialize should move to nvme_mpath_init_identify(), or maybe be done there in addition to in nvme_mpath_init_ctrl(). I'm will to make that change now... if that's what people want.  I don't think it would require any extensive retesting.
> 
> /John
> 
> 
I think with Keith's recent proposed patch for fixing io accounting on failover, the 
nvme_mpath_end_request() would be called even for cancelled IO and so the nr_active 
counter shall be adjusted correctly for cancelled IO requests. Having said that, IMO
you shall consider moving initialization of nr_active counter to nvme_mpath_init_identify() 
as that's common function invoked from regular controller initialization code path as well 
the reset code path.

Thanks,
--Nilay

