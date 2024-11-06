Return-Path: <linux-kernel+bounces-398490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3A109BF1DF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 16:40:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 828AA284ED9
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 15:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22D4B2036FB;
	Wed,  6 Nov 2024 15:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A7pmiu5p"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A3C202623;
	Wed,  6 Nov 2024 15:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730907594; cv=none; b=ftmqbCmkRAueg0DEZCtbUsa9wjyEM8KFVZnmTWP3WWDLUaUnP+N8YP/13BO26sOC88q6pKMMBHhvcG9LWG9uq3L+tPQaaCwuDXhJnEYJtgUYbcvmsSEWKvQW0qKPNKtQe/xYj3yq52WHNxAo2Fx48z4XAPlNdJfMtLEFS/UygHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730907594; c=relaxed/simple;
	bh=NaKsELaU/b5nqP/laIjTWgjkDEmvl+VLqDiH80xLOQ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jWvDWD2hGxHcI+0QA/2tT+HP/1CkYUwl5zrcfD8JzlXiEJyFPWyZp950Z4qPb6qkZ6HKeXhnhZFJ/9PKc72DJs6P0Zr/bFrO/vIPXBH3A6PuQAFHh8+jVtTi8peSmpbxCQplPFZEeJoQfDKS/hcsJBhOKGTZ6MABMI62A/ybY8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A7pmiu5p; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-20cdda5cfb6so67392515ad.3;
        Wed, 06 Nov 2024 07:39:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730907592; x=1731512392; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=6b/OOSOCY7f5FLIlW2qRjW2jgveapAVMWffApE6OmjA=;
        b=A7pmiu5pTsWhwEKPK5xxcfMzQXjdC8h1twfO4rhp2RHXeu17QSKfXg1zS6lEkVpSDz
         zLCyb6xjCd6+ookwEPE6msUB5oDuJnKLUdunwIGn7BYSnqGULlpywWK8mXRDww83zNRc
         b4QwlRT73DjTy/mzyJW066yVS8NRenVi969nvV7oznTv6U0tH1B9BxiR63WYHPCuuUKs
         q2euJ1OFU2Or3m2mkUlS8gylYfIaqVznmaOOPmoe4EaImKzFg5NHZ7ov/ttvV1bmF7x3
         arHKaOr8OFS72FnflVeL+1oydRsI8GjeZo8lIlPXZrTNuxmaAzyPWsD1ENlbD+vdbkWh
         EONg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730907592; x=1731512392;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6b/OOSOCY7f5FLIlW2qRjW2jgveapAVMWffApE6OmjA=;
        b=cMN1dDcoJDFtdv1OjcXXLqKnrlJ87Wr72PovrKtA8NyOVoxtdO9H2uws94na3htbf1
         EQg2x41TDrRhEPesztxS2uMcy0WJRSNaZVyH3EWQSpK4H/QbHr1cQy/Mci06l0OpuPY8
         9Lx8NkVTDFj/i70YATOTdUm5PlC4a2uaAK5TUIGde3r5ZMygnQ1+PLorgEHZhX7TEX9W
         jPRK1d5XyxkRgIjIDMXVEp4w4p4LkceZs4/YByyqrp+qUVAi7ATmcBFklK2sp924p0vt
         06Wvfa8TKMFTq+kkxbeaPAjTQI9YLpvfpeTO9UXs3qcBAMuZt+HgPAbF5KJj/Z5A71Xl
         4Aow==
X-Forwarded-Encrypted: i=1; AJvYcCV0rzW9oafaex7NW7Sp993pp//0ctHlBnrCPCdCmTnsS3uxqT1SbdnCCNm0AUeU1JE7s9HPsNPbm1A=@vger.kernel.org, AJvYcCWIRyb/V4fAdGC+ybFasXcocx8Wh/KLfBZjlXyxtOkonOp/8klMak4hjj7mLl5hEamIbtBTx9tMjaMqMF4G@vger.kernel.org, AJvYcCWTDPFQYrzNS2BchbxiiD3bIAMWvoPILUgB+7EPCiTgP0/W7LwHt57FC2WRdKV5yWfRCBi3uOLGCh6xLpc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGD4bP19uDpDrNfc6G2rE3TTgYm/LlsXOdZwLz5xYoWvs1jBTy
	rvjrNLPiHfxLQYOjZbBPrNu4gwPcKUpyO0P1m1a/7z3Xn0Um+N4FiyyydA==
X-Google-Smtp-Source: AGHT+IENGNX8f5nVgznDHTo/n5Swun7YREqsdZ67Y9SanC1+8mlybtY2tgQvyJulM3K1AB3k+tGsuw==
X-Received: by 2002:a17:902:db12:b0:20b:c258:2a74 with SMTP id d9443c01a7336-21103b1d871mr314805355ad.29.1730907592087;
        Wed, 06 Nov 2024 07:39:52 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211057083e9sm96404005ad.76.2024.11.06.07.39.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Nov 2024 07:39:51 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <e99cb4a5-eb75-4248-b9ac-db16ed3b4f38@roeck-us.net>
Date: Wed, 6 Nov 2024 07:39:50 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] hwmon: (ina226) Add support for SY24655
To: wenliang <wenliang202407@163.com>
Cc: jdelvare@suse.com, corbet@lwn.net, linux-hwmon@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <b3da9f78-c7d5-4bbf-80f3-bf5b52270792@roeck-us.net>
 <20241106150547.2538-1-wenliang202407@163.com>
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
In-Reply-To: <20241106150547.2538-1-wenliang202407@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/6/24 07:05, wenliang wrote:
> SY24655: Support for current and voltage detection as well as
> power calculation.
> 
> Signed-off-by: wenliang <wenliang202407@163.com>
> ---

> @@ -668,6 +731,11 @@ static umode_t ina2xx_is_visible(const void *_data, enum hwmon_sensor_types type
>   			if (has_alerts)
>   				return 0444;
>   			break;
> +		case hwmon_power_average:
> +			if (has_power_average)
> +				return 0444;
> +			break;
> +			return 0444;

That is quite obviously wrong. Again, I'll fix it up myself
while applying the patch.

Guenter


