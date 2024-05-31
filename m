Return-Path: <linux-kernel+bounces-197506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 936458D6B8D
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 23:31:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B28F5B21A50
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 21:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76A2577F08;
	Fri, 31 May 2024 21:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yovvu1S7"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D67182B9;
	Fri, 31 May 2024 21:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717191099; cv=none; b=NWXRU5dpvFW2VTzpjUUhKAm88dL2umGwfxJ6XKgRtYrjkQ/XrO4pyYGwllv88QEaW0UKvfoAWGcU5uO+dsdIHRL8V758S8MU8/UunEtcGaL/zzVykPXV/XHkjOOpdcWzGjKyKZsjTrTxjyTTQJd5fwE9LWp3icQtvdDYoXXXvmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717191099; c=relaxed/simple;
	bh=p+h+RR8Tux2ov6Q/YfGRzyN6928v4VHs7jLvp5QqIXk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VNQT4He82VrjvV37AF8S75ilZa2JeQNWVOyhYIQ/xXuhbbKDqxv9WIcX3j1f4IYOemGsGUe46as8VqidV70UDIhc1PIM0yTqXABZJQpaZMJfgOg0WEMLHIeZjY72DrvTs5GZrf9Rr2xX7ME0sBcCgmpCqrkDDCyOK1WW3qGQrwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yovvu1S7; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-70109d34a16so2345592b3a.2;
        Fri, 31 May 2024 14:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717191098; x=1717795898; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=lmTK+P0aAS88cJMG+0siFJrcs9hOJ7w3yXrh727oCsA=;
        b=Yovvu1S71iGD75DcSBcAGRqli6LBrXXcFDcVmay8WUX2Gca7CSCYCji/pCAIxd+hTi
         cTRGmLcm+9jAszAEBC5wCOvPay0rM14+5GU3EsurKid+53hr9vy/U11tCfV2LSYo5vcZ
         lcE3MkpwWGJsRhXABLCX2utXZVPK9I5rRadrG+Z5fLF6kPpdcgENRmDk+2vfQPjZfwpL
         BWNJLnkWiP8WTsDD1uJCD0GZvpB1jRi1XozqhKnBMCXa+xeNq0BX3BMdf2PwKeNUpeJI
         8DMjMuK3h9m6t4x0IzOyjomZo84aN6B9Zv67V0tRnjVpNjf4Ze2ioM57NHbCR1/BcZa1
         85uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717191098; x=1717795898;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lmTK+P0aAS88cJMG+0siFJrcs9hOJ7w3yXrh727oCsA=;
        b=TdhklFfmI6gYfWz/8kQdJrIdMx2YZignhrqgb/UZ1hg55+Uds8IeUMEFQbqZqHQHHo
         TNn2bsv26bX9dpEd53WSXTF1PQneShS9UE6wJVD6dPMOiQe+CVK9N5M9jNF6cJdiaEG3
         8GOpIxY4ymDwbVbi4tLvwVloQO56Cc3a1bxGVLB9UQ1qV8AJmTN3C9fRi8AJ7OyLMbbI
         m+3JZWM4z+cx3O4p5LvXtdh8ZTLhFj7adlAh+2prKGmb0WnW3qFqu4DE82r22RcgLO+0
         +qXlO9odcQjdLaZXyfAQy1sE4VCBXDXni3UVtftrwRKwAlxPNZV20pkc3UXy3CHmEhHp
         QdWw==
X-Forwarded-Encrypted: i=1; AJvYcCV3ZZdSfZrLy5okiMtKbd3vtUMBeyqvtqpbpEwtgHF8bfAMWA8WM5GuKh3u3u5psoJWmxyVey+C2CxB9t1FY7I4c4voJnVf9pcltBXlB4jzTnoHf6uZcjGC3FUPoId46wYO3qiEqC2nl9g=
X-Gm-Message-State: AOJu0YzS/6/SGm9XfZJLwPAgXnI8ce2Er1zZNJN8ddVLzQ0B9sJ8you0
	DWSKCd5oRrIGhncxCDSYwqLh0pTK3OVmT5/tnasgrBbJjokekopb
X-Google-Smtp-Source: AGHT+IFd98ETMNBo5PLkVyZ9UtPTuKfKcJyylrYvEEoGY+8NVntQAivV9DKV0ht/8tQf4PsJYyyoLQ==
X-Received: by 2002:a05:6a00:4a05:b0:6ea:e2d8:468 with SMTP id d2e1a72fcca58-7024789b9c4mr2442492b3a.26.1717191097697;
        Fri, 31 May 2024 14:31:37 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6c353fffe55sm1425729a12.14.2024.05.31.14.31.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 May 2024 14:31:37 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <294ff393-9cd5-4e81-a8c9-955dbadc612a@roeck-us.net>
Date: Fri, 31 May 2024 14:31:35 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] hwmon: add ChromeOS EC driver
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 Jean Delvare <jdelvare@suse.com>, Benson Leung <bleung@chromium.org>,
 Lee Jones <lee@kernel.org>, Tzung-Bi Shih <tzungbi@kernel.org>
Cc: Guenter Roeck <groeck@chromium.org>, linux-kernel@vger.kernel.org,
 linux-hwmon@vger.kernel.org, chrome-platform@lists.linux.dev,
 Dustin Howett <dustin@howett.net>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Moritz Fischer <mdf@kernel.org>, Stephen Horvath <s.horvath@outlook.com.au>,
 Rajas Paranjpe <paranjperajas@gmail.com>
References: <20240529-cros_ec-hwmon-v4-0-5cdf0c5db50a@weissschuh.net>
 <20240529-cros_ec-hwmon-v4-2-5cdf0c5db50a@weissschuh.net>
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
In-Reply-To: <20240529-cros_ec-hwmon-v4-2-5cdf0c5db50a@weissschuh.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/28/24 23:27, Thomas Weißschuh wrote:
> The ChromeOS Embedded Controller exposes fan speed and temperature
> readings.
> Expose this data through the hwmon subsystem.
> 
> The driver is designed to be probed via the cros_ec mfd device.
> 
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>

I assume this patch and first patch of the series will be applied
through the cros-ec branch.

I don't know if Tzung-Bi has additional comments; from my perspective

Acked-by: Guenter Roeck <linux@roeck-us.net>

Thanks,
Guenter


