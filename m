Return-Path: <linux-kernel+bounces-321309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17810971896
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 13:49:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 246AC1C223B6
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 11:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F6681B653D;
	Mon,  9 Sep 2024 11:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="SDoWqS6z"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C3F81B5EDA
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 11:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725882567; cv=none; b=dr8u/MNvDpXLuTo0E6mDhn1P7Tnfst6IyoSV9SJIj/JKYy77AvLPLuKT9eDSFvowhV5NjFF7lDEuyPFi9M7QhYb9YSPUUx2Q9uK0SfNUiKPxTM6QOzoZTL86YF1ZqXm/78yavVjZOrauVo6UjiDqbU36arvOHSfd6hv5Cc/mjzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725882567; c=relaxed/simple;
	bh=osEgMmc3pSgymuEZ5F4klxDmO7a0n5xJEBKV4k+DAZc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c8zuEMf5Uiz6ZtpvEVSRgvVJwTl6JdARpxGr3KwvsrIeNHtZE0cXuT8/5GdP8/Tn8KjKyFB+M9nN+WkA6xpzACCmjmZ7/4DNkbpqH4VYb50mEPZNobFi8hIscGLX0N3ow2UTpkCLXVcRK7In4aF+/87KOKP5Fklob4usTpTSANs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=SDoWqS6z; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1725882566; x=1757418566;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=osEgMmc3pSgymuEZ5F4klxDmO7a0n5xJEBKV4k+DAZc=;
  b=SDoWqS6zzelZ9wU7FMndLOZ7Y7XFk3QO5BI1LDNCKKjyWg7O9veGnciO
   VNXhWtzcnMsiuxmNy/HA52QSPi5z4cAQa9GOucVwO3vvHlSdUGNjcmaVX
   EclvGrAwEVPShyTzLR/dq4GoChBnAH4aA3eAfpYFml8id9Cw8qamdSQaG
   o0bqmK2iInz+4kj0bDHVNIZk0jTHSkgnKtEFFH1dnxuit2KAltCneiWGz
   KuAoE28FFLtoBKwjJVklIoSY26uEbhr2/MBl/20jbzyk/JIwkR6MSwBmE
   tmBlTFfWxIBEn2xAXRLrOJllwux+eBxB780v7UOT43V+RW12Uaf2Oeued
   g==;
X-CSE-ConnectionGUID: WusmmYi+Rp29pd7EVOjWCg==
X-CSE-MsgGUID: /az8+jGUS0GouVUdPyt8YA==
X-IronPort-AV: E=Sophos;i="6.10,214,1719903600"; 
   d="asc'?scan'208";a="34628456"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Sep 2024 04:49:24 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 9 Sep 2024 04:48:44 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex01.mchp-main.com (10.10.85.143)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Mon, 9 Sep 2024 04:48:43 -0700
Date: Mon, 9 Sep 2024 12:48:10 +0100
From: Conor Dooley <conor.dooley@microchip.com>
To: Miquel =?iso-8859-1?Q?Sabat=E9_Sol=E0?= <mikisabate@gmail.com>
CC: <paul.walmsley@sifive.com>, <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
	<linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<jesse@rivosinc.com>, <conor@kernel.org>
Subject: Re: [PATCH v2] riscv: hwprobe: export Zicntr and Zihpm extensions
Message-ID: <20240909-botanical-frying-9d6eeaa99fb3@wendy>
References: <20240817075629.262318-1-mikisabate@gmail.com>
 <20240820044749.557349-1-mikisabate@gmail.com>
 <66d9605f.5d0a0220.3dabb6.3586@mx.google.com>
 <20240909-raving-reproach-74431f57896d@wendy>
 <66dede4f.5d0a0220.1ef0e1.c922@mx.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="aaw5R+2YUCgSbkMR"
Content-Disposition: inline
In-Reply-To: <66dede4f.5d0a0220.1ef0e1.c922@mx.google.com>

--aaw5R+2YUCgSbkMR
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 09, 2024 at 01:38:49PM +0200, Miquel Sabat=C3=A9 Sol=C3=A0 wrot=
e:
> On dl., de set. 09 2024, Conor Dooley wrote:
> > On Thu, Sep 05, 2024 at 09:40:14AM +0200, Miquel Sabat=C3=A9 Sol=C3=A0 =
wrote:
> >> On dt., d=E2=80=99ag. 20 2024, Miquel Sabat=C3=A9 Sol=C3=A0 wrote:
> >
> > By the way, I totally missed this first time around because the v2 was
> > sent as a reply to v1 - it's pretty common for people to view their
> > mailbox sorted by thread, and sending new versions as a reply will bury
> > it.

> Thanks for the review!
>=20
> This is my first contribution to the Linux kernel, as you can tell :)
> Will keep in mind next time!

No worries & welcome.
It did end up in patchwork, so it was unlikely to get permanently lost:
https://patchwork.kernel.org/project/linux-riscv/patch/20240820044749.55734=
9-1-mikisabate@gmail.com/

--aaw5R+2YUCgSbkMR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZt7gegAKCRB4tDGHoIJi
0oS7AQCPejIA2EuGNAVFaYjpLhdFiegbpRs8sEPVNQCZ00INFwD8CINDSoz0A5LH
U5oKuhYn8bJNkG8ICoXMjSGyg+7utAU=
=PbRq
-----END PGP SIGNATURE-----

--aaw5R+2YUCgSbkMR--

