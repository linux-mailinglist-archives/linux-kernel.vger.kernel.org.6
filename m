Return-Path: <linux-kernel+bounces-306766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71BA396433E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 13:39:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3AE21C23706
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 11:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6946A191F99;
	Thu, 29 Aug 2024 11:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RiWo/MaD"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 040361BC4E;
	Thu, 29 Aug 2024 11:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724931559; cv=none; b=KVUAWfScpzKtVjTweR2qJfXPVXleA+Tl5aWC+Dj2010eElILSmqRwn/hxE2Ju/frIRQ+Ymlzwi94jL/ZzvYWCWOkgfdpRaOrcf8WNAE2XFFq9l2qLXwSfbff7d9oEG0ttL5cQv5kIZrbLRNt0TvjulvSamkchwA8+NngYyb15Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724931559; c=relaxed/simple;
	bh=sGM4uplKjypkmLbLycCLYcQho8pHfbr9o0k/SZff0YE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GO9FqgPdtnrs1vq+pradUsT8VnYkQmBXAD7XRDhCD3jYxZRLyWMep3ENRSYqPSv4mySs83ZtAs0MomeNvRNLc+9n5YNxuJWUw0+Ea2UmEyVLVrodtRG7ik8c++dJKa9N3XRKc14soSF2cnxmC5N6ATH9b7u5MZN/OD8OO8/Iaf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RiWo/MaD; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724931558; x=1756467558;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=sGM4uplKjypkmLbLycCLYcQho8pHfbr9o0k/SZff0YE=;
  b=RiWo/MaD7Cvw/gpiEQGkUPJ7KTfoTY/E+3Xqtu6UB49KxnFlGI5QuNdP
   OlLDP+ihp4719ArgMOUnWyehI1midO02LfoBY31+Xlo8trjakPF9rhxZc
   00iza9ty/XSQNy1rKIZlA7RoYFmtCgS6n/dwUmJhx4jmGQiMNjMvZNxcl
   zR3z7U8WPTeG1Cez/cfE38zO1Buo0B86NDqd+GlsaeBBl2J+f60qsTJHQ
   uqrsotg2YNo0F1j39DLkkKTtOcfGNJ/JmQkMKuWNNashoeyFoFXlUtgCB
   OiDhYJcZxSpb5G27vEIbU1AjaUdKvk3Kes6rpwUvGwb8eRZCgtkfhAFHy
   A==;
X-CSE-ConnectionGUID: iBVHFozlQNaR3ue+/sS+9A==
X-CSE-MsgGUID: c8L2d5fISIGY18/tBgqK8g==
X-IronPort-AV: E=McAfee;i="6700,10204,11178"; a="23402475"
X-IronPort-AV: E=Sophos;i="6.10,185,1719903600"; 
   d="scan'208";a="23402475"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2024 04:39:15 -0700
X-CSE-ConnectionGUID: diY9O52cTWC64/WKu7u1Pw==
X-CSE-MsgGUID: 43Jo5YeMQwqgJTb0+HZwRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,185,1719903600"; 
   d="scan'208";a="67693623"
Received: from carterle-desk.ger.corp.intel.com ([10.245.246.205])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2024 04:39:13 -0700
Message-ID: <e1d7028e69cb226acf30ed5c316e5fea20546bc4.camel@linux.intel.com>
Subject: Re: [PATCH v2 1/3] Documentation: admin-guide: pm: Add efficiency
 vs. latency tradeoff to uncore documentation
From: Tero Kristo <tero.kristo@linux.intel.com>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>,
 srinivas.pandruvada@linux.intel.com,  platform-driver-x86@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>
Date: Thu, 29 Aug 2024 14:39:10 +0300
In-Reply-To: <d4939d77-8fab-f4b6-f1f7-4af05951d3eb@linux.intel.com>
References: <20240828153657.1296410-1-tero.kristo@linux.intel.com>
	 <20240828153657.1296410-2-tero.kristo@linux.intel.com>
	 <d4939d77-8fab-f4b6-f1f7-4af05951d3eb@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-08-29 at 12:18 +0300, Ilpo J=C3=A4rvinen wrote:
> On Wed, 28 Aug 2024, Tero Kristo wrote:
>=20
> > Added documentation about the functionality of efficiency vs.
> > latency tradeoff
> > control in intel Xeon processors, and how this is configured via
> > sysfs.
> >=20
> > Signed-off-by: Tero Kristo <tero.kristo@linux.intel.com>
> > ---
> > v2:
> > =C2=A0 * Largely re-wrote the documentation
> >=20
> > =C2=A0.../pm/intel_uncore_frequency_scaling.rst=C2=A0=C2=A0=C2=A0=C2=A0=
 | 59
> > +++++++++++++++++++
> > =C2=A01 file changed, 59 insertions(+)
> >=20
> > diff --git a/Documentation/admin-
> > guide/pm/intel_uncore_frequency_scaling.rst b/Documentation/admin-
> > guide/pm/intel_uncore_frequency_scaling.rst
> > index 5ab3440e6cee..26ded32b06f5 100644
> > --- a/Documentation/admin-
> > guide/pm/intel_uncore_frequency_scaling.rst
> > +++ b/Documentation/admin-
> > guide/pm/intel_uncore_frequency_scaling.rst
> > @@ -113,3 +113,62 @@ to apply at each uncore* level.
> > =C2=A0
> > =C2=A0Support for "current_freq_khz" is available only at each fabric
> > cluster
> > =C2=A0level (i.e., in uncore* directory).
> > +
> > +Efficiency vs. Latency Tradeoff
> > +-------------------------------
> > +
> > +The Efficiency Latency Control (ELC) feature improves performance
> > +per watt. With this feature hardware power management algorithms
> > +optimize trade-off between latency and power consumption. For some
> > +latency sensitive workloads further tuning can be done by SW to
> > +get desired performance.
> > +
> > +The hardware monitors the average CPU utilization across all cores
> > +in a power domain at regular intervals and decides an uncore
> > frequency.
> > +While this may result in the best performance per watt, workload
> > may be
> > +expecting higher performance at the expense of power. Consider an
> > +application that intermittently wakes up to perform memory reads
> > on an
> > +otherwise idle system. In such cases, if hardware lowers uncore
> > +frequency, then there may be delay in ramp up of frequency to meet
> > +target performance.
> > +
> > +The ELC control defines some parameters which can be changed from
> > SW.
> > +If the average CPU utilization is below a user defined threshold
> > +(elc_low_threshold_percent attribute below), the user defined
> > uncore
> > +frequency floor frequency will be used (elc_floor_freq_khz
> > attribute
>=20
> Consider the following simplification:
>=20
> "the user defined uncore frequency floor frequency" ->
> "the user-defined uncore floor frequency"
>=20
> I think it tells the same even without that first "frequency".
>=20
> Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
>=20

Yeah, it looks kind of silly. I think that's just a typo from my side,
thanks for catching.

-Tero

