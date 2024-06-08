Return-Path: <linux-kernel+bounces-206893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A94DF900F66
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 05:45:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 428AD283C0F
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 03:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8A5BFC0C;
	Sat,  8 Jun 2024 03:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dwoGk2k2"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E0420EB;
	Sat,  8 Jun 2024 03:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717818293; cv=none; b=JhzLkDFftDk2kR9voOV3iWrDA7ZV/bqilrqrKXUxdvaoX+HGg3DwAn9E/GsXWOSCCzO2MfES8BZe7sUj+rDtPv7FBe2mgjPnbwzrvY8o3wMpE7tdZO5EYDY16t/Luz/RvnRutOKbv4R7U1c4ZfL7kEneU+Xdep9F0f2Cjirmo4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717818293; c=relaxed/simple;
	bh=h3nmL7t5Wz+TTNjk2K/5BGwjV18TbLQal4X7ok/8ei8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OknhalJ+cmSeqS/6Sh80fJbzBtyCKVpJ4lUqxXEbHlEfK37QMTemI65SkutpX2PpbPgADtR/9PyFnmm/+09ELraaVDrSGUYl2BsV01rptZhTyZg3F+8dtYy2NPGhfoPsbD7pX4viEB94rC4ipkikqxN7zeGN8AQnxZlzZSyDTIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dwoGk2k2; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717818290; x=1749354290;
  h=message-id:subject:from:reply-to:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=h3nmL7t5Wz+TTNjk2K/5BGwjV18TbLQal4X7ok/8ei8=;
  b=dwoGk2k2m5kHZXTX7Vh1rF37jbyPJg1Z4YODAAooXMG0/oL+moEpowUz
   Lruj6Wkp/zlHoIi6J2jzyporO9ShGpMrhBDxCn/mwvkrVZ3no/yN/zrw2
   lMSWid+pfjbAJ4PM1c8wHYZt4YiyKSOK+SGcc2FnSIjrJfhMGOTbK7ugP
   y0eHZnv9L5vSB1lqeigntdoIGl5jEd/PJ1NauSX9e1MgDNrtSwfb///Zu
   lI5AOL6gjFsd9Gfs13S2Bt9N0eVxHboCEZDxpkDN9QeaqjcW1MU8OawMd
   8T1P6dhqa2tDu/98mMpp0bdVBuGv0bUMNFkeJBvWLZDehKJ3cedet7cXK
   A==;
X-CSE-ConnectionGUID: M0Fw0+i4SPGv/kqEb6+urw==
X-CSE-MsgGUID: QfmUnxdNQBSWm7PlYGpykQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11096"; a="17483362"
X-IronPort-AV: E=Sophos;i="6.08,222,1712646000"; 
   d="scan'208";a="17483362"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2024 20:44:49 -0700
X-CSE-ConnectionGUID: AM9XMo+QR3yQlzn2cne3gA==
X-CSE-MsgGUID: DEJS3iTrTqOidWVvvSpE4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,222,1712646000"; 
   d="scan'208";a="38600234"
Received: from lbattagl-mobl1.amr.corp.intel.com ([10.209.70.26])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2024 20:44:48 -0700
Message-ID: <b23fadac815f137ad93fa3bb90149e52956b3c62.camel@linux.intel.com>
Subject: Re: [PATCH V3 1/3] platform/x86/intel/sdsi: Add ioctl SPDM transport
From: "David E. Box" <david.e.box@linux.intel.com>
Reply-To: david.e.box@linux.intel.com
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: linux-doc@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, LKML
	 <linux-kernel@vger.kernel.org>, platform-driver-x86@vger.kernel.org
Date: Fri, 07 Jun 2024 20:44:47 -0700
In-Reply-To: <b32cd809-7aed-62ed-1b6e-550221a3acbb@linux.intel.com>
References: <20240606011617.557264-1-david.e.box@linux.intel.com>
	 <b32cd809-7aed-62ed-1b6e-550221a3acbb@linux.intel.com>
Organization: David E. Box
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-06-07 at 16:14 +0300, Ilpo J=C3=A4rvinen wrote:
> On Wed, 5 Jun 2024, David E. Box wrote:
>=20
> > Intel On Demand adds attestation and firmware measurement retrieval
> > services through use of the protocols defined the Security Protocols an=
d
> > Data Measurement (SPDM) specification. SPDM messages exchanges are used=
 to
> > authenticate On Demand hardware and to retrieve signed measurements of =
the
> > NVRAM state used to track feature provisioning and the NVRAM state used=
 for
> > metering services. These allow software to verify the authenticity of t=
he
> > On Demand hardware as well as the integrity of the reported silicon
> > configuration.
> >=20
> > Add an ioctl interface for sending SPDM messages through the On Demand
> > mailbox. Provides commands to get a list of SPDM enabled devices, get t=
he
> > message size limits for SPDM Requesters and Responders, and perform an =
SPDM
> > message exchange.
> >=20
> > Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> > Link:
> > https://www.dmtf.org/sites/default/files/standards/documents/DSP0274_1.=
0.1.pdf
> > =C2=A0[1]
> > ---
>=20
> > +static int sdsi_spdm_do_command(struct sdsi_priv *priv,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct sdsi_spdm_command __user *=
argp)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u32 req_size, rsp_size;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (get_user(req_size, &argp=
->size))
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0return -EFAULT;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (req_size < 4 || req_size=
 > sizeof(struct sdsi_spdm_message))
>=20
> Hi David,
>=20
> Is that 4 actually SPDM_HEADER_SIZE?
>=20
> If my guess is correct, no need to send an updated version, I'll just fix=
=20
> it while applying.

It is SPDM_HEADER_SIZE but I already fixed it in V4 since I had to address =
an
LKP report.

David

>=20
>=20


