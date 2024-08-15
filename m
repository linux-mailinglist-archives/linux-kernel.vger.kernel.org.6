Return-Path: <linux-kernel+bounces-287678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5F60952B3D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 11:38:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C5E2281ED7
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 09:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E16419E7F7;
	Thu, 15 Aug 2024 08:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kvSTnNGB"
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B4871993B0
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 08:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723710917; cv=none; b=Yp6Q5CKcIlM/VkBQ6AvJfSeH/6/c7SSG0OYfWePUb3Teum12cRObFCKnv3wryJl4MPa/sy2US2lixd/skKTN80r+Y5OzG5cFVSSPtAyprz1PtnjMtvpTtXbvvSQB38/6qJqSQ74MOhtuvaSQeJzyb7lEZC0kho6hH6RxVcYBzkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723710917; c=relaxed/simple;
	bh=tMD384NGd2FNoicKMSQOBoGZQdYzCWHzLu+XkzTMfvM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gbj3KW6NQsOCTTMHdk/6nnqlFrCfa05h0qo4PZkXGt659ye4K2/qZznkDmsCnksjPi6oqRe6kwSNYNg0jZ+C2tKTw8US2Lrkg2QdcLhGpGlXCv53lzFyvLUPRcp0gOw4krsHGJUpXvxpvgBj4ASl0bgjJhuczvvmTmp6sfF6uiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kvSTnNGB; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-68e3b219fe6so1437117b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 01:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723710915; x=1724315715; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GYYVMDYBpdqwl6lizPAh3H8eho/Vn0tl96oFDNQzS/Q=;
        b=kvSTnNGB5SPwWTuLMsfIS+d6fJejmKaaiFlUi4cjQ9Yh8yXtufPklP+mkHW4dqLzlw
         CnA5qDyRIAoROlqFW9RV3oqi9/FliPfS+nWLIzKwgfHikXwhOFjEydBfnoskYuDQ1bga
         HdHX+0DnykHeU8X6bYrwlhwWUpACTobFkxuNNX6IuJ+anS3w2e20ON7equp4Vn7pYm30
         29My3wjmAe6/+MCgXvNrxI0LfbMX4DrkV8FOr3T2yFlF+g0zf/cEz2ek3ttkiIGlmYGJ
         b5nyJiIAz1WHoLzayQE+K0HlYyDHQCua/88kbSRN9IrWoYoMt6bNos1Ap+ISvlaQ3qqP
         JVig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723710915; x=1724315715;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GYYVMDYBpdqwl6lizPAh3H8eho/Vn0tl96oFDNQzS/Q=;
        b=QXMurxnwqbLVc7mTVYnLsCnbqrNNsj48Y0cz4ZpcuvW7VeRLFtd4oFq4zrNh9F8wJh
         Bqo6QO819xWIoYj7wRWe04NyeNte9YrmdyWXkARIf10O8GAYDHDAlA860t25bw8/HQ8Z
         imW/P6GRI4QKW6PS5NS3KggKx4mIA9jDUX8Yzf78xElzohWvEeq9wt3DovwBKg97KWAz
         SmAM/0FD7fIkfQTVDofmovjoylFj8qvfbdz4JYpBU2WNpD3GbgoMN8hbxqLO5MgJcqUi
         cZ2uv/b2yXE+JuN7dI3HPSOZrkWNC180+BPf8fccDnw4AFfBcjh27p6WeAmAvma8JfO1
         GP4A==
X-Forwarded-Encrypted: i=1; AJvYcCVVk2Nb4cVc1XDOMy8zs8Typ3dNGeqIfe/rCCR3CFBRJ9k9hZeRs2kxdk9cYne8r2/RR8KO4+R2cgf/Bmo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZLvhyGaETMMNbP4HcLbElaIVZwcwa4Cr3hY/SU5fD36Asfzc/
	seA6W5pBT4/6JvLxU73+ubcOsAHplR7MXry96q+KcZpJLkipI62R
X-Google-Smtp-Source: AGHT+IGp+x8qmV0pYwu/Djz+PoFikr2EeX3IKVT5Zc9KZnXGuZRuTq9aVyLY5iO9C7t+KLY7Dvd4bQ==
X-Received: by 2002:a05:6902:2611:b0:e0e:8735:7161 with SMTP id 3f1490d57ef6-e1155c0d4d9mr3712714276.8.1723710915140;
        Thu, 15 Aug 2024 01:35:15 -0700 (PDT)
Received: from ?IPV6:2604:2d80:4022:0:9007:a741:5566:7d2e? ([2604:2d80:4022:0:9007:a741:5566:7d2e])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e1171e72bebsm206429276.38.2024.08.15.01.35.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Aug 2024 01:35:14 -0700 (PDT)
Message-ID: <362eea30-7b6d-4cd5-aed9-88c0d014dd91@gmail.com>
Date: Thu, 15 Aug 2024 03:35:13 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] misc: fastrpc: Restrict untrusted app to attach to
 privileged PD
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Cc: "srinivas.kandagatla@linaro.org" <srinivas.kandagatla@linaro.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Ekansh Gupta <quic_ekangupt@quicinc.com>, stable <stable@kernel.org>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
References: <20240628114501.14310-1-srinivas.kandagatla@linaro.org>
 <20240628114501.14310-7-srinivas.kandagatla@linaro.org>
 <9a9f5646-a554-4b65-8122-d212bb665c81@umsystem.edu>
 <2024081535-unfasten-afloat-9684@gregkh>
Content-Language: en-US
From: Joel Selvaraj <joelselvaraj.oss@gmail.com>
In-Reply-To: <2024081535-unfasten-afloat-9684@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi greg k-h,

The git commit id is: bab2f5e8fd5d2f759db26b78d9db57412888f187

But I am bit hesitant if we should revert it because there is a CVE 
attached to it: https://ubuntu.com/security/CVE-2024-41024

Also, I am ok with changing userspace if it's necessary. It would be 
nice if the authors can clarify the ideal fix here.

Regards,
Joel Selvaraj

On 8/15/24 00:15, gregkh@linuxfoundation.org wrote:
> On Thu, Aug 15, 2024 at 02:34:18AM +0000, Selvaraj, Joel (MU-Student) wrote:
>> Hi Srinivas Kandagatla and Ekansh Gupta,
>>
>> On 6/28/24 06:45, srinivas.kandagatla@linaro.org wrote:
>>> From: Ekansh Gupta <quic_ekangupt@quicinc.com>
>>>
>>> Untrusted application with access to only non-secure fastrpc device
>>> node can attach to root_pd or static PDs if it can make the respective
>>> init request. This can cause problems as the untrusted application
>>> can send bad requests to root_pd or static PDs. Add changes to reject
>>> attach to privileged PDs if the request is being made using non-secure
>>> fastrpc device node.
>>>
>>> Fixes: 0871561055e6 ("misc: fastrpc: Add support for audiopd")
>>> Cc: stable <stable@kernel.org>
>>> Signed-off-by: Ekansh Gupta <quic_ekangupt@quicinc.com>
>>> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>>> ---
>>>    drivers/misc/fastrpc.c      | 22 +++++++++++++++++++---
>>>    include/uapi/misc/fastrpc.h |  3 +++
>>>    2 files changed, 22 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
>>> index 5680856c0fb8..a7a2bcedb37e 100644
>>> --- a/drivers/misc/fastrpc.c
>>> +++ b/drivers/misc/fastrpc.c
>>> @@ -2087,6 +2087,16 @@ static int fastrpc_req_mem_map(struct fastrpc_user *fl, char __user *argp)
>>>      return err;
>>>    }
>>>
>>> +static int is_attach_rejected(struct fastrpc_user *fl)
>>> +{
>>> +   /* Check if the device node is non-secure */
>>> +   if (!fl->is_secure_dev) {
>>> +           dev_dbg(&fl->cctx->rpdev->dev, "untrusted app trying to attach to privileged DSP PD\n");
>>> +           return -EACCES;
>>> +   }
>>> +   return 0;
>>> +}
>>
>> This broke userspace for us. Sensors stopped working in SDM845 and other
>> qcom SoC devices running postmarketOS. Trying to communicate with the
>> fastrpc device just ends up with a permission denied error. This was
>> previously working. I am not sure if this is intended. Here are my two
>> observations:
>>
>> 1. if change the if condition to
>>
>> `if (!fl->is_secure_dev && fl->cctx->secure)`
>>
>> similar to how it's done in fastrpc's `is_session_rejected()` function,
>> then it works. But I am not sure if this is an valid fix. But currently,
>> fastrpc will simply deny access to all fastrpc device that contains the
>> `qcom,non-secure-domain` dt property. Is that the intended change?
>> Because I see a lot of adsp, cdsp and sdsp fastrpc nodes have that dt
>> property.
>>
>> 2. In the `fastrpc_rpmsg_probe()` function, it is commented that,
>>
>> "Unsigned PD offloading is only supported on CDSP"
>>
>> Does this mean adsp and sdsp shouldn't have the `qcom,non-secure-domain`
>> dt property? In fact, it was reported that removing this dt property and
>> using the `/dev/fastrpc-sdsp-secure` node instead works fine too. Is
>> this the correct way to fix it?
>>
>> I don't know much about fastrpc, just reporting the issue and guessing
>> here. It would be really if this can be fixed before the stable release.
> 
> I will be glad to revert it, what was the git id for this in the tree
> now?
> 
> thanks,
> 
> greg k-h


