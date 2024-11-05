Return-Path: <linux-kernel+bounces-396396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C52089BCC98
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 13:20:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 831DA280F79
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 12:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21EAD1D5145;
	Tue,  5 Nov 2024 12:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="XESoF6jh"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F3CB667
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 12:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730809196; cv=none; b=gSP0MOUuso/erdxG+YEkd+28OIsqi+N6ojHgOYfjTBV8FMIqs0Q7dhGswUPhkHZXka3w3pxbadGmCN/fm5fT/fFj+h+F4VrRvnBAc9DqNUC+4EGy+PFElA5yeMY8MxsOdhhqemQYEBYC2E04VPS5s56vn1dZGsBsH0c++tEf2lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730809196; c=relaxed/simple;
	bh=cSfRNVa689NsXFf6LQVBfgwq1hNCsNjbBEQzj+E3I3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=leZE/rXeJL1OHzlKHTLkJnH2bXE0uy136Q/0jIUT9jmf1aQc5Y3csi80enjl3L5utoiucpIJXhUtKGxlbxHT8SjTGE38VepzCSaCMl7FtfVr6ZfinfrSLr5BStB4W3PPcStLaIzKyQWFXUw4lyrH1kUwrXox7k5fVFEiGGx7j+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=XESoF6jh; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4314c4cb752so47748765e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 04:19:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1730809192; x=1731413992; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sQU/IyTDBE8a53IlvM72u1kGeqOoXp5doWB497P289E=;
        b=XESoF6jhDVTWeFgui9DjzNdq9J+YAeuQjI9sD4mBRZ2JPLjejs6YePTbLqtBB7DHNC
         KiOay1kfixN4mPwGRSGX75+H2UU/AFY3nZIxXOUu14kVhVW8//du9tetn3R+4cfYNANn
         SC7jwoLe4iRwC4M4HtXYhZutp5oK6tKtzkilUL2leoGJHy53l/SJmKLewTkaxebTMGWA
         nNtj4+MEn4eVEYnRXlUeq3DMhdUgmxUYJhu3nog8or7QkzAwoqRvBhqQdDINVDB4Jbgu
         J/XN/JQ1V5b7P2IolBY3qu68KEkRaO1QT0TVawXSAXh0hmsVWQGiZ+fztDJSHefYUAKk
         040A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730809192; x=1731413992;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sQU/IyTDBE8a53IlvM72u1kGeqOoXp5doWB497P289E=;
        b=EQUXluz2srnaenAfNL9EeQ2oiwppjUID1lSUSt68OfPHnFd3PgC2sfSN7x7BgDPkNI
         YM21cqZ3OCAHQeOWdRq5xbaxEW3VWqoGAGeXEcs4B/eM+oNwDFwFRXYHPJT8bWQGvW7n
         Ooo8l/sX1oGNuTSRHCozW3fSXbh2hBnLTyyzF2SedRta6UGb1rC5CJ9Rbdm0dKY5s+Kc
         IfjimMFYj2VXjAhE8q2/VdudCGVDYne4G1VFg8rYgV8gq9/MiiT7duGZj5iV8EDKoF9o
         bykw+z0KPRl9nUcpecKP1UXl6cb9yk+xttX1BpF799IwMeu5ztO2jRECcqxsSTBksh42
         m0iQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPfpNq/7TFs519nty7TiZudqBXuoXFcEpK40DPMoiWewyPObluR9h+zOQl97dl0Kin5foY7nSHFrXAKT4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUY5uayHX+rx9KIn+Pbt729ImurS3FOE0LPht1KHFSTA0phktj
	DGWw00KE04onKsDyITBpjlBVk+En3at9RyPfR9mcA3s0Ab3ADsYImunEWt5GlxA=
X-Google-Smtp-Source: AGHT+IHoLA3MoVlv5d8Tr8bssN98IwzqrS77jeXA72lGk7Cq/J3lymLYGnd59ADYoNu4jd5UWw1wmw==
X-Received: by 2002:a5d:6c61:0:b0:35f:d70:6193 with SMTP id ffacd0b85a97d-381bea1c0c9mr17374862f8f.41.1730809192376;
        Tue, 05 Nov 2024 04:19:52 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c10b7d15sm16238437f8f.8.2024.11.05.04.19.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 04:19:52 -0800 (PST)
Date: Tue, 5 Nov 2024 13:19:49 +0100
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Jocelyn Falempe <jfalempe@redhat.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Javier Martinez Canillas <javierm@redhat.com>,
	"Guilherme G . Piccoli" <gpiccoli@igalia.com>,
	bluescreen_avenger@verizon.net,
	Caleb Connolly <caleb.connolly@linaro.org>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 5/6] drm/log: Implement suspend/resume
Message-ID: <ZyoNZfLT6tlVAWjO@pathway.suse.cz>
References: <20241023121145.1321921-1-jfalempe@redhat.com>
 <20241023121145.1321921-6-jfalempe@redhat.com>
 <Zxpa2zt1P9Avy4Pm@pathway.suse.cz>
 <27c1a6bf-d1e4-469f-a0d4-3e74ab0d0a07@redhat.com>
 <a6c00956-3733-43a1-9538-aa2758d2b4a3@redhat.com>
 <ZyT7MScAsHxkACfD@pathway.suse.cz>
 <d5c8ea70-8596-42a1-8688-0f6131187b73@redhat.com>
 <84o72vcm46.fsf@jogness.linutronix.de>
 <ZyjXB52dbhjZEHp6@pathway.suse.cz>
 <84ikt3c8uy.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84ikt3c8uy.fsf@jogness.linutronix.de>

On Mon 2024-11-04 16:38:53, John Ogness wrote:
> On 2024-11-04, Petr Mladek <pmladek@suse.com> wrote:
> > I wonder whether console_start()/console_stop() should really
> > manipulate CON_ENABLE flag. It might be historical solution when
> > @console_suspended was a global variable.
> >
> > But it has changed with the commit 9e70a5e109a4a2336 ("printk: Add
> > per-console suspended state").
> >
> > It might make more sense when console_start()/console_stop()
> > manipulates CON_SUSPENDED flag. Then it would make sense
> > to rename them suspend_this_console()/resume_this_console().
> 
> I worry about letting console drivers and printk.c both modify this flag
> during normal runtime. One might clear CON_SUSPENDED too soon and cause
> trouble.
> 
> CON_ENABLE and @console_suspended were always orthogonal. Moving
> @console_suspended to CON_SUSPENDED did not change that relationship.
> 
> IMHO we should continue to keep them separate. But your point about the
> console not being registered is a good one. We should update
> console_stop()/console_start() to only operate on @console if it is
> registered. Since those functions take the console_list_lock anyway, it
> would be a simple change.

First, I am fine with using console_start()/console_stop() in this
patchset. I agree that this API was created for this purpose
and should still work fine.

But I think that the API is a bit messy and would deserve a clean up.
We should do it in a separate patchset.


History:

  + commit 56dafec3913935c997 ("Import 2.1.71") in v2.1.71, Nov 2007 [1]

    This version introduced "console=" parameter which allowed to
    choose the consoles on the commandline. Before, they were
    selected at build time.

    The @flags and CON_ENABLED flag were added here as well.
    It looks to me like all available console drivers were registered
    but only consoles with CON_ENABLE flag printed the messages.


  + commit 33c0d1b0c3ebb61243d9b ("[PATCH] Serial driver stuff")
    in v2.5.28, Jul 2002 [1]

    Added generic serial_core. The CON_ENABLED flag was re-used
    to disable console when suspending the serial drivers.


  + commit 557240b48e2dc4f6fa878 ("Add support for suspending and
    resuming the whole console subsystem") in v2.6.18, Jun 2006

    Added @console_suspended global variable. It was used as a big hammer
    to block all console drivers and avoid subtle problems during suspend.


  + commit 9e70a5e109a4a233678 ("printk: Add per-console suspended state")
    in v6.6, Jul 2023

    Replaced the global @console_supended global variable with
    per-console CON_SUSPENDED flag.

    The motivation seems to be to remove dependency on console_lock.
    The per-CPU flag allows to query the state via SRCU.

    But the flag is set for all consoles at the same time in
    console_suspend()/console_resume()

	=> it still works as the big hammer.


Observation:

  + CON_ENABLED is not needed for the original purpose. Only enabled
    consoles are added into @console_list.

  + CON_ENABLED is still used to explicitely block the console driver
    during suspend by console_stop()/console_start() in serial_core.c.

    It is not bad. But it is a bit confusing because we have
    CON_SUSPENDED flag now and this is about suspend/resume.


  + CON_SUSPENDED is per-console flag but it is set synchronously
    for all consoles.

    IMHO, a global variable would make more sense for the big hammer
    purpose.


Big question:

  Does the driver really needs to call console_stop()/console_start()
  when there is the big hammer?

  I would preserve it because it makes the design more robust.

  Anyway, the driver-specific handling looks like the right solution.
  The big hammer feels like a workaround.


Reasonable semantic:

  1. Rename:

	console_suspend() -> console_suspend_all()
	console_resume()  -> console_resume_all()

     and manipulate a global @consoles_suspended variable agagin.
     It is the big hammer API.


  2. Rename:

	console_stop(con)  -> console_suspend(con)
	console_start(con) -> console_resume(con)

     and manipulare the per-console CON_SUSPENDED flag here.


   3. Get rid of the ambiguous CON_ENABLED flag. It won't longer
      have any purpose.

      Except that it is also used to force console registration.
      But it can be done a better way, e.g. by introducing
      register_console_force() API.


As I said, we could/should this clean up in a separate patchset.
Like printk-people should fix the printk-mess.


[1] pre-git linux kernel history:
    git://git.kernel.org/pub/scm/linux/kernel/git/history/history.git

Best Regards,
Petr

