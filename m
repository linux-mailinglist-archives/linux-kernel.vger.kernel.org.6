Return-Path: <linux-kernel+bounces-283493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8821594F59E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 19:09:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46300283131
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 17:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C3F9187FE1;
	Mon, 12 Aug 2024 17:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S5YrvzbP"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3381804F;
	Mon, 12 Aug 2024 17:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723482560; cv=none; b=heqYDZJRIvw7snfB0BKmA3PRC2RMOVuug4zXmaMs9LsWEMh57G6TeRHpLHXeH1h7lOdaaRC/mE38fEAeUOdiI4zxH1yVLByZP2Aogb+hjeqMMuEvV1BXj5eTkDnEpFnQ3PRgN7/rXwK80gpC2MyXi2TXYx9uOr+1a/f4CgLiJbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723482560; c=relaxed/simple;
	bh=hASvAeBZCNnpBDx7OVpK3WqY6MuUHhTqFBeCgrUo6p4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Mfn6T6hezho4Ufh0yC0HJGN50SucAPzJ1e/Wl1KK6FfvflKgG0t0N/vlm/O2zYNBqHOyrrW8eo8Run+On44UsG3k2foMKrmjVoz7CCJeHNgM1ZAFh90+WzTVmPSXXD1sdpqU8ouIehS29h5WhURFJ/U1m7slSpR0WVY7L94A2hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S5YrvzbP; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723482559; x=1755018559;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=hASvAeBZCNnpBDx7OVpK3WqY6MuUHhTqFBeCgrUo6p4=;
  b=S5YrvzbP+KNHce4XJ5Rqrk3esxm0WgL6pi8tbxNxCSsogu+2fgjsmCf1
   siYHJjWb/I1hvzN9lbikgTf5+tZMZ3DvhxXrptyAUaP3J67U2PoD8suvi
   dcs6BmaQshVSKr4nPg1addC1p5r9Yi6EsMmvb87rhIxS8oohxkmvhTME+
   CVtmsZiTfJEGH62xlgSQEt9+wWkSwlHCyAhQAz/rUnyQr7E1n71vPQoDu
   NpsnhAE1tyFuyt9HROPTR+1A/KrFX1GSU2QQmrwubznysMrVQ5EJk6pAM
   0jyg7s5wCo0AbAvqj5rUNm2QPPf/2R/P6ubF/40bU7HcwSwZlCTEvz6c7
   g==;
X-CSE-ConnectionGUID: 9TCWpzSOSlKyz5P1KmhAqw==
X-CSE-MsgGUID: iAR0uqHYTlGfZoeNszQhlg==
X-IronPort-AV: E=McAfee;i="6700,10204,11162"; a="21771758"
X-IronPort-AV: E=Sophos;i="6.09,283,1716274800"; 
   d="scan'208";a="21771758"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2024 10:09:18 -0700
X-CSE-ConnectionGUID: g8pv7Za3T8CFOQ8G0HFtYA==
X-CSE-MsgGUID: FgiFMMUxSVCv2NNn29nViQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,283,1716274800"; 
   d="scan'208";a="81583640"
Received: from spandruv-desk1.amr.corp.intel.com ([10.125.109.83])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2024 10:09:18 -0700
Message-ID: <d21c069438cc9c314e29fe9b75a97cf15ab6e087.camel@linux.intel.com>
Subject: Re: [PATCH] platform/x86/intel-uncore-freq: Do not present separate
 package-die domain
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, platform-driver-x86@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>
Date: Mon, 12 Aug 2024 10:09:10 -0700
In-Reply-To: <cd7cc6b8-4993-937b-072b-8fbc1e309a4d@linux.intel.com>
References: <20240731185756.1853197-1-srinivas.pandruvada@linux.intel.com>
	 <cd7cc6b8-4993-937b-072b-8fbc1e309a4d@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Ilpo,

On Mon, 2024-08-12 at 14:16 +0300, Ilpo J=C3=A4rvinen wrote:
> On Wed, 31 Jul 2024, Srinivas Pandruvada wrote:
>=20
> > The scope of uncore control is per power domain in a package and
> > die.
> > A package-die can have multiple power domains on some processors.
> > In this
> > case package-die domain (root domain) aggregates all information
> > from
> > power domains in it.
> >=20
> > On some processors, CPUID enumerates the die number same as power
> > domain
> > ID. In this case there is one to one relationship between package-
> > die and
> > power domain ID. There is no use of aggregating information from
> > all
> > power domain IDs as the information will be duplicate and
> > confusing. In
> > this case do not create separate package-die domain.
>=20
> Hi Srinivas,
>=20
> I got confused by this changelog because its order is quite
> illogical.
>=20
> First paragraph talks about case A. When you say "all information"=20
> is "aggregated", I immediately make the assumption that the
> aggregated=20
> information is what is wanted because, well, you normally want "all=20
> information" and nothing else is being told here.
>=20
> Second paragraph starts to talk about case B and then suddenly
> switches to=20
> talk what should have been done in case A (that aggregated
> information is=20
> useless/confusing).
>=20
Is this any better:

"
The scope of uncore control is per power domain in a package and die
with TPMI.

There are two types of processor configurations possible:
1. A compute die is not enumerated in CPUID. In this case there is only
one die in a package. In this case there will be multiple power domains
in a single die.
2. A power domain in a package is enumerated as a compute die in CPUID.
So there is one to one relationship between a die and power domain.

To allow die level controls, the current implementation creates a root
domain and aggregates all information from power domains in it. This
is well suited for configuration 1 above.

But when newer processors use configuration 2 above, this will present
redundant information, So no use of aggregating. In this case do not
create separate root domain.
"

Thanks,
Srinivas

> So I think some reorganization of the sentences would be useful to
> not=20
> jump between cases mid-paragraph without any hints.
>=20
> (I hope my explanation is enough to highlight why it was hard to
> follow).
>=20
> When I finally understood what the changelog was saying, I found out
> the=20
> code change is fine too but it first looked like it was doing exactly
> the=20
> opposite to my expectations/reasonale given in the changelog.
>=20


