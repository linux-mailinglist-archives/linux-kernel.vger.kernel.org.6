Return-Path: <linux-kernel+bounces-289052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 14FB4954199
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 08:17:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8BB22B24039
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 06:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D891D81ADA;
	Fri, 16 Aug 2024 06:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="INFc+7dC"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA5D640875
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 06:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723789043; cv=none; b=cZTlOfQMIXxCbscpP9PcnynfhODsrsZ8TsZ3SzJjO2NsANWLgP10VQBUxR3tNwn5YN5QdAjXWFBANaZSxvOE/tJAUqWUinGH4Y9g9aSFxGPULqjNOegZyeAYft2QtM7s4p9NLyh+srOA1YjTN+HFHKs06qJhBkZUWnMMfUI4eq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723789043; c=relaxed/simple;
	bh=MiQ7dZ4bs9b3OKw2e7b5GoLROhGISJrbGG6GnN3L/eI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W9Nzcg4GyksCuOPzAMIpzAye64lXZcc9PmcOE1gMycSueypV7lw3B7xhaZgy1uF5LBgcdorc3gsJdDWTsiZ4dAqytcWE275vrRWQqGjm0ZqgF8sr4XMVCrk/Ap4t7vvdgBN5EEc8tN1noY7TQTZfACF7mn6eQx0z42zxKQDT0v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=INFc+7dC; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com [209.85.160.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id B419D3FD39
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 06:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1723789038;
	bh=ehzIyWD4eKlgNDPaY1N9jwRF9mkHpKjwLz4FCtpXUHA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=INFc+7dCypmfTJSQKv0a8Zfnz6e0fD+3qzVRXzBPIQsOpCV9Jx95YGFkfkW06/dDO
	 BoT548DDAZXeYjb09atZjBcxKMGxKGivou+r1pHijBAyiI+ZUZwYSq2wUmtKoiuAj7
	 ZesHp21zFlmP6JmhYsDUU2l8CpzVxjwIVljjJG0+Fx00GfjbMRmTnuYSzK5z7tW3e6
	 mjs8D+19B7GgUwq5T+CaFLxnWbfSOn7ZhJ+5tpi5jO1WQpCT4W+VLtlo+f4/kPaZXK
	 54lnPfLSOKcG/KnZqy0CEhXA0T/oXj8SowwRLupl8p9PQ5U+zAcntbvwU7nuDbsPx/
	 GUVQCjX0cg8qA==
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-2701f8196c2so456820fac.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 23:17:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723789037; x=1724393837;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ehzIyWD4eKlgNDPaY1N9jwRF9mkHpKjwLz4FCtpXUHA=;
        b=c0d9xmLJxTjdBhBMlpRhHrUpD/waBy0IstYqxa1uqkhIFEKalr9z7BmFkvW6Pa16pj
         3XniRtX8qlmhfof99NNw/SuePHFiFA4V8a4UEwaFCz0RrPZZp4zULTN75NaGnZQkqd2l
         b6rDdP+ly5tu2STiHg+eDeY7goJ77vFG9H5yehYxJ0bdvV4PeDh3oJ30Dy3rKzz85bTh
         NwLOLkMiLZ4k2b+zuEbygaTVDZ0kXmCI3YO29UQKWQ+0gmm4qThzo3nFb62XZKWLz7bB
         8Xf/JZfidjeR0y2zI03BjCueZvqf7bsueBw0t0V3Au9dap93fn7VKd892Q00L91HYm0b
         sDtw==
X-Forwarded-Encrypted: i=1; AJvYcCWtTA2rvM/oqWi1970RydSmOCpYfa2npO82ctUsxedIpLaYARGApmzsGnUDYt6C4JSKSorq/5yOBiN38U34lzsI8tC55FThQn2iymVq
X-Gm-Message-State: AOJu0Ywvi7QEWXRMO1+VGjoxQ7WqAvefnQcj4f83OkOt/C7F3O8sEV+l
	dh0FnsqFwwkg0jBhIOtowQenCuoNsx27ufVtlOVYbH7d5rLHub5PQgmNkDT/TLFDwBOS2PrvBsA
	6rAj5/zVb4H3gCCcXH01XUTxhrOE+C/tGrTvF4PT39ZiEK1fben+osJGeUNkf0OEOGB9ZOLjAC0
	5EENGf52nsVVcsUbwBBvYhZZu+mqXE56MqHQBXupsOqJxO/5C4CWSD
X-Received: by 2002:a05:6870:470a:b0:261:f8e:a37a with SMTP id 586e51a60fabf-2701c39da02mr2249186fac.14.1723789037438;
        Thu, 15 Aug 2024 23:17:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG2xGp8G9OGDgd8o1nFBkFJc8sBm5ZT9zC4ZpSfXcDwUlR+eH3YD+8Upb/5ElZY7PKTk6AxWgdQaRyG+568zQI=
X-Received: by 2002:a05:6870:470a:b0:261:f8e:a37a with SMTP id
 586e51a60fabf-2701c39da02mr2249170fac.14.1723789037058; Thu, 15 Aug 2024
 23:17:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240530085227.91168-2-kai.heng.feng@canonical.com>
 <20240802000414.GA127813@bhelgaas> <CAAd53p66NNOaD=KdvW911gKSf+QOSCik9c-dJmn6zQqXaoFQXw@mail.gmail.com>
In-Reply-To: <CAAd53p66NNOaD=KdvW911gKSf+QOSCik9c-dJmn6zQqXaoFQXw@mail.gmail.com>
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Date: Fri, 16 Aug 2024 14:17:04 +0800
Message-ID: <CAAd53p4NHoqt1=LsSpKS8CMF_-BHg-N_nCF3F5qZpkWDNohU1w@mail.gmail.com>
Subject: Re: [PATCH 2/2] PCI: vmd: Let OS control ASPM for devices under VMD domain
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, nirmal.patel@linux.intel.com, 
	jonathan.derrick@linux.dev, ilpo.jarvinen@linux.intel.com, 
	david.e.box@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Bjorn,

On Fri, Aug 2, 2024 at 9:04=E2=80=AFAM Kai-Heng Feng
<kai.heng.feng@canonical.com> wrote:
>
> On Fri, Aug 2, 2024 at 8:04=E2=80=AFAM Bjorn Helgaas <helgaas@kernel.org>=
 wrote:
> >
> > On Thu, May 30, 2024 at 04:52:27PM +0800, Kai-Heng Feng wrote:
> > > Intel SoC cannot reach lower power states when mapped VMD PCIe bridge=
s
> > > and NVMe devices don't have ASPM configured.
> > >
> > > So set aspm_os_control attribute to let OS really enable ASPM for tho=
se
> > > devices.
> > >
> > > Fixes: f492edb40b54 ("PCI: vmd: Add quirk to configure PCIe ASPM and =
LTR")
> >
> > I assume f492edb40b54 was tested and worked at the time.  Is the
> > implication that newer Intel SoCs have added more requirements for
> > getting to low power states, since __pci_enable_link_state() would
> > have warned and done nothing even then?
> >
> > Or maybe this is a new system that sets ACPI_FADT_NO_ASPM, and
> > f492edb40b54 was tested on systems that did *not* set
> > ACPI_FADT_NO_ASPM?
>
> I believe it's the case here. Vendors may or may not set
> ACPI_FADT_NO_ASPM, so f492edb40b54 works on some systems but not
> others.

Do you think this is code is ready? Or is there any improvement should be m=
ade?

Kai-Heng

>
> Kai-Heng
>
> >
> > > Link: https://lore.kernel.org/linux-pm/218aa81f-9c6-5929-578d-8dc15f8=
3dd48@panix.com/
> > > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > > ---
> > >  drivers/pci/controller/vmd.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vm=
d.c
> > > index 87b7856f375a..1dbc525c473f 100644
> > > --- a/drivers/pci/controller/vmd.c
> > > +++ b/drivers/pci/controller/vmd.c
> > > @@ -751,6 +751,8 @@ static int vmd_pm_enable_quirk(struct pci_dev *pd=
ev, void *userdata)
> > >       if (!(features & VMD_FEAT_BIOS_PM_QUIRK))
> > >               return 0;
> > >
> > > +     pdev->aspm_os_control =3D 1;
> > > +
> > >       pci_enable_link_state_locked(pdev, PCIE_LINK_STATE_ALL);
> > >
> > >       pos =3D pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_LTR);
> > > --
> > > 2.43.0
> > >

