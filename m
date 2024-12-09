Return-Path: <linux-kernel+bounces-437750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E75939E9806
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 15:00:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C6C2283A2A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 14:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32C081ACED5;
	Mon,  9 Dec 2024 14:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bSAaWUoT"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965901ACEC1
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 14:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733752807; cv=none; b=Z0v8CmORe3U5srzPAr5i2shs/JW2wNwAjmoqpjubXDPQQ7no9LCYyyVz6A6VFQ3zzstyRzFAyecHPqGoljWPvbbwXCD6nfp4bJ7b/fqbvwIJ8la61LfKK8J+U+R3rrylkPoITbKmrG/zDA61Z4QpqjpYww95LFdfsFJAKNmtgCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733752807; c=relaxed/simple;
	bh=C5SPkIMLMGPdipV7wV9Knmtkda1Y0Q8dSKm1tzmoOa4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Sp8G9bBEorVpNY5fQRyjmAQV+kHeRcpNtwcg4Us2YzORn0S/ASyQFISR3hWAS/VxQ4IDzTXedvZAHC07kffXQqBfYQZh66yRou1U3h328e7PRq/LOogYValfri/p13aLWyD9An2OKLgm/f+p/oChMDJlbyTKPLMrQj+Hj3+Nit4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bSAaWUoT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733752804;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oCinklkjigCgS0jKysyYQNawyzGFbbjhT/H2okLIUXE=;
	b=bSAaWUoTjgn91rogRodK4Z9C5HbSZkkrzaypYRle6sUufYMR24fmTy1C2OCwne8PJ3m3H8
	WYkcsg2MtsiOV1eEoD5ENq5VO6EK4dqlZqCjeNZpJ9IFH3gpDXVgjAd3xBKrtbkgjuo89l
	VdpsSZ4YGkXrgUG0e5wCPwP5xh2JfGE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-19-TY1A2LhMMtCzq8K7BxiAeA-1; Mon, 09 Dec 2024 09:00:02 -0500
X-MC-Unique: TY1A2LhMMtCzq8K7BxiAeA-1
X-Mimecast-MFC-AGG-ID: TY1A2LhMMtCzq8K7BxiAeA
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-434f852cb35so6570695e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 06:00:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733752802; x=1734357602;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oCinklkjigCgS0jKysyYQNawyzGFbbjhT/H2okLIUXE=;
        b=hyR+4pPq+u5VhXuP5W/m5zr5h1cFHg7rbV3DZA13ds8shDTiWjG7xY41fH/OqmIQLx
         5K5AZXY7XeRnRmW9UmjjQp+IvnW+Rqegd6DxuWLwJ340EVtI83OjhUBCWMmTcttfiEeW
         rN+7fJ2KsH/j1f2OATT3W75kkf8syA6TpORON4DnKInztR/kpDBrJQCXnX77MY80+HQf
         j5PlTvbfklrrReb6R6YXeOY3wdMskyvL5cOF4qlBygLRcdkHLqFME5zGzc8ny1yeB0od
         DKDb/Zpw2KMaoQ2fu0VgtOo4SHpvL8t+XbpkOCFTGYK5QU5cWWlewjBCP8AaKjDfE7xC
         YpFw==
X-Forwarded-Encrypted: i=1; AJvYcCWsjoQ67DPfQWZZTBo10sG9ycnLCD+o4dx1Ppp/DvArgnrv1qQT/noXNClumy8XSfX4jAykww+7pC6yupM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2KMuAm0hm0x3YZUW1lBD3NFwBM55tZhqFzXjhbCg/QNY1xK8u
	0EPYMYcZirxvpjZq4fJLMgEkYuFWJ9U7bi+NabUYSnvQAdnYiXrSeFXRTQI2frcPOplElEUeRqJ
	R4c7z+3F59fwP9PJAHabui4uAhoCwoHEMBiVjz61LKkoyqNXCqNp5DhnBNOpbng==
X-Gm-Gg: ASbGncsqbY9C/UOc7hKeBRgTacOxYFZ/N0odPNkpYHXqvYNo4HYUv+Y2kyk/WrNa/IS
	XC5FN7BDasN86uJ36mJXY9I3jS4ihf1hljf3sCUlkUq2khoN3xc59URmEFvydsIkeykzhLRn8Xw
	TsYnswHXBkWpfA2s9ugJDm3pRgGiTyf/2pttJssrOolq5EmUrgsAEsuWkWTd5hpxLm05nvdVKPt
	QlQi9CxonoF50SMwPLtRIcOz5nLxYpWCfda4dZC+tbEniIUSCRNQC72XWO5A/iFoCgaqwakWFzW
X-Received: by 2002:a5d:64ab:0:b0:385:f17b:de54 with SMTP id ffacd0b85a97d-3862b33f3d0mr10459798f8f.5.1733752801659;
        Mon, 09 Dec 2024 06:00:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGD8yoSQI/o9NyRQ9nL3G8Ec4Yb63GP/cbt9ujdYqnPDIttZz6GWVr7Hj38Vw1jKYW5HojffA==
X-Received: by 2002:a5d:64ab:0:b0:385:f17b:de54 with SMTP id ffacd0b85a97d-3862b33f3d0mr10459774f8f.5.1733752801285;
        Mon, 09 Dec 2024 06:00:01 -0800 (PST)
Received: from [10.200.68.91] (nat-pool-muc-u.redhat.com. [149.14.88.27])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434eba653a0sm83272245e9.22.2024.12.09.06.00.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 06:00:00 -0800 (PST)
Message-ID: <416477913eed1837a3efb0d9a952ea5ee37f538b.camel@redhat.com>
Subject: Re: [PATCH v2] vdpa: solidrun: Replace deprecated PCI functions
From: Philipp Stanner <pstanner@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Alvaro Karsz <alvaro.karsz@solid-run.com>, "Michael S. Tsirkin"
	 <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Xuan Zhuo
	 <xuanzhuo@linux.alibaba.com>, Eugenio =?ISO-8859-1?Q?P=E9rez?=
	 <eperezma@redhat.com>, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Date: Mon, 09 Dec 2024 15:00:00 +0100
In-Reply-To: <whzxo7v7ocomwvx2onrccrrnfc7eg5g5yeusoifmmflaiawaa6@xylztblydibz>
References: <20241209115118.125940-2-pstanner@redhat.com>
	 <whzxo7v7ocomwvx2onrccrrnfc7eg5g5yeusoifmmflaiawaa6@xylztblydibz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-12-09 at 14:31 +0100, Stefano Garzarella wrote:
> On Mon, Dec 09, 2024 at 12:51:18PM +0100, Philipp Stanner wrote:
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
> > Changes in v2:
> > =C2=A0- Fix build warning because of dead variable.
> > =C2=A0- Make "bars_found" a boolean, since only true or false are
> > relevant.
> > ---
> > drivers/vdpa/solidrun/snet_main.c | 55 ++++++++++++++--------------
> > ---
> > 1 file changed, 25 insertions(+), 30 deletions(-)
> >=20
> > diff --git a/drivers/vdpa/solidrun/snet_main.c
> > b/drivers/vdpa/solidrun/snet_main.c
> > index c8b74980dbd1..1b9841698a1a 100644
> > --- a/drivers/vdpa/solidrun/snet_main.c
> > +++ b/drivers/vdpa/solidrun/snet_main.c
> > @@ -556,59 +556,57 @@ static const struct vdpa_config_ops
> > snet_config_ops =3D {
> > static int psnet_open_pf_bar(struct pci_dev *pdev, struct psnet
> > *psnet)
> > {
> > 	char *name;
> > -	int ret, i, mask =3D 0;
> > +	unsigned short i;
> > +	bool bars_found =3D false;
> > +	void __iomem *io;
>=20
> I would suggest to move this declaration (*io) inside the for loop
> where=20
> it's used.

If you prefer that, OK

>=20
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
> > +		if (pci_resource_len(pdev, i) =3D=3D 0)
> > +			continue;
> > +
> > +		io =3D pcim_iomap_region(pdev, i, name);
> > +		if (IS_ERR(io)) {
> > +			SNET_ERR(pdev, "Failed to request and map
> > PCI BARs\n");
> > +			return PTR_ERR(io);
>=20
> Now instead of calling pcim_iomap_regions() once, we need to call=20
> pcim_iomap_region() multiple times.
> If one of these fails, should we unmap the ones we mapped before?

Nope =E2=80=93 pcim_ functions are managed and psnet_open_pf_bar() is calle=
d
only in the probe() path. Failure of the primer will lead to the latter
returning the error, causing devres to unmapp everything that has so
far been mapped.

P.

>=20
> Thanks,
> Stefano
>=20
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
> > @@ -656,15 +654,12 @@ static int psnet_detect_bar(struct psnet
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


