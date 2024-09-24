Return-Path: <linux-kernel+bounces-337171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B4FF984641
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 14:55:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC39EB2265A
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 12:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 408921A727D;
	Tue, 24 Sep 2024 12:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FHL+nuXA"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4BE81A7040;
	Tue, 24 Sep 2024 12:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727182521; cv=none; b=Bdk733oam8AU1RU/p0/EvAyLb8X2WWwT04EM8hgEzkLCp+XEMUPxkwzAO3gssJRtRppqnaQ8JWPswO5pfv/owIWqNWZrIafm691qiNkvjTHcjc3J7jFnKQFUgRDpT1//SYktbHi5MSYRtLRL+ZuT+RTUzMA8aOde5eGUy1AVDg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727182521; c=relaxed/simple;
	bh=njvhLKdbbtTckJAQzn4DS7FhQomuThTjVs0QIZxc6e4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YUjodqyJN48wLmmfKrHzXVD02p6OBY/VcJU7l46PvL7IZD0blYpPLv0jcS7GRsOBP5BoOHuv4I0sRg5QFClQYs/9UFZhnQsfjyUDcratI8k0rcEMdIiteOojKDlvji4rAOqFY4aFMWFl2rZGQ5OxdYUoMG9hAxAIKva4biFm8RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FHL+nuXA; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727182520; x=1758718520;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=njvhLKdbbtTckJAQzn4DS7FhQomuThTjVs0QIZxc6e4=;
  b=FHL+nuXAplpWjmvx00Sp5krWDD9gmVvLWHjhCXTG/ITIA3tKGCABvN2F
   UBLpNA9WUb0JfJcgI91uy4ak3l7rIwK/dp/pmJ8YauIwvbKgVwH1xFaqo
   TjsMsNUKe89xqGRtVi9IanLkH/Phjfi73Wwe3xi8Hvy4f4l5ZyrPcwqsX
   yJZzGywsGe4dzTjC7SAtHP8HXYs4mnNT372vXDxfr/6HN50f6b/OY3h4S
   rzWa3gIEjmfZThXhBNn71sYsbNwgYs+Aso+eaLIJzgTB7FA9Jihc4Wmml
   +yhYmtLCEVwyqpPG8rUHtPRuewti6snrb9OT+EN68yht5n2pRyHL+urqa
   A==;
X-CSE-ConnectionGUID: txZEva12S3+6Dl4+k54UBw==
X-CSE-MsgGUID: hvGCwMWlReuk+H0jAfxAEw==
X-IronPort-AV: E=McAfee;i="6700,10204,11204"; a="25648945"
X-IronPort-AV: E=Sophos;i="6.10,254,1719903600"; 
   d="scan'208";a="25648945"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2024 05:55:19 -0700
X-CSE-ConnectionGUID: xCH/sMlwRCe3tALHwzHhfQ==
X-CSE-MsgGUID: LN/PMizTTSOz9xRJQRf78Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,254,1719903600"; 
   d="scan'208";a="94748292"
Received: from kuha.fi.intel.com ([10.237.72.152])
  by fmviesa002.fm.intel.com with SMTP; 24 Sep 2024 05:55:16 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 24 Sep 2024 15:55:14 +0300
Date: Tue, 24 Sep 2024 15:55:14 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Amit Sunil Dhamne <amitsd@google.com>
Cc: gregkh@linuxfoundation.org, robh@kernel.org,
	dmitry.baryshkov@linaro.org, badhri@google.com, kyletso@google.com,
	rdbabiera@google.com, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [RFC v3 2/2] usb: typec: tcpm: Add support for parsing time dt
 properties
Message-ID: <ZvK2slBHR8PhzaMt@kuha.fi.intel.com>
References: <20240923224059.3674414-1-amitsd@google.com>
 <20240923224059.3674414-3-amitsd@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240923224059.3674414-3-amitsd@google.com>

Hi,

> @@ -7611,10 +7650,13 @@ struct tcpm_port *tcpm_register_port(struct device *dev, struct tcpc_dev *tcpc)
>  	err = tcpm_fw_get_caps(port, tcpc->fwnode);
>  	if (err < 0)
>  		goto out_destroy_wq;
> +


This extra newline is not relevant or necessary. Otherwise this LGTM:

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

>  	err = tcpm_fw_get_snk_vdos(port, tcpc->fwnode);
>  	if (err < 0)
>  		goto out_destroy_wq;
>  
> +	tcpm_fw_get_timings(port, tcpc->fwnode);
> +
>  	port->try_role = port->typec_caps.prefer_role;
>  
>  	port->typec_caps.revision = 0x0120;	/* Type-C spec release 1.2 */

thanks,

-- 
heikki

