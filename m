Return-Path: <linux-kernel+bounces-342045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F61D988A02
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 20:19:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30ACAB20E3B
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 18:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8A2D1C1AA7;
	Fri, 27 Sep 2024 18:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eCmeasou"
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755F2174EFA
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 18:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727461164; cv=none; b=hgN1nZbcUtXq7pF1yuPO1fWXiJy4QDEHgBg4/j+U+A1wDyQy5/291QNr080QM34mCjHy3Mk11hwCrucFW0xDvz5avfP96HVRb9q0guhEgCNqugO5ea4Kyo7ibB0Mhfh5D2aMSHV/I4yX+UWrU7v0Tn1B2xV3gXsrjoeV5TncgiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727461164; c=relaxed/simple;
	bh=hPZsk+m6EUhm8EVvWXNN0vIGJHq194e4maM8ldpOdFo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IkmjqX8YYAfTkm4xXZW+O+/+6Am0FVFlCyzGxaTTLqyrmRicizoY/tgSmmVeuhDbpBNhbIilwHCuL/lsG/9ZPnvoKzeupIFcRcdU/3u/TgJh+IJpdMVCeEvnFbhqksODT1sPavOIL/6GMyCYjeFtYbejgZuv2k+X+FMrUfuAuXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eCmeasou; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-8349389f9b8so61460039f.0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 11:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1727461161; x=1728065961; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hQqrJujpydlp91BVmmyoPafshZVAFUzISmrTF6aV2rs=;
        b=eCmeasouQ/pLiZhA2wFpcUTd23fUUDMYyDr4Mha+38zK4Pkb1wqyuufCQ4jGO2atAL
         VTioT9Xa1seh7Y5ceVT+fcBsVr3QVO6sVD/Li5bDh/zZi9umUh2TtseFebQo+lozvlZC
         t7fvbSP9CZ+wfY+ctGJ8Jp2ictP3MBh/jUyhQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727461161; x=1728065961;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hQqrJujpydlp91BVmmyoPafshZVAFUzISmrTF6aV2rs=;
        b=q5q8DmrR4AE8tN8E78ZiFVBYILuMJee8SnJsP9LSbRek/1HumFxO46SZ2T3D9KDrvj
         nBBtUXwhVwkEqVZnFTj5EtYo1wNw7hBEskhjZ8wW43r/D/B/4FfdYvpa9pH6B+ke7EcB
         +G8AJotpFAnQgeRMTcw1y9B8rF2ojQYPY9oZOb/rZpJgq9suvBHy54u6Jcygxf2Gk0Q/
         L8MJyNlZq9gu44lM2plcweomV63C1OjYoLKmbbi9OpPjYxaemm05YW+EY0SCtfKY48yG
         cC8Dam2vNS3w1EHZKRZutmv+HrOhNtruBqMv0Gnz12y2S8EAtoQGBUxkXwtC3Bia4pB2
         RCrw==
X-Forwarded-Encrypted: i=1; AJvYcCUt0pcegQADZQ8gtC0GFhZWthF1D9ubOoMm4tQK/oLbL8rEemIAL/KIsBFuZy4EeG5ZbEg6EkjnF4csZxk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz41D5azAdi4U2BBfOJ+kJfwxdgpevxJ1cEfT1iug46Q4CZQZzN
	8MU/KG21x7aS3J9xkGT5QJBm5GGLSScgEBm9gAAdaAMBSDWdDW6HCOFOiwmzxgc=
X-Google-Smtp-Source: AGHT+IGNBttqWmrIjxtKnwZktpXPiai3iHlCQaFi1wD72Iy1t84sF9OeIz7FZLIg0q9kqHxFBLJo6Q==
X-Received: by 2002:a05:6602:2dd2:b0:82c:ee6d:a7ee with SMTP id ca18e2360f4ac-834931b193dmr396304239f.2.1727461161598;
        Fri, 27 Sep 2024 11:19:21 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4d8888c2f43sm607811173.113.2024.09.27.11.19.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Sep 2024 11:19:20 -0700 (PDT)
Message-ID: <c38d9510-3cd6-4c8c-be45-f6f15334878a@linuxfoundation.org>
Date: Fri, 27 Sep 2024 12:19:20 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: vDSO: align stack for O2-optimized memcpy
To: "Jason A. Donenfeld" <Jason@zx2c4.com>, christophe.leroy@csgroup.eu,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: kernel test robot <oliver.sang@intel.com>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <202409241558.98e13f6f-oliver.sang@intel.com>
 <20240924115001.916112-1-Jason@zx2c4.com> <ZvbqNZz547IGq7vy@zx2c4.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <ZvbqNZz547IGq7vy@zx2c4.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/27/24 11:24, Jason A. Donenfeld wrote:
> Hi Shuah,
> 
> On Tue, Sep 24, 2024 at 01:47:23PM +0200, Jason A. Donenfeld wrote:
>> When switching on -O2, gcc generates SSE2 instructions that assume a
>> 16-byte aligned stack, which the standalone test's start point wasn't
>> aligning. Fix this with the usual alignnent sequence.

I fixed this spelling when I apply. checkpatch is good at catching
these by the way.

>>
>> Fixes: ecb8bd70d51 ("selftests: vDSO: build tests with O2 optimization")
>> Reported-by: kernel test robot <oliver.sang@intel.com>
>> Closes: https://lore.kernel.org/oe-lkp/202409241558.98e13f6f-oliver.sang@intel.com
>> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
>   
> Just FYI, I'm expecting that this is a patch you take through your tree
> for 6.12, and hopefully before rc1, as automated testing is failing.
> 
> Jason

Okay. Thanks for letting me know.

I will try to send this up for rc1 if at all possible.

Applied to linux-kselftest next

thanks,
-- Shuah

