Return-Path: <linux-kernel+bounces-411038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7872B9CF32C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 18:44:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC057B63A06
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 16:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 678EC1D79B7;
	Fri, 15 Nov 2024 16:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1+QRTKPw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C14ED1D47C7;
	Fri, 15 Nov 2024 16:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731689183; cv=none; b=E/yNdCGjLrvAlVJc2twJkCIdLfwtdRCxqlA/2cY2e6Dz2Wwy2VHUE5WHzlqWEYw+t6sRB6mQFX+Ajd9LbEKa+t6+I0hauWqpX0ngk4aEeUyXdGtAxEaBVUA0G+nWRWK9qWP5eDVAC3/zeuF0vEjGnHJvJEcokbNI1i315dc/CWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731689183; c=relaxed/simple;
	bh=BNhqGmZpGO18Kd9qsEPWforINqkenKitF4CgQOg2lxI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ARHggsGDgAOT72PHc5BCvh0/WQEoHtjB6CzuVVN3JGlk5y0ckHaR6oN/EQU9IO+YgFm3/pMhAjpjkE9G22uraxZmlwpF3zjKFeFOkSY4GCpkdJzuRsW+og48w4k9YivXRufc4lGij8QLCZOki0MU0x/1Iochv/lZkgHN4llARR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1+QRTKPw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2D15C4CECF;
	Fri, 15 Nov 2024 16:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731689183;
	bh=BNhqGmZpGO18Kd9qsEPWforINqkenKitF4CgQOg2lxI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=1+QRTKPwF59OSlWmutPUUMxLR3dn6KMf2xjO+Vr7EA6svw1+Rjw0kJHvbHdmlmX5A
	 CEeKQ5j10QBGboByplZX+7sISRSajE12hvs7OVOANGKoMbL5LbGTsCzT8mEf5bwR/v
	 0QUySnfmWNFFM8weHxtN7IBecUxTNJmo2RYSlaXo=
Date: Fri, 15 Nov 2024 17:46:00 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Doug Anderson <dianders@chromium.org>
Cc: linux-usb@vger.kernel.org, stern@rowland.harvard.edu,
	linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>,
	Herve Codina <herve.codina@bootlin.com>,
	Rob Herring <robh@kernel.org>,
	Grant Grundler <grundler@chromium.org>,
	Oliver Neukum <oneukum@suse.com>, Yajun Deng <yajun.deng@linux.dev>
Subject: Re: [PATCH v2 1/2] USB: make single lock for all usb dynamic id lists
Message-ID: <2024111554-elves-crumpled-0a24@gregkh>
References: <2024111322-kindly-finalist-d247@gregkh>
 <CAD=FV=XGBfkLQ2N3dr3smhMDb+ze-XpbHjd7EChAByGNwJOnOw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD=FV=XGBfkLQ2N3dr3smhMDb+ze-XpbHjd7EChAByGNwJOnOw@mail.gmail.com>

On Thu, Nov 14, 2024 at 02:37:10PM -0800, Doug Anderson wrote:
> Hi,
> 
> On Tue, Nov 12, 2024 at 10:49 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > There are a number of places where we accidentally pass in a constant
> > structure to later cast it off to a dynamic one, and then attempt to
> > grab a lock on it, which is not a good idea.  To help resolve this, move
> > the dynamic id lock out of the dynamic id structure for the driver and
> > into one single lock for all USB dynamic ids.  As this lock should never
> > have any real contention (it's only every accessed when a device is
> 
> nit: s/every/ever/
> 
> 
> > added or removed, which is always serialized) there should not be any
> > difference except for some memory savings.
> >
> > Note, this just converts the existing use of the dynamic id lock to the
> > new static lock, there is one place that is accessing the dynamic id
> > list without grabbing the lock, that will be fixed up in a follow-on
> > change.
> >
> > Cc: Johan Hovold <johan@kernel.org>
> > Cc: Herve Codina <herve.codina@bootlin.com>
> > Cc: Rob Herring <robh@kernel.org>
> > Cc: Alan Stern <stern@rowland.harvard.edu>
> > Cc: Grant Grundler <grundler@chromium.org>
> > Cc: Oliver Neukum <oneukum@suse.com>
> > Cc: Yajun Deng <yajun.deng@linux.dev>
> > Cc: Douglas Anderson <dianders@chromium.org>
> > Cc: linux-usb@vger.kernel.org
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> > v2: - change to a mutex
> >     - strip out of larger series
> >
> >  drivers/usb/common/common.c     |  3 +++
> >  drivers/usb/core/driver.c       | 15 +++++----------
> >  drivers/usb/serial/bus.c        |  4 +---
> >  drivers/usb/serial/usb-serial.c |  4 +---
> >  include/linux/usb.h             |  2 +-
> >  5 files changed, 11 insertions(+), 17 deletions(-)
> 
> I'm not familiar enough with the code to confirm with 100% certainty
> your assertions that there won't be any contention problems with this
> lock. However, your argument sounds reasonable to me and, since you
> are much more familiar with the subsystem, I'll believe you. :-)
> 
> I would have a slight concern that you are changing a "spin_lock" to a
> "mutex", which doesn't seem to be talked about in the patch
> description. This is likely to be fine given that all of the users are
> "spin_lock" and not "spin_lock_irq" or "spin_lock_irqsave", but it
> still makes me worried that there's some random bit of code somewhere
> that calls one of these functions while sleeping is disabled. I guess
> that's not likely.
> 
> In any case, this seems OK to me assuming it tests well.
> 
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> 

THanks for the reviews!

