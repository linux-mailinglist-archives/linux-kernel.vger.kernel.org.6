Return-Path: <linux-kernel+bounces-250144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D9C592F4A4
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 06:30:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22EE11F244A9
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 04:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 362F81426C;
	Fri, 12 Jul 2024 04:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="SFhgyT7E"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0896A8827
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 04:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720758634; cv=none; b=A8bfAHgMGysjSARHVFW8x7YSnQP3F28xv2IcaIbfyaXfK/gvQklAU56IfBJCGNvpW0p2M+ilDe1FHQcw1t/uvRDMivWYr7DajL6EbvTmNIgXZN7TkD3nOnwefy48Zlhe92BuqF9loIy8hOnj4oJTj4kLDqfwIv6hrNc0U8LiC0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720758634; c=relaxed/simple;
	bh=UmnAFUdkTGwdt7T83/k6it09IXNDdB/wcpoIaoSusLQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=amX+6iT7S+zxmjbuHLIijItWwRFi0zIILFBcW9sa0unmqi5PRoapZhrr3CIGVkJcb0k3UEr5B2YRDL4NGPCDUCL9R7wIslwDqCfR9TCv2yoEmElJLRX9o/n1UWeP5p4zo/h4HAJW78NPzJ/tSFhk9DIZAubf9dkLSXoQZMd/Hl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=SFhgyT7E; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46C4RE6D021833;
	Fri, 12 Jul 2024 04:30:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=1
	zOVV4QHtjkS/1m/+veVhz4yMLjjRvy4S5mRVNpptow=; b=SFhgyT7EM7p8G/UQD
	IlPWpM1jKGWBA5LaiwjjS9m1Vh0spNEFVXiNgG46wRcyeLk1Oqhiws2sFtPiQsvK
	YIAuRcO+XpFl53XrucoubfKvjyRtSMubC2CrFtcxSnoTyccPciaPQ3/O9snb4TGB
	bjhnA0fjVRoG9X6leqSLMV5m7Y+Ow4Q+Fl88S17PifeGub1uMjJp3RGtX37EYC3o
	Kp9Q8entqCshBmswaVkitYyLw/ygI2SXJ88F/viHMJt+pGqDqKryD5WDj6NWUy1r
	fhXeBre0xqfyGgAQRfqjE8VWo9c75Rv3lfDnuyo/O3Il8DurA80DdaUDpJeKroLQ
	GmzgA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40atdtgep2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Jul 2024 04:30:17 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 46C2kovv024583;
	Fri, 12 Jul 2024 04:30:16 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 407hrn4j80-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Jul 2024 04:30:16 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 46C4UCMU18547162
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Jul 2024 04:30:14 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6CB5320043;
	Fri, 12 Jul 2024 04:30:12 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D2B2320040;
	Fri, 12 Jul 2024 04:30:10 +0000 (GMT)
Received: from [9.109.204.94] (unknown [9.109.204.94])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 12 Jul 2024 04:30:10 +0000 (GMT)
Message-ID: <59d88de7-369a-44e8-a965-109c8690869e@linux.ibm.com>
Date: Fri, 12 Jul 2024 10:00:09 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sysfs/cpu: Make crash_hotplug attribute world-readable
To: Petr Tesarik <petr.tesarik@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>, kexec@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Petr Tesarik <petr@tesarici.cz>,
        Petr Tesarik <ptesarik@suse.com>
References: <20240711103409.319673-1-petr.tesarik@suse.com>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <20240711103409.319673-1-petr.tesarik@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 1NvJa-aqowZkCC7asWwgmigPWhVS0Kez
X-Proofpoint-GUID: 1NvJa-aqowZkCC7asWwgmigPWhVS0Kez
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-12_02,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 lowpriorityscore=0 mlxscore=0 bulkscore=0 adultscore=0 impostorscore=0
 clxscore=1011 malwarescore=0 suspectscore=0 spamscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2406140001
 definitions=main-2407120029

Hello Petr,

Just want to mentioned few points about the commit message. No strong
opinion on changing the commit message.

On 11/07/24 16:04, Petr Tesarik wrote:
> From: Petr Tesarik <ptesarik@suse.com>
>
> There is no reason to restrict access to this attribute, as it merely
> reports whether crash elfcorehdr is automatically updated on CPU hot
> plug/unplug and/or online/offline events.

Now, it is not just elfcorehdr; there could be multiple kexec segments 
based on the architecture's needs.
For example, on PowerPC, it is elfcorehdr and FDT.

>
> Note that since commit 79365026f8694 ("crash: add a new kexec flag for
> hotplug support"), this maps to the same flag which is world-accessible
> through /sys/devices/system/memory/crash_hotplug.

The previous comment is more relevant for the kexec_load system call.

For the kexec_file_load system call, the kexec flag introduced in the 
commit message
mentioned above is irrelevant. Building kernel with CONFIG_CRASH_HOTPLUG 
is enough.

> Signedoff-by: Petr Tesarik <ptesarik@suse.com>
> ---
>   drivers/base/cpu.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
> index c61ecb0c2ae2..73d69791d0d3 100644
> --- a/drivers/base/cpu.c
> +++ b/drivers/base/cpu.c
> @@ -308,7 +308,7 @@ static ssize_t crash_hotplug_show(struct device *dev,
>   {
>   	return sysfs_emit(buf, "%d\n", crash_check_hotplug_support());
>   }
> -static DEVICE_ATTR_ADMIN_RO(crash_hotplug);
> +static DEVICE_ATTR_RO(crash_hotplug);

I agree, it doesn't have to be readable by admin only.

Acked-by: Sourabh Jain <sourabhjain@linux.ibm.com>


Thanks for the patch.
- Sourabh

