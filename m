Return-Path: <linux-kernel+bounces-366181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97DE699F1B6
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 17:45:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2181F1F2575B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 15:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 758F81EBA09;
	Tue, 15 Oct 2024 15:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IcC4MuBB"
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6CC1DD0FB
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 15:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729007071; cv=none; b=XOHIB6lL1i3W3k1o24EMVXalVhXNBDVJY0/zJYPWnb269WX38azAYneMYGITJiZ2QuT5MNUu6J5Kc+VsN9kj6O8N46tEWXmACtQ0fwUmjdCck9vEKKZRiAclLmnYmVI2+Sems4quzTUbKWNyJcDHFwkH4yMZBNuaAxNy1AHyjys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729007071; c=relaxed/simple;
	bh=ZMviXiAqX/1vRejHCZJsZfvVa1vrc6BGMbmi0/4asaQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D19Okln7Qj5x2nKG3kk461tSpPzwDpv6LjgAWq6nktzXcjSfIwk10f6LnS391mIUiFfogW8FP/ZPHeb7TPOjasdib9hb7EAP7NWQ8hhO3Ei+blRWfztXjuTSBoMQR3BYg0WHIKOi8G+XmCTmlpyj+ckrUo9SCbsnTNjXRAqmi/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IcC4MuBB; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-8354cc1ab0cso204473439f.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 08:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1729007068; x=1729611868; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3Bntwg/Atv9rqd2TP5mnLWBftbDjm7MQLD0dLGG8M38=;
        b=IcC4MuBBDBUfHkmcsJjWYgckIJVM2Yyjul5BULi0GU2C/LX7lci7kyPrnztBqGNPQE
         JGnC27ZfXRqC4H2EqxBixuWBHJaBZ3UcxNq2MxoDzTjhBxQqMeujazX2s0TJiOB4oXGa
         /91FvFsCGhC4cr/butS2T6fe/3wh9/CVXXV4Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729007068; x=1729611868;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3Bntwg/Atv9rqd2TP5mnLWBftbDjm7MQLD0dLGG8M38=;
        b=KFcXoRJavkyGxWJH3MNG++r5d6SzpVKRnTAxxX2ypIhVoS47qlFxvfS0Y8O4VsBUzo
         w61mUxH+o/n8n14x/mhP7Kg05JpAd8FDHBJo0T7q3qSlAvEZLiooDs9YJL5qUTvGB0nG
         hlil75ONEguvOEjbK/XNUd/f5bOqk26zRhyo3iV/NLjs7VfeDAh3S1x7ExwaeEkyFLxg
         VaKWl7GjPDmhuI+z2X2C4P1QYag4vA3/o7Dk86oE9R1EfxOItgZrXgYlE51cZDPXl0b/
         sR+1PHqbzQo2Gxvd6FHFBscqCCzpQaB6S+154wkSW/MNhjYQJ1mEvlIzFH2mzVCFI+bl
         SV1w==
X-Forwarded-Encrypted: i=1; AJvYcCWutpwzZJxbHu9Ush7MF0q0RQItylphlMYDBWGiObbkUdK4tsoay7E+HJb40TL2Q3OEP3s1FEBKcTjQbVQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYvWRUrJ0a8pXFmm6fuYTjfTLuhApRk0NIHyJo0xM3JjAmWbQQ
	1/Cn0hoyfls7Bjg5nXyhYPHWJNmYGh02682PUXlJfaf7cfZcqB7liO8LnsnWesg=
X-Google-Smtp-Source: AGHT+IFRGisUuDXjoDnaEkZXdXJnMpumv6OGpg87Zn/JEQr2OVhnvKMYBa0BDP1KgXedaRFG0AVMRQ==
X-Received: by 2002:a05:6602:13cf:b0:835:3884:77a3 with SMTP id ca18e2360f4ac-83a947117d5mr132679039f.13.1729007068306;
        Tue, 15 Oct 2024 08:44:28 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4dbec9b24cdsm367688173.63.2024.10.15.08.44.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Oct 2024 08:44:27 -0700 (PDT)
Message-ID: <b744b13e-f226-49fa-996a-c9dca2cfe90f@linuxfoundation.org>
Date: Tue, 15 Oct 2024 09:44:27 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] Bluetooth: btintel_pcie: Remove structually
 deadcode
To: "Everest K.C." <everestkc@everestkc.com.np>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241014163001.4537-1-everestkc@everestkc.com.np>
 <31a73bb7-47ec-496c-8a65-02e331051e0e@linuxfoundation.org>
 <CAEO-vhEg_whKPkWmym99+a1Lx2kU5CcBCYrz6unKANbCbV9dHg@mail.gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <CAEO-vhEg_whKPkWmym99+a1Lx2kU5CcBCYrz6unKANbCbV9dHg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/14/24 22:52, Everest K.C. wrote:
> On Mon, Oct 14, 2024 at 6:02 PM Shuah Khan <skhan@linuxfoundation.org> wrote:
>>
>> On 10/14/24 10:30, Everest K.C. wrote:
>>> The switch case statement has a default branch. Thus, the return
>>> statement at the end of the function can never be reached.
>>> Fixing it by removing the return statement at the end of the
>>
>> Change "Fixing" to "Fix it"
> Will fix it in V2.
>>> function.
>>>
>>> This issue was reported by Coverity Scan.
>>> https://scan7.scan.coverity.com/#/project-view/51525/11354?selectedIssue=1600709
>>
>> Please include the output from the scan. People can't see this report
>> without logging in.
> The issue is no longer visible in Coverity. Though the code is still
> the same. The issue hasn't
> been fixed. Should I remove the link too ?

What's the use of including a link that don't show the problem?

>>>
>>> Fixes: 5ea625845b0f ("Bluetooth: btintel_pcie: Add handshake between driver and firmware")
>>> Signed-off-by: Everest K.C. <everestkc@everestkc.com.np>
>>> ---
>>>    drivers/bluetooth/btintel_pcie.c | 1 -
>>>    1 file changed, 1 deletion(-)
>>>
>>> diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
>>> index e4ae8c898dfd..660496e55276 100644
>>> --- a/drivers/bluetooth/btintel_pcie.c
>>> +++ b/drivers/bluetooth/btintel_pcie.c
>>> @@ -391,7 +391,6 @@ static inline char *btintel_pcie_alivectxt_state2str(u32 alive_intr_ctxt)
>>>        default:
>>>                return "unknown";
>>>        }
>>> -     return "null";
>>
>> What happens when you build your patch with -Werror?
>> Do you see any build errors?
> I compiled the intel bluetooth module without error. Will mention that
> in V2 patch too.

Okay.

>>>    }
>>>
>>>    /* This function handles the MSI-X interrupt for gp0 cause (bit 0 in
>>

thanks,
-- Shuah


