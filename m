Return-Path: <linux-kernel+bounces-373474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08F759A5737
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 00:10:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37D3C1C20F0D
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 22:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 295A119882B;
	Sun, 20 Oct 2024 22:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gvUF2b8O"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B0C836124;
	Sun, 20 Oct 2024 22:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729462216; cv=none; b=HgXxObuxAepZAl1Ez/f04b+4seIPVz5OhINdQDrmzR0lcJUFUi1MCx09/qAESTSZkrnRsM/y5SV4usgPVfTev37PqcHtP2o86ezuGGkr4zl4KW2QYPcxacCdsjVASLuzuhW8FQu9Sl25vum0SR0iOJqOp7hJph3oCUD8XHbkblo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729462216; c=relaxed/simple;
	bh=orK88O5B1OE3fuixoCT2tIoGPe2dV1+Pk0OTqS7pe3A=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=br74b8A9EUkoHdI297xaWjH/omNjuDPiaEgV9qBtC26uAeiR1L3O6bKhsTSfvQkYJKb5csbRN8PPhcV2kKwowaFMUFBCIqXbVM35KBqZau9kM0nhMqptmqm69T4OpxYCY/anpWs03dBTBLXMGvJPmCrEDAhgM9ptsebDWzCkMDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gvUF2b8O; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729462214; x=1760998214;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=orK88O5B1OE3fuixoCT2tIoGPe2dV1+Pk0OTqS7pe3A=;
  b=gvUF2b8OsHdWACQe+u5/34D/yEFdSku9TjRS7+u3f02X2vwsSZ5jCrUp
   aBqVw/zSK4cpUjQ71EpOcGClv9EKL25k/Ycqih8FDBdYWzsEc93uK098i
   xVYhNUbZmJcVpOsmBvOVF6kdYxHcJhKvTy+wukVbbTbrSlAlRZ+wCu8sM
   dK8ttXDnC0YOhOc7XbGdFsuLXJSQa92/z1sOroGLQIdWggC6+81jb6qzz
   +xCdV7gU/qJdxX6CsKeQnaxf8D8sQvNqH70Ozcz5iekzHt2ST4M/sf1SW
   kR2n6LhpLitPMmBN+U9QAM3WFExE4f9T/1iruxKgz566KlumJM8blRYvo
   w==;
X-CSE-ConnectionGUID: Xr7VOWJSS3yg0WU6eka9eQ==
X-CSE-MsgGUID: Sj21dNtRQb2NePoZ/37eow==
X-IronPort-AV: E=McAfee;i="6700,10204,11231"; a="29031457"
X-IronPort-AV: E=Sophos;i="6.11,219,1725346800"; 
   d="scan'208";a="29031457"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2024 15:10:13 -0700
X-CSE-ConnectionGUID: AWCkhnulRd6M7QFB46MBgg==
X-CSE-MsgGUID: nW2Y1RXMQW2WwXXhlba6RQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,219,1725346800"; 
   d="scan'208";a="84410501"
Received: from spandruv-desk1.amr.corp.intel.com ([10.125.110.18])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2024 15:10:14 -0700
Message-ID: <83af2aa34c08cc153649ef40fa5228efcfaddac8.camel@linux.intel.com>
Subject: Re: [PATCH] platform/x86: asus-wmi: Support setting AIPT modes
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: Armin Wolf <W_Armin@gmx.de>, corentin.chary@gmail.com, luke@ljones.dev, 
	hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Michael Larabel <Michael@phoronix.com>, Casey Bowman
 <casey.g.bowman@intel.com>
Date: Sun, 20 Oct 2024 15:10:13 -0700
In-Reply-To: <eee71aa0-d0db-48a7-ade9-4b444c087de5@gmx.de>
References: <20241020065051.1724435-1-srinivas.pandruvada@linux.intel.com>
	 <911ce141-8f20-48fb-bc43-e6d4262dbc81@gmx.de>
	 <c5aee6fc77427daca6e009cd22c3637bffec0219.camel@linux.intel.com>
	 <eee71aa0-d0db-48a7-ade9-4b444c087de5@gmx.de>
Autocrypt: addr=srinivas.pandruvada@linux.intel.com; prefer-encrypt=mutual;
 keydata=mQGNBGYHNAsBDAC7tv5u9cIsSDvdgBBEDG0/a/nTaC1GXOx5MFNEDL0LWia2p8Asl7igx
 YrB68fyfPNLSIgtCmps0EbRUkPtoN5/HTbAEZeJUTL8Xdoe6sTywf8/6/DMheEUzprE4Qyjt0HheW
 y1JGvdOA0f1lkxCnPXeiiDY4FUqQHr3U6X4FPqfrfGlrMmGvntpKzOTutlQl8eSAprtgZ+zm0Jiwq
 NSiSBOt2SlbkGu9bBYx7mTsrGv+x7x4Ca6/BO9o5dIvwJOcfK/cXC/yxEkr1ajbIUYZFEzQyZQXrT
 GUGn8j3/cXQgVvMYxrh3pGCq9Q0Q6PAwQYhm97ipXa86GcTpP5B2ip9xclPtDW99sihiL8euTWRfS
 TUsEI+1YzCyz5DU32w3WiXr3ITicaMV090tMg9phIZsjfFbnR8hY03n0kRNWWFXi/ch2MsZCCqXIB
 oY/SruNH9Y6mnFKW8HSH762C7On8GXBYJzH6giLGeSsbvis2ZmV/r+LmswwZ6ACcOKLlvvIukAEQE
 AAbQ5U3Jpbml2YXMgUGFuZHJ1dmFkYSA8c3Jpbml2YXMucGFuZHJ1dmFkYUBsaW51eC5pbnRlbC5j
 b20+iQHRBBMBCAA7FiEEdki2SeUi0wlk2xcjOqtdDMJyisMFAmYHNAsCGwMFCwkIBwICIgIGFQoJC
 AsCBBYCAwECHgcCF4AACgkQOqtdDMJyisMobAv+LLYUSKNuWhRN3wS7WocRPCi3tWeBml+qivCwyv
 oZbmE2LcxYFnkcj6YNoS4N1CHJCr7vwefWTzoKTTDYqz3Ma0D0SbR1p/dH0nDgN34y41HpIHf0tx0
 UxGMgOWJAInq3A7/mNkoLQQ3D5siG39X3bh9Ecg0LhMpYwP/AYsd8X1ypCWgo8SE0J/6XX/HXop2a
 ivimve15VklMhyuu2dNWDIyF2cWz6urHV4jmxT/wUGBdq5j87vrJhLXeosueRjGJb8/xzl34iYv08
 wOB0fP+Ox5m0t9N5yZCbcaQug3hSlgp9hittYRgIK4GwZtNO11bOzeCEMk+xFYUoa5V8JWK9/vxrx
 NZEn58vMJ/nxoJzkb++iV7KBtsqErbs5iDwFln/TRJAQDYrtHJKLLFB9BGUDuaBOmFummR70Rbo55
 J9fvUHc2O70qteKOt5A0zv7G8uUdIaaUHrT+VOS7o+MrbPQcSk+bl81L2R7TfWViCmKQ60sD3M90Y
 oOfCQxricddC
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2024-10-20 at 21:54 +0200, Armin Wolf wrote:
> Am 20.10.24 um 21:27 schrieb srinivas pandruvada:
>=20
> > [...]
> >=20
> > > > +	adev =3D acpi_dev_get_first_match_dev("PNP0C14", "ATK",
> > > > -1);
> > > Is there really no way of changing the AIPT mode through the WMI
> > > interface?
> > > I would prefer using the WMI interface if available, since the
> > > firmware might
> > > assume that FANL is only called through the WMI interface.
> > >=20
> > I wish the same. Didn't find any. Asus is aware of this change
> > which I
> > submitted, they didn't suggest that there is alternative.
> >=20
> > > Do you have a acpidump from a affected device?
> > >=20
> > Will send you.
> >=20
> > Thanks,
> > Srinivas
>=20
> Thanks,
>=20
> the return value of DSTS() on your device contains:
>=20
> - 8-bit current AIPT mode
> - 8-bit nothing
> - 8-bit constant 0x07
> - 8-bit constant 0x0a
>=20
> Maybe you can try to find out more about the unknown constants. For
> the rest, you can use
> the helper functions provided by the driver.

Thanks for looking into this. I will get help from Asus.

-Srinivas

>=20
> Thanks,
> Armin Wolf
>=20
> > > Thanks,
> > > Armin Wolf
> > >=20
> > > > +	if (adev) {
> > > > +		acpi_handle handle =3D acpi_device_handle(adev);
> > > > +
> > > > +		acpi_dev_put(adev);
> > > > +
> > > > +		if (!acpi_has_method(handle, "FANL"))
> > > > +			return 0;
> > > > +
> > > > +		asus->acpi_mgmt_handle =3D handle;
> > > > +		asus->asus_aipt_present =3D true;
> > > > +		dev_info(dev, "ASUS Intelligent Performance
> > > > Technology (AIPT) is present\n");
> > > > +		/*
> > > > +		 * Set the mode corresponding to default Linux
> > > > platform power
> > > > +		 * profile Balanced
> > > > +		 */
> > > > +		asus_wmi_write_aipt_mode(asus, AIPT_STANDARD);
> > > > +	}
> > > > +
> > > > =C2=A0=C2=A0=C2=A0	return 0;
> > > > =C2=A0=C2=A0 }
> > > >=20
> >=20


