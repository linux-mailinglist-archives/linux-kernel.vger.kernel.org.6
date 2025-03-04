Return-Path: <linux-kernel+bounces-544656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40730A4E3B6
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 16:38:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0164421106
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 15:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2E16279329;
	Tue,  4 Mar 2025 15:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IN/UPaUY"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C307C278159;
	Tue,  4 Mar 2025 15:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741101562; cv=none; b=bofdyCPD0YPp30ch3iVAvyfVyteT7IolEfSazbzLJCavmcdmoI0fEBrN3vawmV3xCr4Hu/lpSI2iiUiNQ1F+x5wBPBIF8AAOdb32eETI3DlRfn18JcmgCmC0jXEXz44FD33JmNf7FUGXlFuFDzQWY+xy1f1GlyyXPU4JqwsGY5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741101562; c=relaxed/simple;
	bh=lre90AnL7K2m8QxfZ6Y+Tr0nGqAW9WbAY9JOO24u/Gs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sJTyDNfbS4E76AXFQ7iXhRvtN2v27lgURIWFNrUfwgiAROqEq3cIlSBXi7VEnzLl2OOvoLx0104lW76WlsMStZUtdhhC49jFy4KW8nlM1vRdcT2ku1VAT3KNJ1TqYteEb1LXnCB9/1JNPr8zCWo3RHyWcPuc7OoeLUzUtwuG/wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IN/UPaUY; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741101561; x=1772637561;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lre90AnL7K2m8QxfZ6Y+Tr0nGqAW9WbAY9JOO24u/Gs=;
  b=IN/UPaUYaUDw40SYkb16FxZ7KyDilgz3tDtuS/6IOxYN8QtNoKO2+FP4
   xz29dSznDGFnKOJCkXhpE1CxF+onHJzwFes2QUoDGZNMT2w6RQLqm8IXJ
   50MaB4FvkLBhVDU5vKOTv/bpHIFp8TwNNyiaAZ6Eq8CBeFSulTY1DN6NJ
   7bs/K90+R+ksJn3etCyJ3jR/NBscKScNK2Sm95zLiRRRIk/VdB5fUPqiB
   Qdnc2tbwdE8Q+qYuDRD3S4nH7M3MOnNgCMs0RkEb6tUrGZHSVikLipmWp
   q2pfZYsukReksyQbdlI0OuEe0vrrvx3gyVAoCDweywsdgYSiZwHeZQ1BE
   Q==;
X-CSE-ConnectionGUID: QrQDCbHXQr+yNcbzr/DfpQ==
X-CSE-MsgGUID: GZxi49U9QUicaVwE5zfkGg==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="41272804"
X-IronPort-AV: E=Sophos;i="6.14,220,1736841600"; 
   d="scan'208";a="41272804"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 07:19:20 -0800
X-CSE-ConnectionGUID: v8COlOEGQ5q1KpcqCFxI/A==
X-CSE-MsgGUID: 1pNMc42eQwq0dGLWUZKgHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,220,1736841600"; 
   d="scan'208";a="123525059"
Received: from kuha.fi.intel.com ([10.237.72.152])
  by fmviesa004.fm.intel.com with SMTP; 04 Mar 2025 07:19:17 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 04 Mar 2025 17:19:16 +0200
Date: Tue, 4 Mar 2025 17:19:16 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Andrei Kuchynski <akuchynski@chromium.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Benson Leung <bleung@chromium.org>,
	"Christian A. Ehrhardt" <lk@c--e.de>,
	Jameson Thies <jthies@google.com>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] usb: typec: ucsi: Fix NULL pointer access
Message-ID: <Z8cZ9O-qZnV5btpx@kuha.fi.intel.com>
References: <20250301081057.1952519-1-akuchynski@chromium.org>
 <20250301081057.1952519-2-akuchynski@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250301081057.1952519-2-akuchynski@chromium.org>

On Sat, Mar 01, 2025 at 08:10:56AM +0000, Andrei Kuchynski wrote:
> Resources should be released only after all threads that utilize them
> have been destroyed.
> This commit ensures that resources are not released prematurely by waiting
> for the associated workqueue to complete before deallocating them.
> 
> Signed-off-by: Andrei Kuchynski <akuchynski@chromium.org>

This needs to be marked as a fix. Please add the appropriate Fixes
tag and Cc stable.

thanks,

> ---
>  drivers/usb/typec/ucsi/ucsi.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
> index fcf499cc9458..43b4f8207bb3 100644
> --- a/drivers/usb/typec/ucsi/ucsi.c
> +++ b/drivers/usb/typec/ucsi/ucsi.c
> @@ -1825,11 +1825,11 @@ static int ucsi_init(struct ucsi *ucsi)
>  
>  err_unregister:
>  	for (con = connector; con->port; con++) {
> +		if (con->wq)
> +			destroy_workqueue(con->wq);
>  		ucsi_unregister_partner(con);
>  		ucsi_unregister_altmodes(con, UCSI_RECIPIENT_CON);
>  		ucsi_unregister_port_psy(con);
> -		if (con->wq)
> -			destroy_workqueue(con->wq);
>  
>  		usb_power_delivery_unregister_capabilities(con->port_sink_caps);
>  		con->port_sink_caps = NULL;
> @@ -2013,10 +2013,6 @@ void ucsi_unregister(struct ucsi *ucsi)
>  
>  	for (i = 0; i < ucsi->cap.num_connectors; i++) {
>  		cancel_work_sync(&ucsi->connector[i].work);
> -		ucsi_unregister_partner(&ucsi->connector[i]);
> -		ucsi_unregister_altmodes(&ucsi->connector[i],
> -					 UCSI_RECIPIENT_CON);
> -		ucsi_unregister_port_psy(&ucsi->connector[i]);
>  
>  		if (ucsi->connector[i].wq) {
>  			struct ucsi_work *uwork;
> @@ -2032,6 +2028,11 @@ void ucsi_unregister(struct ucsi *ucsi)
>  			destroy_workqueue(ucsi->connector[i].wq);
>  		}
>  
> +		ucsi_unregister_partner(&ucsi->connector[i]);
> +		ucsi_unregister_altmodes(&ucsi->connector[i],
> +					 UCSI_RECIPIENT_CON);
> +		ucsi_unregister_port_psy(&ucsi->connector[i]);
> +
>  		usb_power_delivery_unregister_capabilities(ucsi->connector[i].port_sink_caps);
>  		ucsi->connector[i].port_sink_caps = NULL;
>  		usb_power_delivery_unregister_capabilities(ucsi->connector[i].port_source_caps);
> -- 
> 2.48.1.711.g2feabab25a-goog

-- 
heikki

