Return-Path: <linux-kernel+bounces-537832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B151DA49194
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 07:30:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5DCE67A2750
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 06:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 690F11C5D44;
	Fri, 28 Feb 2025 06:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VUWIb2MB"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C2E1C4A13
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 06:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740724169; cv=none; b=u0dUy7j3lMUezee9DuUeFcNNXj9q7y+pRC08NHDomWySG/g/r89FdSCK8sMeQWAGsVaPhEzNSCcJUjKZP1LB+vh1Qgh9NKczVEgALzeCM9rLsUJFlC45q0p+tWUpt9vXr91UA9WdfzUXKaVScPSTk2MtNrtV9MiXnOo78ZmGnRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740724169; c=relaxed/simple;
	bh=QFRIK9jvp/p3tGfwIy3dqloYbSY23uMuKPrSiA1uh/U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jeByRcGXxcEyLe7Gos/nE6USpJfYdwZ8lctVLxD/16sRALzeEBoBr1V4xD43TDXe+1ojtKs7cSpPZmSmI/yMrpjGJMawsdCASRN2isLrLS9/h+MqxzePpF3+Ja77cFpF0nmEi4Vtd2iwJEnU/uj8JmskjXhC8bFopN8j4dbGHn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=VUWIb2MB; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51S0fhos017877;
	Fri, 28 Feb 2025 06:29:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Jh8vbY
	NYnAIcE9CyTf4BhDISkt5yCae96d3hjvlWfJI=; b=VUWIb2MBTS2yuwwY4KuOIo
	nRb7Ko9Fiz5DMkBwJBxVlndSzvf74dpLR/aNppZr/PMOSsTk7urXove40IkGoO2i
	TWfAjo7DZzSqTzlw5Fb927w/0ICDGNw8RHhzJoXufu3b8lkw2CBYEGr6W8oMg2Er
	ei+v4MjIIjqhHI0YBMBuSCliM6TaJFwgF+VpmOVOm0Ze4+1jdRvBuMl+jvYGkkpt
	R8yjmVf7dfD5Tx/ZtDzMAT5NYDNSNW8AmVgiYYlzNDV2t6qWQry7Vb1XwUInFjL8
	hmtd2owsJ9EJN4VHWQE0IzCDya0jXEbEjKx906Kpl14wkUyrHmwdkd0bm+14FfSQ
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 452krpe21n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Feb 2025 06:29:04 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51S63OrC012457;
	Fri, 28 Feb 2025 06:29:03 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 44yrwt57r4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Feb 2025 06:29:03 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51S6T23M23331384
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Feb 2025 06:29:03 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DAD1658056;
	Fri, 28 Feb 2025 06:29:02 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AF4B158052;
	Fri, 28 Feb 2025 06:28:59 +0000 (GMT)
Received: from [9.109.198.149] (unknown [9.109.198.149])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 28 Feb 2025 06:28:59 +0000 (GMT)
Message-ID: <abd856da-7ca6-419f-943b-80dcc885f68b@linux.ibm.com>
Date: Fri, 28 Feb 2025 11:58:58 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] nvme: update the multipath warning in
 nvme_init_ns_head
To: John Meneghini <jmeneghi@redhat.com>, kbusch@kernel.org, hch@lst.de,
        sagi@grimberg.me
Cc: loberman@redhat.com, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org, emilne@redhat.com, bgurney@redhat.com
References: <20250228032541.369804-1-jmeneghi@redhat.com>
 <20250228032541.369804-4-jmeneghi@redhat.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20250228032541.369804-4-jmeneghi@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: elnEcWRFPBm-yQ6qxc2csW1NX2BTc8JM
X-Proofpoint-GUID: elnEcWRFPBm-yQ6qxc2csW1NX2BTc8JM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-27_08,2025-02-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 lowpriorityscore=0 spamscore=0 impostorscore=0 priorityscore=1501
 mlxscore=0 bulkscore=0 mlxlogscore=937 clxscore=1011 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502280041



On 2/28/25 8:55 AM, John Meneghini wrote:
> The new NVME_MULTIPATH_PARAM config option requires updates
> to the warning message in nvme_init_ns_head(). Remove
> the old warning message and add new ones.
> 
> Signed-off-by: John Meneghini <jmeneghi@redhat.com>
> ---
>  drivers/nvme/host/core.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 818d4e49aab5..c2b7e6834535 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -3823,8 +3823,16 @@ static int nvme_init_ns_head(struct nvme_ns *ns, struct nvme_ns_info *info)
>  			dev_warn(ctrl->device,
>  				"Found shared namespace %d, but multipathing not supported.\n",
>  				info->nsid);
> +#ifdef CONFIG_NVME_MULTIPATH
> +#ifdef CONFIG_NVME_MULTIPATH_PARAM
> +			dev_warn_once(ctrl->device,
> +				"Shared namespace support requires core.nvme_multipath=Y.\n");
> +
> +#endif
> +#else
>  			dev_warn_once(ctrl->device,
> -				"Support for shared namespaces without CONFIG_NVME_MULTIPATH is deprecated and will be removed in Linux 6.0.\n");
> +				"Shared namespace support requires CONFIG_NVME_MULTIPATH.\n");
> +#endif
>  		}
>  	}
>  

As NVME_MULTIPATH_PARAM depends on NVME_MULTIPATH, it implicitly implies 
that if NVME_MULTIPATH_PARAM is enabled then NVME_MULTIPATH has to be on.
So above logic could be simplified.

However on another note, I really don't understand why do we need to add 
new warning here as there's already a warning present just above your
changes.

Thanks,
--Nilay



