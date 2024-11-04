Return-Path: <linux-kernel+bounces-394923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A67C9BB62A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 14:31:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEF8B1F21AC3
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 13:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 719641CAB8;
	Mon,  4 Nov 2024 13:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eaQJ+oyI"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B44A2AE77
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 13:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730727080; cv=none; b=XTK2kJdCoabWjNb0dspfdblfgpE5kJWhPTUm3CyYBMhH+5NnjYyEhiwxLVV6lr8N+98LXTLCTcn8a4vSxMBsD3jJnEX39JBz28LTe7SZ4iCxR7KYvitIVPOriqZI5Int4LxQH3WU9h22HZ6oloDcw4GWDb9bWLkRBv0PluNA4aI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730727080; c=relaxed/simple;
	bh=kodBsdRfD/DXh90GS47ntCLBgJstasH/u85d5mSYyxw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XmIDksQAc67VRcCJXITfy0iGP2vnDLUGphC1Rba1j3BO60mYaq/BUxgBuP4L3NxYCSWA8CvXwKfAMctgWeGoANdHOyCYLUU6NEmU/68ObMBGE2nHd6ttiY3+BNmK1ulpXYtbozXwp6sb5becsSEdVeFdg5HvRYdsoj9GDw/2SuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=fail smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eaQJ+oyI; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A4BjXF2028121
	for <linux-kernel@vger.kernel.org>; Mon, 4 Nov 2024 13:31:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	F1S7Gy8QIeV5v9acG5PdnpXbJVpvQu/FalyZloKRpbk=; b=eaQJ+oyIGacBV5oA
	fdtG78VUjdxK5RPwkykkU2j6V31znPF0oxVg9vv5WbIgoqHyBMIPyb7Azl++AC0x
	3dUj7wI/Z7xrZOrzHuLRIwoThSfR/0SccVQmvdhX4FTC3SgRmPghpBrkmfEZOFtT
	AOOuJXqukPFVQKvKIy3WmRXbQSaL2KfA45HWBJ1pziqseHZO7WZZM4xWW3bFCgwP
	bvCQAgLVW0AJJrkxZXuM4zmdVEE0fsUAL4jOwlWmSZOkScqfwf3B3UWsP+jF0i1j
	nIbBKwBU7T862OX6I9syMVu1+2++FKmsaZnGb8I8tmtxeRny/YXSkUGxet3BBPfO
	G3o/Iw==
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com [209.85.210.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42ncyxvb4s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 13:31:17 +0000 (GMT)
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-7180405a9faso408633a34.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 05:31:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730727077; x=1731331877;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F1S7Gy8QIeV5v9acG5PdnpXbJVpvQu/FalyZloKRpbk=;
        b=UXNReWxxUjyfCqloc3KGUzd87aYb3NU13hfFejTj90tN/oGQA9Rz6d+rFk0cPKsN4l
         7ErXf6KIfkOREBq2dcf05bvDdBa28oKpCKdv3gUuaJoW6o7C6GTeiFFfw4qqzsP+X/mx
         f608OdKEQK0xhAl0WeJlPOZopiB+r9XWVuhL3WYhGzrWpxZxEaN5WhGzgobI+oydCeZ0
         uhUSCMj3Al6MTPDi8qeAXEf9j8EHVdwt/AzjLbawIgOWb3yl5FUrx18DklxJFQjash4E
         i4Fkr7IXV+EYEQzU8aDF7qFYZNPAn/2Auqo9qupDrWGw9pmcIViXGdO5dPHvOWCw5Snx
         RFvA==
X-Forwarded-Encrypted: i=1; AJvYcCUfuwhL5eBaglGOz0TV4viK4aOgzVtxqaFn/nbZuCMBfWYvRq5ptvF/xDATyAqigdQOX+bnUOlo0jqp4Co=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNTYcJw1iovR5txGVd7FlsDjm6U+G+wnIvkQ/RLhWUF4O9Tf6G
	/ZuWkp2zU2Tut3VE6ixzbpoSgSKWSQx5APgXeFnyd8q9CJQk8QZWswL2ZGX9G09Sl37uI0tZJhm
	FuCLlbfAe4YM+pHWgJfMh6F7qey4GltRDZEQEVL+x2Us5bBCa/9rnXVSaEDANthA=
X-Received: by 2002:a05:6870:c088:b0:27c:a414:c22d with SMTP id 586e51a60fabf-29051d59b42mr7647664fac.11.1730727076932;
        Mon, 04 Nov 2024 05:31:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGsphxCgdyLX6i5mbcSU6x9YPCwShnh+4XR726m45ecMqfJ7TcfvS7n7e/Z1S1w2qYu/8DHjQ==
X-Received: by 2002:a05:6870:c088:b0:27c:a414:c22d with SMTP id 586e51a60fabf-29051d59b42mr7647654fac.11.1730727076559;
        Mon, 04 Nov 2024 05:31:16 -0800 (PST)
Received: from [192.168.212.27] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9e566845c1sm552621066b.210.2024.11.04.05.31.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Nov 2024 05:31:15 -0800 (PST)
Message-ID: <260eff7f-9243-49f5-830a-09bf7297af97@oss.qualcomm.com>
Date: Mon, 4 Nov 2024 14:31:13 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] firmware: qcom: scm: rework QSEECOM allowlist
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Steev Klimaszewski <steev@kali.org>
References: <20241103-rework-qseecom-v1-0-1d75d4eedc1e@linaro.org>
 <20241103-rework-qseecom-v1-2-1d75d4eedc1e@linaro.org>
 <02171841-acd3-4f26-987d-1376caf11481@oss.qualcomm.com>
 <CAA8EJpqwY+kuOV1xu4vw8pC5AFhpK+J7P9mnyLeHfaf=CJkRMw@mail.gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <CAA8EJpqwY+kuOV1xu4vw8pC5AFhpK+J7P9mnyLeHfaf=CJkRMw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 8J1C5blzHkiaNF5EaX1fR0EU1tQRvX4h
X-Proofpoint-GUID: 8J1C5blzHkiaNF5EaX1fR0EU1tQRvX4h
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 mlxscore=0 phishscore=0 adultscore=0 mlxlogscore=999
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411040118

On 4.11.2024 12:34 PM, Dmitry Baryshkov wrote:
> On Mon, 4 Nov 2024 at 11:24, Konrad Dybcio
> <konrad.dybcio@oss.qualcomm.com> wrote:
>>
>> On 3.11.2024 4:37 PM, Dmitry Baryshkov wrote:
>>> Listing individual machines in qcom_scm_qseecom_allowlist doesn't scale.
>>> Allow it to function as allow and disallow list at the same time by the
>>> means of the match->data and list the SoC families instead of devices.
>>>
>>> In case a particular device has buggy or incompatible firmware user
>>> still can disable QSEECOM by specifying qcom_scm.qseecom=off kernel
>>> param and (in the longer term) adding machine-specific entry to the
>>> qcom_scm_qseecom_allowlist table.
>>>
>>> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>>> ---
>>>  drivers/firmware/qcom/qcom_scm.c | 37 ++++++++++++++++++++-----------------
>>>  1 file changed, 20 insertions(+), 17 deletions(-)
>>>
>>> diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
>>> index 9fed03d0a4b7e5709edf2db9a58b5326301008b4..6f70fbb0ddfbf88542ff2b3ed2bc372c2f3ce9eb 100644
>>> --- a/drivers/firmware/qcom/qcom_scm.c
>>> +++ b/drivers/firmware/qcom/qcom_scm.c
>>> @@ -1743,28 +1743,23 @@ module_param(qseecom, charp, 0);
>>>
>>>  /*
>>>   * We do not yet support re-entrant calls via the qseecom interface. To prevent
>>> - * any potential issues with this, only allow validated machines for now. Users
>>> + * any potential issues with this, only allow validated platforms for now. Users
>>>   * still can manually enable or disable it via the qcom_scm.qseecom modparam.
>>> + *
>>> + * To disable QSEECOM for a particular machine, add compatible entry and set
>>                                                        ^ a
>>
>>> + * data to (void *)false.
>>>   */
>>>  static const struct of_device_id qcom_scm_qseecom_allowlist[] __maybe_unused = {
>>> -     { .compatible = "dell,xps13-9345" },
>>> -     { .compatible = "lenovo,flex-5g" },
>>> -     { .compatible = "lenovo,thinkpad-t14s" },
>>> -     { .compatible = "lenovo,thinkpad-x13s", },
>>> -     { .compatible = "lenovo,yoga-slim7x" },
>>> -     { .compatible = "microsoft,arcata", },
>>> -     { .compatible = "microsoft,romulus13", },
>>> -     { .compatible = "microsoft,romulus15", },
>>> -     { .compatible = "qcom,sc8180x-primus" },
>>> -     { .compatible = "qcom,x1e80100-crd" },
>>> -     { .compatible = "qcom,x1e80100-qcp" },
>>> +     { .compatible = "qcom,sc8180x", .data = (void *)true },
>>> +     { .compatible = "qcom,sc8280xp", .data = (void *)true },
>>> +     { .compatible = "qcom,x1e80100", .data = (void *)true },
>>>       { }
>>>  };
>>
>> + Steev I think you had some unhappy machine
>>
>> And maybe 8180 Primus?
> 
> I don't think I understand this comment, could you please explain?

"maybe 8180-primus had some issues, too"

Konrad

