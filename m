Return-Path: <linux-kernel+bounces-232862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 450AD91AF37
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 20:41:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C49DAB220AD
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 18:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 090E319AD54;
	Thu, 27 Jun 2024 18:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="f/Z/TI4w"
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 972A013C3D7
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 18:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719513701; cv=none; b=VJxOkH9JHmj4wsPmSBingxYZEKkd+UMC1bXc6o+PsxzXw33xNr5fAgG+sEGRGxvd5dVOhFGdV07JpSF3U1y/7IoxZSKxxGt2E1PGE++GtNBK3+/oEidkCVUCpTNif36AlDqjcqPBbKoYZ0f5YzSNdOasmQpGI6pSdN/2CMudvrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719513701; c=relaxed/simple;
	bh=125TjForjEqo3vPkjAAt5+UZ3IBFofOTgy6dpGc67Gg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G80k36q9kmgc2Dk/NXgGZmbw3ZpTsESq8++pnYRDg6X/oBvlZ+N8FxpXsXPdC52tV4PFb7tPoJMoKUeNMdJKCH9nMEj32Byd8ek4rI151vdnLiA/szevrjbaHUQzKDwSXIroKmOqaOthvfZEnNbnA7PgvHKJqwtlWQClkX8s9Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=f/Z/TI4w; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3762c172d94so3737025ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 11:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1719513698; x=1720118498; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mBZrzd3l+QBB0qVF57NE+VuAbUtWDCM7+bdK0dPzz00=;
        b=f/Z/TI4wIdltGwSKSfbKe2Gsv+6dMwvL0M/xZ+ghUjTMcRiRcy3gdz9Pq6BA+IXpU5
         SSFPg3B6xnMNrXlMFXjJ/jzDcVLrfnzm4Y19LW99atwGakmzfD/dj1jgedghQfbz6Lbb
         6jlWomI088L/sHt0hDnCr+yWZXSNX07gAdtf8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719513698; x=1720118498;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mBZrzd3l+QBB0qVF57NE+VuAbUtWDCM7+bdK0dPzz00=;
        b=uMauuCjN1RgEQetWPkzuaDW2QSC2YhMtYE4zTEC8bqj9JwS/HtSqQkiqcx/pHubTsw
         If0EIcqXSkXOHp5z6jG7Tn8gPF9wrGmObXYXif878p3U8MoNURvcG5yIIIrCQpg5ajMp
         qXaJ5DARDMuPaEEtNEaChaWR1hNY6jjj1nLB/t5MMrCYXMX8Ljp7rEfuklp6IpGomXfb
         9FgtSRC6TkHfRRh/GTxuFlzFYg0c5uXz9PgFIUH2ChV5F3gbBnnMR0S7GA6okds/rJbU
         sfpOFKcxKjsYy0O04MUPxW1tLkewZ4a5orx8ysPkaL0gc+BqbVgPvi3Q+olmFjgcQeYO
         Al5A==
X-Forwarded-Encrypted: i=1; AJvYcCUL+Rv/NC1mvv+BptZOuK/ONftJsZy8c39cY7Fj9f17llH0a+qNJ1GuYWy6pUGvcjJp3JD0nFwTBHkDmcusiaV+HmQIUCAPGMV1aH+s
X-Gm-Message-State: AOJu0YxJyi/F/V7p7QXev2skyV99aUjbWzbuti7u/Qd8dU0j+ubVQd6u
	ygKW2tJ2vsZeZAXm0J4BvX54KczIlNaiUVlp4/CnXqF3l+KKNQ3iAhSedJfnAQ0=
X-Google-Smtp-Source: AGHT+IGlpypgBxWhaGGhaei1invqkWl/nU5w0Ksc4S6KUTcLPJ4fg2XtI2N2zdxQFFpO/N8qypPFWw==
X-Received: by 2002:a05:6e02:15ca:b0:376:4224:7611 with SMTP id e9e14a558f8ab-376422477a7mr156049795ab.3.1719513698699;
        Thu, 27 Jun 2024 11:41:38 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-37ad4370d30sm272315ab.65.2024.06.27.11.41.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jun 2024 11:41:37 -0700 (PDT)
Message-ID: <8facf491-3c4c-4efb-8a14-f34011ffe011@linuxfoundation.org>
Date: Thu, 27 Jun 2024 12:41:37 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] selftests/watchdog: convert the test output to KTAP
 format
To: Laura Nao <laura.nao@collabora.com>, shuah@kernel.org
Cc: kernel@collabora.com, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20240506111359.224579-1-laura.nao@collabora.com>
 <20240506111359.224579-3-laura.nao@collabora.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240506111359.224579-3-laura.nao@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/6/24 05:13, Laura Nao wrote:
> Modify the script output to conform to the KTAP format standard. The

What is script here?

> number of tests executed is determined by the script arguments, and
> options such as -c, -f, -h, -i, and -p do not impact the total test
> count.
> 
> No functional change is intended.

There are functional changes - keep_alive() coupled with changes
tailored by a script that isn't in the kernel code which isn't
ideal.

Why not inlcude the script in this patch series to make it part
of the kernel?

> 
> Signed-off-by: Laura Nao <laura.nao@collabora.com>
> ---
>   .../selftests/watchdog/watchdog-test.c        | 154 ++++++++++--------
>   1 file changed, 89 insertions(+), 65 deletions(-)
> 
> diff --git a/tools/testing/selftests/watchdog/watchdog-test.c b/tools/testing/selftests/watchdog/watchdog-test.c
> index 786cc5a26206..90f32de9e194 100644
> --- a/tools/testing/selftests/watchdog/watchdog-test.c
> +++ b/tools/testing/selftests/watchdog/watchdog-test.c
> @@ -22,6 +22,7 @@
>   #include <sys/ioctl.h>
>   #include <linux/types.h>
>   #include <linux/watchdog.h>
> +#include "../kselftest.h"
>   
>   #define DEFAULT_PING_RATE	1
>   #define DEFAULT_PING_COUNT	5
> @@ -29,6 +30,7 @@
>   int fd;
>   const char v = 'V';
>   static const char sopts[] = "bdehp:c:st:Tn:NLf:i";
> +static const char topts[] = "bdeLn:Nst:T";
>   static const struct option lopts[] = {
>   	{"bootstatus",          no_argument, NULL, 'b'},
>   	{"disable",             no_argument, NULL, 'd'},
> @@ -52,7 +54,7 @@ static const struct option lopts[] = {
>    * the PC Watchdog card to reset its internal timer so it doesn't trigger
>    * a computer reset.
>    */
> -static void keep_alive(void)
> +static int keep_alive(void)
>   {
>   	int dummy;
>   	int ret;
> @@ -60,6 +62,8 @@ static void keep_alive(void)
>   	ret = ioctl(fd, WDIOC_KEEPALIVE, &dummy);
>   	if (!ret)
>   		printf(".");
> +
> +	return ret;
>   }

Are these changes driven by the script that isn't in the kernel code?
I don't want to see changes to keep_alive() bevator.

thanks,
-- Shuah


