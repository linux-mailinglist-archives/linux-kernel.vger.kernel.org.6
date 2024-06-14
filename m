Return-Path: <linux-kernel+bounces-214795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 570DB908A04
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 12:34:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 099381F2AB96
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 10:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35E4C146D6A;
	Fri, 14 Jun 2024 10:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="hT0h+5h5"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0336146582
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 10:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718361221; cv=none; b=DmroV1LpW58ccor8nk2JC8+fwFR4cIfnJ8poDR0h3zh5IPnMoOnIubIwhTB3RP529M17amve9hy9NCjCCqoW45u5Tka7drHsIcw0zT5ps7FbkXhmUstJEyG4sVWt4DXBrUGH3hb1oyNrWpWU+Mia/hg9EAEA9XHjYexCNhIgVjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718361221; c=relaxed/simple;
	bh=zKFVQcNDWqXCGZ7zuzGjVyrkVqlxiBV4E3WyjElyZPg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mIQ291ij8KpIXeawb+UGktW3xiDE2rZILPEkgkQcQLVmm7rv5B/40j1LV/7pX16cjBj611OYAkKxcLMixGPl3UX8bt3J3wG5JgMlOPCqgXhsd9OK8yuPT2w0ShqYLPdAoE5dmD4eurjiLtkD+4+bxDW7DYzzxfYpkKeLqk5qRe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=hT0h+5h5; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1718361220; x=1749897220;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zKFVQcNDWqXCGZ7zuzGjVyrkVqlxiBV4E3WyjElyZPg=;
  b=hT0h+5h5U+6t29DSz1ATuXnDKPp5jQFVQ6VGjEjpKRa3zMM5K/99D4tZ
   R8AkVezZnzVnTeDJn/fyK8co9OpS+ci9k3o6smepELH5EC/euI4VEsDR9
   d1rflsygmTos8BAzO+UaZ8UYbllAz9G6DghVUfAVT0QTQs2a5Re2wVJtn
   pAHyqdJFoj+guYjqbnyhJtTSMojimXD+QBY5DP9azo7QOw0qzQsgTJC2b
   8E0YbxIJttMFcIrziUSewoUUNM1ktHbHdeTPswy1Iy+hY+4/KHgFVH+dM
   8ICbt1/GpmaS7DCk2kghfNDOB13jY80GT9cUJBpVkZlk48kNebLx5BgeX
   A==;
X-CSE-ConnectionGUID: SO3PLno2RDKKqlus4gx9zg==
X-CSE-MsgGUID: gghXVzn6TvCsGhAud+X65w==
X-IronPort-AV: E=Sophos;i="6.08,237,1712646000"; 
   d="asc'?scan'208";a="258401164"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Jun 2024 03:33:40 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 14 Jun 2024 03:33:03 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex03.mchp-main.com (10.10.85.151)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Fri, 14 Jun 2024 03:33:02 -0700
Date: Fri, 14 Jun 2024 11:32:44 +0100
From: Conor Dooley <conor.dooley@microchip.com>
To: Samuel Holland <samuel.holland@sifive.com>
CC: <linux-riscv@lists.infradead.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Andrew Jones <ajones@ventanamicro.com>, Conor Dooley <conor@kernel.org>,
	<linux-kernel@vger.kernel.org>, Deepak Gupta <debug@rivosinc.com>
Subject: Re: [PATCH v2 3/3] riscv: Call riscv_user_isa_enable() only on the
 boot hart
Message-ID: <20240614-ambition-machine-e7ece59835b2@wendy>
References: <20240613171447.3176616-1-samuel.holland@sifive.com>
 <20240613171447.3176616-4-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qiDFuQ1nB2wyYWDo"
Content-Disposition: inline
In-Reply-To: <20240613171447.3176616-4-samuel.holland@sifive.com>

--qiDFuQ1nB2wyYWDo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 13, 2024 at 10:14:41AM -0700, Samuel Holland wrote:
> Now that the [ms]envcfg CSR value is maintained per thread, not per
> hart, riscv_user_isa_enable() only needs to be called once during boot,
> to set the value for the init task. This also allows it to be marked as
> __init. riscv_isa_extension_check() sets any_cpu_has_zicboz, so it also
> needs to be marked __init; it could have had this annotation already.
>=20
> Reviewed-by: Deepak Gupta <debug@rivosinc.com>
> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>


--qiDFuQ1nB2wyYWDo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZmwcTAAKCRB4tDGHoIJi
0mUHAQCStAMT6gpp0nXlmH2BnbFquTM6/e0j0BbeyiugguDaigD+IVfaMRkmfF8j
lhiLwlGdAwHHQezVNILCQlCUtjVz2wE=
=GZRs
-----END PGP SIGNATURE-----

--qiDFuQ1nB2wyYWDo--

