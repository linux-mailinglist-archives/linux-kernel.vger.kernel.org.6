Return-Path: <linux-kernel+bounces-249441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F13692EBC5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 17:34:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B04521C23122
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 15:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 128E31662FE;
	Thu, 11 Jul 2024 15:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NyNEx3up"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72C01642B;
	Thu, 11 Jul 2024 15:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720712087; cv=none; b=Yzv3ZnB20XVDtLMBfBTrUW0ilgmGDlFuYiqgAcEdyzLuRJNnc34gINr9X6rIDXlXxKL2XV5yzXs8tuGcVK44t1j9bsk2BgK0OWlCczWf6H2QCNHVHQDYUnkkbcj6MiPrO0Y0ePnmNDGQh1bypJyq+ouUNXhQIkuJyZRX8emew6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720712087; c=relaxed/simple;
	bh=U5jon1rYFX1NVG83utEX/mdSih5YntDhhBFTKpbCiGQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nMGmOtv1/Jec0FHKwKhtk2uDtFTmNv/W+7SC/qyh6riZAZaQMDtZGybj225yFsyxEs0wIKqIrKy6qjIs9kviSXOG7WfvVyaFdMaeKY5K0q+9x2GDEkmoHprvt2vJAvXCxqJY7SQCfWCPFHudMBeA6qsG9S7AgjEklmngWLis6hE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NyNEx3up; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720712086; x=1752248086;
  h=message-id:subject:from:reply-to:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=U5jon1rYFX1NVG83utEX/mdSih5YntDhhBFTKpbCiGQ=;
  b=NyNEx3upIw3C3TnklcQ9EA4FRfx3MTBdbIZ8/OL3Py7Sqy1Wnvm08Ut+
   aObFkkpG0yyDKWVMpOKOdTJlKnHpVebZK9Yejhvkew3JvafzXGP6X0nbn
   ZNHvEgM0l4vjqIRCiyP/j9LlZUm7YAjF078PlbVmDiGotzDz5tO1R8GfB
   gfkjZ38o6XYNu7aXwCaJcnfc2a3qAXZqGzmQjdb7257DDS5aySEfA4IrD
   2oeTzncuWmxhWagxDSfYq+5OrcfUZsdeMmbRGqZv26UlmPVkjwtkP6Vu5
   8FjpV0UA5EBjZ1jnzTNpWCntr2hXMJ4zTferH7FXMXF46DfFIrVIysCFQ
   A==;
X-CSE-ConnectionGUID: rwcZK4rQRMijLGBzJdXY1Q==
X-CSE-MsgGUID: RBa1OcMhSyW/UwJvnCwl/g==
X-IronPort-AV: E=McAfee;i="6700,10204,11130"; a="17974840"
X-IronPort-AV: E=Sophos;i="6.09,200,1716274800"; 
   d="scan'208";a="17974840"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2024 08:34:45 -0700
X-CSE-ConnectionGUID: gC6Y0LgAQdOKD6RHyyz8tw==
X-CSE-MsgGUID: 0e13ganHTiCbMfQXMJE4hg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,200,1716274800"; 
   d="scan'208";a="53544670"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2024 08:34:45 -0700
Received: from [10.54.75.156] (debox1-desk1.jf.intel.com [10.54.75.156])
	by linux.intel.com (Postfix) with ESMTP id E172020738FE;
	Thu, 11 Jul 2024 08:34:44 -0700 (PDT)
Message-ID: <0da168ef21485ee944ceedbc1b77f3141f741dfe.camel@linux.intel.com>
Subject: Re: [PATCH v2] platform/x86:intel/pmc: Enable the ACPI PM Timer to
 be turned off when suspended
From: "David E. Box" <david.e.box@linux.intel.com>
Reply-To: david.e.box@linux.intel.com
To: Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>, Marek Maslanka
	 <mmaslanka@google.com>
Cc: LKML <linux-kernel@vger.kernel.org>, David E Box
 <david.e.box@intel.com>,  Hans de Goede <hdegoede@redhat.com>, Ilpo
 =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 platform-driver-x86@vger.kernel.org, Rafael J Wysocki <rjw@rjwysocki.net>
Date: Thu, 11 Jul 2024 08:34:44 -0700
In-Reply-To: <CAE2upjS-hzciBNm+csXM+i-dnW1knBEyAwcGDya1WCezxD7M=Q@mail.gmail.com>
References: 
	<CAGcaFA3c_rc6HVVqc2=UqOgu2c7zX_XTWNx7Yf-KL7W8LgEi7A@mail.gmail.com>
	 <20240703113850.2726539-1-mmaslanka@google.com>
	 <CAE2upjS-hzciBNm+csXM+i-dnW1knBEyAwcGDya1WCezxD7M=Q@mail.gmail.com>
Autocrypt: addr=david.e.box@linux.intel.com; prefer-encrypt=mutual;
 keydata=mQENBF2w2YABCACw5TpqmFTR6SgsrNqZE8ro1q2lUgVZda26qIi8GeHmVBmu572RfPydisEpCK246rYM5YY9XAps810ZxgFlLyBqpE/rxB4Dqvh04QePD6fQNui/QCSpyZ6j9F8zl0zutOjfNTIQBkcar28hazL9I8CGnnMko21QDl4pkrq1dgLSgl2r2N1a6LJ2l8lLnQ1NJgPAev4BWo4WAwH2rZ94aukzAlkFizjZXmB/6em+lhinTR9hUeXpTwcaAvmCHmrUMxeOyhx+csO1uAPUjxL7olj2J83dv297RrpjMkDyuUOv8EJlPjvVogJF1QOd5MlkWdj+6vnVDRfO8zUwm2pqg25DABEBAAG0KkRhdmlkIEUuIEJveCA8ZGF2aWQuZS5ib3hAbGludXguaW50ZWwuY29tPokBTgQTAQgAOBYhBBFoZ8DYRC+DyeuV6X7Mry1gl3p/BQJdsNmAAhsDBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAAAoJEH7Mry1gl3p/NusIAK9z1xnXphedgZMGNzifGUs2UUw/xNl91Q9qRaYGyNYATI6E7zBYmynsUL/4yNFnXK8P/I7WMffiLoMqmUvNp9pG6oYYj8ouvbCexS21jgw54I3m61M+wTokieRIO/GettVlCGhz7YHlHtGGqhzzWB3CGPSJMwsouDPvyFFE+28p5d2v9l6rXSb7T297Kh50VX9Ele8QEKngrG+Z/u2lr/bHEhvx24vI8ka22cuTaZvThYMwLTSC4kq9L9WgRv31JBSa1pcbcHLOCoUl0RaQwe6J8w9hN2uxCssHrrfhSA4YjxKNIIp3YH4IpvzuDR3AadYz1klFTnEOxIM7fvQ2iGu5AQ0EXbDZgAEIAPGbL3wvbYUDGMoBSN89GtiC6ybWo28JSiYIN5N9LhDTwfWROenkRvmTESaE5fAM24sh8S0h+F+eQ7j/E/RF3pM31gSovTKw0Pxk7GorK
	FSa25CWemxSV97zV8fVegGkgfZkBMLUId+AYCD1d2R+tndtgjrHtVq/AeN0N09xv/d3a+Xzc4ib/SQh9mM50ksqiDY70EDe8hgPddYH80jHJtXFVA7Ar1ew24TIBF2rxYZQJGLe+Mt2zAzxOYeQTCW7WumD/ZoyMm7bg46/2rtricKnpaACM7M0r7g+1gUBowFjF4gFqY0tbLVQEB/H5e9We/C2zLG9r5/Lt22dj7I8A6kAEQEAAYkBNgQYAQgAIBYhBBFoZ8DYRC+DyeuV6X7Mry1gl3p/BQJdsNmAAhsMAAoJEH7Mry1gl3p/Z/AH/Re8YwzY5I9ByPM56B3Vkrh8qihZjsF7/WB14Ygl0HFzKSkSMTJ+fvZv19bk3lPIQi5lUBuU5rNruDNowCsnvXr+sFxFyTbXw0AQXIsnX+EkMg/JO+/V/UszZiqZPkvHsQipCFVLod/3G/yig9RUO7A/1efRi0E1iJAa6qHrPqE/kJANbz/x+9wcx1VfFwraFXbdT/P2JeOcW/USW89wzMRmOo+AiBSnTI4xvb1s/TxSfoLZvtoj2MR+2PW1zBALWYUKHOzhfFKs3cMufwIIoQUPVqGVeH+u6Asun6ZpNRxdDONop+uEXHe6q6LzI/NnczqoZQLhM8d1XqokYax/IZ4=
Organization: David E. Box
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Marek. Thanks for the patch.

On Wed, 2024-07-03 at 12:30 -0400, Rajneesh Bhardwaj wrote:
> On Wed, Jul 3, 2024 at 7:39=E2=80=AFAM Marek Maslanka <mmaslanka@google.c=
om> wrote:
> >=20
> > Allow to disable ACPI PM Timer on suspend and enable on resume. A
> > disabled timer helps optimise power consumption when the system is
> > suspended. On resume the timer is only reactivated if it was activated
> > prior to suspend, so unless the ACPI PM timer is enabled in the BIOS,
> > this won't change anything.
>=20
> Back in the days IIRC, it was frowned upon but I am not sure anymore.
> Maybe Rafael or David will have some opinion on this change. Is this
> something that could be done in a platform specific manner such as in
> coreboot?

I discussed with Rafael. This is generally a good idea, but need to ensure =
that
the ACPI PM Timer isn't being used as a clock source. This could mess with =
the
timekeeping system. Also, maybe a better idea is to disable it altogether a=
t
probe time if it's not being used as a clock source. This should only be th=
e
case when TSC is unstable and HPET is unavailable, but need to confirm.

David

>=20
> >=20
> > Signed-off-by: Marek Maslanka <mmaslanka@google.com>
> > ---
> > =C2=A0drivers/platform/x86/intel/pmc/adl.c=C2=A0 |=C2=A0 2 ++
> > =C2=A0drivers/platform/x86/intel/pmc/cnp.c=C2=A0 |=C2=A0 2 ++
> > =C2=A0drivers/platform/x86/intel/pmc/core.c | 37 ++++++++++++++++++++++=
+++++
> > =C2=A0drivers/platform/x86/intel/pmc/core.h |=C2=A0 8 ++++++
> > =C2=A0drivers/platform/x86/intel/pmc/icl.c=C2=A0 |=C2=A0 2 ++
> > =C2=A0drivers/platform/x86/intel/pmc/mtl.c=C2=A0 |=C2=A0 2 ++
> > =C2=A0drivers/platform/x86/intel/pmc/spt.c=C2=A0 |=C2=A0 2 ++
> > =C2=A0drivers/platform/x86/intel/pmc/tgl.c=C2=A0 |=C2=A0 2 ++
> > =C2=A08 files changed, 57 insertions(+)
> >=20
> > diff --git a/drivers/platform/x86/intel/pmc/adl.c
> > b/drivers/platform/x86/intel/pmc/adl.c
> > index e7878558fd909..9d9c07f44ff61 100644
> > --- a/drivers/platform/x86/intel/pmc/adl.c
> > +++ b/drivers/platform/x86/intel/pmc/adl.c
> > @@ -295,6 +295,8 @@ const struct pmc_reg_map adl_reg_map =3D {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .ppfear_buckets =3D CNP_PPFE=
AR_NUM_ENTRIES,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .pm_cfg_offset =3D CNP_PMC_P=
M_CFG_OFFSET,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .pm_read_disable_bit =3D CNP=
_PMC_READ_DISABLE_BIT,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .acpi_pm_tmr_ctl_offset =3D SPT_P=
MC_ACPI_PM_TMR_CTL_OFFSET,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .acpi_pm_tmr_disable_bit =3D SPT_=
PMC_BIT_ACPI_PM_TMR_DISABLE,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .ltr_ignore_max =3D ADL_NUM_=
IP_IGN_ALLOWED,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .lpm_num_modes =3D ADL_LPM_N=
UM_MODES,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .lpm_num_maps =3D ADL_LPM_NU=
M_MAPS,
> > diff --git a/drivers/platform/x86/intel/pmc/cnp.c
> > b/drivers/platform/x86/intel/pmc/cnp.c
> > index dd72974bf71e2..513c02670c5aa 100644
> > --- a/drivers/platform/x86/intel/pmc/cnp.c
> > +++ b/drivers/platform/x86/intel/pmc/cnp.c
> > @@ -200,6 +200,8 @@ const struct pmc_reg_map cnp_reg_map =3D {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .ppfear_buckets =3D CNP_PPFE=
AR_NUM_ENTRIES,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .pm_cfg_offset =3D CNP_PMC_P=
M_CFG_OFFSET,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .pm_read_disable_bit =3D CNP=
_PMC_READ_DISABLE_BIT,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .acpi_pm_tmr_ctl_offset =3D SPT_P=
MC_ACPI_PM_TMR_CTL_OFFSET,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .acpi_pm_tmr_disable_bit =3D SPT_=
PMC_BIT_ACPI_PM_TMR_DISABLE,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .ltr_ignore_max =3D CNP_NUM_=
IP_IGN_ALLOWED,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .etr3_offset =3D ETR3_OFFSET=
,
> > =C2=A0};
> > diff --git a/drivers/platform/x86/intel/pmc/core.c
> > b/drivers/platform/x86/intel/pmc/core.c
> > index 10c96c1a850af..e97ac7a8a18bc 100644
> > --- a/drivers/platform/x86/intel/pmc/core.c
> > +++ b/drivers/platform/x86/intel/pmc/core.c
> > @@ -1171,6 +1171,35 @@ static bool pmc_core_is_pson_residency_enabled(s=
truct
> > pmc_dev *pmcdev)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return val =3D=3D 1;
> > =C2=A0}
> >=20
> > +/*
> > + * Enable or disable APCI PM Timer
> > + *
> > + * @return: Previous APCI PM Timer enabled state
> > + */
> > +static bool pmc_core_enable_apci_pm_timer(struct pmc_dev *pmcdev, bool
> > enable)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct pmc *pmc =3D pmcdev->pmcs[=
PMC_IDX_MAIN];
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const struct pmc_reg_map *map =3D=
 pmc->map;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool state;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u32 reg;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!map->acpi_pm_tmr_ctl_offset)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 return false;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mutex_lock(&pmcdev->lock);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reg =3D pmc_core_reg_read(pmc, ma=
p->acpi_pm_tmr_ctl_offset);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 state =3D !(reg & map->acpi_pm_tm=
r_disable_bit);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (enable)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 reg &=3D ~map->acpi_pm_tmr_disable_bit;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 reg |=3D map->acpi_pm_tmr_disable_bit;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pmc_core_reg_write(pmc, map->acpi=
_pm_tmr_ctl_offset, reg);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mutex_unlock(&pmcdev->lock);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return state;
> > +}
> >=20
> > =C2=A0static void pmc_core_dbgfs_unregister(struct pmc_dev *pmcdev)
> > =C2=A0{
> > @@ -1446,6 +1475,10 @@ static __maybe_unused int pmc_core_suspend(struc=
t
> > device *dev)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (pmcdev->suspend)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 pmcdev->suspend(pmcdev);
> >=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Disable APCI PM Timer */
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pmcdev->enable_acpi_pm_timer_on_r=
esume =3D
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 pmc_core_enable_apci_pm_timer(pmcdev, false);
> > +
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Check if the syspend will=
 actually use S0ix */
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (pm_suspend_via_firmware(=
))
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 return 0;
> > @@ -1500,6 +1533,10 @@ int pmc_core_resume_common(struct pmc_dev *pmcde=
v)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int offset =3D pmc->map->lpm=
_status_offset;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int i;
> >=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Enable APCI PM Timer */
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (pmcdev->enable_acpi_pm_timer_=
on_resume)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 pmc_core_enable_apci_pm_timer(pmcdev, true);
> > +
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Check if the syspend used=
 S0ix */
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (pm_suspend_via_firmware(=
))
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 return 0;
> > diff --git a/drivers/platform/x86/intel/pmc/core.h
> > b/drivers/platform/x86/intel/pmc/core.h
> > index 83504c49a0e31..fe1a94f693b63 100644
> > --- a/drivers/platform/x86/intel/pmc/core.h
> > +++ b/drivers/platform/x86/intel/pmc/core.h
> > @@ -67,6 +67,8 @@ struct telem_endpoint;
> > =C2=A0#define SPT_PMC_LTR_SCC=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x3A0
> > =C2=A0#define SPT_PMC_LTR_ISH=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x3A4
> >=20
> > +#define SPT_PMC_ACPI_PM_TMR_CTL_OFFSET=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 0x18FC
> > +
> > =C2=A0/* Sunrise Point: PGD PFET Enable Ack Status Registers */
> > =C2=A0enum ppfear_regs {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 SPT_PMC_XRAM_PPFEAR0A =3D 0x=
590,
> > @@ -147,6 +149,8 @@ enum ppfear_regs {
> > =C2=A0#define SPT_PMC_VRIC1_SLPS0LVEN=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BIT(13)
> > =C2=A0#define SPT_PMC_VRIC1_XTALSDQDIS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BIT(22)
> >=20
> > +#define SPT_PMC_BIT_ACPI_PM_TMR_DISABLE=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BIT(1)
> > +
> > =C2=A0/* Cannonlake Power Management Controller register offsets */
> > =C2=A0#define CNP_PMC_SLPS0_DBG_OFFSET=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x10B4
> > =C2=A0#define CNP_PMC_PM_CFG_OFFSET=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x1818
> > @@ -344,6 +348,8 @@ struct pmc_reg_map {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const u8=C2=A0 *lpm_reg_inde=
x;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const u32 pson_residency_off=
set;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const u32 pson_residency_cou=
nter_step;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const u32 acpi_pm_tmr_ctl_offset;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const u32 acpi_pm_tmr_disable_bit=
;
> > =C2=A0};
> >=20
> > =C2=A0/**
> > @@ -417,6 +423,8 @@ struct pmc_dev {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u32 die_c6_offset;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct telem_endpoint *punit=
_ep;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct pmc_info *regmap_list=
;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool enable_acpi_pm_timer_on_resu=
me;
> > =C2=A0};
> >=20
> > =C2=A0enum pmc_index {
> > diff --git a/drivers/platform/x86/intel/pmc/icl.c
> > b/drivers/platform/x86/intel/pmc/icl.c
> > index 71b0fd6cb7d84..cbbd440544688 100644
> > --- a/drivers/platform/x86/intel/pmc/icl.c
> > +++ b/drivers/platform/x86/intel/pmc/icl.c
> > @@ -46,6 +46,8 @@ const struct pmc_reg_map icl_reg_map =3D {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .ppfear_buckets =3D ICL_PPFE=
AR_NUM_ENTRIES,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .pm_cfg_offset =3D CNP_PMC_P=
M_CFG_OFFSET,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .pm_read_disable_bit =3D CNP=
_PMC_READ_DISABLE_BIT,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .acpi_pm_tmr_ctl_offset =3D SPT_P=
MC_ACPI_PM_TMR_CTL_OFFSET,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .acpi_pm_tmr_disable_bit =3D SPT_=
PMC_BIT_ACPI_PM_TMR_DISABLE,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .ltr_ignore_max =3D ICL_NUM_=
IP_IGN_ALLOWED,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .etr3_offset =3D ETR3_OFFSET=
,
> > =C2=A0};
> > diff --git a/drivers/platform/x86/intel/pmc/mtl.c
> > b/drivers/platform/x86/intel/pmc/mtl.c
> > index c7d15d864039d..91f2fa728f5c8 100644
> > --- a/drivers/platform/x86/intel/pmc/mtl.c
> > +++ b/drivers/platform/x86/intel/pmc/mtl.c
> > @@ -462,6 +462,8 @@ const struct pmc_reg_map mtl_socm_reg_map =3D {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .ppfear_buckets =3D MTL_SOCM=
_PPFEAR_NUM_ENTRIES,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .pm_cfg_offset =3D CNP_PMC_P=
M_CFG_OFFSET,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .pm_read_disable_bit =3D CNP=
_PMC_READ_DISABLE_BIT,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .acpi_pm_tmr_ctl_offset =3D SPT_P=
MC_ACPI_PM_TMR_CTL_OFFSET,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .acpi_pm_tmr_disable_bit =3D SPT_=
PMC_BIT_ACPI_PM_TMR_DISABLE,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .lpm_num_maps =3D ADL_LPM_NU=
M_MAPS,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .ltr_ignore_max =3D MTL_SOCM=
_NUM_IP_IGN_ALLOWED,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .lpm_res_counter_step_x2 =3D=
 TGL_PMC_LPM_RES_COUNTER_STEP_X2,
> > diff --git a/drivers/platform/x86/intel/pmc/spt.c
> > b/drivers/platform/x86/intel/pmc/spt.c
> > index ab993a69e33ee..2cd2b3c68e468 100644
> > --- a/drivers/platform/x86/intel/pmc/spt.c
> > +++ b/drivers/platform/x86/intel/pmc/spt.c
> > @@ -130,6 +130,8 @@ const struct pmc_reg_map spt_reg_map =3D {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .ppfear_buckets =3D SPT_PPFE=
AR_NUM_ENTRIES,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .pm_cfg_offset =3D SPT_PMC_P=
M_CFG_OFFSET,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .pm_read_disable_bit =3D SPT=
_PMC_READ_DISABLE_BIT,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .acpi_pm_tmr_ctl_offset =3D SPT_P=
MC_ACPI_PM_TMR_CTL_OFFSET,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .acpi_pm_tmr_disable_bit =3D SPT_=
PMC_BIT_ACPI_PM_TMR_DISABLE,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .ltr_ignore_max =3D SPT_NUM_=
IP_IGN_ALLOWED,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .pm_vric1_offset =3D SPT_PMC=
_VRIC1_OFFSET,
> > =C2=A0};
> > diff --git a/drivers/platform/x86/intel/pmc/tgl.c
> > b/drivers/platform/x86/intel/pmc/tgl.c
> > index e0580de180773..371b4e30f1426 100644
> > --- a/drivers/platform/x86/intel/pmc/tgl.c
> > +++ b/drivers/platform/x86/intel/pmc/tgl.c
> > @@ -197,6 +197,8 @@ const struct pmc_reg_map tgl_reg_map =3D {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .ppfear_buckets =3D ICL_PPFE=
AR_NUM_ENTRIES,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .pm_cfg_offset =3D CNP_PMC_P=
M_CFG_OFFSET,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .pm_read_disable_bit =3D CNP=
_PMC_READ_DISABLE_BIT,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .acpi_pm_tmr_ctl_offset =3D SPT_P=
MC_ACPI_PM_TMR_CTL_OFFSET,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .acpi_pm_tmr_disable_bit =3D SPT_=
PMC_BIT_ACPI_PM_TMR_DISABLE,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .ltr_ignore_max =3D TGL_NUM_=
IP_IGN_ALLOWED,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .lpm_num_maps =3D TGL_LPM_NU=
M_MAPS,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .lpm_res_counter_step_x2 =3D=
 TGL_PMC_LPM_RES_COUNTER_STEP_X2,
> > --
> > 2.45.2.803.g4e1b14247a-goog
> >=20
>=20
>=20


