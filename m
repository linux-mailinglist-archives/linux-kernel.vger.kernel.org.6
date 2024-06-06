Return-Path: <linux-kernel+bounces-204020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90A1C8FE302
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 11:36:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 406B11F26FF6
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 09:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BCE615383A;
	Thu,  6 Jun 2024 09:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S/l8QgMo"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F9713FD93;
	Thu,  6 Jun 2024 09:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717666520; cv=none; b=WARrBCQmIxQcWMufFBDvJCNSHmcXYQyqEsVNEznZQhSLWMCLW4SqtydbifmmHEINzOb/x+LYLn6sxO2jJsYdWzrl24oYVkZX8aGrWZc0kZVM6EKiVwGnFtwr4ebPRHpa3tCO9p7pbNrhActPOb2WMIAVJyWoCyjMsHsM7ZpIZ0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717666520; c=relaxed/simple;
	bh=lSnVyFfsh3dBWQOr8ak0lsCs/qYXVWWWArFcx9m3wjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=roaC+phudKxLEFZgXuz0Zekpm/vwJnr67a038KjRyLob95sbxfI63G4xa48fW0GeUCKiIX/oIGeOrIuI3JXL3dRzY5u7eJvR8mLkFbQaK0krVN1QyoYHJhAb0jFOLKgznKLI1OwSEpxV+W8Gev9hR2XS7KfTiypKuTdiMVX+E0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S/l8QgMo; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717666519; x=1749202519;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lSnVyFfsh3dBWQOr8ak0lsCs/qYXVWWWArFcx9m3wjQ=;
  b=S/l8QgMoTLsUA40XdOwAUtA5SEdaQ0RdO7odu7o1soWgg74pz4WhhZV0
   A6nevV6JJzgMlzsVoLBDhEWZP+KjaoOL0bm87BUygqCvhogtb3CKmXGoy
   PqSHGUN88C43UylNKeYxlnb/vfRx6vCW51ULb8HCcFDffEXn+YuBAfLk0
   0sf9ELt45tEPdSzw1TIB/237EKT/IyqGn7HstXmIIXa79Ry+7GVfO6/Ni
   uF+XaraEocs6laHZx9DpjKkef81AVqHnLg9xhNE0NFknf7xfI3ZqP9DcA
   kkdZE0RJ73EMtzepnoXJ6Wrrm3tkpchG+zg46F+4hImeRQ5Sk12ZlekOD
   Q==;
X-CSE-ConnectionGUID: U/lujlU9Q5GCSHu6BzYVPw==
X-CSE-MsgGUID: fOTIIMXrQKOwyptqj8OksA==
X-IronPort-AV: E=McAfee;i="6600,9927,11094"; a="24976825"
X-IronPort-AV: E=Sophos;i="6.08,218,1712646000"; 
   d="scan'208";a="24976825"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2024 02:35:18 -0700
X-CSE-ConnectionGUID: 6Q885TLKTBSEtSsgDAqeIA==
X-CSE-MsgGUID: J8llops4SY+XlB2zYjha6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,218,1712646000"; 
   d="scan'208";a="75375036"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by orviesa001.jf.intel.com with SMTP; 06 Jun 2024 02:35:15 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 06 Jun 2024 12:35:14 +0300
Date: Thu, 6 Jun 2024 12:35:14 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Javier Carrasco <javier.carrasco@wolfvision.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] usb: typec: tipd: add error log to provide firmware
 name and size
Message-ID: <ZmGC0roOLn3hIo9A@kuha.fi.intel.com>
References: <20240606-tps6598x_fw_update_log-v1-0-2b5b8369a0ba@wolfvision.net>
 <20240606-tps6598x_fw_update_log-v1-2-2b5b8369a0ba@wolfvision.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240606-tps6598x_fw_update_log-v1-2-2b5b8369a0ba@wolfvision.net>

On Thu, Jun 06, 2024 at 11:03:56AM +0200, Javier Carrasco wrote:
> The current error logs do not show the firmware name and size for the
> tps6598x. On the other hand, this information is provided for the
> tps25750. Both implementations have access to that information, and the
> existing message for the tps25750 can be used for the tps6598x without
> extra modifications.
> 
> Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/tipd/core.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
> index 851b0d02727a..58f6eeffd070 100644
> --- a/drivers/usb/typec/tipd/core.c
> +++ b/drivers/usb/typec/tipd/core.c
> @@ -1195,6 +1195,10 @@ static int tps6598x_apply_patch(struct tps6598x *tps)
>  
>  release_fw:
>  	release_firmware(fw);
> +	if (ret) {
> +		dev_err(tps->dev, "Failed to write patch %s of %zu bytes\n",
> +			firmware_name, fw->size);
> +	}
>  
>  	return ret;
>  };
> 
> -- 
> 2.40.1

-- 
heikki

