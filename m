Return-Path: <linux-kernel+bounces-336440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9210E983AC1
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 03:25:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E00A1F2290C
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 01:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 587011B85DF;
	Tue, 24 Sep 2024 01:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j8bQl28p"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F96115C0
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 01:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727141125; cv=none; b=V5EEDIOG2nXA8te1zMkAsFDTzJ7sLbbpEGJBO4J8hxvw8FQdhzKHpDUJEC4Qbjxen+r0Uo0uW9uMfyOxE67zsdYi9ogm06EmbuzclLKluXAOxyAObhHmWYDN1t1B6DuDdO+5KEC8Z5BKPOtnkJcRuVRYhWwynVm7K/TWO/C3kq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727141125; c=relaxed/simple;
	bh=hq8awPVD63CgDTjcmK7Z4CJuwsOfQE9MdW0DGlNVe8w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SipaSRgZHIZThlATg24v4goxxm8TfrIu0h/rGqtY5VRwecaIJyrgKFl80sSSUL8jbMZ+GyjeTy2kKDB54cFB3stEDLPpHpIqQNktZ4NL52OY4kpYT0hzBpRqX3bRke3PYkHAzFU+8hG8O/TKcaYyAJlYWPJX/EM+dXylUGAbYZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j8bQl28p; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727141124; x=1758677124;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=hq8awPVD63CgDTjcmK7Z4CJuwsOfQE9MdW0DGlNVe8w=;
  b=j8bQl28pNVLlmHy0dtj22WNqTRSBkyjpu1eX08zRarnQeCQNdFup+wkz
   eXHBhTCBCbeeg+w+hO0AvMS+/w79OX20eCQZP38kS15B5V95atG2BxqSb
   kcQKgIicGHqU5BcftqiJtLfEXY/ywWlnTstvbFaG1Um3YZaIqRgPk5mYO
   JT3oz+lmxN3Be3GbVgn7xpRwWlqtQMmSXxjPsPRCGsGrhcBMtZroyXZ4e
   a8MepJBs/iyMJVxgNZgTa8bWUc98B6+/yJzDbsqOHNQmp0w61pdpEZ9Nn
   +xijPM5o549EMxOZ44vGhsa00CL9UVUEPRuPXpYYdd8sh3cJECQA5YI/k
   Q==;
X-CSE-ConnectionGUID: HwPQY4PCQ+2oVIDc73PyEw==
X-CSE-MsgGUID: G/+WaIwGTEaVRR+0xGynzQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11204"; a="37253604"
X-IronPort-AV: E=Sophos;i="6.10,253,1719903600"; 
   d="scan'208";a="37253604"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2024 18:25:23 -0700
X-CSE-ConnectionGUID: e4nByTBpTOq8diEi0bNVtQ==
X-CSE-MsgGUID: UTLl0aPPSVildeZciom5Lw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,253,1719903600"; 
   d="scan'208";a="76021867"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2024 18:25:22 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,  Andrew Morton
 <akpm@linux-foundation.org>,  linux-kernel@vger.kernel.org, Linus Torvalds
 <torvalds@linux-foundation.org>
Subject: Re: [PATCH] resource, kunit: add dependency on SPARSEMEM
In-Reply-To: <435dc218-f7ea-4697-b3ef-6a786e8d1b2c@roeck-us.net> (Guenter
	Roeck's message of "Mon, 23 Sep 2024 06:39:43 -0700")
References: <20240922225041.603186-1-linux@roeck-us.net>
	<CAMuHMdWAuQcFQaQNy2EP_u9vk13g2C3sb3FFBCMAUPyGMgZ+hg@mail.gmail.com>
	<435dc218-f7ea-4697-b3ef-6a786e8d1b2c@roeck-us.net>
Date: Tue, 24 Sep 2024 09:21:48 +0800
Message-ID: <87msjxu9qr.fsf@yhuang6-desk2.ccr.corp.intel.com>
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

> On 9/23/24 05:58, Geert Uytterhoeven wrote:
>> Hi G=C3=BCnter,
>> On Mon, Sep 23, 2024 at 12:50=E2=80=AFAM Guenter Roeck <linux@roeck-us.n=
et>
>> wrote:
>>> Building allmodconfig images on systems with SPARSEMEM=3Dn results in
>>> the following message.
>>>
>>> WARNING: unmet direct dependencies detected for GET_FREE_REGION
>>>    Depends on [n]: SPARSEMEM [=3Dn]
>>>    Selected by [m]:
>>>    - RESOURCE_KUNIT_TEST [=3Dm] && RUNTIME_TESTING_MENU [=3Dy] && KUNIT=
 [=3Dm]
>>>
>>> and the build ultimately fails.
>> Really? What's the build error?
>
> I saw it on hexagon, and I didn't bother writing down the actual build er=
ror
> message. But it turns out you are correct, the m68k machine does build wi=
th
> CONFIG_RESOURCE_KUNIT_TEST=3Dy even though SPARSEMEM and with it GET_FREE=
_REGION
> are not set. Never mind, I don't really want or have time to argue. I'll =
just
> disable CONFIG_RESOURCE_KUNIT_TEST when building hexagon images and where=
ver
> else I see the problem.
>
>> It does build for me on m68k, after fixing:
>>      --- a/include/linux/mm.h
>>      +++ b/include/linux/mm.h
>>      @@ -101,7 +101,7 @@ extern int mmap_rnd_compat_bits __read_mostly;
>>       # ifdef MAX_PHYSMEM_BITS
>>       # define PHYSMEM_END   ((1ULL << MAX_PHYSMEM_BITS) - 1)
>>       # else
>>      -# define PHYSMEM_END   (-1ULL)
>>     +# define PHYSMEM_END   ((phys_addr_t)-1)
>>       # endif
>>       #endif

After Linus' fix for PHYSMEM_END, GET_FREE_REGION doesn't need to depend
on SPARSEMEM anymore.  So, I think we can remove the dependency.  Can
you check whether the following patch work for you on top of latest
upstream kernel (with Linus' fix).

------------------------8<-------------------------------
From ce1a930f74192a4a85c20564098470356f8c2ed4 Mon Sep 17 00:00:00 2001
From: Huang Ying <ying.huang@intel.com>
Date: Mon, 23 Sep 2024 09:24:03 +0800
Subject: [PATCH] resource: Remove dependency on SPARSEMEM from GET_FREE_REG=
ION

We want to use the functions configured via GET_FREE_REGION in
resource kunit tests.  However, GET_FREE_REGION depends on SPARSEMEM.
This makes resource kunit tests cannot be built on some architectures
lacking SPARSEMEM.  In fact, these functions doesn't depend on
SPARSEMEM now.  So, remove dependency on SPARSEMEM from
GET_FREE_REGION.

Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
---
 mm/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/mm/Kconfig b/mm/Kconfig
index b72e7d040f78..f287b0d1c5fc 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -1060,7 +1060,6 @@ config HMM_MIRROR
 	depends on MMU
=20
 config GET_FREE_REGION
-	depends on SPARSEMEM
 	bool
=20
 config DEVICE_PRIVATE
--=20
2.39.2




