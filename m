Return-Path: <linux-kernel+bounces-316847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B15A96D616
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 12:30:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F1631C255DC
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 10:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08356198E9B;
	Thu,  5 Sep 2024 10:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XZMuz79D"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D2F198845;
	Thu,  5 Sep 2024 10:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725532231; cv=none; b=dqHOI049jJ26HW14KcozsEtHAfCORDM9lfiqpcxGPn2V2rt4lFTwI8D1sXzJz5k/CSgXquwa9w7K6woqMNZIZKQgDKprCYwqIU74TomgyNBGdYboVDrUtW3FvbQ2nqgRYtcQNsecR/JibOxLW2k0b4rLCsoa52xiusW1a74mefE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725532231; c=relaxed/simple;
	bh=GM6trB8qqYdQ/Ed3/cfE8iPX9QWQHUFk57sGbyXrPPg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X8fcApoZ7yx2+KwobfwtGoeueIUTgLFuj2PxkB2Wc3ckxp6hc3P+uxSacCtdNedWSNbRkWdQV7QEJAxxnGzCIFLKVBxXg984iWqShj8efLqE7scdV00WmkDrMI/5R5usPG4DEofSun7lrOGiSJCjgoNl5GLNHxKiuEHL0HRaZLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XZMuz79D; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725532229; x=1757068229;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GM6trB8qqYdQ/Ed3/cfE8iPX9QWQHUFk57sGbyXrPPg=;
  b=XZMuz79Dr/BKnWn5JVAHv/LDnqjbhNzwx4Nf4e7uiv3rNprbuftiXcFP
   MXSoXPIR0ugXwPf6Ls61VBqRa4UL4TqtzfanH8LHdPxOyIsTJ+nHHRJ7b
   S+PL6/v6ZWyTyK7Ld3z2pqAY2Y1780UsxPU9oijcqHO2wyXOiVKCcdmGd
   kTp2Mh9T1aKfIaOTOtArGxIWNr73Gq6yFXCtFEug4ifM5vKZLQx/YNRsQ
   a8payl27eVFfjEnIzb6ncksnuVHGZNtrCGZ+uQwUJ3IXcH/7YrmzSS/q2
   sANA9yY26pHgzag55BTRbLzmVbn4jcCXBN6HQECbJ4RQvB6xZt5bAv51r
   g==;
X-CSE-ConnectionGUID: P/wmimskRF6eHIkpL0DIqg==
X-CSE-MsgGUID: fPP3r8E5QDe6O/NXVHxkhA==
X-IronPort-AV: E=McAfee;i="6700,10204,11185"; a="28128280"
X-IronPort-AV: E=Sophos;i="6.10,204,1719903600"; 
   d="scan'208";a="28128280"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2024 03:30:28 -0700
X-CSE-ConnectionGUID: 73TzvbwMTiWyYJScluHwVg==
X-CSE-MsgGUID: 5S3Ka0+CS0aqsY2DBbGsLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,204,1719903600"; 
   d="scan'208";a="96323927"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by orviesa002.jf.intel.com with SMTP; 05 Sep 2024 03:30:25 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 05 Sep 2024 13:30:23 +0300
Date: Thu, 5 Sep 2024 13:30:23 +0300
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
Message-ID: <ZtmIP1iTz+XnUD4o@kuha.fi.intel.com>
References: <20240903181917.617400-1-lk@c--e.de>
 <ZthNkY4MEpUgw3We@kuha.fi.intel.com>
 <ZthnbdKig//kPKgF@cae.in-ulm.de>
 <Zth0pbxJnKYKn8u2@kuha.fi.intel.com>
 <ZtixzrzsA9bluuL7@cae.in-ulm.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZtixzrzsA9bluuL7@cae.in-ulm.de>

Hi,

On Wed, Sep 04, 2024 at 09:15:26PM +0200, Christian A. Ehrhardt wrote:
> 
> Hi Heikki,
> 
> On Wed, Sep 04, 2024 at 05:54:29PM +0300, Heikki Krogerus wrote:
> > On Wed, Sep 04, 2024 at 03:58:05PM +0200, Christian A. Ehrhardt wrote:
> > > 
> > > Hi Heikki,
> > > 
> > > On Wed, Sep 04, 2024 at 03:07:45PM +0300, Heikki Krogerus wrote:
> > > > On Tue, Sep 03, 2024 at 08:19:17PM +0200, Christian A. Ehrhardt wrote:
> > > > > If the busy indicator is set, all other fields in CCI should be
> > > > > clear according to the spec. However, some UCSI implementations do
> > > > > not follow this rule and report bogus data in CCI along with the
> > > > > busy indicator. Ignore the contents of CCI if the busy indicator is
> > > > > set.
> > > > > 
> > > > > If a command timeout is hit it is possible that the EVENT_PENDING
> > > > > bit is cleared while connector work is still scheduled which can
> > > > > cause the EVENT_PENDING bit to go out of sync with scheduled connector
> > > > > work. Check and set the EVENT_PENDING bit on entry to
> > > > > ucsi_handle_connector_change() to fix this.
> > > > > 
> > > > > Reported-by: Anurag Bijea <icaliberdev@gmail.com>
> > > > > Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219108
> > > > > Bisected-by: Christian Heusel <christian@heusel.eu>
> > > > > Tested-by: Anurag Bijea <icaliberdev@gmail.com>
> > > > > Fixes: de52aca4d9d5 ("usb: typec: ucsi: Never send a lone connector change ack")
> > > > > Cc: stable@vger.kernel.org
> > > > > Signed-off-by: Christian A. Ehrhardt <lk@c--e.de>
> > > > > ---
> > > > >  drivers/usb/typec/ucsi/ucsi.c | 8 ++++++++
> > > > >  1 file changed, 8 insertions(+)
> > > > > 
> > > > > diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
> > > > > index 4039851551c1..540cb1d2822c 100644
> > > > > --- a/drivers/usb/typec/ucsi/ucsi.c
> > > > > +++ b/drivers/usb/typec/ucsi/ucsi.c
> > > > > @@ -38,6 +38,10 @@
> > > > >  
> > > > >  void ucsi_notify_common(struct ucsi *ucsi, u32 cci)
> > > > >  {
> > > > > +	/* Ignore bogus data in CCI if busy indicator is set. */
> > > > > +	if (cci & UCSI_CCI_BUSY)
> > > > > +		return;
> > > > 
> > > > I started testing this and it looks like the commands never get
> > > > cancelled when the BUSY bit is set. I don't think this patch is the
> > > > problem, though. I think the BUSY handling broke earlier, probable in
> > > > 5e9c1662a89b ("usb: typec: ucsi: rework command execution functions").
> > > > 
> > > > I need to look at this a bit more carefully, but in the meantime, can
> > > > you try this:
> > > > 
> > > > 	if (cci & UCSI_CCI_BUSY) {
> > > > 		complete(&ucsi->complete);
> > > >		return;
> > > >         }
> > > 
> > > I really don't think this is the correct thing to do and it will
> > > likely make things worse.
> > 
> > That was the behaviour before all that command execution refactoring
> > this summer. I'm not saying that it's right, but that's how it was.
> 
> The code to do that is still there but does not get called because
> the ETIMEDOUT error is checked for CCI in ucsi_run_command.
> I guess something like this (only compile tested) would fix it:
> 
> diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
> index 540cb1d2822c..d6d61606bbcf 100644
> --- a/drivers/usb/typec/ucsi/ucsi.c
> +++ b/drivers/usb/typec/ucsi/ucsi.c
> @@ -111,15 +111,13 @@ static int ucsi_run_command(struct ucsi *ucsi, u64 command, u32 *cci,
>  		size = clamp(size, 0, 16);
>  
>  	ret = ucsi->ops->sync_control(ucsi, command);
> -	if (ret)
> -		return ret;
> -
> -	ret = ucsi->ops->read_cci(ucsi, cci);
> -	if (ret)
> -		return ret;
> +	if (ucsi->ops->read_cci(ucsi, cci))
> +		return -EIO;
>  
>  	if (*cci & UCSI_CCI_BUSY)
>  		return -EBUSY;
> +	if (ret)
> +		return ret;
>  
>  	if (!(*cci & UCSI_CCI_COMMAND_COMPLETE))
>  		return -EIO;
> 

Yes, that looks good.

> > > A notification with the UCSI_CCI_BUSY bit does _not_ mean that
> > > the controller is busy doing other things and cannot complete the
> > > command.
> > > 
> > > Instead it is an indication that the controller _is_ working to
> > > complete our command but will take somewhat longer:
> > > 
> > > Citing:
> > > | Note: If a command takes longer than MIN_TIME_TO_RESPOND_WITH_BUSY ms
> > > |       for the PPM (excluding PPM to OPM communication latency) to complete,
> > > |       then the PPM shall respond to the command by setting the CCI Busy
> > > |       Indicator and notify the OPM.
> > > |       Subsequently, when the PPM actually completes the command, the
> > > |       PPM shall notify the OPM of the outcome of the command via an
> > > |       asynchronous notification associated with that command.
> > > 
> > > Unless I misunderstand what you are trying to do your change would
> > > cause us to needlessly abort/cancel every command that takes more than
> > > MIN_TIME_TO_RESPOND_WITH_BUSY to complete.
> > > 
> > > What am I missing?
> > 
> > The decision to Cancel was made to work around buggy EC firmwares that
> > reported BUSY, and then never completed the command. So without that
> > Cancel hack, the PPM was stuck on those systems.
> 
> Yes fine. But the cancel should be done _after_ the command times
> out normally, I guess. Otherwise conforming systems will get there
> commands terminated/aborted for no good reason. And this is what
> the current code tries to do.
> 
> > I don't know what we should do about that hack. We probable could just
> > ignore those old systems, and then add quirks for them as needed. But
> > I also don't really like what you are proposing in this patch, that we
> > basically ignore the BUSY bit completely.
> 
> See above. I think that solves both cases nicely.

Agreed. Can you incorporate that into this patch?

> > Right now I was hoping that we return the behaviour of the driver to
> > a point where everything worked as before, and after that start
> > improving the driver. That's why I was hoping to hear does the problem
> > that you are seeing go away with that approach.
> > 
> > With which command do you guys get the busy notification?
> 
> It happens for all types of commands. I will append debug output where
> all commands sent and all CCI values read are printed.
> 
> Unfortunately, I don't have direct access to the affected hardware.
> I'm just looking into this because one of my changes from earlier
> this year caused a regression on that machine. Is this sufficient to
> show what's going on?

Yes it's fine. I was mostly interested.

> > In any case, I don't think all those ucsi_*_common() functions give us
> > enough room to move here. I feel that the command execution needs to
> > be refactored somehow again.
> 
> That's your call to make but personally, I like the recent changes
> to the interface between ucsi.c and the backend drivers.

Just to clarify here, I did no have anything that drastic in mind.

Thanks Christian,

-- 
heikki

