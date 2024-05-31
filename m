Return-Path: <linux-kernel+bounces-196501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 400B68D5D14
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 10:48:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71A191C22597
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 08:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FC46155A5C;
	Fri, 31 May 2024 08:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WfoJxfGf"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EDDF15575F;
	Fri, 31 May 2024 08:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717145279; cv=none; b=U+JRggPpB2LQ0V6Gb44kqDO9pT0GsHUOSzuLhJrrnGnHwueVBHv/h1CCYatGXlP5ALfQl9oFwcdHZ+l3/9sddoSqVZHhS7ZP9/IMum8Pja7qUosEYpEsBEmIZ9x3XNdk9YoKhQtgK+MX+RzAB7WJ8jHkhL51ybp0K5O6cWaYH48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717145279; c=relaxed/simple;
	bh=uS5o+FWxiCvy3YjKzKRAy5N6NMJJQCv7/fpq7ul1rzI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kCeKEHiBb/Su0x8oOajoNUodeKA6gKgBg1NeO9wFh67YyYlFwQcmFen9ZG6ZXXQCwypllhnAookxY22/D+WGLao/XfmmeW/M08VptUAWTF9+qh5S4q9bvr2LVMU3xLSBnKsZx6uVk8yed3A0IYYAv8IMjF67uigDA1Us4V64XXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WfoJxfGf; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717145279; x=1748681279;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uS5o+FWxiCvy3YjKzKRAy5N6NMJJQCv7/fpq7ul1rzI=;
  b=WfoJxfGfU3+KVuHfaoQXRke+gtHWiyRc4//BQ2omhv9GE2UWimNormxX
   GFkW3DFMct8O/y7Ct99P6SbQVlzyubJcL3PQOamTDovV1rUARgPC8asQ+
   Bxpc9zDP2Q7zmWMUgRNtTJ+toG0NkXXfF5TcmPAkealZWfdCTicZ0aYJR
   6nOaiS2bYWK5+flY3vaq/Z0VC422YFaJMhiJbzw2sK/vUcRjYSC+e1BW5
   GtkqJjg906LZGmLO2dlAr9vqSwydOqJqRJmqp+FBWakuBi6bZV2/S2lId
   OIannGUPmRdzJqOz7kMJU4zdUiN+Ku3D4UCIVzQ4Ajto6t4JJXak09EtV
   A==;
X-CSE-ConnectionGUID: Kgvqg1hIRJWRUuV9h6zsOg==
X-CSE-MsgGUID: tkhWaPOpTS6o0KNlpVtnYQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11088"; a="24800874"
X-IronPort-AV: E=Sophos;i="6.08,203,1712646000"; 
   d="scan'208";a="24800874"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 01:47:58 -0700
X-CSE-ConnectionGUID: m1xok72FQv+SEHizwj3eGA==
X-CSE-MsgGUID: 3o6D9GnQRx+pphs5KaqdIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,203,1712646000"; 
   d="scan'208";a="36581972"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by orviesa006.jf.intel.com with SMTP; 31 May 2024 01:47:56 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Fri, 31 May 2024 11:47:54 +0300
Date: Fri, 31 May 2024 11:47:54 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
	linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCH v1 1/1] usb: typec: tcpm: print error on hard reset
Message-ID: <ZlmOukCZ7Qh2g4Bd@kuha.fi.intel.com>
References: <20240523171645.223225-1-sebastian.reichel@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240523171645.223225-1-sebastian.reichel@collabora.com>

On Thu, May 23, 2024 at 07:12:29PM +0200, Sebastian Reichel wrote:
> A USB-C hard reset involves removing the voltage from VBUS for some
> time. So basically it has the same effect as removing the USB-C plug
> for a short moment. If the machine is powered from the USB-C port and
> does not have a fallback supply (e.g. a battery), this will result in
> a full machine reset due to power loss.
> 
> Ideally we want to avoid triggering a hard reset on these boards. A
> non-working USB-C port is probably better than unplanned reboots. But
> boards with a backup supply should do the hard reset to get everything
> working again.
> 
> In theory it would be enough to check the self_powered property, but
> it seems the property might not be configured consistently enough in
> system firmwares.
> 
> So let's start with just printing an error message when a hard reset is
> triggered on systems we expect to be affected. This at least makes
> debugging issues on affected systems easier without impacting unaffected
> systems too much.
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/tcpm/tcpm.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index 8a1af08f71b6..375bc84d14a2 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -5185,6 +5185,8 @@ static void run_state_machine(struct tcpm_port *port)
>  	case HARD_RESET_SEND:
>  		if (port->ams != NONE_AMS)
>  			tcpm_ams_finish(port);
> +		if (!port->self_powered && port->port_type == TYPEC_PORT_SNK)
> +			dev_err(port->dev, "Initiating hard-reset, which might result in machine power-loss.\n");
>  		/*
>  		 * State machine will be directed to HARD_RESET_START,
>  		 * thus set upcoming_state to INVALID_STATE.
> -- 
> 2.43.0

-- 
heikki

