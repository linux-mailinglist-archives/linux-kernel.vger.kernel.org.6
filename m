Return-Path: <linux-kernel+bounces-364430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 520B299D493
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 18:25:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4557AB2549F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 16:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54B731B4F1E;
	Mon, 14 Oct 2024 16:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="EYDWeUIu"
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14FA728FC
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 16:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728923090; cv=none; b=pq19uzdszZdbW5tXYInXTndO0z8URV5A8r05FvZd1eQ1G9JOrjy0lx+fACJDpY7LT92fJQGVkhhxShGt4Ia974I+Z7oyhQLmOtOrPQdkUT2Jj5C5NiuhJEXGd6n8PBJ85MGPL/XgK189AqVH/6Gl5Whbt/gLeKXLSVrKlfIrASY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728923090; c=relaxed/simple;
	bh=7qk94Guv8LBFSYegmHwjOoEMP2PDG3o5wK0DA1GKGto=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YBUhpLBYL3lfS1wTYqgVr77KNcTDGZxAQ2p3+emPJ6UIVKi+JYrHJ9/75t/pTQuEGn6eVeKSwFd1bUiD2MnqBwsfYi6caKjjFLboWuBsg3zEqK2PpzpqfX9H6C4yV7s4k9GFrALVIsCE5i519qnUCyKqNeaC2BCxMvbcz4qACVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=EYDWeUIu; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3a3b463e9b0so9105505ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 09:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1728923088; x=1729527888; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dJn/xuiSxsczXZp7+7UAGdT6DhOFjqYt9pTtANxrEgQ=;
        b=EYDWeUIufbDJvOngMMsVg3uRiYyY+RoUSNof6uBpnrvsicw7ZsMSrTNIXYFXw2NJd3
         nlow1JX6f/s5PNc443REAYWoXlU7Mm1T3vK7PjA+Qpt4Vy8yTO6LpBWswB08DsXyvBFp
         hxmJZASTXbS/gCx1uKxQTowIhML/n0a2meBUe6bkwUsbhCNOA3UVXlIsUbgNwwxAacK4
         l/HVdT8qHdeMmIDDGzRtV7xeNVN6xNKN7pDMa1qe+fnwb8hGOiKr/HUTNM057vcxjWDl
         APKj5piXS1iFY/UOmQ+uQ/yZElBMcHITELQ3SKHZMODRPRshif1lWK47cC36MINa5qMA
         f5gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728923088; x=1729527888;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dJn/xuiSxsczXZp7+7UAGdT6DhOFjqYt9pTtANxrEgQ=;
        b=bX2n8JMSnkP3q1tF80i0g0w6Z8Jo80gQhzte5ygJ3m46qOHAvVwjXeMfBH4yhUT6Cy
         kGVCTTJBRMNdbghXKEFvuIzwoxQ4+5M/+F77kLwpKNuiqI4yDnyH2y8DHfc9dukHobeG
         oVNTAO8YplT95lMcrfiXiGSVRQL/xOq6B+9zgfb28TMVPGExmn0nbjaA4Murhbg3314Q
         YexrCtb4DvcK0Jp/b5lYICxxDVb0k3ZSQSPaOhzdclzEQLL9SgdpEEz//vgCPM8sLM2M
         XsNVMn3rV50blLjMmpMXQLG4fVzXyMZ+PlAic3t9g+UI0jfSb2GWws9SwvI8iFvwz5r7
         ay/w==
X-Forwarded-Encrypted: i=1; AJvYcCW9g43ylQN2zuMm0QvD2fLVUoogR48/P9aXmxo4o8QiofI9tsGdjlJuvLH9mmqSGMVSRd58uFb2V3X5zaw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWMXKlQyYt6lkXoUCJsrd1mOi+8iYlcKhleGlQnMAgI3L25kB2
	+Bm0KZfW45ti5JQGrM/89CCK4Wrm0qjQG9vs4PKrHw0tVy/Laf51i+/6oUy7x4lTAIveSyZu0JB
	qD4F8rbrQNuyLzhZ36F+IXtqCW6N9yJUlRniT3w==
X-Google-Smtp-Source: AGHT+IFV0VHvASCjoRM9a75NSJBiTm5im9fCEBfBFDcZ+2dk7xxJU9/OmuDjfiaRkKYfTG9qzDMF2vMyVR4n8GO9JFU=
X-Received: by 2002:a05:6e02:b2e:b0:39e:6e47:814d with SMTP id
 e9e14a558f8ab-3a3b5f1c0f0mr80933735ab.2.1728923088127; Mon, 14 Oct 2024
 09:24:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014065739.656959-1-sunilvl@ventanamicro.com>
In-Reply-To: <20241014065739.656959-1-sunilvl@ventanamicro.com>
From: Anup Patel <anup@brainfault.org>
Date: Mon, 14 Oct 2024 21:54:37 +0530
Message-ID: <CAAhSdy0yH=fn_2bhZUubkaNZb1RtQz1GTWMTgTyteA1j7ZiNLg@mail.gmail.com>
Subject: Re: [PATCH] irqchip/riscv-intc: Fix no-SMP boot with ACPI
To: Sunil V L <sunilvl@ventanamicro.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Thomas Gleixner <tglx@linutronix.de>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2024 at 12:27=E2=80=AFPM Sunil V L <sunilvl@ventanamicro.co=
m> wrote:
>
> When CONFIG_SMP is disabled, the static array rintc_acpi_data with size
> NR_CPUS will not be sufficient to hold all RINTC structures passed from
> the firmware. All RINTC structures are required to configure
> IMSIC/APLIC/PLIC properly irrespective of SMP in the OS. So, allocate
> dynamic memory based on the number of RINTC structures in MADT to fix
> this issue.
>
> Fixes: f8619b66bdb1 ("irqchip/riscv-intc: Add ACPI support for AIA")
> Reported-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>
> Closes: https://github.com/linux-riscv/linux-riscv/actions/runs/112809975=
11/job/31375229012
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup

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
>
>  static u32 nr_rintc;
> -static struct rintc_data *rintc_acpi_data[NR_CPUS];
> +static struct rintc_data **rintc_acpi_data;
>
>  #define for_each_matching_plic(_plic_id)                               \
>         unsigned int _plic;                                             \
> @@ -329,13 +329,30 @@ int acpi_rintc_get_imsic_mmio_info(u32 index, struc=
t resource *res)
>         return 0;
>  }
>
> +static int __init riscv_intc_acpi_match(union acpi_subtable_headers *hea=
der,
> +                                       const unsigned long end)
> +{
> +       return 0;
> +}
> +
>  static int __init riscv_intc_acpi_init(union acpi_subtable_headers *head=
er,
>                                        const unsigned long end)
>  {
>         struct acpi_madt_rintc *rintc;
>         struct fwnode_handle *fn;
> +       int count;
>         int rc;
>
> +       if (!rintc_acpi_data) {
> +               count =3D acpi_table_parse_madt(ACPI_MADT_TYPE_RINTC, ris=
cv_intc_acpi_match, 0);
> +               if (count <=3D 0)
> +                       return -EINVAL;
> +
> +               rintc_acpi_data =3D kcalloc(count, sizeof(*rintc_acpi_dat=
a), GFP_KERNEL);
> +               if (!rintc_acpi_data)
> +                       return -ENOMEM;
> +       }
> +
>         rintc =3D (struct acpi_madt_rintc *)header;
>         rintc_acpi_data[nr_rintc] =3D kzalloc(sizeof(*rintc_acpi_data[0])=
, GFP_KERNEL);
>         if (!rintc_acpi_data[nr_rintc])
> --
> 2.43.0
>

