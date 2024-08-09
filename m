Return-Path: <linux-kernel+bounces-280993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F168D94D1AD
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 15:55:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A300B1F24ED7
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 13:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06C9419581F;
	Fri,  9 Aug 2024 13:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dDKvEPkQ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F23C91957FF
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 13:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723211746; cv=none; b=GXlhvxFEAXwvx4jFIzDnqWgWz7+i+1Q3GQr4M182XS6+l9YWvGXpm6SmwneY7hlXtbXjleXz/FXct+riEix1M+LaswQhQEusAvHQauxZhBE8w9jWsFi25y6Lr8jHFdgCD+SK0BNc/kZBXL+XU3hliTmPe1+Nsk5nG73yimTPMbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723211746; c=relaxed/simple;
	bh=u3qb9u7xUqfWCyseEYNO2y6Aw00VoHXE9cd46e9bm7g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XRcmoOsiAPgyvgd5d9tAf1GN382uVbqZ9+ZP7RJT3okgHAqur+dDWwxSrSUu6oHVMHHAfPfBFGmgP1hl69R0cS33ehti8u/250qdcS8Vn0kWwQP1kH1y8apY4wqCE8HvJSN04lhAQF25z7DAQiP4+1jPMJ/QCQe1GqDuZ5fTPZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dDKvEPkQ; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723211745; x=1754747745;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=u3qb9u7xUqfWCyseEYNO2y6Aw00VoHXE9cd46e9bm7g=;
  b=dDKvEPkQng1xtvqcORK9MyGfYZA2rcp/ACTLCkl9LML2OkT2iY3kM3/k
   XoC0cuBFShBqpHOXh5ve/f9cWNCjVNeTg+qpQugJIhGSelgUdbFR5xmOv
   l54x801/QWI3OiGcnGupT8BaW2ghYJlU3obcGVcfYJUsEZm0FF3e8IouW
   aW/zA+hBq4VRGY9motwbkqzU0vkxjgoyMFbO8T611fQFfdGcLXs5jgYOU
   ukI6fzVGLUoQWKy2Lsk5jBDssfFXjvdjXmB2FPEsGFpBzolOLVThULBky
   A/m653gp1YPAZ3y+7RgfT7v5tgtRkFpu521nmd3OgGl7fB+i2T8xWSsMr
   g==;
X-CSE-ConnectionGUID: P4zFqmZoRzy1YrGa63++aQ==
X-CSE-MsgGUID: Ut5bqgx3Qvi8y7jbZMrWIQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11158"; a="38891107"
X-IronPort-AV: E=Sophos;i="6.09,276,1716274800"; 
   d="scan'208";a="38891107"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 06:55:44 -0700
X-CSE-ConnectionGUID: HNMyY+K7TzSrs6VZjAP8ug==
X-CSE-MsgGUID: Gcxom01WTMeHvnEkUCog5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,276,1716274800"; 
   d="scan'208";a="57787766"
Received: from unknown (HELO [10.237.72.57]) ([10.237.72.57])
  by orviesa006.jf.intel.com with ESMTP; 09 Aug 2024 06:55:43 -0700
Message-ID: <2a9f6c23-9c7b-496b-9998-ea0afe526b46@linux.intel.com>
Date: Fri, 9 Aug 2024 16:55:41 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v3 3/6] i3c: mipi-i3c-hci: Add a quirk to set PIO
 mode
To: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Guruvendra Punugupati <Guruvendra.Punugupati@amd.com>,
 Krishnamoorthi M <krishnamoorthi.m@amd.com>, linux-i3c@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240807052359.290046-1-Shyam-sundar.S-k@amd.com>
 <20240807052359.290046-4-Shyam-sundar.S-k@amd.com>
Content-Language: en-US
From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
In-Reply-To: <20240807052359.290046-4-Shyam-sundar.S-k@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi

On 8/7/24 8:23 AM, Shyam Sundar S K wrote:
> The AMD HCI controller currently only supports PIO mode but exposes DMA
> rings to the OS, which leads to the controller being configured in DMA
> mode. To address this, add a quirk to avoid configuring the controller in
> DMA mode and default to PIO mode.
> 
> Additionally, introduce a generic quirk infrastructure to the mipi-i3c-hci
> driver to facilitate seamless future quirk additions.
> 
> Co-developed-by: Krishnamoorthi M <krishnamoorthi.m@amd.com>
> Signed-off-by: Krishnamoorthi M <krishnamoorthi.m@amd.com>
> Co-developed-by: Guruvendra Punugupati <Guruvendra.Punugupati@amd.com>
> Signed-off-by: Guruvendra Punugupati <Guruvendra.Punugupati@amd.com>
> Signed-off-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
> ---

...

> +void amd_i3c_hci_quirks_init(struct i3c_hci *hci)
> +{
> +#if defined(CONFIG_X86)
> +	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD)
> +		hci->quirks |= HCI_QUIRK_PIO_MODE;
> +#endif
> +}

I was thinking these quirks can be passed as driver_data more cleanly 
and be specific only to affected HW if AMD HW would have an unique ACPI 
ID for each HW version.

Above X86_VENDOR_AMD might be too generic if and when quirks are fixed 
in the future HW :-)

So something like:

static const struct acpi_device_id i3c_hci_acpi_match[] = {
	{"AMDI1234", HCI_QUIRK_PIO_MODE | HCI_QUIRK_OD_PP_TIMING | 
HCI_QUIRK_RESP_BUF_THLD},
	{}
};

and set them in the i3c_hci_probe() as:

hci->quirks = (unsigned long)device_get_match_data(&pdev->dev);

