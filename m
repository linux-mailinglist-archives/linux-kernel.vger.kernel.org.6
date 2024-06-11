Return-Path: <linux-kernel+bounces-210081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6903903F1C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 16:46:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42AB82833DA
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 14:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E769D111A1;
	Tue, 11 Jun 2024 14:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="avwe33f7"
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30DB5171A5
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 14:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718117207; cv=none; b=cdlLYh29eqxsqWsQQZJxA1IrI2+akGgWA8mJbYY3SFMRy0d9iHwYC9ZMVyPN9BnWsU1gvXUjpMo8ZuutkxEo07+Sl62c+S0oC2/rvMpxkjCyhIe6CCiJtw6P3hVowtL3/kgEH9GycV47ZBWWbKW2IQ3meZK6BV98KEh/cFqpQYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718117207; c=relaxed/simple;
	bh=YS93EmhvsNCHUzkRltXmFg/kyvtPxR/SgrHEK/06tyo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UppNW8GKGIYJnwat8kMIlgo9Nu2Ln3EtwYOKZNoxAw8TNj0PqVbLqycvE1YQZ0KOZoMKt+4B+Ao5UbOF5VVZWP/9Q9oCf1GYGbGiDoXuMx9klcv38rVfUAPplMt6kg3M9rTDv6mChw20f6kkiSGu3lVT/4LIlX+Vxc1fpML2hkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=avwe33f7; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-62a0827316dso5535807b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 07:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1718117203; x=1718722003; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y4oOmcc62KuINJgrDPpdqc07FOLSw//xTr8h1MxyG7o=;
        b=avwe33f7YwCNbY0wvDVUzWsz61zGu4FoZj5mEyCP1cZub3xa44ZcFU6ClBVdD1L69D
         gkKiGGyteHTx09aMfX5LPt7MsYVRZzhABWYhNC44EZfixjPPPdW9KJxdizB0rOt5B3TC
         6OJOgrdqWGH5T3v+7tkNNcYxCKOrV7MKHyAeE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718117203; x=1718722003;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y4oOmcc62KuINJgrDPpdqc07FOLSw//xTr8h1MxyG7o=;
        b=dSKDniEkh9hczZ/W977ceCKGzCOzaBJeOxrVCjRno/EI6fHDwHg7ubgJCSKYiKNjpH
         O5Z1UmGrG+QcGehdnO2TeEQa/HciDH0ryUjGU0VC8gqp9mUKrOCXnn8PcP8cVsr5Kzj9
         0M25t3AlzqqA5pPEFYdCbeDkoeCH9VlgYtyYqAMtQOmlY9ES0w0HvtMqpjmT/ItwDalr
         +zlWFGZGagMOUoOoGIyCPY25c4qDDg8spLa7gfzOLZUJGTFIv5dc/7Ogtz9A/K28ue54
         6dGmyahBDqARrJOjpBEcHumq33aojzMFh75c5OLxZM0jkgjq4UMLyMse670fba4oF6zg
         4vhA==
X-Forwarded-Encrypted: i=1; AJvYcCVX9pFIaNBegZg+ajfXQ52PLa99z6ll3zQozR/bUJyRqG5S6IRC7ZqUOqFMLZfmM2NR3rW0PWIUpJ6lc9WVvII4T6KM2cn8Th0Clzaa
X-Gm-Message-State: AOJu0YyYeL+x7A5YMYSO7TwyYHnzF2EubbZ8KOceKSpa36rUu4d+o01s
	9WZ4fLh0Cucrwdly8oYZ9vtdmxc1qauTM5Wmbi8wC3xwO9mT9uvMAu5M+9gx54o=
X-Google-Smtp-Source: AGHT+IFe8P/Dd7p7Ts3W5h3yhz58D2E6RxyLY9zdF0OLfzXhWlorREcO1afSNjtFCWT2/cvKS5K3Zg==
X-Received: by 2002:a0d:fbc5:0:b0:622:cd7d:febd with SMTP id 00721157ae682-62cd568ebc8mr99646547b3.3.1718117201883;
        Tue, 11 Jun 2024 07:46:41 -0700 (PDT)
Received: from ?IPV6:2607:fb91:213b:a129:544a:cc06:ea0:4045? ([2607:fb91:213b:a129:544a:cc06:ea0:4045])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-62ccace8257sm20304497b3.43.2024.06.11.07.46.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jun 2024 07:46:41 -0700 (PDT)
Message-ID: <43e24489-a3af-4e53-afc6-ff1dd9462ee2@linuxfoundation.org>
Date: Tue, 11 Jun 2024 08:46:39 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] selftests: seccomp: fix format-zero-length warnings
To: Kees Cook <kees@kernel.org>
Cc: Amer Al Shanawany <amer.shanawany@gmail.com>,
 Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>,
 Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 kernel test robot <lkp@intel.com>, Shuah Khan <skhan@linuxfoundation.org>
References: <be032a65-e61b-40e0-a982-cb622ccca548@linuxfoundation.org>
 <20240607124117.66769-2-amer.shanawany@gmail.com>
 <a461ba9f-b171-4b49-b282-1f4e2830f31e@linuxfoundation.org>
 <202406100957.750569FFD1@keescook>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <202406100957.750569FFD1@keescook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/10/24 10:59, Kees Cook wrote:
> On Fri, Jun 07, 2024 at 02:58:47PM -0600, Shuah Khan wrote:
>> On 6/7/24 06:41, Amer Al Shanawany wrote:
>>> fix the following errors by removing empty print statements:
>>> seccomp_benchmark.c:197:24: warning: zero-length gnu_printf format
>>>    string [-Wformat-zero-length]
>>>     197 |         ksft_print_msg("");
>>>         |                        ^~
>>> seccomp_benchmark.c:202:24: warning: zero-length gnu_printf format
>>>    string [-Wformat-zero-length]
>>>     202 |         ksft_print_msg("");
>>>         |                        ^~
>>> seccomp_benchmark.c:204:24: warning: zero-length gnu_printf format
>>>    string [-Wformat-zero-length]
>>>     204 |         ksft_print_msg("");
>>>         |                        ^~
>>>
>>> Reported-by: kernel test robot <lkp@intel.com>
>>> Closes: https://lore.kernel.org/oe-kbuild-all/202312260235.Uj5ug8K9-lkp@intel.com/
>>> Signed-off-by: Amer Al Shanawany <amer.shanawany@gmail.com>
>>> ---
>>> Changes v1 -> v2:
>>> removed empty print statements
>>
>> Kees,
>>
>> Is this change okay with you. I didn't see any use for
>> these empty ksft_print_msg().
>>
>> I will take this patch if you are okay with the change.
> 
> Dropping these means that the "#" marks go missing. Currently:
> 
> # Running on:
> # Linux proton 6.5.0-25-generic #25~22.04.1-Ubuntu SMP PREEMPT_DYNAMIC Tue Feb 20 16:09:15 UTC 2 x86_64 x86_64 x86_64 GNU/Linux
> 
> with the proposed patch:
> 
> # Running on:
> Linux proton 6.5.0-25-generic #25~22.04.1-Ubuntu SMP PREEMPT_DYNAMIC Tue Feb 20 16:09:15 UTC 2 x86_64 x86_64 x86_64 GNU/Linux
> 
> This breaks the TAP syntax for the test, so we should find a different
> solution.
> 
> Perhaps:
> 
> ksft_print_msg("%s", "");
> 
> ?
> 

Thank you Kees. Yes that would work.

Amer, please send me v3 based on Kees's suggestions.

thanks,
-- Shuah


