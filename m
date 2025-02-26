Return-Path: <linux-kernel+bounces-534568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CEB3CA4689E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 18:56:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59C891888E6B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 17:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7B6122ACCA;
	Wed, 26 Feb 2025 17:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lOw4qzAK"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9EC22A81D
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 17:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740592566; cv=none; b=nT9D0KEpUthjoRWY5qHkVSIziAgs67PiVP1RiPwsCrCUu4Ku1LOk6GhPiH7MUXY/SPsS8wLKMw9PP+IYeKveC4nLkghLNbbYx4QAaaI1uUanDj1vFWUvyGHUVMn9IZFtOF4Bs9m4ZVH+vbrbwZPHjGgAJarqABLG1IXRwLvrrSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740592566; c=relaxed/simple;
	bh=vnQ8yrmJ9Q1zs9FzhhEdVIS2SPOPcZQzkqPoxgy+4Bo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gCrEAkza5P4QtB2NVvUFev6zEhBwba+zGOWxTqiQE1xygsBnR3AMvuMPnrm/DEq1GADt7jafWwZft0RKxvzZ4qZIiGDZPcl+1SZUmoraxpt3/RO8eUetys0FgPrcp8aCse2INSA0vky2SbsoaK6lRL3SM8KsVkVXVFvbAm4tCYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lOw4qzAK; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51QCEJpH000529
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 17:56:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MiLkwWgDngD2cClR9A/kmeef7N8a6DcAA3tuT7l9MRU=; b=lOw4qzAK09QohoCs
	NjT9i8BtQXQ8aT+E7PZ7h69IVu7W1qmopcaN+h0Co4g+ujN1TqUG69kLUhBPqvql
	2d5teVBwDpmPnxnW07/px1j/82WzFtVTfzclNmpXXuPqC8RaR+b9Ob0pfMOEQqTQ
	LWc+B6ZDlkIZ0kReHTnYCDAu4nSZ0YIXEV8x73vL483f7Ah7vhn8IHH16Fua7R7v
	2VLJZaHn0hhqszTJKZFrf82gQ13++yMf5GmQOphvja7mKh+jp/1E5J79Sfwk873C
	MqWfFPZDi37zeTNpQE3M9YzFsvK9Xt78yQeC142ldTcZJox4X50SA/s/JSi40TDI
	cFLm/g==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4522skrwru-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 17:56:03 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6e422f1ceadso277436d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 09:56:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740592563; x=1741197363;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MiLkwWgDngD2cClR9A/kmeef7N8a6DcAA3tuT7l9MRU=;
        b=J2Mxe9+aJbFlaJ95e1XKsUlamTur2nfYoqTZxMtmMf0nowht0n5spul1r+ybVjpqaA
         kAu7IXUNVw+ZuR5CFUSAMZg8qRjGobEqLybVnssZgrZ3Nf2ucl2p795ON+oi/LxdsRhR
         Qa6qWeNHzoau2LM9kVrDzbnFyLrbPLo065O3+yn3gi5NEsqSZ9zLblGLQyZyww6HA+cR
         a0DxnbzJrg2CwzyCaF8UuxfZJ2A8CupI3baJbD87WzkdwctxRfvEE38Uas+40tDRFKZD
         6QxDCA7iC+2e/0wfyZFeoUDj6AVqeYcB3TFkw87qGkvj7GNkG0jLHAGNL23iZSeYAF1t
         MoKw==
X-Forwarded-Encrypted: i=1; AJvYcCVWTVPMybD0XE49pJhKJdTMX096m5pdc7+Id3GoP8QkmJUBjSJ+cmJ3KislvI9G9zJsEG86mXElq3Xci5U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQKXxv5iivdO5YBdx0QLAh1Oicv9SLPk8sSgZHWHoFGr6Eytv2
	1bT9N/n4GgQLrLWuQhyAB/aQX9fo9e1lGsfYHP6FAoqVJl7beL7pRrPihcx2XqIF5/jc1R400hb
	fy9VLOOPGiV2JoGB5+a442o6akv97/yzq/FW+cKtrpwBxDRvwDIsyRVt+lHu5Ung=
X-Gm-Gg: ASbGnctxz7wPF35TiBecMx4DOycFrHFUzvHu/M3yqUrb/oqVVc8+ws/0MwZdeBG4aQS
	6M2LzfeIkBPCQysUZSwW+5G0amb3lSwPRKhk0s/sZ+rIWzIafjiSY0RZeqG8AN/FXxZIbQjQ4mX
	WPFGOA/3OtDEhk+RbSNEVqyJCPO6sUx7KaMs7nlpviOV7IjqJxPR9mGrFSAXteeXVU3Sjc93gqy
	WMtzTRf3dZn75uWClcp5+i5dTznWlBXOCTiTLj4XJZPpfZFva8LfgIS3KoqsUaMw5oVCYcFKCY0
	RPfvgMQdFLfL3iz2yBq1movx8R3ZjFV0C8QKiD3oDr3xwXFezbi+H8/AxI08PJxbM242MA==
X-Received: by 2002:a05:6214:2029:b0:6d8:a091:4f52 with SMTP id 6a1803df08f44-6e6ae9b0dcfmr104742456d6.7.1740592562667;
        Wed, 26 Feb 2025 09:56:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHEKLmVc/JyOeQTde//JfKrKvvS44AaQioHZpmlj4kYMM7908+g/dV/BSchGOJ3gqH73/FWHw==
X-Received: by 2002:a05:6214:2029:b0:6d8:a091:4f52 with SMTP id 6a1803df08f44-6e6ae9b0dcfmr104742226d6.7.1740592562260;
        Wed, 26 Feb 2025 09:56:02 -0800 (PST)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abed1a01648sm367373166b.0.2025.02.26.09.56.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Feb 2025 09:56:01 -0800 (PST)
Message-ID: <5e46f261-94e4-441b-a0be-fbf54c34a5f6@oss.qualcomm.com>
Date: Wed, 26 Feb 2025 18:55:59 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: qcm6490-idp: Update protected clocks
 list
To: Trilok Soni <quic_tsoni@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Taniya Das <quic_tdas@quicinc.com>
Cc: Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Ajit Pandey <quic_ajipan@quicinc.com>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        Jagadeesh Kona <quic_jkona@quicinc.com>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250206-protected_clock_qcm6490-v1-1-5923e8c47ab5@quicinc.com>
 <j43f4wu6wgoho2tl4crckemnngyvek5mma6ghkdyqcivk65dcf@gfsimovfuqy5>
 <502e002d-f5a1-4b78-9a9c-4b227623e5b6@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <502e002d-f5a1-4b78-9a9c-4b227623e5b6@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: b65ISFJQ5Vb1QEeWEm1yOiGDxs4ppwWJ
X-Proofpoint-ORIG-GUID: b65ISFJQ5Vb1QEeWEm1yOiGDxs4ppwWJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-26_04,2025-02-26_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1015
 suspectscore=0 bulkscore=0 adultscore=0 malwarescore=0 priorityscore=1501
 mlxscore=0 spamscore=0 phishscore=0 lowpriorityscore=0 mlxlogscore=636
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2502260141

On 26.02.2025 6:01 AM, Trilok Soni wrote:
> On 2/25/2025 8:42 PM, Bjorn Andersson wrote:
>> On Thu, Feb 06, 2025 at 03:43:21PM +0530, Taniya Das wrote:
>>> Certain clocks are not accessible on QCM6490-IDP board,
>>> thus mark them as protected.
>>>
>>> Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
>>> ---
>>> Mark few clocks as protected on IDP of QCM6490.
>>>
>>> This patchset is separated out from the series[1] to remove dependency from
>>> the LPASS reset.
>>> [1]: https://lore.kernel.org/all/20240816-qcm6490-lpass-reset-v1-0-a11f33cad3c5@quicinc.com/
>>> ---
>>>  arch/arm64/boot/dts/qcom/qcm6490-idp.dts | 21 +++++++++++++++++++++
>>
>> I merged the patch adding this board in November 2023, are you saying
>> that for the last 15 months no one has actually booted it!?
> 
> Should we just delete these boards? I prefer to not have platforms which 
> are not maintained.

I think there's enough RB3Gen2s in the wild now to get rid of this one..
Unless anyone has a real use for it, but it doesn't seem like that's the
case given the lack of activity

Konrad

