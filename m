Return-Path: <linux-kernel+bounces-445857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D2149F1C73
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 04:47:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8310165248
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 03:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2854526AC3;
	Sat, 14 Dec 2024 03:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GLFMXoCq"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44AE010E9;
	Sat, 14 Dec 2024 03:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734148044; cv=none; b=iAeOuElug/Dr00xWvDmG9zQeXQ7aNdD9kPnY4s/5oTgjn0KbE1yNGyQi6XmS3+U1VhX8jicZoigHgbMuoqA4CWksXgn8JksZWN2xZ8Y8l7X6Awoz3EocV8OQlb+oRnhEI/2niKytJn/OAVkP8qFTM30E/MTOj44t+YsSlxmZ7tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734148044; c=relaxed/simple;
	bh=BbnsaTgN29i2rCUM12KAjmF9g4gSGVFSQbWcIYmMCEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EyKbtV4L+OnQHloJCnU4JpFB/4TFlSPgWO+wHzkEv7iaTTI+I8O0S7I1FBcNi+9yY9IueU451AoiouGrCZJ1wPTy/eNvvrB13kY/IZo74S5dUiGhlr9wXWChgDai+B/1bBlE1PsANXSkI1w8bIfsPGh1akzq7sWTavXgfSrEoeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GLFMXoCq; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-728e78c4d7bso1809516b3a.0;
        Fri, 13 Dec 2024 19:47:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734148042; x=1734752842; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BbnsaTgN29i2rCUM12KAjmF9g4gSGVFSQbWcIYmMCEQ=;
        b=GLFMXoCq0W/n9kef6qSguUiIaoq2/640Q/6Yhy8VuX030VBl9weBsyyVQOkwZuq/2F
         UWeRMLzi0sJWvyI3onUF06IXouJZukL2W3ROMA0lXk9/D3A/HRKydwqHc4+gIVL9znbO
         m5joFtuER/hj70njR3mHzNG2aoQOSP4xDoIAoD7NeTU3ouyH+RwbjVdWdbw+a2rZVUxZ
         OiJ1JFuchvrMdXkr4fJYRTqSnaPipdpZjQZePbnDjblwh5TfpgPb9tQcWJOdV0Xbsi0z
         w1VkyWxHaWGhq9uUeR3Y9jsejciZ0gmSwW7cLiFiUuVmDQtvL2PhO/9rCl2GbX4omVN/
         uEjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734148042; x=1734752842;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BbnsaTgN29i2rCUM12KAjmF9g4gSGVFSQbWcIYmMCEQ=;
        b=AMkOvp8MXUpyuXd5NOpVpgzWwWqexHgHPwvm4fXUr9iuG63pYrKIHe7Q2HQ/z6MYNL
         NdDLy/tzeg884RsbEUNcEigX2yzZoS9p4LV44L9in7YC5cV9+sSmTimk6FmV68g0Glk2
         423+cHEhyuuX077N4bKlhtn03mylLUrbDVhVB8zy0BnECEWyGaPWBPo51pauDI4k9STT
         qPjA9XU8O6wQwqszACx8u3aSCQp8J/lcszR04digNRGQYnH4JmqWRzE9u5yYAiR6jPfX
         +1CcfirsT8exJ6Xkh+mcBhPxP4Ol/DfgkR7fu+Rd2IPSPlMpZFJOkxoTb/KLRN1kqkmd
         TvVQ==
X-Forwarded-Encrypted: i=1; AJvYcCVv7IKVkgQvXn4HPTMwubZOd0jh4xQ2mTcPZ24T8xPwUzYn67j9AFKolesz2qZMdg7kZfuFv/fPaRw=@vger.kernel.org
X-Gm-Message-State: AOJu0YykLqsDeQ1wr1FhmfFiMgtjhGPlBhGxToflM8eE3WI24nwmos/f
	r233B3WH7Jx+DpKH6Gn3Dp+NXRaoN7CoHEC1yC3yazFFhv+0clNO5QMxDg==
X-Gm-Gg: ASbGncu3FaRxmEu0tDJnjfNQCaJan4NqjCzUAPZDRT//sAaBd0uOtmfYECDFIQlhm7Y
	u+Pt8ygDZMr1qe9+dt24hgnwZEDWqZbEvd4nfYRBA62x8irYFVFd5cI2pKSIGOQsvnMVkRNo+Z8
	HpZGiDTnqkqh1PD1YFf/94v9YW+qJPeCEghFtEGA2osQb5CYs3yQ0Bdg0QmboA/Q7pOUvcU0pPn
	fQaoeJ2Zlfn0kl78GS8xcLzUdAHSR28uLX0CRjGRewdLQbEFytTxaDy
X-Google-Smtp-Source: AGHT+IGtmAhF3ZuDliJ4haorXTo4WotTtbDlX0Vu+RF6UG1SyjpCKXs7FdWqYuzsoVOuqevgc1Naxg==
X-Received: by 2002:a05:6a20:3947:b0:1cc:e71d:ea10 with SMTP id adf61e73a8af0-1e1dac4a13amr9690910637.14.1734148042243;
        Fri, 13 Dec 2024 19:47:22 -0800 (PST)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-801d5c15245sm359675a12.55.2024.12.13.19.47.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 19:47:21 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id B00C241F5559; Sat, 14 Dec 2024 10:47:17 +0700 (WIB)
Date: Sat, 14 Dec 2024 10:47:17 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] docs: admin-guide: add some subsection headings
Message-ID: <Z1z_xRWhg85N_40m@archie.me>
References: <20241213182057.343527-1-corbet@lwn.net>
 <20241213182057.343527-3-corbet@lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="VqT3Yvjy0BlRZV2N"
Content-Disposition: inline
In-Reply-To: <20241213182057.343527-3-corbet@lwn.net>


--VqT3Yvjy0BlRZV2N
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 13, 2024 at 11:20:53AM -0700, Jonathan Corbet wrote:
> As part of the goal of bringing some order to this file, add subsection
> headings to help readers find what they are looking for.

Looks good, thanks!

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--VqT3Yvjy0BlRZV2N
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZ1z/xQAKCRD2uYlJVVFO
owyrAQCIQJtkq/Gu02NABsBz1UOkRccoV5GsAsGhG/WPzygzPQEAtGDTDXxbkO/d
zOsi+RXAOu0boP0VWaA7s3RP17/eKgs=
=jiIP
-----END PGP SIGNATURE-----

--VqT3Yvjy0BlRZV2N--

