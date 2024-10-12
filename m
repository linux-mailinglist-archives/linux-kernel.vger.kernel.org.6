Return-Path: <linux-kernel+bounces-362067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CEE4899B07E
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 05:47:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04FF61C2110B
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 03:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE7D484A27;
	Sat, 12 Oct 2024 03:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RdEuSdma"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1A9CA41
	for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 03:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728704843; cv=none; b=JgyIyg+mibwInFQtCsnPmEbrnWRDAc/fIR0k9VHluUd6hZBMceC+pyy/nMHqcCH65S+joqqa/yF7NaX0cIQ1avetvMrRVUUPF5NCrDlIWqU4HxSwFFGJRABYJFmbnVdKRAYceqH1xU9UFFtwvHpNOBLMGoorspo73SRi5+TgOK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728704843; c=relaxed/simple;
	bh=whHjTqo4qDAUVEVGJc43zThkgS8uiZocVN4j6Pck2kM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VpsUihaFiTqOifRwdBDT0rBimRUl9KhPFzxLMXEXYEXOHGi4rgQWzW94aH9VPaq9azvH/hUX5yZRyxrw4ZFufOdgON3Xg4Vgt7HitXkQ33yespZ/HGQQoglmJbDVrmoHIcjtu+V2/W6p5QzLbJr5OdvXOJKOwN9QykJvqoheVQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RdEuSdma; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728704842; x=1760240842;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=whHjTqo4qDAUVEVGJc43zThkgS8uiZocVN4j6Pck2kM=;
  b=RdEuSdmaBSxnBmXYww6H46AHeCSnw2VimpJsd4twtPpn//5FJfgsJysV
   2EvFG0jqVWQkwQZ1Ap0pMEb2O9A6fDYDDoojXMacxKcHiNH7sbam4hCJV
   gXOSgE+F1OgopHSmhNPbRYAxE766Tk1GhV59gH/R01zAV/PcEtY3YUlvs
   JqYtgLFIJeDDHr3vUNfHB4hdjtC7rMMp/Thl8pRJwRcvZEKfL6cIwQ4Km
   4z4BkXTNVRDBSlD36cBmY/vefzNgK3Ga6X+Nbgv791xCOU8WwHBtO/FpS
   hTBClt/KdugHdIllRuiyc7NAyv6NgKvCAbPfrQr5llzJJcUGEq4/Kb6ML
   g==;
X-CSE-ConnectionGUID: l0Sii/uxRS+qm2tu7UP44Q==
X-CSE-MsgGUID: GOdZrsDtQ+G7QUItItSfTA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="28209516"
X-IronPort-AV: E=Sophos;i="6.11,197,1725346800"; 
   d="scan'208";a="28209516"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2024 20:47:21 -0700
X-CSE-ConnectionGUID: fOaS1K91TkqcVE2KT1wUMQ==
X-CSE-MsgGUID: s0skI4QbS2mfluRh4hqvtw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,197,1725346800"; 
   d="scan'208";a="81865204"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2024 20:47:19 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,  Andrew Morton
 <akpm@linux-foundation.org>,  linux-kernel@vger.kernel.org,  Linus
 Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] resource, kunit: add dependency on SPARSEMEM
In-Reply-To: <21eae385-ba7e-417c-b2c5-2071c3c7d8f5@roeck-us.net> (Guenter
	Roeck's message of "Thu, 10 Oct 2024 09:01:27 -0700")
References: <20240922225041.603186-1-linux@roeck-us.net>
	<CAMuHMdWAuQcFQaQNy2EP_u9vk13g2C3sb3FFBCMAUPyGMgZ+hg@mail.gmail.com>
	<435dc218-f7ea-4697-b3ef-6a786e8d1b2c@roeck-us.net>
	<87msjxu9qr.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<0247886e-595e-4774-b515-ff628966f2be@roeck-us.net>
	<878quwbgv0.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<21eae385-ba7e-417c-b2c5-2071c3c7d8f5@roeck-us.net>
Date: Sat, 12 Oct 2024 11:43:46 +0800
Message-ID: <87ikty7zpp.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Guenter Roeck <linux@roeck-us.net> writes:

> On 10/9/24 23:40, Huang, Ying wrote:
>> Hi, Guenter,
>> Guenter Roeck <linux@roeck-us.net> writes:
>>=20
>>> On 9/23/24 18:21, Huang, Ying wrote:
>>>> Guenter Roeck <linux@roeck-us.net> writes:
>>>>
>>>>> On 9/23/24 05:58, Geert Uytterhoeven wrote:
>>>>>> Hi G=C3=BCnter,
>>>>>> On Mon, Sep 23, 2024 at 12:50=E2=80=AFAM Guenter Roeck <linux@roeck-=
us.net>
>>>>>> wrote:
>>>>>>> Building allmodconfig images on systems with SPARSEMEM=3Dn results =
in
>>>>>>> the following message.
>>>>>>>
>>>>>>> WARNING: unmet direct dependencies detected for GET_FREE_REGION
>>>>>>>      Depends on [n]: SPARSEMEM [=3Dn]
>>>>>>>      Selected by [m]:
>>>>>>>      - RESOURCE_KUNIT_TEST [=3Dm] && RUNTIME_TESTING_MENU [=3Dy] &&=
 KUNIT [=3Dm]
>>>>>>>
>>>>>>> and the build ultimately fails.
>>>>>> Really? What's the build error?
>>>>>
>>>>> I saw it on hexagon, and I didn't bother writing down the actual buil=
d error
>>>>> message. But it turns out you are correct, the m68k machine does buil=
d with
>>>>> CONFIG_RESOURCE_KUNIT_TEST=3Dy even though SPARSEMEM and with it GET_=
FREE_REGION
>>>>> are not set. Never mind, I don't really want or have time to argue. I=
'll just
>>>>> disable CONFIG_RESOURCE_KUNIT_TEST when building hexagon images and w=
herever
>>>>> else I see the problem.
>>>>>
>>>>>> It does build for me on m68k, after fixing:
>>>>>>        --- a/include/linux/mm.h
>>>>>>        +++ b/include/linux/mm.h
>>>>>>        @@ -101,7 +101,7 @@ extern int mmap_rnd_compat_bits __read_mo=
stly;
>>>>>>         # ifdef MAX_PHYSMEM_BITS
>>>>>>         # define PHYSMEM_END   ((1ULL << MAX_PHYSMEM_BITS) - 1)
>>>>>>         # else
>>>>>>        -# define PHYSMEM_END   (-1ULL)
>>>>>>       +# define PHYSMEM_END   ((phys_addr_t)-1)
>>>>>>         # endif
>>>>>>         #endif
>>>> After Linus' fix for PHYSMEM_END, GET_FREE_REGION doesn't need to
>>>> depend
>>>> on SPARSEMEM anymore.  So, I think we can remove the dependency.  Can
>>>> you check whether the following patch work for you on top of latest
>>>> upstream kernel (with Linus' fix).
>>>>
>>>
>>> It works for m68k. I'll run a complete test on all architectures/platfo=
rms
>>> tonight.
>> Does it work in the complete test?
>>=20
>
> Sorry, I dropped that one. Yes, it does.
>

Thanks a lot!  Can I add your Tested-by in the formal version?

--
Best Regards,
Huang, Ying

