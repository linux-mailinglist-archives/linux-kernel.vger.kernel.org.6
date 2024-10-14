Return-Path: <linux-kernel+bounces-364309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B01E99D187
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 17:17:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F8BA1F245A8
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 15:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C760F1ABEB1;
	Mon, 14 Oct 2024 15:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZLTcR1L0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 200AD1B85D0
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 15:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728918869; cv=none; b=scIdAwmQeIty0adqSer1kP3so2XpdOwjDHqrxM3FOyTPkZ/fEmx+LgOO0ffvGTPehFnOzxCviZ8N/uKqZZP8JUgqyFNNd7Aos+1EtVTa3FOOgG1JbxNDZZuotl4TuJuhZLPSeLUtJFa01sm20u1SNBn+3ZmJFj+pkUxakqpvxzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728918869; c=relaxed/simple;
	bh=nY5g2YHgpdatItZ1mP7yVZRj0wBocZETzf2AagyWRHw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lks6aqBNe2GHvHp4oRajSy1Qjh4agiskLOgp6c6NXU7FBe4Dm0E19t1AdbOA9toXz6jtb4cXETk8cNB3C+slXLMMmj0fHjYovq/ketxSfnGU+niQHTnh8VTW0FqLMeUqVAV722ATpsZPD3lpb9OGREhJOBjb5AdD7aTdaiEEaJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZLTcR1L0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B508C4CEC3;
	Mon, 14 Oct 2024 15:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728918869;
	bh=nY5g2YHgpdatItZ1mP7yVZRj0wBocZETzf2AagyWRHw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=ZLTcR1L0xSwRBTa2M8HOiQ+f9yAde+Pa/d7Vn6kEr5OKWKZvbHSq3zI/Nfz0hmACC
	 T9LophHT+mUITmoOzCiG1UEL4gx7u5rcfpjc66iyArBIL/vTLPYRF8SjmVDNYIIBWm
	 KFchoCkGwyr32QIESzKfDdD/67TKxGAg35fy7WTHeTi6A/MiIKhLNadnUKY9LsVX7r
	 pzRX/+315foJK3vnZhuqweQinP9eelK9ZlNnrVWJCAhOTiXQwl+jLNTa4WTM3zQtsJ
	 uJUZ8NXvkpwrBuxv8LuliV+t5luLC9ia6rQqzB9ow04nKeLQKscyhGxnOkRMOuV39E
	 kjExaklycbhQQ==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Sunil V L <sunilvl@ventanamicro.com>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org
Cc: Anup Patel <anup@brainfault.org>, Thomas Gleixner <tglx@linutronix.de>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, "Rafael J .
 Wysocki" <rafael.j.wysocki@intel.com>, Sunil V L
 <sunilvl@ventanamicro.com>, Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: Re: [PATCH] irqchip/riscv-intc: Fix no-SMP boot with ACPI
In-Reply-To: <20241014065739.656959-1-sunilvl@ventanamicro.com>
References: <20241014065739.656959-1-sunilvl@ventanamicro.com>
Date: Mon, 14 Oct 2024 17:14:26 +0200
Message-ID: <87cyk2zpgt.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Thanks for fixing this, Sunil!

Sunil V L <sunilvl@ventanamicro.com> writes:

> When CONFIG_SMP is disabled, the static array rintc_acpi_data with size
> NR_CPUS will not be sufficient to hold all RINTC structures passed from
> the firmware. All RINTC structures are required to configure
> IMSIC/APLIC/PLIC properly irrespective of SMP in the OS. So, allocate
> dynamic memory based on the number of RINTC structures in MADT to fix
> this issue.

To clarify; QEMU is constructing an ACPI table for multiple harts
(multiple RINTC), but the kernel build is NO_SMP.

> Fixes: f8619b66bdb1 ("irqchip/riscv-intc: Add ACPI support for AIA")
> Reported-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>
> Closes: https://github.com/linux-riscv/linux-riscv/actions/runs/112809975=
11/job/31375229012
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> ---
>  drivers/irqchip/irq-riscv-intc.c | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/irqchip/irq-riscv-intc.c b/drivers/irqchip/irq-riscv=
-intc.c
> index 8c5411386220..f653c13de62b 100644
> --- a/drivers/irqchip/irq-riscv-intc.c
> +++ b/drivers/irqchip/irq-riscv-intc.c
> @@ -265,7 +265,7 @@ struct rintc_data {
>  };
>=20=20
>  static u32 nr_rintc;
> -static struct rintc_data *rintc_acpi_data[NR_CPUS];
> +static struct rintc_data **rintc_acpi_data;
>=20=20
>  #define for_each_matching_plic(_plic_id)				\
>  	unsigned int _plic;						\
> @@ -329,13 +329,30 @@ int acpi_rintc_get_imsic_mmio_info(u32 index, struc=
t resource *res)
>  	return 0;
>  }
>=20=20
> +static int __init riscv_intc_acpi_match(union acpi_subtable_headers *hea=
der,
> +					const unsigned long end)
> +{
> +	return 0;
> +}
> +
>  static int __init riscv_intc_acpi_init(union acpi_subtable_headers *head=
er,
>  				       const unsigned long end)
>  {
>  	struct acpi_madt_rintc *rintc;
>  	struct fwnode_handle *fn;
> +	int count;
>  	int rc;
>=20=20
> +	if (!rintc_acpi_data) {
> +		count =3D acpi_table_parse_madt(ACPI_MADT_TYPE_RINTC, riscv_intc_acpi_=
match, 0);
> +		if (count <=3D 0)
> +			return -EINVAL;
> +
> +		rintc_acpi_data =3D kcalloc(count, sizeof(*rintc_acpi_data), GFP_KERNE=
L);
> +		if (!rintc_acpi_data)
> +			return -ENOMEM;
> +	}
> +
>  	rintc =3D (struct acpi_madt_rintc *)header;
>  	rintc_acpi_data[nr_rintc] =3D kzalloc(sizeof(*rintc_acpi_data[0]), GFP_=
KERNEL);
>  	if (!rintc_acpi_data[nr_rintc])
> --=20
> 2.43.0

For context, this is the splat:

  | Unable to handle kernel paging request at virtual address ff60000000000=
00c
  | Oops [#1]
  | Modules linked in:
  | CPU: 0 UID: 0 PID: 0 Comm: swapper Not tainted 6.12.0-rc2-g2255fe696ded=
 #1
  | epc : acpi_rintc_index_to_hartid+0x2c/0x3c
  |  ra : imsic_get_parent_hartid+0x54/0xb6
  | epc : ffffffff8046b788 ra : ffffffff80a1fe74 sp : ffffffff81403af0
  |  gp : ffffffff815181b8 tp : ffffffff8140c780 t0 : ffffffff81403b58
  |  t1 : 00000000000003ff t2 : 0000000000000004 s0 : ffffffff81403b90
  |  s1 : ff60000080057060 a0 : 0000000000000008 a1 : 0000000000000000
  |  a2 : 0000000000000000 a3 : ffffffff81403b58 a4 : ffffffff80e0dd80
  |  a5 : ff60000000000004 a6 : 0000000000000001 a7 : 0000000000000400
  |  s2 : ffffffff81403bb0 s3 : 0000000000000001 s4 : ff1bfffffea790e8
  |  s5 : ffffffff81403da0 s6 : 0000000000000000 s7 : ffffffff8151c9e8
  |  s8 : 0000000000000001 s9 : 0000000000000003 s10: 0000000000000000
  |  s11: ffffffff81403da0 t3 : 0000000000000400 t4 : 0000000000000401
  |  t5 : 0000000000000001 t6 : 0000000000000400
  | status: 0000000200000100 badaddr: ff6000000000000c cause: 0000000000000=
00d
  | [<ffffffff8046b788>] acpi_rintc_index_to_hartid+0x2c/0x3c
  | [<ffffffff80a20008>] imsic_setup_state+0xe8/0x83a
  | [<ffffffff80a208f8>] imsic_early_acpi_init+0x50/0xd2
  | [<ffffffff80a23536>] acpi_match_madt+0x2e/0x5a
  | [<ffffffff80a1f5f4>] acpi_parse_entries_array+0x164/0x230
  | [<ffffffff80a222ba>] acpi_table_parse_entries_array+0x86/0xc2
  | [<ffffffff80a2234a>] acpi_table_parse_entries+0x54/0x7c
  | [<ffffffff80a22410>] acpi_table_parse_madt+0x22/0x2a
  | [<ffffffff80a2389c>] __acpi_probe_device_table+0x78/0xc8
  | [<ffffffff80a1f98a>] irqchip_init+0x36/0x3e
  | [<ffffffff80a03d2e>] init_IRQ+0x30/0x52
  | [<ffffffff80a00c08>] start_kernel+0x4b4/0x800
  | Code: d513 01d7 1797 010b 8793 2507 97aa 639c 60a2 6402 (6788) 0141=20
  | ---[ end trace 0000000000000000 ]---

(Alex just kicked a build w/ this patch)


Bj=C3=B6rn

