Return-Path: <linux-kernel+bounces-571064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ECD1CA6B8A8
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 11:20:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B47E11894365
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 10:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 199991F2BA7;
	Fri, 21 Mar 2025 10:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SZvoqN4b"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77EEF1F2BA4
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 10:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742552311; cv=none; b=pNc3U3iuI2DJpNl3AdbE5zPKGzCa0Wi8Sn7H7+iOK8rm2l/MoNZ4aQ5923bYKiR+hW2Tj49HbqUj2sxR0EUix28HF9SxnXJBjpi3Ibik17guot2dn4Svne6C0ewaATY+xXTDYJnw8tBa+7gEIIzCUIbu1lnciDzIbeV09cN1ff0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742552311; c=relaxed/simple;
	bh=ROCvRI09Yx2PZxJMMK51fJGVcAZO04Rv8QfyduWmhmc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=XKiIZOHR/H0qZHhfvM89XddQF7rsZcREON7r4iZ1Q6Z7w3r9GV4Hhf1LtP45K8oL3OlPfZT/4+ToElrUcJo8GFOAFalP9gpeUaH+noklKv4SeOpUn7PHY1e7LauBHelqryufRpjqh00VWqVw39CKsVOJcyk1FuHmKKXDbB8Z6J4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SZvoqN4b; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52L8jrjs028887
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 10:18:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5eBg7ja8t6Nygd6OTElfc/5vgmOpe0nAEpW8sRRtOJk=; b=SZvoqN4br13tFkgq
	iL88NHnFatTR5+m6SRszUBX2cA69WhbzS42MMDMXDORyPVni6DBp3efkDIEx0kNn
	crfSa9VQZGFTs2PxydrvLe9B7woNpa3wY21hxdTvWLRUEo9khZMzaHQPFL/2X+IP
	F4dgfRpda4SZIvoGM0hCynNzT+j7ecQ4oeB3M4DST+Ag7zwVy9+jxplAeFVX82eR
	TSi5wKaaVTAUkyCkdZzUkTbmPPq40V6QKvHHh24c9Pp49ekrHhwBzF50yMZswDRH
	0RxV/L1eQzByt9a5LUq7kCEtbLJzqus0rYjIDNJEvDgtO3kP50OKQJvsgK4vThck
	WYGtjQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45fdmx1fn7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 10:18:27 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-225429696a9so44199895ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 03:18:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742552307; x=1743157107;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5eBg7ja8t6Nygd6OTElfc/5vgmOpe0nAEpW8sRRtOJk=;
        b=RF88rnFoXAjEqfXzk+l0xhw1rEOJAJpsOI8nzjmOz0vjsbaq6vjoHbkPgpTrlm9PCn
         rlWRNuI1yppZxDSlUj0Tw/idJ7nDft9Sa5SaZNSui6vIqOrMi8hSeGQJnV462XOYQQDi
         wEaguaMIECNS5roL4revntSa86kIH/ORMljC20Nr0ZOW8Zy42zvwzKLb+pMExkJwAPNB
         xEiqQ2TuDn6eVnsg9t2k/yX7HxjUTm4V5qhhBldr2fpU0Iyz3BHGWe6vZI/aGMSaTOXv
         qhkX2t8+C8HlpekwUIBUwisdaaMHam+KExn1O5LPZk4Yn/G32oHiUeL4ehF93fMP6UVU
         5t/A==
X-Forwarded-Encrypted: i=1; AJvYcCW3mBZB/all7Fwq2HYvZESEgsgUBLwYwmhhb2OdlYMDqT6BThDqJJw75j6Ms3ZHrno/Bnj6hQhI6fOvP9I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHF25KLnUI+0u+Q1khZ5L12MIbv0HPFVHHxeeO0XN7huWy0VW2
	s4rYWPyPg0s1/v4wV758XdwGrvQhEU+QHInendg7Re0fK0P7RbYEOC6Lvxqcbxsq2poKgErO4yh
	qeDjru/ytuDWr+X9E+MzZvLBeYxmOMlFvlhqwbjRjUR2wTHuETjP/Xpkix+QHa1w=
X-Gm-Gg: ASbGncs1ZmIigGvoo4e1pZsvuVvXnfJzmi42Ux6fxArL/fJELGtwTaipCGd0wT4LV0r
	1Au9C/rwoi1DfYJW+F7/fQOp5E7jNJMvleP7EpDKtAsgFFTgz/d1+M5rbN6FI5+wlq3IWNUht/h
	+N6UGht2kjwCwsungJEOIQV0iNaMRQkyV/WdILkQMgJ0kDVAgzmwjtsPoBHOeaSP82ufqu2ufdp
	GEa79urIKlBVtfiIDZ/ku+gr1Qrzvp02lOtauptrYM7zKaeFmhzExeF7c6TXQQxnWvBqt9yqZhR
	ppnq3Bm55kH0T7EmdjDrV3Nf+Plsy0LXWUwXURlo
X-Received: by 2002:a05:6a00:1885:b0:736:ab1d:7ed5 with SMTP id d2e1a72fcca58-73905623ea3mr4417226b3a.0.1742552306394;
        Fri, 21 Mar 2025 03:18:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IErmX0Cycyi+U1NWkOpEJp0xJt9qFz65i2lHVl9EBv5+u0a3sw/CEkjWmRV1B270fqfN0xDFA==
X-Received: by 2002:a05:6a00:1885:b0:736:ab1d:7ed5 with SMTP id d2e1a72fcca58-73905623ea3mr4417149b3a.0.1742552305596;
        Fri, 21 Mar 2025 03:18:25 -0700 (PDT)
Received: from [10.204.65.49] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73906156e39sm1507114b3a.145.2025.03.21.03.18.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Mar 2025 03:18:25 -0700 (PDT)
Message-ID: <4ca8776c-3cc7-4266-8248-4a595fa19e7f@oss.qualcomm.com>
Date: Fri, 21 Mar 2025 15:48:20 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] misc: fastrpc: Add polling mode support for
 fastRPC driver
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
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
 <e46be95c-ca8d-48ce-a616-5f068bd28ebc@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <e46be95c-ca8d-48ce-a616-5f068bd28ebc@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: FGOkLeiOSlotyXT6sci_sSfFtJZwDqM6
X-Authority-Analysis: v=2.4 cv=ReKQC0tv c=1 sm=1 tr=0 ts=67dd3cf4 cx=c_pps a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=NEAV23lmAAAA:8 a=3lyftV9mSLQnT4ktp5MA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: FGOkLeiOSlotyXT6sci_sSfFtJZwDqM6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-21_04,2025-03-20_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 phishscore=0 suspectscore=0 impostorscore=0 clxscore=1015 mlxscore=0
 malwarescore=0 mlxlogscore=999 priorityscore=1501 adultscore=0
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503210076



On 3/20/2025 9:27 PM, Ekansh Gupta wrote:
>
> On 3/20/2025 7:45 PM, Dmitry Baryshkov wrote:
>> On Thu, Mar 20, 2025 at 07:19:31PM +0530, Ekansh Gupta wrote:
>>> On 1/29/2025 4:10 PM, Dmitry Baryshkov wrote:
>>>> On Wed, Jan 29, 2025 at 11:12:16AM +0530, Ekansh Gupta wrote:
>>>>> On 1/29/2025 4:59 AM, Dmitry Baryshkov wrote:
>>>>>> On Mon, Jan 27, 2025 at 10:12:38AM +0530, Ekansh Gupta wrote:
>>>>>>> For any remote call to DSP, after sending an invocation message,
>>>>>>> fastRPC driver waits for glink response and during this time the
>>>>>>> CPU can go into low power modes. Adding a polling mode support
>>>>>>> with which fastRPC driver will poll continuously on a memory
>>>>>>> after sending a message to remote subsystem which will eliminate
>>>>>>> CPU wakeup and scheduling latencies and reduce fastRPC overhead.
>>>>>>> With this change, DSP always sends a glink response which will
>>>>>>> get ignored if polling mode didn't time out.
>>>>>> Is there a chance to implement actual async I/O protocol with the help
>>>>>> of the poll() call instead of hiding the polling / wait inside the
>>>>>> invoke2?
>>>>> This design is based on the implementation on DSP firmware as of today:
>>>>> Call flow: https://github.com/quic-ekangupt/fastrpc/blob/invokev2/Docs/invoke_v2.md#5-polling-mode
>>>>>
>>>>> Can you please give some reference to the async I/O protocol that you've
>>>>> suggested? I can check if it can be implemented here.
>>>> As with the typical poll() call implementation:
>>>> - write some data using ioctl
>>>> - call poll() / select() to wait for the data to be processed
>>>> - read data using another ioctl
>>>>
>>>> Getting back to your patch. from you commit message it is not clear,
>>>> which SoCs support this feature. Reminding you that we are supporting
>>>> all kinds of platforms, including the ones that are EoLed by Qualcomm.
>>>>
>>>> Next, you wrote that in-driver polling eliminates CPU wakeup and
>>>> scheduling. However this should also increase power consumption. Is
>>>> there any measurable difference in the latencies, granted that you
>>>> already use ioctl() syscall, as such there will be two context switches.
>>>> What is the actual impact?
>>> Hi Dmitry,
>>>
>>> Thank you for your feedback.
>>>
>>> I'm currently reworking this change and adding testing details. Regarding the SoC
>>> support, I'll add all the necessary information.
>> Please make sure that both the kernel and the userspace can handle the
>> 'non-supported' case properly.
> Yes, I will include changes to handle in both userspace and kernel.

I am seeking additional suggestions on handling "non-supported" cases before making the
changes.

Userspace: To enable DSP side polling, a remote call is made as defined in the DSP image.
If this call fails, polling mode will not be enabled from userspace.

Kernel: Since this is a DSP-specific feature, I plan to add a devicetree property, such
as "qcom,polling-supported," under the fastrpc node if the DSP supports polling mode.

Does this approach seem appropriate, or is there a better way to handle this?

Thanks,
Ekansh

>
>>> For now, with in-driver
>>> polling, we are seeing significant performance improvements for calls
>>> with different sized buffers. On polling supporting platform, I've observed an
>>> ~80us improvement in latency. You can find more details in the test
>>> results here: 
>>> https://github.com/quic/fastrpc/pull/134/files#diff-7dbc6537cd3ade7fea5766229cf585db585704e02730efd72e7afc9b148e28ed
>> Does the improvement come from the CPU not goint to idle or from the
>> glink response processing?
> Although both are contributing to performance improvement, the major
> improvement is coming from CPU not going to idle state.
>
> Thanks,
> Ekansh
>
>>> Regarding your concerns about power consumption, while in-driver polling
>>> eliminates CPU wakeup and scheduling, it does increase power consumption.
>>> However, the performance gains seem to outweigh this increase.
>>>
>>> Do you think the poll implementation that you suggested above could provide similar
>>> improvements?
>> No, I agree here. I was more concentrated on userspace polling rather
>> than hw polling.
>>


