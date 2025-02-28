Return-Path: <linux-kernel+bounces-537831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 905A9A49193
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 07:30:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CE6716E5EB
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 06:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F0551C54A6;
	Fri, 28 Feb 2025 06:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="q6fOYz9R"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00AFD1C4A06
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 06:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740724153; cv=none; b=dsRQ+LY9Z3o1Wr2qUuOIahB7uH/SDtFaIcxyGy8Qbi6bW2uVkOUCsi2kYOrKcihdrpSXdG3pcqLkPaR8Fkkmgv3/zGfDuu9xKcgNqH5fslEmsGeMlvan29396obmY9L8H7Jd6bMlX35mvNtDjVFrGa5DHCBcW9V+Rta8Ijwag+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740724153; c=relaxed/simple;
	bh=iouNsNPxBQu7ZSnLJ3M0a61eUKvJXyuHzAgu11eMyZw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b5WkhXb2URanuKV7pzqP8eYaUvradnXmP5XDw8W4h4RUMyFJswXI784B9/yRk70KOzxUugvUeL8bqp7jdrzDAr38bcX7yI97GfkojWZ0ZFgWVlEdc95ERmb2xOtqQjiQpWniyVKJTVSYvGwahF5z27yz8kwjCa7yQeRVx/lRfEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=q6fOYz9R; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51S2QDTM018108;
	Fri, 28 Feb 2025 06:28:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=WeMNm5
	1+6ZKFYZqtAy3GOlGCh8XgJKoAtAG4m4ffCPs=; b=q6fOYz9RcBp4dN4PHfK8fX
	6OZz2yp6c5VYU9oyijEgUwz8TYy7WbM4/8NuIdw2JkpO0uCnqsWZiq9Exgux8uCP
	t2uTMkMuiwY7IuLkmxQgbshqx9NHTwkDO85MgUzcxkijjsicgLrZyhRSHeM0NWbx
	Bwcq0qrlVQWwMTOdDGVeOQFY6TKi1u85FYIDCO5R7qtRmDhlk7TwBDGVC1hbp7SH
	cjWivDPZsrvJRGrZQTwoYOK8i1uDx04PwJmwTw2FkkqvqXaGJzMajIyBc7pSuUJM
	U/q2spWNlX1IIZFbRD5U4X9tX5L5j24Oo4CaTB4tEJ8xBmfdY7fNJf35VbwU67+w
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 452krpe210-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Feb 2025 06:28:50 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51S5lIY9012491;
	Fri, 28 Feb 2025 06:28:50 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44ys9yw7pu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Feb 2025 06:28:50 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51S6SnKu12649088
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Feb 2025 06:28:49 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5BED458052;
	Fri, 28 Feb 2025 06:28:49 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6255C58068;
	Fri, 28 Feb 2025 06:28:46 +0000 (GMT)
Received: from [9.109.198.149] (unknown [9.109.198.149])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 28 Feb 2025 06:28:46 +0000 (GMT)
Message-ID: <bc07b3df-4634-44fc-a16c-f4c3bb30e456@linux.ibm.com>
Date: Fri, 28 Feb 2025 11:58:44 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] nvme-multipath: add the NVME_MULTIPATH_PARAM config
 option
To: John Meneghini <jmeneghi@redhat.com>, kbusch@kernel.org, hch@lst.de,
        sagi@grimberg.me
Cc: loberman@redhat.com, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org, emilne@redhat.com, bgurney@redhat.com
References: <20250228032541.369804-1-jmeneghi@redhat.com>
 <20250228032541.369804-3-jmeneghi@redhat.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20250228032541.369804-3-jmeneghi@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: xjODHAE76ywNgQoU1riXZ7S4wvZgevn7
X-Proofpoint-GUID: xjODHAE76ywNgQoU1riXZ7S4wvZgevn7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-27_08,2025-02-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 lowpriorityscore=0 spamscore=0 impostorscore=0 priorityscore=1501
 mlxscore=0 bulkscore=0 mlxlogscore=999 clxscore=1011 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502280041



On 2/28/25 8:55 AM, John Meneghini wrote:
> The NVME_MULTIPATH_PARAM option controls the core.nvme_multipath module
> parameter. When NVME_MULTIPATH_PARAM=n the multipath parameter is removed
> and core nvme multipathing is enabled. When NVME_MULTIPATH_PARAM=y
> the multipath parameter is added and multipath support becomes
> configurable with the core.nvme_multipath parameter.
> 
> By default NVME_MULTIPATH_PARAM=y
> 
> Signed-off-by: John Meneghini <jmeneghi@redhat.com>
> ---
>  drivers/nvme/host/Kconfig     | 15 +++++++++++++++
>  drivers/nvme/host/multipath.c |  3 ++-
>  2 files changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/Kconfig b/drivers/nvme/host/Kconfig
> index 91b0346ce65a..c4251504f201 100644
> --- a/drivers/nvme/host/Kconfig
> +++ b/drivers/nvme/host/Kconfig
> @@ -28,6 +28,21 @@ config NVME_MULTIPATH
>  
>  	  If unsure, say Y.
>  
> +config NVME_MULTIPATH_PARAM
> +	bool "NVMe multipath param"
> +	depends on NVME_CORE && NVME_MULTIPATH
> +	help
> +	  This option enables configurable support for multipath access with
> +	  NVMe subsystems. If this option is enabled NVMe multipath support is
> +	  configured by the nvme core module parameter named "multipath". If
> +	  this option is disabled the nvme core module "multipath" parameter
> +	  is removed and support for NVMe multipath access can not be
> +	  configured. When this option is disabled a single /dev/nvmeXnY
> +	  device entry will be seen for each NVMe namespace, even if the
> +	  namespace is accessible through multiple controllers.
> +
> +	  If unsure, say Y.
> +
If we want to make NVME_MULTIPATH_PARAM default on then I think we need to add 
"default y" under config NVME_MULTIPATH_PARAM.

>  config NVME_VERBOSE_ERRORS
>  	bool "NVMe verbose error reporting"
>  	depends on NVME_CORE
> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index 2a7635565083..4536ad5fbb82 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -10,10 +10,11 @@
>  #include "nvme.h"
>  
>  bool multipath = true;
> +#ifdef NVME_MULTIPATH_PARAM

Shouldn't it be CONFIG_NVME_MULTIPATH_PARAM instead of NVME_MULTIPATH_PARAM?

Thanks,
--Nilay

