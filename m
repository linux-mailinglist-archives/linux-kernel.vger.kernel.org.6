Return-Path: <linux-kernel+bounces-231086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85960918605
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 17:38:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33D20B21F9D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 15:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23DD718C32C;
	Wed, 26 Jun 2024 15:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QTQoQupx"
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83EE518C322
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 15:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719416195; cv=none; b=K2farjeksSv9iISoN/AOwSap70PJagAOh/lgR3Q+cpQk9ixgs9NjdNUW4mtwpK9Bds0ug9uofFUGadAbqnCt+RmWkDI8BG9sX8p2gFtu357yu8qmTZWfAOqQ0toKlma76j4UfQTn+fxL+zv/LUDV8DIV40W76A3aRzOregMW0NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719416195; c=relaxed/simple;
	bh=/jY4xmMwrD2YVnhKDpXCUYzx8UZ4RvTLc+X/sRIhxjo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZxAhjp/iLfeIIbhJm+R+MelepKRq4zCOfIyj/kkl8+R5iMOqM0LzFKryPNs8YNuY6QnxA3Q2uXV8ueB0HnGzv2mbJFxCsQB7dxS6jCkddEHT6lQrHSQQRV755Qq69SPo0XrVYePduNHkKK/JyjbnFpDwVsfpDuJhOPJo14QI8DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QTQoQupx; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3734052ffd9so3249025ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 08:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1719416192; x=1720020992; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TGsoDw+FPosCxydCexs3FGCDKDSHuHy3qnWt55jHb4E=;
        b=QTQoQupxkFVKbncr4UUiv+AuB0eJj2NCTsPZg6L0y00Ems+DJuENReLyDL4nXPXpWz
         BLCRRFk0n6rztOw9dyD2DcP2ZwVqlGj1j/2DKuVOm6XmTEuPXdtjFuY90tUNwYKytXeO
         xVbHU4QDFc3jsQVUOSCCjw0NC9YVndVFUKqqg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719416192; x=1720020992;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TGsoDw+FPosCxydCexs3FGCDKDSHuHy3qnWt55jHb4E=;
        b=acTnyWj5T1b7wjlTogcIkHFdMTXqkWbMajKGOjIs6rNjGacCwV4KluS4pkoxehdbEF
         fArMJCHKiYEMQxy3Yho2ml56HUwsek8CvR6jxlubDN4yCyCt4txsDuBGyE6wj0n8uU/8
         JbOawhty3VdW2Za18Xxrtd946+8lujTl4iURRgya9XWqH7P/0af5nbweNoPsePoUmb6y
         nxd6T9G5VNPOJEFWM413bdkxonyfQlEt601Ekkygbmzwlnw/yhnu0w75AFEQMPmAFS/K
         YvecLpTrZnUbUtltjigE0KHR3XlFPUmaq9aEbP/X1KAqwjle5FYOt1Q9s/calzC+aoFo
         SmOA==
X-Forwarded-Encrypted: i=1; AJvYcCXhEx083XdnFeC/wrqwkt8xwI35jYZvdFXuPMq8y5Gc/Et2u0tCckPL89hu238qRiWCZL0nhoJcskC9/4VZQA2fGQxi5RT4uJB8mdAg
X-Gm-Message-State: AOJu0YyK0kRbuSseMCiou01rMCz3/I4oa8J7VO81VkUUT78B2JQqWh7h
	KkIeuItWMJN2GSXhvnekvbn/DviPhVXcfy94Qu0PAreF4QFrWtlLPduGjMQVZ2A=
X-Google-Smtp-Source: AGHT+IE+Nmar/X+M9AvuAWQl/5hT6k3MlbdVaL6J4g9683ewMXiSo67B2x0mUc1FURTq32erlUmS0g==
X-Received: by 2002:a5d:984e:0:b0:7f3:9dd3:15bf with SMTP id ca18e2360f4ac-7f39dd317famr1026613839f.0.1719416192571;
        Wed, 26 Jun 2024 08:36:32 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-7f391ff7650sm269168939f.33.2024.06.26.08.36.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jun 2024 08:36:32 -0700 (PDT)
Message-ID: <7ea62dd3-723b-4691-a0e6-c4bea07db532@linuxfoundation.org>
Date: Wed, 26 Jun 2024 09:36:31 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cpupower: Make help command available for custom
 install dir
To: Roman Storozhenko <romeusmeister@gmail.com>
Cc: Thomas Renninger <trenn@suse.com>, Shuah Khan <shuah@kernel.org>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20240622-fix-help-issue-v2-1-6c19e28a4ec1@gmail.com>
 <0a5ab4c0-e397-4dda-92f8-a23bcb42765c@linuxfoundation.org>
 <CALsPMBMUAEwFOSfkjrd2Os+6YKunrAnkNHrJ6eU3DOvaE6BrsQ@mail.gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <CALsPMBMUAEwFOSfkjrd2Os+6YKunrAnkNHrJ6eU3DOvaE6BrsQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/26/24 01:29, Roman Storozhenko wrote:
> On Tue, Jun 25, 2024 at 9:29 PM Shuah Khan <skhan@linuxfoundation.org> wrote:
>>
>> On 6/22/24 07:01, Roman Storozhenko wrote:
>>> When the 'cpupower' utility installed in the custom dir, it fails to
>>> render appropriate help info for a particular subcommand:
>>> $ LD_LIBRARY_PATH=lib64/ bin/cpupower help monitor
>>> with error message like 'No manual entry for cpupower-monitor.1'
>>> The issue is that under the hood it calls 'exec' function with
>>> the following args: 'man cpupower-monitor.1'. In turn, 'man' search
>>> path is defined in '/etc/manpath.config'. Of course it contains only
>>> standard system man paths.
>>> Make subcommands help available for a user by setting up 'MANPATH'
>>> environment variable to the custom installation man pages dir. That
>>> variable value will be prepended to the man pages standard search paths
>>> as described in 'SEARCH PATH' section of MANPATH(5).
>>>
>>> Signed-off-by: Roman Storozhenko <romeusmeister@gmail.com>
>>> ---
>>> Changes in v2:
>>> - Fixed spelling errors
>>> - Simplified man pages search approach by the 'MANPATH' variable usage
>>> - Link to v1: https://lore.kernel.org/r/20240621-fix-help-issue-v1-1-7906998d46eb@gmail.com
>>> ---
>>>    tools/power/cpupower/utils/cpupower.c | 41 ++++++++++++++++++++++++++++++-----
>>>    1 file changed, 35 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/tools/power/cpupower/utils/cpupower.c b/tools/power/cpupower/utils/cpupower.c
>>> index 9ec973165af1..1b1b79c572ad 100644
>>> --- a/tools/power/cpupower/utils/cpupower.c
>>> +++ b/tools/power/cpupower/utils/cpupower.c
>>> @@ -12,6 +12,8 @@
>>>    #include <unistd.h>
>>>    #include <errno.h>
>>>    #include <sched.h>
>>> +#include <libgen.h>
>>> +#include <limits.h>
>>>    #include <sys/types.h>
>>>    #include <sys/stat.h>
>>>    #include <sys/utsname.h>
>>> @@ -80,14 +82,17 @@ static void print_help(void)
>>>
>>>    static int print_man_page(const char *subpage)
>>>    {
>>> -     int len;
>>> -     char *page;
>>> +     char *page, *man_path, *exec_dir;
>>> +     char exec_path[PATH_MAX];
>>> +     int subpage_len;
>>>
>>> -     len = 10; /* enough for "cpupower-" */
>>> -     if (subpage != NULL)
>>> -             len += strlen(subpage);
>>> +     if (!subpage)
>>> +             return -EINVAL;
>>>
>>> -     page = malloc(len);
>>> +     subpage_len = 10; /* enough for "cpupower-" */
>>> +     subpage_len += strlen(subpage);
>>> +
>>> +     page = malloc(subpage_len);
>>>        if (!page)
>>>                return -ENOMEM;
>>>
>>> @@ -97,6 +102,30 @@ static int print_man_page(const char *subpage)
>>>                strcat(page, subpage);
>>>        }
>>>
>>> +     /* Get current process image name full path */
>>> +     if (readlink("/proc/self/exe", exec_path, PATH_MAX) > 0) {
>>
>> Using /proc/self/exe is Linux and platform specific and not a
>> good solution. Did you loom into using argv[0]?
> 
> Yes, it is not the best solution. I would rather prefer to have a portable,
> POSIX-based one. But after exploring possible options I came to the
> conclusion that unfortunately such a solution doesn't exist.
> According to C11 language standard:
> "If the value of argc is greater than zero, the string pointed to by argv[0]
> represents the program name;....".
> Notice - program name, not the absolute path to the program. The actual
> value of argv is under control of the calling environment.
> You could look at the nice discussion of the topic for example here:
> https://www.reddit.com/r/C_Programming/comments/dgcmhd/exactly_how_reliable_is_argv0_at_being_the/
> Besides - this utility is a part of the Linux Kernel source tree and therefore
> has no requirement of the portability to another OSes.
> 

Even so, you don't want to move it towards non-portable. I think I asked
this before on your previous version of the patch:

What happens when you set the MANPATH before running the command?

thanks,
-- Shuah


