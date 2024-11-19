Return-Path: <linux-kernel+bounces-414578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD93B9D2A3A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 16:54:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8777F1F2406A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 15:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57FCE1CFEB0;
	Tue, 19 Nov 2024 15:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c6X80phY"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E951CF2BD;
	Tue, 19 Nov 2024 15:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732031642; cv=none; b=nmjKgEx2/6GgG3RjzXbS989pe6VnnVcyBum20e2xcY+5prPd0RL1elofSiYHco2+F/SJl6oftEAZWZ/q3NjfC980O9ZRMZJCg5iDiQyUOczNIxezrf+VR12T2t660lDAmxh2PJ2faKFxnF1FWIy2yCMxmN3FNq7TFIbw+j8WsDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732031642; c=relaxed/simple;
	bh=oerxtD3nEVi4XTue4l49odCUQx6jpGjoapzMXc667oY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ciVRuwuEOUs6sLS56UhxGUZF8QJudn5KtWy9TrklzKGJdEsj1BVKi2KpC2RFSV+klRl2q3XSGUIH2KOyG01fNj1wNZ1R593wWUqJh2+WkwcjbBPHkZAGEEJb2C+91YiDZke14JbHkLnhbmupm7tmDxWPCOB4ujxrF89UeZ2JAAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c6X80phY; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732031640; x=1763567640;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oerxtD3nEVi4XTue4l49odCUQx6jpGjoapzMXc667oY=;
  b=c6X80phYHuQND484BhLxMWzBv1dHeca9zVXxPEg6BYD2AkQL4leVABMu
   a6ISKjtEotloxaqjtYlh6g9Lzqw8yy98WAgtQ2/6G9OXk5yBOGuA8cQ9w
   Is3MMvvSaA4qLvu+kUMe7MPsIHIOdHO0e1XWbt3z/EhJKrwVmgo0D+Jgd
   G/L22PkG6Sj/2BdQsDyQCgKz/I7LH9sxSGEk35xeIYcktmpm+oKcxJ9Lj
   VkLu6YOgu2/VTJceaFBTGzjur1OnvO3x8BzwZLgr8jdKEeYLB7qvdsxfx
   Gxc9NdFZm98iKUXnnqzz44GUFHAJFvQfwHBzqYDKtv+v+sD+7V6n/Xc79
   g==;
X-CSE-ConnectionGUID: KmGTDzjRSAyvWMsr1KscYw==
X-CSE-MsgGUID: mpGTs0N1SvOGEGUUTxy6AQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11261"; a="31420434"
X-IronPort-AV: E=Sophos;i="6.12,166,1728975600"; 
   d="scan'208";a="31420434"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2024 07:53:59 -0800
X-CSE-ConnectionGUID: 2vowImP2Qoe5lB+Anw/K8Q==
X-CSE-MsgGUID: brq/mmlnTOm8eWaPpVdyzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,166,1728975600"; 
   d="scan'208";a="89535173"
Received: from kuha.fi.intel.com ([10.237.72.152])
  by orviesa010.jf.intel.com with SMTP; 19 Nov 2024 07:53:57 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 19 Nov 2024 17:53:55 +0200
Date: Tue, 19 Nov 2024 17:53:55 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 14/15] usb: typec: tcpci_mt6370: don't include
 'pm_wakeup.h' directly
Message-ID: <Zzy0kz54bW3Xe0Al@kuha.fi.intel.com>
References: <20241118072917.3853-1-wsa+renesas@sang-engineering.com>
 <20241118072917.3853-15-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241118072917.3853-15-wsa+renesas@sang-engineering.com>

On Mon, Nov 18, 2024 at 08:29:13AM +0100, Wolfram Sang wrote:
> The header clearly states that it does not want to be included directly,
> only via 'device.h'. 'platform_device.h' works equally well. Remove the
> direct inclusion.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/tcpm/tcpci_mt6370.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpci_mt6370.c b/drivers/usb/typec/tcpm/tcpci_mt6370.c
> index 9cda1005ef01..bc5fd2557e6f 100644
> --- a/drivers/usb/typec/tcpm/tcpci_mt6370.c
> +++ b/drivers/usb/typec/tcpm/tcpci_mt6370.c
> @@ -11,7 +11,6 @@
>  #include <linux/mod_devicetable.h>
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
> -#include <linux/pm_wakeup.h>
>  #include <linux/pm_wakeirq.h>
>  #include <linux/regmap.h>
>  #include <linux/regulator/consumer.h>
> -- 
> 2.39.2

-- 
heikki

