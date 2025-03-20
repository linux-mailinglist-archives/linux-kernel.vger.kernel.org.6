Return-Path: <linux-kernel+bounces-569794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 289D2A6A7DC
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 15:03:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12AB91889E05
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 13:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95C7022259C;
	Thu, 20 Mar 2025 13:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UhAAxBGl"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F897222578
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 13:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742478582; cv=none; b=sdm3gj8fOrjBKc5CEBp2QoQxAKiwRIvaQyKclW5gXI4VUjP/QrjU3oisG57Oh3eauPP43gin5XHkJQeHpvCsQgAEyxn/0IGnC7gDN4CbhkmV6SsFm/EtPWQzYda9/Kb1H5wBceFeS1f1yzCFr7YH4IMwqPaLG73VyITmA430RQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742478582; c=relaxed/simple;
	bh=gNs6E8DzktDdmEmu49dlWhMivZ9Klhpwa66mpTvcjfQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o2stVo+nVNmf8+kpMurfOnK1rN5//lJJLX9lA3aPHdWL712GZuwAM6fFQ5Q/u8/5tzSUqBMu3niNYAEH0XWO5cSEFLva4xTKsrmyui3DGwk77gl8mx+VAZ7C5BRU+bUY91/J5xOowmRF1Y48Z/G6nqLsYgBsHgM9wTMPgDAc9i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UhAAxBGl; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52K6Z6XI017488
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 13:49:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	I7U4TbaEHlxMDt++dxxsV6U7qeF8FQoqCkKcr1ziLEQ=; b=UhAAxBGlEKi2/Dkp
	jQjbZcTuIdV5ia/5v2z45Pu9ubStpf0Lm7FPnMCetv0JdHkMki9tMGsh3XC2Dr7K
	ta1QwRHbv8FlyAPnXGektt7TSaRxDtDKVC3uwE68iBkHsV6l+gciOOMll8TsDIUH
	otjPUPh0JzWGox+FZixeGeETucG2ACSdnrycH8PmC4qItPsgvzLSgmBbuOReqJdh
	Sq8LCndsHfBaH0qjd5gxDi5ndb2byPa3KiflvU3n6en90T1aWFqbdyr7ge/wCeCT
	PesFx2FCgbsreHt4ma0gBS1+bvywRjomJ1le0NVnWCvD702i4F3NR6nZ23kv7JV1
	xPweuA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45exxbs4bc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 13:49:38 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-224364f2492so10066405ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 06:49:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742478577; x=1743083377;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I7U4TbaEHlxMDt++dxxsV6U7qeF8FQoqCkKcr1ziLEQ=;
        b=XIhMmpKrKYAGNMvIaQV3LxEC0XxpSrOYPtal3GhsJOASnSWFoNA/E0ub4SHTlEGP+w
         EQSpipAKAhBb3WfuSt3mN286GuIx5z8xIWnqCntxMGmtM4TSKgHkuSYomsuxvhbIplkg
         n+SI/oOxjhUT9Ogh2RUrvkaPkhKx2p30HnuQ1E9dKK/a74IzuqHtHNyptILKcoQvSmcV
         5ghgsi1YaeA0r0Fq6j+HFaEAEA+qV5N9JQgRBnXWXy1iEiThY5AeKsKCZ1EgSDjvsYZL
         q2h9uU8hwa3S6dmGq7c4N2ZnfUPME+jfisWWAs7qNLXpwWJ/r0F7Nv1+O9h0HMDZvIs0
         gawQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4rrrZfrI/cfU9eWsDAd8dtJEeG9zh/8rA6L/RIKq49HD3oRJ1NotPqIfx5GIzogGHIPkDqu8ceEDOwEU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3ZsODm1WLw/lDhQgndK1yCQiIjaX8uT2FJ3Wc5iNqonq8CXNz
	sXVB3kE/Z2E74juULd6TfGMwTDYWof3OjIX7UtizZdukLsGaysUmgui0EhMnHOqByU32mirLGRj
	Di3VKHc1SQqXz/EQsdJ6Vr4SGyu3Ny/eTkGIPYVRAyU8IDPY9GITDXOOwZJbWveE29gAnHxo=
X-Gm-Gg: ASbGncv8DHJSfLkEJEzI8I+nobi3v7nvQWodnj5IkXFHBpYWdFPxijzKOXxKU9OND1x
	duvxlUH4IXlbCzFc81M3PqoRy0MLKVWAXQ9xXI9ovaLJLU5wB5hVwhsu68n+qEJqS57Dd0dw5rS
	wiSmO3nChGAy6W84UJ9mH9YyvzrJCtQsbTTP60dqQUAK858nF7K9P1ev/Q0GNS1+dc4whv5z+v9
	JjB1AWEanZDnzfsWWR2f4820Hz81N2o+MJcGolr3avEGAop4Pmnp5hYO8oyKzl/9pkb8MCJTidr
	om7u7WZIhlg+XU3YGzJfQYzRMdvfqkQ13qRME0b/+w==
X-Received: by 2002:a05:6a00:4b56:b0:736:7a00:e522 with SMTP id d2e1a72fcca58-7376d5f182emr9991783b3a.2.1742478577127;
        Thu, 20 Mar 2025 06:49:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGkmX72k8cYdM55w18iIa7Nrgi0OFF5WGnj5G5TqwDvjTDZvJHic3ZcnZMmi1LvQv4sddN4rQ==
X-Received: by 2002:a05:6a00:4b56:b0:736:7a00:e522 with SMTP id d2e1a72fcca58-7376d5f182emr9991728b3a.2.1742478576612;
        Thu, 20 Mar 2025 06:49:36 -0700 (PDT)
Received: from [192.168.1.5] ([122.164.167.76])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73902baedf5sm296202b3a.146.2025.03.20.06.49.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Mar 2025 06:49:36 -0700 (PDT)
Message-ID: <939fcff6-fb93-487b-995b-88e3ff020784@oss.qualcomm.com>
Date: Thu, 20 Mar 2025 19:19:31 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] misc: fastrpc: Add polling mode support for
 fastRPC driver
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: srinivas.kandagatla@linaro.org, linux-arm-msm@vger.kernel.org,
        gregkh@linuxfoundation.org, quic_bkumar@quicinc.com,
        linux-kernel@vger.kernel.org, quic_chennak@quicinc.com,
        dri-devel@lists.freedesktop.org, arnd@arndb.de,
        ekansh.gupta@oss.qualcomm.com
References: <20250127044239.578540-1-quic_ekangupt@quicinc.com>
 <20250127044239.578540-5-quic_ekangupt@quicinc.com>
 <hgox77a7e6zzriltwhzzciau6u2pmil4y3rl5o2l6zkp4fmlmp@q2dai5fxcvtq>
 <49295da9-82d4-45a0-a2a4-fdaa6600c70d@quicinc.com>
 <an4cvztdkqmrt7w2iaziihlxf4tbox65ze362v2lmycjnqg26y@jizjmh2ki34z>
Content-Language: en-US
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
In-Reply-To: <an4cvztdkqmrt7w2iaziihlxf4tbox65ze362v2lmycjnqg26y@jizjmh2ki34z>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=QN1oRhLL c=1 sm=1 tr=0 ts=67dc1cf2 cx=c_pps a=JL+w9abYAAE89/QcEU+0QA==:117 a=rQ4PyoImJZNyGwpw8nHSHQ==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=NEAV23lmAAAA:8 a=aSIFMdu-n8rCKYYgogAA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: mKzQoxNerwgFEMLOi4Ujl_86YhfkMGqE
X-Proofpoint-GUID: mKzQoxNerwgFEMLOi4Ujl_86YhfkMGqE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-20_03,2025-03-20_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 phishscore=0 spamscore=0 impostorscore=0 suspectscore=0 mlxlogscore=999
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 adultscore=0
 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503200085



On 1/29/2025 4:10 PM, Dmitry Baryshkov wrote:
> On Wed, Jan 29, 2025 at 11:12:16AM +0530, Ekansh Gupta wrote:
>>
>>
>> On 1/29/2025 4:59 AM, Dmitry Baryshkov wrote:
>>> On Mon, Jan 27, 2025 at 10:12:38AM +0530, Ekansh Gupta wrote:
>>>> For any remote call to DSP, after sending an invocation message,
>>>> fastRPC driver waits for glink response and during this time the
>>>> CPU can go into low power modes. Adding a polling mode support
>>>> with which fastRPC driver will poll continuously on a memory
>>>> after sending a message to remote subsystem which will eliminate
>>>> CPU wakeup and scheduling latencies and reduce fastRPC overhead.
>>>> With this change, DSP always sends a glink response which will
>>>> get ignored if polling mode didn't time out.
>>> Is there a chance to implement actual async I/O protocol with the help
>>> of the poll() call instead of hiding the polling / wait inside the
>>> invoke2?
>> This design is based on the implementation on DSP firmware as of today:
>> Call flow: https://github.com/quic-ekangupt/fastrpc/blob/invokev2/Docs/invoke_v2.md#5-polling-mode
>>
>> Can you please give some reference to the async I/O protocol that you've
>> suggested? I can check if it can be implemented here.
> As with the typical poll() call implementation:
> - write some data using ioctl
> - call poll() / select() to wait for the data to be processed
> - read data using another ioctl
>
> Getting back to your patch. from you commit message it is not clear,
> which SoCs support this feature. Reminding you that we are supporting
> all kinds of platforms, including the ones that are EoLed by Qualcomm.
>
> Next, you wrote that in-driver polling eliminates CPU wakeup and
> scheduling. However this should also increase power consumption. Is
> there any measurable difference in the latencies, granted that you
> already use ioctl() syscall, as such there will be two context switches.
> What is the actual impact?

Hi Dmitry,

Thank you for your feedback.

I'm currently reworking this change and adding testing details. Regarding the SoC
support, I'll add all the necessary information. For now, with in-driver
polling, we are seeing significant performance improvements for calls
with different sized buffers. On polling supporting platform, I've observed an
~80us improvement in latency. You can find more details in the test
results here: 
https://github.com/quic/fastrpc/pull/134/files#diff-7dbc6537cd3ade7fea5766229cf585db585704e02730efd72e7afc9b148e28ed

Regarding your concerns about power consumption, while in-driver polling
eliminates CPU wakeup and scheduling, it does increase power consumption.
However, the performance gains seem to outweigh this increase.

Do you think the poll implementation that you suggested above could provide similar
improvements?

Thanks,
Ekansh

>
>


