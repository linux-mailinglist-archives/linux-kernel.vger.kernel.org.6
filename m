Return-Path: <linux-kernel+bounces-371848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 880689A4143
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 16:34:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5B921C21ED7
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 14:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67D281F130B;
	Fri, 18 Oct 2024 14:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XcZUlLUb"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3446D1DB352
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 14:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729262057; cv=none; b=XdP8OrvE5GDlD0lH/zV6hgZ1HpjCcXJGAx5Tw5dKKVBDioaNsUmYPDHCjeGNjIHgh8YQ1pn2Tsnw5myQpyD9zXxQP9Mfgr2q9hiVQwBtDsqOOOkVGVS8WF8osNixvjl8Is80AluOgWIFeihDHZtiMbPJFsbEr+lk4XhWUL50lpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729262057; c=relaxed/simple;
	bh=RaFpgywSScq01ux3+3OV5asn2Vl82d8XmKwKAiPeXjE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KjsLWBXsTqzC3eLXKMi11FchQvkcH+9biUbtZrBFeiAXv/99u61j248cdcn9JJyxOfIEzLTvk6LY6QBsxip+C82dUISJP1lJKbqohLqmi4Gh2O/qq624YQxME/zHFDwLg1s6P6HbcOZY8gorbkOxKWRaA3C8OXikvyNU3AzAHWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com; spf=fail smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XcZUlLUb; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49I9M1cM005759
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 14:34:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kbqKpzObyi/yGBLuUSwte4NmOybimaxnDCPAICv2vCE=; b=XcZUlLUbwhK784vl
	pTXoopfXeGvZrxaRblVlwCvNfa074mQREzIQFRx1P9X5EtsyB8gtKBdfYfPlVauO
	pelMdp9tQcUT1M81HBQijKNe9+TTsRPuUr0wuAPDUoTh1ss7LhZdafj/N0CipinL
	FjuuWWBNDvdTj2daP+ZpAxMtfO3xeBQNnfXHlJKZdwrZBNASc0/ueezmajPyoryj
	iHKdHuNTbfdPgeUgdvIKfVwmDPLh3UVwrnt9IOcULEXlcF0Y8As5Kb/ZyGd8EZ/Z
	M7ZJDc3imCpkMYrBTnKB9x6PNywosrVSd6APVA56SFPbQSWKWr2RFPvX1O6/0QE/
	qrwTwQ==
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42bmys8xsj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 14:34:14 +0000 (GMT)
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-7180917b56dso435992a34.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 07:34:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729262054; x=1729866854;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kbqKpzObyi/yGBLuUSwte4NmOybimaxnDCPAICv2vCE=;
        b=Okvtjzy/Pj0NeQkn3MYyzmio2Vx7CUa3eI3ht36+MYiYAHBBiHsDPgZPw/R5Gi4V4Y
         PFRt+LnWyJWIfqhaTsnL3S7qS5hklee6AwrpGp0v5IwqOSXmndk2JdUNyhDI4peRbrvW
         p7dwVdf14Ld4dj1vKGkm9GMeIhA/atj5E07VPAf+9U/eAbSg+IQ9rGY0lXEwo9LWCXOI
         Kz1I6N2BG2CzXA1boU3lWHMZSs6rY6FZD/yLPTgWgKNuK9zyvF5YFwjdH0xiTThncmD5
         lIDeNhMhd+BzjDLj8ag++GPXiziNBIW+hFHx6dAcOUMM6LkwJLOONdQwVYwLcoiYvz/U
         Rlew==
X-Forwarded-Encrypted: i=1; AJvYcCUpL29OXTF9MuvqMjR3rij/LOyss1ALTWMbLYpxjZeHv9LrrxTOpavxjIuJW1QP57PNEoUsspDN5tkBx4s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwABbKEhn82ybYvYVbZc3T1miqQGqp0prBgM1nDZgnjy6J6Cacg
	KKmyy8tPMU99G/6iqbIb2UgTRaAcPG19LSSX/X6OZcPW8zv7/dhJUQk9bg19jLOQ+jX3JHFwxwg
	GYPqwKkukpbuYBI9lfDUcBJ2oLPoBU9SwCpAYkKqtzE0mEBTTNS9l4olnpvAd1zg=
X-Received: by 2002:a54:448d:0:b0:3e5:efa0:f47b with SMTP id 5614622812f47-3e602da9e4fmr506194b6e.8.1729262053965;
        Fri, 18 Oct 2024 07:34:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGISNsIBENtnBzCTvI6c6V6TLW2BX8U9uWZoNoj5zLbSBeYFzjNg1XUoOUyspiUqE9msR/7JQ==
X-Received: by 2002:a54:448d:0:b0:3e5:efa0:f47b with SMTP id 5614622812f47-3e602da9e4fmr506186b6e.8.1729262053636;
        Fri, 18 Oct 2024 07:34:13 -0700 (PDT)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ca0b0809dfsm830005a12.36.2024.10.18.07.34.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Oct 2024 07:34:12 -0700 (PDT)
Message-ID: <c8560240-0b02-45ac-bee9-d969b46dc636@oss.qualcomm.com>
Date: Fri, 18 Oct 2024 16:34:10 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] arm64: dts: qcom: sc8280xp-blackrock: dt
 definition for WDK2023
To: Krishna Kurapati <quic_kriskura@quicinc.com>,
        jens.glathe@oldschoolsolutions.biz
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski
 <krzk+dt@kernel.org>,
        Rob Herring <robh@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>, linux-kernel@vger.kernel.org,
        Merck Hung <merckhung@gmail.com>
References: <20241013-jg-blackrock-for-upstream-v3-0-839d3483a8e7@oldschoolsolutions.biz>
 <20241013-jg-blackrock-for-upstream-v3-3-839d3483a8e7@oldschoolsolutions.biz>
 <050f8c5e-b16f-4df1-b1b1-06e60f838085@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <050f8c5e-b16f-4df1-b1b1-06e60f838085@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: VCuwpLOehMLRcvUSFqRoglA68u7ClUjT
X-Proofpoint-ORIG-GUID: VCuwpLOehMLRcvUSFqRoglA68u7ClUjT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1015
 impostorscore=0 mlxscore=0 suspectscore=0 lowpriorityscore=0 phishscore=0
 mlxlogscore=634 malwarescore=0 adultscore=0 priorityscore=1501 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2410180092

On 14.10.2024 5:37 AM, Krishna Kurapati wrote:
> 
> 
> On 10/13/2024 5:24 PM, Jens Glathe via B4 Relay wrote:
>> From: Jens Glathe <jens.glathe@oldschoolsolutions.biz>
>>
>> Device tree for the Microsoft Windows Dev Kit 2023. This work
>> is based on the initial work of Merck Hung <merckhung@gmail.com>.
>>
>> The Windows Dev Kit 2023 is a nice little desktop based on sc8280xp.
>> Link: https://learn.microsoft.com/en-us/windows/arm/dev-kit/

[...]

>> +
>> +&usb_0_qmpphy {
>> +    vdda-phy-supply = <&vreg_l4d>;
>> +    phy-supply = <&vreg_l4d>;
>> +    vdda-pll-supply = <&vreg_l9d>;
>> +    pll-supply = <&vreg_l9d>;
>> +
>> +    orientation-switch;
>> +
>> +    status = "okay";
>> +};
>> +
> 
> I may be wrong but aren't only 3 supplies for femto and 2 supplies for qmp sufficient ? I see two extra supplies in each node.
> 
> Same for all the other usb phys as well.

Correct, drop the ones without "vdda-", Jens

Konrad

