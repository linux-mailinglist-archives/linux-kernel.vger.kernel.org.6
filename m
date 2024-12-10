Return-Path: <linux-kernel+bounces-438595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 435A59EA340
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 01:01:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69FCE28136B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 00:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73D6522612;
	Tue, 10 Dec 2024 00:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cTmxL/a/"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3268218E3F
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 00:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733788889; cv=none; b=DI1y1q+Oj9sTZhTcgHnUBkxbGikDEitvivAexqPpFcPRS9I/KFP9vL4uiDxQCvoQXXpIDn77c9dcIZJ42xPqI2yUdRvPk/rTaEPNX7OJKD+MG4G+kDnBWtvEwM27Z8NhwBdJEJBr+e4e88zQIGIHpEzeSzDK6Pe+K8IpAx3yE/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733788889; c=relaxed/simple;
	bh=ODTr/EN7uOzzdelyAGiLaho7MMk/IuODVtzg+npRn00=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H6z2ZwsmprR+cOfNN5iFMAAeuQqFSSkbtg7khMcrcf7+9dq9Rj1yvqmj8MljttfxY9xSXPYEnUX5EwTdULQy9zPvj23NczUTZy2yW/ETTWa0Gka7QcKc8rRxhfSCqQM25zn64Npe0ugL5yAN/omYemakMAk7lASiUN8oRJO6zZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cTmxL/a/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B9NqLJl021040
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 00:01:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1EqxPduBDSvSsoN4JFJf1y6Rui0Hp2FOo5ojAyR5TFQ=; b=cTmxL/a/AIHdqNDY
	NTFredgPjjARGh7yUS80FKnTsiIWELuR1UPvXouOaHS1PyPiQpFUPxHWkdPZtNrj
	LzWgzkDzyRXthhKmAfT6ehzr6CuTHtdf71sk9vKVwGVsjgjMQjxLkryJKu/ZylDk
	UVl2A/bU3eCDWjm/9mnqxgfqjnaP2h9ONkPm/Jhk39KgmwOju5tE/qSKEJjje0hG
	fa3U1Jj79MtlIFM/IXsJY9CTIYvEaxgT4kQb3x2ldYiP9gzw+06EnoOlQ3iHHuUh
	AaZZfda1Ri6iVNXb/EdCMVfJad+stfIpYf31CZ28qXLCNi1k61tR5HxGyLAQZW15
	sTpuxg==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43eak380jy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 00:01:27 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-725dd39ebe7so1646145b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 16:01:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733788886; x=1734393686;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1EqxPduBDSvSsoN4JFJf1y6Rui0Hp2FOo5ojAyR5TFQ=;
        b=uC9pJdeEYN317aZyGHupBMPo9EsbDrv9RMylM50/lKrAYpA5NgHrEkABxk/PTLky8B
         gbvwIQhnuhkon/Evt05Vj9uRoVkI6PsGutiRVb3TqkGDVtyzhrbHu9Dp0ar+WKL2yErT
         feruTgTU/SBcXv6vnCTSaanXx/NfSCJHdqsSJVY1w+MZGCT55ozLJkBnC4yDrbpBiknl
         NiItHq/mCqdxrrt17tz5mT1e2wYmWK4EwNYz0mDkBp9Ej74WMsPFz0VYYvM9jgHUlFND
         IDcUNPbOqQ7uxgf3ZolbncxkjtxXkg4BQfonJJwxFIqy9cQdYebyWe6yutCOiRpRiiJG
         cWBQ==
X-Gm-Message-State: AOJu0YzTdpxN/4DgvjKfRKJ7y5iTq0GdVYMMst8eSKLQeLQYeRw2P+XR
	yFB4SRPfs6mxF1RU84RQPFpFIfLrJY48ZgKYt+8vhWU4NY6ylY4/tMLtcOWFzcihA3puLmf6sft
	7aAIWF358cOtDE0IymzzuOOFHPD9DY2u3UAROc39Gmvl7ImIALFf2Vn4WPjr/j6k=
X-Gm-Gg: ASbGncu38US4x60djsfF2XogbvyOO0xnCx6m0Jao0j4269Z+SdlMOVcFNupopZPnvM7
	BzRb8KMOtAcLo42XRP+AW57c3yc2incGIjPePO/QnZOoM7A8JxGb8ckkkh+nZ6sRc4+3kU47Cpc
	60yG2EkdQOsRL7OedqX3dpImtdL1ztHd9e+4zsvW3q4yyPhHy9s+fF/r3Rs4gYmwuxDa7gCamBg
	wR+JsDei+uXdS0U6h5SbldgO8361oWVMSgDkOFmCTQSs7iZ0j/0yFMgR8CvBPMYntxFlfzzk7rN
	BUsQ+Sg5+l/rR7w=
X-Received: by 2002:a05:6a00:816:b0:71e:4786:98ee with SMTP id d2e1a72fcca58-7273cba6f5bmr3311101b3a.21.1733788886343;
        Mon, 09 Dec 2024 16:01:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGERk0lzTLfmPchRAiAHRbnp6RfJLbLF+LVgKVUWmhDtsOlSUndfB+9OPQWeoieIm4bzgudIg==
X-Received: by 2002:a05:6a00:816:b0:71e:4786:98ee with SMTP id d2e1a72fcca58-7273cba6f5bmr3311033b3a.21.1733788885886;
        Mon, 09 Dec 2024 16:01:25 -0800 (PST)
Received: from [10.81.24.74] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725ce38be98sm4867179b3a.52.2024.12.09.16.01.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Dec 2024 16:01:25 -0800 (PST)
Message-ID: <79f0dbc0-b0b7-448d-a4fb-9e3eceb89801@oss.qualcomm.com>
Date: Mon, 9 Dec 2024 16:01:24 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] soc: hisilicon: kunpeng_hbmcache: Add support for
 online and offline the hbm cache
To: Zhang Zekun <zhangzekun11@huawei.com>, xuwei5@hisilicon.com,
        lihuisong@huawei.com, Jonathan.Cameron@huawei.com
Cc: linux-kernel@vger.kernel.org, liuyongqiang13@huawei.com
References: <20241206112812.32618-1-zhangzekun11@huawei.com>
 <20241206112812.32618-3-zhangzekun11@huawei.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20241206112812.32618-3-zhangzekun11@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: zH-YqVUZQOBgoXyhZE6Vl0WozsjdKNBT
X-Proofpoint-GUID: zH-YqVUZQOBgoXyhZE6Vl0WozsjdKNBT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=857 clxscore=1015 spamscore=0 mlxscore=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0
 bulkscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412090187

On 12/6/24 03:28, Zhang Zekun wrote:
> Add a driver for High Bandwidth Memory (HBM) cache, which provides user
> space interfaces to power on/off the HBM cache. Use HBM as a cache can
> take advantage of the high bandwidth of HBM in normal memory access, and
> OS does not need to aware of the existence of HBM cache. For workloads
> which does not require a high memory access bandwidth, power off the HBM
> cache device can help save energy.
> 
> Signed-off-by: Zhang Zekun <zhangzekun11@huawei.com>

...

> +module_exit(hbm_cache_module_exit);
> +MODULE_LICENSE("GPL");

Unlike the 1/2 patch, this one CAN be built as a module, so please add the
missing MODULE_DESCRIPTION() macro to avoid the warning with make W=1.

/jeff


