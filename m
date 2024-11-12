Return-Path: <linux-kernel+bounces-405793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96C659C5704
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 12:52:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B685280A0A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 11:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 118EA1CD1F5;
	Tue, 12 Nov 2024 11:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iE5MbN0N"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4EBD1BCA11;
	Tue, 12 Nov 2024 11:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731412306; cv=none; b=Bh+q2ohESEFYTVyCHZSxaefol2gbyiLOL6rBK0YEOrezBaBZwI+0DGqY6Q9+qZsWrfTQYU5Do2U3w7UaJAwre+qzWi566QpCcAgRyhbbzqhlYSxkRRS6qWX43+JccK1XapWWUmI4p6hXeA6awjRLNN6w4BqkDrNzMZq73d+i8vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731412306; c=relaxed/simple;
	bh=IDSB+0NIZbf11fpgWGAanQLivWHIwGk+LTEmDiC46GQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N02LH9p7/3oaR7zpHab9SpAzw5jWAqeZ5uaLDEovzvG2VVG1qcBymjhdq5p4lkRNW11+JoMoHPM3fK5D5Do0w0pTJo6THj5/2h84XBIjfWqO8UfsPBgX30l6o1GVQ7P6CXuDVR43Yfo1EynKABCmFmpzbeJ4UystNl90VdSSBxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iE5MbN0N; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731412304; x=1762948304;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IDSB+0NIZbf11fpgWGAanQLivWHIwGk+LTEmDiC46GQ=;
  b=iE5MbN0NpUque0HCqJlL4wD4UAbP1ILCwQ3pYUCvhw4Jk+LKModqP+at
   qkIkqx7X1GEfEFus6SomOP+72LjcvgaRqpr8YMwdrYGRoo4+uNbl4fb+C
   QkfvmDcLLwP0DXsLvUkzeN+Ob/wZzZSNvvq2Q/sAtYIdtBn2628+sB206
   Q6h57AmPrQWTlpFESak5VX6ACsmEwhVK7/14+mRs2NfjCvh6VutnA/77c
   fjHf5pMfrWEEp8gW1ZJeaeGO1qE+8mMWujNlotjLiATlCoz+lF+Ho3M5P
   PmdotqKH8pMM15egpv2hkWJDPPL2IRHx8cuJE7uvZUBRKdT4UhAd+FMDv
   Q==;
X-CSE-ConnectionGUID: dkEPb0/TT9KegDGW3GwRWg==
X-CSE-MsgGUID: pzanGsajQwm+dwdouTChHw==
X-IronPort-AV: E=McAfee;i="6700,10204,11253"; a="48752980"
X-IronPort-AV: E=Sophos;i="6.12,147,1728975600"; 
   d="scan'208";a="48752980"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2024 03:51:43 -0800
X-CSE-ConnectionGUID: mdq+nGRcQum9P7XzQZawtQ==
X-CSE-MsgGUID: UqsmfTzNT/6N6P1an5K7tw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,147,1728975600"; 
   d="scan'208";a="92196326"
Received: from kuha.fi.intel.com ([10.237.72.152])
  by fmviesa004.fm.intel.com with SMTP; 12 Nov 2024 03:51:40 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 12 Nov 2024 13:51:39 +0200
Date: Tue, 12 Nov 2024 13:51:39 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Ajay Gupta <ajayg@nvidia.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	Haotien Hsu <haotienh@nvidia.com>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] usb: typec: fix potential array underflow in
 ucsi_ccg_sync_control()
Message-ID: <ZzNBS4M9c0tjSmX1@kuha.fi.intel.com>
References: <c69ef0b3-61b0-4dde-98dd-97b97f81d912@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c69ef0b3-61b0-4dde-98dd-97b97f81d912@stanley.mountain>

On Mon, Nov 11, 2024 at 02:08:06PM +0300, Dan Carpenter wrote:
> The "command" variable can be controlled by the user via debugfs.  The
> worry is that if con_index is zero then "&uc->ucsi->connector[con_index
> - 1]" would be an array underflow.
> 
> Fixes: 170a6726d0e2 ("usb: typec: ucsi: add support for separate DP altmode devices")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/ucsi/ucsi_ccg.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/usb/typec/ucsi/ucsi_ccg.c b/drivers/usb/typec/ucsi/ucsi_ccg.c
> index bccfc03b5986..fcb8e61136cf 100644
> --- a/drivers/usb/typec/ucsi/ucsi_ccg.c
> +++ b/drivers/usb/typec/ucsi/ucsi_ccg.c
> @@ -644,6 +644,10 @@ static int ucsi_ccg_sync_control(struct ucsi *ucsi, u64 command)
>  	    uc->has_multiple_dp) {
>  		con_index = (uc->last_cmd_sent >> 16) &
>  			UCSI_CMD_CONNECTOR_MASK;
> +		if (con_index == 0) {
> +			ret = -EINVAL;
> +			goto unlock;
> +		}
>  		con = &uc->ucsi->connector[con_index - 1];
>  		ucsi_ccg_update_set_new_cam_cmd(uc, con, &command);
>  	}
> @@ -651,6 +655,7 @@ static int ucsi_ccg_sync_control(struct ucsi *ucsi, u64 command)
>  	ret = ucsi_sync_control_common(ucsi, command);
>  
>  	pm_runtime_put_sync(uc->dev);
> +unlock:
>  	mutex_unlock(&uc->lock);
>  
>  	return ret;
> -- 
> 2.45.2

-- 
heikki

