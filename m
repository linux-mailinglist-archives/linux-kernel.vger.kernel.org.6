Return-Path: <linux-kernel+bounces-268023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16317941F7C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 20:22:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 394131C22E7F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 18:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84D3218A92F;
	Tue, 30 Jul 2024 18:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hqGfP+GT"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E9D18A6DD
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 18:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722363757; cv=none; b=hob0QUmkCkgvGI5CyBuMwdCFHaG0BqvcvZwSWEXiYcN2pvHSCi98YAwK+QOX1mr+SGngRgVNlsqy13mXQN6F6xxKbLCJa/XLk308L7a2gRDGFjxd0t7XOwG+/IpFRv3a150q6T63gOJT0dR2/vqqqSmRdUPb+WHBh+lAX4PqvlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722363757; c=relaxed/simple;
	bh=cWdsxSSY9bCGXCxVlGXkkFL2YFDuN2cWdJkpLihqIyo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cXcgf5bKJ90emVqPPoxN1NQhFMVx7LXFnr46w4AoBMjLyWFD9zUyvPnsNT9vGJtfRdmt1+ZfvBw+6mgKpivf32OLYXBwVHQ0HBKo2tGc3n3anRi4fy2xxkhpRHEpFKbekGQCPp432nNA6SK4kk+BwzkLvFvw4SNhXQgwafKjtrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hqGfP+GT; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-70d316f0060so94466b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 11:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722363755; x=1722968555; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=WuuUhMYQQSlR+3Pwz3JpqDaA99BP6vvzQyK5UCiRXC8=;
        b=hqGfP+GTwwJC6TkTeR/yAmweYFJD5rds9uqkHH4Jul8CR97PtfCe/mdXPg+5Hw5R1C
         aEn1eyoj9vfG1FG9DN1ft0bLJnNsnzgflMP1TNsUzRvDAFrrN0SWL1acfGZkIr2BqF/v
         BnlRKGdCMyYejjq823bLFjQbZyrvm4I0tXmT9irtNUUN+62H+JnGJbFHB64li53mdDel
         /RiZvqlD1dJ8iEZXda5h2neF6FlI9eAZMg7UgnvuLZpSFeLD/UqSc1EJ4ZCtpMw9h/+5
         x61VmZ3x3s/XEfKWEeLNHLizCN08CDBRgcRsP5kEcxb4C2mU4RckzmRef3n140qqW3jv
         eVCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722363755; x=1722968555;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WuuUhMYQQSlR+3Pwz3JpqDaA99BP6vvzQyK5UCiRXC8=;
        b=an4C2WqQIz4zHzMlF5CeCDfgHL6IQCn+OjBUsIMCmW4A05mS8QHrdA4mFnK6kaGjZJ
         wnvf7IoZ5BfGZKdE8yzk+CwF4Y4ZA3ti0fg2jY6kfYtZ/NPWtnApjbkfTHpFG/oJCFPz
         AegCXVQmbRaKBQaLIKmJbRIGbyhTjawFTU2szXx3s2GaZ7N7BZa4Lgh9Svat4Tt0lfj/
         DnO8fwvjwVtTgG4s12tca0cau5uQU8BgTAwolIJNOY8Vxv7M4pfeJTGNgRQMrxD8LxO2
         uDL5jScE2gbdMSMR9fCfOY9c2LH8EKCa1kl/5XYWZpBa0yAlva369TCVHxNOWB93rYA7
         u3aQ==
X-Gm-Message-State: AOJu0YzQ1EqJNnzC2zCyLSj9tHhnFLoCKbS8cMwo+I6yefFqZSSUdwT8
	vy0Lj/0laeDOh032X7NitF5mXzWVL2UZrBBTiMF2tEGTDKA8Wxci
X-Google-Smtp-Source: AGHT+IGECf6xmV4GfG+RKVds6vioSvQK/uZUwDxVBpuXJ5RIJ8oK1TM2NyE5UqD5RCq9/QzuUa6DPA==
X-Received: by 2002:a05:6a20:a11a:b0:1bd:1d5f:35be with SMTP id adf61e73a8af0-1c4e47a42b3mr4823781637.11.1722363755243;
        Tue, 30 Jul 2024 11:22:35 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70ead89fd67sm8705554b3a.192.2024.07.30.11.22.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jul 2024 11:22:34 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <5963cdad-40be-4278-a84e-2a804334e77c@roeck-us.net>
Date: Tue, 30 Jul 2024 11:22:32 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Linux 6.11-rc1
To: Jens Axboe <axboe@kernel.dk>,
 Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <CAHk-=wiyNokz0d3b=GRORij=mGvwoYHy=+bv6m2Hu_VqNdg66g@mail.gmail.com>
 <f8677c93-a76d-473c-8abc-8dc7b4403691@roeck-us.net>
 <b7ecddb7-4486-4b2d-9179-82250cf830e7@roeck-us.net>
 <63e7adbf-0eb8-4d59-ae7a-689b9d9f69b4@kernel.dk>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <63e7adbf-0eb8-4d59-ae7a-689b9d9f69b4@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/30/24 10:20, Jens Axboe wrote:
> On 7/30/24 11:04 AM, Guenter Roeck wrote:
>> On Mon, Jul 29, 2024 at 08:29:20AM -0700, Guenter Roeck wrote:
>>> On Sun, Jul 28, 2024 at 02:40:01PM -0700, Linus Torvalds wrote:
>>>> The merge window felt pretty normal, and the stats all look pretty
>>>> normal too. I was expecting things to be quieter because of summer
>>>> vacations, but that (still) doesn't actually seem to have been the
>>>> case.
>>>>
>>>> There's 12k+ regular commits (and another 850 merge commits), so as
>>>> always the summary of this all is just my merge log. The diffstats are
>>>> also (once again) dominated by some big hardware descriptions (another
>>>> AMD GPU register dump accounts for ~45% of the lines in the diff, and
>>>> some more perf event JSON descriptor files account for another 5%).
>>>>
>>>> But if you ignore those HW dumps, the diff too looks perfectly
>>>> regular: drivers account for a bit over half (even when not counting
>>>> the AMD register description noise). The rest is roughly one third
>>>> architecture updates (lots of it is dts files, so I guess I could have
>>>> lumped that in with "more hw descriptor tables"), one third tooling
>>>> and documentation, and one third "core kernel" (filesystems,
>>>> networking, VM and kernel). Very roughly.
>>>>
>>>> If you want more details, you should get the git tree, and then narrow
>>>> things down based on interests.
>>>>
>>>
>>> Build results:
>>> 	total: 158 pass: 139 fail: 19
>>> Failed builds:
>> ...
>>> 	i386:q35:pentium3:defconfig:pae:nosmp:net=ne2k_pci:initrd
>>
>> This failure bisects to commit 0256994887d7 ("Merge tag
>> 'for-6.11/block-post-20240722' of git://git.kernel.dk/linux"). I have no
>> idea why that would be the case, but it is easy to reproduce. Maybe it is
>> coincidental. Either case, copying Jens in case he has an idea.
> 
> I can take a look, but please post some details on what is actually
> being run here so I can attempt to reproduce it. I looked at your
> initial email too, and there's a link in there to:
> 
> https://kerneltests.org/builders
> 
> but I'm still not sure what's being run.
> 

Please see http://server.roeck-us.net/qemu/x86-nosmp/

Thanks,
Guenter


