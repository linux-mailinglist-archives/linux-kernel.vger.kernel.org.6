Return-Path: <linux-kernel+bounces-267063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D01E9940BEF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 10:42:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79E151F2573E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 08:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD75C192B99;
	Tue, 30 Jul 2024 08:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aPVRmtEL"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AFF4156C4B;
	Tue, 30 Jul 2024 08:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722328892; cv=none; b=nhyRuP+OJ0RnMeg9+5RQBW4Iqrij13n/rcnNSy81LHqKcrxrUDoKD36yta+wvszJ6gzxcC6DTYywG+F8zWBNqo1V7aErRQ2yCPwa3gjZj2fHiy0WBfhmZEHRHf1ws0OXLhB88jjvV2niby4mh5zQvPT2lk0kArhHgXdUXz8l5YI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722328892; c=relaxed/simple;
	bh=EZwgfB+SpCkB8yyda/21W0llO92QMrqgQrAHgsYlxs0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KxS4p0cP7WxokzLKT1ZM4vuO4evU0PDoFlpqjaeXEpT9qFjyAzmaLfjQQBZegAIO/2QR2jbjL4XZHHN6+4ZLHYfejOhVTdwCqJ5KRHExmB4K+WNlg+JtKwJwk7ucNx0fe6xH45TqX4Yke1WEXc4Sujh5HHcRK6kYN/DF8YQjVlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aPVRmtEL; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722328891; x=1753864891;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EZwgfB+SpCkB8yyda/21W0llO92QMrqgQrAHgsYlxs0=;
  b=aPVRmtELCqIU2W5cXZT8cmKLTWEP8WfpiCBFsohbCmev72zofAlTlz0v
   5AGA7LyxB/AOkYJmKD/Y4v88YFQXL+ZgkagqYKfgvADC014irp1+kJSjo
   8ekDcXIj2c2PGiLMGHOTl1PZ1iEXBdVnD7voIVyf9PiZ0QTy4yni4gAr9
   ozzNEzto4JTVFWdHTaXZiZ3GD9zMxvBbw6nReeKn/Iz6qIjB4iJk4y8ML
   qtEUx51Z111PBMiCGa+VjLkEpbNm5K4R59j7lpEV4ZQ2cnnZmmlroQ4Nk
   7qvC6+dTQEIBUQ4fvQVkzEOPG1MIbG29VJVVtIRvBhcsvJ1wQ0TxevgeW
   Q==;
X-CSE-ConnectionGUID: a7+ZgAnGQEKYsZqhmu63Mg==
X-CSE-MsgGUID: Ru+odA0bQCmdLUwGniZevw==
X-IronPort-AV: E=McAfee;i="6700,10204,11148"; a="20281403"
X-IronPort-AV: E=Sophos;i="6.09,248,1716274800"; 
   d="scan'208";a="20281403"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2024 01:41:30 -0700
X-CSE-ConnectionGUID: h2tVqVDOR9iTiL029BFXEg==
X-CSE-MsgGUID: ujmr2l5qSue4aV5FuoG2lQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,248,1716274800"; 
   d="scan'208";a="53932617"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmviesa006.fm.intel.com with SMTP; 30 Jul 2024 01:41:26 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 30 Jul 2024 11:41:25 +0300
Date: Tue, 30 Jul 2024 11:41:25 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Marco Felsch <m.felsch@pengutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	RD Babiera <rdbabiera@google.com>,
	Guenter Roeck <linux@roeck-us.net>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] usb: typec: tcpci: Fix error code in
 tcpci_check_std_output_cap()
Message-ID: <ZqinNYgseXFj3l7g@kuha.fi.intel.com>
References: <b0880888-6719-4614-91fc-8ee63b71d304@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b0880888-6719-4614-91fc-8ee63b71d304@stanley.mountain>

On Fri, Jul 12, 2024 at 09:05:50AM -0500, Dan Carpenter wrote:
> The tcpci_check_std_output_cap() function is supposed to return negative
> error codes but it's declared as type bool so the error handling doesn't
> work.  Declare it as an int instead.
> 
> Fixes: 62ce9ef14797 ("usb: typec: tcpci: add support to set connector orientation")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/tcpm/tcpci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpci.c b/drivers/usb/typec/tcpm/tcpci.c
> index 8a18d561b063..b5e49af48f43 100644
> --- a/drivers/usb/typec/tcpm/tcpci.c
> +++ b/drivers/usb/typec/tcpm/tcpci.c
> @@ -67,7 +67,7 @@ static int tcpci_write16(struct tcpci *tcpci, unsigned int reg, u16 val)
>  	return regmap_raw_write(tcpci->regmap, reg, &val, sizeof(u16));
>  }
>  
> -static bool tcpci_check_std_output_cap(struct regmap *regmap, u8 mask)
> +static int tcpci_check_std_output_cap(struct regmap *regmap, u8 mask)
>  {
>  	unsigned int reg;
>  	int ret;
> -- 
> 2.43.0

-- 
heikki

