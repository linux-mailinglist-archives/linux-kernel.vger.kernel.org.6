Return-Path: <linux-kernel+bounces-428044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 130399E0964
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 18:05:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E45E71627A2
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 17:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BD851D9A42;
	Mon,  2 Dec 2024 17:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iMYkr5se"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1299E15ADA6
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 17:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733158950; cv=none; b=pkZjAhZZz9MyQn7qeT/OCsv1ARb2vk4u21lV+5c+3fXBAhWWu/vJCIE+qua/CGTlcdM+13Z02z4KeRWqJVvoEGjd5wBkMapYVBrFIG6DNo3gdrgeUA0uLc0n3iBg+RmcVa2SlF8+cNsGNcutbRdIipUenr9/BSEg6gc/1tpgliU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733158950; c=relaxed/simple;
	bh=YwbLF60fuSt2sjVmULmyiMlfIeKWOK251W47T9cqABo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bAeS05YTf0TzOsfypLoipf9s4r2N7mKX1nojt/t6Ev35aLE89PFjCUr7mElmmuIYcb/liS8x0Q1eC9hFlje5lcPpyzCyMzwQdms4ZPxibiSfc5bCX9XP9egWyKx9PISOY7f9VSWQGKrrGkmutDD2TK2FQTU7fgfVdKL0dJY8/zA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iMYkr5se; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2e56750bb0dso3247487a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 09:02:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733158948; x=1733763748; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=9/33dK4XCyA4IU9W5HnFJwhdO4HJGY77cL68SO6s4ss=;
        b=iMYkr5se8nFiSgGY9hFn0RJZOyPzZ7f2wNT4XqdZvfiIZrNMd996kUkOvG/HGaEvpw
         L2bJ36joTjevOLK+Eh8UUhhV34TqRq3whLXk4nDIih764Lo17d0/wD+cLewUkjer2Pq2
         SDxQ8yMB/c2Kp1i35em6g525uEP6iqtpODZ26D0BsPhdtAULGottS6+rKUrtRl1+SNkA
         8lFonOy+Syd6EqFK3s3AiTjChPNVbLA9WABiawHTEZkZ0nhp0ldmQk8PBmV0xG4dMfSq
         XNqJOr5LoSaxW4RD3rDVA4EKuHgneLMgD3unem8QiqQr5AV1dv2ot9VwLObONc+iaTGt
         ig6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733158948; x=1733763748;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9/33dK4XCyA4IU9W5HnFJwhdO4HJGY77cL68SO6s4ss=;
        b=hjmasCiUNrr7lHny5zrImSQhAvMn4Cw85RttwDOW/nSBWh1YjNgyn6YfEomAFjlCet
         1OWWhH9FRHjXnzeDS6E+oP3oKdliMSgFx54mW9pylC2THIaKoElc/kkPIu4pTTfeypxt
         LbuAHtgB8Jolw1NIRUPATF9xlckDe2LJ6ULppcYx45Tx+SoC/4kjdBTJ/5stzWVLryIr
         uV/Z7wXFM2uEbP6KkPfRY83SlRY1Osscfg6B92799lXVKqoAC2ud+Kis6ws5m5xxJluJ
         zE6ecQD9Bmif4J9Frhi54GbcPnusZ2btx026H4PwatmTCRxLx9Vk/y4cF3fnW5D5Da5K
         e7kQ==
X-Forwarded-Encrypted: i=1; AJvYcCWTS/td374UUFsRwdokm7fjTi0rtB0pszbH9f/yiGdtpHHhfl4cwQCeEq1sfVKFC8k5aBRuB8kN+AWfOzY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKGeUFYWQPhAWe2JRL0Rnm6zul9POgvHB7Vd4a/AkMqXzUPsOb
	hyfdfk2Mw1kDJY5sACR2XfxEVndji7go/NUeqq5UGoeL+B0RLMxw
X-Gm-Gg: ASbGncuReRLYm5fOdMqY7jgTQKegS5gwdYIVClLpr7eV0aQ+6inkAVraVXB/5pvrEng
	8xdT/DBf7jH6FX+14KgeHDe1V7QJVNflIhwg1RsMPB09CUpqLU1yt5Orj9ln8mCfiukdTXRoC4b
	x4bHg4aB2FtcvC+VICO4/6VYeTPAHhY414NPGnjsLCO3netw4Kqn+2zfWfwmKXIG8MqfUZSByqz
	k+dSr9YdCWf+siCUZzWi6BsbJjQB2OB/7TidzOWJR6QnJjZfAavUEo47t0JF5kRROmk2BgJEVA2
	+cC7XYNSN6+mmbIUM6YFzzo=
X-Google-Smtp-Source: AGHT+IGuZ9Vpxm3OP07gdp6xrQD8sAGyBwfeNHZF6AWFTnG9yMGoxnLC8/WC8qFLXX2whimuEuuywg==
X-Received: by 2002:a17:90b:1d03:b0:2ee:e518:c1cb with SMTP id 98e67ed59e1d1-2eee518c3c2mr2937167a91.7.1733158948135;
        Mon, 02 Dec 2024 09:02:28 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ee5a8a7f5csm6435121a91.14.2024.12.02.09.02.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Dec 2024 09:02:27 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <c92efa1b-7353-4e54-982d-9d861fe36e68@roeck-us.net>
Date: Mon, 2 Dec 2024 09:02:25 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] Staging driver changes for 6.13-rc1
To: Dave Penkler <dpenkler@gmail.com>
Cc: Greg KH <gregkh@linuxfoundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Stephen Rothwell <sfr@canb.auug.org.au>, linux-kernel@vger.kernel.org,
 linux-staging@lists.linux.dev
References: <Z0lCyXBV06VyH96s@kroah.com>
 <f10e976e-7a04-4454-b38d-39cd18f142da@roeck-us.net>
 <2024113025-sly-footer-3462@gregkh>
 <7d7e65af-b818-45de-a92c-ee59a864dbdb@roeck-us.net> <Z02Cz6GbdtGNPywE@egonzo>
 <f4ded99e-35c7-4651-8c73-376390ceb130@roeck-us.net> <Z03TqThAOa29MEjD@egonzo>
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
In-Reply-To: <Z03TqThAOa29MEjD@egonzo>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/2/24 07:35, Dave Penkler wrote:
> On Mon, Dec 02, 2024 at 06:52:28AM -0800, Guenter Roeck wrote:
>> On Mon, Dec 02, 2024 at 10:50:07AM +0100, Dave Penkler wrote:
>> [ ... ]
>>> That is weird: the type of resource.start is resource_size_t which resolves to u32 via phys_addr_t on i386 which should be the same size as void *
>>> For compile check purposes simply changing iobase type to phys_addr_t the following error message appears:
>>>
>>> drivers/staging/gpib/ines/ines_gpib.c: In function 'ines_common_pci_attach':
>>> drivers/staging/gpib/ines/ines_gpib.c:783:28: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]
>>>    783 |         nec_priv->iobase = (void *)(pci_resource_start(ines_priv->pci_device,
>>>        |                            ^
>>> drivers/staging/gpib/ines/ines_gpib.c:783:26: error: assignment to 'phys_addr_t' {aka 'long long unsigned int'} from 'void *' makes integer from pointer without a cast [-Wint-conversion]
>>>    783 |         nec_priv->iobase = (void *)(pci_resource_start(ines_priv->pci_device,
>>>        |                          ^
>>>
>>> It would seem that for some reason phys_addr_t resolves to long long unsigned int
>>
>> Check out CONFIG_X86_PAE, which adds 64-bit physical address support to
>> 32-bit x86 images. Pointers are still 32 bit in that mode, though.
>>
>> Guenter
> OK thanks. I will submit a patch to use ioremap.
> -Dave

FWIW, I applied the following patch (hack) to my fixes branch to get around
the build problem.

Guenter

---
diff --git a/drivers/staging/gpib/Kconfig b/drivers/staging/gpib/Kconfig
index 9ee432316465..a9fe2920d5c0 100644
--- a/drivers/staging/gpib/Kconfig
+++ b/drivers/staging/gpib/Kconfig
@@ -1,6 +1,7 @@
  # SPDX-License-Identifier: GPL-2.0
  menuconfig GPIB
         tristate "Linux GPIB drivers"
+       depends on !X86_PAE
         help
           Enable support for GPIB cards and dongles for Linux.  GPIB
           is the General Purpose Interface Bus which conforms to the


