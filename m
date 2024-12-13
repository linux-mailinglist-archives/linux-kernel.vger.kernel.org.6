Return-Path: <linux-kernel+bounces-445297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50FC19F144F
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 18:49:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11F922811C0
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 17:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0A6B188A08;
	Fri, 13 Dec 2024 17:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="NUfCMD0u"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E1517B50E
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 17:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734112162; cv=none; b=Ody6DsrpJ+Yn0dV91s8jWAd76UZ2A5Oylgcw/EHKow+aKBUyt/KMg6895VhFZ7l2uodrhdflxTTt5krk66WuZlHz8DkWHLdlenwAfJ73Qb1/LjjH0UnIC9kZdTDsK+VpUQbDxn0oRG64cdj5y4I6ecv6wa66oKkHICDK2b56Ie4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734112162; c=relaxed/simple;
	bh=xJEvzeprXTbKvC4iu+h67hiCQxiACLhmxC3+jAYoUvw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=RR2tgnuTZ1MmfsPSlYyaEvaPpjF4j0okLlu/tjw8owGNRKNOiem38G91hw5qwQhiIVnIFeySD35qR8XrI0M0bw6MycrH4F8lvzpnL++o1kUhzCYUoyX68q+KBs7+LkChGh9phlUnD63oYYHNhTn9DVVEkEWx/Bgal8Yi/B3hQ3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=NUfCMD0u; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BDA4Fqo013312;
	Fri, 13 Dec 2024 17:49:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ccRf4dxInKCR5rNbOCB41Uabbf0x6GfGWKiNui3GNwI=; b=NUfCMD0us/HlmYC5
	PqXS/7Y2iwulGbk/skX7BqORRQUuEBTyxY60AJnU/QZ+N1FylpZ1/AA8ztu/oa40
	xvLI0TEVvUIcNpCZZWdjvfvtbEZ2PYGPRs+zcz8oik6ckDaFukcspz0nUDZZZHuk
	yh3x54bIbUWaUrQA2v24CLRLhhmlhL2Dw4fIqf8hC8aQ5mo+qIMsNrXJbKwkBWqy
	u/Brfm/G+121R3x8C6UKQzUP2B3+n32wWjW5dIgWVANVRjgRroTL7xZ5oUjX08cJ
	VuI+heQfdiS7wmtKVKAgOEVQ4ciXAZMvTy4Hs3qsCX4wgGVLiD7EvXo4mgHwCcsM
	qw8bKw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43gjudh7nm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Dec 2024 17:49:11 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BDHnALZ006411
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Dec 2024 17:49:10 GMT
Received: from [10.226.59.182] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 13 Dec
 2024 09:49:09 -0800
Message-ID: <6d4267db-922d-8c01-f76a-6b796422c24d@quicinc.com>
Date: Fri, 13 Dec 2024 10:49:03 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH 1/2] accel/amdxdna: use modern PM helpers
Content-Language: en-US
To: Lizhi Hou <lizhi.hou@amd.com>, Arnd Bergmann <arnd@kernel.org>,
        Min Ma
	<min.ma@amd.com>, Oded Gabbay <ogabbay@kernel.org>
CC: Arnd Bergmann <arnd@arndb.de>,
        Narendra Gutta
	<VenkataNarendraKumar.Gutta@amd.com>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
References: <20241213090259.68492-1-arnd@kernel.org>
 <828570ae-1ff6-4bef-4bb8-51da9237e63e@quicinc.com>
 <e3d9dcd1-70bf-5656-e1a9-749c5a08a20b@amd.com>
From: Jeffrey Hugo <quic_jhugo@quicinc.com>
In-Reply-To: <e3d9dcd1-70bf-5656-e1a9-749c5a08a20b@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 6jCgDqWcFVztfgp_9hxU2UYqs-18Qxvr
X-Proofpoint-ORIG-GUID: 6jCgDqWcFVztfgp_9hxU2UYqs-18Qxvr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 impostorscore=0 bulkscore=0 phishscore=0 mlxlogscore=999 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412130125

On 12/13/2024 10:41 AM, Lizhi Hou wrote:
> 
> On 12/13/24 09:07, Jeffrey Hugo wrote:
>> On 12/13/2024 2:02 AM, Arnd Bergmann wrote:
>>> From: Arnd Bergmann <arnd@arndb.de>
>>>
>>> The old SET_SYSTEM_SLEEP_PM_OPS and SET_RUNTIME_PM_OPS macros cause a 
>>> build
>>> warning when CONFIG_PM is disabled:
>>>
>>> drivers/accel/amdxdna/amdxdna_pci_drv.c:343:12: error: 
>>> 'amdxdna_pmops_resume' defined but not used [-Werror=unused-function]
>>>    343 | static int amdxdna_pmops_resume(struct device *dev)
>>>        |            ^~~~~~~~~~~~~~~~~~~~
>>> drivers/accel/amdxdna/amdxdna_pci_drv.c:328:12: error: 
>>> 'amdxdna_pmops_suspend' defined but not used [-Werror=unused-function]
>>>    328 | static int amdxdna_pmops_suspend(struct device *dev)
>>>        |            ^~~~~~~~~~~~~~~~~~~~~
>>>
>>> Change these to the modern replacements.
>>>
>>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>>
>> Looks sane to me.
>>
>> Lizhi, can you verify that this works as expected for you?  I'd hate 
>> to accidentally break something.
> 
> Verified suspend/resume. It works fine.

Excellent.  Would you like to give a reviewed-by and/or a tested-by?

-Jeff


