Return-Path: <linux-kernel+bounces-271673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22A5B945172
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 19:27:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C85B1C22551
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 17:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 629E81B8EA6;
	Thu,  1 Aug 2024 17:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IJGaUuyZ"
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79981B4C27
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 17:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722533257; cv=none; b=CR4/Vp60+4c3pqJZMdvMOYg8WqHoHWXAN7oQ4uRpQpbWIFSUroAW9YF2WakEpRmSlAqWPcsTws4EwhDdkLTtZYWJvzxA8FhKOFcQ4ks1av/dkahWtodW9JsV8TIT6LxxLgypQU+GrGtWzj/vM7eNEnHiPl+SGodgBHfxBte6aWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722533257; c=relaxed/simple;
	bh=bId7gP/loV8FGzON4JBMqgbZPdmQa1LIMF2T+0984KI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PYF05nOtS/D3BMyAZOdTDElY9hq2wM1r9TOM/xOmXzkPyCPkKKSFP/8alTcboZL8DWvZE1WnHev9nZJc58XNnwG/FufPozXGHjuRXOAGpHINdOdSFymx6ULr3jIWf0aGoEZEynBbvRYO7NvZYqfXsvceEyLk/1BKGVIm1abhlsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IJGaUuyZ; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3748ec0cae2so2557365ab.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 10:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1722533255; x=1723138055; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XvjXd9+buzfO11kaj0Ak+01IPu1cm6eWry4DAzKlnvU=;
        b=IJGaUuyZd2rqLFTKOcA2lbAAHSfOhEXPScvVhScQLDXemUhVtCzXXFekitjZvVE4pA
         vWn+W+jgcX7biqSmj0ighn79jZmHizgF7WdF77jUNjjLfUyc39+vx2nwyMdOOf8hA1HJ
         4V8dKlemAGu3fPw9xaR6JwaA3WL2QTq90d3uU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722533255; x=1723138055;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XvjXd9+buzfO11kaj0Ak+01IPu1cm6eWry4DAzKlnvU=;
        b=tclbxG4GMKSUyfrFF3G0qR95FIL2HKbsYFuuK6KcsPAuHhRifnccV0CAdF/0uxDGc3
         LlXzGZ4AsB1R4KjlrIK7h8KsKCQHyvbLP9tmWHg+GyEHNEEuPOJMUZUElq2vygilBCr3
         NZuR29Yu1u+Uhow0f7lnncopP9f2OekB1HCS5g9+EhJ5msDBiHCBMmwKX+zVGbrPsMz5
         OIk9TnzDWtBpVBuTHYMaIA1UBDT1J+B14yMv72VFTWV9LoMuLNC83e+nL02qw1oCQK7t
         waD7aU7CEug0d7mh/jyIwgOCqom5jAptXCcQaGZ9M9c2BQ6FnYDnkPSVAs+9y/jaohds
         q57w==
X-Forwarded-Encrypted: i=1; AJvYcCUoRBgyrO1ZY5DDFzgEidHbgkUTVat5KmMa8jI/Rycr7KYgd+qsoNmlQgKbL7XjlOy6Hs48DOnGWVrdHtk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgtXGHoaFIxJGhkye5PRGC8BEqD42tWlm9QLeMcwgqqHuCEW+J
	UdPuMQF6zGv0oh6zlJVT2tSJRKGPF9PU0ml4JPOLzxeHeThAnfupNmyJt0HHtxQ=
X-Google-Smtp-Source: AGHT+IGUyTv6tUwJDPzdWwPYOqHK6HoT9ZZPInrajbxk2JZzM0qb5kO4EbasMUvOyEOAZf5vkTAOww==
X-Received: by 2002:a05:6602:4613:b0:81f:86e1:5a84 with SMTP id ca18e2360f4ac-81fd43981demr71759239f.2.1722533254768;
        Thu, 01 Aug 2024 10:27:34 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4c8d6a3e3casm20125173.147.2024.08.01.10.27.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Aug 2024 10:27:34 -0700 (PDT)
Message-ID: <2e1509f5-2a10-4876-8619-6a6b9c29d269@linuxfoundation.org>
Date: Thu, 1 Aug 2024 11:27:33 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] selftests: openat2: don't print total number of tests
 and then skip
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Shuah Khan <shuah@kernel.org>
Cc: Aleksa Sarai <cyphar@cyphar.com>, kernel@collabora.com,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240731133951.404933-1-usama.anjum@collabora.com>
 <c1414d9d-61b1-4f92-bc8a-333679362283@linuxfoundation.org>
 <d30aa38c-5dbd-4c18-b20f-a6eb9e9e722b@collabora.com>
 <f560819b-3a3c-4999-ad63-422ca31e9b08@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <f560819b-3a3c-4999-ad63-422ca31e9b08@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/1/24 10:27, Shuah Khan wrote:
> On 8/1/24 02:42, Muhammad Usama Anjum wrote:
>> On 7/31/24 9:57 PM, Shuah Khan wrote:
>>> On 7/31/24 07:39, Muhammad Usama Anjum wrote:
>>>> Don't print that 88 sub-tests are going to be executed, but then skip.
>>>> This is against TAP compliance. Instead check pre-requisites first
>>>> before printing total number of tests.
>>>
>>> Does TAP clearly mention this?
>> Yes from https://testanything.org/tap-version-13-specification.html
>>
>> Skipping everything
>> This listing shows that the entire listing is a skip. No tests were run.
>>
>> TAP version 13
>> 1..0 # skip because English-to-French translator isn't installed
> 

One more thing on TAP compliance - we don't strive to be TAP compliant
as it doesn't meet our special needs.

It is important to keep the how many tests could be run to improve testing
coverage.

Refer to: https://www.kernel.org/doc/html/latest/dev-tools/ktap.html

"The Linux Kernel largely uses TAP output for test results. However, Kernel
testing frameworks have special needs for test results which don’t align with
the original TAP specification. Thus, a “Kernel TAP” (KTAP) format is specified
to extend and alter TAP to support these use-cases. This specification describes
the generally accepted format of KTAP as it is currently used in the kernel."

I appreciate the effort you are putting into improving the reports. I request
that you refer to the above document and also keep in mind what would help us
improve our testing over focusing just on reports and compliance.

thanks,
-- Shuah

