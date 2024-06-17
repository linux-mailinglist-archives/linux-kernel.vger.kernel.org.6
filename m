Return-Path: <linux-kernel+bounces-216902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CE0C90A847
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 10:21:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1E751F21F2A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 08:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FD24190463;
	Mon, 17 Jun 2024 08:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="heGlY2D8"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF6318628D
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 08:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718612477; cv=none; b=UPn/QeG2pr20G6tPK3j3Q9pWXapE0fapMS9CYjHiFGG9oGEsQhx8oCHx9dvX7sBertjDs0G6zdxc9Q7c60tJGW/5l4cM04orn45oQ/vEau7Xfz/O+qdr4N2sUmNHgV5OpNASkM/o9RZJNAGi//U3P52l3v0ByFnG6iOIX6SN/z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718612477; c=relaxed/simple;
	bh=cTK/nSEc0sr9Zt54gC1HBI5EuJKjOx81XMNMXuBOuZM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PwDXODZMgYsyw4xksuZyXjum68rqUkx2FlQEee8j/Lv1ggccFd2hawS+WqQ/VUPFIrckpMfsZEmBHNGrSjrk3+/TqAGLxpN+CUU1+0nol8aGCN1ezkn8ADmTGZUPOhXDYf5PoAotxA43qjzQQcE5Sgdtq1WD4f74ZQTfEbDo7MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=heGlY2D8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718612474;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cTK/nSEc0sr9Zt54gC1HBI5EuJKjOx81XMNMXuBOuZM=;
	b=heGlY2D8y+UOBnTrDKk2AX8//JOpy9r/qO4RupDJtI+8RWmiY6LfRWnWj4THfSGbnKXzgx
	QAjcEmlyXXGTyfk4Xl3rmsjKjtTsYcyfzyBzIbLe7hVmdWEnmFy0yfvaoaYHh3XDEPPBm8
	8eeMs71b8xb1sgUYLUuCuahIxB/Q7zQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-180-ePEETrMdPQuoGTxSRssgig-1; Mon, 17 Jun 2024 04:21:13 -0400
X-MC-Unique: ePEETrMdPQuoGTxSRssgig-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-42180d2a0d6so6443125e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 01:21:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718612472; x=1719217272;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cTK/nSEc0sr9Zt54gC1HBI5EuJKjOx81XMNMXuBOuZM=;
        b=FjgvkOIwOw3gsh4dl5Vm0nYZECQNfgegI1t1bSiTHw4+dyurwt386PV/lC9NfLbzGa
         B++wurDIfrvWQakYYQBNyrGLEycFNJXtljGB05+z6sUlTxm3dGkgjTWSkN0B2j1jC1r2
         1OfelDSLtw8zozM1OcUtV9jbZIhkbOkL1dSxGbWegIuWeE8R1vZRjGdi4i9hdkwwdnRk
         hKNLtpRvqF+HQZFPARcSQ2VONO4wcsMPRqSrJmL2BedMRVC0j58qNT7NmlCe26+keMWr
         xDhu8O4jc3OFhnDa3yhnPD25gUBAoGVWxev4ZnoVpxnT+NwRoz1cSZjOPVoRtV5NJwO9
         eIUg==
X-Forwarded-Encrypted: i=1; AJvYcCVDesFHcbW0jBxGn3yM3ahQlamVpGHorM+/vpNiJgdaAngrjPScrKFqFy9VeHqcDxRahWI2HknXXNeXnjSzSPFOykv76ZDHPTj/ws6I
X-Gm-Message-State: AOJu0YySxaKLo1LVIU2aMpsYP3VLlTyWFf9lPRQAQ+ONNKXKqj3jAcHr
	bGnrOo5LPLbCUBG8WwYQJIVaQWmJkMVQVuXlY6KPFjhxqze84Dk3apUR6ugVlgY9uAN0rB8qkE0
	vb1Uj7sTJFqXcAbSoTtiD/qaNwe5xKohQUKo1L06pWgBq/QJCYq79kSjOwszQxw==
X-Received: by 2002:a05:600c:3510:b0:421:7dc3:9a1d with SMTP id 5b1f17b1804b1-42304855035mr66204745e9.4.1718612471938;
        Mon, 17 Jun 2024 01:21:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG5EsN4snPVwwdJpY6BujEFyiznYI79kUxwQuEaA6q+Ugp50bjVUn6XOpisZtSD3pKxm3q1hw==
X-Received: by 2002:a05:600c:3510:b0:421:7dc3:9a1d with SMTP id 5b1f17b1804b1-42304855035mr66204555e9.4.1718612471570;
        Mon, 17 Jun 2024 01:21:11 -0700 (PDT)
Received: from pstanner-thinkpadt14sgen1.remote.csb (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422870e95eesm189677815e9.25.2024.06.17.01.21.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 01:21:11 -0700 (PDT)
Message-ID: <bdfd5c582e7b858d3f32428000d2268228beef5f.camel@redhat.com>
Subject: Re: [PATCH v9 10/13] PCI: Give pci_intx() its own devres callback
From: Philipp Stanner <pstanner@redhat.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Hans de Goede
 <hdegoede@redhat.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>,  Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Daniel Vetter <daniel@ffwll.ch>, Bjorn Helgaas <bhelgaas@google.com>, Sam
 Ravnborg <sam@ravnborg.org>,  dakr@redhat.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-pci@vger.kernel.org
Date: Mon, 17 Jun 2024 10:21:10 +0200
In-Reply-To: <20240614161443.GA1115997@bhelgaas>
References: <20240614161443.GA1115997@bhelgaas>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-06-14 at 11:14 -0500, Bjorn Helgaas wrote:
> On Fri, Jun 14, 2024 at 10:09:46AM +0200, Philipp Stanner wrote:
> > On Thu, 2024-06-13 at 16:06 -0500, Bjorn Helgaas wrote:
> > > On Thu, Jun 13, 2024 at 01:50:23PM +0200, Philipp Stanner wrote:
> > > > pci_intx() is one of the functions that have "hybrid mode"
> > > > (i.e.,
> > > > sometimes managed, sometimes not). Providing a separate
> > > > pcim_intx()
> > > > function with its own device resource and cleanup callback
> > > > allows
> > > > for
> > > > removing further large parts of the legacy PCI devres
> > > > implementation.
> > > >=20
> > > > As in the region-request-functions, pci_intx() has to call into
> > > > its
> > > > managed counterpart for backwards compatibility.
> > > >=20
> > > > As pci_intx() is an outdated function, pcim_intx() shall not be
> > > > made
> > > > visible to drivers via a public API.
> > >=20
> > > What makes pci_intx() outdated?=C2=A0 If it's outdated, we should
> > > mention
> > > why and what the 30+ callers (including a couple in drivers/pci/)
> > > should use instead.
> >=20
> > That is 100% based on Andy Shevchenko's (+CC) statement back from
> > January 2024 a.D. [1]
> >=20
> > Apparently INTx is "old IRQ management" and should be done through
> > pci_alloc_irq_vectors() nowadays.
>=20
> Do we have pcim_ support for pci_alloc_irq_vectors()?

Nope.

All PCI devres functions that exist are now in pci/devres.c, except for
the hybrid functions (pci_intx() and everything calling
__pci_request_region()) in pci.c


P.

>=20
> > [1]
> > https://lore.kernel.org/all/ZabyY3csP0y-p7lb@surfacebook.localdomain/
>=20


