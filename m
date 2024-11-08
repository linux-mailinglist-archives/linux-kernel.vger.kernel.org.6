Return-Path: <linux-kernel+bounces-401673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 277AE9C1DC2
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 14:17:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3025B28467D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 13:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06DE11EB9F6;
	Fri,  8 Nov 2024 13:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WngEN8pA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42919197A82;
	Fri,  8 Nov 2024 13:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731071848; cv=none; b=Pr5JjouUmEBtEAuACT57/kgACnoeJajkaGBSTGPSWgZ3Tddqb9AIbwWp/D8u2wQo6fmyHzJCg/XuEhFf9qoFdBOWeaSnWzH26TrxVSd/MgGtdVNkweRDCiOxjtr5oYu1SKiezgd+2uP8UO+MNUeBQ46C8URLkpu579iatyxo0g4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731071848; c=relaxed/simple;
	bh=aTlcdGF4Imb5wPzEWaP+ifFhnpk6S1zRFb9Re4B9pNI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IYs441d0waMhdBXHjkgfFMk/YhwEhTNn2g5XHpVATrQae6invBBwRpHSG6fz8tv/o00JXEL3WfpLJBMkCuk0HyEG5cpkd9NJy10hfuqWoKN9xVxRnJBoyncK0FlSu41a10y/j3l8fNBmakyzl1GsAurRj4o+Kzc1yZTudCuYYtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WngEN8pA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11587C4CECE;
	Fri,  8 Nov 2024 13:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731071847;
	bh=aTlcdGF4Imb5wPzEWaP+ifFhnpk6S1zRFb9Re4B9pNI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WngEN8pAwo0ecvflBVtVunkuvB1FY+gEmc4QVjM0bRfzpbrCXVJ/veBtQmeOcsqT7
	 SkiidZoWNjkoPUy+Zbcaba3HfK3W5q4W23OIfnvxFLPQ316BRKNQhaMr28gyD0dNSS
	 l4nelqULMEbrPfIh8v0OEIdwP2FRscpbsba+3eN0=
Date: Fri, 8 Nov 2024 14:17:23 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Cc: heikki.krogerus@linux.intel.com, tzungbi@kernel.org,
	linux-usb@vger.kernel.org, chrome-platform@lists.linux.dev,
	jthies@google.com, akuchynski@google.com, pmalani@chromium.org,
	dmitry.baryshkov@linaro.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/7] usb: typec: Check port is active before enter
 mode on probe
Message-ID: <2024110849-bonded-flatten-5f5e@gregkh>
References: <20241107193021.2690050-1-abhishekpandit@chromium.org>
 <20241107112955.v3.3.I439cffc7bf76d94f5850eb85980f1197c4f9154c@changeid>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241107112955.v3.3.I439cffc7bf76d94f5850eb85980f1197c4f9154c@changeid>

On Thu, Nov 07, 2024 at 11:29:56AM -0800, Abhishek Pandit-Subedi wrote:
> Enforce the same requirement as when we attempt to activate altmode via
> sysfs (do not enter partner mode if port mode is not active). In order
> to set a default value for this field, also introduce the inactive field
> in struct typec_altmode_desc.
> 
> Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> ---
> 
> Changes in v3:
> - Use port.active instead of introducing auto-enter field
> - Introduce inactive field to typec_altmode_desc to set default value
>   for active.
> - Always make port 'active' field writable
> 
>  drivers/usb/typec/altmodes/displayport.c | 7 +++++--
>  drivers/usb/typec/altmodes/thunderbolt.c | 6 +++++-
>  drivers/usb/typec/class.c                | 5 +++--
>  include/linux/usb/typec.h                | 2 ++
>  4 files changed, 15 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/usb/typec/altmodes/displayport.c b/drivers/usb/typec/altmodes/displayport.c
> index 3245e03d59e6..f4116e96f6a1 100644
> --- a/drivers/usb/typec/altmodes/displayport.c
> +++ b/drivers/usb/typec/altmodes/displayport.c
> @@ -767,8 +767,11 @@ int dp_altmode_probe(struct typec_altmode *alt)
>  	if (plug)
>  		typec_altmode_set_drvdata(plug, dp);
>  
> -	dp->state = plug ? DP_STATE_ENTER_PRIME : DP_STATE_ENTER;
> -	schedule_work(&dp->work);
> +	/* Only attempt to enter altmode if port is active. */
> +	if (port->active) {
> +		dp->state = plug ? DP_STATE_ENTER_PRIME : DP_STATE_ENTER;
> +		schedule_work(&dp->work);
> +	}

What prevents active from changing right after you checked it?

> @@ -150,6 +151,7 @@ struct typec_altmode_desc {
>  	u32			vdo;
>  	/* Only used with ports */
>  	enum typec_port_data	roles;
> +	bool			inactive : 1;

A boolean bitfield?  That's not needed, please just do this properly.

thanks,

greg k-h

