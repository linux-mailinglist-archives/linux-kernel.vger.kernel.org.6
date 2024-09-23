Return-Path: <linux-kernel+bounces-335429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BD4597E5A8
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 07:37:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CF711C208FC
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 05:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D464B101DE;
	Mon, 23 Sep 2024 05:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZLPSa//g"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5647184
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 05:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727069826; cv=none; b=aW0e5N3Af6JGb6hWyg8cuq+E3wfIpc2b33LSxpqMPPTPmBtOZu1aHlbNYCbd11FrtZI20CQKa4kcIPCL8OjOGvbobxWEVv8CAhjD61MvDWEQma54Q6lVg9kRHllrTZs9A4zqkgIPAZi63SRbadrU8rZR/5fiyII8b23dJ2ofpsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727069826; c=relaxed/simple;
	bh=e6xPyTGaCARr9kHdRBWXY1Z266siIPfCD8X32fMOBgk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LcDmKxg/Eo7kBPFTmETIid4uGCuvHs0wxYckXgVLMd53Ro29FzS19RZoYyGCIyeUayOIFho7DAlH8wBNa/17m7C/ol9iVd58P4TlrNGc0yQVW55RY3hYUDcTJxlGJQReZDQd8Ef+F+mHbSyGqxQi3w3+aru3DMSc0i6sdNEBhDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ZLPSa//g; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48N2dGBT001531;
	Mon, 23 Sep 2024 05:36:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=pp1; bh=
	e6xPyTGaCARr9kHdRBWXY1Z266siIPfCD8X32fMOBgk=; b=ZLPSa//gxK6eokjQ
	2VIbkMX+k5zxZ1SDEpg1+f2AVpNKjPx1bXlbKlYZgu5UAuEb+AQRACfVHalQvcEx
	3bd+ol2VC7FE+P2FwO6LiTvNl2Aur4ZmthqyDTVYG980lx08IlTsMn2Yk0zFTqbG
	72u6VfxZwhUzzQzbSuF+Zq+M5NJeCiVAMjwX2/WM2u1npnmSM27Bs9hg6dZSL1uI
	FXCJn/NhnWwexIlMGja4eFhCLI0Fx3d74XMzRGqfdnpR3nsB1Y2XHxWPY1AVOXcs
	rnU+7Z5zvavmRKSUDhyG0vHOEyxYU0G8R6hT3d2l+aMHFXe1G/eD0YIxjxcnoFT9
	1D4WKg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41snna1qwy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Sep 2024 05:36:49 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48N0daXU020846;
	Mon, 23 Sep 2024 05:36:48 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 41tb62vb6w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Sep 2024 05:36:48 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 48N5alGB28508748
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Sep 2024 05:36:47 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6583858052;
	Mon, 23 Sep 2024 05:36:47 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 28EF358065;
	Mon, 23 Sep 2024 05:36:45 +0000 (GMT)
Received: from [9.61.252.168] (unknown [9.61.252.168])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 23 Sep 2024 05:36:44 +0000 (GMT)
Message-ID: <03a55b4b-eb45-4187-9de6-ef06f8176d05@linux.vnet.ibm.com>
Date: Mon, 23 Sep 2024 11:06:43 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [Bug][Git-Bisect][6.11.0-next-20240917]BUG: Unable to handle
 kernel data access on read at 0xc00c020000013d88
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        akpm@linux-foundation.org, minchan@kernel.org, terrelln@fb.com,
        sfr@canb.auug.org.au
References: <57130e48-dbb6-4047-a8c7-ebf5aaea93f4@linux.vnet.ibm.com>
 <20240923021557.GA38742@google.com>
Content-Language: en-GB
From: Venkat Rao Bagalkote <venkat88@linux.vnet.ibm.com>
In-Reply-To: <20240923021557.GA38742@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: j_6Ip9-DdyJmOeFLwhwqwk8BF74tf54h
X-Proofpoint-ORIG-GUID: j_6Ip9-DdyJmOeFLwhwqwk8BF74tf54h
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-23_02,2024-09-19_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 mlxscore=0 mlxlogscore=858 spamscore=0 impostorscore=0 priorityscore=1501
 phishscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2409230037

Hello,


Below is the TC, I was running.


https://github.com/avocado-framework-tests/avocado-misc-tests/blob/master/generic/ltp.py

Regards,

Venkat.

On 23/09/24 7:45 am, Sergey Senozhatsky wrote:
> Hi,
>
> On (24/09/22 22:23), Venkat Rao Bagalkote wrote:
>> Greetings!!!
>>
>> I am observing Kernel OOPs on PowerPC system, while running LTP Test case.
>>
>> [11472.962838] BUG: Unable to handle kernel data access on read at
>> 0xc00c020000013d88
>> [11472.962846] Faulting instruction address: 0xc00000000055e2c0
> [..]
>> [11472.963005] NIP [c00000000055e2c0] kfree+0x60/0x468
>> [11472.963013] LR [c008000004e02838] zram_destroy_comps+0x5c/0xa4 [zram]
>> [11472.963020] Call Trace:
>> [11472.963023] [c0000005da817b30] [c00000051f580440] 0xc00000051f580440
>> (unreliable)
>> [11472.963028] [c0000005da817ba0] [c008000004e02838]
>> zram_destroy_comps+0x5c/0xa4 [zram]
>> [11472.963034] [c0000005da817bd0] [c008000004e02d24]
>> zram_reset_device+0x178/0x250 [zram]
>> [11472.963040] [c0000005da817c20] [c008000004e031e0] reset_store+0xd0/0x174
>> [zram]
>> [11472.963046] [c0000005da817c80] [c000000000a85874]
>> dev_attr_store+0x34/0x50
>> [11472.963052] [c0000005da817ca0] [c00000000070e7a4]
>> sysfs_kf_write+0x64/0x78
>> [11472.963060] [c0000005da817cc0] [c00000000070d2a8]
>> kernfs_fop_write_iter+0x1b0/0x290
>> [11472.963066] [c0000005da817d10] [c000000000604868] vfs_write+0x38c/0x488
>> [11472.963071] [c0000005da817dc0] [c000000000604c98] ksys_write+0x84/0x140
> Can you post the script that you run?

