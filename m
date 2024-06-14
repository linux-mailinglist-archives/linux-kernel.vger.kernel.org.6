Return-Path: <linux-kernel+bounces-215153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67BEC908ECF
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 17:35:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 094AB2818E7
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 15:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 901A615CD64;
	Fri, 14 Jun 2024 15:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="nLsPPILe"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA8A3B1AB
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 15:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718379313; cv=none; b=o/StxEFVCAnhOVQTERrqjeuRUwHYU+EGUFrMYT1U4EWNvxO/xObB9XnpM1jcqFN9LWbPEfOCA3l6Y8YjLRP/v9nas8fdDS7qzfcnPtWlF0A0DvE9mGnCjhK8xLctykhYIG+dVGsr0YUqT6+cdDz2wyIiOtePGieN8FKdf0PIXuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718379313; c=relaxed/simple;
	bh=By+OoUK9phjDxFni9NpDYhaOStLT4N1Ufyg/V2rZsuM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aWxxd+eki2QscaCdksrAH3Fdxtm4Xs9Cwgi9adjB0DMvPwJVONOZBp1BmL+9/e6hR9LUo2uLjw4Bl4vDrU6G0jCTjafNlK/tnmRep5ykJ2wKbF4yYkhwYzbkTe6ivBjJCalRBH1WKzJn6oOzSzSybVGdTLu4Gy9Ni7C7Vu7zQFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=nLsPPILe; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2ec002caf3eso38163611fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 08:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718379309; x=1718984109; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=By+OoUK9phjDxFni9NpDYhaOStLT4N1Ufyg/V2rZsuM=;
        b=nLsPPILey2jD3seYmP68z6SLyndCASGyfQre4fy54xmJm+Suif8hg/mcv4Gi029hpp
         vu2iBc4QYZvm6EMN4RCySgNJwp3+VZptNtAVTNU00Zo2enINoAaoWwRAFWLMcub7v+cJ
         XQMMEqffUgP27ooAmFUX/BKpkDGnvYhwTTj/oomMY1oQtcAu8RjjKh9+LdTsnA7+48j5
         4JwEi95WscZoDmLadMY2OFTqVaci8B9c8W4VNtnDdtaRjE85E6l2eLm7vzCIkDvNTTyC
         vtxMImDmCVOHj8oO1RpIcFv4mZQX5x7XyHiy50o6u+zo/fqa75O4ZuFJxEfNRbl544QB
         DMaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718379309; x=1718984109;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=By+OoUK9phjDxFni9NpDYhaOStLT4N1Ufyg/V2rZsuM=;
        b=C4t6UhvOJL2Q/N+X0PGOUL6fWAc3jahgE3MDnCaYlqqppAwyCRSurwhTFsYAphfgoN
         +9/HHmbeROei6nt6JRNa6O1B4YYPG1bd1u1i76JnVNPdWjLTMjUcd/KXs/Ga42J+BD71
         0Nc+sr2GbtclyVACS7O8yFWUhtTHfjoEgHvjkCRoe/TDtqzyjL8AJgtN4d5T/KAdN148
         BUI+EmdYb6OFRSuXTUe7edFfuv7Klm2q+CWMxzT9pPFtotGWA3ajFMK5SAGbt/mOf1gD
         rggEMpRmliSByCWigJCGOLyDOKxHTee6++aTjuilnvaej/2uSUlhLGvjQyRGO8EyXE3v
         M9IA==
X-Forwarded-Encrypted: i=1; AJvYcCVRQxG+Ro1xdIXlGKS/nnDwde5xTznf8iKW6LqUHV+RZY70gr8nqoduoRZy3t/XAam0bVcZSKhoIEimnk2XQrOq167Xi7s7Tk4zLo3+
X-Gm-Message-State: AOJu0YxCb+mMCvMO4omva3L4yPq+WzkXBz2/e5JXjwrP0a949uFZESli
	Sve/UFiTsJrRQic/fAeBy0Woo02ebqwLyG9x3pq5sjEXBdtPSfZUp5iBOCdw+Rw=
X-Google-Smtp-Source: AGHT+IEZFCe/X0dPZ4UuhbZeK/Ijt1BLha/MawlM++zT52lImv6xyoOojlWTAYxhTmOdMBbXtX4hig==
X-Received: by 2002:ac2:44a2:0:b0:52c:a5cc:27e7 with SMTP id 2adb3069b0e04-52ca6e9dafcmr2324082e87.66.1718379309156;
        Fri, 14 Jun 2024 08:35:09 -0700 (PDT)
Received: from localhost (p509153eb.dip0.t-ipconnect.de. [80.145.83.235])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f56f40fe2sm200252766b.148.2024.06.14.08.35.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 08:35:08 -0700 (PDT)
Date: Fri, 14 Jun 2024 17:35:07 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Sean Young <sean@mess.org>, linux-kernel@vger.kernel.org, 
	linux-pwm@vger.kernel.org
Subject: Re: [PATCH] bus: ts-nbus: Use pwm_apply_might_sleep()
Message-ID: <rlpicrfrp4nsftgj24oakn6urj7axi2gptrlzpdk3f2scvmzqb@5caoklb74wvm>
References: <20240614090829.560605-1-sean@mess.org>
 <xj5mqnte5dgs4yzuku6g7gnprgm43tdbunxmo6o4thzreyraok@kttvkz5dhaei>
 <1f13c705-dec7-48f6-a6d7-4a9000eedf7d@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="c5ub5pa2ooxsz7dl"
Content-Disposition: inline
In-Reply-To: <1f13c705-dec7-48f6-a6d7-4a9000eedf7d@app.fastmail.com>


--c5ub5pa2ooxsz7dl
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Arnd,

On Fri, Jun 14, 2024 at 01:38:05PM +0200, Arnd Bergmann wrote:
> On Fri, Jun 14, 2024, at 12:06, Uwe Kleine-K=F6nig wrote:
> > On Fri, Jun 14, 2024 at 10:08:29AM +0100, Sean Young wrote:
> >
> > Thanks. I guess the patch becoming
> > 8129d25e32b7fd0f77bc664252321f3a16bb26b8 was created a while before
> > pwm_apply_might_sleep() was a thing.
> >
> > Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>
> >
> > Arnd, you merged the last changes to that driver. Do you want to care
> > for that one, too? If not I can apply it via my pwm tree.
>=20
> Whichever works best for you. I generally take drivers/bus
> and drivers/soc fixes through the soc tree, but if this is
> a PWM related change then having it in the pwm tree makes
> sense as well.
>=20
> If you like me to pick it up through the soc tree, please
> forward the fix to soc@kernel.org.

OK, then I pick it up and consider it done. Thanks.

Best regards
Uwe

--c5ub5pa2ooxsz7dl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmZsYykACgkQj4D7WH0S
/k4xQwf/RPjgnr71cDGKDmyjNofEfiQ1ZhYO5iXTl8+UCZqHHQ+9E5JiswnpxUDi
nLBXz3EHObg2h+x0f7HpDn4TLGgn0zLCJ5R1mUhtJXgYU0v61Xs4XJDGhTQ075zM
+7GoRqdNAhtsycqHhXRy5Dkgr0nTMhQjhpSpVfrWFImvy4CV4FfWuWB6k60aFKvC
mNJPJhu+9jrs2P2HGu4rxv6IHhgUJrB2uC4Rp/rJoh6bHOls5usy1OTffCkvndTi
TOGz/D8L0qabV5zpOyoBt/VygYr9lbu3WY8Bs6bnfPMF8miWptTIiJ6X+pIyAMJf
kqBUuTD9Ri+GtNUMWxwviNJVVx1AnQ==
=49MG
-----END PGP SIGNATURE-----

--c5ub5pa2ooxsz7dl--

