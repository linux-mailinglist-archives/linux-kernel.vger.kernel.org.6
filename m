Return-Path: <linux-kernel+bounces-394514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 796B49BB05E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 10:56:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 318A01F2271A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 09:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 243FD1AF0B9;
	Mon,  4 Nov 2024 09:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OuVqlfgU"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A244E1AC43A
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 09:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730714194; cv=none; b=SYjJsEN6/3SxtJDRvpNqwo3dbYIdQtWgzvd2LZaykyhQNa0LdTqOPQ4JIeIzNJvMKAXb1aFxkwmF93WzYsjz8F8kTJB0jtMzKn+3Fs5WAk9u3+HeTnwFU3s86mxdoRSRXSQOA1VVdlJgyJqqrthuQl5d2xbypPsYUUtsHM/R0rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730714194; c=relaxed/simple;
	bh=nHdpv247LA9ew/IBuRehQAh82Ao4YLrgihyzrAjDP+0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I1JVjPAdZWnv3VYjMn1f5udY3sY/IHt5Gg2tz63ZzhlCrZIZaZqK+/8wd+ufGdwv5FkXUGOmB1QDXFIFPdotH3fWm2LaS9jyYBI2GV0CRPqCcsVuZ+NyWqvr0dNdmp9+omVV/NCxBNDZ7YTP2SYsJ1W3RAcD5foEsPpCYp8KkKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OuVqlfgU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730714191;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+O+GodM/+FMt6xYNhMI8LWS+K36k5DEO2ipAK0wzq4Q=;
	b=OuVqlfgUiD9UFcGDAzZkHv+9EO+jBM2aynwVlcEmWxmrJUw1QB9xcVyXgHqnUfqXtuUSgY
	5r8YLycHDXnnOZWAni8b48nSfDJCR4PiAAwXQbA573bP3sst1L1RBkLAHo5ZKXd1v2uvzf
	X/iy/CmxUJ9odxCfZoGwiXc3RfwQImM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-169--HlLpGjtNHKTy70PJZVE7Q-1; Mon, 04 Nov 2024 04:56:30 -0500
X-MC-Unique: -HlLpGjtNHKTy70PJZVE7Q-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-37d67f4bf98so1820716f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 01:56:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730714189; x=1731318989;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+O+GodM/+FMt6xYNhMI8LWS+K36k5DEO2ipAK0wzq4Q=;
        b=Pg8Op8sa/hrZcUsq4w4Pnkm9vjlI/3occHaLp1hCsEz6NoJSDnVCz7eLkXx18vkXpM
         hLkQI9Daj3E5QnYo86/tLHTrNA3SVd9lao3nEk0ju1Y+mOe70NUNZqk2u7MO3I7+uQ3m
         VaDZltFT54Qc/BQgPkDuzPki2UphD8SqXPpDgD48qWwyr1igI45mu2sWP9YMrkiz1zBK
         cRggU4nD7Jz7WDdTPYxshYNrzOYwSEqwk8X7vijMwaaTRnB1k/DDvTDlMftmrf0mkRIU
         Z5vR2x6qvlDQRiRE6FDd9VVUCA/8fSXuwcimvKbaTbJd6Gb8UzjQZaFnFi5gDS/Wrqmc
         IYyA==
X-Forwarded-Encrypted: i=1; AJvYcCX+ZzfImXJOLJoIw22wZd6ztvOZPc0znemBUlkkF9vCXLix1KjSBcby4FgqnlxJg2pqYhSXYneaDJUSOQw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyME9p+L8dhyJjyp/s5T3jfF22o9s271y3QjImBNYc5U2/FtTl3
	mVDcFfTt9HICBuruY4bfEPU8q7v5SR9+Uge7GahINm2K0R+hnAKElBQVHa/GmnnIm+WIInrLta7
	BpJOta8HHmHeQSA8nyIK/aIVzeQ84Er4b86qxG+G7UvF6G25HQCSOc5AfNoBZ/A==
X-Received: by 2002:a5d:530e:0:b0:37d:4fab:c194 with SMTP id ffacd0b85a97d-3806115a933mr20464041f8f.25.1730714189112;
        Mon, 04 Nov 2024 01:56:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEfUOygrLk+iYdGxhbcddNRVSY775g5X2ebYnRvGl9sCoLlnCySDJd+oCk/UgIA9QNvj2TPIQ==
X-Received: by 2002:a5d:530e:0:b0:37d:4fab:c194 with SMTP id ffacd0b85a97d-3806115a933mr20464021f8f.25.1730714188683;
        Mon, 04 Nov 2024 01:56:28 -0800 (PST)
Received: from ?IPV6:2a01:e0a:c:37e0:ced3:55bd:f454:e722? ([2a01:e0a:c:37e0:ced3:55bd:f454:e722])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c113e687sm12783275f8f.84.2024.11.04.01.56.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Nov 2024 01:56:28 -0800 (PST)
Message-ID: <d5c8ea70-8596-42a1-8688-0f6131187b73@redhat.com>
Date: Mon, 4 Nov 2024 10:56:27 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/6] drm/log: Implement suspend/resume
To: Petr Mladek <pmladek@suse.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 John Ogness <john.ogness@linutronix.de>,
 Javier Martinez Canillas <javierm@redhat.com>,
 "Guilherme G . Piccoli" <gpiccoli@igalia.com>,
 bluescreen_avenger@verizon.net, Caleb Connolly <caleb.connolly@linaro.org>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20241023121145.1321921-1-jfalempe@redhat.com>
 <20241023121145.1321921-6-jfalempe@redhat.com>
 <Zxpa2zt1P9Avy4Pm@pathway.suse.cz>
 <27c1a6bf-d1e4-469f-a0d4-3e74ab0d0a07@redhat.com>
 <a6c00956-3733-43a1-9538-aa2758d2b4a3@redhat.com>
 <ZyT7MScAsHxkACfD@pathway.suse.cz>
Content-Language: en-US, fr
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <ZyT7MScAsHxkACfD@pathway.suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01/11/2024 17:00, Petr Mladek wrote:
> On Fri 2024-10-25 11:46:16, Jocelyn Falempe wrote:
>> On 25/10/2024 01:11, Jocelyn Falempe wrote:
>>> On 24/10/2024 16:34, Petr Mladek wrote:
>>>> On Wed 2024-10-23 14:00:13, Jocelyn Falempe wrote:
>>>>> The console is already suspended in printk.c.
>>>>
>>>> Does this mean that drm_log_client_suspend() is called
>>>> after suspend_console(), please?
>>>
>>> To be honest, I wasn't able to tell which one is called first, and if
>>> the order is enforced (I didn't check if drivers can be suspended in
>>> parallel, or if it's all sequential)..
>>>
>>> I then checked if it's possible to suspend the console, but didn't found
>>> an easy API to do so, so I went with this lazy patch, just ensuring
>>> we're not writing to a suspended graphic driver.
>>
>> I've run some tests on my hardware, and the console is suspended before the
>> graphic driver:
>>
>> [   56.409604] printk: Suspending console(s) (use no_console_suspend to
>> debug)
>> [   56.411430] serial 00:05: disabled
>> [   56.421877] sd 0:0:0:0: [sda] Synchronizing SCSI cache
>> [   56.421954] sd 4:0:0:0: [sdb] Synchronizing SCSI cache
>> [   56.422545] ata1.00: Entering standby power mode
>> [   56.422793] DRM log suspend
>>
>> But because there is the "no_console_suspend" parameter, and we should make
>> sure to not draw when the graphic driver is suspended, I think this patch is
>> needed, and good enough.
>> I will just rephrase the commit message, to make it clear, that some message
>> won't be drawn, only if "no_console_suspend" is set.
> 
> Ah, I forgot about the "no_console_suspend" parameter. The problem
> with this patch is that it would quietly drop all pending messages.
> 
> drm_log_write_thread() does not have any return value.
> nbcon_emit_next_record() would assume that the message was printed.
> And the kthread would continue emitting next message...
> 
> In compare, CON_SUSPENDED would cause that console_is_usable()
> returns false. As a result, nbcon_kthread_func() would not try
> to emit any message and go into a sleep.
> 
> If we set CON_SUSPENDED then the pending messages will get printed
> after the resume. If we use this patch, the messages would get lost.
> 
> 
> This is why I am not happy with this patch. I would prefer to
> block the console. I see three better solutions:
> 
>    1. Set CON_SUSPENDED from drm_log_client_suspend even when
>       "no_console_suspend" is used.
> 
>       It is a bit dirty and might cause some confusion.
> 
> 
>    2. Add a new flag, e.g. CON_BLOCKED or CON_DRIVER_BLOCKED,
>       which might be used for this purpose.
> 
> 
>    3. Allow con->write_thread() to return an error code.
> 
>       The question is how exactly the error should be handled.
>       The kthread would not know when the printing might succeed
>       again.
> 
> 
> I personally prefer the 2nd variant.

I looked at what serial drivers are doing, because they can also have 
their clock gated in suspend.

Would calling console_stop() in the suspend and console_start() in 
resume work ?

https://elixir.bootlin.com/linux/v6.11.6/source/drivers/tty/serial/serial_core.c#L2462

https://elixir.bootlin.com/linux/v6.11.6/source/kernel/printk/printk.c#L3323

It looks like it should do exactly what we need ?

Best regards,

-- 

Jocelyn

> 
> 
> Best Regards,
> Petr
> 
> PS: I am sorry for the late reply. I had vacation...
> 


