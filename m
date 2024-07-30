Return-Path: <linux-kernel+bounces-266627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1C389403AC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 03:28:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D11E281998
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 01:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1DD19479;
	Tue, 30 Jul 2024 01:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N5YrCEXD"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145899450
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 01:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722302913; cv=none; b=iilv8q6TSUKEkxMuX8EbeKHnh6JVHTzQvJuEpcDwvlMjCw8OPHBL9kHEtmzCoF5cidmJEW9E91eXGnSrZIKgTVlhUDmg29Sywn7simaphJ0WSABId5uvnjuy8iz2ALtrAqUIx9CER9NWg7wE7YwFmH2f6Zo38dmmtQ3JAvk6VQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722302913; c=relaxed/simple;
	bh=bHLggzBkR32ABTBuDeD5m8BceYVfT11ujqxOCYp94L4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ev2c8QMPrE0jLrMD0JeziCYnJRV9oVDfP9SC0QRItfJ9/JdD+b9SXySlRJtfAAKHd3yquMXvNn+K0EIqvF2e6WB/PL6GOgwacTyvT6elEPX/5yu8CXVdLKPFx7SXnFoUkfQ8jNpxU53OoAshzPHV3fwu3EyXSGtyIsum75OF1Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N5YrCEXD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722302910;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5xktMOVoHugI0lTfnvlwNQ+Q7ARYmOA7NCAixOdxBTU=;
	b=N5YrCEXDb/LYno9A4kA/DhcIqIseTcdhSADhRpfgpR30u29fJsw+AMWUSNLd4qQeYnxXtu
	cfRxg6RFDA1E2Kkl5Vnb18QSIZl58P4PcR2ZUseqROWsZSXUUD/9EypA+arT2fsf+fyqZe
	BSUQ9RwnO+IjQ5p6vRwCqcU2qHFANP8=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-OXuO0xakMO-cdrduclCyGg-1; Mon, 29 Jul 2024 21:28:28 -0400
X-MC-Unique: OXuO0xakMO-cdrduclCyGg-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-5a45054aa03so1674440a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 18:28:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722302907; x=1722907707;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5xktMOVoHugI0lTfnvlwNQ+Q7ARYmOA7NCAixOdxBTU=;
        b=ig6g9a9FiAUiUXssePgbwKqX11/PXrX85DDnuW7BAaTrqOfo2bOn6Fj1n5mF4iQh7t
         uVgHhfqSAvqR5202L/i5n0WCjzRssHGu/jTl1XwAwbOYYVFfHzUl9nVRoWOmqqrDZjWV
         yYdt5nm6kPLn/V9Kiz7yajGv0JXyN/yIJptulY8hS627ir+hizRAp0pUzm9EfnEqkG1U
         FjH6wRF12qAIhMa//X0GzrPMbdpN9B4ctGSPhqyBz3cBxKWllSXpDVlNcIlR3DdcFpfF
         QgLLc+az5FR22FXrg6LZcWw6k6TK1ENSisqvpNDNOUaLGmn2qafr9pIN68l9VqgVSpwa
         l8og==
X-Forwarded-Encrypted: i=1; AJvYcCXXaF5J7buYwkXzw8RFmzJxzWG893OoofFQZd+Vv07N8Bpt+Rw/TNSh40dmUJS0MbUvM0lZGpPYx05/Wg23ZWa2NtdbsXanHyn/2Owr
X-Gm-Message-State: AOJu0YyPTUZphfdJeaZxP7lty/tamGOAJGyeRnrC2gp3MDV/cZsyljF6
	nJEzBKIMahTR/I1dlt58GkB143KinYLeLbVNK1GU410Dmw1cRbXjdSX+BX3KaHn7B43+d1EW5IS
	jC109BfinkLq46sXh8ijoqdAS9w908SJcdShUWkr3uM0dPGSCi6W0UiylomtfNMdGfXMffrI7WB
	tN36knmO9+2ZUJZdBDK6KySxsqvmOmHiZu0I8O
X-Received: by 2002:a05:6402:3481:b0:5a0:d004:60c6 with SMTP id 4fb4d7f45d1cf-5b021d22ba2mr8115646a12.18.1722302907437;
        Mon, 29 Jul 2024 18:28:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFdPTNCvh6T69SK0IJXobLvCIllL/ErzFAg0dOuyEmshyYj0yciGy5k79zWO9SA5PSF4d+cis7D29a6K9GM9s8=
X-Received: by 2002:a05:6402:3481:b0:5a0:d004:60c6 with SMTP id
 4fb4d7f45d1cf-5b021d22ba2mr8115635a12.18.1722302906995; Mon, 29 Jul 2024
 18:28:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240729052146.621924-1-lulu@redhat.com> <20240729052146.621924-2-lulu@redhat.com>
 <52af9b4f-aa8f-4c6f-9ced-c6fa9b396343@lunn.ch>
In-Reply-To: <52af9b4f-aa8f-4c6f-9ced-c6fa9b396343@lunn.ch>
From: Cindy Lu <lulu@redhat.com>
Date: Tue, 30 Jul 2024 09:27:50 +0800
Message-ID: <CACLfguVHKw-ppXeA8DDH0CtvYZ9m8rkk+Jr7ZF9pFfbLr1VRGQ@mail.gmail.com>
Subject: Re: [PATCH v7 1/3] vdpa: support set mac address from vdpa tool
To: Andrew Lunn <andrew@lunn.ch>
Cc: dtatulea@nvidia.com, mst@redhat.com, jasowang@redhat.com, parav@nvidia.com, 
	sgarzare@redhat.com, netdev@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 30 Jul 2024 at 03:13, Andrew Lunn <andrew@lunn.ch> wrote:
>
> > +static int vdpa_dev_net_device_attr_set(struct vdpa_device *vdev,
> > +                                     struct genl_info *info)
> > +{
> > +     struct vdpa_dev_set_config set_config =3D {};
> > +     struct vdpa_mgmt_dev *mdev =3D vdev->mdev;
> > +     struct nlattr **nl_attrs =3D info->attrs;
> > +     const u8 *macaddr;
> > +     int err =3D -EINVAL;
> > +
> > +     down_write(&vdev->cf_lock);
> > +     if (nl_attrs[VDPA_ATTR_DEV_NET_CFG_MACADDR]) {
> > +             set_config.mask |=3D BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MACADD=
R);
> > +             macaddr =3D nla_data(nl_attrs[VDPA_ATTR_DEV_NET_CFG_MACAD=
DR]);
> > +
> > +             if (is_valid_ether_addr(macaddr)) {
> > +                     ether_addr_copy(set_config.net.mac, macaddr);
> > +                     memcpy(set_config.net.mac, macaddr, ETH_ALEN);
>
> ether_addr_copy() and memcpy()?
>
> > +                     if (mdev->ops->dev_set_attr) {
> > +                             err =3D mdev->ops->dev_set_attr(mdev, vde=
v,
> > +                                                           &set_config=
);
> > +                     } else {
> > +                             NL_SET_ERR_MSG_FMT_MOD(info->extack,
> > +                                                    "device does not s=
upport changing the MAC address");
>
> You would generally return EOPNOTSUPP in this case, not EINVAL.
>
> Also, the device does not support setting attributes. Given the
> generic name, i assume you plan to set other attributes in the future,
> at which point this error message will be wrong.
>
sure=EF=BC=8C will fix this
Thanks
cindy
>         Andrew
>


