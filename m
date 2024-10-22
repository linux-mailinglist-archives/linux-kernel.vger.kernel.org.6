Return-Path: <linux-kernel+bounces-376291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E4079AA2C3
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 15:06:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0141FB231C7
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 13:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 907CA19DF81;
	Tue, 22 Oct 2024 13:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="U/Z4sZ2A"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C8219DF40
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 13:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729602365; cv=none; b=m+rV73IwHPppvi5q2pIJ+AWU92JVzhBWYSDF8DzEcu5G8amUWJSr5O7TaF9UZDviMcUyOefuDNlfFkQoYGVIyNgKHJF0xhNW5NwT4AYAwvl00Leygu4vGz4dphTttVAChMl/aYbkibuqOOROykmN+wezOdWOoPK0PNkcQGk72cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729602365; c=relaxed/simple;
	bh=eY7mpQBbU1G0VReE9nekoD13SERU82VMupF3O+8zGHQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mbh0oDvBDCeT+Ue2aYFPVUGVQquVjxzt9H15V1YTRVryf3xF/lz3ZeDX0mrZA6iLVIAcG1/bNVsl3oMbBfnykdbI6JbWUlu9e+Awly0lI+ronlleenFuVbQGl+es8v7IIdNeeDFjEMCerRB3N+rcD01S/wRX19RuGz5wKtOxssY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=U/Z4sZ2A; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com [209.85.128.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id EA60C3F201
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 13:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1729602354;
	bh=0O0WVESJ/gBslREDRe+kHvdq3pwvvgnmmFBLBmZkHXY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=U/Z4sZ2ApOTcuVp921bZ2gPikn0YI+EOS1Jh1N94+W80Wxn2RTR74gT7FxY18F6NZ
	 H57DvZsCch+eD7pQjzyNRfNO8gHaK3taBRUuVy+IfFtyluZL8s9j8Cz+SVrh/fzlL8
	 EWpugca6ZMQ2RvYHo2Os6QVfkX2AzK/+k5Lt4+i/V5cQ9+KzrR8BdEdKbc3UKsas7A
	 0leQ06Q2iPo1RMxoGFE1B/irkLWZiPeoGVZiusBtBmGWMeD32Qdwp2NF010ACXgpRG
	 mBg6YLqP85+s6UnFGxvwjRy8BfB2T4cINumYWLup/RDU9/GuDgDnxiswsGiGsdhOKj
	 bUFELfj7Opd+A==
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-6e376aa4586so105929267b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 06:05:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729602354; x=1730207154;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0O0WVESJ/gBslREDRe+kHvdq3pwvvgnmmFBLBmZkHXY=;
        b=C64veFcs0qitL7OgnERpPpDuAag7RGprl39us/Ab0Ohflfn8+gYCDZvDwcSz+rqZMl
         QPyibDxPFhVi7M0c1nYOFLg3n+aluh+GqZ5E2DIyCfDk7CnFcAFm0DY7/+m4vAk3quts
         QWVkHiqc40GdQvrf+T73V9lsfrjfzTiQf/RYuILDwIQ2mxjrNNh4lctyTCr57RvxqKuh
         Wmb/sw6lCz2Z0uxwFYaNAXQFqW26YAUoLeJBb2TlfLiAL8v28/mXNncOsAGpi3lhoTWD
         5aWPuagXf4g09oxn2EJ73kOyHvqiXG+i6nXGN3xtrQdb36SkIQGd0CG90sW+WHT6k766
         DA1Q==
X-Forwarded-Encrypted: i=1; AJvYcCWNdX7//tuIQa9JEDbEV6yktomV35d6bFjas42ZfZ7FHKQHMHYn2DcHTixF4g57joIzAWyKbX61ZNBPy2U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZiT5HMK74R3RjhuEMRe18pTB+HaXesURfZ2U70J1o5VOWcJbT
	XXo4/VELZrXOu4phRMITcaeWtwL3/dvwf3Nm4wSakeg1a9ChkVeQpdX+b60aThZyt7cv6BpuYTy
	wYCoVsxPm5CvVEEmcHbvhCTBtCiXXYXjj4DmxjBlb6Bekb63Yr1vZXCQ2n+G3gfc5ITAnIifU3D
	Cg2XKZGPfeNDgVAzSTKC3w3ugNjDStKjmPBh2jFMtrVjTCkjT0UuXF
X-Received: by 2002:a05:690c:6488:b0:6e2:12e5:35a2 with SMTP id 00721157ae682-6e7d3a9d0efmr35481627b3.4.1729602352383;
        Tue, 22 Oct 2024 06:05:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHxFH7L0Og3HjEiO0RR0AgMsyb3zr7MHcHrL6a+rQzlQXdmftWvF+5p4i1HxLWocDDzf5rvoAZPVYX7v9rfOlw=
X-Received: by 2002:a05:690c:6488:b0:6e2:12e5:35a2 with SMTP id
 00721157ae682-6e7d3a9d0efmr35479837b3.4.1729602350449; Tue, 22 Oct 2024
 06:05:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240926125909.2362244-1-acelan.kao@canonical.com>
 <ZvVgTGVSco0Kg7H5@wunner.de> <CAFv23Q=5KdqDHYxf9PVO=kq=VqP0LwRaHQ-KnY2taDEkZ9Fueg@mail.gmail.com>
 <ZvZ61srt3QAca2AI@wunner.de> <Zvf7xYEA32VgLRJ6@wunner.de> <CAFv23QkwxmT7qrnbfEpJNN+mnevNAor6Dk7efvYNOdjR9tGyrw@mail.gmail.com>
 <ZvvW1ua2UjwHIOEN@wunner.de> <ZvvXDQSBRZMEI2EX@wunner.de> <CAFv23Q=4O5czQaNw2mEnwkb9LQfODfQDeW+qQD14rfdeVEwjwA@mail.gmail.com>
 <CAFv23QmAOAobFC=4tkKBM4NQPR_b3Nsji5xa+TczUbAJ1dxhvg@mail.gmail.com>
In-Reply-To: <CAFv23QmAOAobFC=4tkKBM4NQPR_b3Nsji5xa+TczUbAJ1dxhvg@mail.gmail.com>
From: AceLan Kao <acelan.kao@canonical.com>
Date: Tue, 22 Oct 2024 21:05:39 +0800
Message-ID: <CAFv23Q=HqyL4EGjG0VdsQH9rP0_DbRdpExbeJy6DAoKQ0OMbkA@mail.gmail.com>
Subject: Re: [PATCH] PCI: pciehp: Fix system hang on resume after hot-unplug
 during suspend
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

AceLan Kao <acelan.kao@canonical.com> =E6=96=BC 2024=E5=B9=B410=E6=9C=8817=
=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8A=E5=8D=8810:40=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
> AceLan Kao <acelan.kao@canonical.com> =E6=96=BC 2024=E5=B9=B410=E6=9C=887=
=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=8812:34=E5=AF=AB=E9=81=93=EF=
=BC=9A
> >
> > Lukas Wunner <lukas@wunner.de> =E6=96=BC 2024=E5=B9=B410=E6=9C=881=E6=
=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=887:03=E5=AF=AB=E9=81=93=EF=BC=9A
> > >
> > > On Tue, Oct 01, 2024 at 01:02:46PM +0200, Lukas Wunner wrote:
> > > > On Mon, Sep 30, 2024 at 09:31:53AM +0800, AceLan Kao wrote:
> > > > > Lukas Wunner <lukas@wunner.de> 2024 9 28 8:51:
> > > > > > -       if (pci_get_dsn(pdev) !=3D ctrl->dsn)
> > > > > > +       dsn =3D pci_get_dsn(pdev);
> > > > > > +       if (!PCI_POSSIBLE_ERROR(dsn) &&
> > > > > > +           dsn !=3D ctrl->dsn)
> > > > > >                 return true;
> > > > >
> > > > > In my case, the pciehp_device_replaced() returns true from this f=
inal check.
> > > > > And these are the values I got
> > > > > dsn =3D 0x00000000, ctrl->dsn =3D 0x7800AA00
> > > > > dsn =3D 0x00000000, ctrl->dsn =3D 0x21B7D000
> > > >
> > > > Ah because pci_get_dsn() returns 0 if the device is gone.
> > > > Below is a modified patch which returns false in that case.
> > >
> > > Sorry, forgot to include the patch:
> > >
> > > -- >8 --
> > >
> > > diff --git a/drivers/pci/hotplug/pciehp_core.c b/drivers/pci/hotplug/=
pciehp_core.c
> > > index ff458e6..957c320 100644
> > > --- a/drivers/pci/hotplug/pciehp_core.c
> > > +++ b/drivers/pci/hotplug/pciehp_core.c
> > > @@ -287,24 +287,32 @@ static int pciehp_suspend(struct pcie_device *d=
ev)
> > >  static bool pciehp_device_replaced(struct controller *ctrl)
> > >  {
> > >         struct pci_dev *pdev __free(pci_dev_put);
> > > +       u64 dsn;
> > >         u32 reg;
> > >
> > >         pdev =3D pci_get_slot(ctrl->pcie->port->subordinate, PCI_DEVF=
N(0, 0));
> > >         if (!pdev)
> > > +               return false;
> > > +
> > > +       if (pci_read_config_dword(pdev, PCI_VENDOR_ID, &reg) =3D=3D 0=
 &&
> > > +           !PCI_POSSIBLE_ERROR(reg) &&
> > > +           reg !=3D (pdev->vendor | (pdev->device << 16)))
> > >                 return true;
> > >
> > > -       if (pci_read_config_dword(pdev, PCI_VENDOR_ID, &reg) ||
> > > -           reg !=3D (pdev->vendor | (pdev->device << 16)) ||
> > > -           pci_read_config_dword(pdev, PCI_CLASS_REVISION, &reg) ||
> > > +       if (pci_read_config_dword(pdev, PCI_CLASS_REVISION, &reg) =3D=
=3D 0 &&
> > > +           !PCI_POSSIBLE_ERROR(reg) &&
> > >             reg !=3D (pdev->revision | (pdev->class << 8)))
> > >                 return true;
> > >
> > >         if (pdev->hdr_type =3D=3D PCI_HEADER_TYPE_NORMAL &&
> > > -           (pci_read_config_dword(pdev, PCI_SUBSYSTEM_VENDOR_ID, &re=
g) ||
> > > -            reg !=3D (pdev->subsystem_vendor | (pdev->subsystem_devi=
ce << 16))))
> > > +           pci_read_config_dword(pdev, PCI_SUBSYSTEM_VENDOR_ID, &reg=
) =3D=3D 0 &&
> > > +           !PCI_POSSIBLE_ERROR(reg) &&
> > > +           reg !=3D (pdev->subsystem_vendor | (pdev->subsystem_devic=
e << 16)))
> > >                 return true;
> > >
> > > -       if (pci_get_dsn(pdev) !=3D ctrl->dsn)
> > > +       if ((dsn =3D pci_get_dsn(pdev)) &&
> > > +           !PCI_POSSIBLE_ERROR(dsn) &&
> > > +           dsn !=3D ctrl->dsn)
> > >                 return true;
> > >
> > >         return false;
> > Hi Lukas,
> >
> > Sorry for the late reply, just encountered a strong typhoon in my area
> > last week and can't check this in our lab.
> >
> > The patched pciehp_device_replaced() returns false at the end of the
> > function in my case.
> > Unplug the dock which is connected with a tbt storage won't be
> > considered as a replacement.
> >
> > But when I tried to replace the dock with the tbt storage during
> > suspend, it still returned false at the end of the function like
> > unplugged.
> >
> > BTW, it's a new model, so I think the ICM is used. And the reg is
> > 0xffffffff when unplugged.
> Hi Lukas,
>
> PCI_POSSIBLE_ERROR() always returns true no matter the device is
> replaced or unplugged
> It seems difficult to distinguish between when a device is replaced
> and when it's unplugged.
>
> Do you have any ideas to fix the issue?
> This issue is severe to me, because the system hangs almost everytime
> when daisy chain tbt devices are unplugged when suspended.
> Thanks.
Hi Lukas,

I just submitted the v2, please help to review, thanks.
https://lore.kernel.org/linux-kernel/20241022130243.263737-1-acelan.kao@can=
onical.com/T/#u

