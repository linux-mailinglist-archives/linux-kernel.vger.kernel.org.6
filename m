Return-Path: <linux-kernel+bounces-263826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AE5493DB18
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 01:06:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEA4B1C21EB0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 23:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD4E214EC60;
	Fri, 26 Jul 2024 23:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dFipUmbW"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9E12B9BE
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 23:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722035194; cv=none; b=JrQpYto52t/hjkjPeHbRXVrUTKm2NDcfVEcTvms5Sn6ypv/YGh4SNwKgb4TxiGaVX07FT4TIdPipGcWj/NamMGjGruBppivGaT4PKVSm8KvjcCtZmgJtSiPNWc8DMhYACSrrF/4g1j6vlF/GP/Il8dl+w3Q6F4cIN16gk8Bbn2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722035194; c=relaxed/simple;
	bh=ld6KeuB4sATn7KhNW/BfMGlPLHxeZpj4+EBu8ioiPck=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iken1EDSOB/sbHTUJXXApc5/IcZtg9JtRv+X2WiXHw28I9qV9k9A42Z5f5rR5Xwfw1gnGo2ITkbAaTxLDW1nk1JtyigBF8rq5UVEQuUIKGH/S9lo+7u8eVy+04RH+H+yQbfmUgUMtAmcLBAAHUMspqje2I6SSXonrfAbkyvTzn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=dFipUmbW; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5ab2baf13d9so3053082a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 16:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1722035190; x=1722639990; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x+ufKxTs+4yOu1uTFcIromX5f1C1mm5vL8h9xvW7RjA=;
        b=dFipUmbWeFL0f/u7/K9mPYDgjfJtEJYu38rdvPw7Ou23rc27tS5BYqHOPn0XfbiRmS
         +jzOkXdlGi/nEYPtlC4VeeVnx2Xd91P3OQuzeWReTZVf8w9ZY+7KIrHOXCm0T6MOl5/B
         yoSoxqav5claVSlBuhWRHkEaKnAKXa3HcvGfc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722035190; x=1722639990;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x+ufKxTs+4yOu1uTFcIromX5f1C1mm5vL8h9xvW7RjA=;
        b=bXiPw6hQixKruvlKafooO4QRwCjUZ0lIyYp6mcnO1PqeGmyRjPwEz+GUKWUADozRwB
         oiTZ+CuKqcDCDpd6wArk3HQSJV3uF4pZcnZ2Jd3Ghn4mnI6OxV9z4Tid6EXcsovgBwyX
         OI9nWJGsOQrQ5UKikx0v6jU7cUsc9UDP0Pq/EESEhPb7IHUZzFXAumE8EfIG6WbMZa08
         8YjM0LCijn/0dYXqtH0sDYxyxYjohhV1m7Fjq1he66cbjzwrCGAMtMakoxX8t+6vi9OR
         QGzJfkTebv+go/vYAqOvTLR92/kTv1IYzos5d0ldittr5pVNNfY7LmBqcxJSyNrH6dhs
         2VhQ==
X-Forwarded-Encrypted: i=1; AJvYcCVVGGqJW3SCvbzsEm1XUqnOZ4W+VHjNdbElKHho2h3Sw3zFGRdDnLoc7pB5EIMWkjr0OBnYr+hnl+fil2Men0l7Ur+oSd26zTAjVAhW
X-Gm-Message-State: AOJu0YxhRpfaOJhpOTTbm1xQX/vaHY0e+XR9HWK9HyYn/PC8atuL+0iM
	ULZFObiY9ZZg4wHK03f+zkpfbuHcOebICf7BqiMBsfUBverb0kY6H32Eu7v0pxZueduMLcApnfx
	N7hsLtCusxMt6f4/eCR8npy0mkry57w8LbSEIgQn/KCmnERQ=
X-Google-Smtp-Source: AGHT+IGEQmOdGLNP3Mq5rTpzM4kyWZztDxXbtgm6nR21X2SELvdhrhBNz1AWPZR1GYT402EWXUxVjo+vAtNCDjCBUiw=
X-Received: by 2002:a05:6402:3487:b0:5a3:b45:3979 with SMTP id
 4fb4d7f45d1cf-5b020ba8a06mr486269a12.17.1722035189399; Fri, 26 Jul 2024
 16:06:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240326-pci-bridge-d3-v4-0-f1dce1d1f648@linaro.org> <20240511071532.GC6672@thinkpad>
In-Reply-To: <20240511071532.GC6672@thinkpad>
From: Hsin-Yi Wang <hsinyi@chromium.org>
Date: Fri, 26 Jul 2024 16:06:03 -0700
Message-ID: <CAJMQK-gBACa0s7qo=sOkK2UJB+9WbNHBkfg4NTxp3dVfjvugSg@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] PCI: Allow D3Hot for PCI bridges in Devicetree
 based platforms
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, lukas@wunner.de, 
	mika.westerberg@linux.intel.com, Bjorn Helgaas <helgaas@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 26, 2024 at 4:02=E2=80=AFPM Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> On Tue, Mar 26, 2024 at 04:18:16PM +0530, Manivannan Sadhasivam wrote:
> > Hi,
> >
> > This series allows D3Hot for PCI bridges in Devicetree based platforms.
> > Even though most of the bridges in Devicetree platforms support D3Hot, =
PCI
> > core will allow D3Hot only when one of the following conditions are met=
:
> >
> > 1. Platform is ACPI based
> > 2. Thunderbolt controller is used
> > 3. pcie_port_pm=3Dforce passed in cmdline
> >
> > While options 1 and 2 do not apply to most of the DT based platforms,
> > option 3 will make the life harder for distro maintainers.
> >
> > Initially, I tried to fix this issue by using a Devicetree property [1]=
, but
> > that was rejected by Bjorn and it was concluded that D3Hot should be al=
lowed by
> > default for all the Devicetree based platforms.
> >
> > During the review of v3 series, Bjorn noted several shortcomings of the
> > pci_bridge_d3_possible() API [2] and I tried to address them in this se=
ries as
> > well.
> >
> > But please note that the patches 2 and 3 needs closer review from ACPI =
and x86
> > folks since I've splitted the D3Hot and D3Cold handling based on my lit=
tle
> > understanding of the code.
> >
> > Testing
> > =3D=3D=3D=3D=3D=3D=3D
> >
> > This series is tested on SM8450 based development board on top of [3].
> >
>
> Bjorn, a gently ping on this series.
>

Hi, I was also working on a similar patch to add bridge_d3 to arm
platforms until I found this series, which is what we need. Also
kindly ping on this series.

Thanks!

> - Mani
>
> > - Mani
> >
> > [1] https://lore.kernel.org/linux-pci/20240214-pcie-qcom-bridge-v3-1-3a=
713bbc1fd7@linaro.org/
> > [2] https://lore.kernel.org/linux-pci/20240305175107.GA539676@bhelgaas/
> > [3] https://lore.kernel.org/linux-arm-msm/20240321-pcie-qcom-bridge-dts=
-v2-0-1eb790c53e43@linaro.org/
> >
> > Changes in v4:
> > - Added pci_bridge_d3_possible() rework based on comments from Bjorn
> > - Got rid of the DT property and allowed D3Hot by default on all DT pla=
tforms
> >
> > Changes in v3:
> > - Fixed kdoc, used of_property_present() and dev_of_node() (Lukas)
> > - Link to v2: https://lore.kernel.org/r/20240214-pcie-qcom-bridge-v2-1-=
9dd6dbb1b817@linaro.org
> >
> > Changes in v2:
> > - Switched to DT based approach as suggested by Lukas.
> > - Link to v1: https://lore.kernel.org/r/20240202-pcie-qcom-bridge-v1-0-=
46d7789836c0@linaro.org
> >
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> > Manivannan Sadhasivam (4):
> >       PCI/portdrv: Make use of pci_dev::bridge_d3 for checking the D3 p=
ossibility
> >       PCI: Rename pci_bridge_d3_possible() to pci_bridge_d3_allowed()
> >       PCI: Decouple D3Hot and D3Cold handling for bridges
> >       PCI: Allow PCI bridges to go to D3Hot on all Devicetree based pla=
tforms
> >
> >  drivers/pci/bus.c          |  2 +-
> >  drivers/pci/pci-acpi.c     |  9 ++---
> >  drivers/pci/pci-sysfs.c    |  2 +-
> >  drivers/pci/pci.c          | 90 ++++++++++++++++++++++++++++++++------=
--------
> >  drivers/pci/pci.h          | 12 ++++---
> >  drivers/pci/pcie/portdrv.c | 16 ++++-----
> >  drivers/pci/remove.c       |  2 +-
> >  include/linux/pci.h        |  3 +-
> >  8 files changed, 89 insertions(+), 47 deletions(-)
> > ---
> > base-commit: 705c1da8fa4816fb0159b5602fef1df5946a3ee2
> > change-id: 20240320-pci-bridge-d3-092e2beac438
> >
> > Best regards,
> > --
> > Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> >
>
> --
> =E0=AE=AE=E0=AE=A3=E0=AE=BF=E0=AE=B5=E0=AE=A3=E0=AF=8D=E0=AE=A3=E0=AE=A9=
=E0=AF=8D =E0=AE=9A=E0=AE=A4=E0=AE=BE=E0=AE=9A=E0=AE=BF=E0=AE=B5=E0=AE=AE=
=E0=AF=8D

