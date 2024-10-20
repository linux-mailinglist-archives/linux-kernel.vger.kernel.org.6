Return-Path: <linux-kernel+bounces-373388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B33019A562B
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 21:27:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4ADF1C20A67
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 19:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCE8E196C67;
	Sun, 20 Oct 2024 19:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QvoUU09t"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4794192D7E;
	Sun, 20 Oct 2024 19:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729452435; cv=none; b=L16U/O3PxW1g1OZtTiQo/f9kb6mdDvjC3K65Qgzmn2RgBAchyLh0xkvD+Sc08ghkA4CUX6S5/s46NsVHWqqw7CI2AyQfmvmbA22Yo9tRkeSkNH1W/C3pMPz6GJA9X7ghP2i56O0L+SWaPwdFEq9wY18ibEnS8kS7hIpDn7zeJAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729452435; c=relaxed/simple;
	bh=sSHVtz9z0qvwH1E4Tas4Q+XocOgDDP0wNCO7Ab9f3lw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gNaUFXpfXruSblAP98KDtGmoW6bAdm7hGxg01YWYapAUV9uTGSEnL1bO4W4+919eJ5l3egD5mWaMfwhRGimqVlVThu0bD5EzauhhNFOWm7rCWM/QIEw0mELt0acAKUnDk1NEIM+9Qyop9mrTRuWNmKbZsnwZFfXIFq9jI9UTlW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QvoUU09t; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729452433; x=1760988433;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=sSHVtz9z0qvwH1E4Tas4Q+XocOgDDP0wNCO7Ab9f3lw=;
  b=QvoUU09tzBypoH8RY+NpdT6yutWz1+8B/+UAWkDpRoIEwsg3fVJnEUlr
   KoYS0xkPydip1YZPmzfEEFGbUgceOxRgpD95sAXXMxmeRBKq07liwsM0J
   77w02MgEnGNW4yQ4OdE9CD9a3cdlOiha53TqLn7fLQ+hWsrjziejRsrZJ
   hs7G4inPSjfVMOO3EDYrH7H7XCgOa4VhmGnlLuwDQFxVp5WXkI++VH2M4
   OA+YZiPTwH90/rfS50kyQUua23sd9fZZaqCROfgBvr7aGEkYDE+EY9Ihd
   1i0dgUIS5nDPQlMCwCodkiCBz/0IRYKGUsRAtvIT/3C+I45rHgGMHmYqn
   g==;
X-CSE-ConnectionGUID: ccTaSSLcRT+WOmXJnJnKWA==
X-CSE-MsgGUID: sJPPYpcJSGy4ORCgGqlpdQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11231"; a="29048885"
X-IronPort-AV: E=Sophos;i="6.11,219,1725346800"; 
   d="scan'208";a="29048885"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2024 12:27:11 -0700
X-CSE-ConnectionGUID: B0NdM1s+R1WIEXtklDarPg==
X-CSE-MsgGUID: u1uM5LQIQsuRgOilLyAMfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,219,1725346800"; 
   d="scan'208";a="110096860"
Received: from spandruv-desk1.amr.corp.intel.com ([10.125.110.18])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2024 12:27:11 -0700
Message-ID: <c5aee6fc77427daca6e009cd22c3637bffec0219.camel@linux.intel.com>
Subject: Re: [PATCH] platform/x86: asus-wmi: Support setting AIPT modes
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: Armin Wolf <W_Armin@gmx.de>, corentin.chary@gmail.com, luke@ljones.dev, 
	hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Michael Larabel <Michael@phoronix.com>, Casey Bowman
 <casey.g.bowman@intel.com>
Date: Sun, 20 Oct 2024 12:27:04 -0700
In-Reply-To: <911ce141-8f20-48fb-bc43-e6d4262dbc81@gmx.de>
References: <20241020065051.1724435-1-srinivas.pandruvada@linux.intel.com>
	 <911ce141-8f20-48fb-bc43-e6d4262dbc81@gmx.de>
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

> >=20

[...]

> > +	adev =3D acpi_dev_get_first_match_dev("PNP0C14", "ATK", -1);
>=20
> Is there really no way of changing the AIPT mode through the WMI
> interface?
> I would prefer using the WMI interface if available, since the
> firmware might
> assume that FANL is only called through the WMI interface.
>=20
I wish the same. Didn't find any. Asus is aware of this change which I
submitted, they didn't suggest that there is alternative.=20

> Do you have a acpidump from a affected device?
>=20
Will send you.

Thanks,
Srinivas

> Thanks,
> Armin Wolf
>=20
> > +	if (adev) {
> > +		acpi_handle handle =3D acpi_device_handle(adev);
> > +
> > +		acpi_dev_put(adev);
> > +
> > +		if (!acpi_has_method(handle, "FANL"))
> > +			return 0;
> > +
> > +		asus->acpi_mgmt_handle =3D handle;
> > +		asus->asus_aipt_present =3D true;
> > +		dev_info(dev, "ASUS Intelligent Performance
> > Technology (AIPT) is present\n");
> > +		/*
> > +		 * Set the mode corresponding to default Linux
> > platform power
> > +		 * profile Balanced
> > +		 */
> > +		asus_wmi_write_aipt_mode(asus, AIPT_STANDARD);
> > +	}
> > +
> > =C2=A0=C2=A0	return 0;
> > =C2=A0 }
> >=20


