Return-Path: <linux-kernel+bounces-225591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 094A591329D
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 09:47:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26292B22300
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 07:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 781BA14B976;
	Sat, 22 Jun 2024 07:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="yef4gcAj"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED284436
	for <linux-kernel@vger.kernel.org>; Sat, 22 Jun 2024 07:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719042447; cv=none; b=Zkt+jOjxyXJT1uB/mAZQ6mK31U9zAGtHj18AWadTiAZ1UDlO+qXXAo3a9ZCVNXfEq+2zhqJMQVqQwDBY44Rm0lmn/kHCqFfXztt0+xMCSM+A0vZhPLF38Suo3yyF0NtEBBSP1spK9CHCvmuqV/fKS3j47aOoU6XHYBAXMc1TILE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719042447; c=relaxed/simple;
	bh=0xjQbaF0wGZrQmhafej0Nl0GkwJTdHTb6T+wAHqySYM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G/t6O4b71aCpH7Oil3KbedXG5nhn8dcQqpu3GkkaNmj6s/k9NeWtdKGwKihRe8PGSLXGnDyzGbJNREZC8HCodduUu7FPrtbtjqrX/lAcGypm5M7baZXwuRfqT3tFibr5i4XVB98IWwT79AOh+Q9+O33OlxMY+eqjliGEMXTIZN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=yef4gcAj; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a6fd4d1c173so156435366b.2
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jun 2024 00:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1719042441; x=1719647241; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=egkT34FStinIi5BkZ/h/jEaWV4yUSynJFOp+kYLOY+4=;
        b=yef4gcAjr+tpoMwzseddIwdo4n8vgWJfiGdxsfIUJ6wABweleo5fQuX6UDP2pzhaAF
         MDaw6OELoTlSZN46Ecyetz7LxGA6dlWpith3HGRbgDhdfYKg9JSwWMoy2/nY+fCIBSuK
         zr+5sF6e6dkZLRPUaSRknGe8rrmXyNDH/B2rJdTjop4/uvq1Xdx5lPyanfDRyjBAYxED
         oWUu+lxpgVybzWgbJ19CIu9sc9Ag+GxM86QVOGqmgdZIEe2nhrJ0E0vrqDs1vCQg63TQ
         W0OUuJV7x4/awCzypBQ1lWiGc6r0WfMeTzSzGBu9zMKStngxaW394vtNhRGm8aqPE/gn
         ehVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719042441; x=1719647241;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=egkT34FStinIi5BkZ/h/jEaWV4yUSynJFOp+kYLOY+4=;
        b=avOPmeH3IKPAbELnJPuBTi9hbk+QyQAzh5E0ULgo8K5yhxRQI2It0BR/bhHp9MwL1J
         E/UMVVfrHDSgs59auZIeLtM29keU5B8cXQxnjweN9iqw70oEGpKSWpydZ5dkwjUdHh1Q
         yFLBZ0w8QxX/pKkMIDmJlFCaSU3kEvKzPf6wBe6Xrc6KesilcPmOFJOUekFEUp53pESG
         Un8+LN3xj81clEBH7gsYgSQNYA0YgKax19eg9dn/R0xRGD+H9UPHo+44fhLNHmtzpEbK
         WWkPQ40kT85O9DU/TmZAZPOyOHaBi9fkNus6pv8abnxku5us39hRYR0bacKNULKfYvkq
         zgww==
X-Forwarded-Encrypted: i=1; AJvYcCWAjxw4jkktUOa6luJhDqmHGiNjwo4Q6HCYny4umlN+LVA1n3GvtsyXXylvxkbnxFj5O5VW56kmJeM20pLlAnWAyZxbySwSkTEDmgbe
X-Gm-Message-State: AOJu0YzT7viS4Jkw7uIZjiWE7OtoKH/NmxBwbqLOCm2qyEAeuMOKm0Is
	ovhd+6hQrrH2R8LCRtcLyZcrCFv2WZZ7fyFj1HQ/GLi+u8ZXJdCDO6jhkxIlM00=
X-Google-Smtp-Source: AGHT+IFQZalXzWXKTfpK1rpPFKZCzbe6vcliQxlkxyj23v7dOhbR1lWTpg5u2CBCr97Ku5zNvey0Ww==
X-Received: by 2002:a17:907:da3:b0:a6f:6f11:2f11 with SMTP id a640c23a62f3a-a6fab7d6dc8mr702812866b.77.1719042441184;
        Sat, 22 Jun 2024 00:47:21 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:36f3:9aff:fec2:7e46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6fcf560956sm163855866b.181.2024.06.22.00.47.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jun 2024 00:47:20 -0700 (PDT)
Date: Sat, 22 Jun 2024 09:47:18 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
Subject: Re: [PATCH RFC 1/3] reset: replace boolean parameters with flags
 parameter
Message-ID: <o3rf7gprs7mrldglqg7e4scibumdno36iuvtlr3c43sofjcb2t@w3d7jsjyddxe>
References: <20240621-reset-get-deasserted-v1-0-94ee76fb7b7d@pengutronix.de>
 <20240621-reset-get-deasserted-v1-1-94ee76fb7b7d@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="f7ya6rdc5z2khkfi"
Content-Disposition: inline
In-Reply-To: <20240621-reset-get-deasserted-v1-1-94ee76fb7b7d@pengutronix.de>


--f7ya6rdc5z2khkfi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Philipp,

I like the idea in general. Just a detail concern down below.

On Fri, Jun 21, 2024 at 04:45:02PM +0200, Philipp Zabel wrote:
> @@ -999,8 +1001,9 @@ static struct reset_controller_dev *__reset_find_rcd=
ev(const struct of_phandle_a
> =20
>  struct reset_control *
>  __of_reset_control_get(struct device_node *node, const char *id, int ind=
ex,
> -		       bool shared, bool optional, bool acquired)
> +		       enum reset_control_flags flags)
>  {
> +	bool optional =3D flags & RESET_CONTROL_FLAGS_BIT_OPTIONAL;
>  	bool gpio_fallback =3D false;
>  	struct reset_control *rstc;
>  	struct reset_controller_dev *rcdev;
> @@ -1065,7 +1068,7 @@ __of_reset_control_get(struct device_node *node, co=
nst char *id, int index,
>  	}
> =20
>  	/* reset_list_mutex also protects the rcdev's reset_control list */
> -	rstc =3D __reset_control_get_internal(rcdev, rstc_id, shared, acquired);
> +	rstc =3D __reset_control_get_internal(rcdev, rstc_id, flags);

If RESET_CONTROL_FLAGS_BIT_OPTIONAL was passed to
__of_reset_control_get(), you're forwarding it to
__reset_control_get_internal(). But the latter doesn't do anything with
that flag. I wonder if the API would be still less prone to error if
you'd filter out RESET_CONTROL_FLAGS_BIT_OPTIONAL before passing to
__reset_control_get_internal() and in __reset_control_get_internal() add
a check for unsupported flags.

>  out_unlock:
>  	mutex_unlock(&reset_list_mutex);
> @@ -1096,8 +1099,9 @@ __reset_controller_by_name(const char *name)
> =20
>  static struct reset_control *
>  __reset_control_get_from_lookup(struct device *dev, const char *con_id,
> -				bool shared, bool optional, bool acquired)
> +				enum reset_control_flags flags)
>  {
> +	bool optional =3D flags & RESET_CONTROL_FLAGS_BIT_OPTIONAL;
>  	const struct reset_control_lookup *lookup;
>  	struct reset_controller_dev *rcdev;
>  	const char *dev_id =3D dev_name(dev);
> [...]
> @@ -1422,7 +1423,7 @@ EXPORT_SYMBOL_GPL(of_reset_control_array_get);
>   * Returns pointer to allocated reset_control on success or error on fai=
lure
>   */
>  struct reset_control *
> -devm_reset_control_array_get(struct device *dev, bool shared, bool optio=
nal)
> +devm_reset_control_array_get(struct device *dev, enum reset_control_flag=
s flags)
>  {
>  	struct reset_control **ptr, *rstc;
> =20
> @@ -1431,7 +1432,7 @@ devm_reset_control_array_get(struct device *dev, bo=
ol shared, bool optional)
>  	if (!ptr)
>  		return ERR_PTR(-ENOMEM);
> =20
> -	rstc =3D of_reset_control_array_get(dev->of_node, shared, optional, tru=
e);
> +	rstc =3D of_reset_control_array_get(dev->of_node, flags);

Is it an error if the new devm_reset_control_array_get() is called
without RESET_CONTROL_FLAGS_BIT_ACQUIRED in flags?

>  	if (IS_ERR_OR_NULL(rstc)) {
>  		devres_free(ptr);
>  		return rstc;

Best regards
Uwe

--f7ya6rdc5z2khkfi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmZ2gYQACgkQj4D7WH0S
/k7q9gf8CKxq7UNCjz/HiKIaXZg0GftqRGoXijvAokcVLRdSmsrGZTJIhJRoSmfW
tQaopw0SpYEodXErtsEf7s0COPGrO1OLB3BJVkLIJXyi6B4ok1jUP6KsYsXu/wdH
6heS+kTeHGMYrPF5Wo4+/45MF0jNUV8zJW3AzaYm5rSgm9F8/nLyt3/fEMPjFQf/
6uy6pjCj2M6WKrcuNw7Hzs+4o9O/Vm+YPzXyJ5qeaczx3LSztYsMyQ3cR/pGGkDt
Ol+RsYFohzVaK66ezkZgpKMkxz4NeN/JeKtNCPVAPmH4TIm5Eu8p/9PYtZjzUdWQ
QQj1YlYvMG4vaiyfeGEHyrrWGxBkHg==
=IiSn
-----END PGP SIGNATURE-----

--f7ya6rdc5z2khkfi--

