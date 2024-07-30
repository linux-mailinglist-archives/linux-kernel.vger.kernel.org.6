Return-Path: <linux-kernel+bounces-268126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C8A89420A7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 21:35:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0742FB24969
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 19:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A840F18C921;
	Tue, 30 Jul 2024 19:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="b8c5lGI2"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1297C770F6
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 19:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722368092; cv=none; b=Z9GeJ1Rds7gi537BPtzY4MQKajY51Cm96S66OxQs5UBQiRzra/qQ43QrfMaxH+xDJGo0k+yuGe8QNNnMcUAm7YRYjUo1ZTnWoWgAPTt6xIZDpAbXIxFD69eJGBSMHeJisesrGAgCrcrBypDC9l2DG19fKeFkBoW3mPjijFIdrCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722368092; c=relaxed/simple;
	bh=VVLs4LEfIoEogJPYXe+SwhnKPfCpUYx2UqMM4Fxe2nM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=maSjcIJS5kCGI/qo7dGimqsehu+z6lwJ/6VO8P5WyXm9Sy2Cg/exmiGph/8vpQqa1s0YYhWHlG9V0fH68Ru+Zb3V1ZZZxmeQqnIhTsZauwJ7glu0ti0pi/dwXUhQO1kZk/qLK5+vGxcPm8DnUqzZaz6KP5ydmHeVNnnF5rhS3D8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=b8c5lGI2; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-70d2879bfb0so359070b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 12:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1722368089; x=1722972889; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6nTp3SOjtNLcBinbhGUgogPJCSjA7tEHYWfl0ox2gh8=;
        b=b8c5lGI2CWYS2jP2LsYCCjTM/zQmZp5totux2zkikX7946okuGatYcyanYIaftPj0d
         eA8Yz/u7cynN8clAgE41KOQoM4tPzVA0CsHbEDCqzYSYgKX9j07+08LF4zkWZEGtmVzF
         keUPcD/CSJKGMIOAvVGJFJlHoVQeMw/U3yrsib4gt9PIJ3qEwEsZgjEotFZUTSp/TRRF
         pJ5NPgqLqcbrT7yPJ1Cc4Oqa66yuPG7AgfGc2q4g7gHdJBTr0yTIPoU6dcCVK06zB4I2
         7oFv6iNN3FOldX6cLkAea2v9QI5CJKgNQoEjOy15R1eT56Jlt7XKidQ0BfnE/JZN7K6Q
         6iIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722368089; x=1722972889;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6nTp3SOjtNLcBinbhGUgogPJCSjA7tEHYWfl0ox2gh8=;
        b=N70Y+AcgautWF5RziDtWthdVwwafvJCMY0Gp2J7NAeB3BXA3vZ9RD+7qts0jkYNAvJ
         g7/8KE+9GdkSoagoA3SeZ5w6zdLHlFez1IaXFYSAhirHiaXSaZanEgI7+xb7f0aPH/mN
         dY+mtKtPP1WfHjaBpl+HtFBe+V/nIA64EKIvQ6ypR3tKP0CS5J7d45EEp1ZXDxXXgLIy
         Iz/QIQn0SIHTNx32MQfkAn/dxUW/iwPPTl8I9ZUDRKSJcVpQTDcPX9t7HdEt4W24jZ/Y
         epubOGUYnmLh6zKyw1tq27ZhwOHWnUAXw2maeTAmM1MU9JKfzEhGLdvlelHfQO8NJULk
         lLOw==
X-Forwarded-Encrypted: i=1; AJvYcCUEiz0tbS2BSxZeQlARGJGCQiIWHpimVsZTeHBqbQeeRFq0wCQNb4JwgJ7eA9ycbS5jDFqwF+8Upx4eCeD9GBHJqYhz8LBrZnDwuG3L
X-Gm-Message-State: AOJu0Yxa6ynfOlYitO8C3bhvLnHLOr+J4lJlRF6wkCWmpcs+RhNeR8rX
	q9zjXl3nmF+HiFm9BPLuScIXGPHHPVJD8wD6d1beH42k6d/XqtgslAaBKRjh8AhrRs4NLPEOQiX
	R
X-Google-Smtp-Source: AGHT+IFbDsxBfHHrdHmon+KNDp719Cvyfx9LAUkmqxUhI4n3t/hoKNycwbLbS/RmMt08YA8gy4CUNQ==
X-Received: by 2002:a05:6300:44:b0:1c2:88eb:1d33 with SMTP id adf61e73a8af0-1c477444d24mr12282492637.6.1722368089230;
        Tue, 30 Jul 2024 12:34:49 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7a9f7c74533sm8061886a12.7.2024.07.30.12.34.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jul 2024 12:34:48 -0700 (PDT)
Message-ID: <520fb82a-8340-4dc2-8964-2abef81b83fa@kernel.dk>
Date: Tue, 30 Jul 2024 13:34:47 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Linux 6.11-rc1
From: Jens Axboe <axboe@kernel.dk>
To: Peter Zijlstra <peterz@infradead.org>,
 Linus Torvalds <torvalds@linux-foundation.org>
Cc: Guenter Roeck <linux@roeck-us.net>, Andy Lutomirski <luto@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Peter Anvin <hpa@zytor.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 the arch/x86 maintainers <x86@kernel.org>
References: <CAHk-=wiyNokz0d3b=GRORij=mGvwoYHy=+bv6m2Hu_VqNdg66g@mail.gmail.com>
 <f8677c93-a76d-473c-8abc-8dc7b4403691@roeck-us.net>
 <b7ecddb7-4486-4b2d-9179-82250cf830e7@roeck-us.net>
 <CAHk-=wj2BYPvYQAQa-pyT3hERcd2pVw+rL5kw7Y=-8PA3JTDAg@mail.gmail.com>
 <20240730192237.GR33588@noisy.programming.kicks-ass.net>
 <231e7a2e-7e2e-4b82-b084-8943b2236de0@kernel.dk>
Content-Language: en-US
In-Reply-To: <231e7a2e-7e2e-4b82-b084-8943b2236de0@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/30/24 1:31 PM, Jens Axboe wrote:
>> Thish would make this BUG_IF_WRONG_CR3, which starts with an ALTERNATIVE
>> jmp. I think we landed a pile of ALTERNATIVE patches this merge window.
>>
>> That said, Boris did spend an awful lot of time testing them... but this
>> is 32bit so who knows how much time that got.
> 
> Since I got this setup with Guenter's setup, it literally takes me seconds
> to compile and test anything. So feel free to toss anything at it and we'll
> see what sticks.

I reverted all the alternative changes, still crashes in the same way.
This is range 1467b49869df..208c6772d38392 fwiw.

-- 
Jens Axboe


