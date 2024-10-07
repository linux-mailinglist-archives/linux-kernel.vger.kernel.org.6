Return-Path: <linux-kernel+bounces-352743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9117D9923A5
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 06:34:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C9781F22902
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 04:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FFC312B17C;
	Mon,  7 Oct 2024 04:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="WEPBW6Y1"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A108E54918
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 04:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728275672; cv=none; b=pO5e6lCTOduup6g32kD/rZOZZ1JQuUGm6qXMA61lQtTBcq5oqAyhQx7jipJsF2DAF7BXFrrkfu1jCcWcIMctFc6P5WSU1csYOrwPfSvaI+xCrBizznyfa37ZirCiCM8Q3eWyL80zX3iNPggs9WWMiwU/893RxjyAEV9E/nJJJ0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728275672; c=relaxed/simple;
	bh=xtVT0IFCi2Qto8kpSQiCGlBpvaMpt3JFkS6nS7bOX5U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m+ROxLUZjO/fuzsFNmBPm+BQZIuAI+mNwpVjakl+f/313SHK0Iqvu4D/LvFCbyHOPvPAWUiJj1Te9ASLo+ooq1UvtO9PRynVTs12bvlS24RMehG8VF4JAaUh/07KVAUASLVzkZK8EED3oESUmjeFFSH/fDAiI1gVx6OpEFqBdPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=WEPBW6Y1; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com [209.85.128.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 171D93F31D
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 04:34:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1728275662;
	bh=RKS/f2MF9K/DRHRfB0v5ZmIcK+e+Ci2Bwh5D2AMKYp8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=WEPBW6Y1EsIzoBjxthb0gqfWCq9lAoePhji1M2UfUnpiLpbKiqa8EnUIR/qmyIWY1
	 f/1B7c+9P/97mOYFUMPEp4nwea+9ZF6nGwrpIaM5H9QTuz9wdy7ySo/Qoebl15f5t0
	 yiLsZ9QEcI1gnl8Nx7OZlw0E8gDZTn1f1VY5JhhdZm7O5ptlff5VT2hPFN+XL7SnjE
	 FxXChujo9sbi5mWSZGOqzceD8YED/H4IYcfpUYD9hfe+p8uX9EeuhF/b7yqcD1Qrar
	 Cy05DJR9q9Nc6VBMHqk03l/DAvtWDI9Qf+48AEUz+Nn9gvh3iNHm2O3TWKf/4JjHjU
	 K2Q54onz3skQA==
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-6e28d223794so66829597b3.0
        for <linux-kernel@vger.kernel.org>; Sun, 06 Oct 2024 21:34:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728275660; x=1728880460;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RKS/f2MF9K/DRHRfB0v5ZmIcK+e+Ci2Bwh5D2AMKYp8=;
        b=QJzM21QHw/6PgzrDTpnaOA2mNyS0X37A/c8vC/M5eSgdExsMxHKXUt96FnVkX22GcJ
         mLu9SRucFUgCDFjRU33Iyi65V3hlGpK73Nh3mBRX7EATXJ9YnRN8pqsgVNO9v73EKixn
         7ea4Kip9oDGdcm0u//UNU0vWOX8YRHnIocoUgiMypK9IyWEL+B7M1+OckTMeX8mRQfbM
         UUJmitgNku/zSVcQztFsxQBGKdFWAM6ds43mcss+ECqOszx0K9/2I+Qbge3aUeDC/m6d
         TQRhXF5BOoJDPPlkW1M3LKNSc4knCGQJzaiJvtPZJy3OWDaigYs5M11PIsgS2i+pxi41
         YATQ==
X-Forwarded-Encrypted: i=1; AJvYcCWNqKcji6Lxh40SYoUYdDCApeGDWENLjE4+l7S1ZNtUNtqluYZr74+7entBOF9twXtoa0KOJMGrFboWPL0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTz+iOG+XLW+kB2+wZ6SEaLjSRaOSQE7FpzENQFXQWGObL0Zha
	yYnyL2kXDMdEg+YMAoy125Oh1LJypLjxWRFpjn0YjUCyFrFaoDqqxTGogn5q4G2WQQpyi9VBIIo
	B7v5ppYDir9GvBUIj0aHwPLpqIEHGx/SidZ+e/EzYCxxefqsb+x6FRr+LvJQgI/I/gvZnItraT5
	EjJ4gNfdpHvemM+QXtc5V35z4B3eTLAKuieQlWLgUcY2LczRHqnk5A
X-Received: by 2002:a05:6902:2388:b0:e22:5b1b:f1f1 with SMTP id 3f1490d57ef6-e28936d681cmr7110370276.22.1728275660429;
        Sun, 06 Oct 2024 21:34:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEHi3j06zDsu+UMiFSC0YAaoU5Gwv3GT9ajM093Bdzuvg/07VdqPhd1wdUbzIXoRnTEH9VD+2v/cf2IOe3HLgE=
X-Received: by 2002:a05:6902:2388:b0:e22:5b1b:f1f1 with SMTP id
 3f1490d57ef6-e28936d681cmr7110367276.22.1728275660149; Sun, 06 Oct 2024
 21:34:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240926125909.2362244-1-acelan.kao@canonical.com>
 <ZvVgTGVSco0Kg7H5@wunner.de> <CAFv23Q=5KdqDHYxf9PVO=kq=VqP0LwRaHQ-KnY2taDEkZ9Fueg@mail.gmail.com>
 <ZvZ61srt3QAca2AI@wunner.de> <Zvf7xYEA32VgLRJ6@wunner.de> <CAFv23QkwxmT7qrnbfEpJNN+mnevNAor6Dk7efvYNOdjR9tGyrw@mail.gmail.com>
 <ZvvW1ua2UjwHIOEN@wunner.de> <ZvvXDQSBRZMEI2EX@wunner.de>
In-Reply-To: <ZvvXDQSBRZMEI2EX@wunner.de>
From: AceLan Kao <acelan.kao@canonical.com>
Date: Mon, 7 Oct 2024 12:34:09 +0800
Message-ID: <CAFv23Q=4O5czQaNw2mEnwkb9LQfODfQDeW+qQD14rfdeVEwjwA@mail.gmail.com>
Subject: Re: [PATCH] PCI: pciehp: Fix system hang on resume after hot-unplug
 during suspend
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Lukas Wunner <lukas@wunner.de> =E6=96=BC 2024=E5=B9=B410=E6=9C=881=E6=97=A5=
 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=887:03=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Tue, Oct 01, 2024 at 01:02:46PM +0200, Lukas Wunner wrote:
> > On Mon, Sep 30, 2024 at 09:31:53AM +0800, AceLan Kao wrote:
> > > Lukas Wunner <lukas@wunner.de> 2024 9 28 8:51:
> > > > -       if (pci_get_dsn(pdev) !=3D ctrl->dsn)
> > > > +       dsn =3D pci_get_dsn(pdev);
> > > > +       if (!PCI_POSSIBLE_ERROR(dsn) &&
> > > > +           dsn !=3D ctrl->dsn)
> > > >                 return true;
> > >
> > > In my case, the pciehp_device_replaced() returns true from this final=
 check.
> > > And these are the values I got
> > > dsn =3D 0x00000000, ctrl->dsn =3D 0x7800AA00
> > > dsn =3D 0x00000000, ctrl->dsn =3D 0x21B7D000
> >
> > Ah because pci_get_dsn() returns 0 if the device is gone.
> > Below is a modified patch which returns false in that case.
>
> Sorry, forgot to include the patch:
>
> -- >8 --
>
> diff --git a/drivers/pci/hotplug/pciehp_core.c b/drivers/pci/hotplug/pcie=
hp_core.c
> index ff458e6..957c320 100644
> --- a/drivers/pci/hotplug/pciehp_core.c
> +++ b/drivers/pci/hotplug/pciehp_core.c
> @@ -287,24 +287,32 @@ static int pciehp_suspend(struct pcie_device *dev)
>  static bool pciehp_device_replaced(struct controller *ctrl)
>  {
>         struct pci_dev *pdev __free(pci_dev_put);
> +       u64 dsn;
>         u32 reg;
>
>         pdev =3D pci_get_slot(ctrl->pcie->port->subordinate, PCI_DEVFN(0,=
 0));
>         if (!pdev)
> +               return false;
> +
> +       if (pci_read_config_dword(pdev, PCI_VENDOR_ID, &reg) =3D=3D 0 &&
> +           !PCI_POSSIBLE_ERROR(reg) &&
> +           reg !=3D (pdev->vendor | (pdev->device << 16)))
>                 return true;
>
> -       if (pci_read_config_dword(pdev, PCI_VENDOR_ID, &reg) ||
> -           reg !=3D (pdev->vendor | (pdev->device << 16)) ||
> -           pci_read_config_dword(pdev, PCI_CLASS_REVISION, &reg) ||
> +       if (pci_read_config_dword(pdev, PCI_CLASS_REVISION, &reg) =3D=3D =
0 &&
> +           !PCI_POSSIBLE_ERROR(reg) &&
>             reg !=3D (pdev->revision | (pdev->class << 8)))
>                 return true;
>
>         if (pdev->hdr_type =3D=3D PCI_HEADER_TYPE_NORMAL &&
> -           (pci_read_config_dword(pdev, PCI_SUBSYSTEM_VENDOR_ID, &reg) |=
|
> -            reg !=3D (pdev->subsystem_vendor | (pdev->subsystem_device <=
< 16))))
> +           pci_read_config_dword(pdev, PCI_SUBSYSTEM_VENDOR_ID, &reg) =
=3D=3D 0 &&
> +           !PCI_POSSIBLE_ERROR(reg) &&
> +           reg !=3D (pdev->subsystem_vendor | (pdev->subsystem_device <<=
 16)))
>                 return true;
>
> -       if (pci_get_dsn(pdev) !=3D ctrl->dsn)
> +       if ((dsn =3D pci_get_dsn(pdev)) &&
> +           !PCI_POSSIBLE_ERROR(dsn) &&
> +           dsn !=3D ctrl->dsn)
>                 return true;
>
>         return false;
Hi Lukas,

Sorry for the late reply, just encountered a strong typhoon in my area
last week and can't check this in our lab.

The patched pciehp_device_replaced() returns false at the end of the
function in my case.
Unplug the dock which is connected with a tbt storage won't be
considered as a replacement.

But when I tried to replace the dock with the tbt storage during
suspend, it still returned false at the end of the function like
unplugged.

BTW, it's a new model, so I think the ICM is used. And the reg is
0xffffffff when unplugged.

