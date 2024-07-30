Return-Path: <linux-kernel+bounces-268304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C77B49422FD
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 00:36:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5503B1F23DD3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 22:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 971D71917CA;
	Tue, 30 Jul 2024 22:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UzlsCUme"
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A14C18DF9D
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 22:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722378975; cv=none; b=MmVOuvXkOYKTt9i7Gg1YGb4RJmZJXumIgvlEdcF41AdFLDs9hFLNFdVg0HfCmP6pLW1z7zl7OTipkYMQ7SuMq9lKpE3o6b91hoxC90tQlXXzycFItkWS8RT8kpUdD4/5Gx4kSwq37wtyIrHAyqM91GKOdiBSpyARPUTe6TKS5cE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722378975; c=relaxed/simple;
	bh=cc8vLvsFZ3snkQtVLxmq6IYaFp9srndCvo2xz44J+ro=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g/AcgqaI4YRr1m26dEeSo+6kcP89qjfXkX1TKEIMlRCz1S3tih0xap/MzM+3eRmNYwy3CNq2DYWko3CVXSA/BpPerjhVnQGp4+T6hYHqAzgrg4JQ9PzMt/DpKBjM/p79M72usZAi1GP/P/fis6duo1KJhuANSbF0eT2U5FTecVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UzlsCUme; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-81f902e94e6so19917739f.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 15:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1722378973; x=1722983773; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hfufdps93lvhHBZU/7yGC32I/ET/zYnuXNh/RR8RkPU=;
        b=UzlsCUmeb1GWG3pXVAnKntEUYU+OB3FGr7Wd7D6hi5FvqANWKdLnghfvNrjEdSdft3
         1qifpwU4bWQeb3yr60VSezyW6q2nv3VY/igj5FbcprAtvnrB9OHui4q4hQ5vRMtK83vQ
         VhVlZ2Kwgti8cFniKyaZkv/9Bs767VRlFPY8o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722378973; x=1722983773;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hfufdps93lvhHBZU/7yGC32I/ET/zYnuXNh/RR8RkPU=;
        b=S4vD604hSfHAWB5SWB2yW1Sw1wGo/Jz7VlVLel2+xjXsHpfreQzoteeZasgOKzBt2v
         jULMrTEu8vdL9Pw2xWlDa05stY+5o6wjPvtTa4PKwiUlumoJ6Lw/zuaDVCEQ+ogmKZ/A
         y2gJucMg5JaHJG23yklyjSO7MtTZocRVnHFPoyAiax8FcE/kqQFhRzZAqPV4nePRYh9n
         O7OrZ0cSF7S7bSBcV6bfc7t3dbUXhUVmF8dABsZhyw9LWO6dSGa4oCDtuJQvIr0PzowD
         NvJldFaOF0d7Rs7Mkr0flf1g0qi7ijrh1o0HXF2oTUiiIVlLZ6SWsunBqbuNGpWv8QhA
         6t/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUo3shdqoDzmPFkKkjzHZ6BRYdjU4odz528soyLNZd2npHTDvZom4XvmKMi4fwoqOQUaojL6Ac3ZNvkt7Hrbt/mNNUpO7lTgGskCG5B
X-Gm-Message-State: AOJu0YxEWqtcVzGfmkGjlwkatn9ZKC3klWMbpn6tmNmLmrQq8CqIY6uH
	uu5HxgjsqKdnGRMO2NsfXsRcZgbNloKhvpblriv66aYFElhglApok9qQd5H6YSI=
X-Google-Smtp-Source: AGHT+IGbHwtVL0eUe7UecSlj4yXroIjkL5fDWuqr1JOjoz63uTFv+YGrH76ZeX+kX7TEvLqN/LgsMw==
X-Received: by 2002:a6b:d303:0:b0:81f:9748:7376 with SMTP id ca18e2360f4ac-81f974874fcmr670378339f.0.1722378973431;
        Tue, 30 Jul 2024 15:36:13 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4c29fbdbf2fsm2986709173.104.2024.07.30.15.36.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jul 2024 15:36:12 -0700 (PDT)
Message-ID: <16f14d1a-56f2-4c2c-8180-74ad9bee0182@linuxfoundation.org>
Date: Tue, 30 Jul 2024 16:36:11 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: user: remove user suite
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Shuah Khan <shuah@kernel.org>, Kees Cook <kees@kernel.org>,
 David Gow <davidgow@google.com>, Vitor Massaru Iha <vitor@massaru.org>
Cc: kernel@collabora.com, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20240725110817.659099-1-usama.anjum@collabora.com>
 <23d0926f-293d-4a8c-b503-bd8b2253b7a8@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <23d0926f-293d-4a8c-b503-bd8b2253b7a8@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/25/24 08:44, Shuah Khan wrote:
> On 7/25/24 05:08, Muhammad Usama Anjum wrote:
>> The user test suite has only one test, test_user_copy which loads
>> test_user_copy module for testing. But test_user_copy module has already
>> been converted to kunit (see fixes). Hence remove the entire suite.
>>
>> Fixes: cf6219ee889f ("usercopy: Convert test_user_copy to KUnit test")
> 
> Remove fixes tag - this isn't a fix and we don't want this propagating
> to stable releases without kunit test for this.
> 
>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>> ---
> 
> Thanks,
> -- Shuah
> 

As mentioned in other threads on this conversion to kunit and removal
of kselfttest - NACK on this patch.

Please don't send me any more of these conversion and removal patches.

thanks,
-- Shuah

