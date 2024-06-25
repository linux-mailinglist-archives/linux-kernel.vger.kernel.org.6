Return-Path: <linux-kernel+bounces-229588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF2AF91711C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 21:29:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5CC51F23C3F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 19:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 002CB17C7DF;
	Tue, 25 Jun 2024 19:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cEYu4BxN"
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B5017C7CF
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 19:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719343744; cv=none; b=d7Ni6BiEAuNZ5jahrlOlX6TXP9n+G6w1ulIkBObwIphc1nf8mocnZTnquhXGc87HqRKl3FdIWmjWsibYmP9EPlCPD+DIsvgezFQnhgbpyuDfvhFQ5tsfYSlMZMewurgkPIvd+9ASqMAPsJjg7dqZTUDEweoOG/rVAFewpedOc9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719343744; c=relaxed/simple;
	bh=57oZNTDSwhNmGdZxcu1p56BKpqyHbfD80sAWf5h07X4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j9t6+m7de/Aec4UYnWqqQ9IkhzWdCJzxrBL/XOJYGkj2SGgSUvcW0KrGQCB33FYep59OXYP9/48wcZW0O6MAyqBcKmfyXpJEiOdPwblV+TXnYUvBg1CxeOMd6p+4La8odQvHh6cw+chLHmcSXSp8ZjmlyVbppClYP2hnJR2N2oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cEYu4BxN; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3762c172d94so2467025ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 12:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1719343741; x=1719948541; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AdqgHQbiLKX0GrfKsc8VRA3Aa5aj9Gv3ZmL9WC7EReU=;
        b=cEYu4BxN/rKB4rhFZXap3oX6IPmnGoVX9bOnAJGjD6FRAjwcL3E35Utwyuxe1uC+n8
         YA9Q2mYoELKMGGazDZgPldDSvfUQTniqEvo4yNzIz31rk4i1wPp8DI8v3gZo+nZa9p6E
         wTAUx+Jr6UAizImaGcdqbIr6vcLATY2SvPHRA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719343741; x=1719948541;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AdqgHQbiLKX0GrfKsc8VRA3Aa5aj9Gv3ZmL9WC7EReU=;
        b=hxXD4b9xgk02OLZ7GtEjqFIJROvnY4WQ3v6sHHQy2xB7NPF8X8pkQihj4iK3tFvqgg
         fmjE3xisI/hImVXaO7xWqc+nCNR6Ay8lWXqdKhG+Az0wgfnUsQBm6iZ2tVaQFhZtTvyh
         fL3/qOUXj49tE2tslltJ/elUN5eZXAr0Ei3S28rjgyqiSZVplKGfL1foD94FmpLJgIa/
         4wN7Yw3dpa7JpQU5PRx5h/qzXxkGhL0WawzfkwLUp2S8ytoFwg+bJ6tiixoqEHcs6X1X
         XKhj9wZi7ZQSxD+gsObdfN8f31PYVo+Z+rBcj0D9VtGT57NsiR3AIGsk5necRABOXkI8
         NYYQ==
X-Forwarded-Encrypted: i=1; AJvYcCXfGypYigsCVPe2kztAPoAPuo9BIiw9NkuHCFFGT7PVzOIxbMFi3+igQ8ST2zmFNrP8jnlt1UfdAZHLu0eU0s2vFiM0t5kLutC7YlRW
X-Gm-Message-State: AOJu0YxReJlwLr7EVDftE6OOBKkujat1re23KZ30Q31CaFYQbwhBo5nG
	3O411PqjKij0J4B7RVlDW4if6Yk7D5MstZaa9VO3KvuKkwUuzwsmguErij0B974=
X-Google-Smtp-Source: AGHT+IG7zwOcPTRc9nkE8fl2fmrJ6wZJFFd+stNb7ZHqxTHswSk3KwlfCDW59o0lEqMqYOgxk0RRZg==
X-Received: by 2002:a92:d28c:0:b0:376:2361:d2ac with SMTP id e9e14a558f8ab-37638b5136dmr75534975ab.2.1719343741315;
        Tue, 25 Jun 2024 12:29:01 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3772b4c8b06sm1159875ab.53.2024.06.25.12.29.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jun 2024 12:29:00 -0700 (PDT)
Message-ID: <0a5ab4c0-e397-4dda-92f8-a23bcb42765c@linuxfoundation.org>
Date: Tue, 25 Jun 2024 13:29:00 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cpupower: Make help command available for custom
 install dir
To: Roman Storozhenko <romeusmeister@gmail.com>,
 Thomas Renninger <trenn@suse.com>, Shuah Khan <shuah@kernel.org>
Cc: Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240622-fix-help-issue-v2-1-6c19e28a4ec1@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240622-fix-help-issue-v2-1-6c19e28a4ec1@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/22/24 07:01, Roman Storozhenko wrote:
> When the 'cpupower' utility installed in the custom dir, it fails to
> render appropriate help info for a particular subcommand:
> $ LD_LIBRARY_PATH=lib64/ bin/cpupower help monitor
> with error message like 'No manual entry for cpupower-monitor.1'
> The issue is that under the hood it calls 'exec' function with
> the following args: 'man cpupower-monitor.1'. In turn, 'man' search
> path is defined in '/etc/manpath.config'. Of course it contains only
> standard system man paths.
> Make subcommands help available for a user by setting up 'MANPATH'
> environment variable to the custom installation man pages dir. That
> variable value will be prepended to the man pages standard search paths
> as described in 'SEARCH PATH' section of MANPATH(5).
> 
> Signed-off-by: Roman Storozhenko <romeusmeister@gmail.com>
> ---
> Changes in v2:
> - Fixed spelling errors
> - Simplified man pages search approach by the 'MANPATH' variable usage
> - Link to v1: https://lore.kernel.org/r/20240621-fix-help-issue-v1-1-7906998d46eb@gmail.com
> ---
>   tools/power/cpupower/utils/cpupower.c | 41 ++++++++++++++++++++++++++++++-----
>   1 file changed, 35 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/power/cpupower/utils/cpupower.c b/tools/power/cpupower/utils/cpupower.c
> index 9ec973165af1..1b1b79c572ad 100644
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
> @@ -80,14 +82,17 @@ static void print_help(void)
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
> @@ -97,6 +102,30 @@ static int print_man_page(const char *subpage)
>   		strcat(page, subpage);
>   	}
>   
> +	/* Get current process image name full path */
> +	if (readlink("/proc/self/exe", exec_path, PATH_MAX) > 0) {

Using /proc/self/exe is Linux and platform specific and not a
good solution. Did you loom into using argv[0]?

thanks,
-- Shuah

