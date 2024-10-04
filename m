Return-Path: <linux-kernel+bounces-350407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B6F89904B5
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 15:45:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 132691F2292F
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 13:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87C1C2101B0;
	Fri,  4 Oct 2024 13:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RTIkHCOG"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B0A2101A7;
	Fri,  4 Oct 2024 13:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728049510; cv=none; b=JNxfo2wY4bOsuOkPwRTZGKOMAAGC9RaCIhkQjrsiKXAVeF90WfMwolaM3vsrUFoJkzxDU/IqwpFEJ9nFjK1mlgZlO4WR3KX4o6EaiW21xx3gXJk2S8FApbDQtACfL2CYMTy9R4B0c7YZTQ1MzYHaIRhcgw4akck/RZd4TYELlUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728049510; c=relaxed/simple;
	bh=4xjpn1cjbsUT4BC0qUmd0788DGsHynkEwz3qlxz8VHU=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=DJByGnOILDA9jC6BX3Phape4luq+0LzIWylVxWh0Yxtiel7Fa/hXvE9/UYQpAhspeB4boL+bV2gPIoPvK+qu+w2BwXw5m+5j7s/+IRnINculE+sJzmFnbvkLe2hFteiWoHBNiHY9JgHw7IwlLRzpH3IRpZ5fiYxBWVATfb1it/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RTIkHCOG; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728049508; x=1759585508;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=4xjpn1cjbsUT4BC0qUmd0788DGsHynkEwz3qlxz8VHU=;
  b=RTIkHCOGVpNgSoM7cteJbOjq04Pw8MYwfm76sExEjhD96VamEuWBOCQw
   2po5aAVGZKq52P/jW3QKSie7n9jbDC6M7Jg0dDUoze3oBvNmARO5i6NjK
   0GhIryGuyv54XUmA7m68W7lKOvR9+3GSOT2OBpbMz+Y6KZUaXl1cfEKJp
   Hql28SY3fu2xwp4mIksFg0UfD2eSDS1Bo7McOHCv8SIXpySsCjm+CX6P2
   aKEbosZ4hMTU8+73m1VujlYUaMjrI9Ybyb17M9jqnQij/pHlWmSwMYGA8
   rDB2PLFnApqifB7Em/RhX37nS4rYrCFkluhJpx44CDTb7lb0ALEKAZgnt
   A==;
X-CSE-ConnectionGUID: /+3fc0EvQzm1XG8ub+eEYQ==
X-CSE-MsgGUID: y2sYQbtqRt2d0bOy8ASzoA==
X-IronPort-AV: E=McAfee;i="6700,10204,11214"; a="52676068"
X-IronPort-AV: E=Sophos;i="6.11,177,1725346800"; 
   d="scan'208";a="52676068"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2024 06:45:07 -0700
X-CSE-ConnectionGUID: wsYMkoOtR16eh6tZtJ3edw==
X-CSE-MsgGUID: gLED+iWsR2uW0MRjW36TVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,177,1725346800"; 
   d="scan'208";a="105451370"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.148])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2024 06:45:05 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 4 Oct 2024 16:45:01 +0300 (EEST)
To: Crag Wang <crag0715@gmail.com>
cc: mario.limonciello@amd.com, Prasanth Ksr <prasanth.ksr@dell.com>, 
    Hans de Goede <hdegoede@redhat.com>, crag.wang@dell.com, 
    Crag Wang <crag_wang@dell.com>, Dell.Client.Kernel@dell.com, 
    platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHv3 1/2] platform/x86: dell-sysman: remove match on
 www.dell.com
In-Reply-To: <20241004024209.201244-1-crag_wang@dell.com>
Message-ID: <eb6c6347-e665-8057-f825-1acfec682ea3@linux.intel.com>
References: <20241004024209.201244-1-crag_wang@dell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 4 Oct 2024, Crag Wang wrote:

> The URL is dynamic and may change according to the OEM. It was mainly used
> for old systems that do not have "Dell System" in the OEM String.
> 
> Signed-off-by: Crag Wang <crag_wang@dell.com>
> ---
>  drivers/platform/x86/dell/dell-wmi-sysman/sysman.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/platform/x86/dell/dell-wmi-sysman/sysman.c b/drivers/platform/x86/dell/dell-wmi-sysman/sysman.c
> index 9def7983d7d6..c05474f1ed70 100644
> --- a/drivers/platform/x86/dell/dell-wmi-sysman/sysman.c
> +++ b/drivers/platform/x86/dell/dell-wmi-sysman/sysman.c
> @@ -520,8 +520,7 @@ static int __init sysman_init(void)
>  {
>  	int ret = 0;
>  
> -	if (!dmi_find_device(DMI_DEV_TYPE_OEM_STRING, "Dell System", NULL) &&
> -	    !dmi_find_device(DMI_DEV_TYPE_OEM_STRING, "www.dell.com", NULL)) {
> +	if (!dmi_find_device(DMI_DEV_TYPE_OEM_STRING, "Dell System", NULL)) {

I suggested making the changes in the opposite order, that was to 
faciliate easy revert of the URL patch if needed which is not the case if
things are changed in this order.

-- 
 i.


