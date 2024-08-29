Return-Path: <linux-kernel+bounces-306950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E1A49645EB
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 15:11:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D52B72878CB
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 13:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DABC1A3BCF;
	Thu, 29 Aug 2024 13:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mua16DRN"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A39C1A4ADE;
	Thu, 29 Aug 2024 13:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724937081; cv=none; b=d0nnc3zWM/bdwABLBgLK2bwRXot8zvPsGIue444N/4Jzvwb7x+SZgTFJWsXV8KzpzppFku0TqZeZRycH/fGcC19aWU+c3UgbKfQiKWmtHkRtDLOzozGDJcVk0YfLHgSV6WBvTLUfNATH9JHRzlY5n15AmpbmOLrANqHCnbyyK2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724937081; c=relaxed/simple;
	bh=xJomEBaTA30qzuVPHC27UCTlgYU6iORyCFsgnV3S1XE=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=bEgDnwwDaRROJP5AIqx+1dIeTE8VGYDTy19KEMF7F+YSS92F3DXTU7diP/KVYCvLO7PP+7WxkWfGhi+L/ydSyBeQjtbswXY9wythsc9LrS/Uuh2y0iHKcHrxgRLad+oo3Df4/v143/Ig7PpzTyYaIQ3C2fWF/CjplnfM53iBDVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mua16DRN; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724937081; x=1756473081;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=xJomEBaTA30qzuVPHC27UCTlgYU6iORyCFsgnV3S1XE=;
  b=mua16DRNCvNMkmZHO2Oia8vIzSpsE1TdpIbJBIiIYUyXUt9Vl9MmQWjx
   Rum2hwmGaeg/HD8JZn7G/GexoRBP3oZ2thZGONoCd+tPc6sMmv+e1qFsj
   ne2y2BWPagImp0Py9Tj/GpesBA2FYl1+CappIkG+w/Nm+oqRdyIcs0qlr
   q2axAjNvOnDXcw4oAuXHx45VKyYVDbijvAv/w+Xm5mrG5GK44ByWSavlI
   yJMz7SQ7PDJyqA06AY/5uiWg/SfBBaa3j/jNQF8B2Zkj5fXjyxlwkDb+L
   lVn2Tp9Dcl01zhscwKkWlGmgdtpnGSOA/NdHHFKqKts+Glh271eGhYjjg
   Q==;
X-CSE-ConnectionGUID: /pb/dV1ySZiz1TRS3BMdew==
X-CSE-MsgGUID: NQBePk1jQ8mLz4LmF8r1Gw==
X-IronPort-AV: E=McAfee;i="6700,10204,11179"; a="23710874"
X-IronPort-AV: E=Sophos;i="6.10,185,1719903600"; 
   d="scan'208";a="23710874"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2024 06:11:14 -0700
X-CSE-ConnectionGUID: k/7QoaEhTiykv2a5DFUqRg==
X-CSE-MsgGUID: PEMNI/xGTdqbZ3vAsss7Aw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,185,1719903600"; 
   d="scan'208";a="68350177"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.245.59])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2024 06:11:09 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 29 Aug 2024 16:11:05 +0300 (EEST)
To: Aleksandr Mishin <amishin@t-argos.ru>
cc: Mario Limonciello <mario.limonciello@dell.com>, 
    Hans de Goede <hdegoede@redhat.com>, Lyndon Sanche <lsanche@lyndeno.ca>, 
    Armin Wolf <W_Armin@gmx.de>, "Darren Hart (VMware)" <dvhart@infradead.org>, 
    Edward O'Callaghan <quasisec@google.com>, 
    platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    lvc-project@linuxtesting.org
Subject: Re: [PATCH] platform/x86: dell-smbios: Fix error path in
 dell_smbios_init()
In-Reply-To: <20240828121703.17470-1-amishin@t-argos.ru>
Message-ID: <760b7678-4fba-8683-3438-d8c6ee1cfc6f@linux.intel.com>
References: <20240828121703.17470-1-amishin@t-argos.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 28 Aug 2024, Aleksandr Mishin wrote:

> In case of error in build_tokens_sysfs(), all the memory that has been
> allocated is freed at end of this function. But then free_group() is
> called which performs memory deallocation again.
> 
> Fix this issue by replacing free_group() call with exit_dell_smbios_wmi()

There are two issues and only one is properly described. Please amend the 
commit message to cover the other problem too.

-- 
 i.

> and exit_dell_smbios_smm().
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: 33b9ca1e53b4 ("platform/x86: dell-smbios: Add a sysfs interface for SMBIOS tokens")
> Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>
> ---
>  drivers/platform/x86/dell/dell-smbios-base.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/dell/dell-smbios-base.c b/drivers/platform/x86/dell/dell-smbios-base.c
> index 6565fac24cde..73e41eb69cb5 100644
> --- a/drivers/platform/x86/dell/dell-smbios-base.c
> +++ b/drivers/platform/x86/dell/dell-smbios-base.c
> @@ -622,7 +622,10 @@ static int __init dell_smbios_init(void)
>  	return 0;
>  
>  fail_sysfs:
> -	free_group(platform_device);
> +	if (!wmi)
> +		exit_dell_smbios_wmi();
> +	if (!smm)
> +		exit_dell_smbios_smm();
>  
>  fail_create_group:
>  	platform_device_del(platform_device);
> 


