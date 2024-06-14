Return-Path: <linux-kernel+bounces-214545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCE3F908639
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 10:24:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6678F28CFB3
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 08:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F23CF18FDD1;
	Fri, 14 Jun 2024 08:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="TAt6VB/3"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C33185086;
	Fri, 14 Jun 2024 08:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718353426; cv=none; b=H/Ggq3YxikW8Tb8RG5Ya/HqSTVGO2eeow2/cSDVIEps4FDdQipPm8jxoHK176gHxjR+krNnXDbgfTsc8BO5KFddfKhwN7Ei0bgUymwQPB4gkz83j30hrdB7DTrjTblGNnhypyDOhAAGTJETmEbZzU3e/ghTg0iupOhYVZ4Etl/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718353426; c=relaxed/simple;
	bh=I30+svJG/M7AzUfaUajhNLsiziVDSGelWON1BY08RRA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b0Uth3DvHHivK2PdYx0uIAbQ/6anVrfMCYIdob9q9BuQOaeynzmr/ca2NV0mj6oKVwajqPPlPFqj0nxb8+l0smgRtyJSKZqrOT/u8vN7hicI+mE4oQTbXEVggf3uD/3SUuPamjQG+fhD3VcV/J44+b0QrqTAywfz87gd0XPnN4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=TAt6VB/3; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1718353424; x=1749889424;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=I30+svJG/M7AzUfaUajhNLsiziVDSGelWON1BY08RRA=;
  b=TAt6VB/3Ywffc6PCn87J4eM6zebeVDQf1/nM7gU3lOUNhB8QaqQEDrzu
   7muhMQvKwzKyWLzo2qqxaLNHD2qNFjtX/mljPrtZiGoCYKgvxyaCLsyn6
   ZwLt1FhoegUCyFpylHlA0f7d1lOQAWBKXz971JOuSPmowQUj97GSOJWwY
   3ETjFowZLSFANNwo0dw45p1bZDHAyUKzhz6XPBJPPA34kPUtCL1LXMlqY
   GndNOVHt179KUmAnHmXGPyCEoxjTHv2a2Cc3WOF6XcJVwpPa8f9jl8+nu
   rG2f9b13zI69Z88qH5LgSBPdXOXAf7/Vh0n/CZyRfA/3kJwDf3TKfDabN
   A==;
X-CSE-ConnectionGUID: lGiPpL1eRHKZ9zuhk1c1dA==
X-CSE-MsgGUID: t41bSOBzQEqKWlfjgFpvSQ==
X-IronPort-AV: E=Sophos;i="6.08,237,1712646000"; 
   d="asc'?scan'208";a="28158885"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Jun 2024 01:23:42 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 14 Jun 2024 01:23:10 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex03.mchp-main.com (10.10.85.151)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Fri, 14 Jun 2024 01:23:05 -0700
Date: Fri, 14 Jun 2024 09:22:47 +0100
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
Subject: Re: [PATCH v2 3/6] RISC-V: Check scalar unaligned access on all CPUs
Message-ID: <20240614-padded-mammal-d956735c1293@wendy>
References: <20240613191616.2101821-1-jesse@rivosinc.com>
 <20240613191616.2101821-4-jesse@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="5roV/dfZvNvEhY/C"
Content-Disposition: inline
In-Reply-To: <20240613191616.2101821-4-jesse@rivosinc.com>

--5roV/dfZvNvEhY/C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 13, 2024 at 03:16:12PM -0400, Jesse Taube wrote:
> Originally, the check_unaligned_access_emulated_all_cpus function
> only checked the boot hart. This fixes the function to check all
> harts.

This seems like it should be split out and get a Fixes: tag & a cc:
stable.

> Check for Zicclsm before checking for unaligned access. This will
> greatly reduce the boot up time as finding the access speed is no longer
> necessary.
>=20
> Signed-off-by: Jesse Taube <jesse@rivosinc.com>
> ---
> V1 -> V2:
>  - New patch
> ---
>  arch/riscv/kernel/traps_misaligned.c       | 23 ++++++----------------
>  arch/riscv/kernel/unaligned_access_speed.c | 23 +++++++++++++---------
>  2 files changed, 20 insertions(+), 26 deletions(-)
>=20
> diff --git a/arch/riscv/kernel/traps_misaligned.c b/arch/riscv/kernel/tra=
ps_misaligned.c
> index b62d5a2f4541..8fadbe00dd62 100644
> --- a/arch/riscv/kernel/traps_misaligned.c
> +++ b/arch/riscv/kernel/traps_misaligned.c
> @@ -526,31 +526,17 @@ int handle_misaligned_store(struct pt_regs *regs)
>  	return 0;
>  }
> =20
> -static bool check_unaligned_access_emulated(int cpu)
> +static void check_unaligned_access_emulated(struct work_struct *unused)
>  {
> +	int cpu =3D smp_processor_id();
>  	long *mas_ptr =3D per_cpu_ptr(&misaligned_access_speed, cpu);
>  	unsigned long tmp_var, tmp_val;
> -	bool misaligned_emu_detected;
> =20
>  	*mas_ptr =3D RISCV_HWPROBE_MISALIGNED_UNKNOWN;
> =20
>  	__asm__ __volatile__ (
>  		"       "REG_L" %[tmp], 1(%[ptr])\n"
>  		: [tmp] "=3Dr" (tmp_val) : [ptr] "r" (&tmp_var) : "memory");
> -
> -	misaligned_emu_detected =3D (*mas_ptr =3D=3D RISCV_HWPROBE_MISALIGNED_E=
MULATED);
> -	/*
> -	 * If unaligned_ctl is already set, this means that we detected that all
> -	 * CPUS uses emulated misaligned access at boot time. If that changed
> -	 * when hotplugging the new cpu, this is something we don't handle.
> -	 */
> -	if (unlikely(unaligned_ctl && !misaligned_emu_detected)) {
> -		pr_crit("CPU misaligned accesses non homogeneous (expected all emulate=
d)\n");
> -		while (true)
> -			cpu_relax();
> -	}
> -
> -	return misaligned_emu_detected;
>  }
> =20
>  bool check_unaligned_access_emulated_all_cpus(void)
> @@ -562,8 +548,11 @@ bool check_unaligned_access_emulated_all_cpus(void)
>  	 * accesses emulated since tasks requesting such control can run on any
>  	 * CPU.
>  	 */
> +	schedule_on_each_cpu(check_unaligned_access_emulated);
> +
>  	for_each_online_cpu(cpu)
> -		if (!check_unaligned_access_emulated(cpu))
> +		if (per_cpu(misaligned_access_speed, cpu)
> +		    !=3D RISCV_HWPROBE_MISALIGNED_EMULATED)
>  			return false;
> =20
>  	unaligned_ctl =3D true;
> diff --git a/arch/riscv/kernel/unaligned_access_speed.c b/arch/riscv/kern=
el/unaligned_access_speed.c
> index a9a6bcb02acf..70c1588fc353 100644
> --- a/arch/riscv/kernel/unaligned_access_speed.c
> +++ b/arch/riscv/kernel/unaligned_access_speed.c
> @@ -259,23 +259,28 @@ static int check_unaligned_access_speed_all_cpus(vo=
id)
>  	kfree(bufs);
>  	return 0;
>  }
> +#endif /* CONFIG_RISCV_PROBE_UNALIGNED_ACCESS */
> =20
>  static int check_unaligned_access_all_cpus(void)
>  {
> -	bool all_cpus_emulated =3D check_unaligned_access_emulated_all_cpus();
> +	bool all_cpus_emulated;
> +	int cpu;
> =20
> +	if (riscv_has_extension_unlikely(RISCV_ISA_EXT_ZICCLSM)) {
> +		for_each_online_cpu(cpu) {
> +			per_cpu(misaligned_access_speed, cpu) =3D RISCV_HWPROBE_MISALIGNED_FA=
ST;
> +		}
> +		return 0;
> +	}
> +
> +	all_cpus_emulated =3D check_unaligned_access_emulated_all_cpus();
> +
> +#ifdef CONFIG_RISCV_PROBE_UNALIGNED_ACCESS

Can we make this an IS_ENABLED() please?


Thanks,
Conor.

>  	if (!all_cpus_emulated)
>  		return check_unaligned_access_speed_all_cpus();
> +#endif
> =20
>  	return 0;
>  }
> -#else /* CONFIG_RISCV_PROBE_UNALIGNED_ACCESS */
> -static int check_unaligned_access_all_cpus(void)
> -{
> -	check_unaligned_access_emulated_all_cpus();
> -
> -	return 0;
> -}
> -#endif
> =20
>  arch_initcall(check_unaligned_access_all_cpus);
> --=20
> 2.43.0
>=20

--5roV/dfZvNvEhY/C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZmv91wAKCRB4tDGHoIJi
0reHAQDJzCDTih2CT5+8AGBLj1gklSGmS/R+h5QMKj0uL8S0zQEAqTT7zZH5px5I
8XwHyIp3NfUTa9Qm5JgQqXy58YGrLgQ=
=jw9t
-----END PGP SIGNATURE-----

--5roV/dfZvNvEhY/C--

