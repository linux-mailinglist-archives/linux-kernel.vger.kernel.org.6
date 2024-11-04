Return-Path: <linux-kernel+bounces-395026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4B849BB74B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 15:15:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6BEC1C2208E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 14:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF9FA2AEFE;
	Mon,  4 Nov 2024 14:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ISfQZNnw"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DDC81C695
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 14:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730729744; cv=none; b=qvC+hWjhrtBioANHsp1IR5rIol76fPbojElroIwGUEPyx91FhPabFCzkCG0GUcl/tztbjG/I6OM+IxL2kLTT7wrDixwy5LDRvdWV911bwg0PD8Q21WWLuRtcGljbJYV8uTKVzI2WJqplC8dPKAUizcRcMmfCPwLkexv/Jf3NUZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730729744; c=relaxed/simple;
	bh=EPRoF5uHY4ptkF25ewtVRPLH98Mgwg5vMfora+aYXeY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BRqewjCdFidOciZ859bloiDTMPMvM9GsUWGaKuRfc0aJdM4KXS/rhoAsWxpp0f/RFP6ef+9euNQJFcv7C9eANWsOzGubaDDZlVMe2N1hrafzP1BEjfbRPb+NULO0yZ8WW4k4hA8UFZyCsaCZxh66Qkh9prWg1uZOw8rskPtI/To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ISfQZNnw; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-37d533b5412so2492635f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 06:15:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1730729739; x=1731334539; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NU79Kil2FkJdGGfsE/UuFxB2i6vVhYYTYqxwIZYYOOQ=;
        b=ISfQZNnwpWnBb0M4XOdo7tiUatpOjvt3uvlvvkjPHeKpVyEQ38+c0xUlTRlHYLNjZr
         1QqiIdNbUl5RjY81wZk3NKogLauyUgxw6OZWYl+JWRpXVHmskWU1beIw9HXzvey6j00P
         JTsSdPN80IyK8ca7CoNUXL0jamNrW/XDWyDLknQYCAuVhrTzUKZiHA9gj4GZwBpn2XX4
         JHuZyAmgkIhPOXZbUFCmG6VXET2oHCuROWKVNRJ6rHpkxWGqm4puoZAg7mgkjdG6mw14
         N7dLJH6ULLB4zj8UsUknQxSbJUOoQr3/D3IHS5yqSSmrh44cPMdQJy8FSUz1zkFdoMmD
         Us4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730729739; x=1731334539;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NU79Kil2FkJdGGfsE/UuFxB2i6vVhYYTYqxwIZYYOOQ=;
        b=cwEZUacT9O/dwPwmlsuMDpxygTQgk3kCW12Y6N3C8RY4Un8GZpB1RzNyZvbrvilNEe
         rVo9iNdTkF1BKa3Wux+znmoCvcdgTdsr4MijfzU8i/4wy3BOYh83EZvLRvfEhy0JVLA9
         z+yB+ztDHghjwdK8v1J2LiZnQzqmxS10gnHPRa/8GwgkMheIpmoH/rPdAzV7DWl1PaG5
         lBZKFV2ILatnajJv3lSu1HkjN8hfD1vbZxHOj6Y1x1voXkkL406D1n/yH1VwSPUWTdVP
         TTeye0pdqu+TF92kGbOgcyNx7BtJeEQEkl4XVAvuO3s/SydI0bAtxz0zMEbzi+sGYJfe
         2rAw==
X-Forwarded-Encrypted: i=1; AJvYcCWeuHUSQBO5EGZUsGK9aPo3mC/42c9+mABmOHaUabUtMcionouz3xq5IVxoQYvJ4Kc4LBGOHAAWIxSQ56M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLSKprm9+ie8/gdHK3f2wxvrhvP7QbrST4rShFB+37Ns1LCicG
	hSr8Lf6b+zudZ41avAPalGzpaiNrx2RA3xONSJiwVjwOweZFXU76ASfx8oayqE0=
X-Google-Smtp-Source: AGHT+IG7mlyU7oOO3XUXb2qoKVnfOPe7DTSkNDY8M0ibJiNqB6GPG5O8vddk4VZPk8E9QsQ4xHl8ZA==
X-Received: by 2002:adf:f7ca:0:b0:37d:34f6:92a with SMTP id ffacd0b85a97d-38061220071mr22566149f8f.51.1730729738071;
        Mon, 04 Nov 2024 06:15:38 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c116bb6asm13323778f8f.110.2024.11.04.06.15.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 06:15:37 -0800 (PST)
Date: Mon, 4 Nov 2024 15:15:35 +0100
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
Message-ID: <ZyjXB52dbhjZEHp6@pathway.suse.cz>
References: <20241023121145.1321921-1-jfalempe@redhat.com>
 <20241023121145.1321921-6-jfalempe@redhat.com>
 <Zxpa2zt1P9Avy4Pm@pathway.suse.cz>
 <27c1a6bf-d1e4-469f-a0d4-3e74ab0d0a07@redhat.com>
 <a6c00956-3733-43a1-9538-aa2758d2b4a3@redhat.com>
 <ZyT7MScAsHxkACfD@pathway.suse.cz>
 <d5c8ea70-8596-42a1-8688-0f6131187b73@redhat.com>
 <84o72vcm46.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84o72vcm46.fsf@jogness.linutronix.de>

On Mon 2024-11-04 11:52:33, John Ogness wrote:
> On 2024-11-04, Jocelyn Falempe <jfalempe@redhat.com> wrote:
> > I looked at what serial drivers are doing, because they can also have 
> > their clock gated in suspend.
> >
> > Would calling console_stop() in the suspend and console_start() in 
> > resume work ?
> 
> Yes. That is what it is for.

It seems that you are right. I have never really investigated the purpose
of this API /o\

One problem with this API is that it does not check whether the
console is registered. I wonder whether it might cause problems.

For example, we should not set the CON_ENABLE flag when the console is not
registered. Doing so would cause register_console() to always enable
the console, even when it is not preferred.

Additionally, nbcon_kthread_wake() uses con->rcuwait, which is initialized
by nbcon_alloc() called from register_console(). Fortunately, nbcon_alloc()
is always called even if the console is not enabled in the end, but this
might change in the future and cause subtle errors.

[ After even more thinking ]

I wonder whether console_start()/console_stop() should really
manipulate CON_ENABLE flag. It might be historical solution when
@console_suspended was a global variable.

But it has changed with the commit 9e70a5e109a4a2336 ("printk: Add
per-console suspended state").

It might make more sense when console_start()/console_stop()
manipulates CON_SUSPENDED flag. Then it would make sense
to rename them suspend_this_console()/resume_this_console().

What do you think?

Best Regards,
Petr

