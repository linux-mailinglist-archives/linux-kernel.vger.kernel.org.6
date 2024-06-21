Return-Path: <linux-kernel+bounces-224931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EEDB9128CC
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 17:03:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8429C1C25E0E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 15:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AE3D57CBA;
	Fri, 21 Jun 2024 15:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dfSdTzfc"
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D9051C42
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 15:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718982171; cv=none; b=WAoPGJwijYdxPGGzcwNv58E/h6qdpWKjqcZmwKfjf1TX+y2y8kwghN7zuES5MPx0uzIigCPlshl7vzsH1uH0f/MMcyGZ9xvxIqMFkb6zg7cMUe6Vm39Pq5/alx0WS29WDf0T+WQGcFtCIFNtxN/R2uVunMuIFwzuLwtwPEB6E/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718982171; c=relaxed/simple;
	bh=fiMx6wwu690oOQT9nRgHH9YTRFAiNUeCWyOvwt4eb8w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y/LEKepuzT2M20xZJ1F4E51+CFxNTr8j+kAal3pzcJI2PdU1BZwXys0Mm/iJahnesGjRo2OwzkSPB1CHPe7Iz1AqkUrl+qK+KfJ/I+YrZRH6INwlCpEcXcp/s0iKvJki6d0Tt6RFhtNtZQSVcPx3+YmJRAfcNBVOzuTCEWVSG3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dfSdTzfc; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-7ebac4d032bso4254039f.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 08:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1718982169; x=1719586969; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1VdGKVZptRgurC360cgfB2zYHtm1AtWvC4+2AMI4Ms4=;
        b=dfSdTzfc800GjjbkChYobMLQvcKyPUmGaUrSQbPwHYdONhItAoXTO5BWFYZ/ZKMO9W
         JrEtc37Paa+42ZVpOgzjjQ4X+XpldBwjnOsuH6STesCV+qeKnZPNIE/JPJ4yx8C+Hrba
         ZmFFJoaIzTc09GD83WxC2LXYOer3rYLVzzwoM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718982169; x=1719586969;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1VdGKVZptRgurC360cgfB2zYHtm1AtWvC4+2AMI4Ms4=;
        b=WyegRc6SnHtud0sUD+WYLUQpDOYDII7MFYt0aoM6nd9RXse4HdnYxK9l7JcWHMQzc6
         k7c7eoDtAgrjTDZl+CqoTu3grxSdW0pU7klvJWL98EGlnP24no/psn38lRbwtfFIEzQK
         qm2QVgNb1vNnSM7NvVh3cPeErHwB9DUkXwTy1FgMUqF/sZ67ddyPoLGGf3FbhkHPK9WE
         GCO0+3H6v3lK6tu5pp7uG6gKSngETmMUQAKtGb9X5ZrcZhH4IXTHuLjQ0smORoS7wEGv
         8z4nwWLVNaNhfD4axH19xk0kqr656h8XnMyre7m/eHftw3BBUouMTSSPX4HZYXkbshJN
         8tgA==
X-Forwarded-Encrypted: i=1; AJvYcCXum0IOI6jQMdhKTAWajqVaL0HOWCzRAcXQj0kRkdSug7Gd40XKLLvIF70/gX3lNyJMMvMxGKgC3ECoqSHZ1gZXH6tD1lI/jBaWw70p
X-Gm-Message-State: AOJu0YztSBxN+GJFyNv4lLlDC+VkjmflOqwtjNpZCWpZx6Usy9HQBZV7
	tyHB0M7v7YgjmN/Aw27vr8VtPlPMnu27U0LIO7kSvxi+sx+o7GR9uedE3e77AVg=
X-Google-Smtp-Source: AGHT+IFztYqDBk66dDZ2hF4/FpkflmaJEY1uhuE6eavvh4EsUEA+b3wfX7Rzs65/V+QX6uyVUv2Ybw==
X-Received: by 2002:a05:6602:1d57:b0:7eb:ea26:3471 with SMTP id ca18e2360f4ac-7f13ee6c867mr851671039f.2.1718982168852;
        Fri, 21 Jun 2024 08:02:48 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-7f391ff7650sm37794239f.33.2024.06.21.08.02.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jun 2024 08:02:48 -0700 (PDT)
Message-ID: <6d745d8d-33b1-4aed-b9c5-095073bc8cde@linuxfoundation.org>
Date: Fri, 21 Jun 2024 09:02:47 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpupower: Make help command available for custom install
 dir
To: Roman Storozhenko <romeusmeister@gmail.com>,
 Thomas Renninger <trenn@suse.com>, Shuah Khan <shuah@kernel.org>
Cc: Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240621-fix-help-issue-v1-1-7906998d46eb@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240621-fix-help-issue-v1-1-7906998d46eb@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/21/24 02:13, Roman Storozhenko wrote:
> When the 'cpupower' utility installed in the custom dir, it fails to
> render appopriate help info for a particular subcommand:

appopriate -> appropriate
Spell check the commit message.

> $ LD_LIBRARY_PATH=lib64/ bin/cpupower help monitor
> with error message like 'No manual entry for cpupower-monitor.1'
> The issue is that under the hood it calls 'exec' function with
> the following args: 'man cpupower-monitor.1'. In turn, 'man' search
> path is defined in '/etc/manpath.config'. Of course it contains only
> standard system man paths.
> Make subcommands man pages available for user using the following rule:
> Render a man page if it is installed in the custom install dir, otherwise
> allow man to search this page by name system-wide as a last resort.
> 

Good find.

> Signed-off-by: Roman Storozhenko <romeusmeister@gmail.com>
> ---
>   tools/power/cpupower/utils/cpupower.c | 54 ++++++++++++++++++++++++++++++-----
>   1 file changed, 47 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/power/cpupower/utils/cpupower.c b/tools/power/cpupower/utils/cpupower.c
> index 9ec973165af1..da4bc6de7494 100644
> --- a/tools/power/cpupower/utils/cpupower.c
> +++ b/tools/power/cpupower/utils/cpupower.c
> @@ -12,6 +12,8 @@
>   #include <unistd.h>
>   #include <errno.h>
>   #include <sched.h>
> +#include <libgen.h>
> +#include <limits.h>
>   #include <sys/types.h>
>   #include <sys/stat.h>
>   #include <sys/utsname.h>
> @@ -21,6 +23,8 @@
>   #include "helpers/bitmask.h"
>   
>   #define ARRAY_SIZE(x) (sizeof(x)/sizeof(x[0]))
> +#define MAN_REL_PATH "/../man/man1/"
> +#define MAN_SUFFIX ".1"
>   
>   static int cmd_help(int argc, const char **argv);
>   
> @@ -80,14 +84,17 @@ static void print_help(void)
>   
>   static int print_man_page(const char *subpage)
>   {
> -	int len;
> -	char *page;
> +	char *page, *man_path, *exec_dir;
> +	char exec_path[PATH_MAX];
> +	int subpage_len;
>   
> -	len = 10; /* enough for "cpupower-" */
> -	if (subpage != NULL)
> -		len += strlen(subpage);
> +	if (!subpage)
> +		return -EINVAL;
>   
> -	page = malloc(len);
> +	subpage_len = 10; /* enough for "cpupower-" */
> +	subpage_len += strlen(subpage);
> +
> +	page = malloc(subpage_len);
>   	if (!page)
>   		return -ENOMEM;
>   
> @@ -97,7 +104,40 @@ static int print_man_page(const char *subpage)
>   		strcat(page, subpage);
>   	}
>   
> -	execlp("man", "man", page, NULL);
> +	/* Get current process image name full path */
> +	if (readlink("/proc/self/exe", exec_path, PATH_MAX) > 0) {
> +
> +		man_path = malloc(PATH_MAX);
> +		if (!man_path) {
> +			free(page);
> +			return -ENOMEM;
> +		}
> +
> +		exec_dir = strdup(exec_path);
> +		if (!exec_dir) {
> +			free(page);
> +			free(man_path);
> +			return -ENOMEM;
> +		}
> +
> +		*man_path = '\0';
> +		strncat(man_path, dirname(exec_dir), strlen(exec_dir));
> +		strncat(man_path, MAN_REL_PATH, strlen(MAN_REL_PATH));
> +		strncat(man_path, page, strlen(page));
> +		strncat(man_path, MAN_SUFFIX, strlen(MAN_SUFFIX));
> +
> +		free(exec_dir);
> +
> +		/* Check if file exists */
> +		if (access(man_path, F_OK) == -1) {
> +			free(man_path);
> +			man_path = page;
> +		}
> +	} else {
> +		man_path = page;
> +	}
> +
> +	execlp("man", "man", man_path, NULL);

You can simplify all of this by using getenv() to get the environment
variables for the program.

Take a look getenv() usages in the kernel sources for reference.
>   

thanks,
-- Shuah


