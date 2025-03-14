Return-Path: <linux-kernel+bounces-561337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 623F4A61034
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 12:41:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CC0A1886746
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 11:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63F3C1FDE00;
	Fri, 14 Mar 2025 11:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EoU7Qg5y"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787E73C6BA;
	Fri, 14 Mar 2025 11:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741952510; cv=none; b=kRPEayBrMicKcxOYlMx4dqZniJi8nVgxQGlyQjNKLYTHTdaxfYH73iDbLWq34IZ/winsFfvxJGgZtNWyl690ckAH6wvz9p0gYWErNS8TvwUvoLJlQiddM4JFu0+zJMupxdS/Cfz+PcZxvkoqiHwVnBq+HtJUwXndQdC+AIM8ipQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741952510; c=relaxed/simple;
	bh=b+N4iAe5kZXWBX3ZlJCpdxKPlfsWdwzYPJJb1b47u5s=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=h+hXdm6hzRMmc8W5ZYXEMQaplvp5O8t+OH/vLFKUIavUTdrLzO/b1G30LMrAdoRLUvDbN5CNTU57Wm3ykv8yt18tTs9458EnqLhbHRyy9g0Y1/HQWbjufHZRRMOzZ0tZy3kgufxxyNhLka20dlLNMzn3Sp2xEp7gZyfxHm4iYJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EoU7Qg5y; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741952508; x=1773488508;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=b+N4iAe5kZXWBX3ZlJCpdxKPlfsWdwzYPJJb1b47u5s=;
  b=EoU7Qg5y5XDh9nUgUyKP8H5lOrVBwckkrikvC0GgR6r//wPaxuDiE71X
   lpkcoapkpKTEaeMcjbo3aLxe9KHOYEQHRobendqAysm3fLA07v8dQ8Yc/
   ihaDZx4aX2DGsW1ptjXVYsL2ZfGfTw+3rCo+bE7mtOcNoUZQbgfVvYtaT
   8cHqz9CG1cUNLnQaNPxtZ8SWj856xK1kZJuubOG/7yOVCbcH3dh/QwitM
   GWUwn77SEpexYNl+9PhjCnX/U5eF0Zf9DHJZRKKMORaOU8fCNlmfw6sMT
   ETapo3oPoZ3eWnt6A9nkq6z6vqkgGd2qFxOrAUSdjvuzoZLqdLiZndiw6
   A==;
X-CSE-ConnectionGUID: nzmskUHBRl206N5wtsbtZw==
X-CSE-MsgGUID: Na3l5NV+T4aT64XR5Mq+xg==
X-IronPort-AV: E=McAfee;i="6700,10204,11372"; a="42966325"
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; 
   d="scan'208";a="42966325"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2025 04:41:47 -0700
X-CSE-ConnectionGUID: 5997ZYRHSdSt+bVBmBzgSA==
X-CSE-MsgGUID: QyQiBgrPTNW+IKa338ajcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; 
   d="scan'208";a="125878045"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.56])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2025 04:41:46 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 14 Mar 2025 13:41:42 +0200 (EET)
To: Chenyuan Yang <chenyuan0y@gmail.com>
cc: W_Armin@gmx.de, Hans de Goede <hdegoede@redhat.com>, 
    platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] platform/x86: wmi: Add Null check for device
In-Reply-To: <20250313162820.3688298-1-chenyuan0y@gmail.com>
Message-ID: <ff53debd-05bd-3a7f-89a5-2110b8103fad@linux.intel.com>
References: <20250313162820.3688298-1-chenyuan0y@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 13 Mar 2025, Chenyuan Yang wrote:

Hi,

Could you please be consistent in style and write "NULL" also in the 
shortlog in the subject.

> Not all devices have an ACPI companion fwnode, so device might be NULL.
> This is similar to the commit cd2fd6eab480
> ("platform/x86: int3472: Check for adev == NULL").

Please fold the paragraph normally.

> Add a check for device not being set and return -ENODEV in that case to
> avoid a possible NULL pointer deref in parse_wdg().
> 
> Note, acpi_wmi_probe() under the same file has such a check.

Hmm, is this a bogus fix, as parse_wdg() is only called from 
acpi_wmi_probe() so how can ACPI companion turn NULL in between??

How was this problem found??

> Signed-off-by: Chenyuan Yang <chenyuan0y@gmail.com>
> ---
>  drivers/platform/x86/wmi.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
> index 646370bd6b03..54e697838c1e 100644
> --- a/drivers/platform/x86/wmi.c
> +++ b/drivers/platform/x86/wmi.c
> @@ -1091,6 +1091,9 @@ static int parse_wdg(struct device *wmi_bus_dev, struct platform_device *pdev)
>  	u32 i, total;
>  	int retval;
>  
> +	if (!device)
> +		return -ENODEV;
> +
>  	status = acpi_evaluate_object(device->handle, "_WDG", NULL, &out);
>  	if (ACPI_FAILURE(status))
>  		return -ENXIO;
> 

-- 
 i.


