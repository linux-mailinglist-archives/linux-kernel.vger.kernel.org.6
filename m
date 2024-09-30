Return-Path: <linux-kernel+bounces-343270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 45B2C9898F7
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 03:32:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9D88B217C3
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 01:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A8924685;
	Mon, 30 Sep 2024 01:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="KQW/48ip"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 474FE383
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 01:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727659929; cv=none; b=Q86A/abovsY77kn9kRyAj4KWveXsioW+bQHkTA9O/PpH5aeiK4yE7DyQauw+rVyoHx2srbKwXaoot/TwT5sxL0WoZF4PbWKWlDtTVT1db+nrmVXaXzwrVeOfHdmphghzINDL9TAdMLfhhdfch3yy2iCXNtVADoZmkIJHxSorC50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727659929; c=relaxed/simple;
	bh=ZVuj4n7TdOvEZ2LwCrz+u9dreUEfz9ZWdeMGlG2fylY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ne42h3AGFWc//8vqNd/Zb2LQHxap2TPnq/KLFhJtudmTReRFDtUwmDCS4u0jCbheuhqH2bFt3A8gZ9xvXbLToHv9UdT/eCT46bruMI9iE4qU1qO1i27sN4wysUE0doagVj1TDU+6d13JszusZZMsXzzDFdKbNaudKUiG+qbZ69M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=KQW/48ip; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com [209.85.128.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 42D923F197
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 01:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1727659925;
	bh=XFcshJdaryV4O2Yy+cfSucqhYsAjbbnK2s82Q1jBAP0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=KQW/48ipI5xssXkbY72+0csLT2LiSQYcfKXTT6yo0hh/7pFF5mL38PZYJmdvILawG
	 QvYNNTJZ/yHCBiw0NbVbgsI79yju82lZypUyBByO/2ys2BfKgTGloM9suYclcTmPX8
	 X5FBkv7PjYbTIn6ywpuceue6zKJ5IIWE7h4g79V3VNQV4EsY9+IPbpZ8SGsnkY1CyM
	 ubDu7FkAVbAMxlmRjM7h7t0QMNLcMOKjJTM3hFnreQhur1zir/ICwzbuxTtGe7XrFw
	 m0uPnz8Cyr9/rvkAdUO5Q9HLy85na8bff361hsimnNmOM2IBx5vB8Bd1ZqyMUQv4C6
	 7+2LGF4okNNLQ==
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-6e2555d3d0eso31771817b3.1
        for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 18:32:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727659924; x=1728264724;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XFcshJdaryV4O2Yy+cfSucqhYsAjbbnK2s82Q1jBAP0=;
        b=AdKVqXLuLbCZOXO97ALCS6pXWB8vOTQnn4tIniwHUrIw9Pqfvp7Ss7cGswc3V5rNwW
         hlNYWv8YYU8i+x/E6NDhvg3aNFgGUHR+gnZPFOf33mW1XZWOFzBABy0nDwgqdKgTlSuF
         7qe9WIn9QSF7mypRCj+X3+mQEgZjSguB5CXurcN2nDlrSRRxAhR45uCJN0U8BB/D4tkq
         zvx585ZaR7i1p+mhTtYpM4NqwUCSeASOuwB8oW+3siqv2JjZDHeAW+Wvpui+DRrOsWbt
         nbYQMKjWItwTbbSm7PsnptwFx3pZRBbiun93sHestue1lpH6rhybmrWBBSZCDJRQIyuH
         GWdw==
X-Forwarded-Encrypted: i=1; AJvYcCVu/ndmnc8xc6nI3riBwy6JtUEbDkPEqiBkuTZJ5zBOSooKuakhiO3DdDjBqx5qMORWotSsmpEy7aNBfK0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yww0zjbAeIFypWpw52l1jTzFeTBTBBxNguSYsjAC7eXRLKJUbXJ
	Cpq3mWRuMn0f0JYOW4gozQNRkGNMn3e6velqZA4yBRctC/QfLu012F8rKtvBVU6Dfpr6b8L240v
	fakd+nNm1mFNb9RePOfOJtS6c58D0CP6vLBHVJJAkCIu/bfxQAU3sycag8nmlDlPIct/aeKaDAI
	+z4tnpwh294Kgl1gzZqXHuu45BmZyV3d19iBYVfknTel4yCvkizREB
X-Received: by 2002:a05:690c:ec3:b0:64b:75d8:5002 with SMTP id 00721157ae682-6e25ec494demr29484647b3.9.1727659924275;
        Sun, 29 Sep 2024 18:32:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGs8sw9rhbDh7zRWt8v2IdjvM01peiQ+FBEdapiFkDzfn5VN5r7d3rt4h4rx0hpUwB/C28XnIpL5aCgJpzqrME=
X-Received: by 2002:a05:690c:ec3:b0:64b:75d8:5002 with SMTP id
 00721157ae682-6e25ec494demr29484597b3.9.1727659923995; Sun, 29 Sep 2024
 18:32:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240926125909.2362244-1-acelan.kao@canonical.com>
 <ZvVgTGVSco0Kg7H5@wunner.de> <CAFv23Q=5KdqDHYxf9PVO=kq=VqP0LwRaHQ-KnY2taDEkZ9Fueg@mail.gmail.com>
 <ZvZ61srt3QAca2AI@wunner.de> <Zvf7xYEA32VgLRJ6@wunner.de>
In-Reply-To: <Zvf7xYEA32VgLRJ6@wunner.de>
From: AceLan Kao <acelan.kao@canonical.com>
Date: Mon, 30 Sep 2024 09:31:53 +0800
Message-ID: <CAFv23QkwxmT7qrnbfEpJNN+mnevNAor6Dk7efvYNOdjR9tGyrw@mail.gmail.com>
Subject: Re: [PATCH] PCI: pciehp: Fix system hang on resume after hot-unplug
 during suspend
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Lukas Wunner <lukas@wunner.de> =E6=96=BC 2024=E5=B9=B49=E6=9C=8828=E6=97=A5=
 =E9=80=B1=E5=85=AD =E4=B8=8B=E5=8D=888:51=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Fri, Sep 27, 2024 at 11:28:54AM +0200, Lukas Wunner wrote:
> > I realize now that commit 9d573d19547b ("PCI: pciehp: Detect device
> > replacement during system sleep") is a little overzealous because it
> > not only reacts to *replaced* devices but also to *unplugged* devices:
> > If the device was unplugged, reading the vendor and device ID returns
> > 0xffff, which is different from the cached value, so the device is
> > assumed to have been replaced even though it's actually been unplugged.
> >
> > The device replacement check runs in the ->resume_noirq phase.  Later o=
n
> > in the ->resume phase, pciehp_resume() calls pciehp_check_presence() to
> > check for unplugged devices.  Commit 9d573d19547b inadvertantly reacts
> > before pciehp_check_presence() gets a chance to react.  So that's somet=
hing
> > that we should probably change.
>
> FWIW, below is a (compile-tested only) patch which modifies
> pciehp_device_replaced() to return false if the device was
> *unplugged* during system sleep.  It continues to return
> true if it was *replaced* during system sleep.
>
> This might avoid the issue you're seeing, though it would
> be good if you could also try Keith's deadlock prevention
> patch (without any other patch) to determine if the deadlock
> is the actual root cause (as I suspect).
>
> Thanks!
>
> -- >8 --
>
> diff --git a/drivers/pci/hotplug/pciehp_core.c b/drivers/pci/hotplug/pcie=
hp_core.c
> index ff458e6..174832b 100644
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
> +       dsn =3D pci_get_dsn(pdev);
> +       if (!PCI_POSSIBLE_ERROR(dsn) &&
> +           dsn !=3D ctrl->dsn)
>                 return true;
In my case, the pciehp_device_replaced() returns true from this final check=
.
And these are the values I got
dsn =3D 0x00000000, ctrl->dsn =3D 0x7800AA00
dsn =3D 0x00000000, ctrl->dsn =3D 0x21B7D000

Did some other test
TBT HDD -> TBT dock -> laptop
   suspend
TBT HDD -> laptop(replace TBT dock with the TBT HDD)
   resume
Got the same result as above, looks like it didn't detect the TBT dock
has been replaced by TBT HDD.

In the origin call trace, unplug TBT dock or replace it with TBT HDD,
it returns true by the below check
        if (pci_read_config_dword(pdev, PCI_VENDOR_ID, &reg) ||
           reg !=3D (pdev->vendor | (pdev->device << 16)) ||
           pci_read_config_dword(pdev, PCI_CLASS_REVISION, &reg) ||
           reg !=3D (pdev->revision | (pdev->class << 8)))
               return true;

>
>         return false;

