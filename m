Return-Path: <linux-kernel+bounces-445364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80D769F1512
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 19:40:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 389A428459D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 18:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27E751E6311;
	Fri, 13 Dec 2024 18:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bMCi0Mlq"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 483351CEAAC
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 18:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734115194; cv=none; b=uUnyDlcbTD9LJ8XFtKzhfHIYgBtmyZVQOzkGwNTJ/CPdpOdVEqgWp2s405tdF+yCkA6cS2PMUJLMcvV3zW8zFgc5zWuKP3YCilurvjgo2HrZtPo5YLPRlrbEKnvi8F+OncjK9819vV5TxGY1DRKO5paxsvbnVti2WqZqjdpYZe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734115194; c=relaxed/simple;
	bh=paYtCl4i/kICh6pN7MDScW68876PeQaBXIq+NdHLqdI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GNjquqn6zW6b1xtFl+2aybc94uqZwCZkAYmxhOvT5xa80UQSzqa8mIAufyS355BD80B+NlQcnyF1n7i71NJTwV81OdtL9t76raM0Ylj6MN7v2t03DOapOS2+4Y3CW6I/HJdjmGzz7X3GenM7hTe/Mfu8dh7t6whG+OaVCmMaMrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bMCi0Mlq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734115190;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y3cmFsOycNOgC9BLdxjtj4gNk2h7ZOfj0CcPdOOHaB8=;
	b=bMCi0MlqKLQ1Sft9uJbnsNAKwecjDWArn5tajvxw29l/9hglzSXvKODPbMSaQbjhqVcuDK
	xpJPi3GwuJLy3F7+pog2xKmDxxfU909tWUzrSmI+ZNZE48DfbYBeumgsbt+DEjt/a/VpJl
	Wh+vmcuC6b6IKJKiDqNDBKCpUlVeCXM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-6IukuBqWOhi88r1FIVlxOQ-1; Fri, 13 Dec 2024 13:39:49 -0500
X-MC-Unique: 6IukuBqWOhi88r1FIVlxOQ-1
X-Mimecast-MFC-AGG-ID: 6IukuBqWOhi88r1FIVlxOQ
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-436219070b4so11892665e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 10:39:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734115188; x=1734719988;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y3cmFsOycNOgC9BLdxjtj4gNk2h7ZOfj0CcPdOOHaB8=;
        b=SFSgiUq4jTerpI9vFvR68MjRNfnYMDoeKuhBX53St2voafBqIy6ZAWn2IhEgI6TC8c
         cnbmbUOi+UOLjvZP2hMTnk6Rmk2MuTfGTlr2wD6M/4skZbLk03Pa6X1qg8LcL35e+xHU
         uDHcT213mi/RSM+WUnzbEC0s3Q4cdCwwE4EZmTNib1K98aOWUSUT575DNUQbPB9KpZde
         UN+VwvOHNpf0a2PJysC1lrYLV36IlSVht7Vu77lSW3Q2r06DAPB0EGxJa6DW2TwOezFP
         Nstt/opYx++IxCWDcchHX69TXTxlLA3/N1qlyB9mcyD9G/ef/e89iZEaufuJF011+b5L
         LYVw==
X-Forwarded-Encrypted: i=1; AJvYcCX1TWny0YNAspRFaT9q8PYUZYVxfiLJ8kithRlfK9hfDpMb9V+KbA+kaFHkfZ10RH9v0cktjPoYcBTsf/0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy49LBEzBcE+5c4iZ2Jqpnt7FQDk2L1NZN8eq659ogrNEO/zQsc
	xr0mrb2HkosKE9pcrtfSAV86TJY4M33vGj4Yn0CXUxwUiEHrXaozJxye/T7Z+xo9st/cn/jh/YY
	n/lvMnShQ4QVIEn1ywfTRKAmoa2WLqqju2hJvWoV56Kt6k50CFwTgYeNSkL4e2g==
X-Gm-Gg: ASbGnctvCTXMQV6zg2K2ppOwKQQU7hssW0uYwAsLtsKzEE39ZHRMLqklPt54CFyhXu5
	nPGU75DUtdAwcV7vy9AkTHYpMe43YRLjJnD3GdctKxU2IWmykCvrAwiYHqfPDDX3wwCROXqe68m
	UL57hvLxsLGK8xEbQzBdHccR3UYu0pxkXkhZ1Pu6qNErxTzEl5iHOA5ulJUCQqBwa7rFYROVjgB
	0FCnO3yokLEVNbjIcYVqmiQAgJTuoIf82mRqI6iQ8X7L0Tow0I90v/5qLLqMHRA5/sd0x0+/eFY
	I8cRD7SSJEGuYSFwJtUqTaY7ytl4gZc1X2zKJXyNBQ2G/KJZ1CUpAxBIe6lfSX6VfQTYwbQ4INT
	ec8PrTMEVzV+TxgV9
X-Received: by 2002:a5d:5986:0:b0:385:dea3:6059 with SMTP id ffacd0b85a97d-3889ad32e66mr3127499f8f.49.1734115187853;
        Fri, 13 Dec 2024 10:39:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFLa3jJsqtYsc5AY0Ty/8UhIHCPB+WGSKX76RT8lLl69x2aAbXZD/4nY0oas16QhNRCrg0q/A==
X-Received: by 2002:a5d:5986:0:b0:385:dea3:6059 with SMTP id ffacd0b85a97d-3889ad32e66mr3127480f8f.49.1734115187442;
        Fri, 13 Dec 2024 10:39:47 -0800 (PST)
Received: from ?IPv6:2001:16b8:2dc8:6700:cf37:cd3f:fa76:dfb9? (200116b82dc86700cf37cd3ffa76dfb9.dip.versatel-1u1.de. [2001:16b8:2dc8:6700:cf37:cd3f:fa76:dfb9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-388c8016373sm243712f8f.36.2024.12.13.10.39.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 10:39:47 -0800 (PST)
Message-ID: <08e922383c726a72574ea24eb2db520d40de4c47.camel@redhat.com>
Subject: Re: [PATCH v3] vdpa: solidrun: Replace deprecated PCI functions
From: Philipp Stanner <pstanner@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Alvaro Karsz <alvaro.karsz@solid-run.com>, "Michael S. Tsirkin"
	 <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Xuan Zhuo
	 <xuanzhuo@linux.alibaba.com>, Eugenio =?ISO-8859-1?Q?P=E9rez?=
	 <eperezma@redhat.com>, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Date: Fri, 13 Dec 2024 19:39:46 +0100
In-Reply-To: <vr7gh5y7ooomyj6hazju7khcuyvw5qs2xjsybj33ztcim3vtc4@gdbozbxlcsi3>
References: <20241211104704.208354-2-pstanner@redhat.com>
	 <vr7gh5y7ooomyj6hazju7khcuyvw5qs2xjsybj33ztcim3vtc4@gdbozbxlcsi3>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-12-13 at 16:10 +0100, Stefano Garzarella wrote:
> On Wed, Dec 11, 2024 at 11:47:05AM +0100, Philipp Stanner wrote:
> > The PCI functions
> >=20
> > 	pcim_iomap_regions()
> > 	pcim_iounmap_regions()
> > 	pcim_iomap_table()
> >=20
> > have been deprecated by the PCI subsystem.
> >=20
> > Replace these functions with their successors pcim_iomap_region()
> > and
> > pcim_iounmap_region().
> >=20
> > Signed-off-by: Philipp Stanner <pstanner@redhat.com>
> > ---
> > Changes in v3:
> > =C2=A0- Move __iomem *io declaration into the loop. (Stefano)
> >=20
> > Changes in v2:
> > =C2=A0- Fix build warning because of dead variable.
> > =C2=A0- Make "bars_found" a boolean, since only true or false are
> > relevant.
> > ---
> > drivers/vdpa/solidrun/snet_main.c | 56 ++++++++++++++--------------
> > ---
> > 1 file changed, 26 insertions(+), 30 deletions(-)
> >=20
> > diff --git a/drivers/vdpa/solidrun/snet_main.c
> > b/drivers/vdpa/solidrun/snet_main.c
> > index c8b74980dbd1..643e335f00f1 100644
> > --- a/drivers/vdpa/solidrun/snet_main.c
> > +++ b/drivers/vdpa/solidrun/snet_main.c
> > @@ -556,59 +556,58 @@ static const struct vdpa_config_ops
> > snet_config_ops =3D {
> > static int psnet_open_pf_bar(struct pci_dev *pdev, struct psnet
> > *psnet)
> > {
> > 	char *name;
> > -	int ret, i, mask =3D 0;
> > +	unsigned short i;
> > +	bool bars_found =3D false;
> > +
> > +	name =3D devm_kasprintf(&pdev->dev, GFP_KERNEL, "psnet[%s]-
> > bars", pci_name(pdev));
> > +	if (!name)
> > +		return -ENOMEM;
> > +
> > 	/* We don't know which BAR will be used to communicate..
> > 	 * We will map every bar with len > 0.
> > 	 *
> > 	 * Later, we will discover the BAR and unmap all other
> > BARs.
> > 	 */
> > 	for (i =3D 0; i < PCI_STD_NUM_BARS; i++) {
> > -		if (pci_resource_len(pdev, i))
> > -			mask |=3D (1 << i);
> > +		void __iomem *io;
> > +
> > +		if (pci_resource_len(pdev, i) =3D=3D 0)
> > +			continue;
> > +
> > +		io =3D pcim_iomap_region(pdev, i, name);
> > +		if (IS_ERR(io)) {
> > +			SNET_ERR(pdev, "Failed to request and map
> > PCI BARs\n");
> > +			return PTR_ERR(io);
> > +		}
> > +
> > +		psnet->bars[i] =3D io;
> > +		bars_found =3D true;
> > 	}
> >=20
> > 	/* No BAR can be used.. */
> > -	if (!mask) {
> > +	if (!bars_found) {
> > 		SNET_ERR(pdev, "Failed to find a PCI BAR\n");
> > 		return -ENODEV;
> > 	}
> >=20
> > -	name =3D devm_kasprintf(&pdev->dev, GFP_KERNEL, "psnet[%s]-
> > bars", pci_name(pdev));
> > -	if (!name)
> > -		return -ENOMEM;
> > -
> > -	ret =3D pcim_iomap_regions(pdev, mask, name);
> > -	if (ret) {
> > -		SNET_ERR(pdev, "Failed to request and map PCI
> > BARs\n");
> > -		return ret;
> > -	}
> > -
> > -	for (i =3D 0; i < PCI_STD_NUM_BARS; i++) {
> > -		if (mask & (1 << i))
> > -			psnet->bars[i] =3D
> > pcim_iomap_table(pdev)[i];
> > -	}
> > -
> > 	return 0;
> > }
> >=20
> > static int snet_open_vf_bar(struct pci_dev *pdev, struct snet
> > *snet)
> > {
> > 	char *name;
> > -	int ret;
> >=20
> > 	name =3D devm_kasprintf(&pdev->dev, GFP_KERNEL, "snet[%s]-
> > bars", pci_name(pdev));
> > 	if (!name)
> > 		return -ENOMEM;
> >=20
> > 	/* Request and map BAR */
> > -	ret =3D pcim_iomap_regions(pdev, BIT(snet->psnet-
> > >cfg.vf_bar), name);
> > -	if (ret) {
> > +	snet->bar =3D pcim_iomap_region(pdev, snet->psnet-
> > >cfg.vf_bar, name);
>=20
> Could we also use a temporary variable here as we did in=20
> psnet_open_pf_bar()?

We can. Some maintainers want it so, others so

>=20
> It seems to me that no one uses `!snet->bar` for now to check whether
> they are configured or not, but maybe better to prevent, WDYT?

So it seems that this driver is a bit special as its probe() function
can take different paths running into one of the respective request
functions.
Doesn't look to me as if pcim_iomap_region() could fail and the driver
would still load?

Anyways, better safe than sorry. If you think it's safer I can modify
it so those pointers are valid or NULL.


P.

>=20
> Thanks,
> Stefano
>=20
> > +	if (IS_ERR(snet->bar)) {
> > 		SNET_ERR(pdev, "Failed to request and map PCI BAR
> > for a VF\n");
> > -		return ret;
> > +		return PTR_ERR(snet->bar);
> > 	}
> >=20
> > -	snet->bar =3D pcim_iomap_table(pdev)[snet->psnet-
> > >cfg.vf_bar];
> > -
> > 	return 0;
> > }
> >=20
> > @@ -656,15 +655,12 @@ static int psnet_detect_bar(struct psnet
> > *psnet, u32 off)
> >=20
> > static void psnet_unmap_unused_bars(struct pci_dev *pdev, struct
> > psnet *psnet)
> > {
> > -	int i, mask =3D 0;
> > +	unsigned short i;
> >=20
> > 	for (i =3D 0; i < PCI_STD_NUM_BARS; i++) {
> > 		if (psnet->bars[i] && i !=3D psnet->barno)
> > -			mask |=3D (1 << i);
> > +			pcim_iounmap_region(pdev, i);
> > 	}
> > -
> > -	if (mask)
> > -		pcim_iounmap_regions(pdev, mask);
> > }
> >=20
> > /* Read SNET config from PCI BAR */
> > --=20
> > 2.47.1
> >=20
>=20


