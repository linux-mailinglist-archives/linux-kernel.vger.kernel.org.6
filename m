Return-Path: <linux-kernel+bounces-328370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF5AC978288
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 16:28:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0733A1C21F43
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 14:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A5B6BA38;
	Fri, 13 Sep 2024 14:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lo7P0Unn"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDCB3B672;
	Fri, 13 Sep 2024 14:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726237695; cv=none; b=qyG7UqZ2TCF4vw+VwJgierUQ/QH4fJ1gn1OSeeHZJSDDMAgtVtyWL4gIym5LF6JOb1Ja4GeQ+ZXaa/vpaRBabSYVaBuXbjl+Tp+I6CecD89xu4+Y52ARDQh7eKskbloMMx6BXob25ZIwbcBmTyEOg1JO3ceHkpUkuaB+J6uUrj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726237695; c=relaxed/simple;
	bh=oiI0FQhazTBPigLN4eIjH5kpGKL9+VIp23TCFhEdnok=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Glu8yds6veQ9VQeRfaengus0aEEOB0qXhoZoJs1B50y0jScLj5nWU0ZcvZ3QhsPYWIloLX4/wja7XRdVYBOetd1uTyeyD4jVP0ZVpvDCHrn0Sx0ZRWK75MC9/vFmrkV49RgJYvPkvfuzXjzkFWKtmjSfu9W6AMkd3iXl2+tX9EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lo7P0Unn; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2055a3f80a4so15789335ad.2;
        Fri, 13 Sep 2024 07:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726237693; x=1726842493; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=367i4sannZtVWEIwwL6Mz15M+zUPnTosTJBvIj90qGM=;
        b=lo7P0UnnO6MSsIJC1scrD/q0Q+hqcN9URyru0feNCWOH6xCTP7XhttUYw7oJxbtn2f
         YWYTnwYeDwULG4vcxMQriZxHHbU51IHJIueyxhjGkCtAW5oKQtfr6PthxrPUVp8XbdBC
         gqofg6ETv374kkcyRlEeRX5Jwj4Zquv84hUUFm4Mnrq7u8PKIumpx66BboPIrCwEc6FO
         nX9BkkM4f7aIq7A/oZtbsgil/A3HkR/wxfapQ0VkNZdzUoeUV76NMCBy6Y7NfzOUnMGH
         HkYMr9qvZC9ETFe8NpBF2OHrM8RAveu4ZrjDsNOzg05Dkqt1PmMUw2/2oIK1NUer6dQt
         Do/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726237693; x=1726842493;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=367i4sannZtVWEIwwL6Mz15M+zUPnTosTJBvIj90qGM=;
        b=t6Dnj51Nsa18DGnmMQgrlWpNIjx5ffJeN7ZoCgIvXJjXBFpiWn0q1dv0vIo7HzoaRf
         l17o4nDuouTBUbVS2xnZhSXNg603krm70pEBsc4QNafof0lRXul90S62fN7Xp03b0x9R
         w9r+GJDF3dao6z2wrRrgGfiBFswYarFuR0xaE/zRjwYd1Z0dpG3Xgfr4iJkXj2FNRNXq
         grD5/qdch7vQhLSg5jSRZYz0FSrDK4P/p3wEjTC0xVtrYEZck4baxDB8WB5nCqZpy488
         lKDLF6TMvwvQNgwPwY+hVWEHQlPkXLhe0HHmAcWHaQTLfmYuABzQAUU1XQIzROuzpgWD
         wAJA==
X-Forwarded-Encrypted: i=1; AJvYcCWDJQiw7pNW4/FsVHehk486F4iAipQOL72Ym3Am/P2ruWET4EOCbLxdboMhhL7ndRUsjI4SpjxCAiOI0Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YyUlBE8IFZ+l/ym6hf+em1ly2+bIyTzQFSRaCGMr9GJTiKlO+GE
	bU8FeBu2TgVl049QYdHlzS+DPIyPuRv0qM/uBFoKCQnrB9P5macS
X-Google-Smtp-Source: AGHT+IHTRhCAEa4Qhc5QaRCkeygVrveR4NalMpodIe9yHcLJivanYPPxbEYBK6wj90rWcMtG1AOQ7Q==
X-Received: by 2002:a17:902:d50a:b0:206:9caf:1e09 with SMTP id d9443c01a7336-2076e47a81amr86461355ad.61.1726237693003;
        Fri, 13 Sep 2024 07:28:13 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2076afe9bf1sm28775065ad.226.2024.09.13.07.28.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Sep 2024 07:28:12 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <48665660-5cca-4d92-a2b8-cf633ac632a6@roeck-us.net>
Date: Fri, 13 Sep 2024 07:28:10 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hwmon: Fix WARN_ON() always called from
 devm_hwmon_device_unregister()
To: PJ Waskiewicz <ppwaskie@kernel.org>, Matthew Sanders <m@ttsande.rs>,
 jdelvare@suse.com, linux-hwmon@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
References: <20240912091401.4101-1-m@ttsande.rs>
 <ca09333e-902e-4b2c-8c8c-eb7f0d2d4922@roeck-us.net>
 <488b3bdf870ea76c4b943dbe5fd15ac8113019dc.camel@kernel.org>
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
In-Reply-To: <488b3bdf870ea76c4b943dbe5fd15ac8113019dc.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/12/24 23:40, PJ Waskiewicz wrote:
> On Thu, 2024-09-12 at 07:13 -0700, Guenter Roeck wrote:
>> On 9/12/24 02:14, Matthew Sanders wrote:
>>> devm_hwmon_device_unregister() only takes parent of a devres-
>>> managed
>>> hwmon device as an argument. This always fails, as devres can't
>>> find
>>> the hwmon device it needs to unregister with the parent device
>>> alone.
>>> Without this patch, the WARN_ON() in devm_hwmon_device_unregister()
>>> will
>>> always be displayed unconditionally:
>>>
>>> [    7.969746] WARNING: CPU: 1 PID: 224 at
>>> drivers/hwmon/hwmon.c:1205 devm_hwmon_device_unregister+0x28/0x30
>>>
>>> This patch adds an extra argument to
>>> devm_hwmon_device_unregister(), a
>>> pointer to a hwmon device which was previously registered to the
>>> parent using devres.
>>>
>>> There aren't any drivers which currently make use of this function,
>>> so
>>> any existing users of devm_hwmon_* shouldn't require any changes as
>>> a
>>> result of this patch.
>>
>> If there are no users, there is no need to keep the function. We
>> should drop
>> it instead.
> 
> There aren't any direct in-tree users of the function.  But some out-
> of-tree drivers can find it useful to use, hence Matt hitting this
> issue.
> 
> If there's a desire to just remove it, that's fine.  But it would
> remove a handy hook for out-of-tree stuff.
> 

Any use of this function is most likely wrong. Out-of-tree code is
completely irrelevant for the upstream kernel. On the contrary - it
is another reason for removing this function. I'll do that myself.

Guenter


