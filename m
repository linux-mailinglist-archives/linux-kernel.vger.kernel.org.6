Return-Path: <linux-kernel+bounces-557593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ED9BA5DB50
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 12:24:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C03D8176F21
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 11:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CBC123F289;
	Wed, 12 Mar 2025 11:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D8QK1xHf"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE4E22E412;
	Wed, 12 Mar 2025 11:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741778637; cv=none; b=S2K2pvq0tZeAIPKDKVVTkxKqKZEAeOU8oluljlh6eTUxEg4z+ungmzGGsk7hKEp4RWLQcOjqxOIAzbTM0DUEzGdKmJwY9oer31D0UzFBA3hJiNwEaBU0GupBF/NVprjMzwcy2brZjEsBgWVa4eNuee7SD0fOE03vaxuvr3k84As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741778637; c=relaxed/simple;
	bh=nkXn2uiDrymeGsZPI5IKOX7wacIgBnNg9h/570TJwIA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FogOm9vveFHXc3RZI/xHjyCcVg45/f95dehO8Ny6RN4A/Tf8Jln4Frm4eeNavaQEwmRyxX4fjX9nS+XrO3uOtcg5X/Cm0SSRA2E5PF9s8GH4U1j1EOZZ18kss7w9HUQWIduG6c3yP2+9gJmFQeNTmdlH2YUrPEdbP7K2W87SEFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D8QK1xHf; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741778636; x=1773314636;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=nkXn2uiDrymeGsZPI5IKOX7wacIgBnNg9h/570TJwIA=;
  b=D8QK1xHfz0dldAc/fQj4Wpzwik4IF1HmAh/XFDCWgMVkwS6DVHvtkF7O
   Wg3XCMPn7ZjRbynQBMI5+OBTGobqOfD7CNokqx//mB6jorVfYZWNZamWr
   RFZAUGKt6OVKq9DmBpD43QgOoavGHshJJ/X578G9XWhIdMeVinc/IrO1F
   38qOdbpudGwRdYnE/csJ5MjC1N9IuCBMtbJblV89Q0TJnRX38R/ESfi3m
   90lUVnMN+SeVhsH+NTDg+HV6cZUQ3c7Rf6P1RvxeJBzVuhCrMdmZebcr0
   mHeyNe4U48fYkE/nZH4H06vthzA7psDT4kCiCJ2aAbgQMLCM0WRHboBKr
   g==;
X-CSE-ConnectionGUID: GxZbpK13T8GvVdTJZbBxHg==
X-CSE-MsgGUID: gRSN4oQFTEu0mptPe4Iz/w==
X-IronPort-AV: E=McAfee;i="6700,10204,11370"; a="42726459"
X-IronPort-AV: E=Sophos;i="6.14,241,1736841600"; 
   d="scan'208";a="42726459"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 04:23:54 -0700
X-CSE-ConnectionGUID: X7T83XnzRM+w7UpJqjmQJw==
X-CSE-MsgGUID: Z7yurOyPSfe34ZD3+u0/jw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,241,1736841600"; 
   d="scan'208";a="120424246"
Received: from choongyo-mobl.gar.corp.intel.com (HELO [10.247.21.123]) ([10.247.21.123])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 04:23:53 -0700
Message-ID: <dbac683e-ab8d-440f-8013-f0ff2287a5ff@linux.intel.com>
Date: Wed, 12 Mar 2025 19:23:49 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] platform/x86: intel_pmc_ipc: add option to build
 without ACPI
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 David E Box <david.e.box@linux.intel.com>,
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250312022955.1418234-1-yong.liang.choong@linux.intel.com>
 <CAHp75VekTbp++4yw4yDhtB96K+C0w1uHiVih5x-jO+TWRLiPmw@mail.gmail.com>
Content-Language: en-US
From: Choong Yong Liang <yong.liang.choong@linux.intel.com>
In-Reply-To: <CAHp75VekTbp++4yw4yDhtB96K+C0w1uHiVih5x-jO+TWRLiPmw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 12/3/2025 3:54 pm, Andy Shevchenko wrote:
> On Wed, Mar 12, 2025 at 4:30 AM Choong Yong Liang
> <yong.liang.choong@linux.intel.com> wrote:
> 
> Thank you, my comments below.
> 
>> This patch introduces a configuration option that allows users to
> 
> s/This patch introduces/Introduce/
> 
>> build the intel_pmc_ipc driver without ACPI support. This is useful
>> for systems where ACPI is not available or desired.
>>
>> Based on the discussion from the patch: https://patchwork.kernel.org/
>> project/netdevbpf/patch/20250227121522.1802832-6-
>> yong.liang.choong@linux.intel.com/#26280764, it was necessary to
>> provide this option to accommodate specific use cases.
> 
> Make it a Link tag, like
> 
> "...from the patch [1], it was..."
> 
> 
> Link: https://.... [1]
> 
> 
Hi Andy,

Thank you for your detailed feedback and suggestions. I'll make the 
necessary adjustments to the patch based on your comments above.

>> Signed-off-by: David E. Box <david.e.box@linux.intel.com>
>> Signed-off-by: Choong Yong Liang <yong.liang.choong@linux.intel.com>
> 
> This is wrong as either it's a wrong tag (SoB --> Suggested-by?), or
> missing Co-developed-by, or wrong order (but in that case David should
> have sent the patch).
> 
I believe the sequence is still correct, as the solution was provided by 
David, and he should be the main author. I'm just the submitter, so my 
sign-off should be placed last.
> ...
> 
>> +#if CONFIG_ACPI
> 
> Better to have #ifdef, but see below
> 
>>   static inline int intel_pmc_ipc(struct pmc_ipc_cmd *ipc_cmd, struct pmc_ipc_rbuf *rbuf)
>>   {
> 
>>   }
>> +#else
>> +static inline int intel_pmc_ipc(struct pmc_ipc_cmd *ipc_cmd, struct pmc_ipc_rbuf *rbuf)
>> +{ return -ENODEV; }
>> +#endif /* CONFIG_ACPI */
> 
> Since it's already static inline, it might be more natural to have
> this inside the function. The current is usually used for the C impl.
> + static inline stub, like
> 
> #ifdef FOO
> int foo(...);
> #else
> static inline int foo(...) { return ... }
> #endif
> 
> But I'm not insisting, it's up to the PDx86 maintainers.
> 
Sure, let's wait for more feedback.

