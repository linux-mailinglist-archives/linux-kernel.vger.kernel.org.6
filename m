Return-Path: <linux-kernel+bounces-534549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 79454A4685D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 18:46:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8BA787A8901
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 17:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB62522541B;
	Wed, 26 Feb 2025 17:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jeHlYBpP"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA0EE22370F
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 17:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740591955; cv=none; b=DBbKLSVTDJU2c8X0yZFYEhTFHymBfWLrwThfsXrXAvYzlALrFSrpnQYT8aBQuJmtbx5sDedWxfvgBg6VbZU7T6fipozYS+d1VyECF+uZrxUYG5k2U4e2XxZpSBtRYQG2rLhLUzrT56OR+vQAiOsYQeZmjDWlOJ4QirrKI2sCZwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740591955; c=relaxed/simple;
	bh=h3UCkmKo1484qRmPGgUdh+KMuRZG6JXSyGfmIPrt1D0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lSna+7AK12jpK3TkyTEywcO7GTmcOn33hjoKJ6r0FTyFSZmiAnfQveyMKwyHHMphMXKSKORyX3bcuyofbBzTtLHE+SZtlgvV4QaalStooxM58IMgeMj5RQFyLryDByDfov5Gg9AXIHMdcuRKlHDFZR4dR9CwrYzAYmWdGW1E06M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jeHlYBpP; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51Q9o9On017718
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 17:45:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	spHUr3AXu2f0Q/mYO04AU9/9MDHJOsZPrNXfPRcj58M=; b=jeHlYBpPslALlr35
	LN/uaObw2ZoG/LQHgaWyQI/uXMZ6mMDZ6U16XzI0anqA+3eGr5/MB5AnU+JwwhIU
	Juz4RQ8HBU0S9o7MDUji9ehBZaB1hB/rgaF72YoMdcI9+8rIsxe9cpHiG0PJxOt+
	aJK33zfI7qTp/eEXJdWNORn8/3OQNoGbGVgE1VoeviK3FHY7G+4+8E6CaEhNZI0Q
	sI/wYzry3EyfvRC8eDjJ5fC4eMAKBLDrpTb8ThZDDrBm+bGQ3zM0Y58MZsrJB8Om
	+43G0FqKBS0axFBOlW4LlomnjOVdCD3QdK5nltFr+7iQqbp2MzCPcMQTQEwD4uh+
	/iCfQA==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 451prn2u4r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 17:45:52 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6e66c7e5348so227876d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 09:45:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740591952; x=1741196752;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=spHUr3AXu2f0Q/mYO04AU9/9MDHJOsZPrNXfPRcj58M=;
        b=kgpIloGCQp3R7AsDc/MQM0faTticJSh16nPBMX56KshYTbvzAGC7f5io4jgH1udQml
         LidO1tPFjr5udt9EWVy9F4AfX7Yjl4A1O7yYLwsdq9gtJLs4y+oAjRGeZB9Cy28g2S8F
         Vjn7aQAIO+gV4eqdXrPRqc6suQo9wQiGYDRiDUxi5cUG2rCfO4WcfatWtRKKGXDjhARY
         FLXhPGC3OLjOOdSuT/AqyLGV5Z1Ho35fAZEN7B2hZ8+z5kGYfQQhXMyIIOsbIf31dW+M
         P9mCqaL3h0P6rYNzviciwjxZlj+IFUUUmtaPvxDnZCCFRgE6/+dLltDwpMjID1eJhWA5
         vGFQ==
X-Forwarded-Encrypted: i=1; AJvYcCUl0lFO32moGFOw1n7ld1AiwQ4oBhRoaK+ocpUEU/JikOCAFsCHABJVZqJ+lbeikZS8ODOVyd15aRWR8bQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywgct0BPAuav18ABxJXth3mcv/PsxW4Jvfo4CyTRsX46crzV/pa
	3oApq8HKzHnnPECalujzseXAgn303Nn9rEmaMK56Bx3hrjSoo4gWAlJo7BVMee6gtKI+agg3Ogk
	pxbDX/KHTIqeZO0z4i/8wWjuhYF+v8bvVP3HtdJD8lDBUX4vbA/CimOiWcrSAvT0=
X-Gm-Gg: ASbGnctLFTSwDT3QwjduUkwEliNLQ5PxniK4NunEhbDig+vQPtX+nV0WEJYBi14lARl
	Ho+LNIpg532JXBtu/Br2Riu9WBynTfHDEAjtmqFAWoo1rBmTBEl3iBLOjEa4NTnYPWQe7yxVntx
	ewY3eEWkTqUm2l0f0QdIyQGeMMjNHFHyG+LtKldS51L9tsc9uLWs8AaqfCwraUTkv/Z+YAN6CM2
	g6ABXLkIkk7S0I5BkuMDzWFarVgK+11SYykcJWdyDI/W37sgo6n2CGaPC1DzcA4Bv13S+lKKUtt
	FZAhrcAklJkxjAf1rGnW15Go57k3sGoTNoJ6tHdxFeHBYcpWjQUg1Xk8RiB87esx3kVHdA==
X-Received: by 2002:a05:6214:21ca:b0:6d8:99b2:63c7 with SMTP id 6a1803df08f44-6e6ae9a12a7mr104618836d6.9.1740591951734;
        Wed, 26 Feb 2025 09:45:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEoiQ5KxqxulmOEbv7ZhtbSVl8vtd+3f7Fmtz2NRViZu3o4YsIbbM/qm/sPMHNIsdwdfvGp7g==
X-Received: by 2002:a05:6214:21ca:b0:6d8:99b2:63c7 with SMTP id 6a1803df08f44-6e6ae9a12a7mr104618696d6.9.1740591951315;
        Wed, 26 Feb 2025 09:45:51 -0800 (PST)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abed1cd5629sm361206566b.8.2025.02.26.09.45.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Feb 2025 09:45:50 -0800 (PST)
Message-ID: <99ed4a61-6e0c-4743-91a1-2312152ccf6e@oss.qualcomm.com>
Date: Wed, 26 Feb 2025 18:45:48 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] arm64: dts: qcom: qcm6490-fairphone-fp5: Add PTN36502
 redriver
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Luca Weiss <luca.weiss@fairphone.com>,
        Bjorn Andersson
 <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        cros-qcom-dts-watchers@chromium.org
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250226-fp5-pmic-glink-dp-v1-0-e6661d38652c@fairphone.com>
 <20250226-fp5-pmic-glink-dp-v1-1-e6661d38652c@fairphone.com>
 <696aed52-7519-4351-a3f6-7b86778b18c3@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <696aed52-7519-4351-a3f6-7b86778b18c3@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: ZsVG8xQPEtmbXRb9doDd8nnqih59HSaf
X-Proofpoint-GUID: ZsVG8xQPEtmbXRb9doDd8nnqih59HSaf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-26_04,2025-02-26_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 clxscore=1015 mlxscore=0 adultscore=0 mlxlogscore=802
 suspectscore=0 phishscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502260140

On 26.02.2025 6:40 PM, Konrad Dybcio wrote:
> On 26.02.2025 3:10 PM, Luca Weiss wrote:
>> Add a node for the "Type-C USB 3.1 Gen 1 and DisplayPort v1.2 combo
>> redriver" found on this device.
>>
>> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
>> ---
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Actually, please also rename the redriver node to redriver@

Konrad

