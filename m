Return-Path: <linux-kernel+bounces-444714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31D389F0B77
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 12:42:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E18DE28333D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 11:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CE001DF24A;
	Fri, 13 Dec 2024 11:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="W0eh0JwL"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 982E8175AB
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 11:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734090150; cv=none; b=pkdX3SRipZh8rXl16/s0b5z5gq9KTLaPQCxoP6MUT5Fg4aQLwi4Ov5NcCIh8RqeDOpeeRz02RB/aELZnfyOawABAcSemuJOoWXTy89RNtIFO4/evzNeW6B0lXzH/3rBDijLWHH3YqX9D8e0tqaQz33lC2n1x9+fnZRz3wDchbl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734090150; c=relaxed/simple;
	bh=KfwElkoamyBr6dHaJmCP1yGZQtya9h6Gl4i7XC83T+w=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=SAUzQyt4xKhScRaMntTHGooiVyBvskqQw8V/umPf/rP2walurIqiLl+FfuUaHG6oZGvE403YUe85w2mOAwOhak8XIC+QydyUa7y64AtJpJ2f19M48F3ZzPl9UHl4VN+C45T+1D0Mx7xL/PGgHhK7QJE3tWQYaPFd+Olty3GX9E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=W0eh0JwL; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BD45wMw017909
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 11:42:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FQv7IVxjVACkrTRCvKOM4p4nwCL4rvLfPutFmzt3IYg=; b=W0eh0JwLthlif8WA
	GZMXwZCPyXXIEQy5MzDgB5Jj4JLgbzOsuspzrzjqEJjoRFNQl0TyFGKprGaPhOUm
	GQ4On/lC6NXH7e4esA5Ruiuk/d3Qqqonqu4Xw58aGQeuzxE1lqbXZTWqyYnYrJjR
	HgIh87cb56Rv2e/sdKrame3xSOgkJYn9+PW9JCGOqyvP1LB7pk/v+TYfv/Cm+hAj
	Ny2ERFc8F2wcYGR6sa/hDV6NYmEHglIbIQajve7dPBOrGVIHCmQrcoviUHVUOX6F
	97lSmg1OaRJUvAZ6ZRe3aqw26ngBPj5g6XZdXY10MzweCmoI6Da9MJ4f/+xzw8ca
	tVjn0A==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43gdkn15fw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 11:42:26 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-7fd481e3c0bso1180366a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 03:42:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734090145; x=1734694945;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FQv7IVxjVACkrTRCvKOM4p4nwCL4rvLfPutFmzt3IYg=;
        b=ZUwuzRJICHA1AYhhFoVLMMmFNRmseWt5FVBb+jtaYbINvZk1B06+It0pC+lpEws02X
         UFr+Tczfw5HNIT6fnAbnSGWYdP7uB+6LDX5Bv86TcsIM2n9l83/pHRgw3ou15V9uQ+9d
         8S+L0LMjM50cT5dCSpfvHRqQrRAxYifAUqMmLRk1mWU/hM6OVDDHb50w7YqimSSf89Hb
         tHJ0VM2gvA/yzy0FtydGTMviFFyYaaEDq/iJadQMIUtcgVQ/R4Ku6b+GyWc6LXcK1HaL
         0R68oM2wI7PccedDsM1MRCq61CIu/jupecpSCYwoGTMHAKuRntGuaJZbVmpkwGWLwcs/
         TNgA==
X-Forwarded-Encrypted: i=1; AJvYcCXa67UOjpr9KyqtANj1oVro7wto0X0SYjqpGs+yf+UtdFQiAHi4uAOYG8r5SoXfGT9LvL7ofXnpXeesa9M=@vger.kernel.org
X-Gm-Message-State: AOJu0YydZnmiFBiE/JOVWhx4oXiD43ppFbLJrtx8TTL+dBQHlaPO6lEf
	E48QJU4z+2QobvsLJ0/77KA3qpo6HIJ4AcafzH7bd0k17LC/4PsnxLA/2xgjV+QoGiJjfX9TY+X
	sjMJCZi5hsqhPb9KiMrEBU9GqO2czqB/aHPZV35okHbw/WWRPylLvKtg8Tu4EcL+yTmqTAVU=
X-Gm-Gg: ASbGncvIiu1IA5WU2wLdMTFrA8ue/6EO4KNIYAvCAPUNROu/aFeNYjAbsS7GsWH5CCV
	NnAAkWxxAtlxLW+RrnypgQnVvc02r0XlaqcA3D6/OKLRlvLwmRk5hoOGzMUb6BqqBc9d26MU78n
	vz7IVJAjZc3liSwRn++Mhb9nRaHwe5pSqXxS+FinCF5cOd8u/2HcvFR+XmSogqRLgRBJO2nFNfG
	rm86js3NDoCMVtVeKmJdP34oJ6/D3w3vLJVNi8P5YMYZSdgzbdi1B/nWf6YQwn4V2rY12fbNuZk
	kwJbc4fkjohF
X-Received: by 2002:a05:6a21:33a2:b0:1e0:c378:6f5b with SMTP id adf61e73a8af0-1e1dfe00a4cmr3432570637.38.1734090144781;
        Fri, 13 Dec 2024 03:42:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEbRGjC5kQy8J8gqH9ctFRDR5zOT73qras+Ov4x8ubPpgzJl0ESePQz9BB2CprPbojLAnteEw==
X-Received: by 2002:a05:6a21:33a2:b0:1e0:c378:6f5b with SMTP id adf61e73a8af0-1e1dfe00a4cmr3432531637.38.1734090144436;
        Fri, 13 Dec 2024 03:42:24 -0800 (PST)
Received: from [10.92.163.196] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725f1fa8ad1sm8583351b3a.103.2024.12.13.03.42.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Dec 2024 03:42:24 -0800 (PST)
Message-ID: <6800730a-d164-40a5-a3ae-dca3b1909c27@oss.qualcomm.com>
Date: Fri, 13 Dec 2024 17:12:19 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
Subject: Re: [PATCH v2 2/2] arm64: dts: qcom: Enable secondary USB controller
 on QCS615 Ride
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Song Xue <quic_songxue@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@quicinc.com
References: <20241211-add_usb_host_mode_for_qcs615-v2-0-2c4abdf67635@quicinc.com>
 <20241211-add_usb_host_mode_for_qcs615-v2-2-2c4abdf67635@quicinc.com>
 <cc3edfc6-f53c-401b-b766-f8e560eb24b9@oss.qualcomm.com>
 <lqscul6yal5mmztup23rcgmyqhfj3vt45rxxsw6ocrnumwfpfe@g3at5zqvtd5u>
Content-Language: en-US
In-Reply-To: <lqscul6yal5mmztup23rcgmyqhfj3vt45rxxsw6ocrnumwfpfe@g3at5zqvtd5u>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: XoHaYpID6t-HLiQDX5GMZcj-lOGk3LXe
X-Proofpoint-ORIG-GUID: XoHaYpID6t-HLiQDX5GMZcj-lOGk3LXe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxlogscore=999
 impostorscore=0 lowpriorityscore=0 clxscore=1011 priorityscore=1501
 phishscore=0 bulkscore=0 suspectscore=0 mlxscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412130081



On 12/13/2024 10:50 AM, Dmitry Baryshkov wrote:
> On Thu, Dec 12, 2024 at 07:14:22PM +0100, Konrad Dybcio wrote:
>> On 11.12.2024 9:26 AM, Song Xue wrote:
>>> From: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
>>>
>>> Enable secondary USB controller on QCS615 Ride platform. The secondary
>>> USB controller is made "host", as it is a Type-A port.
>>>
>>> Signed-off-by: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
>>> Co-developed-by: Song Xue <quic_songxue@quicinc.com>
>>> Signed-off-by: Song Xue <quic_songxue@quicinc.com>
>>> ---
>>>   arch/arm64/boot/dts/qcom/qcs615-ride.dts | 28 ++++++++++++++++++++++++++++
>>>   1 file changed, 28 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/qcs615-ride.dts b/arch/arm64/boot/dts/qcom/qcs615-ride.dts
>>> index f41319ff47b983d771da52775fa78b4385c4e532..26ce0496d13ccbfea392c6d50d9edcab85fbc653 100644
>>> --- a/arch/arm64/boot/dts/qcom/qcs615-ride.dts
>>> +++ b/arch/arm64/boot/dts/qcom/qcs615-ride.dts
>>> @@ -203,6 +203,15 @@ &gcc {
>>>   		 <&sleep_clk>;
>>>   };
>>>   
>>> +&pm8150_gpios {
>>> +	usb2_en_state: usb2-en-state {
>>> +		pins = "gpio10";
>>> +		function = "normal";
>>> +		output-high;
>>> +		power-source = <0>;
>>> +	};
>>
>> Does this go to an enable pin of a vreg / switch?
>>
>> I think we settled on describing such cases as fixed regulators
>> (that are always-on for now) - would you remember, +Dmitry?
> 
> You are right. Usually it's a fixed regulator. At least there should be
> an explanation for that pin.
> 

Hi Dmitry, Konrad,

  Thanks for the review. You are right. I missed it. There is a switch 
TPS2549IRTERQ1 that is being controlled by GPIO10 (just like in [2]) and 
provides vbus to external peripherals. I am trying to get some 
additional info from internal teams before sending v2.

  I followed [1] instead of [2] by mistake. Will fix this up in v2:

  [1]: 
https://lore.kernel.org/all/20240206114745.1388491-3-quic_kriskura@quicinc.com/
  [2]: 
https://lore.kernel.org/all/20240429162048.2133512-3-quic_kriskura@quicinc.com/

Regards,
Krishna,

