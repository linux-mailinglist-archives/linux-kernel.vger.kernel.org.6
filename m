Return-Path: <linux-kernel+bounces-279005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA98D94B7A5
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 09:21:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 681E41F252A6
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 07:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D9BA189F58;
	Thu,  8 Aug 2024 07:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jSVJD0Z1"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E96B8189F2C
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 07:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723101539; cv=none; b=VxIbfyo/A0F5faK8MbQ5aX+s1QCXd5nxA60aSBOez4o/XC5OTnJZxBdlOJckl3bAjZYbmsOsyuJ1Jfoovr7TLsbVpCl1Xoen7bVCisWRsRSnR8Pc5Yj+/H0UYxW0znX/yKAaySvECpmz3N/jY9afIumk4/a96WA6DgUWf8YyUEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723101539; c=relaxed/simple;
	bh=xZ1q4iVftMneU5Db6AJ5bSjJJcMNwwGD9VWVr/mp2no=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T38eb87+NjcySQlIDnX3mBOvDHlZ2f89S9+dAQY145RUuaP2AR9h+esLz17l7fwwTfcL22t4HmrBx9/bvQa0nhKsfdb1EMWdsaEGM8POEDHkodqCheFgp/npsgOs7rWFPS+Frli/h0KBYURtRHkmi7bthV6CxEhsZ42sPCM2ipI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jSVJD0Z1; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-367990aaef3so376846f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 00:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723101536; x=1723706336; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tpfTqck61BGRbHI1Fw35d7IcXYkb1l4PlQZzOETiKiI=;
        b=jSVJD0Z1BCLoc2iLc7vPWBi/94ndVCU2WtgORW6orBLx+I3BW90l/IL7gt9HWA63iV
         y4yGrQSKwHchJ7ECskdkPdOhoB9fYXehVtMMVsO10DzcHExAj/97+EyhZ2CJ/CgSoGHQ
         n8pC3/QdY0FO/N+j4JojRL7LGTzMPS9903d7SJd7p++7+Hb6yVbU13bhcCMHM1GScuZe
         Z/9402nHWnCyYikImypCRcIVo1XYrvJvI1B5QdlgLJyLSYR99AZCZwFAZt7mvzs+Pci+
         wGRAI7MuHN0kL+CsHU5rjIcwjvlGt742ynQXJTOUdecjDrr2AaWIT6rLIQB/0Tm5hV6b
         ZVyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723101536; x=1723706336;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tpfTqck61BGRbHI1Fw35d7IcXYkb1l4PlQZzOETiKiI=;
        b=Sa1dlVA6f/twaWJv+zyaEbmSzElUF0Xkm8hOQZo89Xb6ZrOVv+/8daYTQHzBmITTZf
         2nLs+6lvPv1QM0xYeZOhrxr2eFCNMQJhgguV+tpNK5Xbkx7nSaauCz6GB9lGMnNUHq2V
         UQ3QoE3UTCmcxIA43R2SVYdmBoT4ip9yRx9Zr6oomh5zbgT2HK512wvqSo7a2gGFwJF9
         PHwoXXX/rQmgyS1TwCWbG9osv8zYjpO7c+QQ19tr5lAPZLSdcNYAvYR6UbSaidnGgudJ
         ZuNg75Zng/AzR+ezBffeOpMU/x0AxUdrpRz42vaqgYCAWdhLngu8Zx0Y+/iHJhOO4ssv
         uuGQ==
X-Gm-Message-State: AOJu0YwMDh0aptAq931Q+P1TCYXaFeQG+vu8zdRQ8U8aRXOezP3bf3RI
	tPedq8PvTx6gwIEyKJaWHXQrdu7A4M5EbYEyb9lR5D8Ng1P3/qt4NNiZAkVOV0M=
X-Google-Smtp-Source: AGHT+IEUsmzG7aAGK8BFT1xvxz1HGxw5dkKdO58vFHbRRQ1ZiuhGafVQcf8akV4ZJaVgKL/qH15ndw==
X-Received: by 2002:a5d:4490:0:b0:368:74a8:6c34 with SMTP id ffacd0b85a97d-36d27503a4emr608230f8f.36.1723101536141;
        Thu, 08 Aug 2024 00:18:56 -0700 (PDT)
Received: from [192.168.68.116] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-36d2718d7ccsm915909f8f.51.2024.08.08.00.18.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Aug 2024 00:18:55 -0700 (PDT)
Message-ID: <aef4aad3-ea26-4ad9-ac86-f0906a0524c3@linaro.org>
Date: Thu, 8 Aug 2024 08:18:54 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: Fixes tag needs some work in the nvmem tree
To: Michal Simek <michal.simek@amd.com>,
 Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20240808083050.6ac578f9@canb.auug.org.au>
 <e8688839-7686-47e9-a497-31b57abd46e2@amd.com>
Content-Language: en-US
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <e8688839-7686-47e9-a497-31b57abd46e2@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 08/08/2024 07:00, Michal Simek wrote:
> Hi Stephen,
> 
> On 8/8/24 00:30, Stephen Rothwell wrote:
>> Hi all,
>>
>> In commit
>>
>>    c258adca4fb4 ("dt-bindings: nvmem: Use soc-nvmem node name instead 
>> of nvmem")
>>
>> Fixes tag
>>
>>    Fixes: a0cfd5e99782 ("dt-bindings: nvmem: Convert 
>> xlnx,zynqmp-nvmem.txt to yaml")
>>
>> has these problem(s):
>>
>>    - Target SHA1 does not exist
>>
>> Maybe you meant
>>
>> Fixes: c7f99cd8fb6b ("dt-bindings: nvmem: Convert 
>> xlnx,zynqmp-nvmem.txt to yaml")
> 
> thanks for reporting. You are right and I have no idea where 
> a0cfd5e99782 is coming from because I even don't have this sha1 in my tree.
> 
> Anyway that's my patch and issue on my side and I am sorry for it.
> 
> Srinivas: What do you want me to do? Send updated one or are you able to 
> update the patch itself? Please let me know what you want me to do.

Please send me a new version with fix.

--srini
> 
> Thanks,
> Michal

