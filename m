Return-Path: <linux-kernel+bounces-433062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B6A69E5381
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 12:17:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3F771882785
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 11:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBBB41E04AC;
	Thu,  5 Dec 2024 11:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NKp/33pe"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1A5B1B0F1F;
	Thu,  5 Dec 2024 11:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733397428; cv=none; b=l84BZ7qYumLXg/vZjB5ZT8RMzhdzLXVYX8EkIB+gV4Jp6lKDA4uH938Alvsc/4IaLlWi4iCpImiTi3evtE21GIV0ajaWTcgZkoXGeDcDXtw3kLj+pcO5iq/TsCCPGw8Vs+gRTsRupBM4rjebP8Bm0gHEgr15nAJuSrZ6XUIMs8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733397428; c=relaxed/simple;
	bh=d584/xl9AYR4vwbG7zJc0aQcYRMgCPGFJqqxiWY0nH4=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=iWvJ2i7pBY6KmOCBwap0uAo83eCkLm74WOSwWyt1fZOtSuosSI72lNwYVCxF23BML+XvpebhXr3OiPhFULi5MVAW7nOQdLCha9YiWgOKXRZmSlmNFxRqFst1lSRax5am7y24E6KkIogAmybVDJLM3FV7UY83DCNQJsC5AB5cBwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NKp/33pe; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733397427; x=1764933427;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=d584/xl9AYR4vwbG7zJc0aQcYRMgCPGFJqqxiWY0nH4=;
  b=NKp/33pepo6mUHpDDyR3JHHDQK3Bl8bSNkDULU3aFZ1pfjnkH4EBmwcs
   z2kOi6RuV/htEX9baxoRHHM37KnXcoJQQajSUwx85M3/JvgkK9DrkAnne
   /bzqckb5nK8krd2w11aSNbewf+9qo9iHIMjKjUeIJiJn7dT000l5vouLN
   IOiMfyoiOiU0KPAftvsgTvPhPALzDACbfCDRKNlBwyiD6Lflrd5oLv6cY
   Klc6dVbRyQx7ma7hOg13L9fE6D+BDTRL3z9BYJ/At+kOmnYoxzrszJmTe
   mxkHAJqRBoF1Lt9p2VmY3z+g3BCLEQRXoJERrm/BBux16jzKx1TBaIjae
   Q==;
X-CSE-ConnectionGUID: mNywlZT3QTGifFFBvH770g==
X-CSE-MsgGUID: OYSgjnYhSue6hfzWlpVy/Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11276"; a="33947621"
X-IronPort-AV: E=Sophos;i="6.12,210,1728975600"; 
   d="scan'208";a="33947621"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2024 03:17:06 -0800
X-CSE-ConnectionGUID: +50Dqw76ShivmJ+0SE/2DA==
X-CSE-MsgGUID: 3jJx0oX3T/K4+vQtVygfSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,210,1728975600"; 
   d="scan'208";a="124882991"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.60])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2024 03:17:02 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 5 Dec 2024 13:16:59 +0200 (EET)
To: Kurt Borja <kuurtb@gmail.com>
cc: Dell.Client.Kernel@dell.com, Hans de Goede <hdegoede@redhat.com>, 
    LKML <linux-kernel@vger.kernel.org>, mario.limonciello@amd.com, 
    platform-driver-x86@vger.kernel.org, w_armin@gmx.de
Subject: Re: [RFC PATCH 19/21] platform-x86: Rename alienare-wmi
In-Reply-To: <20241205004709.2186969-2-kuurtb@gmail.com>
Message-ID: <41ea44ee-fa2d-5e06-1080-5bb61fee1352@linux.intel.com>
References: <20241205002733.2183537-3-kuurtb@gmail.com> <20241205004709.2186969-2-kuurtb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 4 Dec 2024, Kurt Borja wrote:

> In order to eventually split the module:
> 
> Rename alienware-wmi.c -> alienware-wmi-base.c
> 
> And modify MAINTAINERS accordingly.
> 
> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
> ---
>  MAINTAINERS                                                    | 3 ++-
>  drivers/platform/x86/dell/Makefile                             | 1 +
>  .../x86/dell/{alienware-wmi.c => alienware-wmi-base.c}         | 0
>  3 files changed, 3 insertions(+), 1 deletion(-)
>  rename drivers/platform/x86/dell/{alienware-wmi.c => alienware-wmi-base.c} (100%)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3809931b9240..a4d02074dd91 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -787,7 +787,8 @@ ALIENWARE WMI DRIVER
>  L:	Dell.Client.Kernel@dell.com
>  S:	Maintained
>  F:	Documentation/wmi/devices/alienware-wmi.rst
> -F:	drivers/platform/x86/dell/alienware-wmi.c
> +F:	drivers/platform/x86/dell/alienware-wmi-*
> +F:	drivers/platform/x86/dell/alienware-wmi.*

Why not F: drivers/platform/x86/dell/alienware-wmi*

?

>  ALLEGRO DVT VIDEO IP CORE DRIVER
>  M:	Michael Tretter <m.tretter@pengutronix.de>
> diff --git a/drivers/platform/x86/dell/Makefile b/drivers/platform/x86/dell/Makefile
> index 79d60f1bf4c1..5e7496aeb070 100644
> --- a/drivers/platform/x86/dell/Makefile
> +++ b/drivers/platform/x86/dell/Makefile
> @@ -5,6 +5,7 @@
>  #
>  
>  obj-$(CONFIG_ALIENWARE_WMI)		+= alienware-wmi.o
> +alienware-wmi-objs			:= alienware-wmi-base.o
>  obj-$(CONFIG_DCDBAS)			+= dcdbas.o
>  obj-$(CONFIG_DELL_LAPTOP)		+= dell-laptop.o
>  obj-$(CONFIG_DELL_RBTN)			+= dell-rbtn.o
> diff --git a/drivers/platform/x86/dell/alienware-wmi.c b/drivers/platform/x86/dell/alienware-wmi-base.c
> similarity index 100%
> rename from drivers/platform/x86/dell/alienware-wmi.c
> rename to drivers/platform/x86/dell/alienware-wmi-base.c
> 

-- 
 i.


