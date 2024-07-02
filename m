Return-Path: <linux-kernel+bounces-237487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 837C392398D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 11:18:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE9CB1C214C4
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 09:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17E9A156F4D;
	Tue,  2 Jul 2024 09:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Ekuw91J2"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D89A6152179
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 09:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719911508; cv=none; b=IiAjxSY0HAj1MZm2BM2GvVfQGFdvios5CuB87QJbWPpK+5hMdEl/aYcLe6jniwlaaAIJHczEdG2GHFb7lifAMYdDIkScX0IlOIHe7VJDUl8V6UlEqjcxgp7A/ZUiafkbAMBNAZTnaYqndMb/DNyzl0DYLj1IByxz/d2gTnFUvcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719911508; c=relaxed/simple;
	bh=z6hlxmwZ8vXMzBC0jp5rOETwoP9ZI1Nr8hKZRvi92SM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XT6gxbimaTdB5xybJJFelaLAG4b3Skdnzxy9fsraK4043gS+gkwkWlsihfVrYYxoOI4A1O+MoUwBZaJZJiX6o2DLel3WRjSGuLtqNR3P8A892/VA/qJklmXemkcuQgX5FiUdawAbisvTuVdyw0XCxHWA1kKGr7EqLFe3DkDJ3ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Ekuw91J2; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2ebe0a81dc8so53076101fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 02:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1719911504; x=1720516304; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DFwzAYH14bjCnPP4j1GqaNKoDc009KxWwR0/l9tG29M=;
        b=Ekuw91J27NIW+XjDLRSZ/6cXiptTTAu4unFMhFQoSDoz9x5kmpg8EIFMlDJ7DjrEb/
         4Ze9ThvjeqdAU0njd+TudIa3DVEeRJpzldJNq3f9idm9kEifgaqGSnsttW/VLOu+XHON
         sNd1ehWl3ywcLy4dfF0n6cjTzKL8w0SbxQlY5cCJ00w2lIcrZnW12u/DMBb0q6GEoZ0O
         aENzCmPlEKboHUlzSTPozYXFNAw/6PmVlPgMLO7gVX5V4MoEnh86FrDN2cMgyB30wYws
         prcG7pZsQFOkYnW3hN0sBEb/7pAKyChLJh5sCNapid73oJjoV01+5sBayz/ZBd1Y6JTJ
         f21A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719911504; x=1720516304;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DFwzAYH14bjCnPP4j1GqaNKoDc009KxWwR0/l9tG29M=;
        b=G/mEfuabVdbZle6tS2rl34VTKNgKqrC1rsuTa3TA1lB0XH/0ILFUZUlyC+mNmZm/wX
         jch/EZkbwx374Pp46sOVhGb/Ivza8RD3iaHoz8hULeNoDlNI3YrKmP+5oOdRKvrhrq9+
         PUMibzfOgPxJNFYQ8KxgJFcyZDaJtgPRSoCcp750tiBnVzFv6kzkYNIN5NiRKbhQqs/b
         HQV2EAkc9suszwBvOrrNDtXtFU3d6HSt6Rwhmz4OEvesQ5IGiluacTzKMJoLuJ72vrNu
         s/U5AiOREn32alKQCq37LdcPtTmKZUstC6RGicjrBzR6TVSxEZYGMb96yHzd4NXNEZc7
         rGug==
X-Forwarded-Encrypted: i=1; AJvYcCXm56DAx2npeVJdjywgAZXPkwcdHoId2MptLjjLfDwtsc/I7HXG/mYHr/qz/Cq9Vnbl/Os2bRJ9btAvj0SOkga9JYeDzE3SWKkgZt5T
X-Gm-Message-State: AOJu0YxMOo76sh5E/UHYLrRP2/1n0qaMdW3DgwD2Y2C+N61T4BkJmj+y
	HZPfw74R6VF3RysNeCzYjdCTClprw4JVGWmxl1F3uuc4GLaDdnstvwNfwuub9Krzee5myfK9IIH
	0
X-Google-Smtp-Source: AGHT+IGuVN6NDljlMKEEHLMiSAXcwyg61uN3DMV1+R8Qc0516LnegcxCSzAJm/+VjT5qX+nZoO2NAg==
X-Received: by 2002:a2e:300c:0:b0:2ec:4f01:2c0f with SMTP id 38308e7fff4ca-2ee5e3bf062mr62458261fa.26.1719911503862;
        Tue, 02 Jul 2024 02:11:43 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70801e53fa7sm7980306b3a.27.2024.07.02.02.11.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 02:11:43 -0700 (PDT)
Date: Tue, 2 Jul 2024 11:11:36 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v2 12/18] printk: Add kthread for all legacy
 consoles
Message-ID: <ZoPESELkawZhA24J@pathway.suse.cz>
References: <20240603232453.33992-1-john.ogness@linutronix.de>
 <20240603232453.33992-13-john.ogness@linutronix.de>
 <Zn6iq3n2ggL138Gs@pathway.suse.cz>
 <87cyo1xnmw.fsf@jogness.linutronix.de>
 <Zn67hDCEHdgtYPv3@pathway.suse.cz>
 <877ce9xim6.fsf@jogness.linutronix.de>
 <874j9dxdr0.fsf@jogness.linutronix.de>
 <ZoLMRQhrwZnWMuj9@pathway.suse.cz>
 <87a5j0kesc.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a5j0kesc.fsf@jogness.linutronix.de>

On Mon 2024-07-01 23:07:23, John Ogness wrote:
> On 2024-07-01, Petr Mladek <pmladek@suse.com> wrote:
> >> I have a new proposal. What if we allow boot consoles to always print
> >> in the caller context (for any preemption model)? I hacked a quick
> >> test together by providing console_flush_all() an extra argument for
> >> printing _only_ on boot consoles. Then in vprintk_emit(), I always do
> >> a boot-console-only-flush (under console_trylock) after storing the
> >> record in the ringbuffer.
> >> 
> >> For PREEMPT_RT this is horrible. But I am OK with mandating that RT
> >> scheduling cannot be guaranteed with boot consoles (just as it is
> >> currently mandated that RT scheduling cannot be guaranteed in
> >> emergency situations). Since the boot consoles are lockless, they
> >> pose no deadlock threat to RT.
> >
> > Is this really the case for all boot consoles?
> >
> > I had the feeling that some boot consoles actually used port->lock.
> > And for example, register_earlycon() is initializing this spin lock.
> 
> Doing a naive search, it seems like there are a few that do some spin
> locking:
> 
> - alpha/kernel/srmcons.c
> - tty/hvc/hvc_xen.c
> - tty/mips_ejtag_fdc.c
> - usb/early/xhci-dbc.c
> 
> I will need to look at these in more detail.

This looks like a non-trivial thing. I assume that you would do this later.
We probably do not want to complicate/delay the current patchset by this.

> >> - We get true synchronous printing when using boot consoles (which
> >>   should make peterz happy).
> >
> > Well, Peter's mode is really special because it is done without
> > the console_lock(). Every printk() is flushing its own message
> > to the console. Parallel printk()'s are busy waiting for each other.
> 
> This is also what I would like to see. For debugging purposes (which is
> the purpose of CON_BOOT) this mode of operation is probably preferred.

Makes sense. And it would be great when it was enough.

Well, I could also imagine that a non-serialized printk() might be
useful to debug some races in the code before the printk
kthreads are started.

Another scenario where a synchronized printk might be useful is
a sudden death. In this case, the "synchronous" printk would
be needed all the time. People might prefer the current
legacy mode where printk works synchronously most of the time
but it is not fully serialized.

Honestly, I do not know what people want. There always will be
usecase where some mode would be needed or work better.
We should be prepared for the situation when people would
want to keep a mode which has been used last 25+ years.

> >> Looking to the future, I think this would also provide an excellent
> >> foundation for the "sync" console option I would like. For nbcon
> >> consoles with the "sync" option specified, it would work the same
> >> way, flushing boot consoles and nbcon consoles directly in
> >> vprintk_emit().
> >
> > The sync mode would be nice.
> >
> > Just to be sure. I guess that you are talking about a sync mode
> > using some trylock mechanism where the current owner would be
> > responsible for flushing everything.
> >
> > Peter Zijlstra's mode (serialized printk()) is easy to implement
> > and might be needed in some situations. But I am not sure if
> > it would be good enough for most other users preferring the
> > current "synchronous" output.
> 
> I have always envisioned it being a true sync mode. Each console has its
> own nbcon state. So if it was set to sync mode, vprintk_emit() could
> local_irq_save() and then busy-wait until it acquires the nbcon state
> for that console. There would be no handovers and no relying on another
> context to print your message. It would be straight forward and truly
> synchronous (for that console). Back to the roots of printk().

I see this as yet another feature which might be introduced later.
In this patchset, I would keep the legacy behavior when boot
consoles are registered.

Best Regards,
Petr

