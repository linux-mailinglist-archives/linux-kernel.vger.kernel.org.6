Return-Path: <linux-kernel+bounces-315345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F92296C177
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 16:57:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99743B28AC4
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 14:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE7851DC1B6;
	Wed,  4 Sep 2024 14:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HhM7w8pF"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC711DA608;
	Wed,  4 Sep 2024 14:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725461676; cv=none; b=Jgb0r6uRbL0gLrjPx6gcjje5608IaDx8slgRP673N4TcVCmLwAZIk36BeE1rnIhD3aivSwvaV5k/VqRKM6ylGOW7dZrGW0gepsPwSXC5hqhWkzEdUcnCtHyC7WnPUTUqXq7HyPHTKyqZHv6wLhOEeyU0VODH4LJS/UkYzAA5NLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725461676; c=relaxed/simple;
	bh=gScODNlhZlCpvbSMLGAqKd3woX3TK+hV8QrO1mnEaek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lhQ6/Xkf5Ov2/5TuB2EpFUiBt5UFNzXvDCoF3KUZH88UCzNZfp7FclnUAh/jNMCTEQPXyZ7Fax7UFHosSq92LBrPUY4HstkYivVPtlgJ1w99sno1Dow6CCnAKq82lsWZwQjRLiP/sVb3JLFC3FBbPA2S5MgOF9E1YJm1GmRMuus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HhM7w8pF; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725461674; x=1756997674;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gScODNlhZlCpvbSMLGAqKd3woX3TK+hV8QrO1mnEaek=;
  b=HhM7w8pFOmqRa0tHZHdFrCacc/2mW0/mdNq5FH/V2p/FNpQRvj7iW/20
   R19ezm1o1fweLolN0fCu8e3alKsCKvtQRsR7/gNKylCPejk3Q0hSqD5yg
   JJLUmUng5lTyL3ynPErwY6L1F8QKmOgCiihliCYtxV8dWS2fqBZ/+mAzk
   QnTtVp3BEc8FuyuRJu7tiEoYlZ0zreOxyxSRupblEUJx9xqMlLemXcBSe
   lAUEaghWYnMEUNt3+lX9S2Z+PxXJnkAr9KbI2ovcf2lQw00CLCZ1eXhPm
   9IQOad/lUfLWICW/KYLiT7i1XQdX+Oz4FkwvHIczn3AvoNlhqWK8fMWdQ
   Q==;
X-CSE-ConnectionGUID: F5poGVHbTsW3L6TG5mmuVg==
X-CSE-MsgGUID: Nz60CBNeT3K8k/On7NPPXg==
X-IronPort-AV: E=McAfee;i="6700,10204,11185"; a="34728443"
X-IronPort-AV: E=Sophos;i="6.10,202,1719903600"; 
   d="scan'208";a="34728443"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2024 07:54:33 -0700
X-CSE-ConnectionGUID: 5eekNsSJQU2avM4KnI150w==
X-CSE-MsgGUID: ujr9ZKurQTSX4qVvTL7Wcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,202,1719903600"; 
   d="scan'208";a="64962308"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmviesa006.fm.intel.com with SMTP; 04 Sep 2024 07:54:30 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 04 Sep 2024 17:54:29 +0300
Date: Wed, 4 Sep 2024 17:54:29 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: "Christian A. Ehrhardt" <lk@c--e.de>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	Anurag Bijea <icaliberdev@gmail.com>,
	Christian Heusel <christian@heusel.eu>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Jameson Thies <jthies@google.com>,
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Subject: Re: [PATCH v3] usb: typec: ucsi: Fix busy loop on ASUS VivoBooks
Message-ID: <Zth0pbxJnKYKn8u2@kuha.fi.intel.com>
References: <20240903181917.617400-1-lk@c--e.de>
 <ZthNkY4MEpUgw3We@kuha.fi.intel.com>
 <ZthnbdKig//kPKgF@cae.in-ulm.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZthnbdKig//kPKgF@cae.in-ulm.de>

On Wed, Sep 04, 2024 at 03:58:05PM +0200, Christian A. Ehrhardt wrote:
> 
> Hi Heikki,
> 
> On Wed, Sep 04, 2024 at 03:07:45PM +0300, Heikki Krogerus wrote:
> > On Tue, Sep 03, 2024 at 08:19:17PM +0200, Christian A. Ehrhardt wrote:
> > > If the busy indicator is set, all other fields in CCI should be
> > > clear according to the spec. However, some UCSI implementations do
> > > not follow this rule and report bogus data in CCI along with the
> > > busy indicator. Ignore the contents of CCI if the busy indicator is
> > > set.
> > > 
> > > If a command timeout is hit it is possible that the EVENT_PENDING
> > > bit is cleared while connector work is still scheduled which can
> > > cause the EVENT_PENDING bit to go out of sync with scheduled connector
> > > work. Check and set the EVENT_PENDING bit on entry to
> > > ucsi_handle_connector_change() to fix this.
> > > 
> > > Reported-by: Anurag Bijea <icaliberdev@gmail.com>
> > > Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219108
> > > Bisected-by: Christian Heusel <christian@heusel.eu>
> > > Tested-by: Anurag Bijea <icaliberdev@gmail.com>
> > > Fixes: de52aca4d9d5 ("usb: typec: ucsi: Never send a lone connector change ack")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Christian A. Ehrhardt <lk@c--e.de>
> > > ---
> > >  drivers/usb/typec/ucsi/ucsi.c | 8 ++++++++
> > >  1 file changed, 8 insertions(+)
> > > 
> > > diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
> > > index 4039851551c1..540cb1d2822c 100644
> > > --- a/drivers/usb/typec/ucsi/ucsi.c
> > > +++ b/drivers/usb/typec/ucsi/ucsi.c
> > > @@ -38,6 +38,10 @@
> > >  
> > >  void ucsi_notify_common(struct ucsi *ucsi, u32 cci)
> > >  {
> > > +	/* Ignore bogus data in CCI if busy indicator is set. */
> > > +	if (cci & UCSI_CCI_BUSY)
> > > +		return;
> > 
> > I started testing this and it looks like the commands never get
> > cancelled when the BUSY bit is set. I don't think this patch is the
> > problem, though. I think the BUSY handling broke earlier, probable in
> > 5e9c1662a89b ("usb: typec: ucsi: rework command execution functions").
> > 
> > I need to look at this a bit more carefully, but in the meantime, can
> > you try this:
> > 
> > 	if (cci & UCSI_CCI_BUSY) {
> > 		complete(&ucsi->complete);
> >		return;
> >         }
> 
> I really don't think this is the correct thing to do and it will
> likely make things worse.

That was the behaviour before all that command execution refactoring
this summer. I'm not saying that it's right, but that's how it was.

> A notification with the UCSI_CCI_BUSY bit does _not_ mean that
> the controller is busy doing other things and cannot complete the
> command.
> 
> Instead it is an indication that the controller _is_ working to
> complete our command but will take somewhat longer:
> 
> Citing:
> | Note: If a command takes longer than MIN_TIME_TO_RESPOND_WITH_BUSY ms
> |       for the PPM (excluding PPM to OPM communication latency) to complete,
> |       then the PPM shall respond to the command by setting the CCI Busy
> |       Indicator and notify the OPM.
> |       Subsequently, when the PPM actually completes the command, the
> |       PPM shall notify the OPM of the outcome of the command via an
> |       asynchronous notification associated with that command.
> 
> Unless I misunderstand what you are trying to do your change would
> cause us to needlessly abort/cancel every command that takes more than
> MIN_TIME_TO_RESPOND_WITH_BUSY to complete.
> 
> What am I missing?

The decision to Cancel was made to work around buggy EC firmwares that
reported BUSY, and then never completed the command. So without that
Cancel hack, the PPM was stuck on those systems.

I don't know what we should do about that hack. We probable could just
ignore those old systems, and then add quirks for them as needed. But
I also don't really like what you are proposing in this patch, that we
basically ignore the BUSY bit completely.

Right now I was hoping that we return the behaviour of the driver to
a point where everything worked as before, and after that start
improving the driver. That's why I was hoping to hear does the problem
that you are seeing go away with that approach.

With which command do you guys get the busy notification?

In any case, I don't think all those ucsi_*_common() functions give us
enough room to move here. I feel that the command execution needs to
be refactored somehow again.

thanks,

-- 
heikki

