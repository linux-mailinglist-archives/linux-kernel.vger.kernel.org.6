Return-Path: <linux-kernel+bounces-234068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ECB091C1B2
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 16:53:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFEA81C21192
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 14:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A2131C0DDB;
	Fri, 28 Jun 2024 14:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Kk0GUHi/"
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D061BF31A
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 14:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719586401; cv=none; b=GRZXt9PZQCSx52LSLrmI3I0QkdTkPJo3Dv8StOfYEXqAzY2jZALEuCMK/dCicoT/U2UTr0C2U5TNVXnpNmCcZZrShgJxlznAZJVqNmREXvxnZBZH407DaDVfCFQcCfVZR8ylg0jUcTvlJv+A/l7juzLw+PbTQEzIHE7w+TIK+S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719586401; c=relaxed/simple;
	bh=1dB7UHPbYnujscVYEmFnttW++598Qv9F86Hsiobx4UA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=pREYhKMAieQ8kODLV+Ih68FQkNUq+BhBrKMq0EW6pLHfGW2tcKPjUjhGsq3BZ8S33schKxa7qktUuqu9QGgYc4wZCKe1ESUf55ugTjNGBK86dyACvJEqOAgemzdJMhuobejWB9b6Fa3+uyxem68YlMXtm7/oj8CyjU5R3ns5zYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Kk0GUHi/; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-7f608ed30e9so1302639f.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 07:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1719586398; x=1720191198; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Vdbljrs/1ZCLZYC6oYgGWzonLEN9hffCNj85tHnM168=;
        b=Kk0GUHi/dazzrbbGKS7t37CGgrm19xmqijlxsnOjZMcH6LcgQ1IoDsjWqTKxki3yIt
         m6a8FOmXrghboJDadGxeH7iXqLuEmpt1W5TbERv1JadDi7XWFTaEUrK0cuu9AnAyyVGr
         HPUUe1QT+F0n8q7j1IdhszTKssJLV7BKrlaL0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719586398; x=1720191198;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vdbljrs/1ZCLZYC6oYgGWzonLEN9hffCNj85tHnM168=;
        b=xAgRh87R88xBqcqzEVEs+Y7yBBOxy9/kpKyKccfZ0cd+n7fS/4YNeVGZCiKWTEqNej
         soXkqfnScWKlTx4lxyNhLj8iFhpYSQCz8RIGc+uvwqlRxabl1JUzbW2BiLji1j/ecdsD
         x6Y1t3Z+gkHNcfgtXGvrFXW4Fgu4lqG32IXp+rPkYDqLdVtwF18rhFhnm4LAskbCHPRw
         4BADohV8iVkWFhFMFMpkiRoU7c9FHtKxjK4s8IYk/KMwD9D2NrtC+It++aads4yqmO4q
         4JEwJqgp5OXBXm9E9yXVgviGYriU0ZZ3gCPJCxf10uoWlbyroEGExm85+ZLIagYamhR4
         eZtQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZhoNNn1LXpYEJvR6T7KAr7VwZuL2uGY9cwx4Dykzp3JJYBHMr/e2s1Gegdq6Zvrm8HudnUGX9zyKEo/VnuXAawJCeg/0I7r9pv7m8
X-Gm-Message-State: AOJu0Yx0tofKLMZ3GYQpnHjdnfQ7e5hWxzFb+Zld5Ra7MNgpczsIJ0G1
	IpmpLPOW8eAClyRHEiKX5kXhATO4qD7BSFThKqfP3He53PH7UeK3PMzkiMToKlI=
X-Google-Smtp-Source: AGHT+IEY9qxTGt1t7su4b1INqVFoK33N+IUogITcmKIEi5eGoA1p6/abyJH1K7FUxOQ2lxxpHZjWKA==
X-Received: by 2002:a5d:994f:0:b0:7f3:b778:6966 with SMTP id ca18e2360f4ac-7f3b7786c2amr1400474839f.2.1719586397706;
        Fri, 28 Jun 2024 07:53:17 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4bb742b9974sm553122173.137.2024.06.28.07.53.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jun 2024 07:53:17 -0700 (PDT)
Message-ID: <ba4d74fd-6762-4e9d-8346-5f3384cb60ce@linuxfoundation.org>
Date: Fri, 28 Jun 2024 08:53:16 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] Signed-off-by: Daniel Hejduk
 <danielhejduk@disroot.org>
To: Daniel Hejduk <danielhejduk@disroot.org>, shuah@kernel.org,
 trenn@suse.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240627135437.2301-1-danielhejduk@disroot.org>
 <20240628092508.3664-2-danielhejduk@disroot.org>
Content-Language: en-US
Cc: Shuah Khan <skhan@linuxfoundation.org>
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240628092508.3664-2-danielhejduk@disroot.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/28/24 03:25, Daniel Hejduk wrote:
> Updating maintainer of the translation.
> 
> Last update to the po file is 5 years old. I will try to complete and
> maintain the translation.
> ---
>   tools/power/cpupower/po/cs.mo | Bin 0 -> 12805 bytes
>   tools/power/cpupower/po/cs.po |   6 +++---
>   2 files changed, 3 insertions(+), 3 deletions(-)
>   create mode 100644 tools/power/cpupower/po/cs.mo

There are multiple things to fix with this patch series.

1. Missing cover letter
2. Binary file included in the patch
3. Subject line doesn't include cpupower. See the format below
    cpupower: -----
4. Change logs are missing are inadquate.
5. Missing version information - this is v2 series

Refer to submitting patches documents in the kernel docs.

Please fix all these problems and resend patches.

thanks,
-- Shuah

