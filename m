Return-Path: <linux-kernel+bounces-554085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF40AA592C2
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 12:31:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B04343A4CF2
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 11:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8780B19F13C;
	Mon, 10 Mar 2025 11:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XG4iVgXz"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776251805A;
	Mon, 10 Mar 2025 11:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741606254; cv=none; b=HRzXP8kNw9SJoOm+4/JL/ua/1YDwtA9tcHy8qg1pRxD+v6sc7m49J2yQdUJoU5vSTBlymy9PpWyfdFTwE37Clr48tMdDqXEAMXHhSe2wYX5+l4yb3uzpN5ECh1o/ts1OjoX6vw+yGnTTXfMac4O0gbkiZv6dLkpAnNR8UNnKt80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741606254; c=relaxed/simple;
	bh=Dgj6SEX5lRYAJLTBu9cYyh2ofDqV7FDTJGHm9kmRnss=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GaqNWsG0AWuyad00rSI4d87luNZ+DmnYhF4je/k7gfqZ2XEERrel4ebnM+yyXHz14h9h7XIuBT/ExyPV8nkGJgyj3IRWDWHirPxUg6aLHfuiO3URQ2e2AexBptiCsR10Z8eedj+oD0R3G7myOPK2LQA5UfjiPw+BQUchL3ouLNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XG4iVgXz; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741606254; x=1773142254;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Dgj6SEX5lRYAJLTBu9cYyh2ofDqV7FDTJGHm9kmRnss=;
  b=XG4iVgXzMleYZTeSMjiTi15CBLfR0F+b7EicooDD/KERhR0I+nq8f0kA
   H5GYLOV17ppgsJOXAx9BCOdnPET6S1gs2WdI17jEgXtknusByawAvLrv8
   qw512hoNUjtmZUyWfUvLRBawl0IC/jTmO7EIZal5HAzIuXFZFucMR/Ov9
   41hfP+wWAOiAO4yrGvUOL5wthm/Hi6kAUUphNUUNop55djK6jkpuf/61I
   kX9vx2o5U5WGbNT0azsqJasa7q5T07mIAlQUoeBQhHMGL/d3GYE3/Cply
   BPbZmDKfzM31F4W/YzM/h+RQ7aSyfwMfG9oOSgPpE7HPhMMKXVeK1i6WI
   Q==;
X-CSE-ConnectionGUID: ADzvcrbeSPKXE0iEWTYkbA==
X-CSE-MsgGUID: xDbFTgEQSwWtSrk0UoOTrQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11368"; a="42448777"
X-IronPort-AV: E=Sophos;i="6.14,235,1736841600"; 
   d="scan'208";a="42448777"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2025 04:30:53 -0700
X-CSE-ConnectionGUID: QJwWIv53Ra+hfKOJGzftNg==
X-CSE-MsgGUID: 8A/GBRLwQ6ejwJn7LM5oqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,235,1736841600"; 
   d="scan'208";a="124574190"
Received: from aslawinx-mobl.ger.corp.intel.com (HELO [10.94.8.107]) ([10.94.8.107])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2025 04:30:47 -0700
Message-ID: <6e892094-ff90-41ef-ac56-b7fcf6abf2a8@linux.intel.com>
Date: Mon, 10 Mar 2025 12:30:45 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/14] ASoC: amd: acp: Refactor dmic-codec platform device
 creation
To: Venkata Prasad Potturu <venkataprasad.potturu@amd.com>,
 broonie@kernel.org, alsa-devel@alsa-project.org
Cc: Vijendar.Mukunda@amd.com, mario.limonciello@amd.com,
 Basavaraj.Hiregoudar@amd.com, Sunil-kumar.Dommati@amd.com,
 syed.sabakareem@amd.com, Liam Girdwood <lgirdwood@gmail.com>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Peter Zijlstra <peterz@infradead.org>, Greg KH <gregkh@linuxfoundation.org>,
 Jeff Johnson <quic_jjohnson@quicinc.com>,
 "open list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..."
 <linux-sound@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
References: <20250310104601.7325-1-venkataprasad.potturu@amd.com>
 <20250310104601.7325-4-venkataprasad.potturu@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Amadeusz_S=C5=82awi=C5=84ski?=
 <amadeuszx.slawinski@linux.intel.com>
In-Reply-To: <20250310104601.7325-4-venkataprasad.potturu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/10/2025 11:45 AM, Venkata Prasad Potturu wrote:
> Refactor dmic-codec platform driver creation using helper function.
> 
> Signed-off-by: Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
> ---
>   sound/soc/amd/acp/acp-pci.c | 49 +++++++++++++++++++++++++------------
>   sound/soc/amd/acp/amd.h     |  1 +
>   2 files changed, 35 insertions(+), 15 deletions(-)
> 

...

>   	addr = pci_resource_start(pci, 0);
>   	chip->base = devm_ioremap(&pci->dev, addr, pci_resource_len(pci, 0));
>   	if (!chip->base) {
>   		ret = -ENOMEM;
> -		goto unregister_dmic_dev;
> +		goto release_regions;
>   	}
>   
>   	chip->acp_hw_ops_init(chip);
>   	ret = acp_hw_init(chip);
>   	if (ret)
> -		goto unregister_dmic_dev;
> +		goto release_regions;
>   

...

> @@ -168,8 +187,8 @@ static int acp_pci_probe(struct pci_dev *pci, const struct pci_device_id *pci_id
>   	pm_runtime_allow(&pci->dev);
>   	return ret;
>   
> -unregister_dmic_dev:
> -	platform_device_unregister(dmic_dev);
> +de_init:
> +	chip->acp_hw_ops->acp_deinit(chip);

On init you call acp_hw_init(), but here you call ->acp_deinit() 
directly instead of acp_hw_deinit()?

>   release_regions:
>   	pci_release_regions(pci);
>   disable_pci:



