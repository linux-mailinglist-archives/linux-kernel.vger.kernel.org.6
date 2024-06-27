Return-Path: <linux-kernel+bounces-231925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A541091A069
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 09:29:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C82911C212C7
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 07:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 779E54E1A2;
	Thu, 27 Jun 2024 07:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A+JkRA2c"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E80D4D11D
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 07:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719473375; cv=none; b=B2XYM6uclGZkQQJfH9wMsvOhXO2edZgcLhsXXSh+w3EACxDdUcJ1nLGOEd86uJgnHNE2Fs9YWn5cuwrGyd/ul6GR9DOd85cNmWagUdChohk+h/pGemf04OWOKvOSZrCcwgyM86/Jg4EWH2MkoFty9egJe+tQAcAUOKTGy/fyUM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719473375; c=relaxed/simple;
	bh=JjSO9oA+bMwMgeph3RVib8k7guo+CU2X8VGJGV3hKAQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IDi7OOxJsvfHueTtx34tO5JX79I3xiz41fCW7hkCQcAKgin/oYUHreLEK9X9fEX/uLSfuCgCwBF4Sy9oe18q+bXVOc74+Q8KPzFWFGxzt5addPMDW3rDJpOs64PZ8Yjd+izegXvbrwcqFvFEoDoMH7mbT2N14qnjVOIuyK68orU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A+JkRA2c; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719473373;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ArljJjB0JyJS00KNOlxMunWxUs1/GD1Wf4W99edQFdU=;
	b=A+JkRA2c6hGai46RC92hnqighdL165ICWakllLKX8cgvzbtTss0ZvJXr7AVNmYVwaX1jLi
	uAX3/z19M+YWmGatfRQcYl9eGKioCin9jUQWLmNZBH8+FTpgmvTGoojbF37eLm5WLKROTQ
	4i+DGcxYOQVTfIuAA+O0dIcoUJ2k0kI=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-412-_wQy8tHFN2KP8pqCTKOH4g-1; Thu, 27 Jun 2024 03:29:30 -0400
X-MC-Unique: _wQy8tHFN2KP8pqCTKOH4g-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-52cdd05fec8so4657103e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 00:29:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719473369; x=1720078169;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ArljJjB0JyJS00KNOlxMunWxUs1/GD1Wf4W99edQFdU=;
        b=rU8naFspADd+rSnWlE5DzxHMITMRTQrDj2LE+OR/mk+oC3fi9omvPZK44WuVUAje0z
         4w1xlF9P6fdg9HcwMzagWKWC46XC5zPag69I7EsS2l7HRhtgL4puRPgmBpfklWbzubsX
         ctX1+oGykGY3oGDvDq3WT52DI6OF80URszzctaQtAKSsiAkbh8qyvREC7eCe8OQDwA7e
         +kUsnccThmBGUswOdKmbXMnpKiqHG14PVGscxJR16RVgSmtmJDAaXKdr9osIe6Phdkvg
         Y3S5Rh/d5AiXIx9h/HZowdjLva6kR1ZqCSMh89fPKvyE+kmyTC3K7ezLXBrZiv2QrPrB
         p53w==
X-Forwarded-Encrypted: i=1; AJvYcCUZ5gjuXZU9koHMqGr/Zr0lit8G8Sap/+Meu5no0jEJ2+JPUeL8aErXTbfVPCIrIkU05VMY8z1ObcVTBs4JARUetC3rgQbzmGZQqAkm
X-Gm-Message-State: AOJu0YxHyi1Q/a2J47RYkLWMhSMGG6SkxtfljqnPmYvx08PP+iPrtsR8
	J72nE+HLXYb/rLl5fB5fEWogCRSXAqGXYHV20ClvCOs4Mb9dKPSt/RUIfWEDnXFN0x/+IT/rYDZ
	SUysuB9+Nib5XRfPjhmiKs+3iT1VMhYEtDe4YgAWStgHeZhHKMzBYSMXXIi3Frg==
X-Received: by 2002:a05:6512:688:b0:52c:8837:718a with SMTP id 2adb3069b0e04-52ce185cffdmr9405301e87.43.1719473369048;
        Thu, 27 Jun 2024 00:29:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHbOO3gAiuM5teegTvAjdpAZYISeHz2jPAZuVwH5HNKIpTCZBH+tcy4/G9Q3EUr6abmm1rODg==
X-Received: by 2002:a05:6512:688:b0:52c:8837:718a with SMTP id 2adb3069b0e04-52ce185cffdmr9405275e87.43.1719473368602;
        Thu, 27 Jun 2024 00:29:28 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:c:37e0:38da:a7d9:7cc9:db3e? ([2a01:e0a:c:37e0:38da:a7d9:7cc9:db3e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-424c8245e7csm52601955e9.3.2024.06.27.00.29.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jun 2024 00:29:28 -0700 (PDT)
Message-ID: <4aa3a028-04e5-4658-9879-df60dab06c54@redhat.com>
Date: Thu, 27 Jun 2024 09:29:25 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] printk: Add a short description string to kmsg_dump()
To: Petr Mladek <pmladek@suse.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin
 <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>,
 "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 Kees Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>,
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
 Steven Rostedt <rostedt@goodmis.org>, John Ogness
 <john.ogness@linutronix.de>, Sergey Senozhatsky <senozhatsky@chromium.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Jani Nikula <jani.nikula@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Kefeng Wang <wangkefeng.wang@huawei.com>,
 Thomas Gleixner <tglx@linutronix.de>, Uros Bizjak <ubizjak@gmail.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-hyperv@vger.kernel.org,
 linux-mtd@lists.infradead.org, linux-hardening@vger.kernel.org
References: <20240625123954.211184-1-jfalempe@redhat.com>
 <ZnvKcnC9ruaIHYij@pathway.suse.cz>
Content-Language: en-US, fr
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <ZnvKcnC9ruaIHYij@pathway.suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 26/06/2024 10:00, Petr Mladek wrote:
> On Tue 2024-06-25 14:39:29, Jocelyn Falempe wrote:
>> kmsg_dump doesn't forward the panic reason string to the kmsg_dumper
>> callback.
>> This patch adds a new parameter "const char *desc" to the kmsg_dumper
>> dump() callback, and update all drivers that are using it.
>>
>> To avoid updating all kmsg_dump() call, it adds a kmsg_dump_desc()
>> function and a macro for backward compatibility.
>>
>> I've written this for drm_panic, but it can be useful for other
>> kmsg_dumper.
>> It allows to see the panic reason, like "sysrq triggered crash"
>> or "VFS: Unable to mount root fs on xxxx" on the drm panic screen.
>>
>> Signed-off-by: Jocelyn Falempe <jfalempe@redhat.com>
>> ---
>>   arch/powerpc/kernel/nvram_64.c             |  3 ++-
>>   arch/powerpc/platforms/powernv/opal-kmsg.c |  3 ++-
>>   drivers/gpu/drm/drm_panic.c                |  3 ++-
>>   drivers/hv/hv_common.c                     |  3 ++-
>>   drivers/mtd/mtdoops.c                      |  3 ++-
>>   fs/pstore/platform.c                       |  3 ++-
>>   include/linux/kmsg_dump.h                  | 13 ++++++++++---
>>   kernel/panic.c                             |  2 +-
>>   kernel/printk/printk.c                     |  8 +++++---
>>   9 files changed, 28 insertions(+), 13 deletions(-)
> 
> The parameter is added into all dumpers. I guess that it would be
> used only drm_panic() because it is graphics and might be "fancy".
> The others simply dump the log buffer and the reason is in
> the dumped log as well.

Ok, I also tried to retrieve the reason from the dumped log, but that's 
really fragile.

> 
> Anyway, the passed buffer is static. Alternative solution would
> be to make it global and export it like, for example, panic_cpu.

It's not a static buffer, because the string is generated at runtime.
eg: https://elixir.bootlin.com/linux/latest/source/arch/arm/mm/init.c#L158

So it will be hard to avoid race conditions.

> 
> Best Regards,
> Petr
> 


