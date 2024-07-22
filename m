Return-Path: <linux-kernel+bounces-258893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D4068938DF7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 13:14:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89EA11F21BDF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 11:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A81316D300;
	Mon, 22 Jul 2024 11:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="MnezjYde"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D5A3A8F7;
	Mon, 22 Jul 2024 11:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721646845; cv=none; b=tSF1FCrWIk5AD/Tc4eI0xnrtuvB+nVnTrzBPQ6qXqN0dIx3OMUlmm0XSurQOoNohLg5x0ff7ghYSw2O2nWpREMfQxj9l1eT/PrPqPtVTBMBahcGR222re3NgYcnhleL4dU6OAQKa0OdZaTnEGUHaj3PI6NumENmO3araH0O0Jus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721646845; c=relaxed/simple;
	bh=k2V9BZKvCGMHXeloQCdzZXYrnoWQegTQUZhBJJkTTXs=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IF/gvvq7EFmTos3EJT+RBvYgNjvojdRJNKcGYVL9W7AYHWxBanKrpY6yRE9y4kO4l21UvUIhZev9DuSnzsIUmzMr2OqOmo434X3M9VxyoMHA4Ml8nrKJndA0WI8fCn4uM3t2STmhtwyk6+5vifbbF+Dg8yst8DD9SRocCDuELi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=MnezjYde; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1721646843; x=1753182843;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=k2V9BZKvCGMHXeloQCdzZXYrnoWQegTQUZhBJJkTTXs=;
  b=MnezjYde7JOBPjtPHIPqv1E6cfP9GHg3w6zX81ZU1bbNHbJKUEgECOYy
   kVyvvojQ4eO9K97kqbARdaFqD6aNjUzGK/PoHG+UemCpr490fIrDSPkg5
   DuIiklMrJX005oss/tbg49cL1Kutelaqna9xMQwvn9pnlV3+U74AdjcIf
   tk5TJmQ/ivzvFmP+gENu2vSsl/ANaS+8l7qv4Nly5CBpfQfq1zPIYAvRc
   uiPbxICkjwMvDzLeBKSVTuk7Ua1xalXrWOmp6xNJFq82FJvFu1EPmM/1E
   Ropd2z/FEkGsT+R3xtmbJv8LZv0l4ndZgAlFAK37RJKuws34cZVImfcr/
   A==;
X-CSE-ConnectionGUID: 61IbvXjYQIyRYEoGtyM+mQ==
X-CSE-MsgGUID: hcc9W0ZYR2e6MfolmIGg3g==
X-IronPort-AV: E=Sophos;i="6.09,228,1716274800"; 
   d="asc'?scan'208";a="30167700"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Jul 2024 04:12:54 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 22 Jul 2024 04:12:46 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex01.mchp-main.com (10.10.85.143)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Mon, 22 Jul 2024 04:12:45 -0700
Date: Mon, 22 Jul 2024 12:12:21 +0100
From: Conor Dooley <conor.dooley@microchip.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: <ysionneau@kalrayinc.com>, <linux-kernel@vger.kernel.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Jonathan Borne <jborne@kalrayinc.com>, Julian Vetter
	<jvetter@kalrayinc.com>, <devicetree@vger.kernel.org>
Subject: Re: [RFC PATCH v3 36/37] kvx: dts: DeviceTree for qemu emulated
 Coolidge SoC
Message-ID: <20240722-cuddly-valiant-ba6153953190@wendy>
References: <20240722094226.21602-1-ysionneau@kalrayinc.com>
 <20240722094226.21602-37-ysionneau@kalrayinc.com>
 <d93f93fa-bbc8-4b89-9abc-767486bc443c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="XuLz4nGzZl9P9olv"
Content-Disposition: inline
In-Reply-To: <d93f93fa-bbc8-4b89-9abc-767486bc443c@kernel.org>

--XuLz4nGzZl9P9olv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 22, 2024 at 11:55:46AM +0200, Krzysztof Kozlowski wrote:
> On 22/07/2024 11:41, ysionneau@kalrayinc.com wrote:
> > From: Yann Sionneau <ysionneau@kalrayinc.com>
> >=20
> > Add device tree for QEMU that emulates a Coolidge V1 SoC.

> > +	model =3D "Kalray Coolidge processor (QEMU)";
> > +	compatible =3D "kalray,coolidge-qemu";

I'm not sure that this should even be in the kernel. Why isn't QEMU able
to generate a devicetree for this emulated platform, like it can on
other architectures?

--XuLz4nGzZl9P9olv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZp4+lQAKCRB4tDGHoIJi
0jDXAP9yD+J9QOu8PzMbtxgo62LiceIpCHdlvPI91zBaqb9tuAD8DtvMRhSJySFG
2neRFeuiK4wY+omh60eiQjE7v+ou2wo=
=6AzY
-----END PGP SIGNATURE-----

--XuLz4nGzZl9P9olv--

