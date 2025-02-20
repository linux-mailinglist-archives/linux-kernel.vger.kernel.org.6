Return-Path: <linux-kernel+bounces-524409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 219FEA3E2A2
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 18:37:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48AD818958B7
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 17:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B43A212D97;
	Thu, 20 Feb 2025 17:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="B86QtlY5"
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77EF20DD47
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 17:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740073056; cv=none; b=QxIna7KqVty4RcGkVWDL4w6rlq/56JMQKiwn1BtbHF9g5PIKojvY6HF7Cm9mo4u8ljawTu3tDY5q1j48+Vj/w9ylDK0fkMwGEYx8k1RXD+GSgawAsj0Gctj2r0GWWrFobpmOhSbcqLMWrZbzBKdvdeVO2jNtjHAFYduekHd28/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740073056; c=relaxed/simple;
	bh=7OqtMzzZ4TQXY1qO181+yuG56Lm6incgS9Z9e/8VJgA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aBJZhEpD4MBh5Qp/6AlKZ3wfV+sTvGBhnys53W1VbxVQAtRLRF0xoWQfzVz8/LFGT0WGx40jOtTMMfXqi5HR7bcK0o0fBKShHGnktE7+hjETuuSR2pCQh3BBKqLJYZBPwVaKLWvEDqlFLx+IobHKt6qi104vp5RYMdJR/zi5uCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=B86QtlY5; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3d2a869d016so3141465ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 09:37:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1740073053; x=1740677853; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lnhaKkAMNEE9ZP4VliJW7pWKwvVo6cP4lX15YihDuIs=;
        b=B86QtlY5Y8HHjqN7QiRbFNL3KyXD3rkQkmXLVUO2n9Q8WLuvyLijkmNN3PQNMPfL3i
         MzIfK4WFE+GnpdV8Z7q/qvet3KZmlHgLSxPUUxdZt3A3AL3hfx2wj1vCSgY4wLHOM+ts
         zK18urVlo2esvZYiOWdavZRNehOr3cjI9GU+I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740073053; x=1740677853;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lnhaKkAMNEE9ZP4VliJW7pWKwvVo6cP4lX15YihDuIs=;
        b=qgDM2B9TjYPW/x9oFueba1P057638lgHjGNaNlVFbuGpWtfn85oAV8Q2SC6rGSr87X
         rPai6A31O3ZCCqOR0k8vaCF2po/FZ9rD5JmCvcq3HjoV0caaXEiNUIbkkJOaAMIAZN23
         f+ZsUYe6KiisOkzazsTpLS/8iJqRDoOZLB3kWve1p3m7dcs8b54DggrSJ7BmkVVQFxpU
         vRInlJI7ErTz26UYl7Kw5a1r1Gi8m3tmMYpDQAifEpXWIN7I3zTsw1WaOETGJWV5OfvO
         8+UdhELyJASoaLD2cC9zXEw64YZ2y9SXVk0UR2ZXJEjkv3nKBPZJ6MS9mLA0CvZvR972
         Wthg==
X-Forwarded-Encrypted: i=1; AJvYcCVoUCRRjDgpxhsDBzdF2PuwL9Yk2RIUPrPFlVRovZpqcbXJav6XJsP/OH5u5xCOmpdy1ZluQUchF/5Isqs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0yzvPbJULI0o7SdAi0BbomfHigeOCL0ekU0rVpk1GrcECQ9XQ
	J5ffL7l8UM8U0WSZos+OqH3dSs6GgrlUA+MFGc1Q2XmFWDo5f9UbyCqBhJp6lGY=
X-Gm-Gg: ASbGnctQqCHEinGC49JrqAqKNaGKTJ6fB2ElYqrmXj//wzXK/02UAA0UVuTjcd5m5Iu
	sQLL+aSVRWEbRbkfTqmDdaamD0FRu1AA3tmEygtizhBBLFFEkF48P1MwhxDFK5eXGqFZBqPKidK
	545gxXp/ZUYv2+pDaDecsCY2hSV59NiT8y60EHL42gnQ5xW7zKTX56Tw1xp/dJIg4hnxtWX6DqD
	s3P6BnAzvuff56GJXrJWqNkd3MR5z/uWD7k+iLBhBg4V1riGUFvUK9+3m8DZaPOVGLvVquf02QW
	wQJsGdzX2gRfgKotvfAFOx8Aow==
X-Google-Smtp-Source: AGHT+IEQDhWjRFdUbWy0dkLYBALEN/O88UerdzmcLg7I0kpse9O0b+B4HUdXcLsKRY2NrU2uQGNx8g==
X-Received: by 2002:a05:6e02:1948:b0:3d2:6768:c4fa with SMTP id e9e14a558f8ab-3d2b538c333mr102737215ab.21.1740073052986;
        Thu, 20 Feb 2025 09:37:32 -0800 (PST)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4eea13a1acfsm1816750173.109.2025.02.20.09.37.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2025 09:37:32 -0800 (PST)
Message-ID: <929c1d63-e3e7-432c-b34a-8953662297ab@linuxfoundation.org>
Date: Thu, 20 Feb 2025 10:37:31 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] cpupower: monitor: Exit with error status if execvp()
 fail
To: Yiwei Lin <s921975628@gmail.com>, trenn@suse.com, shuah@kernel.org
Cc: jwyatt@redhat.com, jkacur@redhat.com, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20250220163846.2765-1-s921975628@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250220163846.2765-1-s921975628@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/20/25 09:38, Yiwei Lin wrote:
> In the case that we give a invalid command to idle_monitor for
> monitoring, the execvp() will fail and thus go to the next line.
> As a result, we'll see two differnt monitoring output. For
> example, running `cpupower monitor -i 5 invalidcmd` which `invalidcmd`
> is not executable.
> 
> ---

Note that everything below this gets thrown away.

> V3:
> - Modify output message content
> 
> V2:
> - Check return value from execvp and print message for invalid command
> ---

These version information goes after the --- below the Signed-off-by

Note that everything below the

> 
> Signed-off-by: Yiwei Lin <s921975628@gmail.com>
> ---

This where the patch version stuff goes. I fixed this for now.

thanks,
-- Shuah

