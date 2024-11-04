Return-Path: <linux-kernel+bounces-395064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B85379BB7F8
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 15:36:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07D51B266D3
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 14:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C00FA1AE850;
	Mon,  4 Nov 2024 14:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dw020A50"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D322AEFE
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 14:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730730982; cv=none; b=FIFfqD9ozOWOA6RK2C4Bxpylj5ftbUingEk5Vrptg8t0aNsy+YqdXzVqYa3l7PXr8Fjj9V+ZoAs9Sh3cYl7OtmOZNPIthTsA+4Zb+HmnMKFE/Azfyl7t6NndGJG5hrwflkzj5GKWSKTG958M6mI8hr+Ey1REGrACUqPvjnqCOnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730730982; c=relaxed/simple;
	bh=r1l/6+gYUEPpZb/dlltnHWUr1Wn7e67aY+ZPhgFC3w0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pu0gefXEDc6atX3u0XlJrA/j1tMBFVZGSsTMOLgghaPrpWkb+ij6Xf5ay5yxKuAx0DZSM+OhVZ525Oa7fyWshSQ4b+zgrWxMyqzeoUZgrltwX6s6o6lqde5b86snAbA3kw7wjZq/F1LSzIgvSbUE2Iuth/5wmNEiGLgWwrZUsLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Dw020A50; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730730979;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cYv5vbThzgM6TqwmtQ00YHFrZj4olBrKvIHPrLfcMxM=;
	b=Dw020A50wBu0qIR6CW2pMRfI40Xg8alBYMgW9OLBSuk0Pa1gSvDajuEWKh39keabmlwBN2
	rh2WSL/G17DzZJGHBhBjXwLzPzqHfO1V5D2Bra0epxdx/B42J5FWJwn+CX5xxZvEBZboRB
	d/nRDR+IqXklYGFksl3xU6TuCugDBjQ=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-303-yT9y5_iEOUeKGZ1-7We1tw-1; Mon, 04 Nov 2024 09:36:18 -0500
X-MC-Unique: yT9y5_iEOUeKGZ1-7We1tw-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-539fb5677c9so4206801e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 06:36:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730730977; x=1731335777;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cYv5vbThzgM6TqwmtQ00YHFrZj4olBrKvIHPrLfcMxM=;
        b=qmea5+s7NMnVcf8sXhWNTdBHvh910Um7wKHjspLAxRaLMyNiOYSUsP9gj6RXvrzGn9
         Luzcm8kKgJIXEqvdVYJgQO4qrorfhM+st5Algc58Rh0VS6xSFjHYVJ+cuT0elmRUMaaJ
         8f365faL3LmLOJ/ndbSJrvDv4Zt4GX/ngrP+XhYqT3Ero0ySV2cHAEuMszS2sPhciBGM
         D/H8NJu6kHoYeFQ2WTUvpkChy/k8kPHTiS5/0YGLj7JIR8aEDMYHdOMlQ7EfNWIZAgPA
         wK8WXSUmJsAQBbMvp3x++QXUaC/28OxVq4hfys397rXfj2TJA4W9nVmT8EniKHjn8YRe
         fa7w==
X-Forwarded-Encrypted: i=1; AJvYcCUv3Fp/6+7rfECdP/A2Jx/0ynrOjKGTA9vKO+tADKn+QeuXU6i4lUGSorZPY2L1kN05BKlqteIa0gOJn7s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/5EzSAEMfGuZnVZz5bDdJXj9+2OcvwpSV6CCIkdbLkcoD5i/4
	S9nfUgd48K0SaYFqgh2YrJ76pjgtF4CGF6AMsT/2PWVrMmjGAayWocViOrmeUr5ITd8BVzjSQ/6
	xKr8I3q7aKlAXdLqvElyWUhoL/0zfy8MTT3DEOnDCVjYfh9/n0M1HOQAvFF1xew==
X-Received: by 2002:a05:6512:10cb:b0:52e:f2a6:8e1a with SMTP id 2adb3069b0e04-53b348d8f8dmr14808735e87.29.1730730976566;
        Mon, 04 Nov 2024 06:36:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGZ97CKyrAMWrqbI1YmP6iHAxPErbFd+1wOPyRpIRe9ENekBpxVLZS5MNlcxqS2cN4d8fsTKw==
X-Received: by 2002:a05:6512:10cb:b0:52e:f2a6:8e1a with SMTP id 2adb3069b0e04-53b348d8f8dmr14808716e87.29.1730730976065;
        Mon, 04 Nov 2024 06:36:16 -0800 (PST)
Received: from ?IPV6:2a01:e0a:c:37e0:ced3:55bd:f454:e722? ([2a01:e0a:c:37e0:ced3:55bd:f454:e722])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c10e74casm13314836f8f.65.2024.11.04.06.36.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Nov 2024 06:36:15 -0800 (PST)
Message-ID: <0d478a44-ae01-46a8-b4e7-a28c480e23be@redhat.com>
Date: Mon, 4 Nov 2024 15:36:14 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/6] drm/log: Implement suspend/resume
To: Petr Mladek <pmladek@suse.com>, John Ogness <john.ogness@linutronix.de>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
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
 <d5c8ea70-8596-42a1-8688-0f6131187b73@redhat.com>
 <84o72vcm46.fsf@jogness.linutronix.de> <ZyjXB52dbhjZEHp6@pathway.suse.cz>
Content-Language: en-US, fr
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <ZyjXB52dbhjZEHp6@pathway.suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04/11/2024 15:15, Petr Mladek wrote:
> On Mon 2024-11-04 11:52:33, John Ogness wrote:
>> On 2024-11-04, Jocelyn Falempe <jfalempe@redhat.com> wrote:
>>> I looked at what serial drivers are doing, because they can also have
>>> their clock gated in suspend.
>>>
>>> Would calling console_stop() in the suspend and console_start() in
>>> resume work ?
>>
>> Yes. That is what it is for.
> 
> It seems that you are right. I have never really investigated the purpose
> of this API /o\
> 
Thanks, I will send a v6 with that change.

> One problem with this API is that it does not check whether the
> console is registered. I wonder whether it might cause problems.

At least for drm_log, register_console() will always be called before.
> 
> For example, we should not set the CON_ENABLE flag when the console is not
> registered. Doing so would cause register_console() to always enable
> the console, even when it is not preferred.
> 
> Additionally, nbcon_kthread_wake() uses con->rcuwait, which is initialized
> by nbcon_alloc() called from register_console(). Fortunately, nbcon_alloc()
> is always called even if the console is not enabled in the end, but this
> might change in the future and cause subtle errors.
> 
> [ After even more thinking ]
> 
> I wonder whether console_start()/console_stop() should really
> manipulate CON_ENABLE flag. It might be historical solution when
> @console_suspended was a global variable.
> 
> But it has changed with the commit 9e70a5e109a4a2336 ("printk: Add
> per-console suspended state").
> 
> It might make more sense when console_start()/console_stop()
> manipulates CON_SUSPENDED flag. Then it would make sense
> to rename them suspend_this_console()/resume_this_console().
> 
> What do you think?

Maybe when registering the console, having a flag to say "I want this 
console to be suspended with the console subsystem" or "I want to handle 
suspend/resume on my own, and call the relevant functions" would be better ?

That would avoid having the same console being suspended/resumed twice, 
and making clear what to expect.

Of course "no_console_suspend" won't really work for drivers handling 
suspend/resume themselves.

-- 

Jocelyn
> 
> Best Regards,
> Petr
> 


