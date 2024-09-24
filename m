Return-Path: <linux-kernel+bounces-336757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 179AB98406A
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 10:25:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96681B2328F
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 08:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1744014F10F;
	Tue, 24 Sep 2024 08:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hMVHMqQR"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630F014AD02
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 08:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727166296; cv=none; b=pbH4PJdb7VXRyQOBrDCozrdMqKAbJQhKqi81d1gwAN8J1CCWI0RCljOk+eG2wjXrpbN2bisxIAjfslFvrmcrU2M59I9cuWxj576/SzGhG1V+YkYw1QZC3mDkHKBUFhb69IFWsikWmWjMG10N5lCaSCeCu55g7oq5HHcAHDIsbo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727166296; c=relaxed/simple;
	bh=Yhu5MQI7ZBp79bM9ySp/mnKisrCGADzR73AhGmoPOuM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IN21RuFUfs0I9Rj2nTmyz7DnYwrOwGz1KWP+tmTfxsLFOkkzHuxaoy2MHBcwzAA7aoEAQNi3xE11cu8WU5tUib0ohyl5w1febL7Hmb+Faex+W8owwyF7RStt6RVkYKb3VdbvJ0AgsHsNA5X6yziz1SZSbD855bSu+A1ogyGsIzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hMVHMqQR; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727166295; x=1758702295;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=Yhu5MQI7ZBp79bM9ySp/mnKisrCGADzR73AhGmoPOuM=;
  b=hMVHMqQR2DhJwAuPnd3+LKCdR2ojEfxfmLGdfachyGA4rQML+sT+zPyC
   tIghxOsB0yjF4HZmaLjr9+lHez0vXH91iUSktCK9i4H6tPgnfGjREUgw3
   WVFUG2h4biRV94dUOfTI26Wzi2I7hdN/wPgdiCUtPGBFpL17JTOrv7yvY
   nEOF/5Z9k4dwfH8wNe0eoDXy/6Z4R9C0To6yw1xhllCqpMc1D3KpwI3bf
   oEFnkPMeLro2HOp2QfDrICRKTNy8tjCjDgWPTV/9DW+mHqnm9FAP5qPrH
   fN8MVo7qNO8v0D5zN1edwU+D1FPzfjoGcn659ricL9A36h7BAVDTBBa+W
   w==;
X-CSE-ConnectionGUID: p+PblMoKS92+p7WTQGri4Q==
X-CSE-MsgGUID: /xeoT2U7QfOmVN73WexqEQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11204"; a="26012079"
X-IronPort-AV: E=Sophos;i="6.10,253,1719903600"; 
   d="scan'208";a="26012079"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2024 01:24:54 -0700
X-CSE-ConnectionGUID: sbLvVlQiSQqDNLq1CfYVvA==
X-CSE-MsgGUID: PM0LORlrQzq5ADlE1S2WMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,253,1719903600"; 
   d="scan'208";a="76114512"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2024 01:24:51 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>, Dan Williams
 <dan.j.williams@intel.com>
Cc: Guenter Roeck <linux@roeck-us.net>,  Andrew Morton
 <akpm@linux-foundation.org>,  <linux-kernel@vger.kernel.org>,  Linus
 Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] resource, kunit: add dependency on SPARSEMEM
In-Reply-To: <CAMuHMdXBbBKskY+TXswaw-oHvLANzoVJGWAjWQDy4HPMuZwasA@mail.gmail.com>
	(Geert Uytterhoeven's message of "Tue, 24 Sep 2024 09:56:35 +0200")
References: <20240922225041.603186-1-linux@roeck-us.net>
	<CAMuHMdWAuQcFQaQNy2EP_u9vk13g2C3sb3FFBCMAUPyGMgZ+hg@mail.gmail.com>
	<435dc218-f7ea-4697-b3ef-6a786e8d1b2c@roeck-us.net>
	<87msjxu9qr.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<CAMuHMdXBbBKskY+TXswaw-oHvLANzoVJGWAjWQDy4HPMuZwasA@mail.gmail.com>
Date: Tue, 24 Sep 2024 16:21:18 +0800
Message-ID: <87a5fxtqbl.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Geert Uytterhoeven <geert@linux-m68k.org> writes:

> Hi Huang,
>
> On Tue, Sep 24, 2024 at 3:25=E2=80=AFAM Huang, Ying <ying.huang@intel.com=
> wrote:
>> Guenter Roeck <linux@roeck-us.net> writes:
>> > On 9/23/24 05:58, Geert Uytterhoeven wrote:
>> >> Hi G=C3=BCnter,
>> >> On Mon, Sep 23, 2024 at 12:50=E2=80=AFAM Guenter Roeck <linux@roeck-u=
s.net>
>> >> wrote:
>> >>> Building allmodconfig images on systems with SPARSEMEM=3Dn results in
>> >>> the following message.
>> >>>
>> >>> WARNING: unmet direct dependencies detected for GET_FREE_REGION
>> >>>    Depends on [n]: SPARSEMEM [=3Dn]
>> >>>    Selected by [m]:
>> >>>    - RESOURCE_KUNIT_TEST [=3Dm] && RUNTIME_TESTING_MENU [=3Dy] && KU=
NIT [=3Dm]
>
>> After Linus' fix for PHYSMEM_END, GET_FREE_REGION doesn't need to depend
>> on SPARSEMEM anymore.  So, I think we can remove the dependency.  Can
>> you check whether the following patch work for you on top of latest
>> upstream kernel (with Linus' fix).
>
> Yes it does, thanks!
>
> One remaining issue is that RESOURCE_KUNIT_TEST selects GET_FREE_REGION.
> IMHO merely enabling a test should not enable extra functionality
> in the kernel.  Can the individual test(s) that do depend on
> GET_FREE_REGION be protected by #ifdef CONFIG_GET_FREE_REGION instead?

After checking GET_FREE_REGION, I don't think that it's a special
functionality.  I guess it's selectable because it depends on SPARSEMEM
and to reduce code size.

Hi, Dan, please correct me if I'm wrong here.

So, to reduce #ifdef in .c file as much as possible and make code
simpler, I prefer to select it for RESOURCE_KUNIT_TEST.

--
Best Regards,
Huang, Ying

