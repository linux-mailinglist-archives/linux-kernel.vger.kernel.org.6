Return-Path: <linux-kernel+bounces-259261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D2A8939331
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 19:28:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08546284354
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 17:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D172616EB59;
	Mon, 22 Jul 2024 17:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MWQrGnFD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E781401B
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 17:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721669318; cv=none; b=lmQcVt/iKscQ2dYIft2FdDAP/2SwNqb5h62JFTGH+3YSf/VqYE8PhdqQKwrgZoESa/7xdhWhbPjMor/MXrXqyoVW0V72FwKQMcaiCvxzz6HX6+N60J0tNKr5EtzOcTMBf3jtPEpSd6ql8l+2PBqbYzDE8lNcmoDHC5sI2ebYs18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721669318; c=relaxed/simple;
	bh=gE67ioz8zjgYuEjUmRgDNta4WfPWJYFrCQjm41DlRjY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h1aMnNT31eCBjNPEwZV20JVQg4ETG5Z3KscPDae7lKq0x+iF+q8mvgK6F/kjgZg66dVKtrchuiPg2ED9e69ASkMIYid3x4nOtJbEkbN2HxcPwQmjSn3X6N0mTTk5ptWu9KkUJHD184yo14G/K+SJidFwbWk3UHJEFQP+pULjiUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MWQrGnFD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50D11C116B1;
	Mon, 22 Jul 2024 17:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721669317;
	bh=gE67ioz8zjgYuEjUmRgDNta4WfPWJYFrCQjm41DlRjY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MWQrGnFDi6rtSeHvm2PJj2hRQ1xi9VLbeoJ4pys14muvHF4xmKqkBNQPzJIZIi9gV
	 gf0xZoYoR194PtP7fUQBfyQYIgyDCd4R5ObBA2acwscvdSrsk83N+Ji1dKx4/ffDju
	 HpF6xNy0ioejp3CoCLJmGF5REPBV6IY7p/bb7CrDQYPtzM2EieAEPkTNgp2u9JI8I1
	 vL2NtdsTUq050sfHSgPqgODKZm0+giTsoScQuOAQ6gQcJ7caX9EBFC8PWO5wNr7VwV
	 E/p5355oh9x9C/gpaUbBpEAjUKFQB4403t7Yg8Z9nSVffm4HUARFS9PXIyzfUt3nzt
	 LvPuIqFhmWj/Q==
Date: Mon, 22 Jul 2024 18:28:32 +0100
From: Conor Dooley <conor@kernel.org>
To: Yunhui Cui <cuiyunhui@bytedance.com>
Cc: punit.agrawal@bytedance.com, paul.walmsley@sifive.com,
	palmer@dabbelt.com, aou@eecs.berkeley.edu,
	akpm@linux-foundation.org, surenb@google.com, peterx@redhat.com,
	alexghiti@rivosinc.com, willy@infradead.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] riscv/mm/fault: add show_pte() before die()
Message-ID: <20240722-pantyhose-salvaging-96faac4b4661@spud>
References: <20240722042037.27934-1-cuiyunhui@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="jxAOmrTq4DroifFi"
Content-Disposition: inline
In-Reply-To: <20240722042037.27934-1-cuiyunhui@bytedance.com>


--jxAOmrTq4DroifFi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 22, 2024 at 12:20:37PM +0800, Yunhui Cui wrote:
> When the kernel displays "Unable to handle kernel paging request at
> virtual address", we would like to confirm the status of the virtual
> address in the page table. So add show_pte() before die().
>=20
> Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>

The patchwork automation reports:
+      1 ../arch/riscv/mm/fault.c:39:4: warning: format specifies type 'uns=
igned long' but the argument has type 'phys_addr_t' (aka 'unsigned long lon=
g') [-Wformat]

Cheers,
Conor.

> ---
>  arch/riscv/mm/fault.c | 53 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 53 insertions(+)
>=20
> diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
> index 5224f3733802..666d282a8bf4 100644
> --- a/arch/riscv/mm/fault.c
> +++ b/arch/riscv/mm/fault.c
> @@ -22,6 +22,58 @@
> =20
>  #include "../kernel/head.h"
> =20
> +static void show_pte(unsigned long addr)
> +{
> +	pgd_t *pgdp, pgd;
> +	p4d_t *p4dp, p4d;
> +	pud_t *pudp, pud;
> +	pmd_t *pmdp, pmd;
> +	pte_t *ptep, pte;
> +	struct mm_struct *mm =3D current->mm;
> +
> +	if (!mm)
> +		mm =3D &init_mm;
> +
> +	pr_alert("Current %s pgtable: %luK pagesize, %d-bit VAs, pgdp=3D0x%016l=
x\n",
> +		 current->comm, PAGE_SIZE/SZ_1K, VA_BITS,
> +		 (mm =3D=3D &init_mm ? __pa_symbol(mm->pgd) :
> +		 (unsigned long)virt_to_phys(mm->pgd)));
> +
> +	pgdp =3D pgd_offset(mm, addr);
> +	pgd =3D pgdp_get(pgdp);
> +	pr_alert("[%016lx] pgd=3D%016lx", addr, pgd_val(pgd));
> +	if (pgd_none(pgd) || pgd_bad(pgd) || pgd_leaf(pgd))
> +		goto out;
> +
> +	p4dp =3D p4d_offset(pgdp, addr);
> +	p4d =3D p4dp_get(p4dp);
> +	pr_cont(", p4d=3D%016lx", p4d_val(p4d));
> +	if (p4d_none(p4d) || p4d_bad(p4d) || p4d_leaf(p4d))
> +		goto out;
> +
> +	pudp =3D pud_offset(p4dp, addr);
> +	pud =3D pudp_get(pudp);
> +	pr_cont(", pud=3D%016lx", pud_val(pud));
> +	if (pud_none(pud) || pud_bad(pud) || pud_leaf(pud))
> +		goto out;
> +
> +	pmdp =3D pmd_offset(pudp, addr);
> +	pmd =3D pmdp_get(pmdp);
> +	pr_cont(", pmd=3D%016lx", pmd_val(pmd));
> +	if (pmd_none(pmd) || pmd_bad(pmd) || pmd_leaf(pmd))
> +		goto out;
> +
> +	ptep =3D pte_offset_map(pmdp, addr);
> +	if (!ptep)
> +		goto out;
> +
> +	pte =3D ptep_get(ptep);
> +	pr_cont(", pte=3D%016lx", pte_val(pte));
> +	pte_unmap(ptep);
> +out:
> +	pr_cont("\n");
> +}
> +
>  static void die_kernel_fault(const char *msg, unsigned long addr,
>  		struct pt_regs *regs)
>  {
> @@ -31,6 +83,7 @@ static void die_kernel_fault(const char *msg, unsigned =
long addr,
>  		addr);
> =20
>  	bust_spinlocks(0);
> +	show_pte(addr);
>  	die(regs, "Oops");
>  	make_task_dead(SIGKILL);
>  }
> --=20
> 2.39.2
>=20
>=20

--jxAOmrTq4DroifFi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZp6WwAAKCRB4tDGHoIJi
0sv+AQDVz6BxNdfqj/Mhhk++WSIcOjYj9aQBtAsjf3uv08sPAgD+K8cK7ypV/tvn
IX+ITIjwsuR4c3NegxPFbQjzeDDGNgY=
=RQTs
-----END PGP SIGNATURE-----

--jxAOmrTq4DroifFi--

