Return-Path: <linux-kernel+bounces-341209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 62AF8987CAF
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 03:44:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83D7D1C2231C
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 01:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AF4514A61A;
	Fri, 27 Sep 2024 01:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i6V2pSpJ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D90A6BFC0
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 01:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727401484; cv=none; b=nhI0TdTLRJn1nqS0iZfLJ0tnKLvzDEH5C2QYe71/r4YFLkwvIyAB5BJSIcu0JfLbWNTL1tE+jGNnXTF7p8vRdNZEFL9uWXbzab38BU6Et9M+2Y4VbIm5zA7OLcbBFOCS5buIKfQEeO1UQ3KqI15Jdokuo3bi5uiA5fVuNU4vpBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727401484; c=relaxed/simple;
	bh=JMfWD7JK5GoEhRpaINObkIFpFEsFdq72gM50YQGaWx4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Mb9Omo7jT2Gkv9BIO3A/oT/LOsihYCf5sjj8vfYQrGMcyekdRMn1p3TdqJNFOuVjwOumxRLhXHueZo0rl3aFG3o8BRj7LsFnbVp5N0jW5yZIDa3MkO/ZqxSkpiNd2jgtGXInqK2/TSNXfIkJpeK64g/f+gNHnNs/2vBkZX1/u8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i6V2pSpJ; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727401482; x=1758937482;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=JMfWD7JK5GoEhRpaINObkIFpFEsFdq72gM50YQGaWx4=;
  b=i6V2pSpJe7y+FcsfC+f9v0M4EYUBkC+BwNhLjU4YLqHb5n8kd0Up5u3y
   Z0J9x0ZgY6Jy/W0ZW8no1lirtWtTbKtUwXKHNShZx9H4qCiYtKfYOE4wS
   PtFcjSK15K28dbs2jN5eeBGpQKq2zdCGo0WtBVjQY2+wJpOc3lSsio1Di
   x4mZwBcTCUvnCkTZg8emVSLT5rGx/hh2XXebbNNraRpQvE6MOKTPb5Vig
   odC4fTdcWHkSpyjHnEIfssTxrFPCiL7126BQ93A2yx+g7h3hwSHHbrTuq
   50pj7daC2eDmoME+1iiX0sGJg99tYEHhbNFMlFzw80OCpLmBBYwBHQO6V
   A==;
X-CSE-ConnectionGUID: Vr3swlQ4SjCPKbGZ7NgO2Q==
X-CSE-MsgGUID: sMKPL434TkeBzaEifEPnwQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11207"; a="26340359"
X-IronPort-AV: E=Sophos;i="6.11,157,1725346800"; 
   d="scan'208";a="26340359"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2024 18:44:41 -0700
X-CSE-ConnectionGUID: bhJ+RqCLQDi6aO55GS29HQ==
X-CSE-MsgGUID: 22pBBzIcS3CdQFi2CH/3zA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,157,1725346800"; 
   d="scan'208";a="72259255"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2024 18:44:40 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,  Guenter Roeck
 <linux@roeck-us.net>,  Andrew Morton <akpm@linux-foundation.org>,
  linux-kernel@vger.kernel.org,  Linus Torvalds
 <torvalds@linux-foundation.org>
Subject: Re: [PATCH] resource, kunit: add dependency on SPARSEMEM
In-Reply-To: <66f5abd431dce_964f2294b9@dwillia2-xfh.jf.intel.com.notmuch> (Dan
	Williams's message of "Thu, 26 Sep 2024 11:45:40 -0700")
References: <20240922225041.603186-1-linux@roeck-us.net>
	<CAMuHMdWAuQcFQaQNy2EP_u9vk13g2C3sb3FFBCMAUPyGMgZ+hg@mail.gmail.com>
	<435dc218-f7ea-4697-b3ef-6a786e8d1b2c@roeck-us.net>
	<87msjxu9qr.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<CAMuHMdXBbBKskY+TXswaw-oHvLANzoVJGWAjWQDy4HPMuZwasA@mail.gmail.com>
	<87a5fxtqbl.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<66f5abd431dce_964f2294b9@dwillia2-xfh.jf.intel.com.notmuch>
Date: Fri, 27 Sep 2024 09:41:06 +0800
Message-ID: <87h6a1rhzh.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Dan Williams <dan.j.williams@intel.com> writes:

> Huang, Ying wrote:
>> Geert Uytterhoeven <geert@linux-m68k.org> writes:
>>=20
>> > Hi Huang,
>> >
>> > On Tue, Sep 24, 2024 at 3:25=E2=80=AFAM Huang, Ying <ying.huang@intel.=
com> wrote:
>> >> Guenter Roeck <linux@roeck-us.net> writes:
>> >> > On 9/23/24 05:58, Geert Uytterhoeven wrote:
>> >> >> Hi G=C3=BCnter,
>> >> >> On Mon, Sep 23, 2024 at 12:50=E2=80=AFAM Guenter Roeck <linux@roec=
k-us.net>
>> >> >> wrote:
>> >> >>> Building allmodconfig images on systems with SPARSEMEM=3Dn result=
s in
>> >> >>> the following message.
>> >> >>>
>> >> >>> WARNING: unmet direct dependencies detected for GET_FREE_REGION
>> >> >>>    Depends on [n]: SPARSEMEM [=3Dn]
>> >> >>>    Selected by [m]:
>> >> >>>    - RESOURCE_KUNIT_TEST [=3Dm] && RUNTIME_TESTING_MENU [=3Dy] &&=
 KUNIT [=3Dm]
>> >
>> >> After Linus' fix for PHYSMEM_END, GET_FREE_REGION doesn't need to dep=
end
>> >> on SPARSEMEM anymore.  So, I think we can remove the dependency.  Can
>> >> you check whether the following patch work for you on top of latest
>> >> upstream kernel (with Linus' fix).
>> >
>> > Yes it does, thanks!
>> >
>> > One remaining issue is that RESOURCE_KUNIT_TEST selects GET_FREE_REGIO=
N.
>> > IMHO merely enabling a test should not enable extra functionality
>> > in the kernel.  Can the individual test(s) that do depend on
>> > GET_FREE_REGION be protected by #ifdef CONFIG_GET_FREE_REGION instead?
>>=20
>> After checking GET_FREE_REGION, I don't think that it's a special
>> functionality.  I guess it's selectable because it depends on SPARSEMEM
>> and to reduce code size.
>>=20
>> Hi, Dan, please correct me if I'm wrong here.
>
> Right, the only reason it is selectable is just to be mindful is
> micro-bloat in kernel/resource.c for the small number of drivers that
> need that call.

Thanks for explanation.

>> So, to reduce #ifdef in .c file as much as possible and make code
>> simpler, I prefer to select it for RESOURCE_KUNIT_TEST.
>
> I agree with the result, but for a different rationale.
>
> RESOURCE_KUNIT_TEST is simply another "driver" that needs
> GET_FREE_REGION. So while I agree with the general idea that "enabling a
> test should not enable extra functionality", in this case the *test* is
> the extra functionality and GET_FREE_REGION comes along for the ride.

Thanks, this sounds totally reasonable for me.

--
Best Regards,
Huang, Ying

