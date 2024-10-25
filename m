Return-Path: <linux-kernel+bounces-381409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CFB629AFEBD
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 11:46:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F394F1C20D27
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 09:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 834EE1D223A;
	Fri, 25 Oct 2024 09:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SYekbR/9"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E77918B484
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 09:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729849584; cv=none; b=BHRhZJzrIqUe/MmQBz9e1k9Q+2y3A2+ujotOuSHMfxZ/VdkWfHThq+VGb/3uv8hVv4iH+bt0HzoBTiGOZ5oehSsC6zxKUYe+BeKZlJ6QTaqmdxz/rglhRyT0/xvN+rBkFrYdduhnHpIOGUxNxb1hr+TtJZ0v6HbwnWKnm59g8N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729849584; c=relaxed/simple;
	bh=F70AUGFMWHquuy/Tw0eSTXlTTOO5ko037pOHez+98Js=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=PRKeZy6NVnF0CDKtusXj8KxmCn2DzJRmQuOaQ0efY1wSYiG6AXaCg6ZRJx/k4ocD8evzkcHM/aXJhGhm9MNxXXdObDhBact1wZ7RoWxHHu07gaMVKLNm1GpvmNjoFPa6H1MszUALEq8o65QppAPhHN5Q0X5iFkhJ+IQGNUI08fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SYekbR/9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729849581;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tN2jtv5nQdcbiUUSIimpClsmzfgFEiHGDI0Rtzi7SB8=;
	b=SYekbR/9YAxRsjr+urSt789eAOLV/8yqh+4j0ypdgUGHWk0GOIZWpOqmVhzFoyN/4IAQBc
	DsqGgOEPfraIiSkY1Pwc6gGBaFd2a3E+2MdpU9/YTGMKD03ux/6CUQeSftM+lHkL+xl3r/
	q9LWgwY4n8MihhIz/aCGgqJSrpzJ2Ek=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-391-k0S6QNwtMgiRplXB9fOzjg-1; Fri, 25 Oct 2024 05:46:19 -0400
X-MC-Unique: k0S6QNwtMgiRplXB9fOzjg-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4315afcae6cso10456245e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 02:46:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729849579; x=1730454379;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tN2jtv5nQdcbiUUSIimpClsmzfgFEiHGDI0Rtzi7SB8=;
        b=jMauRQ2EMbSceil12w4764vhpnW6MRxftzM0iszKN5q1L0lkmYlS/Na3/IbnFvPHby
         fa32vr6GUyQhrF1nNeLOjChitrSmOZctzj5JEkuUkRaj+OB6BRjsBuLtth7o07uB1zOd
         0NMRRDf3Z4LxFZMh09TWSPi0yJvKk9KUYssCR3c81O2/PDwvmBDQKjCYOR5m6ryK+4gz
         1S2P9d+hCkYMcjiNMtf09rOeY/Azp06Cqxmarr82aE43iHWFA4vB1qKtpQ8NNQgI98J3
         iJ9I+PTEfHTjo9/iGHk1r57W9bu2dcvr94JZxEQRlAs1oEnOQKL9MyDc6bDDDlCj57DH
         GwLQ==
X-Forwarded-Encrypted: i=1; AJvYcCUpCjmbCO9HIDGovZJDqxmdHqL+6zjk4ykS8Wcb348b2hOjGcoVPhZdIH02QgYhjQCM3vk0VAgkRJfIoAE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9B1Z6Dj9BnXk7TopnSmLLv3fDmPuy5a4Dgx425c+I2NIz+TO3
	SEw4ftch9TlwdvGDaaFPcx5QHSrDSm8bWfUqLlsXVb1uuHFxl+zFxDMsKdAguhjstwDea5DfYOj
	6EUm9upQlVhl13nv50g3D3UvppYU/8uUfQJSs0vY03HgHPCnvx1fumuoT801Lyw==
X-Received: by 2002:a05:600c:1c81:b0:42c:b67b:816b with SMTP id 5b1f17b1804b1-4318b587a84mr36508475e9.1.1729849578627;
        Fri, 25 Oct 2024 02:46:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGdpaNFQtFJaFzulwqk0ZgDuMR0ogpkeai/wD4ytXG9nnlj02VWJUL0x4c7pNHzwI2S3E6nFw==
X-Received: by 2002:a05:600c:1c81:b0:42c:b67b:816b with SMTP id 5b1f17b1804b1-4318b587a84mr36508265e9.1.1729849578251;
        Fri, 25 Oct 2024 02:46:18 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:c:37e0:ced3:55bd:f454:e722? ([2a01:e0a:c:37e0:ced3:55bd:f454:e722])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4318b5431c9sm43117955e9.0.2024.10.25.02.46.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Oct 2024 02:46:17 -0700 (PDT)
Message-ID: <a6c00956-3733-43a1-9538-aa2758d2b4a3@redhat.com>
Date: Fri, 25 Oct 2024 11:46:16 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/6] drm/log: Implement suspend/resume
From: Jocelyn Falempe <jfalempe@redhat.com>
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
Content-Language: en-US, fr
In-Reply-To: <27c1a6bf-d1e4-469f-a0d4-3e74ab0d0a07@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 25/10/2024 01:11, Jocelyn Falempe wrote:
> On 24/10/2024 16:34, Petr Mladek wrote:
>> On Wed 2024-10-23 14:00:13, Jocelyn Falempe wrote:
>>> The console is already suspended in printk.c.
>>
>> Does this mean that drm_log_client_suspend() is called
>> after suspend_console(), please?
> 
> To be honest, I wasn't able to tell which one is called first, and if 
> the order is enforced (I didn't check if drivers can be suspended in 
> parallel, or if it's all sequential)..
> 
> I then checked if it's possible to suspend the console, but didn't found 
> an easy API to do so, so I went with this lazy patch, just ensuring 
> we're not writing to a suspended graphic driver.

I've run some tests on my hardware, and the console is suspended before 
the graphic driver:

[   56.409604] printk: Suspending console(s) (use no_console_suspend to 
debug)
[   56.411430] serial 00:05: disabled
[   56.421877] sd 0:0:0:0: [sda] Synchronizing SCSI cache
[   56.421954] sd 4:0:0:0: [sdb] Synchronizing SCSI cache
[   56.422545] ata1.00: Entering standby power mode
[   56.422793] DRM log suspend

But because there is the "no_console_suspend" parameter, and we should 
make sure to not draw when the graphic driver is suspended, I think this 
patch is needed, and good enough.
I will just rephrase the commit message, to make it clear, that some 
message won't be drawn, only if "no_console_suspend" is set.

Best regards,

-- 

Jocelyn

> 
>>
>> By other words, does it mean that "dlog->suspended == true" is set
>> only when CON_SUSPENDED is already set in the related con->flags?
>> 8
>>> Just make sure we don't write to the framebuffer while the graphic
>>> driver is suspended.
>>> It may lose a few messages between graphic suspend and console
>>> suspend.
>>
>> The messages should not get lost when the console is properly
>> suspended by suspend_console(), set CON_SUSPENDED.
>>
>> Or maybe, I do not understand it correctly. Maybe you want to say
>> that it should work correctly even without this patch. And this
>> patch creates just a safeguard to make sure that nothing wrong
>> happens even when suspend_console() was not called from some
>> reasons.
> 
> I mean that with this patch if the console is suspended after the 
> graphic driver, then the message between the suspend of the graphic 
> driver and the suspend of the console won't be drawn. I don't see that 
> as a big problem, if you debug suspend/resume with drm_log, and the 
> screen goes blank, you won't see much anyway. And using dmesg when the 
> system is resumed, would have all the messages.
> 
> Without this patch, it may crash if the framebuffer is no more 
> accessible, and drm_log tries to draw a new line on it.
>>
>>
>> Note: I tried to check the order by reading the code. But
>>        drm_log_client_suspend() was called via too many layers.
>>        And I was not able to find where exactly it was called,
>>        for example, from hibernate() in kernel/power/hibernate.c
>>
>>
>>> --- a/drivers/gpu/drm/drm_log.c
>>> +++ b/drivers/gpu/drm/drm_log.c
>>> @@ -310,10 +311,32 @@ static int drm_log_client_hotplug(struct 
>>> drm_client_dev *client)
>>>       return 0;
>>>   }
>>> +static int drm_log_client_suspend(struct drm_client_dev *client, 
>>> bool _console_lock)
>>> +{
>>> +    struct drm_log *dlog = client_to_drm_log(client);
>>> +
>>> +    mutex_lock(&dlog->lock);
>>> +    dlog->suspended = true;
>>> +    mutex_unlock(&dlog->lock);
>>
>> It might also be possible to explicitly set the CON_SUSPENDED flag
>> here to be always on the safe side. We could create variant of
>> suspend_console() just for one console. Something like:
>>
>> void suspend_one_console(struct console *con)
>> {
>>     struct console *con;
>>
>>     if (!console_suspend_enabled)
>>         return;
>>
>>     pr_info("Suspending console(%s) (use no_console_suspend to 
>> debug)\n");
>>     pr_flush(1000, true);
>>
>>     console_list_lock();
>>     if (con && console_is_registered_locked(con))
>>         console_srcu_write_flags(con, con->flags | CON_SUSPENDED);
>>     console_list_unlock();
>>
>>     /*
>>      * Ensure that all SRCU list walks have completed. All printing
>>      * contexts must be able to see that they are suspended so that it
>>      * is guaranteed that all printing has stopped when this function
>>      * completes.
>>      */
>>     synchronize_srcu(&console_srcu);
>> }
>>
>> and call here:
>>
>>     suspend_one_console(dlog->con);
>>
>>
>> But this is not needed when the console is already supposed to be
>> disabled here. If this is the case then it might be better
>> to just check and warn when it does not happen. Something like:
>>
>> void assert_console_suspended(struct console *con)
>> {
>>     int cookie;
>>
>>     cookie = console_srcu_read_lock();
>>
>>     /* Do not care about unregistered console */
>>     if (!con || hlist_unhashed_lockless(&con->node))
>>         goto out;
>>
>>     if (WARN_ON_ONCE(!(console_srcu_read_flags(con) & CON_SUSPENDED)))
>>         pr_flush(1000, true);
>> out:
>>     console_srcu_read_unlock(cookie);
>> }
>>
>>> +    return 0;
>>> +}
>>
>>
> 
> Thanks for this two suggestions, this is really what I was looking for.
> I will run some tests on real hardware, to see which one is suspended 
> first.
> 
> Best regards,
> 


