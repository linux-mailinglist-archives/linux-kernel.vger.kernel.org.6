Return-Path: <linux-kernel+bounces-444271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D9339F03DB
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 05:38:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCC3E1884EA7
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 04:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 842BD1822F8;
	Fri, 13 Dec 2024 04:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b="ZBxSKSuE"
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2855166F1A
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 04:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734064684; cv=none; b=X2DmJDvlWewkJzpMb9oBwJ3kUhanBCMi0d3RLzXxXiKv3P2IxV71Qholeic17c9Syjty6dQIRhvUk3k6qfmc9KvTBzZ/uZSpjfWWhw0M0JUKRlWBTqoGgUqS2XQJum6gFhY21F0RkC1rYG+t4zfZys65PUi8Oy7lvJjF/HgSgiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734064684; c=relaxed/simple;
	bh=GVgXu4A3zASfuRz7mMyfcROq9TZkNBgnJ+YD5t4en8A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gvV9hmVk7wIID8nJCJ1VgEzsglYWfjQBlvBu26n3YyLWQB5kFbMRpTheULEPLjb/Ev3Fv4jZ6jtINjiWmt/2D4T6a6X857iX2BescseH8Or7vg/GpVAC/qu1FdQ4QDgBPTJaJo5NOciulntWQtjB9I6az6NbmWY2t4xrmNXc7rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org; spf=pass smtp.mailfrom=endlessos.org; dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b=ZBxSKSuE; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endlessos.org
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-6efc58fae20so12443917b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 20:38:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessos.org; s=google; t=1734064680; x=1734669480; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CA0VTqFeX4vfwfePnuPtsMQ981tGJ5bnrr7HfndGMDA=;
        b=ZBxSKSuE3RHyAOX9WaUrgcJYn5f0iE/1jU9tHa385Vw33USPmfFHpZ0Dl4C4B5cju/
         EriNXPP6yRKQss8dgqDWKc7G/C2YDNGQeaoHBfc4OssZXupqSz0+p8+zId/U1FgQ0PUO
         71nVfrXKEYaJUwxuXKb4qBaXGuDN5htTBix/yNPnSvKyeR87xQ1DDO11Pq/s2AGU3PWM
         koOuuD0bdQUzRmsZb67GM7k4iFvgIUWyjLjY44iSVnbGkg1MGjMLGOSddZbFNVHT+9TZ
         qG6W0HMWjZ8+1J4SCNSaopoPcIClhaYMLcDOyPheXSCvxzSzwCBalauv9WJUCrD71FUx
         +uHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734064680; x=1734669480;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CA0VTqFeX4vfwfePnuPtsMQ981tGJ5bnrr7HfndGMDA=;
        b=YAcsTnyQSVGN9jQIpQ4vCPaCRv1qleXsR8zuECriy/Yy5t25XWTQJuyMMQ3ZlCO3TY
         HvyH4AHMqyRtoiJUhFmgLhCeC2xgHClarYm19FIz1WTuec2USjxzXPIjsvfQWOpw0Tnp
         +c8J4WO0cga61nt1cfOdly5K6ox2Vqf3wQhFl0CC6cGQqh4PzKcBZA9GfFJd6n/JFjQ+
         o8lrgjpjjwOifcojptxQPUpaybbCDywvXmlaJ5BhQkg4oaueKwZJXs7fI4GEa/5WTZ+h
         WxKUc2RkJuw8kaLN8PjZI9jf3P2PEdmMtcSU58F41plhG58QnqG1amUybxBBpPHIMRrf
         Ohaw==
X-Forwarded-Encrypted: i=1; AJvYcCVdnUjEohYY3GfpoEwa3Fv5kCGYHOnrnDnnC+xAYeCGkvc2cCYR6HaLlcvEloYxHtXEVynlpFiJQvRLvmk=@vger.kernel.org
X-Gm-Message-State: AOJu0YygcmoBXGWHwiDHJHY2eWPfXmazLGCEZKkl/dHemjpFiYXNsyno
	GHytZlNGtU8sLOBef8bC1opmiayjFPxGeP4My7cCBecejTB3i9Eerfc9wogglur0OYyXT0SaoYG
	jCym3KZBX6JaMgYSu6oiC3DYl4q3krzspvP6ynw==
X-Gm-Gg: ASbGncuaM/hDjT8zE1wt2mpiDiTD7SyEc947nuuWnjBHDPBcLBdYpjGqe5VyZYXchCV
	siyFCnYLQn3YY1GoxBK//+YsjGQuWKqbpo8y3oQ==
X-Google-Smtp-Source: AGHT+IHbH63ESaEqwIP/PH2guFIwaDf91nGUtlEaO6s/N+vuTmmeMnoA6MXg8WxKC8sCCjMLJi7yBD5jbJKYj+SbYVc=
X-Received: by 2002:a05:6902:2213:b0:e38:8e02:1f13 with SMTP id
 3f1490d57ef6-e4348f184e8mr1243306276.10.1734064680440; Thu, 12 Dec 2024
 20:38:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241115072200.37509-3-jhp@endlessos.org> <20241212230340.GA3267194@bhelgaas>
In-Reply-To: <20241212230340.GA3267194@bhelgaas>
From: Jian-Hong Pan <jhp@endlessos.org>
Date: Fri, 13 Dec 2024 12:37:24 +0800
Message-ID: <CAPpJ_eeHbQBtNK=0rJG-jzU-jZ=Tc1RknwrQgsFgEjr1qTqyqg@mail.gmail.com>
Subject: Re: [PATCH v13] PCI/ASPM: Make pci_save_aspm_l1ss_state save both
 child and parent's L1SS configuration
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, 
	Nirmal Patel <nirmal.patel@linux.intel.com>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux@endlessos.org, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	"David E. Box" <david.e.box@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Bjorn Helgaas <helgaas@kernel.org> =E6=96=BC 2024=E5=B9=B412=E6=9C=8813=E6=
=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8A=E5=8D=887:03=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Fri, Nov 15, 2024 at 03:22:02PM +0800, Jian-Hong Pan wrote:
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
sor PCIe Controller [8086:9a09] (rev 01) (prog-if 00 [Normal decode])
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
ue SN550 NVMe SSD [15b7:5009] (rev 01) (prog-if 02 [NVM Express])
> >   ...
> >   Capabilities: [900 v1] L1 PM Substates
> >     L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1- L1_PM_Sub=
states+
> >       PortCommonModeRestoreTime=3D32us PortTPowerOnTime=3D10us
> >     L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1-
> >       T_CommonMode=3D0us LTR1.2_Threshold=3D101376ns
> >     L1SubCtl2: T_PwrOn=3D50us
> >
> >
> > Here is VMD mapped PCI device tree:
> >
> > -+-[0000:00]-+-00.0  Intel Corporation Device 9a04
> >  | ...
> >  \-[10000:e0]-+-06.0-[e1]----00.0  Sandisk Corp WD Blue SN550 NVMe SSD
> >               \-17.0  Intel Corporation Tiger Lake-LP SATA Controller
> >
> > When pci_reset_bus() resets the bus [e1] of the NVMe, it only saves and
> > restores NVMe's state before and after reset. Then, when it restores th=
e
> > NVMe's state, ASPM code restores L1SS for both the parent bridge and th=
e
> > NVMe in pci_restore_aspm_l1ss_state(). The NVMe's L1SS is restored
> > correctly. But, the parent bridge's L1SS is restored with a wrong value=
 0x0
> > because the parent bridge's L1SS wasn't saved by pci_save_aspm_l1ss_sta=
te()
> > before reset.
>
> I think the important thing here is that currently
> pci_save_aspm_l1ss_state() saves only the child L1SS state, but
> pci_restore_aspm_l1ss_state() restores both parent and child, and the
> parent state is garbage.
>
> Obviously nothing specific to VMD or NVMe or SATA.
>
> > To avoid pci_restore_aspm_l1ss_state() restore wrong value to the paren=
t's
> > L1SS config like this example, make pci_save_aspm_l1ss_state() save the
> > parent's L1SS config, if the PCI device has a parent.
>
> I tried to simplify the commit log and the patch so it's a little more
> parallel with pci_restore_aspm_l1ss_state().  Please comment and test.
>
> Bjorn
>
> commit c93935e3ac92 ("PCI/ASPM: Save parent L1SS config in pci_save_aspm_=
l1ss_state()")
> Author: Jian-Hong Pan <jhp@endlessos.org>
> Date:   Fri Nov 15 15:22:02 2024 +0800
>
>     PCI/ASPM: Save parent L1SS config in pci_save_aspm_l1ss_state()
>
>     After 17423360a27a ("PCI/ASPM: Save L1 PM Substates Capability for
>     suspend/resume"), pci_save_aspm_l1ss_state(dev) saves the L1SS state =
for
>     "dev", and pci_restore_aspm_l1ss_state(dev) restores the state for bo=
th
>     "dev" and its parent.
>
>     The problem is that unless pci_save_state() has been used in some oth=
er
>     path and has already saved the parent L1SS state, we will restore jun=
k to
>     the parent, which means the L1 Substates likely won't work correctly.
>
>     Save the L1SS config for both the device and its parent in
>     pci_save_aspm_l1ss_state().  When restoring, we need both because L1S=
S must
>     be enabled at the parent (the Downstream Port) before being enabled a=
t the
>     child (the Upstream Port).
>
>     Link: https://lore.kernel.org/r/20241115072200.37509-3-jhp@endlessos.=
org
>     Fixes: 17423360a27a ("PCI/ASPM: Save L1 PM Substates Capability for s=
uspend/resume")
>     Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D218394
>     Suggested-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
>     Signed-off-by: Jian-Hong Pan <jhp@endlessos.org>
>     [bhelgaas: parallel save/restore structure, simplify commit log]

Thanks for the simplification!
Tested on my Asus B1400CEAE. Both the "dev" (NVMe) and the parent (PCI
bridge) keep the correct L1SS config.

Tested-by: Jian-Hong Pan <jhp@endlessos.org>

> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index 28567d457613..e0bc90597dca 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -81,24 +81,47 @@ void pci_configure_aspm_l1ss(struct pci_dev *pdev)
>
>  void pci_save_aspm_l1ss_state(struct pci_dev *pdev)
>  {
> +       struct pci_dev *parent =3D pdev->bus->self;
>         struct pci_cap_saved_state *save_state;
> -       u16 l1ss =3D pdev->l1ss;
>         u32 *cap;
>
> +       /*
> +        * If this is a Downstream Port, we never restore the L1SS state
> +        * directly; we only restore it when we restore the state of the
> +        * Upstream Port below it.
> +        */
> +       if (pcie_downstream_port(pdev) || !parent)
> +               return;
> +
> +       if (!pdev->l1ss || !parent->l1ss)
> +               return;
> +
>         /*
>          * Save L1 substate configuration. The ASPM L0s/L1 configuration
>          * in PCI_EXP_LNKCTL_ASPMC is saved by pci_save_pcie_state().
>          */
> -       if (!l1ss)
> -               return;
> -
>         save_state =3D pci_find_saved_ext_cap(pdev, PCI_EXT_CAP_ID_L1SS);
>         if (!save_state)
>                 return;
>
>         cap =3D &save_state->cap.data[0];
> -       pci_read_config_dword(pdev, l1ss + PCI_L1SS_CTL2, cap++);
> -       pci_read_config_dword(pdev, l1ss + PCI_L1SS_CTL1, cap++);
> +       pci_read_config_dword(pdev, pdev->l1ss + PCI_L1SS_CTL2, cap++);
> +       pci_read_config_dword(pdev, pdev->l1ss + PCI_L1SS_CTL1, cap++);
> +
> +       if (parent->state_saved)
> +               return;
> +
> +       /*
> +        * Save parent's L1 substate configuration so we have it for
> +        * pci_restore_aspm_l1ss_state(pdev) to restore.
> +        */
> +       save_state =3D pci_find_saved_ext_cap(parent, PCI_EXT_CAP_ID_L1SS=
);
> +       if (!save_state)
> +               return;
> +
> +       cap =3D &save_state->cap.data[0];
> +       pci_read_config_dword(parent, parent->l1ss + PCI_L1SS_CTL2, cap++=
);
> +       pci_read_config_dword(parent, parent->l1ss + PCI_L1SS_CTL1, cap++=
);
>  }
>
>  void pci_restore_aspm_l1ss_state(struct pci_dev *pdev)

