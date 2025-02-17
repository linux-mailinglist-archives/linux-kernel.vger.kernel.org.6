Return-Path: <linux-kernel+bounces-517210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD802A37DB7
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 10:02:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D09513B4E38
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 08:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB0381ACEC7;
	Mon, 17 Feb 2025 08:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l0Fb8Xoi"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A92D1A5BB6;
	Mon, 17 Feb 2025 08:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739782696; cv=none; b=XP9QNgT/ID65P/Y4JW/tZxCY9baSpMYpi/8Tx/1PrPr0yxThxUB8Eo9JvV0am/MEkOlxCK8gJgji6ZqNL3gvhwG9i980xypI0ztoSSD6oxkSaa04a8UsW+5BYLDJpoMTI9Oyqz/97yLuKsoxkU6BnAQCYV94T9xTwMCfma9qArI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739782696; c=relaxed/simple;
	bh=YGKakBzwkxieZv4ys38XQTPOxJy5UJPJ9B7AOCv2v7o=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=i7Zyy6JCTO/lZT6VAlHgUYKy57S6rXgrPnpP2lJvuVvWlgxeaABwVHYld5CT1XUUpwyETfIyaIMKzKf31c/OIVqUttBI3NRoUxFjwR1wAt1pPdcq300rFZbBo6b6Hsop9/V4F/0goFukOkGLzTeJwGyiF74PjESkIUJnE11+UCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l0Fb8Xoi; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739782695; x=1771318695;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=YGKakBzwkxieZv4ys38XQTPOxJy5UJPJ9B7AOCv2v7o=;
  b=l0Fb8XoiLvrBUfrBcF8TuJimrZam5R48L6eknyLAGEYIAzsI7DostKB8
   iOc7sTd5SuDoxhgEyqr5kpfTTcGXmTvtoUYMvy8hGB/roYFQ/ICs17G5z
   vxTrvV+GUeR+311IT9ADOnybvFbc2SXRYG1aMq3MurbAjC5xEAgLinRdo
   J4EMCRzVTZelzY7fraxmJQwlVBZMERIkQdeiXWd0+YLhDChcf7DV6Cvh7
   fvGR9FKPuHqCxCzCFk7xSNuFs5ThXwFr4r0slX9+u4YqWDCKR9MZ5BX9a
   iotfTCbkYo/ZAhXoMQJ1Ar0TSyXrTxASW8UJ6uRqFpao1QfRn7GaSL6Ge
   A==;
X-CSE-ConnectionGUID: YcyO7KsjQGKVdlBfStE4NQ==
X-CSE-MsgGUID: x1oUhVXyQ6eR0/O+ZsUhEA==
X-IronPort-AV: E=McAfee;i="6700,10204,11347"; a="39685363"
X-IronPort-AV: E=Sophos;i="6.13,292,1732608000"; 
   d="scan'208";a="39685363"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2025 00:58:13 -0800
X-CSE-ConnectionGUID: nZpr5yv9Q8uL1Yn9ziDUWg==
X-CSE-MsgGUID: kk3aPY7SSw6NmYXGBSw26w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="144989919"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.163])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2025 00:58:11 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 17 Feb 2025 10:58:07 +0200 (EET)
To: Kurt Borja <kuurtb@gmail.com>
cc: Hans de Goede <hdegoede@redhat.com>, platform-driver-x86@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, 
    =?ISO-8859-15?Q?Pali_Roh=E1r?= <pali@kernel.org>, 
    Dell.Client.Kernel@dell.com, Matthew Garrett <mjg59@srcf.ucam.org>, 
    Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH] platform/x86: dell: Use *-y instead of *-objs in
 Makefile
In-Reply-To: <20250214214535.4947-1-kuurtb@gmail.com>
Message-ID: <cc0f1964-ae37-4cfb-b5d2-da2e2a97e522@linux.intel.com>
References: <20250214214535.4947-1-kuurtb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 14 Feb 2025, Kurt Borja wrote:

> The `objs` suffix is reserved for user-space tools. Use the `y` suffix
> instead, which is usually used for kernel drivers.
> 
> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
> ---
> Hi all,
> 
> I based this patch on top of the for-next branch.
> 
> Ilpo, if you prefer this patch to be based on top of the fixes branch,
> let me know. I'd submit two separate patches, one for alienware-wmi, on
> top of the for-next branch and one for the other drivers, on top of
> fixes.

Thanks for the fix.

I took this through for-next branch to not make our lives unnecessarily 
complicated. If there would be only handful of -objs, I might have decide 
otherwise but this (wrong) pattern is really widespread so removing a few 
drops from the ocean is not going to sound us the finish line fanfare. But 
it's still an important step towards the right direction, regardless.

TBH, I didn't know the distinction either until Andy explained it (and 
like you, would have just copied the pattern if one was readily 
available). But I've never really deep dived into the kernel's build 
system anyway.

I wonder why checkpatch doesn't catch it, or does it? At least there are 
no "objs" strings in its source.

-- 
 i.

> 
> ~ Kurt
> 
>  drivers/platform/x86/dell/Makefile | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/platform/x86/dell/Makefile b/drivers/platform/x86/dell/Makefile
> index 8ac9a933c770..c7501c25e627 100644
> --- a/drivers/platform/x86/dell/Makefile
> +++ b/drivers/platform/x86/dell/Makefile
> @@ -5,7 +5,7 @@
>  #
>  
>  obj-$(CONFIG_ALIENWARE_WMI)			+= alienware-wmi.o
> -alienware-wmi-objs				:= alienware-wmi-base.o
> +alienware-wmi-y					:= alienware-wmi-base.o
>  alienware-wmi-$(CONFIG_ALIENWARE_WMI_LEGACY)	+= alienware-wmi-legacy.o
>  alienware-wmi-$(CONFIG_ALIENWARE_WMI_WMAX)	+= alienware-wmi-wmax.o
>  obj-$(CONFIG_DCDBAS)				+= dcdbas.o
> @@ -14,14 +14,14 @@ obj-$(CONFIG_DELL_RBTN)				+= dell-rbtn.o
>  obj-$(CONFIG_DELL_RBU)				+= dell_rbu.o
>  obj-$(CONFIG_DELL_PC)				+= dell-pc.o
>  obj-$(CONFIG_DELL_SMBIOS)			+= dell-smbios.o
> -dell-smbios-objs				:= dell-smbios-base.o
> +dell-smbios-y					:= dell-smbios-base.o
>  dell-smbios-$(CONFIG_DELL_SMBIOS_WMI)		+= dell-smbios-wmi.o
>  dell-smbios-$(CONFIG_DELL_SMBIOS_SMM)		+= dell-smbios-smm.o
>  obj-$(CONFIG_DELL_SMO8800)			+= dell-smo8800.o
>  obj-$(CONFIG_DELL_SMO8800)			+= dell-lis3lv02d.o
>  obj-$(CONFIG_DELL_UART_BACKLIGHT)		+= dell-uart-backlight.o
>  obj-$(CONFIG_DELL_WMI)				+= dell-wmi.o
> -dell-wmi-objs					:= dell-wmi-base.o
> +dell-wmi-y					:= dell-wmi-base.o
>  dell-wmi-$(CONFIG_DELL_WMI_PRIVACY)		+= dell-wmi-privacy.o
>  obj-$(CONFIG_DELL_WMI_AIO)			+= dell-wmi-aio.o
>  obj-$(CONFIG_DELL_WMI_DESCRIPTOR)		+= dell-wmi-descriptor.o
> 
> base-commit: d497c47481f8e8f13e3191c9a707ed942d3bb3d7
> 

