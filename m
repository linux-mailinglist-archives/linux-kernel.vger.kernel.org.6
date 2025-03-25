Return-Path: <linux-kernel+bounces-575259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A927DA6FAAF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 13:06:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6CB3189E96E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 12:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C034C2580CE;
	Tue, 25 Mar 2025 12:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jYmKkYsQ"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70AE42580C3
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 12:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742904005; cv=none; b=cvx950/Aozj3ujP81fHNjyNRKP/Rjcy5gyaBN0Z4YoSjshs6PUCb51wxUydXzQ6BM8Sj9XkrC90u+3tzEqWrFuoFEzLuftjg++qV9J91+wrfrffqFlgyEECiYVQM3AunZPo5sUGI2HY8mXICVlp7AjVuFqtTziMgBwhFnYAkZiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742904005; c=relaxed/simple;
	bh=q/83F/znEMswB4R+YPnTxSNeKn6bQaSzNPaBBwCwynY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Sq1DvtETmcmIJpKZPyGDj+dzF+1UVfJeuPiSkPo6q+AJ2w1ddwQ+X1B9xGlfARL1odKbPLXN0/g5Ta+WxzFH+JYSK5ACKfXOtA4GFFeIi/laRrF9TNnQy9Hxox4/reU2BnrI7wWpPHeXFUdoQOkgkg1Efgj4np1pmUnCZe8hVXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jYmKkYsQ; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3997205e43eso4600587f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 05:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742904002; x=1743508802; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TuK45YEur4aLi12yY4E91d6DOq3lKYtTL3iTuyXH1Ic=;
        b=jYmKkYsQ9Eu5d6gKsLTn/ope7/emhnJSqO83ca+IazEqj8XElJvjaLGgt2yyxooUrj
         EfiJhjasqXL1oDd6Mml8RLa7sxiEOO7ODxKebwjzj9dJANVCIhw7phQEWWJeXozMKu+X
         A786+fdjLKDPImvCwOvItGX3cXHhtYXCIMwbDi7pP/8FW94dvqmq2adY3rluiWq7nAgB
         ZcTtmy+/1MCg5z+Sw6oKNf440DEOqtyxSrRQHXeVAZv7bHKDG/NSe2BmH5fQSjSCOvmj
         HZ6K9Nj/09J9Z69+2HcWQkDDx4KPyGykmvjBHLDj3WbljUaaIiah7byQQb35fPT1VAyf
         KoEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742904002; x=1743508802;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TuK45YEur4aLi12yY4E91d6DOq3lKYtTL3iTuyXH1Ic=;
        b=N3/+NsTRuMZwPOop/DET4yc/nYPpUVBGaLrfXRiyTfRydrG4seO898f7thCN0CVBZb
         3biufmfvFNTbIoaqIGr7hIys43iX5y+QCwmzQUe1rzQ8siPhBE7XGd5anpSfGB6kgmEE
         q2BtZP05UoVTahy/RJMLGAbQf6f0JPoe2Ym69/dtJ2EBdL4Fn5b7qHaUmv/Jpg3kck14
         XsCpSoiHRKCKdc5DLs5i0hZyBCIxM10O/9s4+6WclgqAq0/5+JfdKJYlvLLbhtD3RjUP
         M/Yz+ig6mZ0+8lE5VoO6FNQDlgAzvd2xvlgFsZyP8ig4O4mCYrMhrEEciFLjPlOGEGAM
         pESA==
X-Forwarded-Encrypted: i=1; AJvYcCWGLlQsLY7kUAJltm5XNB+7b1NmV6CoaH72EXfvpyQ0N9dHITjzJ+IrgcDtfKh2ztwNtDLjS6E4eEuwG+U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOADvW+u7WknedY1KwYvbNrn+dYVyeNVaHqZzuUBfbqTlXfBJ/
	Tj5TE+uNqRiZq4FY65f/CZ7cFX/Sl+yPLSkVTJu5EtBwH6wobMz7oS9aP0zjv0s=
X-Gm-Gg: ASbGncvJccDpObh/w4B9Nqw1UFCztUnG07i1FfetxmJ739Ot++KH+hbN6TslS3u3wJh
	Rn23Besp3s4j0DZftcvJOioY+JM8r0PUhZLi3B/iZSr03CKJEriGKmfj/qa2cFVTbHN8vlMFFoX
	w+p/bu6z4RO+KQOAM9fWIXEMJ0HHvf4pMYU4ob+ZckHvaTeumnvGOmoWyuEIdB9CyUjTDjBIQui
	irKLr06hyoSuyQusgjb0r+FqzMS2Hn0ieHSsyUx+/103hlWSyqKEwUn4Jvi9GCeOSqlSxMWGzcq
	uq5ic2DD3DyaljogYkxfKrNVh6ymu8LAi0esEq1tIY2R6jV3hLtjdg==
X-Google-Smtp-Source: AGHT+IETxWtVPyIY7fJYRcwqnqDBdA3ddGHgl67zvBSSoa79y7HsEg5c/va5aTKA+O2h9SpvZDcVOQ==
X-Received: by 2002:a5d:64e7:0:b0:391:3f4f:a172 with SMTP id ffacd0b85a97d-3997f940e3fmr12824268f8f.49.1742904001825;
        Tue, 25 Mar 2025 05:00:01 -0700 (PDT)
Received: from [192.168.1.247] ([145.224.90.136])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d43fdac92sm199600525e9.26.2025.03.25.05.00.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Mar 2025 05:00:01 -0700 (PDT)
Message-ID: <47e8486c-7d7a-46cf-a4e1-9420a3be4357@linaro.org>
Date: Tue, 25 Mar 2025 12:00:00 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/7] coresight: Convert tag clear function to take a
 struct cs_access
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 Mike Leach <mike.leach@linaro.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, leo.yan@arm.com
References: <20250320-james-coresight-claim-tags-v3-0-d3145c153820@linaro.org>
 <20250320-james-coresight-claim-tags-v3-1-d3145c153820@linaro.org>
 <3bbf8aee-7b84-405a-8a3f-648c74196c2c@arm.com>
 <2d3fb704-172c-4632-9e95-02bbfb8c0f90@arm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <2d3fb704-172c-4632-9e95-02bbfb8c0f90@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 21/03/2025 12:42 pm, Suzuki K Poulose wrote:
> On 21/03/2025 11:02, Suzuki K Poulose wrote:
>> On 20/03/2025 14:34, James Clark wrote:
>>> The self hosted claim tag will be reset on device probe in a later
>>> commit. We'll want to do this before coresight_register() is called so
>>> won't have a coresight_device and have to use cs_access instead.
>>>
>>> Also make them public and create locked and unlocked versions for
>>> later use.
>>>
>>> These look functions look like they set the whole tags register as one
>>> value, but they only set and clear the self hosted bit using a SET/CLR
>>> bits mechanism so also rename the functions to reflect this better.
>>>
>>> Reviewed-by: Leo Yan <leo.yan@arm.com>
>>> Signed-off-by: James Clark <james.clark@linaro.org>
>>> ---
>>>   drivers/hwtracing/coresight/coresight-core.c | 27 +++++++++++++++++ 
>>> + +--------
>>>   include/linux/coresight.h                    |  3 ++-
>>>   2 files changed, 21 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/ 
>>> hwtracing/coresight/coresight-core.c
>>> index fb43ef6a3b1f..8471aefeac76 100644
>>> --- a/drivers/hwtracing/coresight/coresight-core.c
>>> +++ b/drivers/hwtracing/coresight/coresight-core.c
>>> @@ -144,19 +144,30 @@ static inline bool 
>>> coresight_is_claimed_any(struct coresight_device *csdev)
>>>       return coresight_read_claim_tags(csdev) != 0;
>>>   }
>>> -static inline void coresight_set_claim_tags(struct coresight_device 
>>> *csdev)
>>> +static inline void coresight_set_self_claim_tag(struct 
>>> coresight_device *csdev)
>>
>> nit: For consistency, this should be renamed to _unlocked ?
>>
> 
> minor nit on the subject;
> 
> s/cs_access/csdev_access/
> 
> Suzuki
> 
> 
>>
> 
> Rest looks fine to me

Fixed those two in v4, thanks.


