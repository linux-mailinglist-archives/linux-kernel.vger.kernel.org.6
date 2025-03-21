Return-Path: <linux-kernel+bounces-572090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FA12A6C65D
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 00:19:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40F9E16B364
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 23:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1858232792;
	Fri, 21 Mar 2025 23:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="083mogp6"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6930920F093
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 23:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742599013; cv=none; b=TstiVsOPU8MHJzNoUXJqKuo/n+InJHJYZiEyv8adGgOf+N5NDjgWjfreF2Kmie6bOlzQrgDku+bPcTUCQfXb+gj6y3vDw2JQNTCouZKj0i51cNif327p/nFsZ/ToJDCs7kNjp/tpa/2y7u6rIfgC1vOL57J9pFTZ8i3iIiOSx14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742599013; c=relaxed/simple;
	bh=8DKaaQsE+scs9IafPhGAEN9NCbmfrSyJ0w8/Xd4IlfY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BVyL1166jlKNVfcsN2b5/agNU15+2AiHwBWaA3zYoexvLKpfz6HPACfhwWpqaYjji+SSMatIL5wO0HbCcn4gxoEXAgC/mvL/g5cUWt1/sAVyyNnyWwPSEJM5mbScTn4gR7ls8nAt33wzoaSrmhXzxRVL7VULAnz0XQAWLOAD/oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=083mogp6; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-226185948ffso52229185ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 16:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742599011; x=1743203811; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OIH7ijeBPiqYRtbzIPfbeGjnxQWH5Tz1Ymx0+lmARm8=;
        b=083mogp6PTA20FKNijOETmLv9aZtDH212EAJBGgs6DaPl1IGtRZspiCRxofSUmVGcf
         l2aYeIdHzGFqnyBdsh16TMhHAbeUI/B8SGQkcSget+a0bPeLb2Qaj4nrX7rYmZgaYeQB
         ZuL+cr+3bTolgbfY368hH9/H+8BFSHUKzNL5Y+Wu4bDuJzy6FGMouSI4urYRnQ6wno0d
         +68tqci+8nXz7v0Qsqor0iHl+UQ68/MdE+TbegoYpCcg7VliuD2CKtcJlXnDfY96w40Y
         2kxQnoYGV5PJH7qd+YvGExYCL5tNn1Kd1W4eeD0ShKpFSwvG3U4en9gOupYUG3RZ5Z/K
         xgvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742599011; x=1743203811;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OIH7ijeBPiqYRtbzIPfbeGjnxQWH5Tz1Ymx0+lmARm8=;
        b=c10WW5bjnlh4l8mEESMwkKBv0DQrJaDuWzA1i6F5a2RFxJWrKUMz2sLSfI9sdIMgdp
         WmH9xhsHUUojeRhdfCCXxlhBn4/FQdmvsclFmelM0JTsVtsqkrex3p/MeEhQnFRfUWJn
         7heGGVR9OB27IdKg6ievDeEcIeMKl07SJU4ks4ARuROhoOoaJTJAsQ9jiqm70cfpLesh
         3sfcFOJdLeHrbQOR9CkADkFIHkB5YR/Cmp0UL+fFIqqUMNkom+yc+vLfxkOmY4I2Hxly
         HERqI1fegK+rlvbwnBCH246f2zSVkddIMFvX9k7X+o7jk4OdSoXubR8R6nCb79iFuwwc
         Hfsw==
X-Forwarded-Encrypted: i=1; AJvYcCWj9nRUYNc3gTpygmFJMSNc0u0kpZOeV1qmcy25v7FhXB1ZyM6SNkuipho7dbCjavcIUUG2lPsgcXiDK2g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxN+0iQ7ZaT+z2OqUTHpBTxldoOKf+jZbFkyx41vkSKFkbeNDI1
	VK+Sj7W4APIeBOYfWvFBiHBR8/ZgNDuhhr+IkAjb68JqR/mSQJpWoLMbvlqNRA==
X-Gm-Gg: ASbGnctpx+PJSNOk6jYGbzTI/be/5qGfMBAvEdbqWbVgsZamwL7X/cJy74W0rdr28Mp
	kCj5P2w2AECUJfRBHr8X2Fbr56noxQuVOGlrM1dI4Ow49To1DU1J+L4Rt9OUnrai808tYLPQ8TQ
	JAGba8CFz5wnXElzkGDU/WYE8/rvHZU822AbzC+sEY8oEqmI+jayEBO2fXTfU1YCJmKJYpkR2//
	VgLyDQB5rrTGX/NgXZ+sJvEbju94WsO4XLeTBf9+ncYAnmj/rS6qRBTh8KAfKuOHv+NjSqND4L7
	0sMkJMIbg6L3lyVpcRjtBwVHkRt1I9NFcZT+byv0Mtx3S/+AhzrKLM3tQeCSCa2tNemKXWVGXzL
	SpiygGiI=
X-Google-Smtp-Source: AGHT+IG+S/vbJZ8UdHGhIlmSLgyiSEb9xnXeh1Dx5wYWoCCxNEnUuuhrUbiG8myJeH5qClc9kzs0uw==
X-Received: by 2002:a05:6a00:1393:b0:730:9801:d3e2 with SMTP id d2e1a72fcca58-7390599a142mr8273307b3a.8.1742599010047;
        Fri, 21 Mar 2025 16:16:50 -0700 (PDT)
Received: from google.com (132.111.125.34.bc.googleusercontent.com. [34.125.111.132])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73905fa92dfsm2639905b3a.5.2025.03.21.16.16.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 16:16:48 -0700 (PDT)
Date: Fri, 21 Mar 2025 23:16:44 +0000
From: Benson Leung <bleung@google.com>
To: Andrei Kuchynski <akuchynski@chromium.org>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	Benson Leung <bleung@chromium.org>,
	Jameson Thies <jthies@google.com>, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] usb: typec: class: Fix NULL pointer access
Message-ID: <Z93zXHJPO3UHY_YF@google.com>
References: <20250321143728.4092417-1-akuchynski@chromium.org>
 <20250321143728.4092417-2-akuchynski@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="oA1blLjyxrjfEY96"
Content-Disposition: inline
In-Reply-To: <20250321143728.4092417-2-akuchynski@chromium.org>


--oA1blLjyxrjfEY96
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Andrei,


On Fri, Mar 21, 2025 at 02:37:26PM +0000, Andrei Kuchynski wrote:
> Concurrent calls to typec_partner_unlink_device can lead to a NULL pointer
> dereference. This patch adds a mutex to protect USB device pointers and
> prevent this issue. The same mutex protects both the device pointers and
> the partner device registration.
>=20
> Cc: stable@vger.kernel.org
> Fixes: 59de2a56d127 ("usb: typec: Link enumerated USB devices with Type-C=
 partner")      =20
> Signed-off-by: Andrei Kuchynski <akuchynski@chromium.org>

Reviewed-by: Benson Leung <bleung@chromium.org>

> ---
>  drivers/usb/typec/class.c | 15 +++++++++++++--
>  drivers/usb/typec/class.h |  1 +
>  2 files changed, 14 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
> index 9c76c3d0c6cf..eadb150223f8 100644
> --- a/drivers/usb/typec/class.c
> +++ b/drivers/usb/typec/class.c
> @@ -1052,6 +1052,7 @@ struct typec_partner *typec_register_partner(struct=
 typec_port *port,
>  		partner->usb_mode =3D USB_MODE_USB3;
>  	}
> =20
> +	mutex_lock(&port->partner_link_lock);
>  	ret =3D device_register(&partner->dev);
>  	if (ret) {
>  		dev_err(&port->dev, "failed to register partner (%d)\n", ret);
> @@ -1063,6 +1064,7 @@ struct typec_partner *typec_register_partner(struct=
 typec_port *port,
>  		typec_partner_link_device(partner, port->usb2_dev);
>  	if (port->usb3_dev)
>  		typec_partner_link_device(partner, port->usb3_dev);
> +	mutex_unlock(&port->partner_link_lock);
> =20
>  	return partner;
>  }
> @@ -1083,12 +1085,14 @@ void typec_unregister_partner(struct typec_partne=
r *partner)
> =20
>  	port =3D to_typec_port(partner->dev.parent);
> =20
> +	mutex_lock(&port->partner_link_lock);
>  	if (port->usb2_dev)
>  		typec_partner_unlink_device(partner, port->usb2_dev);
>  	if (port->usb3_dev)
>  		typec_partner_unlink_device(partner, port->usb3_dev);
> =20
>  	device_unregister(&partner->dev);
> +	mutex_unlock(&port->partner_link_lock);
>  }
>  EXPORT_SYMBOL_GPL(typec_unregister_partner);
> =20
> @@ -2041,10 +2045,11 @@ static struct typec_partner *typec_get_partner(st=
ruct typec_port *port)
>  static void typec_partner_attach(struct typec_connector *con, struct dev=
ice *dev)
>  {
>  	struct typec_port *port =3D container_of(con, struct typec_port, con);
> -	struct typec_partner *partner =3D typec_get_partner(port);
> +	struct typec_partner *partner;
>  	struct usb_device *udev =3D to_usb_device(dev);
>  	enum usb_mode usb_mode;
> =20
> +	mutex_lock(&port->partner_link_lock);
>  	if (udev->speed < USB_SPEED_SUPER) {
>  		usb_mode =3D USB_MODE_USB2;
>  		port->usb2_dev =3D dev;
> @@ -2053,18 +2058,22 @@ static void typec_partner_attach(struct typec_con=
nector *con, struct device *dev
>  		port->usb3_dev =3D dev;
>  	}
> =20
> +	partner =3D typec_get_partner(port);
>  	if (partner) {
>  		typec_partner_set_usb_mode(partner, usb_mode);
>  		typec_partner_link_device(partner, dev);
>  		put_device(&partner->dev);
>  	}
> +	mutex_unlock(&port->partner_link_lock);
>  }
> =20
>  static void typec_partner_deattach(struct typec_connector *con, struct d=
evice *dev)
>  {
>  	struct typec_port *port =3D container_of(con, struct typec_port, con);
> -	struct typec_partner *partner =3D typec_get_partner(port);
> +	struct typec_partner *partner;
> =20
> +	mutex_lock(&port->partner_link_lock);
> +	partner =3D typec_get_partner(port);
>  	if (partner) {
>  		typec_partner_unlink_device(partner, dev);
>  		put_device(&partner->dev);
> @@ -2074,6 +2083,7 @@ static void typec_partner_deattach(struct typec_con=
nector *con, struct device *d
>  		port->usb2_dev =3D NULL;
>  	else if (port->usb3_dev =3D=3D dev)
>  		port->usb3_dev =3D NULL;
> +	mutex_unlock(&port->partner_link_lock);
>  }
> =20
>  /**
> @@ -2614,6 +2624,7 @@ struct typec_port *typec_register_port(struct devic=
e *parent,
> =20
>  	ida_init(&port->mode_ids);
>  	mutex_init(&port->port_type_lock);
> +	mutex_init(&port->partner_link_lock);
> =20
>  	port->id =3D id;
>  	port->ops =3D cap->ops;
> diff --git a/drivers/usb/typec/class.h b/drivers/usb/typec/class.h
> index b3076a24ad2e..db2fe96c48ff 100644
> --- a/drivers/usb/typec/class.h
> +++ b/drivers/usb/typec/class.h
> @@ -59,6 +59,7 @@ struct typec_port {
>  	enum typec_port_type		port_type;
>  	enum usb_mode			usb_mode;
>  	struct mutex			port_type_lock;
> +	struct mutex			partner_link_lock;
> =20
>  	enum typec_orientation		orientation;
>  	struct typec_switch		*sw;
> --=20
> 2.49.0.395.g12beb8f557-goog
>=20

--oA1blLjyxrjfEY96
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQQCtZK6p/AktxXfkOlzbaomhzOwwgUCZ93zWwAKCRBzbaomhzOw
whHhAQD+8sY8h9MFvLXXJX6m474QUzZ0HHuNX40P6R8IYKKqagD9GKf8CySd6Duo
INhWr5qPzNJGGbEPtJO1uox4DHWFuQg=
=yS43
-----END PGP SIGNATURE-----

--oA1blLjyxrjfEY96--

