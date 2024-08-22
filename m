Return-Path: <linux-kernel+bounces-296544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DCF795ABE9
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 05:30:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40B381C20CAE
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 03:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36D201CD2F;
	Thu, 22 Aug 2024 03:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="aZ4syt4i"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8EFD1BC39
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 03:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724297433; cv=none; b=RH4PzUpzb0blyojBzDK9oPcZCz+s0SJGrALIud2ZPL/RRV5x3zg8oPJ28FZQqNfGYdWFRKjYbPk/+NMCyAFbksUe78DEtfFrHSOS54AOALvWIfPNK8Upatonm0XYDTiKjnBEbwu70c3WK2PBajx+gm3Ok5diSKx4H7S8HqWwrPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724297433; c=relaxed/simple;
	bh=CQXyF+7a6BVF6RwyXTpDhEcVDfqPkzrIiLL8n3xC2e4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=N0/D4DhO+uqGmsGpoY9GFUY24EzzoCFQgIBVuVHNOkVm759LXM1I9zutk0oiSh6geK9QgzbaBTMc5ta31O5riSak0QOoCj954tp5rs/R57N6F4rNU6lb1wFWerKtuAyRv+k35KxjkFJ/VrhQ/XadyaBjiTGLC2WpSqXMY+jM8VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=aZ4syt4i; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47M12Ggp001040;
	Thu, 22 Aug 2024 03:30:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	RGtUJKp81FihlVKQ0peRzsezWLgn2jDuiZewxstC0b0=; b=aZ4syt4ixSIh3PZm
	gKH6EcurSGk1cmQjoQ7lp5+PVWdB+rs8tsXJCdlIytSXNbVguPe+ykXR+E2zPK3H
	ARRTUHtlFcfCAGprAE3ovezisVwGy8AUO4WG56JJTFYN4GjxjaMKk33BbOvdMFfP
	mPMSlKj2xmxJCxnngc3U7h6bUL8apjFPow0uHkGmDuK1/3AD7HkvN+CXf+t81CGv
	/PPUHihDq5iN22aaCDd5+xuTXZR/U91qPdh69Xj97s16iBbTu4Bz2cMVMMtKxCxm
	sNclwXucuZeRYxO/q2Q8dJQhRuvLwMs+72jUG2RsvwG7BV7urmAAHbfMLHacdlwP
	GC6/Rg==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 415nrrrue4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Aug 2024 03:30:25 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47M3UBiX021232
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Aug 2024 03:30:11 GMT
Received: from [10.253.10.10] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 21 Aug
 2024 20:30:10 -0700
Message-ID: <36bc2da3-80c2-467d-bcdd-0797809ace72@quicinc.com>
Date: Thu, 22 Aug 2024 11:30:07 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/5] driver core: Sort headers
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC: "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20240821154839.604259-1-andriy.shevchenko@linux.intel.com>
 <20240821154839.604259-2-andriy.shevchenko@linux.intel.com>
Content-Language: en-US
From: quic_zijuhu <quic_zijuhu@quicinc.com>
In-Reply-To: <20240821154839.604259-2-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: DtwRtsBJsCXrNgPm7FecGx-9IcVBZN-Y
X-Proofpoint-GUID: DtwRtsBJsCXrNgPm7FecGx-9IcVBZN-Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-21_17,2024-08-19_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 mlxlogscore=999 mlxscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0
 malwarescore=0 suspectscore=0 priorityscore=1501 clxscore=1011
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408220024

On 8/21/2024 11:48 PM, Andy Shevchenko wrote:
> Sort the headers in alphabetic order in order to ease
> the maintenance for this part.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/base/core.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 144cb8c201fb..6b9d3d255135 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -9,29 +9,29 @@
>   */
>  
>  #include <linux/acpi.h>
> +#include <linux/blkdev.h>
>  #include <linux/cpufreq.h>
>  #include <linux/device.h>
> +#include <linux/dma-map-ops.h> /* for dma_default_coherent */
>  #include <linux/err.h>
>  #include <linux/fwnode.h>
>  #include <linux/init.h>
> +#include <linux/kdev_t.h>
>  #include <linux/kstrtox.h>
>  #include <linux/module.h>
> -#include <linux/slab.h>
> -#include <linux/kdev_t.h>
> +#include <linux/mutex.h>
> +#include <linux/netdevice.h>
>  #include <linux/notifier.h>
>  #include <linux/of.h>
>  #include <linux/of_device.h>
> -#include <linux/blkdev.h>
> -#include <linux/mutex.h>
>  #include <linux/pm_runtime.h>
> -#include <linux/netdevice.h>
>  #include <linux/rcupdate.h>
> -#include <linux/sched/signal.h>
>  #include <linux/sched/mm.h>
> +#include <linux/sched/signal.h>
> +#include <linux/slab.h>
>  #include <linux/string_helpers.h>
>  #include <linux/swiotlb.h>
>  #include <linux/sysfs.h>
> -#include <linux/dma-map-ops.h> /* for dma_default_coherent */
>  
>  #include "base.h"
>  #include "physical_location.h"

Hi Andy,

i don't think it is good idea to sort headers by alphabetic order.

why ?

1) header's dependency is not related to its file (name|path), their
dependency are related to # includes order.

2) it maybe be easy to cause build error.

3) header's path or name maybe be related to subsystem, it is not good
to sort one subsystem's headers before the other.


For header's order, my points is that:

1) sort by their dependency.
   #include <b_header.h>
   #include <a_header.h>
   if
   a_header.h:
   #include <b_header.h>

2) all #include <> block before all #include "" block.

3) sort headers related to source file at the last.

   prefix_xyz.c:

   #include <>
   .....
   #include <prefix_xyz.h>   // it is the last if it is exposed.

   #include "internal_header.h"
   ....

4)
sort relevant header together as far as possible, for example, they
belong to the same subsystem.





