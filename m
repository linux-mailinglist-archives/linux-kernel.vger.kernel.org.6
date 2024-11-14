Return-Path: <linux-kernel+bounces-409507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D3BA9C8DC0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 16:21:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDE7A283BBA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 15:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C16213D8A4;
	Thu, 14 Nov 2024 15:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XwgL8P42"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0ED5674D
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 15:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731597666; cv=none; b=icco7+oMBauiq3JbnJ9l4WPqZQZXRdji+tFhwYCWRlrPVMfUCWkmjS4KcRg8+3faY5jpviRPyXR5FsIe4uFb0tC+JCUDuGKZjtcnfzGNHduU8YagwBky6LqdLpK/PdbekL0ktTz4PdGkBCg5N0pXGTYvy3pP+6ZwyPq1VVohOSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731597666; c=relaxed/simple;
	bh=7MCZRzZ/AzkPceyOazDlSUQhVeaRggBpqmxYwL+WVy0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YKKDEvGqrH4ICFj7frRnPTQxrT9xVCgfpj2+SMqluqxZU9lrKpaRrP/wc/BuroKpl+hnK1EXiPxTUIusKuk4W4krvzUVrErUBM9C2KlX+TaP0jeaR/EEwjcBr8ahUrZUX8Mp+WUw/NF9jW9IDsBbW6L6q+DSSohyWN1lEL0Hzhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=fail smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XwgL8P42; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AEEo6S1026921
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 15:21:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	cVzFCO4CN/tzo7kgRuNz7PpOy9J23iqDC72boSlkowY=; b=XwgL8P42UMpQwgSM
	5051syUZoYacPcsQ0YeAQAHKQsJiD4noPtXH57ShFWsBK93UDEuxNEzhBaZMFpKK
	BrWt3qWrHkV3Ps32MxZNUgl6wKbDwUhHXQq090alckTyXjZupz+gu3gdkPCxrDOD
	Qpxnx1llx5KXmpLIQ7zvk34bYogpDyBVrhJ4QSpafxHO6kVrC41sZ3BTxyByllms
	C8uhMH4cSjUVG6oxiOQsLqQihKjhQncVm2fCIYs2zluYWI+cF/pSgsXoSpQkvfsw
	VZi4kv/8Fv6iaAHYFQRKS76Vxh7YgDv41ynKmfM+kQnjzN5vi2BeXzKV8zzi5QhZ
	3U7FXA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42vt7359jw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 15:21:03 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-46086de3a40so1681491cf.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 07:21:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731597662; x=1732202462;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cVzFCO4CN/tzo7kgRuNz7PpOy9J23iqDC72boSlkowY=;
        b=qLsSGcIwbTccUz2ZC6QXl0MmekW3KmFMesYDIzIDdxdVjb1zn/frFl5gk8TmL3/Wqr
         4r4oBTo501F8p/XZfxjvPOk0zGfeIUuRfJviibEOhw/SCGvfbMoW9cKFVHmo+yBuQDLP
         a2kn82avPQb5y7jsJy/BaXwFb9hGR53ypremOkg2+HLUzYM2JWqNCHnY14H6JL8W7wwH
         H0Mb78efHUIm/rNRkNK6fKMyodmz/mnTZ8ThUgbGjfaz7rEsUXg+6S5dyEKCbIcn6jPV
         G5ghXN4pSKr8MclUWqdD++JoqZfG0RHtboc2DPwWBknYNvTnyscCYd+uzJSBBYEbh+yG
         4mEg==
X-Forwarded-Encrypted: i=1; AJvYcCUThldFGco9Rciw0JlFkL6SoX5AEgHhnKjI5EToUeaRuFqV7X7AxixPvzb52Z9hl5OxA1Z5zG3dqbH1HaQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvLIFpb9mLc4GZQcwIXmDGKLvltIJqU3ovxcu49agAEXTZK0co
	hNpyUK0Lad7u7jkokwN6sfZrht7zwg6NihVf8F3ZHRZBnCjk4aTYEiMlEPRBZbpNKBIZo/YGo2i
	Irs1INRXEKI2g6K9Bco2K6OVCE0N+XeHVLeDyq7GB6HMeRWq7/VN5Vhz8rGq2xyo=
X-Gm-Gg: ASbGncuqBF3ot/hPoI/gur+WZ8h+y9QcLr7XUxLYaOpboA3vb0i6yMHmk/zyQzeisEw
	VROTchqcuh8Hh59AE4E+5qkqFwBL8YFBOBwl1yMd3Vfi9TmzHQJIAxNMR9/tenlgTLmBs3BPZAC
	R4MF3USee1/NQ2jMz5pc155mS63YsYPc06CLWqirvNaD9FwqJ0kl4lvdAb4jbQQV4yN5USRLl6e
	YdeT6dSXLgpVWRy2epgRYYw+oZ8n6adk1NtXsg/G8BYC36JaLdjT3J0VyvSofxwO3f8stgwBTsK
	jemJQGy5TbbKvY8xsNDWsqhb8h9ygwQ=
X-Received: by 2002:ac8:59c7:0:b0:458:3297:806f with SMTP id d75a77b69052e-463093f1c4cmr153434481cf.10.1731597662557;
        Thu, 14 Nov 2024 07:21:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEk+y59ahE80IlwvZJl+xqJ/l+nf1VpXpaxxM3G29yJNwW6rj3keR7gGJ6umEv5Aet5TJbTwA==
X-Received: by 2002:ac8:59c7:0:b0:458:3297:806f with SMTP id d75a77b69052e-463093f1c4cmr153434191cf.10.1731597662104;
        Thu, 14 Nov 2024 07:21:02 -0800 (PST)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20df5161bsm75427866b.60.2024.11.14.07.20.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Nov 2024 07:21:01 -0800 (PST)
Message-ID: <c0b3bd36-6ec0-4d7d-9a65-5b8f02cd6c98@oss.qualcomm.com>
Date: Thu, 14 Nov 2024 16:20:58 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/4] arm64: dts: qcom: qcs615: add UFS node
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Xin Liu <quic_liuxin@quicinc.com>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>, Andy Gross <agross@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, quic_jiegan@quicinc.com,
        quic_aiquny@quicinc.com, quic_tingweiz@quicinc.com,
        quic_sayalil@quicinc.com
References: <20241017042300.872963-1-quic_liuxin@quicinc.com>
 <20241017042300.872963-4-quic_liuxin@quicinc.com>
 <5fe37609-ed58-4617-bd5f-90edc90f5d8b@oss.qualcomm.com>
 <28069114-9893-486b-a8d8-4c8b9ada1b0c@quicinc.com>
 <20241113092716.h3mabw4bzgc5gcha@thinkpad>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241113092716.h3mabw4bzgc5gcha@thinkpad>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 418ENYVWWHX_koGmGjRLt3eIfyYWYyy7
X-Proofpoint-GUID: 418ENYVWWHX_koGmGjRLt3eIfyYWYyy7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 adultscore=0
 clxscore=1015 mlxlogscore=732 mlxscore=0 phishscore=0 bulkscore=0
 malwarescore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411140119

On 13.11.2024 10:27 AM, Manivannan Sadhasivam wrote:
> On Wed, Nov 13, 2024 at 05:19:49PM +0800, Xin Liu wrote:
>>
>>
>> 在 2024/10/26 3:24, Konrad Dybcio 写道:
>>> On 17.10.2024 6:22 AM, Xin Liu wrote:
>>>> From: Sayali Lokhande <quic_sayalil@quicinc.com>	
>>>> 	
>>>> Add the UFS Host Controller node and its PHY for QCS615 SoC.
>>>>
>>>> Signed-off-by: Sayali Lokhande <quic_sayalil@quicinc.com>
>>>> Co-developed-by: Xin Liu <quic_liuxin@quicinc.com>
>>>> Signed-off-by: Xin Liu <quic_liuxin@quicinc.com>
>>>> ---

[...]


>>>> +
>>>> +			status = "disabled";
>>>> +		};
>>>> +
>>>> +		ufs_mem_phy: phy@1d87000 {
>>>> +			compatible = "qcom,qcs615-qmp-ufs-phy", "qcom,sm6115-qmp-ufs-phy";
>>>> +			reg = <0x0 0x01d87000 0x0 0xe00>;
>>>
>>> This register region is a bit longer
>> I just confirmed again, there's no problem here.

I'd happen to disagree, please make it 0xe10-long

Konrad

