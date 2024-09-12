Return-Path: <linux-kernel+bounces-326985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 82237976F7F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 19:26:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 828101C23B8E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 17:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06FDF1BF7E2;
	Thu, 12 Sep 2024 17:25:59 +0000 (UTC)
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 143B015098A
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 17:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=163.172.96.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726161958; cv=none; b=ZLgck+EbL1MCiakCT/82PGXP+oCS7HA2c5A7gWsPdhsAZLo9PmWmTb0SBu/G7JloH/dWwx7gq/1QllCI+VWbPy+mZcae59iMhC3rMswUPfS45qTw9to/Fmqa6Rk3m/yxDTrHURV2zZPH4EoIoweZ/yr0guri9n8/xgzfFD2xFQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726161958; c=relaxed/simple;
	bh=3ONgVfMJXgmy9PQHeYpfI25WqaLgBdHYvdWjmP5r+OI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IONlpAetFQenLwuk+i6M8eA7jwVvUBqucp+ANj0haxn1P3c5dlHVw1vm6AZWG8EM/0T2TEWpZER2aaTxHSczChDXtogn6TRKYSta2ZVQ8A3bHylO1SYql4/eCB5Z1fvlfwhXqssftrEAUchqZ8asz7d43KFODAV1mRCVBuU/d2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; arc=none smtp.client-ip=163.172.96.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Received: (from willy@localhost)
	by mail.home.local (8.17.1/8.17.1/Submit) id 48CHPM8G026358;
	Thu, 12 Sep 2024 19:25:22 +0200
Date: Thu, 12 Sep 2024 19:25:22 +0200
From: Willy Tarreau <w@1wt.eu>
To: nerdopolis <bluescreen_avenger@verizon.net>
Cc: linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg KH <gregkh@linuxfoundation.org>, john.ogness@linutronix.de,
        senozhatsky@chromium.org, tglx@linutronix.de, tony@atomide.com
Subject: Re: VT-less kernels, and /dev/console on x86
Message-ID: <ZuMkAiJz1YgdGpmJ@1wt.eu>
References: <2669238.7s5MMGUR32.ref@nerdopolis2>
 <1877609.QCnGb9OGeP@nerdopolis2>
 <Zs3YyYG0RwNcG2vL@1wt.eu>
 <4925457.GXAFRqVoOG@nerdopolis2>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4925457.GXAFRqVoOG@nerdopolis2>

On Thu, Sep 12, 2024 at 12:48:01PM -0400, nerdopolis wrote:
> > > I still kind of lean to CONFIG_NULL_TTY_CONSOLE, that way if enabled, and in
> > > theory, only distributions that had CONFIG_VT_CONSOLE turned on would turn on
> > > this option. That could allow /dev/console will still work the same way for
> > > user space logging, while disabling vgacon and fbcon.
> > > 
> > > And it could still be overridden by console=ttyS0, which I think is needed
> > > anyway if you have CONFIG_VT_CONSOLE enabled
> > 
> > That sounds safer. And even then, I still don't understand why the application
> > logging to /dev/console needs to block on it instead of just dropping whatever
> > doesn't fit there since that's the primary intent of an optional logging
> > console, i.e. emit events but without preventing regular operations. Maybe
> > *this* is the thing that would require a setting: wait or drop.
> > 
> Sorry about the late reply, the application that is logging and dropping is
> kind of unintentional I think. From how I understand it, systemd wants to
> verify that /dev/console is actually /dev/console, so it calls isatty() on it.

OK.

> isatty() in turn calls the TCGETS ioctl on /dev/console, which when the console
> device is actually /dev/ttyS0, and /dev/ttyS0 is unplugged, it the ioctl fails,
> and isatty() returns false, and systemd assumes that it is not a serial device,
> and in turn it doesn't log because of that.

I'm no tty expert at all, but on this machine I'm having this:

  # dmesg|grep console
  [    0.000000] Kernel command line: boot_image=l0 console=ttyS0,115200 root=/dev/mmcblk0p2 rw rootwait
  [    1.638242] printk: console [ttyS0] disabled
  [    2.848759] printk: console [ttyS0] enabled
  [   12.950334] systemd[1]: Starting Set the console keyboard layout...

  # cat /proc/consoles 
  ttyS0                -W- (EC p a)    4:64

  # strace -e trace=ioctl stty -a < /dev/console 
  ioctl(0, TCGETS, {B115200 opost -isig -icanon -echo ...}) = 0
  ioctl(1, TIOCGWINSZ, {ws_row=30, ws_col=152, ws_xpixel=1534, ws_ypixel=604}) = 0
  ioctl(0, TIOCGWINSZ, {ws_row=24, ws_col=80, ws_xpixel=0, ws_ypixel=0}) = 0
  speed 115200 baud; rows 24; columns 80; line = 0;
  intr = ^C; quit = ^\; erase = ^?; kill = ^U; eof = ^D; eol = <undef>; eol2 = <undef>; swtch = <undef>; start = ^Q; stop = ^S; susp = ^Z; rprnt = ^R;
  werase = ^W; lnext = ^V; discard = ^O; min = 1; time = 0;
  -parenb -parodd -cmspar cs8 hupcl -cstopb cread clocal -crtscts
  -ignbrk -brkint -ignpar -parmrk -inpck -istrip -inlcr -igncr -icrnl -ixon -ixoff -iuclc -ixany -imaxbel iutf8
  opost -olcuc -ocrnl onlcr -onocr -onlret -ofill -ofdel nl0 cr0 tab0 bs0 vt0 ff0
  -isig -icanon -iexten -echo -echoe -echok -echonl -noflsh -xcase -tostop -echoprt -echoctl -echoke -flusho -extproc
  +++ exited with 0 +++

So TCGETS succeeded above, and the console is unplugged. Even if I enable
HW flow control (crtscts) the result is the same BTW (I preferred to check).
Same if I enable carrier detection (-clocal).

So I'm unsure what would cause TCGETS to fail in your case.

Willy

