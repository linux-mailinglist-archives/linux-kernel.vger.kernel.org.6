Return-Path: <linux-kernel+bounces-198992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF6C28D8033
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 12:39:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58E641F25A91
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 10:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2CB0839F7;
	Mon,  3 Jun 2024 10:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ns9sCVlM"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C039A44C6F;
	Mon,  3 Jun 2024 10:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717411159; cv=none; b=AwQFInYj1i3mdft6PcWlo07sg9lZP26hlRjOwa0jgrbQRYnr+BAXY8K+6kt5n/azcvs9yc7nSwGgf7JObz+ulCd/hoMSjSWgiyLMYMgPzViw0yjo1tD39ya6vJyTloBQrfqy8KRNPqxEb3mIzCzkrG61JGMnJatLZSnjKrTyFjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717411159; c=relaxed/simple;
	bh=LsQIxux0yIEjtM+jF28If+cX7L+PAWrkoIva3RasVRo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RBgWXGfWSDv007vUNb4JyLoy8WjPZZWqqT3f0PBXHs+AjsWKTEEZ8EE/bhvAjxXVCGCjLQl+5CJBuuAc8lekz5CL6BXf+5ETuN9bW4pRss8l5eW0G3re5Xg2FXK+S53SfO1fPREA4whIq27U3WE3eRqOuQrXzDGtvOLFCss0/qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ns9sCVlM; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717411157; x=1748947157;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LsQIxux0yIEjtM+jF28If+cX7L+PAWrkoIva3RasVRo=;
  b=ns9sCVlMIRFK5q/W++0fTwNOmGZoQpv6WSLvqt71Hr1TM0xMm5MMKlQX
   REptz4zilMmQZl/W91HUhTAoSOoRNFwcKET61UGskuckxsPbq9qZXD42k
   fbfSxstZ3+ZmTVVhmgbhPCIwPsuXSVU5TOYl+V3dbBTiip/x74HLhBH2y
   3y23biCUVJUq14GfycdXhCGHYcVMbdWegO3pGXIZSgjli3HJ+8VKWQ5gq
   CO0QGxqSNf+iPOaIzAeMhPmXwHH5cl10S72amEP2XLihrJgmhBxM5SGml
   Kxa72CiKKpjN9FH5glRIpiSAKFjrhwe+97NXK6af0R6kQ1BtxsKcXjsLX
   A==;
X-CSE-ConnectionGUID: bVmBCtSQRpWk5LzqyoJvsQ==
X-CSE-MsgGUID: q7KZEnYoSS2ESv2lj4nOag==
X-IronPort-AV: E=McAfee;i="6600,9927,11091"; a="31428227"
X-IronPort-AV: E=Sophos;i="6.08,211,1712646000"; 
   d="scan'208";a="31428227"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2024 03:39:17 -0700
X-CSE-ConnectionGUID: EIe+vuouSka48loB5kkzpg==
X-CSE-MsgGUID: BOlo80DSTsCqyFH/NF4P4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,211,1712646000"; 
   d="scan'208";a="36764262"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by orviesa010.jf.intel.com with SMTP; 03 Jun 2024 03:39:14 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 03 Jun 2024 13:39:13 +0300
Date: Mon, 3 Jun 2024 13:39:13 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Johan Hovold <johan+linaro@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Abel Vesa <abel.vesa@linaro.org>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: typec: ucsi: glink: increase max ports for x1e80100
Message-ID: <Zl2dUQ/QzHauiBH/@kuha.fi.intel.com>
References: <20240603100007.10236-1-johan+linaro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240603100007.10236-1-johan+linaro@kernel.org>

On Mon, Jun 03, 2024 at 12:00:07PM +0200, Johan Hovold wrote:
> The new X Elite (x1e80100) platform has three ports so increase the
> maximum so that all ports can be registered.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/ucsi/ucsi_glink.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/ucsi/ucsi_glink.c b/drivers/usb/typec/ucsi/ucsi_glink.c
> index f7546bb488c3..985a880e86da 100644
> --- a/drivers/usb/typec/ucsi/ucsi_glink.c
> +++ b/drivers/usb/typec/ucsi/ucsi_glink.c
> @@ -14,7 +14,7 @@
>  #include <linux/soc/qcom/pmic_glink.h>
>  #include "ucsi.h"
>  
> -#define PMIC_GLINK_MAX_PORTS	2
> +#define PMIC_GLINK_MAX_PORTS		3
>  
>  #define UCSI_BUF_SIZE                   48
>  
> -- 
> 2.44.1

-- 
heikki

