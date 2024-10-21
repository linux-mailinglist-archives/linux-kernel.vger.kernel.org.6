Return-Path: <linux-kernel+bounces-374558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E423E9A6BF3
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 16:20:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A561E2818D4
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 14:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 023341F9AA8;
	Mon, 21 Oct 2024 14:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UzftFcnM"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817F11F473C;
	Mon, 21 Oct 2024 14:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729520423; cv=none; b=CD7jKfufg9ViVesZwFZG9Ef9mrOsRAPpXmAIBwEaHFHTN+GXdffnqBH3S9WSrnNXw0SlSmwaqEFyafAUQ4h9lulYPz/Xw1JmHKFIC6Wpy8/hJPKGZ74o/ej6T/VygDUJ490x0d0/JtT0SCMB+Lr4Fwz7z2qB75ddiOL1zKbqc9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729520423; c=relaxed/simple;
	bh=s+Pesid7NRqakfpMfcpLT6dSCI9G+GssV6W02f8Qe3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A4u+9zYzkfTHIcoJ+JNKx3Xd88XtBPC2Uf/Jh3GXzrC++y6jSNuKk8mTknV87y8d7lrGVrVkvJUkmfsaeWxqkMF1HytNI9phkF4IfP/WDzUfuEPg/f7SGGPxbZfc0aykm0xM17aGMIa3XLQk9IWNOh/+l4Q5h4BGQVqF/tFc+Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UzftFcnM; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729520422; x=1761056422;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=s+Pesid7NRqakfpMfcpLT6dSCI9G+GssV6W02f8Qe3M=;
  b=UzftFcnMtekQO40fxikXuwBugU9W04h4XlAXxhAKRYgLBAJmj/SctlZz
   f7baSemo1AUB07RXNWw9S7taATrC065UbTbdWZBcFZwINvmGKN8BcL33A
   kIjgSWOYGQarvRufMCzBfXZPdtBWMcIDEovu3vSD94CYFoFz9GODxGzRi
   ZblgI3vO5blFbKcvuysN6PAMlKv9KR7pLTGYwLoDi1IdaIrit2a03c/Kw
   7S6zM8UMcR/yROuJJnq5XKfZfrvZF3vz/LWd31rI5M7VBE6PU3ZY+nCd4
   toq7bMt8xMdnfjwwwW54zZjwCp247nd1Zrjj+h/tPXJ7Fq8oPemCG8Dgc
   w==;
X-CSE-ConnectionGUID: zzhuMOspSjStX3khw4ZKpw==
X-CSE-MsgGUID: yY2AxqrNShKPFCrWnRCnWw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="46472114"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="46472114"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 07:20:21 -0700
X-CSE-ConnectionGUID: 1aMRdTogQoS0b809mkUqGQ==
X-CSE-MsgGUID: JTwiPuZ1Rg+exI3PofddfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,221,1725346800"; 
   d="scan'208";a="79484811"
Received: from kuha.fi.intel.com ([10.237.72.152])
  by orviesa009.jf.intel.com with SMTP; 21 Oct 2024 07:20:19 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 21 Oct 2024 17:20:17 +0300
Date: Mon, 21 Oct 2024 17:20:17 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Hans de Goede <hdegoede@redhat.com>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] usb: typec: fix unreleased fwnode_handle in
 typec_port_register_altmodes()
Message-ID: <ZxZjIa8lB3Xvx3xN@kuha.fi.intel.com>
References: <20241019-typec-class-fwnode_handle_put-v1-1-a3b5a0a02795@gmail.com>
 <ZxZPS7jt4mI1TUG-@kuha.fi.intel.com>
 <ZxZaRUmZS4upPvv8@kuha.fi.intel.com>
 <d5733f9e-6eb5-4b03-b264-a3f9f35791f6@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d5733f9e-6eb5-4b03-b264-a3f9f35791f6@gmail.com>

On Mon, Oct 21, 2024 at 04:06:30PM +0200, Javier Carrasco wrote:
> On 21/10/2024 15:42, Heikki Krogerus wrote:
> > Hi,
> > 
> > On Mon, Oct 21, 2024 at 03:55:43PM +0300, Heikki Krogerus wrote:
> >> On Sat, Oct 19, 2024 at 10:40:19PM +0200, Javier Carrasco wrote:
> >>> The 'altmodes_node' fwnode_handle is never released after it is no
> >>> longer required, which leaks the resource.
> >>>
> >>> Add the required call to fwnode_handle_put() when 'altmodes_node' is no
> >>> longer required.
> >>>
> >>> Cc: stable@vger.kernel.org
> >>> Fixes: 7b458a4c5d73 ("usb: typec: Add typec_port_register_altmodes()")
> >>> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> >>
> >> Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> >>
> >>> ---
> >>>  drivers/usb/typec/class.c | 1 +
> >>>  1 file changed, 1 insertion(+)
> >>>
> >>> diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
> >>> index d61b4c74648d..1eb240604cf6 100644
> >>> --- a/drivers/usb/typec/class.c
> >>> +++ b/drivers/usb/typec/class.c
> >>> @@ -2341,6 +2341,7 @@ void typec_port_register_altmodes(struct typec_port *port,
> >>>  		altmodes[index] = alt;
> >>>  		index++;
> >>>  	}
> >>> +	fwnode_handle_put(altmodes_node);
> >>>  }
> >>>  EXPORT_SYMBOL_GPL(typec_port_register_altmodes);
> > 
> > Sorry to go back to this, but I guess we should actually use those
> > scope based helpers with fwnodes in this case. So instead of a
> > dedicated fwnode_handle_put() call like that, just introduce
> > altmodes_node like this:
> > 
> >         ...
> >         struct fwnode_handle *altmodes_node __free(fwnode_handle) =
> >                 device_get_named_child_node(&port->dev, "altmodes");
> > 
> >         if (IS_ERR(altmodes_node))
> >                 return;
> > 
> >         fwnode_for_each_child_node(altmodes_node, child) {
> >         ...
> > 
> > thanks,
> > 
> 
> That would have to be a second patch, because it does not apply to all
> affected stable kernels. I can send it separately, though.

Great, thanks!

-- 
heikki

