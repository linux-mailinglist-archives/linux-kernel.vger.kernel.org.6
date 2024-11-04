Return-Path: <linux-kernel+bounces-395045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6AA99BB7B9
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 15:27:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85F07281F58
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 14:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AD051B0F2D;
	Mon,  4 Nov 2024 14:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Gpf0Qcm9"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CADA68BEE;
	Mon,  4 Nov 2024 14:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730730450; cv=none; b=jC7fCmwfk+rBMfakqrZjHny4giLTTSfbkw2Auiw5UBPwuvazO7iiAXA+4lFDena/bN+K7bCuGaYtRKHp+oWpg7tx0Ii8BnMB8ybMHdJd/erKOYnS9zYylJ4Gs1q+jJHOkBP8e96F7mxvoy0posh4GYmslEU5cqneIrXJw/UKNCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730730450; c=relaxed/simple;
	bh=mAacIEPRCIZdP88OUMaz6TpMwLO0OSldJPKYresI8kE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ec0UYBlMcbtHmyRL8ZSfTZNLOkagsZMKs+GRxNFxD8GeWeFb3WqzipSmnlOLV07zIK5k6yzJNf3qYr0NExuJnsZJz++r/ZhD/DrW+t6ZLqRNCI8i0pjRrRUHuCu26KwR+EuS6gWKJyrIgnFfGbLfflrSyKx8EsqNo4bXmtSU2VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Gpf0Qcm9; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730730449; x=1762266449;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=mAacIEPRCIZdP88OUMaz6TpMwLO0OSldJPKYresI8kE=;
  b=Gpf0Qcm9gQp0ECJc5Q+VsbUmoDliFKNQGWd7y/os7e8KSwHMTqmHB0TD
   o94NYAQaNZfHlKuZ8V97eP8CwckTX0ezzxNnlczE3P5v4VrqE/CkVio2e
   DcvcoFsv5qhLwGzrcTGSzWnFfSEhqNH4vWgVgRADiERfowJqBc/Wsxh6q
   XjNhs7sPlRobUwo6s6cJdmYpB+R9wZ+ji91YkFFIShI2awe+s4VSAHp0E
   Jt7rQ/1PDZlA70xXCdX7bBBjn59F+I/E5dkTZm3uxJd7GpvHAAJE4jbqH
   75WXJMF0pOtW+UpauHoi+tv10cPk5ly08PV+I/DOU1Pbequ+95m3UrgvD
   Q==;
X-CSE-ConnectionGUID: huMsl/EFQearlXQVicIS7Q==
X-CSE-MsgGUID: X5STIALZRyO6HGBpG1GCVg==
X-IronPort-AV: E=McAfee;i="6700,10204,11246"; a="29851215"
X-IronPort-AV: E=Sophos;i="6.11,257,1725346800"; 
   d="scan'208";a="29851215"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2024 06:14:45 -0800
X-CSE-ConnectionGUID: a0sBERauQP+/Cc23e6O4DA==
X-CSE-MsgGUID: 466nElIvTsGCmVPB2Hxwfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,257,1725346800"; 
   d="scan'208";a="88235457"
Received: from kuha.fi.intel.com ([10.237.72.152])
  by fmviesa004.fm.intel.com with SMTP; 04 Nov 2024 06:14:41 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 04 Nov 2024 16:14:40 +0200
Date: Mon, 4 Nov 2024 16:14:40 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Cc: tzungbi@kernel.org, linux-usb@vger.kernel.org,
	chrome-platform@lists.linux.dev, dmitry.baryshkov@linaro.org,
	jthies@google.com, akuchynski@google.com, pmalani@chromium.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/7] usb: typec: Auto enter control for alternate modes
Message-ID: <ZyjW0CMXgGIt-usC@kuha.fi.intel.com>
References: <20241030212854.998318-1-abhishekpandit@chromium.org>
 <20241030142833.v2.3.I439cffc7bf76d94f5850eb85980f1197c4f9154c@changeid>
 <ZyOVIKGlrlj7kc9-@kuha.fi.intel.com>
 <CANFp7mX-DkyFqwoaq_4V1XEDBqK7bj6-nz2aJi7idM=Q2TT49w@mail.gmail.com>
 <ZyTesZ3gCmYDmrA6@kuha.fi.intel.com>
 <CANFp7mWim9VH+KLH3A+RJ5YFuvrVwDUgU2q8_qvDM3=jzYd6xg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANFp7mWim9VH+KLH3A+RJ5YFuvrVwDUgU2q8_qvDM3=jzYd6xg@mail.gmail.com>

On Fri, Nov 01, 2024 at 09:53:14AM -0700, Abhishek Pandit-Subedi wrote:
> On Fri, Nov 1, 2024 at 6:59 AM Heikki Krogerus
> <heikki.krogerus@linux.intel.com> wrote:
> >
> > On Thu, Oct 31, 2024 at 03:48:45PM -0700, Abhishek Pandit-Subedi wrote:
> > > On Thu, Oct 31, 2024 at 7:33 AM Heikki Krogerus
> > > <heikki.krogerus@linux.intel.com> wrote:
> > > >
> > > > On Wed, Oct 30, 2024 at 02:28:34PM -0700, Abhishek Pandit-Subedi wrote:
> > > > > Add controls for whether an alternate mode is automatically entered when
> > > > > a partner connects. The auto_enter control is only available on ports
> > > > > and applies immediately after a partner connects. The default behavior
> > > > > is to enable auto enter and drivers must explicitly disable it.
> > > > >
> > > > > Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> > > > > ---
> > > > >
> > > > > (no changes since v1)
> > > > >
> > > > >  Documentation/ABI/testing/sysfs-bus-typec |  9 +++++++
> > > > >  drivers/usb/typec/altmodes/displayport.c  |  6 +++--
> > > > >  drivers/usb/typec/altmodes/thunderbolt.c  |  3 ++-
> > > > >  drivers/usb/typec/class.c                 | 31 +++++++++++++++++++++++
> > > > >  include/linux/usb/typec.h                 |  2 ++
> > > > >  include/linux/usb/typec_altmode.h         |  2 ++
> > > > >  6 files changed, 50 insertions(+), 3 deletions(-)
> > > > >
> > > > > diff --git a/Documentation/ABI/testing/sysfs-bus-typec b/Documentation/ABI/testing/sysfs-bus-typec
> > > > > index 205d9c91e2e1..f09d05727b82 100644
> > > > > --- a/Documentation/ABI/testing/sysfs-bus-typec
> > > > > +++ b/Documentation/ABI/testing/sysfs-bus-typec
> > > > > @@ -12,6 +12,15 @@ Description:
> > > > >
> > > > >               Valid values are boolean.
> > > > >
> > > > > +What:                /sys/bus/typec/devices/.../auto_enter
> > > > > +Date:                September 2024
> > > > > +Contact:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > > > > +Description:
> > > > > +             Controls whether a mode will be automatically entered when a partner is
> > > > > +             connected.
> > > > > +
> > > > > +             This field is only valid and displayed on a port. Valid values are boolean.
> > > >
> > > > So, why can't this be controlled with the "active" property of the
> > > > port altmode instead? That's why it's there.
> > > >
> > > > Sorry if I missed something in v1 related to this question.
> > >
> > > There was a bit of discussion around this in another patch in v1:
> > > https://patchwork.kernel.org/project/chrome-platform/patch/20240925092505.8.Ic14738918e3d026fa2d85e95fb68f8e07a0828d0@changeid/
> > > And this patch is probably a good place to continue that discussion.
> > >
> > > With the way altmodes drivers currently work, they will auto-enter
> > > when probed. So if you have a partner that supports both displayport
> > > and thunderbolt, they will both attempt to auto-enter on probe. I
> > > think I could use the `active` field instead so that the port altmode
> > > blocks entry until userspace enables it -- this would avoid the need
> > > to add one more sysfs ABI. I'll actually go ahead and do this for the
> > > next patch series I send up.
> > >
> > > However, the underlying problem I'm trying to solve still exists: how
> > > do you choose a specific altmode to enter if there are multiple to
> > > choose from? I tried to implement a method that first tries USB4 and
> > > then Thunderbolt and then DP but I realized that the altmode drivers
> > > don't necessarily bind immediately after a partner altmode is
> > > registered so I can't just call `activate` (since no ops are attached
> > > to the partner altmode yet). Do you have any thoughts about how to
> > > handle multiple modes as well as how to handle fallback mode entry
> > > (i.e. thunderbolt fails so you try DPAM next)?
> >
> > If the user space needs to take over control of the entry order, then
> > can't it just de-activate all port alt modes by default, and then
> > activate the one that needs to enter? The port driver probable needs
> > to implent the "activate" callback for this.
> >
> > The user space can see when the driver is bound to a device by
> > monitoring the uevents, no?
> 
> This requires userspace intervention to do the correct thing. Let's
> take a real world example:
> 
> I have a TBT4 dock that supports DPAM (svid 0xff01), TBT (svid 0x8087)
> and also USB4.
> 
> * When I plug in the dock, it enumerates and registers the partner
> altmodes. The altmode bus matches typec_displayport and
> typec_thunderbolt and loads the drivers for them. By default, both
> drivers will try to activate their altmode on probe(). Having a
> userspace daemon disable the altmode on the ports and enable them on
> connection will probably work here.
> * If I boot with the dock connected, the same thing happens but my
> userspace daemon may not be running yet. What should the default
> kernel behavior be to enter alt-modes then? When you throw USB4 into
> the mix, this becomes another can of worms since you probably don't
> want to downgrade from USB4 to DPAM.

If you have already entered USB4, then all alt modes need fail to
enter with -EBUSY, just like when another alt mode was already
entered successfully. Right now the port driver is responsible of
checking USB4 status, but we can easily add a check for the usb_mode
of the partner to the typec_altmode_enter().

The default entry order will in practice be the order in which the
modes are discovered (so USB4 will always be first), but the port
drivers can of course influence this by registering the modes in a
specific order - first-come, first-served. But that is only useful if
the port driver knows the priorities of the modes.

You can leave the decision to the user space for example by adding
that "no_auto_enter", that's not a problem, but it still does not
require a new sysfs attribute file. You just use that flag to set the
default value for the "active" attribute.

> On ChromeOS, prior to this patch series, our userspace daemon (typecd)
> could handle all of this in userspace since it could just wait for
> `num_alt_modes` to be filled on partner-attach before trying to enter
> the right mode (via a side-band channel to the EC). After this change,
> typecd will be in a similar bind -- it will have to wait until all
> attached partner SVIDs have drivers attached (if available).
> 
> Underlying all this, I guess the real need here is for some sort of
> signal that says: All partner modes are registered, any necessary
> drivers for these modes are bound and you are ready to make a decision
> on which mode to enter. Then, we could iteratively try to enter the
> best mode (USB4 > TBT > DP) and report failure conditions on why it
> couldn't be entered (i.e. Cable speed, partner problem / link
> training, etc). This could be done in kernel or userspace depending on
> the system.

In user space you use the "num_alt_modes" to see how many alt modes
there are, and then simply wait for all of them (or just the ones that
you are interested in) get registered and bind to a driver. After that
you can enter which ever you want. I don't think you need anything
else there.

If you still need some way to tell the port drivers how to prioritise
the modes without user space, then I think you need some way for the
firmware to be able to deliver that information to the driver.

thanks,

-- 
heikki

