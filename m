Return-Path: <linux-kernel+bounces-303471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E267F960C7F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 15:48:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FD80281641
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 13:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD30E1C2DD1;
	Tue, 27 Aug 2024 13:47:56 +0000 (UTC)
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F8D81BA295
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 13:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=163.172.96.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724766476; cv=none; b=K6doZO7cT56ID16LiFvbOJ1J6RTZPvPOAbPyK6ZDX2W6vuC9o9lQZM+NZtPDYi2XO9G5Y1Vofbd/+q71FFrAkNjeLuvgZKWBwgASE5DvtD4uMPjU4itUf1YLPm3xq9h6Z1zciyiv5opRzPooljmPe/fjzaeU5pmLRIsk7eGN79U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724766476; c=relaxed/simple;
	bh=lqsl/udGBWXTMHPt+kIbCdms5VE9PmHW93O1U3epsoE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aHKPKNi45n4K+7nUvSylNrhLXKIaNxAxQEYF5Ik/eO9csnV0SE5lrotzADQELelIFz7KTPdEEInVQUDcVBd2NjjA8t46tIh9kNtmcRjQRZ/6Bojrs3AdP0+fnxs7KTtLL2tRnG7WoHEZuucZ+9rCgIDHRfmWA9H+2jXVKOGmFfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; arc=none smtp.client-ip=163.172.96.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Received: (from willy@localhost)
	by mail.home.local (8.17.1/8.17.1/Submit) id 47RDknGK023500;
	Tue, 27 Aug 2024 15:46:49 +0200
Date: Tue, 27 Aug 2024 15:46:49 +0200
From: Willy Tarreau <w@1wt.eu>
To: nerdopolis <bluescreen_avenger@verizon.net>
Cc: Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>,
        Greg KH <gregkh@linuxfoundation.org>, john.ogness@linutronix.de,
        senozhatsky@chromium.org, tglx@linutronix.de, tony@atomide.com,
        linux-kernel@vger.kernel.org
Subject: Re: VT-less kernels, and /dev/console on x86
Message-ID: <Zs3YyYG0RwNcG2vL@1wt.eu>
Reply-To: linux-kernel@vger.kernel.org
References: <2669238.7s5MMGUR32.ref@nerdopolis2>
 <ZscNX79dnXUjeTc4@pathway.suse.cz>
 <3085227.687JKscXgg@nerdopolis2>
 <1877609.QCnGb9OGeP@nerdopolis2>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1877609.QCnGb9OGeP@nerdopolis2>

On Tue, Aug 27, 2024 at 08:53:49AM -0400, nerdopolis wrote:
> > > If I get it correctly, you suggest to do not register serial port
> > > when it is not physically connected. It makes some sense.
> > > 
> > Hmm, now that might work, and is a good idea...
> Although now that I think about it, could this cause unintended behavior on
> some hardware? Or folks that might plug in the serial cable after booting for
> whatever reason?

The *vast* majority of serial ports spend their time non-connected, and
are only used to connect to the equipment at runtime, to recover a lost
access, or to connect locally to it during operations. What is proposed
above scares me a little bit:
  - PC-like serial ports (DB-9) support hardware flow control using the
    RTS/CTS lines and are expected to be instantly usable when connecting
    something to them. The presence of a cable is detectable, though many
    will just have a local loop (CTS-RTS, DCD-DTR-DSR) and will in fact
    only detect that the connector is plugged in. Some don't even connect
    them, and turn off HW flow control.

  - many boards don't even have hardware flow control and only provide
    the usual 3-4 pins (GND, TX, RX and optional VCC). These ones will
    never be detected as "connected" and will be permanently broken.

> I still kind of lean to CONFIG_NULL_TTY_CONSOLE, that way if enabled, and in
> theory, only distributions that had CONFIG_VT_CONSOLE turned on would turn on
> this option. That could allow /dev/console will still work the same way for
> user space logging, while disabling vgacon and fbcon.
> 
> And it could still be overridden by console=ttyS0, which I think is needed
> anyway if you have CONFIG_VT_CONSOLE enabled

That sounds safer. And even then, I still don't understand why the application
logging to /dev/console needs to block on it instead of just dropping whatever
doesn't fit there since that's the primary intent of an optional logging
console, i.e. emit events but without preventing regular operations. Maybe
*this* is the thing that would require a setting: wait or drop.

Just my two cents,
Willy

