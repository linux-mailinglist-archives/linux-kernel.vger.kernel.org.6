Return-Path: <linux-kernel+bounces-339872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 16B8A986B9F
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 06:06:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7384AB22557
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 04:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03CAE178CD9;
	Thu, 26 Sep 2024 04:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b="ZnwupdFi"
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C576C1D5AC4
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 04:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727323558; cv=none; b=MUiIdCwlQyMREyJSdw69lPjLLFXU+ifQ/BO7if74tGW5JJx10BVONHTUdCBBtq0StQcY6U8ox8B0Ur8/eK235BrOl+BUqDp416R6GFnFBJpTB2OJqpXA+Jue7u7u0fdQNw7FQ5VCwhMCNB2i23uru8NGUg01qWvQ97511wtXmro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727323558; c=relaxed/simple;
	bh=tK1PKFLMbt8/bZWeqx/scs6exANximA1ySDDg7iz3Vc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kBX9KAC1mPu1fcGwbdDfuvItkODRh4UjUvcsk0vzBCRJ7h3eGAPVGOAOr8QitBA8plwXVu3443a2UncSV94nPyFjaNAtek4h//y3hqK/OMVGlb8qY/7EKv4cJJq7X1N7dovSDarJNyJjErDK2SlkYBDAgGek/MlORKgO09prG/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org; spf=pass smtp.mailfrom=endlessos.org; dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b=ZnwupdFi; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endlessos.org
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e25cf3c7278so134227276.3
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 21:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessos.org; s=google; t=1727323554; x=1727928354; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lBj0RtqfibKYtaiBh+LiZgD/91khbm+mN+YhtElggI4=;
        b=ZnwupdFiFsglbX6n5lT2gmDBnXkbGzrfREG1tSYxzj2ezpCkujA/W6NhOR4XmQx4ES
         GfQUdbibDCJJ7+BHAHtCjuWhVKKai9ZUy6a1GxvhiB3mhsAyEcVifHXigxyJ7JlmbIaA
         BDJXs6Eq0+YOyV44nx2XQe3Cw9pC8cRju61R823wF1+/hzVmrPbgwVeLHo0i5lpEjOuf
         FjhpXkSyhCebmFESGURuiHN3l2YDgIZIRkpe6IBGOr47/bzmsRMBqo14ikQO5R5xRcMi
         1YHJzoBZmLX20uZrC/PC7ETbtU3EYMq8PAjrldrHPdNHU2gLTw4aVH1t1GZ74anEjLHr
         5kDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727323554; x=1727928354;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lBj0RtqfibKYtaiBh+LiZgD/91khbm+mN+YhtElggI4=;
        b=lAf8EiViaTAVI7DWI13acTBB3I6omPRsccxbi/B0duoQXDM1BoSOAOSECzp2lNLiFT
         D9d8brUiE8aRfpfLxS71UaV+Sj0BITDh6hsb44f5MBH77/GRJ3u3NfyKnKwQiLh42Gf1
         cc5qbWgBVVnZpMNbzeoIFi/jrRTjKAz09yjqhVtsalKDIdXEDMV68h+bPrDPJTzPV4kB
         KHR45FtRIpEK85N++92U+5vBmCj5mMCA75wRg18OuxSZkq3qJNeO4xjDISUcMncOfoZF
         TJNORG9g2Tfo28LRKoz+dQH7flsT9URKCF6uEJRwfqb+2ixTL7sf8zjMK7uNvFnkLBCk
         jZgw==
X-Forwarded-Encrypted: i=1; AJvYcCU6PEyzzTbfXkJUNFLUEiWnrztdZWoxGvaYiC3gBUro5TV6uV1APqqgL7lXJgZ5JUKqAsTFusEcL3V4bQw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJGLV9hIvp0p3LjOqLilcWiDXt8q2v00fzv+vbLqR+gPSI8zCo
	wMVJuxK0q+9kKRfx3DhmtZxXRApK6PQHCh1jxJ6BjI2u6q9lEilwqEMvD4Y9q8TnlIUqhy+nEhR
	FmoQhYRlRXWCaf9UqIkIgdzo95kfeM4VdBPH1bQ==
X-Google-Smtp-Source: AGHT+IGGCSnUwZAvSXtNeO350nb+LI2U8w1breV+V6GDnRRZYOaYRp3mHv+hCY6l4pl6F+wQ1jq6k3Ks+NrfnERmgOA=
X-Received: by 2002:a05:6902:70d:b0:e20:287d:5ca5 with SMTP id
 3f1490d57ef6-e24d78234b7mr4294975276.2.1727323554530; Wed, 25 Sep 2024
 21:05:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240924070551.14976-2-jhp@endlessos.org> <20240924072858.15929-3-jhp@endlessos.org>
 <8050f9d4cb851fc301cc35b4fb5a839ff71fdcae.camel@linux.intel.com>
In-Reply-To: <8050f9d4cb851fc301cc35b4fb5a839ff71fdcae.camel@linux.intel.com>
From: Jian-Hong Pan <jhp@endlessos.org>
Date: Thu, 26 Sep 2024 12:05:18 +0800
Message-ID: <CAPpJ_ed09KJY9Gw2qGwOHdKFw4-BAMyG6jOyWHnV7brJutwfVw@mail.gmail.com>
Subject: Re: [PATCH v9 3/3] PCI: vmd: Save/restore PCIe bridge states
 before/after pci_reset_bus()
To: david.e.box@linux.intel.com
Cc: Bjorn Helgaas <helgaas@kernel.org>, Johan Hovold <johan@kernel.org>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, 
	Nirmal Patel <nirmal.patel@linux.intel.com>, 
	Jonathan Derrick <jonathan.derrick@linux.dev>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux@endlessos.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

David E. Box <david.e.box@linux.intel.com> =E6=96=BC 2024=E5=B9=B49=E6=9C=
=8826=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8A=E5=8D=8810:51=E5=AF=AB=E9=81=93=
=EF=BC=9A
>
> Hi Jian-Hong,
>
> On Tue, 2024-09-24 at 15:29 +0800, Jian-Hong Pan wrote:
> > PCI devices' parameters on the VMD bus have been programmed properly
> > originally. But, cleared after pci_reset_bus() and have not been restor=
ed
> > correctly. This leads the link's L1.2 between PCIe Root Port and child
> > device gets wrong configs.
> >
> > Here is a failed example on ASUS B1400CEAE with enabled VMD. Both PCIe
> > bridge and NVMe device should have the same LTR1.2_Threshold value.
> > However, they are configured as different values in this case:
> >
> > 10000:e0:06.0 PCI bridge [0604]: Intel Corporation 11th Gen Core Proces=
sor
> > PCIe Controller [8086:9a09] (rev 01) (prog-if 00 [Normal decode])
> >   ...
> >   Capabilities: [200 v1] L1 PM Substates
> >     L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L1_PM_Sub=
states+
> >       PortCommonModeRestoreTime=3D45us PortTPowerOnTime=3D50us
> >     L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1-
> >       T_CommonMode=3D0us LTR1.2_Threshold=3D0ns
> >     L1SubCtl2: T_PwrOn=3D0us
> >
> > 10000:e1:00.0 Non-Volatile memory controller [0108]: Sandisk Corp WD Bl=
ue
> > SN550 NVMe SSD [15b7:5009] (rev 01) (prog-if 02 [NVM Express])
> >   ...
> >   Capabilities: [900 v1] L1 PM Substates
> >     L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1- L1_PM_Sub=
states+
> >       PortCommonModeRestoreTime=3D32us PortTPowerOnTime=3D10us
> >     L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1-
> >       T_CommonMode=3D0us LTR1.2_Threshold=3D101376ns
> >     L1SubCtl2: T_PwrOn=3D50us
> >
> > Here is VMD mapped PCI device tree:
> >
> > -+-[0000:00]-+-00.0  Intel Corporation Device 9a04
> >  | ...
> >  \-[10000:e0]-+-06.0-[e1]----00.0  Sandisk Corp WD Blue SN550 NVMe SSD
> >               \-17.0  Intel Corporation Tiger Lake-LP SATA Controller
> >
> > When pci_reset_bus() resets the bus [e1] of the NVMe, it only saves and
> > restores NVMe's state before and after reset. Because bus [e1] has only=
 one
> > device: 10000:e1:00.0 NVMe. The PCIe bridge is missed. However, when it
> > restores the NVMe's state, it also restores the ASPM L1SS between the P=
CIe
> > bridge and the NVMe by pci_restore_aspm_l1ss_state(). The NVMe's L1SS i=
s
> > restored correctly. But, the PCIe bridge's L1SS is restored with the wr=
ong
> > value 0x0. Becuase, the PCIe bridge's state is not saved before reset.
> > That is why pci_restore_aspm_l1ss_state() gets the parent device (PCIe
> > bridge)'s saved state capability data and restores L1SS with value 0.
> >
> > So, save the PCIe bridge's state before pci_reset_bus(). Then, restore =
the
> > state after pci_reset_bus(). The restoring state also consumes the savi=
ng
> > state.
> >
> > Link: https://www.spinics.net/lists/linux-pci/msg159267.html
> > Signed-off-by: Jian-Hong Pan <jhp@endlessos.org>
> > ---
> > v9:
> > - Drop the v8 fix about drivers/pci/pcie/aspm.c. Use this in VMD instea=
d.
> >
> >  drivers/pci/controller/vmd.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.=
c
> > index 11870d1fc818..2820005165b4 100644
> > --- a/drivers/pci/controller/vmd.c
> > +++ b/drivers/pci/controller/vmd.c
> > @@ -938,9 +938,16 @@ static int vmd_enable_domain(struct vmd_dev *vmd,
> > unsigned long features)
> >               if (!list_empty(&child->devices)) {
> >                       dev =3D list_first_entry(&child->devices,
> >                                              struct pci_dev, bus_list);
>
> Newline here
> > +                     /* To avoid pci_reset_bus restore wrong ASPM L1SS
> > +                      * configuration due to missed saving parent devi=
ce's
> > +                      * states, save & restore the parent device's sta=
tes
> > +                      * as well.
> > +                      */
>
> No text on first line of comment.

Oops!  Thanks

>     /*
>      * To avoid pci_reset_bus restore wrong ASPM L1SS
>      * ...
>      */
>
> > +                     pci_save_state(dev->bus->self);
> >                       ret =3D pci_reset_bus(dev);
> >                       if (ret)
> >                               pci_warn(dev, "can't reset device: %d\n",
> > ret);
> > +                     pci_restore_state(dev->bus->self);
>
> I think Ilpo's point was that pci_save_aspm_l1ss_state() and
> pci_restore_aspm_l1ss_state() should be more symmetric. If
> pci_save_aspm_l1ss_state() is changed to also handle the state for the de=
vice
> and its parent in the same call, then no change is needed here. But that =
would
> only handle L1SS settings and not anything else that might need to be res=
tored
> after the bus reset. So I'm okay with it either way.

Yes, that made me think the whole day before I sent out this patch. I
do not know what is the best reset bus procedure, especially how other
drivers reset the bus.

If trace the code path:
pci_reset_bus()
  __pci_reset_bus()
    pci_bus_reset()
      pci_bus_save_and_disable_locked()

pci_bus_save_and_disable_locked()'s comment shows "Save and disable
devices from the top of the tree down while holding the @dev mutex
lock for the entire tree". I think that means the PCI(e) bridge should
save state first, then the following bus' devices. However, VMD resets
the child device (10000:e1:00.0 NVMe)'s bus first and only saves the
child device (10000:e1:00.0 NVMe)'s state. It does not visit the tree
from the top to down. So, it misses the PCIe bridge.  Therefore, I
make it save & restore its parent (10000:e0:06.0 PCIe bridge)'s state
as compensation.

Jian-Hong Pan

> >
> >                       break;
> >               }
>

