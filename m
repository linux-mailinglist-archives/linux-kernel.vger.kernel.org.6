Return-Path: <linux-kernel+bounces-392493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B71119B94D6
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 17:01:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CD6E1F22322
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 16:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0B5E1AA788;
	Fri,  1 Nov 2024 16:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="YCb3Wwun"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AED71586C8
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 16:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730476856; cv=none; b=cLBbNzo3MruOUorffUpWfrRfPCp9W/WljMSqkg9L/NQKaSyHr+laL5cOywlEAV7KaDjAuWQyMQah7BFq4QLJWnoVm/eUMuAeC/vqpNcHHVoBmGL3OOQ09+FvHGvB6SYS+R3EY5kg9VKNrMBKqi4xRIpBBJLyGJ0fpjDEaA2uHvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730476856; c=relaxed/simple;
	bh=lZNucv+PPWy5K1UJLM1C1NdHoyGJJqQl0mO7HnnXfz0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PCJIawH2W+UAdnAqs+Oa92iy46OmJhwzIXNdNH3jPEt2jVO1wNvp89bApBa4UVjGR1ri09l8/S2P8y0x5uCOyKs5A5amyulKjOj8+HOBwLJGxWSjvvQ9NL3T9FMjfB+Lafe3Fd36AARfQlotH5uqGJG+btWLMJL97tocU2j+EfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=YCb3Wwun; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-37d6a2aa748so1232081f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 09:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1730476852; x=1731081652; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KYqd6sY/o2ysYuNR1j+SafoMA71bgV0zKTYA4WAwzK4=;
        b=YCb3WwunXueVkQwXCyMD2itHHgOxxoWLL1fweYRwtfBpiywGKk1KoqnctIP0zll8rX
         PfUegY9X04jvPpUoQPwsvwvS1Z4MDlKdpYAEdoIKIBVXihfwGKX+8DesJG6GUc4MEe9O
         Z5lfmPiDHdUHA6vBRO5hX3WSGZ5uva3+IB5sAtRR0+4iEmqcUZU5cevMrp7qWrI8/sAt
         3S7vsAGvTOPTi/o5vxKzNpfXvjs6ut0Fp7vjqAVoE5Jd8WGwrUsZr2a7cVbL/R2l0rAy
         QLYE/7J/TG0lEESb1ybXrN1ACcqAFmxUlZgRXHOVmBOrK+c2K3+LAI9rEW9w9383lPs6
         A6PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730476852; x=1731081652;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KYqd6sY/o2ysYuNR1j+SafoMA71bgV0zKTYA4WAwzK4=;
        b=gmVOzKe3+L4r8jnTl1d6A7bnuLFDPSqiy7lV+H628fMUAb/Py3ibQtCLWXxCVz0N36
         cMefdz1Jx4NXy4mzB8wKiT2MxyZQT1/bUxiG12lbbpbDDOTpH7VtJinQyljdW/1EIrGD
         EiEFFhze1v35wh4c4N6Oo1910ySu1D7Xw9z5/Fbv0NgsfL3MnVI1WkF/6eCzHnxRnH8R
         hPHs4CVFeuFhKHb18Gs0VeA9Y8K3i488RoGQ8zgExxeQ2xv760K7B9CDg3kIXujbr3Wo
         OxrBu9N/y291/4NtVCLQ8bkAjEY+azBRmGf9HcDkTLL2ZAHEvMQtwG9NJABV5iW3sH3g
         MndA==
X-Forwarded-Encrypted: i=1; AJvYcCURmLEdHar751v0AgwxnciTqhbsgQSjE/63YZ1SoMQapl/TyWL5Nr/pHzDbSBYmb4TCYJoWZ6ubnW7cMCg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzrq1mVZAHWpF6gw2ZwLN0UKOgAWGeKhDprZMDLvFF8fEmMc16X
	xWmwjXKOosLkiAQejggvcFDXiZyalX77JMFV8633kH5wb84EW0mHYpPWnK33ERg=
X-Google-Smtp-Source: AGHT+IF+31UkaQD4Bk2fch44Q3qhLJYU672Ie9wm0eb8mrfqiYkGyMRSjiGLJiq4SX/KWz14kzhHDQ==
X-Received: by 2002:a05:6000:1a8c:b0:37d:48ee:d6fc with SMTP id ffacd0b85a97d-381c7a3a486mr2824859f8f.7.1730476851641;
        Fri, 01 Nov 2024 09:00:51 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c10b7b8csm5613158f8f.5.2024.11.01.09.00.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 09:00:51 -0700 (PDT)
Date: Fri, 1 Nov 2024 17:00:49 +0100
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
Message-ID: <ZyT7MScAsHxkACfD@pathway.suse.cz>
References: <20241023121145.1321921-1-jfalempe@redhat.com>
 <20241023121145.1321921-6-jfalempe@redhat.com>
 <Zxpa2zt1P9Avy4Pm@pathway.suse.cz>
 <27c1a6bf-d1e4-469f-a0d4-3e74ab0d0a07@redhat.com>
 <a6c00956-3733-43a1-9538-aa2758d2b4a3@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a6c00956-3733-43a1-9538-aa2758d2b4a3@redhat.com>

On Fri 2024-10-25 11:46:16, Jocelyn Falempe wrote:
> On 25/10/2024 01:11, Jocelyn Falempe wrote:
> > On 24/10/2024 16:34, Petr Mladek wrote:
> > > On Wed 2024-10-23 14:00:13, Jocelyn Falempe wrote:
> > > > The console is already suspended in printk.c.
> > > 
> > > Does this mean that drm_log_client_suspend() is called
> > > after suspend_console(), please?
> > 
> > To be honest, I wasn't able to tell which one is called first, and if
> > the order is enforced (I didn't check if drivers can be suspended in
> > parallel, or if it's all sequential)..
> > 
> > I then checked if it's possible to suspend the console, but didn't found
> > an easy API to do so, so I went with this lazy patch, just ensuring
> > we're not writing to a suspended graphic driver.
> 
> I've run some tests on my hardware, and the console is suspended before the
> graphic driver:
> 
> [   56.409604] printk: Suspending console(s) (use no_console_suspend to
> debug)
> [   56.411430] serial 00:05: disabled
> [   56.421877] sd 0:0:0:0: [sda] Synchronizing SCSI cache
> [   56.421954] sd 4:0:0:0: [sdb] Synchronizing SCSI cache
> [   56.422545] ata1.00: Entering standby power mode
> [   56.422793] DRM log suspend
> 
> But because there is the "no_console_suspend" parameter, and we should make
> sure to not draw when the graphic driver is suspended, I think this patch is
> needed, and good enough.
> I will just rephrase the commit message, to make it clear, that some message
> won't be drawn, only if "no_console_suspend" is set.

Ah, I forgot about the "no_console_suspend" parameter. The problem
with this patch is that it would quietly drop all pending messages.

drm_log_write_thread() does not have any return value.
nbcon_emit_next_record() would assume that the message was printed.
And the kthread would continue emitting next message...

In compare, CON_SUSPENDED would cause that console_is_usable()
returns false. As a result, nbcon_kthread_func() would not try
to emit any message and go into a sleep.

If we set CON_SUSPENDED then the pending messages will get printed
after the resume. If we use this patch, the messages would get lost.


This is why I am not happy with this patch. I would prefer to
block the console. I see three better solutions:

  1. Set CON_SUSPENDED from drm_log_client_suspend even when
     "no_console_suspend" is used.

     It is a bit dirty and might cause some confusion.


  2. Add a new flag, e.g. CON_BLOCKED or CON_DRIVER_BLOCKED,
     which might be used for this purpose.


  3. Allow con->write_thread() to return an error code.

     The question is how exactly the error should be handled.
     The kthread would not know when the printing might succeed
     again.


I personally prefer the 2nd variant.


Best Regards,
Petr

PS: I am sorry for the late reply. I had vacation...

