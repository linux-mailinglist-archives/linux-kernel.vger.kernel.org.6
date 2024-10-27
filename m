Return-Path: <linux-kernel+bounces-383424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CAAC9B1B89
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 02:29:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B71B2820BF
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 00:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6848628F5;
	Sun, 27 Oct 2024 00:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="T/G6a9Tf"
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B931367
	for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2024 00:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729988972; cv=none; b=ggIesu+Iaq7iv8O2TuQJVTEk+N+Pe708gPGWETfwKsT8Q8lpu22huWpANfHg/LNieTWz7+vMHzabCZCj9ZKxAfB90JvwQ4/KjtcqODOzz0odrI9Y+c6D2GwdFXjBNu7e4GzOO+ObEWYR0CGlSXuWdnQ/GDe86NMHwVlMKmr6XwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729988972; c=relaxed/simple;
	bh=a2J+nNa1zs1AD4dHS1jmu/TnHxzKKXVyBrmGSj2ksE0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e2UlE/wgTjBkcO5jGgYVpqoxV8kbgZTnTXA37YQRJyKH/M+VVwIz7tIH8OenLiSUCpnyJ23hhrJFwuPrhagfHM3WEAK4dJeIk2ld5lTNvTsWIK31LEHfvVVaiu7qy37choLclBdzBI/LpKG7yV9SesycnWHhUT++dLzMYSoPFNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=T/G6a9Tf; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7b152a923a3so248770085a.3
        for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 17:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1729988969; x=1730593769; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nf7dY4XiUOsGpMj412qO4GMRiVERCsox/7G1qGLca9E=;
        b=T/G6a9TfgBZQ2MWxCj0AfhI5mJSSlFdNAGLSIzMUBaEgCV6osnoBDA2w4YwY+RV1SP
         UzmFq1QiowsgMMaKM0BnRkbv9Id73ILvZMf41LYYoOqfDp7z9FBxRtByyihyDLsa/sb9
         MZ7sB+jfc5icR4R7tXYsOZNC2yn9OOwzanWQM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729988969; x=1730593769;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nf7dY4XiUOsGpMj412qO4GMRiVERCsox/7G1qGLca9E=;
        b=db5FYnUJx4f6kzsbg/Keh92jgOA2u6qfCEFwyhYPJVNbWJHtMXAyik9aWYHfdUcOJV
         EI2Tz8lZ8FvS5KXZgIga0/p8MDoWrGkOq5TYcs2h6u8ax6Rza4TUKxoyGIAz4t8tbFLr
         cxG0BO/OdKZE/CjdSXjV7lVmSFuaV8DS9JSz1FGCNho/fwDZwV1m5IaNPBVy8EuocGk3
         6m0MKqMsmi9nGeWcOJsSC2LmFMlh64HerQK61Wy9XhhiE7CxTOxJxqI6BZXWbNkEECHe
         kzcZ/zG541lrerBQrBXj7D6EqFAtva/ks4ZUOnLUPD0Z6LM5BtaFKeSAXWDG57Yzh2gm
         0gIw==
X-Forwarded-Encrypted: i=1; AJvYcCW3hqou9HbomwVIEFQcDVJA/6CZemMVctXodCX1+5N98ExwwI5UnS3JD6R2JTMbJuIDXqRLtj1UrbE5tFk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxV2MJySvfNMj8qigAd4hEwRM+71rg2fTtyCXEDpdsyuu/1au9P
	vh7jFg344L2q1URIbN9fyRtuG2zZfSxTrtYeYObfcWr/WSK0dOJhRbWIjVGAxBo+MdofyVMt4YE
	1
X-Google-Smtp-Source: AGHT+IHN/knW5u9MOAU0WJWsokuS3LbChU0sTtWcinNJDCj2TQmt1WG+fI5gZJ3AS944joo6ITllZQ==
X-Received: by 2002:a05:620a:4511:b0:7b1:43d7:12a8 with SMTP id af79cd13be357-7b193ed1cd7mr789756085a.8.1729988969139;
        Sat, 26 Oct 2024 17:29:29 -0700 (PDT)
Received: from [172.19.248.149] ([205.220.129.21])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b18d334ae4sm192268485a.77.2024.10.26.17.29.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Oct 2024 17:29:28 -0700 (PDT)
Message-ID: <c2cae7a7-1a0d-48ef-9b8f-8d2436532ea7@linuxfoundation.org>
Date: Sat, 26 Oct 2024 18:28:56 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-next 1/3] selftests/watchdog: add count parameter for
 watchdog-test
To: Li Zhijian <lizhijian@fujitsu.com>, linux-kselftest@vger.kernel.org
Cc: shuah@kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241025013933.6516-1-lizhijian@fujitsu.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241025013933.6516-1-lizhijian@fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/24/24 19:39, Li Zhijian wrote:
> Currently, watchdog-test keep running until it gets a SIGINT. However,
> when watchdog-test is executed from the kselftests framework, where it
> launches test via timeout which will send SIGTERM in time up. This could
> lead to
> 1. watchdog haven't stop, a watchdog reset is triggered to reboot the OS
>     in silent.
> 2. kselftests gets an timeout exit code, and judge watchdog-test as
>    'not ok'
> 
This test isn't really supposed to be run from kselftest framework.
This is the reason why it isn't included in the default run.

> This patch is prepare to fix above 2 issues

This series needs a separate cover letter explaining how this problem is
being fixed.

> 
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> ---
> Hey,
> Cover letter is here.
> 
> It's notice that a OS reboot was triggerred after ran the watchdog-test
> in kselftests framwork 'make run_tests', that's because watchdog-test
> didn't stop feeding the watchdog after enable it.
> 
> In addition, current watchdog-test didn't adapt to the kselftests
> framework which launchs the test with /usr/bin/timeout and no timeout
> is expected.
> ---
>   tools/testing/selftests/watchdog/watchdog-test.c | 13 +++++++++----
>   1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/testing/selftests/watchdog/watchdog-test.c b/tools/testing/selftests/watchdog/watchdog-test.c
> index bc71cbca0dde..2f8fd2670897 100644
> --- a/tools/testing/selftests/watchdog/watchdog-test.c
> +++ b/tools/testing/selftests/watchdog/watchdog-test.c
> @@ -27,7 +27,7 @@
>   
>   int fd;
>   const char v = 'V';
> -static const char sopts[] = "bdehp:st:Tn:NLf:i";
> +static const char sopts[] = "bdehp:st:Tn:NLf:c:i";
>   static const struct option lopts[] = {
>   	{"bootstatus",          no_argument, NULL, 'b'},
>   	{"disable",             no_argument, NULL, 'd'},
> @@ -42,6 +42,7 @@ static const struct option lopts[] = {
>   	{"gettimeleft",		no_argument, NULL, 'L'},
>   	{"file",          required_argument, NULL, 'f'},
>   	{"info",		no_argument, NULL, 'i'},
> +	{"count",         required_argument, NULL, 'c'},
>   	{NULL,                  no_argument, NULL, 0x0}
>   };
>   
> @@ -95,6 +96,7 @@ static void usage(char *progname)
>   	printf(" -n, --pretimeout=T\tSet the pretimeout to T seconds\n");
>   	printf(" -N, --getpretimeout\tGet the pretimeout\n");
>   	printf(" -L, --gettimeleft\tGet the time left until timer expires\n");
> +	printf(" -c, --count\tStop after feeding the watchdog count times\n");
>   	printf("\n");
>   	printf("Parameters are parsed left-to-right in real-time.\n");
>   	printf("Example: %s -d -t 10 -p 5 -e\n", progname);
> @@ -174,7 +176,7 @@ int main(int argc, char *argv[])
>   	unsigned int ping_rate = DEFAULT_PING_RATE;
>   	int ret;
>   	int c;
> -	int oneshot = 0;
> +	int oneshot = 0, stop = 1, count = 0;
>   	char *file = "/dev/watchdog";
>   	struct watchdog_info info;
>   	int temperature;
> @@ -307,6 +309,9 @@ int main(int argc, char *argv[])
>   			else
>   				printf("WDIOC_GETTIMELEFT error '%s'\n", strerror(errno));
>   			break;
> +		case 'c':
> +			stop = 0;
> +			count = strtoul(optarg, NULL, 0);
>   		case 'f':
>   			/* Handled above */
>   			break;
> @@ -336,8 +341,8 @@ int main(int argc, char *argv[])
>   
>   	signal(SIGINT, term);
>   
> -	while (1) {
> -		keep_alive();
> +	while (stop || count--) {
> +		exit_code = keep_alive();
>   		sleep(ping_rate);
>   	}
>   end:


