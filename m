Return-Path: <linux-kernel+bounces-232869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32DEF91AF4B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 20:48:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB507281BE3
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 18:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B47711CAB7;
	Thu, 27 Jun 2024 18:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="egTH2n1F"
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A87062139D6
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 18:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719514113; cv=none; b=S+j2HbI2K4H6xIhgvfExvQ++oTopjOyjjt2wPsGBKi7LriFusL3gFYujs5+t+UIZLj8QjfAYAYZxj5J0SCcB1OKuwzPGG2QKyfQ2MGUyuahDcTjJ9UukwPODSCcr2nL2itz/LonXFpR0+l3GmsUmRPuKxHPtUz22DFiRJYVAm4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719514113; c=relaxed/simple;
	bh=Ps21LGDi7ixqkIHatAKXL0KCeKFRlwvVz2dx/nKAiQk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h/D3I6spoioJ8xPGT1eKMpGOekq1rIa05Grto04usddTkBZYoBMiqOsfE2tf5x9FtTrPizt+3ARw+i0MhwkF58fyOeDn95bukIsYcPNrDOAl4y6RX6x1LqE/DjmixJP+zcHB3xOwktii/b8Gi27YZwg7bJ68o8dDbYpqcXTBSVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=egTH2n1F; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-7f59854ace1so4320839f.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 11:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1719514110; x=1720118910; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/k1qLy1qLFza2dxpYxxzrSbgR45GguPq4RoinXUVzS4=;
        b=egTH2n1FYRG1Uwq9rIK85CBUEom7ad5XjwqkTuqc7KxuU3phlDdzZGUbEYcEKczqVs
         3ZBOZNLPHo08+OCc8G9ZHZH/bXM10MQTOuiU/5Hs+mKxMg/jnu6Jjv07EidHY8/76qC+
         nI2Z9xMMWhpP/UgeAyt8rwff1tl+TaqSTb0g8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719514110; x=1720118910;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/k1qLy1qLFza2dxpYxxzrSbgR45GguPq4RoinXUVzS4=;
        b=HylWJ6n/Wmv0ZF65gjOTJOhztPbCheNqg2HciDaJK+DdCMjhIIiMoeCJr59xK3v8TT
         LIR7B0coCd2NcVfvNPV7QgpPpIlKTJo/VBt9aHe6wdKJmT7rcvLGLNwag8WgpKXoXSKw
         UJAaT4TYcVzLoquZNPsmS/xj8RF5sX3iTJnDGnnPtbdhHsojbfMa/0nqAqERmQ/zNnVk
         5abTWQu5IZVRFYMEyMHvyh4EpTkEmKKLg0Hfifx6jYzUXxPSN9oPcLVSv6Lplbb5/NML
         DKCcUYJ31/djWNeuowfYCS5Sga0wQc4PYxXDOT5HwE0NFL7ox3VpmGqNfHprEaOKs/Xj
         pO4w==
X-Forwarded-Encrypted: i=1; AJvYcCVxd03aZrNDQ3Ct9/L1jiAVh7C++CKfhc51Koixpr43F6IKj5h4YsbOLCcRqJIiOy3J6duOCUiAI4lQ7ha0Dl7TKGClI0VVWKEwv+yH
X-Gm-Message-State: AOJu0YzhW/l7TaSiLqOgQD9eBv0lc1hdUXE4dj5EJpBZxeRoGFqUDVSd
	fmt53K8ffquNeylublzOVHDc3cyB/wcHdrpslhiGQ/o7joUbFYOpoGDtY6T6urg=
X-Google-Smtp-Source: AGHT+IEXG1NlFSUMjyKzcvcn1MBWxw1iTxL8TaTCUpow4wkmryMvMpGJvH2Mf5GCIPBykhEecXGduA==
X-Received: by 2002:a5d:984e:0:b0:7f3:9dd3:15bf with SMTP id ca18e2360f4ac-7f39dd317famr1358316739f.0.1719514109876;
        Thu, 27 Jun 2024 11:48:29 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4bb742bc2d8sm62323173.144.2024.06.27.11.48.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jun 2024 11:48:29 -0700 (PDT)
Message-ID: <818d06c2-c5d6-4559-a8c9-9bf9e21c30f6@linuxfoundation.org>
Date: Thu, 27 Jun 2024 12:48:28 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] selftests/watchdog: limit ping loop and allow
 configuring the number of pings
To: Laura Nao <laura.nao@collabora.com>, shuah@kernel.org
Cc: kernel@collabora.com, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20240506111359.224579-1-laura.nao@collabora.com>
 <20240506111359.224579-2-laura.nao@collabora.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240506111359.224579-2-laura.nao@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/6/24 05:13, Laura Nao wrote:
> In order to run the watchdog selftest with the kselftest runner, the
> loop responsible for pinging the watchdog should be finite. This
> change limits the loop to 5 iterations by default and introduces a new
> '-c' option to adjust the number of pings as needed.

This patch makes the test run finite in all cases changing the bevavior
to run it forever?
> 
> Signed-off-by: Laura Nao <laura.nao@collabora.com>
> ---
>   tools/testing/selftests/watchdog/watchdog-test.c | 16 ++++++++++++++--
>   1 file changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/watchdog/watchdog-test.c b/tools/testing/selftests/watchdog/watchdog-test.c
> index bc71cbca0dde..786cc5a26206 100644
> --- a/tools/testing/selftests/watchdog/watchdog-test.c
> +++ b/tools/testing/selftests/watchdog/watchdog-test.c
> @@ -24,16 +24,18 @@
>   #include <linux/watchdog.h>
>   
>   #define DEFAULT_PING_RATE	1
> +#define DEFAULT_PING_COUNT	5
>   
>   int fd;
>   const char v = 'V';
> -static const char sopts[] = "bdehp:st:Tn:NLf:i";
> +static const char sopts[] = "bdehp:c:st:Tn:NLf:i";
>   static const struct option lopts[] = {
>   	{"bootstatus",          no_argument, NULL, 'b'},
>   	{"disable",             no_argument, NULL, 'd'},
>   	{"enable",              no_argument, NULL, 'e'},
>   	{"help",                no_argument, NULL, 'h'},
>   	{"pingrate",      required_argument, NULL, 'p'},
> +	{"pingcount",     required_argument, NULL, 'c'},
>   	{"status",              no_argument, NULL, 's'},
>   	{"timeout",       required_argument, NULL, 't'},
>   	{"gettimeout",          no_argument, NULL, 'T'},
> @@ -90,6 +92,8 @@ static void usage(char *progname)
>   	printf(" -h, --help\t\tPrint the help message\n");
>   	printf(" -p, --pingrate=P\tSet ping rate to P seconds (default %d)\n",
>   	       DEFAULT_PING_RATE);
> +	printf(" -c, --pingcount=C\tSet number of pings to C (default %d)\n",
> +	       DEFAULT_PING_COUNT);
>   	printf(" -t, --timeout=T\tSet timeout to T seconds\n");
>   	printf(" -T, --gettimeout\tGet the timeout\n");
>   	printf(" -n, --pretimeout=T\tSet the pretimeout to T seconds\n");
> @@ -172,6 +176,7 @@ int main(int argc, char *argv[])
>   {
>   	int flags;
>   	unsigned int ping_rate = DEFAULT_PING_RATE;
> +	unsigned int ping_count = DEFAULT_PING_COUNT;
>   	int ret;
>   	int c;
>   	int oneshot = 0;
> @@ -248,6 +253,12 @@ int main(int argc, char *argv[])
>   				ping_rate = DEFAULT_PING_RATE;
>   			printf("Watchdog ping rate set to %u seconds.\n", ping_rate);
>   			break;
> +		case 'c':
> +			ping_count = strtoul(optarg, NULL, 0);
> +			if (!ping_count)
> +				ping_count = DEFAULT_PING_COUNT;
> +			printf("Number of pings set to %u.\n", ping_count);
> +			break;
>   		case 's':
>   			flags = 0;
>   			oneshot = 1;
> @@ -336,9 +347,10 @@ int main(int argc, char *argv[])
>   
>   	signal(SIGINT, term);
>   
> -	while (1) {
> +	while (ping_count > 0) {
>   		keep_alive();
>   		sleep(ping_rate);
> +		ping_count--;

So this test no longer runs forever?

thanks,
-- Shuah



