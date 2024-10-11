Return-Path: <linux-kernel+bounces-360829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FA3E99A04B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 11:41:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D6A7284D66
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 09:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C61720FA8E;
	Fri, 11 Oct 2024 09:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kK/SpNBV"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C1419413B
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 09:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728639695; cv=none; b=gHqP/9/aqyoCIVbUV1fEuiLk357WjSthaY5t+M+ut5jbk+z0HGT+SJUvV3s3/8oGuXwwN7QUpgzuUkYPebF4z1cbftOOubQl2uufnzvYK+1LX1/F0p9WMAE3LYIBmsaScMAgQlNVBJOm744JrYvXVy69wz7BQ5cuWLzHIl2uJY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728639695; c=relaxed/simple;
	bh=LB/cH7x2pzJ5VQbbrLYaY3EItf/Da6k4gcFzSYfv/e4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AyPdGh8GP4++tz2QPG72wsY2snbdAL0GpucVSp/FdffOwzmf+xSONPuVb429Di6o9ynPRFfRZTp3xXjJg9keGjEPZ0Iq/e6Jh/wL8IxHuR03PQZnd+Aw9VbhJ/nOTUn+CvwQPETZ0imCxKZJhkvNPrksx0WnNtWhnVR2OPtFG7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kK/SpNBV; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5c9428152c0so1577212a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 02:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728639692; x=1729244492; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eFkvV2tZLZ/lndmyybryC8gPmrkbcqQYe/2yy1vWRjI=;
        b=kK/SpNBVJL9rjb04xMzY1+kVp5QqktPjWtjYEeYfOSGsW62AeRQFzqKsM7CXWovk1E
         q4msfv76Svs9LBH+PnfKHB/V2xRt0Va0umQSgmEgw69+HVvpt9ktL2HyY9NvCrxRspS0
         JPScdQmsgGEccAMCDG6kJrcnjhERlkeBm5AjOP6+x8qSkemiJZygFXYFYsRxUVWzcseT
         LSDVkq/wZQOs4UkMsxtKch//izFEigmWkIw23p9Y9JUGz3oQsdwWY6kArN/d0IIEo24B
         DQWvu+xjOVBn0OnRt37oCjSUoI00Y7Lij60bXdJtn9jNzF2s67dNRVsXwDK0Fw1Dw+W8
         iQJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728639692; x=1729244492;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eFkvV2tZLZ/lndmyybryC8gPmrkbcqQYe/2yy1vWRjI=;
        b=DFKDXtVi4Q2e3Zo3M45jYG2gHYgoIIMZPHtlp8o+YdjLv2MRHuVBqfJ3BToMTjdUze
         H0bNGi8c5lJv+LcwW/aNK7uOsk/TN4xfv5mvjGYApcsSxzg4xXr0HvHwysriCUGhb4Mf
         vN/d3k6t53nGXxzWCqSLietIENrIKV/yl/hltLtUzZEIn9GAZb5sLyw6BF9yG/s1ZFHf
         bq0abAblOXi3W4qMEwyo8uBABN6/tSuTEMO4fmhnwCpuLxFzgAAyjee9KhRO5TTAvgyY
         MAqNcLPvhHgnZigbE7oIkcRU3UUJpHbuK8CMEHspnPimsCNrHtdsfebmR57tUPqJY+sM
         AORA==
X-Forwarded-Encrypted: i=1; AJvYcCUvbCTYv8nSntQlR+B5XIyazXo+ABk53vuRC/C9qpS/xHNlfdRBaf5tkTFQ6dQIv5pLBctccZCjrJJgXRY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfXsCJKA0udpjyHk6EEBKhAIfU0lDd9gSVEe/SNjEmt5LYNHSw
	KXYog4UNDiULlzuLZBOH8Qvza3vTC82JnGW60mpjubOJUVCuTnTMprVYXervNvk=
X-Google-Smtp-Source: AGHT+IHV0FWz8LaMOoLNl/WDkD1DXo5etIuNQysLEeSCJN2NProFBfMgBdzY2Dvu325k2nHOpuwjZw==
X-Received: by 2002:a17:907:e6df:b0:a8a:91d1:5262 with SMTP id a640c23a62f3a-a99b957fdd6mr177786666b.28.1728639691710;
        Fri, 11 Oct 2024 02:41:31 -0700 (PDT)
Received: from [192.168.0.40] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99a80c0723sm191604066b.135.2024.10.11.02.41.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Oct 2024 02:41:31 -0700 (PDT)
Message-ID: <d394fb33-2fe4-4a5a-b6fa-7f5598aede9b@linaro.org>
Date: Fri, 11 Oct 2024 10:41:30 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: camss NULL-deref on power on with 6.12-rc2
To: Johan Hovold <johan@kernel.org>, Robert Foss <rfoss@kernel.org>,
 Todor Tomov <todor.too@gmail.com>
Cc: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
 linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <Zwjw6XfVWcufMlqM@hovoldconsulting.com>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <Zwjw6XfVWcufMlqM@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/10/2024 10:33, Johan Hovold wrote:
> Hi,
> 
> This morning I hit the below NULL-deref in camss when booting a 6.12-rc2
> kernel on the Lenovo ThinkPad X13s.
> 
> I booted the same kernel another 50 times without hitting it again it so
> it may not be a regression, but simply an older, hard to hit bug.
> 
> Hopefully you can figure out what went wrong from just staring at the
> oops and code.
> 
> Johan
> 
> 
> [    5.657860] ov5675 24-0010: failed to get HW configuration: -517

So this caused it, I guess the sensor failed to power up.

You've booted 50 times in a row and hit a corner case where the sensor 
didn't power up leading to a NULL deference.

So, two bugs I'd say.

- What is the cirumcstance where the sensor doesn't power up
- What's the NULL either entity * or entity->pad I'd say.

<snip>
> [    6.594915] Call trace:
> [    6.594915]  camss_find_sensor+0x20/0x74 [qcom_camss]
Hmm, not sure looking at what we have.

                 pad = &entity->pads[0];
                 if (!(pad->flags & MEDIA_PAD_FL_SINK))
                         return NULL;

Is pad guaranteed after entity->pads[0] ?
We dereference it like its guaranteed.

Anyway thanks for the report, should be enough start digging.

---
bod

