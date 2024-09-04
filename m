Return-Path: <linux-kernel+bounces-314366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BCCF96B255
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 09:06:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD597B22BD6
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 07:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFFE96A8D2;
	Wed,  4 Sep 2024 07:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LREveYF/"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE52F126BFE
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 07:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725433604; cv=none; b=DPsrf0aA+6lEgE7o/NfN95tJIE6RbWlIKLMeRaE/LqUbIfVXskqZWs8sv26pwCqJ3fUwQ7HDsf1TS61QsedSim4B8JYyEHPO1fGb61bvdkC2QOpAeJKAQQgSNk8emfdor0FkxvG0XpU5pH2U2F17aWg2Mw+g4X9scXwlFDnnV24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725433604; c=relaxed/simple;
	bh=9+4+02P6VdlWS5bH9NiDFW/JYVZ0bGvOd3je7eBy/Kk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pAfxc2+DYHYgxd8OviT97Ou+zOSZSxr+spPvITHg8GP0DfdF4oKmPv9oqqa6tCWNXw5e5hLNF3mzdK2VVvkWbuOie58RngmLl6biy8+mEtKupv1HfJPeRnnZiSdnnAw1CbmEpszmvJ5BwlL3lHoIxuG1rvEcxuDHMlpSeZfIaEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LREveYF/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725433602;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D1fOf/Lbka3oPuT1iX3a8CQcbtqm54HN8PC96Xte6gY=;
	b=LREveYF/C9SLgUv/CK4wRsdR1yOtW1Dhrnk9B366yDWoNg1b+cpVZs5Gbg7EqtFtCLP/fc
	7Yg3wrcCrJjztCOLxkNxpPRTyT22eTXJaDyuu7MXpj5gXsGT/AmGH/r6YB1kgbdzytXtij
	8jEvl1uRChj27rwtk1ArV2svOyjprIU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-316-9ilLSRe6NAe8byGc7t4prw-1; Wed, 04 Sep 2024 03:06:40 -0400
X-MC-Unique: 9ilLSRe6NAe8byGc7t4prw-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-428ea5b1479so9223225e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 00:06:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725433599; x=1726038399;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D1fOf/Lbka3oPuT1iX3a8CQcbtqm54HN8PC96Xte6gY=;
        b=e0QeEAXuuPeedL636ncDZPNXvh4wUxgZVYjcT9snViGPzL0Gs225XjMfS7HALK/7kH
         AZobRf2DttkfjHnWHqgGYxddeeyzs3AYKjTdILxKPUztvjBX2kDIgd6CmZPxKUYgTzUY
         73z6NRRcOCPpW7G5yh+Z3mg9okXGM4PQLDUEJvVlZZvDUY38flh86epXZVRnYqa5nX67
         LsTxveVGM3Fxy/shnEJb3C9a2F8q5bItr8fktaK1KUT3Ef2KoXwG7sW81/tN8X/TXLjL
         bgvBUgxQas+s74Us4TtdI/DYDK0sA7uXJFHsumg7NdKI2Peq7q49jX/BDb7dk+4nxnCG
         TQwQ==
X-Forwarded-Encrypted: i=1; AJvYcCVhPhZNcz528mF7vxWZodOOyOJVZDkkxy8GfkdeZoSlTkltGvdtbDLXldjTtzMOnRYCfxjdQ3IWF45G2l0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPY1zuTS0WgVOhvQMXzIRjByj/BRGOFJl1RhJso/cpbUTNO1sL
	puW3VEzuj37RrD1Nxp5hFrow4X/yLu7IT6G5sylY9d71MLhI9SR2dEPD806hc26HjrPWUYU2WhN
	VOQTuQqkuhF1mNUXZgu1UW2hy89HQYA2Bt6M3lp4fX4UmJHxsTv+XQKcddPDviQ==
X-Received: by 2002:a05:600c:3b8e:b0:426:616e:db8d with SMTP id 5b1f17b1804b1-42bb01b556bmr154098915e9.15.1725433598813;
        Wed, 04 Sep 2024 00:06:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHf/Kc6FZV8G94W1sYODGsLkpfpa2DDiOzZF4FZwEIEwJQGn0yGP3bHFUfookRalM2sYhKFPA==
X-Received: by 2002:a05:600c:3b8e:b0:426:616e:db8d with SMTP id 5b1f17b1804b1-42bb01b556bmr154098685e9.15.1725433598350;
        Wed, 04 Sep 2024 00:06:38 -0700 (PDT)
Received: from dhcp-64-16.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bb6e33f5esm191840235e9.39.2024.09.04.00.06.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 00:06:38 -0700 (PDT)
Message-ID: <2887936e2d655834ea28e07957b1c1ccd9e68e27.camel@redhat.com>
Subject: Re: [PATCH] PCI: Fix devres regression in pci_intx()
From: Philipp Stanner <pstanner@redhat.com>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Krzysztof
 =?UTF-8?Q?Wilczy=C5=84ski?=
	 <kwilczynski@kernel.org>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>
Date: Wed, 04 Sep 2024 09:06:37 +0200
In-Reply-To: <20240903094431.63551744.alex.williamson@redhat.com>
References: <20240725120729.59788-2-pstanner@redhat.com>
	 <20240903094431.63551744.alex.williamson@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-09-03 at 09:44 -0600, Alex Williamson wrote:
> On Thu, 25 Jul 2024 14:07:30 +0200
> Philipp Stanner <pstanner@redhat.com> wrote:
>=20
> > pci_intx() is a function that becomes managed if
> > pcim_enable_device()
> > has been called in advance. Commit 25216afc9db5 ("PCI: Add managed
> > pcim_intx()") changed this behavior so that pci_intx() always leads
> > to
> > creation of a separate device resource for itself, whereas earlier,
> > a
> > shared resource was used for all PCI devres operations.
> >=20
> > Unfortunately, pci_intx() seems to be used in some drivers'
> > remove()
> > paths; in the managed case this causes a device resource to be
> > created
> > on driver detach.
> >=20
> > Fix the regression by only redirecting pci_intx() to its managed
> > twin
> > pcim_intx() if the pci_command changes.
> >=20
> > Fixes: 25216afc9db5 ("PCI: Add managed pcim_intx()")
>=20
> I'm seeing another issue from this, which is maybe a more general
> problem with managed mode.=C2=A0 In my case I'm using vfio-pci to assign
> an
> ahci controller to a VM.

"In my case" doesn't mean OOT, does it? I can't fully follow.

> =C2=A0 ahci_init_one() calls pcim_enable_device()
> which sets is_managed =3D true.=C2=A0 I notice that nothing ever sets
> is_managed to false.=C2=A0 Therefore now when I call pci_intx() from vfio=
-
> pci
> under spinlock, I get a lockdep warning

I suppose you see the lockdep warning because the new pcim_intx() can=20
now allocate, whereas before 25216afc9db5 it was pcim_enable_device()
which allocated *everything* related to PCI devres.

>  as I no go through pcim_intx()
> code after 25216afc9db5=C2=A0

You alwas went through pcim_intx()'s logic. The issue seems to be that
the allocation step was moved.

> since the previous driver was managed.

what do you mean by "previous driver"?

> =C2=A0 It seems
> like we should be setting is_managed to false is the driver release
> path, right?

So the issue seems to be that the same struct pci_dev can be used by
different drivers, is that correct?

If so, I think that can be addressed trough having
pcim_disable_device() set is_managed to false as you suggest.

Another solution can could at least consider would be to use a
GFP_ATOMIC for allocation in get_or_create_intx_devres().

I suppose your solution is the better one, though.


P.

> =C2=A0 Thanks,
>=20
> Alex
>=20


