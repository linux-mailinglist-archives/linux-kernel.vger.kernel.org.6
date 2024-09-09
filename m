Return-Path: <linux-kernel+bounces-320792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23736971044
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 09:51:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A849FB22158
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 07:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49C78172BCE;
	Mon,  9 Sep 2024 07:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mlCgXlbk"
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34AB61AD9EB;
	Mon,  9 Sep 2024 07:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725868252; cv=none; b=jI2i4p+oaYULP1M8vvUvcbH/n3C8HG6PTXVs0Me8tSAJ+0GX+JlX5XP1Syqj5WCyBaProRAcEUrWkHF1+2ohSV0VEVbzXQTiVsBQJp5CHiAK7WEjCJVn5IHbJpsKKI8RXzHWrHxIdXZ+jzjUmFQrhk16zl99bdMugIwV+a33CGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725868252; c=relaxed/simple;
	bh=OFQlePf5sGWI2hTQLCHAiM5MGGUUMZc4H4tHm6ypWbE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bK7HLSShJKC1CsWdFaaq39Hh6QgrrtIrXWVJkaVCBCQXX/p5Rk4KDyFZxiiN+yqI6ySb22MPMNRso8jUJ4Ie6DcpE/D0KeQ/j4Ys4BPXMWzce8QvVe4IdrvnkDHsYZFQyF0nse81/z8d3SNhqt/yTzyQqcADwQkj1+vh5gono1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mlCgXlbk; arc=none smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-49bd27b3507so1085254137.2;
        Mon, 09 Sep 2024 00:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725868250; x=1726473050; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kjkOFrufKJ1AjHTRc9MH6HUMyIDUtDWhIyaGfEi0t6I=;
        b=mlCgXlbkl1hfBqdgqJFYSsn2GQQ6zA3OMKEhGWCzixzbBjIP8XrPQpsqASZQTayek8
         J/2xHqtNzi78sFY40I+ctlm/ANAyDjwErEw+Bar45odMnx1yloAvQo5+m7x+hKVfJmuM
         ZdLUwdV4c2k9n3117cKZ4FzBQ6qTNVj2A3KYKGkkXnTlRGFdKAR/wg1NqnUa8CkOKxFk
         St375JXQ82f8lz9iqe0hQEuKm/U418HAskTi2K7aiOiOSQl4lRbLzhanZATFPAPdvEji
         /2vFTVlOAjUEAEEaT4U9adkE2kBjMq4fUNBMiGwxTxbEXgEKkmwZ3K0zAT6V/7akQiTC
         aVfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725868250; x=1726473050;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kjkOFrufKJ1AjHTRc9MH6HUMyIDUtDWhIyaGfEi0t6I=;
        b=u3r0XKVQfye74J7oU0oB0Zo+6pEMQdxfzQbWlNwiN4skflrmA91XVIPdBbk13owKb/
         8y4qZ/S9CiDy2ON1HNJ4Mn6luaS4zgdNCDEEvULCu2gJsaQnRhsWlp+U1Mh+PstJhqnX
         rrxxUG9hcBvqXbAM1ZL9D7v4cKIMEi6CQL/idvc6MdqGadwNN+TksiEr1a293Sn4GLfE
         GH6cgQWlez6GOvK0+xJL/4d7CVfM0I/QtKUHI/BHRb5jAyBRVqd1GQwqlN4g+aFYhNaA
         wCFspw8q8kmthr7kNHQ2XNYQ6M2whi0+3LOkoFmb5Q8+EXrwtpu3DLJENtGJvLlh0CfN
         eaJA==
X-Forwarded-Encrypted: i=1; AJvYcCVndDnzraXcCcjUaFC40BUwGS07rfdS8vQewDtkFH5QiQmXFvJK4xFCww0vVoOdId4X9dveAd8IoUdylrqS@vger.kernel.org, AJvYcCXhufVRCkZAktx8ZRkzh4Hd6047QtwdqsqnDw5ebr+PF8VneQ8gTgzi5a+D7ArCnfeKXUNdqSmp7n45a0+3rd0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyym8vBwtbP5DGWZiTL2Nf9vlltijiJO7glhSwH1IjZcFTHXkeU
	qQqp4jJaBx6335ehCLsN7uv1pUdDH1OZnRBGVhhd5400swQ4Gg5TV0ci7NXGRa6mnqcIqe9d6zD
	BVyzXzCeN+hjv/ZA/NcxO8X9XTrHjEy87
X-Google-Smtp-Source: AGHT+IGDe5bTfCYshkuDostS1tj2V885Krj51WrMe86Y3hOultADu8SH5bzVSZCD4CoaYjCR3Qp+0h5I3TcH/QwyzNM=
X-Received: by 2002:a05:6102:b13:b0:498:ede5:b20f with SMTP id
 ada2fe7eead31-49bde25d992mr7855055137.19.1725868249950; Mon, 09 Sep 2024
 00:50:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1725791361.git.christophe.jaillet@wanadoo.fr> <583fa0bebbe18f8cb6e215a895f57b2eb944218e.1725791361.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <583fa0bebbe18f8cb6e215a895f57b2eb944218e.1725791361.git.christophe.jaillet@wanadoo.fr>
From: Iskren Chernev <iskren.chernev@gmail.com>
Date: Mon, 9 Sep 2024 10:50:39 +0300
Message-ID: <CAL7jhid23sd_CFHDLbgqkDPnTtFGQBp5HBShR02b8MDh9Ev26Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] regulator: max77826: Simplify max77826_i2c_probe()
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: lgirdwood@gmail.com, linux-kernel@vger.kernel.org, 
	kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This was my first kernel patch, I didn't understand most of the details.
I guess I left it because of the i2d_set_clientdata, but nothing is accessi=
ng
it, so I guess it's safe to drop.

Reviewed-by: Iskren Chernev <iskren.chernev@gmail.com>

On Sun, Sep 8, 2024 at 2:41=E2=80=AFPM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> 'struct max77826_regulator_info' is unused and can be removed.
>
> There is no i2c_get_clientdata().
> Resources are managed, so there is no need to keep references unless
> explicitly needed.
>
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> --
> Compile tested only.
>
> This patch IS SPECULATIVE, review with care!
> ---
>  drivers/regulator/max77826-regulator.c | 18 ------------------
>  1 file changed, 18 deletions(-)
>
> diff --git a/drivers/regulator/max77826-regulator.c b/drivers/regulator/m=
ax77826-regulator.c
> index 376e3110c695..3b12ad361222 100644
> --- a/drivers/regulator/max77826-regulator.c
> +++ b/drivers/regulator/max77826-regulator.c
> @@ -149,13 +149,6 @@ enum max77826_regulators {
>                 .owner =3D THIS_MODULE,                                  =
 \
>         }
>
> -
> -
> -struct max77826_regulator_info {
> -       struct regmap *regmap;
> -       const struct regulator_desc *rdesc;
> -};
> -
>  static const struct regmap_config max77826_regmap_config =3D {
>         .reg_bits =3D 8,
>         .val_bits =3D 8,
> @@ -235,30 +228,19 @@ static int max77826_read_device_id(struct regmap *r=
egmap, struct device *dev)
>  static int max77826_i2c_probe(struct i2c_client *client)
>  {
>         struct device *dev =3D &client->dev;
> -       struct max77826_regulator_info *info;
>         struct regulator_config config =3D {};
>         struct regulator_dev *rdev;
>         struct regmap *regmap;
>         int i;
>
> -       info =3D devm_kzalloc(dev, sizeof(struct max77826_regulator_info)=
,
> -                               GFP_KERNEL);
> -       if (!info)
> -               return -ENOMEM;
> -
> -       info->rdesc =3D max77826_regulators_desc;
>         regmap =3D devm_regmap_init_i2c(client, &max77826_regmap_config);
>         if (IS_ERR(regmap)) {
>                 dev_err(dev, "Failed to allocate regmap!\n");
>                 return PTR_ERR(regmap);
>         }
>
> -       info->regmap =3D regmap;
> -       i2c_set_clientdata(client, info);
> -
>         config.dev =3D dev;
>         config.regmap =3D regmap;
> -       config.driver_data =3D info;
>
>         for (i =3D 0; i < MAX77826_MAX_REGULATORS; i++) {
>                 rdev =3D devm_regulator_register(dev,
> --
> 2.46.0
>

