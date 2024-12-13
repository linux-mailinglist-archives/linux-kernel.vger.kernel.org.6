Return-Path: <linux-kernel+bounces-445232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FEB29F1317
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 17:58:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89F471883949
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 16:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B2721E32A3;
	Fri, 13 Dec 2024 16:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="axPdZEwC"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE0715573A
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 16:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734109128; cv=none; b=dOMWF9/9K0GygE+C6ZlXYe8Dvjd6iuHqr8NpJWTgSYTWqxRyaBMmBb95kOmwjWJTwo6U5tzudc+DYguSgya86LlgAw0+ih2CvuWFL5NZ7PIKTEx1nD0dubCigNbbkQG6PED/q/75Ua1p0hyVcZjeUvDdYbxuCdeAi6sMKk74BN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734109128; c=relaxed/simple;
	bh=D0z8RW+N6gZ5JCltukdoktT+HmmvEufTU12N5kFKvwI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=nDnG/9mkkB7kD/V8XFB5EE7iQTJblD/jLqOi6UHtrtt3jZksOtEAOEjuK6NjK6NDT0uiKPH5CNG7q1zxIxINvmWkMl6c4Oxpbp79uapiRBCQatzYz3SwbyHYQ1Wp6yZo69ODBud3w69E9LhyS0a5SFW+wZmbVz9ijVZXo+MsJwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=axPdZEwC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BD9plcR019566;
	Fri, 13 Dec 2024 16:58:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UOtFz7REUz4+AgQJxq3QS1WPjdIxLwCBvUCqJ/5aq50=; b=axPdZEwCYPmNatxK
	ge/mdbfAN7yE9cz9h3sXtAWtl1YDQs5S9apwoF34lXrNu1HavlW1xyP25wNCsObj
	48hSZXFosfBwDvhsXRM5Trselb2kOtBsUrGxGKbcWJWSPpLC9IQutZllTuXEctzk
	frvp3CxK3w0JcPzoiBR58YlYABgITz9TtuAhz6BdZQ7DKQ6X9KJ1pWofMXnf2WXp
	v+FmjsFXUtbbdR9cuDV80p7HiDSw2Gv6S8vd+RtKWKKp5k06qE5sbf66RY36e8MR
	pjGbb+SzaRF4YTP09jf6VHgC/UqRvVo717OVReBhl81oK/S0DEalW5Y3SMX81Yfm
	weFwag==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43gjnb15b5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Dec 2024 16:58:42 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BDGwfsh003988
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Dec 2024 16:58:41 GMT
Received: from [10.226.59.182] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 13 Dec
 2024 08:58:41 -0800
Message-ID: <d4db5e3c-56b5-ed77-95af-15e9271339ce@quicinc.com>
Date: Fri, 13 Dec 2024 09:58:40 -0700
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
From: Jeffrey Hugo <quic_jhugo@quicinc.com>
In-Reply-To: <20241206220001.164049-8-lizhi.hou@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: zfh18d9HyhH_T7KUcojeSRkCjAN_zQKH
X-Proofpoint-GUID: zfh18d9HyhH_T7KUcojeSRkCjAN_zQKH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 phishscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2411120000 definitions=main-2412130119

On 12/6/2024 3:00 PM, Lizhi Hou wrote:
> The latest released firmware supports reading firmware interface version
> from registers directly. The driver's probe routine reads the major and
> minor version numbers. If the firmware interface does not compatible with
> the driver, the driver's probe routine returns failure.
> 
> Co-developed-by: Min Ma <min.ma@amd.com>
> Signed-off-by: Min Ma <min.ma@amd.com>
> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
> ---
>   drivers/accel/amdxdna/aie2_message.c | 26 ----------
>   drivers/accel/amdxdna/aie2_pci.c     | 74 ++++++++++++++++++++++------
>   drivers/accel/amdxdna/aie2_pci.h     |  6 +--
>   drivers/accel/amdxdna/npu1_regs.c    |  2 +-
>   drivers/accel/amdxdna/npu2_regs.c    |  2 +-
>   drivers/accel/amdxdna/npu4_regs.c    |  2 +-
>   drivers/accel/amdxdna/npu5_regs.c    |  2 +-

Do you need an update to npu6_regs?

-Jeff

