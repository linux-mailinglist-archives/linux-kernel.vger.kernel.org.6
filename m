Return-Path: <linux-kernel+bounces-311518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33345968A08
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 16:35:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DFEF1C20C21
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 14:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96FD21A2635;
	Mon,  2 Sep 2024 14:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WLvWFQ2i"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8234C1A2622;
	Mon,  2 Sep 2024 14:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725287716; cv=none; b=bvQFvz1+x4i7T2MvrdFGwcutlDkn0nw9RzEjqkRxGpDwyNz2uPJVipds01zA4ZRDa9xxF9swsuFNIyqEZtCj1bdTZuei1OYkc4hkPsn+5Ke3nJyUiNV1gKcosNyS010w4uPFyUtiqPyzIPGeBhcmCelXNm1bDUfdBPe7uOtw5S4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725287716; c=relaxed/simple;
	bh=00guibkwtRNUAm7l+mrSZBpcT0SVm1AnQYBAkp2gYsM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KYTyQfvdaTHVbThPmrYdfiRrN1N5FboE5hF9MDHYO/EHDS6BBN2k6gPDISPWbRhhD+38GNUm2wrgsAA+i5lSWpbxlkBIrpw7m+s9RXI6ev2/CZUpHcENRtvKMzTHzDCO8gyzlt842bTczXgRjcQqxhA8ULv4wDeBuQQQUHAbeVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WLvWFQ2i; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-70cec4aa1e4so3075746b3a.1;
        Mon, 02 Sep 2024 07:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725287714; x=1725892514; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=RvaEgsvt3EmKxcrvNBVRbDBwpGvxKdEq5Ms4mTY66+8=;
        b=WLvWFQ2ipPTQCrdw47JdCZJzzlz1RF/O+F4k6NszjZlTSfbtOL648smVjfKB65fm/9
         HvLHxHvr0Ey3yl1bS7pMtyKMQiTJ/HGEXXROWq3iNM05zuKtV3jlruCdlam6OSE96lAn
         6jBNylh6ztrdCLPTq1KgC4oFxpAnt0DyZwuqRIehuJ9Fp/1vmOQcF6OqME9sAdTevhDq
         CskaYRkBUQ4TJKSDngz1+j8cV8mMYxuPj8mEOljxA+e3fXKr+RfSQ8eYi0GVOUBUPO7g
         DBJ8Kk/6eeA64NlIoM8z2/FrGfn40nDWeQUbj7oLoGkL7OAGIsjgm842fNTHtSd5xYRy
         lRog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725287714; x=1725892514;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RvaEgsvt3EmKxcrvNBVRbDBwpGvxKdEq5Ms4mTY66+8=;
        b=Lly6a2pDESIQBV9zwEynckXd+/GdpmU0G1ThfD4rHnO/aJFZEwj7x1u4pNqLVpWq54
         +nddit1lZJLVIlIWUeKa4KKbz5sTqRPheb6MSpIveUUcHGpC5wmuUs7v1aktIhPfSIIK
         gdFeUgo3McA4fTsua/7nSMsFQe1Cs0ishGn5q7xSTIjgluh2LsbMNQ6tR5i30PL3BLz1
         W7Ut+gidmxkkN6lJYIGiwffL5hxd2WfhqZia0fSWjsSCurIFkZ8KuGEa6pePanu4f4oH
         S3D7SqbF62KqJj1Nda6Dk48XjeXU/LxNIjRk5J1RG8LRz8X+ds4bVH3qCFdL4H+gPUh3
         rYFw==
X-Forwarded-Encrypted: i=1; AJvYcCVlEvQIOQ6Hj2qdbyNz9tkcNQvowo2BGfeAgCrg/gvzUuVNALIhAn9C46v7Gq7SjNemhxFuMNU5aaVbfsu4@vger.kernel.org, AJvYcCWnwlhM0x8h17IOMve26TswFLq5LBbcaBOvnWO4BoqX4W33Tq7jnx1I9eaJQCqPQTLIhfHbtcznntspMg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxR2ymz31S9gy5vpV59QkurAb0YvTieWrQ5cM3rWiYebIu9wKk/
	0TqSA20Ox74TLmZeA2fYJZTGe2KoZW64LTmBa4CwEenPUPMIBjJp
X-Google-Smtp-Source: AGHT+IGbIql4DBM1UPL4+b6z8TFkZXNpV/rNV1zjv2OV0Q8ZhEXfZfcComyGcd9kjMlo3td56B91iw==
X-Received: by 2002:a05:6a00:1398:b0:714:10d2:baae with SMTP id d2e1a72fcca58-715dfc039cemr17998340b3a.14.1725287713611;
        Mon, 02 Sep 2024 07:35:13 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-715e575c3efsm6909357b3a.202.2024.09.02.07.35.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Sep 2024 07:35:13 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <7ac1f26b-2a1c-433b-96bd-920d1846b04a@roeck-us.net>
Date: Mon, 2 Sep 2024 07:35:11 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/5] hwmon: pmbus: Implement generic bus access delay
To: Patrick Rudolph <patrick.rudolph@9elements.com>,
 linux-kernel@vger.kernel.org
Cc: jdelvare@suse.com, linux-hwmon@vger.kernel.org
References: <20240902075319.585656-1-patrick.rudolph@9elements.com>
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
In-Reply-To: <20240902075319.585656-1-patrick.rudolph@9elements.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/2/24 00:53, Patrick Rudolph wrote:
> Some drivers, like the max15301 or zl6100, are intentionally delaying
> SMBus communications, to prevent transmission errors. As this is necessary
> on additional PMBus compatible devices, implement a generic delay mechanism
> in the pmbus core.
> 
> Introduces two delay settings in the pmbus_driver_info struct, one applies
> to every SMBus transaction and the other is for write transaction only.
> Once set by the driver the SMBus traffic, using the generic pmbus access
> helpers, is automatically delayed when necessary.
> 
> The two settings are:
> access_delay:
>    - Unit in microseconds
>    - Stores the accessed timestamp after every SMBus access
>    - Delays when necessary before the next SMBus access
> 
> write_delay:
>    - Unit in microseconds
>    - Stores the written timestamp after a write SMBus access
>    - Delays when necessary before the next SMBus access
> 
> This allows to drop the custom delay code from the drivers and easily
> introduce this feature in additional pmbus drivers.
> 
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>

Series applied.

Thanks,
Guenter


