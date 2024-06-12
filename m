Return-Path: <linux-kernel+bounces-211702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB18A9055B0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 16:49:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47D2E1F239E0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 14:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CB0117FACE;
	Wed, 12 Jun 2024 14:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="cqY9wgKi"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6249817F518
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 14:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718203697; cv=none; b=H6TJPB1Y8QrMGkyirsOBeGS48Bk2ZtW/6EsZbx4K4XPIONS4y2t5XkyutRo/OF5FJs+yokeNvhIjI8N06cWf9P/vxTM3qxykWSST+i9wWFaR7u/JM8XKycFQYlxq3OKU7cNfvhCcq0EpDsAfeMTHFTGFjVKRFZ8gVXIIx747WMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718203697; c=relaxed/simple;
	bh=gTvUfeVcV0WBX/VSstMj3P4uHESmQaeTlXAV82NwTbY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OyxMpJkBcwHMIqeLYhsQ3E8nN5dQA//xSMrK+pk2KF1/jWwOaB836KqoHIeva66fadcjDHOPhN45V61wPwadiiMRRpDtVDdcJOP9rLauoEBXMHskZ0dbXvnvK8/FjZYTSJhpPUFShhbvowkEp4/Lug7fEeysgPjP3qk520Rhowc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=cqY9wgKi; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a6f1cf00b3aso176919666b.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 07:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1718203693; x=1718808493; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8IWtwzoqSJWM3Lgz12Iah6lW8otD2wfGj7uZTal1qAE=;
        b=cqY9wgKiuy/ci4WOO9TbMUPtNwcwMQ34cJH3IY9Frn0/1QtkzeFZ0/Enb4mBdslaKX
         7539l0Iolf4DarmHzWhJyCLey7SdTSsnjNAlP7NUKW64XYgijMBoVK6rHGxb699Zg5Lj
         3+kil24oBa/8I8eoXdvKPdSph69/MY7lBrhshKAdE9RPKp1dTev6JFaBJN4AbiE2dket
         TcYZgyMAQ6387fnjs/iO331jpXQLwmhpFXS2PlCGusNu7FJAtk0EX9o2CHW9Lw3CTDGV
         U5T0vr2xB/fzegSBsrVr9uKjj2Zdps6cmun3TGsy8O19GHR2Mz92CSP6g+VWUJZ4bFAX
         LtUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718203693; x=1718808493;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8IWtwzoqSJWM3Lgz12Iah6lW8otD2wfGj7uZTal1qAE=;
        b=j27HBpQ0V8W1PKYToXri1Q55JV1uS8KTcYhOZoxzD31syk9dQs+mrXYxmZ1lJnH0Ql
         spuMEc/6Sth4PHg+zwxZXax/HD+2CM3GzJPSNffnakJlL8vJT8ChHjO42EXxlrEhVK1e
         UKrno9Tye1U5LOq6G9xug3bUmXSfI47tADpkSb2jhP++8UO5N9ygfwriH+adMPN+OgcR
         NL1Y8ya5TG4BwIw2GnNETTmU6TkifgIoHbjg33TQXpJM+pu/SdFSPfAdBG+Z4Cnne29L
         INo0uFTTTy6+ygwGzq+7cs9+Y6iYV9vlfsTCZHyRYmggHXegSGbd1pHLNO9qnwea6/57
         azkw==
X-Forwarded-Encrypted: i=1; AJvYcCUVGxadrF9XniFeKaC214a4weE4ZEY5Tclrb0HDLR4FeSLDG8BfVPWEXfghsQX7RdxftGIje8hAjEmA+OsEg0TtFcb6BDMOe804B62E
X-Gm-Message-State: AOJu0YybVNg6pCTld6UPUZmikQvPsIhgN2pliBox7eGmk7j2t/45rkSO
	DsVGlcbCKOxcQC4M106sV4heLxDsGMFuKz/asv0Y6+uba19XsfiSpSSqsBjtvzU=
X-Google-Smtp-Source: AGHT+IFe/XnrBiMyULWYXvobbO+KULp/ZOLbfPDdM4O64ls/uoXWS6C0Worus7xXfYnO3Uc+wuChjQ==
X-Received: by 2002:a17:906:ce44:b0:a6f:51b3:cbad with SMTP id a640c23a62f3a-a6f51b3cc99mr5567166b.25.1718203692687;
        Wed, 12 Jun 2024 07:48:12 -0700 (PDT)
Received: from pathway.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f19171cd0sm453652766b.61.2024.06.12.07.48.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 07:48:12 -0700 (PDT)
Date: Wed, 12 Jun 2024 16:48:10 +0200
From: Petr Mladek <pmladek@suse.com>
To: Tony Lindgren <tony.lindgren@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Tony Lindgren <tony@atomide.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] printk: Track command line console positions to fix
 console order
Message-ID: <Zmm1KpOKkigPRyrG@pathway.suse.cz>
References: <20240606114149.118633-1-tony.lindgren@linux.intel.com>
 <ZmgIB2lQaW9oqn3O@pathway.suse.cz>
 <ZmgfZr5ccHATnkAA@tlindgre-MOBL1>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZmgfZr5ccHATnkAA@tlindgre-MOBL1>

On Tue 2024-06-11 12:56:54, Tony Lindgren wrote:
> On Tue, Jun 11, 2024 at 10:17:11AM +0200, Petr Mladek wrote:
> > On Thu 2024-06-06 14:41:46, Tony Lindgren wrote:
> > > Recent changes to allow using DEVNAME:0.0 style console names caused a
> > > regression to the kernel command line handling for the console options.
> > 
> > Sigh, I have missed that it has already ended in the mainline via
> > the tty tree :-/
> > 
> > Honestly, I would prefer to revert it and implement it a clean way.
> > I see a lot of existing and possible problems:
> 
> Naturally no objection from me for reverting if there are issues that are
> unfixable from the printk point of view. I'll update the fix along the
> lines you're suggesting below though, let's see if that's enough for the
> -rc cycle.

OK, let's see how the updated fix looks like.

> > 1. Where and how is DEVNAME:0.0 defined?
> > 
> >    The only documentation seems to be in
> >    Documentation/admin-guide/kernel-parameters.txt for the console=
> >    parameter:
> > 
> > <paste>
> >                <DEVNAME>:<n>.<n>[,options]
> >                         Use the specified serial port on the serial core bus.
> >                         The addressing uses DEVNAME of the physical serial port
> >                         device, followed by the serial core controller instance,
> >                         and the serial port instance. The options are the same
> >                         as documented for the ttyS addressing above.
> > 
> >                         The mapping of the serial ports to the tty instances
> >                         can be viewed with:
> > 
> >                         $ ls -d /sys/bus/serial-base/devices/*:*.*/tty/*
> >                         /sys/bus/serial-base/devices/00:04:0.0/tty/ttyS0
> > 
> >                         In the above example, the console can be addressed with
> >                         console=00:04:0.0. Note that a console addressed this
> >                         way will only get added when the related device driver
> >                         is ready. The use of an earlycon parameter in addition to
> >                         the console may be desired for console output early on.
> > </paste>
> > 
> >    This seems to be a brand new bus.
> > 
> >    Is it stable?
> >    Is it documented in Documentation/ABI/stable/?
> 
> I think the DEVNAME originates from udev to be used for various rules. Yes
> it should be documented somewhere though. I'd say it's stable as it's been
> in use for years :)
> 
> >    It seems that the feature will cover "only" serial consoles.
> >    But DEVNAME is a generic name. It might make more sense to
> >    call it "SERIAL_BASE_DEVNAME" or "SERIAL_DEVNAME" or "SBASE_DEVNAME" or so.
> > 
> >    Anyway, console= is an interface with the user space. We will need to
> >    maintain the backward compatibility "forever".
> > 
> >       => we should think twice about the interface !!!
> 
> I think we want to keep it generic with DEVNAME, I don't see why we'd want
> make it serial console specific, at least in the code. For the documentation,
> I think the kernel parameters example  is clear on the serial port usage?

OK, let's keep the DEVNAME in both the code and documentation,

> > 3. The delimiter between "DEVNAME" and X.Y numbers is ":".
> >    But ":" is also part of the sample DEVNAME "00:00"
> > 
> >    Is it a good idea?
> > 
> >    Is the current naming scheme a well known historic one
> >    or something invented for the new bus?
> 
> PCI and USB use a ":" already for the device naming. Also a "-" can be used
> by the device names, many platform devices do that. I don't think we can
> pick any better limiter here, at least out of the ":", "-" and "." options.

OK, it seems that ':' is the best choice.

And thanks for explaining the other details. Everything makes more sense now.

Best Regards,
Petr

