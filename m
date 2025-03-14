Return-Path: <linux-kernel+bounces-561360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25C1BA61076
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 12:56:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71DF6461DB9
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 11:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CEB51FDE31;
	Fri, 14 Mar 2025 11:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IWrmmagk"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B511FDA66;
	Fri, 14 Mar 2025 11:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741953378; cv=none; b=Qe7Msyg+AI283bms2yg7rSif/jvsmxQSBdpzVQd7UJy4kyd1ebPiEW0vq7XJ9yX8mGtfvL/ZMxx3o9nYEcTuraGD2V4Yb86RdDV8h3w7wrivTDR4ZM2EGPkh+6S+YUYimd6diets7XEsL01VI3DmxlLuMimrfQO+I8jOTOOknvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741953378; c=relaxed/simple;
	bh=saN+oyAs7en/yrR6Un/aRcgUQkDXElpe0GDCuKxLkJk=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=UjBw/ceSrxGC9ZYUYu0Fhe7Ll72fS32kogKYDsgQ2q5Yz0+NvlghztWnk32kjNykL9TLw02b3Sm5GnB7J0DKSSv12TAOwyyrW02SexaXWSSCNHbQjaN9B0crqNzvbbKHi0r4lbI0yY7oIOwLvgscGMVHCTlvQYALwQkjedRvjDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IWrmmagk; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741953377; x=1773489377;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=saN+oyAs7en/yrR6Un/aRcgUQkDXElpe0GDCuKxLkJk=;
  b=IWrmmagkse325YJEW6aezqhyCr3E5pbnDUgpoiuImcZtSNTHRk6E2RT6
   xYmRARBAJEC9JatFkNDDJYGlIelMstJT1eZIYUTcPeNjNUBitE04x4AjI
   LtBhVQ9QSyBEUMBDh9dMxuwYdWcCvqfebgP/7Lx4kFAz1ityXvVBzPb7t
   uQHV1DKCHIJ8jIxzX7D6CFZZNePm5v4pvIJhbGIAQrd8NGv/emaK0zjVD
   DS55MlyKStR359t98hewSuRFG3oMtwPoItUkUyeRL4pKqMMgCNytaJN9k
   5DY3BcpIxos+E5MT5vWLSRgJ7m+8IZdrAKneV7TvkMKQI5yg50webOzdi
   w==;
X-CSE-ConnectionGUID: ySmjTaK7TD+GELOXAmlBhw==
X-CSE-MsgGUID: dkTG25RZS9yDUPNGWb2STA==
X-IronPort-AV: E=McAfee;i="6700,10204,11372"; a="65561234"
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; 
   d="scan'208";a="65561234"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2025 04:56:11 -0700
X-CSE-ConnectionGUID: NFvoujGuSVKWWoxL9f8j+w==
X-CSE-MsgGUID: 9PG90Pj9RLaCqHhmrgkl5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; 
   d="scan'208";a="121044011"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.56])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2025 04:56:07 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 14 Mar 2025 13:56:04 +0200 (EET)
To: Andy Shevchenko <andy.shevchenko@gmail.com>
cc: Choong Yong Liang <yong.liang.choong@linux.intel.com>, 
    Hans de Goede <hdegoede@redhat.com>, 
    =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
    David E Box <david.e.box@linux.intel.com>, 
    platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] platform/x86: intel_pmc_ipc: add option to build
 without ACPI
In-Reply-To: <CAHp75Vcjqv+j9gkZiQ_LtYE1F7YH8ZweHVTa31AbPht8_Knnkg@mail.gmail.com>
Message-ID: <2a00773a-b887-7966-36de-0e2b93359912@linux.intel.com>
References: <20250313085526.1439092-1-yong.liang.choong@linux.intel.com> <CAHp75Vcjqv+j9gkZiQ_LtYE1F7YH8ZweHVTa31AbPht8_Knnkg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-2117771442-1741953364=:10784"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-2117771442-1741953364=:10784
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 13 Mar 2025, Andy Shevchenko wrote:

> On Thu, Mar 13, 2025 at 10:55=E2=80=AFAM Choong Yong Liang
> <yong.liang.choong@linux.intel.com> wrote:
> >
> > From: David E. Box <david.e.box@linux.intel.com>
> >
> > Introduce a configuration option that allows users to build the
> > intel_pmc_ipc driver without ACPI support. This is useful for
> > systems where ACPI is not available or desired.
> >
> > Based on the discussion from the patch [1], it was necessary to
> > provide this option to accommodate specific use cases.
>=20
> > Link: https://patchwork.kernel.org/project/netdevbpf/patch/202502271215=
22.1802832-6-yong.liang.choong@linux.intel.com/#26280764 [1]
>=20
> >
>=20
> No blank line here, but I think Hans or Ilpo may tweak this when applying=
=2E
>=20
> Otherwise LGTM,
> Reviewed-by: Andy Shevchenko <andy@kernel.org>
> Thanks!

Hi both,

The original commit went through net-next tree so I cannot take this into=
=20
pdx86 tree until after the merge window. It seems low impact enough that=20
coordinating with the netdev might not be worth the effort.

To get it going through net-next tree, you'd need to submit v3 so that in=
=20
addition to the current receipients, all relevant netdev people & ML are=20
included as receipients. But I'd be fine if you leave it until after the=20
merge window and I can then handle it then.

> > Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> > Co-developed-by: Choong Yong Liang <yong.liang.choong@linux.intel.com>
> > Signed-off-by: Choong Yong Liang <yong.liang.choong@linux.intel.com>

--=20
 i.

--8323328-2117771442-1741953364=:10784--

