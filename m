Return-Path: <linux-kernel+bounces-228645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 373A891641A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 11:54:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3828284E2D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 09:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CD4714B940;
	Tue, 25 Jun 2024 09:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b="bpeeSqJe"
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D68314A0B5
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 09:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719309215; cv=none; b=sGuNEK83e6lUmjeXVIHvPdi9w5nroZ90BhfflQAnDvgqAZ6U96FEN7nME1KzIb8D8q2Xq0Z/LJdc9+iDH0wKWZGe18+t4rbUebY5F+QFXqIxzNeueM1pDBptVjfqaUGIFcNdG8eT8KCeD8rfHeDbcTPdOGKAn+KN/+cwKzyyORk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719309215; c=relaxed/simple;
	bh=ubR/H1KDCHv15kc/h4bzN7goNlGoi7nGu28lfBNp3Ts=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nSFOCRABhxkZN/9YgCq3SqygHHFiq9ooPpUk9vqjbYuE0YH3vU6zBg+y3SzHuX/dA+C/xKym3Q9KN5yIvmZZ6AJGKnhONVLOaCZMTOSwbadNY9znPOSMp1xpx/O2Y/TeejFFlIJrf15yEgdYKxCqHQ+OO7qJ9r3FWSPdZbFS9BA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org; spf=pass smtp.mailfrom=endlessos.org; dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b=bpeeSqJe; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endlessos.org
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-63b3a9ff064so49006547b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 02:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessos.org; s=google; t=1719309211; x=1719914011; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EihByteN8eLD7Off0+cCvYThY2zGPs4M5iPP7WdFRig=;
        b=bpeeSqJeQ8Hzivb6IONGfm5ATUEddu2vMP4yVC5YCiAnnPf27JBV6AY/M01YrIBF8Y
         9Hr++uVyO5zgXBsPTr2LtWQ4oCVJ5Bm7/jqSKRnOUGl0Rd9BSaiZ1GzUICAcwMUAt0KW
         ni/g9l8BaeIs6iXcPrmeqorPbekCZD2xVyNBewii5ZAQ5slZWwUYymzR9QV7Pk687RjO
         1efMNJNACKnzTFS2rS0+Umtw+Ny4icVU1abBPoPD9R/mB+lDHtZPBgVbdcGTNAAVngAW
         IB0H77jRV3W7HldaYthgkbzGQE/xPa1/cHRgkQvjT1aOFAqTAS7YBR47QV6ocIVY945f
         lMKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719309211; x=1719914011;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EihByteN8eLD7Off0+cCvYThY2zGPs4M5iPP7WdFRig=;
        b=masMyNRm/nvMOeIhydgpwOleBGFfN5UsSjl/85lDwOl1cOgcH187/VTwW2sAxJ5aAf
         Be6deOQUq5LNcPuLy953oY+0iobXj93PQ1wLNP5MLWLPA5StxdB23+/ZiCGtKqBc6oe0
         CKBz5/wT2LEusIF9a435X8DaLoUp6ONuUqzyv9LSrefrCGc/mrDPCLNK+GJO0jIC/ps6
         72Z1ytynXKZA/1kmdPSbimNVy8ow6T+hP4Y4Oq0QJ6pMAo0i9ViEuW7b/0CFySjmpjQu
         /pbGD/nPNCMJDTjaavZQsILXGznHwYQgqWan9gk/43B9TMXxWGpxVJpE48fcrOYZ5CDa
         EjCg==
X-Forwarded-Encrypted: i=1; AJvYcCWUhT2p/JxWBck3zcfVJO9tUGVrrXVtOFTT6GEXjY1dIIpNDAsSLG6QuLcavlByoLEF5yT48UHC/82hc5RDaZw7fivSTiG17TJIdcHZ
X-Gm-Message-State: AOJu0YxST27wcUjQ3V1hBJtlJUJbC46SOQGw15bzvbdlRd20Zz6o4S5l
	svNvTzkctZZeEF9oVRxLlzXssR5IZD1Jis0x4qHv9gouOf1h+La+ihtIlinAhUg7YsBIKs3cz/E
	higEoUyyc8iT1PLJ2Ue0+cXCccMnvZeTR8alpJw==
X-Google-Smtp-Source: AGHT+IFBvNR7MZObZFOvRvXTTt3kur5mv2a9F975t+24bwWHaJvhGsuWd44cQWKN/R/wtGYvxKswobQAqMrsxHtrU/4=
X-Received: by 2002:a25:c585:0:b0:dfa:6bfb:e19a with SMTP id
 3f1490d57ef6-e0303f753b3mr6901340276.39.1719309211199; Tue, 25 Jun 2024
 02:53:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240624081108.10143-2-jhp@endlessos.org> <20240624082144.10265-2-jhp@endlessos.org>
 <20240624082458.00006da1@linux.intel.com>
In-Reply-To: <20240624082458.00006da1@linux.intel.com>
From: Jian-Hong Pan <jhp@endlessos.org>
Date: Tue, 25 Jun 2024 17:52:55 +0800
Message-ID: <CAPpJ_ee5e-wwOGJ9z+AaXbpDUkN_zZt3Q_BLcZTztW8aHcPSfg@mail.gmail.com>
Subject: Re: [PATCH v6 3/3] PCI: vmd: Drop resetting PCI bus action after scan
 mapped PCI child bus
To: Nirmal Patel <nirmal.patel@linux.intel.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, 
	Francisco Munoz <francisco.munoz.ruiz@linux.intel.com>, Johan Hovold <johan@kernel.org>, 
	David Box <david.e.box@linux.intel.com>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, Damien Le Moal <dlemoal@kernel.org>, 
	Jonathan Derrick <jonathan.derrick@linux.dev>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux@endlessos.org, 
	Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Nirmal Patel <nirmal.patel@linux.intel.com> =E6=96=BC 2024=E5=B9=B46=E6=9C=
=8824=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=8811:25=E5=AF=AB=E9=81=93=
=EF=BC=9A
>
> On Mon, 24 Jun 2024 16:21:45 +0800
> Jian-Hong Pan <jhp@endlessos.org> wrote:
>
> > According to "PCIe r6.0, sec 5.5.4", before enabling ASPM L1.2 on the
> > PCIe Root Port and the child device, they should be programmed with
> > the same LTR1.2_Threshold value. However, they have different values
> > on VMD mapped PCI child bus. For example, Asus B1400CEAE's VMD mapped
> > PCI bridge and NVMe SSD controller have different LTR1.2_Threshold
> > values:
> >
> > 10000:e0:06.0 PCI bridge: Intel Corporation 11th Gen Core Processor
> > PCIe Controller (rev 01) (prog-if 00 [Normal decode]) ...
> >     Capabilities: [200 v1] L1 PM Substates
> >         L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+
> > L1_PM_Substates+ PortCommonModeRestoreTime=3D45us PortTPowerOnTime=3D50=
us
> >         L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1-
> >                  T_CommonMode=3D45us LTR1.2_Threshold=3D101376ns
> >         L1SubCtl2: T_PwrOn=3D50us
> >
> > 10000:e1:00.0 Non-Volatile memory controller: Sandisk Corp WD Blue
> > SN550 NVMe SSD (rev 01) (prog-if 02 [NVM Express]) ...
> >     Capabilities: [900 v1] L1 PM Substates
> >         L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1-
> > L1_PM_Substates+ PortCommonModeRestoreTime=3D32us PortTPowerOnTime=3D10=
us
> >         L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1-
> >                    T_CommonMode=3D0us LTR1.2_Threshold=3D0ns
> >         L1SubCtl2: T_PwrOn=3D10us
> >
> > After debug in detail, both of the VMD mapped PCI bridge and the NVMe
> > SSD controller have been configured properly with the same
> > LTR1.2_Threshold value. But, become misconfigured after reset the VMD
> > mapped PCI bus which is introduced from commit 0a584655ef89 ("PCI:
> > vmd: Fix secondary bus reset for Intel bridges") and commit
> > 6aab5622296b ("PCI: vmd: Clean up domain before enumeration"). So,
> > drop the resetting PCI bus action after scan VMD mapped PCI child bus.
> >
> > Signed-off-by: Jian-Hong Pan <jhp@endlessos.org>
> > ---
> > v6:
> > - Introduced based on the discussion
> > https://lore.kernel.org/linux-pci/CAPpJ_efYWWxGBopbSQHB=3DY2+1RrXFR2XWe=
qEhGTgdiw3XX0Jmw@mail.gmail.com/
> >
> >  drivers/pci/controller/vmd.c | 20 --------------------
> >  1 file changed, 20 deletions(-)
> >
> > diff --git a/drivers/pci/controller/vmd.c
> > b/drivers/pci/controller/vmd.c index 5309afbe31f9..af413cdb4f4e 100644
> > --- a/drivers/pci/controller/vmd.c
> > +++ b/drivers/pci/controller/vmd.c
> > @@ -793,7 +793,6 @@ static int vmd_enable_domain(struct vmd_dev *vmd,
> > unsigned long features) resource_size_t offset[2] =3D {0};
> >       resource_size_t membar2_offset =3D 0x2000;
> >       struct pci_bus *child;
> > -     struct pci_dev *dev;
> >       int ret;
> >
> >       /*
> > @@ -935,25 +934,6 @@ static int vmd_enable_domain(struct vmd_dev
> > *vmd, unsigned long features) pci_scan_child_bus(vmd->bus);
> >       vmd_domain_reset(vmd);
> >
> > -     /* When Intel VMD is enabled, the OS does not discover the
> > Root Ports
> > -      * owned by Intel VMD within the MMCFG space.
> > pci_reset_bus() applies
> > -      * a reset to the parent of the PCI device supplied as
> > argument. This
> > -      * is why we pass a child device, so the reset can be
> > triggered at
> > -      * the Intel bridge level and propagated to all the children
> > in the
> > -      * hierarchy.
> > -      */
> > -     list_for_each_entry(child, &vmd->bus->children, node) {
> > -             if (!list_empty(&child->devices)) {
> > -                     dev =3D list_first_entry(&child->devices,
> > -                                            struct pci_dev,
> > bus_list);
> > -                     ret =3D pci_reset_bus(dev);
> > -                     if (ret)
> > -                             pci_warn(dev, "can't reset device:
> > %d\n", ret); -
> > -                     break;
> > -             }
> > -     }
> > -
> >       pci_assign_unassigned_bus_resources(vmd->bus);
> >
> >       pci_walk_bus(vmd->bus, vmd_pm_enable_quirk, &features);
>
> Thanks for the patch.
>
> pci_reset_bus is required to avoid failure in vmd domain creation
> during multiple soft reboots test. So I believe we can't just remove
> it without proper testing. vmd_pm_enable_quirk happens after
> pci_reset_bus, then how is it resetting LTR1.2_Threshold value?

uh!  I mean that drop pci_reset_bus(dev) after pci_scan_child_bus(vmd->bus)
Not pci_walk_bus() with vmd_pm_enable_quirk.

Jian-Hong Pan


Jian-Hong Pan

