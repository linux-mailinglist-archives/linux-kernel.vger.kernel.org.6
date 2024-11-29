Return-Path: <linux-kernel+bounces-425488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1D279DC2C3
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 12:23:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70BEF16392A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 11:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFFA219ABD1;
	Fri, 29 Nov 2024 11:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YboWul5J"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE208199EA3
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 11:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732879393; cv=none; b=adAEemPwlUx5czvGKXcuzFRayj79qGSan/Anus4pDgK/qL+ivqfGkTmGHYuCaEzNR8llfRuNxR4mU0QM/i+PxxuUGbgmgQhOQSnU70qE4orLjVLvO1bssu6UbYUl5aJip79fIDGWBlziapHRsRPy9RdqzVqRGKPkyEHjcOIckGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732879393; c=relaxed/simple;
	bh=kxYvfRmPACkEiOJLMZma1C8CbrSwYduSmM1VO1dOWfQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rk9gKBO09/ueYJWbK1wjXtdoA2vRp/RN7dS0eVolusuCzhrLrEwmiLBrWvqEEtzdYgDsfX+m1pLiJ7ghRkl0mFG1G9t1mKbkDXJPmIqHmfPQIvOcekzwplc290E001k+M16+8ugZSAuukvb1PWRpbywxcawKT1jInb5/Q/jiT4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YboWul5J; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ASLaN9l005340
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 11:23:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	COD58vfhUoNzxrjubALRwDQBlk97eD5+jvvFfNHqFSQ=; b=YboWul5JfPgsTH3o
	avAv+0R/yQ7z5updWAASlDuh63WPni2XZqfRfk1t4HyFCBFCVz1PSy5ZTgNaygOH
	/jjl3dGjohoUirJd39ucpBUIZ1thwlMaQj1EI6oROXSwWxmcRVGNPW0Z7/TdOIdP
	t8A/sTKMVtvPb2m6iAcTvOXpk09FgiHmx7F4qRkJI7NLs/YtpVKUBTndbfi0ISjD
	o3DIzhBhILfxulkT+r8oOR6SPbDGVmjiLCrRI2rARdJ9LwrCAR7+2GQZQst6MlEx
	wHgdIRNSOmdeNKNgLwQo/fNhLFBvkkQnSzblpXRxSC9tlRcIWS7VsngNPERMkhJF
	BHwOjA==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 436h2mm2cb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 11:23:10 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6d3b1d1d8c1so3990746d6.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 03:23:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732879390; x=1733484190;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=COD58vfhUoNzxrjubALRwDQBlk97eD5+jvvFfNHqFSQ=;
        b=ak1Cy855AH1z7abftvzQfQ2A4l9jqhlGi+RLmQwb7seRToD+LzjgC56XAavvJcfDVy
         5sBJzho3VblVCcz54ybqC1etpGV0aIzgoLoKL4myuUgNoSpoH+A86VPbZKD2RH5iew7a
         XhngpqhLtEye56dLOW9oe7SoB6BeOMtHW3L1ZhZZQ2LFJ3MPzcaKjtxOXntZrlEUEBsW
         bjcGDrj6xXh6BDa2z6Kzo30oKkaKoU83D+MN/R++bzi0eXmSDgAFXJzfSLGWGt+UydNs
         xSX4Dl+Uc4nS7My4FobCZPLqRo4J38yGqjB3cR0SqTHFkMlw0U49PAG9VzntRx08Jrac
         1azw==
X-Forwarded-Encrypted: i=1; AJvYcCXXZjRVNy8MCtn+EEBCA/68mk8tmP2e2r2DZtorif1l4HfUvRq2F23oiuSxF+GK6FF34KvMcuDAprX+MzM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSatwHdMEMDO0lfmhT14XLza7aFg6nGVLhhhafN/OtQCvWY3eU
	rYTSV2zyRB0YIfcylHyBuBZ4krWfw5hGNCP8R25IIV+M8D3g1SUm5GKlhxoff4N0BZqUb1qL0du
	PKCXMB1zW34eUP1axvjSkeVSb03cTmhCibDcrgEi6tYvZ+kLxIksVs52hdKCl5NU=
X-Gm-Gg: ASbGnctgym1zDp2OBUMQoJnLOIgqjcbjNCgW8hi2JbC2nkCa6QQsxyeyAS/V76EHDg7
	qG+2hkQmy7/MVuwJkI4MunCU5b1kqO7xcUPvAStPozDlxJbZibWQI762xoUycLndR9vgGEZCYFr
	kAw1O9UKyl7tec1Ahc2F2n/EC5DJItNFIbW88TmnEo+OEDN6KC5CFwzYspptRu5zhA4cwNWynID
	fsNy3OUu/+LO/WbhZ1bjK80t3Mxs9raq4LMv+nD8btSaA7M+1UZQUMQTBjlzHmzIJ5SoLWPuIJU
	cDXL3nba6rM2tOL45lcx/zsRN8woDbc=
X-Received: by 2002:a05:620a:4004:b0:7af:cb6d:69ec with SMTP id af79cd13be357-7b67c43f8b4mr574063585a.11.1732879389781;
        Fri, 29 Nov 2024 03:23:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHKFmXt4qof8cYsrWxQRv6H7IkzWg2Ack7Bv35WGHlgYSb5RCm1o3cSqggRuL45q2ptmfbmCg==
X-Received: by 2002:a05:620a:4004:b0:7af:cb6d:69ec with SMTP id af79cd13be357-7b67c43f8b4mr574062185a.11.1732879389372;
        Fri, 29 Nov 2024 03:23:09 -0800 (PST)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d0bb296379sm392360a12.40.2024.11.29.03.23.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Nov 2024 03:23:07 -0800 (PST)
Message-ID: <6d3ed1e8-7294-4927-9aac-daffe6ffef37@oss.qualcomm.com>
Date: Fri, 29 Nov 2024 12:23:05 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] media: venus: Add support for static video
 encoder/decoder declarations
To: Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: quic_renjiang@quicinc.com, quic_vnagar@quicinc.com,
        quic_dikshita@quicinc.com, konradybcio@kernel.org,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        devicetree@vger.kernel.org
References: <20241127-media-staging-24-11-25-rb3-hw-compat-string-v1-0-99c16f266b46@linaro.org>
 <20241127-media-staging-24-11-25-rb3-hw-compat-string-v1-1-99c16f266b46@linaro.org>
 <7d344377-f1cf-400e-a9c4-442123dcf4ab@oss.qualcomm.com>
 <95ec73c9-da38-4888-9e00-4458b5a7661c@linaro.org>
 <f88dbe6d-ceac-4fb3-83ad-f202a4703003@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <f88dbe6d-ceac-4fb3-83ad-f202a4703003@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 9zSql7hMENGcMxMzHCNY2LAW9Vdaf2ER
X-Proofpoint-ORIG-GUID: 9zSql7hMENGcMxMzHCNY2LAW9Vdaf2ER
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0
 spamscore=0 lowpriorityscore=0 mlxscore=0 impostorscore=0 clxscore=1015
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2411290093

On 28.11.2024 11:34 PM, Bryan O'Donoghue wrote:
> On 28/11/2024 22:14, Bryan O'Donoghue wrote:
>> On 28/11/2024 20:02, Konrad Dybcio wrote:
>>> Bryan,
>>>
>>> I'm still not sure if keeping the logic behind this makes sense at all.
>>>
>>> Could we not just call platform_device_register_data() with a static
>>> configuration of 1 core being enc and the other dec?
>>
>> That's another way to do this. One reason I wrote this series to continue to rely on the existing compat= method though is it stuck in my mind that we have some dependency ordering logic in at the moment.
>>
>> For example:
>>
>> commit 08b1cf474b7f72750adebe0f0a35f8e9a3eb75f6
>> Author: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
>> Date:   Fri Feb 5 19:11:49 2021 +0100
>>
>> And the other reason is the prototype platform_device_register_* looks like more surgery and ultimately more validation / potential for bugs.
>>
>> Since this driver is supposed to be moving to maintenance mode, I didn't want to do a more major rewrite of the probe() and remove() paths.
>>
>> ---
>> bod
>>
> 
> and.. I wanted to continue support sdm630/sdm660/msm8996/msm8998 without any additional effort to go finding power-domains and clocks which in those cases the existing compat= method actually does something useful.
>
> Also potentially other/new additions to venus which have xcoder specific PDs and clocks would logically want to specify those as we do for the above listed SoCs.

We can just keep a small function to grab these and assign as if they
were specified under the root node (check if video-encoder/video-decoder
both exist, grab the clocks for respective cores and continue normally).

My old series [1] should make it easier to tackle that, feel free to take
it over.

Konrad

[1] https://github.com/somainline/linux/commits/topic/mars


