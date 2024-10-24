Return-Path: <linux-kernel+bounces-380107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2A309AE903
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 16:34:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB6EA1C20DA8
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 14:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 316A51E501B;
	Thu, 24 Oct 2024 14:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="POa3uJc8"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56701B393E
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 14:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729780451; cv=none; b=HfuqNV5gGsi1GSphJTNyRThE+lbOC1XVJYCXLLmPnxtULfYp5ip1itfV0qTT2j8wA4p3vzU7fo86AeVw7suW2tXBMUZVAFjN0i89Pwmb91cVLCasGy9HI5+85ndYPkt7684QLCp93v+sPFAg9+y6gxz13sPY64BT3rNnixWmLaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729780451; c=relaxed/simple;
	bh=w1aMGbWxl5Mmd1x7biQCwQ1bbjbD+6ojL7XhUEP7j2o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AuxSjTcmweIx+UETGTtxKDkQMyjcqAZSB2lMOwntXbtQjH6jZjU0ukQt7spTwAB0+vKkrxyjiZabguMgbJIV/FVsHlmXycDsP3vox3om/bqLtrZhs6KLtfALMhnmD1793IyEQjKvHtvcRiu+5gxqM6FabTmKB44gOl3UHzLeUM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=POa3uJc8; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-431481433bdso10152905e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 07:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1729780446; x=1730385246; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=goylafI7jLfFStQC6WZGaXMsQ2JFeFWTrPYVmVeRIjk=;
        b=POa3uJc8jixtb9BKq3ant+wWlyX2yBzinDzqA8jCLxbhbBAH3l/OBVFU1hNasAoL+l
         86Y5mdQ7Rv0I0zEeHn0iIY/HalG/k+14l6aF0RosLYKW7IZbPcY+Woj79HT/KoNZ75Rw
         ZPkL5MGr+OHtpYtPNGlkYviVtrZTvvzHIYtxagGqRHIekmzBBSe5PKrFjtVjaX+F0w6S
         a+eW4MyYPrz62ChI7oml++vtsocoTGIhIZlNBhw60ksYA4IWIB/07OfqNtJOPj66DnaM
         dxWyYdIbksaf6Jvu4AY6b+qGDj5Viv1g5EDvntJzBP61+23IFfFKIjIV9xIU7MKt0akl
         Io/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729780446; x=1730385246;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=goylafI7jLfFStQC6WZGaXMsQ2JFeFWTrPYVmVeRIjk=;
        b=w3Sego7/7l3S+nyU7Mhy9x5OMMSYih/fFaR+OK5zoVAkEk1WAybKBovhQgYdArsUAz
         rwCTUljA+NM6jy9AS1wfkQW0z9cp40vgwuYU3Km0Ag1w9e9I6JknH+meYevoUeJBhRgm
         XESqXmZix4sBjMOUQYVxkbuptQb37D85IS3Wv5eM6rBM7ytHpknMEj9ICiUC6H2xLoSi
         ldP94fhdDOd6/9Uxd6XelNCgEiWAiRtVeWKq8KYAj1A+XfYtmvymc334OTSTOAIFaZ1K
         ZsUSZ5crwj6De2TqmHe58zOXbSm4C4DVDtcyySZ9b7Spbpv6xS/zFf+nWTBY/HUG/g50
         FduA==
X-Forwarded-Encrypted: i=1; AJvYcCWiwssQsYroGjGqgIhf6ZwsBQWbiW4foX3oT3diGZNGJNk99IH5TP1MHutJu4P4eDmo0HXyDQVAE9uoZ4g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHacJXHUyIM/xgES0xEtuFjzCPP7TCEGb4OhxusTA/0QbW0L2H
	tPvGPEGMx/po9hYT6qWfAjywiuzED0E7C7y6dNf/oDzfExsULahEP08ZGe20XFs=
X-Google-Smtp-Source: AGHT+IFhIt6s0sLeMk2XuVfEdZOyWRHE+/3IRCdvhMVcdF+DL47SssF2SCYQrlPrKU0scUP633tJVg==
X-Received: by 2002:a05:600c:3107:b0:431:52b7:a499 with SMTP id 5b1f17b1804b1-4318416039fmr44548645e9.20.1729780446073;
        Thu, 24 Oct 2024 07:34:06 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43186bde181sm48034125e9.11.2024.10.24.07.34.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 07:34:05 -0700 (PDT)
Date: Thu, 24 Oct 2024 16:34:03 +0200
From: Petr Mladek <pmladek@suse.com>
To: Jocelyn Falempe <jfalempe@redhat.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	John Ogness <john.ogness@linutronix.de>,
	Javier Martinez Canillas <javierm@redhat.com>,
	"Guilherme G . Piccoli" <gpiccoli@igalia.com>,
	bluescreen_avenger@verizon.net,
	Caleb Connolly <caleb.connolly@linaro.org>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 5/6] drm/log: Implement suspend/resume
Message-ID: <Zxpa2zt1P9Avy4Pm@pathway.suse.cz>
References: <20241023121145.1321921-1-jfalempe@redhat.com>
 <20241023121145.1321921-6-jfalempe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241023121145.1321921-6-jfalempe@redhat.com>

On Wed 2024-10-23 14:00:13, Jocelyn Falempe wrote:
> The console is already suspended in printk.c.

Does this mean that drm_log_client_suspend() is called
after suspend_console(), please?

By other words, does it mean that "dlog->suspended == true" is set
only when CON_SUSPENDED is already set in the related con->flags?

> Just make sure we don't write to the framebuffer while the graphic
> driver is suspended.
> It may lose a few messages between graphic suspend and console
> suspend.

The messages should not get lost when the console is properly
suspended by suspend_console(), set CON_SUSPENDED.

Or maybe, I do not understand it correctly. Maybe you want to say
that it should work correctly even without this patch. And this
patch creates just a safeguard to make sure that nothing wrong
happens even when suspend_console() was not called from some
reasons.


Note: I tried to check the order by reading the code. But
      drm_log_client_suspend() was called via too many layers.
      And I was not able to find where exactly it was called,
      for example, from hibernate() in kernel/power/hibernate.c


> --- a/drivers/gpu/drm/drm_log.c
> +++ b/drivers/gpu/drm/drm_log.c
> @@ -310,10 +311,32 @@ static int drm_log_client_hotplug(struct drm_client_dev *client)
>  	return 0;
>  }
>  
> +static int drm_log_client_suspend(struct drm_client_dev *client, bool _console_lock)
> +{
> +	struct drm_log *dlog = client_to_drm_log(client);
> +
> +	mutex_lock(&dlog->lock);
> +	dlog->suspended = true;
> +	mutex_unlock(&dlog->lock);

It might also be possible to explicitly set the CON_SUSPENDED flag
here to be always on the safe side. We could create variant of
suspend_console() just for one console. Something like:

void suspend_one_console(struct console *con)
{
	struct console *con;

	if (!console_suspend_enabled)
		return;

	pr_info("Suspending console(%s) (use no_console_suspend to debug)\n");
	pr_flush(1000, true);

	console_list_lock();
	if (con && console_is_registered_locked(con))
		console_srcu_write_flags(con, con->flags | CON_SUSPENDED);
	console_list_unlock();

	/*
	 * Ensure that all SRCU list walks have completed. All printing
	 * contexts must be able to see that they are suspended so that it
	 * is guaranteed that all printing has stopped when this function
	 * completes.
	 */
	synchronize_srcu(&console_srcu);
}

and call here:

	suspend_one_console(dlog->con);


But this is not needed when the console is already supposed to be
disabled here. If this is the case then it might be better
to just check and warn when it does not happen. Something like:

void assert_console_suspended(struct console *con)
{
	int cookie;

	cookie = console_srcu_read_lock();

	/* Do not care about unregistered console */
	if (!con || hlist_unhashed_lockless(&con->node))
		goto out;

	if (WARN_ON_ONCE(!(console_srcu_read_flags(con) & CON_SUSPENDED)))
		pr_flush(1000, true);
out:
	console_srcu_read_unlock(cookie);
}

> +	return 0;
> +}


Best Regards,
Petr

PS: I have vacation the following week and might not be able to
    follow the discussion before I am back.

