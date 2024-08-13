Return-Path: <linux-kernel+bounces-284929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF902950702
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 15:58:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F0AE28446D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 13:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AB7519D075;
	Tue, 13 Aug 2024 13:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cJyFruFL"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 738E219B3DA;
	Tue, 13 Aug 2024 13:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723557515; cv=none; b=cQm247uL1WLm5+C73Wi3hTbHOaiq/I9ZiAIDQ0lO0YJ02fm7LAlx4jFoE/Di/Z/rNm4YIqTk5gDkLHujgiRLo2RXqQmM1wcrfiLec6lbjKQayjdYG8z6i2YNQHO41dJCdgh44QI1Q4d98UNoSujCMbFjrUfe6hyfzW2sARYH+10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723557515; c=relaxed/simple;
	bh=fBCpj/Tr63gawm2Rj6wjNEQS+oADMzCA84Mjg4D2nCM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=U6XbGBNGehjZJJEQN8VVU0F6yDpwlVMFrU9rNUAjyLxGraZfk3kjtlQRasBw0Kp9sBgUIPD2cNhfdBJZqk+2MbJs3gZNyxiMyYGlDWaSYMpzXZRYB6obLi6neqyLftAibTJ1SMrBNuV/vS46hXG7EWQI4QgYKGbme1W46vi02Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cJyFruFL; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723557514; x=1755093514;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=fBCpj/Tr63gawm2Rj6wjNEQS+oADMzCA84Mjg4D2nCM=;
  b=cJyFruFLj2IDzh+BqaChDEDZQlyM8wbd5AalpbsiMxbTxwU0M4VDYiVl
   iklp4uPs2rmJvGpyJYnBZ4IYEKNVoJ0h7CQtezmvOLyUkeknVzwQjSbxn
   r1ONIpsHQwG0LUrM98XvD7GImbH5pdUAFinVlM2L9fbCr+XdQ4hho46Dw
   /VzOfPYQMWvtAIWPSNOOJM8HGkbq45y52S2tL5F4B0H8VDl3X4I8KmzxG
   0UJW98HXmipsuF2k00uuLR9JlbaH319ok/KqbMh6XbYZfv0QdmMSwT/+9
   SPmIg7O5lkhRapNj3Aj+9Xb4QGNKxe14oBmxPYL7QIsCk3cKy8nCoO3jc
   Q==;
X-CSE-ConnectionGUID: Bg+c60+iRwuMMgMpuudF5g==
X-CSE-MsgGUID: jF90FJ6zQ9WMQmwVpCss6w==
X-IronPort-AV: E=McAfee;i="6700,10204,11163"; a="21279682"
X-IronPort-AV: E=Sophos;i="6.09,286,1716274800"; 
   d="scan'208";a="21279682"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 06:58:33 -0700
X-CSE-ConnectionGUID: toYLEk4XRrWqbw+w23amXw==
X-CSE-MsgGUID: P0OISNwIRXK9FFRx+rNlPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,286,1716274800"; 
   d="scan'208";a="58640019"
Received: from rfrazer-mobl3.amr.corp.intel.com (HELO spandruv-desk1.amr.corp.intel.com) ([10.125.109.189])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 06:58:32 -0700
Message-ID: <826971a048e27f726e8258d4355bdc976a74d0f4.camel@linux.intel.com>
Subject: Re: [PATCH] platform/x86/intel-uncore-freq: Do not present separate
 package-die domain
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, platform-driver-x86@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>
Date: Tue, 13 Aug 2024 06:58:32 -0700
In-Reply-To: <3982985e-d8c1-7307-7187-aae438d9b75e@linux.intel.com>
References: <20240731185756.1853197-1-srinivas.pandruvada@linux.intel.com>
	 <cd7cc6b8-4993-937b-072b-8fbc1e309a4d@linux.intel.com>
	 <d21c069438cc9c314e29fe9b75a97cf15ab6e087.camel@linux.intel.com>
	 <3982985e-d8c1-7307-7187-aae438d9b75e@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-08-13 at 10:51 +0300, Ilpo J=C3=A4rvinen wrote:
> On Mon, 12 Aug 2024, srinivas pandruvada wrote:
> > On Mon, 2024-08-12 at 14:16 +0300, Ilpo J=C3=A4rvinen wrote:
> > > On Wed, 31 Jul 2024, Srinivas Pandruvada wrote:
> > >=20
> > > > The scope of uncore control is per power domain in a package
> > > > and
> > > > die.
> > > > A package-die can have multiple power domains on some
> > > > processors.
> > > > In this
> > > > case package-die domain (root domain) aggregates all
> > > > information
> > > > from
> > > > power domains in it.
> > > >=20
> > > > On some processors, CPUID enumerates the die number same as
> > > > power
> > > > domain
> > > > ID. In this case there is one to one relationship between
> > > > package-
> > > > die and
> > > > power domain ID. There is no use of aggregating information
> > > > from
> > > > all
> > > > power domain IDs as the information will be duplicate and
> > > > confusing. In
> > > > this case do not create separate package-die domain.
> > >=20
> > > Hi Srinivas,
> > >=20
> > > I got confused by this changelog because its order is quite
> > > illogical.
> > >=20
> > > First paragraph talks about case A. When you say "all
> > > information"=20
> > > is "aggregated", I immediately make the assumption that the
> > > aggregated=20
> > > information is what is wanted because, well, you normally want
> > > "all=20
> > > information" and nothing else is being told here.
> > >=20
> > > Second paragraph starts to talk about case B and then suddenly
> > > switches to=20
> > > talk what should have been done in case A (that aggregated
> > > information is=20
> > > useless/confusing).
> > >=20
> > Is this any better:
> >=20
> > "
> > The scope of uncore control is per power domain in a package and
> > die
> > with TPMI.
> >=20
> > There are two types of processor configurations possible:
> > 1. A compute die is not enumerated in CPUID. In this case there is
> > only
> > one die in a package. In this case there will be multiple power
> > domains
> > in a single die.
> > 2. A power domain in a package is enumerated as a compute die in
> > CPUID.
> > So there is one to one relationship between a die and power domain.
>=20
> So there are multiple dies in a package and one to one relationship=20
> between a die and power domain.
In case 2, yes.

>=20
> >=20
> > To allow die level controls, the current implementation creates a
> > root
> > domain and aggregates all information from power domains in it.
> > This
> > is well suited for configuration 1 above.
> >=20
> > But when newer processors use configuration 2 above, this will
> > present
> > redundant information, So no use of aggregating. In this case do
> > not
> > create separate root domain.
> > "
>=20
> Yes, it is now clearer. A minor suggestion above to better map with
> the=20
> code (explicitly stating the condition that matches to the check done
> by the code).
OK.

Thanks,
Srinivas

>=20


