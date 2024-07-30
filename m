Return-Path: <linux-kernel+bounces-267079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A91EB940C1E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 10:46:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60B661F280F7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 08:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 713CB19414B;
	Tue, 30 Jul 2024 08:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FyatI8ki"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B5E919004F;
	Tue, 30 Jul 2024 08:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722329138; cv=none; b=GiqCJgFzxRqzKKmTFFIl+k5cF/bhbsst84FPkQ/TB4l3JlGMV1KZENdJRGpYYO0TQAKsI9EdPf5ZGR0SuDWJ9W9folLnyhTHHD2DBDpTKq6UOnct3/026xAFAc9yPycxxZL5bBDi+zVUzYisUorBWCQucM4DIHcj56iTPUtnMBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722329138; c=relaxed/simple;
	bh=WHad+mDxumP9em8jQVeZN24mJf2jPFydzRI+8dSImJU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=khdJn4jXrORY9stbriUSAt2pwh9GAmQhNceZ3h0rWh+nngl5B5iCPN5jrcTEFfjHuBZ5NwO04sFqbcLeTyx2L1VjI9g9SGIcuGcaqvGRMJz4WGlPHLDu7+4u9TphqncuEmAeMO3WPeZTXIIAACKM6FI0EbquGzH2bDIkV9jezj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FyatI8ki; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722329137; x=1753865137;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WHad+mDxumP9em8jQVeZN24mJf2jPFydzRI+8dSImJU=;
  b=FyatI8kiHrAPesrLLAIvsnA6HjNHXIclQuSVzfPteHPiJlDJ31bZe1HA
   YJIo/TYfgJzvjlQmT2Ce8DIW3rPEF0eW2Djihk1LeoeEt2p6jD2zxvDHg
   mzFpgnjaCSL3CqMhgIv7AxIJpK3O2N0x2b49RPM7/MTr2OBQCh/ZFpPvM
   Fb+WMGSWWQA1os2RYOmXWAOo/re5WCPAB9MBshchEFyEmbbMckubYdmoE
   BmUBHG1YbXtIFd+AAiFvDw6FfzC2RiEOWSn8Ks2uTOHdwutjfXO6FMUbr
   SoEv6Pz7X/av7m0BxhE1TmGLU+iUVi1jYPdhv0DII/EUd6+6ay2CeljUL
   w==;
X-CSE-ConnectionGUID: sbPqYcB+Qo6OwLUlIC6H3g==
X-CSE-MsgGUID: kNRAEAD/Qpy2ppS9WDMfqg==
X-IronPort-AV: E=McAfee;i="6700,10204,11148"; a="37604632"
X-IronPort-AV: E=Sophos;i="6.09,248,1716274800"; 
   d="scan'208";a="37604632"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2024 01:45:20 -0700
X-CSE-ConnectionGUID: DUu1G7nASkuk9NO+ibUlYQ==
X-CSE-MsgGUID: aveH8NlsT6KfrQlZv72GPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,248,1716274800"; 
   d="scan'208";a="54241839"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by orviesa009.jf.intel.com with SMTP; 30 Jul 2024 01:45:16 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 30 Jul 2024 11:45:15 +0300
Date: Tue, 30 Jul 2024 11:45:15 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Javier Carrasco <javier.carrasco@wolfvision.net>,
	Abdel Alkuor <abdelalkuor@geotab.com>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, dan.carpenter@linaro.org,
	kernel-janitors@vger.kernel.org, error27@gmail.com
Subject: Re: [PATCH 2/2] usb: typec: tipd: Delete extra semi-colon
Message-ID: <ZqioG3N9lcTxB6+7@kuha.fi.intel.com>
References: <20240724162356.992763-1-harshit.m.mogalapalli@oracle.com>
 <20240724162356.992763-2-harshit.m.mogalapalli@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240724162356.992763-2-harshit.m.mogalapalli@oracle.com>

On Wed, Jul 24, 2024 at 09:23:51AM -0700, Harshit Mogalapalli wrote:
> There shouldn't be a ; at the end of the function, delete it.
> 
> Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/tipd/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
> index eb5596e3406a..dd51a25480bf 100644
> --- a/drivers/usb/typec/tipd/core.c
> +++ b/drivers/usb/typec/tipd/core.c
> @@ -1198,7 +1198,7 @@ static int tps6598x_apply_patch(struct tps6598x *tps)
>  	release_firmware(fw);
>  
>  	return ret;
> -};
> +}
>  
>  static int cd321x_init(struct tps6598x *tps)
>  {
> -- 
> 2.45.2

-- 
heikki

