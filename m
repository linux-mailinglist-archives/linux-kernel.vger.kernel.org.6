Return-Path: <linux-kernel+bounces-405522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 097249C5265
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 10:49:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2662283660
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 09:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AEA420EA3E;
	Tue, 12 Nov 2024 09:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z21vGaR8"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC1C20E021
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 09:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731404918; cv=none; b=FK1M6BhAZHwKpklAgeCSO2OPy8BZp259BEtlZgyrHrhN1/U4jFpmvYCcuFwD45lvXF8Nvs5DHOcgxQI1j72dFuG+ebFmEMOwHQ13Songbnn0pwMw4xTHW57y2q0qVaPv4Z83mk8bcUUjieuMl8qsiLRJoNJO2r8bOP3GGH4wPkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731404918; c=relaxed/simple;
	bh=RkKDAdWbtMOyFm3KjYTYuPWh4xG/YdpIQsa4yIHFMPA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=okYHvRIOfN+1P1HOQCBiekWKHOd0XTlu1WGpS8+ViiNnDpnHu3QCiwFD05ujpDAi4LgsmRWu0SisvQwg7XwWpJN5WCt5Etp5DxAnH1NJJSsADOeKRBi+DB5oVFMr1E8aZLUChsk7Op7M2nt5E/0Gj45i4045jaVv18y7RM668e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z21vGaR8; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731404917; x=1762940917;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=RkKDAdWbtMOyFm3KjYTYuPWh4xG/YdpIQsa4yIHFMPA=;
  b=Z21vGaR8S0bxLg7pv+7UjCIaJ4xY8SIWH4ff5U78pS8jLPtCp5bzqVS9
   KH3SQnIfvq/wBzgg+OWh47YAfot8Zx1uB1H3OtLfyfjg/zXPUlUJECiKV
   Ur9AzXPLVUOEYUR90n9oTxe5gqW8j8qDf4b6B/qjMrgbXzTvJuT/dRXqJ
   psIUCVpSl6prtNEVAxzZl1oZdabYYhGIvUIN8itHFqDa2xB3nMDsSXlFO
   j22woOleuP0fI4wA4vZJUWLQ5GzIIMTzTbMJkHd/qPxHSShCOS/SvQTxR
   f7Zd+2SJ1/J8Mnv8IXNb/dFKRAjOPXcfCbHPvmFMsWQQGy9cMpbXv6Avn
   A==;
X-CSE-ConnectionGUID: 0lfzYO3JQCu2JvypOXrc1g==
X-CSE-MsgGUID: Rp9B4kQFSru/7nqJCeTdLw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="31191821"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="31191821"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2024 01:48:37 -0800
X-CSE-ConnectionGUID: PJ+V/aM9QDiOp18bTYckeQ==
X-CSE-MsgGUID: IvMFK4y9TI6najQuKH7BsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,147,1728975600"; 
   d="scan'208";a="91394037"
Received: from mylly.fi.intel.com (HELO [10.237.72.151]) ([10.237.72.151])
  by fmviesa003.fm.intel.com with ESMTP; 12 Nov 2024 01:48:35 -0800
Message-ID: <eaca7890-af22-4913-9758-53846ad1ec79@linux.intel.com>
Date: Tue, 12 Nov 2024 11:48:34 +0200
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
 <09cfdd95-c566-4379-be17-2d5e0f0e8357@linux.intel.com>
 <507a8af4-f128-4d73-9d0f-b8a6a15603d3@amd.com>
Content-Language: en-US
From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
In-Reply-To: <507a8af4-f128-4d73-9d0f-b8a6a15603d3@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi

On 11/12/24 10:48 AM, Shyam Sundar S K wrote:
>> Am I right this and patch 5/5 can be independent from rest of the series?
> 
> Right. 1/5 and 5/5 can be grouped. But rest of the other patches are
> equally important because they drive the usecase.
> 
>>
>> To me it looks these two patches enable bus communication and thus be
>> useful without rest of the series while latter need more discussion
>> (I'll have some notes coming) and Cc'ing linux-acpi.
> 
> I have Cc'ed linux-acpi in this revision. Do you have any feedback for
> patches 2-4 ?
> 
Yes, I'm reviewing them and only the patch 2/5 was Cc'ed to linux-acpi.

Patchset split would serve better in my opinion enabling basic 
communication and have an other set concentrating more complex scenario 
we were try to get input from ACPI folks.

