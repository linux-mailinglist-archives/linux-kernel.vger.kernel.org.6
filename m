Return-Path: <linux-kernel+bounces-308287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 488CB9659D3
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 10:15:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A06B1C2246B
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 08:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5613B16EB42;
	Fri, 30 Aug 2024 08:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jlmG2C8p"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732B416CD33;
	Fri, 30 Aug 2024 08:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725005655; cv=none; b=CtYYaFHiyzmUsMkmOsiKJT1hwESQsvQZUjvBCAsYGPRdPK4mJOGyg7RjDc3sbQmv2RYavX6pFxkRoaCXKuYuzM9/9MVePsakoUd6WB19EcNuii8j3/2wzBch6qh0+JuZ+dlIv9lcFjcnGJYO+bKffgZu8/MUwinuZH4ZY28rBFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725005655; c=relaxed/simple;
	bh=lGlK/huPst/Uj54bD7qm1iAGK0SCBjHujklkB/TCQhE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TcdO9/zWUJ+s1mhMGdmvPu5m3bBkv/1WmGVceOfcquhW0Af2m5bQj8Ex1xzMTZymGrb717rIoyaAaX+bgquBw3rtzwizrvSJL0Se6PBdg0imgKoG1NbuNdEp0hQhH3xKYGDl22hGgZKc9qPUT5wvL+xxRWDNw0xSKvJuUtzlAR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jlmG2C8p; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725005653; x=1756541653;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lGlK/huPst/Uj54bD7qm1iAGK0SCBjHujklkB/TCQhE=;
  b=jlmG2C8p1bbQq57HkNeyZCIWvD2K/RB/4rJzPBSW/3dEo2WhmxZeE8yf
   iHJogG8pWotQE25OGpzoWOtSyOhrE6JR9bIEYe5Ju8mzphTlZwsvdIeTZ
   CCE5GYdEl54vryBkkZUFrWDrO0LFJifT+/wO4TQ/LWn7+RohniTi1+vY6
   5RJJ87ytYFsDpW9mGkPfBYSdfvMegszmaoE9+wBWiZ18Lm4RMEQY4K1Nn
   wHAjytYoCJxIjpn6ScjmdtOPeZC13x1MJyuWWEMey34lGGpUi/1YWJlc8
   exWBKrbw9DcfQwIEF1hxCMF+OD7e3apm9ryOoN5uzs824xll5F0p3E2QI
   g==;
X-CSE-ConnectionGUID: r5jAXTRpQ1eI9+oECssKVw==
X-CSE-MsgGUID: rSB+q0lMT4moOHfx/fnTaw==
X-IronPort-AV: E=McAfee;i="6700,10204,11179"; a="26532991"
X-IronPort-AV: E=Sophos;i="6.10,188,1719903600"; 
   d="scan'208";a="26532991"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2024 01:12:59 -0700
X-CSE-ConnectionGUID: TsPEtp8iQj+FOhXnxY9XMw==
X-CSE-MsgGUID: wFox/84oTFKcyBEbHcGt7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,188,1719903600"; 
   d="scan'208";a="64567628"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by orviesa008.jf.intel.com with SMTP; 30 Aug 2024 01:12:54 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Fri, 30 Aug 2024 11:12:52 +0300
Date: Fri, 30 Aug 2024 11:12:52 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: "Christian A. Ehrhardt" <lk@c--e.de>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	Anurag Bijea <icaliberdev@gmail.com>,
	Christian Heusel <christian@heusel.eu>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Jameson Thies <jthies@google.com>,
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Subject: Re: [PATCH v2 1/2] usb: typec: ucsi: Enable ASUS zenbook quirk for
 VivoBooks
Message-ID: <ZtF/BJMls7kuD2dt@kuha.fi.intel.com>
References: <20240829100109.562429-1-lk@c--e.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829100109.562429-1-lk@c--e.de>

Hi, Christian,

Sorry, I did not look at this properly in v1.

On Thu, Aug 29, 2024 at 12:01:08PM +0200, Christian A. Ehrhardt wrote:
> The quirk for some ASUS zenbook models is required for
> ASUS VivoBooks. Apply the quirk to these as well.
> 
> This is part of the fix for the builtin keyboard on ASUS
> VivoBooks.

I think that explanation goes to patch 2/2 and vise versa.

> Reported-by: Anurag Bijea <icaliberdev@gmail.com>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219108
> Bisected-by: Christian Heusel <christian@heusel.eu>
> Fixes: de52aca4d9d5 ("usb: typec: ucsi: Never send a lone connector change ack")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christian A. Ehrhardt <lk@c--e.de>
> ---
>  drivers/usb/typec/ucsi/ucsi.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
> index 4039851551c1..540cb1d2822c 100644
> --- a/drivers/usb/typec/ucsi/ucsi.c
> +++ b/drivers/usb/typec/ucsi/ucsi.c
> @@ -38,6 +38,10 @@
>  
>  void ucsi_notify_common(struct ucsi *ucsi, u32 cci)
>  {
> +	/* Ignore bogus data in CCI if busy indicator is set. */
> +	if (cci & UCSI_CCI_BUSY)
> +		return;

This does not look correct. Doesn't this mean you'll timeout always if
BUSY is set?

Couldn't you just check the BUSY as the first action, and then clear
the other bits in CCI if it is set, if that is the problem?

Btw. Does 4f322657ade1 ("usb: typec: ucsi: Call CANCEL from single
location") affect the situation in any way?

thanks,

-- 
heikki

