Return-Path: <linux-kernel+bounces-278533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EAFD794B189
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 22:41:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A395A284812
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 20:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A220613D265;
	Wed,  7 Aug 2024 20:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bb/ufnk2"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF23145B2E
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 20:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723063249; cv=none; b=nq+QiDsMk/xg02UO3ZrvNnsPYeQ9iOF6upF/aWFLa28txe/wWlK+xZGJtPqQHKd94SiwWkHnflJgiAGWWwhNcv6pqbvqhWozGXI8nzH2iHAuCKppnwyTVxe4zdbUY4fhfw1fM2zlTPwcouQhHJwgzo4ut/Sl+Rr3XSpwX8+qfg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723063249; c=relaxed/simple;
	bh=55YDRrtOt4tmON+c01+nExQ7zCVLeDHsxIp4g/SLcaQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K5yNACy2gt72Yi5HsqCVrob+W5/fzUhXSIzd0nXOOfG1Rbs10ux6gUrkU4iakL+H0bXMqCLiz+LeNaACFzX4otqinNWwFyqDG/xUX/DonUXp4X4IjMq5fy1r38+gMeE8+V7u/HHkURcjQxfhbXC4oaaHzkkq4OLCPZmcuU9DWRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Bb/ufnk2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723063247;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NuT7wPEgPegJMdZEEQjcUmkz4FbQk34dp23i6B4YFbM=;
	b=Bb/ufnk2XD9i866XW1ip5xypTf6HjwpmvKbHDTLKY194Rwyg6ghxPHueiXIEDC0xkIiaF6
	iYMQcwon0djtW6CfUKshqVX2pu9ucCQHymz3wWsbhHkf5EDsyTc07NZ3ix8Wt6leDzeGwF
	+xraer4WVCP9fWc8vxrSBdoFzR68bA0=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-CsC5JrEjMbK7xaFk-UmFOw-1; Wed, 07 Aug 2024 16:40:45 -0400
X-MC-Unique: CsC5JrEjMbK7xaFk-UmFOw-1
Received: by mail-yb1-f198.google.com with SMTP id 3f1490d57ef6-e035949cc4eso489960276.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 13:40:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723063245; x=1723668045;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NuT7wPEgPegJMdZEEQjcUmkz4FbQk34dp23i6B4YFbM=;
        b=arPaOK1xhtI8ZhZ/xmq9ytQeGrGTMBsAhiWcEm4QwPOPT3u502l6HdCNltYcufRYTo
         UgnGYTFjkzUlE+GzvZDSbjISkGrSOgrvsg1wN30TOJa4Me26BnTqjqOxdlSzFpKInoPA
         F610fUBj/9/pD+2+RpeJaVJ5xj/MGDPlLryoyLz5YtzHX+xebVTUHR0ZOqzN5pI8KGCp
         Kln+PZ/TBJCQZcAoFB9v1CNkPlc1jN/H/2780vJlVSlVSP46RkirNFXVa/kpuhLRugh+
         5xlC90CPeF2n78eMglZ0MuBQ5bbt+4bZDJG5gxd5n4NBXzYoUXqTZ5JsxQoHwX5/tCSL
         1Dvw==
X-Forwarded-Encrypted: i=1; AJvYcCV+l5STkTH9o/2BbWHo2F9aLaGoUb7+yxn8xdl/QEqwurjs83j5ewwy9cjFy2h1xMMoxb2x+0hpYDSNtXnFEZezw7cHn2JrLO0MCkzl
X-Gm-Message-State: AOJu0YyHefkqEXYBg+DcGL8ahg79ny1G1+OXWxvPhXGmSZIfetb/Vz0s
	Fx6KzM0/QPdnss62GI8+KUKaUckz7aHJKNf7Xa4tpzqUd6s1HQ7PQ82gdyKXc8+eZ60SZ5+Elzu
	0dhEdFmzYodCo1U2t5e+16+fge66hG9w4nQycmC5XB2CQDcWnZK6p73l7d2eSvNQaKZRqa6D1S/
	puJsWtWqjQw3+EFCUj/xc+M+1cColTMEUyl1e+
X-Received: by 2002:a05:6902:108f:b0:e0b:e6da:83f2 with SMTP id 3f1490d57ef6-e0be6da8570mr20071286276.22.1723063245077;
        Wed, 07 Aug 2024 13:40:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE7o6e1QQzQm+QZaPjztNenu/RRqVV+1JEdYvx5ZzNxvqvMPsnDM1pqizaWMoZmY8u96PT7o6OULbbwhXo7QHM=
X-Received: by 2002:a05:6902:108f:b0:e0b:e6da:83f2 with SMTP id
 3f1490d57ef6-e0be6da8570mr20071263276.22.1723063244750; Wed, 07 Aug 2024
 13:40:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240807083018.8734-2-pstanner@redhat.com> <20240807202431.GA110503@bhelgaas>
In-Reply-To: <20240807202431.GA110503@bhelgaas>
From: David Airlie <airlied@redhat.com>
Date: Thu, 8 Aug 2024 06:40:31 +1000
Message-ID: <CAMwc25q+SnSBFfuKcmw8W39CmsLn4V0ZCuuSbkGTc961WRGhoQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] PCI: Deprecate pcim_iomap_regions() in favor of pcim_iomap_region()
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Philipp Stanner <pstanner@redhat.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Jocelyn Falempe <jfalempe@redhat.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Bjorn Helgaas <bhelgaas@google.com>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 8, 2024 at 6:33=E2=80=AFAM Bjorn Helgaas <helgaas@kernel.org> w=
rote:
>
> On Wed, Aug 07, 2024 at 10:30:18AM +0200, Philipp Stanner wrote:
> > pcim_iomap_regions() is a complicated function that uses a bit mask to
> > determine the BARs the user wishes to request and ioremap. Almost all
> > users only ever set a single bit in that mask, making that mechanism
> > questionable.
> >
> > pcim_iomap_region() is now available as a more simple replacement.
> >
> > Make pcim_iomap_region() a public function.
> >
> > Mark pcim_iomap_regions() as deprecated.
> >
> > Signed-off-by: Philipp Stanner <pstanner@redhat.com>
>
> The interesting part of this little series is in ast_drv.c, but there
> may be similar conversions for other drivers coming as well.
>
> To avoid races during the merge window, I propose merging this via the
> PCI tree so I can ensure that any other conversions happen after
> pcim_iomap_region() becomes public.
>
> That would require an ack from Dave.  But if you'd rather take this
> yourself, Dave, here's my ack for the PCI piece:
>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>

I'm fine with it going in via pci.

Acked-by: Dave Airlie <airlied@redhat.com>

Dave.

>
> > ---
> >  drivers/pci/devres.c | 8 ++++++--
> >  include/linux/pci.h  | 2 ++
> >  2 files changed, 8 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/pci/devres.c b/drivers/pci/devres.c
> > index 3780a9f9ec00..89ec26ea1501 100644
> > --- a/drivers/pci/devres.c
> > +++ b/drivers/pci/devres.c
> > @@ -728,7 +728,7 @@ EXPORT_SYMBOL(pcim_iounmap);
> >   * Mapping and region will get automatically released on driver detach=
. If
> >   * desired, release manually only with pcim_iounmap_region().
> >   */
> > -static void __iomem *pcim_iomap_region(struct pci_dev *pdev, int bar,
> > +void __iomem *pcim_iomap_region(struct pci_dev *pdev, int bar,
> >                                      const char *name)
> >  {
> >       int ret;
> > @@ -761,6 +761,7 @@ static void __iomem *pcim_iomap_region(struct pci_d=
ev *pdev, int bar,
> >
> >       return IOMEM_ERR_PTR(ret);
> >  }
> > +EXPORT_SYMBOL(pcim_iomap_region);
> >
> >  /**
> >   * pcim_iounmap_region - Unmap and release a PCI BAR
> > @@ -783,7 +784,7 @@ static void pcim_iounmap_region(struct pci_dev *pde=
v, int bar)
> >  }
> >
> >  /**
> > - * pcim_iomap_regions - Request and iomap PCI BARs
> > + * pcim_iomap_regions - Request and iomap PCI BARs (DEPRECATED)
> >   * @pdev: PCI device to map IO resources for
> >   * @mask: Mask of BARs to request and iomap
> >   * @name: Name associated with the requests
> > @@ -791,6 +792,9 @@ static void pcim_iounmap_region(struct pci_dev *pde=
v, int bar)
> >   * Returns: 0 on success, negative error code on failure.
> >   *
> >   * Request and iomap regions specified by @mask.
> > + *
> > + * This function is DEPRECATED. Do not use it in new code.
> > + * Use pcim_iomap_region() instead.
> >   */
> >  int pcim_iomap_regions(struct pci_dev *pdev, int mask, const char *nam=
e)
> >  {
> > diff --git a/include/linux/pci.h b/include/linux/pci.h
> > index 4cf89a4b4cbc..fc30176d28ca 100644
> > --- a/include/linux/pci.h
> > +++ b/include/linux/pci.h
> > @@ -2292,6 +2292,8 @@ static inline void pci_fixup_device(enum pci_fixu=
p_pass pass,
> >  void __iomem *pcim_iomap(struct pci_dev *pdev, int bar, unsigned long =
maxlen);
> >  void pcim_iounmap(struct pci_dev *pdev, void __iomem *addr);
> >  void __iomem * const *pcim_iomap_table(struct pci_dev *pdev);
> > +void __iomem *pcim_iomap_region(struct pci_dev *pdev, int bar,
> > +                                    const char *name);
> >  int pcim_iomap_regions(struct pci_dev *pdev, int mask, const char *nam=
e);
> >  int pcim_iomap_regions_request_all(struct pci_dev *pdev, int mask,
> >                                  const char *name);
> > --
> > 2.45.2
> >
>


