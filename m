Return-Path: <linux-kernel+bounces-280992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4966894D1AC
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 15:55:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F162A281074
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 13:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2711195FEF;
	Fri,  9 Aug 2024 13:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E9Dmo0fw"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A6B19597F
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 13:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723211668; cv=none; b=rSwUmbKUFdF4E2lDCr9o60durZhPpTXYzckdF/0YLLrrBmSsU4qtXQ0VuHQtqCWhkkgpoOWeq4Pb4ky4vB1/zs/sAmCHsKUscHbtJYHsD1mNgWqAxKWATe9ar/YCdfHPNd/stL8hsoM/oEuIiiGX0psJ6QB+u0+0wCx4l8jK0FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723211668; c=relaxed/simple;
	bh=GQAmDMevSFWVakuf2z9ooWzz8BNB5oGbvOF1VJq1nYM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i8Pfw6CDVAlYb9tfs1OQ3dKV0YiWgobARbH7pTNrDN3kSxgUk4wZuVYCd6MMuZUq3KkNwle/QX5/rVyqniTH9MRsbfDYRzsWgkqLhrUq/vg0jABWbAuF0byWWvB5ozNbIhOfh2TPSQacvvVHe8p+3uBlbawpuOiyjMESxG/Kwy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E9Dmo0fw; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723211666; x=1754747666;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=GQAmDMevSFWVakuf2z9ooWzz8BNB5oGbvOF1VJq1nYM=;
  b=E9Dmo0fwme0Qeiku0wl2KeKkswmLGW3Q1cNnDmuRym7+dnNPdsBL41A1
   hab39pkLa5G379w4R4Ud8epwAPwIUpUt1b09EM477iRHSci8CIMdIgcyw
   l9LIiKou9rkaieNWzkk/7x6g+eCDbHJdAEmVzdYQ2B4EQcr5X9zK1lB6A
   RoISstzPdpDz8Edenw5W/1mH8ooJ3/IojTX8DdLzaMfehJrrqUt+yzjO0
   7rySkdEWiupdDrA1zRX9MzRpePVlmIOx2sClJ5wK5jqf55qL/cggImFjS
   uAgiY39rVQlvILQEO+5SrxcvTQS7d7qjYnSXBEhdnq7p518qpJkIFUNLx
   A==;
X-CSE-ConnectionGUID: PtA0NDNaQbqdRS2Ajk+mbw==
X-CSE-MsgGUID: JWEp38xHSZ+cvynOoPetfQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11158"; a="38890981"
X-IronPort-AV: E=Sophos;i="6.09,276,1716274800"; 
   d="scan'208";a="38890981"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 06:54:23 -0700
X-CSE-ConnectionGUID: AHPjV8aYSXStf+dyrMH8Yw==
X-CSE-MsgGUID: DPrllZEEShK4RsT0b3I0oA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,276,1716274800"; 
   d="scan'208";a="57787447"
Received: from unknown (HELO [10.237.72.57]) ([10.237.72.57])
  by orviesa006.jf.intel.com with ESMTP; 09 Aug 2024 06:54:20 -0700
Message-ID: <e94efd42-bc3f-4003-8ad8-2da6500f0f13@linux.intel.com>
Date: Fri, 9 Aug 2024 16:54:18 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v3 1/6] i3c: mipi-i3c-hci: Add MIPI0100 ACPI ID to
 the I3C Support List
To: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Guruvendra Punugupati <Guruvendra.Punugupati@amd.com>,
 Krishnamoorthi M <krishnamoorthi.m@amd.com>, linux-i3c@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>
References: <20240807052359.290046-1-Shyam-sundar.S-k@amd.com>
 <20240807052359.290046-2-Shyam-sundar.S-k@amd.com>
Content-Language: en-US
From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
In-Reply-To: <20240807052359.290046-2-Shyam-sundar.S-k@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi

I Cc'ed Andy and Rafael because of ACPI ID allocation question that came 
to my mind below which I'm not expert enough to answer.

On 8/7/24 8:23 AM, Shyam Sundar S K wrote:
> The current driver code lacks the necessary plumbing for ACPI IDs,
> preventing the mipi-i3c-hci driver from being loaded on x86
> platforms that advertise I3C ACPI support.
> 
> This update adds the MIPI0100 ACPI ID to the list of supported IDs.
> 
> Signed-off-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
> ---
>   drivers/i3c/master/mipi-i3c-hci/core.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/i3c/master/mipi-i3c-hci/core.c b/drivers/i3c/master/mipi-i3c-hci/core.c
> index 4e7d6a43ee9b..24dd4603d6c6 100644
> --- a/drivers/i3c/master/mipi-i3c-hci/core.c
> +++ b/drivers/i3c/master/mipi-i3c-hci/core.c
> @@ -834,12 +834,19 @@ static const __maybe_unused struct of_device_id i3c_hci_of_match[] = {
>   };
>   MODULE_DEVICE_TABLE(of, i3c_hci_of_match);
>   
> +static const struct acpi_device_id i3c_hci_acpi_match[] = {
> +	{"MIPI0100"},
> +	{}
> +};

I started thinking that because of quirks would AMD need to allocate an 
own ACPI ID for each of your HW version and not use generic MIPI ID?

Then passing AMD specific quirks would be easy via driver_data here.



