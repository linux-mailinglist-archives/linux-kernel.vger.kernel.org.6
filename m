Return-Path: <linux-kernel+bounces-573723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6C67A6DB79
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 14:30:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7E0D3A4071
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 13:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AD7425F7AA;
	Mon, 24 Mar 2025 13:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FBQ0IH7L"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63CF425EFB8
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 13:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742822975; cv=none; b=daDthjp1Oda+nKUKtXI9Y9u2ZQAGyDYwXi14IN+khHGZT52cetiajFR8bdSeO0H2K1aRLSg8Hjq7gQ8pUbBfl4XLPPc/BjBDixd9Kf7eRCdPIrEDfF+ZvmkyWBQfnYTc2lj5UwwbgBrwuVDmpWdTVPIaHnvsF+deBNROlY8znlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742822975; c=relaxed/simple;
	bh=ToQFGwDDDePBcLj0Tl6e42Pcn77uyEQUZi/Zk7Ze/gY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=akf4hSHS7KXdm/5JtMheCzO8g0tQvuausrZmiT73hHA4yqov/BD6WpPHbnhQsXl3JeGD06RshqvRoi+xSh7DZ3o17pk7dydxIydDxjKG9h4zGkI4v1hQQwjLhEAbh4eGt91FG+H+f9xBmto3ZtCuzuJpoebkMqrVKKQDwLDEfE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FBQ0IH7L; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5e5e22e6ed2so6521623a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 06:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742822972; x=1743427772; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wTTdxiEXTLI0RB3J4azgwISZcRhYfAuhdc+KevBi5vw=;
        b=FBQ0IH7Lil4t9nylwAriL9+AADyK4D7SWkKRjsG5xi2VT33mg92IGpF2cykNROCn8O
         lJ6+ME1dBfD8L3JFQlJAqqod+S0Jv3EegET70RAB8WqXIT0GKNzdQiAAcnFYZRY78khY
         Nav4G2mzWCl2GjoU64fyhBhGqRpn4svcfpH2CrFDXm/byrSDLnoNizxS6FS/ix0njbeI
         +BCrEqbckeqoybCo5eqE35sy9XNeIf22lEaoP/L3y4G1JNe9y628aD5cdgbkIfbEzST4
         MnwkxEuVcO46+zVaOgJdpNb8Rv7uDxFzM1AJpg/+9WzshEim0fjjkvEwLWB/PYgw54/O
         XgCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742822972; x=1743427772;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wTTdxiEXTLI0RB3J4azgwISZcRhYfAuhdc+KevBi5vw=;
        b=Vz1gbUgVo9LesZPa6Gv0eU7edJqqMGdYheZHRcDXBwYU2JYeknu25FvPHuEm2cqGOh
         D1cdrfOhWHwWTSLWxwjKZR8f01bM/fbEi3OaknpzPMx6sj5fdiwY/jf6ceMmb2o9Q9uH
         42xBEcXTXrN0UGzdAGfAsbxaLl1dAZkWVsUrfJF+UffIGdBlcqyfrcdJtMZWFSpcvshI
         W/qVyYPJdleyn9myGw52gaB8QJqyViaS8vccTjAiiDVv0Cmoq/g1RaNOZMpCv+hykhla
         0CyepkWv8dDKeH2UCO4JJmKWW1kMQnzCWcqHum6xWaDauHhKAOS+njoPLoN2KLDbokJp
         wB2Q==
X-Forwarded-Encrypted: i=1; AJvYcCXJMsupW9q/2wfRWE/GbcMBFx7EryCm4px2Z/dBeJlgUVjX4sfe69Ri/p0JXyFq1cwN7IT/xJ4JwOLL7f4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyw0Az4h7vQmOPmTx6n22ZToPbYOYHMUPCvfwD4yjfHpw6DerwY
	nn5Fgu65UFAeCrlLtt/Y8A6C1Q9UXDl8JYvrsEdVqY80xNGTOK9HfjG7ZBf2om4=
X-Gm-Gg: ASbGncuJCc9b5cM6KV9b0ZYbPBTuOLEro5fK+T1WTUe6v8DKcB/zE28Hwdss1N6xApw
	yAIamKlTKKExaPlC9eBMdry+1pN2bszRLuYTx+vVFGrMLZxg+UpCRg3kVj9yO+zbf4lGK6OKEmd
	O8HyBMfFEbQzJ7f++xpnjvEh7i8ks09x845qekLzc3fWC/WiXVx4LJHh+URCbauTjqASvmjvRV5
	Wqe4AxPIVOihbfJmQW7EVpeDRCnjjH+sDTF4qvj77gz96Mq74MUvGkoY5kk2Z0LRlZ7dsbIeb24
	TW1GtYF/Uo3vvBL1rofnp7JUFDvGLrMzEyGvaAZBZ5KmZzts9MWEXWRWJILMwHU=
X-Google-Smtp-Source: AGHT+IH+XEdLXnQX6nhvXQgyxnwEG52GJc4c2uceRNSxMxazFeWfoa7SI9NnS80gXy0yOwDc7i3hHg==
X-Received: by 2002:a17:907:9482:b0:ac3:10e3:7fa5 with SMTP id a640c23a62f3a-ac3f20f51cbmr1074443466b.21.1742822971571;
        Mon, 24 Mar 2025 06:29:31 -0700 (PDT)
Received: from [192.168.68.117] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-ac3efbdc78esm682685766b.134.2025.03.24.06.29.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Mar 2025 06:29:31 -0700 (PDT)
Message-ID: <90f2bcab-d89f-40c0-9851-7ff25f2c1eda@linaro.org>
Date: Mon, 24 Mar 2025 13:29:30 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] misc: fastrpc: add support for gpdsp remoteproc
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Ling Xu <quic_lxu5@quicinc.com>, andersson@kernel.org,
 konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, amahesh@qti.qualcomm.com, arnd@arndb.de,
 gregkh@linuxfoundation.org, quic_kuiw@quicinc.com,
 quic_ekangupt@quicinc.com, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org
References: <20250320091446.3647918-1-quic_lxu5@quicinc.com>
 <20250320091446.3647918-3-quic_lxu5@quicinc.com>
 <30bba296-8e6f-41ee-880e-2d5ecc8fe5a4@linaro.org>
 <5r72xrv5rtw6bemh5onygkroyasroviijlta4hvwgm5c5hzvax@3icylchlufu3>
Content-Language: en-US
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <5r72xrv5rtw6bemh5onygkroyasroviijlta4hvwgm5c5hzvax@3icylchlufu3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 21/03/2025 14:07, Dmitry Baryshkov wrote:
> On Thu, Mar 20, 2025 at 05:11:20PM +0000, Srinivas Kandagatla wrote:
>>
>>
>> On 20/03/2025 09:14, Ling Xu wrote:
>>> The fastrpc driver has support for 5 types of remoteprocs. There are
>>> some products which support GPDSP remoteprocs. Add changes to support
>>> GPDSP remoteprocs.
>>>
>>> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
>>> Signed-off-by: Ling Xu <quic_lxu5@quicinc.com>
>>> ---
>>>    drivers/misc/fastrpc.c | 10 ++++++++--
>>>    1 file changed, 8 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
>>> index 7b7a22c91fe4..80aa554b3042 100644
>>> --- a/drivers/misc/fastrpc.c
>>> +++ b/drivers/misc/fastrpc.c
>>> @@ -28,7 +28,9 @@
>>>    #define SDSP_DOMAIN_ID (2)
>>>    #define CDSP_DOMAIN_ID (3)
>>>    #define CDSP1_DOMAIN_ID (4)
>>> -#define FASTRPC_DEV_MAX		5 /* adsp, mdsp, slpi, cdsp, cdsp1 */
>>> +#define GDSP0_DOMAIN_ID (5)
>>> +#define GDSP1_DOMAIN_ID (6)
>>
>> We have already made the driver look silly here, Lets not add domain ids for
>> each instance, which is not a scalable.
>>
>> Domain ids are strictly for a domain not each instance.
>>
>>
>>> +#define FASTRPC_DEV_MAX		7 /* adsp, mdsp, slpi, cdsp, cdsp1, gdsp0, gdsp1 */
>>>    #define FASTRPC_MAX_SESSIONS	14
>>>    #define FASTRPC_MAX_VMIDS	16
>>>    #define FASTRPC_ALIGN		128
>>> @@ -107,7 +109,9 @@
>>>    #define miscdev_to_fdevice(d) container_of(d, struct fastrpc_device, miscdev)
>>>    static const char *domains[FASTRPC_DEV_MAX] = { "adsp", "mdsp",
>>> -						"sdsp", "cdsp", "cdsp1" };
>>> +						"sdsp", "cdsp",
>>> +						"cdsp1", "gdsp0",
>>> +						"gdsp1" };
>>>    struct fastrpc_phy_page {
>>>    	u64 addr;		/* physical address */
>>>    	u64 size;		/* size of contiguous region */
>>> @@ -2338,6 +2342,8 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
>>>    		break;
>>>    	case CDSP_DOMAIN_ID:
>>>    	case CDSP1_DOMAIN_ID:
>>> +	case GDSP0_DOMAIN_ID:
>>> +	case GDSP1_DOMAIN_ID:
>>>    		data->unsigned_support = true;
>>>    		/* Create both device nodes so that we can allow both Signed and Unsigned PD */
>>>    		err = fastrpc_device_register(rdev, data, true, domains[domain_id]);
>>
>>
>> Can you try this patch: only compile tested.
>>
>> ---------------------------------->cut<---------------------------------------
>>  From 3f8607557162e16673b26fa253d11cafdc4444cf Mon Sep 17 00:00:00 2001
>> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> Date: Thu, 20 Mar 2025 17:07:05 +0000
>> Subject: [PATCH] misc: fastrpc: cleanup the domain names
>>
>> Currently the domain ids are added for each instance of domain, this is
>> totally not scalable approch.
>>
>> Clean this mess and create domain ids for only domains not its
>> instances.
>> This patch also moves the domain ids to uapi header as this is required
>> for FASTRPC_IOCTL_GET_DSP_INFO ioctl.
>>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> ---
>>   drivers/misc/fastrpc.c      | 45 ++++++++++++++++++++-----------------
>>   include/uapi/misc/fastrpc.h |  7 ++++++
>>   2 files changed, 32 insertions(+), 20 deletions(-)
>>
> 
> 
>> diff --git a/include/uapi/misc/fastrpc.h b/include/uapi/misc/fastrpc.h
>> index f33d914d8f46..89516abd258f 100644
>> --- a/include/uapi/misc/fastrpc.h
>> +++ b/include/uapi/misc/fastrpc.h
>> @@ -133,6 +133,13 @@ struct fastrpc_mem_unmap {
>>   	__s32 reserved[5];
>>   };
>>
>> +#define ADSP_DOMAIN_ID (0)
>> +#define MDSP_DOMAIN_ID (1)
>> +#define SDSP_DOMAIN_ID (2)
>> +#define CDSP_DOMAIN_ID (3)
>> +#define GDSP_DOMAIN_ID (4)
> 
> Why are you adding these to uAPI? How are they going to be used by the
> userspace?
> 
>> +
>> +#define FASTRPC_DOMAIN_MAX	4
>>   struct fastrpc_ioctl_capability {
>>   	__u32 domain;

here, in domain value of fastrpc_ioctl_capability.



>>   	__u32 attribute_id;
>> -- 
>> 2.25.1
>>
>>
>> ---------------------------------->cut<---------------------------------------
> 

