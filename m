Return-Path: <linux-kernel+bounces-445252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F36039F135A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 18:11:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B42482842BB
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 17:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B225C1E377E;
	Fri, 13 Dec 2024 17:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="XRit0EcZ"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8A117C21E
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 17:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734109912; cv=none; b=Lpqj9CdEvVDAv8U0SF8KxkrGlPmgT5Iu3cxc6EbKLgie8b4uBoobjab14PDgktxB2UuRb+tlhv6+HA8xZLHWJJ+tFFHl+a4vkThaTGaWdXogG3IbYj5Wd6Wp+zmGJkhQ0lD2xD2AfgXcRUpvfGU+2tRQRkftXJFz3vDoVkxlUDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734109912; c=relaxed/simple;
	bh=v1/S1J+Zt4ZQtgNk7mzxwoZ6hmU/dMnggbADiB5pTWE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Ekq1TBqHqVLuzj7N3Iqh2sDZFsYGLSqfD52W8Wm1I33D1EgUGBDu5J8qApUXlzw4fWIP4Mn7PkyMqIMmGXXFlL69iDzXIMKir/Xho4Gv06gFmcHhQTQOVeAaMvLssTmgOQfOJPBJqkD3doyIpSARYXTmKecEbjruAeHH/rmsi9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=XRit0EcZ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BD9nnpl017510;
	Fri, 13 Dec 2024 17:11:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	DkVx+mJQDVWzEgy08o62IMNR47QZ+mjyF4EWWFiuvn8=; b=XRit0EcZPmYN4xYf
	7CcOuh4LLsuxwS+kGIf3iVBDZDpeY25Jk2uwrQ7h3RkSWsRE9x2aFzS4fJcIzGKZ
	MPheXzXBK8Eer33gxOpf4qLyduTltmysOo4cYTe5UY/iH1tOF3iEiF2Az0IxegTK
	y4dUYSkUoiOIRjjmmwt0eoP8GAEiZFNvhy+26aUMS4I3+jbMMm13rNu6vh/0p+aq
	DYYPxyeDSJ5Lna7AfyOBUlnH0No+p+L6ZEQfXnNVW9DaazOERdcyndvF3j4nRBwi
	5FdimDGNwIltHw1+MChSY6Lx/ZdEHL/lQFpLZ7OV7b+toiMZdYreM0lsZXfthQER
	9FJtaQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43gjmt16pv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Dec 2024 17:11:45 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BDHBiIo013387
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Dec 2024 17:11:44 GMT
Received: from [10.226.59.182] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 13 Dec
 2024 09:11:44 -0800
Message-ID: <be1f7725-2177-c376-6e96-6be48773f419@quicinc.com>
Date: Fri, 13 Dec 2024 10:11:43 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH V2 7/8] accel/amdxdna: Read firmware interface version
 from registers
Content-Language: en-US
To: Lizhi Hou <lizhi.hou@amd.com>, <ogabbay@kernel.org>,
        <dri-devel@lists.freedesktop.org>
CC: <linux-kernel@vger.kernel.org>, <min.ma@amd.com>, <max.zhen@amd.com>,
        <sonal.santan@amd.com>, <king.tam@amd.com>,
        <mario.limonciello@amd.com>
References: <20241206220001.164049-1-lizhi.hou@amd.com>
 <20241206220001.164049-8-lizhi.hou@amd.com>
 <d4db5e3c-56b5-ed77-95af-15e9271339ce@quicinc.com>
 <ab646462-07f2-e09c-cd4d-6bc697d8cd43@amd.com>
From: Jeffrey Hugo <quic_jhugo@quicinc.com>
In-Reply-To: <ab646462-07f2-e09c-cd4d-6bc697d8cd43@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: j_9XKytAhnhbnYvTVEl7mGjgbdd8lo2i
X-Proofpoint-ORIG-GUID: j_9XKytAhnhbnYvTVEl7mGjgbdd8lo2i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 phishscore=0 suspectscore=0 priorityscore=1501 mlxlogscore=999 spamscore=0
 malwarescore=0 clxscore=1015 adultscore=0 bulkscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2412130121

On 12/13/2024 10:02 AM, Lizhi Hou wrote:
> 
> On 12/13/24 08:58, Jeffrey Hugo wrote:
>> On 12/6/2024 3:00 PM, Lizhi Hou wrote:
>>> The latest released firmware supports reading firmware interface version
>>> from registers directly. The driver's probe routine reads the major and
>>> minor version numbers. If the firmware interface does not compatible 
>>> with
>>> the driver, the driver's probe routine returns failure.
>>>
>>> Co-developed-by: Min Ma <min.ma@amd.com>
>>> Signed-off-by: Min Ma <min.ma@amd.com>
>>> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
>>> ---
>>>   drivers/accel/amdxdna/aie2_message.c | 26 ----------
>>>   drivers/accel/amdxdna/aie2_pci.c     | 74 ++++++++++++++++++++++------
>>>   drivers/accel/amdxdna/aie2_pci.h     |  6 +--
>>>   drivers/accel/amdxdna/npu1_regs.c    |  2 +-
>>>   drivers/accel/amdxdna/npu2_regs.c    |  2 +-
>>>   drivers/accel/amdxdna/npu4_regs.c    |  2 +-
>>>   drivers/accel/amdxdna/npu5_regs.c    |  2 +-
>>
>> Do you need an update to npu6_regs?
> 
> npu6_regs is added with upstream fw minor already. Thus, it does not 
> need an update.

Ok.

Reviewed-by: Jeffrey Hugo <quic_jhugo@quicinc.com>

I'm expecting to see a v3 based on the other review feedback. Let me 
know if this is incorrect.

-Jeff


