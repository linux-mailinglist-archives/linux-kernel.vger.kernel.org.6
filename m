Return-Path: <linux-kernel+bounces-315063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3202996BD6A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 14:59:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DA691C24D70
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 12:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08A011DB939;
	Wed,  4 Sep 2024 12:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K5EkVWnD"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB66D1D9D99
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 12:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725454655; cv=none; b=aXMciu5ZVGMkVcetFVUDH2hnvB4Xf4cCaKRbHX+7/U4nmns8iwMqe+qFQO9y2ppflNa4D/I9IDIxTlaJs51kiDLKSXLrVXutdMHYff72FeGxwCdrjXAaNDi6eEJERBQoWH4c3yiy0YCQjk3FqukZ4TYZFn6h++78qBcZ30VdDco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725454655; c=relaxed/simple;
	bh=nAS/Y/Y7RaYODxzBkH7Wcz9UJ1xzt6dWuLQyLqLErwY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B2X7zt+pZR7ONrI2tnRWvdpavdPMiDgPz1XImtJasr3Zfer5+5grDzkD/n8c11tw0SGVSSR90X9AJjiSTnfkqS4f0icaoZYD4Uniytel+fnWIJKf/1nbLvwXq8Gcjrdbt2rUMQDPBfsrQrzMp/ZjYRZoE4WtduL+BFlY3wqYx6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K5EkVWnD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725454652;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hr0QPsQ8kKmsm1us550S0o5dWq5voRCeCjok7fkF5tg=;
	b=K5EkVWnDV1AYestY3XI0zTMnNjlRlMC6XkTsP+maEyau53wO+NNCDvP7Sj7RfSar9E33Ab
	qa3Otk6ZYzzQKaM7WkZhkbbTlPhWHik6+auCT6bMbGb3RVkCnEkEhsu2qPJQ6LGURV/miq
	PRSwxN1z4UpA/g9DbLorqhMQSmHrfL4=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-211-uRgHyuQsMzS1godDkyTDbQ-1; Wed, 04 Sep 2024 08:57:29 -0400
X-MC-Unique: uRgHyuQsMzS1godDkyTDbQ-1
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-39f51259995so711315ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 05:57:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725454649; x=1726059449;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hr0QPsQ8kKmsm1us550S0o5dWq5voRCeCjok7fkF5tg=;
        b=TS9Gvo0BDzV/WXkjjZMkPyj6aG7ElCdNjOkQoGJSHUcDib/6/Zbz8wmAOZUfprwNr3
         S+AdVDP8qo1lvR4//I6kbe/+SkEPfRA9hy6KIsFZvFq07/r397XX0euHy4rujTwpVDvu
         XFxv5Cq8M6wKe2QC+uOa1nRzu7FgFeNLyw/dzh5m1ogn3kenWV49J99iNulWYryWyUtg
         9UAAvKt6jj2N0XDhGP3jPLhW1VOpAhwk2YKGnOUsxKpI2spneulf2tlLe0Nr9p8QL4rt
         9s8d2TUhPxqjyrM1qEgeJeDFmSIXQBpHEj5CVO3ct0o8UKp2phetJ+ptljI19ngdeT/k
         plpQ==
X-Forwarded-Encrypted: i=1; AJvYcCX/pP4CReb8gV3VGTHpmeaPM57I9T1mq/TIeljfBGPVO9HvLiTBfA5O+cO8iEkwf8f6CNTmt8mkybAolMc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYH0FCx9bnayM2NuvKvHKcabU6xi8Vi6E5EvVPKa+8F0s4Z39N
	9wxgLbmSgnty7/ryH0cJDRvFmxnEIyuiWTIfeHln/GJCNgj+/gccbrAcxF324F8XzP6IDZuSSNF
	XlclM2qADvAOiRqjf6zXCcLzz6mxQDW5KTScB4jWx+JlBt3PLTbPz0rRExXhWUA==
X-Received: by 2002:a05:6e02:2187:b0:39f:7a06:6279 with SMTP id e9e14a558f8ab-39f7a0664e1mr11419595ab.5.1725454648808;
        Wed, 04 Sep 2024 05:57:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF5TAzuY2mhgg0UicT/y2Xf563yx0ZJEKUn8JSuLWk5pYKcHxL54Nzyp05Yy9gqgFxJfGCwVg==
X-Received: by 2002:a05:6e02:2187:b0:39f:7a06:6279 with SMTP id e9e14a558f8ab-39f7a0664e1mr11419435ab.5.1725454648323;
        Wed, 04 Sep 2024 05:57:28 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ced2eaccd1sm3106308173.124.2024.09.04.05.57.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 05:57:27 -0700 (PDT)
Date: Wed, 4 Sep 2024 06:57:26 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Philipp Stanner <pstanner@redhat.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Krzysztof =?UTF-8?B?V2lsY3p5xYRz?=
 =?UTF-8?B?a2k=?=  <kwilczynski@kernel.org>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [PATCH] PCI: Fix devres regression in pci_intx()
Message-ID: <20240904065726.1f7275b6.alex.williamson@redhat.com>
In-Reply-To: <2887936e2d655834ea28e07957b1c1ccd9e68e27.camel@redhat.com>
References: <20240725120729.59788-2-pstanner@redhat.com>
	<20240903094431.63551744.alex.williamson@redhat.com>
	<2887936e2d655834ea28e07957b1c1ccd9e68e27.camel@redhat.com>
Organization: Red Hat
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 04 Sep 2024 09:06:37 +0200
Philipp Stanner <pstanner@redhat.com> wrote:

> On Tue, 2024-09-03 at 09:44 -0600, Alex Williamson wrote:
> > On Thu, 25 Jul 2024 14:07:30 +0200
> > Philipp Stanner <pstanner@redhat.com> wrote:
> >  =20
> > > pci_intx() is a function that becomes managed if
> > > pcim_enable_device()
> > > has been called in advance. Commit 25216afc9db5 ("PCI: Add managed
> > > pcim_intx()") changed this behavior so that pci_intx() always leads
> > > to
> > > creation of a separate device resource for itself, whereas earlier,
> > > a
> > > shared resource was used for all PCI devres operations.
> > >=20
> > > Unfortunately, pci_intx() seems to be used in some drivers'
> > > remove()
> > > paths; in the managed case this causes a device resource to be
> > > created
> > > on driver detach.
> > >=20
> > > Fix the regression by only redirecting pci_intx() to its managed
> > > twin
> > > pcim_intx() if the pci_command changes.
> > >=20
> > > Fixes: 25216afc9db5 ("PCI: Add managed pcim_intx()") =20
> >=20
> > I'm seeing another issue from this, which is maybe a more general
> > problem with managed mode.=C2=A0 In my case I'm using vfio-pci to assign
> > an
> > ahci controller to a VM. =20
>=20
> "In my case" doesn't mean OOT, does it? I can't fully follow.

"OOT" Out Of Tree?  No, "In my case" is simply introducing the scenario
in which I see the issue.  vfio-pci is an in-tree driver used to attach
devices to userspace drivers, such as QEMU.  The ahci driver is loaded
during system boot, setting the is_managed flag.  The ahci driver is
then unbound from the device and the vfio-pci driver is bound.  The
vfio-pci driver provides a uAPI for userspace drivers to operate a
device in an an IOMMU protected context.
=20
> > =C2=A0 ahci_init_one() calls pcim_enable_device()
> > which sets is_managed =3D true.=C2=A0 I notice that nothing ever sets
> > is_managed to false.=C2=A0 Therefore now when I call pci_intx() from vf=
io-
> > pci
> > under spinlock, I get a lockdep warning =20
>=20
> I suppose you see the lockdep warning because the new pcim_intx() can=20
> now allocate, whereas before 25216afc9db5 it was pcim_enable_device()
> which allocated *everything* related to PCI devres.
>=20
> >  as I no go through pcim_intx()
> > code after 25216afc9db5=C2=A0 =20
>=20
> You alwas went through pcim_intx()'s logic. The issue seems to be that
> the allocation step was moved.

Unintentionally, yes, I believe so.  vfio-pci is not a managed, devres
driver and therefore had no expectation of using the managed code path.

> > since the previous driver was managed. =20
>=20
> what do you mean by "previous driver"?

As noted, the ahci driver is first bound to the device at boot,
unbound, and the vfio-pci driver bound to the device.  The ahci driver
is the previous driver.

> > =C2=A0 It seems
> > like we should be setting is_managed to false is the driver release
> > path, right? =20
>=20
> So the issue seems to be that the same struct pci_dev can be used by
> different drivers, is that correct?

Yes, and more generically, the driver release should undo everything
that has been configured by the driver probe.

> If so, I think that can be addressed trough having
> pcim_disable_device() set is_managed to false as you suggest.

If that's sufficient and drivers only call pcim_disable_device() in
their release function.  I also note that f748a07a0b64 ("PCI: Remove
legacy pcim_release()") claims that:

  Thanks to preceding cleanup steps, pcim_release() is now not needed
  anymore and can be replaced by pcim_disable_device(), which is the
  exact counterpart to pcim_enable_device().

However, that's not accurate as pcim_enable_device() adds a devm
action, unconditionally calls pci_enable_device() and sets is_managed
to true.  If we assume pcim_pin_device() is a valid concept, don't we
still need to remove the devm action as well?

> Another solution can could at least consider would be to use a
> GFP_ATOMIC for allocation in get_or_create_intx_devres().

If we look at what pci_intx() does without devres, it's simply reading
and setting or clearing a bit in config space.  I can attest that a
driver author would have no expectation that such a function allocates
memory and there are scenarios where we want to call this with
interrupts disabled, such as within an interrupt context.  So, TBH, it
might make sense to consider whether an allocation in this path is
appropriate at all, but I'm obviously no expert in devres.

> I suppose your solution is the better one, though.

I see you've posted a patch, I'll test it as soon as I'm able.  Thanks,

Alex


