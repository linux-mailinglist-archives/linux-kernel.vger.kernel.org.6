Return-Path: <linux-kernel+bounces-293834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5DB8958586
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 13:14:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3962C1F233BB
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 11:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07C6418E74E;
	Tue, 20 Aug 2024 11:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="afWcm9yw"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7CC18D63E
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 11:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724152469; cv=none; b=u5GI/N0+6V8S7m5gxt8NQw2zf1cQ8202El/bxGgoBk0jgwLte3U0aADv9Lo/9ANI82E5+csb5XOLhNSkzbUjPdxIav3yZhcYjthQOLmnAbex0J9UJ+0I3eNwkwBpIiQnIKPEIcvDMvFGwVZarjD22pxYwwFl8pOVb9ZqYlMWpks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724152469; c=relaxed/simple;
	bh=rGM+Q7dIYBoJCsuGamvXSRRNj+I6b8oz5K4/Bniwl6c=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jfZxooJJT+GCjQrtva5lXcY2joK+QYTY04nq1g9Ewblc6QNBMaWqvSvk6K8jxVYND19iBJ50m6dNuo8mBvyDK+k5uqQGe4DLeIqLFUNrKDz5lI9GPE2jHl3tGOrtjjQXdT73u+C0OV7TXtQncaQ5lSMDngMb8g64HDhaxDw4D54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=afWcm9yw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724152465;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y1Q7acyOuQZwg2/89j6b8m+Ec7sRWq6gAjTgotRXIu4=;
	b=afWcm9ywV0wrmLJReG2xDjaRLOYh2B87cZHN8Evxj3I6SQDvo7C8z9mTQ+F6xkiE4Hhr46
	kONikQAUcJCSA9CCzzvHmI/OJ5JBHeyDwP86BRrrlGOF1LJb3H8JNUJlbl9hmrmutU1RZq
	hkm2reOvPp+Cz3/Jk82JpP4iQ2luKJ4=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-214-WZkh0f9cNauCF0kcEeU7Bw-1; Tue, 20 Aug 2024 07:14:24 -0400
X-MC-Unique: WZkh0f9cNauCF0kcEeU7Bw-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-52eff9a3109so591930e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 04:14:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724152463; x=1724757263;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y1Q7acyOuQZwg2/89j6b8m+Ec7sRWq6gAjTgotRXIu4=;
        b=tult3ZiTe1XDrbqqONgVd/Ik7SxF4H6tD82n43bWHQya9jbc1SxDJ+j5TUhvR603VA
         gt7zSxsBro490j5qFL4O5TucuOHwVtzkW6pmzI2kSxPTp9QrzOhC7k1L/AkvTqjCBo6V
         rrPQwtDOacF8mDMgHzuMNqJdsJH3C1TgDcpqJnDIT0695xwQK89u0k5DZRnLXiCqiHH4
         eiuywuwTKuLYrRXa6leFLqOm/aTj/V42qVwGgAKUh96iwi/KmBMVjPJV1sB4w7XQa/GE
         dQkVBvOf5QsjVBxi40A0lTyYexEF66vAkFOe5fLQn1riJPh1NZYZNb00b1IIxngBy+ul
         MmGg==
X-Forwarded-Encrypted: i=1; AJvYcCUx6O1KJkaiHfOcyUvDzIsnhAP8xvGgqrZgCrPGRl/VEWjNYL9F7p8l0J9QtsVYS5t4APy+Ev45wuAyK6D0+MzUH5z0R/W4vVQCSS2p
X-Gm-Message-State: AOJu0YwWVf6hxMHU7JNrSkYjkzm5467bMgrvRo48+i1rkrWVZCRDWaON
	mFaYBeLVlafm4h4IgVx+DDnJ2LEYkG4uhk/n1F2sVHWKCvuK2R09Etip5EQp2IB5CutKwsXYB7c
	iF1Jggna6KSKwnLmY0mpgv57WdKveG/xAfBaWpxJLrh3+ZKmZla7bSGDbIwb0Cw==
X-Received: by 2002:a05:6512:3c84:b0:530:baec:3975 with SMTP id 2adb3069b0e04-5331c6904bamr5596060e87.1.1724152463004;
        Tue, 20 Aug 2024 04:14:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGYdlvki0skRqSH7C03GeJxZqEQK+y/koEXnizdbc6P1v4DyVRhp4tYp6FmBEQj38Z0lN9WKg==
X-Received: by 2002:a05:6512:3c84:b0:530:baec:3975 with SMTP id 2adb3069b0e04-5331c6904bamr5596024e87.1.1724152462340;
        Tue, 20 Aug 2024 04:14:22 -0700 (PDT)
Received: from eisenberg.fritz.box ([2001:16b8:3dcc:1f00:bec1:681e:45eb:77e2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8383935657sm747366866b.138.2024.08.20.04.14.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 04:14:22 -0700 (PDT)
Message-ID: <01b1e7d505a2b3e670f1613ce3e6a60efd3449ab.camel@redhat.com>
Subject: Re: [PATCH 8/9] vdap: solidrun: Replace deprecated PCI functions
From: Philipp Stanner <pstanner@redhat.com>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: alexandre.torgue@foss.st.com, alvaro.karsz@solid-run.com,
 andy@kernel.org,  axboe@kernel.dk, bhelgaas@google.com, brgl@bgdev.pl,
 broonie@kernel.org,  corbet@lwn.net, davem@davemloft.net,
 edumazet@google.com, eperezma@redhat.com,  hao.wu@intel.com,
 jasowang@redhat.com, joabreu@synopsys.com, kuba@kernel.org, 
 linus.walleij@linaro.org, linux-arm-kernel@lists.infradead.org, 
 linux-block@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-fpga@vger.kernel.org, linux-gpio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, mcoquelin.stm32@gmail.com, 
 mdf@kernel.org, mst@redhat.com, netdev@vger.kernel.org, pabeni@redhat.com, 
 richardcochran@gmail.com, trix@redhat.com, virtualization@lists.linux.dev, 
 xuanzhuo@linux.alibaba.com, yilun.xu@intel.com
Date: Tue, 20 Aug 2024 13:14:20 +0200
In-Reply-To: <d35a962d-dc95-4469-867e-95b704cca474@wanadoo.fr>
References: <20240819165148.58201-2-pstanner@redhat.com>
	 <20240819165148.58201-10-pstanner@redhat.com>
	 <74e9109a-ac59-49e2-9b1d-d825c9c9f891@wanadoo.fr>
	 <3e4288bb7300f3fd0883ff07b75ae69d0532019b.camel@redhat.com>
	 <d35a962d-dc95-4469-867e-95b704cca474@wanadoo.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-08-20 at 12:50 +0200, Christophe JAILLET wrote:
> Le 20/08/2024 =C3=A0 10:09, Philipp Stanner a =C3=A9crit=C2=A0:
> > > > @@ -556,33 +556,24 @@ static const struct vdpa_config_ops
> > > > snet_config_ops =3D {
> > > > =C2=A0=C2=A0 static int psnet_open_pf_bar(struct pci_dev *pdev, str=
uct
> > > > psnet
> > > > *psnet)
> > > > =C2=A0=C2=A0 {
> > > > =C2=A0=C2=A0=C2=A0	char name[50];
> > > > -	int ret, i, mask =3D 0;
> > > > +	int i;
> > > > +
> > > > +	snprintf(name, sizeof(name), "psnet[%s]-bars",
> > > > pci_name(pdev));
> > > > +
> > > > =C2=A0=C2=A0=C2=A0	/* We don't know which BAR will be used to
> > > > communicate..
> > > > =C2=A0=C2=A0=C2=A0	 * We will map every bar with len > 0.
> > > > =C2=A0=C2=A0=C2=A0	 *
> > > > =C2=A0=C2=A0=C2=A0	 * Later, we will discover the BAR and unmap all=
 other
> > > > BARs.
> > > > =C2=A0=C2=A0=C2=A0	 */
> > > > =C2=A0=C2=A0=C2=A0	for (i =3D 0; i < PCI_STD_NUM_BARS; i++) {
> > > > -		if (pci_resource_len(pdev, i))
> > > > -			mask |=3D (1 << i);
> > > > -	}
> > > > -
> > > > -	/* No BAR can be used.. */
> > > > -	if (!mask) {
> > > > -		SNET_ERR(pdev, "Failed to find a PCI BAR\n");
> > > > -		return -ENODEV;
> > > > -	}
> > > > -
> > > > -	snprintf(name, sizeof(name), "psnet[%s]-bars",
> > > > pci_name(pdev));
> > > > -	ret =3D pcim_iomap_regions(pdev, mask, name);
> > > > -	if (ret) {
> > > > -		SNET_ERR(pdev, "Failed to request and map PCI
> > > > BARs\n");
> > > > -		return ret;
> > > > -	}
> > > > +		if (pci_resource_len(pdev, i)) {
> > > > +			psnet->bars[i] =3D
> > > > pcim_iomap_region(pdev,
> > > > i, name);
> > >=20
> > > Hi,
> > >=20
> > > Unrelated to the patch, but is is safe to have 'name' be on the
> > > stack?
> > >=20
> > > pcim_iomap_region()
> > > --> __pcim_request_region()
> > > --> __pcim_request_region_range()
> > > --> request_region() or __request_mem_region()
> > > --> __request_region()
> > > --> __request_region_locked()
> > > --> res->name =3D name;
> > >=20
> > > So an address on the stack ends in the 'name' field of a "struct
> > > resource".
> >=20
> > Oh oh...
> >=20
> > >=20
> > > According to a few grep, it looks really unusual.
> > >=20
> > > I don't know if it is used, but it looks strange to me.
> >=20
> >=20
> > I have seen it used in the kernel ringbuffer log when you try to
> > request something that's already owned. I think it's here, right in
> > __request_region_locked():
> >=20
> > /*
> > =C2=A0 * mm/hmm.c reserves physical addresses which then
> > =C2=A0 * become unavailable to other users.=C2=A0 Conflicts are
> > =C2=A0 * not expected.=C2=A0 Warn to aid debugging if encountered.
> > =C2=A0 */
> > if (conflict->desc =3D=3D IORES_DESC_DEVICE_PRIVATE_MEMORY) {
> > 	pr_warn("Unaddressable device %s %pR conflicts with %pR",
> > 		conflict->name, conflict, res);
> > }
> >=20
> >=20
> > Assuming I interpret the code correctly:
> > The conflicting resource is found when a new caller (e.g. another
> > driver) tries to get the same region. So conflict->name on the
> > original
> > requester's stack is by now gone and you do get UB.
> >=20
> > Very unlikely UB, since only rarely drivers race for the same
> > resource,
> > but still UB.
> >=20
> > But there's also a few other places. Grep for "conflict->name".
> >=20
> > >=20
> > >=20
> > > If it is an issue, it was apparently already there before this
> > > patch.
> >=20
> > I think this has to be fixed.
> >=20
> > Question would just be whether one wants to fix it locally in this
> > driver, or prevent it from happening globally by making the common
> > infrastructure copy the string.
> >=20
> >=20
> > P.
> >=20
>=20
> Not a perfect script, but the below coccinelle script only find this=20
> place, so I would +1 only fixing things here only.
>=20
> Agree?

Yup, sounds good. Copying the string would cause trouble (GFP flags)
anyways.

I'll provide a fix in v2.

Thanks,
P.

>=20
> CJ
>=20
>=20
>=20
> @@
> identifier name;
> expression x;
> constant N;
> @@
> 	char name[N];
> 	...
> (
> *	pcim_iomap_region(..., name, ...);
> >=20
> *	pcim_iomap_regions(..., name, ...);
> >=20
> *	request_region(..., name, ...);
> >=20
> *	x =3D pcim_iomap_region(..., name, ...);
> >=20
> *	x =3D pcim_iomap_regions(..., name, ...);
> >=20
> *	x =3D request_region(..., name, ...);
> )
>=20
>=20


