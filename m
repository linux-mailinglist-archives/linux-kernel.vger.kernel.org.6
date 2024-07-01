Return-Path: <linux-kernel+bounces-235909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E91191DB24
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 11:11:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70C091C2196A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 09:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E85D86250;
	Mon,  1 Jul 2024 09:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="AKOHCuGM"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53DD85654
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 09:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719825048; cv=none; b=JmJD1JtqVDiI2KYXURHgJAhjuotZ8GY1xXvjFx0kYarzpjCmEULKjxatFbN2JrikdnJVdURclsoROIqmv64EOZtJUTscBwZDxTRVrOSswVZnZrLt9/M0N5eEHDeCdmE7xb9uxnzE/Itut8VWSdgJ9lc7psSYCCDI3zKIVKunHP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719825048; c=relaxed/simple;
	bh=s6wUZFBzlnzCYz9OAO3FsO7lybksMejV2MvZlfsae3s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e96+LrhPGQvwy8SdWShuo0F/6EynhIZS6eBFHkW4MDf0X8dvP8Tsq/fBcpRhDAeHbGfxuE34Y9qQKQOVeGen1escjoxUAAXEt7he+uLP90eWs4o8FtEiJS7UJukSDnBfV8YOJKoegaZtI9jAPm7BvxbmiLSPo9X1H2a5MPh73zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=AKOHCuGM; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2c825f0b381so1458388a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 02:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1719825046; x=1720429846; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9VvOaQzlpnKiFlOfEz9Er17nO3pgB9yQmQ0QBuBPFt4=;
        b=AKOHCuGMfsIxvxv2OU4p9uJ5yUytHDvIi9QO32h+ZTOS6dNmdlgRKRhv+pkJKgpxmH
         wydpOIAqjs5lrNnrMVUJr5aHEvGY08ngawL+Lwl+999tm7F4pX6nhRPUPPtd7vqKGvx2
         4baNWrACULEhGiMqbVUMVjUFFwqPCjMLWQecJ47CShnLeh0ZGYnORCBnXwNQH38E5d4O
         9HVLyOWiY9LPSL+b3p30GI3/5QiNP07WTQCxvdHEmAqjqdl2j0wNuXpoz7TuKM75Cct7
         jvffk0Js/c+xfcqmY5l8k63T6cqfvdOJVaEhzKF4CaL1cjjR1hPqf8jnsw8jbqXGz0PK
         f18g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719825046; x=1720429846;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9VvOaQzlpnKiFlOfEz9Er17nO3pgB9yQmQ0QBuBPFt4=;
        b=p0lu/88PidwtoA1f+oqMWPInVg8983rIyFb1ex9wWMdwxx+L2oZI2a63IWQqmkyhBz
         W7DKzdS1t3oHWwsQRDMXBaJ7mtaU4s6HJHUyoDoq/EMgwXskz3pNwUI4fILQktaKLMnR
         vpbgAmgsInxSwSskVHMw7LDRYgyOvfqUWQiw12sgxwvVvi/wkh6CHMQsYznsOOCf1ECh
         +z3heoBJiw6O1bIo2Ah3sIynKB9YZ24Pa0nDtoT5NvmRhiSyr/xfb2HFnPmXtq0r0l0/
         ydKofsIOLom1kJSpBvtBddL5HF0laNKUEJU2ISEKk/vWQquiUOiwRpmI2vcFi0QEB9nL
         bUow==
X-Forwarded-Encrypted: i=1; AJvYcCXbjyawx7PJeAEqXhhcSeCDHjm9TYepnZCFRuqi0zf0JdGBtPK0PecVZ26P+lAXmCXhzM9P764qGC6FWUOS5B/XDOqEr1O3GKCIAAI2
X-Gm-Message-State: AOJu0Ywj0cycAWN3XITJa2hkjRHB1iTsn4d0mBjZGqxWMdqYLQbX0vvk
	DvD6mNNQsPjEiGNxEqLPKp5ywOHQI0KpVEl1qrNmnkq8cIaPQU2epsbf+eVzKOiY3YoVZ+4Vp+D
	fsze4yi8Jysj9PMlCrSbOt8hffjHPUh0cC8Lb4g==
X-Google-Smtp-Source: AGHT+IGwkj24vCYggigVErwYUWeLyyQPYaxqLK9M4dtT+l3m8GW14hK5AXbiZ8Timfu0ZgNDZaYV9PwlM36bnRlfo7g=
X-Received: by 2002:a17:90a:fa03:b0:2c8:ec4c:436 with SMTP id
 98e67ed59e1d1-2c93d767652mr2217306a91.33.1719825046205; Mon, 01 Jul 2024
 02:10:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240701072908.25503-1-luxu.kernel@bytedance.com>
 <20240701072908.25503-2-luxu.kernel@bytedance.com> <CAH2o1u7j6pXhWHL2rBZak6LeXxn_KUbQHjygRGQKuEfS_vmtkQ@mail.gmail.com>
In-Reply-To: <CAH2o1u7j6pXhWHL2rBZak6LeXxn_KUbQHjygRGQKuEfS_vmtkQ@mail.gmail.com>
From: Xu Lu <luxu.kernel@bytedance.com>
Date: Mon, 1 Jul 2024 17:10:35 +0800
Message-ID: <CAPYmKFtCzQOOsN7vutoY0MrthtvcGxBqRsbr4ZgMQsaY1CrXHQ@mail.gmail.com>
Subject: Re: [External] Re: [PATCH 1/1] iommu/riscv: Support sharing irq lines
 between iommu queues
To: Tomasz Jeznach <tjeznach@rivosinc.com>
Cc: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, 
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	apatel@ventanamicro.com, sunilvl@ventanamicro.com, iommu@lists.linux.dev, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux@rivosinc.com, baolu.lu@linux.intel.com, lihangjing@bytedance.com, 
	xieyongji@bytedance.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sorry for not describing it clearly.

Indeed, the hardware interrupt lines have be configured in
riscv_iommu_init_check().

What I mean is that virtual interrupts of irqs[iommu->irqs_count] to
irqs[RISCV_IOMMU_INTR_COUNT - 1] are not set, which will cause
riscv_iommu_queue_enable() fail:
       const unsigned int irq =3D
iommu->irqs[riscv_iommu_queue_vec(iommu, queue->qid)];
       rc =3D request_threaded_irq(irq, xxx);
       if (rc) {
                 queue->iommu =3D NULL;
                 return rc;
       }

The virtual irq of queue id 'q' should be the same as irqs[q %
iommu->irqs_count] as ICVEC is configured in the same way.

Regards,

Xu Lu

On Mon, Jul 1, 2024 at 4:47=E2=80=AFPM Tomasz Jeznach <tjeznach@rivosinc.co=
m> wrote:
>
> On Mon, Jul 1, 2024 at 9:29=E2=80=AFAM 'Xu Lu' via linux <linux@rivosinc.=
com> wrote:
> >
> > When the number of wired interrupt lines is less than the number of
> > iommu queues, we should assign one irq line for several queues and
> > configure csr icvec accordingly.
> >
>
> Is this case not already covered by the code in function
> riscv_iommu_init_check(), assigning cause to vector register (ICVEC)
> based on available interrupt vectors? Interrupt vector selection is
> based on accepted ICVEC configuration (see riscv_iommu_queue_vec()).
>
> Relevant code (patch 'Command and fault queue support'):
> iommu->icvec =3D FIELD_PREP(RISCV_IOMMU_ICVEC_FIV, 1 % iommu->irqs_count)=
 |
>        FIELD_PREP(RISCV_IOMMU_ICVEC_PIV, 2 % iommu->irqs_count) |
>        FIELD_PREP(RISCV_IOMMU_ICVEC_PMIV, 3 % iommu->irqs_count);
>
> Values in iommu->irqs[] should represent actual interrupts allocated
> for the device.
>
> Best,
> - Tomasz
>
> > Signed-off-by: Xu Lu <luxu.kernel@bytedance.com>
> > ---
> >  drivers/iommu/riscv/iommu-platform.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/drivers/iommu/riscv/iommu-platform.c b/drivers/iommu/riscv=
/iommu-platform.c
> > index da336863f152..1d0af1260d5b 100644
> > --- a/drivers/iommu/riscv/iommu-platform.c
> > +++ b/drivers/iommu/riscv/iommu-platform.c
> > @@ -60,6 +60,10 @@ static int riscv_iommu_platform_probe(struct platfor=
m_device *pdev)
> >         for (vec =3D 0; vec < iommu->irqs_count; vec++)
> >                 iommu->irqs[vec] =3D platform_get_irq(pdev, vec);
> >
> > +       for (vec =3D iommu->irqs_count; vec < RISCV_IOMMU_INTR_COUNT; v=
ec++)
> > +               iommu->irqs[vec] =3D platform_get_irq(pdev,
> > +                                                   (vec % iommu->irqs_=
count));
> > +
> >         /* Enable wire-signaled interrupts, fctl.WSI */
> >         if (!(iommu->fctl & RISCV_IOMMU_FCTL_WSI)) {
> >                 iommu->fctl |=3D RISCV_IOMMU_FCTL_WSI;
> > --
> > 2.20.1
> >
> > --
> > You received this message because you are subscribed to the Google Grou=
ps "linux" group.
> > To unsubscribe from this group and stop receiving emails from it, send =
an email to linux+unsubscribe@rivosinc.com.
> > To view this discussion on the web visit https://groups.google.com/a/ri=
vosinc.com/d/msgid/linux/20240701072908.25503-2-luxu.kernel%40bytedance.com=
.
> > For more options, visit https://groups.google.com/a/rivosinc.com/d/opto=
ut.

