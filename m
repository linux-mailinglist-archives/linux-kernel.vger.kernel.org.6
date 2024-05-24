Return-Path: <linux-kernel+bounces-189085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF8468CEAD0
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 22:24:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E6671C20E45
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 20:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A8A974427;
	Fri, 24 May 2024 20:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ndlwcTOL"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D981E46542
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 20:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716582256; cv=none; b=fsM359v6pQ/MtfNhZzdkkDhTkpWWlndfyHz0p/8sQjo4dgjKm7OcgkGAZSHuS/rso0TndDLTbIepaN9gotEgnYjq8HEJad6igvrubyMPmGlWYGcGXuAkydMpoHT9IVx1RvrY3RzLbzFIdUG7l6NLt0CyhZFFtURtKQnCdGXylpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716582256; c=relaxed/simple;
	bh=wjtZl3yVNDRBs9GHNh0iDIm0IyJKnZLQ7EQ3LIdkgBY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aINEUK0cKwjUwq0fiEfi6gtd09+aBglZs4quJKfzAJIatv8VTIxHnF5HQApDFUU0orh2ewyqiIg5LXoFPZ4t/9WaZ6VyYUJmavDEdLP6izbVXPOgNFPsbHz7+Qdtqt5PRf211XLprwTxaleFCdbid+i1xAxr8/m9KMypojUwqxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ndlwcTOL; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1f44b45d6abso11404635ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 13:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716582254; x=1717187054; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=rjNgYx0LS4/kjUZ+6MEdVkZwT2zxa+2G66XS0PLZCx8=;
        b=ndlwcTOLyJ0Hubuzq6CKluVhh49HI6Zaaur9RlYlm5OMtlaOv+jhu5E3/ob5vM2cfw
         K5KDtz2zZmYVNbpqKwm5HKw4Sm7q8+d1ZK+0nNT80yIQusnO9TWxtfpM6Bkp2ImUCETM
         W1kwJJ/Fe5uCghnNsN3b6IfFqLelsjLDQNZgBflGQ5mynGRtwbFlLeKrt7iTvRBLCAT/
         POENnhXn/780XxtL6fjTbfprRg/c2dOjWCUUymJk4frrgLFLJgMyA6NBaGWW09tHZ+uG
         hFHnG6HxqYgKGjJQWNXVHncvlEahe6H1mDfWsSUs1QHNjzGQiylHrjjLiYjv2RjarcKc
         rnMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716582254; x=1717187054;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rjNgYx0LS4/kjUZ+6MEdVkZwT2zxa+2G66XS0PLZCx8=;
        b=k/LNJO8bKpm5mZz71512c3A+AqebGBm/wXrIs6TyA8SHGkpi4lFlRX8kkFmHpsNkNe
         n0IsECs5y/DXvIRQBqjQxKOUrKp3OQzQ10eHtRcvIZN599GUNsfFNuhmjizqMdl+H2Hy
         DF9AZo2tVUUaOKMAA6ZVVyDiY9zIUcxvkpR1zWzsXutKKs3KfBI6MxsCd/AiXwS0hdIc
         DJfljpYQ7goCAxL+8s5iaX7x6kCxepL7leY3sIH+J2JtubM+IM2rPZ7veAd5teW9ldL6
         AxwrOqUBGrdxy2DMTX9zcu3n5XHG4kW4LG9AebR33W4HSOhsAsy4hkyopz5BU0T9XErK
         fLiQ==
X-Forwarded-Encrypted: i=1; AJvYcCVp4Yh19mQ8MQWW1LhIhlETvitO1vTiGmPIG4VkqPmx4tOFh5U1UaUq7QsoEy6xjOVNghwzMYy9SXVP3cVCHo8V4JbJ4STgckGAGPeu
X-Gm-Message-State: AOJu0YxbpBj5uwxGdl0zV5pVLA6DfgM882RnFRcP+GNa4biK00F9qwke
	NEASg8IJXV/Qjuf3hDT+n7YMDQC/fsmgspRzfxJIabDWN9AFUzbNdIDVpg==
X-Google-Smtp-Source: AGHT+IEsGTXGcl+nT3WDZVUBNccpstdx6wdfVQd7Gd/Sf56hQgRvC69lFPyZsX4GBaOyAbfxLOAVkA==
X-Received: by 2002:a17:903:5c7:b0:1e9:9c6e:9732 with SMTP id d9443c01a7336-1f4486e145dmr30237085ad.19.1716582254066;
        Fri, 24 May 2024 13:24:14 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f44c7a4e84sm17877145ad.73.2024.05.24.13.24.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 May 2024 13:24:13 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <c9a5c36f-3253-48d9-9258-c657e0e0ba04@roeck-us.net>
Date: Fri, 24 May 2024 13:24:11 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: riscv: irq-riscv-imsic-early.c:52:9: error: too many arguments to
 function 'riscv_ipi_set_virq_range'
To: Thomas Gleixner <tglx@linutronix.de>, Palmer Dabbelt <palmer@dabbelt.com>
Cc: Conor Dooley <conor@kernel.org>, naresh.kamboju@linaro.org,
 linux-kernel@vger.kernel.org, lkft-triage@lists.linaro.org,
 regressions@lists.linux.dev, linux-riscv@lists.infradead.org,
 apatel@ventanamicro.com, anders.roxell@linaro.org, dan.carpenter@linaro.org,
 Arnd Bergmann <arnd@arndb.de>
References: <mhng-44d7a1c7-c15a-4077-ac94-23985f686474@palmer-ri-x1c9>
 <87y17zc88y.ffs@tglx>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <87y17zc88y.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/24/24 12:36, Thomas Gleixner wrote:
> On Fri, May 24 2024 at 10:35, Palmer Dabbelt wrote:
>> On Fri, 24 May 2024 10:18:42 PDT (-0700), tglx@linutronix.de wrote:
>>> On Fri, May 24 2024 at 08:10, Guenter Roeck wrote:
>>>> On Wed, May 15, 2024 at 10:05:59AM -0700, Palmer Dabbelt wrote:
>>>>> as a conflict resolution, which IIUC should happen when Linus merges my next
>>>>> PR.  So I'll try and remember to call that out.
>>>>>
>>>>
>>>> Unfortunately it looks like the conflict resolution did not happen,
>>>> and mainline builds are now affected.
>>>
>>> Fix is queued and goes to Linus tomorrow.
>>
>> Sorry I misesd this.  The PR I sent Linus this morning contains my fix
>> from earlier this week:
>> https://lore.kernel.org/linux-riscv/171647463438.13050.6219786365640043025.git-patchwork-notify@kernel.org/T/#t
> 
> Happens. I don't rebase my try. I just mention it to Linus when I
> send the pull request. It's the same change so the result is a NOOP and
> not another conflict :)
> 

For my part I did try to find out if a fix had been submitted before sending
my note. Unfortunately I missed it. The problem is now fixed upstream.
Sorry for the noise.

Guenter


