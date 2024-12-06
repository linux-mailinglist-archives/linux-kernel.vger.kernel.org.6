Return-Path: <linux-kernel+bounces-434904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CBC99E6C89
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 11:49:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22E7B18840F5
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 10:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBE521BA86C;
	Fri,  6 Dec 2024 10:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="O1qqw887"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D061F130D
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 10:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733482162; cv=none; b=M3NtowCOF4PNGI/QWhVVBpgBipUSyBMv+O05grJWuRAsClcs+ImXWFVNsig2Cd+UvWROiktICCyM0nuJs59SPPURQyfDzkr4ZfMwU6nIRHhY5muMtjiA9WQn9kfLUF9pn2XyQSuCxiRSpTTuao9OQIaRa/8Jqj3355QxX5NCZc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733482162; c=relaxed/simple;
	bh=uXsgG7LYBOGMYkTiXI15pI94Az2NTHCvQ93iz6S8zdA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Lo1rV+tSDk+J0h/QpGJ2K5ji1ZyTgCb5lM5kXZn2ge09K2GccQjGNFdTdDHviE0jjSAktDiLGi6TIeTaIvQcbcd2RSzr8uAeNsBr5+7eN7HQByRUarPKa68r3VOjI7R+NaQ4gZwCnK9w0D3pdBfey3NoQ9f7q+pEy9bcoQT9+7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=O1qqw887; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B67glZW003733
	for <linux-kernel@vger.kernel.org>; Fri, 6 Dec 2024 10:49:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rmzSUIXipKayF3xY1od8zx8fw3lJ7UPJ30/Nq5MaUlM=; b=O1qqw88731XtBylV
	g5W3rltm9Bj0Oo9ofChkoRJ6tEtMQ1v+2lFYhL/PKUxGpcV2HogsaiXE7YJy/A2K
	LVNStJg1gRd1GFjMczVs1Xy0p+6EPhcdZSRXTYs8jYD7lzTkMq0ka2UczSipuIEt
	ThHJyDcnd5qC089b91HL+46xXw7B3KOvCXQqBY2vbqHndZfqkOdEdyH8Zo6lysi4
	/tHZZdl7AFJn6ivlSvvR9SNULc/x1xwo37lihMClzn6cSGnA1MrZH0PdIGzzqxRT
	tealzV4VfhPUXIHuwu0Q9MVUHQUJn65AnFCPQtOO3D16VfWNvrdmpSDGi4HgMcqK
	rD7emA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43ba0kkm8d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 10:49:19 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4668f02aeebso4358011cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 02:49:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733482158; x=1734086958;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rmzSUIXipKayF3xY1od8zx8fw3lJ7UPJ30/Nq5MaUlM=;
        b=OcRgsPFLkMMnrrAPvoFIZ5lfFStUEhajf/r/uIV2vw1yGz4ls2+U+wl1wRxlwtnDy0
         OEnTzlb/0cqnXpxA4oJgsoh51NbKCJWRiX5wCn5/5Ux4aUUTcc/ZllcJaUSx3u3hCNoO
         rg4BrzKz4E+bfrVW5VDmGKBi1KHBd7aH+NpR4CoeQpvmALRggnQj2rFl/b64PM+bwYJG
         TADEe/cSdIvBPLAMMkJLg0MWidMKf31Q0qExzM6wMW5KQZJluhAhpu1MxktfEXqFZoK9
         nLtwnraU7XRYEDU31xFP12gUrjf4zkcs95cLVvu5wx6xUrUWWtjwYNj75lezAGAgwy7R
         jgNA==
X-Forwarded-Encrypted: i=1; AJvYcCXRiTMzdzafum+ojBiSC2jTf8egp4t8fqYXhOdrJK3A4m2U9wJ9lBBUrch2n4zrqfMeOnH84LCkJwh3ygs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy56SD8wvIlZ47dzidK2F+A0e9E85THjIliUVqfD5oynILB8xBf
	9tpAwQDY40gLVxv/u+rvbwDx8qKD3stf2fwutHimhLC64XZddnrNEA7h3fNSe7oepfjkEPgRZIe
	bburXkLUEAk0+HXVQq9gUs9jN/O91nnx7kKD8u7+EkgdICk0ulGLArWFppF5+yds=
X-Gm-Gg: ASbGncumXz9xOF6Hwq28Op58Oj4HCCHymZlLjRdgQS7yD2wBZzUKJ7Mb2iFMiVvTKwA
	JXjwySpCM30UHe5W+oWKZDr8rPIlRGSTndNOaiceQJ70xM0gGx69Dz7rF/OWVVbA7aaZf7Cc2f4
	XD+qpQ3NsuhBmga71jbrCFkvBM68T8vBFcLwnToCfcPWtTEUA5zJxrXOPoWc0u6WkuFYHqbvRE9
	JZ9nCPEg8UNDCclbZiqdgrB36vmakwDEbIFYAV//MbPGHcbEUNWY0+jagKrTR89nrgEIf4av2ic
	/gqfMZEP66SIv3B5f0lgrYg4AB2W76M=
X-Received: by 2002:a05:620a:2905:b0:7a9:b9dc:1b95 with SMTP id af79cd13be357-7b6bcb04ec6mr134938585a.9.1733482158475;
        Fri, 06 Dec 2024 02:49:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFNXW/loUXUOCTdG4RUTS4LHcC86Y48mc4tNSrPbk0WXGI8Acu/+JWm0senE7i5qm0oyG2niw==
X-Received: by 2002:a05:620a:2905:b0:7a9:b9dc:1b95 with SMTP id af79cd13be357-7b6bcb04ec6mr134937585a.9.1733482158106;
        Fri, 06 Dec 2024 02:49:18 -0800 (PST)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d14c7aa3besm1975925a12.75.2024.12.06.02.49.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Dec 2024 02:49:16 -0800 (PST)
Message-ID: <e63af513-5fd8-40b0-a1b2-daa9821ebf5a@oss.qualcomm.com>
Date: Fri, 6 Dec 2024 11:49:14 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 15/22] wifi: ath12k: add BDF address in hardware
 parameter
To: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, Kalle Valo <kvalo@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20241015182637.955753-1-quic_rajkbhag@quicinc.com>
 <20241015182637.955753-16-quic_rajkbhag@quicinc.com>
 <142f92d7-72e1-433b-948d-2c7e7d37ecfc@oss.qualcomm.com>
 <0796510c-20bd-4a81-bd60-40aacbcf61c0@quicinc.com>
 <83d216c4-bf9e-4eb4-86d3-e189602f37cc@oss.qualcomm.com>
 <30e5d714-2e52-4a0e-9dc8-b6cacf6ad382@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <30e5d714-2e52-4a0e-9dc8-b6cacf6ad382@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: kEO1Em37zR8jwqnjUBLZi7YXLZGVi3y1
X-Proofpoint-GUID: kEO1Em37zR8jwqnjUBLZi7YXLZGVi3y1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 mlxscore=0 bulkscore=0 mlxlogscore=999 spamscore=0 malwarescore=0
 impostorscore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412060079

On 6.12.2024 5:34 AM, Raj Kumar Bhagat wrote:
> On 12/5/2024 11:12 PM, Konrad Dybcio wrote:
>> On 3.12.2024 10:18 AM, Raj Kumar Bhagat wrote:
>>> On 11/4/2024 7:46 PM, Konrad Dybcio wrote:
>>>> On 15.10.2024 8:26 PM, Raj Kumar Bhagat wrote:
>>>>> The Ath2k AHB device (IPQ5332) firmware requests BDF_MEM_REGION_TYPE
>>>>> memory during QMI memory requests. This memory is part of the
>>>>> HOST_DDR_REGION_TYPE. Therefore, add the BDF memory address to the
>>>>> hardware parameter and provide this memory address to the firmware
>>>>> during QMI memory requests.
>>>>
>>>> Sounds like something to put in the device tree, no?
>>>>
>>>
>>> This BDF memory address is the RAM offset. We did add this in device tree in
>>> version 1. This is removed from device tree in v2 based on the review comment that
>>> DT should not store RAM offset.
>>>
>>> refer below link:
>>> Link: https://lore.kernel.org/all/f8cd9c3d-47e1-4709-9334-78e4790acef0@kernel.org/
>>
>> Right, I think this could be something under /reserved-memory instead
>>
> 
> Thanks for the suggestion. However, the BDF_MEM_REGION_TYPE is already within the
> memory reserved for HOST_DDR_REGION_TYPE through /reserved-memory. Therefore, reserving
> the memory for BDF_MEM_REGION_TYPE again in the Device Tree (DT) will cause a warning
> for 'overlapping memory reservation'.

Then you can grab a handle to it with of_reserved_mem_lookup()
and of_reserved_mem_device_init_by_idx()

Konrad

