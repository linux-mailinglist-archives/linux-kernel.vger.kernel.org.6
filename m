Return-Path: <linux-kernel+bounces-433116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CD2B9E5406
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 12:33:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06F642812A3
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 11:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 314F4202C26;
	Thu,  5 Dec 2024 11:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NAq/J/Uw"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C40021DB52D;
	Thu,  5 Dec 2024 11:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733398375; cv=none; b=lYT2Pt6zfIAi+IMzBhVYZCw40iCS/F6y2rdbaftc+mkudSfrXPrFYPRtnDg8d4Bzk5K1+DWjv5Y9HFemudpZEE8O67XaLM2MXmhkVMXXB9zRC9fVlTMw4+XL9YPxB3B2UFsMXkLgBNgb73c4De+TGLZLE36ujgVwqs3IYvxEUMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733398375; c=relaxed/simple;
	bh=ctvOJ5uo9QztDCQyGLxE7wHVtDuBSxiQgaHt/qUMQCM=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=q6lSbBZgPx4LRPhtboB8CEtpn0vGF07t1dXg/wQbEgW82tiN+ECQ254Lyo8BZ1rTiSFeMrWMJLh9yF4R6Q7fzP0jcCR9Fvqh6h4jNO3dbY4UgTv7Vc0q2QmEDF3KYIriAT5FIHMp2DWLwMFjOuOGGXNiNjCSz9z9A6nbxvEtTDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NAq/J/Uw; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733398373; x=1764934373;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=ctvOJ5uo9QztDCQyGLxE7wHVtDuBSxiQgaHt/qUMQCM=;
  b=NAq/J/UwIwxU8Cukh6Y8J1edKnX9OqEkrRxhvOMye3bMFvnwGg/NRpfC
   dLf4dTW0xe3bLmLqwQc1GAjnsarcWYBlUcjvqwARHJLW0oNAjHHu+f7Tl
   MkrbhlZ9x483npgi7TceXNmtNIWy7yJR1587JkCniF6ts9WFfE9UGHkcu
   jNJDiMPVUHwKrvndoahLQDoxTpHsdW1J0hZ/Z04rPa7atUL0idg3Ji91i
   EiteqKEbuNQgPPvzq5WlFw8MbQp7cvqpnqmxaZlUbNe9MlbGpAhf2hEW5
   wuErvEE4sKBeOiQKTUKdLOevQmoyAsY4yko7rjRRVulxgCI56/dBVKtBC
   w==;
X-CSE-ConnectionGUID: R6pInUzbQNmoLdRe0QAccg==
X-CSE-MsgGUID: flJuW5UMSKC8icobnI8DeA==
X-IronPort-AV: E=McAfee;i="6700,10204,11276"; a="59109105"
X-IronPort-AV: E=Sophos;i="6.12,210,1728975600"; 
   d="scan'208";a="59109105"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2024 03:32:53 -0800
X-CSE-ConnectionGUID: kRsf8d8AT+CY9dmbIyOc+Q==
X-CSE-MsgGUID: oxRzv559RgqNjIVZJjwqgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,210,1728975600"; 
   d="scan'208";a="99147176"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.60])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2024 03:32:49 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 5 Dec 2024 13:32:46 +0200 (EET)
To: Kurt Borja <kuurtb@gmail.com>
cc: Dell.Client.Kernel@dell.com, Hans de Goede <hdegoede@redhat.com>, 
    LKML <linux-kernel@vger.kernel.org>, mario.limonciello@amd.com, 
    platform-driver-x86@vger.kernel.org, w_armin@gmx.de
Subject: Re: [RFC PATCH 16/21] alienware-wmi: Make running control state part
 of platdata
In-Reply-To: <20241205004534.2186539-2-kuurtb@gmail.com>
Message-ID: <d0828df1-4a46-2cd3-f15a-b08e5d011bba@linux.intel.com>
References: <20241205002733.2183537-3-kuurtb@gmail.com> <20241205004534.2186539-2-kuurtb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 4 Dec 2024, Kurt Borja wrote:

> Both WMI devices have a different "RUNNING" control state code. Make the
> WMI drivers decide which code to use, and refactor sysfs methods
> accordingly.
> 
> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
> ---
>  drivers/platform/x86/dell/alienware-wmi.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/platform/x86/dell/alienware-wmi.c b/drivers/platform/x86/dell/alienware-wmi.c
> index 25e0139ed78c..fa21a50d66bd 100644
> --- a/drivers/platform/x86/dell/alienware-wmi.c
> +++ b/drivers/platform/x86/dell/alienware-wmi.c
> @@ -431,6 +431,7 @@ struct alienfx_platdata {
>  	bool hdmi_mux;
>  	bool amplifier;
>  	bool deepslp;
> +	u8 running_code;
>  };
>  
>  static u8 interface;
> @@ -576,18 +577,18 @@ static ssize_t lighting_control_state_store(struct device *dev,
>  					    const char *buf, size_t count)
>  {
>  	struct alienfx_priv *priv;
> +	struct alienfx_platdata *pdata;
>  	u8 val;
>  
>  	priv = dev_get_drvdata(dev);
> +	pdata = dev_get_platdata(dev);
>  
>  	if (strcmp(buf, "booting\n") == 0)
>  		val = LEGACY_BOOTING;
>  	else if (strcmp(buf, "suspend\n") == 0)
>  		val = LEGACY_SUSPEND;
> -	else if (interface == LEGACY)
> -		val = LEGACY_RUNNING;
>  	else
> -		val = WMAX_RUNNING;
> +		val = pdata->running_code;
>  
>  	priv->lighting_control_state = val;
>  	pr_debug("alienware-wmi: updated control state to %d\n",
> @@ -1249,6 +1250,7 @@ static int legacy_wmi_probe(struct wmi_device *wdev, const void *context)
>  		.hdmi_mux = quirks->hdmi_mux,
>  		.amplifier = quirks->amplifier,
>  		.deepslp = quirks->deepslp,
> +		.running_code = LEGACY_RUNNING,
>  	};
>  
>  	if (quirks->num_zones > 0)
> @@ -1333,6 +1335,7 @@ static int wmax_wmi_probe(struct wmi_device *wdev, const void *context)
>  		.hdmi_mux = quirks->hdmi_mux,
>  		.amplifier = quirks->amplifier,
>  		.deepslp = quirks->deepslp,
> +		.running_code = WMAX_RUNNING,
>  	};
>  
>  	if (quirks->thermal)
> 

I've not taken extensive look at interdependent changes in the series but 
while reviewing patch 20/21 I noticed that alienfx_probe() changed there
from:

-       if (interface == WMAX)
-               priv->lighting_control_state = WMAX_RUNNING;
-       else if (interface == LEGACY)
-               priv->lighting_control_state = LEGACY_RUNNING;

to:

+       priv->lighting_control_state = pdata->running_code;

Somehow, it felt odd and then looking this patch 16, it felt even odder. 
Perhaps there's a good reason my review that didn't go deep enough failed 
to uncover but please check if this is an indication that something is a 
miss in the series.

-- 
 i.


