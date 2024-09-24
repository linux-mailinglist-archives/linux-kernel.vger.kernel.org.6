Return-Path: <linux-kernel+bounces-337338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4B9C9848D3
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 17:43:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A21D1F234D7
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 15:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06F2C1AB6D7;
	Tue, 24 Sep 2024 15:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mUpNCdh0"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB8419F40D;
	Tue, 24 Sep 2024 15:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727192608; cv=none; b=SGI+SeANd08dtWzRZIeZHDwPgKmYGB2svlN5fhHjKZMOEWqlFMmBLUxZb8YjB9Vi0AUEEDwPitukTxhFIJ9GDiySi1E7R0EoKUF4NFKKps6mJRkVUC/WyKLhluMrquzOs4NtIGrm7fPspkN9vCpn+GVb9eo0Y4Nb7MGbIQYRc7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727192608; c=relaxed/simple;
	bh=IKlPFgwPs3C9s5jXT8lrcoRt3WARlazJOwa/Uk2KWCw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G4ZvP4RRVjEVaZ6H5GN8sfLVeWvyFZ98mgedgpSYZd7vn0+ywnJGZJ6H3UxVSdbFhwEB9K/Y/2T7hmsMx71Rru1iVxE2V0V4iGzjqlUFc9H1KuUr4n2ifFkj4SCJk9cUMO5GmrE2f8Jr5Z5VFga+pCb3TeK4WNx9zTcRaayOwrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mUpNCdh0; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2054feabfc3so51548325ad.1;
        Tue, 24 Sep 2024 08:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727192605; x=1727797405; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=HSC0aWydli9B/QIw7es5dpYAa7Ef7DjM4fveUpwQgYk=;
        b=mUpNCdh0T42aQDk3nGDga3Eo6t6R+2/SZRNeSoz/vzIJRbvHjnWFzP24OatWbXqe+4
         lxGc7ezWK085AFXOqEe0wJB11ZpWZkKanQNXKo8q0FdS6ofzrMb747RuDjjWyKEkrane
         ynmyCL56gG9rJkuFaht6EJJmvXp1PWRNR0LUpfirEbZDKWfpdxII3Xbg3g6sozY9A4Yw
         8Lc0zhepogru07qj6y4CRA2Ie/1mYhsQTVMYU+HJo7hvo8KPy3bR+miV+BaVBp2en5ki
         AVAVsDe1lQfCzM5n8dgCeccHdU/Ki+Mycff63df0G7wXxqmYvZFgoyW0G/cuJTxlzcJK
         pAfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727192605; x=1727797405;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HSC0aWydli9B/QIw7es5dpYAa7Ef7DjM4fveUpwQgYk=;
        b=h1CE1v/RGXOZumdBPaeDS5M+sjF1oJFc2UIKwsyKPENas5daQBRd49PeKc3yfOZqvY
         p7kF8RHgf6AWo+4HRieSF/1eRIrWcR83WnF8sk+TagR2fCguEbKeyAp2WMIlcsR40VhF
         tUWuSUZWw/RsmNjeG0gNSV7cbPkQqma/FhYGnlSegqOs4Ej0ztw95SWOPfAeQwCNRlEr
         xiOgvCo/tL0UBKq1BFeSWaqMESj0XA+oQTpwtHgxCX+K+LqB7q7+ZVeJbXjc0fQ0Jllb
         TM81yzY/mPypsi0yztHP6ll0wLvqGEuvIqHgn9LVIYPVLFn61XGNBSefCGTuQu22BpLd
         eqwA==
X-Forwarded-Encrypted: i=1; AJvYcCUPAx3pfw/WwTT6O+r0gB5zm9GWfj22kVL4Fic6WWdRT2R7mvoY8UQlPtPzf7mLqBzOi10j4ZHOsdin57Y4@vger.kernel.org, AJvYcCWzjO/o/RIHT2op6a2hDyN93qP/Qbt8xqtR1umUx1+o3tPYYc9FyaEgZJRRUh/ztAw1l4qOVmS9z8HVKQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzFYFipvUYNMZ68SJuDPEm2LKhybm2L+eVk6CFIL4hetECiX1m1
	mMwK9n4zb5d6oE6LFs1Dse6zItzIRjS+Vsm7tBrCPkoLHm1FDV7/WMYflQ==
X-Google-Smtp-Source: AGHT+IFH9WrlJpfH753BdHtnT5CIhp53Pk/y5Zw2kwudwnzRxSpjCgyekzHht78a7HeVWEXlRaQuHw==
X-Received: by 2002:a17:902:d4ca:b0:206:b7b8:1f0e with SMTP id d9443c01a7336-208d97f356cmr233567395ad.1.1727192605170;
        Tue, 24 Sep 2024 08:43:25 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20af185482asm11636165ad.244.2024.09.24.08.43.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Sep 2024 08:43:24 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <84ba0d7f-cb85-4f00-a8a9-ad8e8a56840f@roeck-us.net>
Date: Tue, 24 Sep 2024 08:43:23 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hwmon: (max6639) : Add DT support
To: Naresh Solanki <naresh.solanki@9elements.com>
Cc: Jean Delvare <jdelvare@suse.com>, linux-kernel@vger.kernel.org,
 linux-hwmon@vger.kernel.org
References: <20240628115451.4169902-1-naresh.solanki@9elements.com>
 <349543e5-21b2-4725-9b33-1fcb4ae124f6@roeck-us.net>
 <CABqG17hpqFG-PeyENXnGn9k7V2goBP+k6BtSURoMM7DgXtxWmA@mail.gmail.com>
 <0aaed899-9001-4355-bcca-17855576a928@roeck-us.net>
 <CABqG17h0+HWSCF0PRVBaj37WYYsz17+n1MD1Uiuscqy_dvU41g@mail.gmail.com>
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
In-Reply-To: <CABqG17h0+HWSCF0PRVBaj37WYYsz17+n1MD1Uiuscqy_dvU41g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/24/24 07:44, Naresh Solanki wrote:
> Hi Guenter,
> 
> On Tue, 24 Sept 2024 at 19:42, Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> On 9/24/24 02:29, Naresh Solanki wrote:
>>> Hi Guenter,
>>>
>>> Sorry for the late reply,
>>>
>>> On Fri, 28 Jun 2024 at 20:30, Guenter Roeck <linux@roeck-us.net> wrote:
>>>>
>>>> On 6/28/24 04:54, Naresh Solanki wrote:
>>>>> Remove platform data & add devicetree support.
>>>>>
>>>>
>>>> Unless I am missing something, this doesn't just add devicetree support,
>>>> it actually _mandates_ devicetree support. There are no defaults.
>>>> That is not acceptable.
>>> I agree with you. It is best to have some defaults & then overwrite
>>> based on DT properties.
>>> But in that case we would have to assume that all fans are enabled
>>> irrespective of their hardware connections in the schematics(example
>>> fan_enable).
>>>
>>> I'm not sure if that is fine. But if you feel that is alright then
>>> I'll rewrite the driver to assume
>>> everything is enabled with default values.
>>
>> That would still be a functional change, or am I missing something ?
>> It would overwrite any configuration written by a BIOS/ROMMON.
> With that, driver would take the current chip configuration as default &
> just configure specific config specified in DT(if any) & continue with
> initialization?

Yes.

Thanks,
Guenter


