Return-Path: <linux-kernel+bounces-439053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB6899EAA11
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 08:55:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C693A1888C25
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 07:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD6C113AD20;
	Tue, 10 Dec 2024 07:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="a9Ox3Fh+"
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064E0233123
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 07:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733817299; cv=none; b=cVSLkwlbgQLD5qzpqwO8oIPTauGVrSvndS+yxEtZHfu8uhdnCCZ/5TWEBhoxvO8sKuYSYq28TJa10g36rg/eZc5KC1e3J5iHEHyy2/zHVb/0sw2SVc4wDkzTFE/Lm8GeFrBtlib1PXjkE7rZkNGiUvG/Ewmqa7AyXR57Vz157Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733817299; c=relaxed/simple;
	bh=26cu36Y/aumavTKVnlTu8SUqS9rPkploIx7N5kO87RM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SmVg2gYJIHzNgo+Xzo9pCKmwVXhyQ7qX+PcKcrDmeMB7G9KkhLjeljxEMAQXCME9pCXizHiGUyy/b05TcEY8HSX9+JqGXtC0FkRJdYXoI75waWl1TvOZoxaLmFRcq6KVkNX8EhwGOm1AOgOQRnfoKxJ33ljelJCIFXZYwKTItM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=a9Ox3Fh+; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-29737adb604so2667908fac.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 23:54:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1733817296; x=1734422096; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WPQvSbygqgIrExnr2bcxHFawcj0mKCE45rlYtPqLVSE=;
        b=a9Ox3Fh++TvK4KE14lU5L1l2XBeCsz63i6s4X0ihEmqjpRL+pkn+eFMpxXqIaXoP90
         j5x+gGBZRociAsSwDARCVqgS1F2HV/wksRyIsrDqeUd4Mz1fNm3aGcVddYiDVkwAXItX
         gnv9+mB1bweSUR1PzK1AR1gGfWZ0nOw8D1PQUDgVieWAXODYTFtgvHFMzvWpGJMxp9hX
         mniatlcRup0RhwU0/XEL5mbuNKitY77hu99WrNAcCaDUmByx9P983f5P6DDcVsJ9tlTR
         pOnY7X1/oMFs2osxhvxlp/1R1GWkS4eSYQ5InvarHt/yYQhW7fTaOBBtY7bQfFyU11fa
         PmEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733817296; x=1734422096;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WPQvSbygqgIrExnr2bcxHFawcj0mKCE45rlYtPqLVSE=;
        b=VrXevfUKq6QgOV91AV8i8hBASJZoQ5McpmobvKAI3P1oMk7f4h1jyDFnrbR6C4S4kx
         jAP71JL5Ykvlwt/zM+3znC+XXUcClnB6y9/dWZgF2HfwPyswipy9M4dDlnXbZo/T54su
         dXVqd+AjC4NUrYoLhWaeDNoerS1hhaowGuh6RfDK+gjnFVQaelme3VwkX5Bd87Taxq4q
         NH/Yu7U1Q6bUC+OmZbJ03oKEOCJFNDWwhZy3WB7GkBi4RM/FNZr/SCzpIfGLC9STn+yY
         Bh96ZmIrPDFXrrWbsb50lzynypOAAZrT7Lu8q1cGzj7lXr7V2yxnXd8N0XZBS9M2hU+q
         8SqA==
X-Forwarded-Encrypted: i=1; AJvYcCVOMJON+IzIbqTaZiOMFE1d+4QA7Gb8vlaI0ewnQqV2/Khhucz7zYsQTjqd9JV7GtKB+oY1JItH7mm8Wes=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQ79H2hls5DUaJQq1J9V6cFK53pMFDlGDM6esTHa3nv7YSvhNz
	YGzKkTZgdlawrBSJFngy6D6RSwEdk/fw0UU89pOhTiCdCKCggSU6CmCicVSQrwrH8VGKjYSq425
	yPXF/n2aND161S/g8ypdnyEAKox1tDhr7Fn8YNA==
X-Gm-Gg: ASbGncuyMZB1TdaNueENx/nEvs2KruhkFBZvWJ9wU1YLhBPLp8T047EMY3I6WtAhMUc
	oycD/rmZJiTiQ3XBA13NW1XwcSPEMMyXsB0gVJg==
X-Google-Smtp-Source: AGHT+IEtSPr48pGU/X+eSQ59PgbAI2DXvJGXJO+Mwo2oW/aawM83bRTg9TYcK3/pr5ZgifHEYZHiB2LUsmyVyglKvrY=
X-Received: by 2002:a05:6870:f78a:b0:296:e88f:8f56 with SMTP id
 586e51a60fabf-29f7389c4e1mr14517090fac.26.1733817296059; Mon, 09 Dec 2024
 23:54:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240614142156.29420-1-zong.li@sifive.com> <20240614142156.29420-3-zong.li@sifive.com>
In-Reply-To: <20240614142156.29420-3-zong.li@sifive.com>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Tue, 10 Dec 2024 15:54:45 +0800
Message-ID: <CAEEQ3wmccVW0ApAxeGM97XS7BH3khuzRK=wAhg5En3BjEKNnvw@mail.gmail.com>
Subject: Re: [External] [RFC PATCH v2 02/10] iommu/riscv: support HPM and
 interrupt handling
To: Zong Li <zong.li@sifive.com>
Cc: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, 
	tjeznach@rivosinc.com, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, jgg@ziepe.ca, kevin.tian@intel.com, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-riscv@lists.infradead.org, luxu.kernel@bytedance.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Add Luxu in the loop.

On Fri, Jun 14, 2024 at 10:22=E2=80=AFPM Zong Li <zong.li@sifive.com> wrote=
:
>
> This patch initialize the pmu stuff and uninitialize it when driver
> removing. The interrupt handling is also provided, this handler need to
> be primary handler instead of thread function, because pt_regs is empty
> when threading the IRQ, but pt_regs is necessary by perf_event_overflow.
>
> Signed-off-by: Zong Li <zong.li@sifive.com>
> ---
>  drivers/iommu/riscv/iommu.c | 65 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 65 insertions(+)
>
> diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
> index 8b6a64c1ad8d..1716b2251f38 100644
> --- a/drivers/iommu/riscv/iommu.c
> +++ b/drivers/iommu/riscv/iommu.c
> @@ -540,6 +540,62 @@ static irqreturn_t riscv_iommu_fltq_process(int irq,=
 void *data)
>         return IRQ_HANDLED;
>  }
>
> +/*
> + * IOMMU Hardware performance monitor
> + */
> +
> +/* HPM interrupt primary handler */
> +static irqreturn_t riscv_iommu_hpm_irq_handler(int irq, void *dev_id)
> +{
> +       struct riscv_iommu_device *iommu =3D (struct riscv_iommu_device *=
)dev_id;
> +
> +       /* Process pmu irq */
> +       riscv_iommu_pmu_handle_irq(&iommu->pmu);
> +
> +       /* Clear performance monitoring interrupt pending */
> +       riscv_iommu_writel(iommu, RISCV_IOMMU_REG_IPSR, RISCV_IOMMU_IPSR_=
PMIP);
> +
> +       return IRQ_HANDLED;
> +}
> +
> +/* HPM initialization */
> +static int riscv_iommu_hpm_enable(struct riscv_iommu_device *iommu)
> +{
> +       int rc;
> +
> +       if (!(iommu->caps & RISCV_IOMMU_CAPABILITIES_HPM))
> +               return 0;
> +
> +       /*
> +        * pt_regs is empty when threading the IRQ, but pt_regs is necess=
ary
> +        * by perf_event_overflow. Use primary handler instead of thread
> +        * function for PM IRQ.
> +        *
> +        * Set the IRQF_ONESHOT flag because this IRQ might be shared wit=
h
> +        * other threaded IRQs by other queues.
> +        */
> +       rc =3D devm_request_irq(iommu->dev,
> +                             iommu->irqs[riscv_iommu_queue_vec(iommu, RI=
SCV_IOMMU_IPSR_PMIP)],
> +                             riscv_iommu_hpm_irq_handler, IRQF_ONESHOT |=
 IRQF_SHARED, NULL, iommu);
> +       if (rc)
> +               return rc;
> +
> +       return riscv_iommu_pmu_init(&iommu->pmu, iommu->reg, dev_name(iom=
mu->dev));
> +}
> +
> +/* HPM uninitialization */
> +static void riscv_iommu_hpm_disable(struct riscv_iommu_device *iommu)
> +{
> +       if (!(iommu->caps & RISCV_IOMMU_CAPABILITIES_HPM))
> +               return;
> +
> +       devm_free_irq(iommu->dev,
> +                     iommu->irqs[riscv_iommu_queue_vec(iommu, RISCV_IOMM=
U_IPSR_PMIP)],
> +                     iommu);
> +
> +       riscv_iommu_pmu_uninit(&iommu->pmu);
> +}
> +
>  /* Lookup and initialize device context info structure. */
>  static struct riscv_iommu_dc *riscv_iommu_get_dc(struct riscv_iommu_devi=
ce *iommu,
>                                                  unsigned int devid)
> @@ -1612,6 +1668,9 @@ void riscv_iommu_remove(struct riscv_iommu_device *=
iommu)
>         riscv_iommu_iodir_set_mode(iommu, RISCV_IOMMU_DDTP_IOMMU_MODE_OFF=
);
>         riscv_iommu_queue_disable(&iommu->cmdq);
>         riscv_iommu_queue_disable(&iommu->fltq);
> +
> +       if (iommu->caps & RISCV_IOMMU_CAPABILITIES_HPM)
> +               riscv_iommu_pmu_uninit(&iommu->pmu);
>  }
>
>  int riscv_iommu_init(struct riscv_iommu_device *iommu)
> @@ -1651,6 +1710,10 @@ int riscv_iommu_init(struct riscv_iommu_device *io=
mmu)
>         if (rc)
>                 goto err_queue_disable;
>
> +       rc =3D riscv_iommu_hpm_enable(iommu);
> +       if (rc)
> +               goto err_hpm_disable;
> +
>         rc =3D iommu_device_sysfs_add(&iommu->iommu, NULL, NULL, "riscv-i=
ommu@%s",
>                                     dev_name(iommu->dev));
>         if (rc) {
> @@ -1669,6 +1732,8 @@ int riscv_iommu_init(struct riscv_iommu_device *iom=
mu)
>  err_remove_sysfs:
>         iommu_device_sysfs_remove(&iommu->iommu);
>  err_iodir_off:
> +       riscv_iommu_hpm_disable(iommu);
> +err_hpm_disable:
>         riscv_iommu_iodir_set_mode(iommu, RISCV_IOMMU_DDTP_IOMMU_MODE_OFF=
);
>  err_queue_disable:
>         riscv_iommu_queue_disable(&iommu->fltq);
> --
> 2.17.1
>
>

Thanks,
Yunhui

