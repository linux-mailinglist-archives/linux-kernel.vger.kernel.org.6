Return-Path: <linux-kernel+bounces-271901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B55F29454B3
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 00:58:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9864AB21196
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 22:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAA9314D420;
	Thu,  1 Aug 2024 22:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="headaPY4"
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F5B514A4DE
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 22:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722553097; cv=none; b=WwxQ/Dp3t8F3bUZO73TD85i+FE2guoJNVr+n/Zc0NZ9fHBQrlB5RyTp1faZAIu1Mdok+Xn0GyLa5B61M5jhhW+Qh6/HQelYuI8NO7L9AkDaqfapPkC2+Kpv6zTceYl8ra2rWNqX3roWj5PGWWO/AWoBG2GzXBJEJWEoCuJHMf4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722553097; c=relaxed/simple;
	bh=hNdDXaljFNdIHoVTIanpM9D5lQGS9CEwc4VjHOkMyac=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vBYbiU+aqS5+ifxFdkB2Tu1W432FHCRj30eORNDH4CM2TrMDP5VbtsDjH6YI4zjS6KTLe1Or2G74bDnEQgAc3R3WIvQJ3jUlW7MjaNvYwGZGLUI49j8V4B7fsc7FvQ1L5TgDYxnFj6b1nBnGHd+pNXQJ7j9iDEFmZCk9ziAouXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=headaPY4; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-81f86cebca3so47921039f.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 15:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1722553094; x=1723157894; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=elZ2sawDHL+/JCA2pOdK2FdH2e0k6/WBRk2kp+m5XlE=;
        b=headaPY4ifHx1fIt0ceO/6kGYkAUbYmNuQp49Uf5MDCwQzVFUdakJ7mxTHqyVrcPgE
         efdWIyxgOwgMjcElwPoB4/b9XQKT7V94K3ONfBbqua9BHlUOhFpmDzOjvz21jBBi80aP
         mXYJSSS+EVEXgioZj7DSH8qCh3HlGAru9M/4w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722553094; x=1723157894;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=elZ2sawDHL+/JCA2pOdK2FdH2e0k6/WBRk2kp+m5XlE=;
        b=qT5t4o6OJGOYfiDPpLCQiyI88IUqc97wTdSN3lgSYdkCtrg6IWn990QOYdo/cf24Ag
         DE3nzc8JTv6HE/yHSqsOKXXlUf4DjGDrMMjmtujTxzeas8XwyS9mG8A3Q/Oc9kARqDJL
         lmlwgC20fnQqZz1pNz+giGUIgVJhZOz+WmmpHvQozn4SiAPjd1GozYtjNiQe1+Eff7IO
         zFnLhxGWJZXiaQAi2znAd3yyP0DwTudTtmRGCeP7jJJNELxD22C5Dp2zCGg3KINzgyZU
         TY/eEqnOWPEwvclHl+DaFflo7IiOPBsEorHiWna52GBZ4GE+8LtCW7Pb/xbwsi9BV51g
         fF9w==
X-Forwarded-Encrypted: i=1; AJvYcCUni2yHd9HhlthituWRpubL/02ARbJUyF5aVU8kHCn5x7C/dgOegBuHs1mBjRB+bbWheJ0S62vmrJT0DdYzHY+YW4Rnx/FJspWgkyhU
X-Gm-Message-State: AOJu0YwTTaQWAE6T1oEj2zOj3xXEV/CMC7VciBhxVB1+Ueabk7wrj3mh
	PCMQ38IP74VB6vQP9NuulDSqEdaohOKxPkXefmT+eHahm3VeYx36QpUqOhXYG3USzAXZG/ywDYB
	a
X-Google-Smtp-Source: AGHT+IGxJgKzAS12NnQ8yQU+4WoL2n+SRv85MJf67jk/GDNMR1xS0EcgdwZ8FIIX33NXp1Zt3iI2MA==
X-Received: by 2002:a5e:9811:0:b0:803:f97f:59e1 with SMTP id ca18e2360f4ac-81fd42a80aamr123597939f.0.1722553094653;
        Thu, 01 Aug 2024 15:58:14 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4c8d69c4725sm175708173.74.2024.08.01.15.58.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Aug 2024 15:58:14 -0700 (PDT)
Message-ID: <deda17e1-328f-4eed-b14b-84b47d36e8d7@linuxfoundation.org>
Date: Thu, 1 Aug 2024 16:58:13 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: tpm2: redirect python unittest logs to stdout
To: Jarkko Sakkinen <jarkko@kernel.org>,
 Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Shuah Khan <shuah@kernel.org>
Cc: kernel@collabora.com, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20240710081539.1741132-1-usama.anjum@collabora.com>
 <47ea7423-3aae-4bb3-a41f-1fcb5c07e74b@collabora.com>
 <8696338c-fcd7-4c0f-87ec-9303c9c1ce88@linuxfoundation.org>
 <D34XE10GQHIY.1H7BTET3DOREV@kernel.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <D34XE10GQHIY.1H7BTET3DOREV@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/1/24 16:24, Jarkko Sakkinen wrote:
> On Wed Jul 31, 2024 at 8:45 PM EEST, Shuah Khan wrote:
>> On 7/31/24 07:42, Muhammad Usama Anjum wrote:
>>> Reminder
>>>
>>
>> top post???
>>
>>> On 7/10/24 1:15 PM, Muhammad Usama Anjum wrote:
>>>> The python unittest module writes all its output to stderr, even when
>>>> the run is clean. Redirect its output logs to stdout.
>>>>
>>>> Cc: Jarkko Sakkinen <jarkko@kernel.org>
>>>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>>>> ---
>>>>    tools/testing/selftests/tpm2/test_async.sh | 2 +-
>>>>    tools/testing/selftests/tpm2/test_smoke.sh | 2 +-
>>>>    tools/testing/selftests/tpm2/test_space.sh | 2 +-
>>>>    3 files changed, 3 insertions(+), 3 deletions(-)
>>>>
>>
>> Applied to linux-kselftest next for Linux 6.12-rc1
>>
>> thanks,
>> -- Shuah
> 
> OK, great. Maybe it is not *that* critical to backport this.
> 

I took the liberty to pull this in. I agree that this doesn't need
backport. It suppresses messages and doesn't really fix any bug.

I tested it to make sure it doesn't suppress important messages.

thanks,
-- Shuah


