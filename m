Return-Path: <linux-kernel+bounces-361082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F4DD99A332
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 14:04:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0B741C210C5
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 12:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27A30217312;
	Fri, 11 Oct 2024 12:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HmzvnJGf"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1991821502D
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 12:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728648228; cv=none; b=FjITvfsA33A+wezZh4V62w5nr3V7oAqHzK8n/19LGPLYe+hC/7rivxUeEZs82BSn5oGuB1R6hHFhPwHoQE3+LQnK4N0wm4mnjx17sTAeTiyZ23fqub2Gf6mHJldRNibMEdr6c/ZKYcQP15w/87h+il4vzYDzTjwGxZtAv+AM7xM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728648228; c=relaxed/simple;
	bh=JWzZMjqpp/xPZ1MmHfjs2qnl7WyX+6LRJNU05aMLIA0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dbIyMqr5FsOnU/VT7B5cQaIF3mo1389Cnjh03DOpq1dflbse6E/rY/gy5PWn0DAxP6YJwm0DyLSKbG5eGOOnPXL5dtulxGFm4cPsTQOOl52AbdZ9RYznGtuIGZD+c16XFJelDNmr0FP77tCDeMes5EcV8R1nIRrjdf2rMBsteKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HmzvnJGf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728648225;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3I5lHL6mHTQWMds6pJC4dZUawdNZoxrsfeR6hWpkDqM=;
	b=HmzvnJGfYk4/e7bD5ZZtE1b+i4kla43u+mtoVdV3eKIMww2ZKVEOWNRVmCAFhxkaud0pyw
	62ACAt5xy88XuHaqmH9HbSsBJTLndAHJoeBq1lBq+gFVhHa8vfkJfotvh9lLvIjqjSQOes
	3b7LgyMw9NRjHxYi4hxXNfddwU04vxg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-148-VdWwTtgfMbCNeDRYeuUM_w-1; Fri, 11 Oct 2024 08:03:44 -0400
X-MC-Unique: VdWwTtgfMbCNeDRYeuUM_w-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-42cb857fc7dso11848665e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 05:03:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728648223; x=1729253023;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3I5lHL6mHTQWMds6pJC4dZUawdNZoxrsfeR6hWpkDqM=;
        b=ZobkBQltnTDVGCQ6BlgUdSl0FzHuPIIyEcA5+GueodD3PXpUa7oWvJNNBOhyloA5/a
         ZJUn7hOocArIzOj1OawXfy2HwMHNXWdgWZ35HstrqJkfazWTGTlMdUplZpUkzc3rsksP
         SvzP00m2p1rJnuo4Z4uFRt9U9ucFmPA1u0+ud/v3OfjjZnru0cyiWa8TAYRQ0jCKN0dH
         IbhNyfyFXupVOiJZC/FghUoMAGYhqeVtei8PAF2nuOz4LBwL+Yil19MIoFIr9qPrK1+O
         mh88FSIakRwGMXm9lF5Gc1AB6bFO/sn9tvFNJ8ZxbGWR9tSxeQeBF1+IYxMv9pAIB9ra
         TOUg==
X-Forwarded-Encrypted: i=1; AJvYcCV2UwqI8SpMyvnVU4AzqUziOHGrUjkDc/HeubjYKqm68z9oiFag2pzoatf1Y/z5Kt10KRxo6hwmqllNqPc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0jw84XeRUdGa2zK1ygvWQ299zhZUJL+fgv9nYzqtdN1t7SL2Z
	p7lJSYxEEAXd8n2wWO7XWuWZFq4vPmsq5ECKPwUe9qecFUJhnxTfGHeGQiSwbJvPUcUmxdKXXSz
	XX0Xl7pi2NWDQBH7Y7LrEdB/PaeYDA8uqAhw8TX69HCuDet4Wv83u2Qm64MRl8w==
X-Received: by 2002:a05:600c:1d1c:b0:42c:c003:edd1 with SMTP id 5b1f17b1804b1-4311decaa48mr19192015e9.10.1728648222810;
        Fri, 11 Oct 2024 05:03:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IExbuVJr4JGcXjTZsUgf0Q1cJGFJf/2hMvz1Z5drCky7hS/DrFylID4EQn0lZzCFTWpUUq6Zw==
X-Received: by 2002:a05:600c:1d1c:b0:42c:c003:edd1 with SMTP id 5b1f17b1804b1-4311decaa48mr19191405e9.10.1728648222253;
        Fri, 11 Oct 2024 05:03:42 -0700 (PDT)
Received: from eisenberg.fritz.box ([2001:16b8:3d05:4700:3e59:7d70:cabd:144b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-430ccf51770sm73523925e9.22.2024.10.11.05.03.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 05:03:41 -0700 (PDT)
Message-ID: <914de38f0b6b3d2ddf98c16e427085732bebfd4a.camel@redhat.com>
Subject: Re: [RFC PATCH 01/13] PCI: Prepare removing devres from pci_intx()
From: Philipp Stanner <pstanner@redhat.com>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>, 
 Sergey Shtylyov <s.shtylyov@omp.ru>, Basavaraj Natikar
 <basavaraj.natikar@amd.com>, Jiri Kosina <jikos@kernel.org>,  Benjamin
 Tissoires <bentiss@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Alex Dubov <oakad@yahoo.com>,
 Sudarsana Kalluru <skalluru@marvell.com>, Manish Chopra
 <manishc@marvell.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Rasesh Mody <rmody@marvell.com>,
 GR-Linux-NIC-Dev@marvell.com, Igor Mitsyanko <imitsyanko@quantenna.com>,
 Sergey Matyukevich <geomatsi@gmail.com>, Kalle Valo <kvalo@kernel.org>,
 Sanjay R Mehta <sanju.mehta@amd.com>, Shyam Sundar S K
 <Shyam-sundar.S-k@amd.com>, Jon Mason <jdmason@kudzu.us>, Dave Jiang
 <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, Bjorn Helgaas
 <bhelgaas@google.com>, Juergen Gross <jgross@suse.com>, Stefano Stabellini
 <sstabellini@kernel.org>, Oleksandr Tyshchenko
 <oleksandr_tyshchenko@epam.com>,  Jaroslav Kysela <perex@perex.cz>, Takashi
 Iwai <tiwai@suse.com>, Mario Limonciello <mario.limonciello@amd.com>, Chen
 Ni <nichen@iscas.ac.cn>, Ricky Wu <ricky_wu@realtek.com>, Al Viro
 <viro@zeniv.linux.org.uk>, Breno Leitao <leitao@debian.org>, Kevin Tian
 <kevin.tian@intel.com>, Thomas Gleixner <tglx@linutronix.de>, Ilpo
 =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>, Mostafa Saleh
 <smostafa@google.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Hannes Reinecke <hare@suse.de>, John Garry <john.g.garry@oracle.com>,
 Soumya Negi <soumya.negi97@gmail.com>, Jason Gunthorpe <jgg@ziepe.ca>, Yi
 Liu <yi.l.liu@intel.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, 
 Christian Brauner <brauner@kernel.org>, Ankit Agrawal <ankita@nvidia.com>,
 Reinette Chatre <reinette.chatre@intel.com>, Eric Auger
 <eric.auger@redhat.com>, Ye Bin <yebin10@huawei.com>, Marek
 =?ISO-8859-1?Q?Marczykowski-G=F3recki?= <marmarek@invisiblethingslab.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Kai Vehmanen
 <kai.vehmanen@linux.intel.com>,  Peter Ujfalusi
 <peter.ujfalusi@linux.intel.com>, Rui Salvaterra <rsalvaterra@gmail.com>,
 Marc Zyngier <maz@kernel.org>, linux-ide@vger.kernel.org,
 linux-kernel@vger.kernel.org,  linux-input@vger.kernel.org,
 netdev@vger.kernel.org,  linux-wireless@vger.kernel.org,
 ntb@lists.linux.dev, linux-pci@vger.kernel.org, 
 linux-staging@lists.linux.dev, kvm@vger.kernel.org, 
 xen-devel@lists.xenproject.org, linux-sound@vger.kernel.org
Date: Fri, 11 Oct 2024 14:03:39 +0200
In-Reply-To: <20241010114304.064f5d3d.alex.williamson@redhat.com>
References: <20241009083519.10088-1-pstanner@redhat.com>
	 <20241009083519.10088-2-pstanner@redhat.com>
	 <20241010114304.064f5d3d.alex.williamson@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-10-10 at 11:43 -0600, Alex Williamson wrote:
> On Wed,=C2=A0 9 Oct 2024 10:35:07 +0200
> Philipp Stanner <pstanner@redhat.com> wrote:
>=20
> > pci_intx() is a hybrid function which sometimes performs devres
> > operations, depending on whether pcim_enable_device() has been used
> > to
> > enable the pci_dev. This sometimes-managed nature of the function
> > is
> > problematic. Notably, it causes the function to allocate under some
> > circumstances which makes it unusable from interrupt context.
> >=20
> > To, ultimately, remove the hybrid nature from pci_intx(), it is
> > first
> > necessary to provide an always-managed and a never-managed version
> > of that function. Then, all callers of pci_intx() can be ported to
> > the
> > version they need, depending whether they use pci_enable_device()
> > or
> > pcim_enable_device().
> >=20
> > An always-managed function exists, namely pcim_intx(), for which
> > __pcim_intx(), a never-managed version of pci_intx() had been
> > implemented.
> >=20
> > Make __pcim_intx() a public function under the name
> > pci_intx_unmanaged(). Make pcim_intx() a public function.
> >=20
> > Signed-off-by: Philipp Stanner <pstanner@redhat.com>
> > ---
> > =C2=A0drivers/pci/devres.c | 24 +++---------------------
> > =C2=A0drivers/pci/pci.c=C2=A0=C2=A0=C2=A0 | 26 ++++++++++++++++++++++++=
++
> > =C2=A0include/linux/pci.h=C2=A0 |=C2=A0 2 ++
> > =C2=A03 files changed, 31 insertions(+), 21 deletions(-)
> >=20
> > diff --git a/drivers/pci/devres.c b/drivers/pci/devres.c
> > index b133967faef8..475a3ae5c33f 100644
> > --- a/drivers/pci/devres.c
> > +++ b/drivers/pci/devres.c
> > @@ -411,31 +411,12 @@ static inline bool mask_contains_bar(int
> > mask, int bar)
> > =C2=A0	return mask & BIT(bar);
> > =C2=A0}
> > =C2=A0
> > -/*
> > - * This is a copy of pci_intx() used to bypass the problem of
> > recursive
> > - * function calls due to the hybrid nature of pci_intx().
> > - */
> > -static void __pcim_intx(struct pci_dev *pdev, int enable)
> > -{
> > -	u16 pci_command, new;
> > -
> > -	pci_read_config_word(pdev, PCI_COMMAND, &pci_command);
> > -
> > -	if (enable)
> > -		new =3D pci_command & ~PCI_COMMAND_INTX_DISABLE;
> > -	else
> > -		new =3D pci_command | PCI_COMMAND_INTX_DISABLE;
> > -
> > -	if (new !=3D pci_command)
> > -		pci_write_config_word(pdev, PCI_COMMAND, new);
> > -}
> > -
> > =C2=A0static void pcim_intx_restore(struct device *dev, void *data)
> > =C2=A0{
> > =C2=A0	struct pci_dev *pdev =3D to_pci_dev(dev);
> > =C2=A0	struct pcim_intx_devres *res =3D data;
> > =C2=A0
> > -	__pcim_intx(pdev, res->orig_intx);
> > +	pci_intx_unmanaged(pdev, res->orig_intx);
> > =C2=A0}
> > =C2=A0
> > =C2=A0static struct pcim_intx_devres *get_or_create_intx_devres(struct
> > device *dev)
> > @@ -472,10 +453,11 @@ int pcim_intx(struct pci_dev *pdev, int
> > enable)
> > =C2=A0		return -ENOMEM;
> > =C2=A0
> > =C2=A0	res->orig_intx =3D !enable;
> > -	__pcim_intx(pdev, enable);
> > +	pci_intx_unmanaged(pdev, enable);
> > =C2=A0
> > =C2=A0	return 0;
> > =C2=A0}
> > +EXPORT_SYMBOL(pcim_intx);
>=20
> What precludes this from _GPL?=C2=A0 Also note that this is now calling a
> GPL symbol, so by default I'd assume it should also be GPL.=C2=A0 Thanks,

Ah right, I overlooked that pci_intx() also has the _GPL version.
Will make consistent.

Thx,
P.

>=20
> Alex
>=20
> > =C2=A0
> > =C2=A0static void pcim_disable_device(void *pdev_raw)
> > =C2=A0{
> > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > index 7d85c04fbba2..318cfb5b5e15 100644
> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c
> > @@ -4476,6 +4476,32 @@ void pci_disable_parity(struct pci_dev *dev)
> > =C2=A0	}
> > =C2=A0}
> > =C2=A0
> > +/**
> > + * pci_intx - enables/disables PCI INTx for device dev, unmanaged
> > version
> > + * @pdev: the PCI device to operate on
> > + * @enable: boolean: whether to enable or disable PCI INTx
> > + *
> > + * Enables/disables PCI INTx for device @pdev
> > + *
> > + * This function behavios identically to pci_intx(), but is never
> > managed with
> > + * devres.
> > + */
> > +void pci_intx_unmanaged(struct pci_dev *pdev, int enable)
> > +{
> > +	u16 pci_command, new;
> > +
> > +	pci_read_config_word(pdev, PCI_COMMAND, &pci_command);
> > +
> > +	if (enable)
> > +		new =3D pci_command & ~PCI_COMMAND_INTX_DISABLE;
> > +	else
> > +		new =3D pci_command | PCI_COMMAND_INTX_DISABLE;
> > +
> > +	if (new !=3D pci_command)
> > +		pci_write_config_word(pdev, PCI_COMMAND, new);
> > +}
> > +EXPORT_SYMBOL_GPL(pci_intx_unmanaged);
> > +
> > =C2=A0/**
> > =C2=A0 * pci_intx - enables/disables PCI INTx for device dev
> > =C2=A0 * @pdev: the PCI device to operate on
> > diff --git a/include/linux/pci.h b/include/linux/pci.h
> > index 573b4c4c2be6..6b8cde76d564 100644
> > --- a/include/linux/pci.h
> > +++ b/include/linux/pci.h
> > @@ -1353,6 +1353,7 @@ int __must_check pcim_set_mwi(struct pci_dev
> > *dev);
> > =C2=A0int pci_try_set_mwi(struct pci_dev *dev);
> > =C2=A0void pci_clear_mwi(struct pci_dev *dev);
> > =C2=A0void pci_disable_parity(struct pci_dev *dev);
> > +void pci_intx_unmanaged(struct pci_dev *pdev, int enable);
> > =C2=A0void pci_intx(struct pci_dev *dev, int enable);
> > =C2=A0bool pci_check_and_mask_intx(struct pci_dev *dev);
> > =C2=A0bool pci_check_and_unmask_intx(struct pci_dev *dev);
> > @@ -2293,6 +2294,7 @@ static inline void pci_fixup_device(enum
> > pci_fixup_pass pass,
> > =C2=A0				=C2=A0=C2=A0=C2=A0 struct pci_dev *dev) { }
> > =C2=A0#endif
> > =C2=A0
> > +int pcim_intx(struct pci_dev *pdev, int enabled);
> > =C2=A0void __iomem *pcim_iomap(struct pci_dev *pdev, int bar, unsigned
> > long maxlen);
> > =C2=A0void __iomem *pcim_iomap_region(struct pci_dev *pdev, int bar,
> > =C2=A0				const char *name);
>=20


