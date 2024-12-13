Return-Path: <linux-kernel+bounces-445184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51F2C9F1269
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 17:42:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71B99162F7F
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 16:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B07AA1E2306;
	Fri, 13 Dec 2024 16:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="GWoOSPhA"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A4516A395
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 16:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734108166; cv=none; b=IH6QTMtf4a7T8pM1vNe9gLa33TIKqQvLM0XHBZF5Weh/zyBNneRjIW0nelv6T7h/QuXhkh9mywEkzYq0Aw6ZQSzRHJbbcD50gu3BpNNn/+UBltnK2oav+V+gPwi50/xMeRaHcQ7PbArScEfsN9lOqvH9fiqohxbfuCEFMcmBkPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734108166; c=relaxed/simple;
	bh=5PgxpjxipbKj1Nwr0N326xKNHnOrMBDB3nQAFx0BBoU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=fm6kVHaWdOq6yhETCZBTHf8vXw6TRdN39Y1rL6QMldkHIKWUQya2qkqyWnrULSOgCXpfKdth6yU8+bUZYtJkMvP7XOu7N5c8LUxO2OHAbrXaRBrLIHOvx0ozef9OpqnvGor6eBzuglQgWeWgBXTqX7t/zrr1OMusrvDlavZIu8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=GWoOSPhA; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BDBj3gB022262;
	Fri, 13 Dec 2024 16:42:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hZJMD2KkV2bxXZ60B1kpI2halUOt5PVlO616O1Nuu0c=; b=GWoOSPhAJ4iXvnDU
	cuDft0nhdKBYigBkKawMZCz7SD0l2GesSYEj28ojE/oK/6T2aBS2E0bozplkFXb7
	OP8caJEJYXq6wkw20cCSpMYJjfTGrj6yH5SA85lb7qGpnTX5uStmhhVaHNgHnlBj
	8vJs+uerhhBHU+D3KQYOnyGKH9jhZLzYXc3HFoe9L6wWsdAIPc2v4IBgTiMSc8sB
	rlS5h0c/sz5nd1gz22CqNJsn5auwm2fAfNRsHlgcCmiux7TOFHV9IN0bID0BSKm5
	2OC9P8H1tDoqFI0wRMDvsmE99SNmY5wrjtxTnHaGQ+/qUQMwU+LpVEMNGzjr0L9T
	ho6TsA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43gmac0s22-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Dec 2024 16:42:39 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BDGgbsN015572
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Dec 2024 16:42:37 GMT
Received: from [10.226.59.182] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 13 Dec
 2024 08:42:37 -0800
Message-ID: <58c6106f-7d44-fb89-bca7-09e28dd51d6a@quicinc.com>
Date: Fri, 13 Dec 2024 09:42:36 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH V2 4/8] accel/amdxdna: Replace idr api with xarray
Content-Language: en-US
To: Lizhi Hou <lizhi.hou@amd.com>, <ogabbay@kernel.org>,
        <dri-devel@lists.freedesktop.org>
CC: <linux-kernel@vger.kernel.org>, <min.ma@amd.com>, <max.zhen@amd.com>,
        <sonal.santan@amd.com>, <king.tam@amd.com>,
        <mario.limonciello@amd.com>
References: <20241206220001.164049-1-lizhi.hou@amd.com>
 <20241206220001.164049-5-lizhi.hou@amd.com>
From: Jeffrey Hugo <quic_jhugo@quicinc.com>
In-Reply-To: <20241206220001.164049-5-lizhi.hou@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: tEgSrz_MklInDwf0bxk7oj7I2YbK_W8h
X-Proofpoint-GUID: tEgSrz_MklInDwf0bxk7oj7I2YbK_W8h
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 phishscore=0 impostorscore=0 priorityscore=1501 malwarescore=0
 suspectscore=0 spamscore=0 adultscore=0 mlxlogscore=564 lowpriorityscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412130117

On 12/6/2024 2:59 PM, Lizhi Hou wrote:
> Switch mailbox message id and hardware context id management over from
> the idr api to the xarray api.
> 
> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>

Implementation looks sane, however you appear to be missing several 
instances of #include <linux/xarray.h>

-Jeff

