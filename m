Return-Path: <linux-kernel+bounces-194739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C78EC8D4141
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 00:19:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78A671F23704
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 22:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CA42169ADC;
	Wed, 29 May 2024 22:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ABnQFjxs"
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405EE16133B
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 22:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717021192; cv=none; b=nm+5GsRkG1KcDXZiZ2m0oA7nGXMxtkHAhxB/HGiYc5J/0vMMBuMLLzQ3fz0CEcjHDjbLFL2qNYz7qHDzEwP9vCJrnQFnwG8QJEMUQ7rBtuoiFoB4lOWiKOm/MB6RW/WjcEiY/0GVERChK9RriInqp7NU+MjmusrDrs8okGIYirI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717021192; c=relaxed/simple;
	bh=73lBekzJ3/cpyPRD/n21KmDDVPuP2JH1OaIv63wgdjI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nzUNWcj2+FkWTeI5sKmKUiWD6WCsicnzL1ITtFaHKP1HRyxCWPSsSKG4g+wLiA2v9bgRY4N8Qbd8hPYNgfyWCXV6B7hK8MWtOojp9O//57INa8uYV2KeMCZK1o0pAV9ycTld0oC8wxhUAH5KA/LLdyLbkYlUs7JKDRq5muzIX28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ABnQFjxs; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-7e3b1981fe5so1257239f.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 15:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1717021189; x=1717625989; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mC4b6Il0GC2QVDL2/I1OYkGxzS6sqepYodC6YDu796A=;
        b=ABnQFjxsTOMgyhDzI/W+PBhdTXi0rZBT2nXfOZLYddp729WR4Q3JqJjkC/cTikjDl8
         +3Ybs+y8H0o2eYpovDp5x97mHhbuVxHdIi4eAGNPPLn0arlOJfsVetsv7fZ5FugwjUxH
         ECwroYaCSdIUo5D4Fiz0VmkoGsbBF5O85cxXg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717021189; x=1717625989;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mC4b6Il0GC2QVDL2/I1OYkGxzS6sqepYodC6YDu796A=;
        b=ao91ihqIqvia5emWFxbhYZbv9/PklUJjhRrmPsNzoz5TavaMKbzbza/Tk7gLPLed/S
         8wLGJuDOPDd0vvE2xDAOnSZkp1xFuDp7P0bnepYru2f/LU5DvuFONqLYxkzEPGCeBVm3
         aoCVXGE7b5bmto6T2bVeHm9v/+E+Bm6/GQvOjNMBB/u0od1FHqF3y3AoJ1QSGdo3ItAT
         /WPerUR4m8pbxQKqsVcdNXTo9tQD6kcpvRdxJkjMT6Gc2LfG+F4rKiF2GLRkZQ63bPN7
         NWUUjcCUsI9j8l2oghBy7EDYz9fUnUiz54v0/P2YIDS4Wys7UgA+b+S5pdkhPBUMG37M
         GMBw==
X-Gm-Message-State: AOJu0YxJpCi9cJNjsSr/hpwIAhJ24NeAGhSvbXunhxMSbiDwlLGmqxmS
	czRjqLPUFJbaRneTrQ59iMiPC4ydzoRX+n/7FkWvNjzCJtjm7xLZDPmd172fkuc=
X-Google-Smtp-Source: AGHT+IHkLiHSvg/KtR3lDXPP39vKvdxIInqwjcrMHdeIk4e1kiHq6u41EdK9U8AuM2KlTdWAHFCSVA==
X-Received: by 2002:a5d:961a:0:b0:7e1:7e15:6471 with SMTP id ca18e2360f4ac-7eaf5d698c8mr34483339f.1.1717021189367;
        Wed, 29 May 2024 15:19:49 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4b10cf31917sm1013611173.45.2024.05.29.15.19.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 May 2024 15:19:49 -0700 (PDT)
Message-ID: <2359b378-d664-4d63-bd64-f539ec8607ac@linuxfoundation.org>
Date: Wed, 29 May 2024 16:19:48 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: cachestat: Fix build warnings on ppc64
To: Michael Ellerman <mpe@ellerman.id.au>, linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 hannes@cmpxchg.org, nphamcs@gmail.com, Shuah Khan
 <skhan@linuxfoundation.org>, shuah <shuah@kernel.org>
References: <20240521030111.56568-1-mpe@ellerman.id.au>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240521030111.56568-1-mpe@ellerman.id.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/20/24 21:01, Michael Ellerman wrote:
> Fix warnings like:
>    test_cachestat.c: In function ‘print_cachestat’:
>    test_cachestat.c:30:38: warning: format ‘%llu’ expects argument of
>    type ‘long long unsigned int’, but argument 2 has type ‘__u64’ {aka
>    ‘long unsigned int’} [-Wformat=]
> 
> By switching to unsigned long long for u64 for ppc64 builds.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---
>   tools/testing/selftests/cachestat/test_cachestat.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/tools/testing/selftests/cachestat/test_cachestat.c b/tools/testing/selftests/cachestat/test_cachestat.c
> index b171fd53b004..632ab44737ec 100644
> --- a/tools/testing/selftests/cachestat/test_cachestat.c
> +++ b/tools/testing/selftests/cachestat/test_cachestat.c
> @@ -1,5 +1,6 @@
>   // SPDX-License-Identifier: GPL-2.0
>   #define _GNU_SOURCE
> +#define __SANE_USERSPACE_TYPES__ // Use ll64
>   
>   #include <stdio.h>
>   #include <stdbool.h>

Applied to linux-kselftest fixes for the next rc.

Michael, If you want to take this through, let me know, I can drop this.

thanks,
-- Shuah

