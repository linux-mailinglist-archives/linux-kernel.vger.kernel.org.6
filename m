Return-Path: <linux-kernel+bounces-214562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 390F7908673
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 10:37:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3D22B227C2
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 08:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83984190074;
	Fri, 14 Jun 2024 08:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="YW2yeP5p"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95BDC1849;
	Fri, 14 Jun 2024 08:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718354253; cv=none; b=qVpHxb06o/CNv/e/wjbAAra23FA5c9GHQyuDkZ2S4KGl5Rl3Ly/PfLJa2shkh9MN4DhAiCBSiSe9hR4XEGHdCMfYOKKdOzMYrAgBqQd0vw5btQykblkY/PEb1n1UjjJx9SmbpFHkL+e1hRwKM70NcszWAyDIvNTUaOYlwjoLENo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718354253; c=relaxed/simple;
	bh=IE56RPoqKyRQy8bsSYTv0dvMwFiHl4QLf2TB7HaBQLQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Iu7t63/NqJwZnhLfduzfD0JvGcSlHoRjgwFni/WMEGnBTrsnKC9qhoGb4R5oqGohz4uLAe/Er3bpRPU/g1RL29c1moApE9nsDK+bK+ihJ8P+d3d69hI7O56VRo76IWi9B02WM65dcCzNYkTSadnp4+kd9YJczXaIEC0q1Y5A3XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=YW2yeP5p; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1718354251; x=1749890251;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IE56RPoqKyRQy8bsSYTv0dvMwFiHl4QLf2TB7HaBQLQ=;
  b=YW2yeP5pZzSts/P3luQ0AgIei6MKe5tpWM8hJQ+kw8c6ATsNU6apzhIu
   h7DM5EHCLKgPNQz8clwUulwuJRbIc/Qg2yhzHj6O6JaeBebqclx4mODHV
   32AAQ5nJIUIBzcKhETJO/sB04O2ysehK8Ptb+1J+YBboh6kfrSdncuFuu
   3H1/fsocS4RyHltLqWbq2lMRhBB2Er6EHPz2kOHtLJ6CF0TkRS6hUca4o
   7cDFsxnz0JvYE8LldRGeW1eSVoES9iAwC+pIJ8kSiqgrVdn2KAJiw3d6C
   pp5q8Bv62572VXlW5kj94xxkeYgq86PPKQxJhDOEYEy3xUKSLNHqnHGMA
   Q==;
X-CSE-ConnectionGUID: NG7Mft5MRmOGOwVcOw10MA==
X-CSE-MsgGUID: T/1ZNyhISGCswnvApzi+sQ==
X-IronPort-AV: E=Sophos;i="6.08,237,1712646000"; 
   d="asc'?scan'208";a="194925024"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Jun 2024 01:37:28 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 14 Jun 2024 01:37:19 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex04.mchp-main.com (10.10.85.152)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Fri, 14 Jun 2024 01:37:13 -0700
Date: Fri, 14 Jun 2024 09:36:55 +0100
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
Message-ID: <20240614-viral-dinghy-71d5f6585a55@wendy>
References: <20240613191616.2101821-1-jesse@rivosinc.com>
 <20240613191616.2101821-5-jesse@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Ytzm/oHaDkbsSGqU"
Content-Disposition: inline
In-Reply-To: <20240613191616.2101821-5-jesse@rivosinc.com>

--Ytzm/oHaDkbsSGqU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 13, 2024 at 03:16:13PM -0400, Jesse Taube wrote:
> --- a/arch/riscv/kernel/unaligned_access_speed.c
> +++ b/arch/riscv/kernel/unaligned_access_speed.c
> @@ -19,7 +19,8 @@
>  #define MISALIGNED_BUFFER_ORDER get_order(MISALIGNED_BUFFER_SIZE)
>  #define MISALIGNED_COPY_SIZE ((MISALIGNED_BUFFER_SIZE / 2) - 0x80)
> =20
> -DEFINE_PER_CPU(long, misaligned_access_speed);
> +DEFINE_PER_CPU(long, misaligned_access_speed) =3D RISCV_HWPROBE_MISALIGN=
ED_UNKNOWN;
> +DEFINE_PER_CPU(long, vector_misaligned_access) =3D RISCV_HWPROBE_VEC_MIS=
ALIGNED_UNSUPPORTED;
> =20
>  #ifdef CONFIG_RISCV_PROBE_UNALIGNED_ACCESS
>  static cpumask_t fast_misaligned_access;
> @@ -268,12 +269,18 @@ static int check_unaligned_access_all_cpus(void)
> =20
>  	if (riscv_has_extension_unlikely(RISCV_ISA_EXT_ZICCLSM)) {
>  		for_each_online_cpu(cpu) {
> +#ifdef CONFIG_RISCV_VECTOR_MISALIGNED
> +			per_cpu(vector_misaligned_access, cpu) =3D RISCV_HWPROBE_VEC_MISALIGN=
ED_FAST;
> +#endif
> +#ifdef CONFIG_RISCV_MISALIGNED
>  			per_cpu(misaligned_access_speed, cpu) =3D RISCV_HWPROBE_MISALIGNED_FA=
ST;
> +#endif

Can you IS_ENABLED()-ify these two as well please?

--Ytzm/oHaDkbsSGqU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZmwBJwAKCRB4tDGHoIJi
0o83AP4l3yMCtJznhon+dFQUAVsO6wRiQb2NfRzHzaOsUmMyyQEA3rLtvEQrCOU7
yZz/D4drHvHR3eCHR57Lvgb+yeiQJww=
=ToT+
-----END PGP SIGNATURE-----

--Ytzm/oHaDkbsSGqU--

