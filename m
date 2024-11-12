Return-Path: <linux-kernel+bounces-405364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F7199C505E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 09:16:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5714B23210
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 08:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D220C20ADE4;
	Tue, 12 Nov 2024 08:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CeBqXfp0"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81ED283A14
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 08:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731399376; cv=none; b=t2NbNxfuBcge18+DJdro+Hr4r4glsgYRMVzau0nImGRgFmJUspK+LtsptmUG7czRHbnIV6itRpbDW6ECpBeep84nKlJN7wncbycgbyqHLiq/4WEuzOk80AJ4Jyz9J0HSXbRHbHmO+yid4JYqZCIVgryHmA5LT/ZsMKC4ih0DwIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731399376; c=relaxed/simple;
	bh=wfPsGh/NtuGCX40RhvU95ybOGuqzMZVTNrnQGmkaCwE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BPnQAQZdAUAa/GMsu43l79OUXxMPhWkJud/Mry3mIJXRRv483Ijn/I1CCP0v3wmqGe4hvYED8Uo32n58mpoYFlhZUl3y5xJSfNXQM5PhT55qH84atsp0Uxh9i8ZtXW0snAFOXM6cCc5Sh8IGr53zT4V60vXStfAbDqCzGczwQis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CeBqXfp0; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731399374; x=1762935374;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=wfPsGh/NtuGCX40RhvU95ybOGuqzMZVTNrnQGmkaCwE=;
  b=CeBqXfp0n1Dy8f4WlaR+Pbaqu/ZlM68fT8ncnrhZmpp3wRRbLvYdrzy5
   Gn8EEcvlV3LVoidM1PI34h2YjlK/MiSO0YhtL8UP2OfkMJbT8uSTWg95d
   y42jOFvAEkBFURCPgXEtbulYb/+79asEKXTfMIZnCGkxXObyFSl5lonO2
   63YAZ58UAWqVRde++HUNTB2FVZtuh0WYDn9UGj/qUOfPvfsuyB3BWRz2e
   k8iIwalp84a53y64H16vvVNkOd5NOv2tfW30KVGwRcrEqdkFfWh+I8s0L
   HVazRnEWTROKLjrUNKRuMcGwEtEJM3HHGWh0LAF3j8JzvAMTK9D6QG4bv
   g==;
X-CSE-ConnectionGUID: SvqM6fiBQGyK8e7WTdc+5w==
X-CSE-MsgGUID: f9NCqj4cRQe1Pmzj1pVIYg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="31374112"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="31374112"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2024 00:16:14 -0800
X-CSE-ConnectionGUID: 8NUvMpJhTs2+8B937cVOcg==
X-CSE-MsgGUID: pdJ1w3pHRDODzglOF2FSuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,147,1728975600"; 
   d="scan'208";a="92266122"
Received: from mylly.fi.intel.com (HELO [10.237.72.151]) ([10.237.72.151])
  by orviesa005.jf.intel.com with ESMTP; 12 Nov 2024 00:16:13 -0800
Message-ID: <09cfdd95-c566-4379-be17-2d5e0f0e8357@linux.intel.com>
Date: Tue, 12 Nov 2024 10:16:11 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/5] i3c: dw: Add support for AMDI0015 ACPI ID
To: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Sanket.Goswami@amd.com, linux-i3c@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20241108073323.523805-1-Shyam-sundar.S-k@amd.com>
 <20241108073323.523805-2-Shyam-sundar.S-k@amd.com>
Content-Language: en-US
From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
In-Reply-To: <20241108073323.523805-2-Shyam-sundar.S-k@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi

On 11/8/24 9:33 AM, Shyam Sundar S K wrote:
> Add AMDI0015 _HID for Designware I3C driver so that the dw-i3c-master
> driver can be probed on AMD platforms.
> 
> Signed-off-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
> ---
>   drivers/i3c/master/dw-i3c-master.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/i3c/master/dw-i3c-master.c b/drivers/i3c/master/dw-i3c-master.c
> index 8d694672c110..1a7c300b6d45 100644
> --- a/drivers/i3c/master/dw-i3c-master.c
> +++ b/drivers/i3c/master/dw-i3c-master.c
> @@ -1748,12 +1748,19 @@ static const struct of_device_id dw_i3c_master_of_match[] = {
>   };
>   MODULE_DEVICE_TABLE(of, dw_i3c_master_of_match);
>   
> +static const struct acpi_device_id amd_i3c_device_match[] = {
> +	{ "AMDI0015" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(acpi, amd_i3c_device_match);
> +
>   static struct platform_driver dw_i3c_driver = {
>   	.probe = dw_i3c_probe,
>   	.remove_new = dw_i3c_remove,
>   	.driver = {
>   		.name = "dw-i3c-master",
>   		.of_match_table = dw_i3c_master_of_match,
> +		.acpi_match_table = amd_i3c_device_match,
>   		.pm = &dw_i3c_pm_ops,
>   	},
>   };

Am I right this and patch 5/5 can be independent from rest of the series?

To me it looks these two patches enable bus communication and thus be 
useful without rest of the series while latter need more discussion 
(I'll have some notes coming) and Cc'ing linux-acpi.

