Return-Path: <linux-kernel+bounces-174486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62CC58C0F73
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 14:16:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03C4D1F22E87
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 12:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F29D14B95A;
	Thu,  9 May 2024 12:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="pkwvLWqy"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9F712F5B3;
	Thu,  9 May 2024 12:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715256977; cv=none; b=O1erYhD+a1m4CtCfPnk5IF84uU+oYDoD8kZv8I9/KPHLi0v7MkvFrVoz227fKWmxelXECRg06xGxMMvQes/pAMpaP41RgzPiujqRBzoo9sc2NQbOo9tOelVvJlMCg2eQw9ccmIcET8qizJYhMRwt3CiT1SUPZhao3U3gYU+Ul7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715256977; c=relaxed/simple;
	bh=xv+8EY80PprWDIrphFPGiwYWzI8mMjfVvHBAlRZAjVQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FxBWpfdh8KZHpcXPebSYFqQwFwRzgSM3XiRzecIiZNM3Q8TSlPrw8+tnjyOestwFXmciB37yhraXlNI1+7TDljrqBZQMBlEeYKhvgbdeVnyfEmdzGCJqYov/1sH5bYaPdF0cQJnIO9hlUUI+3fqUemBEPqFa3JKgCunbBDTfepo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=pkwvLWqy; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1715256976; x=1746792976;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xv+8EY80PprWDIrphFPGiwYWzI8mMjfVvHBAlRZAjVQ=;
  b=pkwvLWqyPRzp7aj8gNQ0+TO3LKqnUqEWaUDdamLTVh1L8RtW7w7pUi+G
   WQmC284hb/tJ+NJ6o8aibecJHDgpHQlm3Ru9DvrcA2lrk6Ojb46eijqKu
   fkBt9czV4vKQXknAELT9uilp90Ibhu1K1gIit5hWY56k7RddDnGYVk4Gu
   HWLGj6G85shFzrX/QR0lsbNG71vPpuy+tWkl1ApbjlCnfc1Oz5Rzonb1Y
   VqCP0+abFD9tvbEJetM8iyZfrV6lI52f9sSS8ACBhbjUV/GMWnI+pz3xt
   RIQPOczZjV+WF1ey2RHPy/8nwCKmKb/73TYSLrlvYHRd3yriiahP4QTsa
   Q==;
X-CSE-ConnectionGUID: vyZ8CGhFQVqGx8FDY47/hA==
X-CSE-MsgGUID: CXov5e8bRyuYi+nK6g4mHg==
X-IronPort-AV: E=Sophos;i="6.08,147,1712646000"; 
   d="asc'?scan'208";a="24313807"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 May 2024 05:16:14 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 9 May 2024 05:15:41 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex01.mchp-main.com (10.10.85.143)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Thu, 9 May 2024 05:15:40 -0700
Date: Thu, 9 May 2024 13:15:30 +0100
From: Conor Dooley <conor.dooley@microchip.com>
To: Yangyu Chen <cyy@cyyself.name>
CC: <linux-riscv@lists.infradead.org>, Conor Dooley <conor@kernel.org>, Palmer
 Dabbelt <palmer@dabbelt.com>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] riscv: dts: fix isa string for Canaan Kendryte K230
Message-ID: <20240509-humility-sliceable-fc22f8d64d90@wendy>
References: <tencent_B61C1370E7632842D61BB7F9FA0515B44D09@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="yzTCDg/qHC1C/s+B"
Content-Disposition: inline
In-Reply-To: <tencent_B61C1370E7632842D61BB7F9FA0515B44D09@qq.com>

--yzTCDg/qHC1C/s+B
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 09, 2024 at 05:33:11PM +0800, Yangyu Chen wrote:
> The original is a string in dts that has no "zfh" or "zvfh" extension,
> but the K230 chip has them, so I am adding them to the dts. This
> patch also reordered the Z* extension in the isa string and used
> canonical order for the category as the first key and then alphabet
> order as the second key to meet RISC-V ISA Extension Naming
> Conventions.
>=20
> Signed-off-by: Yangyu Chen <cyy@cyyself.name>

I'm just gonna squash this one into the original patch, since I had to
drop it from v6.10 material.

Cheers,
Conor.

--yzTCDg/qHC1C/s+B
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZjy+YgAKCRB4tDGHoIJi
0jGiAQD7pc1KyZymIGJlsegKO1WYvefd963SGPkomtSKGL1bfwD/Xnsyh56Pzfcd
OXdMDHsYbfBT7F78lGFCKrwFVRE03AQ=
=XNdt
-----END PGP SIGNATURE-----

--yzTCDg/qHC1C/s+B--

