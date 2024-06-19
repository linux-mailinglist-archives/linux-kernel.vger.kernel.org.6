Return-Path: <linux-kernel+bounces-220908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B861790E903
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 13:10:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66622285712
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 11:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F39CB136675;
	Wed, 19 Jun 2024 11:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="oxBU6YUU"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346F175817
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 11:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718795396; cv=none; b=lSVQjRBOL+txE2awwo5JdOD5yqVE4aP20/8iHPAbuwSvXPfXmxHx4TMOXjvzeuFIQZB9h69BiBBbRIvvndbFPqWJ3/IjyHGNGZ3uibO14x15yTZ3MaLh1lwCtZRwXfLG8uzPEORixWAYQQIiL6lT0cvpWDzmmUXf5pUsua/fMmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718795396; c=relaxed/simple;
	bh=Aftmxka0peBR0pWaoqsSOoEY42ivJvNWC/DQjOwuVF0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=duALqtScgXorHDJbR41DpoawgUWefRIlEPbEAX33ukPFg3Xrm8VDlyhVutXYoCGgT7Ojn9bGzCis3lK9W8GfYWEAkALBU9z69GefR7Y6LtmpGFDcB/j+lkERto5ke2su80yU1pawj4IG9ni3VL7sfQJyArb0JGMVoF64+z1/5Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=oxBU6YUU; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45JB3mQs003373;
	Wed, 19 Jun 2024 11:09:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	AH5DtsEnAs0v6SD7FrhfZA197Dlut/nFuVdUAitOViw=; b=oxBU6YUUOUs8GRcd
	UojJzDZWgFRjMMejeHQAXakO0GYbb9D5RSRyiLpI5k1HbpCBAiM/pmPK6ZxKUs9y
	vWFIQZ8at7IYohQcXEx41rGm2LfGFixQSzyWuCYCBh5F/pZJ8XOmp25y9sUKo6qb
	rnNl0oy5MIO7oVYq+qkLEoUL8HDN7l/Krax09F8gTKVmGeJhr2U/fqcWJYck92hC
	QquoeZlWeQPZR6QGuygswbK8gtPpQnrIARqvg5HRcqw+7iWzIhEku968zhl3qk7g
	kOMvIl7YGLpO1Be9/XboqftDlo/J283F4KmQckz5twhQAuQGlA2j1RCfsAMi58O2
	Nqdu3Q==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yujah9f4b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Jun 2024 11:09:35 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA05.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45JB9YNI027632
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Jun 2024 11:09:34 GMT
Received: from [10.218.26.168] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 19 Jun
 2024 04:09:30 -0700
Message-ID: <066a05ca-e2e8-4cfe-8d33-60a665495cdf@quicinc.com>
Date: Wed, 19 Jun 2024 16:39:27 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kernel/reboot: enhance dmesg logging for system restart
To: =?UTF-8?B?7J2064+Z66+8?= <ldmldm05@gmail.com>
CC: <benjamin.bara@skidata.com>, <dmitry.osipenko@collabora.com>,
        <lee@kernel.org>, <daniel.lezcano@linaro.org>,
        <j.granados@samsung.com>, <linux-kernel@vger.kernel.org>,
        <dongmin.lee@linux.dev>
References: <20240607105906.4192924-1-quic_faiyazm@quicinc.com>
 <CACmEs-4mntpn8SQVgx5Qv9W8cmWQ__=1ds_j=vXxcDp27=SXLA@mail.gmail.com>
Content-Language: en-US
From: Faiyaz Mohammed <quic_faiyazm@quicinc.com>
In-Reply-To: <CACmEs-4mntpn8SQVgx5Qv9W8cmWQ__=1ds_j=vXxcDp27=SXLA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 9v9_EXcuf6jMpJIJ_5iGeTst5ytMaDlF
X-Proofpoint-GUID: 9v9_EXcuf6jMpJIJ_5iGeTst5ytMaDlF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-19_02,2024-06-19_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=830
 clxscore=1011 spamscore=0 lowpriorityscore=0 mlxscore=0 priorityscore=1501
 phishscore=0 adultscore=0 suspectscore=0 impostorscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405170001
 definitions=main-2406190082

Sorry for the delayed response.

On 6/7/2024 7:35 PM, 이동민 wrote:
> On Fri, Jun 7, 2024 at 7:59 PM Faiyaz Mohammed <quic_faiyazm@quicinc.com> wrote:
>>
>> It is useful to add the PID and Comm information along with command info.
>>
>> Currently, when system reboot kernel logs don not print PID and Comm:
>>
>> reboot: Restarting system with command 'reboot,scheduled_reboot'
>> reboot: Restarting system with command 'RescueParty'
>> reboot: Restarting system with command 'bootloader'
>> reboot: Restarting system with command 'recovery'
>> reboot: Restarting system with command 'userrequested,recovery’
>>
>> For Example after adding PID and Comm:
>>
>> reboot: PID: 1 Comm: init Restarting system with command 'shell'
>> reboot: PID: 1 Comm: init Restarting system with command 'bootloader'
> 
> Printing out PID and COMM information might be useful for getting
> which task is triggered system reboot. However, It's never a critical
> information that deserves printed with pr_emerg() to whoever want the
> system to be rebooted, unless the kernel is in a problematic
> situation.
> 
Agreed, It's not critical to print the process name which trigger reboot 
with pr_emerg(), so should it be OK if we add additional logging with 
reduced log level?

> If reboot is called by user space via reboot system call, reboot is
> never a problematic situation because it's user's intend in the
> kernel's view. Other kernel codes which invokes involuntary restart
> such as temperature overheat (drivers/memory/emif.c:622), already
> prints out the situation before invoking system_reboot(), hence, there
> is no reason to print out who called system_reboot().
> 
Agreed in kernel view user's space reboot is intended but if system is 
silently rebooting due to any user process(vendor specific user process 
or even a OS specific user deamon) meeting any error condition then a 
developer debugging the system need to know which user process is 
issuing reboot system call to debug further, so in humble opinion it is 
helpful for system debug perspective.

> Again, system reboot is not kernel panic, oops nor bug. If your intend
> is to debug the reboot handler's behavior more easily, just set a
> breakpoint for kernel_restart() function with gdb.
> 
> --
> Best Regards,
> Dongmin Lee
> 
> https://ldmsys.net/

