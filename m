Return-Path: <linux-kernel+bounces-424711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BEA09DB863
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 14:15:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8FDCB2129A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 13:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2305B1A2C04;
	Thu, 28 Nov 2024 13:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lraxmJMT"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68AA81A9B24;
	Thu, 28 Nov 2024 13:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732799709; cv=none; b=YVtwjsmN8PJchxUzI64aPiSsx37OJfwEJZ4/ZiyqXV9x5uWp5dxbkLM3TM/aWoQyPbG8wjBydZcybYSl8uTX+Rz48Y2tj3Bw91S3rPXDYdU8fKgAw7IC48MbdN9r3hK/DMW9mxl/OTRxsMX5g58cuPYhRhrcpfN9U5oYUgMeQag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732799709; c=relaxed/simple;
	bh=7kyZJu/pnHKx22oZwaxi0VRQM35GE9ixpJ1ccfmWSMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PVS2RoNBuKEUGUVF3PgL9pV5IJKPKzSyJKkrUNo3BKbQ0nYSMTfAAaWJnnw1+YI7x/ploLviI11FUEuDkt9hwjFkAP/J0gIEelzhHSzdUBEAuff0fIk+RWzC3BUZUNVu4pgm8unESX2hgbj0E3Wl9r7O29CoBYG0NXp3TXgXLM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lraxmJMT; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732799707; x=1764335707;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=7kyZJu/pnHKx22oZwaxi0VRQM35GE9ixpJ1ccfmWSMQ=;
  b=lraxmJMTEBG1jON3MMIW390ojsqFbKxi6qyLG1NK4VVqQcDsljI/Md4i
   3BVk+xOQK6Zbnk2rNrEzEx3ZF8+d4qgyvK7VdikakZYDMMu0fj9OYmoAV
   Okjmk9A4fGwImI2oy9pkNZuIG0WcC2Im3JaAqScVvkSu6psN+/AF7tlqy
   ayD5HtFrv5ZIVxhX9PH+du4h0RUWkcMU5DO+R2e5JydwELxjeeBOPavjL
   YQYYJaYPDx+nkH3IRjgunV4BmohYQyd/ldVCzrN9n31qCVjchJQ6w9xD8
   m47HzusIESpZ6SRBi3Mc335eVBO7qfs5XeZ+VZWR/bXXTLAzTRE1g2E3/
   w==;
X-CSE-ConnectionGUID: LdDHUprDTQiLknS/BPA6Yw==
X-CSE-MsgGUID: ipavMg5LSWuIiwdSnDDQrA==
X-IronPort-AV: E=McAfee;i="6700,10204,11270"; a="44090454"
X-IronPort-AV: E=Sophos;i="6.12,192,1728975600"; 
   d="scan'208";a="44090454"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2024 05:15:07 -0800
X-CSE-ConnectionGUID: ybbHRNQaQSStMFpUQAoxIA==
X-CSE-MsgGUID: sHeog235RiemdKgly0CxIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,192,1728975600"; 
   d="scan'208";a="96328121"
Received: from kuha.fi.intel.com ([10.237.72.152])
  by fmviesa003.fm.intel.com with SMTP; 28 Nov 2024 05:15:04 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 28 Nov 2024 15:15:03 +0200
Date: Thu, 28 Nov 2024 15:15:02 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: =?iso-8859-1?Q?Facklam=2C_Oliv=E9r?= <oliver.facklam@zuehlke.com>
Cc: Biju Das <biju.das@bp.renesas.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"von Heyl, Benedict" <benedict.vonheyl@zuehlke.com>,
	=?iso-8859-1?B?RvZyc3Qs?= Mathis <mathis.foerst@zuehlke.com>,
	"Glettig, Michael" <Michael.Glettig@zuehlke.com>
Subject: Re: [PATCH v2 3/4] usb: typec: hd3ss3220: support configuring port
 type
Message-ID: <Z0hs1ougC6HSt5KO@kuha.fi.intel.com>
References: <20241114-usb-typec-controller-enhancements-v2-0-362376856aea@zuehlke.com>
 <20241114-usb-typec-controller-enhancements-v2-3-362376856aea@zuehlke.com>
 <Zzsp2JOhnnPPOWvB@kuha.fi.intel.com>
 <ZR1P278MB10224924F48419CA813402309F272@ZR1P278MB1022.CHEP278.PROD.OUTLOOK.COM>
 <Z0RRQoRN7721FF-Z@kuha.fi.intel.com>
 <ZR1P278MB1022EC72C26F483A416DB1979F282@ZR1P278MB1022.CHEP278.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZR1P278MB1022EC72C26F483A416DB1979F282@ZR1P278MB1022.CHEP278.PROD.OUTLOOK.COM>

Hi,

On Wed, Nov 27, 2024 at 08:02:55AM +0000, Facklam, Olivér wrote:
> Hi Heikki,
> 
> > -----Original Message-----
> > From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > Sent: Monday, November 25, 2024 11:28 AM
> > 
> > Hi Olivér,
> > 
> > Sorry to keep you waiting.
> > 
> > On Mon, Nov 18, 2024 at 02:00:41PM +0000, Facklam, Olivér wrote:
> > > Hello Heikki,
> > >
> > > Thanks for reviewing.
> > >
> > > > -----Original Message-----
> > > > From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > > > Sent: Monday, November 18, 2024 12:50 PM
> > > >
> > > > Hi Oliver,
> > > >
> > > > I'm sorry, I noticed a problem with this...
> > > >
> > > > On Thu, Nov 14, 2024 at 09:02:08AM +0100, Oliver Facklam wrote:
> > > > > The TI HD3SS3220 Type-C controller supports configuring the port
> > > > > type it will operate as through the MODE_SELECT field of the
> > > > > General Control Register.
> > > > >
> > > > > Configure the port type based on the fwnode property "power-role"
> > > > > during probe, and through the port_type_set typec_operation.
> > > > >
> > > > > The MODE_SELECT field can only be changed when the controller is
> > > > > in unattached state, so follow the sequence recommended by the
> > > > > datasheet
> > > > to:
> > > > > 1. disable termination on CC pins to disable the controller 2.
> > > > > change the mode 3. re-enable termination
> > > > >
> > > > > This will effectively cause a connected device to disconnect for
> > > > > the duration of the mode change.
> > > >
> > > > Changing the type of the port is really problematic, and IMO we
> > > > should actually never support that.
> > >
> > > Could you clarify why you think it is problematic?
> > 
> > It's not completely clear to me what it's meant for. If it was just for fixing the
> > type of the port to be sink, source or DRP before connections, it would make
> > sense, but since it can be use even when there is an actice connection (there
> > is nothing preventing that), it can in practice be used to swap the role.
> > 
> > And in some cases in the past where this attribute file was proposed to be
> > used with some other drivers, the actual goal really ended up being to be
> > able to just swap the role with an existing connection instead of being able to
> > fix the type of the port. The commit message made it sound like that could be
> > the goal in this case as well, but maybe I misunderstood.
> > 
> > Even in cases where it's clear that the intention is to just fix the role before
> > connections, why would user space needs to control that is still not
> > completely clear, at least not to me.
> 
> The idea is to give the user the possibility to control/restrict how the port is
> operating even if they have an actual dual-role capable port.
> 
> Let me clarify. In my use case, I have a DRP port, and in most cases I would
> like to use it as such.
> However, there are cases where this operating mode causes additional
> difficulties -- for example when connecting to another dual-role port 
> implementing the same role preference (e.g. 2 Try.SNK devices connected
> together). Then the role outcome is random.
> Since this chip doesn't support PD, there is no way to switch the role from
> userspace.
> When I know I'm going to be working with these types of connections, it
> would be better if I can restrict the operation mode to "sink-only" (for example)
> for that duration. Without needing to change my device tree.
> 
> Sure, the mechanism can be abused to switch the role on an active connection,
> but that was not the primary idea here.
> I would even argue that calling a port type change during an active
> connection terminates that connection, and starts a new connection
> from scratch with the new behavior.

Okay, thanks for the explanation.

> > > > Consider for example, if your port is sink only, then the platform
> > > > almost certainly can't drive the VBUS. This patch would still allow
> > > > the port to be changed to source port.
> > >
> > > In my testing, it appeared to me that when registering a type-c port
> > > with "typec_cap.type = TYPEC_PORT_SNK" (for example), then the type-c
> > > class disables the port_type_store functionality:
> > > 	if (port->cap->type != TYPEC_PORT_DRP ||
> > > 	    !port->ops || !port->ops->port_type_set) {
> > > 		dev_dbg(dev, "changing port type not supported\n");
> > > 		return -EOPNOTSUPP;
> > > 	}
> > >
> > > So to my understanding, a platform which cannot drive VBUS should
> > > simply set the fwnode `power-role="sink"`. Since patch 2/4 correctly
> > > parses this property, wouldn't that solve this case?
> > 
> > True. I stand corrected.
> > 
> > > > Sorry for not realising this in v1.
> > > >
> > > > I think what you want here is just a power role swap. Currently
> > > > power role swap is only supported when USB PD is supported in the
> > > > class code, but since the USB Type-C specification quite clearly
> > > > states that power role and data role swap can be optionally
> > > > supported even when USB PD is not supported (section 2.3.3) we need to
> > fix that:
> > >
> > > My interpretation of section 2.3.3 is that the 2 mechanisms allowing
> > > power role swap are:
> > > - USB PD (after initial connection)
> > > - "as part of the initial connection process": to me this is simply referring to
> > the
> > > 	Try.SRC / Try.SNK mechanism, for which we already have
> > > 	the "try_role" callback.
> > >
> > > Maybe I'm misunderstanding what the intentions are behind each of the
> > > typec_operations, so if you could clarify that (or give some pointer),
> > > that would be appreciated. My understanding:
> > > - "try_role": set Try.SRC / Try.SNK / no preference for a dual-role
> > > port for initial connection
> > > - "pr_set" / "dr_set" / "vconn_set": swap power and data role resp.
> > > 	after the initial connection using USB-PD.
> > > - "port_type_set": configure what port type to operate as, i.e. which initial
> > connection
> > > 	state machine from the USB-C standard to apply for the next
> > > connection Please correct me if any of these are incorrect.
> > 
> > I don't know what's the intention with the port_type attribute file
> > unfortunately.
> > 
> > > > diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
> > > > index 58f40156de56..ee81909565a4 100644
> > > > --- a/drivers/usb/typec/class.c
> > > > +++ b/drivers/usb/typec/class.c
> > > > @@ -1535,11 +1535,6 @@ static ssize_t power_role_store(struct device
> > > > *dev,
> > > >                 return -EOPNOTSUPP;
> > > >         }
> > > >
> > > > -       if (port->pwr_opmode != TYPEC_PWR_MODE_PD) {
> > > > -               dev_dbg(dev, "partner unable to swap power role\n");
> > > > -               return -EIO;
> > > > -       }
> > > > -
> > > >         ret = sysfs	_match_string(typec_roles, buf);
> > > >         if (ret < 0)
> > > >                 return ret;
> > > >
> > > >
> > > > After that it should be possible to do power role swap also in this
> > > > driver when the port is DRP capable.
> > > >
> > > > > Signed-off-by: Oliver Facklam <oliver.facklam@zuehlke.com>
> > > > > ---
> > > > >  drivers/usb/typec/hd3ss3220.c | 66
> > > > ++++++++++++++++++++++++++++++++++++++++++-
> > > > >  1 file changed, 65 insertions(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/drivers/usb/typec/hd3ss3220.c
> > > > b/drivers/usb/typec/hd3ss3220.c
> > > > > index
> > > >
> > e581272bb47de95dee8363a5491f543354fcbbf8..e3e9b1597e3b09b82f0726a
> > > > 01f311fb60b4284da 100644
> > > > > --- a/drivers/usb/typec/hd3ss3220.c
> > > > > +++ b/drivers/usb/typec/hd3ss3220.c
> > > [...]
> > > > > @@ -131,8 +183,16 @@ static int hd3ss3220_dr_set(struct typec_port
> > > > *port, enum typec_data_role role)
> > > > >       return ret;
> > > > >  }
> > > > >
> > > > > +static int hd3ss3220_port_type_set(struct typec_port *port, enum
> > > > typec_port_type type)
> > > > > +{
> > > > > +     struct hd3ss3220 *hd3ss3220 = typec_get_drvdata(port);
> > > > > +
> > > > > +     return hd3ss3220_set_port_type(hd3ss3220, type); }
> > > >
> > > > This wrapper seems completely useless. You only need one function
> > > > here for the callback.
> > >
> > > The wrapper is to extract the struct hd3ss3220 from the typec_port.
> > > The underlying hd3ss3220_set_port_type I am also using during probe to
> > > configure initial port type.
> > 
> > Ah, I missed that. Sorry about that.
> > 
> > > One point worth mentioning here is that if the MODE_SELECT register is
> > > not configured, the chip will operate according to a default which is
> > > chosen by an external pin (sorry if this was not detailed enough in
> > > commit msg)
> > > >From the datasheet:
> > > -------------------
> > > | PORT | 4 | I | Tri-level input pin to indicate port mode. The state
> > > | of this pin is sampled when HD3SS3220's
> > > 		ENn_CC is asserted low, and VDD5 is active. This pin is also
> > sampled following a
> > > 		I2C_SOFT_RESET.
> > > 		H - DFP (Pull-up to VDD5 if DFP mode is desired)
> > > 		NC - DRP (Leave unconnected if DRP mode is desired)
> > > 		L - UFP (Pull-down or tie to GND if UFP mode is desired)
> > >
> > > In our use case, it was not desirable to leave this default based on
> > > wiring, and it makes more sense to me to allow the configuration to
> > > come from the fwnode property. Hence the port type setting in probe().
> > 
> > I get that, but that just means you want to fix the type during probe, no?
> > Why do you need to expose this to the user space?
> 
> I've been thinking a bit more about this "fixing the type during probe" feature.
> My current implementation always fixes the type, even if no device tree entry
> for "power-role" was found. Could that cause issues for people relying on the
> configuration through the PORT pin?
> 
> I could consider a solution where if the property is absent, the type is not
> reconfigured during the probe. Although then I would have to do manual parsing
> of that DT property. With typec_get_fw_cap() from patch 2/4, I loose
> the information about individual properties being present/absent.
> Would be interested in hearing your thoughts.

I don't think it's a problem to check does the property exist directly
in the driver. It sounds like that's what should be done in this case.

Br,

-- 
heikki

