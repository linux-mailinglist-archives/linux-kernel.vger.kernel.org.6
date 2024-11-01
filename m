Return-Path: <linux-kernel+bounces-392332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15E2B9B92B7
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 14:59:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8576B1F237C3
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 13:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9945C1A2574;
	Fri,  1 Nov 2024 13:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="flxxEX1f"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA4C1A0B08;
	Fri,  1 Nov 2024 13:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730469562; cv=none; b=MA+iuH7npqXN07ykSXer6CmYuUIh/UAiFJgaH4umOMW3wm0Vx0VW6ECiiUuRC0RYFzUfNaMi4JuU2cxrcqKhxHXOMN5+qq3B8zXycM+moVE1CfKkqPYGPDnHj6ljkRHTONRzgfPiphwGfnZo4mIMiUEZ1CCpbDGsHVtpxsSEZEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730469562; c=relaxed/simple;
	bh=9u3rAh++RTJxOlt4gOXF3ETryUU4PzcwAPKxwur0mI8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m63ug8De7O5Pld0hbsKW61jc+0kemp1bZ4yWGLG9Tz6n2IhbgSqWekCgAxq6OR6uv6ZNLvwjAPlX34EruAhNKU/tNElSLiwqwhzxt+bB83XjseZNbApdEGDcIyjOrLKj12sc7dBdk/NYLIEOdcq19MGqJNfTXbLevExNIehnGf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=flxxEX1f; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730469559; x=1762005559;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=9u3rAh++RTJxOlt4gOXF3ETryUU4PzcwAPKxwur0mI8=;
  b=flxxEX1fp9vcCj+ejSHKcFUzia6KqvZ/619PH1e2s6Hr0XG6usbfS8jK
   xJpH6eHcnL8As227QlsOpF9uBpk3zBhMX+FKUKe5vFYq1Z4kZsXcbnV8C
   3DR5gXWyW/mpuUgjcA5N1AGTdiTv8FvDqzewM71Xdr+Q/ksQUsZ77bboz
   yyl1Yp8OrHQPishGReyTa+9yZScUk7TDwE4mupSPCB0Ljst4hmfRCzhGN
   5SoaDhCeKr28hShJ/uNVeGIAkLghKOYZB4pWBqH5A2fUKN3Hiv7mMqHnh
   7LBPh4INMEziBifHWs4MNakx0d+GSGbdSD2CmPeboWSkTGcYzT4i6Bb6/
   g==;
X-CSE-ConnectionGUID: FsW8kV1kSvuTe+DSp6+uAA==
X-CSE-MsgGUID: OK73Sc6kSsuhV7RL8I/XMw==
X-IronPort-AV: E=McAfee;i="6700,10204,11243"; a="33074765"
X-IronPort-AV: E=Sophos;i="6.11,249,1725346800"; 
   d="scan'208";a="33074765"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2024 06:59:18 -0700
X-CSE-ConnectionGUID: N5rVIHOASCa3MB8ZuM2Rag==
X-CSE-MsgGUID: T2fKK2dWQgqKIoy/kYGyfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="87765957"
Received: from kuha.fi.intel.com ([10.237.72.152])
  by orviesa003.jf.intel.com with SMTP; 01 Nov 2024 06:59:15 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Fri, 01 Nov 2024 15:59:13 +0200
Date: Fri, 1 Nov 2024 15:59:13 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Cc: tzungbi@kernel.org, linux-usb@vger.kernel.org,
	chrome-platform@lists.linux.dev, dmitry.baryshkov@linaro.org,
	jthies@google.com, akuchynski@google.com, pmalani@chromium.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/7] usb: typec: Auto enter control for alternate modes
Message-ID: <ZyTesZ3gCmYDmrA6@kuha.fi.intel.com>
References: <20241030212854.998318-1-abhishekpandit@chromium.org>
 <20241030142833.v2.3.I439cffc7bf76d94f5850eb85980f1197c4f9154c@changeid>
 <ZyOVIKGlrlj7kc9-@kuha.fi.intel.com>
 <CANFp7mX-DkyFqwoaq_4V1XEDBqK7bj6-nz2aJi7idM=Q2TT49w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANFp7mX-DkyFqwoaq_4V1XEDBqK7bj6-nz2aJi7idM=Q2TT49w@mail.gmail.com>

On Thu, Oct 31, 2024 at 03:48:45PM -0700, Abhishek Pandit-Subedi wrote:
> On Thu, Oct 31, 2024 at 7:33 AM Heikki Krogerus
> <heikki.krogerus@linux.intel.com> wrote:
> >
> > On Wed, Oct 30, 2024 at 02:28:34PM -0700, Abhishek Pandit-Subedi wrote:
> > > Add controls for whether an alternate mode is automatically entered when
> > > a partner connects. The auto_enter control is only available on ports
> > > and applies immediately after a partner connects. The default behavior
> > > is to enable auto enter and drivers must explicitly disable it.
> > >
> > > Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> > > ---
> > >
> > > (no changes since v1)
> > >
> > >  Documentation/ABI/testing/sysfs-bus-typec |  9 +++++++
> > >  drivers/usb/typec/altmodes/displayport.c  |  6 +++--
> > >  drivers/usb/typec/altmodes/thunderbolt.c  |  3 ++-
> > >  drivers/usb/typec/class.c                 | 31 +++++++++++++++++++++++
> > >  include/linux/usb/typec.h                 |  2 ++
> > >  include/linux/usb/typec_altmode.h         |  2 ++
> > >  6 files changed, 50 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/Documentation/ABI/testing/sysfs-bus-typec b/Documentation/ABI/testing/sysfs-bus-typec
> > > index 205d9c91e2e1..f09d05727b82 100644
> > > --- a/Documentation/ABI/testing/sysfs-bus-typec
> > > +++ b/Documentation/ABI/testing/sysfs-bus-typec
> > > @@ -12,6 +12,15 @@ Description:
> > >
> > >               Valid values are boolean.
> > >
> > > +What:                /sys/bus/typec/devices/.../auto_enter
> > > +Date:                September 2024
> > > +Contact:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > > +Description:
> > > +             Controls whether a mode will be automatically entered when a partner is
> > > +             connected.
> > > +
> > > +             This field is only valid and displayed on a port. Valid values are boolean.
> >
> > So, why can't this be controlled with the "active" property of the
> > port altmode instead? That's why it's there.
> >
> > Sorry if I missed something in v1 related to this question.
> 
> There was a bit of discussion around this in another patch in v1:
> https://patchwork.kernel.org/project/chrome-platform/patch/20240925092505.8.Ic14738918e3d026fa2d85e95fb68f8e07a0828d0@changeid/
> And this patch is probably a good place to continue that discussion.
> 
> With the way altmodes drivers currently work, they will auto-enter
> when probed. So if you have a partner that supports both displayport
> and thunderbolt, they will both attempt to auto-enter on probe. I
> think I could use the `active` field instead so that the port altmode
> blocks entry until userspace enables it -- this would avoid the need
> to add one more sysfs ABI. I'll actually go ahead and do this for the
> next patch series I send up.
> 
> However, the underlying problem I'm trying to solve still exists: how
> do you choose a specific altmode to enter if there are multiple to
> choose from? I tried to implement a method that first tries USB4 and
> then Thunderbolt and then DP but I realized that the altmode drivers
> don't necessarily bind immediately after a partner altmode is
> registered so I can't just call `activate` (since no ops are attached
> to the partner altmode yet). Do you have any thoughts about how to
> handle multiple modes as well as how to handle fallback mode entry
> (i.e. thunderbolt fails so you try DPAM next)?

If the user space needs to take over control of the entry order, then
can't it just de-activate all port alt modes by default, and then
activate the one that needs to enter? The port driver probable needs
to implent the "activate" callback for this.

The user space can see when the driver is bound to a device by
monitoring the uevents, no?

thanks,

-- 
heikki

