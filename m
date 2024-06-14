Return-Path: <linux-kernel+bounces-214505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F6039085B0
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 10:10:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 954BA1C21EBF
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 08:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9015F184126;
	Fri, 14 Jun 2024 08:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="CpGYsKCo"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AAB11836DE;
	Fri, 14 Jun 2024 08:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718352598; cv=none; b=PBsPWHx0S5m8nFiTC43JuNmPFmQLkhC05QODi+wnbdnrbedMt7bey2zTwTrUjEsSEg5ki/+Z+ZL+dqj7THP6OmznYmhRt5Pm2Csd+pgFSz96C41CNp3bsOU4hI5stvSVTLs2a3xZYsDZQPTyw+FzIGJBFiN/LWSNWzKDVkKBmd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718352598; c=relaxed/simple;
	bh=tdyxMi9MCtjeyNj6V3YguqessosZYjypEXDKgngR3k4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pQaqpjaspWA92HgrpAkmLqCoWeb6BJUcJUUCWHea1pegZIn8qc6D+4ntVS2Y/SyjKgkye31L37ZNw5fW/rh/6Zb5/B+EE+7G2dSDQThoM+TgKOC3aaZTWpt1DUDhkPQ+mfdd3v1OjN+J74eTq8EGXY2HR5fQ+m449XklB8hAZ08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=CpGYsKCo; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1718352596; x=1749888596;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tdyxMi9MCtjeyNj6V3YguqessosZYjypEXDKgngR3k4=;
  b=CpGYsKCoW4PGUZpLpT7vHazzPvsz70Vi+l44fuLr234xepsHKyQJGlyM
   NsgcbgvwJwEAgMKvr11Fa4fcCAhePZHKD9ME7jEpTZYmafq0aHzi4vWFJ
   yva9mD2X9zAL8rcNhLNpUCzAWhpFDfo0Xw/WhorH85quBqMaUb22xgJFr
   QUsjL1n0HEoxqNMWTqvE+cVLXfeHdowDaa+h+43i7xoAAQsX3W0LRRJmT
   pJb7kYsdujmXacIlfnhh9GvBpTpqMmDBTEyhV0n5KlDpLH5FFwHCvF+M4
   BotzoBLk6PmnEmldqkngkJEzBAEIlxI/U6mJfadA6M45AS6Bkj//0vuQX
   w==;
X-CSE-ConnectionGUID: MPaymeoARIu6VK5pumub+w==
X-CSE-MsgGUID: Uq74KbUuSymUnT1JBSATOA==
X-IronPort-AV: E=Sophos;i="6.08,237,1712646000"; 
   d="asc'?scan'208";a="29987298"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Jun 2024 01:09:54 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 14 Jun 2024 01:09:38 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex01.mchp-main.com (10.10.85.143)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Fri, 14 Jun 2024 01:09:33 -0700
Date: Fri, 14 Jun 2024 09:09:15 +0100
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
Subject: Re: [PATCH v2 1/6] RISC-V: Add Zicclsm to cpufeature and hwprobe
Message-ID: <20240614-oyster-ditch-80e8f00fd91b@wendy>
References: <20240613191616.2101821-1-jesse@rivosinc.com>
 <20240613191616.2101821-2-jesse@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="OQKmvcs8HRT7+PY2"
Content-Disposition: inline
In-Reply-To: <20240613191616.2101821-2-jesse@rivosinc.com>

--OQKmvcs8HRT7+PY2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 13, 2024 at 03:16:10PM -0400, Jesse Taube wrote:
> > Zicclsm Misaligned loads and stores to main memory regions with both
> > the cacheability and coherence PMAs must be supported.
> > Note:
> > This introduces a new extension name for this feature.
> > This requires misaligned support for all regular load and store
> > instructions (including scalar and vector) but not AMOs or other
> > specialized forms of memory access. Even though mandated, misaligned
> > loads and stores might execute extremely slowly. Standard software
> > distributions should assume their existence only for correctness,
> > not for performance.
>=20
> Detecing zicclsm allows the kernel to report if the
> hardware supports misaligned accesses even if support wasn't probed.
>=20
> This is useful for usermode to know if vector misaligned accesses are
> supported.
>=20
> Signed-off-by: Jesse Taube <jesse@rivosinc.com>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

--OQKmvcs8HRT7+PY2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZmv6qwAKCRB4tDGHoIJi
0mzaAP9YBq9BuQ1DEPPsxpTTaIEq91WxQdesurCAlXQCERPNnQEA5hS94j7obJ9J
hv52wvk6In81vYzmCTh9UFDBJVVc9gw=
=TSBq
-----END PGP SIGNATURE-----

--OQKmvcs8HRT7+PY2--

