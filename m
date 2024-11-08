Return-Path: <linux-kernel+bounces-401235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D0F59C177C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 09:08:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E78A82838BD
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 08:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9495D1D2F55;
	Fri,  8 Nov 2024 08:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="glH6f2Qv"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9F91D0DC0;
	Fri,  8 Nov 2024 08:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731053296; cv=none; b=GFdXAOn1NBhtbgl6Mvg2AGbwiZC8fB3+FrpyeNetWoKfdqglqcnCYyCjdES1GsZLpPUiqeLSMXk+ebPSpldobnOR6OlY1StsDwbZ9lALsUdeVexZNPWY4d3UHtBnxItYaFq9OTZJMKnbdq0DvcE7qSClBysCOCT6sdgjuiIBzwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731053296; c=relaxed/simple;
	bh=AI9EMBn63ekAdbC9s6kHeDhDDE5FG9Rh+suJiaL2z1c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KVu1+iZ5oBt/97mLDLSjxZ24cesg4ZHmX0JaSZntjJfbflPW8huHYkJBZOYPgdAVXrwcQXRkphQB7XeHcsDR2JUZeNUapSoGGsnyGCasA1Uq8HARlHbHlLiodGyzX1gz0WzuruDnCeHbRUh8lnG8fvQW91XZPJwe7O7lctyGBtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=glH6f2Qv; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731053295; x=1762589295;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=AI9EMBn63ekAdbC9s6kHeDhDDE5FG9Rh+suJiaL2z1c=;
  b=glH6f2QvpzO9SCyQanOI7Vc6VQTdYZus+wo5LA34NvV4tq1gxBZY/B/O
   wRL90nh/zsOlDJ1gTW6SfM3avQG1vFHYxdlLjDj+x1NqOKg3q7wn2Dx24
   W7MPzwatHor6iHeTMOYBM4yU/rcj5oj6By22nQPRHqKeqI/h/4OBfqvul
   bvkpSPmFw0H/HY5LniyoItyE4bCMT6ju2euCarSxVKrpwbd619GVpt+28
   XOpSJfg8ZVTzoehSrOBHq8wjgMJvsmdecZx4uFlTdL8MWUwKM2OPkhpj1
   tkVDDYx5t2ItWjpv6hd0Rx/ATIPp1EpQ395YS2UtF9te8JwDvs7OqL0uv
   w==;
X-CSE-ConnectionGUID: cyAnpGeEQkykhGNIAz+yww==
X-CSE-MsgGUID: eJnxCIQlSHSeGidoD1eiXQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30699011"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="30699011"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2024 00:08:14 -0800
X-CSE-ConnectionGUID: n0FTouI8SBujM4LJD6h4oQ==
X-CSE-MsgGUID: 7yvunYfCQS6prdhcsaXzrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,137,1728975600"; 
   d="scan'208";a="116294718"
Received: from kuha.fi.intel.com ([10.237.72.152])
  by orviesa002.jf.intel.com with SMTP; 08 Nov 2024 00:08:12 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Fri, 08 Nov 2024 10:08:09 +0200
Date: Fri, 8 Nov 2024 10:08:09 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: =?iso-8859-1?Q?Facklam=2C_Oliv=E9r?= <oliver.facklam@zuehlke.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"von Heyl, Benedict" <benedict.vonheyl@zuehlke.com>,
	=?iso-8859-1?B?RvZyc3Qs?= Mathis <mathis.foerst@zuehlke.com>,
	"Glettig, Michael" <Michael.Glettig@zuehlke.com>
Subject: Re: [PATCH 2/4] usb: typec: hd3ss3220: use typec_get_fw_cap() to
 fill typec_cap
Message-ID: <Zy3G6dyvvpU4A6NO@kuha.fi.intel.com>
References: <20241107-usb-typec-controller-enhancements-v1-0-3886c1acced2@zuehlke.com>
 <20241107-usb-typec-controller-enhancements-v1-2-3886c1acced2@zuehlke.com>
 <ZyzMzEHA9DPMc_z9@kuha.fi.intel.com>
 <ZR1P278MB102298AE3011962AEE1BC91E9F5C2@ZR1P278MB1022.CHEP278.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZR1P278MB102298AE3011962AEE1BC91E9F5C2@ZR1P278MB1022.CHEP278.PROD.OUTLOOK.COM>

On Thu, Nov 07, 2024 at 03:24:44PM +0000, Facklam, Olivér wrote:
> Hello Heikki,
> 
> > -----Original Message-----
> > From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > Sent: Thursday, November 7, 2024 3:21 PM
> > To: Facklam, Olivér <oliver.facklam@zuehlke.com>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>; linux-
> > usb@vger.kernel.org; linux-kernel@vger.kernel.org; von Heyl, Benedict
> > <benedict.vonheyl@zuehlke.com>; Först, Mathis
> > <mathis.foerst@zuehlke.com>; Glettig, Michael
> > <Michael.Glettig@zuehlke.com>
> > Subject: Re: [PATCH 2/4] usb: typec: hd3ss3220: use typec_get_fw_cap() to fill
> > typec_cap
> > 
> > Hi Oliver,
> > 
> > On Thu, Nov 07, 2024 at 12:43:28PM +0100, Oliver Facklam via B4 Relay
> > wrote:
> > > From: Oliver Facklam <oliver.facklam@zuehlke.com>
> > >
> > > The type, data, and prefer_role properties were previously hard-coded
> > > when creating the struct typec_capability.
> > >
> > > Use typec_get_fw_cap() to populate these fields based on the
> > > respective fwnode properties.
> > >
> > > Signed-off-by: Oliver Facklam <oliver.facklam@zuehlke.com>
> > > ---
> > >  drivers/usb/typec/hd3ss3220.c | 8 ++++----
> > >  1 file changed, 4 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/drivers/usb/typec/hd3ss3220.c
> > > b/drivers/usb/typec/hd3ss3220.c index
> > >
> > 56f74bf70895ca701083bde44a5bbe0b691551e1..e6e4b1871b5d805f8c3671
> > 31509f
> > > 4e6ec0d2b5f0 100644
> > > --- a/drivers/usb/typec/hd3ss3220.c
> > > +++ b/drivers/usb/typec/hd3ss3220.c
> > > @@ -259,12 +259,12 @@ static int hd3ss3220_probe(struct i2c_client
> > *client)
> > >  		goto err_put_fwnode;
> > >  	}
> > >
> > > -	typec_cap.prefer_role = TYPEC_NO_PREFERRED_ROLE;
> > > +	ret = typec_get_fw_cap(&typec_cap, connector);
> > > +	if (ret)
> > > +		goto err_put_role;
> > 
> > You are not leaving any fallback here. Are you sure all the existing systems
> > supply those properties?
> > 
> > There is another problem. At least "data-role" property is optional, but that
> > will in practice make it a requirement.
> 
> I missed that typec_get_fw_cap() was not setting a default if the property is absent.
> 
> > 
> > I think it would be safer to use the values from the device properties only if
> > they are available. Otherwise simply use default values.
> 
> I'll add back the previous values as defaults before calling typec_get_fw_cap().
> That will make data-role and try-power-role optional again, as intended.
> 
> However, "power-role" seems to be required by the function. Is this expected?

Yes.

> Or should I write my own fwnode parsing logic?

No, don't do that.

You can check the return value. If it's -EINVAL or -ENXIO, the
properties are not there, and you can safely use the defaults.
Otherwise, consider the failure as critical.

thanks,

-- 
heikki

