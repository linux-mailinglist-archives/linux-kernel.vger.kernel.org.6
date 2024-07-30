Return-Path: <linux-kernel+bounces-266630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCDF49403B7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 03:29:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70A601F22704
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 01:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72B8CBE40;
	Tue, 30 Jul 2024 01:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cjbpV/ti"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E608821
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 01:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722302958; cv=none; b=kYbfxcUnl7+nqL+SvKnuFnUK/ZfNvWKuhDYyCNrTnr+8YijLUxql3kwI/b6fV8X+FGgjimkDXqkZc/72LFMOTPFnDKBZ5GCoQuXaPX3J3o3WZ3gJKOFS/Lr0S6VczDpY7mCyLZw06DKF6v/S1GQkkTZCh1evD+v9AakfXjUPSSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722302958; c=relaxed/simple;
	bh=6V2Eg0+AV6C5wE2oxMFjIOKPbugqLyq7K0dfTJQYrkA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ua/wUufqjjh3T9MK7gOw1Q/YdUYhK/+cg6+wmoUcAvXUreatzFWepZcS+kaOi4HzR7NM3ArZ+O63zkxL7+CEkZ9yZdGCv8fNbKnwbO+M3Zz6kAu8DCKOJoU8OG9VZK94w8XzXh83bBOVljWN+jtGsE7nhs/ihwYsSfiVXzQfDA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cjbpV/ti; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722302956;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O7worZc1WoS5CXw2Mg6pRcBJ9Od3yKPnwBVoMm0OgZU=;
	b=cjbpV/tiZGvODTayr3j4CoXyfisOtLhAP72sMGUo6+kGpIwVwOc9SQ1TnPi28SaWdqh6qP
	RKLg4V4YKyOG9CDt8v4sIG5mbwQQ64bdVrlhBpdTXjjqU/u4CKj3xQjzvtJI8ZVJGytuLB
	CiudeAMWH9FwWwp3SR8vec/kj17foRY=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-596-YBogom0uPfiG47FPyHLo8A-1; Mon, 29 Jul 2024 21:29:14 -0400
X-MC-Unique: YBogom0uPfiG47FPyHLo8A-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-5af786d643aso2570367a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 18:29:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722302954; x=1722907754;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O7worZc1WoS5CXw2Mg6pRcBJ9Od3yKPnwBVoMm0OgZU=;
        b=QdD1K0EKEV2Jum8guLBXjh9AcEnDKp1+CJQBLuoH3sUtVlHyIG213azt7WtzpWjmbx
         t3OSR10A+ngRbXcVIZZaV6xYM7wfkqL+UG14Ubi2GWyqZBJpQwdQZDWiZt3uP1NNMkM2
         urP78h+azpUSCkmhArDsnZWYezRT65E1UEBz4gQvVI2Hrc+A2y+xDlqh9RoOLfsiWJsp
         +uo9z+HBD9Os79zpUKJEd9DHPUgW9osIWdNFSO27fnKx0oB3Kllc+5HnDx320kKjmI1A
         k1jSQ9M6Z6AWL6zCdd6H6vQvmuHLQlXWqkInOAbhyH/x5sWB0HsQGomWhbbqJXTUTOO0
         g8ew==
X-Forwarded-Encrypted: i=1; AJvYcCXl1WQ+l+qNg+79mnvWv4G9csvKoJWHmQXMSAECzluqbm21Yc09/uDNqh1OnG40oidKMoHQLApeu7gWLLSOfcz2XdAfJqaTaAUtEEyl
X-Gm-Message-State: AOJu0YwqtoG7g2fZqaGY2MU0o1x7LmuYzfsOt6aR4VAGbp3V1AR8/VyO
	CS9bs328zr88Y4R2c9rakC29h1OE+FFpQyvZINpYpk8mJ2K3n+nVmDpDarRc7OwPZ2SLKR9jyXp
	GuVqGUz7sHHHnV5jnrPYlV7f/2eHnpjlqbMigwNV3LAqnulRG58gdjyxGLx+W4E6ysWD6orWFPQ
	jtp61X301t60TTZcVQhznTEzyR0Tcun25P+GJW
X-Received: by 2002:a50:aadb:0:b0:5a3:3b44:ae00 with SMTP id 4fb4d7f45d1cf-5b020ea8945mr5859943a12.20.1722302953771;
        Mon, 29 Jul 2024 18:29:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGLuOO7m5Qr5P8MSrVRUXIug1lSaQ0AKlobOKhsrzfg5Qpeu0JjwO/i2NWbI/Rn9Tgkhkq9CAnEijp0eyxafS0=
X-Received: by 2002:a50:aadb:0:b0:5a3:3b44:ae00 with SMTP id
 4fb4d7f45d1cf-5b020ea8945mr5859930a12.20.1722302953410; Mon, 29 Jul 2024
 18:29:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240729052146.621924-1-lulu@redhat.com> <20240729052146.621924-4-lulu@redhat.com>
 <aa0ffd28-bfb8-4b25-8730-a522861bca98@lunn.ch>
In-Reply-To: <aa0ffd28-bfb8-4b25-8730-a522861bca98@lunn.ch>
From: Cindy Lu <lulu@redhat.com>
Date: Tue, 30 Jul 2024 09:28:36 +0800
Message-ID: <CACLfguWt1Uw=tpKCViz9+Hv-s3EvuAc6YeHP3yWYtg6tnuC9Hg@mail.gmail.com>
Subject: Re: [PATCH v7 3/3] vdpa/mlx5: Add the support of set mac address
To: Andrew Lunn <andrew@lunn.ch>
Cc: dtatulea@nvidia.com, mst@redhat.com, jasowang@redhat.com, parav@nvidia.com, 
	sgarzare@redhat.com, netdev@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 30 Jul 2024 at 03:16, Andrew Lunn <andrew@lunn.ch> wrote:
>
> > +static int mlx5_vdpa_set_attr(struct vdpa_mgmt_dev *v_mdev, struct vdp=
a_device *dev,
> > +                           const struct vdpa_dev_set_config *add_confi=
g)
> > +{
> > +     struct virtio_net_config *config;
> > +     struct mlx5_core_dev *pfmdev;
> > +     struct mlx5_vdpa_dev *mvdev;
> > +     struct mlx5_vdpa_net *ndev;
> > +     struct mlx5_core_dev *mdev;
> > +     int err =3D -EINVAL;
>
> I would say this should also be EOPNOTSUPP.
>
sure=EF=BC=8C will change this
Thanks
cindy
> > +
> > +     mvdev =3D to_mvdev(dev);
> > +     ndev =3D to_mlx5_vdpa_ndev(mvdev);
> > +     mdev =3D mvdev->mdev;
> > +     config =3D &ndev->config;
> > +
> > +     down_write(&ndev->reslock);
> > +     if (add_config->mask & (1 << VDPA_ATTR_DEV_NET_CFG_MACADDR)) {
> > +             pfmdev =3D pci_get_drvdata(pci_physfn(mdev->pdev));
> > +             err =3D mlx5_mpfs_add_mac(pfmdev, config->mac);
> > +             if (!err)
> > +                     ether_addr_copy(config->mac, add_config->net.mac)=
;
> > +     }
> > +
> > +     up_write(&ndev->reslock);
> > +     return err;
>
>
>     Andrew
>
> ---
> pw-bot: cr
>


