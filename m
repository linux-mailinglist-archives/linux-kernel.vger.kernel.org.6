Return-Path: <linux-kernel+bounces-569982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2056DA6AA71
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 16:58:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F28213B2E7B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 15:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37BCD1EDA05;
	Thu, 20 Mar 2025 15:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NthndX+4"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79BE1DE3B1
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 15:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742486280; cv=none; b=XZv2jE3TLIAzN6TcdYTOM54Lo/nxkqh+F8d8w+3oVxInjI+tTvEoUZ3g1YowQB0SUJ2FZa7cueyQbuTyZxYA6ngyl4iM/FFWYPI7e+WofKW8qHilnzaBEfBWMx5N734Pmn02XmOqG2mFavFhXQPqPpOoL0YvLjuqF7XZMXkx1/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742486280; c=relaxed/simple;
	bh=1HG1R5pgnE3jTOBFHjrcrx5hNP55t9mVMYMylghCRyY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HQJ4EdzWEQ/wBgeGdKjOjQHNCGtCk9OyKsQ/0WQsrw89jGcUbwOAGSz14JsYqv/fS6EG1J+8cBlLmV39dzDsAY+puVKXPYCdlY+kVI5rxjVdrli7B46mf3VzTYI4B4+CFit+dsPh20BC6zkQzE4/vYyYd/eNfAzLy8pLhYnCqGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NthndX+4; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52KDoS5a005934
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 15:57:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7EAFxyWTIXD2IGnfq82GcLshDDFop+FScfu6PliKyoE=; b=NthndX+41AkrKXLN
	gpUbr94ve4On6PUCVFGcAM3MJROe6ttkTe/PXJ8HkV0A02OLjHwqfCXx1mbUPM1F
	RQ1XMQGAi/fdziCTqePEOP5AyIZXlXeAue1a41M9hB7iF3pc72Ceh3pS1Au0ON1B
	g7g/LTKZneQ//e+yvUdNbI6Mqe+986IJ32+085KLp4yuTT69TyqBOZyYmzbx4euK
	S4+HS5I4pnGkEH7Mgd7jg5P6BBfI9VSXqJG5FKfkqDzyq+uE+CVMiYxl+VKHG4TV
	xQjM8bJ4f2Vave56zP4SSwKR3ceB/ni+Bx4Tk0ml3HZw2tmQPnDwbTa6UwHva9AW
	08h+lA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45etmc282a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 15:57:57 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-22403329f9eso12034245ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 08:57:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742486276; x=1743091076;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7EAFxyWTIXD2IGnfq82GcLshDDFop+FScfu6PliKyoE=;
        b=AdgoufjPPyeM894kaTqQwsdCk+MYxno4GjIhulYvLLG++7quFFgcVekl3awERT6URU
         +wzxkRhW94UXHB8LyLxe3ApRhMbPOLrL2cpDbzaPIqgseJGV7FahEY3X+O9LuEr9HmAt
         7DKUwtm6IDL/+VtA2GDGkecXZzyDxJa5qj/VzbGTYMaFvAFmVwBZ6nu75P0OwPZN8pw7
         WSrSZt1MS34jl3ouZyMSjePHTYWhB5xusA3lfU2hsoj96IHqMtDkRdaemDeYnXLpqeP2
         O4zZVbh8deuGUNhm4Qnftu24t9tmXEpkOBI0fNUIRtnLDC4a+27vLnEcuaHK3g9+WbHC
         DcPw==
X-Forwarded-Encrypted: i=1; AJvYcCVCjxlvtyIn8+B1RlGlmV7KRBEs9tUZQsfGtmOie5YqH9ekYZPUunjzn4dDzJP+fCYYgyJcDXQAZBoXzj8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdctF6/5bEP1TDz0a3OwO0gvY3nt3trtwoiGuvjf+eP99sm+54
	rXVJvmdeAUDNKyAL++H3Aj9pDVR4BmMbwOCrCxKHpOTFdBxqWxTrvWEhpumR3x6nVCpSXpOQEHL
	KYMtzzgO5O/b6C9wTp6MRxjZE7sNbtJggdbffae7uv6WSsZKhCatfKCLDmVz9Yco=
X-Gm-Gg: ASbGncvsEMvi+9crm0dm5v9Ta3hv7mESs4WgGjQkP0KBBip7L5fT+7D6gb9DKUJSsxk
	nsZa9bF7qyCRPHClylGcio8P4cGl+2jnNIH2ohM8lYZaE67anDyJnTsImzPhZUCFAU7tczh17Mw
	nDUDHQxexSVBDmtqk6Sjme35OPqLo0k/jJR++mhWM+yyMu113hbZgZ67FUOoDwz4L/z+SEQvvsI
	wFau7l24YpM26iUDusZDLhXgi4nEE6IXTpbdjxIPLC6C51W2PmXU2ErUDUN/5L0PnFf6KL2GF97
	r2MFs63PAPy0//EwWlKevl1aUuWfmPgEFqrzxhPbHA==
X-Received: by 2002:a17:903:2ac6:b0:220:e362:9b1a with SMTP id d9443c01a7336-2265edee4b7mr69582595ad.25.1742486275690;
        Thu, 20 Mar 2025 08:57:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGi8XbhLs92+ZkMltC891+1rpGELh9oFO3sgLfdR5Hc5Ego4ssiojy48Xlws9pVR6ouyP0mhg==
X-Received: by 2002:a17:903:2ac6:b0:220:e362:9b1a with SMTP id d9443c01a7336-2265edee4b7mr69582035ad.25.1742486275268;
        Thu, 20 Mar 2025 08:57:55 -0700 (PDT)
Received: from [192.168.1.5] ([122.164.167.76])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c68884ecsm137243495ad.5.2025.03.20.08.57.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Mar 2025 08:57:54 -0700 (PDT)
Message-ID: <e46be95c-ca8d-48ce-a616-5f068bd28ebc@oss.qualcomm.com>
Date: Thu, 20 Mar 2025 21:27:42 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] misc: fastrpc: Add polling mode support for
 fastRPC driver
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        srinivas.kandagatla@linaro.org, linux-arm-msm@vger.kernel.org,
        gregkh@linuxfoundation.org, quic_bkumar@quicinc.com,
        linux-kernel@vger.kernel.org, quic_chennak@quicinc.com,
        dri-devel@lists.freedesktop.org, arnd@arndb.de
References: <20250127044239.578540-1-quic_ekangupt@quicinc.com>
 <20250127044239.578540-5-quic_ekangupt@quicinc.com>
 <hgox77a7e6zzriltwhzzciau6u2pmil4y3rl5o2l6zkp4fmlmp@q2dai5fxcvtq>
 <49295da9-82d4-45a0-a2a4-fdaa6600c70d@quicinc.com>
 <an4cvztdkqmrt7w2iaziihlxf4tbox65ze362v2lmycjnqg26y@jizjmh2ki34z>
 <939fcff6-fb93-487b-995b-88e3ff020784@oss.qualcomm.com>
 <2k6573yrw3dyn3rpwqz4asdpx3nlmj4ornm7kmxv3f4jlc6hzg@qkwn7gqduwri>
Content-Language: en-US
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
In-Reply-To: <2k6573yrw3dyn3rpwqz4asdpx3nlmj4ornm7kmxv3f4jlc6hzg@qkwn7gqduwri>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: ajISmRU-gDyW9816RfhzCfoPXe5UK5-9
X-Proofpoint-GUID: ajISmRU-gDyW9816RfhzCfoPXe5UK5-9
X-Authority-Analysis: v=2.4 cv=aMLwqa9m c=1 sm=1 tr=0 ts=67dc3b05 cx=c_pps a=IZJwPbhc+fLeJZngyXXI0A==:117 a=rQ4PyoImJZNyGwpw8nHSHQ==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=NEAV23lmAAAA:8 a=iVoIhCtSH5cMpfonS4MA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-20_04,2025-03-20_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 spamscore=0 clxscore=1015 phishscore=0 mlxscore=0
 suspectscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503200101



On 3/20/2025 7:45 PM, Dmitry Baryshkov wrote:
> On Thu, Mar 20, 2025 at 07:19:31PM +0530, Ekansh Gupta wrote:
>>
>> On 1/29/2025 4:10 PM, Dmitry Baryshkov wrote:
>>> On Wed, Jan 29, 2025 at 11:12:16AM +0530, Ekansh Gupta wrote:
>>>>
>>>> On 1/29/2025 4:59 AM, Dmitry Baryshkov wrote:
>>>>> On Mon, Jan 27, 2025 at 10:12:38AM +0530, Ekansh Gupta wrote:
>>>>>> For any remote call to DSP, after sending an invocation message,
>>>>>> fastRPC driver waits for glink response and during this time the
>>>>>> CPU can go into low power modes. Adding a polling mode support
>>>>>> with which fastRPC driver will poll continuously on a memory
>>>>>> after sending a message to remote subsystem which will eliminate
>>>>>> CPU wakeup and scheduling latencies and reduce fastRPC overhead.
>>>>>> With this change, DSP always sends a glink response which will
>>>>>> get ignored if polling mode didn't time out.
>>>>> Is there a chance to implement actual async I/O protocol with the help
>>>>> of the poll() call instead of hiding the polling / wait inside the
>>>>> invoke2?
>>>> This design is based on the implementation on DSP firmware as of today:
>>>> Call flow: https://github.com/quic-ekangupt/fastrpc/blob/invokev2/Docs/invoke_v2.md#5-polling-mode
>>>>
>>>> Can you please give some reference to the async I/O protocol that you've
>>>> suggested? I can check if it can be implemented here.
>>> As with the typical poll() call implementation:
>>> - write some data using ioctl
>>> - call poll() / select() to wait for the data to be processed
>>> - read data using another ioctl
>>>
>>> Getting back to your patch. from you commit message it is not clear,
>>> which SoCs support this feature. Reminding you that we are supporting
>>> all kinds of platforms, including the ones that are EoLed by Qualcomm.
>>>
>>> Next, you wrote that in-driver polling eliminates CPU wakeup and
>>> scheduling. However this should also increase power consumption. Is
>>> there any measurable difference in the latencies, granted that you
>>> already use ioctl() syscall, as such there will be two context switches.
>>> What is the actual impact?
>> Hi Dmitry,
>>
>> Thank you for your feedback.
>>
>> I'm currently reworking this change and adding testing details. Regarding the SoC
>> support, I'll add all the necessary information.
> Please make sure that both the kernel and the userspace can handle the
> 'non-supported' case properly.

Yes, I will include changes to handle in both userspace and kernel.

>
>> For now, with in-driver
>> polling, we are seeing significant performance improvements for calls
>> with different sized buffers. On polling supporting platform, I've observed an
>> ~80us improvement in latency. You can find more details in the test
>> results here: 
>> https://github.com/quic/fastrpc/pull/134/files#diff-7dbc6537cd3ade7fea5766229cf585db585704e02730efd72e7afc9b148e28ed
> Does the improvement come from the CPU not goint to idle or from the
> glink response processing?

Although both are contributing to performance improvement, the major
improvement is coming from CPU not going to idle state.

Thanks,
Ekansh

>
>> Regarding your concerns about power consumption, while in-driver polling
>> eliminates CPU wakeup and scheduling, it does increase power consumption.
>> However, the performance gains seem to outweigh this increase.
>>
>> Do you think the poll implementation that you suggested above could provide similar
>> improvements?
> No, I agree here. I was more concentrated on userspace polling rather
> than hw polling.
>


