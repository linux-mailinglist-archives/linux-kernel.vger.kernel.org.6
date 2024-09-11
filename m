Return-Path: <linux-kernel+bounces-324779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A043E9750BA
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 13:26:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E237288E84
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 11:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3AF5187845;
	Wed, 11 Sep 2024 11:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="P8MFS+PW"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F74C18732C
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 11:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726053950; cv=none; b=TvgqL5u4OfY+SWcNsc7myoMdJ+45zcDpLavksikflcgLPknZoA29SXpZNORpGX0avHFNimNVoZOqajqhAhDPFJMLhnlEdOa6QOZ/RbyDJ0ilxZ9Xh8f1sJkzgL4oNITZBFlCFaeCMP3b0tMnC7kr4dJKqQkuMYDae0dYwuX/BJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726053950; c=relaxed/simple;
	bh=UUIMQCiSkkY+WdK1hVcDPjE0JL86iuiXek9+/fnbsSg=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qA+TmRZbEb27BvSMkBP6dWeFcHVbjjZ1WhlIVcUwJ5e/KI77sTmJJPJNTtH1qHFLm686ptk0owfSM4C9xbndwCinpKc0hfQc99SnQI7w7WrMgmoQAiK1nWyurb29p40spzr+WsXyupMT4XGM08iyPt8nr/zmA2Z8y3qiobMX5Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=P8MFS+PW; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48B1nUPw012586;
	Wed, 11 Sep 2024 11:25:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:subject:from:to:cc:references:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=pp1; bh=
	sywYchqhTAQV+RCPprqliDsB9dTSqAw/2IhHgB76NhE=; b=P8MFS+PWLb1Zr5fa
	NXjwneUkUS8yggXDhoJr8Hot3t3IkEXJ1V5RyHQkYRQ8YhGlceEDlzgbbIpdcgnt
	5/D7pFsmpfeRzNHRfqWt4qiYJAAIqPZqR6u7NlfysChywmd2AbJF1dzOH4wE4oU5
	q+EiiCek2M7eDN5zqRccQRHJujrQY1WItHF3sn9cDfFsUm3TgARb2ZKjJV/x9bIB
	cMj0IM3We7BWsdREBGcddG9Zo/UFJX087fM6ltcoypD6Lxq3XKkRd8AEN4B22O4p
	tcxoYjUzSz1rf8D1JgqQGoLw6oiv38VHX7vyo6ZcFpFlMZ+QaCYVCBTJt4ZQEYhF
	ccDwvA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41gc8qdh8a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Sep 2024 11:25:34 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 48BBM67k014261;
	Wed, 11 Sep 2024 11:25:33 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41gc8qdh87-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Sep 2024 11:25:33 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48BAEHoF019899;
	Wed, 11 Sep 2024 11:25:33 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41h25q154a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Sep 2024 11:25:33 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 48BBPScY12648720
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Sep 2024 11:25:28 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 552E520043;
	Wed, 11 Sep 2024 11:25:28 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 32D8E20040;
	Wed, 11 Sep 2024 11:25:25 +0000 (GMT)
Received: from [9.43.116.75] (unknown [9.43.116.75])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 11 Sep 2024 11:25:24 +0000 (GMT)
Message-ID: <051bff75-e21a-468e-958b-5eead2e5c8c2@linux.ibm.com>
Date: Wed, 11 Sep 2024 16:55:23 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] kexec/crash: no crash update when kexec in progress
From: Sourabh Jain <sourabhjain@linux.ibm.com>
To: bhe@redhat.com
Cc: Hari Bathini <hbathini@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>, kexec@lists.infradead.org,
        linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org, x86@kernel.org,
        Sachin P Bappalige <sachinpb@linux.vnet.ibm.com>
References: <20240911111528.104303-1-sourabhjain@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20240911111528.104303-1-sourabhjain@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: JYHQ6pVXKWof2VG3slyjEUbPV9nDC49B
X-Proofpoint-ORIG-GUID: IKogUM0QbkfR-Rsl13s6SeHboUzSYGkW
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-10_12,2024-09-09_02,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 mlxscore=0 lowpriorityscore=0 impostorscore=0 priorityscore=1501
 malwarescore=0 adultscore=0 clxscore=1015 mlxlogscore=999 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409110082

Hello all,

Please ignore this patch. V2 has been resent with an updated 
linuxppc-dev mailing list address:
https://lore.kernel.org/all/20240911112111.108056-1-sourabhjain@linux.ibm.com/

Apologies for the noise.

Thanks,
Sourabh Jain

On 11/09/24 16:45, Sourabh Jain wrote:
> The following errors are observed when kexec is done with SMT=off on
> powerpc.
>
> [  358.458385] Removing IBM Power 842 compression device
> [  374.795734] kexec_core: Starting new kernel
> [  374.795748] kexec: Waking offline cpu 1.
> [  374.875695] crash hp: kexec_trylock() failed, elfcorehdr may be inaccurate
> [  374.935833] kexec: Waking offline cpu 2.
> [  375.015664] crash hp: kexec_trylock() failed, elfcorehdr may be inaccurate
> snip..
> [  375.515823] kexec: Waking offline cpu 6.
> [  375.635667] crash hp: kexec_trylock() failed, elfcorehdr may be inaccurate
> [  375.695836] kexec: Waking offline cpu 7.
>
> To avoid kexec kernel boot failure on PowerPC, all the present CPUs that
> are offline are brought online during kexec. For more information, refer
> to commit e8e5c2155b00 ("powerpc/kexec: Fix orphaned offline CPUs across
> kexec"). Bringing the CPUs online triggers the crash hotplug handler,
> crash_handle_hotplug_event(), to update the kdump image. Since the
> system is on the kexec kernel boot path and the kexec lock is held, the
> crash_handle_hotplug_event() function fails to acquire the same lock to
> update the kdump image, resulting in the error messages mentioned above.
>
> To fix this, return from crash_handle_hotplug_event() without printing
> the error message if kexec is in progress.
>
> The same applies to the crash_check_hotplug_support() function. Return
> 0 if kexec is in progress because kernel is not in a position to update
> the kdump image.
>
> Cc: Hari Bathini <hbathini@linux.ibm.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: kexec@lists.infradead.org
> Cc: linuxppc-dev@ozlabs.org
> Cc: linux-kernel@vger.kernel.org
> Cc: x86@kernel.org
> Reported-by: Sachin P Bappalige <sachinpb@linux.vnet.ibm.com>
> Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
> ---
>
> Changelog:
>
> Since v1:
>   - Keep the kexec_in_progress check within kexec_trylock() - Baoquan He
>   - Include the reason why PowerPC brings offline CPUs online
>     during the kexec kernel boot path - Baoquan He
>   - Rebased on top of #next-20240910 to avoid conflict with the patch below
>     https://lore.kernel.org/all/20240812041651.703156-1-sourabhjain@linux.ibm.com/T/#u
>
> ---
>   kernel/crash_core.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> index c1048893f4b6..078fe5bc5a74 100644
> --- a/kernel/crash_core.c
> +++ b/kernel/crash_core.c
> @@ -505,7 +505,8 @@ int crash_check_hotplug_support(void)
>   	crash_hotplug_lock();
>   	/* Obtain lock while reading crash information */
>   	if (!kexec_trylock()) {
> -		pr_info("kexec_trylock() failed, kdump image may be inaccurate\n");
> +		if (!kexec_in_progress)
> +			pr_info("kexec_trylock() failed, kdump image may be inaccurate\n");
>   		crash_hotplug_unlock();
>   		return 0;
>   	}
> @@ -547,7 +548,8 @@ static void crash_handle_hotplug_event(unsigned int hp_action, unsigned int cpu,
>   	crash_hotplug_lock();
>   	/* Obtain lock while changing crash information */
>   	if (!kexec_trylock()) {
> -		pr_info("kexec_trylock() failed, kdump image may be inaccurate\n");
> +		if (!kexec_in_progress)
> +			pr_info("kexec_trylock() failed, kdump image may be inaccurate\n");
>   		crash_hotplug_unlock();
>   		return;
>   	}


