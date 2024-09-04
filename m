Return-Path: <linux-kernel+bounces-316063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17E5A96CAAF
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 01:06:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97D0D1F274C4
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 23:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B2A317ADE3;
	Wed,  4 Sep 2024 23:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DqpMlRrp"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 713831372;
	Wed,  4 Sep 2024 23:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725491202; cv=none; b=VAWdAshBDroG+qQMX60QDQHZ9Z/U1dbmRlkr77fIcMBAM51+gCcLPHc65Q5+IQd2KmQLmoG6mTKQeLZ+3LZfjhS6hK28RfCH9Fp/Hf0bXV6LNr3hfG7u+BivJOL76nEwSR0QpI95ZduZMsikyd7IOGjgWcAeJi5DGBV/QB5AAhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725491202; c=relaxed/simple;
	bh=jUQ2jbgF4Phafd6slQbdao1PXMmbCCsziIIQqwTkn5Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B6j9JgzLgnWINEhzkiqrdu0SO2x7+xJaOglggrirqUKqBfov9rJeyqY3o5/kbeWkY/F6R0k1tF8KBhfEAg1rldfMnNrCk+ukAKjBeBZ3jdCfYI5QqcwSJEjOABjKs8lA8sghlHdMDGKSWjVoScEyGMMLa2PU5KWunPD9qOfktws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DqpMlRrp; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725491200; x=1757027200;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=jUQ2jbgF4Phafd6slQbdao1PXMmbCCsziIIQqwTkn5Q=;
  b=DqpMlRrpJMEKHQCOmDIU2JhgLTefmjpvKxRFpuOkhzx5ivyvSo/m7QY+
   gFwg6CCAtut+T3jXWlvnbxLHxktrZY91V+onLrv0SAx61UJHldY1b2Ihd
   cXfiwHM4X95a3+ZFvXnXW0vENimID2MmCiLHsyH12pPKVyb4b9c1mIVG5
   tjeuTcFSjqaDRRhk5kByhjAm4+ErF+XgB03F82DKsa6IDnBbEETZZkgvE
   vjW0kwLUdCvaT9jg0X8nwBTF/2nKg7f+aEUjpZxAepXy2GznnZ9HSIiEF
   eV13rUYiMEt4X0ZmK4COcwabHnPSo3wvlUwOm1fEFIhc8/PhNAi7y7j5T
   w==;
X-CSE-ConnectionGUID: s70Wb2dkQxGB50IwEtEgWw==
X-CSE-MsgGUID: FwXJWyZSTJu9Wfb4iGKu/w==
X-IronPort-AV: E=McAfee;i="6700,10204,11185"; a="34783234"
X-IronPort-AV: E=Sophos;i="6.10,203,1719903600"; 
   d="scan'208";a="34783234"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2024 16:06:39 -0700
X-CSE-ConnectionGUID: ob7Ntml/TKSv7p89o6i6Aw==
X-CSE-MsgGUID: QKjdx+GyQ0O10RcKZkUX7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,203,1719903600"; 
   d="scan'208";a="65412520"
Received: from xpardee-mobl.amr.corp.intel.com (HELO [10.125.100.132]) ([10.125.100.132])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2024 16:06:39 -0700
Message-ID: <475c7d70-c27e-4937-84f6-f85a464a467e@linux.intel.com>
Date: Wed, 4 Sep 2024 16:06:23 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] platform/x86:intel/pmc: Ignore all LTRs during suspend
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: irenic.rajneesh@gmail.com, david.e.box@linux.intel.com,
 Hans de Goede <hdegoede@redhat.com>, platform-driver-x86@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>
References: <20240808205551.403770-1-xi.pardee@linux.intel.com>
 <0332a6a1-840b-576c-fe81-f1a690d0dd9a@linux.intel.com>
Content-Language: en-US
From: Xi Pardee <xi.pardee@linux.intel.com>
In-Reply-To: <0332a6a1-840b-576c-fe81-f1a690d0dd9a@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

On 8/30/2024 2:53 AM, Ilpo Järvinen wrote:
> On Thu, 8 Aug 2024, Xi Pardee wrote:
>
>> From: Xi Pardee <xi.pardee@intel.com>
>>
>> Add support to ignore all LTRs before suspend and restore the previous
>> LTR values after suspend. This feature could be turned off with module
>> parameter ltr_ignore_all_suspend.
> This does not answer why? question.

I will add the reason to commit message in next version.

>
>> Suggested-by: Rafael J. Wysocki<rafael.j.wysocki@intel.com>
> Please add a space between the name and email.
>
> This patch seems to have fallen through cracks and did not appear in the
> patchwork at all.
Will add a space between the name and email.
>
>> Signed-off-by: Xi Pardee <xi.pardee@intel.com>
>> ---
>>   drivers/platform/x86/intel/pmc/core.c | 53 +++++++++++++++++++++++++++
>>   drivers/platform/x86/intel/pmc/core.h |  2 +
>>   2 files changed, 55 insertions(+)
>>
>> diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
>> index 01ae71c6df59..f364a011721d 100644
>> --- a/drivers/platform/x86/intel/pmc/core.c
>> +++ b/drivers/platform/x86/intel/pmc/core.c
>> @@ -714,6 +714,49 @@ static int pmc_core_s0ix_blocker_show(struct seq_file *s, void *unused)
>>   }
>>   DEFINE_SHOW_ATTRIBUTE(pmc_core_s0ix_blocker);
>>   
>> +static void pmc_core_ltr_ignore_all(struct pmc_dev *pmcdev)
>> +{
>> +	unsigned int i;
>> +
>> +	for (i = 0; i < ARRAY_SIZE(pmcdev->pmcs); i++) {
>> +		struct pmc *pmc;
>> +		u32 ltr_ign;
>> +
>> +		pmc = pmcdev->pmcs[i];
>> +		if (!pmc)
>> +			continue;
>> +
>> +		guard(mutex)(&pmcdev->lock);
>> +		pmc->ltr_ign = pmc_core_reg_read(pmc, pmc->map->ltr_ignore_offset);
>> +
>> +		/* ltr_ignore_max is the max index value for ltr ignore register */
> ltr -> LTR
Will change it in next version.
>
>> +		ltr_ign = pmc->ltr_ign | GENMASK(pmc->map->ltr_ignore_max, 0);
>> +		pmc_core_reg_write(pmc, pmc->map->ltr_ignore_offset, ltr_ign);
>> +	}
>> +
>> +	/*
>> +	 * Ignoring ME during suspend is blocking platforms with ADL PCH to get to
>> +	 * deeper S0IX substate.
> S0ix
>
> --
>   i.

Will change it in next version.

Thanks!

Xi

>
>> +	 */
>> +	pmc_core_send_ltr_ignore(pmcdev, 6, 0);
>> +}
>> +
>> +static void pmc_core_ltr_restore_all(struct pmc_dev *pmcdev)
>> +{
>> +	unsigned int i;
>> +
>> +	for (i = 0; i < ARRAY_SIZE(pmcdev->pmcs); i++) {
>> +		struct pmc *pmc;
>> +
>> +		pmc = pmcdev->pmcs[i];
>> +		if (!pmc)
>> +			continue;
>> +
>> +		guard(mutex)(&pmcdev->lock);
>> +		pmc_core_reg_write(pmc, pmc->map->ltr_ignore_offset, pmc->ltr_ign);
>> +	}
>> +}
>> +
>>   static inline u64 adjust_lpm_residency(struct pmc *pmc, u32 offset,
>>   				       const int lpm_adj_x2)
>>   {
>> @@ -1479,6 +1522,10 @@ static bool warn_on_s0ix_failures;
>>   module_param(warn_on_s0ix_failures, bool, 0644);
>>   MODULE_PARM_DESC(warn_on_s0ix_failures, "Check and warn for S0ix failures");
>>   
>> +static bool ltr_ignore_all_suspend = true;
>> +module_param(ltr_ignore_all_suspend, bool, 0644);
>> +MODULE_PARM_DESC(ltr_ignore_all_suspend, "Ignore all LTRs during suspend");
>> +
>>   static __maybe_unused int pmc_core_suspend(struct device *dev)
>>   {
>>   	struct pmc_dev *pmcdev = dev_get_drvdata(dev);
>> @@ -1488,6 +1535,9 @@ static __maybe_unused int pmc_core_suspend(struct device *dev)
>>   	if (pmcdev->suspend)
>>   		pmcdev->suspend(pmcdev);
>>   
>> +	if (ltr_ignore_all_suspend)
>> +		pmc_core_ltr_ignore_all(pmcdev);
>> +
>>   	/* Check if the syspend will actually use S0ix */
>>   	if (pm_suspend_via_firmware())
>>   		return 0;
>> @@ -1594,6 +1644,9 @@ static __maybe_unused int pmc_core_resume(struct device *dev)
>>   {
>>   	struct pmc_dev *pmcdev = dev_get_drvdata(dev);
>>   
>> +	if (ltr_ignore_all_suspend)
>> +		pmc_core_ltr_restore_all(pmcdev);
>> +
>>   	if (pmcdev->resume)
>>   		return pmcdev->resume(pmcdev);
>>   
>> diff --git a/drivers/platform/x86/intel/pmc/core.h b/drivers/platform/x86/intel/pmc/core.h
>> index ea04de7eb9e8..e862ea88b816 100644
>> --- a/drivers/platform/x86/intel/pmc/core.h
>> +++ b/drivers/platform/x86/intel/pmc/core.h
>> @@ -372,6 +372,7 @@ struct pmc_info {
>>    * @map:		pointer to pmc_reg_map struct that contains platform
>>    *			specific attributes
>>    * @lpm_req_regs:	List of substate requirements
>> + * @ltr_ign:		Holds LTR ignore data while suspended
>>    *
>>    * pmc contains info about one power management controller device.
>>    */
>> @@ -380,6 +381,7 @@ struct pmc {
>>   	void __iomem *regbase;
>>   	const struct pmc_reg_map *map;
>>   	u32 *lpm_req_regs;
>> +	u32 ltr_ign;
>>   };
>>   
>>   /**
>>

