Return-Path: <linux-kernel+bounces-380765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 865CF9AF5BB
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 01:11:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA1E1283003
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 23:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A16F218D61;
	Thu, 24 Oct 2024 23:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g3SF3BpO"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E433E14F9FD
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 23:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729811509; cv=none; b=OpwLBT8AwyeRp9KA5cGkG/3Qkzyqs3K2DA9NY5oiVSY1fR1Nf63T/MWaEXQE+G91FrJk2wYTJY6rT0yxJBVSVALz+jB1tLzWcRVH52pUkjSsh6Asr4rPJg7QtLvOmeshNDQuMzNviZgd+jnYDlYzEDmpu84ix4rRjoQLE1dnxyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729811509; c=relaxed/simple;
	bh=FVFCgQPdujPvqhKahfOuLKz5m3Wze0w+0Fy03qmeQmU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=riRaRAFG9VHiAYvLfmpvmtFiEzIimJcO2nDbxaQX5p2GMFXLUS02/vcrCxdZdNDsucGJunNcqWgnLQlswDb30K9tHAWgfQw8Rf2kJtjmnlCY1R+n78Fqe+sodQNEFLfBNtLWj0Vy6exA3AhoWr0ERWUDrmdZ3FLpxSTL2V35zl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g3SF3BpO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729811505;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rXZPkdgMHHyVt8CVaW2aG/NmyoMp0u0Qd43+yE4rMWI=;
	b=g3SF3BpOBtxzcXqh2mNW6TtELV9vfJFBfHazpsX/ehb6HkeKzH9X/CJ9C+Geq1sYJDobzM
	Ri+1p4SFL/eFkbEWYX6V6BKQ0f9lVtUohLPl9OxBWxQlmDs3v9xHSLg9jcxd6c3tdxX3us
	OYgF0lCfn2dHcJk+QRzesO32lptELfc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-454-PzhW37M4PuSgU5ww2IYOiA-1; Thu, 24 Oct 2024 19:11:42 -0400
X-MC-Unique: PzhW37M4PuSgU5ww2IYOiA-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43164f21063so10047705e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 16:11:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729811501; x=1730416301;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rXZPkdgMHHyVt8CVaW2aG/NmyoMp0u0Qd43+yE4rMWI=;
        b=quhKis2fts7bQflbumgyXb92vZL+N8Ve67ciTRjwxXfx4aCPehnfm/Q/T+xNWHIxT8
         OVIUrP1cwvThLQ2yMcRrRkcyRRYMUoNwz4bFv5Gfkyo16PKLiGC6XGnJkLMxE0hq3HU0
         IGgy0ZD+nZHbq15zn9W09lN2zMyqnILyYoqnJuPvXfwC/QI8yOkQikIrUSBlgIdYHSsg
         mQDcQgPgPDJQFSf3tecyAej/tG8q7Ggg/scmOSI4F1sNMqaVgWXWpaMu8fENFUJkmJnS
         ABiFHXkmA5veQnZvJ4CMYnfCFk2VJNXnCbN3hlVPM6GOtazg52dVZKLNnRfMyH9GXxF9
         DgeQ==
X-Forwarded-Encrypted: i=1; AJvYcCWNtan7UmivtAQgarm1PmxROq4g/c/chfn2QE9gxu5jnMyJDbFSMNlHw8tWlD9AbccMXlac+W+7a8HhDtg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhLm6ICXPDKFEMRtY6wDhnimHPuKoxgmBrlDkSMu8SQeTIal2M
	qMUUZu3eXIo1Az1fR1QTgq+FBYiWa1socAQ1Er33pRXrLf6dXjZPSIYhclrxqvCKWFvvRp+td1N
	QHbHoGoyVd9BN6CxpBH09/f4SuMdXfHa3Cxr/B/Le6+EYNCV44stZ2z0tGjE3jQ==
X-Received: by 2002:a05:600c:1d87:b0:42f:8ac6:4f34 with SMTP id 5b1f17b1804b1-431841ab121mr53037225e9.35.1729811501374;
        Thu, 24 Oct 2024 16:11:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG+Uu0As6KH+ZIsHke5UWCWSFkansh16nnjINSzANHlGC9c9STJlej8pHJDvU1tjgd3Tt4/RQ==
X-Received: by 2002:a05:600c:1d87:b0:42f:8ac6:4f34 with SMTP id 5b1f17b1804b1-431841ab121mr53037065e9.35.1729811500949;
        Thu, 24 Oct 2024 16:11:40 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:c:37e0:ced3:55bd:f454:e722? ([2a01:e0a:c:37e0:ced3:55bd:f454:e722])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4318b566f11sm30877365e9.20.2024.10.24.16.11.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Oct 2024 16:11:39 -0700 (PDT)
Message-ID: <27c1a6bf-d1e4-469f-a0d4-3e74ab0d0a07@redhat.com>
Date: Fri, 25 Oct 2024 01:11:38 +0200
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
Content-Language: en-US, fr
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <Zxpa2zt1P9Avy4Pm@pathway.suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24/10/2024 16:34, Petr Mladek wrote:
> On Wed 2024-10-23 14:00:13, Jocelyn Falempe wrote:
>> The console is already suspended in printk.c.
> 
> Does this mean that drm_log_client_suspend() is called
> after suspend_console(), please?

To be honest, I wasn't able to tell which one is called first, and if 
the order is enforced (I didn't check if drivers can be suspended in 
parallel, or if it's all sequential)..

I then checked if it's possible to suspend the console, but didn't found 
an easy API to do so, so I went with this lazy patch, just ensuring 
we're not writing to a suspended graphic driver.

> 
> By other words, does it mean that "dlog->suspended == true" is set
> only when CON_SUSPENDED is already set in the related con->flags?
> 8
>> Just make sure we don't write to the framebuffer while the graphic
>> driver is suspended.
>> It may lose a few messages between graphic suspend and console
>> suspend.
> 
> The messages should not get lost when the console is properly
> suspended by suspend_console(), set CON_SUSPENDED.
> 
> Or maybe, I do not understand it correctly. Maybe you want to say
> that it should work correctly even without this patch. And this
> patch creates just a safeguard to make sure that nothing wrong
> happens even when suspend_console() was not called from some
> reasons.

I mean that with this patch if the console is suspended after the 
graphic driver, then the message between the suspend of the graphic 
driver and the suspend of the console won't be drawn. I don't see that 
as a big problem, if you debug suspend/resume with drm_log, and the 
screen goes blank, you won't see much anyway. And using dmesg when the 
system is resumed, would have all the messages.

Without this patch, it may crash if the framebuffer is no more 
accessible, and drm_log tries to draw a new line on it.
> 
> 
> Note: I tried to check the order by reading the code. But
>        drm_log_client_suspend() was called via too many layers.
>        And I was not able to find where exactly it was called,
>        for example, from hibernate() in kernel/power/hibernate.c
> 
> 
>> --- a/drivers/gpu/drm/drm_log.c
>> +++ b/drivers/gpu/drm/drm_log.c
>> @@ -310,10 +311,32 @@ static int drm_log_client_hotplug(struct drm_client_dev *client)
>>   	return 0;
>>   }
>>   
>> +static int drm_log_client_suspend(struct drm_client_dev *client, bool _console_lock)
>> +{
>> +	struct drm_log *dlog = client_to_drm_log(client);
>> +
>> +	mutex_lock(&dlog->lock);
>> +	dlog->suspended = true;
>> +	mutex_unlock(&dlog->lock);
> 
> It might also be possible to explicitly set the CON_SUSPENDED flag
> here to be always on the safe side. We could create variant of
> suspend_console() just for one console. Something like:
> 
> void suspend_one_console(struct console *con)
> {
> 	struct console *con;
> 
> 	if (!console_suspend_enabled)
> 		return;
> 
> 	pr_info("Suspending console(%s) (use no_console_suspend to debug)\n");
> 	pr_flush(1000, true);
> 
> 	console_list_lock();
> 	if (con && console_is_registered_locked(con))
> 		console_srcu_write_flags(con, con->flags | CON_SUSPENDED);
> 	console_list_unlock();
> 
> 	/*
> 	 * Ensure that all SRCU list walks have completed. All printing
> 	 * contexts must be able to see that they are suspended so that it
> 	 * is guaranteed that all printing has stopped when this function
> 	 * completes.
> 	 */
> 	synchronize_srcu(&console_srcu);
> }
> 
> and call here:
> 
> 	suspend_one_console(dlog->con);
> 
> 
> But this is not needed when the console is already supposed to be
> disabled here. If this is the case then it might be better
> to just check and warn when it does not happen. Something like:
> 
> void assert_console_suspended(struct console *con)
> {
> 	int cookie;
> 
> 	cookie = console_srcu_read_lock();
> 
> 	/* Do not care about unregistered console */
> 	if (!con || hlist_unhashed_lockless(&con->node))
> 		goto out;
> 
> 	if (WARN_ON_ONCE(!(console_srcu_read_flags(con) & CON_SUSPENDED)))
> 		pr_flush(1000, true);
> out:
> 	console_srcu_read_unlock(cookie);
> }
> 
>> +	return 0;
>> +}
> 
> 

Thanks for this two suggestions, this is really what I was looking for.
I will run some tests on real hardware, to see which one is suspended first.

Best regards,

-- 

Jocelyn

> Best Regards,
> Petr
> 
> PS: I have vacation the following week and might not be able to
>      follow the discussion before I am back.
> 


