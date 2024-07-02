Return-Path: <linux-kernel+bounces-238339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86136924885
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 21:42:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A91ED1C20CDA
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 19:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABAD61CE099;
	Tue,  2 Jul 2024 19:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C9SyRAOr"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FBA26E5ED;
	Tue,  2 Jul 2024 19:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719949319; cv=none; b=XNAXK+Lnwd8bb4HqlKhC++gL06flhfO9poP9IlF7M7eyGnn3UsuP99CLBmV74TbFJSWpY1ZHMIdMaIAAnwicc2ISgNJkSkenga8AeMWWv/GYzOFHAzwW569oNNoShUl2t8GzCWrvHPLXxYZrgB45zMlVZw/HPzj0/4nU0E0nJPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719949319; c=relaxed/simple;
	bh=TZGcjbtvTsnrvFBj3xqWqx8rGJ5OZrkJk7XtA1uzbdw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RKn8FKL4t+6bTp2Cp082YvwQ80pte0EnX85IFPKl6HCyB4vDokyS0outht9HmH9mtLThnhTlWGgF1eE3g9uxnFIFLJLmu1xBQGpn0JhhhXtKS9su82e1w3+BqqL2bgw7mcVN9St5UXBWEdjt+a+Cjtkh43EpB6QJUlV/Ou3tDuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C9SyRAOr; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-706b539fcaeso4060600b3a.0;
        Tue, 02 Jul 2024 12:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719949318; x=1720554118; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=nNFpzjchwkxobyBRrMsfVq2/FuemrGIUhIq6St66qhw=;
        b=C9SyRAOrH/Z67SRjUeI99nunVTlrPbIKogZHkZzOT4FGKRsVNz6HUjC+k5kQOoQYXO
         Nv9nbC/OD/Re5kKGjx5FqvsoweIPefyMFwUXDvSXjthl10pD+YmP6QCRXH829InqqkBB
         T9N1pzEtTG9IxfaxXZmWhX6bIphjgqahYdG4Wi46dggblBznnl9vfVFqT3PW3f/SwV/q
         SFXRB9vNWj9y4JyJa3uOpMCGHYnIOa2S5J6M41qRxJqgeqlK4gNLggk5tWHZxNDIxgWD
         HpB56jEG8qtLK0zegRxOcGR6izOWZkYdz+OwiF1Hpme3SUZZtaOCYshsGueJ3wPh+5lK
         Yj8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719949318; x=1720554118;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nNFpzjchwkxobyBRrMsfVq2/FuemrGIUhIq6St66qhw=;
        b=jtX/i3YteX4yUTt9xd3ZErCLJbRWj4UTA+sLDj7q05ZCNAkQSYUx5TJuQvE035LCqE
         mYBP9DaXYPUAb/FQGZ7dcM8p/rpAKppoZZiLOspxxDQWAraICI8W1JsVGA1cZ7WRZppv
         adQSw4DRgJCtpn61nCPsN9WDURu995HPzX39s12ekhj3CE6Ss2koY8fs+ZlWKeaJfry3
         0t2A22FHAbSoXc4KUrkV1xuQq/H81X9LlUM8EkoesPFBnp1etf5vNw3dHM1QkTRWtyrG
         3ESqnM+HvZ6TenyMsnubuC5XDxoiSFnRYtYFpkIUZKXSA+F0P8z4tClxc57tpc54rnsa
         aDfg==
X-Forwarded-Encrypted: i=1; AJvYcCUCs82wu1VI7Psek1XJsSXlyCZUrtRoJS5jzg511ej3lm2Pc3N/DY8MwfI/Eu7FYFNznetTkGVo8kNciwtAFMP5cncCNo/n4QKvZxezS3twZe9S1AWRpCmjHa4oqXHHbb44bpnpXm+EgCU=
X-Gm-Message-State: AOJu0Yz2Os/E5zhPpyWsDI0jRca6T7pd7uy+kcw4Zma3ZwfawRPMIdKS
	ga/UAy+RWY5pdtmyVCEBUIKhtGUG56NY74Gg7RA5I/YDxfVRs0lo4Nb3QA==
X-Google-Smtp-Source: AGHT+IH6ct0kRkaJ/3I7wpdHjmOW+7Kton0AK/6wgw6KRAaTuUjoWg3keO/EMYOXsh8l7q+ZZnZ2sQ==
X-Received: by 2002:a05:6a20:9744:b0:1bd:27d4:afcf with SMTP id adf61e73a8af0-1bee4994c6fmr17745635637.24.1719949317566;
        Tue, 02 Jul 2024 12:41:57 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-72c6c9e1634sm7035885a12.58.2024.07.02.12.41.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jul 2024 12:41:56 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <b83aaa99-caa8-47b4-a502-b1f284c6408c@roeck-us.net>
Date: Tue, 2 Jul 2024 12:41:55 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hwmon: (adt7475) Fix default duty on fan is disabled
To: Wayne Tung <chineweff@gmail.com>
Cc: jdelvare@suse.com, linux-hwmon@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240701073252.317397-1-chineweff@gmail.com>
 <6c91530f-00f3-44ed-ae77-312260c2af9e@roeck-us.net>
 <CABrnb7xqZFWwp9A3==ccDkkyAWy855O7JKYrf4EDUGEbhMEZnw@mail.gmail.com>
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
In-Reply-To: <CABrnb7xqZFWwp9A3==ccDkkyAWy855O7JKYrf4EDUGEbhMEZnw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/2/24 03:31, Wayne Tung wrote:
> I'm using adt7475 on the x86 system.
> I found that when I tried to probe the driver manually, fans would run full speed (It's in disabled mode by default).
> So I traced the driver and found the issue.
> 

Thanks for the update. It is interesting to learn that this chip
is still actively used.

Guenter


