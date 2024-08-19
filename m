Return-Path: <linux-kernel+bounces-292015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EF3F956A28
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 14:00:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED70A288A1F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 12:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E79BC16B399;
	Mon, 19 Aug 2024 11:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WFO0QNCs"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 565011684AE
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 11:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724068799; cv=none; b=DS2rqnnzAsTckskyD7mixIiybodGLppUQYsVP8CVS1aVrMP/B5h/iadO7+uw/XSh0GhdFB6ZpomBH7RkvoG7wftj8TGOSw8POHK55ngSHnFNG7zw828VGQ4jmMFLQvjzbzWj8MfQ2PFdufDrAajCSxf1N4JzaqCPmPxfvnuT9ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724068799; c=relaxed/simple;
	bh=OdfKG+Y+WpKzKq+/piz1wvzBNK3UQgASLDArRYosKX8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=neg8NgRgRwWqDv4bT6GEuRAVFSszqeW193rqPM5Pm+Q38QNWKaIYjndvhmqXXC1BWvN1MbKSnC6DLOjSWpERBEViDWQUG1Fmi8pVBmo/0JfnEvfEBUlD3YOSk4t9Qww/NDlAOCpfJfT2lxret2WRYT+pRdRvpqthUYUtbTAS1v8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WFO0QNCs; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5bf068aebe5so338970a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 04:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724068795; x=1724673595; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PxAyy60UhDc/2n/7sqdnnMGfyzcoCrZ0o7gb5Mlyvtk=;
        b=WFO0QNCsriNLWNCgWs+he85MjmNHKfx15xyk9lcRTjhH0iuSEFWkGa3YwFTed95PKS
         hzYqUxQHczqdCGs7sAuBKDT9wUOMoZEItdiKWiVqVKqoRue/eM8AH8b9VXYS4SkJFawG
         ZQm1T/gfKXdD7IbEGGrF0Zee9o862WIvIlehVhHV8kWxDKJ3flNhrof7gkVn+qdH8M+M
         ZxOi0KhwpVKiYH+U2dM17vGoIaM+Zl1OdUUzg7iI0lydngRxJ1korGsp7aF7XwXMQa1V
         9yhULQxB29YIaiOOW+T5Y9UX6Ms5AW/s3y/0suCiT6qI4s0Yvnhnw2pZRg4+Ja0D4L0t
         bZlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724068795; x=1724673595;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PxAyy60UhDc/2n/7sqdnnMGfyzcoCrZ0o7gb5Mlyvtk=;
        b=p3M4j4FUjlcOK1dgL+mwb6BpzEB3dHfhxEf3OlS1/BFLfP/eQ/EMToz+n9U8lp1pok
         /O674tPqV1XtJKSAQ+BRb3QjXCmaMlgBWu5K9IM95a/YAkXFZ8MPCB4BbFzUA083k95d
         FvJLgQgWn2XEU2V5LyXEdkt6IBgYUXyhZuj3dd3p/0biyK4Gby9HQOeUaxDjJ9AxiY4H
         yDg934REapY6AgrWopT9Wb1m3jhIG0JuCLjCTx+Vx0WrIfsr/1gduTZ9S4F1RLme6Aba
         44e1S6JkTAS7J7PDCCLtRLPUaFSBZTaeAGHTLdILSsQUbL++JzCHV697DiP0oKYB54Ap
         t0Zg==
X-Forwarded-Encrypted: i=1; AJvYcCXEQ8c1lhCHesQ7C0uIVljY+/ymkVWiRDVVV7YjKbQQ5a6+kN8eZhst6IstTHdLMefeu934wqrSIY7ep1oy3lVE8qNHosHxRUPIZQGU
X-Gm-Message-State: AOJu0YyUkme/f+mu90u3lgor1lHaDr814IwogdZwhPXDnBetoHJPni28
	fZSsQBJkf05PoQ522H9OvHzsvxSicOU2axCR6h1rRhLe/Nyhj+1hlRw6P7OF7yc=
X-Google-Smtp-Source: AGHT+IEkUSm5mpC3K/ghwBMyE8pEwTqjg9TAMiGn0MI0ne1BA7mSPXEsq4hCeRvBZSIsgIpRFiiTCQ==
X-Received: by 2002:a17:907:e24d:b0:a7a:acae:340e with SMTP id a640c23a62f3a-a8392932543mr760970366b.26.1724068795131;
        Mon, 19 Aug 2024 04:59:55 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-a8383947250sm624606866b.165.2024.08.19.04.59.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Aug 2024 04:59:54 -0700 (PDT)
Message-ID: <df4d5786-6345-42d2-b3bd-a0cd03d83495@linaro.org>
Date: Mon, 19 Aug 2024 13:59:54 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clocksource/drivers/timer-of: Remove percpu irq related
 code
To: Uros Bizjak <ubizjak@gmail.com>
Cc: tglx@linutronix.de, linux-kernel@vger.kernel.org
References: <20240819100335.2394751-1-daniel.lezcano@linaro.org>
 <CAFULd4bDjN1XcLx+Uy703Vkf89LMH=E__L8qtF-A7KW3VLFiBQ@mail.gmail.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAFULd4bDjN1XcLx+Uy703Vkf89LMH=E__L8qtF-A7KW3VLFiBQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 19/08/2024 13:12, Uros Bizjak wrote:
> On Mon, Aug 19, 2024 at 12:03 PM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>>
>> Found by GCC's named address space checks:
>>
>> timer-of.c:29:46: warning: incorrect type in argument 2 (different address spaces)
>> timer-of.c:29:46:    expected void [noderef] __percpu *
>> timer-of.c:29:46:    got struct clock_event_device *clkevt
>> timer-of.c:74:51: warning: incorrect type in argument 4 (different address spaces)
>> timer-of.c:74:51:    expected void [noderef] __percpu *percpu_dev_id
>> timer-of.c:74:51:    got struct clock_event_device *clkevt
> 
> Actually, the above is what sparse reports. GCC's named address space
> checks errors out with:
> 
> drivers/clocksource/timer-of.c: In function ‘timer_of_irq_exit’:
> drivers/clocksource/timer-of.c:29:46: error: passing argument 2 of
> ‘free_percpu_irq’ from pointer to non-enclosed address space
>    29 |                 free_percpu_irq(of_irq->irq, clkevt);
>       |                                              ^~~~~~
> In file included from drivers/clocksource/timer-of.c:8:
> ./include/linux/interrupt.h:201:43: note: expected ‘__seg_gs void *’
> but argument is of type ‘struct clock_event_device *’
>   201 | extern void free_percpu_irq(unsigned int, void __percpu *);
>       |                                           ^~~~~~~~~~~~~~~
> drivers/clocksource/timer-of.c: In function ‘timer_of_irq_init’:
> drivers/clocksource/timer-of.c:74:51: error: passing argument 4 of
> ‘request_percpu_irq’ from pointer to non-enclosed address space
>    74 |                                    np->full_name, clkevt) :
>       |                                                   ^~~~~~
> ./include/linux/interrupt.h:190:56: note: expected ‘__seg_gs void *’
> but argument is of type ‘struct clock_event_device *’
>   190 |                    const char *devname, void __percpu *percpu_dev_id)
>       |                                         ~~~~~~~~~~~~~~~^~~~~~~~~~~~~
> 
> Anyway, your patch fixes the above build errors, as well as sparse
> checking warnings.

Thanks I'll amend the description with your comment

> Tested-by: Uros Bizjak <ubizjak@gmail.com>

Thanks for testing

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

