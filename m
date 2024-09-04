Return-Path: <linux-kernel+bounces-315411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0B0196C25E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 17:30:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AC6D1F221E9
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 15:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 183031DCB34;
	Wed,  4 Sep 2024 15:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hJsl48Qd"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA931CF7A1
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 15:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725463796; cv=none; b=nPwg3OWXQpSsQkPt1w5Eq0Yz0dLO5lqhWXg6MW9LRIfCP/KCh7hWWWn7BtQuz412MYbkeVPqFHrdu9vcrx174Dwoyj7u5k8OpY3HmDLB1Tpt/QnekU2DCQmAEqMIErV2/89YmylOC5qmk/HivGjA6fJZY3ws/RuUWVCXQpZYLew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725463796; c=relaxed/simple;
	bh=aZWoZHQB+0NF2Ob7yIuyBi0DZhsRsBY5cjekS/lZaQI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rPUXyoNBi7CF7TGmeIfKHs7whnXGzUIBTMEJ9+rB5WE08OeuBwZo7iPE8mAwCAxvPWvfHam9iBnklM9fnP+I1eJXake0pLSUQnjk/Zx64UY7NTU9G2kQJoVj7glq0eCSkk/TGmHo3gThkWO44a++COUngNFhIjrYheKqN/VeRv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hJsl48Qd; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725463795; x=1756999795;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=aZWoZHQB+0NF2Ob7yIuyBi0DZhsRsBY5cjekS/lZaQI=;
  b=hJsl48QdCYqIyoMw5AtfTL0YXj2zA/d5MDQr413v2/1BF5k1gwXF+UhI
   vTv92pamGSCYNJH4/sDvna3CpG5d3f3GncIpXMTjriUROSuGSQuFJsLZ3
   N53y4nZ5DmnFSmLSGsaroLH+5MWICU/atjJHtDK6lBw5TFRegaCMQsT57
   l5eNgr5MSBE2sciRT98o8K1NoKsWyBpIsAPrmHaKW1PwrGPTzy7ev8/0A
   vP3o0WkJZT7vkEk2u9B7G/+Yrf4/GCwx/n1QPPVu8xk2Uz5GQtqKGZjhP
   4L2Ja73BFzoN14jSWExBO4nLySdB8HJ+fEi6MAnJskvbrjtKQEj8CS5YB
   g==;
X-CSE-ConnectionGUID: 99WOv2N6Qa6vN7IFqGsd6Q==
X-CSE-MsgGUID: RHs2EfcRRqK6YPoYn1RDjw==
X-IronPort-AV: E=McAfee;i="6700,10204,11185"; a="34703343"
X-IronPort-AV: E=Sophos;i="6.10,202,1719903600"; 
   d="scan'208";a="34703343"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2024 08:29:55 -0700
X-CSE-ConnectionGUID: POLDbwruT/So+OOqYk4IiA==
X-CSE-MsgGUID: x5v0gv1+QqqHkPkyEcPItw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,202,1719903600"; 
   d="scan'208";a="64996107"
Received: from rchatre-mobl4.amr.corp.intel.com (HELO [10.125.109.157]) ([10.125.109.157])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2024 08:29:54 -0700
Message-ID: <f15fa33a-46a8-4488-90e3-fa9e1d7a6c42@intel.com>
Date: Wed, 4 Sep 2024 08:29:53 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ntb: idt: Fix the cacography in ntb_hw_idt.c
To: zhangjiao2 <zhangjiao2@cmss.chinamobile.com>, fancer.lancer@gmail.com
Cc: jdmason@kudzu.us, allenbh@gmail.com, ntb@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20240904065442.102889-1-zhangjiao2@cmss.chinamobile.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20240904065442.102889-1-zhangjiao2@cmss.chinamobile.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/3/24 11:54 PM, zhangjiao2 wrote:
> From: zhang jiao <zhangjiao2@cmss.chinamobile.com>
> 
> The word 'swtich' is wrong, so fix it.
> 
> Signed-off-by: zhang jiao <zhangjiao2@cmss.chinamobile.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/ntb/hw/idt/ntb_hw_idt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ntb/hw/idt/ntb_hw_idt.c b/drivers/ntb/hw/idt/ntb_hw_idt.c
> index 48dfb1a69a77..6fc9dfe82474 100644
> --- a/drivers/ntb/hw/idt/ntb_hw_idt.c
> +++ b/drivers/ntb/hw/idt/ntb_hw_idt.c
> @@ -2547,7 +2547,7 @@ static void idt_deinit_dbgfs(struct idt_ntb_dev *ndev)
>   */
>  
>  /*
> - * idt_check_setup() - Check whether the IDT PCIe-swtich is properly
> + * idt_check_setup() - Check whether the IDT PCIe-switch is properly
>   *		       pre-initialized
>   * @pdev:	Pointer to the PCI device descriptor
>   *

