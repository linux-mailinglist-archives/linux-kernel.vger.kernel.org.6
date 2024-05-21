Return-Path: <linux-kernel+bounces-184801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3EAC8CAC2A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 12:26:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74D21283851
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 10:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0BD2605CE;
	Tue, 21 May 2024 10:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DLgT5ypH"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 724466AF88
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 10:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716286997; cv=none; b=I3dOWJCpYYA+X8bx+8WpTroWZyhG/D7ljUxaYU5Q8K7lbuFa+qPWLZIYUkdmt580HFMIDfvguYllQAEJfOs/XpG4zu1+Kt2tlSIgC3xrzYK4qcnNssg8aOnq/ECoCO1mlXCVzUxF617Hr9hzugeRzOrkcn8AHdT70GP4j+PGNyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716286997; c=relaxed/simple;
	bh=TGipTdPHNHCLl97EfHA22CEaxmJ3omALfsBr9AA5n5Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F7TWXSNL5mVkpRrZK7j8Ytt0QKxTGE86GLfQeRTK25Os9iM8VgftgVEU538RFm7D77GqopDJHUon5TBWF8gJJ1abw/VXgaGTPdwdliXIuZZz1VuOPexsYdFs6kRqkirQb4GAsLU8+8q6f9f6e736a9RDly1NHMw9jiPJ/KcxGwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=DLgT5ypH; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44LALHUe026595;
	Tue, 21 May 2024 10:23:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=gYjBp8UDgCqwdbwnC4iAaXMYgYLYq/F7FqKFDgIavfg=;
 b=DLgT5ypHsJcwvtNGUUVL5G8WIfWLyPFbFy8nxs7+fxPqFvFsYNhvexuzXXelzTqf/xj+
 0v+nacg1EuQEb8rOm0C+hgYVyjmSkwfl8xobUwZHd3s0YHdHb+92OplNsDQvUajz7bBL
 1aeAU5bHwR7Cv+XdBkyVyQBIxYnp509aUMlN4LyPVXKobCd52aWgVbn7HOPv5cZiVHVA
 WG861uj8CLMMO3q7O5T79IuhN8NXIUHyoKzyhVs6FcKTZt9LBs9UCj7SE5iDaRwP4wgn
 y8DR3Z9xlC//8pGU+VYTKmNsMzljmwP6GNU0L4cTumVK4o+8qOWlMEcd0sE5yW9PITeR Qg== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3y8sbx82cg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 May 2024 10:23:04 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44LAN4j0029261;
	Tue, 21 May 2024 10:23:04 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3y8sbx82cb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 May 2024 10:23:04 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 44L8gPHp008232;
	Tue, 21 May 2024 10:23:03 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3y78vkvpyy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 May 2024 10:23:03 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 44LAN0Ag22872540
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 May 2024 10:23:02 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 764F258043;
	Tue, 21 May 2024 10:23:00 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1DEB75805D;
	Tue, 21 May 2024 10:22:57 +0000 (GMT)
Received: from [9.171.37.250] (unknown [9.171.37.250])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 21 May 2024 10:22:56 +0000 (GMT)
Message-ID: <460cb285-7537-4c02-8e79-2c5087331ccf@linux.ibm.com>
Date: Tue, 21 May 2024 15:52:55 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] nvme: multipath: Implemented new iopolicy
 "queue-depth"
To: Sagi Grimberg <sagi@grimberg.me>, John Meneghini <jmeneghi@redhat.com>,
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
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <073ae18a-a80e-4a95-a093-36210a3bb230@grimberg.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: sPWry-Y1DEjmDJfmKTgH41k0pDLSudQK
X-Proofpoint-ORIG-GUID: 5mo44nngSRfXww-apT4DkSCAA9GRML1G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-21_06,2024-05-21_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 mlxlogscore=985 priorityscore=1501 clxscore=1015 suspectscore=0
 malwarescore=0 lowpriorityscore=0 mlxscore=0 phishscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405210078



On 5/21/24 15:45, Sagi Grimberg wrote:
> 
> 
> On 21/05/2024 13:11, Sagi Grimberg wrote:
>>
>>>> Don't think this matters because cancellation only happens when we
>>>> teardown the controller anyways...
>>>>
>>> I think in case if we reset the nvme controller then we don't teardown
>>> controller, isn't it? In this case we cancel all pending requests, and
>>> later restart the controller.
>>
>> Exactly, nvme_mpath_init_ctrl resets the counter.
> 
> Except you're right, the counter reset needs to move to nvme_mpath_init_identify()
> or some place that is called on every controller reset.
Yeah that was my point. Unfortunately, nvme_mpath_init_ctrl() is not called when we do nvme 
controller reset. So either we move nvme_mpath_init_ctrl() to some common place which 
is called from regular controller init code as well as controller reset code path 
or we may explicitly reset nr_active counter from nvme_timeout().

Thanks,
--Nilay

