Return-Path: <linux-kernel+bounces-198709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A97378D7C6B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 09:25:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 475CC1F22B5D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 07:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 592D843AA2;
	Mon,  3 Jun 2024 07:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G2gDK9AD"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB4A42047
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 07:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717399489; cv=none; b=rF84TQVby8HTTqBTvu05QHlL6u7Q2+aOUCzbevGlUYI9VATbq5EzOZCJh6YrNlXHNsU3JabXpg6ay/2efWl73CtVeoj59RzP90Npj86gjqXZYkbq1C3bHjqhkiCxtWYFeZEFTpD3hj3EYZK0tUda+qWjUIT4yB3NyaOuDgrmU1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717399489; c=relaxed/simple;
	bh=CFw0jXkCJ2C0wlfWJK24i5rMaTVUzDmZPVQIJxPWnQA=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=DRcVtJApZtyH2UMgEYPsRh75IqQKR91lE4Kt5yg4W8FxKgju14+jw6LHvhWm+foEqXWyg41mhj8roZ6nqZSAFptqI7OqDaWQ9gr9mc5Tb0gjCSwedr+4xeOZ/4G5XL1f6gTZlbSNRSKsFveifz4bk3att3JDSSgvRT+SnZxBGlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G2gDK9AD; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717399488; x=1748935488;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=CFw0jXkCJ2C0wlfWJK24i5rMaTVUzDmZPVQIJxPWnQA=;
  b=G2gDK9AD0dULbtSNRWzbN1bDwIVT3gGumBWwcNDY2OpXPiz+u778KJZ1
   yAs7UOeCwVf+xwRfezMf2jPEfHwBOtoWskk2J3hE4okwG+Q7RraD0DBZV
   JRJUMtPNWVC+1wJ/5gfIOxtQbk7ifSfQA1M9sJ57ZqO8BP2S90/Cxf0jJ
   53wIOvY8Az5d358a+sL0Ya822RCkn8st//h9B+yYAA4wudGaYpKGoXUER
   ENYVFDKq6gRlWahUxrz27bgS52AZ4owgfuA1H3eoO3sqRKsrFCbBfGakh
   GK+19g0gTFgrUkkgVi4zJZVQ8ilLEqy2s3+1xLlMhMyleurbGe64ga8Aj
   Q==;
X-CSE-ConnectionGUID: jiMuqrmSR5OiHXB1lp6GdA==
X-CSE-MsgGUID: zN2aiknTRo+zrIOjJ9xPtQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11091"; a="13824948"
X-IronPort-AV: E=Sophos;i="6.08,210,1712646000"; 
   d="scan'208";a="13824948"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2024 00:24:47 -0700
X-CSE-ConnectionGUID: kxqd9paxTmyZfVioFUTnCg==
X-CSE-MsgGUID: wgn4h+pnQIKznB3X/28G+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,210,1712646000"; 
   d="scan'208";a="36875565"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.161])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2024 00:24:44 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 3 Jun 2024 10:24:39 +0300 (EEST)
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
cc: Chia-I Wu <olvaffe@gmail.com>, amd-gfx@lists.freedesktop.org, 
    dri-devel@lists.freedesktop.org, christian.koenig@amd.com, 
    alexander.deucher@amd.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Alison Schofield <alison.schofield@intel.com>, 
    Dave Jiang <dave.jiang@intel.com>, Baoquan He <bhe@redhat.com>, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kernel/resource: optimize find_next_iomem_res
In-Reply-To: <Zlw1_n20oqchAYxH@smile.fi.intel.com>
Message-ID: <783e9d9a-e408-c6f0-9a4b-050e1979b919@linux.intel.com>
References: <20240531053704.2009827-1-olvaffe@gmail.com> <ZlmQ3_wcL3cgp4Hb@smile.fi.intel.com> <CAPaKu7SsD+X7KAO=3vEYU_7YGM_f+7k1fdC9nEK=-NaJw8oYaA@mail.gmail.com> <Zlw1_n20oqchAYxH@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-947370823-1717399436=:1529"
Content-ID: <ac58b535-760b-99ee-4936-892d3e4f1ed9@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-947370823-1717399436=:1529
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <9a23e7b3-9da0-cdcd-f514-8f55036748af@linux.intel.com>

On Sun, 2 Jun 2024, Andy Shevchenko wrote:

> On Fri, May 31, 2024 at 02:31:45PM -0700, Chia-I Wu wrote:
> > On Fri, May 31, 2024 at 1:57=E2=80=AFAM Andy Shevchenko <
> > andriy.shevchenko@linux.intel.com> wrote:
> > > On Thu, May 30, 2024 at 10:36:57PM -0700, Chia-I Wu wrote:
>=20
> ...
>=20
> > > P.S> I'm not so sure about this change. It needs a thoroughly testing=
, esp.
> > > in PCI case. Cc'ing to Ilpo.
>=20
> > What's special about PCI?
>=20
> PCI, due to its nature, may rebuild resources either by shrinking or expa=
nding
> of the entire subtree after the PCI bridge in question. And this may happ=
en at
> run-time due to hotplug support. But I'm not a deep expert in this area, =
Ilpo
> knows much more than me.

There is code which clearly tries to do expanding resource but that=20
usually fails to work as intended because of a parent resource whose size=
=20
is fixed because it's already assigned.

Some other code might block shrinking too under certain conditions.

This area would need to be reworked in PCI core but it's massive and=20
scary looking change.

--=20
 i.
--8323328-947370823-1717399436=:1529--

