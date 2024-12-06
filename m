Return-Path: <linux-kernel+bounces-434288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C11F69E6468
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 03:48:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C9C8284A3B
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 02:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 707A8186E2E;
	Fri,  6 Dec 2024 02:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="C9Lq5Fy2"
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F0EDBE46
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 02:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733453315; cv=none; b=aZoT3x970//PVW3c8zILHVM0h+/lbwhCYBZ3o6MmM3ibyUKwsv8UhaOrEoO7AZW+mxOcSzTMVWmcqo1HM/GHr15K0y5PdPRdSTbjklm+WQDRL/ZZ23NpAvvmMWBMNC6Rm4xD6BBkLMsc3LuJFBkF6bhAcoPtFNaqB7fOLv/Yn0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733453315; c=relaxed/simple;
	bh=BDh9SwDxe4c0aV+frjodEvY9GG4dCdzC4qXVuQhQw44=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fymH+IHXEmPsfNJHbeQRbbctaBqV0lDaq94rjS/Q++B5ktNiaVnHlvSee0ZANKPHx397G1VQptlmFTTwL35sCQfJXH2w1OzdHvieoCn5zp8CkBaTLf8gfYG+znG9fQDpL7f3+9ZAOSIRzmNSTYoATvV/vsNvVJWjGKEg0DXX2Sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=C9Lq5Fy2; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3a81324bbdcso2408835ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 18:48:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1733453312; x=1734058112; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+mi3nFSqOdvJ5nQ1z8BgTnHPuWDoGYPQE2B7nJ2HsiY=;
        b=C9Lq5Fy2EPVbjyXlUozmahQWyQhHjP1dV/GwUym4xOw/aiSGAIZ3f7EakLs4pkQBOD
         RSjY0c1RVzunbzI/pmGFEi8iOXuaKi03+zhtu+PPbAwVHFhdPD1DKiyy+0z6NiTuGTnK
         xvNwOGIfBFZPJCrP90kXuDtaFrJLwjN+bzXO8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733453312; x=1734058112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+mi3nFSqOdvJ5nQ1z8BgTnHPuWDoGYPQE2B7nJ2HsiY=;
        b=Ica4hM82b4uucEzYKLUBJotx+tcj6jl1x1okPmN1epS2LVLBrzYD9iHb2IEVf2Lqpp
         1vPvWvGnVB6/Kfj43ai6iLtSiNdDAEW89NffE8r7VOH1I6oPrXN/PI0XWO2UAbXiuw1b
         seC34FsANPhILdYq7dJF87HiGZKZrf7GHQQ7exWFjzvzXRlfPNfY2j6NA62ee3Gyphxs
         dYkQSohon/reSi4VvPGejjSm7qbQ0UKy8HFlFljwmEqiGrAiaYSKq05ia5GmaST6WY0l
         A2W2RmumiY2pQK7akRV9faUHV5PGWal1aRXVBprj1f9S+XAfssQ6vHX8Yv9MDw6pKiF1
         8LDg==
X-Forwarded-Encrypted: i=1; AJvYcCVsKsq4C2du0Rxr68h5d7WctH8zj+7xxQkC4nZIP0mj4tc0gz4oIfKzxls+kaURhS33VL5mgS1AmMnif3w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7AgVIiLzDn3ohPiDW1xBppvey1TaSK/kt7WbG/Kc71AE5U6TI
	8N8nG9NoKHW5JFVgbtCeBNH9vn1eX/yodxxIOJKGtL/dT5fwXec5EM94ululQemDCF+nYg+OJyX
	u
X-Gm-Gg: ASbGncvwz2/qWVD+Je6rYtEyd2CghuCciGMMiHCWGSq8gKe22eiO2NjKZPIvj2ze0gm
	rfrx0IBcwhxfoRKuYMLD33Z5tfZc3Xnu5QnFmL/zDGp/rjX2py6jn7qgnrpyNxNUuDO5mhYriJG
	tBUdhR8MNGdc8t+RD+aNMpu1MU/DPyK67HpN8WpfcHngIwf/ig/Oy9wNzYgVxqZ5J/HX0K1MR8e
	Nt5S5oEZ1Xm2ErTBaeImaSvJ7Jg58zZqdF4JjK+rv5ZfF4mmrrWRLdGI23Hig==
X-Google-Smtp-Source: AGHT+IG3w166JVH5UZKAPvvLoDSYm33y/5NewE1e1kaytwmWtrsRPA+PK/6trNQWEAh8u7zUAJEsnQ==
X-Received: by 2002:a05:6e02:12c2:b0:3a7:70a4:6872 with SMTP id e9e14a558f8ab-3a811d71941mr20802295ab.9.1733453312293;
        Thu, 05 Dec 2024 18:48:32 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e28610808csm603413173.10.2024.12.05.18.48.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Dec 2024 18:48:31 -0800 (PST)
Message-ID: <206162ed-eef9-4428-a59f-6029ed1bac8f@linuxfoundation.org>
Date: Thu, 5 Dec 2024 19:48:29 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] selftests/watchdog: add -c option to limit the
 ping loop
To: Laura Nao <laura.nao@collabora.com>, shuah@kernel.org
Cc: kernel@collabora.com, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20241119150127.152830-1-laura.nao@collabora.com>
 <20241119150127.152830-2-laura.nao@collabora.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241119150127.152830-2-laura.nao@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/19/24 08:01, Laura Nao wrote:
> In order to run the watchdog selftest in a non-interactive environment,
> the loop responsible for pinging the watchdog should be finite.
> Introduce a new '-c' option to adjust the number of pings as needed.
> 
> Signed-off-by: Laura Nao <laura.nao@collabora.com>
> ---
>   tools/testing/selftests/watchdog/watchdog-test.c | 15 +++++++++++++--
>   1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/watchdog/watchdog-test.c b/tools/testing/selftests/watchdog/watchdog-test.c
> index bc71cbca0dde..58c25015d5e7 100644
> --- a/tools/testing/selftests/watchdog/watchdog-test.c
> +++ b/tools/testing/selftests/watchdog/watchdog-test.c
> @@ -27,13 +27,14 @@
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
> @@ -90,6 +91,7 @@ static void usage(char *progname)
>   	printf(" -h, --help\t\tPrint the help message\n");
>   	printf(" -p, --pingrate=P\tSet ping rate to P seconds (default %d)\n",
>   	       DEFAULT_PING_RATE);
> +	printf(" -c, --pingcount=C\tLimit the number of pings to C (default infinite)\n");
>   	printf(" -t, --timeout=T\tSet timeout to T seconds\n");
>   	printf(" -T, --gettimeout\tGet the timeout\n");
>   	printf(" -n, --pretimeout=T\tSet the pretimeout to T seconds\n");
> @@ -172,6 +174,7 @@ int main(int argc, char *argv[])
>   {
>   	int flags;
>   	unsigned int ping_rate = DEFAULT_PING_RATE;
> +	unsigned int ping_count = -1;

Assigning -1 to unsigned?

>   	int ret;
>   	int c;
>   	int oneshot = 0;
> @@ -248,6 +251,12 @@ int main(int argc, char *argv[])
>   				ping_rate = DEFAULT_PING_RATE;
>   			printf("Watchdog ping rate set to %u seconds.\n", ping_rate);
>   			break;
> +		case 'c':
> +			ping_count = strtoul(optarg, NULL, 0);

strtoul() returns ULONG_MAX if there are errors.Don't you have
to handle those cases? Also ping_count in unsigned int? Do you
see compile warns?


> +			if (!ping_count)
> +				oneshot = 1;

Why not just "goto end" at this point?

> +			printf("Number of pings set to %u.\n", ping_count);> +			break;
>   		case 's':
>   			flags = 0;
>   			oneshot = 1;
> @@ -336,9 +345,11 @@ int main(int argc, char *argv[])
>   
>   	signal(SIGINT, term);
>   
> -	while (1) {
> +	while (ping_count != 0) {
>   		keep_alive();
>   		sleep(ping_rate);
> +		if (ping_count > 0)
> +			ping_count--;

Did you test this with strtoul() failed case when the return
could be ULONG_MAX?

>   	}
>   end:
>   	/*

thanks,
-- Shuah

