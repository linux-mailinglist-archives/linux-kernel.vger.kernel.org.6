Return-Path: <linux-kernel+bounces-549804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5D79A5576E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 21:28:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 024557A3A98
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 20:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0451527602E;
	Thu,  6 Mar 2025 20:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sl6MefK3"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D85270EA0
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 20:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741292891; cv=none; b=CBDcRvj3j8/WCSpMlPrPVw3/GAOiM+eomBJmXSYt6yMQ7G7X/ZkmS6IQu56Q9HRsXdZezNgnQzMYWN9fSUHrmtEp0kKKz7b9XNWAF/zbjIvbkS6WVQj28r6xShwiCPlXey1JEOKL0XSIGogTzlKpBH1CTRoDWJcjmA9V4oH8KnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741292891; c=relaxed/simple;
	bh=9r+fgi7YcM+OL8YzPJvXm3Tu+DUfhRSJTGCEsOmaks8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aLJ7EfK8KlGOkCN0OvPZ8Scf8D6Zra/PVoPmz+qJgJAVYc9bGB8FR1fFKKOejgZ4QTTM0YPC6ec9hEvcES5mQ9ZykBjQyyrQJ78KjlJ2z6Icx4pylF6iw7a3U8LMJYKMXwTwGdJ0YZMc1+JMM6HX3oniHBZ00BxKewwwdLAHbXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sl6MefK3; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-22423adf751so11046085ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 12:28:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741292889; x=1741897689; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GctVpXPllCHYWuu9hUwNfCuRYyncGsuqbdCvzTlEz48=;
        b=sl6MefK3MtTdAeJS2XOh1/FXZgS6w+Z9Y5mE+VQbBE8xZITjJG46CegOrVxm4DOFcO
         9vjnWBzclMwieDcH3CPJFDppVoWIf+LOsYp6ox3H1Z0gElhGVRB+tXWoXOSolyLPbQlU
         bXG8zCLWHjyPINYwhKK4PeUSqV8gBicvO147bfQkFEC5qWoxDRkqNiKOuyzeD5ZlXWGT
         yCL9ixVGmKlDLGXXuE7gdgl0BScra55pLOsf3JZFFdE8D6pE8nlYIKtWvXxqJk2BJi5k
         KbMuOLnhn71mc+goufmrhGLN3WbT7mIOlGs7WdBABqkZ7AoKScsK+wmh4Q3p3STng5Lu
         RUPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741292889; x=1741897689;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GctVpXPllCHYWuu9hUwNfCuRYyncGsuqbdCvzTlEz48=;
        b=oM5f3wgUasAJsqlLDHIFnw1NAMpypchwQdFV3doSxJD2HG50fxPz/stsCtQDVL3GUL
         JOsYLb9KHmD8+tcJ5Xl2tb6Kw/bDOmfHkvgE6+Jnt2ZjDXGowAOE8GY2xDKFsnTvIIZ4
         H4irxfWXm4jj2uR227seklatP/sIQelBSCRaZuUClpjNPP79/ioZlkMPw3A7b/qweaqH
         qVF88jfQOqKBxhKPwQa0/UA1Uq6gPXaYYlM12AHpBpN1CRX6fJNTehzZgWxRNW1voGI0
         HYDVgepeIDEKj01s4klz/ghdF4QR13QvS3TC4gvTdzK4IZB85MmO1wIFBFxHfmKOmtXT
         cjxw==
X-Forwarded-Encrypted: i=1; AJvYcCWIZ02+OLCfOll3F5zLdLAX2IlRN2J4uXOgj6V/li9ka5qFx3UyHbSr+57Q6fhokPAsFFYZkIN8fME0zE8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYcKPWg/z7qAgDMlzIdTHkMjdgZjpUv+cSiCviUKuxCl7mHl/4
	m9e7DfvlXiAjjD3ystMkVn9VhKvI6V8t9DdWZhl1S6qPIuqeFCEgwqRLeQl6Xw==
X-Gm-Gg: ASbGncsOAdgxVN68bANYFx+lL8FIken8/QfMWp7Z8nqlxaj/iC/S85gQGRdFNZ3KJIn
	HsunhTbD8uL309Mnh0bn6MB2eYmN0DsRMZVzdKDKZ2H/rOV4FFCYOJ2otKNevMbP9jaeqpI8Xk4
	7TemaN7cYVFB/xwrGJOuORgTJbs2W51J5/7zXVUqtnrIze0CqXvrw/uwoYngAzrxBpKidNyi9eO
	eo0R7oM2AgXH2R5Xq+hFuMD+aofYr+NZTyZSUORdCaBe1jE1sPLkQJ0xVKSHAT6PkOgYkcJxQh3
	EwtuIfiVkpFeSP1rTeACVoPKV0z6fOrszuc2lav+ZgBpd8kvYdkTPr1RKcXT0KdrBKiy4QAvE3x
	AVs3s
X-Google-Smtp-Source: AGHT+IFiSHnSkJOs/EER/kwvfX8Ds31VHyJZRbQKYI8qPXYDZiuyjKY9f0E3k62CA9zP4luRElVERw==
X-Received: by 2002:a05:6a21:2d08:b0:1ee:dcd3:80d7 with SMTP id adf61e73a8af0-1f54493353emr1884457637.0.1741292888662;
        Thu, 06 Mar 2025 12:28:08 -0800 (PST)
Received: from google.com (65.185.125.34.bc.googleusercontent.com. [34.125.185.65])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-736985387d3sm1837619b3a.172.2025.03.06.12.28.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 12:28:07 -0800 (PST)
Date: Thu, 6 Mar 2025 20:28:02 +0000
From: Benson Leung <bleung@google.com>
To: Andrei Kuchynski <akuchynski@chromium.org>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Benson Leung <bleung@chromium.org>,
	"Christian A. Ehrhardt" <lk@c--e.de>,
	Jameson Thies <jthies@google.com>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/1] usb: typec: ucsi: Fix NULL pointer access
Message-ID: <Z8oFUiazzBTKnGRB@google.com>
References: <20250305111739.1489003-1-akuchynski@chromium.org>
 <20250305111739.1489003-2-akuchynski@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="VDE8sWMpSlokQIQ6"
Content-Disposition: inline
In-Reply-To: <20250305111739.1489003-2-akuchynski@chromium.org>


--VDE8sWMpSlokQIQ6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Andrei,

On Wed, Mar 05, 2025 at 11:17:39AM +0000, Andrei Kuchynski wrote:
> Resources should be released only after all threads that utilize them
> have been destroyed.
> This commit ensures that resources are not released prematurely by waiting
> for the associated workqueue to complete before deallocating them.
>=20
> Cc: stable@vger.kernel.org
> Fixes: b9aa02ca39a4 ("usb: typec: ucsi: Add polling mechanism for partner=
 tasks like alt mode checking")
> Signed-off-by: Andrei Kuchynski <akuchynski@chromium.org>

Reviewed-by: Benson Leung <bleung@chromium.org>


> ---
>  drivers/usb/typec/ucsi/ucsi.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
> index fcf499cc9458..43b4f8207bb3 100644
> --- a/drivers/usb/typec/ucsi/ucsi.c
> +++ b/drivers/usb/typec/ucsi/ucsi.c
> @@ -1825,11 +1825,11 @@ static int ucsi_init(struct ucsi *ucsi)
> =20
>  err_unregister:
>  	for (con =3D connector; con->port; con++) {
> +		if (con->wq)
> +			destroy_workqueue(con->wq);
>  		ucsi_unregister_partner(con);
>  		ucsi_unregister_altmodes(con, UCSI_RECIPIENT_CON);
>  		ucsi_unregister_port_psy(con);
> -		if (con->wq)
> -			destroy_workqueue(con->wq);
> =20
>  		usb_power_delivery_unregister_capabilities(con->port_sink_caps);
>  		con->port_sink_caps =3D NULL;
> @@ -2013,10 +2013,6 @@ void ucsi_unregister(struct ucsi *ucsi)
> =20
>  	for (i =3D 0; i < ucsi->cap.num_connectors; i++) {
>  		cancel_work_sync(&ucsi->connector[i].work);
> -		ucsi_unregister_partner(&ucsi->connector[i]);
> -		ucsi_unregister_altmodes(&ucsi->connector[i],
> -					 UCSI_RECIPIENT_CON);
> -		ucsi_unregister_port_psy(&ucsi->connector[i]);
> =20
>  		if (ucsi->connector[i].wq) {
>  			struct ucsi_work *uwork;
> @@ -2032,6 +2028,11 @@ void ucsi_unregister(struct ucsi *ucsi)
>  			destroy_workqueue(ucsi->connector[i].wq);
>  		}
> =20
> +		ucsi_unregister_partner(&ucsi->connector[i]);
> +		ucsi_unregister_altmodes(&ucsi->connector[i],
> +					 UCSI_RECIPIENT_CON);
> +		ucsi_unregister_port_psy(&ucsi->connector[i]);
> +
>  		usb_power_delivery_unregister_capabilities(ucsi->connector[i].port_sin=
k_caps);
>  		ucsi->connector[i].port_sink_caps =3D NULL;
>  		usb_power_delivery_unregister_capabilities(ucsi->connector[i].port_sou=
rce_caps);
> --=20
> 2.49.0.rc0.332.g42c0ae87b1-goog
>=20

--VDE8sWMpSlokQIQ6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQQCtZK6p/AktxXfkOlzbaomhzOwwgUCZ8oFUgAKCRBzbaomhzOw
wshkAP9k51Btf5PLARneuF9jO3cYwi1O6adrJbgGw5ruHc53pAD9E7feIK9I8n4/
Py+0rXhG6xMiyiRaA6KCf6/Q9iXhpQ8=
=l0KK
-----END PGP SIGNATURE-----

--VDE8sWMpSlokQIQ6--

