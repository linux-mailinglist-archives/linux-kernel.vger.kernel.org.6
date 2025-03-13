Return-Path: <linux-kernel+bounces-559043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEE82A5EEB2
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 09:59:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23A823AF922
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 08:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57B0326388E;
	Thu, 13 Mar 2025 08:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zoqv8Tho"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D332627E8;
	Thu, 13 Mar 2025 08:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741856380; cv=none; b=aqgoU+zi8siWTVTqJRrhsPT9fCOlfphCAizC54wnip6DFQqS6lzPKKLx9WtbbzBaoxwK/8sMX5pyoJZZK1f6R0h+rCCyr8pIMUQlQxnqsWQaWWponuTzmn1ZSZvR4CaaTY+cIVH7JBuERlPvOEPY/XBUFAFhEVmfHQB8XFvT4Eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741856380; c=relaxed/simple;
	bh=i4tUZd9erZBD5LlwfVkopEm5j1Y60T1nD7KX1mvmhCs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LR8DOeKVExIG20zedFmOEgjtRiscgFibFX/M0ks3k1+Nn7sAC6Af2M3EGXoFh+UV9EGvQNw8Y3X19MC17FoMzjqsfuyJ4/fjjTrrp6tNCROoM99WTSz4Q4+5Ub0leU4oNICFtOHovSg4Olz8qkI/WFHrtqRRQs7zPIWR++Hu4wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zoqv8Tho; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741856379; x=1773392379;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=i4tUZd9erZBD5LlwfVkopEm5j1Y60T1nD7KX1mvmhCs=;
  b=Zoqv8ThomRLXw7zPTmVyUXsptOJiG3AQTG5A2B/+ZUQaeMFoVQZO5kHb
   I6fFQQRkxZGGCE87ed6hw7EYi0VMe1iGCEsBbtuhkYq4LVh0HrkcLOnme
   dKZVUbwiRLcBjAT8d3mJ9Qd9O9zzMNAscz7gNhJ3zh3aALxqsWzwx1pj+
   cWFGrstCww+bfmVCkjAxd+0KH1Y6Lb93ZVm6Ubi0UPfa30COVUBGg0WyU
   wVzHfNCgCEsjw5RZ4hOtCfK0WCYPXQRKYF0ZiiMmIDQNjukeMCwr5bUOP
   zSzWWX/WqHYDP7isP+6gCiGRght7VNs1+WuPt1FB20cAfn4qTKvm319MJ
   A==;
X-CSE-ConnectionGUID: 4B/3InGARiWyVtzK76PfgA==
X-CSE-MsgGUID: wQAFC65RTeiPxPLxUkpQ/g==
X-IronPort-AV: E=McAfee;i="6700,10204,11371"; a="42992278"
X-IronPort-AV: E=Sophos;i="6.14,244,1736841600"; 
   d="scan'208";a="42992278"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 01:59:38 -0700
X-CSE-ConnectionGUID: N5ctUkCQQzWvq5uci93o+A==
X-CSE-MsgGUID: mf+xTRd3QPyW53E7a5R3Mg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,244,1736841600"; 
   d="scan'208";a="121384004"
Received: from choongyo-mobl.gar.corp.intel.com (HELO [10.247.100.100]) ([10.247.100.100])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 01:59:27 -0700
Message-ID: <21d10c76-6f8b-4050-aa7d-59b12b3c5e85@linux.intel.com>
Date: Thu, 13 Mar 2025 16:59:21 +0800
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
 <dbac683e-ab8d-440f-8013-f0ff2287a5ff@linux.intel.com>
 <CAHp75VeLhHh_xhxUb5fsk71ck_m9SGUeXjH8taq+JYjEpHdk2Q@mail.gmail.com>
Content-Language: en-US
From: Choong Yong Liang <yong.liang.choong@linux.intel.com>
In-Reply-To: <CAHp75VeLhHh_xhxUb5fsk71ck_m9SGUeXjH8taq+JYjEpHdk2Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 12/3/2025 10:00 pm, Andy Shevchenko wrote:
> On Wed, Mar 12, 2025 at 1:23 PM Choong Yong Liang
> <yong.liang.choong@linux.intel.com> wrote:
>> On 12/3/2025 3:54 pm, Andy Shevchenko wrote:
>>> On Wed, Mar 12, 2025 at 4:30 AM Choong Yong Liang
>>> <yong.liang.choong@linux.intel.com> wrote:
> 
> ...
> 
>> Thank you for your detailed feedback and suggestions. I'll make the
>> necessary adjustments to the patch based on your comments above.
>>
>>>> Signed-off-by: David E. Box <david.e.box@linux.intel.com>
>>>> Signed-off-by: Choong Yong Liang <yong.liang.choong@linux.intel.com>
>>>
>>> This is wrong as either it's a wrong tag (SoB --> Suggested-by?), or
>>> missing Co-developed-by, or wrong order (but in that case David should
>>> have sent the patch).
>>>
>> I believe the sequence is still correct, as the solution was provided by
>> David, and he should be the main author. I'm just the submitter, so my
>> sign-off should be placed last.
> 
> You are the submitter *and* the author in this case. As I said, that
> SoB chain is wrong in its current form.
> 
Hi Andy,

I believe this time I have correctly attributed the authorship by following 
the guide from:
https://docs.kernel.org/process/submitting-patches.html#when-to-use-acked-by-cc-and-co-developed-by
---
From: David E. Box <david.e.box@linux.intel.com>

<changelog>

Signed-off-by: David E. Box <david.e.box@linux.intel.com>
Co-developed-by: Choong Yong Liang <yong.liang.choong@linux.intel.com>
Signed-off-by: Choong Yong Liang <yong.liang.choong@linux.intel.com>
---

