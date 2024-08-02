Return-Path: <linux-kernel+bounces-272600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 446CF945E9B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 15:23:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0075A283174
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 13:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 839061E3CB9;
	Fri,  2 Aug 2024 13:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ah8vZqD5"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D981DAC4F
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 13:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722605004; cv=none; b=rCtl8RgLSFJPXio64c4qFemxTjqS5GGhFt1GvnvMbI3MZvnhtqohb95MpT8dx0cM8OXibEFWoyoiICAG9kVvVe3FY6oXZ3dXgMvKOHNBUnx+/dEpwqEqfuDYkmNK57pXXeBGJm8OcWzjUroC8HTnh8GprG6Moide7AjKi3+KcnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722605004; c=relaxed/simple;
	bh=SbzVMvrgqgnN6vDegUB9cL5i+J+RsUNUs2IF58rQ7o4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ejx4S+/qUIkkR6CqdLteGuU8PEXD5AE3aDPxUnQzLPSkEs6Lk3wiz737AbzxC3ifGPaZYEs3FeJ6ROWG1rIRjg9LBBahBwM9mvhcHZJMIK04owQFu66NvEjZiXuUGPzxTq1JPsqAXL6nCNMiuyEUQgTa+6ZUnIlr9wzF81uDVNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ah8vZqD5; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722605003; x=1754141003;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=SbzVMvrgqgnN6vDegUB9cL5i+J+RsUNUs2IF58rQ7o4=;
  b=Ah8vZqD5FgRkMaOP9R3c+HZJG++kEos2N3gTe3KB3u8finU5s/VQdKrM
   1HnoLIDM06CnyCqkAOki522Y4JLhLJ0k6tnYRdrVP35Gje3qQlz+6nlEQ
   UeE3Btg1bLs3aLgOYjuHduE8p74ABnrpVjiuh1uvzSvsGP9EoBqObFgvM
   hgGfKrIZoeg+GagfrUQLgpo92dlXE1tQDxoGEowxa7i4aspFJOlZa/Xm3
   dZ2SIN3JbBSoUnF9sSvn2SBaZ9wiwdDwVG1iWHE4m8WwXpEMgElQ/J2JF
   hXd3LjSrDiy5aB0Q+pBaAyLbnDTO7lDBEUzPxxi7Z0rtwijN37PfnhtHJ
   Q==;
X-CSE-ConnectionGUID: esKcBqMfTMutLzg5439tDw==
X-CSE-MsgGUID: 1U6H6qkbROKxlvcpfsR62A==
X-IronPort-AV: E=McAfee;i="6700,10204,11152"; a="20571622"
X-IronPort-AV: E=Sophos;i="6.09,257,1716274800"; 
   d="scan'208";a="20571622"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2024 06:23:22 -0700
X-CSE-ConnectionGUID: Hi/gxvj9Qeeq8I28/TOxqA==
X-CSE-MsgGUID: 1BjErpSTRxqf4IP9A9RHrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,257,1716274800"; 
   d="scan'208";a="55636314"
Received: from mylly.fi.intel.com (HELO [10.237.72.151]) ([10.237.72.151])
  by orviesa006.jf.intel.com with ESMTP; 02 Aug 2024 06:23:20 -0700
Message-ID: <4808f199-2cc7-4150-ac04-0f36db841f50@linux.intel.com>
Date: Fri, 2 Aug 2024 16:23:19 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] i3c: mipi-i3c-hci: Add MIPI0100 ACPI ID to the I3C
 Support List
To: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Guruvendra Punugupati <Guruvendra.Punugupati@amd.com>,
 Krishnamoorthi M <krishnamoorthi.m@amd.com>, linux-i3c@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240724071245.3833404-1-Shyam-sundar.S-k@amd.com>
 <20240724071245.3833404-2-Shyam-sundar.S-k@amd.com>
Content-Language: en-US
From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
In-Reply-To: <20240724071245.3833404-2-Shyam-sundar.S-k@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi

On 7/24/24 10:12 AM, Shyam Sundar S K wrote:
> The current driver code lacks the necessary plumbing for ACPI IDs,
> preventing the mipi-i3c-hci driver from being loaded on x86
> platforms that advertise I3C ACPI support.
> 
> This update adds the MIPI0100 ACPI ID to the list of supported IDs.
> 
> Signed-off-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
> ---
> MIPI0100 is the ACPI ID as defined in the MIPI I3C DisCo specification.
> 
>   drivers/i3c/master/mipi-i3c-hci/core.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/i3c/master/mipi-i3c-hci/core.c b/drivers/i3c/master/mipi-i3c-hci/core.c
> index d7e966a25583..dbc8c38bd962 100644
> --- a/drivers/i3c/master/mipi-i3c-hci/core.c
> +++ b/drivers/i3c/master/mipi-i3c-hci/core.c
> @@ -826,12 +826,18 @@ static const __maybe_unused struct of_device_id i3c_hci_of_match[] = {
>   };
>   MODULE_DEVICE_TABLE(of, i3c_hci_of_match);
>   
> +static const struct acpi_device_id i3c_hci_acpi_match[] = {
> +	{"MIPI0100"},
> +	{}
> +};
> +
>   static struct platform_driver i3c_hci_driver = {
>   	.probe = i3c_hci_probe,
>   	.remove_new = i3c_hci_remove,
>   	.driver = {
>   		.name = "mipi-i3c-hci",
>   		.of_match_table = of_match_ptr(i3c_hci_of_match),
> +		.acpi_match_table = i3c_hci_acpi_match,
>   	},
>   };
>   module_platform_driver(i3c_hci_driver);

Looks otherwise ok to me but is this missing MODULE_DEVICE_TABLE()?

