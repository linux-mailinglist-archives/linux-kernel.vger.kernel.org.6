Return-Path: <linux-kernel+bounces-347667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5174E98D9E4
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 16:15:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12C5E283110
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 14:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 558631D0E2B;
	Wed,  2 Oct 2024 14:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iNfdZQcl"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D311CFEB3
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 14:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727878290; cv=none; b=CYBsRE31o9IHuNdhc9dlLJxsvggvVdHXf/tks69aOGihMDTNq/BgQHlzOqcJ+fAcx0Z2JKP8uGk1NU0pYfwfagOJfjlZcZn+r8HjP3t8cOzaDrYMVkfORpM+fSo8Y1d1YjphimzANTk9igll+bbOwSn5WxvZy59jb4BsXUaQ6zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727878290; c=relaxed/simple;
	bh=658tIolhIRl4hR8ss4suC20le2vpms7jFq0D5sztqEI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z1Wa+RX6AIAVRGX/KPhmNUZA5lr5dy5YONvisKXJ2+rJ86oVshntxv0yZRyjMSrcKuDpHyZ2PNfXiVwW/sNLvuEOYsw25+5rp1zlzk2HXAZPI1kUb6uB0WM0qNAG72PhEe4j7Eo61YEttHho902LAQuomyJ9VnBI6nchaCejPGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iNfdZQcl; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2e078d28fe9so4857578a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 07:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727878289; x=1728483089; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=658tIolhIRl4hR8ss4suC20le2vpms7jFq0D5sztqEI=;
        b=iNfdZQclDQJU1l0KgtSc0cnG49qvumqGaemAeKJtYriSG5NZ0pasqKm3Rm+AG74O0U
         yIl2fcfCm21abE5pHwBIChQS/klLi6ViBc8Dn6x23gBR1Wm8ZPn1q+UxmXyH0FZm3XYE
         5C5A03k4144Ld4k175fbezHdJjogVhrg9dPOFGlHaJabLIpATkxlzBnV8hLfGE3oWiS5
         KPmWr9mzf4Er2A9MDfGmVTCJhbfmNUNLc4Z8WVx6WgSj/DUpa9eaMdm4J3/BZeiVLJvH
         eFz2RZamNxhb+8IUQTeoOu4JJqwNUfyHsFk/2XIUWw/t43BKFKdopIMgjQWkQnA4zEN5
         yILw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727878289; x=1728483089;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=658tIolhIRl4hR8ss4suC20le2vpms7jFq0D5sztqEI=;
        b=maArsYreUjH29AsgXcPIV5+43v/B8ebdXTm+UVp5suyzABlBtxXe7mtKG9qGSjaSHk
         jJxIalZ/Cjzc6eUlx7SN/NfrsM1RMqcu7m0IguoRHbtLYUYBiZKoc/McIU789DZl9aWS
         44+rr92lxiI8DE5a1PG1IY19mdM9cz2E8TwB8OcnObnM6yrUSP7LEcFp7c/LuNkIKha8
         hZyi4yQaG/hvh0gzbHZYp/PdRaUufjK7hO7utdYWJ/PLlZTbLenHK3z0sCWv/sbOhaA1
         erEsL8dw/QyIjqtzg+icC1khagWZ5Ls/DQojbvtxMfDSUnRrSw9INAcG+0c5DjXi1hWb
         /6vg==
X-Gm-Message-State: AOJu0YxhAeS4huf87DCU47ufePTuQqRlDv6Hhk+fdZ3GUtsVLbOegf1k
	qc+Qzq2veNjTb20RCqkVSc3jRo9UCDVONBJUXOv15r/sbC7rFTJ4dhrxA7SG
X-Google-Smtp-Source: AGHT+IE6HMz7Mf0hqhONvP3HfSyUkiwkuRdRuUZP48zvw4TTXmXSxTM6hylAuterwKZyH20ycNGXFw==
X-Received: by 2002:a17:90a:2f62:b0:2c2:5f25:5490 with SMTP id 98e67ed59e1d1-2e18493e7e4mr4037185a91.34.1727878288570;
        Wed, 02 Oct 2024 07:11:28 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e18f791966sm1596050a91.22.2024.10.02.07.11.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 07:11:27 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id E516A420B882; Wed, 02 Oct 2024 21:11:21 +0700 (WIB)
Date: Wed, 2 Oct 2024 21:11:21 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Okan Tumuklu <okantumukluu@gmail.com>, shuah@kernel.org
Cc: linux-kernel@vger.kernel.org,
	Okan =?utf-8?B?VMO8bcO8a2zDvA==?= <117488504+Okan-tumuklu@users.noreply.github.com>
Subject: Re: [PATCH] Update core.c
Message-ID: <Zv1UiXMbwlK9mieQ@archie.me>
References: <20240930220649.6954-1-okantumukluu@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mPrM+OeFNQ6sdFp1"
Content-Disposition: inline
In-Reply-To: <20240930220649.6954-1-okantumukluu@gmail.com>


--mPrM+OeFNQ6sdFp1
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 01, 2024 at 01:06:49AM +0300, Okan Tumuklu wrote:
> From: Okan T=C3=BCm=C3=BCkl=C3=BC <117488504+Okan-tumuklu@users.noreply.g=
ithub.com>

Please use your real email address and don't forget to add Signed-off-by:
trailer (`git commit -s` does it for you).

>=20
> 1:The control flow was simplified by using else if statements instead of =
goto structure.
>=20
> 2:Error conditions are handled more clearly.
>=20
> 3:The device_unlock call at the end of the function is guaranteed in all =
cases.

Split logical changes into separate patches - in a patch set.

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--mPrM+OeFNQ6sdFp1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZv1UhAAKCRD2uYlJVVFO
ozIyAP0QpbsXSyC/AX4mc9p/4uvTLf58BDjpe7PTvDs/W0USDgD/cV+gk9wgscwt
uuYp8CmTwBzpilmgKlVuUFnkOdn2VA8=
=uXT+
-----END PGP SIGNATURE-----

--mPrM+OeFNQ6sdFp1--

