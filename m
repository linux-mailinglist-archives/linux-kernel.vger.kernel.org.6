Return-Path: <linux-kernel+bounces-213097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 245E7906B0B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 13:34:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D14D1C24822
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 11:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BD5C143C41;
	Thu, 13 Jun 2024 11:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BxvJ92s9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FFC713791B;
	Thu, 13 Jun 2024 11:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718278420; cv=none; b=cKM6r04GNYQ7/YRGMcaUJRQrD20lfnflw0RbPXCdAsrWQXsjwdu4IWCBkSCnRFFdkAIZdvM977Tz4JAWD4du8kJd/HKa4XrCsbG8yvBWxYffhzZ7I71UONoEWGcpZWwo/NBtB4a/OtiD6OqzYM7rPMhv4Y5PJ8bKqJH2vi7g9fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718278420; c=relaxed/simple;
	bh=tYDOTnZN4WaMj/eRey1nKzm34RYJ/l/vK+gS9mH/eLg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q7htQS8KLoqO3z2KAysj7vKTm0iOjJSV/uyWadmkk7MKVIvYGw1PjOlqnkWE3Xbn6DUprGYEF5w1OIV07OE1knww5n3t0r+G3iblimujyP7EA1PXXwWrDNGCHojCvO49xbTuuMqx/6eKo/BjIr9YDBQho4ur28bai0Ro87mj8mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BxvJ92s9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADBB5C2BBFC;
	Thu, 13 Jun 2024 11:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718278420;
	bh=tYDOTnZN4WaMj/eRey1nKzm34RYJ/l/vK+gS9mH/eLg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BxvJ92s90ZNTNMAoWAKt2fgASuD522HcKk4RnTPwXX/bbP5uSA7bW0D9lW3D1cVWc
	 icfLjlRNOVbLiUlFXnepLSwWxqbrLzPn0RhNwB4ABsZdSH3RcbEKzh5bd6RobMeGtf
	 JdpIhGpIREndf1numOH4L2xJLOeQSo5KXty5ipvk=
Date: Thu, 13 Jun 2024 13:33:37 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Jonathan Corbet <corbet@lwn.net>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-gpio@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v8 2/2] misc: gpio-virtuser: new virtual testing driver
 for the GPIO API
Message-ID: <2024061336-scooter-immortal-ec5f@gregkh>
References: <20240613092830.15761-1-brgl@bgdev.pl>
 <20240613092830.15761-3-brgl@bgdev.pl>
 <2024061356-uptake-ideology-e57b@gregkh>
 <CAMRc=MfjQdFR_8ALGibxQnr5tzoHykCBpkBxjH78c5HuD43rBg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=MfjQdFR_8ALGibxQnr5tzoHykCBpkBxjH78c5HuD43rBg@mail.gmail.com>

On Thu, Jun 13, 2024 at 01:22:58PM +0200, Bartosz Golaszewski wrote:
> On Thu, Jun 13, 2024 at 12:02 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Thu, Jun 13, 2024 at 11:28:30AM +0200, Bartosz Golaszewski wrote:
> > > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > >
> > > The GPIO subsystem used to have a serious problem with undefined behavior
> > > and use-after-free bugs on hot-unplug of GPIO chips. This can be
> > > considered a corner-case by some as most GPIO controllers are enabled
> > > early in the boot process and live until the system goes down but most
> > > GPIO drivers do allow unbind over sysfs, many are loadable modules that
> > > can be (force) unloaded and there are also GPIO devices that can be
> > > dynamically detached, for instance CP2112 which is a USB GPIO expender.
> > >
> > > Bugs can be triggered both from user-space as well as by in-kernel users.
> > > We have the means of testing it from user-space via the character device
> > > but the issues manifest themselves differently in the kernel.
> > >
> > > This is a proposition of adding a new virtual driver - a configurable
> > > GPIO consumer that can be configured over configfs (similarly to
> > > gpio-sim) or described on the device-tree.
> > >
> > > This driver is aimed as a helper in spotting any regressions in
> > > hot-unplug handling in GPIOLIB.
> > >
> > > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > > ---
> > >  .../admin-guide/gpio/gpio-virtuser.rst        |  176 ++
> > >  Documentation/admin-guide/gpio/index.rst      |    1 +
> >
> > sysfs documentation needs to go in Documentation/ABI/ not in a random
> > .rst file where the tools that check this will not catch it.
> >
> 
> This is a testing driver, not representing real hardware. Do we hold
> such modules to the same standard?

Yes.

> > >  MAINTAINERS                                   |    8 +
> > >  drivers/misc/Kconfig                          |    8 +
> > >  drivers/misc/Makefile                         |    1 +
> > >  drivers/misc/gpio-virtuser.c                  | 1790 +++++++++++++++++
> >
> > Why not put this in drivers/gpio/?  Why misc?
> >
> 
> Because it's quite... well "misc". It's not a GPIO chip provider
> (drivers/gpio/ is for GPIO providers), it's only a GPIO consumer. It
> also has an interface that doesn't fit any particular subsystem.

but it's gpio-specific, please put it there.

> > > +Both attributes allow to read and set arrays of GPIO values. User must pass
> > > +exactly the number of values that the array contains in the form of a string
> > > +containing zeroes and ones representing inactive and active GPIO states
> > > +respectively. In this example: ``echo 11 > values``.
> >
> > sysfs is "one value per file", so why are there multiple values here?
> >
> > If you want to just use this for testing, and want to put whatever you
> > want in the files, just use debugfs, that's what it is there for, not
> > sysfs.
> >
> 
> Debugfs doesn't allow me to attach attributes to a particular device
> which is what I want here.

Yes it does, you just have to create the tree yourself.  Many subsystems
do this today just fine.

Please do not abuse sysfs for something that it is not designed for,
please use debugfs, that is EXACTLY what it is designed for.

thanks,

greg k-h

