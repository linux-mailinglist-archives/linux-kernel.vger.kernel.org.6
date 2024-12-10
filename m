Return-Path: <linux-kernel+bounces-439118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 744E59EAAFE
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 09:48:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8F1A28184E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 08:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D6712309B4;
	Tue, 10 Dec 2024 08:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="lMMIX/B9"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AED612DD88
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 08:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733820527; cv=none; b=GN2R8gKtOTWuBTzL7Vahw+vq1HFuEOw3TXIOYPOcfWy2Xat0hVuah6wSZsxs3PQN+alrCdubFcm79nT+6he+ycLZB7gjbCb3e1IzToVAUZjsF2lJvRcjaEub/L9dYO/lvlUybLXduNA3szQevyoUeIdKbbJmJOTcxvyy2EoFib8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733820527; c=relaxed/simple;
	bh=v6xc/l4hD48lWm3gti8CMAmjAPPSWSN9XeL2cEIB4hM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I3LkN7598NW0PvX8ZAIKlVibkPqnCGXA1VmjAmwVfbMqRpX3liNF6gMy7rKo7Yu76JQtHIF17vE38qTafBhuIPiKVe+Pvpoa489CLl6UNXksD5JlHIz5HgKxbqFGQgrI7pqYM1zS6J+ukENcKvuy/I35Byjc/MFgSEbGxuoCynM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=lMMIX/B9; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-725ec1fa493so1481599b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 00:48:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1733820525; x=1734425325; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4xdi3z9/CNbVcJitr9EduQ8bN9iyAWrkkGNI8Z3BdOU=;
        b=lMMIX/B9nsmGg3UJUktrHiZJfwlMuhrPz3HsS6ej29mLSqkzxC4HwGyCJV3cY8gho3
         6Kd0caCgGRqYfYFgjq0ED1LrwmdTwzzrRRrodHh4zhNSw8/o9qxifsyEBPEdmTzghvVa
         4HuE4nKSoLd1Zq4HtSFCY35i2hT7R2KpUzMUeztFPS+Pp4eUXq11FPiA1/o9KFFEJHvN
         ArZeER2iyqoUYcwpkZZw2UogW1h0N7yluOOjS2ePXd+eABiuBR1SRPXlmAa9rv4eJBqW
         QTS/K0wbvg7bzUU38wOvZBeTjtPX0jscgPMTG78CK1s7KfNehrj8ITOdYhYzQqPRW+GD
         63JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733820525; x=1734425325;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4xdi3z9/CNbVcJitr9EduQ8bN9iyAWrkkGNI8Z3BdOU=;
        b=KJnDroSdPvEsLiFKpeLiwOf797lFyZ/GObBXDbZCgHUdnWlBQp25EMahRc4sHl62um
         OuyyJ/F+6sI+KcLmSFvOnE9Htghd0myUq7Pj2dA4gzxEhMqycarj0pFNKRx7LeW6IllU
         EI/rmyMDGnHJZU9kv4m2EvZNGNGwAQv4/RQ/1Pl9qECuUIjMyohR2/iWBv8jxvGgaDCQ
         TbCtA5UGsuU0uzZ2OAkp2P1yMDM4K3Iyy9qjzbEuUdr/N1djqZb7h3tFsghfIXISBLsE
         ma3FX3u7ajAuFwa8qtBokD5h4eOzllzlztgkCI3Z4wOIg/yO3O2XFW+2h7vtWm8H29Zm
         jQKA==
X-Forwarded-Encrypted: i=1; AJvYcCV12grQFwNogg7UOmYZoF8sXH63wAIfFpC6mMyOaRoJF99nFaFO0lbBWYn0RhnjaOWjWbEoRiO6SPl2xNE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxp7A2sV7nKoaaxSOCyTxC3vG1EgMk8UUsyamFp//zppTm5BH+/
	mlFPVgBPG5w0yewyG3QiFWhd2bhWcRGw+vrHC82ZNQBA9o9mt90+1TJHYS8sO7TkUo612WZ144u
	h7/dIgl1XKJE355gHdvLaNnroD9wYyETmG09gpA==
X-Gm-Gg: ASbGncuGi9jGaeE7EmHbEZLrOuSvDZWqV9eTouwlu94H4PJiGUW5073Wo+AzXaUlk9D
	3Mns1zK9+bcr13JxmjJrYzP2W35c4n9KQa539d2mNg1gpeimO
X-Google-Smtp-Source: AGHT+IEeuMu8uXi3ZE16bp1ukXRs8K6CpNq5yl10CKIHFHI15DQEAFvQNF0rRvfgKbd84KwQSI2khPon70vuDsQN4WY=
X-Received: by 2002:a05:6a20:b598:b0:1e1:afa9:d38b with SMTP id
 adf61e73a8af0-1e1b1a79bf7mr6372667637.8.1733820525586; Tue, 10 Dec 2024
 00:48:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240614142156.29420-1-zong.li@sifive.com> <20240614142156.29420-3-zong.li@sifive.com>
 <CAEEQ3wmccVW0ApAxeGM97XS7BH3khuzRK=wAhg5En3BjEKNnvw@mail.gmail.com>
In-Reply-To: <CAEEQ3wmccVW0ApAxeGM97XS7BH3khuzRK=wAhg5En3BjEKNnvw@mail.gmail.com>
From: Xu Lu <luxu.kernel@bytedance.com>
Date: Tue, 10 Dec 2024 16:48:34 +0800
Message-ID: <CAPYmKFtHn+ggujCWeQoSaWPK-2G=-Om0DuCpFyf+ha+OXQfsnw@mail.gmail.com>
Subject: Re: [External] [RFC PATCH v2 02/10] iommu/riscv: support HPM and
 interrupt handling
To: yunhui cui <cuiyunhui@bytedance.com>
Cc: Zong Li <zong.li@sifive.com>, joro@8bytes.org, will@kernel.org, 
	robin.murphy@arm.com, tjeznach@rivosinc.com, paul.walmsley@sifive.com, 
	palmer@dabbelt.com, aou@eecs.berkeley.edu, jgg@ziepe.ca, kevin.tian@intel.com, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Zong Li,

Thanks for your job. We have tested your iommu pmu driver and have
some feedbacks.

1. Maybe it is better to clear ipsr.PMIP first and then handle the pmu
ovf irq in riscv_iommu_hpm_irq_handler(). Otherwise, if a new overflow
happens after the riscv_iommu_pmu_handle_irq() and before pmip clear,
we will drop it.

2. The period_left can be messed in riscv_iommu_pmu_update() as
riscv_iommu_pmu_get_counter() always return the whole register value
while bit 63 in hpmcycle actually indicates whether overflow happens
instead of current value. Maybe these two functions should be
implemented as:

static void riscv_iommu_pmu_set_counter(struct riscv_iommu_pmu *pmu, u32 id=
x,
                                        u64 value)
{
        void __iomem *addr =3D pmu->reg + RISCV_IOMMU_REG_IOHPMCYCLES;

        if (WARN_ON_ONCE(idx < 0 || idx > pmu->num_counters))
                return;

        if (idx =3D=3D 0)
                value =3D (value & ~RISCV_IOMMU_IOHPMCYCLES_OF) |
                        (readq(addr) & RISCV_IOMMU_IOHPMCYCLES_OF);

        writeq(FIELD_PREP(RISCV_IOMMU_IOHPMCTR_COUNTER, value), addr + idx =
* 8);
}

static u64 riscv_iommu_pmu_get_counter(struct riscv_iommu_pmu *pmu, u32 idx=
)
{
        void __iomem *addr =3D pmu->reg + RISCV_IOMMU_REG_IOHPMCYCLES;
        u64 value;

        if (WARN_ON_ONCE(idx < 0 || idx > pmu->num_counters))
                return -EINVAL;

        value =3D readq(addr + idx * 8);

        if (idx =3D=3D 0)
                return FIELD_GET(RISCV_IOMMU_IOHPMCYCLES_COUNTER, value);

        return FIELD_GET(RISCV_IOMMU_IOHPMCTR_COUNTER, value);
}

Please ignore me if these issues have already been discussed.

Best regards,

Xu Lu

On Tue, Dec 10, 2024 at 3:55=E2=80=AFPM yunhui cui <cuiyunhui@bytedance.com=
> wrote:
>
> Add Luxu in the loop.
>
> On Fri, Jun 14, 2024 at 10:22=E2=80=AFPM Zong Li <zong.li@sifive.com> wro=
te:
> >
> > This patch initialize the pmu stuff and uninitialize it when driver
> > removing. The interrupt handling is also provided, this handler need to
> > be primary handler instead of thread function, because pt_regs is empty
> > when threading the IRQ, but pt_regs is necessary by perf_event_overflow=
.
> >
> > Signed-off-by: Zong Li <zong.li@sifive.com>
> > ---
> >  drivers/iommu/riscv/iommu.c | 65 +++++++++++++++++++++++++++++++++++++
> >  1 file changed, 65 insertions(+)
> >
> > diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
> > index 8b6a64c1ad8d..1716b2251f38 100644
> > --- a/drivers/iommu/riscv/iommu.c
> > +++ b/drivers/iommu/riscv/iommu.c
> > @@ -540,6 +540,62 @@ static irqreturn_t riscv_iommu_fltq_process(int ir=
q, void *data)
> >         return IRQ_HANDLED;
> >  }
> >
> > +/*
> > + * IOMMU Hardware performance monitor
> > + */
> > +
> > +/* HPM interrupt primary handler */
> > +static irqreturn_t riscv_iommu_hpm_irq_handler(int irq, void *dev_id)
> > +{
> > +       struct riscv_iommu_device *iommu =3D (struct riscv_iommu_device=
 *)dev_id;
> > +
> > +       /* Process pmu irq */
> > +       riscv_iommu_pmu_handle_irq(&iommu->pmu);
> > +
> > +       /* Clear performance monitoring interrupt pending */
> > +       riscv_iommu_writel(iommu, RISCV_IOMMU_REG_IPSR, RISCV_IOMMU_IPS=
R_PMIP);
> > +
> > +       return IRQ_HANDLED;
> > +}
> > +
> > +/* HPM initialization */
> > +static int riscv_iommu_hpm_enable(struct riscv_iommu_device *iommu)
> > +{
> > +       int rc;
> > +
> > +       if (!(iommu->caps & RISCV_IOMMU_CAPABILITIES_HPM))
> > +               return 0;
> > +
> > +       /*
> > +        * pt_regs is empty when threading the IRQ, but pt_regs is nece=
ssary
> > +        * by perf_event_overflow. Use primary handler instead of threa=
d
> > +        * function for PM IRQ.
> > +        *
> > +        * Set the IRQF_ONESHOT flag because this IRQ might be shared w=
ith
> > +        * other threaded IRQs by other queues.
> > +        */
> > +       rc =3D devm_request_irq(iommu->dev,
> > +                             iommu->irqs[riscv_iommu_queue_vec(iommu, =
RISCV_IOMMU_IPSR_PMIP)],
> > +                             riscv_iommu_hpm_irq_handler, IRQF_ONESHOT=
 | IRQF_SHARED, NULL, iommu);
> > +       if (rc)
> > +               return rc;
> > +
> > +       return riscv_iommu_pmu_init(&iommu->pmu, iommu->reg, dev_name(i=
ommu->dev));
> > +}
> > +
> > +/* HPM uninitialization */
> > +static void riscv_iommu_hpm_disable(struct riscv_iommu_device *iommu)
> > +{
> > +       if (!(iommu->caps & RISCV_IOMMU_CAPABILITIES_HPM))
> > +               return;
> > +
> > +       devm_free_irq(iommu->dev,
> > +                     iommu->irqs[riscv_iommu_queue_vec(iommu, RISCV_IO=
MMU_IPSR_PMIP)],
> > +                     iommu);
> > +
> > +       riscv_iommu_pmu_uninit(&iommu->pmu);
> > +}
> > +
> >  /* Lookup and initialize device context info structure. */
> >  static struct riscv_iommu_dc *riscv_iommu_get_dc(struct riscv_iommu_de=
vice *iommu,
> >                                                  unsigned int devid)
> > @@ -1612,6 +1668,9 @@ void riscv_iommu_remove(struct riscv_iommu_device=
 *iommu)
> >         riscv_iommu_iodir_set_mode(iommu, RISCV_IOMMU_DDTP_IOMMU_MODE_O=
FF);
> >         riscv_iommu_queue_disable(&iommu->cmdq);
> >         riscv_iommu_queue_disable(&iommu->fltq);
> > +
> > +       if (iommu->caps & RISCV_IOMMU_CAPABILITIES_HPM)
> > +               riscv_iommu_pmu_uninit(&iommu->pmu);
> >  }
> >
> >  int riscv_iommu_init(struct riscv_iommu_device *iommu)
> > @@ -1651,6 +1710,10 @@ int riscv_iommu_init(struct riscv_iommu_device *=
iommu)
> >         if (rc)
> >                 goto err_queue_disable;
> >
> > +       rc =3D riscv_iommu_hpm_enable(iommu);
> > +       if (rc)
> > +               goto err_hpm_disable;
> > +
> >         rc =3D iommu_device_sysfs_add(&iommu->iommu, NULL, NULL, "riscv=
-iommu@%s",
> >                                     dev_name(iommu->dev));
> >         if (rc) {
> > @@ -1669,6 +1732,8 @@ int riscv_iommu_init(struct riscv_iommu_device *i=
ommu)
> >  err_remove_sysfs:
> >         iommu_device_sysfs_remove(&iommu->iommu);
> >  err_iodir_off:
> > +       riscv_iommu_hpm_disable(iommu);
> > +err_hpm_disable:
> >         riscv_iommu_iodir_set_mode(iommu, RISCV_IOMMU_DDTP_IOMMU_MODE_O=
FF);
> >  err_queue_disable:
> >         riscv_iommu_queue_disable(&iommu->fltq);
> > --
> > 2.17.1
> >
> >
>
> Thanks,
> Yunhui

