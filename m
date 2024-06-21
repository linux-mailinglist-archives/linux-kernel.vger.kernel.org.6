Return-Path: <linux-kernel+bounces-225328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EA8E912F23
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 23:04:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1BAD1C2173D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 21:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A0D017BB1A;
	Fri, 21 Jun 2024 21:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Nx8JLK+a"
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F4B155329
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 21:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719003847; cv=none; b=L66FIHfcE0BtAZLU0vttRoC+4SHYje/dIrMFtM92ZexTnVQ6SUVCOCJCgIf/4J3D5ymLlpXz7Quj8NdibxG7tK9/1TWdPWyp8WqCADrY9KuY0lJ0iZhPYkedzuuXcYz+b0qHzqJHTV3SnIEe0XFSZO5VLVShb+C/b+LchzcrcoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719003847; c=relaxed/simple;
	bh=3jhZ1Gbwn3MiZ8AUkdKoob7HZ66X+msUyMxS7MtivEo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RU0QjIRRn7nEV1VZFMGpa2uTiSj9OrB+BKhGQEuXsyY+udmG0wvt+uLQl1+FF2IT6vC4TRnM6oTxg+7p6pFvT0bt/ekSQ69KHMjwnQparl9YFtZ5v2/btebXszGZBnabKPoLDs1ZDJdAkFaXp9oMcDewylhRwk4PQDYXmZEJVD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Nx8JLK+a; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-7e8e7306174so9601839f.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 14:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1719003844; x=1719608644; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x0C9Ul1qlhDcm6cNBLklwjqBGPJxzhUtl4ux8QbvBLk=;
        b=Nx8JLK+aCaXRFZ4jr9R0KTKPJg0eq5ISIpPg8LXmwg23f8gKpxcFTKKySxQvbjPYWW
         475a1AzOP2uZ9q6dw1BtqRT8XUxf6ruualL8w53q/OCoGnvCTDPKoNoorCS7IU/h6r/9
         1SwuWAL8PmiM5crgYry1eguhR8tBpYklspTQc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719003844; x=1719608644;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x0C9Ul1qlhDcm6cNBLklwjqBGPJxzhUtl4ux8QbvBLk=;
        b=FgcjQki6kz1vVgkAxd5Tnl6zlljAigCX+lnoth/DF12RH13460P9GCiGQ7xi6OSE/O
         oblcnYKM1jf9o3r0kQOh7C+ZTjy4MAakf162rfG2frt12w5ZhO2Pp00GRBHo+0BRAAcM
         83kdUINGC25XbxNUgfb4O7YJYiFJVhqRoXyQ1IF2Vapgq9a2UxbBPhuXldxU6vFQe1qT
         Dh2AQnsw4uHOeABLtyG4AdVc2nmPgkSqD6b5JNvhHd6s4YfozQ+XVO/Mfo4rnDwCB/Kz
         Be49LLvhH18+Jz0a43+A0TqUNDCw7rF9aataknoHZSXvpQjzY/jaluRrx6Y+E0hOot5A
         ELXA==
X-Forwarded-Encrypted: i=1; AJvYcCX56L8I0I8jZ1fWwya+XF5BVuNA8WESYHwl49k/ka9V5MV1i8kFbQDXr6o3snWVe8ZYexktWVtvK9xGWeMwzecVnp4QNRVtd4bz7JAh
X-Gm-Message-State: AOJu0YxutXD1vVspP8QL3yfx2Nqh6wvM+rQX1M7KwAbTjmUnoG5YrA+p
	Ad5L8xWYnbt1DwbU4nkUSyIZSVzM8a96r2dhh+X4yZP+SX1CaqdL4x75A14fmuE=
X-Google-Smtp-Source: AGHT+IF8gVp35QAbssZYwQbkda1NSCFa/dlYGoWYArn7qZ6L6qxVOw+IPnq/Ln2R//5p8lOw8pFb+w==
X-Received: by 2002:a05:6e02:1c4d:b0:36d:cb9d:cc9e with SMTP id e9e14a558f8ab-3761d72cc51mr112380695ab.2.1719003844208;
        Fri, 21 Jun 2024 14:04:04 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3762f3222ebsm5096615ab.40.2024.06.21.14.04.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jun 2024 14:04:03 -0700 (PDT)
Message-ID: <4962b96d-d2d8-429d-9794-120349741a58@linuxfoundation.org>
Date: Fri, 21 Jun 2024 15:04:03 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpupower: Make help command available for custom install
 dir
To: Roman Storozhenko <romeusmeister@gmail.com>
Cc: Thomas Renninger <trenn@suse.com>, Shuah Khan <shuah@kernel.org>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20240621-fix-help-issue-v1-1-7906998d46eb@gmail.com>
 <6d745d8d-33b1-4aed-b9c5-095073bc8cde@linuxfoundation.org>
 <CALsPMBPd1O2zBxyvfTJiPvuWO+zaTxrYizmiKULr1A-77ME_Rw@mail.gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <CALsPMBPd1O2zBxyvfTJiPvuWO+zaTxrYizmiKULr1A-77ME_Rw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/21/24 12:18, Roman Storozhenko wrote:
> On Fri, Jun 21, 2024 at 5:02 PM Shuah Khan <skhan@linuxfoundation.org> wrote:
>>
>> On 6/21/24 02:13, Roman Storozhenko wrote:
>>> When the 'cpupower' utility installed in the custom dir, it fails to
>>> render appopriate help info for a particular subcommand:
>>
>> appopriate -> appropriate
>> Spell check the commit message.
> 
> Thanks for highlighting this, will fix.
>>
>>> $ LD_LIBRARY_PATH=lib64/ bin/cpupower help monitor
>>> with error message like 'No manual entry for cpupower-monitor.1'
>>> The issue is that under the hood it calls 'exec' function with
>>> the following args: 'man cpupower-monitor.1'. In turn, 'man' search
>>> path is defined in '/etc/manpath.config'. Of course it contains only
>>> standard system man paths.
>>> Make subcommands man pages available for user using the following rule:
>>> Render a man page if it is installed in the custom install dir, otherwise
>>> allow man to search this page by name system-wide as a last resort.
>>>
>>
>> Good find.
>>
>>> Signed-off-by: Roman Storozhenko <romeusmeister@gmail.com>
>>> ---
>>>    tools/power/cpupower/utils/cpupower.c | 54 ++++++++++++++++++++++++++++++-----
>>>    1 file changed, 47 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/tools/power/cpupower/utils/cpupower.c b/tools/power/cpupower/utils/cpupower.c
>>> index 9ec973165af1..da4bc6de7494 100644
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
>>> @@ -21,6 +23,8 @@
>>>    #include "helpers/bitmask.h"
>>>
>>>    #define ARRAY_SIZE(x) (sizeof(x)/sizeof(x[0]))
>>> +#define MAN_REL_PATH "/../man/man1/"
>>> +#define MAN_SUFFIX ".1"
>>>
>>>    static int cmd_help(int argc, const char **argv);
>>>
>>> @@ -80,14 +84,17 @@ static void print_help(void)
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
>>> @@ -97,7 +104,40 @@ static int print_man_page(const char *subpage)
>>>                strcat(page, subpage);
>>>        }
>>>
>>> -     execlp("man", "man", page, NULL);
>>> +     /* Get current process image name full path */
>>> +     if (readlink("/proc/self/exe", exec_path, PATH_MAX) > 0) {
>>> +
>>> +             man_path = malloc(PATH_MAX);
>>> +             if (!man_path) {
>>> +                     free(page);
>>> +                     return -ENOMEM;
>>> +             }
>>> +
>>> +             exec_dir = strdup(exec_path);
>>> +             if (!exec_dir) {
>>> +                     free(page);
>>> +                     free(man_path);
>>> +                     return -ENOMEM;
>>> +             }
>>> +
>>> +             *man_path = '\0';
>>> +             strncat(man_path, dirname(exec_dir), strlen(exec_dir));
>>> +             strncat(man_path, MAN_REL_PATH, strlen(MAN_REL_PATH));
>>> +             strncat(man_path, page, strlen(page));
>>> +             strncat(man_path, MAN_SUFFIX, strlen(MAN_SUFFIX));
>>> +
>>> +             free(exec_dir);
>>> +
>>> +             /* Check if file exists */
>>> +             if (access(man_path, F_OK) == -1) {
>>> +                     free(man_path);
>>> +                     man_path = page;
>>> +             }
>>> +     } else {
>>> +             man_path = page;
>>> +     }
>>> +
>>> +     execlp("man", "man", man_path, NULL);
>>
>> You can simplify all of this by using getenv() to get the environment
>> variables for the program.
>>
>> Take a look getenv() usages in the kernel sources for reference.
> 
> If you mean that I can extract the current working directory and then add
> relative path to man page to it then yes, I can. But the issue with
> this approach
> is that this will work only if I run the binary from its directory,
> otherwise it fail,
> because current_working_directory is not the image_path. And there is no
> environment variable which defines the path to the process's binary.
> Just in case, I looked to the kernel sources which use getenv() in userspace and
> also examined the list of the POSIX environment variables:
> https://pubs.opengroup.org/onlinepubs/9699919799/basedefs/V1_chap08.html
> And nothing came to my mind in terms of simplification.
> So, please suggest me what I could change.
> 

How about setting MANPATH before running the command?

thanks,
-- Shuah




