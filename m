Return-Path: <linux-kernel+bounces-267067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C218940C03
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 10:43:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 156D7B25DA4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 08:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D282319415D;
	Tue, 30 Jul 2024 08:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xd+0EVbm"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B99A21940B3;
	Tue, 30 Jul 2024 08:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722328953; cv=none; b=frvxCqqeKuD6DiCzh1N+R23lSYhp3GLH3svseHkbHJT7a6IsKpeTxUJtXBo4vYPoRrrcGEJak6V5UuMMPYcAGVycU+HZzkoxyFQSqF8eEk/OdYoEgzTLwUu9cYPZFIejsAQsSX2eCPUDuOHyRPlw3O9TxVX8ziuKUEq3PJe7hiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722328953; c=relaxed/simple;
	bh=S3lYo6i1o0iWuCG4zRP5rCqJ/YiBUltiRpqwP1mBLGY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FgHZM28SCuksP6LUcn8YHx9gZz1+aazNr1ujQs2DFZK3JCUkp1UMgpBJI57Qcr8gcqjMnAu0ho5Yjz7AiRni4H09v038RmnftaU5ymFQhztxrkT60NgBfBU0rJAybJvM6j5ffxToRuYT5mlvJfbmCbBELo9wUDOikHvhTXxU3DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xd+0EVbm; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722328952; x=1753864952;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=S3lYo6i1o0iWuCG4zRP5rCqJ/YiBUltiRpqwP1mBLGY=;
  b=Xd+0EVbm0xlRQRewIdJiyaXfTOcHklU6onHilhUKuS8CFKjteb0l0vlU
   BgwFTu89OuGanaK+rLsBq5yLvrIaKiZP1/YaCet44rjF6hW7yIY4Yqi4j
   72ml3IrtXSA5XQhJyF9qMy9L9xJlSjs4KGS/kbf1AYGsrqlLEPG28W4Ww
   OZpqLjIIBGXUlZ9jJRwQrD8oi/83rEilCXclSHFDS8te5fKH5aqytXqKF
   /dFIgFPiVvmvdZ1EldzyepJocoayw/vJq40bbEjvKCKMMjI23yySt/m0C
   FSKODwt1oNaow2Lim3XkTfRhAsyDd2McrXofaFL8rGZWPkhxx2TMnsUGY
   g==;
X-CSE-ConnectionGUID: Qludt/8qTBGcfJxcVUczvQ==
X-CSE-MsgGUID: QUv/LdnKRTG/8zhxYYDtSw==
X-IronPort-AV: E=McAfee;i="6700,10204,11148"; a="31278624"
X-IronPort-AV: E=Sophos;i="6.09,248,1716274800"; 
   d="scan'208";a="31278624"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2024 01:42:30 -0700
X-CSE-ConnectionGUID: tAv+SritSPCuGh/gMgm3Pw==
X-CSE-MsgGUID: OjgD0Xo/RP+VnVnC6u35kw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,248,1716274800"; 
   d="scan'208";a="53970398"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmviesa007.fm.intel.com with SMTP; 30 Jul 2024 01:42:26 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 30 Jul 2024 11:42:25 +0300
Date: Tue, 30 Jul 2024 11:42:25 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Chen Ni <nichen@iscas.ac.cn>
Cc: gregkh@linuxfoundation.org, dmitry.baryshkov@linaro.org,
	neil.armstrong@linaro.org, johan+linaro@kernel.org,
	quic_kriskura@quicinc.com, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: typec: ucsi: glink: Remove unnecessary semicolon
Message-ID: <ZqincQ7co9/Zll4P@kuha.fi.intel.com>
References: <20240715073947.4028319-1-nichen@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240715073947.4028319-1-nichen@iscas.ac.cn>

On Mon, Jul 15, 2024 at 03:39:47PM +0800, Chen Ni wrote:
> Remove unnecessary semicolon at the end of the switch statement.
> This is detected by coccinelle.
> 
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/ucsi/ucsi_glink.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/ucsi/ucsi_glink.c b/drivers/usb/typec/ucsi/ucsi_glink.c
> index 16c328497e0b..459a5af02910 100644
> --- a/drivers/usb/typec/ucsi/ucsi_glink.c
> +++ b/drivers/usb/typec/ucsi/ucsi_glink.c
> @@ -263,7 +263,7 @@ static void pmic_glink_ucsi_callback(const void *data, size_t len, void *priv)
>  	case UC_UCSI_USBC_NOTIFY_IND:
>  		schedule_work(&ucsi->notify_work);
>  		break;
> -	};
> +	}
>  }
>  
>  static void pmic_glink_ucsi_pdr_notify(void *priv, int state)
> -- 
> 2.25.1

-- 
heikki

