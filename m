Return-Path: <linux-kernel+bounces-272300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28D1A9459D9
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 10:25:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4ACDF1C22930
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 08:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D35771C2312;
	Fri,  2 Aug 2024 08:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b="egWRJE7R"
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4E213FF6
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 08:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722587098; cv=none; b=M2K8Y1GMuFTVqS2ZwARsxonjgHk/V2h+chOjAsvEc7nGF1RXqRM1+ahGmlognf4B/Z96YfCrBGyQRCKlahReXhW20yyYwwiwKX/4gw5+mWhRjnjgmrIR2FAku/cVDuWMuD9McPC4iUat6qzVoEsmbm3Tts0RjXTegQqVhijVJvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722587098; c=relaxed/simple;
	bh=Z7B4ej6Mdj2+V0RtL74zqFZgEeI1PTkP8LnxQO89PYk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KdhVJqr2P6CW1GCRRuXmw3DiwzayXF64OVCNffRlDKTDGTA81B2jLZH388n7ItvqSwSKODYykvsnBMqv85FRtT+IwHcQZamDQe0NuLM4wqSb5+PA9gQHy6/KvEZKp1Hk93EsPc9LTxdt8TRFzLm358SXhgGs14/ORv0r7AN/84k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org; spf=pass smtp.mailfrom=endlessos.org; dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b=egWRJE7R; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endlessos.org
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e0885b4f1d5so6432366276.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2024 01:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessos.org; s=google; t=1722587094; x=1723191894; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AiVreYMKSzML2GjOpf0xHyyUDslaxEFhmmZabXtLDM0=;
        b=egWRJE7Rkbyb576pGvJFK+m4g0eXN9B79bWgElhZvmOHhz0+XfINr3EGYDp2Am0EMS
         t/Xav6iM4+Q7MP4iAXtUiyly7Hx+zVGufFdwcSVjlF3ZaD5XRWr+Oio4oOGL/1+cW08y
         CQcY8ukMlYHRxz53+Mqxty7tOt7YUe+lO2aGMkeM2US+gX270WxE1onS/HJsaPM2I1BY
         fC5h6ayusGVWQpleQqpfCd7o/FN4LYbw5+QKJgCV9+UpksfAezC9a8wRiYXLaYiQgZti
         2uYcIliUHgmqmjA54AjOecaCVN35RU2mSBRS1esLq+Edbote4B/5dl1eRhntmzB8oORM
         i/Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722587094; x=1723191894;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AiVreYMKSzML2GjOpf0xHyyUDslaxEFhmmZabXtLDM0=;
        b=iJLCpmPnvbtEfiXizkA/odz0pddcClgqbnJguhldNEXsMKCnFUEiWg6tNwrGU2DhKj
         0HGy7teDwhcg7ge/io9OsBxZJA66mx7j22Ysc5V3Uh7bIdHF1ElezIu9xelG0R0L7Z+L
         KWY4luvAPeYGTphiKtd8EK1Vzag0oU6koHbmsqSAyMqY2aA3v2VLaxaYPgh9B5IAQvZt
         VXXhLDFBEbQWO5UIFWeEYBExZSStIDTFM0G36BykdQd3cCKRMLhSZKVPtPJTZuUkTPXc
         wn1wugOi4cD/sOTjX0/AN4amgiZ2VxmM5N+qgHf4iVNR4efIbh65ExBiZg64P1Je3NUE
         ao+g==
X-Forwarded-Encrypted: i=1; AJvYcCVL2na0lEO4LzuQdXUtyA2Sodndnry+P4QzGn0wms8ubf3ac8hggySL/d9CL/dgZVrJ1V565WldGjNbz4qpIaBOofMJvtXDoVOaedC4
X-Gm-Message-State: AOJu0Yx9nVBQAX9fcrI3krLlBwyQo+PFwF7NfstQj+mJlUaPb3DurIyE
	8GD27bAGyzi5Zd3eg4kRx6krkmXANOihMkbHYK2VOe62FdmbEuMC+UN9nC2a6rukQM3zT8JIvYY
	War860u6oGD4jWAI3lw2nQRQiMUcWh261SkdjwQ==
X-Google-Smtp-Source: AGHT+IFIESiJEeEBTmmXQg27WfjMc+QvxNvI7xxd/zoyTg5h71etytPKHyRbnw2Zm4xe8fT6eIxxkkMgmg8pVXO8q4s=
X-Received: by 2002:a05:6902:20c8:b0:e0b:d7da:ae01 with SMTP id
 3f1490d57ef6-e0bde2c191emr3325333276.5.1722587094502; Fri, 02 Aug 2024
 01:24:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240719075200.10717-2-jhp@endlessos.org> <20240719080255.10998-2-jhp@endlessos.org>
In-Reply-To: <20240719080255.10998-2-jhp@endlessos.org>
From: Jian-Hong Pan <jhp@endlessos.org>
Date: Fri, 2 Aug 2024 16:24:18 +0800
Message-ID: <CAPpJ_edybLMtrN_gxP2h9Z-BuYH+RG-qRqMqgZM1oSVoW1sP5A@mail.gmail.com>
Subject: Re: [PATCH v8 4/4] PCI/ASPM: Fix L1.2 parameters when enable link state
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Johan Hovold <johan@kernel.org>, David Box <david.e.box@linux.intel.com>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, Damien Le Moal <dlemoal@kernel.org>, 
	Nirmal Patel <nirmal.patel@linux.intel.com>, 
	Jonathan Derrick <jonathan.derrick@linux.dev>, 
	Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux@endlessos.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Jian-Hong Pan <jhp@endlessos.org> =E6=96=BC 2024=E5=B9=B47=E6=9C=8819=E6=97=
=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=884:04=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Currently, when enable link's L1.2 features with __pci_enable_link_state(=
),
> it configs the link directly without ensuring related L1.2 parameters, su=
ch
> as T_POWER_ON, Common_Mode_Restore_Time, and LTR_L1.2_THRESHOLD have been
> programmed.
>
> This leads the link's L1.2 between PCIe Root Port and child device gets
> wrong configs when a caller tries to enabled it.
>
> Here is a failed example on ASUS B1400CEAE with enabled VMD:
>
> 10000:e0:06.0 PCI bridge: Intel Corporation 11th Gen Core Processor PCIe =
Controller (rev 01) (prog-if 00 [Normal decode])
>     ...
>     Capabilities: [200 v1] L1 PM Substates
>         L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L1_PM_S=
ubstates+
>                   PortCommonModeRestoreTime=3D45us PortTPowerOnTime=3D50u=
s
>         L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1-
>                    T_CommonMode=3D45us LTR1.2_Threshold=3D101376ns
>         L1SubCtl2: T_PwrOn=3D50us
>
> 10000:e1:00.0 Non-Volatile memory controller: Sandisk Corp WD Blue SN550 =
NVMe SSD (rev 01) (prog-if 02 [NVM Express])
>     ...
>     Capabilities: [900 v1] L1 PM Substates
>         L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1- L1_PM_S=
ubstates+
>                   PortCommonModeRestoreTime=3D32us PortTPowerOnTime=3D10u=
s
>         L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1-
>                    T_CommonMode=3D0us LTR1.2_Threshold=3D0ns
>         L1SubCtl2: T_PwrOn=3D10us
>
> According to "PCIe r6.0, sec 5.5.4", before enabling ASPM L1.2 on the PCI=
e
> Root Port and the child NVMe, they should be programmed with the same
> LTR1.2_Threshold value. However, they have different values in this case.
>
> Invoke aspm_calc_l12_info() to program the L1.2 parameters properly befor=
e
> enable L1.2 bits of L1 PM Substates Control Register in
> __pci_enable_link_state().
>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D218394
> Signed-off-by: Jian-Hong Pan <jhp@endlessos.org>
> ---
> v2:
> - Prepare the PCIe LTR parameters before enable L1 Substates
>
> v3:
> - Only enable supported features for the L1 Substates part
>
> v4:
> - Focus on fixing L1.2 parameters, instead of re-initializing whole L1SS
>
> v5:
> - Fix typo and commit message
> - Split introducing aspm_get_l1ss_cap() to "PCI/ASPM: Introduce
>   aspm_get_l1ss_cap()"
>
> v6:
> - Skipped
>
> v7:
> - Pick back and rebase on the new version kernel
> - Drop the link state flag check. And, always config link state's timing
>   parameters
>
> v8:
> - Because pcie_aspm_get_link() might return the link as NULL, move
>   getting the link's parent and child devices after check the link is
>   not NULL. This avoids NULL memory access.
>
>  drivers/pci/pcie/aspm.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index 5db1044c9895..55ff1d26fcea 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -1411,9 +1411,15 @@ EXPORT_SYMBOL(pci_disable_link_state);
>  static int __pci_enable_link_state(struct pci_dev *pdev, int state, bool=
 locked)
>  {
>         struct pcie_link_state *link =3D pcie_aspm_get_link(pdev);
> +       u32 parent_l1ss_cap, child_l1ss_cap;
> +       struct pci_dev *parent, *child;
>
>         if (!link)
>                 return -EINVAL;
> +
> +       parent =3D link->pdev;
> +       child =3D link->downstream;
> +
>         /*
>          * A driver requested that ASPM be enabled on this device, but
>          * if we don't have permission to manage ASPM (e.g., on ACPI
> @@ -1428,6 +1434,15 @@ static int __pci_enable_link_state(struct pci_dev =
*pdev, int state, bool locked)
>         if (!locked)
>                 down_read(&pci_bus_sem);
>         mutex_lock(&aspm_lock);
> +       /*
> +        * Ensure L1.2 parameters: Common_Mode_Restore_Times, T_POWER_ON =
and
> +        * LTR_L1.2_THRESHOLD are programmed properly before enable bits =
for
> +        * L1.2, per PCIe r6.0, sec 5.5.4.
> +        */
> +       parent_l1ss_cap =3D aspm_get_l1ss_cap(parent);
> +       child_l1ss_cap =3D aspm_get_l1ss_cap(child);
> +       aspm_calc_l12_info(link, parent_l1ss_cap, child_l1ss_cap);
> +
>         link->aspm_default =3D pci_calc_aspm_enable_mask(state);
>         pcie_config_aspm_link(link, policy_to_aspm_state(link));
>
> --
> 2.45.2
>

Hi Nirmal and Paul,

It will be great to have your review here.

I had tried to "set the threshold value in vmd_pm_enable_quirk()"
directly as Paul said [1].  However, it still needs to get the PCIe
link from the PCIe device to set the threshold value.
And, pci_enable_link_state_locked() gets the link. Then, it will be
great to calculate and programm L1 sub-states' parameters properly
before configuring the link's ASPM there.

[1]: https://lore.kernel.org/linux-kernel/20240624081108.10143-2-jhp@endles=
sos.org/T/#mc467498213fe1a6116985c04d714dae378976124

Jian-Hong Pan

