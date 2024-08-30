Return-Path: <linux-kernel+bounces-309497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A538966B5F
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 23:40:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40A95284BBA
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 21:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE7821BC9E1;
	Fri, 30 Aug 2024 21:40:20 +0000 (UTC)
Received: from cae.in-ulm.de (cae.in-ulm.de [217.10.14.231])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F0ED1474C3;
	Fri, 30 Aug 2024 21:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.14.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725054020; cv=none; b=jKdZ2eQaxSCvbLzqQepLC55xetSXN7XeOt+DT6MZ6PRRZ5PnDqkBB2UmNw3Iu321L4760WuYWv2jBHjDKgfYV8c+n7o5E6VSTgZG30db8d1m8irOUO9i1S73GDGzt3G6hr/7yNu3l1Rq4UJY5khLl8h/oojucC9J65AfSfU8fxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725054020; c=relaxed/simple;
	bh=cf1n5NssZY1yUpvsrgf2wNTfJcUlZ0bn4pDunKzmJd8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gh8x7a6bN+xz/y1heersy45VtROomqabQpgVDmNnzxsGfsT0EzISKgY8wIYE+Of+Pn9Uw9IdfWKPvH4uHsSu2Qmck2YsnMB+c8/BTB/t96CACddtV6LwFqgbdOjgNDVeup2T5oqs8tROzzvbgHu3mjulnVqkkUtGuKxpTcXjijo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c--e.de; spf=pass smtp.mailfrom=c--e.de; arc=none smtp.client-ip=217.10.14.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c--e.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=c--e.de
Received: by cae.in-ulm.de (Postfix, from userid 1000)
	id 0A5C014056A; Fri, 30 Aug 2024 23:40:07 +0200 (CEST)
Date: Fri, 30 Aug 2024 23:40:07 +0200
From: "Christian A. Ehrhardt" <lk@c--e.de>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	Anurag Bijea <icaliberdev@gmail.com>,
	Christian Heusel <christian@heusel.eu>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Jameson Thies <jthies@google.com>,
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Subject: Re: [PATCH v2 1/2] usb: typec: ucsi: Enable ASUS zenbook quirk for
 VivoBooks
Message-ID: <ZtI8N5/SCt+dI/6z@cae.in-ulm.de>
References: <20240829100109.562429-1-lk@c--e.de>
 <ZtF/BJMls7kuD2dt@kuha.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZtF/BJMls7kuD2dt@kuha.fi.intel.com>


Hi Heikki,

On Fri, Aug 30, 2024 at 11:12:52AM +0300, Heikki Krogerus wrote:
> Hi, Christian,
> 
> Sorry, I did not look at this properly in v1.
> 
> On Thu, Aug 29, 2024 at 12:01:08PM +0200, Christian A. Ehrhardt wrote:
> > The quirk for some ASUS zenbook models is required for
> > ASUS VivoBooks. Apply the quirk to these as well.
> > 
> > This is part of the fix for the builtin keyboard on ASUS
> > VivoBooks.
> 
> I think that explanation goes to patch 2/2 and vise versa.

Obviously! Sorry about that.

> 
> > Reported-by: Anurag Bijea <icaliberdev@gmail.com>
> > Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219108
> > Bisected-by: Christian Heusel <christian@heusel.eu>
> > Fixes: de52aca4d9d5 ("usb: typec: ucsi: Never send a lone connector change ack")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Christian A. Ehrhardt <lk@c--e.de>
> > ---
> >  drivers/usb/typec/ucsi/ucsi.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> > 
> > diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
> > index 4039851551c1..540cb1d2822c 100644
> > --- a/drivers/usb/typec/ucsi/ucsi.c
> > +++ b/drivers/usb/typec/ucsi/ucsi.c
> > @@ -38,6 +38,10 @@
> >  
> >  void ucsi_notify_common(struct ucsi *ucsi, u32 cci)
> >  {
> > +	/* Ignore bogus data in CCI if busy indicator is set. */
> > +	if (cci & UCSI_CCI_BUSY)
> > +		return;
> 
> This does not look correct. Doesn't this mean you'll timeout always if
> BUSY is set?

This is only in the notify function that would do the wakeup on
command completion. The very point of this change is that we do no
wakeup if UCSI_CCI_BUSY is set along with other bogus bits.

The UCSI controller is supposed to send another notification without
the busy bit set once the command completes.

Note that the ASUS laptop actually sends notifications with the BUSY
bit set while processing a command. This is presumably to let us know
that the command is being processed but that it takes longer.

For example this is a possible sequence:
ucsi_sync_control_common: cmd=20012	# GET_CONNECT_STATUS
ucsi_notify_common: cci=0x10000002	# BUSY notification
ucsi_notify_common: cci=0x80000904	# Command completion

> Couldn't you just check the BUSY as the first action, and then clear
> the other bits in CCI if it is set, if that is the problem?

That would not make any difference. The value is only used in this function
for a few other checks that look at fields that are supposed to be zero.
Thus zeroing these fields would have the same effect.

I think you had the actual error handling in mind that happens _after_
the timeout hits. CCI is read again there and if it still reports BUSY
the command is canceled.

> Btw. Does 4f322657ade1 ("usb: typec: ucsi: Call CANCEL from single
> location") affect the situation in any way?

I would have to check with the reporter of the bug but I don't think
it makes a difference because this is the error recovery code that
runs after the timeout. I only touched the notification code that would
do the wakeup.

Best regards,
Christian


