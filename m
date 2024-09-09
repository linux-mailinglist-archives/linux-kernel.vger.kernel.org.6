Return-Path: <linux-kernel+bounces-321242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA3AF971653
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 13:12:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DDDF1F21033
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 11:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 904481B5327;
	Mon,  9 Sep 2024 11:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="m2b8nfR2"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 095FA15EFA1
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 11:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725880368; cv=none; b=Ml8PkU0WK+BPqJ5xsbi0ixVAjdplta73r41z51pNM1DwGC46Dl8UwjLMUZb8RN0kje3oVtAG7QR/RG5m3kFLQPTTD2Hw9Ry6D9XbpeJhfLM1vP/yDRo3cgXEZ35e8MYwzJjakx9JX7dKbE1DfF1cwEsJ7xVR9tHD37FKHYxf0so=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725880368; c=relaxed/simple;
	bh=Rphq9aNLGcRYY67zbP4cV/aEbsHnchoDgt15YmtpO3U=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PaLXzUkjT1IT+vV+ppT56d/I/Oe4MyPX8Z15kDKDkfm1gY/tgi48+/CRWbaQcyMlKGmIJa/Z2azolVJ/pz0t01Ab3xIps9gNW9rzgx/omeB+9b0I3OucOUL4HwNAoEdU1wkoZKR93603/vb8jhUscEnYVRSPsCd5ggC1XQf5JUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=m2b8nfR2; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1725880365; x=1757416365;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Rphq9aNLGcRYY67zbP4cV/aEbsHnchoDgt15YmtpO3U=;
  b=m2b8nfR2bnMDdcRIbyyNmYNA7XWyovycHoqfhR/1bnN5xPi97sGnJFNv
   nXZNAaTyEhlVBrM45tm9WHpiUw84icCZ132XiCKAfRUd1NoMszwW+Xh3b
   ZidYxdpOPB1P18ckm1yjbNGvwbmBEcv7W1NtytX/eQYIZq1R8A5fDbCKB
   d0pqjo+a6kONnIrgmU9KJLaLAE3DAzNwg/0FxMx8zSpecdQj4ph7/jqIl
   sfK9qGa2g8AwIAxhZUjf1byMbHtnmHVEzbcw6OrK12udCNPvappxuiNCr
   SxbkFmrvrF+1pjYzhfU0sSYhyijG89CjGycLH4zTQIJRjerA09479DUY3
   w==;
X-CSE-ConnectionGUID: IudSk0JrThq49CLawqampQ==
X-CSE-MsgGUID: wtKLYQcGQ4qObFCcGnHyuA==
X-IronPort-AV: E=Sophos;i="6.10,214,1719903600"; 
   d="asc'?scan'208";a="34627609"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Sep 2024 04:12:44 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 9 Sep 2024 04:12:20 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex02.mchp-main.com (10.10.85.144)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Mon, 9 Sep 2024 04:12:19 -0700
Date: Mon, 9 Sep 2024 12:11:46 +0100
From: Conor Dooley <conor.dooley@microchip.com>
To: Miquel =?iso-8859-1?Q?Sabat=E9_Sol=E0?= <mikisabate@gmail.com>
CC: <paul.walmsley@sifive.com>, <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
	<linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<jesse@rivosinc.com>, <conor@kernel.org>
Subject: Re: [PATCH v2] riscv: hwprobe: export Zicntr and Zihpm extensions
Message-ID: <20240909-raving-reproach-74431f57896d@wendy>
References: <20240817075629.262318-1-mikisabate@gmail.com>
 <20240820044749.557349-1-mikisabate@gmail.com>
 <66d9605f.5d0a0220.3dabb6.3586@mx.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="S5iLkL5yVJmHWDnB"
Content-Disposition: inline
In-Reply-To: <66d9605f.5d0a0220.3dabb6.3586@mx.google.com>

--S5iLkL5yVJmHWDnB
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 05, 2024 at 09:40:14AM +0200, Miquel Sabat=C3=A9 Sol=C3=A0 wrot=
e:
> On dt., d=E2=80=99ag. 20 2024, Miquel Sabat=C3=A9 Sol=C3=A0 wrote:
>=20
> > Export Zicntr and Zihpm ISA extensions through the hwprobe syscall.
> >
> > Signed-off-by: Miquel Sabat=C3=A9 Sol=C3=A0 <mikisabate@gmail.com>
> > ---
> >  Documentation/arch/riscv/hwprobe.rst  | 6 ++++++
> >  arch/riscv/include/uapi/asm/hwprobe.h | 2 ++
> >  arch/riscv/kernel/sys_hwprobe.c       | 2 ++
> >  3 files changed, 10 insertions(+)
> >
> > diff --git a/Documentation/arch/riscv/hwprobe.rst b/Documentation/arch/=
riscv/hwprobe.rst
> > index 3db60a0911df..cfd2929d0562 100644
> > --- a/Documentation/arch/riscv/hwprobe.rst
> > +++ b/Documentation/arch/riscv/hwprobe.rst
> > @@ -183,6 +183,9 @@ The following keys are defined:
> >         defined in the Atomic Compare-and-Swap (CAS) instructions manua=
l starting
> >         from commit 5059e0ca641c ("update to ratified").
> > =20
> > +  * :c:macro:`RISCV_HWPROBE_EXT_ZICNTR`: The Zicntr extension version =
2.0
> > +       is supported as defined in the RISC-V ISA manual.
> > +
> >    * :c:macro:`RISCV_HWPROBE_EXT_ZICOND`: The Zicond extension is suppo=
rted as
> >         defined in the RISC-V Integer Conditional (Zicond) operations e=
xtension
> >         manual starting from commit 95cf1f9 ("Add changes requested by =
Ved
> > @@ -192,6 +195,9 @@ The following keys are defined:
> >         supported as defined in the RISC-V ISA manual starting from com=
mit
> >         d8ab5c78c207 ("Zihintpause is ratified").
> > =20
> > +  * :c:macro:`RISCV_HWPROBE_EXT_ZIHPM`: The Zihpm extension version 2.0
> > +       is supported as defined in the RISC-V ISA manual.
> > +
> >    * :c:macro:`RISCV_HWPROBE_EXT_ZVE32X`: The Vector sub-extension Zve3=
2x is
> >      supported, as defined by version 1.0 of the RISC-V Vector extensio=
n manual.
> > =20
> > diff --git a/arch/riscv/include/uapi/asm/hwprobe.h b/arch/riscv/include=
/uapi/asm/hwprobe.h
> > index b706c8e47b02..098a815b3fd4 100644
> > --- a/arch/riscv/include/uapi/asm/hwprobe.h
> > +++ b/arch/riscv/include/uapi/asm/hwprobe.h
> > @@ -72,6 +72,8 @@ struct riscv_hwprobe {
> >  #define		RISCV_HWPROBE_EXT_ZCF		(1ULL << 46)
> >  #define		RISCV_HWPROBE_EXT_ZCMOP		(1ULL << 47)
> >  #define		RISCV_HWPROBE_EXT_ZAWRS		(1ULL << 48)
> > +#define		RISCV_HWPROBE_EXT_ZICNTR	(1ULL << 49)
> > +#define		RISCV_HWPROBE_EXT_ZIHPM		(1ULL << 50)
> >  #define RISCV_HWPROBE_KEY_CPUPERF_0	5
> >  #define		RISCV_HWPROBE_MISALIGNED_UNKNOWN	(0 << 0)
> >  #define		RISCV_HWPROBE_MISALIGNED_EMULATED	(1 << 0)
> > diff --git a/arch/riscv/kernel/sys_hwprobe.c b/arch/riscv/kernel/sys_hw=
probe.c
> > index 8d1b5c35d2a7..910b41b6a7ab 100644
> > --- a/arch/riscv/kernel/sys_hwprobe.c
> > +++ b/arch/riscv/kernel/sys_hwprobe.c
> > @@ -107,9 +107,11 @@ static void hwprobe_isa_ext0(struct riscv_hwprobe =
*pair,
> >  		EXT_KEY(ZCB);
> >  		EXT_KEY(ZCMOP);
> >  		EXT_KEY(ZICBOZ);
> > +		EXT_KEY(ZICNTR);
> >  		EXT_KEY(ZICOND);
> >  		EXT_KEY(ZIHINTNTL);
> >  		EXT_KEY(ZIHINTPAUSE);
> > +		EXT_KEY(ZIHPM);
> >  		EXT_KEY(ZIMOP);
> >  		EXT_KEY(ZKND);
> >  		EXT_KEY(ZKNE);
> >
> > base-commit: dc1c8034e31b14a2e5e212104ec508aec44ce1b9
>=20
> Hello,
>=20
> Can I get a review on this version of this patchset?

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

By the way, I totally missed this first time around because the v2 was
sent as a reply to v1 - it's pretty common for people to view their
mailbox sorted by thread, and sending new versions as a reply will bury
it.

Cheers,
Conor.

--S5iLkL5yVJmHWDnB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZt7X8gAKCRB4tDGHoIJi
0thiAP9hQnKR4nidhZ+Q/MFpJAMc8yb08FsLJQ/6HEH7mnqVDgD6AoBEiQy+m2Tq
Q4K90S9mDC+ePAHjHt1WucXOjwUidgk=
=rbYl
-----END PGP SIGNATURE-----

--S5iLkL5yVJmHWDnB--

