Return-Path: <linux-kernel+bounces-339920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 01937986C2D
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 07:57:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3C121F22852
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 05:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB84618757D;
	Thu, 26 Sep 2024 05:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ASb7/1Hx"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 358591865F2
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 05:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727330237; cv=none; b=XzLW1zykyH2s1ecvACGKDFpxP+p7VNa4WWxMEiCspqdyIO3xAZHPwVk/tFrFlDk7ENee2Y4eFHTnaAVtBGRKe9H0MQ+BCsMlBjZPRz6RWfevAwdxTR8FNPa8DN4TKicNB/7/xpijdsZDERHWfTBsVGgPUeTIUoBauaxV4CPj6xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727330237; c=relaxed/simple;
	bh=ITcZgpSh9LkUnu9Tr5EgQGWrxVVYkLELYOcebU23AL0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Szqt5HDekO3b8zfoiRLO01JW6djLkYavOadmxuF7f0ZU5LbLlzb80n8otupFEefK/PqDYtEONRDRRTmLyxDH7kjDXIhSbsbs5XlF1K+yqVbSHOiemw+PY7thZ3Bt3xvpKcffv4C/uums+9e0K10qbmOTVHrXFbiyRRWm2HJvN4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ASb7/1Hx; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-42bb7298bdeso6760305e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 22:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1727330231; x=1727935031; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ITcZgpSh9LkUnu9Tr5EgQGWrxVVYkLELYOcebU23AL0=;
        b=ASb7/1HxoTQIj88hAXUBDCH6uSXWN0RRTZQEKUfUo9cNZgVcu80/H1sHZDBYbMz8nQ
         mwfFbzh8eLRZ0HgOYqBHFEUQSFgZ9DN/zya7ozCQ9TboW8ny5s9xxR+9dX1sbjNfYj2t
         BSWyxuJuHwiAZtQooeuHfeU+VvwteKwJpZWNA0owlIe/05OWPSgsOjJCYbTlUBFol1fb
         nmtCvglJJhtRqNK3of1p6Z1KzC2u95GnTjB9sB1f8m5mGX/T2ly+nt3xiFvyNSLPVaNh
         25vRQ5Xz+BHz4xsGP2A/jEy16kkuiJPTvmYezXMRzzuX6mDXP7/NoSmW/fHflfi5PuFx
         CJ2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727330231; x=1727935031;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ITcZgpSh9LkUnu9Tr5EgQGWrxVVYkLELYOcebU23AL0=;
        b=gq9qb5ZZSj3ZGra75+g4lEWYfAvMrTItKSYkiMKf6ymKcm5wZZh0luX+OudpTk5Kd8
         2Jh4CgwLz2QAAuO/A9R2TdkgkqePG4C2OK8KdqN9iG8ta0pcoMp5RcnIPgRZeifFEfD8
         rpVUvVTMzZVowrOW9QlNRKMPeTs/S0L7uoT+2IcYAW5cZk2+Bmqm72PoNRR//tqGzoaw
         QdSfBdF2g5omt/wnyra5Jxxj53I7HeHoseMfO8OgQfiH45ZyQHU12/xFs4gqWzUTRUhJ
         BdEBg+/L4TDWek/DTUkU0ERg2Xf4Jg7a9Ynsv9B1RuFd27CmorDgJisP7rdIO1pkCZt2
         SSxA==
X-Forwarded-Encrypted: i=1; AJvYcCVtkCzJlJhN0Ar2O8bCSLBc9OzsiNzY+IPNvU+CXcwdwVq4K0A+pGozYsP2BJ6VcMoN29AyhKWBxZrDOZY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3ii1JFXVpbY4ELb75P6z/3NBwFF0TKRwFQNrVGwBgTd5cPcTQ
	5ClQIc/7UNNo+LzJVtBlIho2gPBL7Z4RzHg9pvDhPf2NqRIicB2g88IrjBOyt4I=
X-Google-Smtp-Source: AGHT+IExrhrRpSEyITEQj3X4Ht4Gv1XTDE6DLVsIWnD2pFn4X8BvPA3hJa5P+M0yXmuY0mDkKaPOqw==
X-Received: by 2002:a05:600c:3b87:b0:42c:b62c:9f0d with SMTP id 5b1f17b1804b1-42e96116388mr47382035e9.17.1727330230908;
        Wed, 25 Sep 2024 22:57:10 -0700 (PDT)
Received: from localhost (lfbn-nic-1-357-249.w90-116.abo.wanadoo.fr. [90.116.189.249])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e96a0d8eesm37376845e9.30.2024.09.25.22.57.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 22:57:10 -0700 (PDT)
Date: Thu, 26 Sep 2024 07:57:08 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
Subject: Re: [PATCH v2 0/3] reset: Requesting pre-deasserted,
 auto-reasserting reset controls via devres
Message-ID: <vvthbvqhcvaau2bfvlg7yajpeybrvlvqdmbqzgygk6wyjcf7di@lfwuqmpk2u3z>
References: <20240925-reset-get-deasserted-v2-0-b3601bbd0458@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2lygf7fyh3o4gbis"
Content-Disposition: inline
In-Reply-To: <20240925-reset-get-deasserted-v2-0-b3601bbd0458@pengutronix.de>


--2lygf7fyh3o4gbis
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Philipp,

On Wed, Sep 25, 2024 at 06:40:08PM +0200, Philipp Zabel wrote:
> There is a recurring pattern of drivers requesting a reset control and
> deasserting the reset during probe, followed by registering a reset
> assertion via devm_add_action_or_reset().
>=20
> We can simplify this by providing devm_reset_control_get_*_deasserted()
> helpers that return an already deasserted reset control, similarly to
> devm_clk_get_enabled().
>=20
> This doesn't remove a lot of boilerplate at each instance, but there are
> quite a few of them now.

I really like it, thanks for respinning!

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>

Two small notes: I think __devm_reset_control_get() could be a bit
simplified if it used devm_add_action_or_reset() instead of
devres_alloc() + devres_add(). I also would have prefered an if block
(or a function pointer) in the release function instead of a ?:
construct to select the right release function like e.g.
__devm_clk_get() does it. But that's both subjective I think and
orthogonal to this patch set.

Best regards
Uwe

--2lygf7fyh3o4gbis
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmb097EACgkQj4D7WH0S
/k4qlAf+PJJjeWrIALfzoqWqogeq1qVOmP7PcEPUAiVSKIrfBnzoNlCQ/u1vmIrf
mKl8hI67Lfix4wciDnW3BZ1kgwAA3r/w+QoGuuC7aDY8j0Exh/fTxdYqH8fxg8zP
XyZQFxfh5Z96gQSvusyd3C8Fu+d3WWy+5K81gKb4ohN6QZdOUpvw8goESRQVv103
u64I6rA/iI+DELRdBnI6/1eqWy8RyCa3mDpPTM8sBQDCQRwC9b47i9kpAyJO4sbx
+4X6NJ9iYOE9NlsU/C7WlpoToH7wRWBNkeWUlgTiDCsrw/qBW+ZH1hTPXgazaMMC
72CKjvcYi+rSpZtGdrAg0APbAM1LwQ==
=M8Iz
-----END PGP SIGNATURE-----

--2lygf7fyh3o4gbis--

