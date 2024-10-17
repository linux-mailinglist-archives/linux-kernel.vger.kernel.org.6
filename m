Return-Path: <linux-kernel+bounces-369079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2D289A18B3
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 04:41:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70D241F21E2F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 02:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A6C14C62B;
	Thu, 17 Oct 2024 02:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="TT1O+HwP"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65BD2E634
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 02:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729132876; cv=none; b=i9Ve7Q7vc/eCGRz8uNkvtfwpnT5H30K5QHkDHX1Kk9kwnYh3wMBRUZmLddbIhEEXagD/80ndyHtTUusKOa6mXtlwS5XRg2dJQLbqh+Ya5sdT2uCgdrcO4jvhw8FCJgX6MOW5gGXVLYCjCuxfPmsy9JTvBO6hkzu8dhVAlPtZ1Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729132876; c=relaxed/simple;
	bh=dLAnMTgfHyWEyMiXYcOAXUOFKE+kM6b7O9NeyGqvoVE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I8mu5R9RxrfBMtM+MiQErXM4/nQZQCxELIgNe2H90V7XQf6LNlYQrR2LduTITfEouB6n8vjYEJ5CHJ9ewtODKvKcKTATyH4sRr4qAsUv9hFK/Gu9ovl8qsvi5V7zo5dbcuVG94S1KEyiQ3f+8mu523fX7/2EOhAXcoDO2crudgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=TT1O+HwP; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com [209.85.128.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 8F9663F363
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 02:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1729132863;
	bh=T24SWxRsUs3FH0Hfu2DAqNwIbPAhsue5M4uaumpInTc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=TT1O+HwPzpmNUy9LWF2QBuaifSogoNvk/8Xvfb1HNKTelK9J3+gkjOHTTRldaY82Y
	 eAasjoE0aXARb7jGkSiY6DQlKTgLq/WT8Fo0x8rEs+90Ux2GqacjnlUCdN9eb8I2Z3
	 Z0+dwYQdSTR0AcGDzN0mFsI1x56ExMrVdqMw1VTFwWZBzj+McJtSpCWjO8WqEY2wvw
	 JbPP6QxTUACV5zzOpnqCZ1nYFPb3bdThmAnc4Mc6tmD1w8hXhxURO9RdIVSJGajhzp
	 87SN+tWoScrntqZw2eSkgA/WbqitGFSNXzJW5QJMgGKfFwESp6suxRGoTqw1UiCgso
	 2LyaAqokTKuKQ==
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-6e38fabff35so10486557b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 19:41:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729132862; x=1729737662;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T24SWxRsUs3FH0Hfu2DAqNwIbPAhsue5M4uaumpInTc=;
        b=jkvR+XM0+K2adi4Q9P22OciavN2HLd2Etf4AajALcB0ALTjPyoeXC94K8aWctGewR8
         ieYVnHEjbxjNRQBIrZpNsnmLIuyYoxjAs2116P/gCm0oiV1JQEv0lNcVuptrAYD/B3Zt
         5ewtuG9qKheEI1QPWUz6chL1yAfkNKUjpOVtllhi+zERY8HtU+jGdEQVqbIXRy9nHeTn
         E7+1z7vyePMoydNk/NC3I5SiR1n6D7I/z1QsTksAJSyM369dfImpLWxScVLVTiubM2zh
         L4KoWBTcsO9d8Xi6SHaylQskNUHNPXoMVEbzVgqRfCJCBaAlz9nC/0CXeQ1BzRRRlw6C
         TH0g==
X-Forwarded-Encrypted: i=1; AJvYcCVP1mFKIoukIk/1cxAiiyp4a+VY3E4aopiTwCr/LJ6Uhz5tHccV88ApdEMMUHKbXHTKiXh9RhG1xFhw9P8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBGs34fULZAYkOGqozTd15T8SorX+v4+35Gvjd+D1daXL1x/Kb
	KTqtjfhpPEugvwXjES1oixvOVQjsj4F8U+7LFakhW5smLCqDO1FxJ/A59gGrQ3kAmO8qVT7sC8Q
	CZcorBuvkfeSZb8HUI1e/CVSr75vCKHdCJhnbx+t8lrW+hvxmIqp3FzopR+nPZ/OcXyYGIX6n2J
	4/rstTDLM2wFkAxWvQreuatBTOcoBHjzrm8QouGJFa/yaNrAjuKSLY
X-Received: by 2002:a05:6902:124a:b0:e29:629f:8a7f with SMTP id 3f1490d57ef6-e297856bcccmr6141459276.35.1729132862605;
        Wed, 16 Oct 2024 19:41:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHVIn6LC4RH+ZuMQpvyr93R7VXfYfB6DsvjjWy90VkucZ4oPJS9YJUKbITF5HdXuBCRiozOb9FMG4dEuo4pjMg=
X-Received: by 2002:a05:6902:124a:b0:e29:629f:8a7f with SMTP id
 3f1490d57ef6-e297856bcccmr6141453276.35.1729132862313; Wed, 16 Oct 2024
 19:41:02 -0700 (PDT)
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
In-Reply-To: <CAFv23Q=4O5czQaNw2mEnwkb9LQfODfQDeW+qQD14rfdeVEwjwA@mail.gmail.com>
From: AceLan Kao <acelan.kao@canonical.com>
Date: Thu, 17 Oct 2024 10:40:51 +0800
Message-ID: <CAFv23QmAOAobFC=4tkKBM4NQPR_b3Nsji5xa+TczUbAJ1dxhvg@mail.gmail.com>
Subject: Re: [PATCH] PCI: pciehp: Fix system hang on resume after hot-unplug
 during suspend
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

AceLan Kao <acelan.kao@canonical.com> =E6=96=BC 2024=E5=B9=B410=E6=9C=887=
=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=8812:34=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
> Lukas Wunner <lukas@wunner.de> =E6=96=BC 2024=E5=B9=B410=E6=9C=881=E6=97=
=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=887:03=E5=AF=AB=E9=81=93=EF=BC=9A
> >
> > On Tue, Oct 01, 2024 at 01:02:46PM +0200, Lukas Wunner wrote:
> > > On Mon, Sep 30, 2024 at 09:31:53AM +0800, AceLan Kao wrote:
> > > > Lukas Wunner <lukas@wunner.de> 2024 9 28 8:51:
> > > > > -       if (pci_get_dsn(pdev) !=3D ctrl->dsn)
> > > > > +       dsn =3D pci_get_dsn(pdev);
> > > > > +       if (!PCI_POSSIBLE_ERROR(dsn) &&
> > > > > +           dsn !=3D ctrl->dsn)
> > > > >                 return true;
> > > >
> > > > In my case, the pciehp_device_replaced() returns true from this fin=
al check.
> > > > And these are the values I got
> > > > dsn =3D 0x00000000, ctrl->dsn =3D 0x7800AA00
> > > > dsn =3D 0x00000000, ctrl->dsn =3D 0x21B7D000
> > >
> > > Ah because pci_get_dsn() returns 0 if the device is gone.
> > > Below is a modified patch which returns false in that case.
> >
> > Sorry, forgot to include the patch:
> >
> > -- >8 --
> >
> > diff --git a/drivers/pci/hotplug/pciehp_core.c b/drivers/pci/hotplug/pc=
iehp_core.c
> > index ff458e6..957c320 100644
> > --- a/drivers/pci/hotplug/pciehp_core.c
> > +++ b/drivers/pci/hotplug/pciehp_core.c
> > @@ -287,24 +287,32 @@ static int pciehp_suspend(struct pcie_device *dev=
)
> >  static bool pciehp_device_replaced(struct controller *ctrl)
> >  {
> >         struct pci_dev *pdev __free(pci_dev_put);
> > +       u64 dsn;
> >         u32 reg;
> >
> >         pdev =3D pci_get_slot(ctrl->pcie->port->subordinate, PCI_DEVFN(=
0, 0));
> >         if (!pdev)
> > +               return false;
> > +
> > +       if (pci_read_config_dword(pdev, PCI_VENDOR_ID, &reg) =3D=3D 0 &=
&
> > +           !PCI_POSSIBLE_ERROR(reg) &&
> > +           reg !=3D (pdev->vendor | (pdev->device << 16)))
> >                 return true;
> >
> > -       if (pci_read_config_dword(pdev, PCI_VENDOR_ID, &reg) ||
> > -           reg !=3D (pdev->vendor | (pdev->device << 16)) ||
> > -           pci_read_config_dword(pdev, PCI_CLASS_REVISION, &reg) ||
> > +       if (pci_read_config_dword(pdev, PCI_CLASS_REVISION, &reg) =3D=
=3D 0 &&
> > +           !PCI_POSSIBLE_ERROR(reg) &&
> >             reg !=3D (pdev->revision | (pdev->class << 8)))
> >                 return true;
> >
> >         if (pdev->hdr_type =3D=3D PCI_HEADER_TYPE_NORMAL &&
> > -           (pci_read_config_dword(pdev, PCI_SUBSYSTEM_VENDOR_ID, &reg)=
 ||
> > -            reg !=3D (pdev->subsystem_vendor | (pdev->subsystem_device=
 << 16))))
> > +           pci_read_config_dword(pdev, PCI_SUBSYSTEM_VENDOR_ID, &reg) =
=3D=3D 0 &&
> > +           !PCI_POSSIBLE_ERROR(reg) &&
> > +           reg !=3D (pdev->subsystem_vendor | (pdev->subsystem_device =
<< 16)))
> >                 return true;
> >
> > -       if (pci_get_dsn(pdev) !=3D ctrl->dsn)
> > +       if ((dsn =3D pci_get_dsn(pdev)) &&
> > +           !PCI_POSSIBLE_ERROR(dsn) &&
> > +           dsn !=3D ctrl->dsn)
> >                 return true;
> >
> >         return false;
> Hi Lukas,
>
> Sorry for the late reply, just encountered a strong typhoon in my area
> last week and can't check this in our lab.
>
> The patched pciehp_device_replaced() returns false at the end of the
> function in my case.
> Unplug the dock which is connected with a tbt storage won't be
> considered as a replacement.
>
> But when I tried to replace the dock with the tbt storage during
> suspend, it still returned false at the end of the function like
> unplugged.
>
> BTW, it's a new model, so I think the ICM is used. And the reg is
> 0xffffffff when unplugged.
Hi Lukas,

PCI_POSSIBLE_ERROR() always returns true no matter the device is
replaced or unplugged
It seems difficult to distinguish between when a device is replaced
and when it's unplugged.

Do you have any ideas to fix the issue?
This issue is severe to me, because the system hangs almost everytime
when daisy chain tbt devices are unplugged when suspended.
Thanks.

