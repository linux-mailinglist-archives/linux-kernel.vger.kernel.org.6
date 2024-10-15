Return-Path: <linux-kernel+bounces-365314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4705D99E058
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 10:07:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BAE32821CD
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 08:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B40F1B85D4;
	Tue, 15 Oct 2024 08:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XhkG5Py+"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CFF21B4F3E
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 08:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728979620; cv=none; b=nWwtLwY9NqttjxpSXaAvixSU3sIHW4Xy327bJWraf57uzlypu+Lrl5vHjaXd1YRGnOdvBQcVL/Hc93uzqj1/6IwH5nZBK1gdDaxduTQlcmf370EBwR5VJMrTDKfCV3fBXR/hHHPusoMw4z8PQ5nzl2myFozH3FEGGMoc9PgosQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728979620; c=relaxed/simple;
	bh=2dprieRmK8rkpW+7/3CVZPJ2i3vksh9KUR+silX+sr8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=k6fKrGqwRpBF4TkfWaVzwf+J3PV1agypQnRfvChtK96i86eeGKnyX/EWaTwKSLJwcfjHaSrJTIPLczgrZJOwHV9AU5V62Nx+4+C7oTkWELzhTSB4lXlhUyzxUS46pY9oi8unAj0kC9J9RKj7OoyxU95pMDP1t7vx0/Kp2vzJdj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XhkG5Py+; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728979616; x=1760515616;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=2dprieRmK8rkpW+7/3CVZPJ2i3vksh9KUR+silX+sr8=;
  b=XhkG5Py+p9NtsEkT6tSxwiayQ0BD5bVLZ2X8630a3jS7zfY2Ik2aRsLz
   EUVFKzey9uLuXFr/a7wgdod1xtHNm7L6XApBbYlOhRhZSwYpSdqJaRDPV
   3Iv8WMhPF8kbganAvSPhd45mpr2966fqyWCkj+tjS6fzmyEnj+N1Mv2Yu
   FNnYzGY4upKZMl6zLile+uC2eQ9YoNRn3D5eWWtmsK+nGXNkMzQXfyQdo
   STS+msbEmCILsHY7b6JD93Xwy0FPkfq94cn93IdLW2oVtORSHvBUbKdFT
   qYWaQly/CbkbfiM2JNoHS4bZUCEdAbdAN7CrnlpI76PD79JnNhYcVjS++
   w==;
X-CSE-ConnectionGUID: O21JyTTFRWKf6LjRH9mAog==
X-CSE-MsgGUID: z0+qYSqhTGauDG7EU8VhXw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="38910396"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="38910396"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2024 01:06:56 -0700
X-CSE-ConnectionGUID: 4PEoWR3PRQmptDQYjDN9pA==
X-CSE-MsgGUID: mh2wWuA9Th2QPj4OuAihsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,204,1725346800"; 
   d="scan'208";a="115265001"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2024 01:06:53 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: David Hildenbrand <david@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,  linux-mm@kvack.org,
  linux-kernel@vger.kernel.org,  Guenter Roeck <linux@roeck-us.net>,
  Nathan Chancellor <nathan@kernel.org>,  Arnd Bergmann <arnd@arndb.de>,
  Dan Williams <dan.j.williams@intel.com>,  Jonathan Cameron
 <jonathan.cameron@huawei.com>
Subject: Re: [PATCH] resource: Remove dependency on SPARSEMEM from
 GET_FREE_REGION
In-Reply-To: <942d18c3-f9a8-482e-a166-c7c9d6fb28d7@redhat.com> (David
	Hildenbrand's message of "Tue, 15 Oct 2024 09:07:07 +0200")
References: <20241015051554.294734-1-ying.huang@intel.com>
	<942d18c3-f9a8-482e-a166-c7c9d6fb28d7@redhat.com>
Date: Tue, 15 Oct 2024 16:03:20 +0800
Message-ID: <878qup94jb.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Hi, David,

David Hildenbrand <david@redhat.com> writes:

> On 15.10.24 07:15, Huang Ying wrote:
>> We want to use the functions configured via GET_FREE_REGION in
>> resource kunit tests.  However, GET_FREE_REGION depends on SPARSEMEM.
>> This makes resource kunit tests cannot be built on some architectures
>> lacking SPARSEMEM.  In fact, these functions doesn't depend on
>> SPARSEMEM now.  So, remove dependency on SPARSEMEM from
>> GET_FREE_REGION.
>> Link:
>> https://lore.kernel.org/lkml/20240922225041.603186-1-linux@roeck-us.net/
>> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
>> Tested-by: Guenter Roeck <linux@roeck-us.net>
>> Cc: Nathan Chancellor <nathan@kernel.org>
>> Cc: Arnd Bergmann <arnd@arndb.de>
>> Cc: Dan Williams <dan.j.williams@intel.com>
>> Cc: David Hildenbrand <david@redhat.com>
>> Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
>> ---
>>   mm/Kconfig | 1 -
>>   1 file changed, 1 deletion(-)
>> diff --git a/mm/Kconfig b/mm/Kconfig
>> index 4c9f5ea13271..33fa51d608dc 100644
>> --- a/mm/Kconfig
>> +++ b/mm/Kconfig
>> @@ -1085,7 +1085,6 @@ config HMM_MIRROR
>>   	depends on MMU
>>     config GET_FREE_REGION
>> -	depends on SPARSEMEM
>>   	bool
>>     config DEVICE_PRIVATE
>
> Added by
>
> commit 14b80582c43e4f550acfd93c2b2cadbe36ea0874
> Author: Dan Williams <dan.j.williams@intel.com>
> Date:   Fri May 20 13:41:24 2022 -0700
>
>     resource: Introduce alloc_free_mem_region()
>
> @Dan, any insight why that dependency was added?

Dan has explain it some what in the following email,

https://lore.kernel.org/lkml/66f5abd431dce_964f2294b9@dwillia2-xfh.jf.intel.com.notmuch/

This is reachable from the "Link:" tag in the patch.

--
Best Regards,
Huang, Ying

