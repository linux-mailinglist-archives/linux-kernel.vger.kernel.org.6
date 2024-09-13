Return-Path: <linux-kernel+bounces-327687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C2EC9779AC
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 09:32:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B623288574
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 07:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 412A9187355;
	Fri, 13 Sep 2024 07:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="kjlh8vBL"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 592911D52B
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 07:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726212734; cv=none; b=CIiCXCOb+ksHEgaPKFhdFxC/I7kbNOGjd+Jx3+/PJRcGCYJNIeX2yn+cX7pJd0Z8rdpAJNQ5gF8cmhJfgTzsmtffWGhtiHpX5z1llwvh8i/FlRmRecLLSXxcJPVn9lq+pCkdjGN4TThsnT4jxfc+p1YX+gG/CnZtGjP6WXIIN9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726212734; c=relaxed/simple;
	bh=zCD8LaN0kjsKdIM6ZRCopPXn4g4+foguZouvDF3CqkU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K+o9MR++suXS5eA3AvBfapSB+k2zkWs1zAHefpzNHfhhetTmBVsLiowniqIhj6a/6kLiGplyI5stwl36yRAOlTcrKEP4V3argZWnrn2G92lrHmWeh5k1LMunvaQCgMUgJCStkYUkcvuAYo6g9iegySqZhEcocrLB9LrIdAjVbdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=kjlh8vBL; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a8d0d82e76aso260337966b.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 00:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1726212730; x=1726817530; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zCD8LaN0kjsKdIM6ZRCopPXn4g4+foguZouvDF3CqkU=;
        b=kjlh8vBLGDBORhkUtQS3p3feRa+rlSTrjIG23NsKkVA3lGaR1zQEbBPBqrETGMgXW8
         jiaGWGkFmA3pA6Mu/pNupur2p4RZxWBObuhr7EXk1Q+sz/ZRL2lR73t0IYmaDoITyWvc
         bzghjJ6SLUOOgYjQi13VvN1rGGih1dIFg4j3ZzL7bXyo6o8Y72Kfylh6XSLEK+OYUuem
         eJpBQeroiwmajGHj47AhfpwdQ6c9fjTDOc7ypOu5mXGUo0GORXw+2Kw5+Rvl+Ow8UXgl
         5GuSQAHetuAJ3lopfJS+MLQjzyxe4LYEE5ID5k/IOizZsok+OSRxm6sFRWNmAvDPeiFX
         qeqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726212730; x=1726817530;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zCD8LaN0kjsKdIM6ZRCopPXn4g4+foguZouvDF3CqkU=;
        b=JE3VmxdUr28sB/HaIRATaw5fAn0LKnMwL22Sw9NiS0kZu6q+m7Vv+CIkR7aT7wGwko
         WBQjcURsUwZoF3RAbP52eN7+791kBvOak8Zq4xMjs53XGgjFr+bHjGLVxjAn5CyLImNx
         F+raIoV0goZTRiiHtjMZ7UmXb+B2iW7CHBZsIH1LmNAwMAyATpgNRI43AffvxE05eztI
         g4dy0oQrPdwDFARMIcooO1BGt3RqkkjJbiHybG6znmdSc97HYIdXpbH5NantMO2hPxqg
         q1pPCLafYmVSY75PgOIJFPo3XTROI7C3HGB22Y7LDAxoMYj4CGPQABqyGFlb3aXuVMl7
         myDw==
X-Forwarded-Encrypted: i=1; AJvYcCXRKSTY/RlvCALdDICXCiSIkI4Ef4urIdA4Q5rJXB9IhHk+4VQUuuy4254F4dqEqt0k2+fy8+GYvEUwEYM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFdokyZzzmm5ZI9eWyPjVJSk+giLzCnYAAKrMWYd9C3m0OFQKS
	3fHlAL1ZmmnXIL2N1IqewjX/aAJ8hN9/0Z4UFJnIAFyD4qG6SZ7f4k2EbcFonPM=
X-Google-Smtp-Source: AGHT+IHssm2URqE1gS4gVcn6Nj0DllldqANqwzd6oBjRAAhdE80d1B5MN/NDiKEsCAH6AylUactzuQ==
X-Received: by 2002:a17:906:fe47:b0:a7a:3928:3529 with SMTP id a640c23a62f3a-a90293b188cmr601509866b.13.1726212730074;
        Fri, 13 Sep 2024 00:32:10 -0700 (PDT)
Received: from localhost (p5dc68d3d.dip0.t-ipconnect.de. [93.198.141.61])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25cf371bsm842411966b.175.2024.09.13.00.32.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 00:32:09 -0700 (PDT)
Date: Fri, 13 Sep 2024 09:32:07 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Devarsh Thakkar <devarsht@ti.com>, jyri.sarha@iki.fi, 
	tomi.valkeinen@ideasonboard.com, airlied@gmail.com, daniel@ffwll.ch, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, praneeth@ti.com, nm@ti.com, 
	vigneshr@ti.com, r-ravikumar@ti.com, j-choudhary@ti.com, grandmaster@al2klimov.de, 
	caihuoqing@baidu.com, ahalaney@redhat.com, cai.huoqing@linux.dev, 
	colin.i.king@gmail.com, javierm@redhat.com, dmitry.baryshkov@linaro.org, 
	geert+renesas@glider.be, laurent.pinchart@ideasonboard.com, robh@kernel.org, 
	sam@ravnborg.org, simona.vetter@ffwll.ch, ville.syrjala@linux.intel.com, 
	wangxiaojun11@huawei.com, yuanjilin@cdjrlc.com, yuehaibing@huawei.com
Subject: Re: [PATCH] drm/tidss: Add MIT license along with GPL-2.0
Message-ID: <3y4pqlazkuofc37s6zlw7waqzmtdl5iydhm4i3i45n6d6pnflc@osyocv7wxtif>
References: <20240912171142.3241719-1-devarsht@ti.com>
 <c501c5d3-d715-4ac5-98be-35d23ad1cfbe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fwomuhf5lvybpujn"
Content-Disposition: inline
In-Reply-To: <c501c5d3-d715-4ac5-98be-35d23ad1cfbe@kernel.org>


--fwomuhf5lvybpujn
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Thu, Sep 12, 2024 at 10:47:31PM +0200, Danilo Krummrich wrote:
> On 9/12/24 7:11 PM, Devarsh Thakkar wrote:
> > Modify license to include dual licensing as GPL-2.0-only OR MIT license=
 for
> > tidss display driver. This allows other operating system ecosystems suc=
h as
> > Zephyr and also the commercial firmwares to refer and derive code from =
this
> > display driver in a more permissive manner.
> >=20
> > Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
>=20
> My only contribution to this driver was through DRM refactorings,
> but anyways:
>=20
> Acked-by: Danilo Krummrich <dakr@kernel.org>

Similar for me. I only touched one of the affected files with a
refactoring change (34cdd1f691ade28abd36ce3cab8f9d442f43bf3f). I don't
assume this gives me any copyright to that driver, but to simplify
things:

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>

Best regards
Uwe

--fwomuhf5lvybpujn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmbj6nUACgkQj4D7WH0S
/k6Vowf/SMe2WNrVNQ5D0QME7lNXR9gfCQBxgUOR1uEijmytgCZX6K8s8KmQRPd+
m6GRlpvCWOkFDA/0l4cKexh7gkMG/K94hY0pBGlgCDgu0O+4Nhtx/XTo/MRBDZRx
yDtWz3YS1LJyOmzt5ogOea1ZxANsYDVKnoLZ737p1oOTrXGqeOJiVxhl4qzpS2Dq
jhIw+wntbT6Ea0SsGKoFaKFkbiYa8/Demkgd39Kpb/OEXgAnTDlgLhBPGi+PjlX2
Jdo2G2TsHCuOLBe4J9OgcLSUkKM8STnGjX4tMMA4mjxXUZrxbwXZ+GSENcDNRJ/z
BFLRA5gh7qOuYJsECveGW/1huoN3Tg==
=BVdJ
-----END PGP SIGNATURE-----

--fwomuhf5lvybpujn--

