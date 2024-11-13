Return-Path: <linux-kernel+bounces-407351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 820AD9C6C3C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 11:01:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32B3BB2CE64
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 10:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABA861F8907;
	Wed, 13 Nov 2024 10:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TVkW0qGF"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C341F80BA
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 10:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731492017; cv=none; b=Prw0dnFjhPC1MPSKyntGuLvEpJJrT5/zjiO8B2ft45O4DsJW1qpwZO7HW5PIDX/oIgXgK4Q/mdJGRRaPgZYXOr9jRsf5DK1BR9mA7qjABQFTVIhSEphakNw8V7vqtfAcx4ce1vNL8hch+h0sPuJHJ09CF0CH8EyRtwMGapi/654=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731492017; c=relaxed/simple;
	bh=XTg1A6VERW2vZuQ8bcofRgH6ca1goDGT1y1rIAqX34s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=inQGpeAO1hJRrj6YKLBgeTp1EXL+qFLeYfNO5VYayoWTBe2cCKS1B1O66IgK9tV+lXKESiTM33pAw8QLGMfY9UbnAsMi4SVZoWY8kvi/AVH9DAmvY0RpxcWOdl2ke7gwyerUWeCp1pWnrjja1L4UnBiNLueQo4IeNYaYxlew9BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TVkW0qGF; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731492011; x=1763028011;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=XTg1A6VERW2vZuQ8bcofRgH6ca1goDGT1y1rIAqX34s=;
  b=TVkW0qGFL9mzfltADpmsKv8Xl5KsrAD9VdpMgshTir/ASd2dzIDAH2Sc
   ADAVpRwvOmoGhEXA+F0n4tjoG6FvJyKx0LYV4b5tAlSnHkxi2zfBmx8l6
   elR2X55Uqyd1wS2K4TFIpAcRsStGkLRtKEfiPwhnx9BYBxsZv2RQmt8ty
   Lv7Garaid5O98UkJTDGGDn/OmQ5XCuLwMaG1MZDhhPyJ5KSTpHzB7/4dE
   kXxP4UiXgaYZNdLbhLdamrP/I8AN7gfavKKJ7r5plFjN4GkLff0oaMF3o
   jKyGkWIkuk5cofwkG6Grm5oUEhKCbZmalBu8IzegmDxRCF9ZUHyuGxcvp
   g==;
X-CSE-ConnectionGUID: Kirir34NQbWuWFDv/kxTzQ==
X-CSE-MsgGUID: WRh+THjrSfiEUeXq7uoIUw==
X-IronPort-AV: E=McAfee;i="6700,10204,11254"; a="31258416"
X-IronPort-AV: E=Sophos;i="6.12,150,1728975600"; 
   d="scan'208";a="31258416"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2024 02:00:09 -0800
X-CSE-ConnectionGUID: teOArXzgSayK1TaaOOx2VQ==
X-CSE-MsgGUID: VSWqnHkRQZuZGE60Q0mmYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,150,1728975600"; 
   d="scan'208";a="91867725"
Received: from mylly.fi.intel.com (HELO [10.237.72.58]) ([10.237.72.58])
  by fmviesa003.fm.intel.com with ESMTP; 13 Nov 2024 02:00:07 -0800
Message-ID: <9a78959a-391b-4a77-a33e-e230fbf2e0c0@linux.intel.com>
Date: Wed, 13 Nov 2024 12:00:06 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/5] i3c: master: Add support for SETAASA CCC
To: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Sanket.Goswami@amd.com, linux-i3c@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20241108073323.523805-1-Shyam-sundar.S-k@amd.com>
 <20241108073323.523805-5-Shyam-sundar.S-k@amd.com>
Content-Language: en-US
From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
In-Reply-To: <20241108073323.523805-5-Shyam-sundar.S-k@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi

On 11/8/24 9:33 AM, Shyam Sundar S K wrote:
> @@ -1907,7 +1926,14 @@ static int i3c_master_bus_init(struct i3c_master_controller *master)
>   		goto err_bus_cleanup;
>   	}
>   
> -	i3c_master_add_spd_dev(master, i3cboardinfo);
> +	/*
> +	 * If the I3C slave on the bus is SPD device, then do not follow the regular
> +	 * DAA process. Also, as per SPD spec SETAASA is required for the bus discovery
> +	 * and sending RSTDAA and DISEC is considered as illegal. So skip the entire process
> +	 * if the jdec_spd flag has been identified from the BIOS.
> +	 */
> +	if (master->jdec_spd)
> +		return i3c_master_add_spd_dev(master, i3cboardinfo);
>   
This looks wrong the previous patch adds unconditional call to 
i3c_master_add_spd_dev() and this patch makes it conditional. Can 
previous patch then cause a regression if applied without this one?

>   	if (master->ops->set_speed) {
>   		ret = master->ops->set_speed(master, I3C_OPEN_DRAIN_SLOW_SPEED);
> @@ -2311,6 +2337,10 @@ static int i3c_acpi_configure_master(struct i3c_master_controller *master)
>   		return -ENODEV;
>   	}
>   
> +	status = acpi_evaluate_object(master->ahandle, "_STR", NULL, NULL);
> +	if (ACPI_SUCCESS(status))
> +		master->jdec_spd = true;
> +

I'm still suspicious about this one when existence of _STR for the host 
controller causes normal bus initialization to be skipped. I.e. like below.

Device (I3C0)
{
	_STR ("My I3C Host Controller")
...

