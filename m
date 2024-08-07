Return-Path: <linux-kernel+bounces-277912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EC4694A80C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 14:48:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B46ECB21583
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 12:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4CE21E6735;
	Wed,  7 Aug 2024 12:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="g/r4xAz2"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E96481C824B
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 12:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723034895; cv=none; b=cw3X0OOBQ1BxiKeE4KjplHAIvVjLrroq1gjotFZnPg/r0tgpbbna2M2GgklVzNaxpj0s7lquQDxGO1/JslNlhOptB9KEk50dIOZY5Tp8pfpATs2Trf2Wryoyavtb3VIjd5/8orC499uALC5ha7uskBSDqm8JvVOb3yDV61Y377o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723034895; c=relaxed/simple;
	bh=oiTbTN5LhmneoFq31HnaDvZnC14/if+F4La/L8nAHdc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gzRrfPVjXJdlBdSpnpGz+NxVEDc3Pr9PbJK267WXwtkIPUsL9LhOio9ZtXcDcMbfTbGcSybWDfo1mTaMdrFm4QU09G60nYfPxRwWSHocMxW30/6TBFigDfw7F7zOfDJBwXQJ37u1R5Nf7B6b6l5KQYuOwIrVqUKDUf7Ouy4087c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=g/r4xAz2; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a7a9185e1c0so182233866b.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 05:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1723034891; x=1723639691; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TEx3Q/q8Dx9YZd98Mep1qJXB/+YjUOnnoN7caf0GuBo=;
        b=g/r4xAz2oYMnoMOSBuyK8L/mzXwhITP+y9HLrPcs3RCE7kkgey4bqtv/GIwAxdu3ja
         j7YRJdOuhpN79UYkWfi5JNViiZJx0Sl2tS/H8FlxmohFl3Mx5rDI+mgSyvaepR8nPJRV
         9eWhc+3aAqKGo7ziV+ue8uzsv3e5DWMoQPjhPu5ZqGJOBcQU6U1ZIo5uPfqGVm8s77Wj
         DkP1qFj1siumP/TN57Cm0qeg/UFVE8uP4iLUoUIWdn6vkZXqxqg9zoReSLp+8+8mJNW5
         JmoNZtlSkH0rusBf2Vfxl4rsCIlQGTmEJStjxYErt/0jh4jDXuYbpBEprj1LBVx2eLtv
         dLfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723034891; x=1723639691;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TEx3Q/q8Dx9YZd98Mep1qJXB/+YjUOnnoN7caf0GuBo=;
        b=i6C5q4qC15EcvbdsmUyyUsb+AHzEgPZ/9ikmRteULE9odfW7cK1HbEcQMmpq5BMmJa
         rAxsTzsze95IAQnXPl5tpIHbjhzKZIVU0ZnqxdNAknh4GmUvWX2xv7xqJTzTZfZM2oJU
         JIhvvGfmNAMoYkYZCyNfonqbcDha9osWplM/GW/cLUvsj/GsbBus2uBbcPSwynGIDCrd
         BvX5iFuliWI5nEF9syyg4zUM/eo58rgZq4sqqD6cM7xCtkiLb1kUxIgWgHH9RJ4oW+kR
         4W+EhHux2+hOI7cWRoWoSJWGPvb9UEDu1BhDGOUv0nDuyuZRFCK/XpIFd0O5JRYbx5+N
         F0Dg==
X-Forwarded-Encrypted: i=1; AJvYcCW4ARB7l68x5PMbksYwnHcjo38THEhlrRkDQkDQFFqDV5tnvH+S6hy8Z8W0DnY15F0/GEA2PLmtn6NQxIs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/cgJayrrjgwxee9cu7HlfWDjr349PTsTaCY+DygByHiaewOsf
	yGlD2JSkzyPO2S7NB5umqeZScoUJQa9EDF8WztEOYiQ2zqRL3VnZyRF5Nm52qqI=
X-Google-Smtp-Source: AGHT+IFYQQB9YJGZJYYMNT+BneL9OIRNvUoEBCbVI0gyuiHEeIW6HzKUdxlD/xxh7Nu5fhpEkt+CfQ==
X-Received: by 2002:a17:907:94cc:b0:a7a:a960:99ee with SMTP id a640c23a62f3a-a7dc4fbac60mr1414529566b.32.1723034891086;
        Wed, 07 Aug 2024 05:48:11 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9bcaf7esm650364566b.12.2024.08.07.05.48.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 05:48:10 -0700 (PDT)
Date: Wed, 7 Aug 2024 14:48:09 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v7 24/35] printk: nbcon: Flush new records on
 device_release()
Message-ID: <ZrNtCWvRK2ASWovm@pathway.suse.cz>
References: <20240804005138.3722656-1-john.ogness@linutronix.de>
 <20240804005138.3722656-25-john.ogness@linutronix.de>
 <ZrDwZfGriZSxmjnp@pathway.suse.cz>
 <875xsdf7zm.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875xsdf7zm.fsf@jogness.linutronix.de>

On Wed 2024-08-07 03:21:57, John Ogness wrote:
> On 2024-08-05, Petr Mladek <pmladek@suse.com> wrote:
> >> +	/*
> >> +	 * This context must flush any new records added while the console
> >> +	 * was locked. The console_srcu_read_lock must be taken to ensure
> >> +	 * the console is usable throughout flushing.
> >> +	 */
> >> +	cookie = console_srcu_read_lock();
> >> +	if (console_is_usable(con, console_srcu_read_flags(con)) &&
> >> +	    prb_read_valid(prb, nbcon_seq_read(con), NULL)) {
> >> +		if (!have_boot_console) {
> >> +			__nbcon_atomic_flush_pending_con(con, prb_next_reserve_seq(prb));
> >> +		} else if (!is_printk_legacy_deferred()) {
> >> +			if (console_trylock())
> >> +				console_unlock();
> >
> > nbcon_device_release() is going to be called in uart_port_unlock*()
> > still under the port->lock.
> >
> > => It smells with a potential deadlock. The console_flush_all() in
> >    console_unlock() might want to flush this console under the
> >    port->lock as well.
> >
> >    And it almost happens because nbcon_legacy_emit_next_record()
> >    might eventually take con->device_lock() when called in
> >    a task context.
> >
> >    It will not happen here because this code uses console_trylock()
> >    which would set @console_may_schedule to false.
> 
> Exactly. That is an important point. We must never try to invoke the
> write_thread() callback while holding a spinlock.
> 
> > Anyway, it would look more safe when the flush was done after releasing
> > the port->lock.
> 
> Even then we could never invoke the write_thread() callback because the
> caller may be holding other spinlocks. If we cannot safely call
> console_lock(), we cannot take the device lock. The atomic callback must
> be used and that means the port lock cannot be involved in the
> console_trylock().

It makes sense. But it is not obvious.

I actually thought about using con->device_lock() lock around
nbcon_legacy_emit_next_record(). It would help to synchronize
the legacy loop against nbcon_device_lock()/nbcon_device_release().
It won't be needed to call the legacy loop in
nbcon_device_release().

But it was bad idea. There are more reasons to avoid taking
con->device_lock() after console_trylock():

  1. con->device_lock() might be a sleeping lock in the future. [*]
     It actually already is a sleeping lock in RT. And
     console_trylock() might be used in printk() in any context.

  2. The less locks we take the more safe printk() will be in
     various contexts and situations, especially in panic().


[*] I still have to wire this into my mental model. I keep forgetting it.

    It would be nice to have a documentation summarizing the main
    ideas and describing the printk() design. I hope that we will
    do it one day.

Best Regards,
Petr

