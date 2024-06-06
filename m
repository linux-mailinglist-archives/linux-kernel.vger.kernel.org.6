Return-Path: <linux-kernel+bounces-204021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0BB58FE358
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 11:47:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15B81B296F4
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 09:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2715315278C;
	Thu,  6 Jun 2024 09:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SmkWgd4t"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07EA9152190;
	Thu,  6 Jun 2024 09:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717666537; cv=none; b=jHx9V63+Pba1RbTC69fQXe2EeWa7GU3nP0BIvPM7JjCorj7nnHxBP5SISoLMe9YSmee2IY3j5PpbZ9wFBnFmCGnFqRIq0oXr7vjY9bUUSt90cSJVgC4nr4IHIVO0Me9br4WkofN42sq+gewMbrjYb3ZULFw+ZBpiXH6e9p9scLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717666537; c=relaxed/simple;
	bh=qNdgbtVZBhbRhwqW0g7Ha+IeNh5sfHj6cg5lKD8twg4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RQUctozUoc2Aq4eaVtfcG2EVknoO5vARR8sHKVi+KJKhSoTJMTSSrrnr76tr9BEVlzYJZdQSn0AQzA/jzszb/IRk+OfyQfDQ4PeHEH+laY9SPCbIb+P3ktcPWuzFWXZDn3B8wjUzkrlXXBXQi6pQbFTHhKYaWAcXo+lFGsyAafk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SmkWgd4t; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717666536; x=1749202536;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qNdgbtVZBhbRhwqW0g7Ha+IeNh5sfHj6cg5lKD8twg4=;
  b=SmkWgd4t5VL+XZXvB2aCL6Pam7iobeMRocwJf72Xz5s/hEM2HTPV+Vzg
   TrMwxryEM9gQhb+1f2k89rjzV5Al3531c4WFokZzgNlie9J2n1i6lWanI
   gjZvjiisCsgft92QesbFgyMBiy50Nh47nscYVXRvYm/UX4bTAQdQUSl3U
   jdWzvM8QFRJ5netP+Gx19ySxrAsdjUEmIl2JpLoQcnOa1Yg4Jz18vfXDC
   N2QcvQnMcBxrSaWusNa/22UThM4FIsQtS1O+WPGiANtrWg6ncO28QSOg8
   SvF/d2wFVqH1ivOf4coH+7ZfPiK51Ejtx2gIGKBSwOBie/p5zhwn26cZf
   g==;
X-CSE-ConnectionGUID: hSWJnq7aQVWn6yn86nm2IA==
X-CSE-MsgGUID: V/G4l8pzSMW/8Qbmvr0q3Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11094"; a="24954363"
X-IronPort-AV: E=Sophos;i="6.08,218,1712646000"; 
   d="scan'208";a="24954363"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2024 02:35:35 -0700
X-CSE-ConnectionGUID: 2tRr+0PoSqK9jW5C7fhb0A==
X-CSE-MsgGUID: zjSkyaT7Rzin2gbzg57M9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,218,1712646000"; 
   d="scan'208";a="42844311"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by orviesa003.jf.intel.com with SMTP; 06 Jun 2024 02:35:33 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 06 Jun 2024 12:35:32 +0300
Date: Thu, 6 Jun 2024 12:35:32 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Javier Carrasco <javier.carrasco@wolfvision.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	Julia Lawall <julia.lawall@inria.fr>
Subject: Re: [PATCH 3/3] usb: typec: tipd: use min() to set tps6598x firmware
 packet size
Message-ID: <ZmGC5MGJEGh32Vrp@kuha.fi.intel.com>
References: <20240606-tps6598x_fw_update_log-v1-0-2b5b8369a0ba@wolfvision.net>
 <20240606-tps6598x_fw_update_log-v1-3-2b5b8369a0ba@wolfvision.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240606-tps6598x_fw_update_log-v1-3-2b5b8369a0ba@wolfvision.net>

On Thu, Jun 06, 2024 at 11:03:57AM +0200, Javier Carrasco wrote:
> Simplify the current firmware packet size check in the tps6598x
> implementation by means of a single call to min(), which is what the
> current code does in a more verbose, less elegant way.
> 
> This patch fixes a cocci warning ("WARNING opportunity for min()").
> 
> Suggested-by: Julia Lawall <julia.lawall@inria.fr>
> Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/tipd/core.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
> index 58f6eeffd070..ea768b19a7f1 100644
> --- a/drivers/usb/typec/tipd/core.c
> +++ b/drivers/usb/typec/tipd/core.c
> @@ -1165,10 +1165,7 @@ static int tps6598x_apply_patch(struct tps6598x *tps)
>  
>  	bytes_left = fw->size;
>  	while (bytes_left) {
> -		if (bytes_left < TPS_MAX_LEN)
> -			in_len = bytes_left;
> -		else
> -			in_len = TPS_MAX_LEN;
> +		in_len = min(bytes_left, TPS_MAX_LEN);
>  		ret = tps6598x_exec_cmd(tps, "PTCd", in_len,
>  					fw->data + copied_bytes,
>  					TPS_PTCD_OUT_BYTES, out);
> 
> -- 
> 2.40.1

-- 
heikki

