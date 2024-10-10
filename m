Return-Path: <linux-kernel+bounces-358353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D2149997D88
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 08:44:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 897D01F21E0D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 06:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18D641A2645;
	Thu, 10 Oct 2024 06:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ayo7pxAT"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8533D6B
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 06:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728542652; cv=none; b=d/9AJDhL8XbLNAPeb8xEVIJ+5hMthnXhq/Hcty/6BKmcx3f1HAzT/IQ3wcjIT71xJUzdOEkirTG+i4CNzrUADxuCfECR8e5MtkRhx/3vCZy2NYVizU+7yauK93bo25FqlAY+RBxe14UQME5PI/Lpg/8vrWbUMwLhpWLWrHwv+/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728542652; c=relaxed/simple;
	bh=YAHRpt+dmbz7sMPu4+k71akkIOEsujpxHsNAzS56y7k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=elHWLi24O+CrdALhmYqLVhnPmjR/vBjQB9pn59w8SNjlwDA6ZlJZxUiV0vHQvrbyzFkTBlZ8K2m63c3JOAX/1XG4e5LZ7Tj5MGpj+efAaQ646XxjLikQpwy3MrFrHZ+qb3FW5aLnv7jaQugGRzD8Gq8ITH/NO55XBcvjodER61w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ayo7pxAT; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728542651; x=1760078651;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=YAHRpt+dmbz7sMPu4+k71akkIOEsujpxHsNAzS56y7k=;
  b=ayo7pxATwl+0X1OQOVwvYS+ldLDUh0LatEdbzspk6KOLtWLewiRRSqiR
   Rj/PSP+PtY5XqX3wHPtesg26o05IP7vPrV5n4i3TAvU4VlirZiJ8TdE8j
   vO6rtMIop72epXOU1cdLL7XBTj7X3Hayddgq4kYaQDVlsbWQC5/Nl6A7+
   Z/oKY5kNXjskagaedTkAmC2Xod78nX/R+s1xPHKR9GnAneqc8grESo1oq
   7giTeAtWbmQNKEm8jV5qQBPxG6yfDDu8ICe8+03LcHLKwfpL+a++DSssL
   IJMdJI2+r+G12UGzZERrBn5DXfBki9/ehf6GHA2LTqDNyiojF27f7rnAg
   Q==;
X-CSE-ConnectionGUID: Kev1gwRxRyaALBRqzkrBIw==
X-CSE-MsgGUID: 56iGdct4SbCulWepD1jhSQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11220"; a="28037654"
X-IronPort-AV: E=Sophos;i="6.11,192,1725346800"; 
   d="scan'208";a="28037654"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2024 23:44:10 -0700
X-CSE-ConnectionGUID: ASNkDfcJSvuUkWlmHsG0mw==
X-CSE-MsgGUID: QqXtysY0TKavBLRRdBXGPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,192,1725346800"; 
   d="scan'208";a="81291166"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2024 23:44:08 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,  Andrew Morton
 <akpm@linux-foundation.org>,  linux-kernel@vger.kernel.org,  Linus
 Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] resource, kunit: add dependency on SPARSEMEM
In-Reply-To: <0247886e-595e-4774-b515-ff628966f2be@roeck-us.net> (Guenter
	Roeck's message of "Mon, 23 Sep 2024 19:41:53 -0700")
References: <20240922225041.603186-1-linux@roeck-us.net>
	<CAMuHMdWAuQcFQaQNy2EP_u9vk13g2C3sb3FFBCMAUPyGMgZ+hg@mail.gmail.com>
	<435dc218-f7ea-4697-b3ef-6a786e8d1b2c@roeck-us.net>
	<87msjxu9qr.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<0247886e-595e-4774-b515-ff628966f2be@roeck-us.net>
Date: Thu, 10 Oct 2024 14:40:35 +0800
Message-ID: <878quwbgv0.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi, Guenter,

Guenter Roeck <linux@roeck-us.net> writes:

> On 9/23/24 18:21, Huang, Ying wrote:
>> Guenter Roeck <linux@roeck-us.net> writes:
>>=20
>>> On 9/23/24 05:58, Geert Uytterhoeven wrote:
>>>> Hi G=C3=BCnter,
>>>> On Mon, Sep 23, 2024 at 12:50=E2=80=AFAM Guenter Roeck <linux@roeck-us=
.net>
>>>> wrote:
>>>>> Building allmodconfig images on systems with SPARSEMEM=3Dn results in
>>>>> the following message.
>>>>>
>>>>> WARNING: unmet direct dependencies detected for GET_FREE_REGION
>>>>>     Depends on [n]: SPARSEMEM [=3Dn]
>>>>>     Selected by [m]:
>>>>>     - RESOURCE_KUNIT_TEST [=3Dm] && RUNTIME_TESTING_MENU [=3Dy] && KU=
NIT [=3Dm]
>>>>>
>>>>> and the build ultimately fails.
>>>> Really? What's the build error?
>>>
>>> I saw it on hexagon, and I didn't bother writing down the actual build =
error
>>> message. But it turns out you are correct, the m68k machine does build =
with
>>> CONFIG_RESOURCE_KUNIT_TEST=3Dy even though SPARSEMEM and with it GET_FR=
EE_REGION
>>> are not set. Never mind, I don't really want or have time to argue. I'l=
l just
>>> disable CONFIG_RESOURCE_KUNIT_TEST when building hexagon images and whe=
rever
>>> else I see the problem.
>>>
>>>> It does build for me on m68k, after fixing:
>>>>       --- a/include/linux/mm.h
>>>>       +++ b/include/linux/mm.h
>>>>       @@ -101,7 +101,7 @@ extern int mmap_rnd_compat_bits __read_mostl=
y;
>>>>        # ifdef MAX_PHYSMEM_BITS
>>>>        # define PHYSMEM_END   ((1ULL << MAX_PHYSMEM_BITS) - 1)
>>>>        # else
>>>>       -# define PHYSMEM_END   (-1ULL)
>>>>      +# define PHYSMEM_END   ((phys_addr_t)-1)
>>>>        # endif
>>>>        #endif
>> After Linus' fix for PHYSMEM_END, GET_FREE_REGION doesn't need to
>> depend
>> on SPARSEMEM anymore.  So, I think we can remove the dependency.  Can
>> you check whether the following patch work for you on top of latest
>> upstream kernel (with Linus' fix).
>>=20
>
> It works for m68k. I'll run a complete test on all architectures/platforms
> tonight.

Does it work in the complete test?

--
Thanks,
Huang, Ying

>> ------------------------8<-------------------------------
>>>From ce1a930f74192a4a85c20564098470356f8c2ed4 Mon Sep 17 00:00:00 2001
>> From: Huang Ying <ying.huang@intel.com>
>> Date: Mon, 23 Sep 2024 09:24:03 +0800
>> Subject: [PATCH] resource: Remove dependency on SPARSEMEM from GET_FREE_=
REGION
>> We want to use the functions configured via GET_FREE_REGION in
>> resource kunit tests.  However, GET_FREE_REGION depends on SPARSEMEM.
>> This makes resource kunit tests cannot be built on some architectures
>> lacking SPARSEMEM.  In fact, these functions doesn't depend on
>> SPARSEMEM now.  So, remove dependency on SPARSEMEM from
>> GET_FREE_REGION.
>> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
>> Cc: Guenter Roeck <linux@roeck-us.net>
>> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
>> Cc: Nathan Chancellor <nathan@kernel.org>
>> Cc: Arnd Bergmann <arnd@arndb.de>
>> ---
>>   mm/Kconfig | 1 -
>>   1 file changed, 1 deletion(-)
>> diff --git a/mm/Kconfig b/mm/Kconfig
>> index b72e7d040f78..f287b0d1c5fc 100644
>> --- a/mm/Kconfig
>> +++ b/mm/Kconfig
>> @@ -1060,7 +1060,6 @@ config HMM_MIRROR
>>   	depends on MMU
>>     config GET_FREE_REGION
>> -	depends on SPARSEMEM
>>   	bool
>>     config DEVICE_PRIVATE

