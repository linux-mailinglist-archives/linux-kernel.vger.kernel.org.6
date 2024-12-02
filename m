Return-Path: <linux-kernel+bounces-428061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 833809E09A8
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 18:17:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49188281940
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 17:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E55551D86F1;
	Mon,  2 Dec 2024 17:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ze/d5fiL"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 979121D63CA;
	Mon,  2 Dec 2024 17:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733159844; cv=none; b=LAghDVZQkgMGTCsrSMw7ZY7BTbj7Npzi6V5OP9uTvqAuZMaFVFc0GzJq8SK9TS1u//zj3nX4nW4OzduDplLo3+is0s4dtRVk2rFfyOkMJ41p9VlZ+5iqS9hk/xKN97PcWTc2qORXM0vUDkr0W+yDpcX6F4C2D0HX9YoKISVjyEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733159844; c=relaxed/simple;
	bh=9NtXREONGUEuU2E1XL8NdCmvvxBZ6W2BkUCscjBvGlY=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Ib7u67AuBarFdk8ONoOeK6/942qeOJVQO61LGLK5EoxQQBJKR1Hqcij9pmlM9CH/9cvtoMQW8MWzyAPf+sBiK4EnFz6squSRoj9YbNKSNwK/U3UXGrrGfQUPdsQ2dJG6omD/kBa56jjzMRTL1dB/zKGjZza0BeoiphXxKvIYFLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ze/d5fiL; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733159843; x=1764695843;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=9NtXREONGUEuU2E1XL8NdCmvvxBZ6W2BkUCscjBvGlY=;
  b=Ze/d5fiLkiQlf9S4CfyJdY3j7pIzymdSAxTeiNgCD4xpm4BfyuGoW1CU
   a2Gzgztd/npYGT2cwrwvW8Pb+PyT+0jv92pxoE1UZgUGTwZD7i2KuZR80
   IF/zzi6wxE1ef++IVSM1zbCRjwTeKoSInCIeXy++qfyF7pFbkRTZGPqms
   ENJzQW6j8YnPT4DGn8iTQG06s16FNALFkIweOHDZxwYRLDVakZv1uvlK8
   OswrY/rT51GxTRuUlFukkyDV1jE8+2g9+/Fntf9WIBF+2MViEt5WxMaY3
   sg2OP0o5rq45YzzaE/TJG9SXawFnej1Q1jx28KAf4NOuiz3FE0EgzMW5a
   g==;
X-CSE-ConnectionGUID: ybydHqLUTMWtfuvtt9EbVA==
X-CSE-MsgGUID: ghgZ2aOxQOq57Sj8F+3SZA==
X-IronPort-AV: E=McAfee;i="6700,10204,11274"; a="44011274"
X-IronPort-AV: E=Sophos;i="6.12,203,1728975600"; 
   d="scan'208";a="44011274"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2024 09:17:22 -0800
X-CSE-ConnectionGUID: QiD4yxpbQW23NHkaaVBIDw==
X-CSE-MsgGUID: a55QSpSjTOapW5UV/XmIKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,203,1728975600"; 
   d="scan'208";a="93639651"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.61])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2024 09:17:19 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 2 Dec 2024 19:17:16 +0200 (EET)
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
cc: LKML <linux-kernel@vger.kernel.org>, Armin Wolf <W_Armin@gmx.de>, 
    Hans de Goede <hdegoede@redhat.com>, platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH 12/15] platform/x86: quickstart: don't include 'pm_wakeup.h'
 directly
In-Reply-To: <20241118072917.3853-13-wsa+renesas@sang-engineering.com>
Message-ID: <35cd3752-9378-69e3-8da9-7f47dfd127d0@linux.intel.com>
References: <20241118072917.3853-1-wsa+renesas@sang-engineering.com> <20241118072917.3853-13-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 18 Nov 2024, Wolfram Sang wrote:

> The header clearly states that it does not want to be included directly,
> only via 'device.h'. 'platform_device.h' works equally well. Remove the
> direct inclusion.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>  drivers/platform/x86/quickstart.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/quickstart.c b/drivers/platform/x86/quickstart.c
> index 8d540a1c8602..c332c7cdaff5 100644
> --- a/drivers/platform/x86/quickstart.c
> +++ b/drivers/platform/x86/quickstart.c
> @@ -20,7 +20,6 @@
>  #include <linux/module.h>
>  #include <linux/mutex.h>
>  #include <linux/platform_device.h>
> -#include <linux/pm_wakeup.h>
>  #include <linux/printk.h>
>  #include <linux/slab.h>
>  #include <linux/sysfs.h>

Thanks for the patch. I've applied it to the review-ilpo-next branch in 
the pdx86 repo.

-- 
 i.


