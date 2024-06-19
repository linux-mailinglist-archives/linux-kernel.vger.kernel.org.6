Return-Path: <linux-kernel+bounces-220887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0CDC90E89D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 12:48:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C29851C22004
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 10:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93DC712FF63;
	Wed, 19 Jun 2024 10:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nhh1LUrl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7BBC3398B
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 10:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718794087; cv=none; b=GHC1y+AnG2Elpx4yaccq7j8s9tc0hYVsixTr32kQnJa3N5K39LC9RW81YbDJy+7Aj3fuVClmY8/nZGXOJ+GffGj71wHhYQoLcXHe0Aid1IG/MFOc35Vecxq9Xk/oa/VDyZuo9Sh32kbpEhu0MjO6/V716GRGvsObnpayFE1PhRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718794087; c=relaxed/simple;
	bh=mCxiKmF5FtxEh3AMxcTpMqIkx0eNtMcqVNEWz/TCWJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pf1JQZ7Bo0UpYm9vx6fujvGGA1CRtqmKPjVuWVngBjaFQtogs4HIvuobK5+6VQ6YIJhTNjlJHUrG+DkqGNV4QcMk1uQzLMYCvShA8nUWXYlmK6PCdzlLzGX3zCUUggqYkA1rBeJ5DiqdVmEQGHJ1kTFUoAjG3ORxz4fziOpHxc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nhh1LUrl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1490C32786;
	Wed, 19 Jun 2024 10:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718794087;
	bh=mCxiKmF5FtxEh3AMxcTpMqIkx0eNtMcqVNEWz/TCWJA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nhh1LUrl0dJ0HBwYjWY+FLm+Xid2gbA4GdO531RQdSobw1UQSht0KbYOZMsU3JIE7
	 nItjRK14Q63aaoJc+d6v0CZASa0WRDj1f6vJB7SJBaLOo5TTodbKNmgtVdi8hnqPp7
	 jbK/FTjS0/Zno2yBvSC9RcE7fwfuAgqVjBjTSokY=
Date: Wed, 19 Jun 2024 12:48:04 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Khasnis Soumya <soumya.khasnis@sony.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, rafael@kernel.org,
	linux-kernel@vger.kernel.org, festevam@denx.de, lee@kernel.org,
	benjamin.bara@skidata.com, dmitry.osipenko@collabora.com,
	ldmldm05@gmail.com, srinavasa.nagaraju@sony.com,
	Madhusudan.Bobbili@sony.com, shingo.takeuchi@sony.com,
	keita.aihara@sony.com, masaya.takahashi@sony.com
Subject: Re: [PATCH v5] driver core: Add timeout for device shutdown
Message-ID: <2024061955-zigzagged-uncoiled-da96@gregkh>
References: <20240613083226.GA8191@sony.com>
 <2024061326-moonlit-protozoan-61f8@gregkh>
 <ecf55d97-363d-4731-bcfa-81cb4e58f2c7@linaro.org>
 <20240619100000.GA10362@sony.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240619100000.GA10362@sony.com>

On Wed, Jun 19, 2024 at 10:00:00AM +0000, Khasnis Soumya wrote:
> On Thu, Jun 13, 2024 at 01:51:57PM +0200, Daniel Lezcano wrote:
> > On 13/06/2024 10:43, Greg KH wrote:
> > > On Thu, Jun 13, 2024 at 08:32:26AM +0000, Soumya Khasnis wrote:
> > >> The device shutdown callbacks invoked during shutdown/reboot
> > >> are prone to errors depending on the device state or mishandling
> > >> by one or more driver. In order to prevent a device hang in such
> > >> scenarios, we bail out after a timeout while dumping a meaningful
> > >> call trace of the shutdown callback to kernel logs, which blocks
> > >> the shutdown or reboot process.
> > > 
> > > Again, this is not a "device shutdown" timeout, it is a "the whole
> > > system has not shutdown this fast" timeout.
> > > 
> > > And in looking at my system, it doesn't shutdown in 10 seconds as it is
> > > madly flushing a ton of stuff out to the disks, and they are slow
> > > beasts.  So your 10 second default would cause me data loss on my
> > > workstation, not good!
> > 
> > Thanks for pointing this out. It is exactly what I was worried about ...
> Thank you for comments Daniel and Greg, let me explain.
> 
> Typically reboot/shutdown sequence involves following steps in User land before kernel restart/shutdown sequence is entered.
> 
> 1.	Terminate all services (except shutdown critical tasks)
> 2.	Sync File systems
> 3.	Unmount File systems
> 4.	Trigger kernel reboot(LINUX_REBOOT_CMD_RESTART/LINUX_REBOOT_CMD_POWER_OFF) system call
> 
> A userspace watchdog can be setup for above as exists on Android system.
> This needs large timeout value because it involves syncing data to disks.  

True.

> Below is the kernel restart sequence after control moves to kernel in step 4).
> The issue we intend to address here is that the device driver shutdown callbacks may hang
> due to unresponsive device or a broken driver.
> 
> |-kernel_restart()
>               |- kernel_restart_prepare()
>                      |- device_shutdown() // Iterates over the device hierarchy and invokes the shutdown callbacks (class/bus/driver->shutdown)
>               |- syscore_shutdown()
>               |- machine_restart()
> 
> I still believe a 10 sec timeout as default is reasonable for the device_shutdown().
> Not all drivers necessarily implement a shutdown callback and the timeout can be configured for large systems as needed.

No, you can not break existing systems with this, sorry.

Just enable the watchdog before you do step 4 and then if reboot doesn't
happen in time, the watchdog will reboot the kernel for you.

Also, again, fix your broken drivers to not do this please.  You
obviously have experience with this already, what's preventing that from
being fixed on your end?  Same goes for an "unresponsive device", that
too can be fixed in your broken driver, and some might argue, needs to
be fixed no matter what.

Don't paper over broken out-of-tree kernel code with stuff like this,
fix it please.

thanks,

greg k-h

