Return-Path: <linux-kernel+bounces-177434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6C388C3E86
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 12:01:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C460283505
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 10:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A60481494A6;
	Mon, 13 May 2024 10:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X7X8b9Ul"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B603A148827;
	Mon, 13 May 2024 10:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715594511; cv=none; b=OM/59BUVfW+eREBfz+csr3HU2zAvOt5CGNNP+WeEI2l5ieUo4BK+vnjYnZ3DdDY18gztJobau8gaTdXyr1vCdvGvAkzWqfiP5pWv0MZbc0hNguUUFGCOybKJk2leu4CjRW4FRFVAjkxInxfstwEp3I5zY/0TN7m68cEHn0guPsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715594511; c=relaxed/simple;
	bh=Qo9o1XrA1EO5JUb/ndwrJm6xU9C72R1Z1+wD2dPNngg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bqjP4w+9GKbvghSNWjlUbSPBe4WQmC796Nys4HKN0B61bGbT5myQGeqkCm3+DDBfviBnePbN6kVojC0rTjlnnOPyd7C5QaA/PjoKePk0jti0xYXd6eCLLT4ivPbvGqc5FWaITDZfW48JgOuvCckzogr5MC6/pApwhrmtjTElO8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X7X8b9Ul; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6f4178aec15so3564628b3a.0;
        Mon, 13 May 2024 03:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715594509; x=1716199309; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wsHGrQD8d3vZOGtUj6cKrKPve0b+TKlEfKoHtxLtx4o=;
        b=X7X8b9Ul8KSJl6mM/Zq8g8Gtw5+m9PMrWQZBODNJ1GHUJz4kvAeD4zqjKWA8pI9mus
         kzEKzI0jfJVjYZU0MVllBfJzvONTo5lbj5+OOaONLzzJnFqqFsSUSlCM9fD6w6O5VAwP
         Y0kOPX8yqJ/CZJRFFbA8oGifeM84eeLHlv+4eMgMtuhfxC2yGG72pEDjuuiOgIc9URND
         9qOwunhcQ08+G9cv4znghD5WnEXL8XTyu4i+1icwQhgxy3jmwomNjiLv9b6OzjeBFkf5
         Q3x90DuLnXPgLQHXt1rTGtoHpdbt2VhmhXXxpgW3iGtttYkb/IQrSk9J7qghv+5Nx6np
         +wtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715594509; x=1716199309;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wsHGrQD8d3vZOGtUj6cKrKPve0b+TKlEfKoHtxLtx4o=;
        b=LL0IO9FD138y7rvh69NMlPldsJE+9d9vlgH8gW77YTUGAllgyzo0vSIcAeuQRwczTk
         0kkb+eABhRHCV0q9XiDIN/86XG9bZUdb5Z6ZS3+b9jeQmShNPVuJKDKhQPnOYO/yOWv6
         +PE5PtG3vWA6o6eO3RA8NLN6TbOjsh+4AR7DWAGJUG2yqhSeq6JI0lRpjHvjK/tj9gzI
         i8SRyX8qs6QS0uA5CFjuLPFg7TmjNpy5R8dOH01Nhf15od//cwILPzEGxFDpIDxXio3n
         45ck2NmGOVLISJGPB5B7Dl+kCI/h0bAcOXE3Qy58Sr3Cy7axnH2xQxtoW8So9eCjXU4f
         Z3Og==
X-Forwarded-Encrypted: i=1; AJvYcCWY82txHscD0MS7/VT6XqKl3Vo8vAaT/zwyWTNFq5EKCGhPUQi6lGAqC8EUdEQ+iqeQLhA2PQokmWvNJ7TXPLJaRf57ysmguf26b8BYrDUAWjoOJpwYau7SrZzZLWzE9TA4V/t7X24Qlr8=
X-Gm-Message-State: AOJu0YxCd1Idw/TQvJljQfHZW2fAI2c+Snr4D3x/6Wa2EF8wI3ZMxUzB
	F9rQ3BUkBJKwMCbh7hxoBG5ZCGhfujGDz2x2wezY6hn9i9coMWy5
X-Google-Smtp-Source: AGHT+IHa3sJVlFM/28jWPbP/W6FAHtXJtAWQ2RUQQSOhav83y7X/ocw5OvnlM0IrqcbHWJQ4M0P6zQ==
X-Received: by 2002:a05:6a00:1943:b0:6ed:de6e:dd24 with SMTP id d2e1a72fcca58-6f4e02cebeamr10496414b3a.16.1715594508848;
        Mon, 13 May 2024 03:01:48 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2b26cf5sm6997997b3a.195.2024.05.13.03.01.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 03:01:48 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 12A33184885CF; Mon, 13 May 2024 17:01:45 +0700 (WIB)
Date: Mon, 13 May 2024 17:01:45 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Noah Wang <noahwang.wang@outlook.com>, jdelvare@suse.com
Cc: linux@roeck-us.net, linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: add MP2891 driver
Message-ID: <ZkHlCanX_CLg1SEr@archie.me>
References: <SEYPR04MB64825A740FDE7282B2FECEE2FAE22@SEYPR04MB6482.apcprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zV8qHaqC4xTI+Syi"
Content-Disposition: inline
In-Reply-To: <SEYPR04MB64825A740FDE7282B2FECEE2FAE22@SEYPR04MB6482.apcprd04.prod.outlook.com>


--zV8qHaqC4xTI+Syi
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 13, 2024 at 01:52:25PM +0800, Noah Wang wrote:
>  Documentation/hwmon/mp2891.rst |  95 +++++++++++++++
>  drivers/hwmon/pmbus/Kconfig    |   9 ++
>  drivers/hwmon/pmbus/Makefile   |   1 +
>  drivers/hwmon/pmbus/mp2891.c   | 210 +++++++++++++++++++++++++++++++++
>  4 files changed, 315 insertions(+)
>  create mode 100644 Documentation/hwmon/mp2891.rst
>  create mode 100644 drivers/hwmon/pmbus/mp2891.c

You forget to add toctree entry:

---- >8 ----
diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
index 1ca7a4fe1f8f57..5825a056ad054f 100644
--- a/Documentation/hwmon/index.rst
+++ b/Documentation/hwmon/index.rst
@@ -164,6 +164,7 @@ Hardware Monitoring Kernel Drivers
    mlxreg-fan
    mp2856
    mp2888
+   mp2891
    mp2975
    mp5023
    mp5990

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--zV8qHaqC4xTI+Syi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZkHlBQAKCRD2uYlJVVFO
o8B5AQDg5ODcn2tSF79O9KxdpsZipGzgANXBlQiayYiEseUcIgEA33Arcbyuilde
zDbmZAqlquxNa1u4c1N9Sf9nkHa4ngY=
=3uyn
-----END PGP SIGNATURE-----

--zV8qHaqC4xTI+Syi--

