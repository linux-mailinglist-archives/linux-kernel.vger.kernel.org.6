Return-Path: <linux-kernel+bounces-374068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A80199A61F0
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 12:09:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6D241C25AAF
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 10:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D2591E3DDE;
	Mon, 21 Oct 2024 10:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ngDYBB+z"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12CC1E0087;
	Mon, 21 Oct 2024 10:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729505344; cv=none; b=Oy5S/rL4ffEU3/Sr/mQn5h0tM9KKf/kYNK83v6Yt+juDgfE7pm24ExJr1OjUUJ+WsyfSiEdxyeBRx3aeBZ4EvRHSATp33k3nn0aKXCok8b/4XxGZwYrw3H7GQKKLTKmj43h0/jOb/fmpInXOnDXDeoaWqyMjT3tV/5RcNkXkMT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729505344; c=relaxed/simple;
	bh=18+jnM85UjW+wbWkxa7PX1839a1zgtzyUj59Bn2HJi8=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=C0HJsSWDxswra6jMTEP9aFTL0asWkmxepTjkEg1knE6hZZwqSHf1OeQaiT3VqukA++LU/HcKDQmsnEToZTTYZra2Xelyr41ORJ6RLUAeFW/bT4AGnq5wE0/0dU4ULo7ZXyF4AXMPkJ7R9l0DlGYChfLwt9jPfyVanci2yKvgjbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ngDYBB+z; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729505343; x=1761041343;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=18+jnM85UjW+wbWkxa7PX1839a1zgtzyUj59Bn2HJi8=;
  b=ngDYBB+zNqeGQ4b+fDE1ffjl8cQz8OLAPJ8LsN60BrJFx92eVNX4MjS0
   ajvfTCiP9R771GTTCqWHzPlFrXoBZrgP0SQLqnGKBNbJEUP6i2K9PP7EL
   LLvkO0TLtd2MzDhZgbGQrjKT2EGscVfu8b7KMOxlMGBp5GabaFTKJ6GVo
   pMb5406hfHHohvP1N8NPz9NaBMpe8ad4vq18BgWBrkIncTJmJhvfi/yLW
   SmnvS9HAbrgHH2EfnYoZtd8Qox8qTsL1XwFX0MMpiWds/dZ67Y00vBCaG
   GmYvBG2600/nkq3thThW4JcuxOg/FDcOnSwRoDutzvC4X1PXnj2zrVYLQ
   g==;
X-CSE-ConnectionGUID: ytRcUNLsTRSjb9roJG11KQ==
X-CSE-MsgGUID: 8q6LIrgnSTW4ZBveSvZCEg==
X-IronPort-AV: E=McAfee;i="6700,10204,11231"; a="29101157"
X-IronPort-AV: E=Sophos;i="6.11,220,1725346800"; 
   d="scan'208";a="29101157"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 03:09:02 -0700
X-CSE-ConnectionGUID: Uq3XoKk9TNG9/w8SInjXiA==
X-CSE-MsgGUID: UiiZ5kuNRKGms2jEQavPug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,220,1725346800"; 
   d="scan'208";a="79832816"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.201])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 03:08:59 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 21 Oct 2024 13:08:55 +0300 (EEST)
To: Andy Shevchenko <andy.shevchenko@gmail.com>
cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
    LKML <linux-kernel@vger.kernel.org>, platform-driver-x86@vger.kernel.org, 
    Andy Shevchenko <andy@kernel.org>, 
    Mika Westerberg <mika.westerberg@linux.intel.com>, 
    Hans de Goede <hdegoede@redhat.com>, Ferry Toth <fntoth@gmail.com>
Subject: Re: [PATCH v2 2/3] platform/x86: intel_scu_ipc: Simplify code with
 cleanup helpers
In-Reply-To: <CAHp75VejavDObi4PMLPVCO==YCTRkOvV-uOOSyx_=74bOSrKxQ@mail.gmail.com>
Message-ID: <e4ede6f5-6459-862a-adb9-fdd6f9524c51@linux.intel.com>
References: <20241021084053.2443545-1-andriy.shevchenko@linux.intel.com> <20241021084053.2443545-3-andriy.shevchenko@linux.intel.com> <28078013-a643-af8e-22be-f36c75790ba5@linux.intel.com>
 <CAHp75VejavDObi4PMLPVCO==YCTRkOvV-uOOSyx_=74bOSrKxQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-1909606106-1729504337=:1065"
Content-ID: <dd84cda3-68ba-895e-1ee3-e448909d4566@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1909606106-1729504337=:1065
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <9697b3e8-66b6-c22a-bdcc-aca957226134@linux.intel.com>

On Mon, 21 Oct 2024, Andy Shevchenko wrote:

> On Mon, Oct 21, 2024 at 12:32=E2=80=AFPM Ilpo J=C3=A4rvinen
> <ilpo.jarvinen@linux.intel.com> wrote:
> > On Mon, 21 Oct 2024, Andy Shevchenko wrote:
>=20
> ...
>=20
> > IMO, this change is doing too many things at once and it's hard to just=
ify
> > why those changes must be kept in the same patch. If the guard() change
> > is done first and only then the logic reversions, both patches would
> > probably be near trivial to review for correctness.
>=20
> Are you insisting on this?
> Because that's how I have done similar changes in the past all over
> the kernel, and IIRC you are the first one asking for this :-)

Well, I know I could go through the patch as is and likely find out it's=20
correct. But as is, it requires clearly more effort that it would if those=
=20
two things would be separated. The contexts would be much smaller and=20
focused if you split this into two and since you know the end result (the=
=20
current patch), the second patch is just the diff of the first to it.

I'm not saying it's always required but TBH, this patch definitely would=20
get simpler to read if you split it into two. So to answer your question,=
=20
it's more of a judgement call than insisting it always.


--=20
 i.
--8323328-1909606106-1729504337=:1065--

