Return-Path: <linux-kernel+bounces-323699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13C7E97420B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 20:24:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B271A1F23E8E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 18:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2945F1A4E7B;
	Tue, 10 Sep 2024 18:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="l7QhLuvo"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE48816F27F;
	Tue, 10 Sep 2024 18:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725992653; cv=none; b=lxafwXJZMH/jZtjw0HWNDVAPSGGBiJ/dqZaTcxaU5dhMJWEoIpw4TKuxh7iGg0kta50Y85j2ZZAELtb19vsLDUEms2AS6912b10QRoTSN1QLp0PYg30MR0E8c2NgXb81ydbYi/tj8J7SuT0RG4cnp4Su5MBAQ0Yoj9hyWQPx25Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725992653; c=relaxed/simple;
	bh=FXc84KrUTmYWpngdZdX7oT+66rodhCYt/xubydX6mNI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=keN9+KgF+a2uxBMt6jGIRvKLl+xxXozNmbOvTTPV0NcMqC50Zr60WRjkm8L3O44K4grBqGCRg7HCknkE43jBZoyjZQNM6z+N9+TJJPNDPCyO7o26XpO50VhJa0itlpIieAcQJ4HlptykcR6bv4MmJxbAHZvYkORMkpKcF2CMXtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=l7QhLuvo; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48AF06TT020621;
	Tue, 10 Sep 2024 18:24:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FXc84KrUTmYWpngdZdX7oT+66rodhCYt/xubydX6mNI=; b=l7QhLuvoNrB7z+99
	WvkU89/TJ/VDnvTXiwgXnWo5FqS+k0ik3u7azTTkDe2ExvA9qtSZUQK09jyW3x1S
	D2IGe3FhZWF6M6NAzBbQJIa2u6yNbMogV9gCxGaCy5ZL6aIl+yyr5uD6mFCRG8bY
	YngpFMKXVF9TfGP1xlvM8uDqlVwqfBWFFfRkVQ0v9Fvk1ZQ5MTbSfmL/SlK1kU/C
	KTzDDodEey1qjuRiGC4mHVwKCnFxpu9jdPRWGvl813WxooY+2o18oxl9BJJQVT4S
	PkP+sVfF/jxWQscjpFmjGfEJ5hcvuHhTd06Tr/yNdK+U6RczX4VroD3CMG8Zv1Mx
	oiakLQ==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41he5dx94m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Sep 2024 18:24:01 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48AIO04v002310
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Sep 2024 18:24:00 GMT
Received: from [10.110.64.127] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 10 Sep
 2024 11:23:57 -0700
Message-ID: <a18a8a39-5e32-4fc0-95bf-9544aab2799f@quicinc.com>
Date: Tue, 10 Sep 2024 11:23:56 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] dt-bindings: firmware: arm,scmi: allow multiple
 instances
To: Cristian Marussi <cristian.marussi@arm.com>
CC: <sudeep.holla@arm.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <arm-scmi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel@quicinc.com>,
        <quic_psodagud@quicinc.com>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>
References: <20240910163456.2383372-1-quic_nkela@quicinc.com>
 <ZuCDXQaUDfmUuh_D@pluto>
Content-Language: en-US
From: Nikunj Kela <quic_nkela@quicinc.com>
In-Reply-To: <ZuCDXQaUDfmUuh_D@pluto>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: TnhuFgINHBQFCfABqCDg2SWbxMR5kp-9
X-Proofpoint-GUID: TnhuFgINHBQFCfABqCDg2SWbxMR5kp-9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 impostorscore=0
 malwarescore=0 mlxscore=0 phishscore=0 bulkscore=0 adultscore=0
 mlxlogscore=620 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409100137


On 9/10/2024 10:35 AM, Cristian Marussi wrote:
> On Tue, Sep 10, 2024 at 09:34:56AM -0700, Nikunj Kela wrote:
>> This change extends scmi node name so as to allow multiple
>> SCMI instances.
>>
> Hi Nikunj,
>
> LGTM.
> Reviewed-by: Cristian Marussi <cristian.marussi@arm.com>
>
> Thanks,
> Cristian

Thanks Cristian for reviewing the patch!



