Return-Path: <linux-kernel+bounces-381295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B45C39AFD4A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 10:55:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D75571C23B42
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 08:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8D401D3593;
	Fri, 25 Oct 2024 08:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mnoY1dXH"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B4A18DF6E
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 08:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729846529; cv=none; b=llrZB6d2wCJWJmHmpNnZlZDRw5p0rTooEdn1/u+n5pmrzGRfR0iXf6J7R9tm7MxRYo5yRfU63agR+ZmZ9ybz7VbBc6m93egrAFmSMrnmKP2mHaCzrirIpIuOfWoXBHTqiwI8UHF6gn/5HRzmFXrCoQHUIxw7xJX/IoHZk0mU80U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729846529; c=relaxed/simple;
	bh=fNQG1QZTbt0LxlFeQJHnAhJb4bHcsZWmEg15MTLR2Yk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JyHjJgMw3boa2CA/vbB6Pgmhptak+r0YlYR6C95Ks1AjPfSs8mJ3x355LYBPaP+u/EQ074vRbxlkrqEXKYxzdjSUXxXRNkGiukC7yGmmUzmSbnPcGYNXJg8llFzzwOpav9FNls00g7O5gAi+Eqvsko6n2uS9ygPnqCvnz5ZI20A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=fail smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mnoY1dXH; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49OL3VpD027195
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 08:55:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xpMl9MKbPWhvY4ikXMw6qzkaPHGDOB3f4Ep/LZ8PYkY=; b=mnoY1dXHc0fii/UR
	d0/hfZjBOvQajEy9SmO79u9DU/+iTkkBIRGlICiZT/BoQSJvprvFlRO//dEsnd3Z
	rieLGRTl0V5C4Eq9w5cgxxXogz3QeXY1UshLkScB2hL3KWERTRSBTJ42OMXE1pwb
	hsb4pCOFQnzASrKjpZwr0tIKT3Wf51TEV9UMyfxetupBi/uzwj4VOIrVW0Y/kdqJ
	yx0vtjIVXKWnWAlsX5wGGu0a3SIrd/lTRox/1OSqXoFjbqkb2n+efvN1NNHk/gTP
	NCwfVEsRQttdf1BYdT9YY25OH6b9fgybsbPxgoFTqrRa12rgqAejZQ4D6NBc43z6
	AFlpRg==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com [209.85.222.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42em3wrbb6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 08:55:26 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id a1e0cc1a2514c-84fba3e0787so18435241.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 01:55:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729846525; x=1730451325;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xpMl9MKbPWhvY4ikXMw6qzkaPHGDOB3f4Ep/LZ8PYkY=;
        b=KtcarYHhNbF4HbmcfaDP7Dnab4yMAwOauoNI853FwKd1cT3p+MhyfY+WsB5ZKi5u0N
         KgwYvsxFovcBqzdNephsMpZtUcv6by+JWaDeN8l4jdHnmqne60dLkbC8Au0uAprtNzle
         Hm3ZapdF3JR1S23UdlmrVVm1MM6Am0GVardGY6BjL1Jl59TKr4EehdUyBz8QDYIVKFBE
         aPc64wKmt0N+j4Lw8aALUvv3/0K/W84tr5CDWR6yajVLjXXBbBTEKxF9F04w/dErcCY+
         TTGHKUosdJZkLeoOQkB5jYzhW82Uj+1WUOW68YGXf+H8sAiEUcf3+ouawwBAwOOC9io+
         gL7A==
X-Forwarded-Encrypted: i=1; AJvYcCULR1ErpXSJ2Ywi7kYcuKFoBj+Qf2XplhVtexFeKXu03Cd79HbHygtD7uWWIDrKAaQ0THCEVzbz/j4240A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBH7MZzHoQQaKHoKISeNfo9Fc4iSQdncaecJnz66il8XaJna22
	917LZff1TV0NTOsEBwtDjH72LC8b1SYSEdp1V/JYuXMLHcyHRQS/TukNZfdoSWaHIIMH1HOvpbo
	s1jMwK8flFT7NI/yaf/x2hxGoZ53JmbVespmoIGUdSf/+gCQRVM5XGUO56p4FWns=
X-Received: by 2002:a05:6102:5107:b0:4a4:9363:b84e with SMTP id ada2fe7eead31-4a8c8070ed2mr132710137.3.1729846525303;
        Fri, 25 Oct 2024 01:55:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHql1wkhBNCRoe8pzM2qGG7qPSq9TeaKQQpM1QxS4HywtdjdnZK/ZQMBkpiJAqElaCfqRLYyA==
X-Received: by 2002:a05:6102:5107:b0:4a4:9363:b84e with SMTP id ada2fe7eead31-4a8c8070ed2mr132700137.3.1729846524968;
        Fri, 25 Oct 2024 01:55:24 -0700 (PDT)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cbb63197d5sm391482a12.72.2024.10.25.01.55.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Oct 2024 01:55:23 -0700 (PDT)
Message-ID: <52f67b29-551b-4ccb-8c26-c49dcacea5a1@oss.qualcomm.com>
Date: Fri, 25 Oct 2024 10:55:20 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] arm64: dts: qcom: sc8280xp-blackrock: dt
 definition for WDK2023
To: Jens Glathe <jens.glathe@oldschoolsolutions.biz>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Merck Hung <merckhung@gmail.com>
References: <20241013-jg-blackrock-for-upstream-v3-0-839d3483a8e7@oldschoolsolutions.biz>
 <20241013-jg-blackrock-for-upstream-v3-3-839d3483a8e7@oldschoolsolutions.biz>
 <f4dcebea-e2a7-41bb-bbd4-58e34bedee01@oss.qualcomm.com>
 <61308a22-f63d-403f-bed7-c082bf716bce@oldschoolsolutions.biz>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <61308a22-f63d-403f-bed7-c082bf716bce@oldschoolsolutions.biz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 6G21-uRDNun67WPpjubc30b58TJSJr8d
X-Proofpoint-ORIG-GUID: 6G21-uRDNun67WPpjubc30b58TJSJr8d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 phishscore=0
 mlxlogscore=781 lowpriorityscore=0 malwarescore=0 suspectscore=0
 spamscore=0 mlxscore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410250068

On 25.10.2024 7:35 AM, Jens Glathe wrote:
> 
> On 18.10.24 16:38, Konrad Dybcio wrote:
>> On 13.10.2024 1:54 PM, Jens Glathe via B4 Relay wrote:
>>> From: Jens Glathe <jens.glathe@oldschoolsolutions.biz>
>>>
>>> Device tree for the Microsoft Windows Dev Kit 2023. This work
>>> is based on the initial work of Merck Hung <merckhung@gmail.com>.
>>>
>>> The Windows Dev Kit 2023 is a nice little desktop based on sc8280xp.
>>> Link: https://learn.microsoft.com/en-us/windows/arm/dev-kit/
>> [...]
>>
>>> +
>>> +        pinctrl-names = "default";
>>> +        pinctrl-0 = <&wcd_default>;
>> property-n
>> property-names
>>
>> (all throughout the file)
>>
>> [...]
>>
>>> +    pmic-glink {
>>> +        compatible = "qcom,sc8280xp-pmic-glink", "qcom,pmic-glink";
>>> +
>>> +        #address-cells = <1>;
>>> +        #size-cells = <0>;
>>> +        orientation-gpios = <&tlmm 166 GPIO_ACTIVE_HIGH>,
>>> +                    <&tlmm 49 GPIO_ACTIVE_HIGH>;
>>> +
>>> +        connector@0 {
>> Could you add a comment describing which connector is which (see e.g.
>> x1e80100-microsoft-romulus.dtsi)
>>
>> [...]
>>
>>> +&gpu {
>>> +    status = "okay";
>>> +
>>> +    zap-shader {
>>> +        memory-region = <&gpu_mem>;
>>> +        firmware-name = "qcom/sc8280xp/MICROSOFT/blackrock/qcdxkmsuc8280.mbn";
>> "microsoft" lowercase would be consistent with other DTs in arm64/qcom
> Hmm what about Lenovo X13s. I'll change it to lower case.

rg microsoft/ -i arch/arm64/boot/dts/qcom

yields lowercase, so let's not step out of the line

Konrad

