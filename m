Return-Path: <linux-kernel+bounces-301634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F84195F372
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 16:02:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73F751C2039D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 14:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D313188017;
	Mon, 26 Aug 2024 14:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="RZ6QKza5"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9507BFC08
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 14:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724680960; cv=none; b=hDjDgbgkDPcPeUUvBEqhoz6oe2wp3d30+gNb2eofS23K4e5i4lzgiA5y3CseuyFR1u3EYS0YPiySlk8/WQqrI7A7h9TIVABkDFn7wAK95FCV5VcgZIKNqKFxwH+aHsPjgmsqfGdBf5KHjo8WiYL+BYofv3w5fElIrUb7wtzFpf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724680960; c=relaxed/simple;
	bh=5cxuE4PKcDoVz8K1p/cAclSemIvBZlwsMEeUYbTDq48=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GQmSBMjf5ptLwKSxn+dGILE9AJ+1d/tkOr0q+TCfARDN/7dtqC5ctPkXWJ0kIOvp4sqBof5pyX9ZmALwEh4Zklbrr4wj+8wARGaTD8B9Qo7wItONUjQBH+JTbsDfYpdWXR92H2Ut1KgoD0oxT9ibIKTg4eq06qiKQZHzwKwO4p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=RZ6QKza5; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5343617fdddso6279179e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 07:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1724680956; x=1725285756; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NyQI2+zYYES2psL5SX3gnl+wC8mrL0RNw7hfzKkkYHQ=;
        b=RZ6QKza5Z7WCkCYi8SsKpm6P1le1MN4fHa3hmHgU2/ZJKQhDPHDiVX8RVuIosEqWuT
         nIz/8G8u4+kMWIQTNzMKO4hcxaMfjUGWip4k1oE6anxB4bQtCm9mpHaq1YaI0fDqRB0k
         yVVZsX6Qb4QvJ2H37HtlGbEtZVcAv9asqs+jMBIxl84C3SZFGQXxlp7nqjuGoHqKsh/Z
         GmXS4nEpmjQ76pG3mXX8nRXYEJnfLDVUJMrNYaJ9dPdHnrd+exsGEJNKZwqtTyfKtSMK
         tY+Ec85K8/xdUQN++QLg2gyLVoNiwLuorXXfczUoC3y9ivPh2nbKJHoufKaVE7jwxgtI
         xQrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724680956; x=1725285756;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NyQI2+zYYES2psL5SX3gnl+wC8mrL0RNw7hfzKkkYHQ=;
        b=ZXpa+10M+dZ07wDC0yjfEG+Q83offriNuUosgYib1lXXMg7YUoI3njIuqgyt/3UL5Q
         2fDeT1xx+ty1+i71YBJo72pxQjcvGu1jJPU78RFiciu77EX2gLd987OZGGx68e+lt5el
         +b5WrxtJA8drNRc6ymaO0EzHeNvvM6uIOo8S+xWWFyPevQWIK11ivt5yg3F+yC+jnMSP
         FMb4elfpEr7abnKnmRo7c0dDLS4hZOOJa4ECneBxZHFeeezzYqhETqIofYclVwIgjkfe
         uBKxPyJ7pk/Lju5LQnUo0OGInNIODE+nqiMZhZgPVbSw3GeMZeN5CuUvMvodg0wrrG8A
         D4pw==
X-Forwarded-Encrypted: i=1; AJvYcCXlXV2+RO8uKVXSutjZVaE4KdRTrf9jdj36e3ZdSq+R2E+Je8rucw1FrFCpbHvjwpCxRgRkb27mtXF5Bhc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTLwvXAODQcHIQs1ROsWJnNAuZvZDgfYvZHnnklU75VLqMtD9c
	2Q+nGo7CBOVfmLNu/5MVV618u3n/vVZHjFL26A28Kv36dsGIl3396p4LMI5uCSQ=
X-Google-Smtp-Source: AGHT+IGYZx51trJdpSW+7hoCpVTra+ptnGwftP0C7+GW8iO7xDwwV8anDSrRrmbckv9Qe476xmYPOw==
X-Received: by 2002:a05:6512:3d20:b0:52e:73f5:b7c4 with SMTP id 2adb3069b0e04-5343887e063mr7763644e87.37.1724680956222;
        Mon, 26 Aug 2024 07:02:36 -0700 (PDT)
Received: from pathway.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f5085absm665433866b.224.2024.08.26.07.02.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 07:02:36 -0700 (PDT)
Date: Mon, 26 Aug 2024 16:02:34 +0200
From: Petr Mladek <pmladek@suse.com>
To: Derek Barbosa <debarbos@redhat.com>
Cc: pmaldek@suse.com, williams@redhat.com, john.ogness@linutronix.de,
	tglx@linutronix.de, linux-rt-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: test 1: was: Re: A Comparison of printk between upstream and
 linux-rt-devel
Message-ID: <ZsyK-s2D8eqqBrXU@pathway.suse.cz>
References: <ZsdoD6PomBRsB-ow@debarbos-thinkpadt14sgen2i.remote.csb>
 <ZshiIdUFQs4CKW2t@pathway.suse.cz>
 <Zsjd0WUNIU8_kprt@debarbos-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zsjd0WUNIU8_kprt@debarbos-thinkpadt14sgen2i.remote.csb>

On Fri 2024-08-23 15:06:57, Derek Barbosa wrote:
> Hi,
> 
> On Fri, Aug 23, 2024 at 12:19:13PM +0200, Petr Mladek wrote:
> > Could you please also share the kernel command line? I can't find it
> > anywhere.
> > 
> > Especially I am interested whether it:
> > 
> >   + wanted to show backtraces on all CPUs via "panic_print" parameter.
> 
> Sure, here's the output of cat /proc/cmdline on the stock kernel
> 
> BOOT_IMAGE=(hd0,gpt2)/vmlinuz-6.11.0-0.rc3.20240814git6b0f8db921ab.32.eln142.x86_64 
> root=/dev/mapper/cs_rt--qe--06-root ro 
> crashkernel=1G-4G:192M,4G-64G:256M,64G-:512M 
> resume=/dev/mapper/cs_rt--qe--06-swap rd.lvm.lv=cs_rt-qe-06/root rd.lvm.lv=cs_rt-qe-06/swap 
> console=ttyS0,115200
> 
> >   + did a crashdump or a reboot.
>  
> Yes, with kexec-tools and kdump configured, we succesfully booted into the
> kdump kernel and rebooted every time as well as generated vmcores.
>
> In fact, examining said vmvcore-dmesg.txt log, we are able to see the final
> trace printed. It is simply through the serial console that we are unable to.

I see. This probably explains why the result of the stock kernel was so bad.

There are two tricks which increases the chance to see panic
messages on legacy consoles:

    1. bust_spinlocks() causes that con->write() callbacks ignore
       port->lock.

       This helps only when console_trylock() succeeds in printk().
       Also the serial port must be in a state which allows to see
       the data written by con->write().

       This does not help in NMI


    2. console_flush_on_panic() ignores even console_lock()
       It tries to call console drivers even in NMI context.

       This would likely allow to see the panic bracktrace even
       on stock kernel. But it _not_ called when crashdump is
       called.

> I will attach the vmcore-dmesg.txt. I also just did another run of
> console_blast, capturing the output from invocation to reboot.
> >
> >   + used also another console (graphics).
> 
> No, I solely used a serial console at ttyS0 at 115200 baud.

I see.

> > Do you miss the backtrace from the panic-CPU or non-panic-CPUs or
> > both?
> 
> I am not 100% certain. I included the two attachments, which may have your
> answer.
> >
> > The dump of the backtraces on non-panic-CPUs might have been affected
> > by the regression fixed earlier this week via
> > https://lore.kernel.org/r/20240812072703.339690-1-takakura@valinux.co.jp
> 
> Excellent. Is this included in the latest rt-devel tree? I can build that kernel
> and run it through the gambit of tests again.

Not needed. The tests were not affected by the bug because you did not use
"panic_printk" parameter on the command line.

> > Did the system reboot in the end?
> > Or does it got stuck somewhere?
> 
> The system always reboots.

Great.

> If you have any other questions, please let me know. I would be happy to re-do
> these tests with different kernels, configs + other variables and controls.

It might be interesting to redo the 1st test without the crashdump.
I wonder if console_flush_on_panic() would allow to see the panic
backtrace with the stock kernel.

But it is not important. The most important thing is that the new
nbcon consoles are clearly better and more reliable at least in
the tested scenarios.

Best Regards,
Petr

