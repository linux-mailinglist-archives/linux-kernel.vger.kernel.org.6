Return-Path: <linux-kernel+bounces-312419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BC2A969663
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 10:00:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED1DD285B8D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 08:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0C3320011F;
	Tue,  3 Sep 2024 08:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lRf/EAFF"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 524191AB6C3
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 08:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725350443; cv=none; b=d9mm+3cfl1Z/8I+7egGKs+HHxOZ7HckHuz3ZVVx5qXFIICKYKcOqKHCkHOpiL9gYtNg1bhBBRu2l4t7xg4UrqWA7Z0sxrcKJjLubhFebOXrA6U/ThpzsnpxA+ez/hGRuQ+NQuRybYPHrTDgCx730WfzwJPoK1iP+r2zVJUWUm7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725350443; c=relaxed/simple;
	bh=G3LFCqnW5ftp4eKpOc1g4kJ6sXDL5+AieekjdM9CRH4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EGwiE7/PCBhlvdOU3l5+JWXP+sm8zj9g9Wjlwog9r8PExu5Xbfyn6+hUg8uDM/kXieYnU5QLyIoray76Vk+WIeFETHz5epQXzmeZad3Z9WdPPPjWFtqdKM/w04O7vzXzE8Rml+jEE+Up33aGDPlWsRd5m6UgLsLm/hDEQg4YGoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lRf/EAFF; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-20536dcc6e9so21975705ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 01:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725350441; x=1725955241; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=18ASbZOQ9JhYoxdtgi92lypeyO+a9bqFtCkBPLRDikc=;
        b=lRf/EAFFSDk2dCqCvKChBGbTGT3RNXH7owL23zohcPNkkk1zta6eCDOxMACQ/UYbFV
         M6Uy2s8HkHycWE6LdojWM6H768U8Cd21VrmQvq49U0NHXf5RQbEX/XeaoduQRTeF7Wig
         F6nhS+79Vbs4YvvtoNWRoDqP85+5n4sPNQbAWmG2lbeWv1z3CrUhxcme1w86scG3/5d4
         JBRYDRbtId77N3qO8iLvtYxkYTly60NFwqJFp/qzifYeWzFNVJQjASViY/UHa1KYPZ4d
         LrJSwJlrbuakLlNtpWqEwb+vHkBLeh13jAP187xWwAs1uu+ykW/V845C6CSg4/NUVSfy
         ZksQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725350441; x=1725955241;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=18ASbZOQ9JhYoxdtgi92lypeyO+a9bqFtCkBPLRDikc=;
        b=w7eSBAaEIzWEwmRxI928x+reZeG7tAwo+t+UbslKXr+CApxCkO439eok/thdNtW9um
         JYz4PneYcWnclmHCqhpdpy/0a4NKnC/gYLK50ff/P6PS14qOOO8+sg4OgcavObd8VTCV
         OH3DLdEv9gHXsBFGzINIXFHmh1sFyn9YY3m+326SdcXOhzfW7hE/COlVpo/zAZyG8UO6
         WNGvNDpwBdI7pfdEEvnmnNwdA4HngfuORLieMlIsVgrU40FwE7LknM43juiHGm4M6ARV
         no8sdQ1fAVUSZs6iLjYmfzUBEJf0HG6aUjeA27dMhAzFaPUFEA21wWRDAQWGpOLVG9ZG
         DOvA==
X-Forwarded-Encrypted: i=1; AJvYcCWr8e2LvbbLD8JXQ94oUeShdM9Vs0MqtZebWNE6I5ZvGvGjrKS9kBGhdFjpaDRN1QO7oxW14uKkKqrtVZA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0tvkjKYX4xSvlMiWhLBF357Y0AtZetlxhEdXXzkRnG4xg6hiu
	779e16R7mz2et6ZVwotJlFfp8alw6lrNp7TV8mEA3/DC4c1Rx2b/mBnj2PRYTA==
X-Google-Smtp-Source: AGHT+IGnm/2yMKT5h2zpwY5I2nInceLrlv2x0BkFUCQWwdd/dCRHX0Tra/Y36FH7UQNW+Uh2nmLZlA==
X-Received: by 2002:a17:902:7c94:b0:1fd:7097:af58 with SMTP id d9443c01a7336-2050c215b2amr126598555ad.11.1725350439089;
        Tue, 03 Sep 2024 01:00:39 -0700 (PDT)
Received: from thinkpad ([120.60.129.190])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20542d5d1b2sm48636275ad.36.2024.09.03.01.00.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 01:00:38 -0700 (PDT)
Date: Tue, 3 Sep 2024 13:30:23 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: nirmal.patel@linux.intel.com, jonathan.derrick@linux.dev,
	acelan.kao@canonical.com, lpieralisi@kernel.org, kw@linux.com,
	robh@kernel.org, bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: vmd: Delay interrupt handling on MTL VMD controller
Message-ID: <20240903080023.4stjjmcmeugdoydp@thinkpad>
References: <20240903025544.286223-1-kai.heng.feng@canonical.com>
 <20240903042852.v7ootuenihi5wjpn@thinkpad>
 <CAAd53p4EWEuu-V5hvOHtKZQxCJNf94+FOJT+_ryu0s2RpB1o-Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAd53p4EWEuu-V5hvOHtKZQxCJNf94+FOJT+_ryu0s2RpB1o-Q@mail.gmail.com>

On Tue, Sep 03, 2024 at 03:07:45PM +0800, Kai-Heng Feng wrote:
> On Tue, Sep 3, 2024 at 12:29 PM Manivannan Sadhasivam
> <manivannan.sadhasivam@linaro.org> wrote:
> >
> > On Tue, Sep 03, 2024 at 10:55:44AM +0800, Kai-Heng Feng wrote:
> > > Meteor Lake VMD has a bug that the IRQ raises before the DMA region is
> > > ready, so the requested IO is considered never completed:
> > > [   97.343423] nvme nvme0: I/O 259 QID 2 timeout, completion polled
> > > [   97.343446] nvme nvme0: I/O 384 QID 3 timeout, completion polled
> > > [   97.343459] nvme nvme0: I/O 320 QID 4 timeout, completion polled
> > > [   97.343470] nvme nvme0: I/O 707 QID 5 timeout, completion polled
> > >
> > > The is documented as erratum MTL016 [0]. The suggested workaround is to
> > > "The VMD MSI interrupt-handler should initially perform a dummy register
> > > read to the MSI initiator device prior to any writes to ensure proper
> > > PCIe ordering." which essentially is adding a delay before the interrupt
> > > handling.
> > >
> >
> > Why can't you add a dummy register read instead? Adding a delay for PCIe
> > ordering is not going to work always.
> 
> This can be done too. But it can take longer than 4us delay, so I'd
> like to keep it a bit faster here.
> 

No. As I said, this delay is not going to work all the time and highly
unreliable. Please use the register read as suggested.

- Mani

> >
> > > Hence add a delay before handle interrupt to workaround the erratum.
> > >
> > > [0] https://edc.intel.com/content/www/us/en/design/products/platforms/details/meteor-lake-u-p/core-ultra-processor-specification-update/errata-details/#MTL016
> > >
> > > Link: https://bugzilla.kernel.org/show_bug.cgi?id=217871
> > > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > > ---
> > >  drivers/pci/controller/vmd.c | 18 ++++++++++++++++--
> > >  1 file changed, 16 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> > > index a726de0af011..3433b3730f9c 100644
> > > --- a/drivers/pci/controller/vmd.c
> > > +++ b/drivers/pci/controller/vmd.c
> > > @@ -16,6 +16,7 @@
> > >  #include <linux/srcu.h>
> > >  #include <linux/rculist.h>
> > >  #include <linux/rcupdate.h>
> > > +#include <linux/delay.h>
> > >
> > >  #include <asm/irqdomain.h>
> > >
> > > @@ -74,6 +75,9 @@ enum vmd_features {
> > >        * proper power management of the SoC.
> > >        */
> > >       VMD_FEAT_BIOS_PM_QUIRK          = (1 << 5),
> > > +
> > > +     /* Erratum MTL016 */
> > > +     VMD_FEAT_INTERRUPT_QUIRK        = (1 << 6),
> > >  };
> > >
> > >  #define VMD_BIOS_PM_QUIRK_LTR        0x1003  /* 3145728 ns */
> > > @@ -90,6 +94,8 @@ static DEFINE_IDA(vmd_instance_ida);
> > >   */
> > >  static DEFINE_RAW_SPINLOCK(list_lock);
> > >
> > > +static bool interrupt_delay;
> > > +
> > >  /**
> > >   * struct vmd_irq - private data to map driver IRQ to the VMD shared vector
> > >   * @node:    list item for parent traversal.
> > > @@ -105,6 +111,7 @@ struct vmd_irq {
> > >       struct vmd_irq_list     *irq;
> > >       bool                    enabled;
> > >       unsigned int            virq;
> > > +     bool                    delay_irq;
> >
> > This is unused. Perhaps you wanted to use this instead of interrupt_delay?
> 
> This is leftover, will scratch this.
> 
> Kai-Heng
> 
> >
> > - Mani
> >
> > >  };
> > >
> > >  /**
> > > @@ -680,8 +687,11 @@ static irqreturn_t vmd_irq(int irq, void *data)
> > >       int idx;
> > >
> > >       idx = srcu_read_lock(&irqs->srcu);
> > > -     list_for_each_entry_rcu(vmdirq, &irqs->irq_list, node)
> > > +     list_for_each_entry_rcu(vmdirq, &irqs->irq_list, node) {
> > > +             if (interrupt_delay)
> > > +                     udelay(4);
> > >               generic_handle_irq(vmdirq->virq);
> > > +     }
> > >       srcu_read_unlock(&irqs->srcu, idx);
> > >
> > >       return IRQ_HANDLED;
> > > @@ -1015,6 +1025,9 @@ static int vmd_probe(struct pci_dev *dev, const struct pci_device_id *id)
> > >       if (features & VMD_FEAT_OFFSET_FIRST_VECTOR)
> > >               vmd->first_vec = 1;
> > >
> > > +     if (features & VMD_FEAT_INTERRUPT_QUIRK)
> > > +             interrupt_delay = true;
> > > +
> > >       spin_lock_init(&vmd->cfg_lock);
> > >       pci_set_drvdata(dev, vmd);
> > >       err = vmd_enable_domain(vmd, features);
> > > @@ -1106,7 +1119,8 @@ static const struct pci_device_id vmd_ids[] = {
> > >       {PCI_VDEVICE(INTEL, 0xa77f),
> > >               .driver_data = VMD_FEATS_CLIENT,},
> > >       {PCI_VDEVICE(INTEL, 0x7d0b),
> > > -             .driver_data = VMD_FEATS_CLIENT,},
> > > +             .driver_data = VMD_FEATS_CLIENT |
> > > +                            VMD_FEAT_INTERRUPT_QUIRK,},
> > >       {PCI_VDEVICE(INTEL, 0xad0b),
> > >               .driver_data = VMD_FEATS_CLIENT,},
> > >       {PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_VMD_9A0B),
> > > --
> > > 2.43.0
> > >
> >
> > --
> > மணிவண்ணன் சதாசிவம்

-- 
மணிவண்ணன் சதாசிவம்

