Return-Path: <linux-kernel+bounces-568103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C30DA68E2A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 14:46:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C58A425C5F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 13:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D82E259C94;
	Wed, 19 Mar 2025 13:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kX34gZop"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ABE9257AEE;
	Wed, 19 Mar 2025 13:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742391879; cv=none; b=LBqyY6EVI02T1Rk197xkUDccG3AECF5oPfRTBlwhEOrX7xyYYqYxXFA4trc6UYiIUCstk5OOI+LbgMVTktQGZNiIw6odJJjK0mceUhvrS0nf+K1H15bVUehC6hoXMOx+7PTHTFY/9vzsJp3hQVhym0/yodQgm9maONgfM8JI30Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742391879; c=relaxed/simple;
	bh=axmn8Lo4vGN02pvFgcJvBFPtad31W+YNY4F3cl8H8RQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZZZYM7oPpTeOxoh1VTSeZzcroKxvk5d5wEWK99oQv/MLzVvWZzLYB2sH/SBgK5mTG0opp4sGpaHv9YpjKAjjWCKzOjp2rjR7Ih0lPC+nK5aeh6FyIXay4YYxtGdNPxMmspZki0aeVpXRuNBrNcf9Q0ozkGW16zoVxARA1a5o1qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kX34gZop; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-225a28a511eso118347005ad.1;
        Wed, 19 Mar 2025 06:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742391877; x=1742996677; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=KUdH3cdTI4tPMLijmbinK0VWfaYch90dsDAzIZdwZ2c=;
        b=kX34gZopSYY/lXtLGdbiLRYz5ArnGzFd2FyW9Q4z1pJWk1eQTq5j688Bv9VoRpf61X
         stsKZ/Oy6MsWK4RxjgGGQHQXFr+SSS7pgL9W3B9E9l4XRh+N1w1hqLv0Es6H4+W5DWA0
         2e+gDStUWNYDg6n3WVHlDvzprcyJ4ZI1RdRfo1hwKJaiBGmMC6Oxdp/hU4V1LPUbhPCZ
         GgwepXPYdQZeRaB/LKCBLp68MWNYXgoRdeVyOkaew9yJQvsC+cINtDcxt2RBD/SdCF/G
         clPtYRP+HHVa+qsROnDhtZQ8bo4KSNt5WaSUJ0ECJqT+eH9YUYW71SeS4pnvC1Qu/xCF
         4yFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742391877; x=1742996677;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KUdH3cdTI4tPMLijmbinK0VWfaYch90dsDAzIZdwZ2c=;
        b=rArfkojcMy8sKGeRUW1nEKugxPf5xWUM3x4FkJv3oOpxjET7ERrm8lUl7ma8sng8w5
         OJd2cOoZe48biZz7s5zRyW53c5Fijj2EZbFQyCKXPqEHRsZNtocc0Kg1Tp5SBjejOZzM
         t5MV8wTGBFhVQUagVFECJfl72/AZDpLaHMi0YZiO8v2v4GcDBKVkJ3P9K8jnDHTuzTgK
         +yUsNelLCCGOMshS5ojI4SBpSBRYC4csWYJ8nAxLGUoGcKyD5d/bNsO+5kpEKuWcVtZo
         d1ZgLVAGnY/8EgrSLlD5W42cPbpC1SI18nk2zc21S8EeZuy9bLrF33tecTv8NSJj4DAF
         RqSg==
X-Forwarded-Encrypted: i=1; AJvYcCV7jfrmBkb05Slh44AApU9uG+IOPNq0MAPjpm4kL8XMgWDet8YnGlYsxfd+Ex3Wsc3pCI4fM+sB3Oxd@vger.kernel.org, AJvYcCVgDc+NtFB3XTUdvZwl620Lj9tWoNQlaxfPey8lZr9IGe/q4a3cNeIOtpt/Q/tokob3CiGswckIbtwB8iEK@vger.kernel.org, AJvYcCWxjz2FTYKJmbRxizEutZ2jcfbFufbh+simcfPzhw1st03uhfmc+PooT4niku47u3qCR11Bd+u1A1uvx/A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvgtNmvPGUJRSqKwBEAC8x6i7sWR9L5Kbyd0tjMv4FX0TzQzzG
	FxPx83Y1YsWT8kagi05OKPVTR+hq9wGSD6jFB7S7QSKeT/7e4lfv
X-Gm-Gg: ASbGncuzOaGk+ESfD9EwuzgcBReJjFLMG2oFZR/BYKeWKHESJGNfhCre7Jo+yJqWp4n
	NE0OBgkme1QGjeu953Ho+Nxfr/BRbhN23VsqREXcqEecx974UQ4l2aZJR2/W3i5nc9mV1EBk2ZX
	RSBeZAcXzAd9lP37EIwHj8Z/0EbbYYBndhQfHaC2MxVoYnR23BIPDl2BODOjNqZ8M9zVaGsYB/y
	KRlXB7K9A+tnubvSjWm+WeTH0w461ANFBstnqTYfInW0XNooAdFmaYT74/kBDI1BlXy97kJ57U9
	NLvxB2+C4kzs2T+w6tipezpImbo3oYZTWWst7EBZteRTSG2HbyNZGgt3Vm2KKP0YYcD94Tn+aFj
	3vfcYlLmqquUYdzDFGQ==
X-Google-Smtp-Source: AGHT+IGWPE4C0Kwq8FOYyCGFfbTw5NnLZ7oMo+zBxPH/pnR5qEZWC6WZIx9sw8dSF7Ysym4urv/f3A==
X-Received: by 2002:a05:6a20:9c8d:b0:1f0:e42e:fb1d with SMTP id adf61e73a8af0-1fbed3161a2mr5225975637.36.1742391877349;
        Wed, 19 Mar 2025 06:44:37 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7371167da28sm11594418b3a.89.2025.03.19.06.44.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Mar 2025 06:44:36 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <1c7e20e1-b139-4fc4-8127-f409ce9a3cf4@roeck-us.net>
Date: Wed, 19 Mar 2025 06:44:35 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dt-bindings: hwmon: amc6821: add PWM polarity
To: Francesco Dolcini <francesco@dolcini.it>, Rob Herring <robh@kernel.org>,
 Quentin Schulz <quentin.schulz@cherry.de>
Cc: Jean Delvare <jdelvare@suse.com>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Farouk Bouabid <farouk.bouabid@cherry.de>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250224180801.128685-1-francesco@dolcini.it>
 <20250224180801.128685-2-francesco@dolcini.it>
 <20250226134922.GA1944823-robh@kernel.org>
 <20250226135806.GA47264@francesco-nb> <20250319101228.GA17979@francesco-nb>
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
In-Reply-To: <20250319101228.GA17979@francesco-nb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/19/25 03:12, Francesco Dolcini wrote:
> Hello Rob and all,
> 
> On Wed, Feb 26, 2025 at 02:58:06PM +0100, Francesco Dolcini wrote:
>> On Wed, Feb 26, 2025 at 07:49:22AM -0600, Rob Herring wrote:
>>> On Mon, Feb 24, 2025 at 07:08:00PM +0100, Francesco Dolcini wrote:
>>>> From: Francesco Dolcini <francesco.dolcini@toradex.com>
>>>>
>>>> Add property to describe the PWM-Out pin polarity.
>>>
>>> Why doesn't the invert support in the pwm binding work for you? Yes, I
>>> read the discussion, but don't remember the conclusion and you need to
>>> justify it here.
>>
>> This chip is not a PWM controller, it is a FAN controller.
>>
>> The HW has a PWM pin output that is used to control the fan, but the
>> device is not modelled as a PWM controller (correctly, given that is not
>> such a device) and the OS does not control the PWM, the chip reads the
>> temperature and decide the PWM duty cycle accordingly in an autonomous
>> way.
> 
> Can you advise on how to move this forward? Is my explanation good
> enough or some more clarification is needed? Should I send a v3
> incorporating such a comment into the commit message? Anything else?
> 

DT maintainers insist that pwm properties are described using pwm cells.
That does not mean that the driver has to implement a pwm controller
(and I would resist doing that, because it is pointless), just that
the chip's pwm properties are described this way. That is indeed a deviation
from older devicetree files, where "inverted" properties were acceptable.

I don't know if there is a means to avoid that. Some devicetree files
don't mention pwm in the property name. See nxp,inverted-out or
atmel,lcdcon-backlight-inverted for examples. I suspect that is no longer
acceptable, though. The easiest would probably be to define optional
minimal pwm bindings for the chip. Unless I am missing something, that
would just be the pwm polarity, so you would have a single pwm cell.
Something like

   '#pwm-cells':
     const: 1
     description: |
       Number of cells in a PWM specifier.
       - cell 0: The PWM polarity: 0 or PWM_POLARITY_INVERTED

and then something like

     fan_controller: fan@18 {
	compatible = "ti,amc6821";
	reg = <0x18>;
	#pwm-cells = <1>;

	pwms = <&fan_controller PWM_POLARITY_INVERTED>;
     };	

That may require some tweaking though; I think #pwm-cells may apply to the
children of a property, not to the property itself.

Guenter


