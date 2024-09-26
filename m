Return-Path: <linux-kernel+bounces-340606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F7849875C4
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 16:39:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8DA71F22361
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 14:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D29A37A13A;
	Thu, 26 Sep 2024 14:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TNvo4CQ4"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05A35258
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 14:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727361571; cv=none; b=UTL8wFPUZKiyGqB2UXq+85nVTsqNsyJt9s3MOrHQFfYQCD3BcGHN/qwdCbOslNttDEUnxbSHKAn/5CYfA1nYeDLZyL02ojRMJnhtBf/eHSsidWpdKpmEq502u/Rp3+6YVM2vZ90WZWc5zproxzMXoyCXgMFNOdQV7hWcynWg59I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727361571; c=relaxed/simple;
	bh=k1NzGdqi/1CdRfu06i6s5EEkUq1fDdKCX8ueCHY7wxY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PSADpbZz1lA061ONxy4k2QdqQNVUKkDoWXIFmnrszgh4SVK915y0AbmT+eRgajcgq1oznScKFy4X/UKkEeFuVf3bLm06fCcGoJMjohjRhfIoNEeNv5AGbkWKYCUu+CYBgiBZHJSyGZ2x7GS9K5Q89xPteDjqtwNdcOse5otyH3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TNvo4CQ4; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727361570; x=1758897570;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=k1NzGdqi/1CdRfu06i6s5EEkUq1fDdKCX8ueCHY7wxY=;
  b=TNvo4CQ4RvOjkysp1QXxLaQxg3TAHIa7c86DNxS1/lBcp8ycVYu7ot7V
   iwdoNR1FJNeOeWleY2tNQefn+Fr5aNQmAZVnBxtOamyeztboohLk/8eCJ
   rUdwZzjHZp+DZx8AsxlAIKvyMC1l9xItDh4u9SkSKn2fMS1H9+FJ+uh0r
   5bq2napPjNPCbo63cZ3nFokLSvWy/HpMta6zMeXo9FhQ2rvR/Wc1OQM4S
   gcSg7nQcSSK86STpybjjQyT3cbbjymTdCchaPRgmYsd0BJ6m5th+cjs+9
   fMrFVRBaWrMyvEjIM5On0Ut3l89HNDOxqw9Pb8rQYOK4kBtd49v15E5oS
   w==;
X-CSE-ConnectionGUID: 2OadwWXWQNCwj0LRWp4NDA==
X-CSE-MsgGUID: /zaqqz/ASCaCYuOvtOTh+A==
X-IronPort-AV: E=McAfee;i="6700,10204,11207"; a="26641730"
X-IronPort-AV: E=Sophos;i="6.11,155,1725346800"; 
   d="scan'208";a="26641730"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2024 07:39:29 -0700
X-CSE-ConnectionGUID: lMnTIVepT+eFDDxu6UbKfw==
X-CSE-MsgGUID: cJO6Hum0TkuMxq5JTcV5xg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,155,1725346800"; 
   d="scan'208";a="102993567"
Received: from kuha.fi.intel.com ([10.237.72.152])
  by fmviesa001.fm.intel.com with SMTP; 26 Sep 2024 07:39:26 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 26 Sep 2024 17:39:24 +0300
Date: Thu, 26 Sep 2024 17:39:24 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Cc: tzungbi@kernel.org, jthies@google.com, pmalani@chromium.org,
	akuchynski@google.com, Benson Leung <bleung@chromium.org>,
	Guenter Roeck <groeck@chromium.org>,
	chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/8] platform/chrome: cros_ec_typec: Displayport support
Message-ID: <ZvVyHD-QVQm5W6uy@kuha.fi.intel.com>
References: <20240925162513.435177-1-abhishekpandit@chromium.org>
 <20240925092505.6.I142fc0c09df58689b98f0cebf1c5e48b9d4fa800@changeid>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240925092505.6.I142fc0c09df58689b98f0cebf1c5e48b9d4fa800@changeid>

> diff --git a/drivers/platform/chrome/cros_typec_altmode.h b/drivers/platform/chrome/cros_typec_altmode.h
> new file mode 100644
> index 000000000000..a8b37a18c83a
> --- /dev/null
> +++ b/drivers/platform/chrome/cros_typec_altmode.h
> @@ -0,0 +1,34 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +
> +#ifndef __CROS_TYPEC_ALTMODE_H__
> +#define __CROS_TYPEC_ALTMODE_H__
> +
> +struct cros_typec_port;
> +struct typec_altmode;
> +struct typec_altmode_desc;
> +struct typec_displayport_data;
> +
> +#if IS_ENABLED(CONFIG_TYPEC_DP_ALTMODE)
> +struct typec_altmode *
> +cros_typec_register_displayport(struct cros_typec_port *port,
> +				struct typec_altmode_desc *desc,
> +				bool ap_mode_entry);
> +
> +int cros_typec_displayport_status_update(struct typec_altmode *altmode,
> +					 struct typec_displayport_data *data);
> +#else
> +struct typec_altmode *

static inline struct typec_altmode *

> +cros_typec_register_displayport(struct cros_typec_port *port,
> +				struct typec_altmode_desc *desc,
> +				bool ap_mode_entry)
> +{
> +	return typec_port_register_altmode(port->port, desc);
> +}
> +
> +int cros_typec_displayport_status_update(struct typec_altmode *altmode,
> +					 struct typec_displayport_data *data)

static inline int

> +{
> +	return 0;
> +}
> +#endif
> +#endif /* __CROS_TYPEC_ALTMODE_H__ */

thanks,

-- 
heikki

