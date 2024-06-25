Return-Path: <linux-kernel+bounces-228117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A86AD915B1F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 02:50:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C67931C21574
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 00:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21F0117543;
	Tue, 25 Jun 2024 00:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EOPgn7Rn"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D7C14006
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 00:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719276627; cv=none; b=ktGl4H8vfbtZcRhDCqXt5XC1tEDWFi2G6t/+KWbD/9gBNvhlBOQwLwitI+OAq4EgGvtm6O5W0V12iLoq7EBYUzUt9gjGENt8hpmqiq0I93DRv0oCS2N8GGkTfr3++su1D+KkNcdveJJce+AeSy5n7qgdS6k5lEMd6yzhRIE9xhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719276627; c=relaxed/simple;
	bh=rB2MbipxDzsiH1Hfswz8Ykw9O8jI2q01H75IMdchmOY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H1JrjJ10RDhISdGHu+c8WhHq7gL50ZHWy/6QvdndkUrdgMGm4HCsgffD0XiX2XNlXYLmVxIOUEfCChdDVhit0sSVKal/hBIR12Q6Q/LwOAX1wJDRwPetOPp7vu55ykuTI5+YeYefAoog4NcRowv3lKzu2l03BnPFQQE/HyefsL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EOPgn7Rn; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1f70ec6ff8bso49015ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 17:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719276625; x=1719881425; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HuUUmuhyiaTVcKA0vONscsWMwteJeDj/FdD7FnMQHHk=;
        b=EOPgn7RnRMisQgyTZwaJxGo47m/04av63u0D+kaSjDVUgxGG3Okellna5LIY0FuYCq
         FLFexHNsL6EdWIIK7m4DRC/r9rdjIwxmNgNiiC45kFySzBPf99b7kwfVt87gbW/Bg1X0
         wu5Z/Uz6cCwP9/IaG1qvHg4OLXg6+7hYjZ/CYRF9zcuf5Y0XidiPdGy1te/qdSCi45yL
         POcMWkB5b5F4WLaNGwN+jkvfZfSv5fqg52LBk0d8fFNmgO/8v9V2Wm0/m+y2CgAIgfoa
         GKsP7Jvr0sBdNSmNw+LJgqr+0tHvwXfGVENmlcDDtLttu7SKUkbhciQD2BTrSLGeKpkT
         pMPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719276625; x=1719881425;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HuUUmuhyiaTVcKA0vONscsWMwteJeDj/FdD7FnMQHHk=;
        b=gc9IGPNh+C+mQ6O2yChKHgi6JvLlan8j+x0BBkvsAxgiB/bOnN3h61dW09sSsAVZi2
         UnLsAmyHG1kYYVCDAQv49moCBgvD/JbPGJ4YJM3gQnTLGniA+teNhvkS11sNtmZj5+63
         nK201tUBmnXxqXq+cOb3GYfwwgxO/BGVA5Ma2WtwIrgVOOFxyJC9DvWT7XeHheMbDiX0
         nMC2T/Z/omVLsqesKXs2Bz2dop+Btk9tlHsYLAKmI1fNTAQKrAs9YfP57uRUxFpm+oLc
         L8CQVil8ps94SqGeL7imQhilqWxdZpfcbILkebeMMAl/od6lL4w+PHuD8eia5cpQ35tc
         Xn3A==
X-Forwarded-Encrypted: i=1; AJvYcCWMhYj9j6IZbSz6idnc9yDfJSpPfASA3swR+kMol+GmOKyIenDS6NtMf3+b2JJUZNdefCuh2wiZgJfr1FqBx9wj7YDlVjpfSYFrFk5c
X-Gm-Message-State: AOJu0Yxz6ZoNTVIqmtnVrdzo/VixyYuCfAvyvlQnIu7Ah21jmQlh7LUm
	0x6F86d/YTj05wgrTX81TrwNJtmzQnAbrDiLgY70sd1C6yErNck+DlwwsYJC+g==
X-Google-Smtp-Source: AGHT+IGY3Bx4DM3ftR/tJGFuyc+1khlNaAKY6t6qe6ia5l6qoIh3a9h1jB0maMsux+9q1/QJ+kVtug==
X-Received: by 2002:a17:902:b186:b0:1f6:b033:a4e with SMTP id d9443c01a7336-1fa68fb0a2fmr1524945ad.4.1719276624897;
        Mon, 24 Jun 2024 17:50:24 -0700 (PDT)
Received: from google.com (109.120.125.34.bc.googleusercontent.com. [34.125.120.109])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9eb2f058bsm68735405ad.13.2024.06.24.17.50.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 17:50:23 -0700 (PDT)
Date: Tue, 25 Jun 2024 00:50:19 +0000
From: Benson Leung <bleung@google.com>
To: Jameson Thies <jthies@google.com>
Cc: heikki.krogerus@linux.intel.com, linux-usb@vger.kernel.org,
	jonathanh@nvidia.com, abhishekpandit@chromium.org,
	andersson@kernel.org, dmitry.baryshkov@linaro.org,
	fabrice.gasnier@foss.st.com, gregkh@linuxfoundation.org,
	hdegoede@redhat.com, neil.armstrong@linaro.org,
	rajaram.regupathy@intel.com, saranya.gopal@intel.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] usb: typec: ucsi: Only set number of plug altmodes
 after registration
Message-ID: <ZnoUS1kOL3aYar-Q@google.com>
References: <20240625004607.3223757-1-jthies@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="XS2a0J9riWCr4B+Z"
Content-Disposition: inline
In-Reply-To: <20240625004607.3223757-1-jthies@google.com>


--XS2a0J9riWCr4B+Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Jameson,

On Tue, Jun 25, 2024 at 12:46:07AM +0000, Jameson Thies wrote:
> Move the setting of the plug's number of alternate modes into the
> same condition as the plug's registration to prevent dereferencing the
> connector's plug pointer while it is null.
>=20
> Fixes: c313a44ac9cd ("usb: typec: ucsi: Always set number of alternate mo=
des")
> Suggested-by: Jon Hunter <jonathanh@nvidia.com>
> Signed-off-by: Jameson Thies <jthies@google.com>

Reviewed-by: Benson Leung <bleung@chromium.org>

Thanks,
Benson

> ---
>  drivers/usb/typec/ucsi/ucsi.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
> index 76c48d873b2a..77e46bf4a098 100644
> --- a/drivers/usb/typec/ucsi/ucsi.c
> +++ b/drivers/usb/typec/ucsi/ucsi.c
> @@ -1180,13 +1180,13 @@ static int ucsi_check_cable(struct ucsi_connector=
 *con)
>  		ret =3D ucsi_register_altmodes(con, UCSI_RECIPIENT_SOP_P);
>  		if (ret < 0)
>  			return ret;
> -	}
> =20
> -	if (con->plug_altmode[0]) {
> -		num_plug_am =3D ucsi_get_num_altmode(con->plug_altmode);
> -		typec_plug_set_num_altmodes(con->plug, num_plug_am);
> -	} else {
> -		typec_plug_set_num_altmodes(con->plug, 0);
> +		if (con->plug_altmode[0]) {
> +			num_plug_am =3D ucsi_get_num_altmode(con->plug_altmode);
> +			typec_plug_set_num_altmodes(con->plug, num_plug_am);
> +		} else {
> +			typec_plug_set_num_altmodes(con->plug, 0);
> +		}
>  	}
> =20
>  	return 0;
>=20
> base-commit: 819984a0dd3606b7c46fe156cd56a0dc0d604788
> --=20
> 2.45.2.741.gdbec12cfda-goog
>=20

--XS2a0J9riWCr4B+Z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQQCtZK6p/AktxXfkOlzbaomhzOwwgUCZnoURwAKCRBzbaomhzOw
wmZFAQCFp47heT1YN6FYLm2P3DWbSZj4vlnGqrr7kPehVyjGNAD9GQw4MJzKCCzu
gO9WMGBnDcnudVrf3zovAhs8ESu4fAo=
=y+Vr
-----END PGP SIGNATURE-----

--XS2a0J9riWCr4B+Z--

