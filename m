Return-Path: <linux-kernel+bounces-222490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C27E91024F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 13:14:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E999B1F21DCF
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 11:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C0501AB34E;
	Thu, 20 Jun 2024 11:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TTa6YGBa"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E17D31AAE09
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 11:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718882062; cv=none; b=gtNh468+ScHna/cWo5KeBi88p8q7ALxJ3BzUYZX+31pcjCxbmaV1rIB5vqRjxHDn2A+L1cTmwHu4Y69jgl6m4p/UlJHvVXzfSfpOwU3+mkI14+/CURQJXtmKnyZO84MMB9wwSyUGlEmveWf/hdhQalwD+Yd6LwwC4WSWY6f0mmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718882062; c=relaxed/simple;
	bh=41V5qM2Xc8+hKW6MPPByw1cyUc6zgZCcguLz9Xf3LIg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=dryCmuNYh/yWcGQYnd/4nFbiMGWWtgDxkmglaJWzO6Wq7AhzGTmC/uEAv5m11DEuWedCP8ur2GUw+MiTZbd16Tx9BWJ1ClhkJukTADsJ77abOrBo87BC95juDDkVGCmTp6XX8483WpmgHjQT9CM6Qlc5eZAfGA0xaJ7nKQpbw+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TTa6YGBa; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718882061; x=1750418061;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=41V5qM2Xc8+hKW6MPPByw1cyUc6zgZCcguLz9Xf3LIg=;
  b=TTa6YGBagS/dCEDaBtUXlAwhF1B9RtYupJrPfwFItZXGk8DMOrSfFN06
   A8WrXURwRxdHmFTAFy1/TH9ZgXuVAZXcXA1FcBDPd5FBLRFx/4UpHVz7A
   1iO2dISroiyz4wc9xiYeQoOaUNplhvUliZ1txqyqH89P5zS2/Pt4m2qHu
   XfpAbwjn3RttVT1Be73dt8YhAgqaRt4kKSqdb/mhYOE9DbI5ASWW/V4ri
   pjk40VloJ2KEaE060Caq0hZMqrff0NinoVjpkYaBHA3YkkpCZbvq2ICRc
   wAzJc5o3k8EQXYcPDREz+JGXATtRi3ut+nWPmkPY911co4egpcl9xS1nr
   A==;
X-CSE-ConnectionGUID: 8JCm/11hT36+vS3IeQkCkQ==
X-CSE-MsgGUID: uimiK2gPSMqlBZbwvQ5/IQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11108"; a="12161663"
X-IronPort-AV: E=Sophos;i="6.08,252,1712646000"; 
   d="scan'208";a="12161663"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2024 04:14:19 -0700
X-CSE-ConnectionGUID: v4ovnh61T3ukPwlwybUEKA==
X-CSE-MsgGUID: opO1isRZRx6et/8qXf718w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,252,1712646000"; 
   d="scan'208";a="46660974"
Received: from lfiedoro-mobl.ger.corp.intel.com (HELO [10.245.246.65]) ([10.245.246.65])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2024 04:14:17 -0700
Message-ID: <6f51ef55-54a7-4dfc-b203-77bc48790c62@linux.intel.com>
Date: Thu, 20 Jun 2024 13:14:15 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] soundwire: bus: simplify by using local slave->prop
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Vinod Koul <vkoul@kernel.org>, Bard Liao <yung-chuan.liao@linux.intel.com>,
 Sanyog Kale <sanyog.r.kale@intel.com>, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org
References: <20240620091046.12426-1-krzysztof.kozlowski@linaro.org>
Content-Language: en-US
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20240620091046.12426-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/20/24 11:10, Krzysztof Kozlowski wrote:
> The sdw_initialize_slave() function stores 'slave->prop' as local 'prop'
> variable, so use it in all applicable places to make code a bit simpler.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

> ---
>  drivers/soundwire/bus.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
> index 191e6cc6f962..263ca32f0c5c 100644
> --- a/drivers/soundwire/bus.c
> +++ b/drivers/soundwire/bus.c
> @@ -1410,7 +1410,7 @@ static int sdw_initialize_slave(struct sdw_slave *slave)
>  		}
>  	}
>  	if ((slave->bus->prop.quirks & SDW_MASTER_QUIRKS_CLEAR_INITIAL_PARITY) &&
> -	    !(slave->prop.quirks & SDW_SLAVE_QUIRKS_INVALID_INITIAL_PARITY)) {
> +	    !(prop->quirks & SDW_SLAVE_QUIRKS_INVALID_INITIAL_PARITY)) {
>  		/* Clear parity interrupt before enabling interrupt mask */
>  		status = sdw_read_no_pm(slave, SDW_SCP_INT1);
>  		if (status < 0) {
> @@ -1436,7 +1436,7 @@ static int sdw_initialize_slave(struct sdw_slave *slave)
>  	 * device-dependent, it might e.g. only be enabled in
>  	 * steady-state after a couple of frames.
>  	 */
> -	val = slave->prop.scp_int1_mask;
> +	val = prop->scp_int1_mask;
>  
>  	/* Enable SCP interrupts */
>  	ret = sdw_update_no_pm(slave, SDW_SCP_INTMASK1, val, val);
> @@ -1447,7 +1447,7 @@ static int sdw_initialize_slave(struct sdw_slave *slave)
>  	}
>  
>  	/* No need to continue if DP0 is not present */
> -	if (!slave->prop.dp0_prop)
> +	if (!prop->dp0_prop)
>  		return 0;
>  
>  	/* Enable DP0 interrupts */

