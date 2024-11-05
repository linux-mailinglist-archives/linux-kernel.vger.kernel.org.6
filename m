Return-Path: <linux-kernel+bounces-396578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE7BB9BCF0B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 15:21:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD03A1C22C9D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 14:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C4211D9669;
	Tue,  5 Nov 2024 14:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WK8KsgU1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zgzRxGZP"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B4EF1D933A
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 14:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730816376; cv=none; b=d8v1+3YIso/zd4toRGLujiX2mKdUdCIVdqMceSrl1Y7x3V7EM7J0AmeBkLWogF4rSw9geUpR9qf9OdkzwBv0HQ7bH0WzornxKe/lSyQ5wcSwUNTWevIMV82HReuUDHfgvrK+aeAvy81a0gpN1S6Y3M8ZjISG1IVQosqh93oXY8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730816376; c=relaxed/simple;
	bh=iiLX1b/J0tiwuRIpePIIt5LneWbItyz0ZCjO4407Kf4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LCa8XQMw4vy1UiXZWozfS1DXPCm378OJPA8VgKIKy5ymHRht2ANpPpoI33dPEQvtPhpDAC1a8AccmZaccmRvIsp/OUslGW+UItuNViHKtfKKB+hw4ALBEYwWyx2GZRL92yTzjdLYMF2GVOEhuzc54e/MItIQJxnHXevCwqCmKqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WK8KsgU1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zgzRxGZP; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730816371;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=D3f0JmLHkvF+6wnB/S3LI0uD2ynto7nK8TgQHv09rcI=;
	b=WK8KsgU1/QBerDp5/7zg7F6Ow7NvKYSDCCXSpKzLEZrGJXa+8OtLdIA3nF3Kq9FH/YZCan
	GxDtdGAJLBFZX2cj7Y47+dOZ7D4ekDsO+/ppRpNYi48PyrSXWQ5ImQBWcwYSKtI+U+TSRv
	XU9UxlorSkZNEej27Ay1jhojthlZJLsAD6Jk+os4kS/eXhB6aG4i7UbDV+uU0K9JjJJYYy
	WcPrzlrbbNSt/ACopLR4EfpKqIXZSIs4G7xwztsnw/Ohio+oCWeKYEbrCHC8lgfs9n6U/I
	kfV5nsyI5fE4BEtcxIJjRCeMqEGAc3uOR2tLcNcE5iGo2KGIfx1pKqor8aS5hw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730816371;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=D3f0JmLHkvF+6wnB/S3LI0uD2ynto7nK8TgQHv09rcI=;
	b=zgzRxGZPqQir4mOgbd+OBFSjO59uQulWnQJVxsEWyBYwgkds1QLqoxWg+HRX8SINQU0bQh
	lPi6fcDxz9t4UDDg==
To: Petr Mladek <pmladek@suse.com>
Cc: Jocelyn Falempe <jfalempe@redhat.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Javier Martinez Canillas
 <javierm@redhat.com>, "Guilherme G . Piccoli" <gpiccoli@igalia.com>,
 bluescreen_avenger@verizon.net, Caleb Connolly
 <caleb.connolly@linaro.org>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 5/6] drm/log: Implement suspend/resume
In-Reply-To: <ZyoNZfLT6tlVAWjO@pathway.suse.cz>
References: <20241023121145.1321921-1-jfalempe@redhat.com>
 <20241023121145.1321921-6-jfalempe@redhat.com>
 <Zxpa2zt1P9Avy4Pm@pathway.suse.cz>
 <27c1a6bf-d1e4-469f-a0d4-3e74ab0d0a07@redhat.com>
 <a6c00956-3733-43a1-9538-aa2758d2b4a3@redhat.com>
 <ZyT7MScAsHxkACfD@pathway.suse.cz>
 <d5c8ea70-8596-42a1-8688-0f6131187b73@redhat.com>
 <84o72vcm46.fsf@jogness.linutronix.de> <ZyjXB52dbhjZEHp6@pathway.suse.cz>
 <84ikt3c8uy.fsf@jogness.linutronix.de> <ZyoNZfLT6tlVAWjO@pathway.suse.cz>
Date: Tue, 05 Nov 2024 15:25:31 +0106
Message-ID: <844j4lepak.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2024-11-05, Petr Mladek <pmladek@suse.com> wrote:
> Observation:
>
>   + CON_ENABLED is not needed for the original purpose. Only enabled
>     consoles are added into @console_list.
>
>   + CON_ENABLED is still used to explicitely block the console driver
>     during suspend by console_stop()/console_start() in serial_core.c.
>
>     It is not bad. But it is a bit confusing because we have
>     CON_SUSPENDED flag now and this is about suspend/resume.

Also note that CON_ENABLED is used to gate ->unblank(). It should
probably consider CON_SUSPENDED as well.

>   + CON_SUSPENDED is per-console flag but it is set synchronously
>     for all consoles.
>
>     IMHO, a global variable would make more sense for the big hammer
>     purpose.
>
>
> Big question:
>
>   Does the driver really needs to call console_stop()/console_start()
>   when there is the big hammer?
>
>   I would preserve it because it makes the design more robust.

Agreed. They serve different purposes.

console_stop()/console_start() is a method for _drivers_ to communicate
that they must not be called because their hardware is not
available/functioning.

console_suspend()/console_resume() is a method for the _system_ to
communicate that consoles should be silent because they are annoying or
we do not trust that they won't cause problems.

>   Anyway, the driver-specific handling looks like the right solution.
>   The big hammer feels like a workaround.

Agreed. Do the 6 call sites even really need the big hammer? I am
guessing yes because there are probably console drivers that do not use
console_stop()/console_start() in their suspend/resume and thus rely on
the whole subsystem being disabled.

> Reasonable semantic:
>
>   1. Rename:
>
> 	console_suspend() -> console_suspend_all()
> 	console_resume()  -> console_resume_all()
>
>      and manipulate a global @consoles_suspended variable agagin.
>      It is the big hammer API.

Agreed. As a global variable, it can still rely on SRCU for
synchronization.

>   2. Rename:
>
> 	console_stop(con)  -> console_suspend(con)
> 	console_start(con) -> console_resume(con)
>
>      and manipulare the per-console CON_SUSPENDED flag here.

Agreed.

>    3. Get rid of the ambiguous CON_ENABLED flag. It won't longer
>       have any purpose.
>
>       Except that it is also used to force console registration.
>       But it can be done a better way, e.g. by introducing
>       register_console_force() API.

Agreed.

John

