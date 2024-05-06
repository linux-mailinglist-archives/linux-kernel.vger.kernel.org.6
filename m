Return-Path: <linux-kernel+bounces-169498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF5B08BC98E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 10:30:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 689C32827A3
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 08:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 397171419B3;
	Mon,  6 May 2024 08:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eE4jLLGP"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01C3140394;
	Mon,  6 May 2024 08:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714984204; cv=none; b=Woi1E3nGx4/yZJnttCJIRdZ2eC9oipTduaxaMqOe/Z0WbjZSofYZYwQ94XCJ1USHS84NQSEWYT73s+JSRNyxWrDR72VAgcWcEwsA4T7pkJ3YH7rWWOm9BzLYhzLpAs8bBHN5GKLSl65lKfl6yeXv/uDjqopYkec5bJHm0RH2mGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714984204; c=relaxed/simple;
	bh=zrbZIYIjFmgdhfsUba9NxX9M2jhKqKDPnqsG+oMRwkc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nokTBxQuXMlXhQD0xRmF6L9zyUR7G8iPa//1i3BHht1rFMQJiRStGZNj9fjst6kNtyq1cKw5QUtbCUEMFFnUvI7Bj8KhQuXD0Ioi3MmYDizW3JYcHs+EQWETrQ1PYjwmJGq8y5DvrBd+wmj4nHwr79qnmNtkZUrV2uVw1VLohhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eE4jLLGP; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714984203; x=1746520203;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zrbZIYIjFmgdhfsUba9NxX9M2jhKqKDPnqsG+oMRwkc=;
  b=eE4jLLGPYEq37bG91L/BAUfm7dlWs+uEp69GTZLXJVNKoT1sX9oaFFni
   qaC5cxM+6esmjHQA3KL1s+/rZQvdTRk4mJKivahphS+DnN/Y8ZIUqurdX
   fn5CzHvbIj2g3SroRKOJdTfHiVLuzCO8exqFISRUk3xR+qIkBt7i3YK2+
   C1dud2Qf5lykwX5wQUn3zJUxM0uL21UeWfCWAorGOaebfOrUbxDeAg9gp
   zdZGfXAjj5uNIeox9x6gmLtY6XmrSUXg1S6BJq2tPeRZCZn0HomTZYlk5
   XH2cdGixSW8F1jbA74Czdtp7nLlcNjmQ8IaW7GUawGfdaolQigrxJ3nwO
   Q==;
X-CSE-ConnectionGUID: s30eJvoTQhC8V2abl6+1BQ==
X-CSE-MsgGUID: f66cxqmKSfOIJBReRysnJg==
X-IronPort-AV: E=McAfee;i="6600,9927,11064"; a="21333923"
X-IronPort-AV: E=Sophos;i="6.07,257,1708416000"; 
   d="scan'208";a="21333923"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2024 01:30:02 -0700
X-CSE-ConnectionGUID: j1lGy3uJRieHkthvMxf4gw==
X-CSE-MsgGUID: CUcpglKaTaeLobxLesCHyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,257,1708416000"; 
   d="scan'208";a="28184894"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmviesa010.fm.intel.com with SMTP; 06 May 2024 01:30:00 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 06 May 2024 11:29:58 +0300
Date: Mon, 6 May 2024 11:29:58 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Javier Carrasco <javier.carrasco@wolfvision.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Abdel Alkuor <abdelalkuor@geotab.com>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] usb: typec: tipd: rely on i2c_get_match_data()
Message-ID: <ZjiVBkkdUAZ0B/vb@kuha.fi.intel.com>
References: <20240429-tps6598x_fix_event_handling-v3-0-4e8e58dce489@wolfvision.net>
 <20240429-tps6598x_fix_event_handling-v3-3-4e8e58dce489@wolfvision.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240429-tps6598x_fix_event_handling-v3-3-4e8e58dce489@wolfvision.net>

On Mon, Apr 29, 2024 at 03:35:59PM +0200, Javier Carrasco wrote:
> The first thing i2c_get_match_data() does is calling
> device_get_match_data(), which already checks if there is a fwnode.
> 
> Remove explicit usage of device_get_match_data() as it is already
> included in i2c_get_match_data().
> 
> Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/tipd/core.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
> index 191f86da283d..ad76dbd20e65 100644
> --- a/drivers/usb/typec/tipd/core.c
> +++ b/drivers/usb/typec/tipd/core.c
> @@ -1365,10 +1365,7 @@ static int tps6598x_probe(struct i2c_client *client)
>  			TPS_REG_INT_PLUG_EVENT;
>  	}
>  
> -	if (dev_fwnode(tps->dev))
> -		tps->data = device_get_match_data(tps->dev);
> -	else
> -		tps->data = i2c_get_match_data(client);
> +	tps->data = i2c_get_match_data(client);
>  	if (!tps->data)
>  		return -EINVAL;
>  
> 
> -- 
> 2.40.1

-- 
heikki

