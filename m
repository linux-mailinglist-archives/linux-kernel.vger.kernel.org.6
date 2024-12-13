Return-Path: <linux-kernel+bounces-445054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69FC49F1062
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 16:09:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20D0E2843A6
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 15:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DB471E1C09;
	Fri, 13 Dec 2024 15:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="l8xiEAJi"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E261D8F5E
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 15:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734102516; cv=none; b=CfPqdKETbe+vW7SXjOJyM05lIUyQx2KMt8ehYUzj1RFCPC6gpIXVz2Ou35r9iwpRquvh9La66b8oN5a27kD0OdhQqIay4gGRAu9OwjnpAixEEdXeMMr8GkovUP+QoUwEno+3scuO/EVErFA4+Mcc52vU5g1LPg3C2hyHkZvPUxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734102516; c=relaxed/simple;
	bh=gifl5K2wVo1pUEBYfH4X/5VFPN2lBKZmAvz5lyuJzXI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A2YXTS/xMUbrWe1WFc71w/wNboe3tjKxSdODoHmauXDDBl3ATnsWOiKj0G4iBwRb4ggQl8eMPjs6YrKYhDrzmRaaBQ59xGll724F/RoNHgLKohDyU1XNaNBHHGch4r5sy267onBICvvALXx44+FK+O0+YpxjjrN0t/cfP55Z10o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=l8xiEAJi; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BDAPfu9024170
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 15:08:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gf/fh9YGa6CvGhKh2kJtbLjeDgDSqi4w3sMvOIhuQQw=; b=l8xiEAJi/rzNYvYn
	LP6U5R2lzWm1Hybbqq985lUCKHurNYmi2yZ1xmnFl63cQyUoMjye0CnpdZlN7qL5
	i+7hVXfTPP0lpFI+5NZASzv3LMr/ah/BXpPL7MFISkhk/i5f2gm2QVrhz7QaT4Xv
	nYxupxRM6zVXRq3twGHxoeJuI797yFW19tpNChPaYO27NyIX7WlR1GZYRCvqB3nA
	WK4cQL8V04JRd5BymBDcdAq8DR3yQnsdIARFp8kUKsthc5lxqAX6yBEAV1UZCKC/
	13Q8GMS4YLLiWd4qSQo7ANJ1an8OVZdzaD6+AbPBhEPXKmQttK3jSh7T0vwmWxgX
	LAKXaA==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43fd40ps4g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 15:08:33 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6d8f77bf546so4730706d6.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 07:08:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734102512; x=1734707312;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gf/fh9YGa6CvGhKh2kJtbLjeDgDSqi4w3sMvOIhuQQw=;
        b=CLSjndC4ueYN6bz4LG8Yuup4lkfCJrqhBMVRM25vsMOvd2W8KtHIT8Oz13h4BcqQ/R
         1gIm+vIgwAinOU15faQMsv8cVLrkUrMcl7V7hyD5sNW2SV4lKEwgZwIbxDYlPeB+02BF
         J6EO6vilwxsYpmf/gDOG3aD4pkaBJdREe2FbXoy333atCUMSI2RCwwbvoVF2LLjXwl+p
         TPPJSxKn2Z7IAUXXgaO1szzldPDa08gqIW4/KzkFtC+NLpn6Ooyj0XA+ULnNRfXAJfnG
         w3I8tIdiqdfcAg3DDQ2z53v4dECRTeG3hOBgtTLIZLwz22D1b2mL+TnpyGoMhHKio7VE
         U+Bw==
X-Forwarded-Encrypted: i=1; AJvYcCVb7URnfnAVvTWEJcraDv5ER+jvruWKNaMxWyIevIfomYtj/ki1JoBGSs4xxp80uzRBheaeorXC2nOyEoA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZjQKQnCYwinLXcaBHy4/ZEJNS2kyaHlgpFT9LofaEz6zx+qe6
	3R7VIkX8sos9lqz4ifWP6dP78EE5jQfjDPOCOMa2qvEAxjMEMTSmg8bYBxnbzBRXRmfj4i2bxQH
	4NjzWH8taV0ZJNacUsYEy2X+K0gvg+9Sd+tQWdmvru10KWzR0r/BOgRN2S/WHS6c=
X-Gm-Gg: ASbGncsar29n9CSEtljrsAJCBkpJmviRtTm26XytVnd81f7BEIk3s/EftFvSvmkzlT/
	CpW4ZtjxB+M7p7mXGTi2wNCEUl+AmkPty18tnmqJeg7ogeJDU8Gv0EhgtGuk2AoTYvcEkdN6QbG
	fw86sDbHwu5ucN8d3Pe9gyNpNxevK5aa9bXdHUtCgvYD6yq4kehX/69eXdztDDNKAju4/fewjQK
	+kARF6Yw3+SzAxROYmR473/gcGAQqPDtUDHUT9QYowvdqRINtCzuAtNvyleYhlyGQOAUfcfp3af
	UqwYOyHl0KUjkFbe/yIQq92S9HPR2v9z+C+x
X-Received: by 2002:a05:620a:414a:b0:7b6:ce0a:d28c with SMTP id af79cd13be357-7b6fbec8010mr196209485a.1.1734102512430;
        Fri, 13 Dec 2024 07:08:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFX2nm0PualiDIHCcimw5pbm6pmtCmSanRdLgYIld/OBrvjbYoZl7+DIgL64ZiMsGszKUs5/g==
X-Received: by 2002:a05:620a:414a:b0:7b6:ce0a:d28c with SMTP id af79cd13be357-7b6fbec8010mr196207085a.1.1734102511977;
        Fri, 13 Dec 2024 07:08:31 -0800 (PST)
Received: from [192.168.58.241] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d6501d5863sm54806a12.76.2024.12.13.07.08.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Dec 2024 07:08:30 -0800 (PST)
Message-ID: <98fe04fb-8ae5-4fb6-91bd-3f9406efab02@oss.qualcomm.com>
Date: Fri, 13 Dec 2024 16:08:27 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 20/23] arm64: dts: qcom: sdx75: Fix MPSS memory length
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Abel Vesa
 <abel.vesa@linaro.org>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Luca Weiss <luca.weiss@fairphone.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20241213-dts-qcom-cdsp-mpss-base-address-v3-0-2e0036fccd8d@linaro.org>
 <20241213-dts-qcom-cdsp-mpss-base-address-v3-20-2e0036fccd8d@linaro.org>
 <9a7f43fd-a720-481e-b8ca-68150c202b74@oss.qualcomm.com>
 <d7a89a5d-cb70-4d05-bb3c-9f4808984175@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <d7a89a5d-cb70-4d05-bb3c-9f4808984175@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: Bjer0lNr_pmuL8kRz9J9D4lXvOIl9dau
X-Proofpoint-ORIG-GUID: Bjer0lNr_pmuL8kRz9J9D4lXvOIl9dau
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 suspectscore=0 impostorscore=0 phishscore=0 clxscore=1015 bulkscore=0
 lowpriorityscore=0 mlxlogscore=999 priorityscore=1501 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412130107

On 13.12.2024 4:06 PM, Krzysztof Kozlowski wrote:
> On 13/12/2024 15:56, Konrad Dybcio wrote:
>> On 13.12.2024 3:54 PM, Krzysztof Kozlowski wrote:
>>> The address space in MPSS/Modem PAS (Peripheral Authentication Service)
>>> remoteproc node should point to the QDSP PUB address space
>>> (QDSP6...SS_PUB) which has a length of 0x10000.  Value of 0x4040 was
>>> copied from older DTS, but it grew since then.
>>>
>>> This should have no functional impact on Linux users, because PAS loader
>>> does not use this address space at all.
>>>
>>> Cc: stable@vger.kernel.org
>>> Fixes: 41c72f36b286 ("arm64: dts: qcom: sdx75: Add remoteproc node")
>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>>
>>> ---
>>>
>>> Changes in v3:
>>> New patch
>>> ---
>>>  arch/arm64/boot/dts/qcom/sdx75.dtsi | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/sdx75.dtsi b/arch/arm64/boot/dts/qcom/sdx75.dtsi
>>> index 5f7e59ecf1ca6298cb252ee0654bc7eaeefbd303..a7cb6bacc4ad5551486d2ded930c1a256d27655e 100644
>>> --- a/arch/arm64/boot/dts/qcom/sdx75.dtsi
>>> +++ b/arch/arm64/boot/dts/qcom/sdx75.dtsi
>>> @@ -893,7 +893,7 @@ tcsr: syscon@1fc0000 {
>>>  
>>>  		remoteproc_mpss: remoteproc@4080000 {
>>>  			compatible = "qcom,sdx75-mpss-pas";
>>> -			reg = <0 0x04080000 0 0x4040>;
>>> +			reg = <0 0x04080000 0 0x10000>;
>>
>> I think this should be 0x04400000 instead
> 
> 
> There are two QDSP6SS blocks - one at 0x0408_0000 and other you mention
> at 0x0440_0000 (MSS_VQ6). I think in all other DTS, e.g. SM8550, we
> describe the first, so 0x0408.

Ok right I looked at the wrong one

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

