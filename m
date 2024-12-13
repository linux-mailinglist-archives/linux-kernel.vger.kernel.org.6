Return-Path: <linux-kernel+bounces-445235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 875759F131F
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 18:00:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E75B8188B3FE
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 17:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7AA91E25F8;
	Fri, 13 Dec 2024 17:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="mm+C5a2H"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB8CD175AB
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 17:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734109240; cv=none; b=l+X0mprSmUj3E+sEl8OpTt5sAYLNah6TmlvbZjUOl3agHvRCwTad8OWiC2KZabaZq411f5HwVuODuVtSIAQW82/fUZgMUbCo6YnBrWsD/s5q6Sob0KtUmoaeHW7/M872fVcgwlzEnc8HqkTnPHbd7UAzulvf9/h8vfTqFErMzL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734109240; c=relaxed/simple;
	bh=V7N+qORRmt4BAIHqFNe8gZ6GOvi4wFdHA1TaCcBlLSc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=pmy3de9Bb9vHl9/SLHnEgQV4idrqx5KqWmCSwl1Oq7pdfZMLO2tFEbagy8ng+BwTzfGdW5ENJ3UIE/MbtY/UbmPLP4zDG4unxQGQYbI6dkbYgizdQ4vMXUFhk77YDItbzE/xnWMi5F4sOE3gzAv8yaCAShtY9qGpOjSw8g77kzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=mm+C5a2H; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BD80m79032708;
	Fri, 13 Dec 2024 17:00:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	JwSrvGKQlxh/YHMqQkllB0n9kD31dFA0Qzn3Rwzm6cM=; b=mm+C5a2HBV2RRntR
	U8hguzAFIPTR21Xz0D89wPj53cIkjLu2HRnqsKzfZlitUUhmHFWtIwkHsgFOmkHJ
	fHUmjh6HWIBqJgVIs7zx8OlOeAXjYr2/H/lgPnOdPxmLPgjrfb0ifuTLJJWo4GsU
	7rrht0K0yXuAIqqXorpTyDyuC9Mo4rK4W9KOKcI7l39NtpY8oCrH1HIoJTIP3nRr
	6OMymDXso6B4VCluNY4DhIetnk5zrZ9DBG6xbDxBbp1CoDIAxKWQfem4s5rdga0l
	rQb/BmLkBmEr+f1lAI01dL+mxVVA9IgbYOdB6PRoftpmnaw5bK2QN/Du1ChV/01p
	mjM0gw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43f6tfg8aw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Dec 2024 17:00:34 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BDH0YgM030421
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Dec 2024 17:00:34 GMT
Received: from [10.226.59.182] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 13 Dec
 2024 09:00:33 -0800
Message-ID: <0ecffccb-e40b-8a0c-1dca-8be69959881e@quicinc.com>
Date: Fri, 13 Dec 2024 10:00:32 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH V2 0/8] AMD NPU driver improvements
Content-Language: en-US
To: Lizhi Hou <lizhi.hou@amd.com>, <ogabbay@kernel.org>,
        <dri-devel@lists.freedesktop.org>
CC: <linux-kernel@vger.kernel.org>, <min.ma@amd.com>, <max.zhen@amd.com>,
        <sonal.santan@amd.com>, <king.tam@amd.com>,
        <mario.limonciello@amd.com>
References: <20241206220001.164049-1-lizhi.hou@amd.com>
From: Jeffrey Hugo <quic_jhugo@quicinc.com>
In-Reply-To: <20241206220001.164049-1-lizhi.hou@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: AoHws_ocdzSl5gwWC1F3hmv6XmVMml1T
X-Proofpoint-ORIG-GUID: AoHws_ocdzSl5gwWC1F3hmv6XmVMml1T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 mlxlogscore=733 malwarescore=0 spamscore=0 lowpriorityscore=0
 impostorscore=0 adultscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412130119

On 12/6/2024 2:59 PM, Lizhi Hou wrote:
> Add recent improvements and bug fixes for amdxdna driver (depends on [1])
> 1. Support recent hardware and firmware.
> 2. Replace idr APIs with xarray.
> 3. Fix the bugs been found.
> 
> [1]: https://lore.kernel.org/all/20241118172942.2014541-1-lizhi.hou@amd.com/
> 
> Changes since v1:
> - Add one patch to fix possible compiling failure
> - Minor fixes for code review comments

Patch 1 and 2 applied to drm-misc-next.  You can drop them from the 
series when you post v3.

-Jeff

