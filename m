Return-Path: <linux-kernel+bounces-276488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0570B94947C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 17:26:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28AAA1C218E8
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 15:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2959A36127;
	Tue,  6 Aug 2024 15:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="EPSPNpfh"
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A352AE97
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 15:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722957949; cv=none; b=l/YkZuFM/RKNDOYsw5yiLi2Jgm+4qPy+tJ8Q6j1gsVtp2g4ojQ93wUirTO1pm9aY2I0P+Ghx9GLP8e3vfDj2r4C2pN3u4fUCP8HY1aiJvYPZ7iranlMjC8eR59I0hvLkNQExlVOylIXsPsRXAiMO0uYr7rNg6rCXLYW2lJgOVxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722957949; c=relaxed/simple;
	bh=900LQubH8X088PQcoK6a0R1nFpSkYEOfMMzBW84XtcM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pRgNywEORnBisSS0AgkFj9EplFbPXdR8XAXsevh2dAk9OzxU62lh8T7VzvEEPFcwCQ0HRv3qw1cKmBD8xySDnEGJWDcR3WaxH1JngVWX3JGeoqef6OSfT9h4CCGr9EiKMHT6Lt1k6l+aU/TCTEsJRsg54vaeo7o7iKSum2AyI1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=EPSPNpfh; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-39834949f27so3165595ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 08:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1722957945; x=1723562745; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2hSFaWzu7k5+i7urG/rB+QN7qlxFaVHDeVcWBVMpJHI=;
        b=EPSPNpfh2KnZAHOggU9OhZc2/HdqN0qQUSLkujWLKpg5flqKEGW2Ay/ZbKhs0ahw/Z
         IcVjGMeCYEFATUeRAIICeoLwNQCbuWoD4rcHU06Kkqn9M1qklxTwsnEl9HYBcUfHvXcm
         PXSLkiFK4A8ipp73EFdhhYv2jImqA0tRLlgrWZufrGygMpdTYHNXehYxfKFSQnDel8LU
         Flm6qQgfiRQzT90F43Sb/dfa0LXGGxUOBlikQavPbx+AvGpFkNFZNWdqHU7Fi3rw2nyO
         +rh/DTf+aWq6/LN/IUkN59qy7ogUmD9r/xfRKPQmrOfdFRfo0xdYQE5bTcEO2P2nel+m
         +7FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722957945; x=1723562745;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2hSFaWzu7k5+i7urG/rB+QN7qlxFaVHDeVcWBVMpJHI=;
        b=xDD2ofE7BuDY5Ku7NmAmyFGJ5CuW8RJx95CsOV7gzE3DAOwd/vCyds9x78x92QG1XT
         LaBKFcK1wCLglUi8zF1acGp+RBbf9zPOLM9vTSRqQNpIEXnMLrEIBEPyOtGEF2Ur8RGj
         7Uj8sjFgtFk9Mzzb62/cEAzKhUCGLTgsBxSYryV2wOsfKfL8ZNKfJwZwSK1AbnruVINC
         QUbgEsuGs477weWZ8nqDbfxq71ocZ+xPb22pYGlWO2lOm/vcpUniV7N6a+fHvk33e09x
         P1X6wnWmr76W+RDbpyxxH8GanMNkyGmjl10/Mr8cYM04Qux2gcJYsyyeBqTQDcxnBilW
         2VAQ==
X-Gm-Message-State: AOJu0YxCTygHoX0D84+KjkYmQ1dhGY/7qN4BDb4IMoEC1zIu62BjoMO4
	MJFPtoo08NCDLRuWSCbZYwl7UXJPkUEd/84OrXbHq63WiUOC6W93bzWUnCzGbS8cn+Z+nQaZL6m
	qifwGearRRF2PbNuwtb8gbVqNDO7JuNx4CyB+UA==
X-Google-Smtp-Source: AGHT+IFRjj14ZK3zQwhUJXXLBufMqLIkirrDvsuwso/YZ1pLiuKaOUUkzxwFjczveLiPrX3RKPs/9rVwHlLGeDyxf6w=
X-Received: by 2002:a05:6e02:1645:b0:39b:375a:f8b7 with SMTP id
 e9e14a558f8ab-39b375afc45mr146160275ab.23.1722957945281; Tue, 06 Aug 2024
 08:25:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240729142241.733357-1-sunilvl@ventanamicro.com> <20240729142241.733357-15-sunilvl@ventanamicro.com>
In-Reply-To: <20240729142241.733357-15-sunilvl@ventanamicro.com>
From: Anup Patel <anup@brainfault.org>
Date: Tue, 6 Aug 2024 20:55:34 +0530
Message-ID: <CAAhSdy2ATNkx4cpMLpVrBUbxSG+WVbOFpMA8LQcMAE2jGSs4ng@mail.gmail.com>
Subject: Re: [PATCH v7 14/17] irqchip/riscv-imsic-state: Create separate
 function for DT
To: Sunil V L <sunilvl@ventanamicro.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-pci@vger.kernel.org, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Samuel Holland <samuel.holland@sifive.com>, 
	Robert Moore <robert.moore@intel.com>, Conor Dooley <conor.dooley@microchip.com>, 
	Andrew Jones <ajones@ventanamicro.com>, Haibo Xu <haibo1.xu@intel.com>, 
	Atish Kumar Patra <atishp@rivosinc.com>, Drew Fustini <dfustini@tenstorrent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 29, 2024 at 7:54=E2=80=AFPM Sunil V L <sunilvl@ventanamicro.com=
> wrote:
>
> While populating IMSIC global structure, many fields are initialized
> using DT properties. Make the code which uses DT properties as separate
> function so that it is easier to add ACPI support later. No
> functionality added/changed.
>
> Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup

> ---
>  drivers/irqchip/irq-riscv-imsic-state.c | 97 ++++++++++++++-----------
>  1 file changed, 55 insertions(+), 42 deletions(-)
>
> diff --git a/drivers/irqchip/irq-riscv-imsic-state.c b/drivers/irqchip/ir=
q-riscv-imsic-state.c
> index 5479f872e62b..f9e70832863a 100644
> --- a/drivers/irqchip/irq-riscv-imsic-state.c
> +++ b/drivers/irqchip/irq-riscv-imsic-state.c
> @@ -510,6 +510,60 @@ static int __init imsic_matrix_init(void)
>         return 0;
>  }
>
> +static int __init imsic_populate_global_dt(struct fwnode_handle *fwnode,
> +                                          struct imsic_global_config *gl=
obal,
> +                                          u32 *nr_parent_irqs)
> +{
> +       int rc;
> +
> +       /* Find number of guest index bits in MSI address */
> +       rc =3D of_property_read_u32(to_of_node(fwnode), "riscv,guest-inde=
x-bits",
> +                                 &global->guest_index_bits);
> +       if (rc)
> +               global->guest_index_bits =3D 0;
> +
> +       /* Find number of HART index bits */
> +       rc =3D of_property_read_u32(to_of_node(fwnode), "riscv,hart-index=
-bits",
> +                                 &global->hart_index_bits);
> +       if (rc) {
> +               /* Assume default value */
> +               global->hart_index_bits =3D __fls(*nr_parent_irqs);
> +               if (BIT(global->hart_index_bits) < *nr_parent_irqs)
> +                       global->hart_index_bits++;
> +       }
> +
> +       /* Find number of group index bits */
> +       rc =3D of_property_read_u32(to_of_node(fwnode), "riscv,group-inde=
x-bits",
> +                                 &global->group_index_bits);
> +       if (rc)
> +               global->group_index_bits =3D 0;
> +
> +       /*
> +        * Find first bit position of group index.
> +        * If not specified assumed the default APLIC-IMSIC configuration=
.
> +        */
> +       rc =3D of_property_read_u32(to_of_node(fwnode), "riscv,group-inde=
x-shift",
> +                                 &global->group_index_shift);
> +       if (rc)
> +               global->group_index_shift =3D IMSIC_MMIO_PAGE_SHIFT * 2;
> +
> +       /* Find number of interrupt identities */
> +       rc =3D of_property_read_u32(to_of_node(fwnode), "riscv,num-ids",
> +                                 &global->nr_ids);
> +       if (rc) {
> +               pr_err("%pfwP: number of interrupt identities not found\n=
", fwnode);
> +               return rc;
> +       }
> +
> +       /* Find number of guest interrupt identities */
> +       rc =3D of_property_read_u32(to_of_node(fwnode), "riscv,num-guest-=
ids",
> +                                 &global->nr_guest_ids);
> +       if (rc)
> +               global->nr_guest_ids =3D global->nr_ids;
> +
> +       return 0;
> +}
> +
>  static int __init imsic_get_parent_hartid(struct fwnode_handle *fwnode,
>                                           u32 index, unsigned long *harti=
d)
>  {
> @@ -578,50 +632,9 @@ static int __init imsic_parse_fwnode(struct fwnode_h=
andle *fwnode,
>                 return -EINVAL;
>         }
>
> -       /* Find number of guest index bits in MSI address */
> -       rc =3D of_property_read_u32(to_of_node(fwnode), "riscv,guest-inde=
x-bits",
> -                                 &global->guest_index_bits);
> +       rc =3D imsic_populate_global_dt(fwnode, global, nr_parent_irqs);
>         if (rc)
> -               global->guest_index_bits =3D 0;
> -
> -       /* Find number of HART index bits */
> -       rc =3D of_property_read_u32(to_of_node(fwnode), "riscv,hart-index=
-bits",
> -                                 &global->hart_index_bits);
> -       if (rc) {
> -               /* Assume default value */
> -               global->hart_index_bits =3D __fls(*nr_parent_irqs);
> -               if (BIT(global->hart_index_bits) < *nr_parent_irqs)
> -                       global->hart_index_bits++;
> -       }
> -
> -       /* Find number of group index bits */
> -       rc =3D of_property_read_u32(to_of_node(fwnode), "riscv,group-inde=
x-bits",
> -                                 &global->group_index_bits);
> -       if (rc)
> -               global->group_index_bits =3D 0;
> -
> -       /*
> -        * Find first bit position of group index.
> -        * If not specified assumed the default APLIC-IMSIC configuration=
.
> -        */
> -       rc =3D of_property_read_u32(to_of_node(fwnode), "riscv,group-inde=
x-shift",
> -                                 &global->group_index_shift);
> -       if (rc)
> -               global->group_index_shift =3D IMSIC_MMIO_PAGE_SHIFT * 2;
> -
> -       /* Find number of interrupt identities */
> -       rc =3D of_property_read_u32(to_of_node(fwnode), "riscv,num-ids",
> -                                 &global->nr_ids);
> -       if (rc) {
> -               pr_err("%pfwP: number of interrupt identities not found\n=
", fwnode);
>                 return rc;
> -       }
> -
> -       /* Find number of guest interrupt identities */
> -       rc =3D of_property_read_u32(to_of_node(fwnode), "riscv,num-guest-=
ids",
> -                                 &global->nr_guest_ids);
> -       if (rc)
> -               global->nr_guest_ids =3D global->nr_ids;
>
>         /* Sanity check guest index bits */
>         i =3D BITS_PER_LONG - IMSIC_MMIO_PAGE_SHIFT;
> --
> 2.43.0
>

