Return-Path: <linux-kernel+bounces-440013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C926B9EB780
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 18:10:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C9B628283D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 17:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 061A4234975;
	Tue, 10 Dec 2024 17:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IwHNyNAK"
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D0A2343D8
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 17:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733850604; cv=none; b=akPHIqPwoMRTDDeJ6Gm44cmP6zopv6hKPVSpHV4EHsv47OJ2Qol9EiCE0lXp+jl1wPqsS9YRoJIZDVDjlA4j91V1OxGDscI0+kpLC8WwB2tX0rcSzYaORZ4nXrTo6Hexxbcf8154Iu+D0U9+Da2ofvISdbFcyDOvXUkO7gW9ZPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733850604; c=relaxed/simple;
	bh=n7TX/KGVtqtN/arIkiCvvxqUxQBAA9t8KQHNkd+Kzi0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lpo9Y3141iehUWF1wEzd1AAnOrTRHUPBGyNy279V660XZPqlCgTL1LKq5udI2JUFxeJu57GU+6d2RW1TiLf3RF3OH10IbHwdT+AGkP8hxXx1Br4QTlVeqQqBf5MgUx4HHselRtDZK4eXIHDW8grruCZdT1ytP+udvPjgIaFOdQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IwHNyNAK; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3a777958043so24195085ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 09:10:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1733850602; x=1734455402; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OVkYBvw17/WfzayXGy8io1dx1e/dJ//f+G5krTuVRXY=;
        b=IwHNyNAKw68QUf7Y0dFtF1InMFyKaTCi3KU33mGsaZKENYtNPlEtyNL6ga/L08Xceh
         5JyU9aI/98SF39V5N55km2KkQfcjwREpQtfR0AJO9jtWanv68DVFOskl2bgj85KZuWb4
         EcWVshIFBqCM4NQxYbKM/EYGhJPErXQ7CZqzk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733850602; x=1734455402;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OVkYBvw17/WfzayXGy8io1dx1e/dJ//f+G5krTuVRXY=;
        b=QhtzGStqOeAnRw8IW+gvuzc1fjcRtRRU0J52regnrGmdIRite8ieIoJfsX7wgxUfFL
         YFsFsw0U2tZ5SsFlJsfk1XqCcVeoOSJt4xwu7Q7cXiHVmRGQvwQIxl1zTc0klrIvadZZ
         N9sN06OdxJsPcQsTcpDKzuukxp1/DJFoU1t+lnYniNhzemR26YYzfvq+yGl1w25sO/1s
         pSqMAng/4QtYAHsaVjAugsCfP9Wf6D8qsWZcWgJIuKPIqEq8Xt7tas80rUl9Dp9vYJTa
         NrjkOhnxQ1GRyYynJ9ehXR4yBfaLaURE3CdEIcetkjEl+8QmiZcngWo6HPmD5POuFV7m
         7yeQ==
X-Forwarded-Encrypted: i=1; AJvYcCUS7aJDKhILyRzqkcb89IvMYHDPzDzn7Yo3L/ydOCtqFKZpUjNq6IchkaIu5aOzG6QmeUsZz62lw3fHRKE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiV0T7ajRMmpacHkic+zuNZhaV9908a9ySrvxMXXw8O93lkeld
	08J4GZ5ZJqc3ZRzFM0+OohBMkNbc0dAJvq60F0WXFv2RyafobC6zTsyCXwK6u0Bl5QEcJW01vKr
	V
X-Gm-Gg: ASbGncsj0qOFfFDbOoPYioBaiazwLNxHbKBGz4/0fVskAIxj9sxJwzaquR1JRa0JTz+
	XDkYohfxbxf4kydE2yZxBfrdHcHv+27EN7stI6Q3qciCzavcvsgvq6fppNa9cmddZokJJ2KcvkI
	YOLMWHMplZ5ehHhIo6xQ54K4gRaX8d8zPkUTtj33bIJ5+eA5Rd+cOYuC9ru/HP0yCyBe4ezd45N
	iYRlDaiWvU+mnAqgoKR4bVerPurQ7iEw4YhdXiwWV4NVwwn/xjlu1By5r5cW039/g==
X-Google-Smtp-Source: AGHT+IEzIMlDQqNqHqbv8i4VSsCEok3zEc7VgJmYt6flLbyLvhHrDbMWrBxSWujOoiWgdpiR6ADVtQ==
X-Received: by 2002:a05:6e02:2199:b0:3a7:80ff:4a6e with SMTP id e9e14a558f8ab-3a811d9c055mr127020545ab.11.1733850601829;
        Tue, 10 Dec 2024 09:10:01 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e2bff662b7sm1136449173.103.2024.12.10.09.10.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2024 09:10:01 -0800 (PST)
Message-ID: <57d11b05-d2ac-4fb3-beb2-cd1f45b38596@linuxfoundation.org>
Date: Tue, 10 Dec 2024 10:10:00 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-next v3] selftests/filesystems: Add missing gitignore
 file
To: Li Zhijian <lizhijian@fujitsu.com>, linux-kselftest@vger.kernel.org
Cc: shuah@kernel.org, linux-kernel@vger.kernel.org,
 Christian Brauner <brauner@kernel.org>, Miklos Szeredi
 <mszeredi@redhat.com>, Josef Bacik <josef@toxicpanda.com>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241122073725.1531483-1-lizhijian@fujitsu.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241122073725.1531483-1-lizhijian@fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/22/24 00:37, Li Zhijian wrote:
> Compiled binary files should be added to .gitignore
> 
> 'git status' complains:
> Untracked files:
> (use "git add <file>..." to include in what will be committed)
>       filesystems/statmount/statmount_test_ns
> 
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Miklos Szeredi <mszeredi@redhat.com>
> Cc: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> ---
> Hello,
> Cover letter is here.
> 
> This patch set aims to make 'git status' clear after 'make' and 'make
> run_tests' for kselftests.
> ---
> V3:
>    sorted the ignored files
> V2:
>     split as a separate patch from a small one [0]
>     [0] https://lore.kernel.org/linux-kselftest/20241015010817.453539-1-lizhijian@fujitsu.com/
> 
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> ---
>   tools/testing/selftests/filesystems/statmount/.gitignore | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/tools/testing/selftests/filesystems/statmount/.gitignore b/tools/testing/selftests/filesystems/statmount/.gitignore
> index 82a4846cbc4b..973363ad66a2 100644
> --- a/tools/testing/selftests/filesystems/statmount/.gitignore
> +++ b/tools/testing/selftests/filesystems/statmount/.gitignore
> @@ -1,2 +1,3 @@
>   # SPDX-License-Identifier: GPL-2.0-only
> +statmount_test_ns
>   /*_test
'
I am seeing duplicate signature warning on this patch. Please
fix and send a correct patch.

thanks,
-- Shuah

