Return-Path: <linux-kernel+bounces-420818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20E3F9D8382
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 11:36:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E690DB2C9AA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 10:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F051192589;
	Mon, 25 Nov 2024 10:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fouxrzBd"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F19191F7E;
	Mon, 25 Nov 2024 10:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732530505; cv=none; b=Tq4FeBAB6hWGjr5T0hs9FKhwNbJyYF37q/RqMu4RF/ezAanbqPpIBXeolXmnwrw4wcyM14AM9oG6bzCpmITIRUyVRch7271Xxmgi6SPSt05nXcjRayIOpsvEMVVhY+BX6sJi20jSWLrSSZzqWkUFdMuPo+zoQxFqIwu7O5dQPsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732530505; c=relaxed/simple;
	bh=Td+5EEQzC5KgR6blIuLKDXD2I/H9vF133xyB8vmFB5w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BG3VWIu/KaX36qftHMdqqOLDde65V/QJUZ6o51oBxqUGRZEPAUWRLKUO6oxoBzKZpiIG4+GwD9amGflsegQswLzgDvhiJtQvRmRhsxbe7HA/BVI5thWprkZX3YH6emZG5clftsu/HBePe++adYcC2UvsogDw/1Sdj7bkQYb41LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fouxrzBd; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732530503; x=1764066503;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Td+5EEQzC5KgR6blIuLKDXD2I/H9vF133xyB8vmFB5w=;
  b=fouxrzBdLWJAV1Iu7lW7blEKPcvi9RAafytdQEK29FCWH4qMdFh6hZc+
   N98IS+OI1cx4g3P6SERIOhZvDtyKWG4/yW+IPR4wM7/1t5TFyAFmsPHnU
   h/Hm01D8D6Au6CjXNmj0sCJaX2ySf8YX6f+OI7HFb725SKgDQHVyNOZKz
   sClJqi9z2PaoQf3pgWrCBUVeJMxGRoXr8WFvOhNCuQwz89I7txDDAPYvg
   yRhswW0l7V96qefrFui+YjhCZgA4ks07zy0zR3bDs9QEfc/CiZdts+IcU
   SjQD9IFyPB+WuTIVMhPcul3udTf3Bejesnf7D4335vVyIi0880aRsI1/f
   Q==;
X-CSE-ConnectionGUID: sXNajUbFQRGz6hZT8xzXWA==
X-CSE-MsgGUID: U3ouv+TARG6ovC58wEeziA==
X-IronPort-AV: E=McAfee;i="6700,10204,11266"; a="50150111"
X-IronPort-AV: E=Sophos;i="6.12,182,1728975600"; 
   d="scan'208";a="50150111"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2024 02:28:22 -0800
X-CSE-ConnectionGUID: dVnJtMhfRZmqq5ZpmG8VFA==
X-CSE-MsgGUID: 1YF3asDURs6i2eCuFEW+Ig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,182,1728975600"; 
   d="scan'208";a="122172790"
Received: from kuha.fi.intel.com ([10.237.72.152])
  by fmviesa001.fm.intel.com with SMTP; 25 Nov 2024 02:28:19 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 25 Nov 2024 12:28:18 +0200
Date: Mon, 25 Nov 2024 12:28:18 +0200
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
Message-ID: <Z0RRQoRN7721FF-Z@kuha.fi.intel.com>
References: <20241114-usb-typec-controller-enhancements-v2-0-362376856aea@zuehlke.com>
 <20241114-usb-typec-controller-enhancements-v2-3-362376856aea@zuehlke.com>
 <Zzsp2JOhnnPPOWvB@kuha.fi.intel.com>
 <ZR1P278MB10224924F48419CA813402309F272@ZR1P278MB1022.CHEP278.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZR1P278MB10224924F48419CA813402309F272@ZR1P278MB1022.CHEP278.PROD.OUTLOOK.COM>

Hi Olivér,

Sorry to keep you waiting.

On Mon, Nov 18, 2024 at 02:00:41PM +0000, Facklam, Olivér wrote:
> Hello Heikki,
> 
> Thanks for reviewing.
> 
> > -----Original Message-----
> > From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > Sent: Monday, November 18, 2024 12:50 PM
> > To: Facklam, Olivér <oliver.facklam@zuehlke.com>
> > Cc: Biju Das <biju.das@bp.renesas.com>; Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org>; linux-usb@vger.kernel.org; linux-
> > kernel@vger.kernel.org; von Heyl, Benedict
> > <benedict.vonheyl@zuehlke.com>; Först, Mathis
> > <mathis.foerst@zuehlke.com>; Glettig, Michael
> > <Michael.Glettig@zuehlke.com>
> > Subject: Re: [PATCH v2 3/4] usb: typec: hd3ss3220: support configuring port
> > type
> > 
> > Hi Oliver,
> > 
> > I'm sorry, I noticed a problem with this...
> > 
> > On Thu, Nov 14, 2024 at 09:02:08AM +0100, Oliver Facklam wrote:
> > > The TI HD3SS3220 Type-C controller supports configuring the port type
> > > it will operate as through the MODE_SELECT field of the General
> > > Control Register.
> > >
> > > Configure the port type based on the fwnode property "power-role"
> > > during probe, and through the port_type_set typec_operation.
> > >
> > > The MODE_SELECT field can only be changed when the controller is in
> > > unattached state, so follow the sequence recommended by the datasheet
> > to:
> > > 1. disable termination on CC pins to disable the controller
> > > 2. change the mode
> > > 3. re-enable termination
> > >
> > > This will effectively cause a connected device to disconnect
> > > for the duration of the mode change.
> > 
> > Changing the type of the port is really problematic, and IMO we should
> > actually never support that.
> 
> Could you clarify why you think it is problematic?

It's not completely clear to me what it's meant for. If it was just
for fixing the type of the port to be sink, source or DRP before
connections, it would make sense, but since it can be use even when
there is an actice connection (there is nothing preventing that), it
can in practice be used to swap the role.

And in some cases in the past where this attribute file was proposed
to be used with some other drivers, the actual goal really ended up
being to be able to just swap the role with an existing connection
instead of being able to fix the type of the port. The commit message
made it sound like that could be the goal in this case as well, but
maybe I misunderstood.

Even in cases where it's clear that the intention is to just fix the
role before connections, why would user space needs to control that is
still not completely clear, at least not to me.

> > Consider for example, if your port is sink only, then the platform
> > almost certainly can't drive the VBUS. This patch would still allow
> > the port to be changed to source port.
> 
> In my testing, it appeared to me that when registering a type-c port with
> "typec_cap.type = TYPEC_PORT_SNK" (for example), then the type-c class
> disables the port_type_store functionality:
> 	if (port->cap->type != TYPEC_PORT_DRP ||
> 	    !port->ops || !port->ops->port_type_set) {
> 		dev_dbg(dev, "changing port type not supported\n");
> 		return -EOPNOTSUPP;
> 	}
> 
> So to my understanding, a platform which cannot drive VBUS should simply
> set the fwnode `power-role="sink"`. Since patch 2/4 correctly parses this property,
> wouldn't that solve this case?

True. I stand corrected.

> > Sorry for not realising this in v1.
> > 
> > I think what you want here is just a power role swap. Currently power
> > role swap is only supported when USB PD is supported in the class
> > code, but since the USB Type-C specification quite clearly states that
> > power role and data role swap can be optionally supported even when
> > USB PD is not supported (section 2.3.3) we need to fix that:
> 
> My interpretation of section 2.3.3 is that the 2 mechanisms allowing 
> power role swap are:
> - USB PD (after initial connection)
> - "as part of the initial connection process": to me this is simply referring to the
> 	Try.SRC / Try.SNK mechanism, for which we already have 
> 	the "try_role" callback.
> 
> Maybe I'm misunderstanding what the intentions are behind each of the 
> typec_operations, so if you could clarify that (or give some pointer), that would
> be appreciated. My understanding:
> - "try_role": set Try.SRC / Try.SNK / no preference for a dual-role port for initial connection
> - "pr_set" / "dr_set" / "vconn_set": swap power and data role resp.
> 	after the initial connection using USB-PD.
> - "port_type_set": configure what port type to operate as, i.e. which initial connection
> 	state machine from the USB-C standard to apply for the next connection
> Please correct me if any of these are incorrect.

I don't know what's the intention with the port_type attribute file
unfortunately.

> > diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
> > index 58f40156de56..ee81909565a4 100644
> > --- a/drivers/usb/typec/class.c
> > +++ b/drivers/usb/typec/class.c
> > @@ -1535,11 +1535,6 @@ static ssize_t power_role_store(struct device
> > *dev,
> >                 return -EOPNOTSUPP;
> >         }
> > 
> > -       if (port->pwr_opmode != TYPEC_PWR_MODE_PD) {
> > -               dev_dbg(dev, "partner unable to swap power role\n");
> > -               return -EIO;
> > -       }
> > -
> >         ret = sysfs	_match_string(typec_roles, buf);
> >         if (ret < 0)
> >                 return ret;
> > 
> > 
> > After that it should be possible to do power role swap also in this
> > driver when the port is DRP capable.
> > 
> > > Signed-off-by: Oliver Facklam <oliver.facklam@zuehlke.com>
> > > ---
> > >  drivers/usb/typec/hd3ss3220.c | 66
> > ++++++++++++++++++++++++++++++++++++++++++-
> > >  1 file changed, 65 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/usb/typec/hd3ss3220.c
> > b/drivers/usb/typec/hd3ss3220.c
> > > index
> > e581272bb47de95dee8363a5491f543354fcbbf8..e3e9b1597e3b09b82f0726a
> > 01f311fb60b4284da 100644
> > > --- a/drivers/usb/typec/hd3ss3220.c
> > > +++ b/drivers/usb/typec/hd3ss3220.c
> [...]
> > > @@ -131,8 +183,16 @@ static int hd3ss3220_dr_set(struct typec_port
> > *port, enum typec_data_role role)
> > >       return ret;
> > >  }
> > >
> > > +static int hd3ss3220_port_type_set(struct typec_port *port, enum
> > typec_port_type type)
> > > +{
> > > +     struct hd3ss3220 *hd3ss3220 = typec_get_drvdata(port);
> > > +
> > > +     return hd3ss3220_set_port_type(hd3ss3220, type);
> > > +}
> > 
> > This wrapper seems completely useless. You only need one function here
> > for the callback.
> 
> The wrapper is to extract the struct hd3ss3220 from the typec_port.
> The underlying hd3ss3220_set_port_type I am also using during probe
> to configure initial port type.

Ah, I missed that. Sorry about that.

> One point worth mentioning here is that if the MODE_SELECT register
> is not configured, the chip will operate according to a default which is 
> chosen by an external pin (sorry if this was not detailed enough in commit msg)
> >From the datasheet:
> -------------------
> | PORT | 4 | I | Tri-level input pin to indicate port mode. The state of this pin is sampled when HD3SS3220's
> 		ENn_CC is asserted low, and VDD5 is active. This pin is also sampled following a
> 		I2C_SOFT_RESET.
> 		H - DFP (Pull-up to VDD5 if DFP mode is desired)
> 		NC - DRP (Leave unconnected if DRP mode is desired)
> 		L - UFP (Pull-down or tie to GND if UFP mode is desired)
> 
> In our use case, it was not desirable to leave this default based on wiring,
> and it makes more sense to me to allow the configuration to come from
> the fwnode property. Hence the port type setting in probe().

I get that, but that just means you want to fix the type during probe,
no? Why do you need to expose this to the user space?

> > >  static const struct typec_operations hd3ss3220_ops = {
> > > -     .dr_set = hd3ss3220_dr_set
> > > +     .dr_set = hd3ss3220_dr_set,
> > > +     .port_type_set = hd3ss3220_port_type_set,
> > >  };
> > 
> > So here I think you should implement the pr_set callback instead.
> 
> I can do that, but based on the MODE_SELECT register description, 
> it seems to me that this setting is fundamentally changing the operation
> mode of the chip, i.e. the state machine that is being run for initial connection.
> So there would have to be a way of "resetting" it to be a dual-role port again,
> which the "pr_set" callback doesn't seem to have?
> 	This register can be written to set the HD3SS3220 mode
> 	operation. The ADDR pin must be set to I2C mode. If the default
> 	is maintained, HD3SS3220 shall operate according to the PORT
> 	pin levels and modes. The MODE_SELECT can only be
> 	changed when in the unattached state.
> 	00 - DRP mode (start from unattached.SNK) (default)
> 	01 - UFP mode (unattached.SNK)
> 	10 - DFP mode (unattached.SRC)
> 	11 - DRP mode (start from unattached.SNK)

Okay, I see. This is not a case for pr_set.

I'm still confused about the use case here. It seems you are not
interested in role swapping after all, so why would you need this
functionality to be exposed to the user space?

I'm sorry if I've missed something.

About the port_type attribute file itself. I would feel more
comfortable with it if it was allowed to be written only when there is
nothing connected to the port. At the very least, I think it should be
documented better so what it's really meant for would be more clear to
everybody.

thanks,

-- 
heikki

