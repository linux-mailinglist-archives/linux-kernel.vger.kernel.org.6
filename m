Return-Path: <linux-kernel+bounces-272008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25B299455D8
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 03:04:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57C5C1C226B9
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 01:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B922D2EE;
	Fri,  2 Aug 2024 01:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="C6u3TiEs"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF6CA2D
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 01:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722560680; cv=none; b=tXzbGE9/UDjGgDA8k1WN78lhERzoeKAqI2zb2gZPjabpmekxpNWwp5o8WyJO4nQpYhJkCKyrlDLFpv2GPDho+Y1oNm7Tk/oy0dV/XS33iuGn8VDd9SVe2AWtW2SX9VI4TsiMztRDwQWoKBSgBDVKC4v5unEj3Ba8JU5QNAeomMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722560680; c=relaxed/simple;
	bh=qhM7Rkoo/wjgyet+sVe9Ojyo+y5fgscuRJSoHTiEu8U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QdUCHBHAQs8Yy9a/tXUGjXNr/65Cq2+NjtxHGDcJU1RJfDA3NLtLbAjQVUnPFucIZ8cYpKx1NNLR0L/7ioIeFXxIsDzxczCSXQ3/thu9+ubFijGR87IrLQIisUEuN8a1MnrHB1E6o2XdI9HgFXoiMmSkOz+9uNjsjv+5oytIqPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=C6u3TiEs; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id B43B83FA52
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 01:04:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1722560675;
	bh=+ZPWBr+Q3IbRsWrbuL1qMThGGqMu0789Q6IwfLEtpY0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=C6u3TiEs6lDSDdxmybzHZQlJCd7J/XJLc5um/lcb9lSZzyxHuczFKjZxF23FpHoXW
	 AA/rpusDAbdk9zT0LCvsDkOMkeP0zL4WppE0U+fAB4MREi3ONKGeAHOQ+r6mfBYPzz
	 yOz+QFxfP+Tez5rD7ldyyUQhj6vPPxIz/t2vEvI9w2vzEQdiql99j76RMxwPxo/+Yd
	 BpmKYmL/cB8pf1M0+HXN9XWSIarWDsY1JY3MQqtF+CV6LDKhp1maFRXy2gD1iktN6F
	 Ne6ukZCnYyLaFtE/aHZzQkmyVKRIAsY/BVdsfPdRqIRzNG+DEDs/HfsK3Vgm9qy2SB
	 EQALf93QCPAMA==
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2cb4bcdd996so2874318a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 18:04:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722560674; x=1723165474;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+ZPWBr+Q3IbRsWrbuL1qMThGGqMu0789Q6IwfLEtpY0=;
        b=kXQA8KgEIzUJN4t4xbALyS65XJn9z1Jm73O9tS6d6j9HOlTYCNh89xnj7jr6jJ4YZg
         HIddPq2CdcnAV/pm5lObWQTl5qjTO6QxZIPINIz7ihhdu4EKHz7JRJMs+Z/NKRQQi1oo
         3z4HmCORTcNCm/jWTe/UzinGwgnNE1Z0uJY8Kbh8oBIUQMIfqwtJW+UTGKfDLne+l1T2
         1uVs4ppYGNGkKT2uDMgw4ZnQjk/gmTGGo3nNScSW7M8f6V9dy85e6YEXpZwlKA+6Q3Pf
         5/M3TrkbBQNCHWUexlck2nYTzKoGRbUd6fXsd+XuCXBiwwApQ10CHAH8iBYrqLoaPCPg
         6Eiw==
X-Forwarded-Encrypted: i=1; AJvYcCUOohLREznBz6/jBbq7ekk++AnVYaQhBnTuabLrUvADZAs/Ji6IFzYyqIackjQJGnTiSchXv+CtJvwL6IFqFZ9iZ1/wE8o1ViN5DRHJ
X-Gm-Message-State: AOJu0YxGuSHAvgDAASN9HLSyabQ44ZzXbMkOBGot+lX2QEySacuxFhvk
	CkJh9+bw7Ndm8Xi66HA6K25IpjQCPS/2h2dHGSNJ9O/hlaf0RqKIl8W8kuR57f5qjU+4E2XYTe8
	fSZ3S5QfKZacW7AIjCFT/y/o5NlTFTicEYC04ghO9Dtm4MtP9z9drlWUszqS+FUePwYzvXbWK8Y
	BVe3j9avCw/pHOCKSjHqPRo8l3aWmWP5hbIb0yu2fd16akTZ3VDxbg
X-Received: by 2002:a17:90a:bb81:b0:2cd:40cf:5ebd with SMTP id 98e67ed59e1d1-2cffa0ae819mr2788366a91.5.1722560674118;
        Thu, 01 Aug 2024 18:04:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHi1XbnIuGlbutYrJYDsV2mpUlSCSSjGOSbhqAhT5XfgwjkLY9Xoo5Lh/RtULrVhIg4zRHNi+WyHSEwurJ43oQ=
X-Received: by 2002:a17:90a:bb81:b0:2cd:40cf:5ebd with SMTP id
 98e67ed59e1d1-2cffa0ae819mr2788327a91.5.1722560673667; Thu, 01 Aug 2024
 18:04:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240530085227.91168-2-kai.heng.feng@canonical.com> <20240802000414.GA127813@bhelgaas>
In-Reply-To: <20240802000414.GA127813@bhelgaas>
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Date: Fri, 2 Aug 2024 09:04:21 +0800
Message-ID: <CAAd53p66NNOaD=KdvW911gKSf+QOSCik9c-dJmn6zQqXaoFQXw@mail.gmail.com>
Subject: Re: [PATCH 2/2] PCI: vmd: Let OS control ASPM for devices under VMD domain
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, nirmal.patel@linux.intel.com, 
	jonathan.derrick@linux.dev, ilpo.jarvinen@linux.intel.com, 
	david.e.box@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 2, 2024 at 8:04=E2=80=AFAM Bjorn Helgaas <helgaas@kernel.org> w=
rote:
>
> On Thu, May 30, 2024 at 04:52:27PM +0800, Kai-Heng Feng wrote:
> > Intel SoC cannot reach lower power states when mapped VMD PCIe bridges
> > and NVMe devices don't have ASPM configured.
> >
> > So set aspm_os_control attribute to let OS really enable ASPM for those
> > devices.
> >
> > Fixes: f492edb40b54 ("PCI: vmd: Add quirk to configure PCIe ASPM and LT=
R")
>
> I assume f492edb40b54 was tested and worked at the time.  Is the
> implication that newer Intel SoCs have added more requirements for
> getting to low power states, since __pci_enable_link_state() would
> have warned and done nothing even then?
>
> Or maybe this is a new system that sets ACPI_FADT_NO_ASPM, and
> f492edb40b54 was tested on systems that did *not* set
> ACPI_FADT_NO_ASPM?

I believe it's the case here. Vendors may or may not set
ACPI_FADT_NO_ASPM, so f492edb40b54 works on some systems but not
others.

Kai-Heng

>
> > Link: https://lore.kernel.org/linux-pm/218aa81f-9c6-5929-578d-8dc15f83d=
d48@panix.com/
> > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > ---
> >  drivers/pci/controller/vmd.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.=
c
> > index 87b7856f375a..1dbc525c473f 100644
> > --- a/drivers/pci/controller/vmd.c
> > +++ b/drivers/pci/controller/vmd.c
> > @@ -751,6 +751,8 @@ static int vmd_pm_enable_quirk(struct pci_dev *pdev=
, void *userdata)
> >       if (!(features & VMD_FEAT_BIOS_PM_QUIRK))
> >               return 0;
> >
> > +     pdev->aspm_os_control =3D 1;
> > +
> >       pci_enable_link_state_locked(pdev, PCIE_LINK_STATE_ALL);
> >
> >       pos =3D pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_LTR);
> > --
> > 2.43.0
> >

