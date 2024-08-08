Return-Path: <linux-kernel+bounces-279729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7921B94C102
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 17:24:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A49831C20FA6
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 15:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB07A1922DF;
	Thu,  8 Aug 2024 15:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DJ+el6oW"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE80C191494
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 15:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723130508; cv=none; b=p3aFRLt+GxQG2653apn7M3cuC6sSuI90anFSD3VxJpe2T5h9w1wJFM6ZG+rtGHWTXV4rFlht39eZyLeCX740TyYnUHyEji9JQOOjuOezH6NggDZRa9ZfJpbgZFyVBv3idUesnQMKqE53gltKXchgoS1l+efpVEl8g9GkDhgLjnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723130508; c=relaxed/simple;
	bh=YlWIdXh4ny6vjcE1XhIC4riSiz794KXskD34jiHAeA8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MT9DUfBlKfr71gOBaUsfGcGWvQ16nITpdjP3T9ZIUkVPEJPcHz/DwrinAJikO1vfAU7yaVWZNqoB9fY1RfqjAdJejEQBIW5LqLhUPQO0IIkhnCmAH/rmb8JkaM49u6BYVQx1X/iVIqLxdAsdu1oZQHzGr5eOg7T3UXSivR8xdo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DJ+el6oW; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1fc6ee64512so10084305ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 08:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723130506; x=1723735306; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=ECZuBMqNALSfPXfP6lwUr9I4uhBcMrsy5RRDfjTSSRE=;
        b=DJ+el6oWXldTnc3wGwurQFx/h7STFwCd8r31mZgUV2+HNKAdUe8FhG+y+VBYjY+AgS
         ke0slVMek4NOtMmlfQKWVjxrLBAcCuKz9rOMPmZbqG/rkA8W21llPBCQSJfgQjN2ZmNt
         DhGY51+qM5GNXEazz2G6RsvqhHqUO4Ig1DDPYN+stSJtmqlzOXdF8mxQIjazwz2Fdqe0
         NR7wQ4QsmpqHZ+mkjnnNAYtkoUJ6K81EqFGr4Zlx7pjzD2GemUrTAH8qN8CSCEE+VFwI
         z9bL6TKG+5K9gLI7Vf+xXyjhSqpRxpVT/PQAvCBnb0JTw+NaNNjk5S6AwTnKg00twxz+
         dUIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723130506; x=1723735306;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ECZuBMqNALSfPXfP6lwUr9I4uhBcMrsy5RRDfjTSSRE=;
        b=pYiBq2SB7MvRPBMviwiJ3HKhPC95Yy8f0TTwcNGCI7kt80WNz2g9ISueUe7+tAa3n7
         wKwU1bog3G/rtm6TrJodEywegCZyqI5eT6ZGFIG6ydQ6dngOpkp0kS0arIOnbQf6+mrd
         i1LaiRbihy8s8I5yEJNlOpFgp/l/6Vym+vO120yQZBJtf8xAOIo2pE7oHWvb69TLdJKf
         i6E6g2pY7CfU2K1q8lVLQNAqYwNUZk0Ry+3G8LirgnaCB9W/LM6CZD2ftQMIfh57k029
         +9WSF7qXqAG/SBFxZoS4KZQP3pubayWgoGQQa10G7GOkLz3lD/7o7Fs0KHhBLFe240QR
         jfQw==
X-Gm-Message-State: AOJu0YyjbG7mS3qBGTjc24DMY0zUNIsXj6qpUc7vMtbWWDi/9vKPYmCp
	/oXlld6d1yu/7tw+XBGCos9n8lXj3JzjVNN7mKIOYqSLYUVeB6v/
X-Google-Smtp-Source: AGHT+IEaTDbHEmHyY6PkpkaK+rB1odgrnlhUQ2wPTFl2t9qUOypCDST48hHI3VkOA3uRfaZ0OgsN6A==
X-Received: by 2002:a17:902:f710:b0:1fb:9b47:b642 with SMTP id d9443c01a7336-20095263175mr21287495ad.31.1723130506013;
        Thu, 08 Aug 2024 08:21:46 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff58f19ca6sm126481525ad.49.2024.08.08.08.21.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Aug 2024 08:21:45 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <e4d6e891-8d93-4539-875f-802a2c1834ae@roeck-us.net>
Date: Thu, 8 Aug 2024 08:21:44 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 16/23] powerpc/e500: Switch to 64 bits PGD on 85xx (32
 bits)
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Nicholas Piggin <npiggin@gmail.com>, "linux-mm@kvack.org"
 <linux-mm@kvack.org>, Peter Xu <peterx@redhat.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Oscar Salvador <osalvador@suse.de>
References: <cover.1719928057.git.christophe.leroy@csgroup.eu>
 <ca85397df02564e5edc3a3c27b55cf43af3e4ef3.1719928057.git.christophe.leroy@csgroup.eu>
 <2c7adbc9-609d-41a9-8a3b-a63d59e21a1f@roeck-us.net>
 <AM0PR07MB496234BE973D5458C53517F29BB12@AM0PR07MB4962.eurprd07.prod.outlook.com>
 <4f46d614-0fbb-452b-a778-b7b3a7f6da8b@roeck-us.net>
 <b73e991e-5f66-455e-a271-e10511ebeaef@csgroup.eu>
 <5cc43ed9-b4f8-49f5-99ee-b411bb144085@roeck-us.net>
 <17eed040-969e-4d2c-b20b-ecfd93450901@csgroup.eu>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 xsFNBE6H1WcBEACu6jIcw5kZ5dGeJ7E7B2uweQR/4FGxH10/H1O1+ApmcQ9i87XdZQiB9cpN
 RYHA7RCEK2dh6dDccykQk3bC90xXMPg+O3R+C/SkwcnUak1UZaeK/SwQbq/t0tkMzYDRxfJ7
 nyFiKxUehbNF3r9qlJgPqONwX5vJy4/GvDHdddSCxV41P/ejsZ8PykxyJs98UWhF54tGRWFl
 7i1xvaDB9lN5WTLRKSO7wICuLiSz5WZHXMkyF4d+/O5ll7yz/o/JxK5vO/sduYDIlFTvBZDh
 gzaEtNf5tQjsjG4io8E0Yq0ViobLkS2RTNZT8ICq/Jmvl0SpbHRvYwa2DhNsK0YjHFQBB0FX
 IdhdUEzNefcNcYvqigJpdICoP2e4yJSyflHFO4dr0OrdnGLe1Zi/8Xo/2+M1dSSEt196rXaC
 kwu2KgIgmkRBb3cp2vIBBIIowU8W3qC1+w+RdMUrZxKGWJ3juwcgveJlzMpMZNyM1jobSXZ0
 VHGMNJ3MwXlrEFPXaYJgibcg6brM6wGfX/LBvc/haWw4yO24lT5eitm4UBdIy9pKkKmHHh7s
 jfZJkB5fWKVdoCv/omy6UyH6ykLOPFugl+hVL2Prf8xrXuZe1CMS7ID9Lc8FaL1ROIN/W8Vk
 BIsJMaWOhks//7d92Uf3EArDlDShwR2+D+AMon8NULuLBHiEUQARAQABzTJHdWVudGVyIFJv
 ZWNrIChMaW51eCBhY2NvdW50KSA8bGludXhAcm9lY2stdXMubmV0PsLBgQQTAQIAKwIbAwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4ACGQEFAlVcphcFCRmg06EACgkQyx8mb86fmYFg0RAA
 nzXJzuPkLJaOmSIzPAqqnutACchT/meCOgMEpS5oLf6xn5ySZkl23OxuhpMZTVX+49c9pvBx
 hpvl5bCWFu5qC1jC2eWRYU+aZZE4sxMaAGeWenQJsiG9lP8wkfCJP3ockNu0ZXXAXwIbY1O1
 c+l11zQkZw89zNgWgKobKzrDMBFOYtAh0pAInZ9TSn7oA4Ctejouo5wUugmk8MrDtUVXmEA9
 7f9fgKYSwl/H7dfKKsS1bDOpyJlqhEAH94BHJdK/b1tzwJCFAXFhMlmlbYEk8kWjcxQgDWMu
 GAthQzSuAyhqyZwFcOlMCNbAcTSQawSo3B9yM9mHJne5RrAbVz4TWLnEaX8gA5xK3uCNCeyI
 sqYuzA4OzcMwnnTASvzsGZoYHTFP3DQwf2nzxD6yBGCfwNGIYfS0i8YN8XcBgEcDFMWpOQhT
 Pu3HeztMnF3HXrc0t7e5rDW9zCh3k2PA6D2NV4fews9KDFhLlTfCVzf0PS1dRVVWM+4jVl6l
 HRIAgWp+2/f8dx5vPc4Ycp4IsZN0l1h9uT7qm1KTwz+sSl1zOqKD/BpfGNZfLRRxrXthvvY8
 BltcuZ4+PGFTcRkMytUbMDFMF9Cjd2W9dXD35PEtvj8wnEyzIos8bbgtLrGTv/SYhmPpahJA
 l8hPhYvmAvpOmusUUyB30StsHIU2LLccUPPOwU0ETofVZwEQALlLbQeBDTDbwQYrj0gbx3bq
 7kpKABxN2MqeuqGr02DpS9883d/t7ontxasXoEz2GTioevvRmllJlPQERVxM8gQoNg22twF7
 pB/zsrIjxkE9heE4wYfN1AyzT+AxgYN6f8hVQ7Nrc9XgZZe+8IkuW/Nf64KzNJXnSH4u6nJM
 J2+Dt274YoFcXR1nG76Q259mKwzbCukKbd6piL+VsT/qBrLhZe9Ivbjq5WMdkQKnP7gYKCAi
 pNVJC4enWfivZsYupMd9qn7Uv/oCZDYoBTdMSBUblaLMwlcjnPpOYK5rfHvC4opxl+P/Vzyz
 6WC2TLkPtKvYvXmdsI6rnEI4Uucg0Au/Ulg7aqqKhzGPIbVaL+U0Wk82nz6hz+WP2ggTrY1w
 ZlPlRt8WM9w6WfLf2j+PuGklj37m+KvaOEfLsF1v464dSpy1tQVHhhp8LFTxh/6RWkRIR2uF
 I4v3Xu/k5D0LhaZHpQ4C+xKsQxpTGuYh2tnRaRL14YMW1dlI3HfeB2gj7Yc8XdHh9vkpPyuT
 nY/ZsFbnvBtiw7GchKKri2gDhRb2QNNDyBnQn5mRFw7CyuFclAksOdV/sdpQnYlYcRQWOUGY
 HhQ5eqTRZjm9z+qQe/T0HQpmiPTqQcIaG/edgKVTUjITfA7AJMKLQHgp04Vylb+G6jocnQQX
 JqvvP09whbqrABEBAAHCwWUEGAECAA8CGwwFAlVcpi8FCRmg08MACgkQyx8mb86fmYHNRQ/+
 J0OZsBYP4leJvQF8lx9zif+v4ZY/6C9tTcUv/KNAE5leyrD4IKbnV4PnbrVhjq861it/zRQW
 cFpWQszZyWRwNPWUUz7ejmm9lAwPbr8xWT4qMSA43VKQ7ZCeTQJ4TC8kjqtcbw41SjkjrcTG
 wF52zFO4bOWyovVAPncvV9eGA/vtnd3xEZXQiSt91kBSqK28yjxAqK/c3G6i7IX2rg6pzgqh
 hiH3/1qM2M/LSuqAv0Rwrt/k+pZXE+B4Ud42hwmMr0TfhNxG+X7YKvjKC+SjPjqp0CaztQ0H
 nsDLSLElVROxCd9m8CAUuHplgmR3seYCOrT4jriMFBtKNPtj2EE4DNV4s7k0Zy+6iRQ8G8ng
 QjsSqYJx8iAR8JRB7Gm2rQOMv8lSRdjva++GT0VLXtHULdlzg8VjDnFZ3lfz5PWEOeIMk7Rj
 trjv82EZtrhLuLjHRCaG50OOm0hwPSk1J64R8O3HjSLdertmw7eyAYOo4RuWJguYMg5DRnBk
 WkRwrSuCn7UG+qVWZeKEsFKFOkynOs3pVbcbq1pxbhk3TRWCGRU5JolI4ohy/7JV1TVbjiDI
 HP/aVnm6NC8of26P40Pg8EdAhajZnHHjA7FrJXsy3cyIGqvg9os4rNkUWmrCfLLsZDHD8FnU
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <17eed040-969e-4d2c-b20b-ecfd93450901@csgroup.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/8/24 02:36, Christophe Leroy wrote:
> 
> 
> Le 07/08/2024 à 16:51, Guenter Roeck a écrit :
>> On 8/7/24 03:11, Christophe Leroy wrote:
>>> Hi,
>>>
>>> Le 31/07/2024 à 18:35, Guenter Roeck a écrit :
>>>> On 7/31/24 08:36, LEROY Christophe wrote:
>>>>>
>>>>> Hi Guenter,
>>>>> Thanks for this report. I'm afk this week, i"ll have a look at it in more détails next week.
>>>>> But to be sûre, does that Oops match the bisected commit ? Because pmd_leaf()  for e500 doesn't exist yet so pmd_write() shouldnt be called.
>>>>> I did validate all my changes with mpc8544 on qemu when i implemented this séries, using map_hugetlb mm selftest. What test tool are you using ?
>>>>
>>>> Nothing special; it is just a qemu boot test with various module test and debug options enabled,
>>>> using a root file system generated with buildroot.
>>>
>>> I still don't get anything with mpc85xx_defconfig.
>>>
>>> Can you tell with debug options you use and which module tests ?
>>>
>>
>> Please see https://eur01.safelinks.protection.outlook.com/?url=http%3A%2F%2Fserver.roeck-us.net%2Fqemu%2Fppc-v6.11-rc2%2F&data=05%7C02%7Cchristophe.leroy%40csgroup.eu%7Cfd337af1375448bcda1508dcb6f06644%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C638586390853555531%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&sdata=7kihrxw5%2FrCI6TzmxGM56tEmghc1Bj7b1czXuM0%2BVrk%3D&reserved=0.
>>
> 
> Thanks,
> 
> CONFIG_SLUB_DEBUG_ON is what exhibits the problem.
> 
> I sent out a patch: https://patchwork.ozlabs.org/project/linuxppc-dev/patch/1cdaacb391cbd3e0240f0e0faf691202874e9422.1723109462.git.christophe.leroy@csgroup.eu/
> 
> With that patch I can successfully boot your config.
> 
> Can you give it a test ?
> 

Done; the patch fixes the problem for me.

Thanks!
Guenter



