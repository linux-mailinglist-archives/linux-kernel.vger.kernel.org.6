Return-Path: <linux-kernel+bounces-433886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73B6D9E5E5A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 19:38:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 227D216BA12
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 18:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4835F22B8C5;
	Thu,  5 Dec 2024 18:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KwtyzGiO"
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B0122B8AC
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 18:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733423877; cv=none; b=HeRnNi0Ti7moKNrSVYHFQsgfgS87tDE8613Kx8U1lwIHwDskFMXAsoGY3/jQ4lnO9OiNFOC+RKn9nL8Mb1ZC9CzU+PZbfdHXCn2CsxGG+AXjxo7AgQqdDKKo/WK1/yeHbQs3qXmDnvmgaC1SpfVlJsgjgXwcwzkChK27jXSdkhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733423877; c=relaxed/simple;
	bh=vN3BWRw+eI3i/QzJldo2ZEVO3gIiBZxxYptlzxCGdeM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PcQjFpGBkfJiOA1g/hiGIaxqR5wRmIqsADfnplK/GFniZ8crtwBSHG0ntAeQPx+vUkPhnTuDW9pjco262lp7JemkcgIZ5rDICkkNfCasing1R3qQYwgbif12Gf/OLOc0tRaoMB2hyiWJZPpQJCebtetPJblSp4Owbo1f+MBsjAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KwtyzGiO; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-84192e4788dso38944439f.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 10:37:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1733423875; x=1734028675; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jyZhhKDY3E0EY6FDWGYO/ik4qxnDvdOzeYmBAuvuaY4=;
        b=KwtyzGiOzOzLyWzVEynEY/3eqBiVQ6GqRlwpTf1TCuVOhCwROxzJhMT3JIw/mGCin5
         E69NuxRNRFwe7pFxKVxtLrzqiZuP/Zlz76hM0m3wuynou8pot6BsUWZ5Lc+t5BTQfZnz
         AS/mLuurI4krJ46gjAnJqCqufL9vpGojr8A1E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733423875; x=1734028675;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jyZhhKDY3E0EY6FDWGYO/ik4qxnDvdOzeYmBAuvuaY4=;
        b=G6Dm1jtAI+LTjszutOaWlQfXOIszI9849Y2cnE9K4A5F8AVM2VfbKAGtHKwmdtSWnK
         RU0W5LAY718qe9VOo46VwUD8xyX5LU5CCFBCvVc9vEcXCXqIMfXvV6btTtBrBvHe3Qs4
         3lPRhFqKOX5kr+/9FiGUjcsKsl2nCSqxvL/sPICSK6C2qEb2tuSjVetuDZCdaoAr6RIT
         eNyecREP+9LXAgN0S45NTFXXgojo0xjrPEGp1tJfOa0BLJjBhc0x1hp7oLDEIgZwHEU+
         vOx7JzpUmRbQ7rPn79Lx4m8ffWn7iPdf6iN3wf6a7e3o4GQ3cKIn3N4q0OUDcbtRWUJG
         OFRA==
X-Forwarded-Encrypted: i=1; AJvYcCUWPUdJpfMl+shOBM6S/ocImGbQSwmODZP/acxaS4RU0O93mZGZWNdqugd313f6sy3/xJdtyR+tni7hTH8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQDihUch9R4VK4s6J99AF5HpVlw+vhFzLmkG1CrbMzRjX2ieWa
	Iu8/+TWwXPNxXGQmDiBzm5l6fowB2Hqo5FSMJduw02OsBS9uAcuKKZEwpCVF3YA=
X-Gm-Gg: ASbGncsiXmO6IKvpUc6+MNKnTLbET56ck0xZyHzTT38dZk6g17ky4yaq7wRnPZTk9PB
	XuIPHz07ldtvKCZwnkumy36NFPS9SZJG4GDarMT25AiYh5gurnvdQNHUUsyL6g9/6zYe1xUuxQj
	7/CPR9HgF8otjJuQKqNr+OV2+1sLo1nxVnUweQFME1n1XAqSBlk2DaNg1m/+pZKNu6d+KY2vvZg
	D24JAOF/ekp/zgmW2eivcjP1qy1RbhQa7LITMloXj4PUOJ3aIJLnf2S5HwLhA==
X-Google-Smtp-Source: AGHT+IGNp1BhKQFk7jXV5cSwne9kxOaVyjPT2p0T4mOEWWVHYoOi2qb9PiCzJIQMXrZY6vl8TtFCeA==
X-Received: by 2002:a05:6602:6b0f:b0:803:5e55:ecb2 with SMTP id ca18e2360f4ac-8447e0fc2b4mr59163639f.0.1733423875125;
        Thu, 05 Dec 2024 10:37:55 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e286108491sm405387173.30.2024.12.05.10.37.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Dec 2024 10:37:54 -0800 (PST)
Message-ID: <a0816bb6-fc78-433a-9cb4-7c16f06d3675@linuxfoundation.org>
Date: Thu, 5 Dec 2024 11:37:53 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] Modify the watchdog selftest for execution in
 non-interactive environments
To: Laura Nao <laura.nao@collabora.com>, shuah@kernel.org
Cc: kernel@collabora.com, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20241119150127.152830-1-laura.nao@collabora.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241119150127.152830-1-laura.nao@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/19/24 08:01, Laura Nao wrote:
> This series is a follow-up to v1[1], aimed at making the watchdog selftest
> more suitable for CI environments. Currently, in non-interactive setups,
> the watchdog kselftest can only run with oneshot parameters, preventing the
> testing of the WDIOC_KEEPALIVE ioctl since the ping loop is only
> interrupted by SIGINT.
> 
> The first patch adds a new -c option to limit the number of watchdog pings,
> allowing the test to be optionally finite. The second patch updates the
> test output to conform to KTAP.
> 
> The default behavior remains unchanged: without the -c option, the
> keep_alive() loop continues indefinitely until interrupted by SIGINT.
> 
> [1] https://lore.kernel.org/all/20240506111359.224579-1-laura.nao@collabora.com/
> 
> Changes in v2:
> - The keep_alive() loop remains infinite by default
> - Introduced keep_alive_res variable to track the WDIOC_KEEPALIVE ioctl return code for user reporting
> 
> Laura Nao (2):
>    selftests/watchdog: add -c option to limit the ping loop
>    selftests/watchdog: convert the test output to KTAP format

I think we discussed this conversion before and I still don't see
the need for this especially this patch converts every single
print() into ktap which isn't necessary.

> 
>   .../selftests/watchdog/watchdog-test.c        | 169 +++++++++++-------
>   1 file changed, 103 insertions(+), 66 deletions(-)
> 

These don't apply on 6.13 or 6.12 - rebase and resend after
making changes to address comments on individual patches.

thanks,
-- Shuah

