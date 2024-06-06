Return-Path: <linux-kernel+bounces-203716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DE288FDF69
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 09:20:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5D412858D9
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 07:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67B4913B5B9;
	Thu,  6 Jun 2024 07:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BJUx2KUE"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D939E33F7;
	Thu,  6 Jun 2024 07:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717658394; cv=none; b=O4QM7kGNi8FKZtgUIRP01vf1kNJhb0/AglWHS+6qgMOq9zJE0o0MvsZaLnEY5SFFrU2Jp1vRqDg9oEKVjPu58XXAhn92dU3qOwhrp/TO+N/zcMBmU/5SAp/9VL3kyyO0/EoQPjwjxUjaZQxBzvHarABaUmekYjnAny0gtjSAHCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717658394; c=relaxed/simple;
	bh=a7uPeHNSogsl6puPap/Zhg4IvhvtmmxpELsNKC9X/44=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rCAAwSpfj2HlulloiYcSWPh7N+deMWhpS+7wW1QH009f9Y36Ekh1gu0pbuzuiRXmdT/Msi/dbBUPBgjtDixfNwW7JplfkR8YVZV1n0CkWBH15iKgBfVz3bW8t1yZb+ZavwiyzxeX87UsuvnJv/xo0YRSR8mu/iV8y4jLcFx0X50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BJUx2KUE; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717658393; x=1749194393;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=a7uPeHNSogsl6puPap/Zhg4IvhvtmmxpELsNKC9X/44=;
  b=BJUx2KUErrq7EIUQ6LY8sv1RrwXqudYkZ4T7eiJwfkCaLRH75ysNs+5x
   z2p3W12KPKzsk8TRxxiXTX9m6F2X3/aWW2/VG8QDbMQaGaA2Yc5m5Gb2r
   gdn2V2jSUPpYfIo6q/uqqxk6xI360xp1RbBS+9H/PI74S7awMAxZgD2WH
   Navvbq9sauQ0m/8Wjypr4nXvdBHX99KXEdANv5ZM3HGpEpkGfqR6ORlBa
   Fu/3D3GmubqwURFV+x0z7r6RWZjeTZwQz7NeG1fS8olIaUscs1Sx9vzkK
   taeDU64hAZ+hWtYzaQBfgQG+KYsYgFQbUPnB931akhTmYIhxQfG9tFN47
   w==;
X-CSE-ConnectionGUID: MfFqqUTcRPykuDbGIvuPgg==
X-CSE-MsgGUID: PG0k22ftTiu2QZKZXo6UHw==
X-IronPort-AV: E=McAfee;i="6600,9927,11094"; a="24876846"
X-IronPort-AV: E=Sophos;i="6.08,218,1712646000"; 
   d="scan'208";a="24876846"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2024 00:19:53 -0700
X-CSE-ConnectionGUID: YYSkyvbXQnyCJ4XflenCyQ==
X-CSE-MsgGUID: MC1QJTQzSpCCHGVZYVlwJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,218,1712646000"; 
   d="scan'208";a="38420693"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by orviesa008.jf.intel.com with SMTP; 06 Jun 2024 00:19:50 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 06 Jun 2024 10:19:49 +0300
Date: Thu, 6 Jun 2024 10:19:49 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org
Subject: Re: [PATCH 1/1] usb: typec: tcpm: use 'time_left' variable with
 wait_for_completion_timeout()
Message-ID: <ZmFjFSzZwE8Z97yZ@kuha.fi.intel.com>
References: <20240604212730.4968-2-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240604212730.4968-2-wsa+renesas@sang-engineering.com>

On Tue, Jun 04, 2024 at 11:27:31PM +0200, Wolfram Sang wrote:
> There is a confusing pattern in the kernel to use a variable named 'timeout' to
> store the result of wait_for_completion_timeout() causing patterns like:
> 
> 	timeout = wait_for_completion_timeout(...)
> 	if (!timeout) return -ETIMEDOUT;
> 
> with all kinds of permutations. Use 'time_left' as a variable to make the code
> self explaining.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/tcpm/tcpm.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index 8a1af08f71b6..e46148c19be3 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -943,7 +943,7 @@ static int tcpm_pd_transmit(struct tcpm_port *port,
>  			    enum tcpm_transmit_type tx_sop_type,
>  			    const struct pd_message *msg)
>  {
> -	unsigned long timeout;
> +	unsigned long time_left;
>  	int ret;
>  	unsigned int negotiated_rev;
>  
> @@ -968,10 +968,10 @@ static int tcpm_pd_transmit(struct tcpm_port *port,
>  		return ret;
>  
>  	mutex_unlock(&port->lock);
> -	timeout = wait_for_completion_timeout(&port->tx_complete,
> -				msecs_to_jiffies(PD_T_TCPC_TX_TIMEOUT));
> +	time_left = wait_for_completion_timeout(&port->tx_complete,
> +						msecs_to_jiffies(PD_T_TCPC_TX_TIMEOUT));
>  	mutex_lock(&port->lock);
> -	if (!timeout)
> +	if (!time_left)
>  		return -ETIMEDOUT;
>  
>  	switch (port->tx_status) {
> -- 
> 2.43.0

-- 
heikki

