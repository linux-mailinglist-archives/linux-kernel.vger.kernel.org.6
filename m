Return-Path: <linux-kernel+bounces-214571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66F99908698
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 10:41:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A9BB1C21C60
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 08:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7B9F18755B;
	Fri, 14 Jun 2024 08:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="ulel9lx9"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61E4186E57;
	Fri, 14 Jun 2024 08:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718354479; cv=none; b=EM7TzQZa/djP1lDqCjQZ8UzsmoKkWIPoLiWwiCeu97Y9ZNSI66aTHM8HHBU/zYlgy2QAw0YPQJbzzCS/V1GAYwfEmz+u9E/KJNgmkCrJiHbGRrPjH0SK94/N/4JSO1CAcmynLmlLxN2FuhA5pSLO+5Jz35m5Hpx8+SHmzd5aMUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718354479; c=relaxed/simple;
	bh=ZDOfCAptFctnoa5A1SoVoCGucPsxFM9g5sCeJUxH9HE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BiS5lH532MKzZa4LWhfyYl3ftlVx4nsjx1ZRfjU3FN1HujRWX7KN0VpP7P6KScUsMhPLJzecbujrQd6WbPQeEBYE6gNmPJLRN6NHW7XPD78Nsbreao3mzy059Gy+4UxEdDcpyv8yVxthrLL9+FVPf/GrkFXCECcpxvvYtyjU67Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=ulel9lx9; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1718354474; x=1749890474;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZDOfCAptFctnoa5A1SoVoCGucPsxFM9g5sCeJUxH9HE=;
  b=ulel9lx9wnq5xL2xLIq/k/nJviVGsyRvZi0ToURNM/IKjr9ifOtqeTfE
   XWWwIVzkBYMlQlzo8cxPU49PEvryaP44kxg6qwJPJjNYlu2RsvydKkguJ
   YTcRCJAWWnc/jwG2F4orJk2E9a89MMl/+1cq5rnoCm4nf5FIlbLEefa4a
   50RmUC3xeJhusZDrCFbdod6TQ81q7P0nEGwU4WI496jKO2SXreeem2WFZ
   wdxlc3FpXNexDYz7yF0eQ87adtQAtjJ0vCg86N6DjmXjzIDqgoROvKQvi
   Ja/1EM3ujQVyjNY5aYyrT+60E4YntBLGXEg0yU8j53Znx4vka6h+IGR4T
   g==;
X-CSE-ConnectionGUID: 4NPx0QlnRdWIkhBEFQ6o0w==
X-CSE-MsgGUID: Ak2QJkQ1QT2Hb92DGF/MQA==
X-IronPort-AV: E=Sophos;i="6.08,237,1712646000"; 
   d="asc'?scan'208";a="28160744"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Jun 2024 01:41:13 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 14 Jun 2024 01:40:52 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex01.mchp-main.com (10.10.85.143)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Fri, 14 Jun 2024 01:40:46 -0700
Date: Fri, 14 Jun 2024 09:40:29 +0100
From: Conor Dooley <conor.dooley@microchip.com>
To: Jesse Taube <jesse@rivosinc.com>
CC: <linux-riscv@lists.infradead.org>, Jonathan Corbet <corbet@lwn.net>, Paul
 Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Conor Dooley <conor@kernel.org>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	=?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>, Evan Green
	<evan@rivosinc.com>, Andrew Jones <ajones@ventanamicro.com>, Charlie Jenkins
	<charlie@rivosinc.com>, Xiao Wang <xiao.w.wang@intel.com>, Andy Chiu
	<andy.chiu@sifive.com>, Eric Biggers <ebiggers@google.com>, Greentime Hu
	<greentime.hu@sifive.com>, =?iso-8859-1?Q?Bj=F6rn_T=F6pel?=
	<bjorn@rivosinc.com>, Heiko Stuebner <heiko@sntech.de>, Costa Shulyupin
	<costa.shul@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Baoquan
 He <bhe@redhat.com>, Anup Patel <apatel@ventanamicro.com>, Zong Li
	<zong.li@sifive.com>, Sami Tolvanen <samitolvanen@google.com>, Ben Dooks
	<ben.dooks@codethink.co.uk>, Alexandre Ghiti <alexghiti@rivosinc.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Erick Archer
	<erick.archer@gmx.com>, Joel Granados <j.granados@samsung.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 4/6] RISC-V: Detect unaligned vector accesses
 supported.
Message-ID: <20240614-distaste-negligee-ba9216a8684e@wendy>
References: <20240613191616.2101821-1-jesse@rivosinc.com>
 <20240613191616.2101821-5-jesse@rivosinc.com>
 <20240614-viral-dinghy-71d5f6585a55@wendy>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="2C5Ng6p8Cz1W0Nqu"
Content-Disposition: inline
In-Reply-To: <20240614-viral-dinghy-71d5f6585a55@wendy>

--2C5Ng6p8Cz1W0Nqu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 14, 2024 at 09:36:55AM +0100, Conor Dooley wrote:
> On Thu, Jun 13, 2024 at 03:16:13PM -0400, Jesse Taube wrote:
> > --- a/arch/riscv/kernel/unaligned_access_speed.c
> > +++ b/arch/riscv/kernel/unaligned_access_speed.c
> > @@ -19,7 +19,8 @@
> >  #define MISALIGNED_BUFFER_ORDER get_order(MISALIGNED_BUFFER_SIZE)
> >  #define MISALIGNED_COPY_SIZE ((MISALIGNED_BUFFER_SIZE / 2) - 0x80)
> > =20
> > -DEFINE_PER_CPU(long, misaligned_access_speed);
> > +DEFINE_PER_CPU(long, misaligned_access_speed) =3D RISCV_HWPROBE_MISALI=
GNED_UNKNOWN;
> > +DEFINE_PER_CPU(long, vector_misaligned_access) =3D RISCV_HWPROBE_VEC_M=
ISALIGNED_UNSUPPORTED;
> > =20
> >  #ifdef CONFIG_RISCV_PROBE_UNALIGNED_ACCESS
> >  static cpumask_t fast_misaligned_access;
> > @@ -268,12 +269,18 @@ static int check_unaligned_access_all_cpus(void)
> > =20
> >  	if (riscv_has_extension_unlikely(RISCV_ISA_EXT_ZICCLSM)) {
> >  		for_each_online_cpu(cpu) {
> > +#ifdef CONFIG_RISCV_VECTOR_MISALIGNED
> > +			per_cpu(vector_misaligned_access, cpu) =3D RISCV_HWPROBE_VEC_MISALI=
GNED_FAST;
> > +#endif
> > +#ifdef CONFIG_RISCV_MISALIGNED
> >  			per_cpu(misaligned_access_speed, cpu) =3D RISCV_HWPROBE_MISALIGNED_=
FAST;
> > +#endif
>=20
> Can you IS_ENABLED()-ify these two as well please?

Ah, you can't cos the variable doesn't exist in the other case.

--2C5Ng6p8Cz1W0Nqu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZmwB/QAKCRB4tDGHoIJi
0lw0AP0dWhFA2S8cu1ZnOnJgSeMCQC978npy6RKjjZB2oEKb2wEAz/ZaOC0iE5/z
bsJe/o/CJnvi7AXZcpQIaYdEDBNgIgs=
=RIo5
-----END PGP SIGNATURE-----

--2C5Ng6p8Cz1W0Nqu--

