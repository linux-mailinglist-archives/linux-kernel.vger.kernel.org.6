Return-Path: <linux-kernel+bounces-277281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6275C949ECE
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 06:23:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85AE41C212F0
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 04:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13CAA191490;
	Wed,  7 Aug 2024 04:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b="EkggeDjq"
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD23D18FDAC
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 04:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723004627; cv=none; b=PE8PRkGOyolBB/eLqTItXIjYl/Tn7KehT7WmlFTrC1PU97f/gfjgenHz3eo8vWmKaxMitufXlD05Z3bGdDY8nnYOYCEuUGKvdf9pHTDBT5sqbxf1xoiFPJeFJXgPg7/K8tG5Fr57J1AUFUjCAzVym10f1njw169HYqOukQEEMEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723004627; c=relaxed/simple;
	bh=DF4YLkT2dkO0DglIRwHWPUhwg+ixGdpdsVWTjspnx/o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p/spSjHeB0PNvYsYIpBoWGOMwD6aL3xD8ydgrw5p3kpLZLoj+No3lBafPMqgfoasB37huBCAnznZeQV1qeEEW/+s30fuz+xXbjB5ISYwV4n1GGn1r5XraA9BJj4leD2z1Jg/GUNvS7O0cOswBfpILWybObQyw8UdjY5p/moBlGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org; spf=pass smtp.mailfrom=endlessos.org; dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b=EkggeDjq; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endlessos.org
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-664ccd158b0so13335607b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 21:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessos.org; s=google; t=1723004623; x=1723609423; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nvR20d9ERYh3Ig9cFYU+v14Ff7CSOV7+SjTSWjYgNGo=;
        b=EkggeDjqftvNw8dNN/QefH9ZaIW+1+dWAz2dZ45HEFTsABc6zVW0H7WflUh3lOIHz+
         P8YoQnzkaRHcv3ODiGzsSMNyDGtKBKh22Q9lePLHgQK0FQ+TXasCNMNgeVsdoGQb7lMq
         D1q0/K7MDtx0cO0sIYaQLzc5e8PQNKUygisoXjNjYfhBv1OKYNDXFQo9TqhxAhoScCIO
         zutSZVpqcUBZpogshwA6id+PvSBqzytLhcaWTD2GaTCNLGFSKSoGbwI9rtW9IdPpksDG
         OblBzwTSgR5MGo1sWbY5m2Zg1tOD8nIe8Y/aSCZyuVIPWp91E0Xv5DULoHsxYQ8k4osC
         011Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723004623; x=1723609423;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nvR20d9ERYh3Ig9cFYU+v14Ff7CSOV7+SjTSWjYgNGo=;
        b=IpbrfPrKuil2902KXv8QAAyD+C4fNlVt7I4J7kqMC2xJKJjofSSbiBOIhirmJ5ERte
         vL/v1F/UchGoEhUOgGnRhikCjiCh1Y7vXkJwvLnz9fQnyNbli+uMgcbqaILKG231psSP
         uPvG/ZFtGzMkmdii80+shP9gBOV1fD+8P/yFQHy3MPvFaEcyF0HEETuDvLB8cuxtq0/G
         /f9CUfug3ilGEBkV/e+dEXiTKyLyppr3htBv5MqjoW+JNgnJ5XwSbmEp1ho2I2TNkCHZ
         Lz0ElN4uIh6j+oY6Tspaxjxgv1bnVxWHkXOM+pSop+QLoEns/lLUMHgrAHCK2mtX6kTB
         vW5g==
X-Forwarded-Encrypted: i=1; AJvYcCWi955e8iyNtuBh+lpsAMU6rYRYC2X7aMT7BlZlqTHEBT1bgBQS6oZnQa0O0YIBpfuTGbzOX3pvCrFffc9U5+Klcw+/90w74znrsw6Z
X-Gm-Message-State: AOJu0Yz7GH2+eVzZF1cCGNiRUEMn3e/v702bpzZKGHwQTRooNPO7FEpM
	/498+z7bNaI/n8RFIeWeJXUnfEv8r9Z8JM7Q4iyhmvAMJ+RJ0US9uOr+Ewe9uV+HqN2dBN4v0/Y
	+L5QhOQJM7LfSx6YA7dfGSfDWua+J01h07StYVg==
X-Google-Smtp-Source: AGHT+IFvTpixASaAP4xWWgQqjnNaP7m3tey7jFG8JbB1XlcOznYi4oLBuRU+2Lnv87Umzp1CJIcF/1QlHwBKcKC6VuI=
X-Received: by 2002:a05:6902:2b0d:b0:e0b:4aa4:1704 with SMTP id
 3f1490d57ef6-e0bde2909f8mr21646461276.18.1723004622627; Tue, 06 Aug 2024
 21:23:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240719075200.10717-2-jhp@endlessos.org> <20240719080255.10998-2-jhp@endlessos.org>
 <CAPpJ_edybLMtrN_gxP2h9Z-BuYH+RG-qRqMqgZM1oSVoW1sP5A@mail.gmail.com> <20240805112456.00007cad@linux.intel.com>
In-Reply-To: <20240805112456.00007cad@linux.intel.com>
From: Jian-Hong Pan <jhp@endlessos.org>
Date: Wed, 7 Aug 2024 12:23:06 +0800
Message-ID: <CAPpJ_ecuWkFZoriVyQxXV3dn-pAxDus-8vVwFMdhjpS5H2cfpw@mail.gmail.com>
Subject: Re: [PATCH v8 4/4] PCI/ASPM: Fix L1.2 parameters when enable link state
To: Nirmal Patel <nirmal.patel@linux.intel.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Johan Hovold <johan@kernel.org>, 
	David Box <david.e.box@linux.intel.com>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, Damien Le Moal <dlemoal@kernel.org>, 
	Jonathan Derrick <jonathan.derrick@linux.dev>, 
	Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux@endlessos.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Nirmal Patel <nirmal.patel@linux.intel.com> =E6=96=BC 2024=E5=B9=B48=E6=9C=
=886=E6=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8A=E5=8D=882:25=E5=AF=AB=E9=81=93=
=EF=BC=9A
>
> On Fri, 2 Aug 2024 16:24:18 +0800
> Jian-Hong Pan <jhp@endlessos.org> wrote:
>
> > Jian-Hong Pan <jhp@endlessos.org> =E6=96=BC 2024=E5=B9=B47=E6=9C=8819=
=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=884:04=E5=AF=AB=E9=81=93=EF=BC=
=9A
> > >
> > > Currently, when enable link's L1.2 features with
> > > __pci_enable_link_state(), it configs the link directly without
> > > ensuring related L1.2 parameters, such as T_POWER_ON,
> > > Common_Mode_Restore_Time, and LTR_L1.2_THRESHOLD have been
> > > programmed.
> > >
> > > This leads the link's L1.2 between PCIe Root Port and child device
> > > gets wrong configs when a caller tries to enabled it.
> > >
> > > Here is a failed example on ASUS B1400CEAE with enabled VMD:
> > >
> > > 10000:e0:06.0 PCI bridge: Intel Corporation 11th Gen Core Processor
> > > PCIe Controller (rev 01) (prog-if 00 [Normal decode]) ...
> > >     Capabilities: [200 v1] L1 PM Substates
> > >         L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+
> > > L1_PM_Substates+ PortCommonModeRestoreTime=3D45us
> > > PortTPowerOnTime=3D50us L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1-
> > > ASPM_L1.2+ ASPM_L1.1- T_CommonMode=3D45us LTR1.2_Threshold=3D101376ns
> > >         L1SubCtl2: T_PwrOn=3D50us
> > >
> > > 10000:e1:00.0 Non-Volatile memory controller: Sandisk Corp WD Blue
> > > SN550 NVMe SSD (rev 01) (prog-if 02 [NVM Express]) ...
> > >     Capabilities: [900 v1] L1 PM Substates
> > >         L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1-
> > > L1_PM_Substates+ PortCommonModeRestoreTime=3D32us
> > > PortTPowerOnTime=3D10us L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1-
> > > ASPM_L1.2+ ASPM_L1.1- T_CommonMode=3D0us LTR1.2_Threshold=3D0ns
> > >         L1SubCtl2: T_PwrOn=3D10us
> > >
> > > According to "PCIe r6.0, sec 5.5.4", before enabling ASPM L1.2 on
> > > the PCIe Root Port and the child NVMe, they should be programmed
> > > with the same LTR1.2_Threshold value. However, they have different
> > > values in this case.
> > >
> > > Invoke aspm_calc_l12_info() to program the L1.2 parameters properly
> > > before enable L1.2 bits of L1 PM Substates Control Register in
> > > __pci_enable_link_state().
> > >
> > > Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D218394
> > > Signed-off-by: Jian-Hong Pan <jhp@endlessos.org>
> > > ---
> > > v2:
> > > - Prepare the PCIe LTR parameters before enable L1 Substates
> > >
> > > v3:
> > > - Only enable supported features for the L1 Substates part
> > >
> > > v4:
> > > - Focus on fixing L1.2 parameters, instead of re-initializing whole
> > > L1SS
> > >
> > > v5:
> > > - Fix typo and commit message
> > > - Split introducing aspm_get_l1ss_cap() to "PCI/ASPM: Introduce
> > >   aspm_get_l1ss_cap()"
> > >
> > > v6:
> > > - Skipped
> > >
> > > v7:
> > > - Pick back and rebase on the new version kernel
> > > - Drop the link state flag check. And, always config link state's
> > > timing parameters
> > >
> > > v8:
> > > - Because pcie_aspm_get_link() might return the link as NULL, move
> > >   getting the link's parent and child devices after check the link
> > > is not NULL. This avoids NULL memory access.
> > >
> > >  drivers/pci/pcie/aspm.c | 15 +++++++++++++++
> > >  1 file changed, 15 insertions(+)
> > >
> > > diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> > > index 5db1044c9895..55ff1d26fcea 100644
> > > --- a/drivers/pci/pcie/aspm.c
> > > +++ b/drivers/pci/pcie/aspm.c
> > > @@ -1411,9 +1411,15 @@ EXPORT_SYMBOL(pci_disable_link_state);
> > >  static int __pci_enable_link_state(struct pci_dev *pdev, int
> > > state, bool locked) {
> > >         struct pcie_link_state *link =3D pcie_aspm_get_link(pdev);
> > > +       u32 parent_l1ss_cap, child_l1ss_cap;
> > > +       struct pci_dev *parent, *child;
> > >
> > >         if (!link)
> > >                 return -EINVAL;
> > > +
> > > +       parent =3D link->pdev;
> > > +       child =3D link->downstream;
> > > +
> > >         /*
> > >          * A driver requested that ASPM be enabled on this device,
> > > but
> > >          * if we don't have permission to manage ASPM (e.g., on ACPI
> > > @@ -1428,6 +1434,15 @@ static int __pci_enable_link_state(struct
> > > pci_dev *pdev, int state, bool locked) if (!locked)
> > >                 down_read(&pci_bus_sem);
> > >         mutex_lock(&aspm_lock);
> > > +       /*
> > > +        * Ensure L1.2 parameters: Common_Mode_Restore_Times,
> > > T_POWER_ON and
> > > +        * LTR_L1.2_THRESHOLD are programmed properly before enable
> > > bits for
> > > +        * L1.2, per PCIe r6.0, sec 5.5.4.
> > > +        */
> > > +       parent_l1ss_cap =3D aspm_get_l1ss_cap(parent);
> > > +       child_l1ss_cap =3D aspm_get_l1ss_cap(child);
> > > +       aspm_calc_l12_info(link, parent_l1ss_cap, child_l1ss_cap);
> > > +
> > >         link->aspm_default =3D pci_calc_aspm_enable_mask(state);
> > >         pcie_config_aspm_link(link, policy_to_aspm_state(link));
> > >
> > > --
> > > 2.45.2
> > >
> >
> > Hi Nirmal and Paul,
> >
> > It will be great to have your review here.
> >
> > I had tried to "set the threshold value in vmd_pm_enable_quirk()"
> > directly as Paul said [1].  However, it still needs to get the PCIe
> > link from the PCIe device to set the threshold value.
> > And, pci_enable_link_state_locked() gets the link. Then, it will be
> > great to calculate and programm L1 sub-states' parameters properly
> > before configuring the link's ASPM there.
> >
> > [1]:
> > https://lore.kernel.org/linux-kernel/20240624081108.10143-2-jhp@endless=
os.org/T/#mc467498213fe1a6116985c04d714dae378976124
> >
> > Jian-Hong Pan
>
> Hi Jian-Hong Pan,
>
> I am not an LTR, ASPM expert, but this part looks good to me.
>
> Can you explain why you decided to move pci_enable_link_state_locked()
> call down to out_state_change in vmd.c?

The idea is setting all LTR related parameters before enabling the ASPM fea=
ture.

> Will it cause any issue if pci_find_ext_capability returns 0?

If pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_LTR) in
vmd_pm_enable_quirk() returns 0, then the device is not a PCIe device.

Then, it goes to:
...
pci_enable_link_state_locked()
  __pci_enable_link_state()

__pci_enable_link_state() uses pcie_aspm_get_link() to get the link
between the PCIe bridge and the PCIe device.  And,
pcie_aspm_get_link() returns the link as a barrier.  If
pcie_aspm_get_link() does not get the link, then the device is a PCIe
bridge, or not a PCIe device.  Because the link is NULL,
__pci_enable_link_state() returns with -EINVAL directly and will not
configure/enable ASPM things.

Jian-Hong Pan

