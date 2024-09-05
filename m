Return-Path: <linux-kernel+bounces-316480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DD5296D025
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 09:13:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 941381F25FF5
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 07:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2AC6192D6E;
	Thu,  5 Sep 2024 07:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D45l60c8"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB59192D72
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 07:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725520406; cv=none; b=eSnzgcWqKPfNs26BpsUnP93TvqW25AdAsXoMlXokFNqDmp8gn425d72eeo7pxLPSLtKu1Yr48cVKg51BTGnUf6yGAStiftOJ6AI5PoW+Uix7pycrgP8o+5cv+BNM2d6epqC6cqoh6rxOLfYfdnQjKtFkIk1lYAkceYrDDCUIaMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725520406; c=relaxed/simple;
	bh=5KD5HYohxCRPZQPC3oSrDR78+0aMrMTSSL3vGRS8xXk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gVaQgJq1m5ps9QK+h0SoD7fIpMTcRKh+7eI77WqXAp66/1UM2l7AAOgsS8ok4Bot75Cp/6EKCToCzjJ971eDd3u6Lg2AeHm5yHGOtBzJh94SNlU+465/Gg7ohBmrmsKHoqbLeQv3SKGI2Op7NCM0ZdnL+ouBu0iZVtvbKYqYwpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D45l60c8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725520404;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z91j6Rg6+MKvqOJxuRUaPb0I2+3pnn9vD4q/2s0d04E=;
	b=D45l60c8oKkDW691eBY6bpPDOHZwYPeR4t8itiCb7390q7nJTEYnA6/EZ0SJZeGPR6deu5
	ZLkNJ7g1nbo/UhWi4HZIdklKPvcM+xfk6dqVFPx9Kjg0Gj+RthWA7CIxbfoj87Y3S4+1G7
	8DvCnHlq9olN7Q4l+mNJEXfQZdhtoC8=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-IFio2L5bMTycroAYGeo6Zg-1; Thu, 05 Sep 2024 03:13:22 -0400
X-MC-Unique: IFio2L5bMTycroAYGeo6Zg-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7a7f9b493adso73280885a.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 00:13:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725520402; x=1726125202;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z91j6Rg6+MKvqOJxuRUaPb0I2+3pnn9vD4q/2s0d04E=;
        b=AYT+8UlF0t/VWSvu27lhd2vX/hx+wDR8nbUNJYCGj3BiklJKSCA8q5DGISXcrZOg5J
         6AWUwRC1seJXv21SmoPYny+uIqiR+B09RhTTj+BkQIswU5hxH8MZV+izkdt8BMWtvzBR
         hifzkfJKQsmrCb6Et8QDNXOeIfJlOKQOltFgR4aDSRl1DDUkmTmW/V1yYYCx8Mw18cLp
         MxbhsBAbCdQDCkGJEj14Sy/D7w3ACxaPJZk7De2dmWndVm0c3lQFglnD9DSdqmJodhGM
         icq/VZ93lZtkUlBYbfmVNFquhSko6xQVvLKCdj7i0AjjushZ7zlmEJyO12nJ8Fs4Mpsu
         m4uQ==
X-Forwarded-Encrypted: i=1; AJvYcCVeG129SbcPwD2MwpjvCT/09qGbJNJ6Qz5ANR1bbits0U1we4d4qNpO97MgERFLmoyv3dNF8iQ2RLEeoZ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyM32jGQZjC1USJVudDBMrWdQ2crbZnriu/cAlPPJQu+Dbe7urg
	hqkbi7ZW++1Ddcz3VdhNCEHW94XehFIYoVtKVSJ6hpEjtb3PPFGC0tTGt2bhOWHiGOSizfyNPmc
	GzyQislZTXI6/869sbKKKjdHSxQMp8uOdtPZ3kwyqzjFi8TRf+WqSKlHRFJbmlQ==
X-Received: by 2002:a05:6214:41a1:b0:6c4:79df:a2d9 with SMTP id 6a1803df08f44-6c47a0d6a88mr93101716d6.9.1725520402320;
        Thu, 05 Sep 2024 00:13:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEqfKSsM5qkK4UmMIe8KoGXUrltHvD9OvoElfA0alMwX6C2kilfYtZvFtKBlretqh/pTwlsdg==
X-Received: by 2002:a05:6214:41a1:b0:6c4:79df:a2d9 with SMTP id 6a1803df08f44-6c47a0d6a88mr93101536d6.9.1725520401970;
        Thu, 05 Sep 2024 00:13:21 -0700 (PDT)
Received: from dhcp-64-16.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c5201e4347sm5385166d6.42.2024.09.05.00.13.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 00:13:21 -0700 (PDT)
Message-ID: <6a17c02077543f98b72662a7189407d0452e6d47.camel@redhat.com>
Subject: Re: [PATCH] PCI: Fix devres regression in pci_intx()
From: Philipp Stanner <pstanner@redhat.com>
To: Damien Le Moal <dlemoal@kernel.org>, Alex Williamson
	 <alex.williamson@redhat.com>, Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Krzysztof
 =?UTF-8?Q?Wilczy=C5=84ski?=
	 <kwilczynski@kernel.org>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Thu, 05 Sep 2024 09:13:19 +0200
In-Reply-To: <65fe5c47-e420-4b4d-a575-2bb90e13482c@kernel.org>
References: <20240725120729.59788-2-pstanner@redhat.com>
	 <20240903094431.63551744.alex.williamson@redhat.com>
	 <2887936e2d655834ea28e07957b1c1ccd9e68e27.camel@redhat.com>
	 <24c1308a-a056-4b5b-aece-057d54262811@kernel.org>
	 <dcbf9292616816bbce020994adb18e2c32597aeb.camel@redhat.com>
	 <20240904120721.25626da9.alex.williamson@redhat.com>
	 <ZtjCFR3kd5GfV_6m@surfacebook.localdomain>
	 <20240904151020.486f599e.alex.williamson@redhat.com>
	 <65fe5c47-e420-4b4d-a575-2bb90e13482c@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-09-05 at 09:33 +0900, Damien Le Moal wrote:
> On 2024/09/05 6:10, Alex Williamson wrote:
> > On Wed, 4 Sep 2024 23:24:53 +0300
> > Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> >=20
> > > Wed, Sep 04, 2024 at 12:07:21PM -0600, Alex Williamson kirjoitti:
> > > > On Wed, 04 Sep 2024 15:37:25 +0200
> > > > Philipp Stanner <pstanner@redhat.com> wrote:=C2=A0=20
> > > > > On Wed, 2024-09-04 at 17:25 +0900, Damien Le Moal wrote:=C2=A0=
=20
> > >=20
> > > ...
> > >=20
> > > > > If vfio-pci can get rid of pci_intx() alltogether, that might
> > > > > be a good
> > > > > thing. As far as I understood Andy Shevchenko, pci_intx() is
> > > > > outdated.
> > > > > There's only a hand full of users anyways.=C2=A0=20
> > > >=20
> > > > What's the alternative?=C2=A0=20
> > >=20
> > > From API perspective the pci_alloc_irq_vectors() & Co should be
> > > used.
> >=20
> > We can't replace a device level INTx control with a vector
> > allocation
> > function.
> > =C2=A0
> > > > vfio-pci has a potentially unique requirement
> > > > here, we don't know how to handle the device interrupt, we only
> > > > forward
> > > > it to the userspace driver.=C2=A0 As a level triggered interrupt,
> > > > INTx will
> > > > continue to assert until that userspace driver handles the
> > > > device.
> > > > That's obviously unacceptable from a host perspective, so INTx
> > > > is
> > > > masked at the device via pci_intx() where available, or at the
> > > > interrupt controller otherwise.=C2=A0 The API with the userspace
> > > > driver
> > > > requires that driver to unmask the interrupt, again resulting
> > > > in a call
> > > > to pci_intx() or unmasking the interrupt controller, in order
> > > > to receive
> > > > further interrupts from the device.=C2=A0 Thanks,=C2=A0=20
> > >=20
> > > I briefly read the discussion and if I understand it correctly
> > > the problem here
> > > is in the flow: when the above mentioned API is being called.
> > > Hence it's design
> > > (or architectural) level of issue and changing call from foo() to
> > > bar() won't
> > > magically make problem go away. But I might be mistaken.
> >=20
> > Certainly from a vector allocation standpoint we can change to
> > whatever
> > is preferred, but the direct INTx manipulation functions are a
> > different thing entirely and afaik there's nothing else that can
> > replace them at a low level, nor can we just get rid of our calls
> > to
> > pci_intx().=C2=A0 Thanks,
>=20
> But can these calls be moved out of the spinlock context ? If not,
> then we need
> to clarify that pci_intx() can be called from any context, which will
> require
> changing to a GFP_ATOMIC for the resource allocation, even if the use
> case
> cannot trigger the allocation. This is needed to ensure the
> correctness of the
> pci_intx() function use.

We could do that I guess. As I keep saying, it's not intended to have
pci_intx() allocate _permanently_. This is a temporary situation.
pci_intx() should have neither devres nor allocation.

> Frankly, I am surprised that the might sleep splat you
> got was not already reported before (fuzzying, static analyzers might
> eventually
> catch that though).

It's a super rare situation:
 * pci_intx() has very few callers
 * It only allocates if pcim_enable_device() instead of
   pci_enable_device() ran.
 * It only allocates when it's called for the FIRST TIME
 * All of the above is only a problem while you hold a lock

>=20
> The other solution would be a version of pci_intx() that has a gfp
> flags
> argument to allow callers to use the right gfp flags for the call
> context.

I don't think that's a good idea. As I said, I want to clean up all
that in the mid term.

As a matter of fact, there is already __pcim_intx() in pci/devres.c as
a pure unmanaged pci_intx() as a means to split and then cleanup the
APIs.

One path towards getting the hybrid behavior out of pci_intx() could be
to rename __pcim_intx() to pci_intx_unmanaged() and port everyone who
uses pci_enable_device() + pci_intx() to that version. That would be
better than to have a third version with a gfp_t argument.


P.

>=20
>=20
> >=20
> > Alex
> >=20
>=20


