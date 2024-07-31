Return-Path: <linux-kernel+bounces-269269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00C4C943001
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 15:24:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C8E21C21C83
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 13:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 234F21B1406;
	Wed, 31 Jul 2024 13:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="jZeH3Qrh"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 201B91DA32
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 13:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722432275; cv=none; b=oNBj0yxInOQiv2Pi2o3rBw1wcgbIRXPjWBDTFEx0LJxevT33AadOgvW2Lf7FKcTMJBmv/XcHHZ0AzBsDqb8ia8Ln0R12Laa89BrcQVJSqfPWsa5mZOYG/dIAac1K0tYZLZD5jKZ2Ko+eSB77Eo3TIvb6Dzf6V/bOnD3Cb5SY7HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722432275; c=relaxed/simple;
	bh=e2ANus+JMnyBj7253umNbuu0Bd1CpWoWQAUeFY7TG8s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fV5C4/XpUIJQTfTbEUk/Oxi0NUlJo2ZD0VQ6k/LBsudfL4ZSp0EAZB3aTL2qiX7hUj3qEUSc9kJ+QFONt4JyqdDcIoBEhwhsDd/Y6FbYIztNGrI8Zf63XM6o2Zivu0E28jwdumU4GGvpsan00eKC5mI5umxE13Zjyq7MiA8nQaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=jZeH3Qrh; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-76b3c938153so380765a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 06:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1722432270; x=1723037070; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uMvESTPZt0lSr92umu/Vqx1/CqVr3+XZK8KJ5G3/0qc=;
        b=jZeH3QrhOqiq/l5j/3sJfusFMHzQoRh+ZHBhTH+K1BXJC1DMXuyvwz/2TJiO3ulR4y
         aSskkg5MhlqiLHAOw5Qdh8U5Hv8ra9xXTuahtlTOtXPTE0tjGPuIuDNmMunzNvjdS3UZ
         r4IdF46+yHdf4KspXOnkEywMfXcVHDGREVHKSPevPZZER1rXLLJqFf1UxSqjiMG7gbIg
         yQvtXUVa0sWGRw1knpitVvfuxNZ7CIKvdbKNhPZ8AvriSXpFVU03YUqvcOSBoNp8FDQe
         9yQon4Qfv7Nmre1B18sAJ8CgezuBK1i8IcgsdzWOmaWqw9wNW5+RS8Zb9k/L4dB0TzDO
         UMUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722432270; x=1723037070;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uMvESTPZt0lSr92umu/Vqx1/CqVr3+XZK8KJ5G3/0qc=;
        b=OYTphS9KbgShGvJ/7wjS6uVW9X5P1cNQKU4xC14cGDG+9e+ZMEczpANCAQv285/DQP
         /BR0qdQ+K4a2VaC1oj9RO46FW7XwqfPBFzz02GZ+zBwGImNk6uWQ0bnH72yZHo2xohnk
         BMXSwN7W3bdgoRPNldUGBaVuNik5J88gURILLwdxplaqEaFDIyL00YyLO4MIC+oi5xkT
         A+XOmPNBhPWRkI/NiydnTelhhng+FRMw97NG3x7G1fjZwHOwFJVqYr0TcBNATT+82EPW
         SuUHxEEgKFOg98AqR5EfiiYYMRP6WmvUA0YrvXsJfeazAKF1hWPVDkAtTE45T6+8yihP
         E78w==
X-Forwarded-Encrypted: i=1; AJvYcCXRHe1kqVIpGro8PxsVwv319Ml8sTkDGFwMk9RfMATZJqalUVrde8ERdJZA3g1otE8ALb42r6brH9zeTIQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwR57Y+wQJX1j+wsaYKnzz046EYAdoQuqcxhr3LGzhpohMUlHCA
	AasdlQk69Djiz5FiGLltvCOXu8k60gquTzaU6wz6Zk9QhXcCdyKQ48Z1yMMQv7U=
X-Google-Smtp-Source: AGHT+IEIlm3z5Bhs/UVBeyZGDgy5Z2mOF20uwInELcwbpPOV91MJrMYhei5NgZleBr72y3w8qCAS+g==
X-Received: by 2002:a05:6a21:329e:b0:1c4:d312:64d8 with SMTP id adf61e73a8af0-1c4d312821bmr5527935637.3.1722432270072;
        Wed, 31 Jul 2024 06:24:30 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71048241e46sm1632066b3a.66.2024.07.31.06.24.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jul 2024 06:24:29 -0700 (PDT)
Message-ID: <b909349e-5ade-4e1b-b434-c2a669699059@kernel.dk>
Date: Wed, 31 Jul 2024 07:24:27 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Linux 6.11-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>,
 Guenter Roeck <linux@roeck-us.net>
Cc: Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Peter Anvin <hpa@zytor.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 the arch/x86 maintainers <x86@kernel.org>
References: <CAHk-=wiyNokz0d3b=GRORij=mGvwoYHy=+bv6m2Hu_VqNdg66g@mail.gmail.com>
 <f8677c93-a76d-473c-8abc-8dc7b4403691@roeck-us.net>
 <b7ecddb7-4486-4b2d-9179-82250cf830e7@roeck-us.net>
 <CAHk-=wj2BYPvYQAQa-pyT3hERcd2pVw+rL5kw7Y=-8PA3JTDAg@mail.gmail.com>
 <20240730192237.GR33588@noisy.programming.kicks-ass.net>
 <231e7a2e-7e2e-4b82-b084-8943b2236de0@kernel.dk>
 <20240730193841.GS33588@noisy.programming.kicks-ass.net>
 <f395b9d1-9515-434b-8ea5-c3bcaac10fd1@roeck-us.net>
 <20240730200947.GT33588@noisy.programming.kicks-ass.net>
 <e791c078-a821-4636-b44d-e02c22c046cc@roeck-us.net>
 <CAHk-=wgnmrbQhnXdpi=sY68m4OJff+qSiOUY-L8SF_u8JkHe8A@mail.gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAHk-=wgnmrbQhnXdpi=sY68m4OJff+qSiOUY-L8SF_u8JkHe8A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/30/24 5:54 PM, Linus Torvalds wrote:
> You also seemed to say that it only happened with some CPU selections.
> Maybe there's something wrong with the ALTERNATIVE() cleanups - I'm
> looking at that new "nested alternatives macros" thing, and the odd
> games we play with the origin and replacement lengths etc.
> 
> That all looks entirely crazy. That file was hard to read before, now
> it's just incomprehensible to me.

As I reported earlier, I already tried with the alternative cleanups
reverted, and it made zero difference - it still goes boom in very much
the same way.

-- 
Jens Axboe


