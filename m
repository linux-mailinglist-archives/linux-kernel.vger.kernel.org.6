Return-Path: <linux-kernel+bounces-434010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FA1B9E601C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 22:30:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35200165B28
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 21:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 038271CCEDB;
	Thu,  5 Dec 2024 21:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ElZEW0SV"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB1D1C174E
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 21:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733434195; cv=none; b=YGsrCjzyOrM+lXZ+Xmw7B0qW3CBfjwZdvR+DoNQAchfKoK/RndLPt/1zJSudZ9X2QqZOx6TKoX4pZQ5vfGh01q1tR3Swq1jD7UmWP16GAd/PtOTld2dBqUqvzzWxtaVBfw7v5MN5pMyCFE8W15O8jexiF8P+QGJYFunwR+W99Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733434195; c=relaxed/simple;
	bh=gBhI0bm83nD4F6ci3DPATOQR64oPTgFRK5nJLhi4Rfs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S+jJSAX9sD6gHMYd8J9YmWPhYXCbKGKzobK+Flxr2uBs1gLce5fehsccrkC8KSkmDxAUzmJPnGT7tlvyKPAS0f5VF2ZTNHqfl6Lc/Jdm+JM7mJ4ZmFcqBwvyxBpkFz8tTxxceV2LVfuxFL+PKZAuQ5+HyzOddnhle+LxME8Q2VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ElZEW0SV; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B5JiFXH018997
	for <linux-kernel@vger.kernel.org>; Thu, 5 Dec 2024 21:29:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	efl0ofco0IcUEUS0WoevpM0QoH5hWyp/iE3lVMb/DzA=; b=ElZEW0SVJfO9pS11
	cUSh327DNKJBdwuL2r2eogyVQUISzwyUAHuE3reKmhiajUP14Da/ipdeRle0sLsy
	8iXbS85xYPtXhtKIZJb732ogzaJDlA9Qj1N+hS1TGCxGxclf0vUYR8QJ5L31hD8A
	I7qPKsawcqZCaJ5RUnEQPveU9sJGzHNQID3bSyVHgP/sWpe3jnhe/OW7vio9Nco2
	NbpYs7cqyXWb18BwG7tG0TT85AlH3A9PQD8KU6cuPj2XOewvtpGeibdVsnKl+ZPV
	fZq9KBs19tB53fzLn3G4/Hfq5EqUq1jpNz5Jc7IsQQ9A2pfw7bqpvDDX6w/Bi0De
	544OIA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43bjk8r6qx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 21:29:52 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-46699075dd4so3430411cf.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 13:29:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733434191; x=1734038991;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=efl0ofco0IcUEUS0WoevpM0QoH5hWyp/iE3lVMb/DzA=;
        b=syMLMwTOcllThhrXUwg5AXv3iWUiS+ylJ2mWU17BM7iabRsQcVp4mG0+SaRHuWmDGo
         fh2/YBY7YWPhGjc2n8XWKewWJw11Rw9A79MnnznrsVuljz6g1hYQAs8j342Qf+qi/o8b
         Rz343ljp9EHQO9JJKMpSdQxPGU3/1xGIjMpzC0Kj2qV4ElWA1ga5iPZSN1BD3JbTZI9G
         iftLlHqhnoEnDMRWdilXfN4zqEx0csv/FjyA5SKXz6zH5btS+4cI2vW0E1Q0g+jnyVmz
         Ow66928STy1agGMvlBWXEfNjfvP6zYbm1I3KCJGvGOj7upxfhEYigSiIgFj3XFZc1N34
         Oakw==
X-Forwarded-Encrypted: i=1; AJvYcCV17jql4mpMXGzvGPkSjL3yz83HTxO4QOKyBQB6QRuqKRRAV9zPKFHEEC7BKUnqwY2WvO2GDgP1ef52Mys=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmI2W/q2yIwrCtaO/LRalaR0/FToXXB12xfx5uEIjBbyqfD1U9
	47/pkOvDP9RHuJVKCyvQ0Q8Vx/qGLTm19iBywCmVXfGVeF71/EJVj1DnvVe6etTW/vm4aqjNTuy
	9H9Lp8nhJrWnwh1qkftj5TVjDxUZySiTVwA0D4te+kkG7odIH0BJ8rMPR3fdcxUqVfp5h+vs=
X-Gm-Gg: ASbGncvIDprNksyTsmJCsapF/zMozdV2lOKZ3wX+Wy9WlsO6siOI1EHw3Han+BdfwKs
	fafye0xZp60lDC4TZVe2tzzp6JnYqBXREtQk4L4/qCcngnRlg+mBVCRXsfoBAPer3u4sU6kQ6Ph
	TLRSVWNLxLHSjuWCrwLhCcefyyJzuf3ddlcz45iz1y9oSSn5q5f/9hOKEVdJRFNHtcMa0d/LynQ
	XaSP0Sug0/bkh1g63xgihcTuWkWe9ClTDLOKomR6Uz4itIGoe9QJ0oyOXqWu7ZfkS8VBacGxLa1
	MNsXQyQxnBCSi5gPv6/McxO1F/KQ4Js=
X-Received: by 2002:a05:620a:4081:b0:7b1:4537:f57d with SMTP id af79cd13be357-7b6bcafd13dmr49006985a.9.1733434191377;
        Thu, 05 Dec 2024 13:29:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF3uIvTj0pHgIm/CkCxzyUcggXhdHNl9bKj1nZMK1Odu5jBfhEPSkmMsCiJxa1S0NUQzbwqmA==
X-Received: by 2002:a05:620a:4081:b0:7b1:4537:f57d with SMTP id af79cd13be357-7b6bcafd13dmr49005485a.9.1733434190919;
        Thu, 05 Dec 2024 13:29:50 -0800 (PST)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa6260edc66sm143944466b.203.2024.12.05.13.29.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Dec 2024 13:29:50 -0800 (PST)
Message-ID: <14682c2b-c0bc-4347-bcf2-9e4b243969a7@oss.qualcomm.com>
Date: Thu, 5 Dec 2024 22:29:48 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] arm64: dts: qcom: qcs8300-ride: enable ethernet0
To: Andrew Lunn <andrew@lunn.ch>, Yijie Yang <quic_yijiyang@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <20241123-dts_qcs8300-v4-0-b10b8ac634a9@quicinc.com>
 <20241123-dts_qcs8300-v4-2-b10b8ac634a9@quicinc.com>
 <cbd696c0-3b25-438b-a279-a4263308323a@lunn.ch>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <cbd696c0-3b25-438b-a279-a4263308323a@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: ADFOAtiX4Bj7q_miZvUwHJX4q8sJWCVs
X-Proofpoint-GUID: ADFOAtiX4Bj7q_miZvUwHJX4q8sJWCVs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 bulkscore=0 phishscore=0 suspectscore=0 spamscore=0
 lowpriorityscore=0 adultscore=0 mlxscore=0 mlxlogscore=865
 priorityscore=1501 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2411120000 definitions=main-2412050159

On 23.11.2024 8:41 PM, Andrew Lunn wrote:
> On Sat, Nov 23, 2024 at 04:51:54PM +0800, Yijie Yang wrote:
>> Enable the SerDes PHY on qcs8300-ride. Add the MDC and MDIO pin functions
>> for ethernet0 on qcs8300-ride. Enable the ethernet port on qcs8300-ride.
>>
>> Signed-off-by: Yijie Yang <quic_yijiyang@quicinc.com>
>> ---
>>  arch/arm64/boot/dts/qcom/qcs8300-ride.dts | 112 ++++++++++++++++++++++++++++++
>>  1 file changed, 112 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/qcs8300-ride.dts b/arch/arm64/boot/dts/qcom/qcs8300-ride.dts
>> index 7eed19a694c39dbe791afb6a991db65acb37e597..af7be26828524cc28299e219c1f0ad459e1c543d 100644
>> --- a/arch/arm64/boot/dts/qcom/qcs8300-ride.dts
>> +++ b/arch/arm64/boot/dts/qcom/qcs8300-ride.dts
>> @@ -210,6 +210,95 @@ vreg_l9c: ldo9 {
>>  	};
>>  };
>>  
>> +&ethernet0 {
>> +	phy-mode = "2500base-x";
>> +	phy-handle = <&sgmii_phy0>;
> 
> Nit picking, but your PHY clearly is not an SGMII PHY if it is using
> 2500base-x. I would call it just phy0, so avoiding using SGMII
> wrongly, which most vendors do use the name SGMII wrongly.

Andrew, does that mean the rest of the patch looks ok?

If so, I don't have any concerns either.

Konrad

