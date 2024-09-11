Return-Path: <linux-kernel+bounces-324065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34544974779
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 02:42:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57ABA1C2551B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 00:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBA3712E7F;
	Wed, 11 Sep 2024 00:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SYKlpGdh"
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ADC7C148
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 00:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726015356; cv=none; b=U6F6J413pST/mlTakgVzIacy+kzRLO7WzXMazBQJ0Xcl6+PtBl8XJw1ShZQm3tHLinY9q/DN7hNbB1MNCckaRo1cvEmm6EcptA90Mjf+R7TVttoy2prL5opMi4YStuKikgroAyCGpNx6d/7iP6keZlsC/9mM7g9lEeeEezrNxUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726015356; c=relaxed/simple;
	bh=7HvliKdnoD8aAmw6Hf/HTmMxdFIQZKz91rN2SxxOu04=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CpYKBkQxZv/Qz7Lh13zTsGWs37UyZVcnp9PvsWvDuUle23Ozypk/vJTIysDVzGoOg/5dxGnw8lMj55phIHBPxkUu3V2WEM4dNn2bsAl79psQ4LDpdgLDVYWMoqdWxQyg6nc8BYMpE7D3p5Y0n1Um3wA8r1kOBZLpbWPUAYfUU8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SYKlpGdh; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-39d2a107aebso439255ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 17:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726015353; x=1726620153; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BeF3/6J6UTqVNK5mhc393zQ0sBFTjQfiTdi/4A4nx4o=;
        b=SYKlpGdhIYxrFbuR1X377AdwNqdo9McBisHExfLOogm7dL83F9kHDx/IR1yrXK1Uol
         V6PUFIuXjJRmpJbk8iDebBY5ct9f1wasxvcKv+i/HXZ9DFIwfqQ8ZXIOwVp/7TljRR+A
         +NjgXV4kmHmDTf+qt59hr++B2V+I5mCzreS4g6WrgcZR7PMMobLJECA52srg9mYGF2AE
         eOiVtUXYCX4IlRy9Ya097Ohv/dCuW4+xmSnfcbxvPFDAttj2T14zQ0IhuFLV4BGpGBce
         9W+G67jR7EnNm1fX6fxtkMc5gQFkQgo+FWqo2mLlgM1wHdULb9zE+ZS34Hu2CpnzPNlZ
         eC0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726015353; x=1726620153;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BeF3/6J6UTqVNK5mhc393zQ0sBFTjQfiTdi/4A4nx4o=;
        b=okzqLzToG2uaa3gbWYxEdPjcJBGQOSSWT1I40lX8y4ZfDDgCDCyD54bk489zGqRdcE
         QbGMBgKlmjFkrRTChVHtws12hQpkfN9yJv5/5zvDpH2idlZli/qMt/iyI6bnewn0lhOC
         paGUAU9KN0Twg6CA+fW+KFN77Tn3TLwDKBYehTsWtTi7JYIu6L1XmN4nVY9/UBUI9KRE
         cLkP/kMnZlftf4rqo1pNiT+/cU0zi3CRKlv3vjuY2tIJEG07kZNPfh7xgxARA7YkYP5p
         RjFqE2/rgEuwgmxtS1dKE40nPqFTBXqdlD0ocgn/20gNsEun7xAombfmKPx7dAtsh2cI
         RuJA==
X-Forwarded-Encrypted: i=1; AJvYcCX5bpHCKJ/FRQNunYF84S8CkfglncsWJU5658bp4i73nL3dfw54PAt8aYnXVTcVLbfKGk5Dd45lRh39EJg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRj8fkFTliDz2+raB4mFuuijm8PZgohzqT+d9H+S29JBtHzRS9
	vWYNIgLeZ25jTz6hZJBqIWc677827hPG/6UJ+ppjB+rpB6BNlxrXGKoxcJHRQgyFPdychNtflHS
	/T83FDlbDwKiul4g1FW2PPK4RGBJ52pLXInI=
X-Google-Smtp-Source: AGHT+IEPvjw5YasAhztllQuvAmSMS4doZl53jlQJSzQ6sqU46zj93mw8ws0rhRo6lpIc5cKdK+SR90M+5GW7gRMWJIA=
X-Received: by 2002:a05:6e02:1a4f:b0:375:9743:9fc with SMTP id
 e9e14a558f8ab-3a074fbe9femr1744795ab.0.1726015353255; Tue, 10 Sep 2024
 17:42:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240827234848.4429-1-helgaas@kernel.org> <20240827234848.4429-2-helgaas@kernel.org>
In-Reply-To: <20240827234848.4429-2-helgaas@kernel.org>
From: Duc Dang <ducdang@google.com>
Date: Tue, 10 Sep 2024 17:42:20 -0700
Message-ID: <CAOBz7Wi2aE8bVVnwBZGhJ5peZ0xAwvP73=QBJR4zHMWd+2qfGg@mail.gmail.com>
Subject: Re: [RFC PATCH 1/3] PCI: Wait for device readiness with Configuration RRS
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	"Maciej W . Rozycki" <macro@orcam.me.uk>, Mika Westerberg <mika.westerberg@linux.intel.com>, 
	Lukas Wunner <lukas@wunner.de>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, 
	Mario Limonciello <mario.limonciello@amd.com>, Alex Williamson <alex.williamson@redhat.com>, 
	linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Tested-by: Duc Dang <ducdang@google.com>

On Tue, Aug 27, 2024 at 4:57=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org> =
wrote:
>
> From: Bjorn Helgaas <bhelgaas@google.com>
>
> After a device reset, delays are required before the device can
> successfully complete config accesses.  PCIe r6.0, sec 6.6, specifies som=
e
> delays required before software can perform config accesses.  Devices tha=
t
> require more time after those delays may respond to config accesses with
> Configuration Request Retry Status (RRS) completions.
>
> Callers of pci_dev_wait() are responsible for delays until the device can
> respond to config accesses.  pci_dev_wait() waits any additional time unt=
il
> the device can successfully complete config accesses.
>
> Reading config space of devices that are not present or not ready typical=
ly
> returns ~0 (PCI_ERROR_RESPONSE).  Previously we polled the Command regist=
er
> until we got a value other than ~0.  This is sometimes a problem because
> Root Complex handling of RRS completions may include several retries and
> implementation-specific behavior that is invisible to software (see sec
> 2.3.2), so the exponential backoff in pci_dev_wait() may not work as
> intended.
>
> Linux enables Configuration RRS Software Visibility on all Root Ports tha=
t
> support it.  If it is enabled, read the Vendor ID instead of the Command
> register.  RRS completions cause immediate return of the 0x0001 reserved
> Vendor ID value, so the pci_dev_wait() backoff works correctly.
>
> When a read of Vendor ID eventually completes successfully by returning a
> non-0x0001 value (the Vendor ID or 0xffff for VFs), the device should be
> initialized and ready to respond to config requests.
>
> For conventional PCI devices or devices below Root Ports that don't suppo=
rt
> Configuration RRS Software Visibility, poll the Command register as befor=
e.
>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  drivers/pci/pci.c   | 41 ++++++++++++++++++++++++++++-------------
>  drivers/pci/pci.h   |  5 +++++
>  drivers/pci/probe.c |  9 +++------
>  include/linux/pci.h |  1 +
>  4 files changed, 37 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index e3a49f66982d..fc2ecb7fe081 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -1283,7 +1283,9 @@ static int pci_dev_wait(struct pci_dev *dev, char *=
reset_type, int timeout)
>  {
>         int delay =3D 1;
>         bool retrain =3D false;
> -       struct pci_dev *bridge;
> +       struct pci_dev *root, *bridge;
> +
> +       root =3D pcie_find_root_port(dev);
>
>         if (pci_is_pcie(dev)) {
>                 bridge =3D pci_upstream_bridge(dev);
> @@ -1292,16 +1294,23 @@ static int pci_dev_wait(struct pci_dev *dev, char=
 *reset_type, int timeout)
>         }
>
>         /*
> -        * After reset, the device should not silently discard config
> -        * requests, but it may still indicate that it needs more time by
> -        * responding to them with CRS completions.  The Root Port will
> -        * generally synthesize ~0 (PCI_ERROR_RESPONSE) data to complete
> -        * the read (except when CRS SV is enabled and the read was for t=
he
> -        * Vendor ID; in that case it synthesizes 0x0001 data).
> +        * The caller has already waited long enough after a reset that t=
he
> +        * device should respond to config requests, but it may respond
> +        * with Request Retry Status (RRS) if it needs more time to
> +        * initialize.
>          *
> -        * Wait for the device to return a non-CRS completion.  Read the
> -        * Command register instead of Vendor ID so we don't have to
> -        * contend with the CRS SV value.
> +        * If the device is below a Root Port with Configuration RRS
> +        * Software Visibility enabled, reading the Vendor ID returns a
> +        * special data value if the device responded with RRS.  Read the
> +        * Vendor ID until we get non-RRS status.
> +        *
> +        * If there's no Root Port or Configuration RRS Software Visibili=
ty
> +        * is not enabled, the device may still respond with RRS, but
> +        * hardware may retry the config request.  If no retries receive
> +        * Successful Completion, hardware generally synthesizes ~0
> +        * (PCI_ERROR_RESPONSE) data to complete the read.  Reading Vendo=
r
> +        * ID for VFs and non-existent devices also returns ~0, so read t=
he
> +        * Command register until it returns something other than ~0.
>          */
>         for (;;) {
>                 u32 id;
> @@ -1311,9 +1320,15 @@ static int pci_dev_wait(struct pci_dev *dev, char =
*reset_type, int timeout)
>                         return -ENOTTY;
>                 }
>
> -               pci_read_config_dword(dev, PCI_COMMAND, &id);
> -               if (!PCI_POSSIBLE_ERROR(id))
> -                       break;
> +               if (root && root->config_crs_sv) {
> +                       pci_read_config_dword(dev, PCI_VENDOR_ID, &id);
> +                       if (!pci_bus_crs_vendor_id(id))
> +                               break;
> +               } else {
> +                       pci_read_config_dword(dev, PCI_COMMAND, &id);
> +                       if (!PCI_POSSIBLE_ERROR(id))
> +                               break;
> +               }
>
>                 if (delay > timeout) {
>                         pci_warn(dev, "not ready %dms after %s; giving up=
\n",
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 79c8398f3938..fa1997bc2667 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -139,6 +139,11 @@ bool pci_bridge_d3_possible(struct pci_dev *dev);
>  void pci_bridge_d3_update(struct pci_dev *dev);
>  int pci_bridge_wait_for_secondary_bus(struct pci_dev *dev, char *reset_t=
ype);
>
> +static inline bool pci_bus_crs_vendor_id(u32 l)
> +{
> +       return (l & 0xffff) =3D=3D PCI_VENDOR_ID_PCI_SIG;
> +}
> +
>  static inline void pci_wakeup_event(struct pci_dev *dev)
>  {
>         /* Wait 100 ms before the system can be put into a sleep state. *=
/
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index b14b9876c030..b1615da9eb6b 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1209,9 +1209,11 @@ static void pci_enable_crs(struct pci_dev *pdev)
>
>         /* Enable CRS Software Visibility if supported */
>         pcie_capability_read_word(pdev, PCI_EXP_RTCAP, &root_cap);
> -       if (root_cap & PCI_EXP_RTCAP_CRSVIS)
> +       if (root_cap & PCI_EXP_RTCAP_CRSVIS) {
>                 pcie_capability_set_word(pdev, PCI_EXP_RTCTL,
>                                          PCI_EXP_RTCTL_CRSSVE);
> +               pdev->config_crs_sv =3D 1;
> +       }
>  }
>
>  static unsigned int pci_scan_child_bus_extend(struct pci_bus *bus,
> @@ -2343,11 +2345,6 @@ struct pci_dev *pci_alloc_dev(struct pci_bus *bus)
>  }
>  EXPORT_SYMBOL(pci_alloc_dev);
>
> -static bool pci_bus_crs_vendor_id(u32 l)
> -{
> -       return (l & 0xffff) =3D=3D PCI_VENDOR_ID_PCI_SIG;
> -}
> -
>  static bool pci_bus_wait_crs(struct pci_bus *bus, int devfn, u32 *l,
>                              int timeout)
>  {
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 4cf89a4b4cbc..121d8d94d6d0 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -371,6 +371,7 @@ struct pci_dev {
>                                            can be generated */
>         unsigned int    pme_poll:1;     /* Poll device's PME status bit *=
/
>         unsigned int    pinned:1;       /* Whether this dev is pinned */
> +       unsigned int    config_crs_sv:1; /* Config CRS software visibilit=
y */
>         unsigned int    imm_ready:1;    /* Supports Immediate Readiness *=
/
>         unsigned int    d1_support:1;   /* Low power state D1 is supporte=
d */
>         unsigned int    d2_support:1;   /* Low power state D2 is supporte=
d */
> --
> 2.34.1
>

