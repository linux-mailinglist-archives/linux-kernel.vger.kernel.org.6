Return-Path: <linux-kernel+bounces-263924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3661093DC69
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 02:21:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 875A9B2AECA
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 00:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D5541552F5;
	Fri, 26 Jul 2024 23:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CtJDPhIC"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC10E14B07B
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 23:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722038377; cv=none; b=fiHLAiiXD8j5e5n2NBvlnBMlubZ9kHhJ8+4lwFg5wO+N+3YI4fE+m7J6CEI9M9u7PGfj6rs7nsdbdXeEspyvKvyYcnKZZQ3wnPSj63i3KI2ifKx41E5etMUL1Avs12JUjZ4j4X2xG7FfHn1YiGzcGXLaOkldeybS1AvJT8Q1PJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722038377; c=relaxed/simple;
	bh=m7LuLCjQ/j+TTkkT59oo8ZrDtTBwZjxarsE1h/MTodw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=grSpXeogbDSOuJOVyXqJlvSAkF2FdgU4SM8+ffKn2QAhimIhdjz/pcPZE/a0T5O/w1m3OTdwlRsXOceaXKeJm2zQQ2+b236BKDrpoK7y60uO7EEQgTOehPl70J529rU/47xBJ64L4NlKxi4iKYnmVrEFknwtXOGxV+HmGg2/7Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=CtJDPhIC; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-52f01b8738dso1931764e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 16:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1722038374; x=1722643174; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1ALvoJaa39vJJ5aGLOtMJDC5BISEBE6uiZ0PlObc8xs=;
        b=CtJDPhIC3or/V70HepFJBTD6aV0aVdBsNdyZ2RaNrjTJxUqGI8dVv1NyskTD6fuBk+
         Q9dYgzFeauU97rvefQfBuAFd28d3MlM7QsWwpR0FmouUnZ/D2m77LH6/UEdkfBGaSjZd
         W18sN7ot8zuCWcSk4bzZXkNAHq8zYXHWcmmWg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722038374; x=1722643174;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1ALvoJaa39vJJ5aGLOtMJDC5BISEBE6uiZ0PlObc8xs=;
        b=hFS1GR4OUjvdszf2My96UI5n9S4uqsfUqXCSX9nzQQ81n/G8xw2EomOXUMecY5TCoJ
         9vmJsVQlmgzBNKvL8q57M/jIoygVmnvZslED/hw8y/S0XIiye+vzOn6wGvc5PXZkeLAR
         8wDVvFB0215VpmuHYIkmWNQKflMAS9Wj8pWsMCeulWX0KwEEtFHT1oG/RJqibyGr3/Pf
         tEI+E2KAy+MvNjTChKUkZegNH6gTAR6RoW7Gkf14ubfwlZPwmk951rw17STxsfsid3DG
         8HcDPGOQMvKqIgvGdEa1R+f2C5mkIMNewAhZi9tyMmDVQMxQmgxggxywJMjzykvP722T
         t6Sg==
X-Forwarded-Encrypted: i=1; AJvYcCVHF6j+b+Li//kiuZKJ8xo7GihmjG8Iz1poEgsGwFTNhyNYHuy+tG7bGfBTQ4aUzcls/uP9n2cymMDuZDQMIumsXYH6jiyjhrigKVPV
X-Gm-Message-State: AOJu0YzNRCUBRf3S3NfmirExOTeqUXIjh2VWKpir+saY3+WwgoaWwmU4
	15BJJGmpmF0SPGhXwj6CDBFCyiR3p1mX1W1LW91spW8q17u9Kyka1iXFAbYv/Ai64zPBdodrgSq
	atY7GKqcXXomPoEOxU7gPfswdtsuykI9QGrSK
X-Google-Smtp-Source: AGHT+IGOd8Il0pzT52TArreVzxc8P27a7UUPdkqEpoezwz3UFLMxq+teWXsDPYoQh47JNu+b94UHf51MCHK7rHgJsKU=
X-Received: by 2002:a2e:7315:0:b0:2ef:268a:a194 with SMTP id
 38308e7fff4ca-2f12ebc9810mr6755791fa.9.1722038373804; Fri, 26 Jul 2024
 16:59:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240326-pci-bridge-d3-v4-0-f1dce1d1f648@linaro.org>
 <20240511071532.GC6672@thinkpad> <CAJMQK-gBACa0s7qo=sOkK2UJB+9WbNHBkfg4NTxp3dVfjvugSg@mail.gmail.com>
In-Reply-To: <CAJMQK-gBACa0s7qo=sOkK2UJB+9WbNHBkfg4NTxp3dVfjvugSg@mail.gmail.com>
From: Hsin-Yi Wang <hsinyi@chromium.org>
Date: Fri, 26 Jul 2024 16:59:07 -0700
Message-ID: <CAJMQK-giFp69717rby_jYwOJ5p11VxocQzL5eu+XL=GSo-Q0pw@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] PCI: Allow D3Hot for PCI bridges in Devicetree
 based platforms
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, lukas@wunner.de, 
	mika.westerberg@linux.intel.com, Bjorn Helgaas <helgaas@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 26, 2024 at 4:06=E2=80=AFPM Hsin-Yi Wang <hsinyi@chromium.org> =
wrote:
>
> On Fri, Jul 26, 2024 at 4:02=E2=80=AFPM Manivannan Sadhasivam
> <manivannan.sadhasivam@linaro.org> wrote:
> >
> > On Tue, Mar 26, 2024 at 04:18:16PM +0530, Manivannan Sadhasivam wrote:
> > > Hi,
> > >
> > > This series allows D3Hot for PCI bridges in Devicetree based platform=
s.
> > > Even though most of the bridges in Devicetree platforms support D3Hot=
, PCI
> > > core will allow D3Hot only when one of the following conditions are m=
et:
> > >
> > > 1. Platform is ACPI based
> > > 2. Thunderbolt controller is used
> > > 3. pcie_port_pm=3Dforce passed in cmdline
> > >
> > > While options 1 and 2 do not apply to most of the DT based platforms,
> > > option 3 will make the life harder for distro maintainers.
> > >
> > > Initially, I tried to fix this issue by using a Devicetree property [=
1], but
> > > that was rejected by Bjorn and it was concluded that D3Hot should be =
allowed by
> > > default for all the Devicetree based platforms.
> > >
> > > During the review of v3 series, Bjorn noted several shortcomings of t=
he
> > > pci_bridge_d3_possible() API [2] and I tried to address them in this =
series as
> > > well.
> > >
> > > But please note that the patches 2 and 3 needs closer review from ACP=
I and x86
> > > folks since I've splitted the D3Hot and D3Cold handling based on my l=
ittle
> > > understanding of the code.
> > >
> > > Testing
> > > =3D=3D=3D=3D=3D=3D=3D
> > >
> > > This series is tested on SM8450 based development board on top of [3]=
.
> > >
> >
> > Bjorn, a gently ping on this series.
> >
>
> Hi, I was also working on a similar patch to add bridge_d3 to arm
> platforms until I found this series, which is what we need. Also
> kindly ping on this series.
>
> Thanks!
>

Tested-by: Hsin-Yi Wang <hsinyi@chromium.org>

> > - Mani
> >
> > > - Mani
> > >
> > > [1] https://lore.kernel.org/linux-pci/20240214-pcie-qcom-bridge-v3-1-=
3a713bbc1fd7@linaro.org/
> > > [2] https://lore.kernel.org/linux-pci/20240305175107.GA539676@bhelgaa=
s/
> > > [3] https://lore.kernel.org/linux-arm-msm/20240321-pcie-qcom-bridge-d=
ts-v2-0-1eb790c53e43@linaro.org/
> > >
> > > Changes in v4:
> > > - Added pci_bridge_d3_possible() rework based on comments from Bjorn
> > > - Got rid of the DT property and allowed D3Hot by default on all DT p=
latforms
> > >
> > > Changes in v3:
> > > - Fixed kdoc, used of_property_present() and dev_of_node() (Lukas)
> > > - Link to v2: https://lore.kernel.org/r/20240214-pcie-qcom-bridge-v2-=
1-9dd6dbb1b817@linaro.org
> > >
> > > Changes in v2:
> > > - Switched to DT based approach as suggested by Lukas.
> > > - Link to v1: https://lore.kernel.org/r/20240202-pcie-qcom-bridge-v1-=
0-46d7789836c0@linaro.org
> > >
> > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.or=
g>
> > > ---
> > > Manivannan Sadhasivam (4):
> > >       PCI/portdrv: Make use of pci_dev::bridge_d3 for checking the D3=
 possibility
> > >       PCI: Rename pci_bridge_d3_possible() to pci_bridge_d3_allowed()
> > >       PCI: Decouple D3Hot and D3Cold handling for bridges
> > >       PCI: Allow PCI bridges to go to D3Hot on all Devicetree based p=
latforms
> > >
> > >  drivers/pci/bus.c          |  2 +-
> > >  drivers/pci/pci-acpi.c     |  9 ++---
> > >  drivers/pci/pci-sysfs.c    |  2 +-
> > >  drivers/pci/pci.c          | 90 ++++++++++++++++++++++++++++++++----=
----------
> > >  drivers/pci/pci.h          | 12 ++++---
> > >  drivers/pci/pcie/portdrv.c | 16 ++++-----
> > >  drivers/pci/remove.c       |  2 +-
> > >  include/linux/pci.h        |  3 +-
> > >  8 files changed, 89 insertions(+), 47 deletions(-)
> > > ---
> > > base-commit: 705c1da8fa4816fb0159b5602fef1df5946a3ee2
> > > change-id: 20240320-pci-bridge-d3-092e2beac438
> > >
> > > Best regards,
> > > --
> > > Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > >
> >
> > --
> > =E0=AE=AE=E0=AE=A3=E0=AE=BF=E0=AE=B5=E0=AE=A3=E0=AF=8D=E0=AE=A3=E0=AE=
=A9=E0=AF=8D =E0=AE=9A=E0=AE=A4=E0=AE=BE=E0=AE=9A=E0=AE=BF=E0=AE=B5=E0=AE=
=AE=E0=AF=8D

