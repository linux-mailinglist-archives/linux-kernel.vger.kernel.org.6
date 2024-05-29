Return-Path: <linux-kernel+bounces-193517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ADE4E8D2D4D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 08:31:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEE2B1C22A38
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 06:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D66315B141;
	Wed, 29 May 2024 06:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="wQ83M6LY"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73EE3A1DD
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 06:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716964261; cv=none; b=eHqn8rRbx4l/3snbiuQBe7o/PFJvfEnSbzrTHmyzOYr+IDkHfOZbzHjg/DPEGmf2c0eu77Dz1GcGsOH3KL1nVKA+KiwhJrKue1lHCbs9TD4LkPxbfsIeZSJ9emy+0HldUDvlR7zWVZgDy3StZ0hVYNAgeE/Q2NyO3trXA0HhwKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716964261; c=relaxed/simple;
	bh=zH5y51QIfyWMgU2MS015Gg0xtYou9QU6HF/0Q3WRPYw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q4OBcUQiBJeTv//V9hnix5GrLL9CIfflk4pL7qADhGYlPoTTASV1mNwGcvG4VakufHZdb/RlJ92kcZGs1Bcd+2EGSYRgTwy9+giRa594DVbI1+PPiygnjRgFW0z1EwJ+4J2Q14jqaopURgy4olJicvWeptpDWUDFjHLiin7+H3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=wQ83M6LY; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1716964259; x=1748500259;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zH5y51QIfyWMgU2MS015Gg0xtYou9QU6HF/0Q3WRPYw=;
  b=wQ83M6LYXpDwt6ivWy4EFdawK4boOTqFdEMlq3mJ15bZtpWFQkEx95W5
   QAEmewK+tRMDND+SddxVZCQZkWjuf8kTNpB88cd0th4Tnzu+fjCQdPv9a
   X5nd0zqH7LvRpGr8vpBUWeWVVxU6VIGZ6J4psPQM9UUVovPapIDN5wqwR
   XnRdIDqXck2bPZMEBhEF8HV8y2IrBwJcYW+veUEmFeH1rHFIHIoAe9wWL
   95IBkv77I+GNYXUtrVjSKQ/wjCPO6TMQQtMbpAGmfImlX94RWDKvG/87f
   uHUYRH4t1Jld/Fu/vYeth/cCJ5s/5qIo5ColSElJZC51w7fSltc8IrTkp
   Q==;
X-CSE-ConnectionGUID: e6tumgM0T7uwd7L4vEg+tw==
X-CSE-MsgGUID: A/hO/U7JRlOuR7VbCaFaIQ==
X-IronPort-AV: E=Sophos;i="6.08,197,1712646000"; 
   d="asc'?scan'208";a="27300257"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 May 2024 23:30:58 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 28 May 2024 23:30:36 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex01.mchp-main.com (10.10.85.143)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Tue, 28 May 2024 23:30:33 -0700
Date: Wed, 29 May 2024 07:30:15 +0100
From: Conor Dooley <conor.dooley@microchip.com>
To: "Wang, Xiao W" <xiao.w.wang@intel.com>
CC: Conor Dooley <conor@kernel.org>, "linux-riscv@lists.infradead.org"
	<linux-riscv@lists.infradead.org>, Andrew Jones <ajones@ventanamicro.com>,
	"pulehui@huawei.com" <pulehui@huawei.com>, Charlie Jenkins
	<charlie@rivosinc.com>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer
 Dabbelt <palmer@dabbelt.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Samuel Holland <samuel.holland@sifive.com>,
	Pu Lehui <pulehui@huaweicloud.com>, =?iso-8859-1?Q?Bj=F6rn_T=F6pel?=
	<bjorn@kernel.org>
Subject: Re: [PATCH v3 2/2] RISC-V: separate Zbb optimisations requiring and
 not requiring toolchain support
Message-ID: <20240529-hangup-recipient-246586c6f8a8@wendy>
References: <20240528-applaud-violin-facef8d9d846@spud>
 <20240528-opossum-flavorful-3411811b87e2@spud>
 <DM8PR11MB5751DBB6A068008269E7D399B8F22@DM8PR11MB5751.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="rG0PxGrUtF8m4yb2"
Content-Disposition: inline
In-Reply-To: <DM8PR11MB5751DBB6A068008269E7D399B8F22@DM8PR11MB5751.namprd11.prod.outlook.com>

--rG0PxGrUtF8m4yb2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 29, 2024 at 01:01:24AM +0000, Wang, Xiao W wrote:
> > From: Conor Dooley <conor@kernel.org>
> > Sent: Tuesday, May 28, 2024 7:11 PM
> > -	ALTERNATIVE("nop", "j strcmp_zbb", 0, RISCV_ISA_EXT_ZBB,
> > CONFIG_RISCV_ISA_ZBB)
> > +	__ALTERNATIVE_CFG("nop", "j strcmp_zbb", 0, RISCV_ISA_EXT_ZBB,
> > +		IS_ENABLED(CONFIG_RISCV_ISA_ZBB_ALT) &&
> > IS_ENABLED(CONFIG_TOOLCHAIN_HAS_ZBB))
>=20
> s/CONFIG_RISCV_ISA_ZBB_ALT/ CONFIG_RISCV_ISA_ZBB
> Same issue for below changes in strn*.S

I could have sworn I grepped for it and there was nothing, obviously
not... Thanks, I'll fix it up in a new version.

Thanks,
Conor

--rG0PxGrUtF8m4yb2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZlbLcwAKCRB4tDGHoIJi
0jc8AP90DEvrOSfWOH9WMnrelnVkjWKIwCS3PIn/6IwaBYSKzAEAiZGYQ825H6R3
OnZEKBXJJgLjKfpAYEb10FkwaeiI2AQ=
=AHbp
-----END PGP SIGNATURE-----

--rG0PxGrUtF8m4yb2--

