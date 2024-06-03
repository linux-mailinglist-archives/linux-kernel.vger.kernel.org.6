Return-Path: <linux-kernel+bounces-198962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC6348D7FBF
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 12:10:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E5BB1F21254
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 10:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79490824AB;
	Mon,  3 Jun 2024 10:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gjQRRJRM"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C39D81735;
	Mon,  3 Jun 2024 10:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717409404; cv=none; b=Jprnb4mYFzxGcsOEHOATVdoNaASPDEZb3tIrr5UU1uZznnFLVRIyP3IZ2c8pWYFZo244/A7C5gqCsT1OudLLwWnCgw/FueoaXF6rSNxrJEyZluSmhfMWVgZwqX2k5SsfFF+26/aSMuEFcFjelP/mYYg7qERWDqOOya/uGk0uC28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717409404; c=relaxed/simple;
	bh=LkYwNLsQN08KA07aWVeaexXqORXA0nPpRiIBfLn5iMI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U4HQPKgV06+iqayyi14Mvm6+2HLVvHbuS6twNYsPHJ5KLc9YTHkmrKN4zez7Sgy2PdhNttfae1Oqe3uLkRAgtmP5AuWi7b4Z9SAIcOL1/R1Pf6vny92i0EcbU3bWDBOGlgWgtXHJcHqmTmgheDnuSfGxnwnAuBnBkfNXvu84sfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gjQRRJRM; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717409402; x=1748945402;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LkYwNLsQN08KA07aWVeaexXqORXA0nPpRiIBfLn5iMI=;
  b=gjQRRJRMwtAdrN+uOB4TCRuZIUDXvz93iUNEkHPwt40wGtZB8rMceuEE
   91/ztzPnhMeaFBgD277ZbFDjsT2DipKzvmqUYYFGM5cAsetkODGV8SnEU
   eU7YP/z18Y3Kvh90/Gif3aaJw+r4gvUCEXAYNvObRJDtuB5Zr98c5jCq+
   6Fp2fO7gn47Kx7mhppA5a8PUg6zt4sa24ux52Lo0pIBg2Vc3MANKP9/jQ
   MnZZ/QIDEZogtP0JyqeMey7VC7+dDWCbyBZB6ViGzMjSgxapJ8i6yca0m
   fsX1yWl+Fsg8JBsh8+irLBJGLrI+oAMuJmg0WNd4hep1drkILBW+uNhJz
   Q==;
X-CSE-ConnectionGUID: AXiKss46TqW5pVlNApj0dg==
X-CSE-MsgGUID: FLcs+WHdTzCKF5c01bMjMw==
X-IronPort-AV: E=McAfee;i="6600,9927,11091"; a="13643358"
X-IronPort-AV: E=Sophos;i="6.08,211,1712646000"; 
   d="scan'208";a="13643358"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2024 03:10:01 -0700
X-CSE-ConnectionGUID: C+srMFuLQUWFU9oKCIwsiA==
X-CSE-MsgGUID: UZXocqB+RRSE0wKkuLywYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,211,1712646000"; 
   d="scan'208";a="68000287"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmviesa001.fm.intel.com with SMTP; 03 Jun 2024 03:09:58 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 03 Jun 2024 13:09:56 +0300
Date: Mon, 3 Jun 2024 13:09:56 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Diogo Ivo <diogo.ivo@tecnico.ulisboa.pt>
Cc: gregkh@linuxfoundation.org, dmitry.baryshkov@linaro.org,
	jthies@google.com, bleung@chromium.org, abhishekpandit@chromium.org,
	saranya.gopal@intel.com, lk@c--e.de, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, pmalani@chromium.org
Subject: Re: [PATCH 1/2] usb: typec: ucsi: Add new capability bits
Message-ID: <Zl2WdKqjQXVyQ6O9@kuha.fi.intel.com>
References: <20240524105837.15342-1-diogo.ivo@tecnico.ulisboa.pt>
 <20240524105837.15342-2-diogo.ivo@tecnico.ulisboa.pt>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240524105837.15342-2-diogo.ivo@tecnico.ulisboa.pt>

On Fri, May 24, 2024 at 11:58:20AM +0100, Diogo Ivo wrote:
> Newer UCSI versions defined additional optional capability bits. Add
> their definitions.
> 
> Signed-off-by: Diogo Ivo <diogo.ivo@tecnico.ulisboa.pt>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/ucsi/ucsi.h | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/ucsi/ucsi.h b/drivers/usb/typec/ucsi/ucsi.h
> index e70cf5b15562..ca4a879d9606 100644
> --- a/drivers/usb/typec/ucsi/ucsi.h
> +++ b/drivers/usb/typec/ucsi/ucsi.h
> @@ -225,7 +225,13 @@ struct ucsi_capability {
>  #define UCSI_CAP_CABLE_DETAILS			BIT(5)
>  #define UCSI_CAP_EXT_SUPPLY_NOTIFICATIONS	BIT(6)
>  #define UCSI_CAP_PD_RESET			BIT(7)
> -#define UCSI_CAP_GET_PD_MESSAGE		BIT(8)
> +#define UCSI_CAP_GET_PD_MESSAGE			BIT(8)
> +#define UCSI_CAP_GET_ATTENTION_VDO		BIT(9)
> +#define UCSI_CAP_FW_UPDATE_REQUEST		BIT(10)
> +#define UCSI_CAP_NEGOTIATED_PWR_LEVEL_CHANGE	BIT(11)
> +#define UCSI_CAP_SECURITY_REQUEST		BIT(12)
> +#define UCSI_CAP_SET_RETIMER_MODE		BIT(13)
> +#define UCSI_CAP_CHUNKING_SUPPORT		BIT(14)
>  	u8 reserved_1;
>  	u8 num_alt_modes;
>  	u8 reserved_2;
> -- 
> 2.45.1

-- 
heikki

