Return-Path: <linux-kernel+bounces-260033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 14BC193A1C3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 15:42:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4105B22B5A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 13:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69D9E15382F;
	Tue, 23 Jul 2024 13:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tf/qBm+h"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5577515382C
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 13:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721742122; cv=none; b=EdaqZf2MaXVVzL26zVReTU0zU7l6zr1CTvxixPXaZEod1kc7LyP68gyH/MQVqtSH76WB9MLzcbPIrgIXt5mC3gMayKfZhM5UflIIwSb5I8DI7mknZo4p9BUFKS7eC0Zdans5CyX25ZBwWkyzcg9MweDJYWHa9igaBeyFhuIKZN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721742122; c=relaxed/simple;
	bh=IdHZU9iwKaUDHBqFADkL46KeDHzTuqNzToVoebjqwsY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iu9o/aK/J7xnZqwbUo9WmZQ4+iGB/yI71uY7jQD8maITS5T0jvQsyaED2DK5S4CiSw00j0VZSVmeAeXRY3sC6DHYaUTyz9ewskGSgheKd/302ifPFQyVBSitLXScgwxuBJEyUXu98wBGm89j/zP1QukNeEGl4fDL9sZg/p0hhA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tf/qBm+h; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1fd7509397bso180255ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 06:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721742120; x=1722346920; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kx7+M6d7Zq/3rbSaEyaIUjUjS9w0AcrnppXBQ67vl3Q=;
        b=tf/qBm+h9lb9xBZtX5ut4JmNNDNliaR+tW32xiacZnI+VB+9QduX/d1RCFX8OnoXdD
         MpzRmuy55fNakfue5ff44GgTlc5NRUOWRVA4UFeXIvG/emdTL2PFOrawjxCsz/40ok6i
         JpXLRe6GQ7ubVoawDK6OLi4LqlcmzQwCt8Hk2i4shH7tZSES0KPPawMvmzxY/4pbc201
         qAf2WAuL8m1HIRZAvmHtPWbW5r0IWiwkJo9MC0t38Z2oc1Wah2WWATVbW57EL4PI6agq
         vspX0dosWWpleA+sR41He9t4VdZE1QkEJfMtPPsEGeWt/T0pHucOKNZHFo0KlqjT6DHm
         JL7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721742120; x=1722346920;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kx7+M6d7Zq/3rbSaEyaIUjUjS9w0AcrnppXBQ67vl3Q=;
        b=EUEIqSGMm39UQgPKVOq6NBz4fcJikox0yCcUmXmJBPois3+enLx7QuJus6fPsAMGbT
         HStm11jIP3kH5vL8F6YtCgkofPlvjKrU9aKjvY1/I+FrsX0MuhQqN1PBrA39BZkKNCZf
         gHp1wEYtzXYYb3ZmYGAutRAgLU/+OYMBZBuEZ2hnvp3ojPOfrExVxtab0NH7lO4rpg9w
         kWfMECYUmiQthr22kNLBEpH5tD4za/ZOkzJ2kpAN69tPN/kTTXAvc/t06xoEnyn4TN2s
         ahODzAM2Kw442sIz1CZ7FVxWksQ0nxLssGyEfXfLappRmxT46wsngalLabJLlZUcqfsU
         jDEg==
X-Forwarded-Encrypted: i=1; AJvYcCW5OIRj4YU344JErQbGe66Gduj6HtyRjKff8QmBppBDwycgaJuYi3Q1Ze9MWU4kroENTa1bJxQKYyCq5HxcvERzQmDBMcPlky5wAUcc
X-Gm-Message-State: AOJu0YyZ4Qdqp7teiYbwHOijVwvY9mz7SttVQHJVs1VD1CmZzibUuRot
	gEfr7oHcWkvNTXaLdeTwDoNTmexxn6n/c5k72v0U0tIA2YUb4KI7Ep8MrWlhYA==
X-Google-Smtp-Source: AGHT+IFUXDw7C2QXnVr2cuN7efFOE5hoF+SttlQTRzFa9PfT4p0Y7oKclGQhbFkG8wFIaKzJMpkWxQ==
X-Received: by 2002:a17:902:db05:b0:1fb:52b1:27ca with SMTP id d9443c01a7336-1fd7ff4654bmr7057095ad.9.1721742120050;
        Tue, 23 Jul 2024 06:42:00 -0700 (PDT)
Received: from google.com (30.161.125.34.bc.googleusercontent.com. [34.125.161.30])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ccf7b2d5e2sm9013856a91.7.2024.07.23.06.41.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jul 2024 06:41:59 -0700 (PDT)
Date: Tue, 23 Jul 2024 13:41:55 +0000
From: Benson Leung <bleung@google.com>
To: Ma Ke <make24@iscas.ac.cn>
Cc: heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org,
	dmitry.baryshkov@linaro.org, bleung@chromium.org,
	utkarsh.h.patel@intel.com, abhishekpandit@chromium.org,
	kyletso@google.com, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, jthies@google.com
Subject: Re: [PATCH] usb: typec: ucsi: Fix NULL pointer dereference in
 ucsi_displayport_vdm()
Message-ID: <Zp-zI8FCg98IYRMI@google.com>
References: <20240723133230.1325392-1-make24@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="KKkQIA2ScFjA3Io2"
Content-Disposition: inline
In-Reply-To: <20240723133230.1325392-1-make24@iscas.ac.cn>


--KKkQIA2ScFjA3Io2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Ma Ke,

On Tue, Jul 23, 2024 at 09:32:30PM +0800, Ma Ke wrote:
> When dp->con->partner is an error, a NULL pointer dereference may occur.
> Add a check for dp->con->partner to avoid dereferencing a NULL pointer.
>=20
> Fixes: 372adf075a43 ("usb: typec: ucsi: Determine common SVDM Version")
> Signed-off-by: Ma Ke <make24@iscas.ac.cn>
> ---
>  drivers/usb/typec/ucsi/displayport.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/usb/typec/ucsi/displayport.c b/drivers/usb/typec/ucs=
i/displayport.c
> index 420af5139c70..eb7d3f97940a 100644
> --- a/drivers/usb/typec/ucsi/displayport.c
> +++ b/drivers/usb/typec/ucsi/displayport.c
> @@ -222,6 +222,8 @@ static int ucsi_displayport_vdm(struct typec_altmode =
*alt,
>  	switch (cmd_type) {
>  	case CMDT_INIT:
>  		if (PD_VDO_SVDM_VER(header) < svdm_version) {
> +			if (IS_ERR_OR_NULL(dp->con->parter))

It looks like you have a typo here.

s/parter/partner


> +				break;
>  			typec_partner_set_svdm_version(dp->con->partner, PD_VDO_SVDM_VER(head=
er));
>  			svdm_version =3D PD_VDO_SVDM_VER(header);
>  		}
> --=20
> 2.25.1
>=20

--KKkQIA2ScFjA3Io2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQQCtZK6p/AktxXfkOlzbaomhzOwwgUCZp+zHwAKCRBzbaomhzOw
wsTpAPsG7x4v9OooowqjUXzYQBYxUqkR3NxqSAbIz/zZlNSnPAD/WDXxv+NCDNQO
YkHLs3XVHygd9zPvLibEtZ0xP4YK5wI=
=b2wO
-----END PGP SIGNATURE-----

--KKkQIA2ScFjA3Io2--

